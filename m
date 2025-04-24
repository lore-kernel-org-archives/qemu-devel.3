Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4939AC369CB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 01:29:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7kyP-0008A2-5K; Wed, 23 Apr 2025 21:01:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kwo-0004zT-JK
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 21:00:16 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kwk-0005Tg-HE
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 21:00:13 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-736a7e126c7so341474b3a.3
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 18:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745456409; x=1746061209; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lhnd2huLJrsHHz0inXKOebAfdB7C56aOSUXVvrPsarQ=;
 b=aPrYj9GoJhJuO1GSAPEOvz7cSkL6FvXdRdl/XBOUT2EGwQ7gFV0FZtpGH4kN4hjEhl
 ejpCnFqPDXvTzqDP2yp3/iHkL+Fh8NLYT8cKiDkAhxmtgTORTbPaumw1tWT0nL8EvcH6
 jmfe4CexPdsx8Q+kF8V9uS7hzRnpgz0jnhUxLaQjF0h1e3idd/vBYJyPg1xPLOHEXZ2R
 vOlR2OYyuiKq9Or3OubS+1STTOmjoXYsgKlnUuGEDhuakEZssq4fl6x3jEzahrNE1s9v
 ojsgkO2Do2DxMvSj7fNQl4uIlVUUd8FDS6jMTOUJEZ9IW1+BKF2vmvXDXh5sIktjFB26
 XJkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745456409; x=1746061209;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lhnd2huLJrsHHz0inXKOebAfdB7C56aOSUXVvrPsarQ=;
 b=NGoJSPCc22Z8cKtqtcCDdj//ot4zgRLme/7My2Ph5qFwvIgAHey17vC/Y1Ijm01tqz
 QzhqPOs62EiB1xK34lzV677zV5FUwwR2WUihI+r6YG/jxf/IeWHcjqLrJwpUzZn9LSS1
 CT27AQPgWMBUGz4AesgF00NjnnZrI4tagc0mEoy6euTR+/w2ALp5MgYg5AA1Uf+X2gty
 jdOzJvXYn26oSCLsTFHSv20RMXq+vbUM8qPfL5V6sjlwL7a5tNdKdmrE8s6kqnh62Kni
 20nP7sHIhRp/DxOvkVVTEO1df9dmov0N7Z3XZtiY8ADhfbY/CQyjc83YJg1mqVLfz62K
 eyWA==
X-Gm-Message-State: AOJu0Yz3fQHer0YV7v2mK9Tnrdp7lOY57FxjJ0OJatQG94tgVbS0wVgA
 RZyOAjt10gZLRsHmr5YaaXfSyATtBZ2FMfgWYMsJjmRVgnwaQFYNGwVtnxy6EiD4/URU4j5+fp9
 p
X-Gm-Gg: ASbGncs5tQIyQOA2xpzddAgfEOJuTSjEMiqmn6e50Z6itRfv1gj6sSa9wbp7qpjoY9V
 sCtFkZ9XuL/+LU9l4SWZHyKmgX8TGsIBXUE2Mxgr/SpuUbv8CEO9yRcTzvSyBhfuR2e+kk79nn+
 zBrM8s/PIm9xEi4nO29VNjs9iygSowLmUe5vcXzICm2lZqZIR4pahav7KDsPoL+4EuiTLPK33K9
 7gor0rGRUMiOfRMw3zpE5vWldamXBX1iT7FkvZO49UyXJlah1po/zclKunIMaDQKif2pVgYQCA/
 IY3ViprkzEc4oZm/KRfhWmRXwnuAZTLKVll0dVBoEftcn6FGW9ZkFzuMcFjPRPWl+EZli+Rcwv4
 =
X-Google-Smtp-Source: AGHT+IHbYzj8twasoNiIiETYg6Rzn9A3tqTcta6fLeOSZgTGQ4lm2xcKrzmmGSABDBIh8NvhlAfx9g==
X-Received: by 2002:a05:6a21:e97:b0:1f5:8b9b:ab56 with SMTP id
 adf61e73a8af0-20444f04463mr1057135637.18.1745456408642; 
 Wed, 23 Apr 2025 18:00:08 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b15f76f45c7sm129259a12.16.2025.04.23.18.00.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 18:00:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 128/148] tcg: Declare TARGET_INSN_START_EXTRA_WORDS in
 'cpu-param.h'
Date: Wed, 23 Apr 2025 17:49:13 -0700
Message-ID: <20250424004934.598783-129-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424004934.598783-1-richard.henderson@linaro.org>
References: <20250424004934.598783-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

To avoid including the huge "cpu.h" for a simple definition,
move TARGET_INSN_START_EXTRA_WORDS to "cpu-param.h".

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/insn-start-words.h | 2 +-
 target/arm/cpu-param.h         | 7 +++++++
 target/arm/cpu.h               | 6 ------
 target/hppa/cpu-param.h        | 2 ++
 target/hppa/cpu.h              | 2 --
 target/i386/cpu-param.h        | 2 ++
 target/i386/cpu.h              | 2 --
 target/m68k/cpu-param.h        | 2 ++
 target/m68k/cpu.h              | 2 --
 target/microblaze/cpu-param.h  | 2 ++
 target/microblaze/cpu.h        | 2 --
 target/mips/cpu-param.h        | 2 ++
 target/mips/cpu.h              | 2 --
 target/openrisc/cpu-param.h    | 2 ++
 target/openrisc/cpu.h          | 2 --
 target/riscv/cpu-param.h       | 8 ++++++++
 target/riscv/cpu.h             | 6 ------
 target/s390x/cpu-param.h       | 2 ++
 target/s390x/cpu.h             | 2 --
 target/sh4/cpu-param.h         | 2 ++
 target/sh4/cpu.h               | 2 --
 target/sparc/cpu-param.h       | 2 ++
 target/sparc/cpu.h             | 1 -
 23 files changed, 34 insertions(+), 30 deletions(-)

diff --git a/include/tcg/insn-start-words.h b/include/tcg/insn-start-words.h
index 50c18bd326..c439c09f2f 100644
--- a/include/tcg/insn-start-words.h
+++ b/include/tcg/insn-start-words.h
@@ -6,7 +6,7 @@
 
 #ifndef TARGET_INSN_START_WORDS
 
-#include "cpu.h"
+#include "cpu-param.h"
 
 #ifndef TARGET_INSN_START_EXTRA_WORDS
 # define TARGET_INSN_START_WORDS 1
diff --git a/target/arm/cpu-param.h b/target/arm/cpu-param.h
index a7ae42d17d..2cee4be693 100644
--- a/target/arm/cpu-param.h
+++ b/target/arm/cpu-param.h
@@ -37,6 +37,13 @@
 # define TARGET_PAGE_BITS_LEGACY 10
 #endif /* !CONFIG_USER_ONLY */
 
+/*
+ * ARM-specific extra insn start words:
+ * 1: Conditional execution bits
+ * 2: Partial exception syndrome for data aborts
+ */
+#define TARGET_INSN_START_EXTRA_WORDS 2
+
 /* ARM processors have a weak memory model */
 #define TCG_GUEST_DEFAULT_MO      (0)
 
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index c1a0faed3a..3705b34285 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -98,12 +98,6 @@
 #define offsetofhigh32(S, M) (offsetof(S, M) + sizeof(uint32_t))
 #endif
 
-/* ARM-specific extra insn start words:
- * 1: Conditional execution bits
- * 2: Partial exception syndrome for data aborts
- */
-#define TARGET_INSN_START_EXTRA_WORDS 2
-
 /* The 2nd extra word holding syndrome info for data aborts does not use
  * the upper 6 bits nor the lower 13 bits. We mask and shift it down to
  * help the sleb128 encoder do a better job.
diff --git a/target/hppa/cpu-param.h b/target/hppa/cpu-param.h
index 7ed6b5741e..68ed84e84a 100644
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
index da5f8adcd5..acc9937240 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -48,8 +48,6 @@
 #define PRIV_KERNEL       0
 #define PRIV_USER         3
 
-#define TARGET_INSN_START_EXTRA_WORDS 2
-
 /* No need to flush MMU_ABS*_IDX  */
 #define HPPA_MMU_FLUSH_MASK                             \
         (1 << MMU_KERNEL_IDX | 1 << MMU_KERNEL_P_IDX |  \
diff --git a/target/i386/cpu-param.h b/target/i386/cpu-param.h
index b0e884c5d7..0c8efce861 100644
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
index 17ad0b644b..9866595cd0 100644
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
index 7afbf6d302..256a2b5f8b 100644
--- a/target/m68k/cpu-param.h
+++ b/target/m68k/cpu-param.h
@@ -17,4 +17,6 @@
 #define TARGET_PHYS_ADDR_SPACE_BITS 32
 #define TARGET_VIRT_ADDR_SPACE_BITS 32
 
+#define TARGET_INSN_START_EXTRA_WORDS 1
+
 #endif
diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
index 0b70e8c6ab..39d0b9d6d7 100644
--- a/target/m68k/cpu.h
+++ b/target/m68k/cpu.h
@@ -78,8 +78,6 @@
 #define M68K_MAX_TTR 2
 #define TTR(type, index) ttr[((type & ACCESS_CODE) == ACCESS_CODE) * 2 + index]
 
-#define TARGET_INSN_START_EXTRA_WORDS 1
-
 typedef CPU_LDoubleU FPReg;
 
 typedef struct CPUArchState {
diff --git a/target/microblaze/cpu-param.h b/target/microblaze/cpu-param.h
index c866ec6c14..5d55e0e3c4 100644
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
index 2bfa396c96..d511f22a55 100644
--- a/target/microblaze/cpu.h
+++ b/target/microblaze/cpu.h
@@ -233,8 +233,6 @@ typedef struct CPUArchState CPUMBState;
 #define STREAM_CONTROL   (1 << 3)
 #define STREAM_NONBLOCK  (1 << 4)
 
-#define TARGET_INSN_START_EXTRA_WORDS 1
-
 /* use-non-secure property masks */
 #define USE_NON_SECURE_M_AXI_DP_MASK 0x1
 #define USE_NON_SECURE_M_AXI_IP_MASK 0x2
diff --git a/target/mips/cpu-param.h b/target/mips/cpu-param.h
index 8fcb1b4f5f..99ca8d1684 100644
--- a/target/mips/cpu-param.h
+++ b/target/mips/cpu-param.h
@@ -20,6 +20,8 @@
 #endif
 #define TARGET_PAGE_BITS 12
 
+#define TARGET_INSN_START_EXTRA_WORDS 2
+
 #define TCG_GUEST_DEFAULT_MO (0)
 
 #endif
diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index 20f31370bc..d16f9a7220 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -100,8 +100,6 @@ struct CPUMIPSFPUContext {
 #define FP_UNIMPLEMENTED  32
 };
 
-#define TARGET_INSN_START_EXTRA_WORDS 2
-
 typedef struct CPUMIPSMVPContext CPUMIPSMVPContext;
 struct CPUMIPSMVPContext {
     int32_t CP0_MVPControl;
diff --git a/target/openrisc/cpu-param.h b/target/openrisc/cpu-param.h
index 37627f2c39..7ea0ecb55a 100644
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
index 19ee85ff5a..569819bfb0 100644
--- a/target/openrisc/cpu.h
+++ b/target/openrisc/cpu.h
@@ -40,8 +40,6 @@ struct OpenRISCCPUClass {
     ResettablePhases parent_phases;
 };
 
-#define TARGET_INSN_START_EXTRA_WORDS 1
-
 enum {
     MMU_NOMMU_IDX = 0,
     MMU_SUPERVISOR_IDX = 1,
diff --git a/target/riscv/cpu-param.h b/target/riscv/cpu-param.h
index fba30e966a..ff4ba81965 100644
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
index 867e539b53..167909c89b 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -45,12 +45,6 @@ typedef struct CPUArchState CPURISCVState;
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
index 5c331ec424..a8a4377f4f 100644
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
index 940eda8dd1..90f64ee20c 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -37,8 +37,6 @@
 
 #define TARGET_HAS_PRECISE_SMC
 
-#define TARGET_INSN_START_EXTRA_WORDS 2
-
 #define MMU_USER_IDX 0
 
 #define S390_MAX_CPUS 248
diff --git a/target/sh4/cpu-param.h b/target/sh4/cpu-param.h
index 2b6e11dd0a..f328715ee8 100644
--- a/target/sh4/cpu-param.h
+++ b/target/sh4/cpu-param.h
@@ -16,4 +16,6 @@
 # define TARGET_VIRT_ADDR_SPACE_BITS 32
 #endif
 
+#define TARGET_INSN_START_EXTRA_WORDS 1
+
 #endif
diff --git a/target/sh4/cpu.h b/target/sh4/cpu.h
index 7752a0c2e1..906f99ddf0 100644
--- a/target/sh4/cpu.h
+++ b/target/sh4/cpu.h
@@ -127,8 +127,6 @@ typedef struct tlb_t {
 #define UTLB_SIZE 64
 #define ITLB_SIZE 4
 
-#define TARGET_INSN_START_EXTRA_WORDS 1
-
 enum sh_features {
     SH_FEATURE_SH4A = 1,
     SH_FEATURE_BCR3_AND_BCR4 = 2,
diff --git a/target/sparc/cpu-param.h b/target/sparc/cpu-param.h
index 6952ee2b82..62d47b804b 100644
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
index 734dfdb1d3..83ac818933 100644
--- a/target/sparc/cpu.h
+++ b/target/sparc/cpu.h
@@ -223,7 +223,6 @@ typedef struct trap_state {
     uint32_t tt;
 } trap_state;
 #endif
-#define TARGET_INSN_START_EXTRA_WORDS 1
 
 typedef struct sparc_def_t {
     const char *name;
-- 
2.43.0


