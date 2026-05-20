Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC325CD5BA4
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 19:24:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPmWK-00079Q-7F; Wed, 20 May 2026 15:23:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPmWG-00078Q-G0
 for qemu-devel@nongnu.org; Wed, 20 May 2026 15:23:53 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPmWD-0001gp-VO
 for qemu-devel@nongnu.org; Wed, 20 May 2026 15:23:52 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4891e5b9c1fso46718675e9.2
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 12:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779305027; x=1779909827; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=pzFene+XPTuBXmA2I8ll8nMg8ewupOG9aMP0/WLLdZg=;
 b=ZN9fzmDTZvIBChMVhrxsJW7yRuXNkMZjRxrM1Nk4aepIjumink882uvu0+6LiCWqfa
 fK9debCxCZqpTYI/ZRuK92pcWnPujYxhcZ0Ow5/okzT9kqwdhMYfNGToZ2T0KqLx3g6g
 qnNun1S4R5ASENZijkdGv76SIQoTkPmQIbI3KzYlTE3uROZXDj0V4swORKkVUyPch8it
 uilhMsOAZg2XgjW+q/lHAw6sbPKV2vin4O67qEDMORI+rRizqtPd9uOJt/t305L1ueDr
 tFX2EZbdrT1GZ6otaKSRSH/7s5crrDLmDkJL9ob5PBDBflXuP38yngE/rZ0zHOUpLcRq
 5rYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779305027; x=1779909827;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=pzFene+XPTuBXmA2I8ll8nMg8ewupOG9aMP0/WLLdZg=;
 b=AmM9JJRRO4npXNq4chJgLTZl7Vk+oDCQ3nKzHm0YZnjFk38iRQsaGWuep16C2rncdo
 eJSZdMY4CFMeZ2Kkff34Ic8FzJtEpOyRYqhoMtizkYzLE2/30PjXIDQGGqPay0a1yyQQ
 gWMBvsMeulQ2vFPLof1S3eITmRuLEPvVzJwxLCoQj/d3/MZMpuRO9g1cu4ijUp9+Hesv
 Cf+SJtBjxI+6RuJ8gGN05NLsnXSoWhdXs9+sbQ3oT9pthj7FwqZYhTTmkiYyzt71gl4y
 pDKRSYg9K4m4gwO2fhOOmY3mnRK80vB8GeKIIMhd5gmV66moeHUj2l2IVhnKzdmeQlJg
 Ok/w==
X-Gm-Message-State: AOJu0YxgAzKwi2/gz1t5zssZih+oSU+LZ/uZIbBnqENnVwwO2hIcGni7
 t0kSsCqUL88cfhfVcswvBZ5Hqumm7288MFSSGpJt8BJD5uzRrmqs4YgM5WoVITEQd22IJZ7Me4a
 m7OWu+8E=
X-Gm-Gg: Acq92OHk3uWM09JI8+j87Imqk0ntC42c8qIrOjvGCJ6W61XAOyUy+DK2JbiOU3N7tOg
 Ys2ut0CyhB2ZsH4sLFc8ftCuIA/hWL4qwQ06sNMcKLP6oc7LHrgjdjPqT5EjGHmctmDRQDrQBT0
 yz5TCmEgg2Xspj4FgtxWFJMKb9thLh7+2vU4he25AnaPQIKaJC/38K41sOFY5dRdoBHtGeSwDts
 lMQj8gPOJLDAN8+ii/Z9h+bXIlL6/5GYRTsMLI71Rmj2rGi0BSgOJpy3wJrq5+sd6sbkfD2rtEP
 XcXv7VC9UXSzM3T0URJI1gMuiwtqcDVAWKMljZYgnIKEc8mgcBW6BA6KC/8uoDKIRFFsJagqd+7
 bRdWPPy8lhPNuNUot3EdaFMbkYrk05RDTHMV0Ha85X0jEIvd637qNuCbHj/ZnPtnDmZvxImrKwS
 Rn3L5DmMvdumlyiAi/dtEdsGSWbNisxbV6JM0jbHISQ1K+wa5v2wO+vBckZ/QAcocDdOLxo/46
X-Received: by 2002:a05:600c:5ca:b0:48f:e6de:1cb9 with SMTP id
 5b1f17b1804b1-48fe6de1dd2mr243248675e9.19.1779305027450; 
 Wed, 20 May 2026 12:23:47 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49033d2fd6bsm11667585e9.1.2026.05.20.12.23.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 20 May 2026 12:23:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 01/33] docker: Remove LegacyKeyValueFormat warnings in
 non-generated files
Date: Wed, 20 May 2026 21:23:06 +0200
Message-ID: <20260520192338.40036-2-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260520192338.40036-1-philmd@linaro.org>
References: <20260520192338.40036-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

Manually update Dockerfiles to not use legacy 'ENV key value' format:
https://docs.docker.com/reference/build-checks/legacy-key-value-format/

This removes warnings when building / using the containers:

 - LegacyKeyValueFormat: "ENV key=value" should be used instead of legacy "ENV key value" format (line 98)
 - LegacyKeyValueFormat: "ENV key=value" should be used instead of legacy "ENV key value" format (line 64)
 - LegacyKeyValueFormat: "ENV key=value" should be used instead of legacy "ENV key value" format (line 97)

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>
Message-ID: <20260518102222.80735-7-philmd@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .../docker/dockerfiles/debian-hexagon-cross.docker | 14 +++++++-------
 .../dockerfiles/debian-loongarch-cross.docker      | 10 +++++-----
 .../docker/dockerfiles/debian-tricore-cross.docker |  6 +++---
 .../docker/dockerfiles/debian-xtensa-cross.docker  |  8 ++++----
 tests/docker/dockerfiles/python.docker             |  5 +++--
 scripts/coverity-scan/coverity-scan.docker         | 12 ++++++------
 6 files changed, 28 insertions(+), 27 deletions(-)

diff --git a/tests/docker/dockerfiles/debian-hexagon-cross.docker b/tests/docker/dockerfiles/debian-hexagon-cross.docker
index 91d4b71ac95..3c94f040b81 100644
--- a/tests/docker/dockerfiles/debian-hexagon-cross.docker
+++ b/tests/docker/dockerfiles/debian-hexagon-cross.docker
@@ -39,15 +39,15 @@ RUN apt-get update && \
     ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/gcc && \
     dpkg-query --showformat '${Package}_${Version}_${Architecture}\n' --show > /packages.txt
 
-ENV TOOLCHAIN_INSTALL /opt
-ENV TOOLCHAIN_RELEASE 12.Dec.2023
-ENV TOOLCHAIN_BASENAME "clang+llvm-${TOOLCHAIN_RELEASE}-cross-hexagon-unknown-linux-musl"
-ENV TOOLCHAIN_URL https://codelinaro.jfrog.io/artifactory/codelinaro-toolchain-for-hexagon/${TOOLCHAIN_RELEASE}/${TOOLCHAIN_BASENAME}.tar.xz
-ENV CCACHE_WRAPPERSDIR "/usr/libexec/ccache-wrappers"
+ENV TOOLCHAIN_INSTALL=/opt
+ENV TOOLCHAIN_RELEASE=12.Dec.2023
+ENV TOOLCHAIN_BASENAME=clang+llvm-${TOOLCHAIN_RELEASE}-cross-hexagon-unknown-linux-musl
+ENV TOOLCHAIN_URL=https://codelinaro.jfrog.io/artifactory/codelinaro-toolchain-for-hexagon/${TOOLCHAIN_RELEASE}/${TOOLCHAIN_BASENAME}.tar.xz
+ENV CCACHE_WRAPPERSDIR=/usr/libexec/ccache-wrappers
 
 RUN curl -#SL "$TOOLCHAIN_URL" | tar -xJC "$TOOLCHAIN_INSTALL"
-ENV PATH $PATH:${TOOLCHAIN_INSTALL}/${TOOLCHAIN_BASENAME}/x86_64-linux-gnu/bin
-ENV MAKE /usr/bin/make
+ENV PATH=$PATH:${TOOLCHAIN_INSTALL}/${TOOLCHAIN_BASENAME}/x86_64-linux-gnu/bin
+ENV MAKE=/usr/bin/make
 # As a final step configure the user (if env is defined)
 ARG USER
 ARG UID
diff --git a/tests/docker/dockerfiles/debian-loongarch-cross.docker b/tests/docker/dockerfiles/debian-loongarch-cross.docker
index 55b3dbe4510..d2ba07972ce 100644
--- a/tests/docker/dockerfiles/debian-loongarch-cross.docker
+++ b/tests/docker/dockerfiles/debian-loongarch-cross.docker
@@ -40,12 +40,12 @@ RUN apt-get update && \
 RUN curl -#SL https://github.com/loongson/build-tools/releases/download/2023.08.08/CLFS-loongarch64-8.1-x86_64-cross-tools-gcc-glibc.tar.xz \
     | tar -xJC /opt
 
-ENV PATH $PATH:/opt/cross-tools/bin
-ENV LD_LIBRARY_PATH /opt/cross-tools/lib:/opt/cross-tools/loongarch64-unknown-linux-gnu/lib:$LD_LIBRARY_PATH
+ENV PATH=$PATH:/opt/cross-tools/bin
+ENV LD_LIBRARY_PATH=/opt/cross-tools/lib:/opt/cross-tools/loongarch64-unknown-linux-gnu/lib:$LD_LIBRARY_PATH
 
-ENV QEMU_CONFIGURE_OPTS --disable-docs --disable-tools
-ENV DEF_TARGET_LIST loongarch64-linux-user,loongarch64-softmmu
-ENV MAKE /usr/bin/make
+ENV QEMU_CONFIGURE_OPTS="--disable-docs --disable-tools"
+ENV DEF_TARGET_LIST=loongarch64-linux-user,loongarch64-softmmu
+ENV MAKE=/usr/bin/make
 
 # As a final step configure the user (if env is defined)
 ARG USER
diff --git a/tests/docker/dockerfiles/debian-tricore-cross.docker b/tests/docker/dockerfiles/debian-tricore-cross.docker
index fd797dc7ee4..9e7ff321677 100644
--- a/tests/docker/dockerfiles/debian-tricore-cross.docker
+++ b/tests/docker/dockerfiles/debian-tricore-cross.docker
@@ -40,9 +40,9 @@ RUN curl -#SL https://github.com/bkoppelmann/package_940/releases/download/trico
     | tar -xzC /usr/local/
 
 # This image can only build a very minimal QEMU as well as the tests
-ENV DEF_TARGET_LIST tricore-softmmu
-ENV QEMU_CONFIGURE_OPTS --disable-user --disable-tools --disable-fdt
-ENV MAKE /usr/bin/make
+ENV DEF_TARGET_LIST=tricore-softmmu
+ENV QEMU_CONFIGURE_OPTS="--disable-user --disable-tools --disable-fdt"
+ENV MAKE=/usr/bin/make
 # As a final step configure the user (if env is defined)
 ARG USER
 ARG UID
diff --git a/tests/docker/dockerfiles/debian-xtensa-cross.docker b/tests/docker/dockerfiles/debian-xtensa-cross.docker
index ef63e44e2ef..d9130fc3378 100644
--- a/tests/docker/dockerfiles/debian-xtensa-cross.docker
+++ b/tests/docker/dockerfiles/debian-xtensa-cross.docker
@@ -19,16 +19,16 @@ RUN apt-get update && \
         python3-minimal && \
     dpkg-query --showformat '${Package}_${Version}_${Architecture}\n' --show > /packages.txt
 
-ENV CPU_LIST dc232b dc233c de233_fpu dsp3400
-ENV TOOLCHAIN_RELEASE 2020.07
+ENV CPU_LIST="dc232b dc233c de233_fpu dsp3400"
+ENV TOOLCHAIN_RELEASE=2020.07
 
 RUN for cpu in $CPU_LIST; do \
         curl -#SL http://github.com/foss-xtensa/toolchain/releases/download/$TOOLCHAIN_RELEASE/x86_64-$TOOLCHAIN_RELEASE-xtensa-$cpu-elf.tar.gz \
         | tar -xzC /opt; \
     done
 
-ENV PATH $PATH:/opt/$TOOLCHAIN_RELEASE/xtensa-dc232b-elf/bin:/opt/$TOOLCHAIN_RELEASE/xtensa-dc233c-elf/bin:/opt/$TOOLCHAIN_RELEASE/xtensa-de233_fpu-elf/bin:/opt/$TOOLCHAIN_RELEASE/xtensa-dsp3400-elf/bin
-ENV MAKE /usr/bin/make
+ENV PATH=$PATH:/opt/$TOOLCHAIN_RELEASE/xtensa-dc232b-elf/bin:/opt/$TOOLCHAIN_RELEASE/xtensa-dc233c-elf/bin:/opt/$TOOLCHAIN_RELEASE/xtensa-de233_fpu-elf/bin:/opt/$TOOLCHAIN_RELEASE/xtensa-dsp3400-elf/bin
+ENV MAKE=/usr/bin/make
 # As a final step configure the user (if env is defined)
 ARG USER
 ARG UID
diff --git a/tests/docker/dockerfiles/python.docker b/tests/docker/dockerfiles/python.docker
index 59e70a02484..79c554a2d87 100644
--- a/tests/docker/dockerfiles/python.docker
+++ b/tests/docker/dockerfiles/python.docker
@@ -4,7 +4,7 @@ FROM fedora:latest
 MAINTAINER John Snow <jsnow@redhat.com>
 
 # Please keep this list sorted alphabetically
-ENV PACKAGES \
+ENV PACKAGES="\
     gcc \
     make \
     python3 \
@@ -15,7 +15,8 @@ ENV PACKAGES \
     python3.11 \
     python3.12 \
     python3.13 \
-    python3.9
+    python3.9 \
+    "
 
 RUN dnf install -y $PACKAGES
 RUN rpm -q $PACKAGES | sort > /packages.txt
diff --git a/scripts/coverity-scan/coverity-scan.docker b/scripts/coverity-scan/coverity-scan.docker
index 93e558c8623..30d154c0d86 100644
--- a/scripts/coverity-scan/coverity-scan.docker
+++ b/scripts/coverity-scan/coverity-scan.docker
@@ -152,12 +152,12 @@ exec "$@"' > /usr/bin/nosync && \
     ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/g++ && \
     ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/gcc
 
-ENV CCACHE_WRAPPERSDIR "/usr/libexec/ccache-wrappers"
-ENV LANG "en_US.UTF-8"
-ENV MAKE "/usr/bin/make"
-ENV NINJA "/usr/bin/ninja"
-ENV PYTHON "/usr/bin/python3"
-ENV QEMU_CONFIGURE_OPTS --meson=internal
+ENV CCACHE_WRAPPERSDIR=/usr/libexec/ccache-wrappers
+ENV LANG=en_US.UTF-8
+ENV MAKE=/usr/bin/make
+ENV NINJA=/usr/bin/ninja
+ENV PYTHON=/usr/bin/python3
+ENV QEMU_CONFIGURE_OPTS=--meson=internal
 
 RUN dnf install -y curl wget
 ENV COVERITY_TOOL_BASE=/coverity-tools
-- 
2.53.0


