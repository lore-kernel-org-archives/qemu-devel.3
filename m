Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12F88C369D5
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 20:12:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9UoM-0005AJ-Ov; Mon, 28 Apr 2025 16:10:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u9UoK-000597-7c
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 16:10:40 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u9UoG-0000d8-MS
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 16:10:39 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-7369ce5d323so4342174b3a.1
 for <qemu-devel@nongnu.org>; Mon, 28 Apr 2025 13:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745871035; x=1746475835; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Euuw7vRLlECbRToI2wToD7v5PcT3Tt4xvVhWvmexFBc=;
 b=A61uohbhT2ozdX530Fm1LNbkKsvkomyWvZONSgkMQbnO4EcuWYY8qCA69s6/RdaPBE
 DWpPuOw56hxsv1CkQ0+griwBaQAqc6yE0iIE0fbphEnJ8cAxvqH0Nl7NgLIUbqlH/oJ0
 SrjcnMadjr0aul/vlblA2Us8SASJ+iXfFM5vT694BspW+LQaI5WA/By7YJDrGdrThdfr
 jRmSZOU7zdTyZ32BRwi49widSJFsznvzoLoCR3ey35Maho2IVGyGljsoro3TDSvbhEc2
 7X/RVqMTgw2hH1U+ZNDnSpwFEtnS/OXBb99jbIO4UaC4bccZKxu9Q0ns7aPGafVMKmuh
 QKSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745871035; x=1746475835;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Euuw7vRLlECbRToI2wToD7v5PcT3Tt4xvVhWvmexFBc=;
 b=irNoh2livp/7ZUZSdv2HvOxKndVUrGavQu9yUritpXg4G2axXsXoNnXWE7UCXIy0un
 tdS1uJ2AT/wPQanxM9tzgACcVJiLt3JUvbDA0qCHhTx+rFTlp9CP0lFz/yNwtGo6ewmZ
 FOjZyUSvc9lC7kIvzorMq3MrrBfNFpS567U7lDh7nHoTFuOh/3seC6L9kagcs4SD3ARj
 145IpRhcHFPlHc9OT2JWEG+SGHdNWJxlWoxFwiuwFHWqbfOjkieC96jeRHHGWgYi9Iyf
 PpcLTF95ye9qCqCcPl1wBLU1QSjWS3ms+akHNpCxQOR99cTB6rcGNALV268vhulbPAFD
 azuA==
X-Gm-Message-State: AOJu0YzRwlTdQZh0MKSDmw4fBN3kQOZ27C/tuBtHtR6DXKQgWkCAhKMX
 7HQDBSWd0SFgpNmzdO99oaSFshcifoYvT/QwHJmg0Cc5cEbAH1UBxiTWBJZ0RITUKPde11+KeLw
 /
X-Gm-Gg: ASbGncvl5R3AyvN3Ag3Yz4s6bRasPL++ZfTdc9ZsN29nMAZvQYor8/T0KJz2f2N7A4c
 nQXyXCVBEJVJdc3hFc/j+zU49fvfJq8IbxHa6b4cdVyYJdho/JFnJGfWa5fc8uJ31XShGqC4wXx
 TLXL870nKt806mz92B2Gh56SW+86tuqYfEmn8AeZB+jPEnVX9fg0RbRyhF3mQPlZEg932zBKar9
 7oZnegC0sy9C1uJruua7kU+5F/YYZfnD/09Nfm1+bfIIhQLI84U/zQXGHPU97lyZPwdt7gVlzSU
 rzcJ/8e1XWRF4M5Sf4qV6ZLfBGj5LTZ6s1fxRw92ygV6jALMehH+IzyTDyfVOrC0jOLeMPJHuK7
 hvoLNMNB3DA==
X-Google-Smtp-Source: AGHT+IEQicDMprqArAUu3GW6CFaz3h3OtYTuO465UMtiylMTJLO57ArZIcMoRFXt09Afz6Blx3gLtg==
X-Received: by 2002:aa7:88cb:0:b0:739:50c0:b3fe with SMTP id
 d2e1a72fcca58-74027139a2cmr1847271b3a.8.1745871035107; 
 Mon, 28 Apr 2025 13:10:35 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25912fb9sm8469976b3a.34.2025.04.28.13.10.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Apr 2025 13:10:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org,
	philmd@linaro.org
Subject: [PATCH 07/10] accel/tcg: Return TCGTBCPUState from
 cpu_get_tb_cpu_state
Date: Mon, 28 Apr 2025 13:10:25 -0700
Message-ID: <20250428201028.1699157-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250428201028.1699157-1-richard.henderson@linaro.org>
References: <20250428201028.1699157-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/internal-common.h |  6 +++++
 include/accel/tcg/cpu-ops.h |  9 +++++--
 include/qemu/typedefs.h     |  1 +
 accel/tcg/cpu-exec.c        | 48 +++++++++++++++----------------------
 accel/tcg/translate-all.c   |  8 ++-----
 target/alpha/cpu.c          | 13 +++++-----
 target/arm/helper.c         | 16 ++++++++-----
 target/avr/cpu.c            |  9 +++----
 target/hexagon/cpu.c        | 15 ++++++------
 target/hppa/cpu.c           | 10 ++++----
 target/i386/tcg/tcg-cpu.c   | 19 +++++++++------
 target/loongarch/cpu.c      | 20 +++++++++-------
 target/m68k/cpu.c           | 20 +++++++++-------
 target/microblaze/cpu.c     | 13 ++++++----
 target/mips/cpu.c           | 14 ++++++-----
 target/openrisc/cpu.c       | 16 +++++++------
 target/ppc/helper_regs.c    |  8 +++----
 target/riscv/tcg/tcg-cpu.c  | 12 +++++-----
 target/rx/cpu.c             | 14 ++++++-----
 target/s390x/cpu.c          | 14 ++++++-----
 target/sh4/cpu.c            | 22 +++++++++++------
 target/sparc/cpu.c          | 17 +++++++------
 target/tricore/cpu.c        | 14 +++++------
 target/xtensa/cpu.c         | 36 +++++++++++++++-------------
 24 files changed, 202 insertions(+), 172 deletions(-)

diff --git a/accel/tcg/internal-common.h b/accel/tcg/internal-common.h
index 98c702422f..3ff4c1cb54 100644
--- a/accel/tcg/internal-common.h
+++ b/accel/tcg/internal-common.h
@@ -12,6 +12,7 @@
 #include "exec/cpu-common.h"
 #include "exec/translation-block.h"
 #include "exec/mmap-lock.h"
+#include "accel/tcg/cpu-ops.h"
 
 extern int64_t max_delay;
 extern int64_t max_advance;
@@ -56,6 +57,11 @@ TranslationBlock *tb_link_page(TranslationBlock *tb);
 void cpu_restore_state_from_tb(CPUState *cpu, TranslationBlock *tb,
                                uintptr_t host_pc);
 
+static inline TCGTBCPUState get_tb_cpu_state(CPUState *cs)
+{
+    return cpu_get_tb_cpu_state(cs);
+}
+
 /**
  * tlb_init - initialize a CPU's TLB
  * @cpu: CPU whose TLB should be initialized
diff --git a/include/accel/tcg/cpu-ops.h b/include/accel/tcg/cpu-ops.h
index f5e5746976..8dbe79ea7c 100644
--- a/include/accel/tcg/cpu-ops.h
+++ b/include/accel/tcg/cpu-ops.h
@@ -18,8 +18,13 @@
 #include "exec/vaddr.h"
 #include "tcg/tcg-mo.h"
 
-void cpu_get_tb_cpu_state(CPUArchState *env, vaddr *pc,
-                          uint64_t *cs_base, uint32_t *flags);
+struct TCGTBCPUState {
+    vaddr pc;
+    uint32_t flags;
+    uint64_t flags2;
+};
+
+TCGTBCPUState cpu_get_tb_cpu_state(CPUState *cs);
 
 struct TCGCPUOps {
     /**
diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
index 507f0814d5..551239ca61 100644
--- a/include/qemu/typedefs.h
+++ b/include/qemu/typedefs.h
@@ -114,6 +114,7 @@ typedef struct SHPCDevice SHPCDevice;
 typedef struct SSIBus SSIBus;
 typedef struct TCGCPUOps TCGCPUOps;
 typedef struct TCGHelperInfo TCGHelperInfo;
+typedef struct TCGTBCPUState TCGTBCPUState;
 typedef struct TaskState TaskState;
 typedef struct TranslationBlock TranslationBlock;
 typedef struct VirtIODevice VirtIODevice;
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index c21c5d202d..a48df5f291 100644
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
+    TCGTBCPUState s = get_tb_cpu_state(cpu);
+    uint32_t cflags = curr_cflags(cpu);
+
+    if (check_for_breakpoints(cpu, s.pc, &cflags)) {
         cpu_loop_exit(cpu);
     }
 
-    tb = tb_lookup(cpu, pc, cs_base, flags, cflags);
+    tb = tb_lookup(cpu, s.pc, s.flags2, s.flags, cflags);
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
@@ -573,9 +567,9 @@ void cpu_exec_step_atomic(CPUState *cpu)
         g_assert(!cpu->running);
         cpu->running = true;
 
-        cpu_get_tb_cpu_state(env, &pc, &cs_base, &flags);
+        TCGTBCPUState s = get_tb_cpu_state(cpu);
+        uint32_t cflags = curr_cflags(cpu);
 
-        cflags = curr_cflags(cpu);
         /* Execute in a serial context. */
         cflags &= ~CF_PARALLEL;
         /* After 1 insn, return and release the exclusive lock. */
@@ -587,16 +581,16 @@ void cpu_exec_step_atomic(CPUState *cpu)
          * Any breakpoint for this insn will have been recognized earlier.
          */
 
-        tb = tb_lookup(cpu, pc, cs_base, flags, cflags);
+        tb = tb_lookup(cpu, s.pc, s.flags2, s.flags, cflags);
         if (tb == NULL) {
             mmap_lock();
-            tb = tb_gen_code(cpu, pc, cs_base, flags, cflags);
+            tb = tb_gen_code(cpu, s.pc, s.flags2, s.flags, cflags);
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
+            TCGTBCPUState s =  get_tb_cpu_state(cpu);
+            uint32_t cflags = cpu->cflags_next_tb;
 
             /*
              * When requested, use an exact setting for cflags for the next
@@ -954,33 +945,32 @@ cpu_exec_loop(CPUState *cpu, SyncClocks *sc)
              * have CF_INVALID set, -1 is a convenient invalid value that
              * does not require tcg headers for cpu_common_reset.
              */
-            cflags = cpu->cflags_next_tb;
             if (cflags == -1) {
                 cflags = curr_cflags(cpu);
             } else {
                 cpu->cflags_next_tb = -1;
             }
 
-            if (check_for_breakpoints(cpu, pc, &cflags)) {
+            if (check_for_breakpoints(cpu, s.pc, &cflags)) {
                 break;
             }
 
-            tb = tb_lookup(cpu, pc, cs_base, flags, cflags);
+            tb = tb_lookup(cpu, s.pc, s.flags2, s.flags, cflags);
             if (tb == NULL) {
                 CPUJumpCache *jc;
                 uint32_t h;
 
                 mmap_lock();
-                tb = tb_gen_code(cpu, pc, cs_base, flags, cflags);
+                tb = tb_gen_code(cpu, s.pc, s.flags2, s.flags, cflags);
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
index 31c7f9927f..759ae77559 100644
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
+        TCGTBCPUState s = get_tb_cpu_state(cpu);
+        tb_page_addr_t addr = get_page_addr_code(env, s.pc);
 
-        cpu_get_tb_cpu_state(env, &pc, &cs_base, &flags);
-        addr = get_page_addr_code(env, pc);
         if (addr != -1) {
             tb_invalidate_phys_range(cpu, addr, addr);
         }
diff --git a/target/alpha/cpu.c b/target/alpha/cpu.c
index d1fddef1f4..6efaa71543 100644
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
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 98adeb7086..aa887af50f 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -11453,21 +11453,22 @@ static bool mve_no_pred(CPUARMState *env)
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
@@ -11529,8 +11530,11 @@ void cpu_get_tb_cpu_state(CPUARMState *env, vaddr *pc,
         DP_TBFLAG_ANY(flags, PSTATE__SS, 1);
     }
 
-    *pflags = flags.flags;
-    *cs_base = flags.flags2;
+    return (TCGTBCPUState){
+        .pc = pc,
+        .flags = flags.flags,
+        .flags2 = flags.flags2,
+    };
 }
 
 #ifdef TARGET_AARCH64
diff --git a/target/avr/cpu.c b/target/avr/cpu.c
index fac8954c39..88a4b970df 100644
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
index e1a93ce24f..08c9aef55e 100644
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
index 24ca2d7175..7270b0a2a7 100644
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
+    return (TCGTBCPUState){ .pc = pc, .flags = flags, .flags2 = cs_base };
 }
 
 static void hppa_cpu_synchronize_from_tb(CPUState *cs,
diff --git a/target/i386/tcg/tcg-cpu.c b/target/i386/tcg/tcg-cpu.c
index cf9ce70139..950b3bfa76 100644
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
+    return (TCGTBCPUState){ .pc = pc, .flags = flags, .flags2 = cs_base };
 }
 
 static void x86_cpu_synchronize_from_tb(CPUState *cs,
diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index db66a6bdeb..1691fe1d9f 100644
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
index 0fc3ed316d..1786d9e0ce 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -39,20 +39,22 @@ static vaddr m68k_cpu_get_pc(CPUState *cs)
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
index a91844e4bf..91e77a4e53 100644
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
+        .flags2 = (env->iflags & IMM_FLAG ? env->imm : 0),
+    };
 }
 
 static void mb_cpu_synchronize_from_tb(CPUState *cs,
diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index 066dadc71b..c514202fbc 100644
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
index cfb3f62663..6b31f9c80e 100644
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
index f2cacef5e5..461b8c97b4 100644
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
index f22737865e..b8bba1a0c7 100644
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
index 3ca3f880a7..127574c085 100644
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
+        .flags2 = env->ex_value
+    };
 }
 
 static const TCGCPUOps s390_tcg_ops = {
diff --git a/target/sh4/cpu.c b/target/sh4/cpu.c
index adbd59cd68..320cb8ddcc 100644
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
+        .flags2 = flags & TB_FLAG_GUSA_MASK ? env->gregs[0] : 0,
+#endif
+    };
 }
 
 static void superh_cpu_synchronize_from_tb(CPUState *cs,
diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index 5a1f5b7915..77591e84ba 100644
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
+        .flags2 = env->npc,
+    };
 }
 
 static void sparc_restore_state_to_opc(CPUState *cs,
diff --git a/target/tricore/cpu.c b/target/tricore/cpu.c
index 8538066114..fdc2012d16 100644
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
index fe974e90f7..4a8de9f42c 100644
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
@@ -112,15 +112,17 @@ void cpu_get_tb_cpu_state(CPUXtensaState *env, vaddr *pc,
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
+    return (TCGTBCPUState){ .pc = env->pc, .flags = flags, .flags2 = cs_base };
 }
 
 static void xtensa_restore_state_to_opc(CPUState *cs,
-- 
2.43.0


