Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE4C8C83F22
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 10:56:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubzo5-00038L-HM; Wed, 16 Jul 2025 06:56:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ubzmJ-0007oi-7p
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 06:54:23 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ubzmF-0002TK-EX
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 06:54:22 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-60780d74c8cso10787116a12.2
 for <qemu-devel@nongnu.org>; Wed, 16 Jul 2025 03:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752663257; x=1753268057; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qU/lIoftl35AmMIjfDZPJ2CybmJfSii4BWcr/TA27jw=;
 b=oIRhDkiyCPOE/VwX3W3HEO4Gb53f/Q20EcY+OpXogH5uPQibwvUehmdCQYMhFDSa4j
 gQHxsLdZj+wSQvguIjVs4m+dyN3E2ITJZCXxPxQBluoFRs3tgqrldE6RY2dStoJ3gIIs
 DkbuIgqG9PxD6zC+jGYxAo/gW34NR+w+015W77W6Eqo5VAe1NVflRzJrSFhkM4yQAQFP
 +zA4JmyrZS+73aMnisa63gp5PXLz3TDcwlK8jx09hlXGCguLd+Z7RJwVKcHzrMG2HVW6
 Hsom8xl6ObYB3BtTaKSUtwybdwwt5ODS8m6Za1UQEo2Vfm1SRueKx5ikunPEdmMAA0CM
 C/aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752663257; x=1753268057;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qU/lIoftl35AmMIjfDZPJ2CybmJfSii4BWcr/TA27jw=;
 b=N2qHAgOVK8f+kXsG+4BHG5E2O/Dx0Ww3flB0qSFm2J4gvBcCDicrDdnS4NmrtYBSfA
 7WX9UUfO8/nRxd0qbHtDHQ3rhHQt2tcmZtEuYU3DGeHKmRI9J399UhbCV3mLOHLLUmah
 x3I1YothTzgzDedXVmeMM5gPxiM5V9DqtnrxR1dvvwmBYuU0ElJKqfUz0+SUidgaT+wB
 zOfkUZlwnYf5twlSkPP5H7OnfZCaFoNI/q2nT/BWAZDsmKwqAqzBLHNxQbQWgurYluhL
 ekHRnAu53mJTeJSz8zrguPoRIPuaq62vcNPHTXQIt4anCu8zcNOAEaUY1wxJy6m/hial
 iHxw==
X-Gm-Message-State: AOJu0Yy/4w0FlJk/Qd6J/7LnOri+TaPvUHlXTVtzUfPIozcuOQa47bpc
 XBQ2+6S2TmyH/6XAmGHHXHtpjXjuWHjig0wh0wGThvpWIGC1PULngv5nDr9AnVRfSTc=
X-Gm-Gg: ASbGnctrVVYg/gU/Zy9pNuFvXEre6IcgWC89nO97O6jFZiXp86FKQm7vspIR/7esIfy
 44iCvf0cesKTCIuF4FsnAlzkPPKv8H1IyQmnqEV+fC3jWamCKRJURvbdrj28LicKciSR0+BySzE
 D55xB8KyVH2gFlXMUOS3e3ZnC4N7MTwDyptkR8AN946coMle7tf+krLO6lK27hmFhMhqjGZ5mN+
 IFUdqU2y/6kg8kySz6o9gJHv+6BV0QMRctKYcUBvfDo9JRG1/b6kpog/k1K/jlqHSiX7vCaFd7K
 TZw02FqH+7wL1dCjPKqjuPULC2vg3BrAjmUr/h8rpbR50UQhQ4Y+qq0Qv6VINHQuVIFP8ieacBH
 bXnPPDUO3Zn5R/gKtsT4zxPU=
X-Google-Smtp-Source: AGHT+IHOyGm92EJtrV/D50upuX6iV8SKIt6KbM6JqWfaCXOWDNCXJcDUCAtsdYG2YR6ZLoHbuH08nw==
X-Received: by 2002:a17:907:b1a:b0:ae3:cc60:8cf0 with SMTP id
 a640c23a62f3a-ae9ce0b938cmr140697866b.34.1752663256766; 
 Wed, 16 Jul 2025 03:54:16 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ae6e82645b8sm1165789566b.106.2025.07.16.03.54.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Jul 2025 03:54:15 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 43F965F8B4;
 Wed, 16 Jul 2025 11:54:15 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 devel@lists.libvirt.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Subject: [RFC PATCH 4/6] tests/docker: add sparc-leon-cross container image
Date: Wed, 16 Jul 2025 11:54:12 +0100
Message-ID: <20250716105414.2330204-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250716105414.2330204-1-alex.bennee@linaro.org>
References: <20250716105414.2330204-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x533.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The distros no longer ship sparc compilers so we must use some others.
The best I could find was Frontgrade Gasiler who ship gcc binaries:

  https://www.gaisler.com/compilers-operating-systems

Add a simple image for building the test cases.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .../dockerfiles/sparc-leon-cross.docker       | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100644 tests/docker/dockerfiles/sparc-leon-cross.docker

diff --git a/tests/docker/dockerfiles/sparc-leon-cross.docker b/tests/docker/dockerfiles/sparc-leon-cross.docker
new file mode 100644
index 0000000000..ec391b01eb
--- /dev/null
+++ b/tests/docker/dockerfiles/sparc-leon-cross.docker
@@ -0,0 +1,40 @@
+#
+# Docker sparc cross-compiler target (tests only)
+#
+#
+#
+# While the normal cross builds take care to setup proper multiarch
+# build environments which can cross build QEMU this just installs the
+# basic compilers for as many targets as possible. We shall use this
+# to build and run linux-user tests on GitLab
+#
+FROM docker.io/library/debian:12-slim
+
+RUN export DEBIAN_FRONTEND=noninteractive && \
+    apt-get update && \
+    apt-get install -y eatmydata && \
+    eatmydata apt-get dist-upgrade -y
+
+# Add extra build tools and as many cross compilers as we can for testing
+RUN DEBIAN_FRONTEND=noninteractive eatmydata\
+        apt install -y --no-install-recommends \
+        ca-certificates \
+        ccache \
+        curl \
+        tar \
+        xz-utils
+
+RUN mkdir -p /opt
+
+RUN curl -#SL https://download.gaisler.com/anonftp/linux/linux-2.6/toolchains/sparc-gaisler-linux5.10-2.1.tar.xz \
+    | tar -xvJC /opt
+
+
+ENV PATH $PATH:/opt/sparc-gaisler-linux5.10/bin
+ENV LD_LIBRARY_PATH /opt/sparc-gaisler-linux5.10/sysroot/leon5/lib/:$LD_LIBRARY_PATH
+
+# As a final step configure the user (if env is defined)
+ARG USER
+ARG UID
+RUN if [ "${USER}" ]; then \
+  id ${USER} 2>/dev/null || useradd -u ${UID} -U ${USER}; fi
-- 
2.47.2


