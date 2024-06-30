Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40755C27C4F
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Jun 2024 19:02:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNznQ-0004t4-QJ; Sun, 30 Jun 2024 15:01:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sNznJ-0004n7-RR
 for qemu-devel@nongnu.org; Sun, 30 Jun 2024 15:01:04 -0400
Received: from mail-io1-xd2c.google.com ([2607:f8b0:4864:20::d2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sNznF-0007UN-Rj
 for qemu-devel@nongnu.org; Sun, 30 Jun 2024 15:01:01 -0400
Received: by mail-io1-xd2c.google.com with SMTP id
 ca18e2360f4ac-7f38f5584ebso97649339f.3
 for <qemu-devel@nongnu.org>; Sun, 30 Jun 2024 12:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719774054; x=1720378854; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FTAXIrXnB/PD2XabsVpOCoLz7F3reaebPtysv0EnFvo=;
 b=qPEoS6RkxQQV9fyG/6S181JzXMlrTVWcj5ySqbfkeTcbzxhBPVImFb08PGgqQ7ce4G
 RchZIIlUdQe+suP95Dz+QsGwWyIvmRdeNnYyfOIY0aRGbYy3RHXPiHSn2LhRjvQsVTMB
 Az9VbBw+q6DJgXoklXhBNi1ZeUNO8JYA4dAahTmWwiWfViO3Lj61GC6HbhDtR+gCG3pp
 v+IfOBDPVjjGk3BlmWGZvy7jAr3+LWPhQEWrbB3aIMJHNQzjTF/L2ASrZN5kDiq5/Ms6
 PNqlEH7udGLqesf7ll3wh5Zn0Uz1go1mPA5PreaFhAzw4+5ktOhWuXAJ8HKPy+fveuIv
 8D6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719774054; x=1720378854;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FTAXIrXnB/PD2XabsVpOCoLz7F3reaebPtysv0EnFvo=;
 b=Q0n2dCz6Ez182vJ8afKlDbWMM4BzFUD41AhKKIb7azZL3LETobYvgSLsq7DRUy98K7
 gmg4pvqOHyIyEoKyHAhDZhaZERqXH8F+kYyuUf6jqLuAlTFnqhKIK2DpyKJWa/7PP6Ir
 rPBuVUw1n0hSxQeLSTn4AyWtuEWkOz3EMt3u+5DKoXzYKCGgvWpWxwJfK17YooXXNu04
 5OOwIzeWaqFHkSkcUTbObVwsLifdX+aqSQjGADqVKbs12U738elFcqMglvGmyRR6uwWv
 uxFWC6e1bVEEilsZR8uqrno8T8sv7iYpfAT2b2Ll5A6ejdnL+VcUqtNwUWSYt1vVxDF+
 dD4A==
X-Gm-Message-State: AOJu0YzJltX+pn9TWlDr0M3pFN3vITt/TRPFViV0FRU2kXyD+elXhBrQ
 953FYj38LjtGqnWyltqnXZpfCpDm2wyjmU3ynTOUO2+afP3X6ebslVGChbrokQLZMiAHR4folQI
 f
X-Google-Smtp-Source: AGHT+IGeyG1uFDyEn4u8ALv9U6tD54FmsB7XnO/jbeP+xinE/zkVpczxZMsm3jzcIvwVlpbV2A1akg==
X-Received: by 2002:a6b:ce01:0:b0:7eb:7887:a496 with SMTP id
 ca18e2360f4ac-7f62ee118a2mr450992939f.4.1719774054553; 
 Sun, 30 Jun 2024 12:00:54 -0700 (PDT)
Received: from stoup.. (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c91d3e7e4bsm5115641a91.52.2024.06.30.12.00.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Jun 2024 12:00:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: akihiko.odaki@daynix.com,
	alex.bennee@linaro.org,
	qemu-arm@nongnu.org
Subject: [PATCH v4 02/14] tests/tcg: Adjust variable defintion from cc-option
Date: Sun, 30 Jun 2024 12:00:38 -0700
Message-Id: <20240630190050.160642-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240630190050.160642-1-richard.henderson@linaro.org>
References: <20240630190050.160642-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::d2c;
 envelope-from=richard.henderson@linaro.org; helo=mail-io1-xd2c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Define the variable to the compiler flag used, not "y".
This avoids replication of the compiler flag itself.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tests/tcg/Makefile.target                 |  2 +-
 tests/tcg/aarch64/Makefile.softmmu-target |  2 +-
 tests/tcg/aarch64/Makefile.target         | 15 ++++++++-------
 3 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/tests/tcg/Makefile.target b/tests/tcg/Makefile.target
index f21be50d3b..cb8cfeb6da 100644
--- a/tests/tcg/Makefile.target
+++ b/tests/tcg/Makefile.target
@@ -49,7 +49,7 @@ quiet-command = $(call quiet-@,$2,$3)$1
 
 cc-test = $(CC) -Werror $1 -c -o /dev/null -xc /dev/null >/dev/null 2>&1
 cc-option = if $(call cc-test, $1); then \
-    echo "$(TARGET_PREFIX)$1 detected" && echo "$(strip $2)=y" >&3; else \
+    echo "$(TARGET_PREFIX)$1 detected" && echo "$(strip $2)=$(strip $1)" >&3; else \
     echo "$(TARGET_PREFIX)$1 not detected"; fi
 
 # $1 = test name, $2 = cmd, $3 = desc
diff --git a/tests/tcg/aarch64/Makefile.softmmu-target b/tests/tcg/aarch64/Makefile.softmmu-target
index 4b03ef602e..39d3f961c5 100644
--- a/tests/tcg/aarch64/Makefile.softmmu-target
+++ b/tests/tcg/aarch64/Makefile.softmmu-target
@@ -81,7 +81,7 @@ run-memory-replay: memory-replay run-memory-record
 EXTRA_RUNS+=run-memory-replay
 
 ifneq ($(CROSS_CC_HAS_ARMV8_3),)
-pauth-3: CFLAGS += -march=armv8.3-a
+pauth-3: CFLAGS += $(CROSS_CC_HAS_ARMV8_3)
 else
 pauth-3:
 	$(call skip-test, "BUILD of $@", "missing compiler support")
diff --git a/tests/tcg/aarch64/Makefile.target b/tests/tcg/aarch64/Makefile.target
index 70d728ae9a..e6d5e008a8 100644
--- a/tests/tcg/aarch64/Makefile.target
+++ b/tests/tcg/aarch64/Makefile.target
@@ -32,17 +32,17 @@ config-cc.mak: Makefile
 
 ifneq ($(CROSS_CC_HAS_ARMV8_2),)
 AARCH64_TESTS += dcpop
-dcpop: CFLAGS += -march=armv8.2-a
+dcpop: CFLAGS += $(CROSS_CC_HAS_ARMV8_2)
 endif
 ifneq ($(CROSS_CC_HAS_ARMV8_5),)
 AARCH64_TESTS += dcpodp
-dcpodp: CFLAGS += -march=armv8.5-a
+dcpodp: CFLAGS += $(CROSS_CC_HAS_ARMV8_5)
 endif
 
 # Pauth Tests
 ifneq ($(CROSS_CC_HAS_ARMV8_3),)
 AARCH64_TESTS += pauth-1 pauth-2 pauth-4 pauth-5
-pauth-%: CFLAGS += -march=armv8.3-a
+pauth-%: CFLAGS += $(CROSS_CC_HAS_ARMV8_3)
 run-pauth-1: QEMU_OPTS += -cpu max
 run-pauth-2: QEMU_OPTS += -cpu max
 # Choose a cpu with FEAT_Pauth but without FEAT_FPAC for pauth-[45].
@@ -54,7 +54,7 @@ endif
 # bti-1 tests the elf notes, so we require special compiler support.
 ifneq ($(CROSS_CC_HAS_ARMV8_BTI),)
 AARCH64_TESTS += bti-1 bti-3
-bti-1 bti-3: CFLAGS += -fno-stack-protector -mbranch-protection=standard
+bti-1 bti-3: CFLAGS += -fno-stack-protector $(CROSS_CC_HAS_ARMV8_BTI)
 bti-1 bti-3: LDFLAGS += -nostdlib
 endif
 # bti-2 tests PROT_BTI, so no special compiler support required.
@@ -63,12 +63,13 @@ AARCH64_TESTS += bti-2
 # MTE Tests
 ifneq ($(CROSS_CC_HAS_ARMV8_MTE),)
 AARCH64_TESTS += mte-1 mte-2 mte-3 mte-4 mte-5 mte-6 mte-7
-mte-%: CFLAGS += -march=armv8.5-a+memtag
+mte-%: CFLAGS += $(CROSS_CC_HAS_ARMV8_MTE)
 endif
 
 # SME Tests
 ifneq ($(CROSS_AS_HAS_ARMV9_SME),)
 AARCH64_TESTS += sme-outprod1 sme-smopa-1 sme-smopa-2
+sme-outprod1 sme-smopa-1 sme-smopa-2: CFLAGS += $(CROSS_AS_HAS_ARMV9_SME)
 endif
 
 # System Registers Tests
@@ -98,7 +99,7 @@ TESTS += sha512-vector
 ifneq ($(CROSS_CC_HAS_SVE),)
 # SVE ioctl test
 AARCH64_TESTS += sve-ioctls
-sve-ioctls: CFLAGS+=-march=armv8.1-a+sve
+sve-ioctls: CFLAGS += $(CROSS_CC_HAS_SVE)
 
 sha512-sve: CFLAGS=-O3 -march=armv8.1-a+sve
 sha512-sve: sha512.c
@@ -133,7 +134,7 @@ endif
 
 ifneq ($(CROSS_CC_HAS_SVE2),)
 AARCH64_TESTS += test-826
-test-826: CFLAGS+=-march=armv8.1-a+sve2
+test-826: CFLAGS += $(CROSS_CC_HAS_SVE2)
 endif
 
 TESTS += $(AARCH64_TESTS)
-- 
2.34.1


