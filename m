Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAFD4D44D57
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 12:36:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8fGH-0001Oq-1W; Wed, 06 Nov 2024 07:35:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t8fGC-0001O8-SH
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 07:35:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t8fG9-0007P3-0F
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 07:35:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730896535;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=hyTCfojHTPKmU3A+APuZO4nVDX28RBGZLY9JTqLUOhQ=;
 b=ZyD1tWACrBo31073CVddJTp0ec+MYACz/B5DPHxeUFyuIiL1r+A+OtQVENrQhgDt4LFpW5
 kvau2vETPeeD8dlBrPoHh70732jhinAWK7QwyPzx6NIWxm6nVytfcf5P3I5SDkXxNAwSWg
 DzYQq/sFy9tUN8wjvwFNBR/GmVkU1E4=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-544-Oe7AyuRKPYivXLdPFYPfdQ-1; Wed,
 06 Nov 2024 07:35:32 -0500
X-MC-Unique: Oe7AyuRKPYivXLdPFYPfdQ-1
X-Mimecast-MFC-AGG-ID: Oe7AyuRKPYivXLdPFYPfdQ
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DD81B1955E7A; Wed,  6 Nov 2024 12:35:30 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.180])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 65B3419560AA; Wed,  6 Nov 2024 12:35:27 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v3] tests: refresh package lists with latest libvirt-ci
Date: Wed,  6 Nov 2024 12:35:25 +0000
Message-ID: <20241106123525.511491-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
the most notable reducing native package sets in cross builds.
Some packages were mistakenly marked as native, rather than
foreign, in libvirt-ci. Fixing this causes our dockerfiles to
pick up the cross arch package instead of native one, thus
improving our test coverage in a few areas.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---

In v3:

  - Block gtk-vnc from mips64el temporarily due to debian bugs

 .gitlab-ci.d/cirrus/freebsd-14.vars                   | 2 +-
 tests/docker/dockerfiles/debian-amd64-cross.docker    | 8 ++++----
 tests/docker/dockerfiles/debian-arm64-cross.docker    | 8 ++++----
 tests/docker/dockerfiles/debian-armhf-cross.docker    | 8 ++++----
 tests/docker/dockerfiles/debian-i686-cross.docker     | 8 ++++----
 tests/docker/dockerfiles/debian-mips64el-cross.docker | 7 +++----
 tests/docker/dockerfiles/debian-mipsel-cross.docker   | 8 ++++----
 tests/docker/dockerfiles/debian-ppc64el-cross.docker  | 8 ++++----
 tests/docker/dockerfiles/debian-s390x-cross.docker    | 8 ++++----
 tests/docker/dockerfiles/fedora-win64-cross.docker    | 4 +---
 tests/lcitool/libvirt-ci                              | 2 +-
 tests/lcitool/mappings.yml                            | 3 +++
 tests/vm/generated/freebsd.json                       | 2 +-
 13 files changed, 38 insertions(+), 38 deletions(-)

diff --git a/.gitlab-ci.d/cirrus/freebsd-14.vars b/.gitlab-ci.d/cirrus/freebsd-14.vars
index 044cec7c14..0a7ac5e0e1 100644
--- a/.gitlab-ci.d/cirrus/freebsd-14.vars
+++ b/.gitlab-ci.d/cirrus/freebsd-14.vars
@@ -10,7 +10,7 @@ CROSS_PKGS=''
 MAKE='/usr/local/bin/gmake'
 NINJA='/usr/local/bin/ninja'
 PACKAGING_COMMAND='pkg'
-PIP3='/usr/local/bin/pip-3.8'
+PIP3='/usr/local/bin/pip'
 PKGS='alsa-lib bash bison bzip2 ca_root_nss capstone4 ccache cmocka ctags curl cyrus-sasl dbus diffutils dtc flex fusefs-libs3 gettext git glib gmake gnutls gsed gtk-vnc gtk3 json-c libepoxy libffi libgcrypt libjpeg-turbo libnfs libslirp libspice-server libssh libtasn1 llvm lzo2 meson mtools ncurses nettle ninja opencv pixman pkgconf png py311-numpy py311-pillow py311-pip py311-pyyaml py311-sphinx py311-sphinx_rtd_theme py311-tomli python3 rpm2cpio rust rust-bindgen-cli sdl2 sdl2_image snappy sndio socat spice-protocol tesseract usbredir virglrenderer vte3 xorriso zstd'
 PYPI_PKGS=''
 PYTHON='/usr/local/bin/python3'
diff --git a/tests/docker/dockerfiles/debian-amd64-cross.docker b/tests/docker/dockerfiles/debian-amd64-cross.docker
index d3b58c3e90..644fd3734d 100644
--- a/tests/docker/dockerfiles/debian-amd64-cross.docker
+++ b/tests/docker/dockerfiles/debian-amd64-cross.docker
@@ -31,10 +31,6 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
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
@@ -109,6 +105,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       libglusterfs-dev:amd64 \
                       libgnutls28-dev:amd64 \
                       libgtk-3-dev:amd64 \
+                      libgtk-vnc-2.0-dev:amd64 \
                       libibverbs-dev:amd64 \
                       libiscsi-dev:amd64 \
                       libjemalloc-dev:amd64 \
@@ -120,6 +117,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       libnfs-dev:amd64 \
                       libnuma-dev:amd64 \
                       libpam0g-dev:amd64 \
+                      libpcre2-dev:amd64 \
                       libpipewire-0.3-dev:amd64 \
                       libpixman-1-dev:amd64 \
                       libpmem-dev:amd64 \
@@ -134,6 +132,8 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       libselinux1-dev:amd64 \
                       libslirp-dev:amd64 \
                       libsnappy-dev:amd64 \
+                      libsndio-dev:amd64 \
+                      libspice-protocol-dev:amd64 \
                       libspice-server-dev:amd64 \
                       libssh-gcrypt-dev:amd64 \
                       libsystemd-dev:amd64 \
diff --git a/tests/docker/dockerfiles/debian-arm64-cross.docker b/tests/docker/dockerfiles/debian-arm64-cross.docker
index 4a6785bf5b..060da53796 100644
--- a/tests/docker/dockerfiles/debian-arm64-cross.docker
+++ b/tests/docker/dockerfiles/debian-arm64-cross.docker
@@ -31,10 +31,6 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
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
@@ -109,6 +105,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       libglusterfs-dev:arm64 \
                       libgnutls28-dev:arm64 \
                       libgtk-3-dev:arm64 \
+                      libgtk-vnc-2.0-dev:arm64 \
                       libibverbs-dev:arm64 \
                       libiscsi-dev:arm64 \
                       libjemalloc-dev:arm64 \
@@ -120,6 +117,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       libnfs-dev:arm64 \
                       libnuma-dev:arm64 \
                       libpam0g-dev:arm64 \
+                      libpcre2-dev:arm64 \
                       libpipewire-0.3-dev:arm64 \
                       libpixman-1-dev:arm64 \
                       libpng-dev:arm64 \
@@ -133,6 +131,8 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       libselinux1-dev:arm64 \
                       libslirp-dev:arm64 \
                       libsnappy-dev:arm64 \
+                      libsndio-dev:arm64 \
+                      libspice-protocol-dev:arm64 \
                       libspice-server-dev:arm64 \
                       libssh-gcrypt-dev:arm64 \
                       libsystemd-dev:arm64 \
diff --git a/tests/docker/dockerfiles/debian-armhf-cross.docker b/tests/docker/dockerfiles/debian-armhf-cross.docker
index 52e8831326..a481fc9695 100644
--- a/tests/docker/dockerfiles/debian-armhf-cross.docker
+++ b/tests/docker/dockerfiles/debian-armhf-cross.docker
@@ -31,10 +31,6 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
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
@@ -109,6 +105,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       libglusterfs-dev:armhf \
                       libgnutls28-dev:armhf \
                       libgtk-3-dev:armhf \
+                      libgtk-vnc-2.0-dev:armhf \
                       libibverbs-dev:armhf \
                       libiscsi-dev:armhf \
                       libjemalloc-dev:armhf \
@@ -120,6 +117,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       libnfs-dev:armhf \
                       libnuma-dev:armhf \
                       libpam0g-dev:armhf \
+                      libpcre2-dev:armhf \
                       libpipewire-0.3-dev:armhf \
                       libpixman-1-dev:armhf \
                       libpng-dev:armhf \
@@ -133,6 +131,8 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       libselinux1-dev:armhf \
                       libslirp-dev:armhf \
                       libsnappy-dev:armhf \
+                      libsndio-dev:armhf \
+                      libspice-protocol-dev:armhf \
                       libspice-server-dev:armhf \
                       libssh-gcrypt-dev:armhf \
                       libsystemd-dev:armhf \
diff --git a/tests/docker/dockerfiles/debian-i686-cross.docker b/tests/docker/dockerfiles/debian-i686-cross.docker
index 1326e8a5ca..61bc361e85 100644
--- a/tests/docker/dockerfiles/debian-i686-cross.docker
+++ b/tests/docker/dockerfiles/debian-i686-cross.docker
@@ -31,10 +31,6 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
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
@@ -109,6 +105,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       libglusterfs-dev:i386 \
                       libgnutls28-dev:i386 \
                       libgtk-3-dev:i386 \
+                      libgtk-vnc-2.0-dev:i386 \
                       libibverbs-dev:i386 \
                       libiscsi-dev:i386 \
                       libjemalloc-dev:i386 \
@@ -120,6 +117,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       libnfs-dev:i386 \
                       libnuma-dev:i386 \
                       libpam0g-dev:i386 \
+                      libpcre2-dev:i386 \
                       libpipewire-0.3-dev:i386 \
                       libpixman-1-dev:i386 \
                       libpng-dev:i386 \
@@ -133,6 +131,8 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       libselinux1-dev:i386 \
                       libslirp-dev:i386 \
                       libsnappy-dev:i386 \
+                      libsndio-dev:i386 \
+                      libspice-protocol-dev:i386 \
                       libspice-server-dev:i386 \
                       libssh-gcrypt-dev:i386 \
                       libsystemd-dev:i386 \
diff --git a/tests/docker/dockerfiles/debian-mips64el-cross.docker b/tests/docker/dockerfiles/debian-mips64el-cross.docker
index 0ba542112e..c09a8da890 100644
--- a/tests/docker/dockerfiles/debian-mips64el-cross.docker
+++ b/tests/docker/dockerfiles/debian-mips64el-cross.docker
@@ -31,10 +31,6 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
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
@@ -115,6 +111,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       libnfs-dev:mips64el \
                       libnuma-dev:mips64el \
                       libpam0g-dev:mips64el \
+                      libpcre2-dev:mips64el \
                       libpipewire-0.3-dev:mips64el \
                       libpixman-1-dev:mips64el \
                       libpng-dev:mips64el \
@@ -126,6 +123,8 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       libselinux1-dev:mips64el \
                       libslirp-dev:mips64el \
                       libsnappy-dev:mips64el \
+                      libsndio-dev:mips64el \
+                      libspice-protocol-dev:mips64el \
                       libspice-server-dev:mips64el \
                       libssh-gcrypt-dev:mips64el \
                       libsystemd-dev:mips64el \
diff --git a/tests/docker/dockerfiles/debian-mipsel-cross.docker b/tests/docker/dockerfiles/debian-mipsel-cross.docker
index 59b5d2655b..2e979111e0 100644
--- a/tests/docker/dockerfiles/debian-mipsel-cross.docker
+++ b/tests/docker/dockerfiles/debian-mipsel-cross.docker
@@ -31,10 +31,6 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
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
@@ -108,6 +104,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       libglusterfs-dev:mipsel \
                       libgnutls28-dev:mipsel \
                       libgtk-3-dev:mipsel \
+                      libgtk-vnc-2.0-dev:mipsel \
                       libibverbs-dev:mipsel \
                       libiscsi-dev:mipsel \
                       libjemalloc-dev:mipsel \
@@ -119,6 +116,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       libnfs-dev:mipsel \
                       libnuma-dev:mipsel \
                       libpam0g-dev:mipsel \
+                      libpcre2-dev:mipsel \
                       libpipewire-0.3-dev:mipsel \
                       libpixman-1-dev:mipsel \
                       libpng-dev:mipsel \
@@ -132,6 +130,8 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       libselinux1-dev:mipsel \
                       libslirp-dev:mipsel \
                       libsnappy-dev:mipsel \
+                      libsndio-dev:mipsel \
+                      libspice-protocol-dev:mipsel \
                       libspice-server-dev:mipsel \
                       libssh-gcrypt-dev:mipsel \
                       libsystemd-dev:mipsel \
diff --git a/tests/docker/dockerfiles/debian-ppc64el-cross.docker b/tests/docker/dockerfiles/debian-ppc64el-cross.docker
index 8680b35c5a..8ee450dba0 100644
--- a/tests/docker/dockerfiles/debian-ppc64el-cross.docker
+++ b/tests/docker/dockerfiles/debian-ppc64el-cross.docker
@@ -31,10 +31,6 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
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
@@ -109,6 +105,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       libglusterfs-dev:ppc64el \
                       libgnutls28-dev:ppc64el \
                       libgtk-3-dev:ppc64el \
+                      libgtk-vnc-2.0-dev:ppc64el \
                       libibverbs-dev:ppc64el \
                       libiscsi-dev:ppc64el \
                       libjemalloc-dev:ppc64el \
@@ -120,6 +117,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       libnfs-dev:ppc64el \
                       libnuma-dev:ppc64el \
                       libpam0g-dev:ppc64el \
+                      libpcre2-dev:ppc64el \
                       libpipewire-0.3-dev:ppc64el \
                       libpixman-1-dev:ppc64el \
                       libpng-dev:ppc64el \
@@ -133,6 +131,8 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       libselinux1-dev:ppc64el \
                       libslirp-dev:ppc64el \
                       libsnappy-dev:ppc64el \
+                      libsndio-dev:ppc64el \
+                      libspice-protocol-dev:ppc64el \
                       libspice-server-dev:ppc64el \
                       libssh-gcrypt-dev:ppc64el \
                       libsystemd-dev:ppc64el \
diff --git a/tests/docker/dockerfiles/debian-s390x-cross.docker b/tests/docker/dockerfiles/debian-s390x-cross.docker
index 384a2b425e..f451a07c4c 100644
--- a/tests/docker/dockerfiles/debian-s390x-cross.docker
+++ b/tests/docker/dockerfiles/debian-s390x-cross.docker
@@ -31,10 +31,6 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
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
@@ -109,6 +105,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       libglusterfs-dev:s390x \
                       libgnutls28-dev:s390x \
                       libgtk-3-dev:s390x \
+                      libgtk-vnc-2.0-dev:s390x \
                       libibverbs-dev:s390x \
                       libiscsi-dev:s390x \
                       libjemalloc-dev:s390x \
@@ -120,6 +117,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       libnfs-dev:s390x \
                       libnuma-dev:s390x \
                       libpam0g-dev:s390x \
+                      libpcre2-dev:s390x \
                       libpipewire-0.3-dev:s390x \
                       libpixman-1-dev:s390x \
                       libpng-dev:s390x \
@@ -133,6 +131,8 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       libselinux1-dev:s390x \
                       libslirp-dev:s390x \
                       libsnappy-dev:s390x \
+                      libsndio-dev:s390x \
+                      libspice-protocol-dev:s390x \
                       libssh-gcrypt-dev:s390x \
                       libsystemd-dev:s390x \
                       libtasn1-6-dev:s390x \
diff --git a/tests/docker/dockerfiles/fedora-win64-cross.docker b/tests/docker/dockerfiles/fedora-win64-cross.docker
index 3ba62b55ad..7dc3eb03f5 100644
--- a/tests/docker/dockerfiles/fedora-win64-cross.docker
+++ b/tests/docker/dockerfiles/fedora-win64-cross.docker
@@ -35,7 +35,6 @@ exec "$@"\n' > /usr/bin/nosync && \
                git \
                glib2-devel \
                glibc-langpack-en \
-               gtk-vnc2-devel \
                hostname \
                llvm \
                make \
@@ -44,7 +43,6 @@ exec "$@"\n' > /usr/bin/nosync && \
                ninja-build \
                nmap-ncat \
                openssh-clients \
-               pcre-static \
                python3 \
                python3-PyYAML \
                python3-numpy \
@@ -58,7 +56,6 @@ exec "$@"\n' > /usr/bin/nosync && \
                sed \
                socat \
                sparse \
-               spice-protocol \
                swtpm \
                tar \
                tesseract \
@@ -89,6 +86,7 @@ RUN nosync dnf install -y \
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
diff --git a/tests/lcitool/mappings.yml b/tests/lcitool/mappings.yml
index 9c5ac87c1c..186f61097b 100644
--- a/tests/lcitool/mappings.yml
+++ b/tests/lcitool/mappings.yml
@@ -13,6 +13,9 @@ mappings:
   libepoxy:
     mips64el-deb:
 
+  gtk-vnc:
+    mips64el-deb:
+
   mesa-libgbm:
     mips64el-deb:
 
diff --git a/tests/vm/generated/freebsd.json b/tests/vm/generated/freebsd.json
index 5da8d30bcd..3cb7fb7060 100644
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


