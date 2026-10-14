Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3CB8C3DA7A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 18:16:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xH3WY-0002T5-5i; Wed, 14 Oct 2026 14:16:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wangyang25@otcaix.iscas.ac.cn>)
 id 1xH3WR-0002Sq-8u; Wed, 14 Oct 2026 14:16:15 -0400
Received: from smtp21.cstnet.cn ([159.226.251.21] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <wangyang25@otcaix.iscas.ac.cn>)
 id 1xH3WN-00010h-Uv; Wed, 14 Oct 2026 14:16:15 -0400
Received: from DESKTOP-7FLBREN (unknown [124.16.137.194])
 by APP-01 (Coremail) with SMTP id qwCowADnuOzgxs9qifjeCg--.49849S4;
 Thu, 15 Oct 2026 02:16:01 +0800 (CST)
From: wangyang <wangyang25@otcaix.iscas.ac.cn>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 daniel.barboza@oss.qualcomm.com
Subject: [PATCH] linux-user/riscv: preserve rs1 address for cbo.zero fault
 reporting
Date: Thu, 15 Oct 2026 02:15:59 +0800
Message-ID: <20261014181559.1567-1-wangyang25@otcaix.iscas.ac.cn>
X-Mailer: git-send-email 2.55.0.windows.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowADnuOzgxs9qifjeCg--.49849S4
X-Coremail-Antispam: 1UD129KBjvJXoW3Xry7Xr1xXFykGF43tr45trb_yoWxCr4UpF
 Z7CrW7Kr93tFn7Xw4ftw4jvF15Wr4vgFsrG34ku3yS9r4Sq3yfZw1Dtay7uF4UGFs5XF4j
 vFsFyryUAFyUXFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUU9Ib7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4
 A2jsIEc7CjxVAFwI0_Gr0_Gr1UM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x2
 0xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18Mc
 Ij6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l
 c7CjxVAaw2AFwI0_JF0_Jw1lc2xSY4AK67AK6ryl42xK82IYc2Ij64vIr41l4I8I3I0E4I
 kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
 WwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr
 0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWU
 JVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJb
 IYCTnIWIevJa73UjIFyTuYvjxUkco2DUUUU
X-Originating-IP: [124.16.137.194]
X-CM-SenderInfo: 5zdqw5xdqjjk46rwut1l0ox2xfdvhtffof0/
Received-SPF: pass client-ip=159.226.251.21;
 envelope-from=wangyang25@otcaix.iscas.ac.cn; helo=cstnet.cn
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
2.55.0.windows.2


