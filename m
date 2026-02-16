Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFE11E83839
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 21:31:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vs6BV-0006fA-9n; Mon, 16 Feb 2026 16:31:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vs6BR-0006YQ-Q2
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 16:31:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vs6BO-0003us-H3
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 16:31:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771277465;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CAMjBMTvi3wUmSxCyKwKDFztHmt36MzIXomLfUW5j1M=;
 b=KTaLQSJP6ywQjzui8fqN12CmlpG2MOw9W6qZ0RXRcE32TwJiwaW7tSiOotn7qpTJ92t3LB
 2ebp/poJeA0q60l9km/a4wIrcQ8ZY3DHuvp+TOFWjMwGXGeiCuCJg/n0POvsOXaO4g31CN
 i1Spfex3RRWDuivm7e1ZYDk/IWeTFKs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-696--tG-vA2ANC--fqy64nDlBQ-1; Mon,
 16 Feb 2026 16:31:02 -0500
X-MC-Unique: -tG-vA2ANC--fqy64nDlBQ-1
X-Mimecast-MFC-AGG-ID: -tG-vA2ANC--fqy64nDlBQ_1771277460
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CE11F1955F1B; Mon, 16 Feb 2026 21:30:59 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.120])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 56B0919560A2; Mon, 16 Feb 2026 21:30:53 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Cleber Rosa <crosa@redhat.com>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Kyle Evans <kevans@freebsd.org>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Yonggang Luo <luoyonggang@gmail.com>, John Snow <jsnow@redhat.com>,
 Warner Losh <imp@bsdimp.com>, Maksim Davydov <davydov-max@yandex-team.ru>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ed Maste <emaste@freebsd.org>, Kevin Wolf <kwolf@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Michael Roth <michael.roth@amd.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Hanna Reitz <hreitz@redhat.com>
Subject: [PATCH v7 09/19] tests/lcitool: update lcitool to latest version
Date: Mon, 16 Feb 2026 16:29:41 -0500
Message-ID: <20260216212952.420120-10-jsnow@redhat.com>
In-Reply-To: <20260216212952.420120-1-jsnow@redhat.com>
References: <20260216212952.420120-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Update to latest lcitool master and refresh tests. Fedora is upgraded to
Fedora 43 and Alpine from 3.21 to 3.23 as a result.

This is being done in this series primarily to ensure that MacOS
installs python-setuptools, which is now separate from the core python
package, and which is needed for this series to work correctly.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 .gitlab-ci.d/cirrus/macos-14.vars             |   2 +-
 tests/docker/dockerfiles/alpine.docker        |   4 +-
 tests/docker/dockerfiles/centos9.docker       | 240 ++++++++--------
 .../dockerfiles/fedora-rust-nightly.docker    | 262 +++++++++---------
 .../dockerfiles/fedora-win64-cross.docker     | 162 +++++------
 tests/docker/dockerfiles/fedora.docker        | 262 +++++++++---------
 tests/lcitool/libvirt-ci                      |   2 +-
 tests/lcitool/refresh                         |   8 +-
 8 files changed, 471 insertions(+), 471 deletions(-)

diff --git a/.gitlab-ci.d/cirrus/macos-14.vars b/.gitlab-ci.d/cirrus/macos-14.vars
index 4701c388e14..def77cfdea5 100644
--- a/.gitlab-ci.d/cirrus/macos-14.vars
+++ b/.gitlab-ci.d/cirrus/macos-14.vars
@@ -11,6 +11,6 @@ MAKE='/opt/homebrew/bin/gmake'
 NINJA='/opt/homebrew/bin/ninja'
 PACKAGING_COMMAND='brew'
 PIP3='/opt/homebrew/bin/pip3'
-PKGS='bash bc bindgen bison bzip2 capstone ccache cmocka coreutils ctags curl dbus diffutils dtc flex gcovr gettext git glib gnu-sed gnutls gtk+3 gtk-vnc jemalloc jpeg-turbo json-c libcbor libepoxy libffi libgcrypt libiscsi libnfs libpng libslirp libssh libtasn1 libusb llvm lzo make meson mtools ncurses nettle ninja pixman pkg-config python3 rpm2cpio rust sdl2 sdl2_image snappy socat sparse spice-protocol swtpm tesseract usbredir vde vte3 vulkan-tools xorriso zlib zstd'
+PKGS='bash bc bindgen bison bzip2 capstone ccache cmocka coreutils ctags curl dbus diffutils dtc flex gcovr gettext git glib gnu-sed gnutls gtk+3 gtk-vnc jemalloc jpeg-turbo json-c libcbor libepoxy libffi libgcrypt libiscsi libnfs libpng libslirp libssh libtasn1 libusb llvm lzo make meson mtools ncurses nettle ninja pixman pkg-config python-setuptools python3 rpm2cpio rust sdl2 sdl2_image snappy socat sparse spice-protocol swtpm tesseract usbredir vde vte3 vulkan-tools xorriso zlib zstd'
 PYPI_PKGS='PyYAML numpy pillow sphinx sphinx-rtd-theme tomli'
 PYTHON='/opt/homebrew/bin/python3'
diff --git a/tests/docker/dockerfiles/alpine.docker b/tests/docker/dockerfiles/alpine.docker
index 03dd6851f60..76d8dd8cfc7 100644
--- a/tests/docker/dockerfiles/alpine.docker
+++ b/tests/docker/dockerfiles/alpine.docker
@@ -1,10 +1,10 @@
 # THIS FILE WAS AUTO-GENERATED
 #
-#  $ lcitool dockerfile --layers all alpine-321 qemu
+#  $ lcitool dockerfile --layers all alpine-323 qemu
 #
 # https://gitlab.com/libvirt/libvirt-ci
 
-FROM docker.io/library/alpine:3.21
+FROM docker.io/library/alpine:3.23
 
 RUN apk update && \
     apk upgrade && \
diff --git a/tests/docker/dockerfiles/centos9.docker b/tests/docker/dockerfiles/centos9.docker
index 670e22be5ad..90ac1f7fade 100644
--- a/tests/docker/dockerfiles/centos9.docker
+++ b/tests/docker/dockerfiles/centos9.docker
@@ -6,126 +6,126 @@
 
 FROM quay.io/centos/centos:stream9
 
-RUN dnf distro-sync -y && \
-    dnf install 'dnf-command(config-manager)' -y && \
-    dnf config-manager --set-enabled -y crb && \
-    dnf install -y epel-release && \
-    dnf install -y epel-next-release && \
-    dnf install -y \
-        SDL2-devel \
-        alsa-lib-devel \
-        bash \
-        bc \
-        bindgen-cli \
-        bison \
-        brlapi-devel \
-        bzip2 \
-        bzip2-devel \
-        ca-certificates \
-        capstone-devel \
-        ccache \
-        clang \
-        compiler-rt \
-        coreutils-single \
-        ctags \
-        cyrus-sasl-devel \
-        daxctl-devel \
-        dbus-daemon \
-        device-mapper-multipath-devel \
-        diffutils \
-        findutils \
-        flex \
-        fuse3-devel \
-        gcc \
-        gettext \
-        git \
-        glib2-devel \
-        glib2-static \
-        glibc-langpack-en \
-        glibc-static \
-        gnutls-devel \
-        gtk3-devel \
-        hostname \
-        jemalloc-devel \
-        json-c-devel \
-        libaio-devel \
-        libasan \
-        libattr-devel \
-        libbpf-devel \
-        libcacard-devel \
-        libcap-ng-devel \
-        libcmocka-devel \
-        libcurl-devel \
-        libdrm-devel \
-        libepoxy-devel \
-        libfdt-devel \
-        libffi-devel \
-        libgcrypt-devel \
-        libiscsi-devel \
-        libjpeg-devel \
-        libnfs-devel \
-        libpmem-devel \
-        libpng-devel \
-        librbd-devel \
-        libseccomp-devel \
-        libselinux-devel \
-        libslirp-devel \
-        libssh-devel \
-        libtasn1-devel \
-        libubsan \
-        liburing-devel \
-        libusbx-devel \
-        libxdp-devel \
-        libzstd-devel \
-        llvm \
-        lttng-ust-devel \
-        lzo-devel \
-        make \
-        mesa-libgbm-devel \
-        meson \
-        mtools \
-        ncurses-devel \
-        nettle-devel \
-        ninja-build \
-        nmap-ncat \
-        numactl-devel \
-        openssh-clients \
-        pam-devel \
-        pcre-static \
-        pipewire-devel \
-        pixman-devel \
-        pkgconfig \
-        pulseaudio-libs-devel \
-        python3 \
-        python3-PyYAML \
-        python3-numpy \
-        python3-pillow \
-        python3-pip \
-        python3-sphinx \
-        python3-sphinx_rtd_theme \
-        python3-tomli \
-        rdma-core-devel \
-        rust \
-        rust-std-static \
-        sed \
-        snappy-devel \
-        socat \
-        spice-protocol \
-        swtpm \
-        systemd-devel \
-        systemtap-sdt-devel \
-        tar \
-        usbredir-devel \
-        util-linux \
-        vte291-devel \
-        vulkan-tools \
-        which \
-        xorriso \
-        zlib-devel \
-        zlib-static \
-        zstd && \
-    dnf autoremove -y && \
-    dnf clean all -y && \
+RUN dnf --quiet distro-sync -y && \
+    dnf --quiet install 'dnf-command(config-manager)' -y && \
+    dnf --quiet config-manager --set-enabled -y crb && \
+    dnf --quiet install -y epel-release && \
+    dnf --quiet install -y epel-next-release && \
+    dnf --quiet install -y \
+                SDL2-devel \
+                alsa-lib-devel \
+                bash \
+                bc \
+                bindgen-cli \
+                bison \
+                brlapi-devel \
+                bzip2 \
+                bzip2-devel \
+                ca-certificates \
+                capstone-devel \
+                ccache \
+                clang \
+                compiler-rt \
+                coreutils-single \
+                ctags \
+                cyrus-sasl-devel \
+                daxctl-devel \
+                dbus-daemon \
+                device-mapper-multipath-devel \
+                diffutils \
+                findutils \
+                flex \
+                fuse3-devel \
+                gcc \
+                gettext \
+                git \
+                glib2-devel \
+                glib2-static \
+                glibc-langpack-en \
+                glibc-static \
+                gnutls-devel \
+                gtk3-devel \
+                hostname \
+                jemalloc-devel \
+                json-c-devel \
+                libaio-devel \
+                libasan \
+                libattr-devel \
+                libbpf-devel \
+                libcacard-devel \
+                libcap-ng-devel \
+                libcmocka-devel \
+                libcurl-devel \
+                libdrm-devel \
+                libepoxy-devel \
+                libfdt-devel \
+                libffi-devel \
+                libgcrypt-devel \
+                libiscsi-devel \
+                libjpeg-devel \
+                libnfs-devel \
+                libpmem-devel \
+                libpng-devel \
+                librbd-devel \
+                libseccomp-devel \
+                libselinux-devel \
+                libslirp-devel \
+                libssh-devel \
+                libtasn1-devel \
+                libubsan \
+                liburing-devel \
+                libusbx-devel \
+                libxdp-devel \
+                libzstd-devel \
+                llvm \
+                lttng-ust-devel \
+                lzo-devel \
+                make \
+                mesa-libgbm-devel \
+                meson \
+                mtools \
+                ncurses-devel \
+                nettle-devel \
+                ninja-build \
+                nmap-ncat \
+                numactl-devel \
+                openssh-clients \
+                pam-devel \
+                pcre-static \
+                pipewire-devel \
+                pixman-devel \
+                pkgconfig \
+                pulseaudio-libs-devel \
+                python3 \
+                python3-PyYAML \
+                python3-numpy \
+                python3-pillow \
+                python3-pip \
+                python3-sphinx \
+                python3-sphinx_rtd_theme \
+                python3-tomli \
+                rdma-core-devel \
+                rust \
+                rust-std-static \
+                sed \
+                snappy-devel \
+                socat \
+                spice-protocol \
+                swtpm \
+                systemd-devel \
+                systemtap-sdt-devel \
+                tar \
+                usbredir-devel \
+                util-linux \
+                vte291-devel \
+                vulkan-tools \
+                which \
+                xorriso \
+                zlib-devel \
+                zlib-static \
+                zstd && \
+    dnf --quiet autoremove -y && \
+    dnf --quiet clean all -y && \
     rm -f /usr/lib*/python3*/EXTERNALLY-MANAGED && \
     rpm -qa | sort > /packages.txt && \
     mkdir -p /usr/libexec/ccache-wrappers && \
diff --git a/tests/docker/dockerfiles/fedora-rust-nightly.docker b/tests/docker/dockerfiles/fedora-rust-nightly.docker
index 8e3b3a9fd90..043b42a0a9b 100644
--- a/tests/docker/dockerfiles/fedora-rust-nightly.docker
+++ b/tests/docker/dockerfiles/fedora-rust-nightly.docker
@@ -1,12 +1,12 @@
 # THIS FILE WAS AUTO-GENERATED
 #
-#  $ lcitool dockerfile --layers all fedora-41 qemu
+#  $ lcitool dockerfile --layers all fedora-43 qemu
 #
 # https://gitlab.com/libvirt/libvirt-ci
 
-FROM registry.fedoraproject.org/fedora:41
+FROM registry.fedoraproject.org/fedora:43
 
-RUN dnf install -y nosync && \
+RUN dnf --quiet install -y nosync && \
     printf '#!/bin/sh\n\
 if test -d /usr/lib64\n\
 then\n\
@@ -16,134 +16,134 @@ else\n\
 fi\n\
 exec "$@"\n' > /usr/bin/nosync && \
     chmod +x /usr/bin/nosync && \
-    nosync dnf update -y && \
-    nosync dnf install -y \
-               SDL2-devel \
-               SDL2_image-devel \
-               alsa-lib-devel \
-               bash \
-               bc \
-               bindgen-cli \
-               bison \
-               brlapi-devel \
-               bzip2 \
-               bzip2-devel \
-               ca-certificates \
-               capstone-devel \
-               ccache \
-               clang \
-               compiler-rt \
-               coreutils \
-               ctags \
-               cyrus-sasl-devel \
-               daxctl-devel \
-               dbus-daemon \
-               device-mapper-multipath-devel \
-               diffutils \
-               findutils \
-               flex \
-               fuse3-devel \
-               gcc \
-               gcovr \
-               gettext \
-               git \
-               glib2-devel \
-               glib2-static \
-               glibc-langpack-en \
-               glibc-static \
-               glusterfs-api-devel \
-               gnutls-devel \
-               gtk-vnc2-devel \
-               gtk3-devel \
-               hostname \
-               jemalloc-devel \
-               json-c-devel \
-               libaio-devel \
-               libasan \
-               libattr-devel \
-               libbpf-devel \
-               libcacard-devel \
-               libcap-ng-devel \
-               libcbor-devel \
-               libcmocka-devel \
-               libcurl-devel \
-               libdrm-devel \
-               libepoxy-devel \
-               libfdt-devel \
-               libffi-devel \
-               libgcrypt-devel \
-               libiscsi-devel \
-               libjpeg-devel \
-               libnfs-devel \
-               libpmem-devel \
-               libpng-devel \
-               librbd-devel \
-               libseccomp-devel \
-               libselinux-devel \
-               libslirp-devel \
-               libssh-devel \
-               libtasn1-devel \
-               libubsan \
-               liburing-devel \
-               libusbx-devel \
-               libxdp-devel \
-               libzstd-devel \
-               llvm \
-               lttng-ust-devel \
-               lzo-devel \
-               make \
-               mesa-libgbm-devel \
-               mtools \
-               ncurses-devel \
-               nettle-devel \
-               ninja-build \
-               nmap-ncat \
-               numactl-devel \
-               openssh-clients \
-               pam-devel \
-               pcre2-static \
-               pipewire-devel \
-               pixman-devel \
-               pkgconfig \
-               pulseaudio-libs-devel \
-               python3 \
-               python3-PyYAML \
-               python3-numpy \
-               python3-opencv \
-               python3-pillow \
-               python3-pip \
-               python3-setuptools \
-               python3-sphinx \
-               python3-sphinx_rtd_theme \
-               python3-wheel \
-               rdma-core-devel \
-               rust \
-               rust-std-static \
-               sed \
-               snappy-devel \
-               socat \
-               sparse \
-               spice-protocol \
-               spice-server-devel \
-               swtpm \
-               systemd-devel \
-               systemtap-sdt-dtrace \
-               tar \
-               tesseract \
-               tesseract-langpack-eng \
-               usbredir-devel \
-               util-linux \
-               virglrenderer-devel \
-               vte291-devel \
-               vulkan-tools \
-               which \
-               xen-devel \
-               xorriso \
-               zlib-devel \
-               zlib-static \
-               zstd && \
-    nosync dnf autoremove -y && \
-    nosync dnf clean all -y && \
+    nosync dnf --quiet update -y && \
+    nosync dnf --quiet install -y \
+                       SDL2_image-devel \
+                       alsa-lib-devel \
+                       bash \
+                       bc \
+                       bindgen-cli \
+                       bison \
+                       brlapi-devel \
+                       bzip2 \
+                       bzip2-devel \
+                       ca-certificates \
+                       capstone-devel \
+                       ccache \
+                       clang \
+                       compiler-rt \
+                       coreutils \
+                       ctags \
+                       cyrus-sasl-devel \
+                       daxctl-devel \
+                       dbus-daemon \
+                       device-mapper-multipath-devel \
+                       diffutils \
+                       findutils \
+                       flex \
+                       fuse3-devel \
+                       gcc \
+                       gcovr \
+                       gettext \
+                       git \
+                       glib2-devel \
+                       glib2-static \
+                       glibc-langpack-en \
+                       glibc-static \
+                       glusterfs-api-devel \
+                       gnutls-devel \
+                       gtk-vnc2-devel \
+                       gtk3-devel \
+                       hostname \
+                       jemalloc-devel \
+                       json-c-devel \
+                       libaio-devel \
+                       libasan \
+                       libattr-devel \
+                       libbpf-devel \
+                       libcacard-devel \
+                       libcap-ng-devel \
+                       libcbor-devel \
+                       libcmocka-devel \
+                       libcurl-devel \
+                       libdrm-devel \
+                       libepoxy-devel \
+                       libfdt-devel \
+                       libffi-devel \
+                       libgcrypt-devel \
+                       libiscsi-devel \
+                       libjpeg-devel \
+                       libnfs-devel \
+                       libpmem-devel \
+                       libpng-devel \
+                       librbd-devel \
+                       libseccomp-devel \
+                       libselinux-devel \
+                       libslirp-devel \
+                       libssh-devel \
+                       libtasn1-devel \
+                       libubsan \
+                       liburing-devel \
+                       libusbx-devel \
+                       libxdp-devel \
+                       libzstd-devel \
+                       llvm \
+                       lttng-ust-devel \
+                       lzo-devel \
+                       make \
+                       mesa-libgbm-devel \
+                       mtools \
+                       ncurses-devel \
+                       nettle-devel \
+                       ninja-build \
+                       nmap-ncat \
+                       numactl-devel \
+                       openssh-clients \
+                       pam-devel \
+                       pcre2-static \
+                       pipewire-devel \
+                       pixman-devel \
+                       pkgconfig \
+                       pulseaudio-libs-devel \
+                       python3 \
+                       python3-PyYAML \
+                       python3-numpy \
+                       python3-opencv \
+                       python3-pillow \
+                       python3-pip \
+                       python3-setuptools \
+                       python3-sphinx \
+                       python3-sphinx_rtd_theme \
+                       python3-wheel \
+                       rdma-core-devel \
+                       rust \
+                       rust-std-static \
+                       sdl2-compat-devel \
+                       sed \
+                       snappy-devel \
+                       socat \
+                       sparse \
+                       spice-protocol \
+                       spice-server-devel \
+                       swtpm \
+                       systemd-devel \
+                       systemtap-sdt-dtrace \
+                       tar \
+                       tesseract \
+                       tesseract-langpack-eng \
+                       usbredir-devel \
+                       util-linux \
+                       virglrenderer-devel \
+                       vte291-devel \
+                       vulkan-tools \
+                       which \
+                       xen-devel \
+                       xorriso \
+                       zlib-devel \
+                       zlib-static \
+                       zstd && \
+    nosync dnf --quiet autoremove -y && \
+    nosync dnf --quiet clean all -y && \
     rm -f /usr/lib*/python3*/EXTERNALLY-MANAGED && \
     rpm -qa | sort > /packages.txt && \
     mkdir -p /usr/libexec/ccache-wrappers && \
diff --git a/tests/docker/dockerfiles/fedora-win64-cross.docker b/tests/docker/dockerfiles/fedora-win64-cross.docker
index c5e1fcebf51..818485c4ba2 100644
--- a/tests/docker/dockerfiles/fedora-win64-cross.docker
+++ b/tests/docker/dockerfiles/fedora-win64-cross.docker
@@ -1,12 +1,12 @@
 # THIS FILE WAS AUTO-GENERATED
 #
-#  $ lcitool dockerfile --layers all --cross-arch mingw64 fedora-41 qemu,qemu-win-installer
+#  $ lcitool dockerfile --layers all --cross-arch mingw64 fedora-43 qemu,qemu-win-installer
 #
 # https://gitlab.com/libvirt/libvirt-ci
 
-FROM registry.fedoraproject.org/fedora:41
+FROM registry.fedoraproject.org/fedora:43
 
-RUN dnf install -y nosync && \
+RUN dnf --quiet install -y nosync && \
     printf '#!/bin/sh\n\
 if test -d /usr/lib64\n\
 then\n\
@@ -16,59 +16,59 @@ else\n\
 fi\n\
 exec "$@"\n' > /usr/bin/nosync && \
     chmod +x /usr/bin/nosync && \
-    nosync dnf update -y && \
-    nosync dnf install -y \
-               bash \
-               bc \
-               bindgen-cli \
-               bison \
-               bzip2 \
-               ca-certificates \
-               ccache \
-               compiler-rt \
-               coreutils \
-               ctags \
-               dbus-daemon \
-               diffutils \
-               findutils \
-               flex \
-               gcc \
-               gcovr \
-               git \
-               glib2-devel \
-               glibc-langpack-en \
-               hostname \
-               llvm \
-               make \
-               mtools \
-               ninja-build \
-               nmap-ncat \
-               openssh-clients \
-               python3 \
-               python3-PyYAML \
-               python3-numpy \
-               python3-opencv \
-               python3-pillow \
-               python3-pip \
-               python3-setuptools \
-               python3-sphinx \
-               python3-sphinx_rtd_theme \
-               python3-wheel \
-               rust \
-               sed \
-               socat \
-               sparse \
-               swtpm \
-               tar \
-               tesseract \
-               tesseract-langpack-eng \
-               util-linux \
-               vulkan-tools \
-               which \
-               xorriso \
-               zstd && \
-    nosync dnf autoremove -y && \
-    nosync dnf clean all -y && \
+    nosync dnf --quiet update -y && \
+    nosync dnf --quiet install -y \
+                       bash \
+                       bc \
+                       bindgen-cli \
+                       bison \
+                       bzip2 \
+                       ca-certificates \
+                       ccache \
+                       compiler-rt \
+                       coreutils \
+                       ctags \
+                       dbus-daemon \
+                       diffutils \
+                       findutils \
+                       flex \
+                       gcc \
+                       gcovr \
+                       git \
+                       glib2-devel \
+                       glibc-langpack-en \
+                       hostname \
+                       llvm \
+                       make \
+                       mtools \
+                       ninja-build \
+                       nmap-ncat \
+                       openssh-clients \
+                       python3 \
+                       python3-PyYAML \
+                       python3-numpy \
+                       python3-opencv \
+                       python3-pillow \
+                       python3-pip \
+                       python3-setuptools \
+                       python3-sphinx \
+                       python3-sphinx_rtd_theme \
+                       python3-wheel \
+                       rust \
+                       sed \
+                       socat \
+                       sparse \
+                       swtpm \
+                       tar \
+                       tesseract \
+                       tesseract-langpack-eng \
+                       util-linux \
+                       vulkan-tools \
+                       which \
+                       xorriso \
+                       zstd && \
+    nosync dnf --quiet autoremove -y && \
+    nosync dnf --quiet clean all -y && \
     rm -f /usr/lib*/python3*/EXTERNALLY-MANAGED
 
 RUN /usr/bin/pip3 install meson==1.8.1
@@ -79,31 +79,31 @@ ENV MAKE="/usr/bin/make"
 ENV NINJA="/usr/bin/ninja"
 ENV PYTHON="/usr/bin/python3"
 
-RUN nosync dnf install -y \
-               mingw-w64-tools \
-               mingw32-nsis \
-               mingw64-SDL2 \
-               mingw64-SDL2_image \
-               mingw64-bzip2 \
-               mingw64-curl \
-               mingw64-gcc \
-               mingw64-gcc-c++ \
-               mingw64-gettext \
-               mingw64-glib2 \
-               mingw64-gnutls \
-               mingw64-gtk-vnc2 \
-               mingw64-gtk3 \
-               mingw64-libepoxy \
-               mingw64-libfdt \
-               mingw64-libgcrypt \
-               mingw64-libjpeg-turbo \
-               mingw64-libpng \
-               mingw64-libtasn1 \
-               mingw64-nettle \
-               mingw64-pixman \
-               mingw64-pkg-config \
-               rust-std-static-x86_64-pc-windows-gnu && \
-    nosync dnf clean all -y && \
+RUN nosync dnf --quiet install -y \
+                       mingw-w64-tools \
+                       mingw32-nsis \
+                       mingw64-SDL2 \
+                       mingw64-SDL2_image \
+                       mingw64-bzip2 \
+                       mingw64-curl \
+                       mingw64-gcc \
+                       mingw64-gcc-c++ \
+                       mingw64-gettext \
+                       mingw64-glib2 \
+                       mingw64-gnutls \
+                       mingw64-gtk-vnc2 \
+                       mingw64-gtk3 \
+                       mingw64-libepoxy \
+                       mingw64-libfdt \
+                       mingw64-libgcrypt \
+                       mingw64-libjpeg-turbo \
+                       mingw64-libpng \
+                       mingw64-libtasn1 \
+                       mingw64-nettle \
+                       mingw64-pixman \
+                       mingw64-pkg-config \
+                       rust-std-static-x86_64-pc-windows-gnu && \
+    nosync dnf --quiet clean all -y && \
     rpm -qa | sort > /packages.txt && \
     mkdir -p /usr/libexec/ccache-wrappers && \
     ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/x86_64-w64-mingw32-c++ && \
diff --git a/tests/docker/dockerfiles/fedora.docker b/tests/docker/dockerfiles/fedora.docker
index 9278d797693..32aaf01aff4 100644
--- a/tests/docker/dockerfiles/fedora.docker
+++ b/tests/docker/dockerfiles/fedora.docker
@@ -1,12 +1,12 @@
 # THIS FILE WAS AUTO-GENERATED
 #
-#  $ lcitool dockerfile --layers all fedora-41 qemu
+#  $ lcitool dockerfile --layers all fedora-43 qemu
 #
 # https://gitlab.com/libvirt/libvirt-ci
 
-FROM registry.fedoraproject.org/fedora:41
+FROM registry.fedoraproject.org/fedora:43
 
-RUN dnf install -y nosync && \
+RUN dnf --quiet install -y nosync && \
     printf '#!/bin/sh\n\
 if test -d /usr/lib64\n\
 then\n\
@@ -16,134 +16,134 @@ else\n\
 fi\n\
 exec "$@"\n' > /usr/bin/nosync && \
     chmod +x /usr/bin/nosync && \
-    nosync dnf update -y && \
-    nosync dnf install -y \
-               SDL2-devel \
-               SDL2_image-devel \
-               alsa-lib-devel \
-               bash \
-               bc \
-               bindgen-cli \
-               bison \
-               brlapi-devel \
-               bzip2 \
-               bzip2-devel \
-               ca-certificates \
-               capstone-devel \
-               ccache \
-               clang \
-               compiler-rt \
-               coreutils \
-               ctags \
-               cyrus-sasl-devel \
-               daxctl-devel \
-               dbus-daemon \
-               device-mapper-multipath-devel \
-               diffutils \
-               findutils \
-               flex \
-               fuse3-devel \
-               gcc \
-               gcovr \
-               gettext \
-               git \
-               glib2-devel \
-               glib2-static \
-               glibc-langpack-en \
-               glibc-static \
-               glusterfs-api-devel \
-               gnutls-devel \
-               gtk-vnc2-devel \
-               gtk3-devel \
-               hostname \
-               jemalloc-devel \
-               json-c-devel \
-               libaio-devel \
-               libasan \
-               libattr-devel \
-               libbpf-devel \
-               libcacard-devel \
-               libcap-ng-devel \
-               libcbor-devel \
-               libcmocka-devel \
-               libcurl-devel \
-               libdrm-devel \
-               libepoxy-devel \
-               libfdt-devel \
-               libffi-devel \
-               libgcrypt-devel \
-               libiscsi-devel \
-               libjpeg-devel \
-               libnfs-devel \
-               libpmem-devel \
-               libpng-devel \
-               librbd-devel \
-               libseccomp-devel \
-               libselinux-devel \
-               libslirp-devel \
-               libssh-devel \
-               libtasn1-devel \
-               libubsan \
-               liburing-devel \
-               libusbx-devel \
-               libxdp-devel \
-               libzstd-devel \
-               llvm \
-               lttng-ust-devel \
-               lzo-devel \
-               make \
-               mesa-libgbm-devel \
-               mtools \
-               ncurses-devel \
-               nettle-devel \
-               ninja-build \
-               nmap-ncat \
-               numactl-devel \
-               openssh-clients \
-               pam-devel \
-               pcre2-static \
-               pipewire-devel \
-               pixman-devel \
-               pkgconfig \
-               pulseaudio-libs-devel \
-               python3 \
-               python3-PyYAML \
-               python3-numpy \
-               python3-opencv \
-               python3-pillow \
-               python3-pip \
-               python3-setuptools \
-               python3-sphinx \
-               python3-sphinx_rtd_theme \
-               python3-wheel \
-               rdma-core-devel \
-               rust \
-               rust-std-static \
-               sed \
-               snappy-devel \
-               socat \
-               sparse \
-               spice-protocol \
-               spice-server-devel \
-               swtpm \
-               systemd-devel \
-               systemtap-sdt-dtrace \
-               tar \
-               tesseract \
-               tesseract-langpack-eng \
-               usbredir-devel \
-               util-linux \
-               virglrenderer-devel \
-               vte291-devel \
-               vulkan-tools \
-               which \
-               xen-devel \
-               xorriso \
-               zlib-devel \
-               zlib-static \
-               zstd && \
-    nosync dnf autoremove -y && \
-    nosync dnf clean all -y && \
+    nosync dnf --quiet update -y && \
+    nosync dnf --quiet install -y \
+                       SDL2_image-devel \
+                       alsa-lib-devel \
+                       bash \
+                       bc \
+                       bindgen-cli \
+                       bison \
+                       brlapi-devel \
+                       bzip2 \
+                       bzip2-devel \
+                       ca-certificates \
+                       capstone-devel \
+                       ccache \
+                       clang \
+                       compiler-rt \
+                       coreutils \
+                       ctags \
+                       cyrus-sasl-devel \
+                       daxctl-devel \
+                       dbus-daemon \
+                       device-mapper-multipath-devel \
+                       diffutils \
+                       findutils \
+                       flex \
+                       fuse3-devel \
+                       gcc \
+                       gcovr \
+                       gettext \
+                       git \
+                       glib2-devel \
+                       glib2-static \
+                       glibc-langpack-en \
+                       glibc-static \
+                       glusterfs-api-devel \
+                       gnutls-devel \
+                       gtk-vnc2-devel \
+                       gtk3-devel \
+                       hostname \
+                       jemalloc-devel \
+                       json-c-devel \
+                       libaio-devel \
+                       libasan \
+                       libattr-devel \
+                       libbpf-devel \
+                       libcacard-devel \
+                       libcap-ng-devel \
+                       libcbor-devel \
+                       libcmocka-devel \
+                       libcurl-devel \
+                       libdrm-devel \
+                       libepoxy-devel \
+                       libfdt-devel \
+                       libffi-devel \
+                       libgcrypt-devel \
+                       libiscsi-devel \
+                       libjpeg-devel \
+                       libnfs-devel \
+                       libpmem-devel \
+                       libpng-devel \
+                       librbd-devel \
+                       libseccomp-devel \
+                       libselinux-devel \
+                       libslirp-devel \
+                       libssh-devel \
+                       libtasn1-devel \
+                       libubsan \
+                       liburing-devel \
+                       libusbx-devel \
+                       libxdp-devel \
+                       libzstd-devel \
+                       llvm \
+                       lttng-ust-devel \
+                       lzo-devel \
+                       make \
+                       mesa-libgbm-devel \
+                       mtools \
+                       ncurses-devel \
+                       nettle-devel \
+                       ninja-build \
+                       nmap-ncat \
+                       numactl-devel \
+                       openssh-clients \
+                       pam-devel \
+                       pcre2-static \
+                       pipewire-devel \
+                       pixman-devel \
+                       pkgconfig \
+                       pulseaudio-libs-devel \
+                       python3 \
+                       python3-PyYAML \
+                       python3-numpy \
+                       python3-opencv \
+                       python3-pillow \
+                       python3-pip \
+                       python3-setuptools \
+                       python3-sphinx \
+                       python3-sphinx_rtd_theme \
+                       python3-wheel \
+                       rdma-core-devel \
+                       rust \
+                       rust-std-static \
+                       sdl2-compat-devel \
+                       sed \
+                       snappy-devel \
+                       socat \
+                       sparse \
+                       spice-protocol \
+                       spice-server-devel \
+                       swtpm \
+                       systemd-devel \
+                       systemtap-sdt-dtrace \
+                       tar \
+                       tesseract \
+                       tesseract-langpack-eng \
+                       usbredir-devel \
+                       util-linux \
+                       virglrenderer-devel \
+                       vte291-devel \
+                       vulkan-tools \
+                       which \
+                       xen-devel \
+                       xorriso \
+                       zlib-devel \
+                       zlib-static \
+                       zstd && \
+    nosync dnf --quiet autoremove -y && \
+    nosync dnf --quiet clean all -y && \
     rm -f /usr/lib*/python3*/EXTERNALLY-MANAGED && \
     rpm -qa | sort > /packages.txt && \
     mkdir -p /usr/libexec/ccache-wrappers && \
diff --git a/tests/lcitool/libvirt-ci b/tests/lcitool/libvirt-ci
index caed407a0f1..514b0cd7f63 160000
--- a/tests/lcitool/libvirt-ci
+++ b/tests/lcitool/libvirt-ci
@@ -1 +1 @@
-Subproject commit caed407a0f1dfe3a3293a41c378c382deefbac36
+Subproject commit 514b0cd7f6375d0089f96e749079093906c532a8
diff --git a/tests/lcitool/refresh b/tests/lcitool/refresh
index 01a71929542..8f0aa3fa343 100755
--- a/tests/lcitool/refresh
+++ b/tests/lcitool/refresh
@@ -215,12 +215,12 @@ try:
     #
     # Standard native builds
     #
-    generate_dockerfile("alpine", "alpine-321",
+    generate_dockerfile("alpine", "alpine-323",
                         trailer="".join(alpine_extras))
     generate_dockerfile("centos9", "centos-stream-9")
     generate_dockerfile("debian", "debian-13",
                         trailer="".join(debian13_extras))
-    generate_dockerfile("fedora", "fedora-41")
+    generate_dockerfile("fedora", "fedora-43")
     generate_dockerfile("opensuse-leap", "opensuse-leap-15")
     generate_dockerfile("ubuntu2204", "ubuntu-2204",
                         trailer="".join(ubuntu2204_rust_extras),
@@ -230,7 +230,7 @@ try:
     #
     # Non-fatal Rust-enabled build
     #
-    generate_dockerfile("fedora-rust-nightly", "fedora-41",
+    generate_dockerfile("fedora-rust-nightly", "fedora-43",
                         trailer="".join(fedora_rustup_nightly_extras))
 
     #
@@ -287,7 +287,7 @@ try:
                         trailer=cross_build("s390x-linux-gnu-",
                                             "s390x-softmmu,s390x-linux-user"))
 
-    generate_dockerfile("fedora-win64-cross", "fedora-41",
+    generate_dockerfile("fedora-win64-cross", "fedora-43",
                         project='qemu,qemu-win-installer',
                         cross="mingw64",
                         trailer=cross_build("x86_64-w64-mingw32-",
-- 
2.53.0


