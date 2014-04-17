#!/bin/bash

# grunt-contrib-copy doesn't preserve permissions
# https://github.com/gruntjs/grunt/issues/615
chmod 755 debian/package-root/opt/brackets/brackets
chmod 755 debian/package-root/opt/brackets/Brackets
chmod 755 debian/package-root/opt/brackets/Brackets-node

# set permissions on subdirectories
find debian -type d -exec chmod 755 {} \;

# delete old package
rm -f brackets.tar.gz

# Move everything we'll be using to a temporary directory for easy clean-up
mkdir archive/out
cp -r debian/package-root/opt/brackets archive/out

# Add brackets.svg
cp debian/package-root/usr/share/icons/hicolor/scalable/apps/brackets.svg archive/out/brackets

# Add the modified brackets.desktop file (call brackets instead of /opt/brackets/brackets)
cp archive/brackets.desktop archive/out/brackets

# Add the install.sh and uninstall.sh files.
cp archive/install.sh archive/out/brackets
cp archive/uninstall.sh archive/out/brackets
# README.md too.
cp archive/README.md archive/out/brackets

tar -cf brackets.tar -C archive/out brackets/

gzip brackets.tar
