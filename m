Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1EF1CF9C5B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2024 08:16:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sseEo-0007Xj-Og; Mon, 23 Sep 2024 04:16:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sseEl-0007SU-5C
 for qemu-devel@nongnu.org; Mon, 23 Sep 2024 04:16:03 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sseEa-0008EW-Hr
 for qemu-devel@nongnu.org; Mon, 23 Sep 2024 04:16:02 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-378c16a4d3eso4398527f8f.1
 for <qemu-devel@nongnu.org>; Mon, 23 Sep 2024 01:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727079350; x=1727684150; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=c3Onvi9UHbad6ukc7arbUZKYIPfwRyBIrmeNY5wtelU=;
 b=BofDlAmWEg6E6hEQ82QWx3RJpKgSNp7wq/Er+b5Gbzx0Vwlidf1inJ7LpYQ423FLHi
 h/1so7gy5qa1O2Nw1bn8sCCRFNXxJv6+k/9wWskxlB24yeqypr32/oPSM047A8KykX7M
 8Fp2M6nUH4MmMmlWLg7LmehoNh16hs5TCl7Kair6wFF/uzbxGwOPe1i1cVi3697Cro4b
 BVlF+2RPLBSdFgXimgut6lrgcpE6QydxXQKSt1dTCZPZNJw2DphE0hAUCLOyIOR4t8RW
 luIoOtBo+SQyoG8eRJGv8XgMLYM5n27/UQMxS+MnRBSUblaEoiyvZuSN3/SSoSWYfZo5
 Y5JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727079350; x=1727684150;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=c3Onvi9UHbad6ukc7arbUZKYIPfwRyBIrmeNY5wtelU=;
 b=eOYJDp4hEPqSv58rgyQGTEG6t9NtLFM2sA/W2oXz+aWqbE6E0FtBU5vAMXLNepcByz
 Wo2wmZF0qbnbdeBIfBouF4FG6OMr8po2/iEDPe1dVeuWWe3bVe7aHIENvsTUrJAhi4kL
 qbHKakFpppr4k4I8K0DmKIJFPoqqrogCSkNYXndqIluy3utUMh7j4uYpPzWEYQIroYCU
 SmDpVCBvBo2l+gNGu8gqYvXEoKGLHq3EWjl/xlkIEVpvnSBWBJf7uL0py5a3TUBKJIfZ
 wbzXHI1JvKL+vMoGxGMIJuQ4fPxGnVW4DT7jXunP0mbQg32FDWTchXdZTujw8ZG5brUQ
 Y6HA==
X-Gm-Message-State: AOJu0YzX6Y3T9eeCt1i/UAPT2O6DxeK8qmQS5yvYTP683BG/2W2rxH3T
 cvn6MdApkmRcU/MSqI4Djute9oZaTZuRzgH/KQbw6IsZo5rEbwsN1weMjS8EnAM=
X-Google-Smtp-Source: AGHT+IG2BMXe+umsdDAemAmgjZQvn/opiBsYMNMkGVh8XZB5q0DXjNMByQ9UetTIcKFFSQxMkvBQVg==
X-Received: by 2002:a5d:4741:0:b0:374:c6b8:50b5 with SMTP id
 ffacd0b85a97d-37a422783aamr8559730f8f.17.1727079349933; 
 Mon, 23 Sep 2024 01:15:49 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a906109669fsm1175032566b.3.2024.09.23.01.15.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Sep 2024 01:15:49 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 81CC15F8A6;
 Mon, 23 Sep 2024 09:15:48 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH] testing: bump mips64el cross to bookworm and allow to fail
Date: Mon, 23 Sep 2024 09:15:37 +0100
Message-Id: <20240923081537.3846145-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

The mips64el cross setup is very broken for bullseye which has now
entered LTS support so is unlikely to be fixed. While we still can't
build the container for bookworm due to a single missing dependency
that will hopefully get fixed in due course. For the sake of keeping
the CI green we mark it as allow_fail for the time being.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Cc: Michael Tokarev <mjt@tls.msk.ru>
---
 .gitlab-ci.d/container-cross.yml                      |  3 +++
 tests/docker/dockerfiles/debian-mips64el-cross.docker | 10 ++++------
 tests/lcitool/refresh                                 |  2 +-
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/.gitlab-ci.d/container-cross.yml b/.gitlab-ci.d/container-cross.yml
index 34c0e729ad..c567926182 100644
--- a/.gitlab-ci.d/container-cross.yml
+++ b/.gitlab-ci.d/container-cross.yml
@@ -49,6 +49,9 @@ i686-debian-cross-container:
 mips64el-debian-cross-container:
   extends: .container_job_template
   stage: containers
+  # Currently waiting for Debian to fix:
+  #  libgl1-mesa-dri:mips64el : Depends: libllvm15:mips64el but it is not going to be installed
+  allow_failure: true
   variables:
     NAME: debian-mips64el-cross
 
diff --git a/tests/docker/dockerfiles/debian-mips64el-cross.docker b/tests/docker/dockerfiles/debian-mips64el-cross.docker
index 2862785692..69d6e8cd11 100644
--- a/tests/docker/dockerfiles/debian-mips64el-cross.docker
+++ b/tests/docker/dockerfiles/debian-mips64el-cross.docker
@@ -1,10 +1,10 @@
 # THIS FILE WAS AUTO-GENERATED
 #
-#  $ lcitool dockerfile --layers all --cross-arch mips64el debian-11 qemu
+#  $ lcitool dockerfile --layers all --cross-arch mips64el debian-12 qemu
 #
 # https://gitlab.com/libvirt/libvirt-ci
 
-FROM docker.io/library/debian:11-slim
+FROM docker.io/library/debian:12-slim
 
 RUN export DEBIAN_FRONTEND=noninteractive && \
     apt-get update && \
@@ -48,16 +48,15 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       python3-opencv \
                       python3-pillow \
                       python3-pip \
-                      python3-setuptools \
                       python3-sphinx \
                       python3-sphinx-rtd-theme \
                       python3-venv \
-                      python3-wheel \
                       python3-yaml \
                       rpm2cpio \
                       sed \
                       socat \
                       sparse \
+                      swtpm \
                       tar \
                       tesseract-ocr \
                       tesseract-ocr-eng \
@@ -69,8 +68,6 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
     dpkg-reconfigure locales && \
     rm -f /usr/lib*/python3*/EXTERNALLY-MANAGED
 
-RUN /usr/bin/pip3 install tomli
-
 ENV CCACHE_WRAPPERSDIR "/usr/libexec/ccache-wrappers"
 ENV LANG "en_US.UTF-8"
 ENV MAKE "/usr/bin/make"
@@ -143,6 +140,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       libvdeplug-dev:mips64el \
                       libvirglrenderer-dev:mips64el \
                       libvte-2.91-dev:mips64el \
+                      libxdp-dev:mips64el \
                       libzstd-dev:mips64el \
                       nettle-dev:mips64el \
                       systemtap-sdt-dev:mips64el \
diff --git a/tests/lcitool/refresh b/tests/lcitool/refresh
index 92381f3c46..a78219f7bc 100755
--- a/tests/lcitool/refresh
+++ b/tests/lcitool/refresh
@@ -166,7 +166,7 @@ try:
                                             "x86_64-linux-user,"
                                             "i386-softmmu,i386-linux-user"))
 
-    generate_dockerfile("debian-mips64el-cross", "debian-11",
+    generate_dockerfile("debian-mips64el-cross", "debian-12",
                         cross="mips64el",
                         trailer=cross_build("mips64el-linux-gnuabi64-",
                                             "mips64el-softmmu,mips64el-linux-user"))
-- 
2.39.5


