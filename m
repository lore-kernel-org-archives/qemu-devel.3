Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 607B1ECE564
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 14:10:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so1X1-0007ng-KW; Tue, 10 Sep 2024 10:07:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1so1Wx-0007WE-PE
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 10:07:43 -0400
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1so1Wt-0006Uf-RH
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 10:07:43 -0400
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-5365a9574b6so6261784e87.1
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 07:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725977258; x=1726582058; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ExuMbIXOAQGfG1vwm+EE/TEBGthlbZ6vFrpI/DJuVTs=;
 b=gWySgFGSZJHBFSCZchbamVIoMYzoFyDoLUWaN56zotj/54fxcwDClfO1uHrgtzDCVo
 87BoehHA4G9bJ+IbJE228SWpKXEEcskzz8cI6SNsfERZMPgJ5fgCXQVzjlU1H25iZqr8
 zDbies236RfOiRL33o6lwGXDJDT57o58nnKc27eV+nNSpL9XW7IAGQVq/Wl0rY9R9Gcd
 BkM7dYoysdeBFcFum3YCkHJzVZvY3Q4X8XM3ZL7UONsvZ12OUQJAeN/OnZc+m/1nD271
 gJxJM+KGNvxeDay6seaAvR+6hMzBOJtyKXaiNIK6+xnAMBCk/9Ut/VzsO5cCbgM44Dre
 fseQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725977258; x=1726582058;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ExuMbIXOAQGfG1vwm+EE/TEBGthlbZ6vFrpI/DJuVTs=;
 b=gV+pVOYlaICYw40QLxhEI0VdnS4Howh90f3iED3faBDVHnOMJcYfAxIjvQZxCE+03L
 OaQMcBTsR7jQVi7BdKeC8qGa7bMg3RbcP9kbT10IxDcs84XO0p6kwzhuwS8rkDkBtY2+
 OypBQlsvuF96C7bG6xQb9HtZ3YI327nLqvTc+W5LT58ipsBXVBpWyJnvUbVWoEh6jrrx
 BAe2dU4A4O0i/mxXdBhKw37ZP+cD4akGsJXClIUrLbTVa5as9Q0ZDhqMlX3U2i9rLZXO
 Onui1IHJ4ja/5+i57yWZjvDxseBVVKRn7H58ODdiAvJSt6irt6hMoFrUYm4H2DDnSDxU
 nMfg==
X-Gm-Message-State: AOJu0YwpYnPcyAQwQBNenbVeALSQjlutbCLoV98wAA+/PaD8TkoU/z1p
 j1T7AehQ7oiNKSzHUWkBfPFdqJ16XWqixRDLluIOqMZLZJl7Pdb1GTJNaU9Yo1c=
X-Google-Smtp-Source: AGHT+IHD9cl3GrQHrZn7xNAQK3tsXaN04X4wSHPljJCjEbWvzFormiwvfDWUhUBkNllzcCE8nQDpOg==
X-Received: by 2002:a05:6512:2395:b0:535:6925:7a82 with SMTP id
 2adb3069b0e04-536587f845amr14728847e87.41.1725977255283; 
 Tue, 10 Sep 2024 07:07:35 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25cecc21sm484887666b.166.2024.09.10.07.07.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2024 07:07:34 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D33825F7B4;
 Tue, 10 Sep 2024 15:07:33 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>, Zhao Liu <zhao1.liu@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Beraldo Leal <bleal@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Thomas Huth <thuth@redhat.com>,
 qemu-arm@nongnu.org, devel@lists.libvirt.org,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Subject: [PATCH 02/26] tests/docker: update debian i686 and mipsel images to
 bookworm
Date: Tue, 10 Sep 2024 15:07:09 +0100
Message-Id: <20240910140733.4007719-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240910140733.4007719-1-alex.bennee@linaro.org>
References: <20240910140733.4007719-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x136.google.com
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


