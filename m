Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3411CCCF9E8
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2024 17:14:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stVYV-0000PE-6l; Wed, 25 Sep 2024 13:11:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1stVYN-0000JO-1b
 for qemu-devel@nongnu.org; Wed, 25 Sep 2024 13:11:52 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1stVYJ-0000b5-9V
 for qemu-devel@nongnu.org; Wed, 25 Sep 2024 13:11:50 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-37cc810ce73so10585f8f.1
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2024 10:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727284302; x=1727889102; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c3Onvi9UHbad6ukc7arbUZKYIPfwRyBIrmeNY5wtelU=;
 b=dGX6XQxkXwLwxuiCSlgfKrvahmbsgaoZUcjptwk9LSo2lxOTjzoL4W3uk1nFsz+Sad
 3GI3kYdFlg/bWOleRDY2oljrvvyBckOPzIZpZAAXn8k9lojPNqNiKsIpYnQyCkFqAGOe
 pBuzjGSJ45cHaVNixPzGw3YyBEXgliYC/KJp58N9jaOkS3rVrdNbWDMKjZffL270WXSl
 RfZwyAbSx6MTCP5oe7GkpZxa4BRD98oJsyt16RC6qTcyRjT9kAkMAQ/Goi//UGK6Mi0A
 GNC4eB81vbQv3lKyJOPSeTOMbnrvsnOcbA+Wom8NnSzIdcRxXuTBstuDZ3VtQE8yksun
 Xs7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727284302; x=1727889102;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c3Onvi9UHbad6ukc7arbUZKYIPfwRyBIrmeNY5wtelU=;
 b=t9EkwcTA3flE8B+ralil0k+JOVDk69Nc/Uc+c07Dpn+LcrLTT+P3Ec1YKDyGrgSctW
 Qm3Tow/5nvr3CGxF8xH9iDVWs4w68c4jApFV+sz3giKxdPYN+z+bRH/gP+d65RaeY5mB
 i1bLaSY2xoqqKGZkzfJnHb0MFwG7Nr0Mes0axbiX2RbrldTFJZDfu1W7zZT1Qcrsyp2b
 LEGgqFmGG6NvTd8c4BQtze6mJr4zfaoh4MrjsR6X8cDQObBKhzO4LghtBqpexEkJYsNO
 9j2FPK/OdSzDqDFQNvgZlh3A3jYgwnzReBhdE4QgkTxFGQ8fDMQVo6QSlKMSkDAWu21m
 JeFQ==
X-Gm-Message-State: AOJu0Yw7xBqoWoh1+ccEpM/ODKYRYTPV5AK95vfcwFyDSXC6uk8iC4xC
 7we+Klm4LLG74Fic0p8PoE9F4rmLCFCcPnGGj2xZKMMeCc3M2z7eHJ5z4gVhAzM=
X-Google-Smtp-Source: AGHT+IGU9YspaaYUHAocJNpuK/dESiOM4/xW0oakkSg3HjbqR0jo4IN7CZSLTTUEdfpSOxiESLD4oA==
X-Received: by 2002:adf:e341:0:b0:371:9377:975f with SMTP id
 ffacd0b85a97d-37cc248404amr1850453f8f.25.1727284302309; 
 Wed, 25 Sep 2024 10:11:42 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cbc2c13cesm4508393f8f.29.2024.09.25.10.11.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Sep 2024 10:11:41 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 6E4A45F920;
 Wed, 25 Sep 2024 18:11:40 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, kvm@vger.kernel.org,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 devel@lists.libvirt.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Marcelo Tosatti <mtosatti@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Yanan Wang <wangyanan55@huawei.com>, Thomas Huth <thuth@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH 01/10] testing: bump mips64el cross to bookworm and allow to
 fail
Date: Wed, 25 Sep 2024 18:11:31 +0100
Message-Id: <20240925171140.1307033-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20240925171140.1307033-1-alex.bennee@linaro.org>
References: <20240925171140.1307033-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x436.google.com
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


