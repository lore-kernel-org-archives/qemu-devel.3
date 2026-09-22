Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6E2FC98302
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 17:05:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x93uy-0006XJ-5W; Tue, 22 Sep 2026 13:04:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mpatocka@redhat.com>)
 id 1x93us-0006X0-Qs
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 13:04:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mpatocka@redhat.com>)
 id 1x93up-0003nO-KH
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 13:04:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790096661;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Vbb7jUeTtG/7ImHZ6+jG7tOM26qYxy+7JWpU3m2VhPw=;
 b=KVqFTgAwU4WhqqH+Q5HcZiyoqJGTL01vuf5AvtJLZoWf4NAXR9fZKBXJh1GJ5gRfnlFNVr
 lMr8seAsliGCGzH8a8I+O65/JiQSJscmO1Fq4BMLXVkr5vcZV6p70e9GoUBtWcvbhoMqto
 AOFC/bdT+bILeTWLhSbEYjU5QODMdK0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-500-r4EmIudhNZWVYpr34BOxFA-1; Tue,
 22 Sep 2026 13:04:17 -0400
X-MC-Unique: r4EmIudhNZWVYpr34BOxFA-1
X-Mimecast-MFC-AGG-ID: r4EmIudhNZWVYpr34BOxFA_1790096656
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 27308197751C; Tue, 22 Sep 2026 17:04:16 +0000 (UTC)
Received: from mpatocka-thinkpadx1carbongen12.rmtcz.csb
 (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 627F130001B9; Tue, 22 Sep 2026 17:04:14 +0000 (UTC)
Date: Tue, 22 Sep 2026 19:04:11 +0200 (CEST)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
cc: Yoshinori Sato <yoshinori.sato@nifty.com>, Helge Deller <deller@gmx.de>, 
 qemu-devel@nongnu.org
Subject: [PATCH v2] linux-user/sh4: fix race in atomic variables
In-Reply-To: <dfa3b2ca-b87b-4581-9769-2f90aba86c56@linaro.org>
Message-ID: <2845945d-4d46-3ae9-8182-7d2288ff06ac@redhat.com>
References: <ae75af55-eb9a-5ac2-9288-aa116a3c4000@redhat.com>
 <dfa3b2ca-b87b-4581-9769-2f90aba86c56@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mpatocka@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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



On Sun, 20 Sep 2026, Richard Henderson wrote:

> On 9/20/26 01:46, Mikulas Patocka wrote:
> > I'm experiencing random deadlocks when running heavily multithreaded
> > workload in qemu-sh4 userspace emulation. This patch fixes them.
> > 
> > The sh4 architecture doesn't support multiprocessing, the processor
> > doesn't have atomic instructions and it uses a technique known as gUSA to
> > provide atomicity guarantees w.r.t. signals or thread scheduling (see the
> > commit 3b894b699c9a for a brief description of gUSA).
> > 
> > The function decode_gusa attempts to recognize several well-known gUSA
> > regions and turn them into atomic instructions. When it fails to
> > recognize a known gUSA pattern, it generates a call to helper_exclusive.
> > Qemu will attempt to stop all the other threads and execute a gUSA region
> > exclusively, so that it can't race with anything.
> > 
> > The problem is in the function cpu_exec_step_atomic - this function stops
> > all other threads with start_exclusive(), then it executes one
> > instruction and then it releases all other threads with end_exclusive().
> > This works for all the architectures except sh4. On sh4, executing one
> > instruction atomically is not enough - we must execute the full gUSA
> > region while the other threads are stopped.
> > 
> > This patch fixes cpu_exec_step_atomic - it adds two new per-architecture
> > functions: is_uninterruptible and revert_uninterruptible.
> > 
> > is_uninterruptible returns true if we are in a gUSA region and we should
> > continue executing code while the other threads are stopped.
> > 
> > If we got TB_EXIT_REQUESTED, we must stop executing code - in this case,
> > we call the function revert_uninterruptible that rolls back PC to the
> > beginning of the gUSA region.
> > 
> > Cc:qemu-stable@nongnu.org
> > Signed-off-by: Mikulas Patocka<mpatocka@redhat.com>
> > 
> > ---
> >   accel/tcg/cpu-exec.c        |   15 +++++++++++++++
> >   include/accel/tcg/cpu-ops.h |   20 ++++++++++++++++++++
> >   target/sh4/cpu.c            |   25 ++++++++++++++++++++++++-
> >   3 files changed, 59 insertions(+), 1 deletion(-)
> 
> I think this should be integrated into the sh4 translator instead.  We should
> not be single-stepping through the atomic region, but generate one TB that
> implements the entire region.
> 
> This may require some coordination with the translator loop.
> 
> 
> r~

Hi

I looked at the sh4 translator and it seems that it already tries to make 
sure that the full gUSA region is translated into one TB - i.e. there is 
"ctx->base.max_insns = max_insns" in sh4_tr_init_disas_context - that will 
override the value "1" that is supplied by cpu_exec_step_atomic. The 
comments suggest that the author is aware of the fact that the gUSA region 
must be completed atomically.

So, the code that single-steps through the gUSA region is not needed.

It seems that the misbehavior is caused by the fact that if we exit from 
the gUSA TB early, we execute the rest of the region in non-exclusive 
context.

I simplified the patch, so that it adds just one method - 
revert_uninterruptible. It tests whether we are in the unfinished gUSA 
region, and if we are, it reverts PC and SP back to the beginning.

Here I'm sending the updated patch.

Mikulas



From: Mikulas Patocka <mpatocka@redhat.com>

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
TB and then it releases all other threads with end_exclusive(). If the TB
executing the gUSA region exited early, the exclusive lock is dropped and
the execution continues without holding it - this is the root cause for
this bug.

This patch fixes cpu_exec_step_atomic - it adds a new per-architecture
function: revert_uninterruptible. Its implementation
superh_cpu_revert_uninterruptible tests if we are in an unfinished gUSA
region and rolls back the PC to the beginning of the region.

Cc: qemu-stable@nongnu.org
Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>

---
 accel/tcg/cpu-exec.c        |    5 +++++
 include/accel/tcg/cpu-ops.h |   10 ++++++++++
 target/sh4/cpu.c            |   25 ++++++++++++++++++++++++-
 3 files changed, 39 insertions(+), 1 deletion(-)

Index: qemu/accel/tcg/cpu-exec.c
===================================================================
--- qemu.orig/accel/tcg/cpu-exec.c	2026-09-22 18:31:48.000000000 +0200
+++ qemu/accel/tcg/cpu-exec.c	2026-09-22 18:31:48.000000000 +0200
@@ -590,6 +590,11 @@ void cpu_exec_step_atomic(CPUState *cpu)
         cpu_exec_longjmp_cleanup(cpu);
     }
 
+#ifdef CONFIG_USER_ONLY
+    if (cpu->cc->tcg_ops->revert_uninterruptible)
+        cpu->cc->tcg_ops->revert_uninterruptible(cpu);
+#endif
+
     /*
      * As we start the exclusive region before codegen we must still
      * be in the region if we longjump out of either the codegen or
Index: qemu/include/accel/tcg/cpu-ops.h
===================================================================
--- qemu.orig/include/accel/tcg/cpu-ops.h	2026-09-22 18:31:48.000000000 +0200
+++ qemu/include/accel/tcg/cpu-ops.h	2026-09-22 18:31:48.000000000 +0200
@@ -168,6 +168,16 @@ struct TCGCPUOps {
      * @addr: tagged guest address
      */
     vaddr (*untagged_addr)(CPUState *cs, vaddr addr);
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
--- qemu.orig/target/sh4/cpu.c	2026-09-22 18:31:48.000000000 +0200
+++ qemu/target/sh4/cpu.c	2026-09-22 18:31:48.000000000 +0200
@@ -92,6 +92,27 @@ static void superh_restore_state_to_opc(
      */
 }
 
+#ifdef CONFIG_USER_ONLY
+static void superh_cpu_revert_uninterruptible(CPUState *cs)
+{
+    SuperHCPU *cpu = SUPERH_CPU(cs);
+    /*
+     * If we are interrupted in the middle of the gUSA region, we must
+     * roll-back PC to the beginning of the region. Continuing halfway
+     * through the region would break atomicity guarantees.
+     *
+     * If we are interrupted after the final write instruction (i.e.
+     * cpu->env.pc == cpu->env.gregs[0]), we must not roll-back, because
+     * the atomic write is already committed in the memory.
+     */
+    if (cpu->env.gregs[15] >= -128u && cpu->env.pc < cpu->env.gregs[0]) {
+        cpu->env.pc = cpu->env.gregs[0] + cpu->env.gregs[15] - 2;
+        cpu->env.gregs[15] = cpu->env.gregs[1];
+        cpu->env.flags &= ~TB_FLAG_ENVFLAGS_MASK;
+    }
+}
+#endif /* CONFIG_USER_ONLY */
+
 #ifndef CONFIG_USER_ONLY
 static bool superh_io_recompile_replay_branch(CPUState *cs,
                                               const TranslationBlock *tb)
@@ -308,7 +329,9 @@ static const TCGCPUOps superh_tcg_ops =
     .restore_state_to_opc = superh_restore_state_to_opc,
     .mmu_index = sh4_cpu_mmu_index,
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_USER_ONLY
+    .revert_uninterruptible = superh_cpu_revert_uninterruptible,
+#else
     .tlb_fill = superh_cpu_tlb_fill,
     .pointer_wrap = cpu_pointer_wrap_notreached,
     .cpu_exec_interrupt = superh_cpu_exec_interrupt,


