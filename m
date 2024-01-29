Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F367EC47DB3
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 23:38:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUb70-0006mr-Fs; Mon, 29 Jan 2024 18:32:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rUb6k-0006L6-Aq
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 18:32:09 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rUb6g-0005Bk-UZ
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 18:32:05 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1d8da50bffaso7801565ad.2
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 15:32:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706571121; x=1707175921; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EOCVROUqo6BWAAqVMvgh7b7Oex6mEKUK85oHrQsmtgA=;
 b=RclNK3urAyrZ4AMb+v6ccZ00J7/DxTDRhbAmocnN7pVg4zYLktUaQZJYHoHBLYL1fF
 CMQs4TPqxLUdwgWwriX4zpS/75xv9c9OTnruMkyM16MuZF1kMYxHQTNWPPRcIHzWEIlq
 Cazcd9zF3G37+EDd56t363e1eAGcDZJvHQIKkLWIIXpBqK4lR/72w87sxOg/eKAGxWR9
 BSz6xj3cgMiF8WMPBACjtKSgj8DDQLdNPd/+kceFIzViVLfNRfhI1FMn9tFDOFKWcBEU
 UX5uMl6N2vdhL4905zOL+VjVI2+i9SL8zDOCUw2Zch3Z+39RyO5DChSt8750r2URA5IJ
 alJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706571121; x=1707175921;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EOCVROUqo6BWAAqVMvgh7b7Oex6mEKUK85oHrQsmtgA=;
 b=WEsUHrcFQuCNr8iDfohJd740YsSFZcO3EjAkk8+2GTQA3P1ld87vl0y6ZDvqFnt13k
 UKj8gh9mTkkjhOaHQOFLmqrccrMJ3WmHWK2kSrvsmvoo1p3T55RklYbxSRFMGSHyIE1f
 LnsRX0tZYQ0KJcgSFSkh774x+Y5YA1bV7MUvNforZtongk4qSw04MW7u8lhk4JF2g2M7
 JM/zzFGMW7zNIHyZvlioDc13zpmUjSKJwa/KlpI0IVLdiLS3OPVizI0St/K/sgDNpyor
 T3haKWRcXUp2UCn5pytUuAcu5PS1C5eAIQ84emoXxm3oZovCYAZWwE7pWcT5M/ByawSb
 MqRQ==
X-Gm-Message-State: AOJu0Yw1YFg1r502pEJPOIEQ/Y265ZEadyDEjMuJ266XFM7WO8DWexiP
 r+UR+wq/3bZeS5ZTHgenzJBlfnExVaq97BvIYY554nAgvoV9rwCKnS4N0ent7qi0i3krzfdGhMv
 8/sc=
X-Google-Smtp-Source: AGHT+IGzZgaS9y2Oo12mptc2a7aRYB01QlrEnbc2E/Yfkp2HZCPUpxlkI+lSR1sH2z/88okZ9YWMyA==
X-Received: by 2002:a17:903:124a:b0:1d7:5e48:7304 with SMTP id
 u10-20020a170903124a00b001d75e487304mr5414514plh.86.1706571121449; 
 Mon, 29 Jan 2024 15:32:01 -0800 (PST)
Received: from stoup.. ([103.210.27.218]) by smtp.gmail.com with ESMTPSA id
 l6-20020a170902eb0600b001d8dbb867b1sm2710591plb.179.2024.01.29.15.31.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jan 2024 15:32:01 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	anjo@rev.ng
Subject: [PATCH 32/33] include/exec: Implement cpu_mmu_index generically
Date: Tue, 30 Jan 2024 09:30:42 +1000
Message-Id: <20240129233043.34558-33-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240129233043.34558-1-richard.henderson@linaro.org>
References: <20240129233043.34558-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

For user-only mode, use MMU_USER_IDX.
For system mode, use CPUClass.mmu_index.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu-all.h    |  4 ++++
 include/exec/cpu-common.h | 19 +++++++++++++++++++
 target/alpha/cpu.h        |  5 -----
 target/arm/cpu.h          | 13 -------------
 target/avr/cpu.h          |  5 -----
 target/cris/cpu.h         |  4 ----
 target/hexagon/cpu.h      |  9 ---------
 target/hppa/cpu.h         | 10 ----------
 target/i386/cpu.h         |  6 ------
 target/loongarch/cpu.h    | 10 ----------
 target/m68k/cpu.h         |  4 ----
 target/microblaze/cpu.h   |  6 ------
 target/mips/cpu.h         |  5 -----
 target/nios2/cpu.h        |  6 ------
 target/openrisc/cpu.h     |  6 ------
 target/ppc/cpu.h          |  5 -----
 target/riscv/cpu.h        |  2 --
 target/rx/cpu.h           |  5 -----
 target/s390x/cpu.h        |  2 --
 target/sh4/cpu.h          |  6 ------
 target/sparc/cpu.h        |  6 ------
 target/tricore/cpu.h      |  5 -----
 target/xtensa/cpu.h       |  5 -----
 target/hppa/cpu.c         |  2 +-
 target/i386/cpu.c         |  2 +-
 target/loongarch/cpu.c    |  2 +-
 target/microblaze/cpu.c   |  2 +-
 target/nios2/cpu.c        |  2 +-
 target/openrisc/cpu.c     |  2 +-
 target/sh4/cpu.c          |  2 +-
 target/sparc/cpu.c        |  2 +-
 31 files changed, 31 insertions(+), 133 deletions(-)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index 8501a33dbf..80c0d0699b 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -311,6 +311,10 @@ CPUArchState *cpu_copy(CPUArchState *env);
 #define TLB_MMIO            (1 << (TARGET_PAGE_BITS_MIN - 2))
 #define TLB_WATCHPOINT      0
 
+static inline int cpu_mmu_index(CPUArchState *env, bool ifetch)
+{
+    return MMU_USER_IDX;
+}
 #else
 
 /*
diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index dcbd5f5783..5a4a36a7d8 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -262,4 +262,23 @@ static inline CPUState *env_cpu(CPUArchState *env)
     return (void *)env - sizeof(CPUState);
 }
 
+#ifndef CONFIG_USER_ONLY
+/**
+ * cpu_mmu_index:
+ * @env: The cpu environment
+ * @ifetch: True for code access, false for data access.
+ *
+ * Return the core mmu index for the current translation regime.
+ * This function is used by generic TCG code paths.
+ *
+ * The user-only version of this function is inline in cpu-all.h,
+ * where it always returns MMU_USER_IDX.
+ */
+static inline int cpu_mmu_index(CPUArchState *env, bool ifetch)
+{
+    CPUState *cs = env_cpu(env);
+    return cs->cc->mmu_index(cs, ifetch);
+}
+#endif /* !CONFIG_USER_ONLY */
+
 #endif /* CPU_COMMON_H */
diff --git a/target/alpha/cpu.h b/target/alpha/cpu.h
index 3beff2738a..7188a409a0 100644
--- a/target/alpha/cpu.h
+++ b/target/alpha/cpu.h
@@ -398,11 +398,6 @@ static inline int alpha_env_mmu_index(CPUAlphaState *env)
     return ret;
 }
 
-static inline int cpu_mmu_index(CPUAlphaState *env, bool ifetch)
-{
-    return alpha_env_mmu_index(env);
-}
-
 enum {
     IR_V0   = 0,
     IR_T0   = 1,
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index d3477b1601..63f31e0d98 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3240,19 +3240,6 @@ FIELD(TBFLAG_A64, NV2_MEM_BE, 36, 1)
 #define EX_TBFLAG_M32(IN, WHICH)   FIELD_EX32(IN.flags2, TBFLAG_M32, WHICH)
 #define EX_TBFLAG_AM32(IN, WHICH)  FIELD_EX32(IN.flags2, TBFLAG_AM32, WHICH)
 
-/**
- * cpu_mmu_index:
- * @env: The cpu environment
- * @ifetch: True for code access, false for data access.
- *
- * Return the core mmu index for the current translation regime.
- * This function is used by generic TCG code paths.
- */
-static inline int cpu_mmu_index(CPUARMState *env, bool ifetch)
-{
-    return EX_TBFLAG_ANY(env->hflags, MMUIDX);
-}
-
 /**
  * sve_vq
  * @env: the cpu context
diff --git a/target/avr/cpu.h b/target/avr/cpu.h
index 4595c6bb18..d185d20dcb 100644
--- a/target/avr/cpu.h
+++ b/target/avr/cpu.h
@@ -184,11 +184,6 @@ static inline void set_avr_feature(CPUAVRState *env, int feature)
     env->features |= (1U << feature);
 }
 
-static inline int cpu_mmu_index(CPUAVRState *env, bool ifetch)
-{
-    return ifetch ? MMU_CODE_IDX : MMU_DATA_IDX;
-}
-
 void avr_cpu_tcg_init(void);
 
 int cpu_avr_exec(CPUState *cpu);
diff --git a/target/cris/cpu.h b/target/cris/cpu.h
index d830dcac5b..3904e5448c 100644
--- a/target/cris/cpu.h
+++ b/target/cris/cpu.h
@@ -260,10 +260,6 @@ enum {
 
 /* MMU modes definitions */
 #define MMU_USER_IDX 1
-static inline int cpu_mmu_index (CPUCRISState *env, bool ifetch)
-{
-	return !!(env->pregs[PR_CCS] & U_FLAG);
-}
 
 /* Support function regs.  */
 #define SFR_RW_GC_CFG      0][0
diff --git a/target/hexagon/cpu.h b/target/hexagon/cpu.h
index 5c11ae3445..3eef58fe8f 100644
--- a/target/hexagon/cpu.h
+++ b/target/hexagon/cpu.h
@@ -146,15 +146,6 @@ static inline void cpu_get_tb_cpu_state(CPUHexagonState *env, vaddr *pc,
     *flags = hex_flags;
 }
 
-static inline int cpu_mmu_index(CPUHexagonState *env, bool ifetch)
-{
-#ifdef CONFIG_USER_ONLY
-    return MMU_USER_IDX;
-#else
-#error System mode not supported on Hexagon yet
-#endif
-}
-
 typedef HexagonCPU ArchCPU;
 
 void hexagon_translate_init(void);
diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index 04439f247d..7a181e8f33 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -281,16 +281,6 @@ static inline int HPPA_BTLB_ENTRIES(CPUHPPAState *env)
     return hppa_is_pa20(env) ? 0 : PA10_BTLB_FIXED + PA10_BTLB_VARIABLE;
 }
 
-int hppa_cpu_mmu_index(CPUState *cs, bool ifetch);
-static inline int cpu_mmu_index(CPUHPPAState *env, bool ifetch)
-{
-#ifdef CONFIG_USER_ONLY
-    return MMU_USER_IDX;
-#else
-    return hppa_cpu_mmu_index(env_cpu(env), ifetch);
-#endif
-}
-
 void hppa_translate_init(void);
 
 #define CPU_RESOLVING_TYPE TYPE_HPPA_CPU
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 62bdb02378..6a5b180ccb 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2315,12 +2315,6 @@ static inline int cpu_mmu_index_kernel(CPUX86State *env)
 #include "hw/i386/apic.h"
 #endif
 
-int x86_cpu_mmu_index(CPUState *cs, bool ifetch);
-static inline int cpu_mmu_index(CPUX86State *env, bool ifetch)
-{
-    return x86_cpu_mmu_index(env_cpu(env), ifetch);
-}
-
 static inline void cpu_get_tb_cpu_state(CPUX86State *env, vaddr *pc,
                                         uint64_t *cs_base, uint32_t *flags)
 {
diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index 47fd110e81..ec37579fd6 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -408,16 +408,6 @@ struct LoongArchCPUClass {
 #define MMU_USER_IDX     MMU_PLV_USER
 #define MMU_DA_IDX       4
 
-int loongarch_cpu_mmu_index(CPUState *cs, bool ifetch);
-static inline int cpu_mmu_index(CPULoongArchState *env, bool ifetch)
-{
-#ifdef CONFIG_USER_ONLY
-    return MMU_USER_IDX;
-#else
-    return loongarch_cpu_mmu_index(env_cpu(env), ifetch);
-#endif
-}
-
 static inline bool is_la64(CPULoongArchState *env)
 {
     return FIELD_EX32(env->cpucfg[1], CPUCFG1, ARCH) == CPUCFG1_ARCH_LA64;
diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
index d13427b0fe..aca4aa610b 100644
--- a/target/m68k/cpu.h
+++ b/target/m68k/cpu.h
@@ -577,10 +577,6 @@ enum {
 /* MMU modes definitions */
 #define MMU_KERNEL_IDX 0
 #define MMU_USER_IDX 1
-static inline int cpu_mmu_index (CPUM68KState *env, bool ifetch)
-{
-    return (env->sr & SR_S) == 0 ? 1 : 0;
-}
 
 bool m68k_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
                        MMUAccessType access_type, int mmu_idx,
diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
index 90ab796de9..446af5dd4c 100644
--- a/target/microblaze/cpu.h
+++ b/target/microblaze/cpu.h
@@ -434,12 +434,6 @@ void mb_cpu_transaction_failed(CPUState *cs, hwaddr physaddr, vaddr addr,
                                MemTxResult response, uintptr_t retaddr);
 #endif
 
-int mb_cpu_mmu_index(CPUState *cs, bool ifetch);
-static inline int cpu_mmu_index(CPUMBState *env, bool ifetch)
-{
-    return mb_cpu_mmu_index(env_cpu(env), ifetch);
-}
-
 #ifndef CONFIG_USER_ONLY
 extern const VMStateDescription vmstate_mb_cpu;
 #endif
diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index 4c15e76781..ef26fe03c7 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -1260,11 +1260,6 @@ static inline int mips_env_mmu_index(CPUMIPSState *env)
     return hflags_mmu_index(env->hflags);
 }
 
-static inline int cpu_mmu_index(CPUMIPSState *env, bool ifetch)
-{
-    return mips_env_mmu_index(env);
-}
-
 #include "exec/cpu-all.h"
 
 /* Exceptions */
diff --git a/target/nios2/cpu.h b/target/nios2/cpu.h
index 9965ff74c1..4164a3432e 100644
--- a/target/nios2/cpu.h
+++ b/target/nios2/cpu.h
@@ -286,12 +286,6 @@ FIELD(TBFLAGS, CRS0, 0, 1)  /* Set if CRS == 0. */
 FIELD(TBFLAGS, U, 1, 1)     /* Overlaps CR_STATUS_U */
 FIELD(TBFLAGS, R0_0, 2, 1)  /* Set if R0 == 0. */
 
-int nios2_cpu_mmu_index(CPUState *cs, bool ifetch);
-static inline int cpu_mmu_index(CPUNios2State *env, bool ifetch)
-{
-    return nios2_cpu_mmu_index(env_cpu(env), ifetch);
-}
-
 static inline void cpu_get_tb_cpu_state(CPUNios2State *env, vaddr *pc,
                                         uint64_t *cs_base, uint32_t *flags)
 {
diff --git a/target/openrisc/cpu.h b/target/openrisc/cpu.h
index 7dbed8d8be..b1b7db5cbd 100644
--- a/target/openrisc/cpu.h
+++ b/target/openrisc/cpu.h
@@ -361,12 +361,6 @@ static inline void cpu_get_tb_cpu_state(CPUOpenRISCState *env, vaddr *pc,
            | (env->sr & (SR_SM | SR_DME | SR_IME | SR_OVE));
 }
 
-int openrisc_cpu_mmu_index(CPUState *cs, bool ifetch);
-static inline int cpu_mmu_index(CPUOpenRISCState *env, bool ifetch)
-{
-    return openrisc_cpu_mmu_index(env_cpu(env), ifetch);
-}
-
 static inline uint32_t cpu_get_sr(const CPUOpenRISCState *env)
 {
     return (env->sr
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 5f4f52aec5..a44de22ca4 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1633,11 +1633,6 @@ static inline int ppc_env_mmu_index(CPUPPCState *env, bool ifetch)
 #endif
 }
 
-static inline int cpu_mmu_index(CPUPPCState *env, bool ifetch)
-{
-    return ppc_env_mmu_index(env, ifetch);
-}
-
 /* Compatibility modes */
 #if defined(TARGET_PPC64)
 bool ppc_check_compat(PowerPCCPU *cpu, uint32_t compat_pvr,
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 9c825c7b51..f63ee9cc58 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -507,8 +507,6 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
                         bool probe, uintptr_t retaddr);
 char *riscv_isa_string(RISCVCPU *cpu);
 
-#define cpu_mmu_index riscv_env_mmu_index
-
 #ifndef CONFIG_USER_ONLY
 void riscv_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
                                      vaddr addr, unsigned size,
diff --git a/target/rx/cpu.h b/target/rx/cpu.h
index 65f9cd2d0a..c53593d7aa 100644
--- a/target/rx/cpu.h
+++ b/target/rx/cpu.h
@@ -158,11 +158,6 @@ static inline void cpu_get_tb_cpu_state(CPURXState *env, vaddr *pc,
     *flags = FIELD_DP32(*flags, PSW, U, env->psw_u);
 }
 
-static inline int cpu_mmu_index(CPURXState *env, bool ifetch)
-{
-    return 0;
-}
-
 static inline uint32_t rx_cpu_pack_psw(CPURXState *env)
 {
     uint32_t psw = 0;
diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index f0fed5d6ad..d37a49b4d9 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -412,8 +412,6 @@ static inline int s390x_env_mmu_index(CPUS390XState *env, bool ifetch)
 #endif
 }
 
-#define cpu_mmu_index s390x_env_mmu_index
-
 #ifdef CONFIG_TCG
 
 #include "tcg/tcg_s390x.h"
diff --git a/target/sh4/cpu.h b/target/sh4/cpu.h
index 9c5e2b349e..9211da6bde 100644
--- a/target/sh4/cpu.h
+++ b/target/sh4/cpu.h
@@ -370,12 +370,6 @@ static inline void cpu_write_sr(CPUSH4State *env, target_ulong sr)
     env->sr = sr & ~((1u << SR_M) | (1u << SR_Q) | (1u << SR_T));
 }
 
-int sh4_cpu_mmu_index(CPUState *cs, bool ifetch);
-static inline int cpu_mmu_index(CPUSH4State *env, bool ifetch)
-{
-    return sh4_cpu_mmu_index(env_cpu(env), ifetch);
-}
-
 static inline void cpu_get_tb_cpu_state(CPUSH4State *env, vaddr *pc,
                                         uint64_t *cs_base, uint32_t *flags)
 {
diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
index 92c58c92c1..51856152fa 100644
--- a/target/sparc/cpu.h
+++ b/target/sparc/cpu.h
@@ -749,12 +749,6 @@ trap_state* cpu_tsptr(CPUSPARCState* env);
 #define TB_FLAG_HYPER        (1 << 7)
 #define TB_FLAG_ASI_SHIFT    24
 
-int sparc_cpu_mmu_index(CPUState *cs, bool ifetch);
-static inline int cpu_mmu_index(CPUSPARCState *env, bool ifetch)
-{
-    return sparc_cpu_mmu_index(env_cpu(env), ifetch);
-}
-
 static inline void cpu_get_tb_cpu_state(CPUSPARCState *env, vaddr *pc,
                                         uint64_t *cs_base, uint32_t *pflags)
 {
diff --git a/target/tricore/cpu.h b/target/tricore/cpu.h
index 2d4446cea5..220af69fc2 100644
--- a/target/tricore/cpu.h
+++ b/target/tricore/cpu.h
@@ -246,11 +246,6 @@ void fpu_set_state(CPUTriCoreState *env);
 
 #define MMU_USER_IDX 2
 
-static inline int cpu_mmu_index(CPUTriCoreState *env, bool ifetch)
-{
-    return 0;
-}
-
 #include "exec/cpu-all.h"
 
 FIELD(TB_FLAGS, PRIV, 0, 2)
diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
index 4b033ee924..6b8d0636d2 100644
--- a/target/xtensa/cpu.h
+++ b/target/xtensa/cpu.h
@@ -713,11 +713,6 @@ static inline uint32_t xtensa_replicate_windowstart(CPUXtensaState *env)
 /* MMU modes definitions */
 #define MMU_USER_IDX 3
 
-static inline int cpu_mmu_index(CPUXtensaState *env, bool ifetch)
-{
-    return xtensa_get_cring(env);
-}
-
 #define XTENSA_TBFLAG_RING_MASK 0x3
 #define XTENSA_TBFLAG_EXCM 0x4
 #define XTENSA_TBFLAG_LITBASE 0x8
diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index fbb37e541e..5f87c1b12a 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -94,7 +94,7 @@ static bool hppa_cpu_has_work(CPUState *cs)
     return cs->interrupt_request & (CPU_INTERRUPT_HARD | CPU_INTERRUPT_NMI);
 }
 
-int hppa_cpu_mmu_index(CPUState *cs, bool ifetch)
+static int hppa_cpu_mmu_index(CPUState *cs, bool ifetch)
 {
     CPUHPPAState *env = cpu_env(cs);
 
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 280bcb7d00..ef46755a50 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -7720,7 +7720,7 @@ static bool x86_cpu_has_work(CPUState *cs)
     return x86_cpu_pending_interrupt(cs, cs->interrupt_request) != 0;
 }
 
-int x86_cpu_mmu_index(CPUState *cs, bool ifetch)
+static int x86_cpu_mmu_index(CPUState *cs, bool ifetch)
 {
     CPUX86State *env = cpu_env(cs);
 
diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index 139acfe373..b08d0dc5de 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -375,7 +375,7 @@ static bool loongarch_cpu_has_work(CPUState *cs)
 #endif
 }
 
-int loongarch_cpu_mmu_index(CPUState *cs, bool ifetch)
+static int loongarch_cpu_mmu_index(CPUState *cs, bool ifetch)
 {
     CPULoongArchState *env = cpu_env(cs);
 
diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index 6dad11905b..2002231a6b 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -118,7 +118,7 @@ static bool mb_cpu_has_work(CPUState *cs)
     return cs->interrupt_request & (CPU_INTERRUPT_HARD | CPU_INTERRUPT_NMI);
 }
 
-int mb_cpu_mmu_index(CPUState *cs, bool ifetch)
+static int mb_cpu_mmu_index(CPUState *cs, bool ifetch)
 {
     CPUMBState *env = cpu_env(cs);
     MicroBlazeCPU *cpu = env_archcpu(env);
diff --git a/target/nios2/cpu.c b/target/nios2/cpu.c
index e42885997e..0760bf6b38 100644
--- a/target/nios2/cpu.c
+++ b/target/nios2/cpu.c
@@ -57,7 +57,7 @@ static bool nios2_cpu_has_work(CPUState *cs)
     return cs->interrupt_request & CPU_INTERRUPT_HARD;
 }
 
-int nios2_cpu_mmu_index(CPUState *cs, bool ifetch)
+static int nios2_cpu_mmu_index(CPUState *cs, bool ifetch)
 {
     return (cpu_env(cs)->ctrl[CR_STATUS] & CR_STATUS_U
             ? MMU_USER_IDX : MMU_SUPERVISOR_IDX);
diff --git a/target/openrisc/cpu.c b/target/openrisc/cpu.c
index 8670152c84..a3cb80ca34 100644
--- a/target/openrisc/cpu.c
+++ b/target/openrisc/cpu.c
@@ -68,7 +68,7 @@ static bool openrisc_cpu_has_work(CPUState *cs)
                                     CPU_INTERRUPT_TIMER);
 }
 
-int openrisc_cpu_mmu_index(CPUState *cs, bool ifetch)
+static int openrisc_cpu_mmu_index(CPUState *cs, bool ifetch)
 {
     CPUOpenRISCState *env = cpu_env(cs);
 
diff --git a/target/sh4/cpu.c b/target/sh4/cpu.c
index 6fead5655f..2031168dc6 100644
--- a/target/sh4/cpu.c
+++ b/target/sh4/cpu.c
@@ -89,7 +89,7 @@ static bool superh_cpu_has_work(CPUState *cs)
     return cs->interrupt_request & CPU_INTERRUPT_HARD;
 }
 
-int sh4_cpu_mmu_index(CPUState *cs, bool ifetch)
+static int sh4_cpu_mmu_index(CPUState *cs, bool ifetch)
 {
     CPUSH4State *env = cpu_env(cs);
 
diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index 7a3b815737..afa62723fe 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -718,7 +718,7 @@ static bool sparc_cpu_has_work(CPUState *cs)
            cpu_interrupts_enabled(env);
 }
 
-int sparc_cpu_mmu_index(CPUState *cs, bool ifetch)
+static int sparc_cpu_mmu_index(CPUState *cs, bool ifetch)
 {
     CPUSPARCState *env = cpu_env(cs);
 
-- 
2.34.1


