Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BF4AC3DA7E
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2024 14:45:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYRbr-0003eY-R1; Mon, 29 Jul 2024 10:44:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sYRbq-0003ay-ES
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 10:44:22 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sYRbm-0008MZ-OQ
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 10:44:21 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a7ac449a0e6so262260066b.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2024 07:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722264257; x=1722869057; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j5fFJhx+vMgfG1V76vPOjIITII9gIRW1UvsbXoaqfhQ=;
 b=Gp9o/a0FRpYF53rV+54dRNr8gvIGVLLmNgQUKjFo+INqZE4iO5A7f5YPXh4GLQpiCK
 9BZsLTYbjiQfGJmUidGRUHgbeLsrB/8NPyzsqi199odIDxD1HXvo4Y1z3KJg4RseDTlU
 c+q38a+70YCYFFDnQYUXQ5h+nIxasRmwqppAs1pHG0KP0sb/Ora11i/AxaqbegTYw2ET
 fRvHFtVsXFxWTDUV9KaBrSuLaNRsrUGO5Ks0OshjMGPLILMbcgNIgf6UwRDvAHIyG7ZU
 u/me/56R3eIp+R0YPBInYTv+THKuYivSRsPz+yvXCrTSS6B/LCB9sCbIgrY71T6VaruC
 vJBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722264257; x=1722869057;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j5fFJhx+vMgfG1V76vPOjIITII9gIRW1UvsbXoaqfhQ=;
 b=vhgBbPU3NRmpbpqx9ZMg++XXYGPjOpS4uS22EE9FVbjTuH1gLFJ9kUhggYDRSRZAG0
 6IlKb8wDUml+g1rhI2oG6SIX6qD0j1VpG67Y9AwO8e2XkthCc4m+S4Cp9VQ7zJXJJfrB
 Z5+9FqDUv4uRVueGhJ7orYL2bH06eri5Cz6dDVS3J1X5S7qGgZHugddltacyhSGDxmM3
 affbQa8Er1DyAv2aj5JFQJdSHOUc4kQeAWcvCR80r/QrQ4M7C6yOYdDpt0muTnRbjS+d
 NTFAM3YYg1489jD2JM2XRSQRLOzqirNX+xbW+onGC3gKWHqWUS0a8F3lJOEAF7jubvyz
 jozg==
X-Gm-Message-State: AOJu0YwT21MxJ3c2vtcIDiJQEASnoWkrd8qsf1rzQw1ZU46vIq4peJks
 1lDaG/NL7GlOZHKCbimxzJAndxG812srmyzXLb/6EDw/UWfIrllyZup+2OSE5AA=
X-Google-Smtp-Source: AGHT+IFxoNmmMsy1h/7fYoWEIEUAYxhhkKCm/iVRs9WvorySlcHEQ9jIDr2TPCGtWEZlVGMSwgJ/fw==
X-Received: by 2002:a17:907:84e:b0:a7d:26ff:aeb0 with SMTP id
 a640c23a62f3a-a7d4000b79bmr474456366b.30.1722264256673; 
 Mon, 29 Jul 2024 07:44:16 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7acad411bcsm511230266b.109.2024.07.29.07.44.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jul 2024 07:44:15 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 1C0A65F8DA;
 Mon, 29 Jul 2024 15:44:15 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>, Thomas Huth <thuth@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-riscv@nongnu.org, Weiwei Li <liwei1518@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-s390x@nongnu.org,
 Cleber Rosa <crosa@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, qemu-arm@nongnu.org,
 Alexandre Iooss <erdnaxe@crans.org>, Song Gao <gaosong@loongson.cn>,
 David Hildenbrand <david@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 01/14] gitlab: record installed packages in /packages.txt in
 containers
Date: Mon, 29 Jul 2024 15:44:01 +0100
Message-Id: <20240729144414.830369-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240729144414.830369-1-alex.bennee@linaro.org>
References: <20240729144414.830369-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x630.google.com
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

From: Daniel P. Berrangé <berrange@redhat.com>

The lcitool created containers save the full distro package list
details into /packages.txt. The idea is that build jobs will 'cat'
this file, so that the build log has a record of what packages
were used. This is important info, because when it comes to debug
failures, the original container is often lost.

This extends the manually written dockerfiles to also create the
/packages.txt file.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Message-Id: <20240724095505.33544-2-berrange@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/docker/dockerfiles/debian-all-test-cross.docker    | 3 ++-
 tests/docker/dockerfiles/debian-hexagon-cross.docker     | 3 ++-
 tests/docker/dockerfiles/debian-legacy-test-cross.docker | 3 ++-
 tests/docker/dockerfiles/debian-loongarch-cross.docker   | 3 ++-
 tests/docker/dockerfiles/debian-tricore-cross.docker     | 3 ++-
 tests/docker/dockerfiles/debian-xtensa-cross.docker      | 3 ++-
 6 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/tests/docker/dockerfiles/debian-all-test-cross.docker b/tests/docker/dockerfiles/debian-all-test-cross.docker
index 6cc38a3633..8ab244e018 100644
--- a/tests/docker/dockerfiles/debian-all-test-cross.docker
+++ b/tests/docker/dockerfiles/debian-all-test-cross.docker
@@ -62,7 +62,8 @@ RUN DEBIAN_FRONTEND=noninteractive eatmydata \
         gcc-s390x-linux-gnu \
         libc6-dev-s390x-cross \
         gcc-sparc64-linux-gnu \
-        libc6-dev-sparc64-cross
+        libc6-dev-sparc64-cross && \
+        dpkg-query --showformat '${Package}_${Version}_${Architecture}\n' --show > /packages.txt
 
 
 ENV QEMU_CONFIGURE_OPTS --disable-system --disable-docs --disable-tools
diff --git a/tests/docker/dockerfiles/debian-hexagon-cross.docker b/tests/docker/dockerfiles/debian-hexagon-cross.docker
index f2d40f2dee..23152b4918 100644
--- a/tests/docker/dockerfiles/debian-hexagon-cross.docker
+++ b/tests/docker/dockerfiles/debian-hexagon-cross.docker
@@ -33,7 +33,8 @@ RUN apt-get update && \
     ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/c++ && \
     ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/cc && \
     ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/g++ && \
-    ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/gcc
+    ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/gcc && \
+    dpkg-query --showformat '${Package}_${Version}_${Architecture}\n' --show > /packages.txt
 
 RUN /usr/bin/pip3 install tomli
 
diff --git a/tests/docker/dockerfiles/debian-legacy-test-cross.docker b/tests/docker/dockerfiles/debian-legacy-test-cross.docker
index d75e0b85e2..5a6616b7d3 100644
--- a/tests/docker/dockerfiles/debian-legacy-test-cross.docker
+++ b/tests/docker/dockerfiles/debian-legacy-test-cross.docker
@@ -36,7 +36,8 @@ RUN DEBIAN_FRONTEND=noninteractive eatmydata \
         python3-pip \
         python3-setuptools \
         python3-venv \
-        python3-wheel
+        python3-wheel && \
+        dpkg-query --showformat '${Package}_${Version}_${Architecture}\n' --show > /packages.txt
 
 RUN /usr/bin/pip3 install tomli
 
diff --git a/tests/docker/dockerfiles/debian-loongarch-cross.docker b/tests/docker/dockerfiles/debian-loongarch-cross.docker
index 6a9197528b..79eab5621e 100644
--- a/tests/docker/dockerfiles/debian-loongarch-cross.docker
+++ b/tests/docker/dockerfiles/debian-loongarch-cross.docker
@@ -32,7 +32,8 @@ RUN apt-get update && \
         python3-pip \
         python3-setuptools \
         python3-venv \
-        python3-wheel
+        python3-wheel && \
+        dpkg-query --showformat '${Package}_${Version}_${Architecture}\n' --show > /packages.txt
 
 RUN /usr/bin/pip3 install tomli
 
diff --git a/tests/docker/dockerfiles/debian-tricore-cross.docker b/tests/docker/dockerfiles/debian-tricore-cross.docker
index 16276aa21d..479b4d6eba 100644
--- a/tests/docker/dockerfiles/debian-tricore-cross.docker
+++ b/tests/docker/dockerfiles/debian-tricore-cross.docker
@@ -34,7 +34,8 @@ RUN apt update && \
        python3-pip \
        python3-setuptools \
        python3-wheel \
-       python3-venv
+       python3-venv && \
+       dpkg-query --showformat '${Package}_${Version}_${Architecture}\n' --show > /packages.txt
 
 RUN /usr/bin/pip3 install tomli
 
diff --git a/tests/docker/dockerfiles/debian-xtensa-cross.docker b/tests/docker/dockerfiles/debian-xtensa-cross.docker
index 413881899b..d011eee2ad 100644
--- a/tests/docker/dockerfiles/debian-xtensa-cross.docker
+++ b/tests/docker/dockerfiles/debian-xtensa-cross.docker
@@ -16,7 +16,8 @@ RUN apt-get update && \
         curl \
         gettext \
         git \
-        python3-minimal
+        python3-minimal && \
+    dpkg-query --showformat '${Package}_${Version}_${Architecture}\n' --show > /packages.txt
 
 ENV CPU_LIST dc232b dc233c de233_fpu dsp3400
 ENV TOOLCHAIN_RELEASE 2020.07
-- 
2.39.2


