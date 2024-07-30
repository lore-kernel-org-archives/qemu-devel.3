Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BCA6C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 16:25:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYpcd-0008HT-4S; Tue, 30 Jul 2024 12:22:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sYpcc-0008D7-21
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 12:22:46 -0400
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sYpca-0003XJ-1o
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 12:22:45 -0400
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-52f025ab3a7so7508962e87.2
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2024 09:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722356561; x=1722961361; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/6pMZlm2bfjoRAj1q+Xtf7pWE5pLMJXZTwTQGH/c6jo=;
 b=YDuQc8Fulx7EH6aE4cXJyl/C9RbEgl6Vz85IVGKf7Nd3QDBlWdEwkcF9OA65GQLWFK
 TgHOk3WLPgw3L/C2fWPA3nLcfOH9AefnLkUSwvkFnnkXuazeFwRLUKdBCgKNTOE5ZFvI
 Hmo1G7YC274sDVcEVF/gwCkD0zDUunW0yQgFBlxv3hO7d3mxKVCVAHCWWo3XY6Mu5COf
 D/kqw0aFL+tttj4coCazBRyg7F/8ahpu0SYGc4GDKPHtnKDAtENo5fvlzd39TFZ7yMCX
 lboMqd69Mps9KfLicLEV2OcmUYAYlqjEHNeZstQaAGqueAMrYzAV3D+mCIGx/mNgE7yH
 sGQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722356561; x=1722961361;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/6pMZlm2bfjoRAj1q+Xtf7pWE5pLMJXZTwTQGH/c6jo=;
 b=ikQydmMrOYr0Qnk7FiPvqcUhePk3itnOz30/7guQQb/fiorKo7EwMluGVkfSjUOzLs
 N1Z4GwETJgOK+sMbLXKSyErPcKs1Xomih9WhdzwJ3YBBs4+G0JLbpSpZulkvJ5lLOF4P
 /vB49gTYuw3UYsYsgN2ZrQ/nxWYHMfMItr84nQKYxbHHVLzBp4kCocoIgRe/b7ahhHcU
 qmECtyCsRGyp+NN5+8UqC7r5XmoLFV9XBLvyD8O0UInNPjlHVldLMwbQjplzBOPedNLR
 kQwLA9glTwkTptIDZe+JNc+AjoD0IxWsJC76jeU4KMuXUiwvTez675ptU3ihplO+tDop
 XBhA==
X-Gm-Message-State: AOJu0YzBGrj1OWM4IhMun28Wd7OJqWdfWOt0uJ5H5CI2fG+NvmOEAnmJ
 aPpyMOwdUYbb8hL5DZDoVf5Dqm/2F0Xya3ECFKOONszmZHHPk2kZl0jnKKdjtvk=
X-Google-Smtp-Source: AGHT+IF5P+/llTRtk+dQ4pOEKCik83nvrWvzJVlzgEa+9OPCALVnEyIDINIwXiaDbW6ZpToazPHLqQ==
X-Received: by 2002:a19:7001:0:b0:52f:42a:a2db with SMTP id
 2adb3069b0e04-5309b28e7bdmr6535675e87.28.1722356560480; 
 Tue, 30 Jul 2024 09:22:40 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7acad9d3f4sm659501066b.165.2024.07.30.09.22.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jul 2024 09:22:38 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E34615F8BC;
 Tue, 30 Jul 2024 17:22:37 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Subject: [PULL 01/14] gitlab: record installed packages in /packages.txt in
 containers
Date: Tue, 30 Jul 2024 17:22:24 +0100
Message-Id: <20240730162237.1425515-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240730162237.1425515-1-alex.bennee@linaro.org>
References: <20240730162237.1425515-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::135;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x135.google.com
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
Acked-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240729144414.830369-2-alex.bennee@linaro.org>

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


