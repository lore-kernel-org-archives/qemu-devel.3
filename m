Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A78D3CCA464
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 20:03:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHRf0-0002fk-Rr; Thu, 15 Oct 2026 16:02:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xHRet-0002ep-HV
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 16:02:36 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xHRer-0003B4-F2
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 16:02:35 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D1C2860A57;
 Thu, 15 Oct 2026 20:02:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C9E71F000C4;
 Thu, 15 Oct 2026 20:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792094551;
 bh=8NoHOEY7OHaburPdA9/fquYQYbqgO+XpL7EItGlu5EM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=kDbzatrn8bz9qK8hwKBl2yPQyD1o4CkZQFMknDBuDAy52r5vNIk7geGQB9AycgC/W
 jLN+TcgkHwWOEADHYQlbxiG5WC0z+lI1xkwG5jCklnxhAHaLFaxB3dfhfBiuH6V/Lk
 FGO28SoTcneegZzJeR90PDwiYSf/4RArlYzySXWjTYL7MmGPocAFUh3hCXwBwu/vRW
 cOJq46kE55YvUNWCPaUI2WLZ0b1xm4fQUGjSbyyJgMszGm6RDQMvUDrrpej/DTBlWm
 WCATv2CNkjXakI0x7/v9yJP/sO9/vQUEQhKJIhro4gxi6TiROmQz1OuFgH3N8iYLmB
 BIxka/id2mO1A==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: Andreas Schwab <schwab@suse.de>, wangyang <wangyang25@otcaix.iscas.ac.cn>,
 Helge Deller <deller@gmx.de>
Subject: [PULL 2/2] linux-user/riscv: preserve rs1 address for cbo.zero fault
 reporting
Date: Thu, 15 Oct 2026 22:02:25 +0200
Message-ID: <20261015200225.6314-3-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261015200225.6314-1-deller@kernel.org>
References: <20261015200225.6314-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=deller@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: wangyang <wangyang25@otcaix.iscas.ac.cn>

helper_cbo_zero() aligns the address down to the cache-block size before
probe_write(), and accel/tcg/user-exec.c:probe_access_internal() reports
that aligned address to cpu_loop_exit_sigsegv(), so a store fault from a
legal cbo.zero (e.g. on a read-only page) reports the aligned block base
as si_addr instead of the rs1 value supplied by the program. Native
RISC-V Linux reports the exact rs1 address. Keep the original address in
CPUState and use it when the fault is reported.

The saved address must not outlive the instruction that produced it. The
helper alone cannot guarantee that, because a store trigger or
breakpoint on the cbo.zero access leaves through the debug path instead
of one of the four fault consumers, and a later unrelated fault would
then report the stale cbo.zero address. Also drop the pending override
on every trap delivery: at the top of riscv_cpu_do_interrupt() and in
riscv_cpu_debug_excp_handler() for system mode, and right after
cpu_exec() returns in the linux-user cpu loop.

Tested: the read-only-page reproducer reports rs1 for offsets 1, 65 and
129; an mcontrol store-trigger reproducer reports the follow-up load's
own access-fault address instead of the earlier cbo.zero rs1.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4151
Suggested-by: David Harris <david.harris@gitlab.com>
Signed-off-by: wangyang <wangyang25@otcaix.iscas.ac.cn>
Signed-off-by: Helge Deller <deller@gmx.de>
---
 accel/tcg/user-exec.c         |  7 ++++++-
 include/hw/core/cpu.h         |  2 ++
 linux-user/riscv/cpu_loop.c   |  3 +++
 target/riscv/tcg/cpu_helper.c | 27 ++++++++++++++++++++++++---
 target/riscv/tcg/debug.c      |  3 +++
 target/riscv/tcg/op_helper.c  |  5 +++++
 6 files changed, 43 insertions(+), 4 deletions(-)

diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index a35aca7889..13c3845811 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -787,7 +787,12 @@ static int probe_access_internal(CPUArchState *env, vaddr addr,
         return TLB_INVALID_MASK;
     }
 
-    cpu_loop_exit_sigsegv(env_cpu(env), addr, access_type, maperr, ra);
+    CPUState *cpu = env_cpu(env);
+    if (cpu->exception_addr_valid) {
+        addr = cpu->exception_addr;
+        cpu->exception_addr_valid = false;
+    }
+    cpu_loop_exit_sigsegv(cpu, addr, access_type, maperr, ra);
 }
 
 int probe_access_flags(CPUArchState *env, vaddr addr, int size,
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index ae66f5e33e..1fd68367f6 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -560,6 +560,8 @@ struct CPUState {
     uint32_t tcg_cflags;
     uint32_t halted;
     int32_t exception_index;
+    vaddr exception_addr;
+    bool exception_addr_valid;
 
     bool vcpu_dirty;
     AccelCPUState *accel;
diff --git a/linux-user/riscv/cpu_loop.c b/linux-user/riscv/cpu_loop.c
index 6f27a06da4..dbf1d42d33 100644
--- a/linux-user/riscv/cpu_loop.c
+++ b/linux-user/riscv/cpu_loop.c
@@ -38,6 +38,9 @@ void cpu_loop(CPURISCVState *env)
         cpu_exec_end(cs);
         qemu_process_cpu_events(cs);
 
+        /* A trap ends the pending cbo.zero address override window. */
+        cs->exception_addr_valid = false;
+
         switch (trapnr) {
         case EXCP_INTERRUPT:
             /* just indicate that signals should be handled asap */
diff --git a/target/riscv/tcg/cpu_helper.c b/target/riscv/tcg/cpu_helper.c
index 07d9222652..4513c9bdbe 100644
--- a/target/riscv/tcg/cpu_helper.c
+++ b/target/riscv/tcg/cpu_helper.c
@@ -1537,7 +1537,12 @@ static void raise_mmu_exception(CPURISCVState *env, target_ulong address,
     default:
         g_assert_not_reached();
     }
-    env->badaddr = address;
+    if (cs->exception_addr_valid) {
+        env->badaddr = cs->exception_addr;
+        cs->exception_addr_valid = false;
+    } else {
+        env->badaddr = address;
+    }
     env->two_stage_lookup = two_stage;
     env->two_stage_indirect_lookup = two_stage_indirect;
 }
@@ -1588,7 +1593,12 @@ void riscv_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
         cs->exception_index = RISCV_EXCP_INST_ACCESS_FAULT;
     }
 
-    env->badaddr = addr;
+    if (cs->exception_addr_valid) {
+        env->badaddr = cs->exception_addr;
+        cs->exception_addr_valid = false;
+    } else {
+        env->badaddr = addr;
+    }
     env->two_stage_lookup = mmuidx_2stage(mmu_idx);
     env->two_stage_indirect_lookup = false;
     cpu_loop_exit_restore(cs, retaddr);
@@ -1621,7 +1631,12 @@ void riscv_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
     default:
         g_assert_not_reached();
     }
-    env->badaddr = addr;
+    if (cs->exception_addr_valid) {
+        env->badaddr = cs->exception_addr;
+        cs->exception_addr_valid = false;
+    } else {
+        env->badaddr = addr;
+    }
     env->two_stage_lookup = mmuidx_2stage(mmu_idx);
     env->two_stage_indirect_lookup = false;
     cpu_loop_exit_restore(cs, retaddr);
@@ -2047,6 +2062,12 @@ void riscv_cpu_do_interrupt(CPUState *cs)
 {
     RISCVCPU *cpu = RISCV_CPU(cs);
     CPURISCVState *env = &cpu->env;
+
+    /*
+     * A trap ends the pending cbo.zero address override window, so drop
+     * any saved rs1 that a store trigger or breakpoint left behind.
+     */
+    cs->exception_addr_valid = false;
     bool virt = env->virt_enabled;
     bool write_gva = false;
     bool always_storeamo = (env->excp_uw2 & RISCV_UW2_ALWAYS_STORE_AMO);
diff --git a/target/riscv/tcg/debug.c b/target/riscv/tcg/debug.c
index e4d719a1da..6962557251 100644
--- a/target/riscv/tcg/debug.c
+++ b/target/riscv/tcg/debug.c
@@ -973,6 +973,9 @@ void riscv_cpu_debug_excp_handler(CPUState *cs)
     RISCVCPU *cpu = RISCV_CPU(cs);
     CPURISCVState *env = &cpu->env;
 
+    /* A debug exit ends the cbo.zero address override window too. */
+    cs->exception_addr_valid = false;
+
     if (cs->watchpoint_hit) {
         if (cs->watchpoint_hit->flags & BP_CPU) {
             do_trigger_action(env, DBG_ACTION_BP);
diff --git a/target/riscv/tcg/op_helper.c b/target/riscv/tcg/op_helper.c
index b67c7718db..3fc993a207 100644
--- a/target/riscv/tcg/op_helper.c
+++ b/target/riscv/tcg/op_helper.c
@@ -188,9 +188,13 @@ void helper_cbo_zero(CPURISCVState *env, target_ulong address)
     int mmu_idx = riscv_env_mmu_index(env, false);
     uintptr_t ra = GETPC();
     void *mem;
+    CPUState *cs = env_cpu(env);
 
     check_zicbo_envcfg(env, MENVCFG_CBZE, ra);
 
+    cs->exception_addr = address;
+    cs->exception_addr_valid = true;
+
     /* Mask off low-bits to align-down to the cache-block. */
     address &= ~(cbozlen - 1);
 
@@ -218,6 +222,7 @@ void helper_cbo_zero(CPURISCVState *env, target_ulong address)
             cpu_stb_mmuidx_ra(env, address + i, 0, mmu_idx, ra);
         }
     }
+    cs->exception_addr_valid = false;
 }
 
 /*
-- 
2.54.0


