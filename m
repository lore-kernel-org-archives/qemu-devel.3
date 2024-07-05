Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAE80C3271E
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 15:33:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPku2-0005iv-CW; Fri, 05 Jul 2024 11:31:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sPktx-0005eY-0K
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 11:31:09 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sPktt-0000QA-2I
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 11:31:08 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-58bac81f40bso2512540a12.1
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2024 08:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720193463; x=1720798263; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GTAwyE/pG5nM9OTzmL49b7cH+p8g0kVoInrpYccmZCc=;
 b=DIIagwuwpRqGQUSR/EpaflWq+x1InpfElgZszgSM+eIs+ixc0ac+PVQKMDuCNQkTwm
 SYURl4/yFJYneVcupwv/8CEE1aMvuqnqEfQSWE0IHIokPqNA/tnO82XZtTz9qPR536Yd
 bZzutQZvuW8YDFf3E8VMX8xvh9SsZtBHKr/HENxAszHj2OP8HPBMvMl6JC5FWODVLTw4
 8szC9jpDk9GaLPGeb2dp4JLjGjb+YYS1at211x5LnxDJKWF/NK/zmyraazIjtryyZyZo
 /QlP6rBq6GHLQwP6wh9e5cySJFNnBu7nI5Ixe6KbfyuutF90hwAzC5GX189+s2hYQYUA
 /yVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720193463; x=1720798263;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GTAwyE/pG5nM9OTzmL49b7cH+p8g0kVoInrpYccmZCc=;
 b=MSkpHDDou/jwLV5LMEwXwOMUxx8bZCoD8DN2qDrO1Qqm0IVfCrPTKUvEotvyQaXDzA
 ZGgzA2zHCK8c5MorbfIMdYuSsBGozF/zwOwS6xHSw06/neRaLuolGx9DowNou9nxFKMP
 ftruEuNZ4fOKd98GJgBUX8lIJZdMnjCbuCr4tvkiuQNqFbSpvFb/pLYb2d4ctgRanQ5j
 SCs7zN0JRhnIpRBFxQ9oG008PqxktTQCsaA2FX7FqH88AFQ2QW4wLpbIr2I4BRt4rQ/h
 9CKnYqJbWNF2t1PiaYIKrA7FFheS5VU+Ppp8JaqXOAHVxGcmwh1xzULOXOvhQiORlZZ1
 24MQ==
X-Gm-Message-State: AOJu0Yx0BqEHUcL7LPeOEw/UAAVB2Zjox9JBS5cpv1V/8tDTmjkxtIHm
 9dOgn9XDrmMUBKz3TgQSBum/cML4HmK2+8ElCg/XOdaGAoZ2C6hIy4iigbv2cG8=
X-Google-Smtp-Source: AGHT+IH4KvaHkGHjYJ2QdqXFIse5w11479ab7AnM4yrPTvgSNADSewV7I7Z3yj4Pmkx422hZymKx6w==
X-Received: by 2002:a17:906:4794:b0:a72:87c4:8fbe with SMTP id
 a640c23a62f3a-a77ba46bba9mr393737166b.21.1720193463004; 
 Fri, 05 Jul 2024 08:31:03 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a77cd9cb2f7sm56529166b.29.2024.07.05.08.30.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jul 2024 08:30:57 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id A793F5F9EB;
 Fri,  5 Jul 2024 16:30:53 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org (open list:ARM TCG CPUs)
Subject: [PULL 07/40] tests/tcg: Adjust variable defintion from cc-option
Date: Fri,  5 Jul 2024 16:30:19 +0100
Message-Id: <20240705153052.1219696-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240705153052.1219696-1-alex.bennee@linaro.org>
References: <20240705153052.1219696-1-alex.bennee@linaro.org>
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

From: Richard Henderson <richard.henderson@linaro.org>

Define the variable to the compiler flag used, not "y".
This avoids replication of the compiler flag itself.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-Id: <20240630190050.160642-3-richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240705084047.857176-8-alex.bennee@linaro.org>

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
index 4ecbca6a41..11ccde5579 100644
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
 AARCH64_TESTS += pauth-1 pauth-2 pauth-4 pauth-5 test-2375
-pauth-%: CFLAGS += -march=armv8.3-a
+pauth-%: CFLAGS += $(CROSS_CC_HAS_ARMV8_3)
 test-2375: CFLAGS += -march=armv8.3-a
 run-pauth-1: QEMU_OPTS += -cpu max
 run-pauth-2: QEMU_OPTS += -cpu max
@@ -55,7 +55,7 @@ endif
 # bti-1 tests the elf notes, so we require special compiler support.
 ifneq ($(CROSS_CC_HAS_ARMV8_BTI),)
 AARCH64_TESTS += bti-1 bti-3
-bti-1 bti-3: CFLAGS += -fno-stack-protector -mbranch-protection=standard
+bti-1 bti-3: CFLAGS += -fno-stack-protector $(CROSS_CC_HAS_ARMV8_BTI)
 bti-1 bti-3: LDFLAGS += -nostdlib
 endif
 # bti-2 tests PROT_BTI, so no special compiler support required.
@@ -64,12 +64,13 @@ AARCH64_TESTS += bti-2
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
@@ -99,7 +100,7 @@ TESTS += sha512-vector
 ifneq ($(CROSS_CC_HAS_SVE),)
 # SVE ioctl test
 AARCH64_TESTS += sve-ioctls
-sve-ioctls: CFLAGS+=-march=armv8.1-a+sve
+sve-ioctls: CFLAGS += $(CROSS_CC_HAS_SVE)
 
 sha512-sve: CFLAGS=-O3 -march=armv8.1-a+sve
 sha512-sve: sha512.c
@@ -134,7 +135,7 @@ endif
 
 ifneq ($(CROSS_CC_HAS_SVE2),)
 AARCH64_TESTS += test-826
-test-826: CFLAGS+=-march=armv8.1-a+sve2
+test-826: CFLAGS += $(CROSS_CC_HAS_SVE2)
 endif
 
 TESTS += $(AARCH64_TESTS)
-- 
2.39.2


