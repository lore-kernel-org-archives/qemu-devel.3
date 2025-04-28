Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4704C369D5
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 20:11:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9UoQ-0005Be-Vw; Mon, 28 Apr 2025 16:10:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u9UoK-00059o-Sm
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 16:10:41 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u9UoH-0000dS-E0
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 16:10:40 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-7fd35b301bdso6630796a12.2
 for <qemu-devel@nongnu.org>; Mon, 28 Apr 2025 13:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745871036; x=1746475836; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fPjE8XgVEzl8dReEQ1Vp9qOkb5DVyaPTMeETZyGfHWI=;
 b=Laih93726FS2anOTD/nDwI6CcqLkmHgihseug5s2NPmjlk3COd6CrNhOclziKu1A6o
 ovLmTrguI8gOTHnaRU33zTfAcbTvJhO4BjszROObxD/7GuDLJgmWRUNFpI8ledLxI+Ck
 DuQBUcjcxeYcDA0Cwt8tbNQEZp1TnetdsmsZfR3taQtnqUhqRnZUfDBQwRobRBF3C4Yt
 CsRFVL1+OqrgI40odLqRgCwjs/UoEGH9Wtvx+7OTjl2AP7h25YkzlfZXcMZUmc+Fs4fH
 AwhxkBFcAPwaOTZI+eSVi7LKrE5JSyL2+i5VdxBopS4p2blTEJ0oXyzNDCUITglQjAd1
 DhAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745871036; x=1746475836;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fPjE8XgVEzl8dReEQ1Vp9qOkb5DVyaPTMeETZyGfHWI=;
 b=E8ckQZgSfdMIbAulnrXq/2E+IbrGFqpNGIawwhoohcXfRMbPb6TnWNSfyKeBAm9YrT
 07fuRbPsz5nL5Y1lSsAQjwaL7DplhI+JTeKzZniQ7PHrs2UEByMXATBXjUvuUHY5x8Wf
 ODEm2IDylkfBfvOdeMD/M+PnryWijPi71yqA16az5u1d7TNGT847cpdoOJWt2lIi2Hww
 FJNGQI+/P3yAPRdixT406xAhVpuiHcDm3PVyb3EqkONa+njiMMBhYwVlaFyemx68THjd
 jXrvvtMCanOIaFCIdnx9QOc6zCwvqxAEg3lsBobA6mVtnkAY1usL3eJHJWGO1/p0WaaJ
 G/PA==
X-Gm-Message-State: AOJu0Yxjpf8a6IpiEybJlJ4c4v8lg8V/L7ok0UW1xbpwmT60tAWYDIab
 QzZlGCeRXhuMO0YwfsQ05aAqrIJ7lb4JkaZs5IFGju/A/IXT26vrOnzNtDYhCXBnYgc3znc5yrp
 H
X-Gm-Gg: ASbGncsqxBoSzMmJWqxuNIXWcN98AHoINn0AT0E3LXNXSWkOnN8zefLhyKrWy74KHkN
 1J0YpKdncMXyfh4cSC0lksA0TEb0Izg84XbAttFZoBnskiqqqC9cGcTUTUZAfaL6u/Xxl2P9hgj
 7EdGhxHUNwPJc0kNDW9ztUdaGW834h/c4Q4bHQiz/qBT6iZ/FeMrctdFu5JUGnvw1Qeaik98BCK
 P2fWXtTDaynT5BASz1vvGuVYJNxbzMi6icCz41+XcbAn+lD4MvyUh36/vHT7u4gSrzJGU4WSueH
 aHp0QqmwBMK1dRcmXr7bGDJPEWDg+3px2FlQ64znX/Lu956HVaX+7DsuV1WLMJF5CSqRhkSfi5A
 =
X-Google-Smtp-Source: AGHT+IHXt4sN4rsMNgpeU+y1SG6jMM7G4esFP8C2vBjpyTGtIiWHa/Qy8sqDTPheNhU1XZE0oRUjDA==
X-Received: by 2002:a05:6a21:c91:b0:1f5:8e94:2e7f with SMTP id
 adf61e73a8af0-2046a646f31mr13968776637.33.1745871035771; 
 Mon, 28 Apr 2025 13:10:35 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25912fb9sm8469976b3a.34.2025.04.28.13.10.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Apr 2025 13:10:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org,
	philmd@linaro.org
Subject: [PATCH 08/10] accel/tcg: Move cpu_get_tb_cpu_state to TCGCPUOps
Date: Mon, 28 Apr 2025 13:10:26 -0700
Message-ID: <20250428201028.1699157-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250428201028.1699157-1-richard.henderson@linaro.org>
References: <20250428201028.1699157-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52f.google.com
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

Move the global function name to a hook on TCGCPUOps.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/internal-common.h | 2 +-
 include/accel/tcg/cpu-ops.h | 8 ++++++--
 target/arm/internals.h      | 1 +
 target/ppc/internal.h       | 2 ++
 accel/tcg/cpu-exec.c        | 1 +
 target/alpha/cpu.c          | 3 ++-
 target/arm/cpu.c            | 1 +
 target/arm/helper.c         | 2 +-
 target/arm/tcg/cpu-v7m.c    | 1 +
 target/avr/cpu.c            | 3 ++-
 target/hexagon/cpu.c        | 3 ++-
 target/hppa/cpu.c           | 3 ++-
 target/i386/tcg/tcg-cpu.c   | 3 ++-
 target/loongarch/cpu.c      | 3 ++-
 target/m68k/cpu.c           | 3 ++-
 target/microblaze/cpu.c     | 3 ++-
 target/mips/cpu.c           | 3 ++-
 target/openrisc/cpu.c       | 3 ++-
 target/ppc/cpu_init.c       | 2 +-
 target/ppc/helper_regs.c    | 3 ++-
 target/riscv/tcg/tcg-cpu.c  | 3 ++-
 target/rx/cpu.c             | 3 ++-
 target/s390x/cpu.c          | 3 ++-
 target/sh4/cpu.c            | 3 ++-
 target/sparc/cpu.c          | 3 ++-
 target/tricore/cpu.c        | 3 ++-
 target/xtensa/cpu.c         | 3 ++-
 27 files changed, 51 insertions(+), 23 deletions(-)

diff --git a/accel/tcg/internal-common.h b/accel/tcg/internal-common.h
index 3ff4c1cb54..130af3098c 100644
--- a/accel/tcg/internal-common.h
+++ b/accel/tcg/internal-common.h
@@ -59,7 +59,7 @@ void cpu_restore_state_from_tb(CPUState *cpu, TranslationBlock *tb,
 
 static inline TCGTBCPUState get_tb_cpu_state(CPUState *cs)
 {
-    return cpu_get_tb_cpu_state(cs);
+    return cs->cc->tcg_ops->get_tb_cpu_state(cs);
 }
 
 /**
diff --git a/include/accel/tcg/cpu-ops.h b/include/accel/tcg/cpu-ops.h
index 8dbe79ea7c..25986a351a 100644
--- a/include/accel/tcg/cpu-ops.h
+++ b/include/accel/tcg/cpu-ops.h
@@ -24,8 +24,6 @@ struct TCGTBCPUState {
     uint64_t flags2;
 };
 
-TCGTBCPUState cpu_get_tb_cpu_state(CPUState *cs);
-
 struct TCGCPUOps {
     /**
      * mttcg_supported: multi-threaded TCG is supported
@@ -68,6 +66,12 @@ struct TCGCPUOps {
      */
     void (*translate_code)(CPUState *cpu, TranslationBlock *tb,
                            int *max_insns, vaddr pc, void *host_pc);
+    /**
+     * @get_tb_cpu_state: Extract CPU state for a TCG #TranslationBlock
+     *
+     * Fill in all data required to select or compile a TranslationBlock.
+     */
+    TCGTBCPUState (*get_tb_cpu_state)(CPUState *cs);
     /**
      * @synchronize_from_tb: Synchronize state from a TCG #TranslationBlock
      *
diff --git a/target/arm/internals.h b/target/arm/internals.h
index d24acdd672..10f523873a 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -370,6 +370,7 @@ void arm_restore_state_to_opc(CPUState *cs,
                               const uint64_t *data);
 
 #ifdef CONFIG_TCG
+TCGTBCPUState arm_get_tb_cpu_state(CPUState *cs);
 void arm_cpu_synchronize_from_tb(CPUState *cs, const TranslationBlock *tb);
 
 /* Our implementation of TCGCPUOps::cpu_exec_halt */
diff --git a/target/ppc/internal.h b/target/ppc/internal.h
index 9012d3809c..681d522c2e 100644
--- a/target/ppc/internal.h
+++ b/target/ppc/internal.h
@@ -308,4 +308,6 @@ static inline int ger_pack_masks(int pmsk, int ymsk, int xmsk)
     return msk;
 }
 
+TCGTBCPUState ppc_get_tb_cpu_state(CPUState *cs);
+
 #endif /* PPC_INTERNAL_H */
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index a48df5f291..a10a2c5f29 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -1052,6 +1052,7 @@ bool tcg_exec_realizefn(CPUState *cpu, Error **errp)
         assert(tcg_ops->cpu_exec_reset);
 #endif /* !CONFIG_USER_ONLY */
         assert(tcg_ops->translate_code);
+        assert(tcg_ops->get_tb_cpu_state);
         assert(tcg_ops->mmu_index);
         tcg_ops->initialize();
         tcg_target_initialized = true;
diff --git a/target/alpha/cpu.c b/target/alpha/cpu.c
index 6efaa71543..695e6f42a6 100644
--- a/target/alpha/cpu.c
+++ b/target/alpha/cpu.c
@@ -41,7 +41,7 @@ static vaddr alpha_cpu_get_pc(CPUState *cs)
     return env->pc;
 }
 
-TCGTBCPUState cpu_get_tb_cpu_state(CPUState *cs)
+static TCGTBCPUState alpha_get_tb_cpu_state(CPUState *cs)
 {
     CPUAlphaState *env = cpu_env(cs);
     uint32_t flags = env->flags & ENV_FLAG_TB_MASK;
@@ -251,6 +251,7 @@ static const TCGCPUOps alpha_tcg_ops = {
 
     .initialize = alpha_translate_init,
     .translate_code = alpha_translate_code,
+    .get_tb_cpu_state = alpha_get_tb_cpu_state,
     .synchronize_from_tb = alpha_cpu_synchronize_from_tb,
     .restore_state_to_opc = alpha_restore_state_to_opc,
     .mmu_index = alpha_cpu_mmu_index,
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 9e74d7bc07..c401f0455b 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2676,6 +2676,7 @@ static const TCGCPUOps arm_tcg_ops = {
 
     .initialize = arm_translate_init,
     .translate_code = arm_translate_code,
+    .get_tb_cpu_state = arm_get_tb_cpu_state,
     .synchronize_from_tb = arm_cpu_synchronize_from_tb,
     .debug_excp_handler = arm_debug_excp_handler,
     .restore_state_to_opc = arm_restore_state_to_opc,
diff --git a/target/arm/helper.c b/target/arm/helper.c
index aa887af50f..84f1d963c2 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -11453,7 +11453,7 @@ static bool mve_no_pred(CPUARMState *env)
     return true;
 }
 
-TCGTBCPUState cpu_get_tb_cpu_state(CPUState *cs)
+TCGTBCPUState arm_get_tb_cpu_state(CPUState *cs)
 {
     CPUARMState *env = cpu_env(cs);
     CPUARMTBFlags flags;
diff --git a/target/arm/tcg/cpu-v7m.c b/target/arm/tcg/cpu-v7m.c
index 57ed3f3a06..ef7e16dfcd 100644
--- a/target/arm/tcg/cpu-v7m.c
+++ b/target/arm/tcg/cpu-v7m.c
@@ -238,6 +238,7 @@ static const TCGCPUOps arm_v7m_tcg_ops = {
 
     .initialize = arm_translate_init,
     .translate_code = arm_translate_code,
+    .get_tb_cpu_state = arm_get_tb_cpu_state,
     .synchronize_from_tb = arm_cpu_synchronize_from_tb,
     .debug_excp_handler = arm_debug_excp_handler,
     .restore_state_to_opc = arm_restore_state_to_opc,
diff --git a/target/avr/cpu.c b/target/avr/cpu.c
index 88a4b970df..47b5334906 100644
--- a/target/avr/cpu.c
+++ b/target/avr/cpu.c
@@ -54,7 +54,7 @@ static int avr_cpu_mmu_index(CPUState *cs, bool ifetch)
     return ifetch ? MMU_CODE_IDX : MMU_DATA_IDX;
 }
 
-TCGTBCPUState cpu_get_tb_cpu_state(CPUState *cs)
+static TCGTBCPUState avr_get_tb_cpu_state(CPUState *cs)
 {
     CPUAVRState *env = cpu_env(cs);
     uint32_t flags = 0;
@@ -241,6 +241,7 @@ static const TCGCPUOps avr_tcg_ops = {
     .mttcg_supported = false,
     .initialize = avr_cpu_tcg_init,
     .translate_code = avr_cpu_translate_code,
+    .get_tb_cpu_state = avr_get_tb_cpu_state,
     .synchronize_from_tb = avr_cpu_synchronize_from_tb,
     .restore_state_to_opc = avr_restore_state_to_opc,
     .mmu_index = avr_cpu_mmu_index,
diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
index 08c9aef55e..9beb6a2dc2 100644
--- a/target/hexagon/cpu.c
+++ b/target/hexagon/cpu.c
@@ -255,7 +255,7 @@ static vaddr hexagon_cpu_get_pc(CPUState *cs)
     return cpu_env(cs)->gpr[HEX_REG_PC];
 }
 
-TCGTBCPUState cpu_get_tb_cpu_state(CPUState *cs)
+static TCGTBCPUState hexagon_get_tb_cpu_state(CPUState *cs)
 {
     CPUHexagonState *env = cpu_env(cs);
     vaddr pc = env->gpr[HEX_REG_PC];
@@ -344,6 +344,7 @@ static const TCGCPUOps hexagon_tcg_ops = {
     .mttcg_supported = false,
     .initialize = hexagon_translate_init,
     .translate_code = hexagon_translate_code,
+    .get_tb_cpu_state = hexagon_get_tb_cpu_state,
     .synchronize_from_tb = hexagon_cpu_synchronize_from_tb,
     .restore_state_to_opc = hexagon_restore_state_to_opc,
     .mmu_index = hexagon_cpu_mmu_index,
diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index 7270b0a2a7..58566d9897 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -51,7 +51,7 @@ static vaddr hppa_cpu_get_pc(CPUState *cs)
                          env->iaoq_f & -4);
 }
 
-TCGTBCPUState cpu_get_tb_cpu_state(CPUState *cs)
+static TCGTBCPUState hppa_get_tb_cpu_state(CPUState *cs)
 {
     CPUHPPAState *env = cpu_env(cs);
     uint32_t flags = 0;
@@ -262,6 +262,7 @@ static const TCGCPUOps hppa_tcg_ops = {
 
     .initialize = hppa_translate_init,
     .translate_code = hppa_translate_code,
+    .get_tb_cpu_state = hppa_get_tb_cpu_state,
     .synchronize_from_tb = hppa_cpu_synchronize_from_tb,
     .restore_state_to_opc = hppa_restore_state_to_opc,
     .mmu_index = hppa_cpu_mmu_index,
diff --git a/target/i386/tcg/tcg-cpu.c b/target/i386/tcg/tcg-cpu.c
index 950b3bfa76..2845e5b0cc 100644
--- a/target/i386/tcg/tcg-cpu.c
+++ b/target/i386/tcg/tcg-cpu.c
@@ -48,7 +48,7 @@ static void x86_cpu_exec_exit(CPUState *cs)
     env->eflags = cpu_compute_eflags(env);
 }
 
-TCGTBCPUState cpu_get_tb_cpu_state(CPUState *cs)
+static TCGTBCPUState x86_get_tb_cpu_state(CPUState *cs)
 {
     CPUX86State *env = cpu_env(cs);
     uint32_t flags, cs_base;
@@ -160,6 +160,7 @@ const TCGCPUOps x86_tcg_ops = {
     .guest_default_memory_order = TCG_MO_ALL & ~TCG_MO_ST_LD,
     .initialize = tcg_x86_init,
     .translate_code = x86_translate_code,
+    .get_tb_cpu_state = x86_get_tb_cpu_state,
     .synchronize_from_tb = x86_cpu_synchronize_from_tb,
     .restore_state_to_opc = x86_restore_state_to_opc,
     .mmu_index = x86_cpu_mmu_index,
diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index 1691fe1d9f..4ea17a288b 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -336,7 +336,7 @@ static bool loongarch_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
 }
 #endif
 
-TCGTBCPUState cpu_get_tb_cpu_state(CPUState *cs)
+static TCGTBCPUState loongarch_get_tb_cpu_state(CPUState *cs)
 {
     CPULoongArchState *env = cpu_env(cs);
     uint32_t flags;
@@ -882,6 +882,7 @@ static const TCGCPUOps loongarch_tcg_ops = {
 
     .initialize = loongarch_translate_init,
     .translate_code = loongarch_translate_code,
+    .get_tb_cpu_state = loongarch_get_tb_cpu_state,
     .synchronize_from_tb = loongarch_cpu_synchronize_from_tb,
     .restore_state_to_opc = loongarch_restore_state_to_opc,
     .mmu_index = loongarch_cpu_mmu_index,
diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index 1786d9e0ce..75a860cf6f 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -39,7 +39,7 @@ static vaddr m68k_cpu_get_pc(CPUState *cs)
     return cpu->env.pc;
 }
 
-TCGTBCPUState cpu_get_tb_cpu_state(CPUState *cs)
+static TCGTBCPUState m68k_get_tb_cpu_state(CPUState *cs)
 {
     CPUM68KState *env = cpu_env(cs);
     uint32_t flags;
@@ -612,6 +612,7 @@ static const TCGCPUOps m68k_tcg_ops = {
 
     .initialize = m68k_tcg_init,
     .translate_code = m68k_translate_code,
+    .get_tb_cpu_state = m68k_get_tb_cpu_state,
     .restore_state_to_opc = m68k_restore_state_to_opc,
     .mmu_index = m68k_cpu_mmu_index,
 
diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index 91e77a4e53..6a4f93e99c 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -95,7 +95,7 @@ static vaddr mb_cpu_get_pc(CPUState *cs)
     return cpu->env.pc;
 }
 
-TCGTBCPUState cpu_get_tb_cpu_state(CPUState *cs)
+static TCGTBCPUState mb_get_tb_cpu_state(CPUState *cs)
 {
     CPUMBState *env = cpu_env(cs);
 
@@ -442,6 +442,7 @@ static const TCGCPUOps mb_tcg_ops = {
 
     .initialize = mb_tcg_init,
     .translate_code = mb_translate_code,
+    .get_tb_cpu_state = mb_get_tb_cpu_state,
     .synchronize_from_tb = mb_cpu_synchronize_from_tb,
     .restore_state_to_opc = mb_restore_state_to_opc,
     .mmu_index = mb_cpu_mmu_index,
diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index c514202fbc..a47a96f060 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -549,7 +549,7 @@ static int mips_cpu_mmu_index(CPUState *cs, bool ifunc)
     return mips_env_mmu_index(cpu_env(cs));
 }
 
-TCGTBCPUState cpu_get_tb_cpu_state(CPUState *cs)
+static TCGTBCPUState mips_get_tb_cpu_state(CPUState *cs)
 {
     CPUMIPSState *env = cpu_env(cs);
 
@@ -566,6 +566,7 @@ static const TCGCPUOps mips_tcg_ops = {
 
     .initialize = mips_tcg_init,
     .translate_code = mips_translate_code,
+    .get_tb_cpu_state = mips_get_tb_cpu_state,
     .synchronize_from_tb = mips_cpu_synchronize_from_tb,
     .restore_state_to_opc = mips_restore_state_to_opc,
     .mmu_index = mips_cpu_mmu_index,
diff --git a/target/openrisc/cpu.c b/target/openrisc/cpu.c
index 6b31f9c80e..c0cd279b1e 100644
--- a/target/openrisc/cpu.c
+++ b/target/openrisc/cpu.c
@@ -41,7 +41,7 @@ static vaddr openrisc_cpu_get_pc(CPUState *cs)
     return cpu->env.pc;
 }
 
-TCGTBCPUState cpu_get_tb_cpu_state(CPUState *cs)
+static TCGTBCPUState openrisc_get_tb_cpu_state(CPUState *cs)
 {
     CPUOpenRISCState *env = cpu_env(cs);
 
@@ -258,6 +258,7 @@ static const TCGCPUOps openrisc_tcg_ops = {
 
     .initialize = openrisc_translate_init,
     .translate_code = openrisc_translate_code,
+    .get_tb_cpu_state = openrisc_get_tb_cpu_state,
     .synchronize_from_tb = openrisc_cpu_synchronize_from_tb,
     .restore_state_to_opc = openrisc_restore_state_to_opc,
     .mmu_index = openrisc_cpu_mmu_index,
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 5981f607d2..fcd96e369e 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -45,7 +45,6 @@
 #include "internal.h"
 #include "spr_common.h"
 #include "power8-pmu.h"
-
 #ifndef CONFIG_USER_ONLY
 #include "hw/boards.h"
 #include "hw/intc/intc.h"
@@ -7483,6 +7482,7 @@ static const TCGCPUOps ppc_tcg_ops = {
   .guest_default_memory_order = 0,
   .initialize = ppc_translate_init,
   .translate_code = ppc_translate_code,
+  .get_tb_cpu_state = ppc_get_tb_cpu_state,
   .restore_state_to_opc = ppc_restore_state_to_opc,
   .mmu_index = ppc_cpu_mmu_index,
 
diff --git a/target/ppc/helper_regs.c b/target/ppc/helper_regs.c
index ccaf2b0343..7e5726871e 100644
--- a/target/ppc/helper_regs.c
+++ b/target/ppc/helper_regs.c
@@ -28,6 +28,7 @@
 #include "cpu-models.h"
 #include "spr_common.h"
 #include "accel/tcg/cpu-ops.h"
+#include "internal.h"
 
 /* Swap temporary saved registers with GPRs */
 void hreg_swap_gpr_tgpr(CPUPPCState *env)
@@ -256,7 +257,7 @@ void hreg_update_pmu_hflags(CPUPPCState *env)
     env->hflags |= hreg_compute_pmu_hflags_value(env);
 }
 
-TCGTBCPUState cpu_get_tb_cpu_state(CPUState *cs)
+TCGTBCPUState ppc_get_tb_cpu_state(CPUState *cs)
 {
     CPUPPCState *env = cpu_env(cs);
     uint32_t hflags_current = env->hflags;
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 461b8c97b4..4ab8f021eb 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -98,7 +98,7 @@ static int riscv_cpu_mmu_index(CPUState *cs, bool ifetch)
     return riscv_env_mmu_index(cpu_env(cs), ifetch);
 }
 
-TCGTBCPUState cpu_get_tb_cpu_state(CPUState *cs)
+static TCGTBCPUState riscv_get_tb_cpu_state(CPUState *cs)
 {
     CPURISCVState *env = cpu_env(cs);
     RISCVCPU *cpu = env_archcpu(env);
@@ -243,6 +243,7 @@ const TCGCPUOps riscv_tcg_ops = {
 
     .initialize = riscv_translate_init,
     .translate_code = riscv_translate_code,
+    .get_tb_cpu_state = riscv_get_tb_cpu_state,
     .synchronize_from_tb = riscv_cpu_synchronize_from_tb,
     .restore_state_to_opc = riscv_restore_state_to_opc,
     .mmu_index = riscv_cpu_mmu_index,
diff --git a/target/rx/cpu.c b/target/rx/cpu.c
index b8bba1a0c7..786c9d3031 100644
--- a/target/rx/cpu.c
+++ b/target/rx/cpu.c
@@ -44,7 +44,7 @@ static vaddr rx_cpu_get_pc(CPUState *cs)
     return cpu->env.pc;
 }
 
-TCGTBCPUState cpu_get_tb_cpu_state(CPUState *cs)
+static TCGTBCPUState rx_get_tb_cpu_state(CPUState *cs)
 {
     CPURXState *env = cpu_env(cs);
     uint32_t flags = 0;
@@ -220,6 +220,7 @@ static const TCGCPUOps rx_tcg_ops = {
 
     .initialize = rx_translate_init,
     .translate_code = rx_translate_code,
+    .get_tb_cpu_state = rx_get_tb_cpu_state,
     .synchronize_from_tb = rx_cpu_synchronize_from_tb,
     .restore_state_to_opc = rx_restore_state_to_opc,
     .mmu_index = rx_cpu_mmu_index,
diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index 127574c085..65330d8ae5 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -309,7 +309,7 @@ static int s390x_cpu_mmu_index(CPUState *cs, bool ifetch)
     return s390x_env_mmu_index(cpu_env(cs), ifetch);
 }
 
-TCGTBCPUState cpu_get_tb_cpu_state(CPUState *cs)
+static TCGTBCPUState s390x_get_tb_cpu_state(CPUState *cs)
 {
     CPUS390XState *env = cpu_env(cs);
     uint32_t flags;
@@ -358,6 +358,7 @@ static const TCGCPUOps s390_tcg_ops = {
 
     .initialize = s390x_translate_init,
     .translate_code = s390x_translate_code,
+    .get_tb_cpu_state = s390x_get_tb_cpu_state,
     .restore_state_to_opc = s390x_restore_state_to_opc,
     .mmu_index = s390x_cpu_mmu_index,
 
diff --git a/target/sh4/cpu.c b/target/sh4/cpu.c
index 320cb8ddcc..20969037d1 100644
--- a/target/sh4/cpu.c
+++ b/target/sh4/cpu.c
@@ -43,7 +43,7 @@ static vaddr superh_cpu_get_pc(CPUState *cs)
     return cpu->env.pc;
 }
 
-TCGTBCPUState cpu_get_tb_cpu_state(CPUState *cs)
+static TCGTBCPUState superh_get_tb_cpu_state(CPUState *cs)
 {
     CPUSH4State *env = cpu_env(cs);
     uint32_t flags;
@@ -289,6 +289,7 @@ static const TCGCPUOps superh_tcg_ops = {
 
     .initialize = sh4_translate_init,
     .translate_code = sh4_translate_code,
+    .get_tb_cpu_state = superh_get_tb_cpu_state,
     .synchronize_from_tb = superh_cpu_synchronize_from_tb,
     .restore_state_to_opc = superh_restore_state_to_opc,
     .mmu_index = sh4_cpu_mmu_index,
diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index 77591e84ba..05805ee127 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -716,7 +716,7 @@ static void sparc_cpu_synchronize_from_tb(CPUState *cs,
     cpu->env.npc = tb->cs_base;
 }
 
-TCGTBCPUState cpu_get_tb_cpu_state(CPUState *cs)
+static TCGTBCPUState sparc_get_tb_cpu_state(CPUState *cs)
 {
     CPUSPARCState *env = cpu_env(cs);
     uint32_t flags = cpu_mmu_index(cs, false);
@@ -1029,6 +1029,7 @@ static const TCGCPUOps sparc_tcg_ops = {
 
     .initialize = sparc_tcg_init,
     .translate_code = sparc_translate_code,
+    .get_tb_cpu_state = sparc_get_tb_cpu_state,
     .synchronize_from_tb = sparc_cpu_synchronize_from_tb,
     .restore_state_to_opc = sparc_restore_state_to_opc,
     .mmu_index = sparc_cpu_mmu_index,
diff --git a/target/tricore/cpu.c b/target/tricore/cpu.c
index fdc2012d16..15e9d0eb1a 100644
--- a/target/tricore/cpu.c
+++ b/target/tricore/cpu.c
@@ -45,7 +45,7 @@ static vaddr tricore_cpu_get_pc(CPUState *cs)
     return cpu_env(cs)->PC;
 }
 
-TCGTBCPUState cpu_get_tb_cpu_state(CPUState *cs)
+static TCGTBCPUState tricore_get_tb_cpu_state(CPUState *cs)
 {
     CPUTriCoreState *env = cpu_env(cs);
 
@@ -185,6 +185,7 @@ static const TCGCPUOps tricore_tcg_ops = {
     .mttcg_supported = false,
     .initialize = tricore_tcg_init,
     .translate_code = tricore_translate_code,
+    .get_tb_cpu_state = tricore_get_tb_cpu_state,
     .synchronize_from_tb = tricore_cpu_synchronize_from_tb,
     .restore_state_to_opc = tricore_restore_state_to_opc,
     .mmu_index = tricore_cpu_mmu_index,
diff --git a/target/xtensa/cpu.c b/target/xtensa/cpu.c
index 4a8de9f42c..6850a0e508 100644
--- a/target/xtensa/cpu.c
+++ b/target/xtensa/cpu.c
@@ -55,7 +55,7 @@ static vaddr xtensa_cpu_get_pc(CPUState *cs)
     return cpu->env.pc;
 }
 
-TCGTBCPUState cpu_get_tb_cpu_state(CPUState *cs)
+static TCGTBCPUState xtensa_get_tb_cpu_state(CPUState *cs)
 {
     CPUXtensaState *env = cpu_env(cs);
     uint32_t flags = 0;
@@ -308,6 +308,7 @@ static const TCGCPUOps xtensa_tcg_ops = {
     .initialize = xtensa_translate_init,
     .translate_code = xtensa_translate_code,
     .debug_excp_handler = xtensa_breakpoint_handler,
+    .get_tb_cpu_state = xtensa_get_tb_cpu_state,
     .restore_state_to_opc = xtensa_restore_state_to_opc,
     .mmu_index = xtensa_cpu_mmu_index,
 
-- 
2.43.0


