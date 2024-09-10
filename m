Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24168EDE9AC
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 17:41:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so4ps-0005jm-5i; Tue, 10 Sep 2024 13:39:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1so4pZ-0004lX-EG
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 13:39:09 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1so4pW-0004ZN-7h
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 13:39:09 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5c25554ec1eso7583301a12.1
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 10:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725989945; x=1726594745; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rxdRaiTcMZc5S1W+zC5XJ30AZucjTk2s7eZ1WW+ddog=;
 b=ggfKaOWQPe1dS893CgpGZ5mGcfBrOPYpqL0Nvz2KzaMixQClCybr6odljo7HROtuTw
 6KzKtXt5tIrippbctoMsf2p44FuEs29Cnnyk9LAlr+E8AcnYvRirmAPhv4QY17zpICty
 fHInb0UFFpFxisBJ5iRmXExC+3IPu2ReG9SE75XRfeQa9PEj6lMfofyr65lxa2bVMFEX
 UP0B/G/fpz6wWMbXGP6WmvPTGW+Jj5nzwVRlgs4BXFk899xCYn+hrd/xYitciD/Jj6NC
 9DikcGw+FrwdSRXUcix5bx3RuRArcf2YNcJwOgvE8jt9Mo8Qg7V93rcAgS23am4Vbpgp
 lsGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725989945; x=1726594745;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rxdRaiTcMZc5S1W+zC5XJ30AZucjTk2s7eZ1WW+ddog=;
 b=UnkjI+/gNj5vOFyBccRQx1XjFGcmHHAtNw62Vpk16Qw7f1hIxDi75k8dytAVQxiflV
 giAUc5qouD0394Fa/zcNaFuojt8LlvNYiy+QQ3AP5dlixvWBX98dsoIhqXkJV/hzuM2O
 U3WI6kqL4DUGQ4corUftYUE7cv6jvoEQ9zDBMJ8i1wUuzUT9eJnPzxDOD+b6hdVxTz36
 0A4VvqkRSRe90SB07TR72VdSG6rwmBOzEJa0ZM1UmFpw6UaQ0r4PffUcDaR7b5L77LgP
 Va2HH9QI1gBZX4A8CkaqCBDCvYB+YzKBA0RuBBPBJI+4eHYIdTsc4/Gs5XoqWV/8jFDa
 EpVA==
X-Gm-Message-State: AOJu0YwIa+y9H7v1+RRVT60vblmgyb87X7yFcl+er9RWymJa2OB7wPHj
 PVJ7bEfnSdyakeH2eV0DpVnCkwYtHVbeXkasCd5u9vwJT1ZCZpWFGPpgDl7z7/4=
X-Google-Smtp-Source: AGHT+IEy8xm9TQ/OfdiMVTVxFx9PsY1/i7uDVqSwJfXKQyMFqLVYM95l36xLFNnAVnlOxzL43plRbQ==
X-Received: by 2002:a05:6402:5111:b0:5c2:6d80:b4ed with SMTP id
 4fb4d7f45d1cf-5c3e9630ee6mr8601383a12.13.1725989944583; 
 Tue, 10 Sep 2024 10:39:04 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c3ebd41c36sm4512760a12.2.2024.09.10.10.39.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2024 10:39:01 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 9CFDA5F7B4;
 Tue, 10 Sep 2024 18:39:00 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-arm@nongnu.org,
 devel@lists.libvirt.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Beraldo Leal <bleal@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Subject: [PATCH v2 02/10] tests/docker: update debian i686 and mipsel images
 to bookworm
Date: Tue, 10 Sep 2024 18:38:52 +0100
Message-Id: <20240910173900.4154726-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240910173900.4154726-1-alex.bennee@linaro.org>
References: <20240910173900.4154726-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x531.google.com
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

Whatever issues there were which stopped these being updates when the
rest were have now been resolved. However mips64el continues to be
broken so don't update it here.

Message-Id: <20240910140733.4007719-3-alex.bennee@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/docker/dockerfiles/debian-i686-cross.docker   | 10 ++++------
 tests/docker/dockerfiles/debian-mipsel-cross.docker | 10 ++++------
 tests/lcitool/refresh                               |  4 ++--
 3 files changed, 10 insertions(+), 14 deletions(-)

diff --git a/tests/docker/dockerfiles/debian-i686-cross.docker b/tests/docker/dockerfiles/debian-i686-cross.docker
index 3fe8ee623d..2328ee1732 100644
--- a/tests/docker/dockerfiles/debian-i686-cross.docker
+++ b/tests/docker/dockerfiles/debian-i686-cross.docker
@@ -1,10 +1,10 @@
 # THIS FILE WAS AUTO-GENERATED
 #
-#  $ lcitool dockerfile --layers all --cross-arch i686 debian-11 qemu
+#  $ lcitool dockerfile --layers all --cross-arch i686 debian-12 qemu
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
@@ -145,6 +142,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       libvdeplug-dev:i386 \
                       libvirglrenderer-dev:i386 \
                       libvte-2.91-dev:i386 \
+                      libxdp-dev:i386 \
                       libzstd-dev:i386 \
                       nettle-dev:i386 \
                       systemtap-sdt-dev:i386 \
diff --git a/tests/docker/dockerfiles/debian-mipsel-cross.docker b/tests/docker/dockerfiles/debian-mipsel-cross.docker
index 0d559ae4ba..4ac314e22e 100644
--- a/tests/docker/dockerfiles/debian-mipsel-cross.docker
+++ b/tests/docker/dockerfiles/debian-mipsel-cross.docker
@@ -1,10 +1,10 @@
 # THIS FILE WAS AUTO-GENERATED
 #
-#  $ lcitool dockerfile --layers all --cross-arch mipsel debian-11 qemu
+#  $ lcitool dockerfile --layers all --cross-arch mipsel debian-12 qemu
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
                       libvdeplug-dev:mipsel \
                       libvirglrenderer-dev:mipsel \
                       libvte-2.91-dev:mipsel \
+                      libxdp-dev:mipsel \
                       libzstd-dev:mipsel \
                       nettle-dev:mipsel \
                       systemtap-sdt-dev:mipsel \
diff --git a/tests/lcitool/refresh b/tests/lcitool/refresh
index 199d5fad87..c60490a7fa 100755
--- a/tests/lcitool/refresh
+++ b/tests/lcitool/refresh
@@ -159,7 +159,7 @@ try:
                         trailer=cross_build("arm-linux-gnueabihf-",
                                             "arm-softmmu,arm-linux-user"))
 
-    generate_dockerfile("debian-i686-cross", "debian-11",
+    generate_dockerfile("debian-i686-cross", "debian-12",
                         cross="i686",
                         trailer=cross_build("i686-linux-gnu-",
                                             "x86_64-softmmu,"
@@ -171,7 +171,7 @@ try:
                         trailer=cross_build("mips64el-linux-gnuabi64-",
                                             "mips64el-softmmu,mips64el-linux-user"))
 
-    generate_dockerfile("debian-mipsel-cross", "debian-11",
+    generate_dockerfile("debian-mipsel-cross", "debian-12",
                         cross="mipsel",
                         trailer=cross_build("mipsel-linux-gnu-",
                                             "mipsel-softmmu,mipsel-linux-user"))
-- 
2.39.2


