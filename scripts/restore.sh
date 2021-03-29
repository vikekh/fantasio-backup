#!/bin/bash

# https://docs.docker.com/storage/volumes/#backup-restore-or-migrate-data-volumes

if [ -z "$1" ]; then
    echo "No argument"
    exit 1
fi

BACKUP_DIR=$1

# backup

docker stop duplicati

docker run --rm -v duplicati-data:/data -v $BACKUP_DIR:/backup ubuntu bash -c "cd /data && tar xvf /backup/duplicati-data.tar.gz --strip 1"

docker start duplicati

# dashboard

docker stop homer
docker stop organizr

docker run --rm -v homer-assets:/data -v $BACKUP_DIR:/backup ubuntu tar czvf /backup/homer-assets.tar.gz /data
docker run --rm -v organizr-config:/data -v $BACKUP_DIR:/backup ubuntu tar czvf /backup/organizr-config.tar.gz /data

docker start homer
docker start organizr

# media

docker stop bazarr
docker stop jackett
docker stop overseerr
docker stop plex
docker stop radarr
docker stop sonarr
docker stop tautulli

docker run --rm -v bazarr-config:/data -v $BACKUP_DIR:/backup ubuntu tar czvf /backup/bazarr-config.tar.gz /data
docker run --rm -v jackett-config:/data -v $BACKUP_DIR:/backup ubuntu tar czvf /backup/jackett-config.tar.gz /data
docker run --rm -v overseerr-config:/data -v $BACKUP_DIR:/backup ubuntu tar czvf /backup/overseerr-config.tar.gz /data
docker run --rm -v plex-config:/data -v $BACKUP_DIR:/backup ubuntu tar czvf /backup/plex-config.tar.gz /data
docker run --rm -v radarr-config:/data -v $BACKUP_DIR:/backup ubuntu tar czvf /backup/radarr-config.tar.gz /data
docker run --rm -v sonarr-config:/data -v $BACKUP_DIR:/backup ubuntu tar czvf /backup/sonarr-config.tar.gz /data
docker run --rm -v tautulli-config:/data -v $BACKUP_DIR:/backup ubuntu tar czvf /backup/tautulli-config.tar.gz /data

docker start bazarr
docker start jackett
docker start overseerr
docker start plex
docker start radarr
docker start sonarr
docker start tautulli

# repository

docker stop nexus

docker run --rm -v nexus-data:/data -v $BACKUP_DIR:/backup ubuntu tar czvf /backup/nexus-data.tar.gz /data

docker start nexus

# reverse-proxy

docker stop caddy

docker run --rm -v caddy-config:/data -v $BACKUP_DIR:/backup ubuntu tar czvf /backup/caddy-config.tar.gz /data
docker run --rm -v caddy-data:/data -v $BACKUP_DIR:/backup ubuntu tar czvf /backup/caddy-data.tar.gz /data

docker start caddy

# torrent

docker stop transmission
docker stop transmission-rss

docker run --rm -v transmission-config:/data -v $BACKUP_DIR:/backup ubuntu tar czvf /backup/transmission-config.tar.gz /data
docker run --rm -v transmission-data:/data -v $BACKUP_DIR:/backup ubuntu tar czvf /backup/transmission-data.tar.gz /data

docker start transmission
docker start transmission-rss

# torrent2

docker stop transmission2
docker stop transmission2-rss

docker run --rm -v transmission2-config:/data -v $BACKUP_DIR:/backup ubuntu tar czvf /backup/transmission2-config.tar.gz /data
docker run --rm -v transmission2-data:/data -v $BACKUP_DIR:/backup ubuntu tar czvf /backup/transmission2-data.tar.gz /data

docker start transmission2
docker start transmission2-rss

# utils

docker stop portainer

docker run --rm -v portainer-data:/data -v $BACKUP_DIR:/backup ubuntu tar czvf /backup/portainer-data.tar.gz /data

docker start portainer