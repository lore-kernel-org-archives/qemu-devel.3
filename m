Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0478C369D1
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 19:52:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7JSD-000401-FE; Tue, 22 Apr 2025 15:38:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JP8-0005Yq-LQ
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:35:41 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JP5-00077M-Oh
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:35:38 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-22c33e5013aso64895565ad.0
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 12:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745350534; x=1745955334; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hRZkBdsvSz1fHYP/nJZ2O75TrqrVsPxfpiF58rzto7E=;
 b=q4SpUqc2fwLC+qjAPyjRBGTH1iRfjNpCK7S7L3JX0KeKxhWXr1tkBrjaZ4bBF9LuSh
 +vzDWczcxxEJDvFC+tR8Meqk5fdL6XZEj0Yrhn80fkTiUJ38Lu854t9KCqkBMUoDXxtb
 8bafFOPxvcjps492ilY4tvtuFaQzz0588krVZpcCFOcx1xJj/OzJ5u5U6MgadawfkPS2
 HwYSJpdkpeGil+4ajx7VtFb7t1HPiPJPQCUYpf/BChLfhd9JfPD2WrYO5hpN/ee9bDUS
 LosV5qXmTLSrqMqW3GASX37gyjdFTsRFRP7wfTfKHDrSZ84I7fDJObG6ELSsHXOu0yuQ
 lwqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745350534; x=1745955334;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hRZkBdsvSz1fHYP/nJZ2O75TrqrVsPxfpiF58rzto7E=;
 b=qN1X854KKjiyRbQouUvEL4jksr0k8zhEfm70sZbOs/+qM2UQ3bWbYS4oVylmyRdFfq
 B2QOOxf+sacDgrGa+fUeP/wAai+k55y8qvH3qmua1m9+dcwRsxXzLbeBtkDpNxNALl/1
 9za4JowexKNZ2Msx6BhGILyXdMmQTKD7vE6HfcU7AOdywo72UmV59rzoW5qIpKJCAW3C
 iSRCE4PweylfYWjDbxnzqaKa4+bXp8O+vlhlm04iDwHCbTXMUMr+KRG36B68jsuEuExT
 XabCN/Xq1sxR9pFlJpAIMX51T+YmlzNcgYg1gfZyDK5r3y+ypP8ERs6QFa0ZdIIWK1cJ
 kQpg==
X-Gm-Message-State: AOJu0YwzEZMoijCTM4xZBioJuRlVqVKDKei9iC3W9pY5ayBw1Q0Pn5E4
 ZmvGOlvMjT3ltoPXzQL027NgghHqBZ/965+qaUQcen7BQ/5MSy9tnQW3G3CgKfVBW336bYmDvHw
 k
X-Gm-Gg: ASbGncuUlldHAMyLR78u6TTnZ3h3pDefPccUT3hsDiLxlVFU3goefADgbRvvk6Qt+AE
 8zZJ9bPUVFmA5xSBYaWqouR5vmabNWH108KOLyz7NzGV37DV1BluPXODq0I8BpAOUV7VLxA7vcc
 yYiK4VQ/qDc7b5VvM4fKbcWNRvZ1QfVBNZJCg3rOdC8NGq/NzvZraoc31SZ6i3q+byG0xs4rvds
 CDdGyMLFOFW9bfrOVw0zZzKZCMGTt/z6EJVmTZKXhMwis2JztSk5CAp7mPUV2W1CHj+opatI5Q2
 /7Zq83rY0FVwrILs0hZ62cqLoDdJTOsg8TeQMITKbk7kXuRqX7Xie548Fy8evXMtek3JMj8dZ+x
 EERhIXxldMQ==
X-Google-Smtp-Source: AGHT+IFa0S2ZtswcJgWsRJX12L2KEtIeDFPC3PbKCWI5hHN73QF2K9T39fbFTTjMb5G1Fe5eW3+BZQ==
X-Received: by 2002:a17:902:e5c5:b0:224:c7c:7146 with SMTP id
 d9443c01a7336-22c53573e54mr178385205ad.6.1745350534114; 
 Tue, 22 Apr 2025 12:35:34 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50fdf1f1sm88996795ad.237.2025.04.22.12.35.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Apr 2025 12:35:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 112/147] exec/cpu-all: remove this header
Date: Tue, 22 Apr 2025 12:27:41 -0700
Message-ID: <20250422192819.302784-113-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250422192819.302784-1-richard.henderson@linaro.org>
References: <20250422192819.302784-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250325045915.994760-16-pierrick.bouvier@linaro.org>
---
 include/exec/cpu-all.h  | 25 -------------------------
 include/hw/core/cpu.h   |  2 +-
 include/qemu/bswap.h    |  2 +-
 target/alpha/cpu.h      |  2 --
 target/arm/cpu.h        |  2 --
 target/avr/cpu.h        |  2 --
 target/hexagon/cpu.h    |  2 --
 target/hppa/cpu.h       |  2 --
 target/i386/cpu.h       |  1 -
 target/loongarch/cpu.h  |  2 --
 target/m68k/cpu.h       |  2 --
 target/microblaze/cpu.h |  2 --
 target/mips/cpu.h       |  2 --
 target/openrisc/cpu.h   |  2 --
 target/ppc/cpu.h        |  2 --
 target/riscv/cpu.h      |  2 --
 target/rx/cpu.h         |  2 --
 target/s390x/cpu.h      |  2 --
 target/sh4/cpu.h        |  2 --
 target/sparc/cpu.h      |  2 --
 target/tricore/cpu.h    |  2 --
 target/xtensa/cpu.h     |  2 --
 accel/tcg/cpu-exec.c    |  1 -
 hw/hyperv/hyperv.c      |  1 -
 semihosting/uaccess.c   |  1 -
 tcg/tcg-op-ldst.c       |  2 +-
 26 files changed, 3 insertions(+), 68 deletions(-)
 delete mode 100644 include/exec/cpu-all.h

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
deleted file mode 100644
index 5122fdbee3..0000000000
--- a/include/exec/cpu-all.h
+++ /dev/null
@@ -1,25 +0,0 @@
-/*
- * defines common to all virtual CPUs
- *
- *  Copyright (c) 2003 Fabrice Bellard
- *
- * This library is free software; you can redistribute it and/or
- * modify it under the terms of the GNU Lesser General Public
- * License as published by the Free Software Foundation; either
- * version 2.1 of the License, or (at your option) any later version.
- *
- * This library is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * Lesser General Public License for more details.
- *
- * You should have received a copy of the GNU Lesser General Public
- * License along with this library; if not, see <http://www.gnu.org/licenses/>.
- */
-#ifndef CPU_ALL_H
-#define CPU_ALL_H
-
-#include "hw/core/cpu.h"
-#include "exec/cpu-defs.h"
-
-#endif /* CPU_ALL_H */
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 28bd27b8ed..10b6b25b34 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -579,7 +579,7 @@ QEMU_BUILD_BUG_ON(offsetof(CPUState, neg) !=
 
 static inline CPUArchState *cpu_env(CPUState *cpu)
 {
-    /* We validate that CPUArchState follows CPUState in cpu-all.h. */
+    /* We validate that CPUArchState follows CPUState in cpu-target.c */
     return (CPUArchState *)(cpu + 1);
 }
 
diff --git a/include/qemu/bswap.h b/include/qemu/bswap.h
index b915835bea..8782056ae4 100644
--- a/include/qemu/bswap.h
+++ b/include/qemu/bswap.h
@@ -206,7 +206,7 @@ CPU_CONVERT(le, 64, uint64_t)
  * (except for byte accesses, which have no endian infix).
  *
  * The target endian accessors are obviously only available to source
- * files which are built per-target; they are defined in cpu-all.h.
+ * files which are built per-target; they are defined in system/memory.h.
  *
  * In all cases these functions take a host pointer.
  * For accessors that take a guest address rather than a
diff --git a/target/alpha/cpu.h b/target/alpha/cpu.h
index fb1d63527e..849f673489 100644
--- a/target/alpha/cpu.h
+++ b/target/alpha/cpu.h
@@ -289,8 +289,6 @@ void alpha_cpu_dump_state(CPUState *cs, FILE *f, int flags);
 int alpha_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
 int alpha_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
 
-#include "exec/cpu-all.h"
-
 enum {
     FEATURE_ASN    = 0x00000001,
     FEATURE_SPS    = 0x00000002,
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index ee92476814..ea9956395c 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2968,8 +2968,6 @@ static inline bool arm_sctlr_b(CPUARMState *env)
 
 uint64_t arm_sctlr(CPUARMState *env, int el);
 
-#include "exec/cpu-all.h"
-
 /*
  * We have more than 32-bits worth of state per TB, so we split the data
  * between tb->flags and tb->cs_base, which is otherwise unused for ARM.
diff --git a/target/avr/cpu.h b/target/avr/cpu.h
index a0fb40141a..d6666175a9 100644
--- a/target/avr/cpu.h
+++ b/target/avr/cpu.h
@@ -259,6 +259,4 @@ bool avr_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
 extern const MemoryRegionOps avr_cpu_reg1;
 extern const MemoryRegionOps avr_cpu_reg2;
 
-#include "exec/cpu-all.h"
-
 #endif /* QEMU_AVR_CPU_H */
diff --git a/target/hexagon/cpu.h b/target/hexagon/cpu.h
index e4fc35b112..c065fa8ddc 100644
--- a/target/hexagon/cpu.h
+++ b/target/hexagon/cpu.h
@@ -158,6 +158,4 @@ void hexagon_translate_init(void);
 void hexagon_translate_code(CPUState *cs, TranslationBlock *tb,
                             int *max_insns, vaddr pc, void *host_pc);
 
-#include "exec/cpu-all.h"
-
 #endif /* HEXAGON_CPU_H */
diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index 4e72ab025b..da5f8adcd5 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -306,8 +306,6 @@ struct HPPACPUClass {
     ResettablePhases parent_phases;
 };
 
-#include "exec/cpu-all.h"
-
 static inline bool hppa_is_pa20(const CPUHPPAState *env)
 {
     return env->is_pa20;
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 1f30129e40..b5d68c796b 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2604,7 +2604,6 @@ static inline bool is_mmu_index_32(int mmu_index)
 #define CC_SRC2 (env->cc_src2)
 #define CC_OP   (env->cc_op)
 
-#include "exec/cpu-all.h"
 #include "svm.h"
 
 #if !defined(CONFIG_USER_ONLY)
diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index 69117c602a..ad8b0ed235 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -504,8 +504,6 @@ static inline void cpu_get_tb_cpu_state(CPULoongArchState *env, vaddr *pc,
     *flags |= is_va32(env) * HW_FLAGS_VA32;
 }
 
-#include "exec/cpu-all.h"
-
 #define CPU_RESOLVING_TYPE TYPE_LOONGARCH_CPU
 
 void loongarch_cpu_post_init(Object *obj);
diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
index 5347fbe397..0b70e8c6ab 100644
--- a/target/m68k/cpu.h
+++ b/target/m68k/cpu.h
@@ -596,8 +596,6 @@ void m68k_cpu_transaction_failed(CPUState *cs, hwaddr physaddr, vaddr addr,
                                  MemTxResult response, uintptr_t retaddr);
 #endif
 
-#include "exec/cpu-all.h"
-
 /* TB flags */
 #define TB_FLAGS_MACSR          0x0f
 #define TB_FLAGS_MSR_S_BIT      13
diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
index 90d820b90c..2bfa396c96 100644
--- a/target/microblaze/cpu.h
+++ b/target/microblaze/cpu.h
@@ -411,8 +411,6 @@ void mb_translate_code(CPUState *cs, TranslationBlock *tb,
 #define MMU_USER_IDX    2
 /* See NB_MMU_MODES in cpu-defs.h. */
 
-#include "exec/cpu-all.h"
-
 /* Ensure there is no overlap between the two masks. */
 QEMU_BUILD_BUG_ON(MSR_TB_MASK & IFLAGS_TB_MASK);
 
diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index 79f8041ced..20f31370bc 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -1258,8 +1258,6 @@ static inline int mips_env_mmu_index(CPUMIPSState *env)
     return hflags_mmu_index(env->hflags);
 }
 
-#include "exec/cpu-all.h"
-
 /* Exceptions */
 enum {
     EXCP_NONE          = -1,
diff --git a/target/openrisc/cpu.h b/target/openrisc/cpu.h
index f16a070ef6..19ee85ff5a 100644
--- a/target/openrisc/cpu.h
+++ b/target/openrisc/cpu.h
@@ -334,8 +334,6 @@ void cpu_openrisc_count_stop(OpenRISCCPU *cpu);
 
 #define CPU_RESOLVING_TYPE TYPE_OPENRISC_CPU
 
-#include "exec/cpu-all.h"
-
 #define TB_FLAGS_SM    SR_SM
 #define TB_FLAGS_DME   SR_DME
 #define TB_FLAGS_IME   SR_IME
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index aa5df47bda..3c02f7f7d4 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1704,8 +1704,6 @@ void ppc_compat_add_property(Object *obj, const char *name,
                              uint32_t *compat_pvr, const char *basedesc);
 #endif /* defined(TARGET_PPC64) */
 
-#include "exec/cpu-all.h"
-
 /*****************************************************************************/
 /* CRF definitions */
 #define CRF_LT_BIT    3
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 14a6779b4c..867e539b53 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -634,8 +634,6 @@ G_NORETURN void riscv_raise_exception(CPURISCVState *env,
 target_ulong riscv_cpu_get_fflags(CPURISCVState *env);
 void riscv_cpu_set_fflags(CPURISCVState *env, target_ulong);
 
-#include "exec/cpu-all.h"
-
 FIELD(TB_FLAGS, MEM_IDX, 0, 3)
 FIELD(TB_FLAGS, FS, 3, 2)
 /* Vector flags */
diff --git a/target/rx/cpu.h b/target/rx/cpu.h
index e2ec78835e..5c19c83219 100644
--- a/target/rx/cpu.h
+++ b/target/rx/cpu.h
@@ -147,8 +147,6 @@ void rx_translate_code(CPUState *cs, TranslationBlock *tb,
                        int *max_insns, vaddr pc, void *host_pc);
 void rx_cpu_unpack_psw(CPURXState *env, uint32_t psw, int rte);
 
-#include "exec/cpu-all.h"
-
 #define CPU_INTERRUPT_SOFT CPU_INTERRUPT_TGT_INT_0
 #define CPU_INTERRUPT_FIR  CPU_INTERRUPT_TGT_INT_1
 
diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index 83d01d5c4e..940eda8dd1 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -948,6 +948,4 @@ uint64_t s390_cpu_get_psw_mask(CPUS390XState *env);
 /* outside of target/s390x/ */
 S390CPU *s390_cpu_addr2state(uint16_t cpu_addr);
 
-#include "exec/cpu-all.h"
-
 #endif
diff --git a/target/sh4/cpu.h b/target/sh4/cpu.h
index 7581f5eecb..7752a0c2e1 100644
--- a/target/sh4/cpu.h
+++ b/target/sh4/cpu.h
@@ -288,8 +288,6 @@ void cpu_load_tlb(CPUSH4State * env);
 /* MMU modes definitions */
 #define MMU_USER_IDX 1
 
-#include "exec/cpu-all.h"
-
 /* MMU control register */
 #define MMUCR    0x1F000010
 #define MMUCR_AT (1<<0)
diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
index b87351a666..734dfdb1d3 100644
--- a/target/sparc/cpu.h
+++ b/target/sparc/cpu.h
@@ -729,8 +729,6 @@ static inline int cpu_pil_allowed(CPUSPARCState *env1, int pil)
 #endif
 }
 
-#include "exec/cpu-all.h"
-
 #ifdef TARGET_SPARC64
 /* sun4u.c */
 void cpu_tick_set_count(CPUTimer *timer, uint64_t count);
diff --git a/target/tricore/cpu.h b/target/tricore/cpu.h
index abb9cba136..c76e65f818 100644
--- a/target/tricore/cpu.h
+++ b/target/tricore/cpu.h
@@ -251,8 +251,6 @@ void fpu_set_state(CPUTriCoreState *env);
 
 #define MMU_USER_IDX 2
 
-#include "exec/cpu-all.h"
-
 FIELD(TB_FLAGS, PRIV, 0, 2)
 
 void cpu_state_reset(CPUTriCoreState *s);
diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
index c5d2042de1..c03ed71c94 100644
--- a/target/xtensa/cpu.h
+++ b/target/xtensa/cpu.h
@@ -733,8 +733,6 @@ static inline uint32_t xtensa_replicate_windowstart(CPUXtensaState *env)
 #define XTENSA_CSBASE_LBEG_OFF_MASK 0x00ff0000
 #define XTENSA_CSBASE_LBEG_OFF_SHIFT 16
 
-#include "exec/cpu-all.h"
-
 static inline void cpu_get_tb_cpu_state(CPUXtensaState *env, vaddr *pc,
                                         uint64_t *cs_base, uint32_t *flags)
 {
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 8d2b957a3b..5ced3879ac 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -35,7 +35,6 @@
 #include "qemu/rcu.h"
 #include "exec/log.h"
 #include "qemu/main-loop.h"
-#include "exec/cpu-all.h"
 #include "cpu.h"
 #include "exec/icount.h"
 #include "exec/replay-core.h"
diff --git a/hw/hyperv/hyperv.c b/hw/hyperv/hyperv.c
index c487f13e2f..8f193fd0bd 100644
--- a/hw/hyperv/hyperv.c
+++ b/hw/hyperv/hyperv.c
@@ -24,7 +24,6 @@
 #include "qom/object.h"
 #include "target/i386/kvm/hyperv-proto.h"
 #include "target/i386/cpu.h"
-#include "exec/cpu-all.h"
 #include "exec/target_page.h"
 
 struct SynICState {
diff --git a/semihosting/uaccess.c b/semihosting/uaccess.c
index f51a253626..81ffecaaba 100644
--- a/semihosting/uaccess.c
+++ b/semihosting/uaccess.c
@@ -8,7 +8,6 @@
  */
 
 #include "qemu/osdep.h"
-#include "exec/cpu-all.h"
 #include "accel/tcg/cpu-mmu-index.h"
 #include "exec/exec-all.h"
 #include "exec/target_page.h"
diff --git a/tcg/tcg-op-ldst.c b/tcg/tcg-op-ldst.c
index 73838e2701..3b073b4ce0 100644
--- a/tcg/tcg-op-ldst.c
+++ b/tcg/tcg-op-ldst.c
@@ -37,7 +37,7 @@ static void check_max_alignment(unsigned a_bits)
 {
     /*
      * The requested alignment cannot overlap the TLB flags.
-     * FIXME: Must keep the count up-to-date with "exec/cpu-all.h".
+     * FIXME: Must keep the count up-to-date with "exec/tlb-flags.h".
      */
     if (tcg_use_softmmu) {
         tcg_debug_assert(a_bits + 5 <= tcg_ctx->page_bits);
-- 
2.43.0


