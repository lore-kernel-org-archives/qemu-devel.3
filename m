Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F310C35FFA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 13:46:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tutjZ-0002ei-Cv; Wed, 19 Mar 2025 09:45:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tutjS-0002ZI-4E
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 09:45:18 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tutjP-0003u1-Lk
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 09:45:17 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3912e96c8e8so4446988f8f.2
 for <qemu-devel@nongnu.org>; Wed, 19 Mar 2025 06:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742391914; x=1742996714; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7eJxBU8sS6BBgMJn+fAfo2vd2fc/VM4cRvoTrtUG6dA=;
 b=LKPPc57PoBGWn0IRjSLzNr2WZlEMkPoHzzz2mMkzr0cwFic6l1nqMVM2QIS8BhNWhN
 32+Xc+UsCi7l0qiiuxa5IGlFRliOgP7f/nbmqgFle8qOsPTdi6C/WIxglG8wl3iTdDJ+
 xNtgULV6wrpwXyt+o0RLXkMHpkhvcMGVlTdSZsO+w+372+M5QCqovmEq3V7sauNuzc+6
 3vR9YW2u8Lte3Q4I32QB9yezTLP8w/pLLeQDEbUke2LIm1HtC+du7zkrhza37SuqZjK4
 dxjvCE1mHSHcXDOAk0AN2BLrpZuvRkmY4jIlhzxCvCv/7wajM/jQQvf1dEc020k0EHal
 1gbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742391914; x=1742996714;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7eJxBU8sS6BBgMJn+fAfo2vd2fc/VM4cRvoTrtUG6dA=;
 b=OcJVJHh0oBpyBpXYfhaWT39vXRaFGUxrR4hqN/DF9It6U7tGRoCWJrbDowTUNheAEO
 viYS1lqrFDP6U3B/UVSla9s9SfHGMqPiAKY/qJAaR/aJagL2CUyEJlUPlKpzMmz+ML4O
 gwQXsIKn+cjCsDxEKWaJB0fOWURkM6gVc0+bLwgFUz3HNaJ8sCX5v8JOORbrjfVti4vo
 papO2HvsKQ/1kife2jRu1vgfBG904oMm1RIkRCYvhveI9Hf3WDDGxh5gmQBmK1TkqYOR
 xECJX2k4yB2AVJ6WGPCntLLDdD5tzRgMWSJB3HS3yIZoz0+rssWKMeIgVhFL+h4v0wlb
 pjGQ==
X-Gm-Message-State: AOJu0YxKLxphxB3hps4bwyM8f5EMfYjVnqsFzv6x0Eh7n2gc92shiWFr
 TaQaheq3ZlH68RCtahu/QEgVb/aF1QbpY4+yJYInGZpgar+l5hH3eGK8t/bMy5uFwqqc3CVHeJg
 b
X-Gm-Gg: ASbGncvYOl/a3nWSElGirGdFcca31JVlxIZabUhiS8bbn5YOWUdNp6VNKR6f3ETMtcB
 ACDEOEg3ShkAPiV8hkJHghK7tgFF08KZF4URvZH9AI4nJoEIu1tWOi9QurY1YJKBfP+vTg3fr6m
 7KRqNq5dAEK1c8Bo0kPWl+19Wy/YOj3q9ef7XADYATQsnMDj7S4GinZQ5OM7IoVcMicv413eMf9
 pMBuu4lr2SvpjMjjqx6DecfcEPpq0sfbPLUwFELmAl9rYNEeLFgdhfrOZDwNzgvRh97YxFMbESq
 AH9sLqukdPumwa5eZiwftbTrWOHW0BCUW6laC9YK7vn1Da7QxVjXFmP4aPQ4cnMCR2eeGHNTRMj
 omj35Tbvf1uMLbR6TWNQ=
X-Google-Smtp-Source: AGHT+IEeQxNsk/U31CJNyiM5R+GbbMkVOAE7gigE2L2QxdVa6L+Y3T5iF4mC4IuVu1ESAsPxV0nb8A==
X-Received: by 2002:a5d:47a7:0:b0:385:ee40:2d88 with SMTP id
 ffacd0b85a97d-399739b63c5mr2556386f8f.3.1742391913538; 
 Wed, 19 Mar 2025 06:45:13 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-395c8975afesm20592484f8f.47.2025.03.19.06.45.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 19 Mar 2025 06:45:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>, Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.1 01/12] tcg: Declare TARGET_INSN_START_EXTRA_WORDS in
 'cpu-param.h'
Date: Wed, 19 Mar 2025 14:44:55 +0100
Message-ID: <20250319134507.45045-2-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250319134507.45045-1-philmd@linaro.org>
References: <20250319134507.45045-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

To avoid including the huge "cpu.h" for a simple definition,
move TARGET_INSN_START_EXTRA_WORDS to "cpu-param.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/cpu-param.h        | 14 ++++++++++++++
 target/arm/cpu.h              | 14 --------------
 target/hppa/cpu-param.h       |  2 ++
 target/hppa/cpu.h             |  2 --
 target/i386/cpu-param.h       |  2 ++
 target/i386/cpu.h             |  2 --
 target/m68k/cpu-param.h       |  2 ++
 target/m68k/cpu.h             |  2 --
 target/microblaze/cpu-param.h |  2 ++
 target/microblaze/cpu.h       |  2 --
 target/mips/cpu-param.h       |  2 ++
 target/mips/cpu.h             |  2 --
 target/openrisc/cpu-param.h   |  2 ++
 target/openrisc/cpu.h         |  2 --
 target/riscv/cpu-param.h      |  8 ++++++++
 target/riscv/cpu.h            |  6 ------
 target/s390x/cpu-param.h      |  2 ++
 target/s390x/cpu.h            |  2 --
 target/sh4/cpu-param.h        |  2 ++
 target/sh4/cpu.h              |  2 --
 target/sparc/cpu-param.h      |  2 ++
 target/sparc/cpu.h            |  1 -
 22 files changed, 40 insertions(+), 37 deletions(-)

diff --git a/target/arm/cpu-param.h b/target/arm/cpu-param.h
index 896b35bd6d5..ed1f0b16e51 100644
--- a/target/arm/cpu-param.h
+++ b/target/arm/cpu-param.h
@@ -38,6 +38,20 @@
 # define TARGET_PAGE_BITS_MIN  10
 #endif /* !CONFIG_USER_ONLY */
 
+/* ARM-specific extra insn start words:
+ * 1: Conditional execution bits
+ * 2: Partial exception syndrome for data aborts
+ */
+#define TARGET_INSN_START_EXTRA_WORDS 2
+
+/* The 2nd extra word holding syndrome info for data aborts does not use
+ * the upper 6 bits nor the lower 13 bits. We mask and shift it down to
+ * help the sleb128 encoder do a better job.
+ * When restoring the CPU state, we shift it back up.
+ */
+#define ARM_INSN_START_WORD2_MASK ((1 << 26) - 1)
+#define ARM_INSN_START_WORD2_SHIFT 13
+
 /* ARM processors have a weak memory model */
 #define TCG_GUEST_DEFAULT_MO      (0)
 
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index a8177c6c2e8..537359ff30b 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -100,20 +100,6 @@
 #define offsetofhigh32(S, M) (offsetof(S, M) + sizeof(uint32_t))
 #endif
 
-/* ARM-specific extra insn start words:
- * 1: Conditional execution bits
- * 2: Partial exception syndrome for data aborts
- */
-#define TARGET_INSN_START_EXTRA_WORDS 2
-
-/* The 2nd extra word holding syndrome info for data aborts does not use
- * the upper 6 bits nor the lower 13 bits. We mask and shift it down to
- * help the sleb128 encoder do a better job.
- * When restoring the CPU state, we shift it back up.
- */
-#define ARM_INSN_START_WORD2_MASK ((1 << 26) - 1)
-#define ARM_INSN_START_WORD2_SHIFT 13
-
 /* We currently assume float and double are IEEE single and double
    precision respectively.
    Doing runtime conversions is tricky because VFP registers may contain
diff --git a/target/hppa/cpu-param.h b/target/hppa/cpu-param.h
index 7ed6b5741e7..68ed84e84af 100644
--- a/target/hppa/cpu-param.h
+++ b/target/hppa/cpu-param.h
@@ -19,6 +19,8 @@
 
 #define TARGET_PAGE_BITS 12
 
+#define TARGET_INSN_START_EXTRA_WORDS 2
+
 /* PA-RISC 1.x processors have a strong memory model.  */
 /*
  * ??? While we do not yet implement PA-RISC 2.0, those processors have
diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index 7be4a1d3800..f289843c299 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -45,8 +45,6 @@
 #define PRIV_KERNEL       0
 #define PRIV_USER         3
 
-#define TARGET_INSN_START_EXTRA_WORDS 2
-
 /* No need to flush MMU_ABS*_IDX  */
 #define HPPA_MMU_FLUSH_MASK                             \
         (1 << MMU_KERNEL_IDX | 1 << MMU_KERNEL_P_IDX |  \
diff --git a/target/i386/cpu-param.h b/target/i386/cpu-param.h
index b0e884c5d70..0c8efce8619 100644
--- a/target/i386/cpu-param.h
+++ b/target/i386/cpu-param.h
@@ -22,6 +22,8 @@
 #endif
 #define TARGET_PAGE_BITS 12
 
+#define TARGET_INSN_START_EXTRA_WORDS 1
+
 /* The x86 has a strong memory model with some store-after-load re-ordering */
 #define TCG_GUEST_DEFAULT_MO      (TCG_MO_ALL & ~TCG_MO_ST_LD)
 
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 76f24446a55..f2cae1b066e 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1610,8 +1610,6 @@ typedef struct {
 #define MAX_FIXED_COUNTERS 3
 #define MAX_GP_COUNTERS    (MSR_IA32_PERF_STATUS - MSR_P6_EVNTSEL0)
 
-#define TARGET_INSN_START_EXTRA_WORDS 1
-
 #define NB_OPMASK_REGS 8
 
 /* CPU can't have 0xFFFFFFFF APIC ID, use that value to distinguish
diff --git a/target/m68k/cpu-param.h b/target/m68k/cpu-param.h
index 7afbf6d302d..256a2b5f8b2 100644
--- a/target/m68k/cpu-param.h
+++ b/target/m68k/cpu-param.h
@@ -17,4 +17,6 @@
 #define TARGET_PHYS_ADDR_SPACE_BITS 32
 #define TARGET_VIRT_ADDR_SPACE_BITS 32
 
+#define TARGET_INSN_START_EXTRA_WORDS 1
+
 #endif
diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
index ddb0f29f4a3..b6cc38f700e 100644
--- a/target/m68k/cpu.h
+++ b/target/m68k/cpu.h
@@ -76,8 +76,6 @@
 #define M68K_MAX_TTR 2
 #define TTR(type, index) ttr[((type & ACCESS_CODE) == ACCESS_CODE) * 2 + index]
 
-#define TARGET_INSN_START_EXTRA_WORDS 1
-
 typedef CPU_LDoubleU FPReg;
 
 typedef struct CPUArchState {
diff --git a/target/microblaze/cpu-param.h b/target/microblaze/cpu-param.h
index c866ec6c149..5d55e0e3c4a 100644
--- a/target/microblaze/cpu-param.h
+++ b/target/microblaze/cpu-param.h
@@ -27,6 +27,8 @@
 /* FIXME: MB uses variable pages down to 1K but linux only uses 4k.  */
 #define TARGET_PAGE_BITS 12
 
+#define TARGET_INSN_START_EXTRA_WORDS 1
+
 /* MicroBlaze is always in-order. */
 #define TCG_GUEST_DEFAULT_MO  TCG_MO_ALL
 
diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
index e44ddd53078..552e9646e95 100644
--- a/target/microblaze/cpu.h
+++ b/target/microblaze/cpu.h
@@ -231,8 +231,6 @@ typedef struct CPUArchState CPUMBState;
 #define STREAM_CONTROL   (1 << 3)
 #define STREAM_NONBLOCK  (1 << 4)
 
-#define TARGET_INSN_START_EXTRA_WORDS 1
-
 /* use-non-secure property masks */
 #define USE_NON_SECURE_M_AXI_DP_MASK 0x1
 #define USE_NON_SECURE_M_AXI_IP_MASK 0x2
diff --git a/target/mips/cpu-param.h b/target/mips/cpu-param.h
index 11b3ac0ac63..b953f993b25 100644
--- a/target/mips/cpu-param.h
+++ b/target/mips/cpu-param.h
@@ -25,6 +25,8 @@
 #define TARGET_PAGE_BITS_MIN 12
 #endif
 
+#define TARGET_INSN_START_EXTRA_WORDS 2
+
 #define TCG_GUEST_DEFAULT_MO (0)
 
 #endif
diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index f6877ece8b4..6545f0b4cd4 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -98,8 +98,6 @@ struct CPUMIPSFPUContext {
 #define FP_UNIMPLEMENTED  32
 };
 
-#define TARGET_INSN_START_EXTRA_WORDS 2
-
 typedef struct CPUMIPSMVPContext CPUMIPSMVPContext;
 struct CPUMIPSMVPContext {
     int32_t CP0_MVPControl;
diff --git a/target/openrisc/cpu-param.h b/target/openrisc/cpu-param.h
index 37627f2c394..7ea0ecb55a6 100644
--- a/target/openrisc/cpu-param.h
+++ b/target/openrisc/cpu-param.h
@@ -12,6 +12,8 @@
 #define TARGET_PHYS_ADDR_SPACE_BITS 32
 #define TARGET_VIRT_ADDR_SPACE_BITS 32
 
+#define TARGET_INSN_START_EXTRA_WORDS 1
+
 #define TCG_GUEST_DEFAULT_MO (0)
 
 #endif
diff --git a/target/openrisc/cpu.h b/target/openrisc/cpu.h
index b97d2ffdd26..ae6d6a77910 100644
--- a/target/openrisc/cpu.h
+++ b/target/openrisc/cpu.h
@@ -38,8 +38,6 @@ struct OpenRISCCPUClass {
     ResettablePhases parent_phases;
 };
 
-#define TARGET_INSN_START_EXTRA_WORDS 1
-
 enum {
     MMU_NOMMU_IDX = 0,
     MMU_SUPERVISOR_IDX = 1,
diff --git a/target/riscv/cpu-param.h b/target/riscv/cpu-param.h
index fba30e966a8..ff4ba81965a 100644
--- a/target/riscv/cpu-param.h
+++ b/target/riscv/cpu-param.h
@@ -16,6 +16,14 @@
 # define TARGET_VIRT_ADDR_SPACE_BITS 32 /* sv32 */
 #endif
 #define TARGET_PAGE_BITS 12 /* 4 KiB Pages */
+
+/*
+ * RISC-V-specific extra insn start words:
+ * 1: Original instruction opcode
+ * 2: more information about instruction
+ */
+#define TARGET_INSN_START_EXTRA_WORDS 2
+
 /*
  * The current MMU Modes are:
  *  - U mode 0b000
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 7de19b41836..b432e31fb6d 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -43,12 +43,6 @@ typedef struct CPUArchState CPURISCVState;
 # define TYPE_RISCV_CPU_BASE            TYPE_RISCV_CPU_BASE64
 #endif
 
-/*
- * RISC-V-specific extra insn start words:
- * 1: Original instruction opcode
- * 2: more information about instruction
- */
-#define TARGET_INSN_START_EXTRA_WORDS 2
 /*
  * b0: Whether a instruction always raise a store AMO or not.
  */
diff --git a/target/s390x/cpu-param.h b/target/s390x/cpu-param.h
index 5c331ec424c..a8a4377f4ff 100644
--- a/target/s390x/cpu-param.h
+++ b/target/s390x/cpu-param.h
@@ -12,6 +12,8 @@
 #define TARGET_PHYS_ADDR_SPACE_BITS 64
 #define TARGET_VIRT_ADDR_SPACE_BITS 64
 
+#define TARGET_INSN_START_EXTRA_WORDS 2
+
 /*
  * The z/Architecture has a strong memory model with some
  * store-after-load re-ordering.
diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index 5b7992deda6..057c33e0225 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -35,8 +35,6 @@
 
 #define TARGET_HAS_PRECISE_SMC
 
-#define TARGET_INSN_START_EXTRA_WORDS 2
-
 #define MMU_USER_IDX 0
 
 #define S390_MAX_CPUS 248
diff --git a/target/sh4/cpu-param.h b/target/sh4/cpu-param.h
index 2b6e11dd0ac..f328715ee86 100644
--- a/target/sh4/cpu-param.h
+++ b/target/sh4/cpu-param.h
@@ -16,4 +16,6 @@
 # define TARGET_VIRT_ADDR_SPACE_BITS 32
 #endif
 
+#define TARGET_INSN_START_EXTRA_WORDS 1
+
 #endif
diff --git a/target/sh4/cpu.h b/target/sh4/cpu.h
index d536d5d7154..3ece180ff63 100644
--- a/target/sh4/cpu.h
+++ b/target/sh4/cpu.h
@@ -125,8 +125,6 @@ typedef struct tlb_t {
 #define UTLB_SIZE 64
 #define ITLB_SIZE 4
 
-#define TARGET_INSN_START_EXTRA_WORDS 1
-
 enum sh_features {
     SH_FEATURE_SH4A = 1,
     SH_FEATURE_BCR3_AND_BCR4 = 2,
diff --git a/target/sparc/cpu-param.h b/target/sparc/cpu-param.h
index 6952ee2b826..62d47b804bb 100644
--- a/target/sparc/cpu-param.h
+++ b/target/sparc/cpu-param.h
@@ -21,6 +21,8 @@
 # define TARGET_VIRT_ADDR_SPACE_BITS 32
 #endif
 
+#define TARGET_INSN_START_EXTRA_WORDS 1
+
 /*
  * From Oracle SPARC Architecture 2015:
  *
diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
index 462bcb6c0e6..d5e8378e6c0 100644
--- a/target/sparc/cpu.h
+++ b/target/sparc/cpu.h
@@ -221,7 +221,6 @@ typedef struct trap_state {
     uint32_t tt;
 } trap_state;
 #endif
-#define TARGET_INSN_START_EXTRA_WORDS 1
 
 typedef struct sparc_def_t {
     const char *name;
-- 
2.47.1


