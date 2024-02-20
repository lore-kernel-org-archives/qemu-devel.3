Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88C16C48BC3
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 17:44:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcUAF-0003Bb-Vy; Tue, 20 Feb 2024 12:44:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rcUAE-0003Ae-N7
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 12:44:18 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rcUAC-0005JC-OI
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 12:44:18 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-33d568fbf62so1228421f8f.3
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 09:44:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708451055; x=1709055855; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nlwRkJ1nvi2u/ezbMvI34tkdFRINCnwrmEyU/SijG5w=;
 b=ukXIFeDWByhnZqM9UWleOQQKYWshEIpmSDUX6WSgb6cM94e6KjQQqaW3BNrk1YvbaK
 A8eUQrHuECPDAzGmty9jq55u80Rwkaipm77TlwbQyMl185YWKqo7Hi9+Bqw044wRhrr6
 dNhOUSxcHabgFIMnCojTCoBOY6fAWT366V+O1Ub5ZxH3T1soOW3rb+sGLw5kQ2mb/skv
 EyPw/5iBKA7jCquaFi/ZjwghGg3wt1b/8uRFtMPEpcYucc5/qc51EYde6WkD/E2/unqj
 P/1zQWVS+7X0Xx1yh7JUGl8w5Ts2Wfp73c/bhSK60qx4+CO1/jwgHrHxc3YvJrpx/fOa
 JBmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708451055; x=1709055855;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nlwRkJ1nvi2u/ezbMvI34tkdFRINCnwrmEyU/SijG5w=;
 b=s58NGkBKxRvY35N9cFhFzVln0f3zO7fFiEFyDGU54ygGcF+6HlxMUxpaHuZ1oIr8mF
 GVk8jWZCNaf2CL+zbhOcdcpZc+ougTXCK28v9eeABBGjz3u+chTzQ3fwNKnaHspPJsXV
 eapgmSb3JWDO9sAhuQJwVYQsD9H0VkBcu52Es+X5vbEQkmF9OZ3M3/laBwQ+z1oDqXFe
 fzflJr6zYpj1qy60aBRpi3bL7dXErMnV9oMQhzJ8b89AK3ic0UC0V+pLKofnOe48DEt0
 ChqHwx+ZgGqDSF3RueooBrmX3YOGgXGgh0yDymVC8OpN/H5r3QGbY8Hwubz0BueeShvW
 wisg==
X-Gm-Message-State: AOJu0YzV8XMJ96ntB+FRquXIQ5afNBx5wuDjc70KUZtXE+TUw+pIK8Nx
 i7hfmZSBLXRFO1kHIuQuJIbkhYqXtge0B9nQuKgPRdYTcdj5/FPvSYDRCS+XMB71tJtcotBjlqX
 i
X-Google-Smtp-Source: AGHT+IGXgLVOlBYqBSxwrrKrpr+9Ate+3mDzhvMki8Xsu4qyT52rPSQUfyBLe6ojGTNbuMBYwCak1w==
X-Received: by 2002:a05:6000:400c:b0:33d:4adf:2949 with SMTP id
 cp12-20020a056000400c00b0033d4adf2949mr5717180wrb.11.1708451055022; 
 Tue, 20 Feb 2024 09:44:15 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 k5-20020adfe3c5000000b0033b66c2d61esm13988443wrm.48.2024.02.20.09.44.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Feb 2024 09:44:14 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Yonggang Luo <luoyonggang@gmail.com>
Subject: [PATCH 2/3] .gitlab-ci.d: Drop cross-win32-system job
Date: Tue, 20 Feb 2024 17:44:11 +0000
Message-Id: <20240220174412.155885-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240220174412.155885-1-peter.maydell@linaro.org>
References: <20240220174412.155885-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

We don't support 32-bit Windows any more, so we don't need to defend it
with this CI job.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 .gitlab-ci.d/container-cross.yml              |   5 -
 .gitlab-ci.d/crossbuilds.yml                  |  14 ---
 .../dockerfiles/fedora-win32-cross.docker     | 111 ------------------
 tests/lcitool/refresh                         |   5 -
 4 files changed, 135 deletions(-)
 delete mode 100644 tests/docker/dockerfiles/fedora-win32-cross.docker

diff --git a/.gitlab-ci.d/container-cross.yml b/.gitlab-ci.d/container-cross.yml
index 8d235cbea01..e3103940a0e 100644
--- a/.gitlab-ci.d/container-cross.yml
+++ b/.gitlab-ci.d/container-cross.yml
@@ -101,11 +101,6 @@ cris-fedora-cross-container:
   variables:
     NAME: fedora-cris-cross
 
-win32-fedora-cross-container:
-  extends: .container_job_template
-  variables:
-    NAME: fedora-win32-cross
-
 win64-fedora-cross-container:
   extends: .container_job_template
   variables:
diff --git a/.gitlab-ci.d/crossbuilds.yml b/.gitlab-ci.d/crossbuilds.yml
index d19d98cde05..987ba9694ba 100644
--- a/.gitlab-ci.d/crossbuilds.yml
+++ b/.gitlab-ci.d/crossbuilds.yml
@@ -159,20 +159,6 @@ cross-mips64el-kvm-only:
     IMAGE: debian-mips64el-cross
     EXTRA_CONFIGURE_OPTS: --disable-tcg --target-list=mips64el-softmmu
 
-cross-win32-system:
-  extends: .cross_system_build_job
-  needs:
-    job: win32-fedora-cross-container
-  variables:
-    IMAGE: fedora-win32-cross
-    EXTRA_CONFIGURE_OPTS: --enable-fdt=internal
-    CROSS_SKIP_TARGETS: alpha-softmmu avr-softmmu hppa-softmmu m68k-softmmu
-                        microblazeel-softmmu mips64el-softmmu nios2-softmmu
-  artifacts:
-    when: on_success
-    paths:
-      - build/qemu-setup*.exe
-
 cross-win64-system:
   extends: .cross_system_build_job
   needs:
diff --git a/tests/docker/dockerfiles/fedora-win32-cross.docker b/tests/docker/dockerfiles/fedora-win32-cross.docker
deleted file mode 100644
index 08799219f98..00000000000
--- a/tests/docker/dockerfiles/fedora-win32-cross.docker
+++ /dev/null
@@ -1,111 +0,0 @@
-# THIS FILE WAS AUTO-GENERATED
-#
-#  $ lcitool dockerfile --layers all --cross-arch mingw32 fedora-38 qemu
-#
-# https://gitlab.com/libvirt/libvirt-ci
-
-FROM registry.fedoraproject.org/fedora:38
-
-RUN dnf install -y nosync && \
-    printf '#!/bin/sh\n\
-if test -d /usr/lib64\n\
-then\n\
-    export LD_PRELOAD=/usr/lib64/nosync/nosync.so\n\
-else\n\
-    export LD_PRELOAD=/usr/lib/nosync/nosync.so\n\
-fi\n\
-exec "$@"\n' > /usr/bin/nosync && \
-    chmod +x /usr/bin/nosync && \
-    nosync dnf update -y && \
-    nosync dnf install -y \
-               bash \
-               bc \
-               bison \
-               bzip2 \
-               ca-certificates \
-               ccache \
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
-               meson \
-               mtools \
-               ninja-build \
-               nmap-ncat \
-               openssh-clients \
-               pcre-static \
-               python3 \
-               python3-PyYAML \
-               python3-numpy \
-               python3-opencv \
-               python3-pillow \
-               python3-pip \
-               python3-sphinx \
-               python3-sphinx_rtd_theme \
-               sed \
-               socat \
-               sparse \
-               spice-protocol \
-               swtpm \
-               tar \
-               tesseract \
-               tesseract-langpack-eng \
-               util-linux \
-               which \
-               xorriso \
-               zstd && \
-    nosync dnf autoremove -y && \
-    nosync dnf clean all -y
-
-ENV CCACHE_WRAPPERSDIR "/usr/libexec/ccache-wrappers"
-ENV LANG "en_US.UTF-8"
-ENV MAKE "/usr/bin/make"
-ENV NINJA "/usr/bin/ninja"
-ENV PYTHON "/usr/bin/python3"
-
-RUN nosync dnf install -y \
-               mingw32-SDL2 \
-               mingw32-SDL2_image \
-               mingw32-bzip2 \
-               mingw32-curl \
-               mingw32-gcc \
-               mingw32-gcc-c++ \
-               mingw32-gettext \
-               mingw32-glib2 \
-               mingw32-gnutls \
-               mingw32-gtk3 \
-               mingw32-libepoxy \
-               mingw32-libgcrypt \
-               mingw32-libjpeg-turbo \
-               mingw32-libpng \
-               mingw32-libtasn1 \
-               mingw32-nettle \
-               mingw32-nsis \
-               mingw32-pixman \
-               mingw32-pkg-config && \
-    nosync dnf clean all -y && \
-    rpm -qa | sort > /packages.txt && \
-    mkdir -p /usr/libexec/ccache-wrappers && \
-    ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/i686-w64-mingw32-c++ && \
-    ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/i686-w64-mingw32-cc && \
-    ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/i686-w64-mingw32-g++ && \
-    ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/i686-w64-mingw32-gcc
-
-ENV ABI "i686-w64-mingw32"
-ENV MESON_OPTS "--cross-file=/usr/share/mingw/toolchain-mingw32.meson"
-ENV QEMU_CONFIGURE_OPTS --cross-prefix=i686-w64-mingw32-
-ENV DEF_TARGET_LIST i386-softmmu
-# As a final step configure the user (if env is defined)
-ARG USER
-ARG UID
-RUN if [ "${USER}" ]; then \
-  id ${USER} 2>/dev/null || useradd -u ${UID} -U ${USER}; fi
diff --git a/tests/lcitool/refresh b/tests/lcitool/refresh
index 0c93557ad67..fe7692c5006 100755
--- a/tests/lcitool/refresh
+++ b/tests/lcitool/refresh
@@ -192,11 +192,6 @@ try:
                         trailer=cross_build("s390x-linux-gnu-",
                                             "s390x-softmmu,s390x-linux-user"))
 
-    generate_dockerfile("fedora-win32-cross", "fedora-38",
-                        cross="mingw32",
-                        trailer=cross_build("i686-w64-mingw32-",
-                                            "i386-softmmu"))
-
     generate_dockerfile("fedora-win64-cross", "fedora-38",
                         cross="mingw64",
                         trailer=cross_build("x86_64-w64-mingw32-",
-- 
2.34.1


