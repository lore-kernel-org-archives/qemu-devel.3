Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D0FDC5DF82
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 17:45:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwNqS-0002xB-5g; Tue, 18 Aug 2026 13:43:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wwNqK-0002vv-Ho
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 13:43:23 -0400
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wwNqE-000811-Po
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 13:43:18 -0400
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-836c5b01e82so3409217b3.0
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 10:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787074990; x=1787679790; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/Q8w9k9lV2JrwiLBsWz2gBgu1b79v9MQACncuAAjwkE=;
 b=Q3Q20pYCNapVgwKFmR9y9amjm21b30E0X2dxULspDDFQ6fjJ/Tz9GJdtG2GWlCY6wX
 UkN0ZHGEf4k8A0o1ViRq4pPqn+I5q8L/PtMhF8l5PLNc4pZ+/fR7IVHIFBJcuF41Li6H
 Q12nP5TKexURpC2dTAn07WpdONkt9ibetgLNCaOCY0YiBW6fYr6q1OOMt/+Mi9I80TIG
 PxAAFDffCbZtRuNAj6+p85h/N2NB6mKpFnMg7ff6ZyqbjUZpiKCbqWeBptNLW4eMEZ0u
 AnEyEnJUCy6SOB+T4A5ScEj7twUuz7pg9HvU3E1bRNvWG71ilFMqyiSwEIu882svqMn3
 PhBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787074990; x=1787679790;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=/Q8w9k9lV2JrwiLBsWz2gBgu1b79v9MQACncuAAjwkE=;
 b=sPW5O3WuwQigOQzCN7WgvxocwzbfbQOklnldH28M6unKa/dI0WiqgbmKfzgK3E4enc
 PvzV1fQeIr436wNRWqnwHpYNsxpk43bV0fUJ4gbRcdk5m6jPuOBEvzG0CAFLOljyWP9a
 r4kri+teGMtsXuQIjNQqml5XD1s4zYZb3lVpZFlnhF/9hCGgd2gfzTefGdJJO0YTRlEd
 SdOw0cQb9Ugfg8n1KoqVJYv9I4yO15ZZOdr8ASLBiEzv4RKKU4ojf9RDVzfsOCPbH1kI
 Wi+ZVMqOZaDpbGrjAogdrPoxf4NK7PHlTscWzEPhUf1ZCfVT335e/sEgYnDTlkpclXeG
 B+pg==
X-Gm-Message-State: AOJu0Yyih9eTl6mG39AFstsTUMtO1ZczqCOrt9ap7tYBCsNrJHnJJxdP
 bI6IzUr/kYT/f9CQzuTGHGy0wFJqBR7yaPpZ/d8sj6Y+863S4QD+fIzvulPtLYKWY44=
X-Gm-Gg: AR+sD11ia5jaLcZrIzw1QneUAmUndcXmWUeCguN5gS5nxWmSAD8fYWGvwWSMrjLujGb
 LHMESUllkzSaUi9fgmsNh88UeUdtFnjCZ3GyHTOZBNmfBX0B8DPCia/RYCQOpIDVI8QPC/ZH47v
 IxSG8huS3AbzaRVd1mU2FAf74NQqP9gjBAN9MnvlyS9wCowK8HPhsK9HeSFoHQXkQerZ3uAaqSa
 ePYBL9+jWSuQcFc+BBmrWr9PrfJy2s0yN7X4hWShCSutqNJjvDyfYzdKJ4bkOo6uD2w3+njMxl/
 Xm6kyBTY3uOwOgRtSg9hD049AQ4Sn8QiXPhzk6fPuAPpPYzBOK9XZQCOSX8QHI2k2CtMIKLk3eR
 dcWN13VJUDh6K0UkBB63jWU93PQ8205cB/iNRhkgzSh4QBt9T1z2c54dY/CJe0usIUjSzSdxfva
 hqwrQnEBw97Vo/boL85ZE3wfv5BZejtr7SM5kvy7Tuvr/44zZVSX/H889zIW8WYEI9MQOX5zQC
X-Received: by 2002:a05:690c:e28b:20b0:81d:a225:ecc0 with SMTP id
 00721157ae682-841316581e9mr32565097b3.27.1787074989676; 
 Tue, 18 Aug 2026 10:43:09 -0700 (PDT)
Received: from localhost ([2600:1702:7a90:6f9f:8bc4:8aec:108d:7a04])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-840f25bed4csm22573147b3.29.2026.08.18.10.43.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 10:43:08 -0700 (PDT)
From: Matt Turner <mattst88@gmail.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, pbonzini@redhat.com, philmd@mailo.com,
 zhao1.liu@intel.com, laurent@vivier.eu, deller@gmx.de,
 pierrick.bouvier@oss.qualcomm.com, Matt Turner <mattst88@gmail.com>
Subject: [PATCH 7/8] RFC: accel/tcg: poison the jump cache instead of polling
 for indirect exits
Date: Tue, 18 Aug 2026 13:42:46 -0400
Message-ID: <20260818174247.649526-8-mattst88@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260818174247.649526-1-mattst88@gmail.com>
References: <20260818174247.649526-1-mattst88@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::112f;
 envelope-from=mattst88@gmail.com; helo=mail-yw1-x112f.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

f799aeecff dropped the icount_decr poll from blocks that cannot close a
control flow cycle. What is left is dominated by blocks that end in an
indirect branch: tcg_gen_lookup_and_goto_ptr{,_inline}() set
exit_check_needed, because the destination is unknown at translation time
and so the block might be part of a cycle. For the emulated compiler that
is still 55.5% of translated blocks and 51.2% of generated-code cycles, and
the two leading instructions of those blocks

    mov  -0x10(%rbp),%ebx
    test %ebx,%ebx

carry 5.01% of all cycles spent in generated code, measured with cycles:pp
so that the figure is not just skid from the dispatch that jumped there.

A block dispatching indirectly does not need to poll, because the dispatch
itself can be made to notice. The out-of-line path already calls
helper_lookup_tb_ptr() every time, so it only needs the helper to return the
epilogue while an exit is pending. The inline probe added by 14c3e5a1f3 is
the interesting case: it already loads the jump cache base from
CPUState and already branches to the slow path when the entry it finds has
a NULL tb. Pointing that base at a page of zeroes therefore turns every
indirect dispatch into a miss, and a miss lands in the same helper. The poll
becomes a pointer swap on the exit request path and costs the fast path
nothing.

So give the probe its own base pointer, tb_jmp_cache_probe, that nothing
else reads. The two places that set icount_decr.u16.high poison it; the
place that clears the flag restores it. The real tb_jmp_cache is untouched
throughout, so no cache contents are lost and the recovery is one store.

Blocks with a backward goto_tb edge still poll. Interrupt latency is
unchanged in kind: an exit is noticed at the next cycle-closing edge, which
is now either a poll or a dispatch, rather than only a poll.

Measured on an x86-64 host, LTO build, on top of the preceding patches. The
control was measured in the same session, because the host's all-core turbo
varies by ~3% between sessions and swamps the effect otherwise:

    before: 810,079,619,264 instructions, 79.563s
    after:  787,483,360,681 instructions, 78.019s
                                          -2.79% instructions, -1.94% wall

Forcing the check off entirely, which is incorrect but is the ceiling, gives
-5.64% instructions and -2.55% wall. So this takes half the instructions and
three quarters of the time: what it removes sits directly after an indirect
branch, where the poll's dependent load was the most expensive place a poll
could be.

In a jitdump profile of the same workload, blocks opening with the poll fall
from 55.5% to 25.9%, cycles in blocks that poll from 51.2% to 18.5%, and
cycles on the two poll instructions from 5.01% to 1.50%.

tests/tcg/alpha/test-indirect-irq.c is added for this: a loop whose only back
edge is an indirect branch, under alarm(1). It passes before and after, and
hangs if the check is simply deleted, which is what makes it a test of the
new mechanism rather than of the old poll. The other alpha tests still pass
and the emulated compiler still produces byte-identical output.

RFC because:

- The restore in cpu_handle_interrupt() races a concurrent poison from
  another thread. The existing barrier around icount_decr.u16.high covers
  it -- a poison that lands after the restore also re-set the flag, and
  exit_request was stored before it -- but this deserves more eyes than the
  single-threaded user-mode testing I have given it.
- Only the inline probe needs the poison, and only alpha uses the inline
  probe today. Targets on the out-of-line path are covered by the helper
  check alone, but that has not been measured.
- The shared zero-filled CPUJumpCache is a 1MB allocation that is never
  written. A read-only mapping would express that better.

Signed-off-by: Matt Turner <mattst88@gmail.com>
---
 accel/tcg/cpu-exec.c                | 54 +++++++++++++++++++++++++++++
 accel/tcg/internal-common.h         |  3 ++
 accel/tcg/tcg-accel-ops.c           |  2 ++
 accel/tcg/translator.c              |  4 +--
 include/hw/core/cpu.h               | 10 ++++++
 include/tcg/tcg.h                   |  2 --
 tcg/tcg-op.c                        | 13 +++++--
 tests/tcg/alpha/Makefile.target     |  3 +-
 tests/tcg/alpha/test-indirect-irq.c | 53 ++++++++++++++++++++++++++++
 9 files changed, 135 insertions(+), 9 deletions(-)
 create mode 100644 tests/tcg/alpha/test-indirect-irq.c

diff --git ./accel/tcg/cpu-exec.c ./accel/tcg/cpu-exec.c
index 257211235d..af466ca14e 100644
--- ./accel/tcg/cpu-exec.c
+++ ./accel/tcg/cpu-exec.c
@@ -388,6 +388,16 @@ const void *HELPER(lookup_tb_ptr)(CPUArchState *env)
      */
     cpu->neg.can_do_io = true;
 
+    /*
+     * A block that dispatches indirectly does not emit the icount_decr poll,
+     * so this is where a pending exit is noticed for that path: either the
+     * probe was poisoned and every dispatch arrives here, or the target uses
+     * the out-of-line lookup and always did.
+     */
+    if (unlikely(cpu_loop_exit_requested(cpu))) {
+        return tcg_code_gen_epilogue;
+    }
+
     TCGTBCPUState s = cpu->cc->tcg_ops->get_tb_cpu_state(cpu);
     s.cflags = curr_cflags(cpu);
 
@@ -752,6 +762,44 @@ static inline bool cpu_handle_exception(CPUState *cpu, int *ret)
     return false;
 }
 
+/*
+ * The inline jump cache probe reads cpu->tb_jmp_cache_probe and takes the
+ * slow path when the entry it finds has a NULL tb. Pointing the probe at a
+ * region that is all zeroes therefore forces every indirect dispatch into
+ * helper_lookup_tb_ptr(), which returns to the main loop while an exit is
+ * pending. That is what lets a block ending in an indirect branch skip the
+ * icount_decr poll: the poll's job is done by a pointer swap that costs the
+ * fast path nothing.
+ *
+ * Only ever read from, and only the tb field of one entry per dispatch, so
+ * one shared zero-filled cache is enough for every CPU.
+ */
+static const CPUJumpCache *tb_jmp_cache_poison(void)
+{
+    static CPUJumpCache *poison;
+
+    if (unlikely(poison == NULL)) {
+        /* Raced allocations are harmless: both are all zeroes. */
+        qatomic_cmpxchg(&poison, NULL, g_new0(CPUJumpCache, 1));
+    }
+    return poison;
+}
+
+void tcg_cpu_poison_jmp_cache(CPUState *cpu)
+{
+    if (qatomic_read(&cpu->tb_jmp_cache_probe) != NULL) {
+        qatomic_set(&cpu->tb_jmp_cache_probe,
+                    (CPUJumpCache *)tb_jmp_cache_poison());
+    }
+}
+
+void tcg_cpu_restore_jmp_cache(CPUState *cpu)
+{
+    if (qatomic_read(&cpu->tb_jmp_cache_probe) != NULL) {
+        qatomic_set(&cpu->tb_jmp_cache_probe, cpu->tb_jmp_cache);
+    }
+}
+
 void tcg_kick_vcpu_thread(CPUState *cpu)
 {
     /*
@@ -764,6 +812,9 @@ void tcg_kick_vcpu_thread(CPUState *cpu)
 
     /* Ensure cpu_exec will see the exit request after TCG has exited.  */
     qatomic_store_release(&cpu->neg.icount_decr.u16.high, -1);
+
+    /* Blocks that only dispatch indirectly do not poll; stop them chaining. */
+    tcg_cpu_poison_jmp_cache(cpu);
 }
 
 static inline bool icount_exit_request(CPUState *cpu)
@@ -796,6 +847,7 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
      * tcg_kick_vcpu_thread())
      */
     qatomic_set_mb(&cpu->neg.icount_decr.u16.high, 0);
+    tcg_cpu_restore_jmp_cache(cpu);
 
 #ifdef CONFIG_USER_ONLY
     assert(!cpu_test_interrupt(cpu, ~0));
@@ -1069,6 +1121,7 @@ bool tcg_exec_realizefn(CPUState *cpu, Error **errp)
     }
 
     cpu->tb_jmp_cache = g_new0(CPUJumpCache, 1);
+    qatomic_set(&cpu->tb_jmp_cache_probe, cpu->tb_jmp_cache);
     tlb_init(cpu);
 #ifndef CONFIG_USER_ONLY
     tcg_iommu_init_notifier_list(cpu);
@@ -1086,5 +1139,6 @@ void tcg_exec_unrealizefn(CPUState *cpu)
 #endif /* !CONFIG_USER_ONLY */
 
     tlb_destroy(cpu);
+    qatomic_set(&cpu->tb_jmp_cache_probe, NULL);
     g_free_rcu(cpu->tb_jmp_cache, rcu);
 }
diff --git ./accel/tcg/internal-common.h ./accel/tcg/internal-common.h
index dc713a6e1a..6007223285 100644
--- ./accel/tcg/internal-common.h
+++ ./accel/tcg/internal-common.h
@@ -154,6 +154,9 @@ void page_table_config_init(void);
 G_NORETURN void cpu_io_recompile(CPUState *cpu, uintptr_t retaddr);
 #endif /* CONFIG_USER_ONLY */
 
+void tcg_cpu_poison_jmp_cache(CPUState *cpu);
+void tcg_cpu_restore_jmp_cache(CPUState *cpu);
+
 void tb_phys_invalidate(TranslationBlock *tb, tb_page_addr_t page_addr);
 void tb_set_jmp_target(TranslationBlock *tb, int n, uintptr_t addr);
 
diff --git ./accel/tcg/tcg-accel-ops.c ./accel/tcg/tcg-accel-ops.c
index 560fe2554b..fc134c48d9 100644
--- ./accel/tcg/tcg-accel-ops.c
+++ ./accel/tcg/tcg-accel-ops.c
@@ -44,6 +44,7 @@
 
 #include "hw/core/cpu.h"
 
+#include "internal-common.h"
 #include "tcg-accel-ops.h"
 #include "tcg-accel-ops-mttcg.h"
 #include "tcg-accel-ops-rr.h"
@@ -106,6 +107,7 @@ void tcg_handle_interrupt(CPUState *cpu, int mask)
         qemu_cpu_kick(cpu);
     } else {
         qatomic_set(&cpu->neg.icount_decr.u16.high, -1);
+        tcg_cpu_poison_jmp_cache(cpu);
     }
 }
 
diff --git ./accel/tcg/translator.c ./accel/tcg/translator.c
index 048ad8bad2..5f98d6446b 100644
--- ./accel/tcg/translator.c
+++ ./accel/tcg/translator.c
@@ -62,8 +62,6 @@ static TCGOp *gen_tb_start(DisasContextBase *db, uint32_t cflags)
     TCGv_i32 count = NULL;
     TCGOp *icount_start_insn = NULL;
 
-    tcg_ctx->exit_check_needed = false;
-
     if ((cflags & CF_USE_ICOUNT) ||
         (!(cflags & CF_NOIRQ) && !defer_exit_check(cflags))) {
         count = tcg_temp_new_i32();
@@ -126,7 +124,7 @@ static void gen_tb_end(const TranslationBlock *tb, uint32_t cflags,
 
     if (tcg_ctx->exitreq_label && defer_exit_check(cflags) &&
         !(cflags & CF_NOIRQ)) {
-        if (db->needs_exit_check || tcg_ctx->exit_check_needed) {
+        if (db->needs_exit_check) {
             TCGv_i32 count = tcg_temp_new_i32();
             TCGOp *save = tcg_ctx->emit_before_op;
 
diff --git ./include/hw/core/cpu.h ./include/hw/core/cpu.h
index 399ac7bd57..cecf9d0583 100644
--- ./include/hw/core/cpu.h
+++ ./include/hw/core/cpu.h
@@ -526,6 +526,16 @@ struct CPUState {
 
     struct CPUJumpCache *tb_jmp_cache;
 
+    /*
+     * What the inline jump cache probe emitted by
+     * tcg_gen_lookup_and_goto_ptr_inline() reads. Normally equal to
+     * tb_jmp_cache; pointed at a page of zeroes while an exit is pending, so
+     * that every indirect dispatch misses and lands in the helper, which
+     * returns to the main loop. Only generated code and the two accessors in
+     * cpu-exec.c may touch it.
+     */
+    struct CPUJumpCache *tb_jmp_cache_probe;
+
     GArray *gdb_regs;
     int gdb_num_regs;
     int gdb_num_g_regs;
diff --git ./include/tcg/tcg.h ./include/tcg/tcg.h
index be9ce7a0e2..7669dc1c2d 100644
--- ./include/tcg/tcg.h
+++ ./include/tcg/tcg.h
@@ -389,8 +389,6 @@ struct TCGContext {
     struct TCGLabelPoolData *pool_labels;
 
     TCGLabel *exitreq_label;
-    /* Set by goto_ptr emission: destination is not known statically. */
-    bool exit_check_needed;
 
 #ifdef CONFIG_PLUGIN
     /*
diff --git ./tcg/tcg-op.c ./tcg/tcg-op.c
index 8282afa61a..ff63f16ccd 100644
--- ./tcg/tcg-op.c
+++ ./tcg/tcg-op.c
@@ -2616,7 +2616,10 @@ void tcg_gen_lookup_and_goto_ptr(void)
         return;
     }
 
-    tcg_ctx->exit_check_needed = true;
+    /*
+     * No icount_decr poll is needed for this exit: the helper is called on
+     * every dispatch and returns to the main loop while an exit is pending.
+     */
     plugin_gen_disable_mem_helpers();
     ptr = tcg_temp_ebb_new_ptr();
     gen_helper_lookup_tb_ptr(ptr, tcg_env);
@@ -2645,7 +2648,11 @@ void tcg_gen_lookup_and_goto_ptr_inline(TCGv_i64 pc,
         return;
     }
 
-    tcg_ctx->exit_check_needed = true;
+    /*
+     * No icount_decr poll is needed for this exit either. A pending exit
+     * poisons tb_jmp_cache_probe, so the guarded load below finds a NULL tb,
+     * takes the slow path, and the helper returns to the main loop.
+     */
     plugin_gen_disable_mem_helpers();
 
     QEMU_BUILD_BUG_ON(sizeof(((CPUJumpCache *)0)->array[0]) != 16);
@@ -2667,7 +2674,7 @@ void tcg_gen_lookup_and_goto_ptr_inline(TCGv_i64 pc,
     tcg_gen_shli_i64(h, h, 4);
 
     tcg_gen_ld_ptr(jc, tcg_env,
-                   offsetof(CPUState, tb_jmp_cache) - sizeof(CPUState));
+                   offsetof(CPUState, tb_jmp_cache_probe) - sizeof(CPUState));
     tcg_gen_trunc_i64_ptr(ent, h);
     tcg_gen_add_ptr(ent, jc, ent);
 
diff --git ./tests/tcg/alpha/Makefile.target ./tests/tcg/alpha/Makefile.target
index eee986bab6..f9f135fc2f 100644
--- ./tests/tcg/alpha/Makefile.target
+++ ./tests/tcg/alpha/Makefile.target
@@ -5,7 +5,8 @@
 ALPHA_SRC=$(SRC_PATH)/tests/tcg/alpha
 VPATH+=$(ALPHA_SRC)
 
-ALPHA_TESTS=hello-alpha test-cond test-cmov test-ovf test-cvttq test-xpage-chain
+ALPHA_TESTS=hello-alpha test-cond test-cmov test-ovf test-cvttq test-xpage-chain \
+	test-indirect-irq
 TESTS+=$(ALPHA_TESTS)
 
 test-cmov: EXTRA_CFLAGS=-DTEST_CMOV
diff --git ./tests/tcg/alpha/test-indirect-irq.c ./tests/tcg/alpha/test-indirect-irq.c
new file mode 100644
index 0000000000..bef2844fd9
--- /dev/null
+++ ./tests/tcg/alpha/test-indirect-irq.c
@@ -0,0 +1,53 @@
+/*
+ * A loop whose only back edge is an indirect branch must still be
+ * interruptible.
+ *
+ * Blocks that dispatch indirectly do not emit the icount_decr poll; a pending
+ * exit instead poisons the inline jump cache probe so that the dispatch falls
+ * into helper_lookup_tb_ptr(), which returns to the main loop. If that
+ * mechanism breaks, this program never leaves the loop and the test times
+ * out rather than failing an assertion.
+ *
+ * A computed goto is used deliberately: a plain while(1) closes the cycle
+ * with a direct backward branch, which is still polled, and so would not
+ * exercise the path under test.
+ */
+#include <assert.h>
+#include <signal.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+
+static volatile sig_atomic_t fired;
+static volatile unsigned long iterations;
+
+static void handler(int sig)
+{
+    fired = 1;
+}
+
+int main(void)
+{
+    /*
+     * Indexing a table with a volatile index, rather than jumping through a
+     * volatile pointer: gcc happily proves a single-valued pointer constant
+     * and emits a direct branch, which is the case this test is not about.
+     */
+    void *target[2];
+    volatile int idx = 0;
+
+    assert(signal(SIGALRM, handler) != SIG_ERR);
+    alarm(1);
+
+    target[0] = &&spin;
+    target[1] = &&out;
+spin:
+    iterations++;
+    if (!fired) {
+        goto *target[idx];
+    }
+out:
+
+    printf("interrupted after %lu iterations\n", iterations);
+    return 0;
+}
-- 
2.54.0


