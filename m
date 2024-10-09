Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71ACBCEFC5D
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 09:49:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syTHs-0001SC-VY; Wed, 09 Oct 2024 05:47:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1syTHp-0001Mq-Gp
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 05:47:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1syTHm-0008Vt-OK
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 05:47:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728467233;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hT7inLHllM8RZKBYIy8Fuo0A70HrgCapOAuw2sK/64c=;
 b=QBTBAduxlMHe9QVyWsCaFqDO2ahCZQl8bwSVN6nrcyGPEbSpIFUASKXSnrrBBoarNwa8CO
 U4xFUnIOsxuQtTsfkNECtwuCRBgY9tUbxoNIW5sOGx3TOd0bSZxsxzoz2wBLwdHTalw9UD
 3SyGkpqaR6sZy2yU5eR1EOgQxejIMQ0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-576-gvgfd7m1Oku63pQfotOwpA-1; Wed, 09 Oct 2024 05:47:11 -0400
X-MC-Unique: gvgfd7m1Oku63pQfotOwpA-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-37d39bf2277so283757f8f.2
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2024 02:47:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728467230; x=1729072030;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hT7inLHllM8RZKBYIy8Fuo0A70HrgCapOAuw2sK/64c=;
 b=I0NaKG7hWFrcM3S+9leA5qDVpb65r2OSduF2zgJ5L/pdsgNWLvsCFI64NlWehzoRRX
 NvgZLUWBkPkgToj9CBUN1E+PAES0dO22tJq33nMKMAKZsCAEIV9Y23jsy+SMW0OgFaQq
 9ivLdaZ/K+ASgqgA3vkWQ4Is6YmUOyIIoYgbf7cg4w8OrDV3Pht8F58H2dHGO3hOJeGu
 9cV4zISGB+LrEWd9XdCrBESWOG8MNslPiQZ8+et8gZFo/xYg4wAxdaKuMHf81LKbxV2g
 b+sNsAaLYGYmxg0sO21he3AUPyd9NsUGQlDvDNNTLJlcmndNfdZsJKAcK5cyOcdxB9Ua
 eXLA==
X-Gm-Message-State: AOJu0Yz/EVs6bgA4XQU1iUFKJlVF8OaeXyigDQn6ELrxqQCz7R6faIYV
 KiEctXdrJJPS5zum9xUvxp+X5E8rGq6BgMF8CP7ycr1+b2DTIAxrVcNGcn/00ch6kM/NzkP5O/f
 xiWMT2D6ACQOVLiLuQuyVjnxYPjEWWSGl+Gk5VQmhbkRT/zi16WGEN93fdEoU6wRwJIxzCw7HZQ
 rGcSR46ViDMuMlPbVDOyq45sAXS2IqE+onCmlCVVc=
X-Received: by 2002:adf:f4ce:0:b0:374:c05f:231d with SMTP id
 ffacd0b85a97d-37d3a90f205mr1197864f8f.0.1728467229881; 
 Wed, 09 Oct 2024 02:47:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEGNhXeoiRd66MfNAD3JiWo4gUy40jBxoe+1J0A0mKg85eNCHDWb1CEGjyB2qm4YBVIsJnhbQ==
X-Received: by 2002:adf:f4ce:0:b0:374:c05f:231d with SMTP id
 ffacd0b85a97d-37d3a90f205mr1197849f8f.0.1728467229437; 
 Wed, 09 Oct 2024 02:47:09 -0700 (PDT)
Received: from avogadro.local ([151.62.111.131])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d1690f265sm9924889f8f.19.2024.10.09.02.47.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Oct 2024 02:47:08 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 13/14] dockerfiles: add a Dockerfile using a nightly Rust
 toolchain
Date: Wed,  9 Oct 2024 11:46:14 +0200
Message-ID: <20241009094616.1648511-14-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241009094616.1648511-1-pbonzini@redhat.com>
References: <20241009094616.1648511-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.151,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

This will be useful in order to test QEMU's Rust code with nightly
clippy.  It can also be used to check that the code builds, until the
minimum supported Rust version is lowered enough to allow enabling Rust
in other Dockerfiles too.

Use a separate container, instead of the Fedora one, to avoid that
CI breaks for everyone if for some reason the rustup build turns out
to be shaky.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 .../dockerfiles/fedora-rust-nightly.docker    | 173 ++++++++++++++++++
 tests/lcitool/refresh                         |  26 +++
 2 files changed, 199 insertions(+)
 create mode 100644 tests/docker/dockerfiles/fedora-rust-nightly.docker

diff --git a/tests/docker/dockerfiles/fedora-rust-nightly.docker b/tests/docker/dockerfiles/fedora-rust-nightly.docker
new file mode 100644
index 00000000000..e642db163c7
--- /dev/null
+++ b/tests/docker/dockerfiles/fedora-rust-nightly.docker
@@ -0,0 +1,173 @@
+# THIS FILE WAS AUTO-GENERATED
+#
+#  $ lcitool dockerfile --layers all fedora-40 qemu
+#
+# https://gitlab.com/libvirt/libvirt-ci
+
+FROM registry.fedoraproject.org/fedora:40
+
+RUN dnf install -y nosync && \
+    printf '#!/bin/sh\n\
+if test -d /usr/lib64\n\
+then\n\
+    export LD_PRELOAD=/usr/lib64/nosync/nosync.so\n\
+else\n\
+    export LD_PRELOAD=/usr/lib/nosync/nosync.so\n\
+fi\n\
+exec "$@"\n' > /usr/bin/nosync && \
+    chmod +x /usr/bin/nosync && \
+    nosync dnf update -y && \
+    nosync dnf install -y \
+               SDL2-devel \
+               SDL2_image-devel \
+               alsa-lib-devel \
+               bash \
+               bc \
+               bison \
+               brlapi-devel \
+               bzip2 \
+               bzip2-devel \
+               ca-certificates \
+               capstone-devel \
+               ccache \
+               clang \
+               ctags \
+               cyrus-sasl-devel \
+               daxctl-devel \
+               dbus-daemon \
+               device-mapper-multipath-devel \
+               diffutils \
+               findutils \
+               flex \
+               fuse3-devel \
+               gcc \
+               gcovr \
+               gettext \
+               git \
+               glib2-devel \
+               glib2-static \
+               glibc-langpack-en \
+               glibc-static \
+               glusterfs-api-devel \
+               gnutls-devel \
+               gtk-vnc2-devel \
+               gtk3-devel \
+               hostname \
+               jemalloc-devel \
+               json-c-devel \
+               libaio-devel \
+               libasan \
+               libattr-devel \
+               libbpf-devel \
+               libcacard-devel \
+               libcap-ng-devel \
+               libcmocka-devel \
+               libcurl-devel \
+               libdrm-devel \
+               libepoxy-devel \
+               libfdt-devel \
+               libffi-devel \
+               libgcrypt-devel \
+               libiscsi-devel \
+               libjpeg-devel \
+               libnfs-devel \
+               libpmem-devel \
+               libpng-devel \
+               librbd-devel \
+               libseccomp-devel \
+               libselinux-devel \
+               libslirp-devel \
+               libssh-devel \
+               libtasn1-devel \
+               libubsan \
+               liburing-devel \
+               libusbx-devel \
+               libxdp-devel \
+               libzstd-devel \
+               llvm \
+               lttng-ust-devel \
+               lzo-devel \
+               make \
+               mesa-libgbm-devel \
+               meson \
+               mtools \
+               ncurses-devel \
+               nettle-devel \
+               ninja-build \
+               nmap-ncat \
+               numactl-devel \
+               openssh-clients \
+               pam-devel \
+               pcre-static \
+               pipewire-devel \
+               pixman-devel \
+               pkgconfig \
+               pulseaudio-libs-devel \
+               python3 \
+               python3-PyYAML \
+               python3-numpy \
+               python3-opencv \
+               python3-pillow \
+               python3-pip \
+               python3-sphinx \
+               python3-sphinx_rtd_theme \
+               python3-zombie-imp \
+               rdma-core-devel \
+               sed \
+               snappy-devel \
+               socat \
+               sparse \
+               spice-protocol \
+               spice-server-devel \
+               swtpm \
+               systemd-devel \
+               systemtap-sdt-devel \
+               tar \
+               tesseract \
+               tesseract-langpack-eng \
+               usbredir-devel \
+               util-linux \
+               virglrenderer-devel \
+               vte291-devel \
+               which \
+               xen-devel \
+               xorriso \
+               zlib-devel \
+               zlib-static \
+               zstd && \
+    nosync dnf autoremove -y && \
+    nosync dnf clean all -y && \
+    rm -f /usr/lib*/python3*/EXTERNALLY-MANAGED && \
+    rpm -qa | sort > /packages.txt && \
+    mkdir -p /usr/libexec/ccache-wrappers && \
+    ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/cc && \
+    ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/clang && \
+    ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/gcc
+
+ENV CCACHE_WRAPPERSDIR "/usr/libexec/ccache-wrappers"
+ENV LANG "en_US.UTF-8"
+ENV MAKE "/usr/bin/make"
+ENV NINJA "/usr/bin/ninja"
+ENV PYTHON "/usr/bin/python3"
+RUN dnf install -y wget
+ENV RUSTUP_HOME=/usr/local/rustup CARGO_HOME=/usr/local/cargo
+ENV RUSTC=/usr/local/rustup/toolchains/nightly-x86_64-unknown-linux-gnu/bin/rustc
+RUN set -eux && \
+  rustArch='x86_64-unknown-linux-gnu' && \
+  rustupSha256='6aeece6993e902708983b209d04c0d1dbb14ebb405ddb87def578d41f920f56d' && \
+  url="https://static.rust-lang.org/rustup/archive/1.27.1/${rustArch}/rustup-init" && \
+  wget "$url" && \
+  echo "${rustupSha256} *rustup-init" | sha256sum -c - && \
+  chmod +x rustup-init && \
+  ./rustup-init -y --no-modify-path --profile default --default-toolchain nightly --default-host ${rustArch} && \
+  chmod -R a+w $RUSTUP_HOME $CARGO_HOME && \
+  /usr/local/cargo/bin/rustup --version && \
+  /usr/local/cargo/bin/rustup run nightly rustc --version && \
+  test "$RUSTC" = "$(/usr/local/cargo/bin/rustup +nightly which rustc)"
+ENV PATH=$CARGO_HOME/bin:$PATH
+RUN /usr/local/cargo/bin/rustup run nightly cargo install bindgen-cli
+# As a final step configure the user (if env is defined)
+ARG USER
+ARG UID
+RUN if [ "${USER}" ]; then \
+  id ${USER} 2>/dev/null || useradd -u ${UID} -U ${USER}; fi
diff --git a/tests/lcitool/refresh b/tests/lcitool/refresh
index a78219f7bc5..1ae0962f04c 100755
--- a/tests/lcitool/refresh
+++ b/tests/lcitool/refresh
@@ -116,6 +116,26 @@ debian12_extras = [
     "ENV QEMU_CONFIGURE_OPTS --enable-netmap\n"
 ]
 
+# Based on the hub.docker.com/library/rust Dockerfiles
+fedora_rustup_nightly_extras = [
+    "RUN dnf install -y wget\n",
+    "ENV RUSTUP_HOME=/usr/local/rustup CARGO_HOME=/usr/local/cargo\n",
+    "ENV RUSTC=/usr/local/rustup/toolchains/nightly-x86_64-unknown-linux-gnu/bin/rustc\n",
+    "RUN set -eux && \\\n",
+    "  rustArch='x86_64-unknown-linux-gnu' && \\\n",
+    "  rustupSha256='6aeece6993e902708983b209d04c0d1dbb14ebb405ddb87def578d41f920f56d' && \\\n",
+    '  url="https://static.rust-lang.org/rustup/archive/1.27.1/${rustArch}/rustup-init" && \\\n',
+    '  wget "$url" && \\\n',
+    '  echo "${rustupSha256} *rustup-init" | sha256sum -c - && \\\n',
+    "  chmod +x rustup-init && \\\n",
+    "  ./rustup-init -y --no-modify-path --profile default --default-toolchain nightly --default-host ${rustArch} && \\\n",
+    "  chmod -R a+w $RUSTUP_HOME $CARGO_HOME && \\\n",
+    "  /usr/local/cargo/bin/rustup --version && \\\n",
+    "  /usr/local/cargo/bin/rustup run nightly rustc --version && \\\n",
+    '  test "$RUSTC" = "$(/usr/local/cargo/bin/rustup +nightly which rustc)"\n',
+    'ENV PATH=$CARGO_HOME/bin:$PATH\n',
+    'RUN /usr/local/cargo/bin/rustup run nightly cargo install bindgen-cli\n',
+]
 
 def cross_build(prefix, targets):
     conf = "ENV QEMU_CONFIGURE_OPTS --cross-prefix=%s\n" % (prefix)
@@ -139,6 +159,12 @@ try:
     generate_dockerfile("opensuse-leap", "opensuse-leap-15")
     generate_dockerfile("ubuntu2204", "ubuntu-2204")
 
+    #
+    # Non-fatal Rust-enabled build
+    #
+    generate_dockerfile("fedora-rust-nightly", "fedora-40",
+                        trailer="".join(fedora_rustup_nightly_extras))
+
     #
     # Cross compiling builds
     #
-- 
2.46.2


