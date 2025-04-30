Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87245C369D9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 16:50:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAAci-0005o4-Ip; Wed, 30 Apr 2025 12:49:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAAcO-00056Q-7X
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 12:49:11 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAAcK-0001ur-Hw
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 12:49:07 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-736a72220edso132511b3a.3
 for <qemu-devel@nongnu.org>; Wed, 30 Apr 2025 09:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746031743; x=1746636543; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZrgNHkmVFQwH5odIUzOQLc+ZFJWjL7PB2mBMvbUpVdg=;
 b=VgJXJLnZz2yZs29l4Gyv45vtOCRCuL+1o3i8q0bwPzTDp1pCqn7QCdc85myOWexWwz
 OfwON1nzpwAZSODBBkr6a9gtEWsdYe2l7Bo7t9SbQhtl8yHzsQ5ism+VwR2TvZpGvxcy
 AbOFKkZnK50c31SrJ1AIe1uJEZ4zNiD62F2TRyYSJx/Fqnp9grvEqh8+bNUNi5CAxFOj
 hwbkK2ii/Fcy5enKE7v2agcyIDcDLMtDR6I1zRW8p8Ko5wodnq8HPCe8DWHrMVvkzsfV
 WvyYvLsjLuJDfMFDStPpPj465j7tMlV2Z+R1Upa9gDMNXzPoxXIq8SYVMk4v/zM7V+vD
 R9FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746031743; x=1746636543;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZrgNHkmVFQwH5odIUzOQLc+ZFJWjL7PB2mBMvbUpVdg=;
 b=wGbS4XZOSD1Xe18X9YP+NUNNw1E24aAtWYETclsIs2tMg2cWGISxxBR0LWJyIjCOqX
 W2jgoKVZnMwHTKVkIB6U0zEHrIPhAVpks/M8JUn4M6U3Bm+Uu9PVe36nQbnRP14AdtvV
 GyAmfnqk3DlNUp2MhXbWcn/Z8KpFoGQ6c/1xHHOwGgFNeVAHZlQcWGcixYvDc/am5HW/
 9qxh5Snii7rEWB18EkxFPewViWlffJasTIycSMGp+1jsT0rWINbYGELCdOX0fN/g4h8M
 dVtj0vVblLX9HX+n0oIbbOmzMENwB1/mn1G2nlXy8dKcelUEUFqBPkdKR1zjRBgcW9+A
 2E0w==
X-Gm-Message-State: AOJu0Yxs4INKfYefsd/LVQKyLWIrO+uKYNFgtdiOskBZ1pP8IDKEVAtz
 LxDe5WH1gpFDrbIR5gNPwp7CzQWOJQHFqPNwedyIiuOF6N+CqWFaPg9KnttUDzoN2qrjZlMmABE
 p
X-Gm-Gg: ASbGncvUAYXqTBRcG/4wyZAoeDGo23tpmR0wT+Ryzvr5zIU8CSNvXBda/EENE327JyA
 Zx+d9+EG7XL/MkBLNVBB9mE6l4Pho7PHHuCxu3wGApCfQsOeFLtr0rpUm8Gt3BkRFHvBJzBFAiH
 2BvphTyDOxGK392tCJayEVL8MgFGsI6rPyPc5bjEQody5G2/Mt+SD4KNx0Xy11kJqjBgcaaQSgI
 KtexXgYiN6/dvnUrlYRj/G2zx78qLHjMIzAVxrHzBQ+S9CzbOd2tDuZDpmWlKjWtAhiHMGiarXr
 3U4Ew5jTPatGQv/FHCFzu/9ZZ6aXgEFSxpOUME8zhZpyLGhUPmCh21QXp34KDIue1Wcp7pPKx4Y
 =
X-Google-Smtp-Source: AGHT+IH2JtGj8gO/vv6GLZ2ZFNjPX53o9s6y8Y1/sbAVJwRFyB8Ec+56mHFG2aXFhdry78ssQ5XNhA==
X-Received: by 2002:a05:6a20:cf83:b0:1f5:7c6f:6c96 with SMTP id
 adf61e73a8af0-20a88036a7cmr5645915637.22.1746031743023; 
 Wed, 30 Apr 2025 09:49:03 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b15f76f580asm9129704a12.2.2025.04.30.09.49.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Apr 2025 09:49:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org,
	philmd@linaro.org
Subject: [PATCH v2 09/16] accel/tcg: Return TCGTBCPUState from
 cpu_get_tb_cpu_state
Date: Wed, 30 Apr 2025 09:48:47 -0700
Message-ID: <20250430164854.2233995-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250430164854.2233995-1-richard.henderson@linaro.org>
References: <20250430164854.2233995-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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

Combine 3 different pointer returns into one structure return.

Include a cflags field in TCGTBCPUState, not filled in by
cpu_get_tb_cpu_state, but used by all callers.  This fills
a hole in the structure and is useful in some subroutines.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/accel/tcg/cpu-ops.h      |  4 +--
 include/accel/tcg/tb-cpu-state.h | 18 ++++++++++
 accel/tcg/cpu-exec.c             | 56 +++++++++++++-------------------
 accel/tcg/translate-all.c        |  8 ++---
 target/alpha/cpu.c               | 13 ++++----
 target/arm/tcg/hflags.c          | 17 ++++++----
 target/avr/cpu.c                 |  9 ++---
 target/hexagon/cpu.c             | 15 +++++----
 target/hppa/cpu.c                | 10 +++---
 target/i386/tcg/tcg-cpu.c        | 19 +++++++----
 target/loongarch/cpu.c           | 20 +++++++-----
 target/m68k/cpu.c                | 21 +++++++-----
 target/microblaze/cpu.c          | 13 +++++---
 target/mips/cpu.c                | 14 ++++----
 target/openrisc/cpu.c            | 16 +++++----
 target/ppc/helper_regs.c         |  8 ++---
 target/riscv/tcg/tcg-cpu.c       | 12 +++----
 target/rx/cpu.c                  | 14 ++++----
 target/s390x/cpu.c               | 14 ++++----
 target/sh4/cpu.c                 | 22 +++++++++----
 target/sparc/cpu.c               | 17 ++++++----
 target/tricore/cpu.c             | 14 ++++----
 target/xtensa/cpu.c              | 40 +++++++++++++----------
 23 files changed, 218 insertions(+), 176 deletions(-)
 create mode 100644 include/accel/tcg/tb-cpu-state.h

diff --git a/include/accel/tcg/cpu-ops.h b/include/accel/tcg/cpu-ops.h
index f5e5746976..43a39c2e13 100644
--- a/include/accel/tcg/cpu-ops.h
+++ b/include/accel/tcg/cpu-ops.h
@@ -16,10 +16,10 @@
 #include "exec/memop.h"
 #include "exec/mmu-access-type.h"
 #include "exec/vaddr.h"
+#include "accel/tcg/tb-cpu-state.h"
 #include "tcg/tcg-mo.h"
 
-void cpu_get_tb_cpu_state(CPUArchState *env, vaddr *pc,
-                          uint64_t *cs_base, uint32_t *flags);
+TCGTBCPUState cpu_get_tb_cpu_state(CPUState *cs);
 
 struct TCGCPUOps {
     /**
diff --git a/include/accel/tcg/tb-cpu-state.h b/include/accel/tcg/tb-cpu-state.h
new file mode 100644
index 0000000000..8f912900ca
--- /dev/null
+++ b/include/accel/tcg/tb-cpu-state.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: LGPL-2.1-or-later */
+/*
+ * Definition of TCGTBCPUState.
+ */
+
+#ifndef EXEC_TB_CPU_STATE_H
+#define EXEC_TB_CPU_STATE_H
+
+#include "exec/vaddr.h"
+
+typedef struct TCGTBCPUState {
+    vaddr pc;
+    uint32_t flags;
+    uint32_t cflags;
+    uint64_t cs_base;
+} TCGTBCPUState;
+
+#endif
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index c21c5d202d..f7e7e7949d 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -385,9 +385,6 @@ const void *HELPER(lookup_tb_ptr)(CPUArchState *env)
 {
     CPUState *cpu = env_cpu(env);
     TranslationBlock *tb;
-    vaddr pc;
-    uint64_t cs_base;
-    uint32_t flags, cflags;
 
     /*
      * By definition we've just finished a TB, so I/O is OK.
@@ -397,20 +394,21 @@ const void *HELPER(lookup_tb_ptr)(CPUArchState *env)
      * The next TB, if we chain to it, will clear the flag again.
      */
     cpu->neg.can_do_io = true;
-    cpu_get_tb_cpu_state(env, &pc, &cs_base, &flags);
 
-    cflags = curr_cflags(cpu);
-    if (check_for_breakpoints(cpu, pc, &cflags)) {
+    TCGTBCPUState s = cpu_get_tb_cpu_state(cpu);
+    s.cflags = curr_cflags(cpu);
+
+    if (check_for_breakpoints(cpu, s.pc, &s.cflags)) {
         cpu_loop_exit(cpu);
     }
 
-    tb = tb_lookup(cpu, pc, cs_base, flags, cflags);
+    tb = tb_lookup(cpu, s.pc, s.cs_base, s.flags, s.cflags);
     if (tb == NULL) {
         return tcg_code_gen_epilogue;
     }
 
     if (qemu_loglevel_mask(CPU_LOG_TB_CPU | CPU_LOG_EXEC)) {
-        log_cpu_exec(pc, cpu, tb);
+        log_cpu_exec(s.pc, cpu, tb);
     }
 
     return tb->tc.ptr;
@@ -560,11 +558,7 @@ static void cpu_exec_longjmp_cleanup(CPUState *cpu)
 
 void cpu_exec_step_atomic(CPUState *cpu)
 {
-    CPUArchState *env = cpu_env(cpu);
     TranslationBlock *tb;
-    vaddr pc;
-    uint64_t cs_base;
-    uint32_t flags, cflags;
     int tb_exit;
 
     if (sigsetjmp(cpu->jmp_env, 0) == 0) {
@@ -573,13 +567,13 @@ void cpu_exec_step_atomic(CPUState *cpu)
         g_assert(!cpu->running);
         cpu->running = true;
 
-        cpu_get_tb_cpu_state(env, &pc, &cs_base, &flags);
+        TCGTBCPUState s = cpu_get_tb_cpu_state(cpu);
+        s.cflags = curr_cflags(cpu);
 
-        cflags = curr_cflags(cpu);
         /* Execute in a serial context. */
-        cflags &= ~CF_PARALLEL;
+        s.cflags &= ~CF_PARALLEL;
         /* After 1 insn, return and release the exclusive lock. */
-        cflags |= CF_NO_GOTO_TB | CF_NO_GOTO_PTR | 1;
+        s.cflags |= CF_NO_GOTO_TB | CF_NO_GOTO_PTR | 1;
         /*
          * No need to check_for_breakpoints here.
          * We only arrive in cpu_exec_step_atomic after beginning execution
@@ -587,16 +581,16 @@ void cpu_exec_step_atomic(CPUState *cpu)
          * Any breakpoint for this insn will have been recognized earlier.
          */
 
-        tb = tb_lookup(cpu, pc, cs_base, flags, cflags);
+        tb = tb_lookup(cpu, s.pc, s.cs_base, s.flags, s.cflags);
         if (tb == NULL) {
             mmap_lock();
-            tb = tb_gen_code(cpu, pc, cs_base, flags, cflags);
+            tb = tb_gen_code(cpu, s.pc, s.cs_base, s.flags, s.cflags);
             mmap_unlock();
         }
 
         cpu_exec_enter(cpu);
         /* execute the generated code */
-        trace_exec_tb(tb, pc);
+        trace_exec_tb(tb, s.pc);
         cpu_tb_exec(cpu, tb, &tb_exit);
         cpu_exec_exit(cpu);
     } else {
@@ -941,11 +935,8 @@ cpu_exec_loop(CPUState *cpu, SyncClocks *sc)
 
         while (!cpu_handle_interrupt(cpu, &last_tb)) {
             TranslationBlock *tb;
-            vaddr pc;
-            uint64_t cs_base;
-            uint32_t flags, cflags;
-
-            cpu_get_tb_cpu_state(cpu_env(cpu), &pc, &cs_base, &flags);
+            TCGTBCPUState s = cpu_get_tb_cpu_state(cpu);
+            s.cflags = cpu->cflags_next_tb;
 
             /*
              * When requested, use an exact setting for cflags for the next
@@ -954,33 +945,32 @@ cpu_exec_loop(CPUState *cpu, SyncClocks *sc)
              * have CF_INVALID set, -1 is a convenient invalid value that
              * does not require tcg headers for cpu_common_reset.
              */
-            cflags = cpu->cflags_next_tb;
-            if (cflags == -1) {
-                cflags = curr_cflags(cpu);
+            if (s.cflags == -1) {
+                s.cflags = curr_cflags(cpu);
             } else {
                 cpu->cflags_next_tb = -1;
             }
 
-            if (check_for_breakpoints(cpu, pc, &cflags)) {
+            if (check_for_breakpoints(cpu, s.pc, &s.cflags)) {
                 break;
             }
 
-            tb = tb_lookup(cpu, pc, cs_base, flags, cflags);
+            tb = tb_lookup(cpu, s.pc, s.cs_base, s.flags, s.cflags);
             if (tb == NULL) {
                 CPUJumpCache *jc;
                 uint32_t h;
 
                 mmap_lock();
-                tb = tb_gen_code(cpu, pc, cs_base, flags, cflags);
+                tb = tb_gen_code(cpu, s.pc, s.cs_base, s.flags, s.cflags);
                 mmap_unlock();
 
                 /*
                  * We add the TB in the virtual pc hash table
                  * for the fast lookup
                  */
-                h = tb_jmp_cache_hash_func(pc);
+                h = tb_jmp_cache_hash_func(s.pc);
                 jc = cpu->tb_jmp_cache;
-                jc->array[h].pc = pc;
+                jc->array[h].pc = s.pc;
                 qatomic_set(&jc->array[h].tb, tb);
             }
 
@@ -1000,7 +990,7 @@ cpu_exec_loop(CPUState *cpu, SyncClocks *sc)
                 tb_add_jump(last_tb, tb_exit, tb);
             }
 
-            cpu_loop_exec_tb(cpu, tb, pc, &last_tb, &tb_exit);
+            cpu_loop_exec_tb(cpu, tb, s.pc, &last_tb, &tb_exit);
 
             /* Try to align the host and virtual clocks
                if the guest is in advance */
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 31c7f9927f..f2766cedfc 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -590,13 +590,9 @@ void tb_check_watchpoint(CPUState *cpu, uintptr_t retaddr)
         /* The exception probably happened in a helper.  The CPU state should
            have been saved before calling it. Fetch the PC from there.  */
         CPUArchState *env = cpu_env(cpu);
-        vaddr pc;
-        uint64_t cs_base;
-        tb_page_addr_t addr;
-        uint32_t flags;
+        TCGTBCPUState s = cpu_get_tb_cpu_state(cpu);
+        tb_page_addr_t addr = get_page_addr_code(env, s.pc);
 
-        cpu_get_tb_cpu_state(env, &pc, &cs_base, &flags);
-        addr = get_page_addr_code(env, pc);
         if (addr != -1) {
             tb_invalidate_phys_range(cpu, addr, addr);
         }
diff --git a/target/alpha/cpu.c b/target/alpha/cpu.c
index 134806e755..90e3a2e748 100644
--- a/target/alpha/cpu.c
+++ b/target/alpha/cpu.c
@@ -41,15 +41,16 @@ static vaddr alpha_cpu_get_pc(CPUState *cs)
     return env->pc;
 }
 
-void cpu_get_tb_cpu_state(CPUAlphaState *env, vaddr *pc,
-                          uint64_t *cs_base, uint32_t *pflags)
+TCGTBCPUState cpu_get_tb_cpu_state(CPUState *cs)
 {
-    *pc = env->pc;
-    *cs_base = 0;
-    *pflags = env->flags & ENV_FLAG_TB_MASK;
+    CPUAlphaState *env = cpu_env(cs);
+    uint32_t flags = env->flags & ENV_FLAG_TB_MASK;
+
 #ifdef CONFIG_USER_ONLY
-    *pflags |= TB_FLAG_UNALIGN * !env_cpu(env)->prctl_unalign_sigbus;
+    flags |= TB_FLAG_UNALIGN * !cs->prctl_unalign_sigbus;
 #endif
+
+    return (TCGTBCPUState){ .pc = env->pc, .flags = flags };
 }
 
 static void alpha_cpu_synchronize_from_tb(CPUState *cs,
diff --git a/target/arm/tcg/hflags.c b/target/arm/tcg/hflags.c
index 5315264c28..b49381924b 100644
--- a/target/arm/tcg/hflags.c
+++ b/target/arm/tcg/hflags.c
@@ -10,6 +10,7 @@
 #include "internals.h"
 #include "cpu-features.h"
 #include "exec/helper-proto.h"
+#include "exec/translation-block.h"
 #include "accel/tcg/cpu-ops.h"
 #include "cpregs.h"
 
@@ -544,21 +545,22 @@ static bool mve_no_pred(CPUARMState *env)
     return true;
 }
 
-void cpu_get_tb_cpu_state(CPUARMState *env, vaddr *pc,
-                          uint64_t *cs_base, uint32_t *pflags)
+TCGTBCPUState cpu_get_tb_cpu_state(CPUState *cs)
 {
+    CPUARMState *env = cpu_env(cs);
     CPUARMTBFlags flags;
+    vaddr pc;
 
     assert_hflags_rebuild_correctly(env);
     flags = env->hflags;
 
     if (EX_TBFLAG_ANY(flags, AARCH64_STATE)) {
-        *pc = env->pc;
+        pc = env->pc;
         if (cpu_isar_feature(aa64_bti, env_archcpu(env))) {
             DP_TBFLAG_A64(flags, BTYPE, env->btype);
         }
     } else {
-        *pc = env->regs[15];
+        pc = env->regs[15];
 
         if (arm_feature(env, ARM_FEATURE_M)) {
             if (arm_feature(env, ARM_FEATURE_M_SECURITY) &&
@@ -620,6 +622,9 @@ void cpu_get_tb_cpu_state(CPUARMState *env, vaddr *pc,
         DP_TBFLAG_ANY(flags, PSTATE__SS, 1);
     }
 
-    *pflags = flags.flags;
-    *cs_base = flags.flags2;
+    return (TCGTBCPUState){
+        .pc = pc,
+        .flags = flags.flags,
+        .cs_base = flags.flags2,
+    };
 }
diff --git a/target/avr/cpu.c b/target/avr/cpu.c
index d9fecb272e..683195b61d 100644
--- a/target/avr/cpu.c
+++ b/target/avr/cpu.c
@@ -54,14 +54,11 @@ static int avr_cpu_mmu_index(CPUState *cs, bool ifetch)
     return ifetch ? MMU_CODE_IDX : MMU_DATA_IDX;
 }
 
-void cpu_get_tb_cpu_state(CPUAVRState *env, vaddr *pc,
-                          uint64_t *cs_base, uint32_t *pflags)
+TCGTBCPUState cpu_get_tb_cpu_state(CPUState *cs)
 {
+    CPUAVRState *env = cpu_env(cs);
     uint32_t flags = 0;
 
-    *pc = env->pc_w * 2;
-    *cs_base = 0;
-
     if (env->fullacc) {
         flags |= TB_FLAGS_FULL_ACCESS;
     }
@@ -69,7 +66,7 @@ void cpu_get_tb_cpu_state(CPUAVRState *env, vaddr *pc,
         flags |= TB_FLAGS_SKIP;
     }
 
-    *pflags = flags;
+    return (TCGTBCPUState){ .pc = env->pc_w * 2, .flags = flags };
 }
 
 static void avr_cpu_synchronize_from_tb(CPUState *cs,
diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
index 2272f1222b..a7f76dd089 100644
--- a/target/hexagon/cpu.c
+++ b/target/hexagon/cpu.c
@@ -255,19 +255,20 @@ static vaddr hexagon_cpu_get_pc(CPUState *cs)
     return cpu_env(cs)->gpr[HEX_REG_PC];
 }
 
-void cpu_get_tb_cpu_state(CPUHexagonState *env, vaddr *pc,
-                          uint64_t *cs_base, uint32_t *flags)
+TCGTBCPUState cpu_get_tb_cpu_state(CPUState *cs)
 {
+    CPUHexagonState *env = cpu_env(cs);
+    vaddr pc = env->gpr[HEX_REG_PC];
     uint32_t hex_flags = 0;
-    *pc = env->gpr[HEX_REG_PC];
-    *cs_base = 0;
-    if (*pc == env->gpr[HEX_REG_SA0]) {
+
+    if (pc == env->gpr[HEX_REG_SA0]) {
         hex_flags = FIELD_DP32(hex_flags, TB_FLAGS, IS_TIGHT_LOOP, 1);
     }
-    *flags = hex_flags;
-    if (*pc & PCALIGN_MASK) {
+    if (pc & PCALIGN_MASK) {
         hexagon_raise_exception_err(env, HEX_CAUSE_PC_NOT_ALIGNED, 0);
     }
+
+    return (TCGTBCPUState){ .pc = pc, .flags = hex_flags };
 }
 
 static void hexagon_cpu_synchronize_from_tb(CPUState *cs,
diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index 4cdaf98ab1..40cbc191bb 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -51,11 +51,12 @@ static vaddr hppa_cpu_get_pc(CPUState *cs)
                          env->iaoq_f & -4);
 }
 
-void cpu_get_tb_cpu_state(CPUHPPAState *env, vaddr *pc,
-                          uint64_t *pcsbase, uint32_t *pflags)
+TCGTBCPUState cpu_get_tb_cpu_state(CPUState *cs)
 {
+    CPUHPPAState *env = cpu_env(cs);
     uint32_t flags = 0;
     uint64_t cs_base = 0;
+    vaddr pc;
 
     /*
      * TB lookup assumes that PC contains the complete virtual address.
@@ -63,7 +64,7 @@ void cpu_get_tb_cpu_state(CPUHPPAState *env, vaddr *pc,
      * incomplete virtual address.  This also means that we must separate
      * out current cpu privilege from the low bits of IAOQ_F.
      */
-    *pc = hppa_cpu_get_pc(env_cpu(env));
+    pc = hppa_cpu_get_pc(env_cpu(env));
     flags |= (env->iaoq_f & 3) << TB_FLAG_PRIV_SHIFT;
 
     /*
@@ -99,8 +100,7 @@ void cpu_get_tb_cpu_state(CPUHPPAState *env, vaddr *pc,
     }
 #endif
 
-    *pcsbase = cs_base;
-    *pflags = flags;
+    return (TCGTBCPUState){ .pc = pc, .flags = flags, .cs_base = cs_base };
 }
 
 static void hppa_cpu_synchronize_from_tb(CPUState *cs,
diff --git a/target/i386/tcg/tcg-cpu.c b/target/i386/tcg/tcg-cpu.c
index bb6f82befb..3004fb3023 100644
--- a/target/i386/tcg/tcg-cpu.c
+++ b/target/i386/tcg/tcg-cpu.c
@@ -48,18 +48,23 @@ static void x86_cpu_exec_exit(CPUState *cs)
     env->eflags = cpu_compute_eflags(env);
 }
 
-void cpu_get_tb_cpu_state(CPUX86State *env, vaddr *pc,
-                          uint64_t *cs_base, uint32_t *flags)
+TCGTBCPUState cpu_get_tb_cpu_state(CPUState *cs)
 {
-    *flags = env->hflags |
+    CPUX86State *env = cpu_env(cs);
+    uint32_t flags, cs_base;
+    vaddr pc;
+
+    flags = env->hflags |
         (env->eflags & (IOPL_MASK | TF_MASK | RF_MASK | VM_MASK | AC_MASK));
     if (env->hflags & HF_CS64_MASK) {
-        *cs_base = 0;
-        *pc = env->eip;
+        cs_base = 0;
+        pc = env->eip;
     } else {
-        *cs_base = env->segs[R_CS].base;
-        *pc = (uint32_t)(*cs_base + env->eip);
+        cs_base = env->segs[R_CS].base;
+        pc = (uint32_t)(cs_base + env->eip);
     }
+
+    return (TCGTBCPUState){ .pc = pc, .flags = flags, .cs_base = cs_base };
 }
 
 static void x86_cpu_synchronize_from_tb(CPUState *cs,
diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index be770b7e19..446cf43914 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -336,16 +336,18 @@ static bool loongarch_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
 }
 #endif
 
-void cpu_get_tb_cpu_state(CPULoongArchState *env, vaddr *pc,
-                          uint64_t *cs_base, uint32_t *flags)
+TCGTBCPUState cpu_get_tb_cpu_state(CPUState *cs)
 {
-    *pc = env->pc;
-    *cs_base = 0;
-    *flags = env->CSR_CRMD & (R_CSR_CRMD_PLV_MASK | R_CSR_CRMD_PG_MASK);
-    *flags |= FIELD_EX64(env->CSR_EUEN, CSR_EUEN, FPE) * HW_FLAGS_EUEN_FPE;
-    *flags |= FIELD_EX64(env->CSR_EUEN, CSR_EUEN, SXE) * HW_FLAGS_EUEN_SXE;
-    *flags |= FIELD_EX64(env->CSR_EUEN, CSR_EUEN, ASXE) * HW_FLAGS_EUEN_ASXE;
-    *flags |= is_va32(env) * HW_FLAGS_VA32;
+    CPULoongArchState *env = cpu_env(cs);
+    uint32_t flags;
+
+    flags = env->CSR_CRMD & (R_CSR_CRMD_PLV_MASK | R_CSR_CRMD_PG_MASK);
+    flags |= FIELD_EX64(env->CSR_EUEN, CSR_EUEN, FPE) * HW_FLAGS_EUEN_FPE;
+    flags |= FIELD_EX64(env->CSR_EUEN, CSR_EUEN, SXE) * HW_FLAGS_EUEN_SXE;
+    flags |= FIELD_EX64(env->CSR_EUEN, CSR_EUEN, ASXE) * HW_FLAGS_EUEN_ASXE;
+    flags |= is_va32(env) * HW_FLAGS_VA32;
+
+    return (TCGTBCPUState){ .pc = env->pc, .flags = flags };
 }
 
 static void loongarch_cpu_synchronize_from_tb(CPUState *cs,
diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index 2b4ec40509..b75ed6e887 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -23,6 +23,7 @@
 #include "cpu.h"
 #include "migration/vmstate.h"
 #include "fpu/softfloat.h"
+#include "exec/translation-block.h"
 #include "accel/tcg/cpu-ops.h"
 
 static void m68k_cpu_set_pc(CPUState *cs, vaddr value)
@@ -39,20 +40,22 @@ static vaddr m68k_cpu_get_pc(CPUState *cs)
     return cpu->env.pc;
 }
 
-void cpu_get_tb_cpu_state(CPUM68KState *env, vaddr *pc,
-                          uint64_t *cs_base, uint32_t *flags)
+TCGTBCPUState cpu_get_tb_cpu_state(CPUState *cs)
 {
-    *pc = env->pc;
-    *cs_base = 0;
-    *flags = (env->macsr >> 4) & TB_FLAGS_MACSR;
+    CPUM68KState *env = cpu_env(cs);
+    uint32_t flags;
+
+    flags = (env->macsr >> 4) & TB_FLAGS_MACSR;
     if (env->sr & SR_S) {
-        *flags |= TB_FLAGS_MSR_S;
-        *flags |= (env->sfc << (TB_FLAGS_SFC_S_BIT - 2)) & TB_FLAGS_SFC_S;
-        *flags |= (env->dfc << (TB_FLAGS_DFC_S_BIT - 2)) & TB_FLAGS_DFC_S;
+        flags |= TB_FLAGS_MSR_S;
+        flags |= (env->sfc << (TB_FLAGS_SFC_S_BIT - 2)) & TB_FLAGS_SFC_S;
+        flags |= (env->dfc << (TB_FLAGS_DFC_S_BIT - 2)) & TB_FLAGS_DFC_S;
     }
     if (M68K_SR_TRACE(env->sr) == M68K_SR_TRACE_ANY_INS) {
-        *flags |= TB_FLAGS_TRACE;
+        flags |= TB_FLAGS_TRACE;
     }
+
+    return (TCGTBCPUState){ .pc = env->pc, .flags = flags };
 }
 
 static void m68k_restore_state_to_opc(CPUState *cs,
diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index 105ede0b1e..72a0d0583c 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -95,12 +95,15 @@ static vaddr mb_cpu_get_pc(CPUState *cs)
     return cpu->env.pc;
 }
 
-void cpu_get_tb_cpu_state(CPUMBState *env, vaddr *pc,
-                          uint64_t *cs_base, uint32_t *flags)
+TCGTBCPUState cpu_get_tb_cpu_state(CPUState *cs)
 {
-    *pc = env->pc;
-    *flags = (env->iflags & IFLAGS_TB_MASK) | (env->msr & MSR_TB_MASK);
-    *cs_base = (*flags & IMM_FLAG ? env->imm : 0);
+    CPUMBState *env = cpu_env(cs);
+
+    return (TCGTBCPUState){
+        .pc = env->pc,
+        .flags = (env->iflags & IFLAGS_TB_MASK) | (env->msr & MSR_TB_MASK),
+        .cs_base = (env->iflags & IMM_FLAG ? env->imm : 0),
+    };
 }
 
 static void mb_cpu_synchronize_from_tb(CPUState *cs,
diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index ab00adf86b..b0f7612a64 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -549,13 +549,15 @@ static int mips_cpu_mmu_index(CPUState *cs, bool ifunc)
     return mips_env_mmu_index(cpu_env(cs));
 }
 
-void cpu_get_tb_cpu_state(CPUMIPSState *env, vaddr *pc,
-                          uint64_t *cs_base, uint32_t *flags)
+TCGTBCPUState cpu_get_tb_cpu_state(CPUState *cs)
 {
-    *pc = env->active_tc.PC;
-    *cs_base = 0;
-    *flags = env->hflags & (MIPS_HFLAG_TMASK | MIPS_HFLAG_BMASK |
-                            MIPS_HFLAG_HWRENA_ULR);
+    CPUMIPSState *env = cpu_env(cs);
+
+    return (TCGTBCPUState){
+        .pc = env->active_tc.PC,
+        .flags = env->hflags & (MIPS_HFLAG_TMASK | MIPS_HFLAG_BMASK |
+                                MIPS_HFLAG_HWRENA_ULR),
+    };
 }
 
 static const TCGCPUOps mips_tcg_ops = {
diff --git a/target/openrisc/cpu.c b/target/openrisc/cpu.c
index d798127d67..aba4639bbb 100644
--- a/target/openrisc/cpu.c
+++ b/target/openrisc/cpu.c
@@ -41,14 +41,16 @@ static vaddr openrisc_cpu_get_pc(CPUState *cs)
     return cpu->env.pc;
 }
 
-void cpu_get_tb_cpu_state(CPUOpenRISCState *env, vaddr *pc,
-                          uint64_t *cs_base, uint32_t *flags)
+TCGTBCPUState cpu_get_tb_cpu_state(CPUState *cs)
 {
-    *pc = env->pc;
-    *cs_base = 0;
-    *flags = (env->dflag ? TB_FLAGS_DFLAG : 0)
-           | (cpu_get_gpr(env, 0) ? 0 : TB_FLAGS_R0_0)
-           | (env->sr & (SR_SM | SR_DME | SR_IME | SR_OVE));
+    CPUOpenRISCState *env = cpu_env(cs);
+
+    return (TCGTBCPUState){
+        .pc = env->pc,
+        .flags = ((env->dflag ? TB_FLAGS_DFLAG : 0)
+                  | (cpu_get_gpr(env, 0) ? 0 : TB_FLAGS_R0_0)
+                  | (env->sr & (SR_SM | SR_DME | SR_IME | SR_OVE))),
+    };
 }
 
 static void openrisc_cpu_synchronize_from_tb(CPUState *cs,
diff --git a/target/ppc/helper_regs.c b/target/ppc/helper_regs.c
index 8d248bcbb9..ccaf2b0343 100644
--- a/target/ppc/helper_regs.c
+++ b/target/ppc/helper_regs.c
@@ -256,9 +256,9 @@ void hreg_update_pmu_hflags(CPUPPCState *env)
     env->hflags |= hreg_compute_pmu_hflags_value(env);
 }
 
-void cpu_get_tb_cpu_state(CPUPPCState *env, vaddr *pc,
-                          uint64_t *cs_base, uint32_t *flags)
+TCGTBCPUState cpu_get_tb_cpu_state(CPUState *cs)
 {
+    CPUPPCState *env = cpu_env(cs);
     uint32_t hflags_current = env->hflags;
 
 #ifdef CONFIG_DEBUG_TCG
@@ -270,9 +270,7 @@ void cpu_get_tb_cpu_state(CPUPPCState *env, vaddr *pc,
     }
 #endif
 
-    *pc = env->nip;
-    *cs_base = 0;
-    *flags = hflags_current;
+    return (TCGTBCPUState){ .pc = env->nip, .flags = hflags_current };
 }
 
 void cpu_interrupt_exittb(CPUState *cs)
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index e67de7dfe2..927153377e 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -98,17 +98,14 @@ static int riscv_cpu_mmu_index(CPUState *cs, bool ifetch)
     return riscv_env_mmu_index(cpu_env(cs), ifetch);
 }
 
-void cpu_get_tb_cpu_state(CPURISCVState *env, vaddr *pc,
-                          uint64_t *cs_base, uint32_t *pflags)
+TCGTBCPUState cpu_get_tb_cpu_state(CPUState *cs)
 {
+    CPURISCVState *env = cpu_env(cs);
     RISCVCPU *cpu = env_archcpu(env);
     RISCVExtStatus fs, vs;
     uint32_t flags = 0;
     bool pm_signext = riscv_cpu_virt_mem_enabled(env);
 
-    *pc = env->xl == MXL_RV32 ? env->pc & UINT32_MAX : env->pc;
-    *cs_base = 0;
-
     if (cpu->cfg.ext_zve32x) {
         /*
          * If env->vl equals to VLMAX, we can use generic vector operation
@@ -192,7 +189,10 @@ void cpu_get_tb_cpu_state(CPURISCVState *env, vaddr *pc,
     flags = FIELD_DP32(flags, TB_FLAGS, PM_PMM, riscv_pm_get_pmm(env));
     flags = FIELD_DP32(flags, TB_FLAGS, PM_SIGNEXTEND, pm_signext);
 
-    *pflags = flags;
+    return (TCGTBCPUState){
+        .pc = env->xl == MXL_RV32 ? env->pc & UINT32_MAX : env->pc,
+        .flags = flags
+    };
 }
 
 static void riscv_cpu_synchronize_from_tb(CPUState *cs,
diff --git a/target/rx/cpu.c b/target/rx/cpu.c
index e8b47be675..be778c9f65 100644
--- a/target/rx/cpu.c
+++ b/target/rx/cpu.c
@@ -44,13 +44,15 @@ static vaddr rx_cpu_get_pc(CPUState *cs)
     return cpu->env.pc;
 }
 
-void cpu_get_tb_cpu_state(CPURXState *env, vaddr *pc,
-                          uint64_t *cs_base, uint32_t *flags)
+TCGTBCPUState cpu_get_tb_cpu_state(CPUState *cs)
 {
-    *pc = env->pc;
-    *cs_base = 0;
-    *flags = FIELD_DP32(0, PSW, PM, env->psw_pm);
-    *flags = FIELD_DP32(*flags, PSW, U, env->psw_u);
+    CPURXState *env = cpu_env(cs);
+    uint32_t flags = 0;
+
+    flags = FIELD_DP32(flags, PSW, PM, env->psw_pm);
+    flags = FIELD_DP32(flags, PSW, U, env->psw_u);
+
+    return (TCGTBCPUState){ .pc = env->pc, .flags = flags };
 }
 
 static void rx_cpu_synchronize_from_tb(CPUState *cs,
diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index 435b2034ff..279289f265 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -309,9 +309,9 @@ static int s390x_cpu_mmu_index(CPUState *cs, bool ifetch)
     return s390x_env_mmu_index(cpu_env(cs), ifetch);
 }
 
-void cpu_get_tb_cpu_state(CPUS390XState *env, vaddr *pc,
-                          uint64_t *cs_base, uint32_t *pflags)
+TCGTBCPUState cpu_get_tb_cpu_state(CPUState *cs)
 {
+    CPUS390XState *env = cpu_env(cs);
     uint32_t flags;
 
     if (env->psw.addr & 1) {
@@ -323,9 +323,6 @@ void cpu_get_tb_cpu_state(CPUS390XState *env, vaddr *pc,
         tcg_s390_program_interrupt(env, PGM_SPECIFICATION, 0);
     }
 
-    *pc = env->psw.addr;
-    *cs_base = env->ex_value;
-
     flags = (env->psw.mask >> FLAG_MASK_PSW_SHIFT) & FLAG_MASK_PSW;
     if (env->psw.mask & PSW_MASK_PER) {
         flags |= env->cregs[9] & (FLAG_MASK_PER_BRANCH |
@@ -342,7 +339,12 @@ void cpu_get_tb_cpu_state(CPUS390XState *env, vaddr *pc,
     if (env->cregs[0] & CR0_VECTOR) {
         flags |= FLAG_MASK_VECTOR;
     }
-    *pflags = flags;
+
+    return (TCGTBCPUState){
+        .pc = env->psw.addr,
+        .flags = flags,
+        .cs_base = env->ex_value,
+    };
 }
 
 static const TCGCPUOps s390_tcg_ops = {
diff --git a/target/sh4/cpu.c b/target/sh4/cpu.c
index 5fb18bf55e..cbd43b55e5 100644
--- a/target/sh4/cpu.c
+++ b/target/sh4/cpu.c
@@ -43,19 +43,27 @@ static vaddr superh_cpu_get_pc(CPUState *cs)
     return cpu->env.pc;
 }
 
-void cpu_get_tb_cpu_state(CPUSH4State *env, vaddr *pc,
-                          uint64_t *cs_base, uint32_t *flags)
+TCGTBCPUState cpu_get_tb_cpu_state(CPUState *cs)
 {
-    *pc = env->pc;
-    /* For a gUSA region, notice the end of the region.  */
-    *cs_base = env->flags & TB_FLAG_GUSA_MASK ? env->gregs[0] : 0;
-    *flags = env->flags
+    CPUSH4State *env = cpu_env(cs);
+    uint32_t flags;
+
+    flags = env->flags
             | (env->fpscr & TB_FLAG_FPSCR_MASK)
             | (env->sr & TB_FLAG_SR_MASK)
             | (env->movcal_backup ? TB_FLAG_PENDING_MOVCA : 0); /* Bit 3 */
 #ifdef CONFIG_USER_ONLY
-    *flags |= TB_FLAG_UNALIGN * !env_cpu(env)->prctl_unalign_sigbus;
+    flags |= TB_FLAG_UNALIGN * !cs->prctl_unalign_sigbus;
 #endif
+
+    return (TCGTBCPUState){
+        .pc = env->pc,
+        .flags = flags,
+#ifdef CONFIG_USER_ONLY
+        /* For a gUSA region, notice the end of the region.  */
+        .cs_base = flags & TB_FLAG_GUSA_MASK ? env->gregs[0] : 0,
+#endif
+    };
 }
 
 static void superh_cpu_synchronize_from_tb(CPUState *cs,
diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index bbdea8556a..6166b81f71 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -716,13 +716,11 @@ static void sparc_cpu_synchronize_from_tb(CPUState *cs,
     cpu->env.npc = tb->cs_base;
 }
 
-void cpu_get_tb_cpu_state(CPUSPARCState *env, vaddr *pc,
-                          uint64_t *cs_base, uint32_t *pflags)
+TCGTBCPUState cpu_get_tb_cpu_state(CPUState *cs)
 {
-    uint32_t flags;
-    *pc = env->pc;
-    *cs_base = env->npc;
-    flags = cpu_mmu_index(env_cpu(env), false);
+    CPUSPARCState *env = cpu_env(cs);
+    uint32_t flags = cpu_mmu_index(cs, false);
+
 #ifndef CONFIG_USER_ONLY
     if (cpu_supervisor_mode(env)) {
         flags |= TB_FLAG_SUPER;
@@ -751,7 +749,12 @@ void cpu_get_tb_cpu_state(CPUSPARCState *env, vaddr *pc,
     }
 #endif /* !CONFIG_USER_ONLY */
 #endif /* TARGET_SPARC64 */
-    *pflags = flags;
+
+    return (TCGTBCPUState){
+        .pc = env->pc,
+        .flags = flags,
+        .cs_base = env->npc,
+    };
 }
 
 static void sparc_restore_state_to_opc(CPUState *cs,
diff --git a/target/tricore/cpu.c b/target/tricore/cpu.c
index 81b3bb6362..1151a812b6 100644
--- a/target/tricore/cpu.c
+++ b/target/tricore/cpu.c
@@ -45,16 +45,14 @@ static vaddr tricore_cpu_get_pc(CPUState *cs)
     return cpu_env(cs)->PC;
 }
 
-void cpu_get_tb_cpu_state(CPUTriCoreState *env, vaddr *pc,
-                          uint64_t *cs_base, uint32_t *flags)
+TCGTBCPUState cpu_get_tb_cpu_state(CPUState *cs)
 {
-    uint32_t new_flags = 0;
-    *pc = env->PC;
-    *cs_base = 0;
+    CPUTriCoreState *env = cpu_env(cs);
 
-    new_flags |= FIELD_DP32(new_flags, TB_FLAGS, PRIV,
-            extract32(env->PSW, 10, 2));
-    *flags = new_flags;
+    return (TCGTBCPUState){
+        .pc = env->PC,
+        .flags = FIELD_DP32(0, TB_FLAGS, PRIV, extract32(env->PSW, 10, 2)),
+    };
 }
 
 static void tricore_cpu_synchronize_from_tb(CPUState *cs,
diff --git a/target/xtensa/cpu.c b/target/xtensa/cpu.c
index c78ef9421c..431b7ebd7b 100644
--- a/target/xtensa/cpu.c
+++ b/target/xtensa/cpu.c
@@ -55,15 +55,15 @@ static vaddr xtensa_cpu_get_pc(CPUState *cs)
     return cpu->env.pc;
 }
 
-void cpu_get_tb_cpu_state(CPUXtensaState *env, vaddr *pc,
-                          uint64_t *cs_base, uint32_t *flags)
+TCGTBCPUState cpu_get_tb_cpu_state(CPUState *cs)
 {
-    *pc = env->pc;
-    *cs_base = 0;
-    *flags = 0;
-    *flags |= xtensa_get_ring(env);
+    CPUXtensaState *env = cpu_env(cs);
+    uint32_t flags = 0;
+    target_ulong cs_base = 0;
+
+    flags |= xtensa_get_ring(env);
     if (env->sregs[PS] & PS_EXCM) {
-        *flags |= XTENSA_TBFLAG_EXCM;
+        flags |= XTENSA_TBFLAG_EXCM;
     } else if (xtensa_option_enabled(env->config, XTENSA_OPTION_LOOP)) {
         target_ulong lend_dist =
             env->sregs[LEND] - (env->pc & -(1u << TARGET_PAGE_BITS));
@@ -85,26 +85,26 @@ void cpu_get_tb_cpu_state(CPUXtensaState *env, vaddr *pc,
         if (lend_dist < (1u << TARGET_PAGE_BITS) + env->config->max_insn_size) {
             target_ulong lbeg_off = env->sregs[LEND] - env->sregs[LBEG];
 
-            *cs_base = lend_dist;
+            cs_base = lend_dist;
             if (lbeg_off < 256) {
-                *cs_base |= lbeg_off << XTENSA_CSBASE_LBEG_OFF_SHIFT;
+                cs_base |= lbeg_off << XTENSA_CSBASE_LBEG_OFF_SHIFT;
             }
         }
     }
     if (xtensa_option_enabled(env->config, XTENSA_OPTION_EXTENDED_L32R) &&
             (env->sregs[LITBASE] & 1)) {
-        *flags |= XTENSA_TBFLAG_LITBASE;
+        flags |= XTENSA_TBFLAG_LITBASE;
     }
     if (xtensa_option_enabled(env->config, XTENSA_OPTION_DEBUG)) {
         if (xtensa_get_cintlevel(env) < env->config->debug_level) {
-            *flags |= XTENSA_TBFLAG_DEBUG;
+            flags |= XTENSA_TBFLAG_DEBUG;
         }
         if (xtensa_get_cintlevel(env) < env->sregs[ICOUNTLEVEL]) {
-            *flags |= XTENSA_TBFLAG_ICOUNT;
+            flags |= XTENSA_TBFLAG_ICOUNT;
         }
     }
     if (xtensa_option_enabled(env->config, XTENSA_OPTION_COPROCESSOR)) {
-        *flags |= env->sregs[CPENABLE] << XTENSA_TBFLAG_CPENABLE_SHIFT;
+        flags |= env->sregs[CPENABLE] << XTENSA_TBFLAG_CPENABLE_SHIFT;
     }
     if (xtensa_option_enabled(env->config, XTENSA_OPTION_WINDOWED_REGISTER) &&
         (env->sregs[PS] & (PS_WOE | PS_EXCM)) == PS_WOE) {
@@ -112,15 +112,21 @@ void cpu_get_tb_cpu_state(CPUXtensaState *env, vaddr *pc,
             (env->sregs[WINDOW_BASE] + 1);
         uint32_t w = ctz32(windowstart | 0x8);
 
-        *flags |= (w << XTENSA_TBFLAG_WINDOW_SHIFT) | XTENSA_TBFLAG_CWOE;
-        *flags |= extract32(env->sregs[PS], PS_CALLINC_SHIFT,
+        flags |= (w << XTENSA_TBFLAG_WINDOW_SHIFT) | XTENSA_TBFLAG_CWOE;
+        flags |= extract32(env->sregs[PS], PS_CALLINC_SHIFT,
                             PS_CALLINC_LEN) << XTENSA_TBFLAG_CALLINC_SHIFT;
     } else {
-        *flags |= 3 << XTENSA_TBFLAG_WINDOW_SHIFT;
+        flags |= 3 << XTENSA_TBFLAG_WINDOW_SHIFT;
     }
     if (env->yield_needed) {
-        *flags |= XTENSA_TBFLAG_YIELD;
+        flags |= XTENSA_TBFLAG_YIELD;
     }
+
+    return (TCGTBCPUState){
+        .pc = env->pc,
+        .flags = flags,
+        .cs_base = cs_base,
+    };
 }
 
 static void xtensa_restore_state_to_opc(CPUState *cs,
-- 
2.43.0


