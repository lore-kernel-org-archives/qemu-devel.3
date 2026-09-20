Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5744C982E1
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2026 11:49:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8G1t-0005dv-2u; Sun, 20 Sep 2026 07:48:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mpatocka@redhat.com>)
 id 1x8G1n-0005dR-Rk
 for qemu-devel@nongnu.org; Sun, 20 Sep 2026 07:48:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mpatocka@redhat.com>)
 id 1x8G1l-0000ji-N8
 for qemu-devel@nongnu.org; Sun, 20 Sep 2026 07:48:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789904892;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=StQvymsY0z9ENMSOVcMGUAwN5MBkM1vh5XZmNJ2xZi0=;
 b=ZWq8ak/Ob6/Xxp0eF0ZOUu5MsR58lRjqFOaVTdViB/fcg6yGEFxAgyhC8BsAbpkRGE2HLU
 MadLHxiWNtCB7aUQRN3d1KdHxRYNiXvi1rlWQLaIuYT4+f+R+zlpNJBwNcGHCRG6pd606F
 DU3GXB+WWuwsptJ7LvoY4OVm/7JghZI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-85-eyi9UPkHPRiig6w2JGkdrw-1; Sun,
 20 Sep 2026 07:47:03 -0400
X-MC-Unique: eyi9UPkHPRiig6w2JGkdrw-1
X-Mimecast-MFC-AGG-ID: eyi9UPkHPRiig6w2JGkdrw_1789904822
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7F315180A8F7; Sun, 20 Sep 2026 11:47:02 +0000 (UTC)
Received: from mpatocka-thinkpadx1carbongen12.rmtcz.csb (unknown [10.44.32.8])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix)
 with ESMTPS id 20B961800370; Sun, 20 Sep 2026 11:47:00 +0000 (UTC)
Date: Sun, 20 Sep 2026 13:46:58 +0200 (CEST)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Yoshinori Sato <yoshinori.sato@nifty.com>, Helge Deller <deller@gmx.de>, 
 Richard Henderson <richard.henderson@linaro.org>
cc: qemu-devel@nongnu.org
Subject: [PATCH] linux-user/sh4: fix race in atomic variables
Message-ID: <ae75af55-eb9a-5ac2-9288-aa116a3c4000@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mpatocka@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
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

I'm experiencing random deadlocks when running heavily multithreaded
workload in qemu-sh4 userspace emulation. This patch fixes them.

The sh4 architecture doesn't support multiprocessing, the processor
doesn't have atomic instructions and it uses a technique known as gUSA to
provide atomicity guarantees w.r.t. signals or thread scheduling (see the
commit 3b894b699c9a for a brief description of gUSA).

The function decode_gusa attempts to recognize several well-known gUSA
regions and turn them into atomic instructions. When it fails to
recognize a known gUSA pattern, it generates a call to helper_exclusive.
Qemu will attempt to stop all the other threads and execute a gUSA region
exclusively, so that it can't race with anything.

The problem is in the function cpu_exec_step_atomic - this function stops
all other threads with start_exclusive(), then it executes one
instruction and then it releases all other threads with end_exclusive().
This works for all the architectures except sh4. On sh4, executing one
instruction atomically is not enough - we must execute the full gUSA
region while the other threads are stopped.

This patch fixes cpu_exec_step_atomic - it adds two new per-architecture
functions: is_uninterruptible and revert_uninterruptible.

is_uninterruptible returns true if we are in a gUSA region and we should
continue executing code while the other threads are stopped.

If we got TB_EXIT_REQUESTED, we must stop executing code - in this case,
we call the function revert_uninterruptible that rolls back PC to the
beginning of the gUSA region.

Cc: qemu-stable@nongnu.org
Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>

---
 accel/tcg/cpu-exec.c        |   15 +++++++++++++++
 include/accel/tcg/cpu-ops.h |   20 ++++++++++++++++++++
 target/sh4/cpu.c            |   25 ++++++++++++++++++++++++-
 3 files changed, 59 insertions(+), 1 deletion(-)

Index: qemu/accel/tcg/cpu-exec.c
===================================================================
--- qemu.orig/accel/tcg/cpu-exec.c	2026-09-20 13:16:20.000000000 +0200
+++ qemu/accel/tcg/cpu-exec.c	2026-09-20 13:16:20.000000000 +0200
@@ -560,6 +560,9 @@ void cpu_exec_step_atomic(CPUState *cpu)
         g_assert(!cpu->running);
         cpu->running = true;
 
+#ifdef CONFIG_USER_ONLY
+next_instr:
+#endif
         TCGTBCPUState s = cpu->cc->tcg_ops->get_tb_cpu_state(cpu);
         s.cflags = curr_cflags(cpu);
 
@@ -586,7 +589,19 @@ void cpu_exec_step_atomic(CPUState *cpu)
         trace_exec_tb(tb, s.pc);
         cpu_tb_exec(cpu, tb, &tb_exit);
         cpu_exec_exit(cpu);
+#ifdef CONFIG_USER_ONLY
+        if (cpu->cc->tcg_ops->is_uninterruptible && cpu->cc->tcg_ops->is_uninterruptible(cpu)) {
+            if ((tb_exit & TB_EXIT_MASK) != TB_EXIT_REQUESTED)
+                goto next_instr;
+            if (cpu->cc->tcg_ops->revert_uninterruptible)
+                cpu->cc->tcg_ops->revert_uninterruptible(cpu);
+        }
+#endif
     } else {
+#ifdef CONFIG_USER_ONLY
+        if (cpu->cc->tcg_ops->revert_uninterruptible)
+            cpu->cc->tcg_ops->revert_uninterruptible(cpu);
+#endif
         cpu_exec_longjmp_cleanup(cpu);
     }
 
Index: qemu/include/accel/tcg/cpu-ops.h
===================================================================
--- qemu.orig/include/accel/tcg/cpu-ops.h	2026-09-20 13:16:20.000000000 +0200
+++ qemu/include/accel/tcg/cpu-ops.h	2026-09-20 13:16:20.000000000 +0200
@@ -168,6 +168,26 @@ struct TCGCPUOps {
      * @addr: tagged guest address
      */
     vaddr (*untagged_addr)(CPUState *cs, vaddr addr);
+
+    /**
+     * is_uninterruptible:
+     * @cpu: cpu context
+     *
+     * Returns true if we are in the middle of the gUSA region and
+     * cpu_exec_step_atomic must keep on executing instructions without
+     * dropping the exclusive lock.
+     */
+    bool (*is_uninterruptible)(CPUState *cs);
+
+    /**
+     * revert_uninterruptible:
+     * @cpu: cpu context
+     *
+     * This function is called if cpu_exec_step_atomic needs to exit. It
+     * tests if we are in the gUSA region and rolls back PC to the
+     * beginning of it.
+     */
+    void (*revert_uninterruptible)(CPUState *cs);
 #else
     /** @do_interrupt: Callback for interrupt handling.  */
     void (*do_interrupt)(CPUState *cpu);
Index: qemu/target/sh4/cpu.c
===================================================================
--- qemu.orig/target/sh4/cpu.c	2026-09-20 13:16:20.000000000 +0200
+++ qemu/target/sh4/cpu.c	2026-09-20 13:16:20.000000000 +0200
@@ -92,6 +92,26 @@ static void superh_restore_state_to_opc(
      */
 }
 
+#ifdef CONFIG_USER_ONLY
+static bool superh_cpu_is_uninterruptible(CPUState *cs)
+{
+    SuperHCPU *cpu = SUPERH_CPU(cs);
+
+    return cpu->env.gregs[15] >= -128u;
+}
+
+static void superh_cpu_revert_uninterruptible(CPUState *cs)
+{
+    SuperHCPU *cpu = SUPERH_CPU(cs);
+
+    if (cpu->env.gregs[15] >= -128u && cpu->env.pc < cpu->env.gregs[0]) {
+        cpu->env.pc = cpu->env.gregs[0] + cpu->env.gregs[15] - 2;
+        cpu->env.gregs[15] = cpu->env.gregs[1];
+        cpu->env.flags &= ~(TB_FLAG_DELAY_SLOT_MASK | TB_FLAG_GUSA_MASK);
+    }
+}
+#endif /* CONFIG_USER_ONLY */
+
 #ifndef CONFIG_USER_ONLY
 static bool superh_io_recompile_replay_branch(CPUState *cs,
                                               const TranslationBlock *tb)
@@ -308,7 +328,10 @@ static const TCGCPUOps superh_tcg_ops =
     .restore_state_to_opc = superh_restore_state_to_opc,
     .mmu_index = sh4_cpu_mmu_index,
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_USER_ONLY
+    .is_uninterruptible = superh_cpu_is_uninterruptible,
+    .revert_uninterruptible = superh_cpu_revert_uninterruptible,
+#else
     .tlb_fill = superh_cpu_tlb_fill,
     .pointer_wrap = cpu_pointer_wrap_notreached,
     .cpu_exec_interrupt = superh_cpu_exec_interrupt,


