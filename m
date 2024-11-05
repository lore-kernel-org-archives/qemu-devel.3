Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4305BD2C122
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 15:25:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8LQH-0004BL-NZ; Tue, 05 Nov 2024 10:24:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t8LQG-00048a-Bn
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 10:24:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t8LQA-0003Bt-Im
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 10:24:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730820281;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ujCFgnWL7OQ7Af+nE4CAm3uEY4JOaTrTqK6521SwfBQ=;
 b=bv0ag0vhzJ+5eDUn2nESzhACHM+4LxsyE/+v+KazeeqUWtxU7L2dnRRfBkCJFOM9+v+Joi
 jZ+e3HBDy+6EQLf7cOIll0S5wLYu0ZS2DLVmJNZCZozxUftNY/xWXqO4FuvwZ1HNuCUQkm
 rBiRpVOTJiINXVyJpKuCMKjDfjVHtJg=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-433-UjBWZsk9OkihFyimrb2igQ-1; Tue,
 05 Nov 2024 10:24:38 -0500
X-MC-Unique: UjBWZsk9OkihFyimrb2igQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7CF401955D4B; Tue,  5 Nov 2024 15:24:37 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.52])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C9B3A1956086; Tue,  5 Nov 2024 15:24:34 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH] tests: refresh package lists with latest libvirt-ci
Date: Tue,  5 Nov 2024 15:24:33 +0000
Message-ID: <20241105152433.344974-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This updates the libvirt-ci  submodule to pull in various fixes,
the most notable being

 * Removal of the macos-15 target. Cirrus CI has changed their
   infra to only permit testing of a single macOS version,
   currently set to 14. Our attempt to test macOS 15 was being
   quietly converted into a macOS 14 test, which we already
   have.

 * Reducing native package sets in cross builds. Some packages
   were mistakenly marked as native, rather than foreign, in
   libvirt-ci. Fixing this causes our dockerfiles to pick up
   the cross arch package instead of native one, thus improving
   our test coverage in a few areas.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 .gitlab-ci.d/cirrus.yml                          | 16 ----------------
 .gitlab-ci.d/cirrus/freebsd-14.vars              |  2 +-
 .gitlab-ci.d/cirrus/macos-15.vars                | 16 ----------------
 .../docker/dockerfiles/debian-amd64-cross.docker |  8 ++++----
 .../docker/dockerfiles/debian-arm64-cross.docker |  8 ++++----
 .../docker/dockerfiles/debian-armhf-cross.docker |  8 ++++----
 .../docker/dockerfiles/debian-i686-cross.docker  |  8 ++++----
 .../dockerfiles/debian-mips64el-cross.docker     |  8 ++++----
 .../dockerfiles/debian-mipsel-cross.docker       |  8 ++++----
 .../dockerfiles/debian-ppc64el-cross.docker      |  8 ++++----
 .../docker/dockerfiles/debian-s390x-cross.docker |  8 ++++----
 .../docker/dockerfiles/fedora-win64-cross.docker |  4 +---
 tests/lcitool/libvirt-ci                         |  2 +-
 tests/lcitool/refresh                            |  1 -
 tests/vm/generated/freebsd.json                  |  2 +-
 15 files changed, 36 insertions(+), 71 deletions(-)
 delete mode 100644 .gitlab-ci.d/cirrus/macos-15.vars

diff --git a/.gitlab-ci.d/cirrus.yml b/.gitlab-ci.d/cirrus.yml
index 5708c2bbab..3f154908fa 100644
--- a/.gitlab-ci.d/cirrus.yml
+++ b/.gitlab-ci.d/cirrus.yml
@@ -75,19 +75,3 @@ aarch64-macos-14-base-build:
     PKG_CONFIG_PATH: /opt/homebrew/curl/lib/pkgconfig:/opt/homebrew/ncurses/lib/pkgconfig:/opt/homebrew/readline/lib/pkgconfig
     CONFIGURE_ARGS: --target-list-exclude=arm-softmmu,i386-softmmu,microblazeel-softmmu,mips64-softmmu,mipsel-softmmu,mips-softmmu,ppc-softmmu,sh4-softmmu,xtensaeb-softmmu
     TEST_TARGETS: check-unit check-block check-qapi-schema check-softfloat check-qtest-x86_64
-
-aarch64-macos-15-base-build:
-  extends: .cirrus_build_job
-  variables:
-    NAME: macos-15
-    CIRRUS_VM_INSTANCE_TYPE: macos_instance
-    CIRRUS_VM_IMAGE_SELECTOR: image
-    CIRRUS_VM_IMAGE_NAME: ghcr.io/cirruslabs/macos-sequoia-base:latest
-    CIRRUS_VM_CPUS: 12
-    CIRRUS_VM_RAM: 24G
-    UPDATE_COMMAND: brew update
-    INSTALL_COMMAND: brew install
-    PATH_EXTRA: /opt/homebrew/ccache/libexec:/opt/homebrew/gettext/bin
-    PKG_CONFIG_PATH: /opt/homebrew/curl/lib/pkgconfig:/opt/homebrew/ncurses/lib/pkgconfig:/opt/homebrew/readline/lib/pkgconfig
-    TEST_TARGETS: check-unit check-block check-qapi-schema check-softfloat check-qtest-x86_64
-    QEMU_JOB_OPTIONAL: 1
diff --git a/.gitlab-ci.d/cirrus/freebsd-14.vars b/.gitlab-ci.d/cirrus/freebsd-14.vars
index c0655b21e9..5e0491e5d4 100644
--- a/.gitlab-ci.d/cirrus/freebsd-14.vars
+++ b/.gitlab-ci.d/cirrus/freebsd-14.vars
@@ -10,7 +10,7 @@ CROSS_PKGS=''
 MAKE='/usr/local/bin/gmake'
 NINJA='/usr/local/bin/ninja'
 PACKAGING_COMMAND='pkg'
-PIP3='/usr/local/bin/pip-3.8'
+PIP3='/usr/local/bin/pip'
 PKGS='alsa-lib bash bison bzip2 ca_root_nss capstone4 ccache cmocka ctags curl cyrus-sasl dbus diffutils dtc flex fusefs-libs3 gettext git glib gmake gnutls gsed gtk-vnc gtk3 json-c libepoxy libffi libgcrypt libjpeg-turbo libnfs libslirp libspice-server libssh libtasn1 llvm lzo2 meson mtools ncurses nettle ninja opencv pixman pkgconf png py311-numpy py311-pillow py311-pip py311-pyyaml py311-sphinx py311-sphinx_rtd_theme py311-tomli python3 rpm2cpio sdl2 sdl2_image snappy sndio socat spice-protocol tesseract usbredir virglrenderer vte3 xorriso zstd'
 PYPI_PKGS=''
 PYTHON='/usr/local/bin/python3'
diff --git a/.gitlab-ci.d/cirrus/macos-15.vars b/.gitlab-ci.d/cirrus/macos-15.vars
deleted file mode 100644
index 23b2c1d22f..0000000000
--- a/.gitlab-ci.d/cirrus/macos-15.vars
+++ /dev/null
@@ -1,16 +0,0 @@
-# THIS FILE WAS AUTO-GENERATED
-#
-#  $ lcitool variables macos-15 qemu
-#
-# https://gitlab.com/libvirt/libvirt-ci
-
-CCACHE='/opt/homebrew/bin/ccache'
-CPAN_PKGS=''
-CROSS_PKGS=''
-MAKE='/opt/homebrew/bin/gmake'
-NINJA='/opt/homebrew/bin/ninja'
-PACKAGING_COMMAND='brew'
-PIP3='/opt/homebrew/bin/pip3'
-PKGS='bash bc bison bzip2 capstone ccache cmocka ctags curl dbus diffutils dtc flex gcovr gettext git glib gnu-sed gnutls gtk+3 gtk-vnc jemalloc jpeg-turbo json-c libepoxy libffi libgcrypt libiscsi libnfs libpng libslirp libssh libtasn1 libusb llvm lzo make meson mtools ncurses nettle ninja pixman pkg-config python3 rpm2cpio sdl2 sdl2_image snappy socat sparse spice-protocol swtpm tesseract usbredir vde vte3 xorriso zlib zstd'
-PYPI_PKGS='PyYAML numpy pillow sphinx sphinx-rtd-theme tomli'
-PYTHON='/opt/homebrew/bin/python3'
diff --git a/tests/docker/dockerfiles/debian-amd64-cross.docker b/tests/docker/dockerfiles/debian-amd64-cross.docker
index 136c3a79a1..eeadb054e9 100644
--- a/tests/docker/dockerfiles/debian-amd64-cross.docker
+++ b/tests/docker/dockerfiles/debian-amd64-cross.docker
@@ -30,10 +30,6 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       git \
                       hostname \
                       libglib2.0-dev \
-                      libgtk-vnc-2.0-dev \
-                      libpcre2-dev \
-                      libsndio-dev \
-                      libspice-protocol-dev \
                       llvm \
                       locales \
                       make \
@@ -106,6 +102,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       libglusterfs-dev:amd64 \
                       libgnutls28-dev:amd64 \
                       libgtk-3-dev:amd64 \
+                      libgtk-vnc-2.0-dev:amd64 \
                       libibverbs-dev:amd64 \
                       libiscsi-dev:amd64 \
                       libjemalloc-dev:amd64 \
@@ -117,6 +114,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       libnfs-dev:amd64 \
                       libnuma-dev:amd64 \
                       libpam0g-dev:amd64 \
+                      libpcre2-dev:amd64 \
                       libpipewire-0.3-dev:amd64 \
                       libpixman-1-dev:amd64 \
                       libpmem-dev:amd64 \
@@ -131,6 +129,8 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       libselinux1-dev:amd64 \
                       libslirp-dev:amd64 \
                       libsnappy-dev:amd64 \
+                      libsndio-dev:amd64 \
+                      libspice-protocol-dev:amd64 \
                       libspice-server-dev:amd64 \
                       libssh-gcrypt-dev:amd64 \
                       libsystemd-dev:amd64 \
diff --git a/tests/docker/dockerfiles/debian-arm64-cross.docker b/tests/docker/dockerfiles/debian-arm64-cross.docker
index 233f6ee1de..27d55ff7ac 100644
--- a/tests/docker/dockerfiles/debian-arm64-cross.docker
+++ b/tests/docker/dockerfiles/debian-arm64-cross.docker
@@ -30,10 +30,6 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       git \
                       hostname \
                       libglib2.0-dev \
-                      libgtk-vnc-2.0-dev \
-                      libpcre2-dev \
-                      libsndio-dev \
-                      libspice-protocol-dev \
                       llvm \
                       locales \
                       make \
@@ -106,6 +102,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       libglusterfs-dev:arm64 \
                       libgnutls28-dev:arm64 \
                       libgtk-3-dev:arm64 \
+                      libgtk-vnc-2.0-dev:arm64 \
                       libibverbs-dev:arm64 \
                       libiscsi-dev:arm64 \
                       libjemalloc-dev:arm64 \
@@ -117,6 +114,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       libnfs-dev:arm64 \
                       libnuma-dev:arm64 \
                       libpam0g-dev:arm64 \
+                      libpcre2-dev:arm64 \
                       libpipewire-0.3-dev:arm64 \
                       libpixman-1-dev:arm64 \
                       libpng-dev:arm64 \
@@ -130,6 +128,8 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       libselinux1-dev:arm64 \
                       libslirp-dev:arm64 \
                       libsnappy-dev:arm64 \
+                      libsndio-dev:arm64 \
+                      libspice-protocol-dev:arm64 \
                       libspice-server-dev:arm64 \
                       libssh-gcrypt-dev:arm64 \
                       libsystemd-dev:arm64 \
diff --git a/tests/docker/dockerfiles/debian-armhf-cross.docker b/tests/docker/dockerfiles/debian-armhf-cross.docker
index f26385e0b9..bd818f3d9c 100644
--- a/tests/docker/dockerfiles/debian-armhf-cross.docker
+++ b/tests/docker/dockerfiles/debian-armhf-cross.docker
@@ -30,10 +30,6 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       git \
                       hostname \
                       libglib2.0-dev \
-                      libgtk-vnc-2.0-dev \
-                      libpcre2-dev \
-                      libsndio-dev \
-                      libspice-protocol-dev \
                       llvm \
                       locales \
                       make \
@@ -106,6 +102,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       libglusterfs-dev:armhf \
                       libgnutls28-dev:armhf \
                       libgtk-3-dev:armhf \
+                      libgtk-vnc-2.0-dev:armhf \
                       libibverbs-dev:armhf \
                       libiscsi-dev:armhf \
                       libjemalloc-dev:armhf \
@@ -117,6 +114,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       libnfs-dev:armhf \
                       libnuma-dev:armhf \
                       libpam0g-dev:armhf \
+                      libpcre2-dev:armhf \
                       libpipewire-0.3-dev:armhf \
                       libpixman-1-dev:armhf \
                       libpng-dev:armhf \
@@ -130,6 +128,8 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       libselinux1-dev:armhf \
                       libslirp-dev:armhf \
                       libsnappy-dev:armhf \
+                      libsndio-dev:armhf \
+                      libspice-protocol-dev:armhf \
                       libspice-server-dev:armhf \
                       libssh-gcrypt-dev:armhf \
                       libsystemd-dev:armhf \
diff --git a/tests/docker/dockerfiles/debian-i686-cross.docker b/tests/docker/dockerfiles/debian-i686-cross.docker
index 2328ee1732..dc7b18bff0 100644
--- a/tests/docker/dockerfiles/debian-i686-cross.docker
+++ b/tests/docker/dockerfiles/debian-i686-cross.docker
@@ -30,10 +30,6 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       git \
                       hostname \
                       libglib2.0-dev \
-                      libgtk-vnc-2.0-dev \
-                      libpcre2-dev \
-                      libsndio-dev \
-                      libspice-protocol-dev \
                       llvm \
                       locales \
                       make \
@@ -106,6 +102,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       libglusterfs-dev:i386 \
                       libgnutls28-dev:i386 \
                       libgtk-3-dev:i386 \
+                      libgtk-vnc-2.0-dev:i386 \
                       libibverbs-dev:i386 \
                       libiscsi-dev:i386 \
                       libjemalloc-dev:i386 \
@@ -117,6 +114,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       libnfs-dev:i386 \
                       libnuma-dev:i386 \
                       libpam0g-dev:i386 \
+                      libpcre2-dev:i386 \
                       libpipewire-0.3-dev:i386 \
                       libpixman-1-dev:i386 \
                       libpng-dev:i386 \
@@ -130,6 +128,8 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       libselinux1-dev:i386 \
                       libslirp-dev:i386 \
                       libsnappy-dev:i386 \
+                      libsndio-dev:i386 \
+                      libspice-protocol-dev:i386 \
                       libspice-server-dev:i386 \
                       libssh-gcrypt-dev:i386 \
                       libsystemd-dev:i386 \
diff --git a/tests/docker/dockerfiles/debian-mips64el-cross.docker b/tests/docker/dockerfiles/debian-mips64el-cross.docker
index bfa96cb507..5f298a0f50 100644
--- a/tests/docker/dockerfiles/debian-mips64el-cross.docker
+++ b/tests/docker/dockerfiles/debian-mips64el-cross.docker
@@ -30,10 +30,6 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       git \
                       hostname \
                       libglib2.0-dev \
-                      libgtk-vnc-2.0-dev \
-                      libpcre2-dev \
-                      libsndio-dev \
-                      libspice-protocol-dev \
                       llvm \
                       locales \
                       make \
@@ -101,6 +97,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       libglib2.0-dev:mips64el \
                       libglusterfs-dev:mips64el \
                       libgnutls28-dev:mips64el \
+                      libgtk-vnc-2.0-dev:mips64el \
                       libibverbs-dev:mips64el \
                       libiscsi-dev:mips64el \
                       libjemalloc-dev:mips64el \
@@ -112,6 +109,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       libnfs-dev:mips64el \
                       libnuma-dev:mips64el \
                       libpam0g-dev:mips64el \
+                      libpcre2-dev:mips64el \
                       libpipewire-0.3-dev:mips64el \
                       libpixman-1-dev:mips64el \
                       libpng-dev:mips64el \
@@ -123,6 +121,8 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       libselinux1-dev:mips64el \
                       libslirp-dev:mips64el \
                       libsnappy-dev:mips64el \
+                      libsndio-dev:mips64el \
+                      libspice-protocol-dev:mips64el \
                       libspice-server-dev:mips64el \
                       libssh-gcrypt-dev:mips64el \
                       libsystemd-dev:mips64el \
diff --git a/tests/docker/dockerfiles/debian-mipsel-cross.docker b/tests/docker/dockerfiles/debian-mipsel-cross.docker
index 4ac314e22e..3bb19e027d 100644
--- a/tests/docker/dockerfiles/debian-mipsel-cross.docker
+++ b/tests/docker/dockerfiles/debian-mipsel-cross.docker
@@ -30,10 +30,6 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       git \
                       hostname \
                       libglib2.0-dev \
-                      libgtk-vnc-2.0-dev \
-                      libpcre2-dev \
-                      libsndio-dev \
-                      libspice-protocol-dev \
                       llvm \
                       locales \
                       make \
@@ -105,6 +101,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       libglusterfs-dev:mipsel \
                       libgnutls28-dev:mipsel \
                       libgtk-3-dev:mipsel \
+                      libgtk-vnc-2.0-dev:mipsel \
                       libibverbs-dev:mipsel \
                       libiscsi-dev:mipsel \
                       libjemalloc-dev:mipsel \
@@ -116,6 +113,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       libnfs-dev:mipsel \
                       libnuma-dev:mipsel \
                       libpam0g-dev:mipsel \
+                      libpcre2-dev:mipsel \
                       libpipewire-0.3-dev:mipsel \
                       libpixman-1-dev:mipsel \
                       libpng-dev:mipsel \
@@ -129,6 +127,8 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       libselinux1-dev:mipsel \
                       libslirp-dev:mipsel \
                       libsnappy-dev:mipsel \
+                      libsndio-dev:mipsel \
+                      libspice-protocol-dev:mipsel \
                       libspice-server-dev:mipsel \
                       libssh-gcrypt-dev:mipsel \
                       libsystemd-dev:mipsel \
diff --git a/tests/docker/dockerfiles/debian-ppc64el-cross.docker b/tests/docker/dockerfiles/debian-ppc64el-cross.docker
index 8c1dcec9cf..f9fa7310f2 100644
--- a/tests/docker/dockerfiles/debian-ppc64el-cross.docker
+++ b/tests/docker/dockerfiles/debian-ppc64el-cross.docker
@@ -30,10 +30,6 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       git \
                       hostname \
                       libglib2.0-dev \
-                      libgtk-vnc-2.0-dev \
-                      libpcre2-dev \
-                      libsndio-dev \
-                      libspice-protocol-dev \
                       llvm \
                       locales \
                       make \
@@ -106,6 +102,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       libglusterfs-dev:ppc64el \
                       libgnutls28-dev:ppc64el \
                       libgtk-3-dev:ppc64el \
+                      libgtk-vnc-2.0-dev:ppc64el \
                       libibverbs-dev:ppc64el \
                       libiscsi-dev:ppc64el \
                       libjemalloc-dev:ppc64el \
@@ -117,6 +114,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       libnfs-dev:ppc64el \
                       libnuma-dev:ppc64el \
                       libpam0g-dev:ppc64el \
+                      libpcre2-dev:ppc64el \
                       libpipewire-0.3-dev:ppc64el \
                       libpixman-1-dev:ppc64el \
                       libpng-dev:ppc64el \
@@ -130,6 +128,8 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       libselinux1-dev:ppc64el \
                       libslirp-dev:ppc64el \
                       libsnappy-dev:ppc64el \
+                      libsndio-dev:ppc64el \
+                      libspice-protocol-dev:ppc64el \
                       libspice-server-dev:ppc64el \
                       libssh-gcrypt-dev:ppc64el \
                       libsystemd-dev:ppc64el \
diff --git a/tests/docker/dockerfiles/debian-s390x-cross.docker b/tests/docker/dockerfiles/debian-s390x-cross.docker
index 72668e0315..f5dd1a6aca 100644
--- a/tests/docker/dockerfiles/debian-s390x-cross.docker
+++ b/tests/docker/dockerfiles/debian-s390x-cross.docker
@@ -30,10 +30,6 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       git \
                       hostname \
                       libglib2.0-dev \
-                      libgtk-vnc-2.0-dev \
-                      libpcre2-dev \
-                      libsndio-dev \
-                      libspice-protocol-dev \
                       llvm \
                       locales \
                       make \
@@ -106,6 +102,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       libglusterfs-dev:s390x \
                       libgnutls28-dev:s390x \
                       libgtk-3-dev:s390x \
+                      libgtk-vnc-2.0-dev:s390x \
                       libibverbs-dev:s390x \
                       libiscsi-dev:s390x \
                       libjemalloc-dev:s390x \
@@ -117,6 +114,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       libnfs-dev:s390x \
                       libnuma-dev:s390x \
                       libpam0g-dev:s390x \
+                      libpcre2-dev:s390x \
                       libpipewire-0.3-dev:s390x \
                       libpixman-1-dev:s390x \
                       libpng-dev:s390x \
@@ -130,6 +128,8 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       libselinux1-dev:s390x \
                       libslirp-dev:s390x \
                       libsnappy-dev:s390x \
+                      libsndio-dev:s390x \
+                      libspice-protocol-dev:s390x \
                       libssh-gcrypt-dev:s390x \
                       libsystemd-dev:s390x \
                       libtasn1-6-dev:s390x \
diff --git a/tests/docker/dockerfiles/fedora-win64-cross.docker b/tests/docker/dockerfiles/fedora-win64-cross.docker
index 6b264d901f..c0a08acb6a 100644
--- a/tests/docker/dockerfiles/fedora-win64-cross.docker
+++ b/tests/docker/dockerfiles/fedora-win64-cross.docker
@@ -34,7 +34,6 @@ exec "$@"\n' > /usr/bin/nosync && \
                git \
                glib2-devel \
                glibc-langpack-en \
-               gtk-vnc2-devel \
                hostname \
                llvm \
                make \
@@ -43,7 +42,6 @@ exec "$@"\n' > /usr/bin/nosync && \
                ninja-build \
                nmap-ncat \
                openssh-clients \
-               pcre-static \
                python3 \
                python3-PyYAML \
                python3-numpy \
@@ -56,7 +54,6 @@ exec "$@"\n' > /usr/bin/nosync && \
                sed \
                socat \
                sparse \
-               spice-protocol \
                swtpm \
                tar \
                tesseract \
@@ -87,6 +84,7 @@ RUN nosync dnf install -y \
                mingw64-gettext \
                mingw64-glib2 \
                mingw64-gnutls \
+               mingw64-gtk-vnc2 \
                mingw64-gtk3 \
                mingw64-libepoxy \
                mingw64-libgcrypt \
diff --git a/tests/lcitool/libvirt-ci b/tests/lcitool/libvirt-ci
index 6b19006b2c..9ad3f70bde 160000
--- a/tests/lcitool/libvirt-ci
+++ b/tests/lcitool/libvirt-ci
@@ -1 +1 @@
-Subproject commit 6b19006b2cbe01adea6a857c71860a8e7ba7ddd7
+Subproject commit 9ad3f70bde9865d5ad18f36d256d472e72b5cbf3
diff --git a/tests/lcitool/refresh b/tests/lcitool/refresh
index 0f16f4d525..7cf882cda7 100755
--- a/tests/lcitool/refresh
+++ b/tests/lcitool/refresh
@@ -229,7 +229,6 @@ try:
     #
     generate_cirrus("freebsd-14")
     generate_cirrus("macos-14")
-    generate_cirrus("macos-15")
 
     #
     # VM packages lists
diff --git a/tests/vm/generated/freebsd.json b/tests/vm/generated/freebsd.json
index 1eb2757c95..45e6f74962 100644
--- a/tests/vm/generated/freebsd.json
+++ b/tests/vm/generated/freebsd.json
@@ -5,7 +5,7 @@
   "make": "/usr/local/bin/gmake",
   "ninja": "/usr/local/bin/ninja",
   "packaging_command": "pkg",
-  "pip3": "/usr/local/bin/pip-3.8",
+  "pip3": "/usr/local/bin/pip",
   "pkgs": [
     "alsa-lib",
     "bash",
-- 
2.46.0


