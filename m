Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75619CEBF61
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 11:57:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vKxpc-0008NK-Ek; Mon, 17 Nov 2025 06:55:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vKxpX-0008HT-HK
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 06:55:35 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vKxpR-0005gN-TH
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 06:55:35 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4779ce2a624so14296605e9.2
 for <qemu-devel@nongnu.org>; Mon, 17 Nov 2025 03:55:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763380528; x=1763985328; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wFC7U4Nj6Xzl5YWyYhyhFTCSqHPDHzpPCYYcg4ysIOI=;
 b=xaiQqSO6u3ZGRwRxbCUs9AWtSU3UXXd4C1yZjl/MFCoH2/wnD6tqNqtdXd9NQDEDxK
 8VHEECaKZ14l8VTjNNDaUWobAuayDAejpj1IaNy4RfzJodL9hgN/HjzP2+Oo8Hb7WN3H
 JPygNTet3A6FfGWD7g+0dns63fD4Y6rqs/8WeZ8beuIaen2o/Vb56ZH6AvBpmLHI5Rs5
 MXtrZVx26Q7pY3CRgAoL4TVhUOa7stm4Homx1iAijUB+94WTmKQW2leDtbjXEA9nGaAj
 JnE5cvcImNvLFv8ud6kfSTc13F8caSWMxgrC/qrbnE6ya9oil43PnBSlXyzxzCp00Pi0
 4ryQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763380528; x=1763985328;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wFC7U4Nj6Xzl5YWyYhyhFTCSqHPDHzpPCYYcg4ysIOI=;
 b=eMphBefbSH4IABKhTdSGjU6YFAIvjIl6KaVIDDxd9HW32vD4KVYZDKdPF4u+18ma90
 YGoMzQg83GWQmoaU3RL6h/HZEP0KwRMqVCTLyR9XPlGJvAlTWy1CHkqKk62lPirdTHYP
 ZBXaT65fHNHInJTHa8pKRfle+deEyuIu87UveyVxXUntTIGRjSHXoVQ3hMq4SZDLRH50
 OjCEZinGc3URv4ih181O8EEyvYT9TTmKsJ7cemqAvAm+Dffm0IpJ/E0gkQI4scFfQVVR
 kjf6IzXNRPixC2AbDEokbXnJHlmQAq4LzkehbY9wvIHUdmFzGGpcAot4Ws08SA4cvXbb
 XsFw==
X-Gm-Message-State: AOJu0Yz5nUoYFcrEjWijkw3E68IaMVdGJopc6DdQo0hhk4SKeR6dtMOA
 HTWyTqzyLqjfvKokcnFEPkIqy8B648Q0WzIqFxpRloT3G7Wr6YVLsh2Isacqb7I56FU=
X-Gm-Gg: ASbGnctSNAXYp5fP4TzZOgt4e/FLAF/SlRdFPFOTXAbAG1SgDAZWRhW/MDIaAamdBpi
 FozqwzdhEO4wW25wSeO38tt5/QOh3/SKDFbGLT6c2Hvp+D6aCmjdBra6cdXtmh2IdxtTCVq0jpP
 rSBZr1Y2rJFMcsk8oaNUobumYC08S4s0GYbfPKJNkUu4t1ic6cfXoXlpQ/LAEB20BQRCQxJz/yI
 mSOP98OmpEngRpfAQ/NaYptLd/ZFZ9DtfNE+wFbt4RKPPbhtjy2t6GbwV4AXpH9i9b09NEGXw9f
 Fn2bIYU0YcuTV6UmIoEDgyWBDOuw5tDMC9Z0nBdE2S8C0ueYizt3G5vhYVuX3U95/0oQQbVh5Vi
 gEuqa8egncKNqQKWKo+U9aRXkl7t2EP6+69WQk1+HoBFV/f91+fKrYiCR2/HUeWCJH5WGRZgVSH
 6gG9ciwYKpiic=
X-Google-Smtp-Source: AGHT+IHMxZ0OjAcRkNISHn7F+1nvh7nHBghJflRm4hixKLwXSTQQX0VJHfbcaXaM9dz8uK3wVaeq/A==
X-Received: by 2002:a05:600c:c177:b0:477:7975:30ea with SMTP id
 5b1f17b1804b1-4778fea1336mr124369185e9.29.1763380528234; 
 Mon, 17 Nov 2025 03:55:28 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42c961f6e64sm12613832f8f.27.2025.11.17.03.55.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Nov 2025 03:55:25 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 564595F8B9;
 Mon, 17 Nov 2025 11:55:24 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ed Maste <emaste@freebsd.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Thomas Huth <thuth@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Kohei Tokunaga <ktokunaga.mail@gmail.com>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, qemu-arm@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>, qemu-s390x@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v3 02/18] libvirt-ci: bump libvirt-ci to latest version
Date: Mon, 17 Nov 2025 11:55:07 +0000
Message-ID: <20251117115523.3993105-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251117115523.3993105-1-alex.bennee@linaro.org>
References: <20251117115523.3993105-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32a.google.com
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

We will need the latest version to add coreutils in the next commit.
As libvirt has updated the handling of ENV variables this brings a
little bit of churn to the docker images.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20251113102525.1255370-3-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/docker/dockerfiles/alpine.docker        | 10 +++++-----
 tests/docker/dockerfiles/centos9.docker       | 10 +++++-----
 .../dockerfiles/debian-amd64-cross.docker     | 16 ++++++++--------
 .../dockerfiles/debian-arm64-cross.docker     | 16 ++++++++--------
 .../dockerfiles/debian-armhf-cross.docker     | 16 ++++++++--------
 .../dockerfiles/debian-i686-cross.docker      | 16 ++++++++--------
 .../dockerfiles/debian-mips64el-cross.docker  | 16 ++++++++--------
 .../dockerfiles/debian-mipsel-cross.docker    | 16 ++++++++--------
 .../dockerfiles/debian-ppc64el-cross.docker   | 16 ++++++++--------
 .../dockerfiles/debian-riscv64-cross.docker   | 19 ++++++++-----------
 .../dockerfiles/debian-s390x-cross.docker     | 16 ++++++++--------
 tests/docker/dockerfiles/debian.docker        | 10 +++++-----
 .../dockerfiles/fedora-rust-nightly.docker    | 10 +++++-----
 .../dockerfiles/fedora-win64-cross.docker     | 14 +++++++-------
 tests/docker/dockerfiles/fedora.docker        | 10 +++++-----
 tests/docker/dockerfiles/opensuse-leap.docker | 10 +++++-----
 tests/docker/dockerfiles/ubuntu2204.docker    | 10 +++++-----
 tests/lcitool/libvirt-ci                      |  2 +-
 18 files changed, 115 insertions(+), 118 deletions(-)

diff --git a/tests/docker/dockerfiles/alpine.docker b/tests/docker/dockerfiles/alpine.docker
index 52adf9ccbb7..1da375c9158 100644
--- a/tests/docker/dockerfiles/alpine.docker
+++ b/tests/docker/dockerfiles/alpine.docker
@@ -126,11 +126,11 @@ RUN apk update && \
     ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/clang && \
     ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/gcc
 
-ENV CCACHE_WRAPPERSDIR "/usr/libexec/ccache-wrappers"
-ENV LANG "en_US.UTF-8"
-ENV MAKE "/usr/bin/make"
-ENV NINJA "/usr/bin/ninja"
-ENV PYTHON "/usr/bin/python3"
+ENV CCACHE_WRAPPERSDIR="/usr/libexec/ccache-wrappers"
+ENV LANG="en_US.UTF-8"
+ENV MAKE="/usr/bin/make"
+ENV NINJA="/usr/bin/ninja"
+ENV PYTHON="/usr/bin/python3"
 # https://gitlab.alpinelinux.org/alpine/aports/-/issues/17463
 RUN apk add clang19-libclang
 # As a final step configure the user (if env is defined)
diff --git a/tests/docker/dockerfiles/centos9.docker b/tests/docker/dockerfiles/centos9.docker
index 0674d778262..ff3e8069b45 100644
--- a/tests/docker/dockerfiles/centos9.docker
+++ b/tests/docker/dockerfiles/centos9.docker
@@ -132,11 +132,11 @@ RUN dnf distro-sync -y && \
     ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/clang && \
     ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/gcc
 
-ENV CCACHE_WRAPPERSDIR "/usr/libexec/ccache-wrappers"
-ENV LANG "en_US.UTF-8"
-ENV MAKE "/usr/bin/make"
-ENV NINJA "/usr/bin/ninja"
-ENV PYTHON "/usr/bin/python3"
+ENV CCACHE_WRAPPERSDIR="/usr/libexec/ccache-wrappers"
+ENV LANG="en_US.UTF-8"
+ENV MAKE="/usr/bin/make"
+ENV NINJA="/usr/bin/ninja"
+ENV PYTHON="/usr/bin/python3"
 # As a final step configure the user (if env is defined)
 ARG USER
 ARG UID
diff --git a/tests/docker/dockerfiles/debian-amd64-cross.docker b/tests/docker/dockerfiles/debian-amd64-cross.docker
index 7f4674400df..26a39940126 100644
--- a/tests/docker/dockerfiles/debian-amd64-cross.docker
+++ b/tests/docker/dockerfiles/debian-amd64-cross.docker
@@ -72,11 +72,11 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
 
 RUN /usr/bin/pip3 install meson==1.8.1
 
-ENV CCACHE_WRAPPERSDIR "/usr/libexec/ccache-wrappers"
-ENV LANG "en_US.UTF-8"
-ENV MAKE "/usr/bin/make"
-ENV NINJA "/usr/bin/ninja"
-ENV PYTHON "/usr/bin/python3"
+ENV CCACHE_WRAPPERSDIR="/usr/libexec/ccache-wrappers"
+ENV LANG="en_US.UTF-8"
+ENV MAKE="/usr/bin/make"
+ENV NINJA="/usr/bin/ninja"
+ENV PYTHON="/usr/bin/python3"
 
 RUN export DEBIAN_FRONTEND=noninteractive && \
     dpkg --add-architecture amd64 && \
@@ -178,9 +178,9 @@ endian = 'little'\n" > /usr/local/share/meson/cross/x86_64-linux-gnu && \
     ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/x86_64-linux-gnu-cc && \
     ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/x86_64-linux-gnu-gcc
 
-ENV ABI "x86_64-linux-gnu"
-ENV MESON_OPTS "--cross-file=x86_64-linux-gnu"
-ENV RUST_TARGET "x86_64-unknown-linux-gnu"
+ENV ABI="x86_64-linux-gnu"
+ENV MESON_OPTS="--cross-file=x86_64-linux-gnu"
+ENV RUST_TARGET="x86_64-unknown-linux-gnu"
 ENV QEMU_CONFIGURE_OPTS --cross-prefix=x86_64-linux-gnu-
 ENV DEF_TARGET_LIST x86_64-softmmu,x86_64-linux-user,i386-softmmu,i386-linux-user
 # As a final step configure the user (if env is defined)
diff --git a/tests/docker/dockerfiles/debian-arm64-cross.docker b/tests/docker/dockerfiles/debian-arm64-cross.docker
index c7cd54ee5ca..4b0163fa1b9 100644
--- a/tests/docker/dockerfiles/debian-arm64-cross.docker
+++ b/tests/docker/dockerfiles/debian-arm64-cross.docker
@@ -72,11 +72,11 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
 
 RUN /usr/bin/pip3 install meson==1.8.1
 
-ENV CCACHE_WRAPPERSDIR "/usr/libexec/ccache-wrappers"
-ENV LANG "en_US.UTF-8"
-ENV MAKE "/usr/bin/make"
-ENV NINJA "/usr/bin/ninja"
-ENV PYTHON "/usr/bin/python3"
+ENV CCACHE_WRAPPERSDIR="/usr/libexec/ccache-wrappers"
+ENV LANG="en_US.UTF-8"
+ENV MAKE="/usr/bin/make"
+ENV NINJA="/usr/bin/ninja"
+ENV PYTHON="/usr/bin/python3"
 
 RUN export DEBIAN_FRONTEND=noninteractive && \
     dpkg --add-architecture arm64 && \
@@ -177,9 +177,9 @@ endian = 'little'\n" > /usr/local/share/meson/cross/aarch64-linux-gnu && \
     ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/aarch64-linux-gnu-cc && \
     ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/aarch64-linux-gnu-gcc
 
-ENV ABI "aarch64-linux-gnu"
-ENV MESON_OPTS "--cross-file=aarch64-linux-gnu"
-ENV RUST_TARGET "aarch64-unknown-linux-gnu"
+ENV ABI="aarch64-linux-gnu"
+ENV MESON_OPTS="--cross-file=aarch64-linux-gnu"
+ENV RUST_TARGET="aarch64-unknown-linux-gnu"
 ENV QEMU_CONFIGURE_OPTS --cross-prefix=aarch64-linux-gnu-
 ENV DEF_TARGET_LIST aarch64-softmmu,aarch64-linux-user
 # As a final step configure the user (if env is defined)
diff --git a/tests/docker/dockerfiles/debian-armhf-cross.docker b/tests/docker/dockerfiles/debian-armhf-cross.docker
index 627d41c6dee..742031ce0a2 100644
--- a/tests/docker/dockerfiles/debian-armhf-cross.docker
+++ b/tests/docker/dockerfiles/debian-armhf-cross.docker
@@ -72,11 +72,11 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
 
 RUN /usr/bin/pip3 install meson==1.8.1
 
-ENV CCACHE_WRAPPERSDIR "/usr/libexec/ccache-wrappers"
-ENV LANG "en_US.UTF-8"
-ENV MAKE "/usr/bin/make"
-ENV NINJA "/usr/bin/ninja"
-ENV PYTHON "/usr/bin/python3"
+ENV CCACHE_WRAPPERSDIR="/usr/libexec/ccache-wrappers"
+ENV LANG="en_US.UTF-8"
+ENV MAKE="/usr/bin/make"
+ENV NINJA="/usr/bin/ninja"
+ENV PYTHON="/usr/bin/python3"
 
 RUN export DEBIAN_FRONTEND=noninteractive && \
     dpkg --add-architecture armhf && \
@@ -174,9 +174,9 @@ endian = 'little'\n" > /usr/local/share/meson/cross/arm-linux-gnueabihf && \
     ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/arm-linux-gnueabihf-cc && \
     ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/arm-linux-gnueabihf-gcc
 
-ENV ABI "arm-linux-gnueabihf"
-ENV MESON_OPTS "--cross-file=arm-linux-gnueabihf"
-ENV RUST_TARGET "armv7-unknown-linux-gnueabihf"
+ENV ABI="arm-linux-gnueabihf"
+ENV MESON_OPTS="--cross-file=arm-linux-gnueabihf"
+ENV RUST_TARGET="armv7-unknown-linux-gnueabihf"
 ENV QEMU_CONFIGURE_OPTS --cross-prefix=arm-linux-gnueabihf-
 ENV DEF_TARGET_LIST arm-softmmu,arm-linux-user
 # As a final step configure the user (if env is defined)
diff --git a/tests/docker/dockerfiles/debian-i686-cross.docker b/tests/docker/dockerfiles/debian-i686-cross.docker
index 2998764065f..1ccfde2e4bb 100644
--- a/tests/docker/dockerfiles/debian-i686-cross.docker
+++ b/tests/docker/dockerfiles/debian-i686-cross.docker
@@ -72,11 +72,11 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
 
 RUN /usr/bin/pip3 install meson==1.8.1
 
-ENV CCACHE_WRAPPERSDIR "/usr/libexec/ccache-wrappers"
-ENV LANG "en_US.UTF-8"
-ENV MAKE "/usr/bin/make"
-ENV NINJA "/usr/bin/ninja"
-ENV PYTHON "/usr/bin/python3"
+ENV CCACHE_WRAPPERSDIR="/usr/libexec/ccache-wrappers"
+ENV LANG="en_US.UTF-8"
+ENV MAKE="/usr/bin/make"
+ENV NINJA="/usr/bin/ninja"
+ENV PYTHON="/usr/bin/python3"
 
 RUN export DEBIAN_FRONTEND=noninteractive && \
     dpkg --add-architecture i386 && \
@@ -174,9 +174,9 @@ endian = 'little'\n" > /usr/local/share/meson/cross/i686-linux-gnu && \
     ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/i686-linux-gnu-cc && \
     ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/i686-linux-gnu-gcc
 
-ENV ABI "i686-linux-gnu"
-ENV MESON_OPTS "--cross-file=i686-linux-gnu"
-ENV RUST_TARGET "i686-unknown-linux-gnu"
+ENV ABI="i686-linux-gnu"
+ENV MESON_OPTS="--cross-file=i686-linux-gnu"
+ENV RUST_TARGET="i686-unknown-linux-gnu"
 ENV QEMU_CONFIGURE_OPTS --cross-prefix=i686-linux-gnu-
 ENV DEF_TARGET_LIST i386-softmmu,i386-linux-user
 # As a final step configure the user (if env is defined)
diff --git a/tests/docker/dockerfiles/debian-mips64el-cross.docker b/tests/docker/dockerfiles/debian-mips64el-cross.docker
index 6e88777f76d..eeb77212d5d 100644
--- a/tests/docker/dockerfiles/debian-mips64el-cross.docker
+++ b/tests/docker/dockerfiles/debian-mips64el-cross.docker
@@ -71,11 +71,11 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
 
 RUN /usr/bin/pip3 install meson==1.8.1
 
-ENV CCACHE_WRAPPERSDIR "/usr/libexec/ccache-wrappers"
-ENV LANG "en_US.UTF-8"
-ENV MAKE "/usr/bin/make"
-ENV NINJA "/usr/bin/ninja"
-ENV PYTHON "/usr/bin/python3"
+ENV CCACHE_WRAPPERSDIR="/usr/libexec/ccache-wrappers"
+ENV LANG="en_US.UTF-8"
+ENV MAKE="/usr/bin/make"
+ENV NINJA="/usr/bin/ninja"
+ENV PYTHON="/usr/bin/python3"
 
 RUN export DEBIAN_FRONTEND=noninteractive && \
     dpkg --add-architecture mips64el && \
@@ -173,9 +173,9 @@ endian = 'little'\n" > /usr/local/share/meson/cross/mips64el-linux-gnuabi64 && \
     ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/mips64el-linux-gnuabi64-cc && \
     ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/mips64el-linux-gnuabi64-gcc
 
-ENV ABI "mips64el-linux-gnuabi64"
-ENV MESON_OPTS "--cross-file=mips64el-linux-gnuabi64"
-ENV RUST_TARGET "mips64el-unknown-linux-gnuabi64"
+ENV ABI="mips64el-linux-gnuabi64"
+ENV MESON_OPTS="--cross-file=mips64el-linux-gnuabi64"
+ENV RUST_TARGET="mips64el-unknown-linux-gnuabi64"
 ENV QEMU_CONFIGURE_OPTS --cross-prefix=mips64el-linux-gnuabi64-
 ENV DEF_TARGET_LIST mips64el-softmmu,mips64el-linux-user
 # As a final step configure the user (if env is defined)
diff --git a/tests/docker/dockerfiles/debian-mipsel-cross.docker b/tests/docker/dockerfiles/debian-mipsel-cross.docker
index 5f4e3fa9636..9b3dca44f15 100644
--- a/tests/docker/dockerfiles/debian-mipsel-cross.docker
+++ b/tests/docker/dockerfiles/debian-mipsel-cross.docker
@@ -71,11 +71,11 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
 
 RUN /usr/bin/pip3 install meson==1.8.1
 
-ENV CCACHE_WRAPPERSDIR "/usr/libexec/ccache-wrappers"
-ENV LANG "en_US.UTF-8"
-ENV MAKE "/usr/bin/make"
-ENV NINJA "/usr/bin/ninja"
-ENV PYTHON "/usr/bin/python3"
+ENV CCACHE_WRAPPERSDIR="/usr/libexec/ccache-wrappers"
+ENV LANG="en_US.UTF-8"
+ENV MAKE="/usr/bin/make"
+ENV NINJA="/usr/bin/ninja"
+ENV PYTHON="/usr/bin/python3"
 
 RUN export DEBIAN_FRONTEND=noninteractive && \
     dpkg --add-architecture mipsel && \
@@ -173,9 +173,9 @@ endian = 'little'\n" > /usr/local/share/meson/cross/mipsel-linux-gnu && \
     ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/mipsel-linux-gnu-cc && \
     ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/mipsel-linux-gnu-gcc
 
-ENV ABI "mipsel-linux-gnu"
-ENV MESON_OPTS "--cross-file=mipsel-linux-gnu"
-ENV RUST_TARGET "mipsel-unknown-linux-gnu"
+ENV ABI="mipsel-linux-gnu"
+ENV MESON_OPTS="--cross-file=mipsel-linux-gnu"
+ENV RUST_TARGET="mipsel-unknown-linux-gnu"
 ENV QEMU_CONFIGURE_OPTS --cross-prefix=mipsel-linux-gnu-
 ENV DEF_TARGET_LIST mipsel-softmmu,mipsel-linux-user
 # As a final step configure the user (if env is defined)
diff --git a/tests/docker/dockerfiles/debian-ppc64el-cross.docker b/tests/docker/dockerfiles/debian-ppc64el-cross.docker
index dfa690616d1..15c6b436d31 100644
--- a/tests/docker/dockerfiles/debian-ppc64el-cross.docker
+++ b/tests/docker/dockerfiles/debian-ppc64el-cross.docker
@@ -72,11 +72,11 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
 
 RUN /usr/bin/pip3 install meson==1.8.1
 
-ENV CCACHE_WRAPPERSDIR "/usr/libexec/ccache-wrappers"
-ENV LANG "en_US.UTF-8"
-ENV MAKE "/usr/bin/make"
-ENV NINJA "/usr/bin/ninja"
-ENV PYTHON "/usr/bin/python3"
+ENV CCACHE_WRAPPERSDIR="/usr/libexec/ccache-wrappers"
+ENV LANG="en_US.UTF-8"
+ENV MAKE="/usr/bin/make"
+ENV NINJA="/usr/bin/ninja"
+ENV PYTHON="/usr/bin/python3"
 
 RUN export DEBIAN_FRONTEND=noninteractive && \
     dpkg --add-architecture ppc64el && \
@@ -176,9 +176,9 @@ endian = 'little'\n" > /usr/local/share/meson/cross/powerpc64le-linux-gnu && \
     ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/powerpc64le-linux-gnu-cc && \
     ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/powerpc64le-linux-gnu-gcc
 
-ENV ABI "powerpc64le-linux-gnu"
-ENV MESON_OPTS "--cross-file=powerpc64le-linux-gnu"
-ENV RUST_TARGET "powerpc64le-unknown-linux-gnu"
+ENV ABI="powerpc64le-linux-gnu"
+ENV MESON_OPTS="--cross-file=powerpc64le-linux-gnu"
+ENV RUST_TARGET="powerpc64le-unknown-linux-gnu"
 ENV QEMU_CONFIGURE_OPTS --cross-prefix=powerpc64le-linux-gnu-
 ENV DEF_TARGET_LIST ppc64-softmmu,ppc64-linux-user
 # As a final step configure the user (if env is defined)
diff --git a/tests/docker/dockerfiles/debian-riscv64-cross.docker b/tests/docker/dockerfiles/debian-riscv64-cross.docker
index 09b2953f32c..2591c4adc96 100644
--- a/tests/docker/dockerfiles/debian-riscv64-cross.docker
+++ b/tests/docker/dockerfiles/debian-riscv64-cross.docker
@@ -72,17 +72,14 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
 
 RUN /usr/bin/pip3 install meson==1.8.1
 
-ENV CCACHE_WRAPPERSDIR "/usr/libexec/ccache-wrappers"
-ENV LANG "en_US.UTF-8"
-ENV MAKE "/usr/bin/make"
-ENV NINJA "/usr/bin/ninja"
-ENV PYTHON "/usr/bin/python3"
+ENV CCACHE_WRAPPERSDIR="/usr/libexec/ccache-wrappers"
+ENV LANG="en_US.UTF-8"
+ENV MAKE="/usr/bin/make"
+ENV NINJA="/usr/bin/ninja"
+ENV PYTHON="/usr/bin/python3"
 
 RUN export DEBIAN_FRONTEND=noninteractive && \
     dpkg --add-architecture riscv64 && \
-    eatmydata apt-get install debian-ports-archive-keyring && \
-    eatmydata echo 'deb http://ftp.ports.debian.org/debian-ports/ sid main' > /etc/apt/sources.list.d/ports.list && \
-    eatmydata echo 'deb http://ftp.ports.debian.org/debian-ports/ unreleased main' >> /etc/apt/sources.list.d/ports.list && \
     eatmydata apt-get update && \
     eatmydata apt-get dist-upgrade -y && \
     eatmydata apt-get install --no-install-recommends -y dpkg-dev && \
@@ -179,9 +176,9 @@ endian = 'little'\n" > /usr/local/share/meson/cross/riscv64-linux-gnu && \
     ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/riscv64-linux-gnu-cc && \
     ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/riscv64-linux-gnu-gcc
 
-ENV ABI "riscv64-linux-gnu"
-ENV MESON_OPTS "--cross-file=riscv64-linux-gnu"
-ENV RUST_TARGET "riscv64gc-unknown-linux-gnu"
+ENV ABI="riscv64-linux-gnu"
+ENV MESON_OPTS="--cross-file=riscv64-linux-gnu"
+ENV RUST_TARGET="riscv64gc-unknown-linux-gnu"
 ENV QEMU_CONFIGURE_OPTS --cross-prefix=riscv64-linux-gnu-
 ENV DEF_TARGET_LIST riscv64-softmmu,riscv64-linux-user
 # As a final step configure the user (if env is defined)
diff --git a/tests/docker/dockerfiles/debian-s390x-cross.docker b/tests/docker/dockerfiles/debian-s390x-cross.docker
index 09a78c15baf..57aa3209c5c 100644
--- a/tests/docker/dockerfiles/debian-s390x-cross.docker
+++ b/tests/docker/dockerfiles/debian-s390x-cross.docker
@@ -72,11 +72,11 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
 
 RUN /usr/bin/pip3 install meson==1.8.1
 
-ENV CCACHE_WRAPPERSDIR "/usr/libexec/ccache-wrappers"
-ENV LANG "en_US.UTF-8"
-ENV MAKE "/usr/bin/make"
-ENV NINJA "/usr/bin/ninja"
-ENV PYTHON "/usr/bin/python3"
+ENV CCACHE_WRAPPERSDIR="/usr/libexec/ccache-wrappers"
+ENV LANG="en_US.UTF-8"
+ENV MAKE="/usr/bin/make"
+ENV NINJA="/usr/bin/ninja"
+ENV PYTHON="/usr/bin/python3"
 
 RUN export DEBIAN_FRONTEND=noninteractive && \
     dpkg --add-architecture s390x && \
@@ -175,9 +175,9 @@ endian = 'big'\n" > /usr/local/share/meson/cross/s390x-linux-gnu && \
     ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/s390x-linux-gnu-cc && \
     ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/s390x-linux-gnu-gcc
 
-ENV ABI "s390x-linux-gnu"
-ENV MESON_OPTS "--cross-file=s390x-linux-gnu"
-ENV RUST_TARGET "s390x-unknown-linux-gnu"
+ENV ABI="s390x-linux-gnu"
+ENV MESON_OPTS="--cross-file=s390x-linux-gnu"
+ENV RUST_TARGET="s390x-unknown-linux-gnu"
 ENV QEMU_CONFIGURE_OPTS --cross-prefix=s390x-linux-gnu-
 ENV DEF_TARGET_LIST s390x-softmmu,s390x-linux-user
 # As a final step configure the user (if env is defined)
diff --git a/tests/docker/dockerfiles/debian.docker b/tests/docker/dockerfiles/debian.docker
index 8dd893be4b0..bbb920c6815 100644
--- a/tests/docker/dockerfiles/debian.docker
+++ b/tests/docker/dockerfiles/debian.docker
@@ -152,11 +152,11 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
 
 RUN /usr/bin/pip3 install meson==1.8.1
 
-ENV CCACHE_WRAPPERSDIR "/usr/libexec/ccache-wrappers"
-ENV LANG "en_US.UTF-8"
-ENV MAKE "/usr/bin/make"
-ENV NINJA "/usr/bin/ninja"
-ENV PYTHON "/usr/bin/python3"
+ENV CCACHE_WRAPPERSDIR="/usr/libexec/ccache-wrappers"
+ENV LANG="en_US.UTF-8"
+ENV MAKE="/usr/bin/make"
+ENV NINJA="/usr/bin/ninja"
+ENV PYTHON="/usr/bin/python3"
 # netmap/cscope/global
 RUN DEBIAN_FRONTEND=noninteractive eatmydata \
   apt install -y --no-install-recommends \
diff --git a/tests/docker/dockerfiles/fedora-rust-nightly.docker b/tests/docker/dockerfiles/fedora-rust-nightly.docker
index 7d31c9f4060..e4233b53cbe 100644
--- a/tests/docker/dockerfiles/fedora-rust-nightly.docker
+++ b/tests/docker/dockerfiles/fedora-rust-nightly.docker
@@ -152,11 +152,11 @@ exec "$@"\n' > /usr/bin/nosync && \
 
 RUN /usr/bin/pip3 install meson==1.8.1
 
-ENV CCACHE_WRAPPERSDIR "/usr/libexec/ccache-wrappers"
-ENV LANG "en_US.UTF-8"
-ENV MAKE "/usr/bin/make"
-ENV NINJA "/usr/bin/ninja"
-ENV PYTHON "/usr/bin/python3"
+ENV CCACHE_WRAPPERSDIR="/usr/libexec/ccache-wrappers"
+ENV LANG="en_US.UTF-8"
+ENV MAKE="/usr/bin/make"
+ENV NINJA="/usr/bin/ninja"
+ENV PYTHON="/usr/bin/python3"
 RUN dnf install -y wget
 ENV RUSTUP_HOME=/usr/local/rustup CARGO_HOME=/usr/local/cargo
 ENV RUSTC=/usr/local/rustup/toolchains/nightly-x86_64-unknown-linux-gnu/bin/rustc
diff --git a/tests/docker/dockerfiles/fedora-win64-cross.docker b/tests/docker/dockerfiles/fedora-win64-cross.docker
index c76a70c3684..e6f84dd556f 100644
--- a/tests/docker/dockerfiles/fedora-win64-cross.docker
+++ b/tests/docker/dockerfiles/fedora-win64-cross.docker
@@ -72,11 +72,11 @@ exec "$@"\n' > /usr/bin/nosync && \
 
 RUN /usr/bin/pip3 install meson==1.8.1
 
-ENV CCACHE_WRAPPERSDIR "/usr/libexec/ccache-wrappers"
-ENV LANG "en_US.UTF-8"
-ENV MAKE "/usr/bin/make"
-ENV NINJA "/usr/bin/ninja"
-ENV PYTHON "/usr/bin/python3"
+ENV CCACHE_WRAPPERSDIR="/usr/libexec/ccache-wrappers"
+ENV LANG="en_US.UTF-8"
+ENV MAKE="/usr/bin/make"
+ENV NINJA="/usr/bin/ninja"
+ENV PYTHON="/usr/bin/python3"
 
 RUN nosync dnf install -y \
                mingw-w64-tools \
@@ -110,8 +110,8 @@ RUN nosync dnf install -y \
     ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/x86_64-w64-mingw32-g++ && \
     ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/x86_64-w64-mingw32-gcc
 
-ENV ABI "x86_64-w64-mingw32"
-ENV MESON_OPTS "--cross-file=/usr/share/mingw/toolchain-mingw64.meson"
+ENV ABI="x86_64-w64-mingw32"
+ENV MESON_OPTS="--cross-file=/usr/share/mingw/toolchain-mingw64.meson"
 ENV QEMU_CONFIGURE_OPTS --cross-prefix=x86_64-w64-mingw32-
 ENV DEF_TARGET_LIST x86_64-softmmu
 # As a final step configure the user (if env is defined)
diff --git a/tests/docker/dockerfiles/fedora.docker b/tests/docker/dockerfiles/fedora.docker
index 891a740fcbc..632259378c9 100644
--- a/tests/docker/dockerfiles/fedora.docker
+++ b/tests/docker/dockerfiles/fedora.docker
@@ -152,11 +152,11 @@ exec "$@"\n' > /usr/bin/nosync && \
 
 RUN /usr/bin/pip3 install meson==1.8.1
 
-ENV CCACHE_WRAPPERSDIR "/usr/libexec/ccache-wrappers"
-ENV LANG "en_US.UTF-8"
-ENV MAKE "/usr/bin/make"
-ENV NINJA "/usr/bin/ninja"
-ENV PYTHON "/usr/bin/python3"
+ENV CCACHE_WRAPPERSDIR="/usr/libexec/ccache-wrappers"
+ENV LANG="en_US.UTF-8"
+ENV MAKE="/usr/bin/make"
+ENV NINJA="/usr/bin/ninja"
+ENV PYTHON="/usr/bin/python3"
 # As a final step configure the user (if env is defined)
 ARG USER
 ARG UID
diff --git a/tests/docker/dockerfiles/opensuse-leap.docker b/tests/docker/dockerfiles/opensuse-leap.docker
index 75e17477807..def0ca9db46 100644
--- a/tests/docker/dockerfiles/opensuse-leap.docker
+++ b/tests/docker/dockerfiles/opensuse-leap.docker
@@ -138,11 +138,11 @@ RUN /usr/bin/pip3.11 install \
                      sphinx \
                      sphinx-rtd-theme
 
-ENV CCACHE_WRAPPERSDIR "/usr/libexec/ccache-wrappers"
-ENV LANG "en_US.UTF-8"
-ENV MAKE "/usr/bin/make"
-ENV NINJA "/usr/bin/ninja"
-ENV PYTHON "/usr/bin/python3.11"
+ENV CCACHE_WRAPPERSDIR="/usr/libexec/ccache-wrappers"
+ENV LANG="en_US.UTF-8"
+ENV MAKE="/usr/bin/make"
+ENV NINJA="/usr/bin/ninja"
+ENV PYTHON="/usr/bin/python3.11"
 # As a final step configure the user (if env is defined)
 ARG USER
 ARG UID
diff --git a/tests/docker/dockerfiles/ubuntu2204.docker b/tests/docker/dockerfiles/ubuntu2204.docker
index 602d4196249..c8cc6249296 100644
--- a/tests/docker/dockerfiles/ubuntu2204.docker
+++ b/tests/docker/dockerfiles/ubuntu2204.docker
@@ -150,11 +150,11 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
 
 RUN /usr/bin/pip3 install meson==1.8.1
 
-ENV CCACHE_WRAPPERSDIR "/usr/libexec/ccache-wrappers"
-ENV LANG "en_US.UTF-8"
-ENV MAKE "/usr/bin/make"
-ENV NINJA "/usr/bin/ninja"
-ENV PYTHON "/usr/bin/python3"
+ENV CCACHE_WRAPPERSDIR="/usr/libexec/ccache-wrappers"
+ENV LANG="en_US.UTF-8"
+ENV MAKE="/usr/bin/make"
+ENV NINJA="/usr/bin/ninja"
+ENV PYTHON="/usr/bin/python3"
 ENV RUSTC=/usr/bin/rustc-1.83
 ENV RUSTDOC=/usr/bin/rustdoc-1.83
 ENV CARGO_HOME=/usr/local/cargo
diff --git a/tests/lcitool/libvirt-ci b/tests/lcitool/libvirt-ci
index 9da20ff7c3b..caed407a0f1 160000
--- a/tests/lcitool/libvirt-ci
+++ b/tests/lcitool/libvirt-ci
@@ -1 +1 @@
-Subproject commit 9da20ff7c3bc9067804a7561c2ff87583b434853
+Subproject commit caed407a0f1dfe3a3293a41c378c382deefbac36
-- 
2.47.3


