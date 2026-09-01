Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54122C624CF
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 03:50:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1FUt-0000wF-Kp; Mon, 31 Aug 2026 23:49:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1x1FUf-0000eH-PW
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 23:49:09 -0400
Received: from mail-yx1-xb133.google.com ([2607:f8b0:4864:20::b133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1x1FUc-0004Me-Dq
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 23:49:05 -0400
Received: by mail-yx1-xb133.google.com with SMTP id
 956f58d0204a3-66b32bb75beso3903687d50.2
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 20:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788234541; x=1788839341; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2aNNw+LRwkAiqFyZ0GoG7IJ1ns7+1hc/AivPTPBuYsM=;
 b=iqwGQlJBdXwG6wT79b18Q8NmMPLIdyoV3EZb+lIZUZhKtmjEV9U/62EihvGdg70vOV
 UI37JJpdCohh+S1MeoB2iYPSscNSMZ1beMsIwnLCw36osGpzoCIq4/LHfMvRqEYaPsGc
 okAg4AUTgPqXyWZS5r5sg8gblCSPdypgX4QIoRc79Tw0DbKMZ2I3kVF1lFkds1WJqYfm
 gAoy15DhlUG+CmTmti/bSDFlk0idC6Nt/b82SuDlvYvOKeWp5Lrx8Be+GfIvq8drs6q9
 TJnmUHrnaoCIKI0819YkmxSAkSTC09+Ft30WeTHcukh/IMcKNNasqWbZYUVlzjnfx3nY
 h8cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788234541; x=1788839341;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=2aNNw+LRwkAiqFyZ0GoG7IJ1ns7+1hc/AivPTPBuYsM=;
 b=LGcJX5I+td7iBxflOwPCA9w2Ox0VdXOT01RAKHuvhfH0zXV7wb4TL03Gk2Nn4ShYVG
 KqRiP/yRqubnljssDq5CHGjTA20yOPFdQFPwQm/8cyzW2EFZAGGxGQPs853iZ2sU0bO0
 6Lg9s3Y/c/RsiCQM847dpkuLSyQqe2kAo1DNkkyiHYnWe18ST8kvZa5gNAI1pXsUhTzZ
 iARZEzlwGgBmy/adj+lv7A4AaUVLzbMDjci7aZDVix+8IX0/V0EIUV15Ka+ScVcNcfhM
 umsq1XgfI3lGGvEVlXLUgvLJ5GvzVjhQOampqoz9mVn2kAi2hqfvFRnCGMs7Dlvu4Y3T
 9NLQ==
X-Gm-Message-State: AFuF++l7XArTzn8GVTDBc9NIOrdbsmDyZuOhNsxpi6CnEzkQ3ohb90Q2
 ZHsIsB6l846VY79JKozkRY9GBt2Ui8z3vxCrd479bjZqi97dRW0Ivhyq/+sk3A==
X-Gm-Gg: AYBFou2qfCmLXvmTZ5HCPArvNyyiiOu8JiZiiK3J4Bxm9zecPmkMqPMgXZWj1m70LpE
 q2sxIDO6nB6D485xuI7jqYnYsfqaXTfJjLYEjtW5KcTSuQChknE7JXK31MVQFkvISet/C021R+u
 LcskpGIfjgHSZ3NJAuT7HaMHubQm/aYPRSQcqH+vcPT1A0pQatZrAUGQ526eM6BtbQTYcdLQ0EE
 DXdaceuoJzFeMPbW8zcGlFDCaF/SsJyUy/86EXYJfUJ9coQ6B4gDZLTC5+qRDsf0xeWldypj2q7
 PPI2JndEvn1EkXTn3oR5IY7wGXYzHgUqkYMPAn+k5UVW0CDLHFiAlIEFgSVfQnPAe/yMU2VyqL2
 MT/McMmH50SDx0nwm8z9baS6F8mt0VRLtgDqS/l7vd2GhtQPoM15JQaETDDCQKE4tWTHGqDDGYI
 Dq8Plg23Q/AkRlCefgJ/SsSBps1czeXsgsFGt1iMlrTvkyY6lav1b481hTnkubyZ6f9L8H4reaI
 Wn/mHv392m+nMtIy3f1rew3dnAZ+AbY9RC7gCQc
X-Received: by 2002:a05:690e:4501:10b0:66e:54a0:cdd3 with SMTP id
 956f58d0204a3-66e54a0e97amr5804793d50.42.1788234540725; 
 Mon, 31 Aug 2026 20:49:00 -0700 (PDT)
Received: from localhost (107-220-129-194.lightspeed.chrlnc.sbcglobal.net.
 [107.220.129.194]) by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-66e4ed2986csm7466463d50.18.2026.08.31.20.48.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2026 20:48:58 -0700 (PDT)
From: Matt Turner <mattst88@gmail.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, pbonzini@redhat.com, philmd@oss.qualcomm.com,
 alex.bennee@linaro.org, zhao1.liu@intel.com,
 Matt Turner <mattst88@gmail.com>
Subject: [PATCH v5 8/9] RFC: accel/tcg: poison the jump cache instead of
 polling for indirect exits
Date: Mon, 31 Aug 2026 23:48:07 -0400
Message-ID: <20260901034808.3524945-9-mattst88@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260901034808.3524945-1-mattst88@gmail.com>
References: <20260827050241.3713332-1-mattst88@gmail.com>
 <20260901034808.3524945-1-mattst88@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::b133;
 envelope-from=mattst88@gmail.com; helo=mail-yx1-xb133.google.com
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

Every translation block begins by loading cpu->neg.icount_decr.u32, testing
it and branching to the exit path. That is three host instructions at the top
of every TB, and blocks are short: an emulated alpha gcc 16.2.0 compiling a
255k line translation unit executes 34.2 billion of them at 6.04 guest
instructions each.

A block does not need to poll if every way out of it already reaches a check.
A goto_tb does not: it chains straight into its destination, with nothing in
between that looks at icount_decr, so the destination has to poll on entry.
An indirect exit does. The out-of-line path calls helper_lookup_tb_ptr()
every time, so it only needs the helper to return the epilogue while an exit
is pending. The inline probe needs a way to be told, so give it one:
CPUState::tb_jmp_cache_probe, the base pointer it reads. Normally that is
cpu->tb_jmp_cache; pointed at a shared page of zeroes instead, every entry
the probe finds has a NULL tb, every dispatch misses, and a miss lands in the
same helper. The real jump cache is untouched, so no cache contents are lost,
and the fast path pays nothing: the base was a load from CPUState either way.

The two places that set icount_decr.u16.high poison the probe; the main loop
puts it back once cpu_handle_interrupt() has cleared the reason. The poison
is a single read-only mapping shared by every CPU, because nothing may ever
write to it and a stray store into a page every vCPU dispatches through is
worth trapping rather than debugging.

The poll is therefore emitted only in blocks that emit a goto_tb. Whether a
block does is not known until its last exit has been generated, so the
decision is deferred and the load and branch are emitted retroactively at the
head of the block in gen_tb_end(), using the same emit_before_op mechanism
the can_do_io stores use. icount opts out and keeps the counter
unconditionally.

Interrupt latency is bounded at one block, as before. It does not depend on
the shape of the guest's control flow graph: a block either polls on entry or
is checked on the way out, and no run of blocks can avoid both. What changes
is where the check sits, not how often one happens.

tests/tcg/multiarch/test-indirect-irq.c is added for this: a loop whose only
back edge is an indirect branch, under alarm(1). That loop's block emits no
goto_tb, so it no longer polls, and the test passes only because the dispatch
notices instead -- it hangs if the poison is removed, which is what makes it a
test of the new mechanism rather than of the old poll. Nothing in it is
architecture specific: the loop is a computed goto, which every target's
compiler supports, so it covers whichever targets go on to use the inline
probe. The other alpha tests still pass and the emulated compiler still
produces byte-identical output.

Measured with qemu-alpha running an emulated alpha gcc 16.2.0 compiling the
SQLite 3.45.1 amalgamation (255k lines, -O2) on an x86-64 host, LTO build, on
top of the preceding patches:

    before: 891,254,240,071 instructions
    after:  868,811,832,620 instructions   -2.52%

    before: 81.45s wall clock
    after:  79.85s wall clock              -1.96%

The emulated compiler produces byte-identical output.

RFC because:

- The un-poison in the main loop races a concurrent poison from another
  thread. The existing barrier around icount_decr.u16.high covers it -- a
  poison that lands after the sync also re-set the flag, and exit_request was
  stored before it -- but this deserves more eyes than the single-threaded
  user-mode testing I have given it.
- Only the inline probe needs the poison, and only alpha uses the inline
  probe today. Targets on the out-of-line path are covered by the helper
  check alone, but that has not been measured.

v3: Rebased onto the removal of "only poll for interrupts in blocks that can
    close a cycle", which v2 sat on top of and which is dropped: it let a
    straight-line run of arbitrary length go unchecked, since a block with no
    backward edge polled nowhere (Richard).

    The rule is now that a block polls iff it emits a goto_tb, rather than
    iff it can close a control flow cycle. That keeps the bound at one block
    without any analysis of the guest's control flow graph, so the objection
    to the dropped patch does not carry over. The deferred-emission machinery
    it needs moves here from that patch; DisasContextBase::needs_exit_check
    and the hook in translator_use_goto_tb() are gone with it, and the flag
    is now set by tcg_gen_goto_tb() rather than by goto_ptr emission.

    All of v2's measurements were dropped: they were taken with the
    cycle-analysis patch underneath, which changes both the baseline and
    what is left to remove, so none of them described this patch. The
    numbers above are a fresh measurement of the series as it now stands.

v4: Moved the test from tests/tcg/alpha/ to tests/tcg/multiarch/: the
    mechanism is generic and nothing in the test is alpha specific (Alex).

    The performance numbers above are the v3 measurements, not re-run: the
    machine they were taken on is busy.

v5: CPUState::tb_jmp_cache_probe moves here from what was patch 5, which
    used it for breakpoints too. Breakpoints are now a cflag, so a pending
    exit is the only reason left to poison, and the machinery shrinks to
    match: no NULL states to handle, no cross-thread poison from
    cpu_breakpoint_insert(), and one condition rather than two.

v5: Map the poison read-only rather than leaving it a writable .bss object.
    Requested by Richard Henderson. It costs a page-aligned 1MB allocation
    at startup instead of nothing on disk, which the enforcement is worth.
    qemu_mprotect_ro() is added for it, alongside the _rw, _rwx and _none
    forms already there.

v5: Drop the NULL checks in the poison and sync helpers. Requested by
    Richard Henderson: the sync is only ever called by the main loop, so it
    cannot see an unrealized CPU, and unrealize now leaves the probe pointing
    at the poison rather than at NULL, so neither has an unrealized state to
    consider.

Signed-off-by: Matt Turner <mattst88@gmail.com>
---
 accel/tcg/cpu-exec.c                    | 91 +++++++++++++++++++++++++
 accel/tcg/internal-common.h             |  9 +++
 accel/tcg/tcg-accel-ops.c               |  2 +
 accel/tcg/translator.c                  | 51 +++++++++++++-
 include/hw/core/cpu.h                   |  9 +++
 include/qemu/mprotect.h                 |  1 +
 include/tcg/tcg.h                       |  2 +
 tcg/tcg-op.c                            | 21 +++++-
 tests/tcg/multiarch/test-indirect-irq.c | 62 +++++++++++++++++
 util/osdep.c                            |  9 +++
 10 files changed, 253 insertions(+), 4 deletions(-)
 create mode 100644 tests/tcg/multiarch/test-indirect-irq.c

diff --git ./accel/tcg/cpu-exec.c ./accel/tcg/cpu-exec.c
index ca90a77a7b..7a371e6928 100644
--- ./accel/tcg/cpu-exec.c
+++ ./accel/tcg/cpu-exec.c
@@ -19,6 +19,9 @@
 
 #include "qemu/osdep.h"
 #include "qemu/qemu-print.h"
+#include "qemu/error-report.h"
+#include "qemu/memalign.h"
+#include "qemu/mprotect.h"
 #include "qapi/error.h"
 #include "qapi/type-helpers.h"
 #include "hw/core/cpu.h"
@@ -388,6 +391,16 @@ const void *HELPER(lookup_tb_ptr)(CPUArchState *env)
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
 
@@ -779,6 +792,70 @@ static inline bool cpu_handle_exception(CPUState *cpu, int *ret)
     return false;
 }
 
+/*
+ * The inline jump cache probe reads cpu->tb_jmp_cache_probe and takes the
+ * slow path when the entry it finds has a NULL tb.  Pointing the probe at a
+ * region that is all zeroes therefore forces every indirect dispatch into
+ * helper_lookup_tb_ptr(), which returns the epilogue while an exit is
+ * pending.  The real jump cache is untouched, so no contents are lost and
+ * recovery is a single store.
+ *
+ * Only ever read from, and only one entry per dispatch, so one shared
+ * zero-filled cache is enough for every CPU.  Mapped read-only, since
+ * nothing may write to it and a stray store into a shared page every vCPU
+ * dispatches through is worth trapping rather than debugging.
+ */
+static CPUJumpCache *tb_jmp_cache_poison;
+
+static void tb_jmp_cache_poison_init(void)
+{
+    size_t align = qemu_real_host_page_size();
+    size_t size = ROUND_UP(sizeof(CPUJumpCache), align);
+    void *p = qemu_memalign(align, size);
+
+    memset(p, 0, size);
+    if (qemu_mprotect_ro(p, size) < 0) {
+        /* Only the enforcement is lost; the zeroes are what matter. */
+        warn_report("could not write-protect the jump cache poison");
+    }
+    tb_jmp_cache_poison = p;
+}
+
+/*
+ * Poison @cpu's probe, from any thread.  A plain store is enough: the value
+ * only ever costs a slow path that is correct on its own, and the generated
+ * code re-reads the base on every dispatch.
+ */
+void tcg_cpu_poison_jmp_cache(CPUState *cpu)
+{
+    qatomic_set(&cpu->tb_jmp_cache_probe, tb_jmp_cache_poison);
+}
+
+/*
+ * Called from @cpu's own main loop, which is the only context that can
+ * establish that no reason to be poisoned is left.
+ */
+void tcg_cpu_sync_jmp_cache(CPUState *cpu)
+{
+    if (qatomic_read(&cpu->tb_jmp_cache_probe) == cpu->tb_jmp_cache) {
+        return;
+    }
+
+    qatomic_set(&cpu->tb_jmp_cache_probe, cpu->tb_jmp_cache);
+
+    /*
+     * Another thread may have set icount_decr.u16.high after the caller
+     * decided no exit was pending, and its poison may have landed before
+     * the store above.  Order that store against the re-read, so the race
+     * is lost in the safe direction: an exit that is still pending here
+     * poisons again, and the dispatch after it returns to the main loop.
+     */
+    smp_mb();
+    if (unlikely(cpu_loop_exit_requested(cpu))) {
+        tcg_cpu_poison_jmp_cache(cpu);
+    }
+}
+
 void tcg_kick_vcpu_thread(CPUState *cpu)
 {
     /*
@@ -791,6 +868,9 @@ void tcg_kick_vcpu_thread(CPUState *cpu)
 
     /* Ensure cpu_exec will see the exit request after TCG has exited.  */
     qatomic_store_release(&cpu->neg.icount_decr.u16.high, -1);
+
+    /* Blocks that only dispatch indirectly do not poll; stop them chaining. */
+    tcg_cpu_poison_jmp_cache(cpu);
 }
 
 static inline bool icount_exit_request(CPUState *cpu)
@@ -991,6 +1071,13 @@ cpu_exec_loop(CPUState *cpu, SyncClocks *sc)
                 break;
             }
 
+            /*
+             * cpu_handle_interrupt() has just cleared everything that would
+             * make a dispatch have to come back here, so this is where the
+             * probe is allowed to return after a poison.
+             */
+            tcg_cpu_sync_jmp_cache(cpu);
+
             tb = tb_lookup(cpu, s);
             if (tb == NULL) {
                 CPUJumpCache *jc;
@@ -1092,6 +1179,7 @@ bool tcg_exec_realizefn(CPUState *cpu, Error **errp)
         assert(tcg_ops->get_tb_cpu_state);
         assert(tcg_ops->mmu_index);
         tcg_ops->initialize();
+        tb_jmp_cache_poison_init();
         tcg_target_initialized = true;
     }
 
@@ -1099,6 +1187,7 @@ bool tcg_exec_realizefn(CPUState *cpu, Error **errp)
     tcg_update_cflags(cpu);
 
     cpu->tb_jmp_cache = g_new0(CPUJumpCache, 1);
+    qatomic_set(&cpu->tb_jmp_cache_probe, cpu->tb_jmp_cache);
     tlb_init(cpu);
 #ifndef CONFIG_USER_ONLY
     tcg_iommu_init_notifier_list(cpu);
@@ -1116,5 +1205,7 @@ void tcg_exec_unrealizefn(CPUState *cpu)
 #endif /* !CONFIG_USER_ONLY */
 
     tlb_destroy(cpu);
+    /* Not NULL: nothing then has to special-case an unrealized CPU. */
+    tcg_cpu_poison_jmp_cache(cpu);
     g_free_rcu(cpu->tb_jmp_cache, rcu);
 }
diff --git ./accel/tcg/internal-common.h ./accel/tcg/internal-common.h
index 853d1b51ee..6faa039850 100644
--- ./accel/tcg/internal-common.h
+++ ./accel/tcg/internal-common.h
@@ -144,6 +144,15 @@ void page_table_config_init(void);
 G_NORETURN void cpu_io_recompile(CPUState *cpu, uintptr_t retaddr);
 #endif /* CONFIG_USER_ONLY */
 
+/*
+ * Force @cpu's generated code back into helper_lookup_tb_ptr(), which
+ * re-checks everything the inline jump cache probe cannot.  Safe to call
+ * from any thread.  tcg_cpu_sync_jmp_cache() undoes it, and is for the
+ * owning CPU's main loop only.
+ */
+void tcg_cpu_poison_jmp_cache(CPUState *cpu);
+void tcg_cpu_sync_jmp_cache(CPUState *cpu);
+
 void tb_phys_invalidate(TranslationBlock *tb, tb_page_addr_t page_addr);
 void tb_set_jmp_target(TranslationBlock *tb, int n, uintptr_t addr);
 
diff --git ./accel/tcg/tcg-accel-ops.c ./accel/tcg/tcg-accel-ops.c
index 560fe2554b..63a15f1689 100644
--- ./accel/tcg/tcg-accel-ops.c
+++ ./accel/tcg/tcg-accel-ops.c
@@ -38,6 +38,7 @@
 #include "exec/cputlb.h"
 #include "exec/hwaddr.h"
 #include "exec/tb-flush.h"
+#include "internal-common.h"
 #include "exec/translation-block.h"
 #include "exec/watchpoint.h"
 #include "gdbstub/enums.h"
@@ -106,6 +107,7 @@ void tcg_handle_interrupt(CPUState *cpu, int mask)
         qemu_cpu_kick(cpu);
     } else {
         qatomic_set(&cpu->neg.icount_decr.u16.high, -1);
+        tcg_cpu_poison_jmp_cache(cpu);
     }
 }
 
diff --git ./accel/tcg/translator.c ./accel/tcg/translator.c
index 8879cd626f..89d255bd04 100644
--- ./accel/tcg/translator.c
+++ ./accel/tcg/translator.c
@@ -45,12 +45,35 @@ bool translator_io_start(DisasContextBase *db)
     return true;
 }
 
+/*
+ * A block that ends in a goto_tb chains straight to its destination: nothing
+ * between the two looks at icount_decr, so the destination has to poll on
+ * entry.  A block whose exits are all indirect does not, because the dispatch
+ * itself notices -- a pending exit poisons tb_jmp_cache_probe, so the probe
+ * misses into helper_lookup_tb_ptr(), which returns the epilogue.  Every block
+ * therefore either polls on entry or is checked as it leaves, which bounds
+ * interrupt latency at one block without looking at the shape of the guest's
+ * control flow graph.
+ *
+ * Which kind a block is is not known until its last exit has been emitted, so
+ * defer the decision to gen_tb_end() and emit the poll retroactively.
+ *
+ * icount needs the counter unconditionally, so it opts out.
+ */
+static bool defer_exit_check(uint32_t cflags)
+{
+    return !(cflags & CF_USE_ICOUNT);
+}
+
 static TCGOp *gen_tb_start(DisasContextBase *db, uint32_t cflags)
 {
     TCGv_i32 count = NULL;
     TCGOp *icount_start_insn = NULL;
 
-    if ((cflags & CF_USE_ICOUNT) || !(cflags & CF_NOIRQ)) {
+    tcg_ctx->exit_check_needed = false;
+
+    if ((cflags & CF_USE_ICOUNT) ||
+        (!(cflags & CF_NOIRQ) && !defer_exit_check(cflags))) {
         count = tcg_temp_new_i32();
         tcg_gen_ld_i32(count, tcg_env,
                        offsetof(CPUState, neg.icount_decr.u32) -
@@ -76,6 +99,9 @@ static TCGOp *gen_tb_start(DisasContextBase *db, uint32_t cflags)
      */
     if (cflags & CF_NOIRQ) {
         tcg_ctx->exitreq_label = NULL;
+    } else if (defer_exit_check(cflags)) {
+        /* Emitted retroactively by gen_tb_end(), if this TB emits a goto_tb. */
+        tcg_ctx->exitreq_label = gen_new_label();
     } else {
         tcg_ctx->exitreq_label = gen_new_label();
         tcg_gen_brcondi_i32(TCG_COND_LT, count, 0, tcg_ctx->exitreq_label);
@@ -91,7 +117,8 @@ static TCGOp *gen_tb_start(DisasContextBase *db, uint32_t cflags)
 }
 
 static void gen_tb_end(const TranslationBlock *tb, uint32_t cflags,
-                       TCGOp *icount_start_insn, int num_insns)
+                       TCGOp *icount_start_insn, int num_insns,
+                       TCGOp *first_insn_start)
 {
     if (cflags & CF_USE_ICOUNT) {
         /*
@@ -102,6 +129,23 @@ static void gen_tb_end(const TranslationBlock *tb, uint32_t cflags,
                            tcgv_i32_arg(tcg_constant_i32(num_insns)));
     }
 
+    if (tcg_ctx->exitreq_label && defer_exit_check(cflags) &&
+        !(cflags & CF_NOIRQ)) {
+        if (tcg_ctx->exit_check_needed) {
+            TCGv_i32 count = tcg_temp_new_i32();
+            TCGOp *save = tcg_ctx->emit_before_op;
+
+            tcg_ctx->emit_before_op = first_insn_start;
+            tcg_gen_ld_i32(count, tcg_env,
+                           offsetof(CPUState, neg.icount_decr.u32) -
+                           sizeof(CPUState));
+            tcg_gen_brcondi_i32(TCG_COND_LT, count, 0, tcg_ctx->exitreq_label);
+            tcg_ctx->emit_before_op = save;
+        } else {
+            tcg_ctx->exitreq_label = NULL;
+        }
+    }
+
     if (tcg_ctx->exitreq_label) {
         gen_set_label(tcg_ctx->exitreq_label);
         tcg_gen_exit_tb(tb, TB_EXIT_REQUESTED);
@@ -238,7 +282,8 @@ void translator_loop(CPUState *cpu, TranslationBlock *tb, int *max_insns,
 
     /* Emit code to exit the TB, as indicated by db->is_jmp.  */
     ops->tb_stop(db, cpu);
-    gen_tb_end(tb, cflags, icount_start_insn, db->num_insns);
+    gen_tb_end(tb, cflags, icount_start_insn, db->num_insns,
+               first_insn_start);
 
     /*
      * Manage can_do_io for the translation block: set to false before
diff --git ./include/hw/core/cpu.h ./include/hw/core/cpu.h
index 81af7b9ee1..c8669f2cad 100644
--- ./include/hw/core/cpu.h
+++ ./include/hw/core/cpu.h
@@ -519,6 +519,15 @@ struct CPUState {
     MemoryRegion *memory;
 
     struct CPUJumpCache *tb_jmp_cache;
+    /*
+     * @tb_jmp_cache_probe: the base the inline jump cache probe reads.
+     *
+     * Normally @tb_jmp_cache.  Pointed at a shared read-only page of zeroes
+     * while an exit is pending, so that every inline dispatch misses and
+     * falls back to helper_lookup_tb_ptr(), which returns to the main loop.
+     * Only generated code and the accessors in cpu-exec.c may touch it.
+     */
+    struct CPUJumpCache *tb_jmp_cache_probe;
 
     GArray *gdb_regs;
     int gdb_num_regs;
diff --git ./include/qemu/mprotect.h ./include/qemu/mprotect.h
index 1e83d1433e..4fc13d79f6 100644
--- ./include/qemu/mprotect.h
+++ ./include/qemu/mprotect.h
@@ -8,6 +8,7 @@
 #define QEMU_MPROTECT_H
 
 int qemu_mprotect_rw(void *addr, size_t size);
+int qemu_mprotect_ro(void *addr, size_t size);
 int qemu_mprotect_rwx(void *addr, size_t size);
 int qemu_mprotect_none(void *addr, size_t size);
 
diff --git ./include/tcg/tcg.h ./include/tcg/tcg.h
index 7669dc1c2d..df08c10544 100644
--- ./include/tcg/tcg.h
+++ ./include/tcg/tcg.h
@@ -389,6 +389,8 @@ struct TCGContext {
     struct TCGLabelPoolData *pool_labels;
 
     TCGLabel *exitreq_label;
+    /* Set by goto_tb emission: this TB chains without reaching a check. */
+    bool exit_check_needed;
 
 #ifdef CONFIG_PLUGIN
     /*
diff --git ./tcg/tcg-op.c ./tcg/tcg-op.c
index b10b2d66d5..1c5c5ec1d3 100644
--- ./tcg/tcg-op.c
+++ ./tcg/tcg-op.c
@@ -2713,6 +2713,13 @@ void tcg_gen_goto_tb(unsigned idx)
     tcg_debug_assert((tcg_ctx->goto_tb_issue_mask & (1 << idx)) == 0);
     tcg_ctx->goto_tb_issue_mask |= 1 << idx;
 #endif
+    /*
+     * A goto_tb chains straight into the destination, with nothing in between
+     * that looks at icount_decr, so this TB has to poll on entry.  See
+     * defer_exit_check().
+     */
+    tcg_ctx->exit_check_needed = true;
+
     plugin_gen_disable_mem_helpers();
     tcg_gen_op1i(INDEX_op_goto_tb, 0, idx);
 }
@@ -2790,8 +2797,13 @@ static void gen_jmp_cache_probe(TCGv_i64 pc, const TranslationBlock *tb)
     gen_jmp_cache_hash(h, pc);
     tcg_gen_shli_i64(h, h, 4);
 
+    /*
+     * Not cpu->tb_jmp_cache: the probe reads its own base so that the main
+     * loop can poison it, which is how a pending exit forces every dispatch
+     * back into the helper.  See tcg_cpu_sync_jmp_cache().
+     */
     tcg_gen_ld_ptr(jc, tcg_env,
-                   offsetof(CPUState, tb_jmp_cache) - sizeof(CPUState));
+                   offsetof(CPUState, tb_jmp_cache_probe) - sizeof(CPUState));
     tcg_gen_trunc_i64_ptr(ent, h);
     tcg_gen_add_ptr(ent, jc, ent);
 
@@ -2849,6 +2861,13 @@ static void gen_goto_jc(TCGv_i64 pc)
 
     plugin_gen_disable_mem_helpers();
 
+    /*
+     * Neither path below needs an icount_decr poll.  The helper returns to
+     * the main loop while an exit is pending, and a pending exit poisons
+     * tb_jmp_cache_probe, so the inline probe finds a NULL tb and falls into
+     * that same helper.
+     */
+
 #ifdef CONFIG_DEBUG_TCG
     /*
      * The caller has asserted that env already describes the destination.
diff --git ./tests/tcg/multiarch/test-indirect-irq.c ./tests/tcg/multiarch/test-indirect-irq.c
new file mode 100644
index 0000000000..a672faf641
--- /dev/null
+++ ./tests/tcg/multiarch/test-indirect-irq.c
@@ -0,0 +1,62 @@
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
+ * A computed goto is used deliberately: a plain while(1) would end the block
+ * with a direct backward branch, that is a goto_tb, and a block that emits a
+ * goto_tb still polls -- so it would not exercise the path under test.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#include <assert.h>
+#include <signal.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+
+/* Written by the handler, read by the loop, so it must not be cached. */
+static volatile sig_atomic_t fired;
+/* Read after the loop, so the loop must not optimize the increment away. */
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
+    volatile int idx = 0;
+    void *target[2];
+    struct sigaction sa;
+
+    memset(&sa, 0, sizeof(sa));
+    sa.sa_handler = handler;
+    sigemptyset(&sa.sa_mask);
+    assert(sigaction(SIGALRM, &sa, NULL) == 0);
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
diff --git ./util/osdep.c ./util/osdep.c
index 4a8b8b5a90..9c72a42b4f 100644
--- ./util/osdep.c
+++ ./util/osdep.c
@@ -99,6 +99,15 @@ int qemu_mprotect_rw(void *addr, size_t size)
 #endif
 }
 
+int qemu_mprotect_ro(void *addr, size_t size)
+{
+#ifdef _WIN32
+    return qemu_mprotect__osdep(addr, size, PAGE_READONLY);
+#else
+    return qemu_mprotect__osdep(addr, size, PROT_READ);
+#endif
+}
+
 int qemu_mprotect_rwx(void *addr, size_t size)
 {
 #ifdef _WIN32
-- 
2.54.0


