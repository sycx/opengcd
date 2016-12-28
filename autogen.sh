
#!/bin/bash -ex

test -d blocks-runtime || \
  git clone https://github.com/mheily/blocks-runtime.git

test -d libkqueue || \
  git clone https://github.com/mheily/libkqueue.git

test -d libpwq || \
  svn co svn://svn.code.sf.net/p/libpwq/code/trunk libpwq

test -d libdispatch
if [ $? -ne 0 ] ; then
  git clone -b macosforge/trunk https://github.com/apple/swift-corelibs-libdispatch.git libdispatch
  cd libdispatch
  patch -p0 < ../patch/disable_dispatch_read.patch
  patch -p0 < ../patch/libdispatch-r197_v2.patch
  cd ..
fi

autoreconf -fvi
