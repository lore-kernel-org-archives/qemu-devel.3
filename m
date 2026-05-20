Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B28ECD5BA4
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 19:24:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPmWT-0007Cg-Al; Wed, 20 May 2026 15:24:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPmWP-0007BJ-Ml
 for qemu-devel@nongnu.org; Wed, 20 May 2026 15:24:03 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPmWL-0001hd-Ej
 for qemu-devel@nongnu.org; Wed, 20 May 2026 15:24:00 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-48d146705b4so58507915e9.3
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 12:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779305034; x=1779909834; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=K7o1REZCIRQjP6nGv0AU1D9abS0hPdsXD8frplxvXTQ=;
 b=FrRI+k0PgY25Fv71IChh5mnP3iGthO2HG4vM03VslYY/hBekWXpa6S2XxpNKJJkJTs
 uaHATUG1zRkJ8ViN5/+1pHHFUt51THQ1/Mkm7CbmGpYoA97PS3RJPSaDVbM6wTuV+YVD
 Yo5QnwXFQKHOvAVpJwwjGQwfnX/bXOXWeYc8Yo5rRXC+9piO4Bf2x2vPykcVBrDftKyL
 wy/i4zm2ByPypgSkCkvPKssTm/pLayr+goLUaLb7bhS8rrP7P4PQLI0BS+6tGI4b+B+J
 Vc+ru4lAuBy85zFbJQB5OyEaE7tkXHHtLkoXYm/6i4ZwM6FyvryRsT6dmcKeNouWY7YL
 zY/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779305034; x=1779909834;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=K7o1REZCIRQjP6nGv0AU1D9abS0hPdsXD8frplxvXTQ=;
 b=sfguVdkqqk/DaOjOvyKnHfbUYWDRYSh+7yqHBt2iEfRglr7oDJUftBBSrIjVOiIat5
 ILzHKUFcilUIC6EKTn0vw2ACw6sO67AYtPCqslNllM0cDuyKks7OrXccQBwe2N/DgScF
 D/0NJYzULLTKPb/nUAUYYQger0bAi+2oeTc2tc01d/3iIsEjlUKO9OVWO4DIqUdWb1PT
 BDGHE8aNWuVS0e+pnrYIf9mJCslHW4t+LnQ0qKJ/krqqW+tHr0xJOe8l8oY8tgp+2q0M
 Si5S/+1rJnfQ7wZa3VTSDNAOeBjuRqI2SPfDD2kM9rOU6zGvXS69qzKgkJ7pigYYbjgR
 m6pQ==
X-Gm-Message-State: AOJu0YyJQDsUarDMngFjE4RM5BofFoh6qQi/z6iO1dYRQm56W6G1BqXY
 SJm18xIE73fDyUHMwp9uELgCxr4ZfsK+TpzxXHZk8wY6j9NbrS0hfXeYp2H0j0OqNZ1LukwLtkL
 no2hJ9cI=
X-Gm-Gg: Acq92OGKhCT7htQoe6C0WTMLLTcKiSIgGq0ETyD86LPxDNNUBTQE5WR8AOf0UHwY6Zu
 r7Xv+T+zVQ6w9NrOs1qGeKJQJF28VuTE41vCncMeKmGiMw+G31Y7r5cVe9ZJMuhVL/gwtaVgyt+
 hFd40OrlxCHMj/d/XPA+Qz6Hbn7R5wcHS2wchDcwiE7uLlDwWv4LNXzJBco/p/9yA3jLng+3deB
 LlW/moC9k0Ug8euIjOfjiPWHsjmmTVHWjMTdrQS9ZxeuElUH7COwb6EEVYd5+VLWJldfXErE828
 u5cvMvrT27ctOcgqJDR5leaw3EIMUqZooY565lbSPec9aUx8fP/ngBoFv2kD1B5aZeh8MORKkVO
 5QDnZqgPSU7AUL/OQGmH2w4f7/yLuHbE/0SPCjLbolG9j+w1TNknM0Q7z2XtpIhdgJYDGW+CFrM
 kz6G+YJG/Aw5JSTrXrzA/t600w+JmFwecTijYKKpKFF21qDEY4OhMFbdgXe7dnVRSfjlCk+vpp
X-Received: by 2002:a05:600c:a406:b0:487:1fb4:7e1 with SMTP id
 5b1f17b1804b1-48fe632a02fmr323172625e9.22.1779305034338; 
 Wed, 20 May 2026 12:23:54 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49033d52a0bsm10744165e9.7.2026.05.20.12.23.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 20 May 2026 12:23:53 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/33] docker: Remove LegacyKeyValueFormat warnings in
 generated files
Date: Wed, 20 May 2026 21:23:07 +0200
Message-ID: <20260520192338.40036-3-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260520192338.40036-1-philmd@linaro.org>
References: <20260520192338.40036-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

Display lcitool changes before generated ones.

Update lcitool refresh script to not use legacy 'ENV key value'
format:
https://docs.docker.com/reference/build-checks/legacy-key-value-format/

Run "make lcitool-refresh" to update the generated container files.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-ID: <20260518102222.80735-8-philmd@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/lcitool/refresh                                | 12 +++++++-----
 tests/docker/dockerfiles/alpine.docker               |  2 +-
 tests/docker/dockerfiles/centos9.docker              |  2 +-
 .../docker/dockerfiles/debian-all-test-cross.docker  | 10 ++++++----
 tests/docker/dockerfiles/debian-amd64-cross.docker   |  2 +-
 tests/docker/dockerfiles/debian-arm64-cross.docker   |  2 +-
 tests/docker/dockerfiles/debian-armhf-cross.docker   |  2 +-
 tests/docker/dockerfiles/debian-i686-cross.docker    |  2 +-
 .../docker/dockerfiles/debian-mips64el-cross.docker  |  2 +-
 tests/docker/dockerfiles/debian-mipsel-cross.docker  |  2 +-
 tests/docker/dockerfiles/debian-ppc64el-cross.docker |  2 +-
 tests/docker/dockerfiles/debian-riscv64-cross.docker |  2 +-
 tests/docker/dockerfiles/debian-s390x-cross.docker   |  2 +-
 tests/docker/dockerfiles/debian.docker               |  2 +-
 tests/docker/dockerfiles/fedora-rust-nightly.docker  |  2 +-
 tests/docker/dockerfiles/fedora-win64-cross.docker   |  2 +-
 tests/docker/dockerfiles/fedora.docker               |  2 +-
 tests/docker/dockerfiles/opensuse-leap.docker        |  2 +-
 scripts/git.orderfile                                |  4 ++++
 19 files changed, 33 insertions(+), 25 deletions(-)

diff --git a/tests/lcitool/refresh b/tests/lcitool/refresh
index e4d01d792b7..a736f7f0ae6 100755
--- a/tests/lcitool/refresh
+++ b/tests/lcitool/refresh
@@ -77,7 +77,7 @@ def generate_dockerfile(host, target, project="qemu", cross=None, trailer=None,
         trailer = "\n".join(add_user_mapping)
 
     if enable_rust:
-        trailer += "\nENV ENABLE_RUST 1\n"
+        trailer += "\nENV ENABLE_RUST=1\n"
     generate(filename, cmd, trailer)
 
 
@@ -169,7 +169,8 @@ debian_all_test_cross_compilers = [
     "  dpkg-dev\\\n",
     "  gdb-multiarch\\\n",
     "  libclang-rt-dev\n",
-    "ENV AVAILABLE_COMPILERS gcc-aarch64-linux-gnu \\\n",
+    "ENV AVAILABLE_COMPILERS=\"\\\n",
+    "  gcc-aarch64-linux-gnu \\\n",
     "  libc6-dev-arm64-cross \\\n",
     "  gcc-arm-linux-gnueabihf \\\n",
     "  libc6-dev-armhf-cross \\\n",
@@ -190,7 +191,8 @@ debian_all_test_cross_compilers = [
     "  gcc-s390x-linux-gnu \\\n",
     "  libc6-dev-s390x-cross\\\n",
     "  gcc-sh4-linux-gnu \\\n",
-    "  libc6-dev-sh4-cross\n",
+    "  libc6-dev-sh4-cross \\\n",
+    "  \"\n",
     "RUN if dpkg-architecture -e amd64; then \\\n",
     "  export AVAILABLE_COMPILERS=\"${AVAILABLE_COMPILERS} gcc-hppa-linux-gnu libc6-dev-hppa-cross\"; \\\n",
     "  export AVAILABLE_COMPILERS=\"${AVAILABLE_COMPILERS} gcc-m68k-linux-gnu libc6-dev-m68k-cross\"; \\\n",
@@ -202,8 +204,8 @@ debian_all_test_cross_compilers = [
     "apt install -y --no-install-recommends \\\n",
     "${AVAILABLE_COMPILERS} && \\\n",
     "dpkg-query --showformat '${Package}_${Version}_${Architecture}' --show > /packages.txt\n",
-    "ENV QEMU_CONFIGURE_OPTS --disable-docs\n",
-    "ENV DEF_TARGET_LIST aarch64-linux-user,alpha-linux-user,arm-linux-user,hppa-linux-user,i386-linux-user,m68k-linux-user,mips-linux-user,mips64-linux-user,mips64el-linux-user,mipsel-linux-user,ppc-linux-user,ppc64-linux-user,ppc64le-linux-user,riscv64-linux-user,s390x-linux-user,sh4-linux-user,sparc64-linux-user\n",
+    "ENV QEMU_CONFIGURE_OPTS=--disable-docs\n",
+    "ENV DEF_TARGET_LIST=aarch64-linux-user,alpha-linux-user,arm-linux-user,hppa-linux-user,i386-linux-user,m68k-linux-user,mips-linux-user,mips64-linux-user,mips64el-linux-user,mipsel-linux-user,ppc-linux-user,ppc64-linux-user,ppc64le-linux-user,riscv64-linux-user,s390x-linux-user,sh4-linux-user,sparc64-linux-user\n",
 ]
 
 def cross_build(prefix, targets):
diff --git a/tests/docker/dockerfiles/alpine.docker b/tests/docker/dockerfiles/alpine.docker
index a7ee85fcda7..118c6e8eeaf 100644
--- a/tests/docker/dockerfiles/alpine.docker
+++ b/tests/docker/dockerfiles/alpine.docker
@@ -141,4 +141,4 @@ ARG UID
 RUN if [ "${USER}" ]; then \
   id ${USER} 2>/dev/null || useradd -u ${UID} -U ${USER}; fi
 
-ENV ENABLE_RUST 1
+ENV ENABLE_RUST=1
diff --git a/tests/docker/dockerfiles/centos9.docker b/tests/docker/dockerfiles/centos9.docker
index 41a1225856e..0d5b5fa7f59 100644
--- a/tests/docker/dockerfiles/centos9.docker
+++ b/tests/docker/dockerfiles/centos9.docker
@@ -145,4 +145,4 @@ ARG UID
 RUN if [ "${USER}" ]; then \
   id ${USER} 2>/dev/null || useradd -u ${UID} -U ${USER}; fi
 
-ENV ENABLE_RUST 1
+ENV ENABLE_RUST=1
diff --git a/tests/docker/dockerfiles/debian-all-test-cross.docker b/tests/docker/dockerfiles/debian-all-test-cross.docker
index 287770a995a..a10ffc73500 100644
--- a/tests/docker/dockerfiles/debian-all-test-cross.docker
+++ b/tests/docker/dockerfiles/debian-all-test-cross.docker
@@ -61,7 +61,8 @@ RUN DEBIAN_FRONTEND=noninteractive eatmydata \
   dpkg-dev\
   gdb-multiarch\
   libclang-rt-dev
-ENV AVAILABLE_COMPILERS gcc-aarch64-linux-gnu \
+ENV AVAILABLE_COMPILERS="\
+  gcc-aarch64-linux-gnu \
   libc6-dev-arm64-cross \
   gcc-arm-linux-gnueabihf \
   libc6-dev-armhf-cross \
@@ -82,7 +83,8 @@ ENV AVAILABLE_COMPILERS gcc-aarch64-linux-gnu \
   gcc-s390x-linux-gnu \
   libc6-dev-s390x-cross\
   gcc-sh4-linux-gnu \
-  libc6-dev-sh4-cross
+  libc6-dev-sh4-cross \
+  "
 RUN if dpkg-architecture -e amd64; then \
   export AVAILABLE_COMPILERS="${AVAILABLE_COMPILERS} gcc-hppa-linux-gnu libc6-dev-hppa-cross"; \
   export AVAILABLE_COMPILERS="${AVAILABLE_COMPILERS} gcc-m68k-linux-gnu libc6-dev-m68k-cross"; \
@@ -94,8 +96,8 @@ DEBIAN_FRONTEND=noninteractive eatmydata \
 apt install -y --no-install-recommends \
 ${AVAILABLE_COMPILERS} && \
 dpkg-query --showformat '${Package}_${Version}_${Architecture}' --show > /packages.txt
-ENV QEMU_CONFIGURE_OPTS --disable-docs
-ENV DEF_TARGET_LIST aarch64-linux-user,alpha-linux-user,arm-linux-user,hppa-linux-user,i386-linux-user,m68k-linux-user,mips-linux-user,mips64-linux-user,mips64el-linux-user,mipsel-linux-user,ppc-linux-user,ppc64-linux-user,ppc64le-linux-user,riscv64-linux-user,s390x-linux-user,sh4-linux-user,sparc64-linux-user
+ENV QEMU_CONFIGURE_OPTS=--disable-docs
+ENV DEF_TARGET_LIST=aarch64-linux-user,alpha-linux-user,arm-linux-user,hppa-linux-user,i386-linux-user,m68k-linux-user,mips-linux-user,mips64-linux-user,mips64el-linux-user,mipsel-linux-user,ppc-linux-user,ppc64-linux-user,ppc64le-linux-user,riscv64-linux-user,s390x-linux-user,sh4-linux-user,sparc64-linux-user
 # As a final step configure the user (if env is defined)
 ARG USER
 ARG UID
diff --git a/tests/docker/dockerfiles/debian-amd64-cross.docker b/tests/docker/dockerfiles/debian-amd64-cross.docker
index 35c593502fc..061cd8e9b82 100644
--- a/tests/docker/dockerfiles/debian-amd64-cross.docker
+++ b/tests/docker/dockerfiles/debian-amd64-cross.docker
@@ -188,4 +188,4 @@ ARG UID
 RUN if [ "${USER}" ]; then \
   id ${USER} 2>/dev/null || useradd -u ${UID} -U ${USER}; fi
 
-ENV ENABLE_RUST 1
+ENV ENABLE_RUST=1
diff --git a/tests/docker/dockerfiles/debian-arm64-cross.docker b/tests/docker/dockerfiles/debian-arm64-cross.docker
index d188d538365..3dfa60fdfd7 100644
--- a/tests/docker/dockerfiles/debian-arm64-cross.docker
+++ b/tests/docker/dockerfiles/debian-arm64-cross.docker
@@ -187,4 +187,4 @@ ARG UID
 RUN if [ "${USER}" ]; then \
   id ${USER} 2>/dev/null || useradd -u ${UID} -U ${USER}; fi
 
-ENV ENABLE_RUST 1
+ENV ENABLE_RUST=1
diff --git a/tests/docker/dockerfiles/debian-armhf-cross.docker b/tests/docker/dockerfiles/debian-armhf-cross.docker
index 988c87075f6..401c64269c1 100644
--- a/tests/docker/dockerfiles/debian-armhf-cross.docker
+++ b/tests/docker/dockerfiles/debian-armhf-cross.docker
@@ -185,4 +185,4 @@ ARG UID
 RUN if [ "${USER}" ]; then \
   id ${USER} 2>/dev/null || useradd -u ${UID} -U ${USER}; fi
 
-ENV ENABLE_RUST 1
+ENV ENABLE_RUST=1
diff --git a/tests/docker/dockerfiles/debian-i686-cross.docker b/tests/docker/dockerfiles/debian-i686-cross.docker
index d720ebb0bca..8b60c7b085f 100644
--- a/tests/docker/dockerfiles/debian-i686-cross.docker
+++ b/tests/docker/dockerfiles/debian-i686-cross.docker
@@ -185,4 +185,4 @@ ARG UID
 RUN if [ "${USER}" ]; then \
   id ${USER} 2>/dev/null || useradd -u ${UID} -U ${USER}; fi
 
-ENV ENABLE_RUST 1
+ENV ENABLE_RUST=1
diff --git a/tests/docker/dockerfiles/debian-mips64el-cross.docker b/tests/docker/dockerfiles/debian-mips64el-cross.docker
index d139c10c555..fc83fc0c00b 100644
--- a/tests/docker/dockerfiles/debian-mips64el-cross.docker
+++ b/tests/docker/dockerfiles/debian-mips64el-cross.docker
@@ -183,4 +183,4 @@ ARG UID
 RUN if [ "${USER}" ]; then \
   id ${USER} 2>/dev/null || useradd -u ${UID} -U ${USER}; fi
 
-ENV ENABLE_RUST 1
+ENV ENABLE_RUST=1
diff --git a/tests/docker/dockerfiles/debian-mipsel-cross.docker b/tests/docker/dockerfiles/debian-mipsel-cross.docker
index 2cfc33e8249..5f105b1d687 100644
--- a/tests/docker/dockerfiles/debian-mipsel-cross.docker
+++ b/tests/docker/dockerfiles/debian-mipsel-cross.docker
@@ -183,4 +183,4 @@ ARG UID
 RUN if [ "${USER}" ]; then \
   id ${USER} 2>/dev/null || useradd -u ${UID} -U ${USER}; fi
 
-ENV ENABLE_RUST 1
+ENV ENABLE_RUST=1
diff --git a/tests/docker/dockerfiles/debian-ppc64el-cross.docker b/tests/docker/dockerfiles/debian-ppc64el-cross.docker
index 7198036380b..2a7e8cba056 100644
--- a/tests/docker/dockerfiles/debian-ppc64el-cross.docker
+++ b/tests/docker/dockerfiles/debian-ppc64el-cross.docker
@@ -186,4 +186,4 @@ ARG UID
 RUN if [ "${USER}" ]; then \
   id ${USER} 2>/dev/null || useradd -u ${UID} -U ${USER}; fi
 
-ENV ENABLE_RUST 1
+ENV ENABLE_RUST=1
diff --git a/tests/docker/dockerfiles/debian-riscv64-cross.docker b/tests/docker/dockerfiles/debian-riscv64-cross.docker
index eb49da9781a..349de3a0bbb 100644
--- a/tests/docker/dockerfiles/debian-riscv64-cross.docker
+++ b/tests/docker/dockerfiles/debian-riscv64-cross.docker
@@ -186,4 +186,4 @@ ARG UID
 RUN if [ "${USER}" ]; then \
   id ${USER} 2>/dev/null || useradd -u ${UID} -U ${USER}; fi
 
-ENV ENABLE_RUST 1
+ENV ENABLE_RUST=1
diff --git a/tests/docker/dockerfiles/debian-s390x-cross.docker b/tests/docker/dockerfiles/debian-s390x-cross.docker
index f4c7896a75f..8bc42b1e00b 100644
--- a/tests/docker/dockerfiles/debian-s390x-cross.docker
+++ b/tests/docker/dockerfiles/debian-s390x-cross.docker
@@ -185,4 +185,4 @@ ARG UID
 RUN if [ "${USER}" ]; then \
   id ${USER} 2>/dev/null || useradd -u ${UID} -U ${USER}; fi
 
-ENV ENABLE_RUST 1
+ENV ENABLE_RUST=1
diff --git a/tests/docker/dockerfiles/debian.docker b/tests/docker/dockerfiles/debian.docker
index 85b78f7e5f8..ee8b313d654 100644
--- a/tests/docker/dockerfiles/debian.docker
+++ b/tests/docker/dockerfiles/debian.docker
@@ -175,4 +175,4 @@ ARG UID
 RUN if [ "${USER}" ]; then \
   id ${USER} 2>/dev/null || useradd -u ${UID} -U ${USER}; fi
 
-ENV ENABLE_RUST 1
+ENV ENABLE_RUST=1
diff --git a/tests/docker/dockerfiles/fedora-rust-nightly.docker b/tests/docker/dockerfiles/fedora-rust-nightly.docker
index 5e88354f133..4f84b803798 100644
--- a/tests/docker/dockerfiles/fedora-rust-nightly.docker
+++ b/tests/docker/dockerfiles/fedora-rust-nightly.docker
@@ -185,4 +185,4 @@ ARG UID
 RUN if [ "${USER}" ]; then \
   id ${USER} 2>/dev/null || useradd -u ${UID} -U ${USER}; fi
 
-ENV ENABLE_RUST 1
+ENV ENABLE_RUST=1
diff --git a/tests/docker/dockerfiles/fedora-win64-cross.docker b/tests/docker/dockerfiles/fedora-win64-cross.docker
index 751789e849b..c1e63feb46f 100644
--- a/tests/docker/dockerfiles/fedora-win64-cross.docker
+++ b/tests/docker/dockerfiles/fedora-win64-cross.docker
@@ -120,4 +120,4 @@ ARG UID
 RUN if [ "${USER}" ]; then \
   id ${USER} 2>/dev/null || useradd -u ${UID} -U ${USER}; fi
 
-ENV ENABLE_RUST 1
+ENV ENABLE_RUST=1
diff --git a/tests/docker/dockerfiles/fedora.docker b/tests/docker/dockerfiles/fedora.docker
index 393ac0cce73..a6996917c4b 100644
--- a/tests/docker/dockerfiles/fedora.docker
+++ b/tests/docker/dockerfiles/fedora.docker
@@ -162,4 +162,4 @@ ARG UID
 RUN if [ "${USER}" ]; then \
   id ${USER} 2>/dev/null || useradd -u ${UID} -U ${USER}; fi
 
-ENV ENABLE_RUST 1
+ENV ENABLE_RUST=1
diff --git a/tests/docker/dockerfiles/opensuse-leap.docker b/tests/docker/dockerfiles/opensuse-leap.docker
index 4b126b7e7de..fc363c647cd 100644
--- a/tests/docker/dockerfiles/opensuse-leap.docker
+++ b/tests/docker/dockerfiles/opensuse-leap.docker
@@ -149,4 +149,4 @@ ARG UID
 RUN if [ "${USER}" ]; then \
   id ${USER} 2>/dev/null || useradd -u ${UID} -U ${USER}; fi
 
-ENV ENABLE_RUST 1
+ENV ENABLE_RUST=1
diff --git a/scripts/git.orderfile b/scripts/git.orderfile
index 8edac0380ba..4b693c9deec 100644
--- a/scripts/git.orderfile
+++ b/scripts/git.orderfile
@@ -39,3 +39,7 @@ qga/*.json
 # code
 *.c
 *.c.inc
+
+# Generated Dockerfiles
+tests/lcitool/refresh
+tests/docker/dockerfiles/*
-- 
2.53.0


