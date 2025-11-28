Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6898D116EA
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Nov 2025 18:22:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vP36s-00031T-OM; Fri, 28 Nov 2025 13:22:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vP36k-0002zX-RS
 for qemu-devel@nongnu.org; Fri, 28 Nov 2025 13:22:16 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vP36h-00036X-JV
 for qemu-devel@nongnu.org; Fri, 28 Nov 2025 13:22:14 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4779ce2a624so19496985e9.2
 for <qemu-devel@nongnu.org>; Fri, 28 Nov 2025 10:22:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764354119; x=1764958919; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IAQyAJgpGubRNxWkkAOB/xJeZ3yjTXTZaU1tMjDuYsk=;
 b=GCzhEU6EHUGAcTn4LrCCstviimvGLbf0HLG+pboCIW91UaPv33I8txFA20uf7E01Wd
 4Bmo8lv3mNzICQkajTvDQJDtZsmHrd2F6h/56cc2hqDCP5ActJzVQSwWRx4Xi6T7Fj/1
 gaY/Bd1FmMhwxMHO3XY9VWeSl4v8McFRLlIy5Qaj29eavwFG2sPz8Ng1geYTfBl0ENeL
 BlnrlJeZ/wjBq23Mog9YvgkzRrk6L2oDlXg+/m2XeeW7L8lIDELvpwKFkmzstU+FKYpn
 NYOB4scP7viQKiFsPFcf0j8ZeDG8SSeWlCAoNxIjn4uGHwDSLMna9r2ivQsKmHUYOzvj
 ULKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764354119; x=1764958919;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IAQyAJgpGubRNxWkkAOB/xJeZ3yjTXTZaU1tMjDuYsk=;
 b=vK3rs8i/czHRUyMuIcx5XxoxOhNcF2FzOx1ZALTajrm6RfsPTLWAWh736BHfpsGAn8
 D+LkraQk49ysJBFEVjDxyFX1KtiWIb7NPc2LVilDvYqZM9299pzeUuQU/T3YUcg4nVdO
 wnExCdlV026lvX+TyIkmDJobmrh0pCFPFAS2gppokpimD7HRjB7907h7+Qx6sOf7Ha6W
 ThnvBcB+KAbMT5qRvB8nStKD8s39ERvsBUWewIu4gNgLfFT5GbLcsZbhLS03VQlWd40A
 5pmXjEyzCeVBhHOun3xJDk21GvVrOPJsmkOclel4Lt9ygwM3shzBrQvMfSpn3Zp3MNtC
 KanQ==
X-Gm-Message-State: AOJu0YwBmcEDD1gYwco5eEaQnTS7JyvjMyWZKwBxVT+bpbn8ZCO9dYTt
 9VUzhbKfryxJtW2J4XrWAyHUWvryvMLkEJR8c6zgjs5p6ejWO2yGAI2xevwKLE8E/Nk=
X-Gm-Gg: ASbGncuLeEmhObRpgUu3IlS2q0wx62L08OIAml8En4cqsc1Tq3KAAfO9y249iMa5juf
 C4pKS9biw3EOy5kv1fekjFjT9VtQpXcmqDNLlaO1PHtysR2xqGysz9wokPIcaN2vuIp08XTMi1o
 rK6NGZf18QB+K/t00lyCMDjPHAyrHJKfAVOJSEz3HCitwQ7U/iXCpa7yT6ZTz6jTJQ9dg/1M+iC
 SIOpAwWWX4g2ImtX4YsTuR8s3HUzk1h7BanoHFdIexx+o3HxNpHGgaEOH+oTOxYMzwNYxhLObjn
 WfT2EZTeQaVgPFmAafHny5ToFXhjvrLhaIy1RYAeg9D2XEtUGEm7/odJ2kuVHibRk3coRQQOXeR
 IftXDYyvYmbm8gaAdXxBnkeJQlWDUiW6BLXrFnqy4k/zBqyYtldcFh+jrEsd2epGmcpVN9WYX3Y
 ZsucymGmKnVhQ=
X-Google-Smtp-Source: AGHT+IGUKS88VUyI4SNGgHqvQXeVaVEyU18MSvhrIRToJ9oU0nDASusK79Y+FFfx02MG0LGDOcqvuA==
X-Received: by 2002:a05:600c:3ba8:b0:477:af8d:203a with SMTP id
 5b1f17b1804b1-47904b24076mr161290475e9.27.1764354119274; 
 Fri, 28 Nov 2025 10:21:59 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42e1ca1a303sm11560447f8f.27.2025.11.28.10.21.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Nov 2025 10:21:58 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 110C85F8FD;
 Fri, 28 Nov 2025 18:21:58 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 3/5] tests/dockerfiles: transition debian-all-test-cross to
 lcitool
Date: Fri, 28 Nov 2025 18:21:55 +0000
Message-ID: <20251128182157.4125745-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251128182157.4125745-1-alex.bennee@linaro.org>
References: <20251128182157.4125745-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

While we are at it bump up to debian-13. As we use this container in
the CI runs this also has the benefit of ensuring our qemu-minimal
dependencies project really has just what we need to build a basic
QEMU.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .../dockerfiles/debian-all-test-cross.docker  | 122 ++++++++++--------
 tests/lcitool/refresh                         |  43 ++++++
 2 files changed, 111 insertions(+), 54 deletions(-)

diff --git a/tests/docker/dockerfiles/debian-all-test-cross.docker b/tests/docker/dockerfiles/debian-all-test-cross.docker
index 420a4e33e60..7c33630a83b 100644
--- a/tests/docker/dockerfiles/debian-all-test-cross.docker
+++ b/tests/docker/dockerfiles/debian-all-test-cross.docker
@@ -1,77 +1,91 @@
+# THIS FILE WAS AUTO-GENERATED
 #
-# Docker all cross-compiler target (tests only)
+#  $ lcitool dockerfile --layers all debian-13 qemu-minimal
 #
-# While the normal cross builds take care to setup proper multiarch
-# build environments which can cross build QEMU this just installs the
-# basic compilers for as many targets as possible. We shall use this
-# to build and run linux-user tests on GitLab
-#
-FROM docker.io/library/debian:12-slim
+# https://gitlab.com/libvirt/libvirt-ci
 
-# Duplicate deb line as deb-src
-RUN sed -in "s/Types: deb/Types: deb deb-src/g" /etc/apt/sources.list.d/debian.sources
+FROM docker.io/library/debian:13-slim
 
 RUN export DEBIAN_FRONTEND=noninteractive && \
     apt-get update && \
     apt-get install -y eatmydata && \
     eatmydata apt-get dist-upgrade -y && \
-    apt build-dep -yy --arch-only qemu
+    eatmydata apt-get install --no-install-recommends -y \
+                      bash \
+                      bc \
+                      bison \
+                      bzip2 \
+                      ca-certificates \
+                      ccache \
+                      findutils \
+                      flex \
+                      gcc \
+                      git \
+                      libc6-dev \
+                      libfdt-dev \
+                      libffi-dev \
+                      libglib2.0-dev \
+                      libpixman-1-dev \
+                      locales \
+                      make \
+                      ninja-build \
+                      pkgconf \
+                      python3 \
+                      python3-pip \
+                      python3-setuptools \
+                      python3-venv \
+                      python3-wheel \
+                      sed \
+                      tar && \
+    eatmydata apt-get autoremove -y && \
+    eatmydata apt-get autoclean -y && \
+    sed -Ei 's,^# (en_US\.UTF-8 .*)$,\1,' /etc/locale.gen && \
+    dpkg-reconfigure locales && \
+    rm -f /usr/lib*/python3*/EXTERNALLY-MANAGED && \
+    dpkg-query --showformat '${Package}_${Version}_${Architecture}\n' --show > /packages.txt && \
+    mkdir -p /usr/libexec/ccache-wrappers && \
+    ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/cc && \
+    ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/gcc
 
-# Add extra build tools and as many cross compilers as we can for testing
-RUN DEBIAN_FRONTEND=noninteractive eatmydata \
-        apt install -y --no-install-recommends \
-        bison \
-        ccache \
-        clang  \
-        dpkg-dev \
-        flex \
-        gcc \
-        git \
-        libclang-rt-dev \
-        ninja-build \
-        python3-pip \
-        python3-setuptools \
-        python3-tomli \
-        python3-venv \
-        python3-wheel
+RUN /usr/bin/pip3 install meson==1.8.1
 
-# All the generally available compilers
+ENV CCACHE_WRAPPERSDIR="/usr/libexec/ccache-wrappers"
+ENV LANG="en_US.UTF-8"
+ENV MAKE="/usr/bin/make"
+ENV NINJA="/usr/bin/ninja"
+ENV PYTHON="/usr/bin/python3"
 ENV AVAILABLE_COMPILERS gcc-aarch64-linux-gnu \
-        libc6-dev-arm64-cross \
-        gcc-arm-linux-gnueabihf \
-        libc6-dev-armhf-cross \
-        gcc-mips-linux-gnu \
-        libc6-dev-mips-cross \
-        gcc-mips64-linux-gnuabi64 \
-        libc6-dev-mips64-cross \
-        gcc-mips64el-linux-gnuabi64 \
-        libc6-dev-mips64el-cross \
-        gcc-mipsel-linux-gnu \
-        libc6-dev-mipsel-cross \
-        gcc-powerpc64le-linux-gnu \
-        libc6-dev-ppc64el-cross \
-        gcc-riscv64-linux-gnu \
-        libc6-dev-riscv64-cross \
-        gcc-s390x-linux-gnu \
-        libc6-dev-s390x-cross
-
+  libc6-dev-arm64-cross \
+  gcc-arm-linux-gnueabihf \
+  libc6-dev-armhf-cross \
+  gcc-mips-linux-gnu \
+  libc6-dev-mips-cross \
+  gcc-mips64-linux-gnuabi64 \
+  libc6-dev-mips64-cross \
+  gcc-mips64el-linux-gnuabi64 \
+  libc6-dev-mips64el-cross \
+  gcc-mipsel-linux-gnu \
+  libc6-dev-mipsel-cross \
+  gcc-powerpc64le-linux-gnu \
+  libc6-dev-ppc64el-cross \
+  gcc-riscv64-linux-gnu \
+  libc6-dev-riscv64-cross \
+  gcc-s390x-linux-gnu \
+  libc6-dev-s390x-cross
 RUN if dpkg-architecture -e amd64; then \
   export AVAILABLE_COMPILERS="${AVAILABLE_COMPILERS} gcc-hppa-linux-gnu libc6-dev-hppa-cross"; \
   export AVAILABLE_COMPILERS="${AVAILABLE_COMPILERS} gcc-m68k-linux-gnu libc6-dev-m68k-cross"; \
   export AVAILABLE_COMPILERS="${AVAILABLE_COMPILERS} gcc-powerpc-linux-gnu libc6-dev-powerpc-cross"; \
   export AVAILABLE_COMPILERS="${AVAILABLE_COMPILERS} gcc-powerpc64-linux-gnu libc6-dev-ppc64-cross"; \
   export AVAILABLE_COMPILERS="${AVAILABLE_COMPILERS} gcc-sparc64-linux-gnu libc6-dev-sparc64-cross"; \
-  fi && \
-  DEBIAN_FRONTEND=noninteractive eatmydata \
-        apt install -y --no-install-recommends \
-        ${AVAILABLE_COMPILERS} && \
-        dpkg-query --showformat '${Package}_${Version}_${Architecture}\n' --show > /packages.txt
-
-
+fi && \
+DEBIAN_FRONTEND=noninteractive eatmydata \
+apt install -y --no-install-recommends \
+${AVAILABLE_COMPILERS} && \
+dpkg-query --showformat '${Package}_${Version}_${Architecture}' --show > /packages.txt
 ENV QEMU_CONFIGURE_OPTS --disable-system --disable-docs --disable-tools
 ENV DEF_TARGET_LIST aarch64-linux-user,arm-linux-user,hppa-linux-user,i386-linux-user,m68k-linux-user,mips-linux-user,mips64-linux-user,mips64el-linux-user,mipsel-linux-user,ppc-linux-user,ppc64-linux-user,ppc64le-linux-user,riscv64-linux-user,s390x-linux-user,sparc64-linux-user
 # As a final step configure the user (if env is defined)
-ENV MAKE /usr/bin/make
 ARG USER
 ARG UID
 RUN if [ "${USER}" ]; then \
diff --git a/tests/lcitool/refresh b/tests/lcitool/refresh
index 3a31fcfee9c..714e989c953 100755
--- a/tests/lcitool/refresh
+++ b/tests/lcitool/refresh
@@ -161,6 +161,40 @@ ubuntu2204_rust_extras = [
     'RUN cargo install bindgen-cli\n',
 ]
 
+debian_all_test_cross_compilers = [
+    "ENV AVAILABLE_COMPILERS gcc-aarch64-linux-gnu \\\n",
+    "  libc6-dev-arm64-cross \\\n",
+    "  gcc-arm-linux-gnueabihf \\\n",
+    "  libc6-dev-armhf-cross \\\n",
+    "  gcc-mips-linux-gnu \\\n",
+    "  libc6-dev-mips-cross \\\n",
+    "  gcc-mips64-linux-gnuabi64 \\\n",
+    "  libc6-dev-mips64-cross \\\n",
+    "  gcc-mips64el-linux-gnuabi64 \\\n",
+    "  libc6-dev-mips64el-cross \\\n",
+    "  gcc-mipsel-linux-gnu \\\n",
+    "  libc6-dev-mipsel-cross \\\n",
+    "  gcc-powerpc64le-linux-gnu \\\n",
+    "  libc6-dev-ppc64el-cross \\\n",
+    "  gcc-riscv64-linux-gnu \\\n",
+    "  libc6-dev-riscv64-cross \\\n",
+    "  gcc-s390x-linux-gnu \\\n",
+    "  libc6-dev-s390x-cross\n",
+    "RUN if dpkg-architecture -e amd64; then \\\n",
+    "  export AVAILABLE_COMPILERS=\"${AVAILABLE_COMPILERS} gcc-hppa-linux-gnu libc6-dev-hppa-cross\"; \\\n",
+    "  export AVAILABLE_COMPILERS=\"${AVAILABLE_COMPILERS} gcc-m68k-linux-gnu libc6-dev-m68k-cross\"; \\\n",
+    "  export AVAILABLE_COMPILERS=\"${AVAILABLE_COMPILERS} gcc-powerpc-linux-gnu libc6-dev-powerpc-cross\"; \\\n",
+    "  export AVAILABLE_COMPILERS=\"${AVAILABLE_COMPILERS} gcc-powerpc64-linux-gnu libc6-dev-ppc64-cross\"; \\\n",
+    "  export AVAILABLE_COMPILERS=\"${AVAILABLE_COMPILERS} gcc-sparc64-linux-gnu libc6-dev-sparc64-cross\"; \\\n",
+    "fi && \\\n",
+    "DEBIAN_FRONTEND=noninteractive eatmydata \\\n",
+    "apt install -y --no-install-recommends \\\n",
+    "${AVAILABLE_COMPILERS} && \\\n",
+    "dpkg-query --showformat '${Package}_${Version}_${Architecture}' --show > /packages.txt\n",
+    "ENV QEMU_CONFIGURE_OPTS --disable-system --disable-docs --disable-tools\n",
+    "ENV DEF_TARGET_LIST aarch64-linux-user,arm-linux-user,hppa-linux-user,i386-linux-user,m68k-linux-user,mips-linux-user,mips64-linux-user,mips64el-linux-user,mipsel-linux-user,ppc-linux-user,ppc64-linux-user,ppc64le-linux-user,riscv64-linux-user,s390x-linux-user,sparc64-linux-user\n",
+]
+
 def cross_build(prefix, targets):
     conf = "ENV QEMU_CONFIGURE_OPTS=--cross-prefix=%s\n" % (prefix)
     targets = "ENV DEF_TARGET_LIST=%s\n" % (targets)
@@ -256,6 +290,15 @@ try:
                         # https://github.com/mesonbuild/meson/pull/14991
                         enable_rust=False)
 
+    # We also generate some docker files with minimal dependencies and
+    # as many cross-compilers as Debian will package for building TCG
+    # tests.
+
+    generate_dockerfile("debian-all-test-cross", "debian-13",
+                        project="qemu-minimal",
+                        enable_rust=False,
+                        trailer="".join(debian_all_test_cross_compilers))
+
     #
     # Cirrus packages lists for GitLab
     #
-- 
2.47.3


