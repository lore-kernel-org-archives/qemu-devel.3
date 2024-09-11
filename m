Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF1EAEE499D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 12:17:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soMG9-0007MD-7H; Wed, 11 Sep 2024 08:15:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1soMG3-0006oz-Dg
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 08:15:41 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1soMFx-0007Ph-Cp
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 08:15:37 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5c24ebaa427so1355583a12.1
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 05:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726056931; x=1726661731; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FxaJGvW87dvHfppQwXLSk9tWMV14wOmOE6nMe6VOAYo=;
 b=xN0ea/t0IvdSKJsbJ/JMC359VtFgORvpq0Hvy7Zynw9NzlsLOBCMBEF9B3B29GzVK1
 uRxi/Peergg8YMlSfophwEqPqs4k245l/PjzKVYEL9eyBGWFKODdQ/sfcIhXkHSsjowm
 BowGXgjYeba8a1/qM23gA1znNS6TbRFovAj6PaLBxr/UfNfBUivQxFdUk0i1+SR/dd/T
 2rGg6YuYaeaDjwX5xK2Om7sEJj0LafhVzwAe98//iXROgcWP61c1rq7+o3F2Bh9GMrRL
 tlGlxbZVwfMcITWWf1gWczZBKnkDsfhBhZ6m8wblu4j7CRzGODx/zpEwS/TXuTld2Y9W
 /4ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726056931; x=1726661731;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FxaJGvW87dvHfppQwXLSk9tWMV14wOmOE6nMe6VOAYo=;
 b=ZPhxLL3hCyIqt6BHSwUDj21m7LEIT8Eoa/XNvDgwpEgmU1OyAByJuATcc3K0eMZkRi
 zIExGxAa4HPdvrpfE8rFcih7HCC7BGoHXruGquV7gJYsdUGR2cdsgJIYnBI2WW8kifuR
 vxuvYfvEnExsfbeiFIH6Ie9J/IHHDeAh60yrOP2GmwiwQk4JAoA3zok99NI3LpXi8M+t
 WoLvVO+FgXmFo0joqokC/rocnaBksRIg2FZty+kyudPO1wncoq4GLc0p+g48/02WorEw
 0BImr8q5OcjJKrgZzQyPr7uPGB36qrhx2rVtMU2MXCglpAn1qUnBbkXvaK/595GCLEiS
 AxLw==
X-Gm-Message-State: AOJu0Ywu5h/jiMQZE8OMv0vae7BO+by6DF3jFiyFtQmJuD2VHB4RkbM4
 LNcOEOO0FsVQAnkcKNkK47H7SYjYVJnUE01OTph0RQbaMVDr4Lg5afBoiSAHYPIqnoifs425Qc4
 6
X-Google-Smtp-Source: AGHT+IE5TSZMv4PKDP4OWAlPmKyCEStgRy9PegS7ncJv6s4rzO3u5KGXzamfgErwxDHRdA8eoyDgVg==
X-Received: by 2002:a17:907:d15:b0:a8a:cc5a:7f30 with SMTP id
 a640c23a62f3a-a8ffb29dd63mr446325366b.25.1726056930876; 
 Wed, 11 Sep 2024 05:15:30 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.196.107])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25c624d4sm598864766b.112.2024.09.11.05.15.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 11 Sep 2024 05:15:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>
Subject: [PULL 09/56] buildsys: Remove CRIS cross container
Date: Wed, 11 Sep 2024 14:13:34 +0200
Message-ID: <20240911121422.52585-10-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240911121422.52585-1-philmd@linaro.org>
References: <20240911121422.52585-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52a.google.com
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

We removed the cross compiled CRIS tests in the previous commit.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Acked-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Message-ID: <20240904143603.52934-4-philmd@linaro.org>
---
 configure                                         |  4 ----
 .gitlab-ci.d/container-cross.yml                  |  5 -----
 tests/docker/Makefile.include                     |  1 -
 tests/docker/dockerfiles/fedora-cris-cross.docker | 14 --------------
 4 files changed, 24 deletions(-)
 delete mode 100644 tests/docker/dockerfiles/fedora-cris-cross.docker

diff --git a/configure b/configure
index d08b71f14b..4cf8be9eeb 100755
--- a/configure
+++ b/configure
@@ -1250,7 +1250,6 @@ probe_target_compiler() {
     aarch64) container_hosts="x86_64 aarch64" ;;
     alpha) container_hosts=x86_64 ;;
     arm) container_hosts="x86_64 aarch64" ;;
-    cris) container_hosts=x86_64 ;;
     hexagon) container_hosts=x86_64 ;;
     hppa) container_hosts=x86_64 ;;
     i386) container_hosts=x86_64 ;;
@@ -1309,9 +1308,6 @@ probe_target_compiler() {
         container_image=debian-armhf-cross
         container_cross_prefix=arm-linux-gnueabihf-
         ;;
-      cris)
-        container_image=fedora-cris-cross
-        ;;
       hexagon)
         container_cross_prefix=hexagon-unknown-linux-musl-
         container_cross_cc=${container_cross_prefix}clang
diff --git a/.gitlab-ci.d/container-cross.yml b/.gitlab-ci.d/container-cross.yml
index e3103940a0..78c8d2faa8 100644
--- a/.gitlab-ci.d/container-cross.yml
+++ b/.gitlab-ci.d/container-cross.yml
@@ -96,11 +96,6 @@ xtensa-debian-cross-container:
   variables:
     NAME: debian-xtensa-cross
 
-cris-fedora-cross-container:
-  extends: .container_job_template
-  variables:
-    NAME: fedora-cris-cross
-
 win64-fedora-cross-container:
   extends: .container_job_template
   variables:
diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index 708e3a72fb..681feae744 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -117,7 +117,6 @@ docker-image-debian-microblaze-cross: $(DOCKER_FILES_DIR)/debian-toolchain.docke
 # These images may be good enough for building tests but not for test builds
 DOCKER_PARTIAL_IMAGES += debian-microblaze-cross
 DOCKER_PARTIAL_IMAGES += debian-xtensa-cross
-DOCKER_PARTIAL_IMAGES += fedora-cris-cross
 
 # images that are only used to build other images
 DOCKER_VIRTUAL_IMAGES := debian-bootstrap debian-toolchain
diff --git a/tests/docker/dockerfiles/fedora-cris-cross.docker b/tests/docker/dockerfiles/fedora-cris-cross.docker
deleted file mode 100644
index 97c9d37ede..0000000000
--- a/tests/docker/dockerfiles/fedora-cris-cross.docker
+++ /dev/null
@@ -1,14 +0,0 @@
-#
-# Cross compiler for cris system tests
-#
-
-FROM registry.fedoraproject.org/fedora:33
-ENV PACKAGES gcc-cris-linux-gnu
-ENV MAKE /usr/bin/make
-RUN dnf install -y $PACKAGES
-RUN rpm -q $PACKAGES | sort > /packages.txt
-# As a final step configure the user (if env is defined)
-ARG USER
-ARG UID
-RUN if [ "${USER}" ]; then \
-  id ${USER} 2>/dev/null || useradd -u ${UID} -U ${USER}; fi
-- 
2.45.2


