#!/bin/bash -e

BASEDIR=$(mktemp -d)
NAME=waggle-node-hostname
ARCH=all

# add package description
mkdir -p ${BASEDIR}/DEBIAN
cat <<EOF > ${BASEDIR}/DEBIAN/control
Package: ${NAME}
Version: ${VERSION_LONG}
Maintainer: sagecontinuum.org
Description: Service to set the hostname on Waggle nodes.
Architecture: ${ARCH}
Priority: optional
EOF

# add control files
cp -p deb/install/postinst ${BASEDIR}/DEBIAN/

# add core files
cp -r ROOTFS/* ${BASEDIR}/

# build deb
dpkg-deb --root-owner-group --build ${BASEDIR} "${NAME}_${VERSION_SHORT}_${ARCH}.deb"
mv *.deb /output/