Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07FB5C3601E
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Apr 2025 21:13:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u05Ff-0004Jy-Gq; Wed, 02 Apr 2025 17:03:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u05FV-0004Fs-UU
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 17:03:53 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u05FN-0005wv-NY
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 17:03:45 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4393dc02b78so925945e9.3
 for <qemu-devel@nongnu.org>; Wed, 02 Apr 2025 14:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743627815; x=1744232615; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+24YNhnxmvc5nUiqHFxsW1vaBRjPX4O6CgQPfWiZ8fQ=;
 b=WvdvyXZ3htTIBJcbiEkXTGcwT/6OP2wkH2tLx3P2FIafscNjLLfJ01h6ou81OoqAAr
 uvWrZQ/rtLx13y0N773euYnV9RMeWH7cv9jyqSmKRpSVEZutQ3xDMRUk6QFQmQTZKwuU
 jBJF6w6JaRQRqoCUHTDn/so2LdIe2SZhFLdWbkpTXtO1zs7cK9gr4TIl2EdCtkcr78z1
 KHhVTI6JA0T4NwJC/s5h52RVMMIpkfbWR39CjMLADbiKqT+2OOZLefrkN5UuFvVaxtps
 RtI+9yM+/oj8YNrSzqhaRa4VuZyNTmp9aKyrskNzyMPPI0v7GUj7oh1+YtHh5gtV4+hz
 +B3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743627815; x=1744232615;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+24YNhnxmvc5nUiqHFxsW1vaBRjPX4O6CgQPfWiZ8fQ=;
 b=a4magIp7ES4kG038gWo36FRATwBT5c6M18EQC5yJidT4bpxxhISik99W7Nb1x7jCWS
 zh2MV1fGihr8xnfPdolvuPTlP++0HZzKh9aHbw/bH3MFlUlvDI3sXecKh2f7gpktWQN4
 RRIUExJX5BdQn6m3H3hIGr44OoqMcKvtydfcqtBqnFjLe6nS+sFDbMaytjFOninTCWy0
 iGWD6K8xCgqFpbBQ7UHkKSxuL/LrjRzpYcpNFTR4x6e5NcZQS/A8EGonuPxssO1znuaM
 XYmaM8CHuaLh2nWimoB91/o4nqUEReiAMXeBvWudXSpmM4cb6N/H2itXtPGnd/6wSyLw
 pahw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVFRqEqgXfJUVDWI+vvqU20GljEwZNXsT0CDrUCHLhvze8WsrpzGsWtwrrEL0IUBXC/A9pOSMA/1m2z@nongnu.org
X-Gm-Message-State: AOJu0Yxyx4kO0+e7G+V4LTA26KiJEiXZxNdQgr8FI5BFt8vqik3phFNg
 CjQ4XkjZ5BC/G++9KvXNaLblVn8g8DKQGs+fPmKMFWd+EdWprCIOcRP4Oq89/lTijCL2jwjlD0s
 u
X-Gm-Gg: ASbGnctEwu1Q8+yzb+oNLlzA9hSrwQIIYZjNGIT4JGKf9iQVGp802hHzK3QshAfv3O4
 QYoXFjJOqdj6L3xGAz2eBNTlJoKodHzAOan8IeXW1fbA7hxxlVKt3gdgKiL3eVfISGmFzjtburV
 m9UIHMFFegZFgwUceartiwF4/oCI0nIOTfZogqPiitz2Xr3GmGBKj4hNxNPdPkk3jdKVE8HqVfN
 I7iFPzb6V5uTKng7uohtniCBAuav8NVLh2KpqNYh3SPELlhniAoiG9Pd7ADSVFqsABFvwhJOLJx
 SBT9dWDZVrtcjkLhb+c2iDcqedKSt+QZ75nLtklQRm9acCiGNbHpV13E2gSFATWet2A2fFeeHX7
 ZQZL0YZr7CCdOZDr+jeE=
X-Google-Smtp-Source: AGHT+IFr3UrxhabV+LGm8Qe8wWWyOkmqniLZtIaHocS8z/1V9A/65CBBrMWILpCvQGMF5rOTecX2jw==
X-Received: by 2002:a05:600c:5941:b0:439:8c80:6af4 with SMTP id
 5b1f17b1804b1-43ea81a2f23mr58175255e9.19.1743627815356; 
 Wed, 02 Apr 2025 14:03:35 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43eb613a7edsm32563485e9.38.2025.04.02.14.03.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 02 Apr 2025 14:03:34 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PATCH-for-10.1 01/43] tcg: Declare TARGET_INSN_START_EXTRA_WORDS in
 'cpu-param.h'
Date: Wed,  2 Apr 2025 23:02:46 +0200
Message-ID: <20250402210328.52897-2-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250402210328.52897-1-philmd@linaro.org>
References: <20250402210328.52897-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/cpu-param.h        | 7 +++++++
 target/arm/cpu.h              | 6 ------
 target/hppa/cpu-param.h       | 2 ++
 target/hppa/cpu.h             | 2 --
 target/i386/cpu-param.h       | 2 ++
 target/i386/cpu.h             | 2 --
 target/m68k/cpu-param.h       | 2 ++
 target/m68k/cpu.h             | 2 --
 target/microblaze/cpu-param.h | 2 ++
 target/microblaze/cpu.h       | 2 --
 target/mips/cpu-param.h       | 2 ++
 target/mips/cpu.h             | 2 --
 target/openrisc/cpu-param.h   | 2 ++
 target/openrisc/cpu.h         | 2 --
 target/riscv/cpu-param.h      | 8 ++++++++
 target/riscv/cpu.h            | 6 ------
 target/s390x/cpu-param.h      | 2 ++
 target/s390x/cpu.h            | 2 --
 target/sh4/cpu-param.h        | 2 ++
 target/sh4/cpu.h              | 2 --
 target/sparc/cpu-param.h      | 2 ++
 target/sparc/cpu.h            | 1 -
 22 files changed, 33 insertions(+), 29 deletions(-)

diff --git a/target/arm/cpu-param.h b/target/arm/cpu-param.h
index a7ae42d17dc..2cee4be6938 100644
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
index c1a0faed3ad..3705b34285b 100644
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
index 2269d1c1064..1c8b610647b 100644
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
index 44ee263d8f1..ad14e22224e 100644
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
index 0b70e8c6ab6..39d0b9d6d73 100644
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
index 2bfa396c96d..d511f22a559 100644
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
index 8fcb1b4f5f2..99ca8d1684c 100644
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
index 20f31370bcb..d16f9a7220e 100644
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
index 19ee85ff5a0..569819bfb0b 100644
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
index 867e539b53a..167909c89bc 100644
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
index 940eda8dd12..90f64ee20cc 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -37,8 +37,6 @@
 
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
index 7752a0c2e1a..906f99ddf00 100644
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
index 734dfdb1d3d..83ac818933b 100644
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
2.47.1


