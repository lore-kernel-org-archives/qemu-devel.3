Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC287CD5BB3
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 21:37:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQXXf-00037A-6s; Fri, 22 May 2026 17:36:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wQXWp-0000Bn-CH; Fri, 22 May 2026 17:35:36 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wQXWj-00081x-6L; Fri, 22 May 2026 17:35:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1779485633; bh=uYPhL+4ibz7lqI8gspHCwGuTnFu+/OP7WFg7jbd4oaM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=dj2/VTw44vnaYmL47jiAh4WZzcpS3weqTfu61wsv0Q+s97lZ3nS8sWLP42zGlnlf7
 nrCPYv6ur7ODPZtMNkxHTWLBDhxFeB9xCjMOoGMBnWWCg8WQaEmkZ5tI+gwoHS1Acw
 zio8Yvm0wia4BqPmSF9DGrgujXKVs6tfsMeQ3V5gEh1Bbn+KLRW1S54+ZS7wx6Ysa3
 Ud+iAuvGtXi0JYRVxbsuz57bqJMwYd1uQWM0av1U05zqP2VR2G+AhwBZq+9X7sgc5B
 5DcA5GxsZV7mX3MYzaw62hlWEL0guHs0uFYcSE6Lk5ye7zLZnrCnF317SjaX3W1XWx
 rmwPhkK6e+0zg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 708DE1AFADB;
 Sat, 23 May 2026 00:33:53 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 917303B7161;
 Sat, 23 May 2026 00:33:57 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, "Scott J. Goldman" <scottjgo@gmail.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.1 76/94] target/arm/hvf: Fix WFI halting to stop idle
 vCPU spinning
Date: Sat, 23 May 2026 00:33:33 +0300
Message-ID: <20260522213356.806058-18-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.1-20260522213549@cover.tls.msk.ru>
References: <qemu-stable-11.0.1-20260522213549@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

From: "Scott J. Goldman" <scottjgo@gmail.com>

Commit b5f8f77271 ("accel/hvf: Implement WFI without using pselect()")
changed hvf_wfi() from blocking the vCPU thread with pselect() to
returning EXCP_HLT, intending QEMU's main event loop to handle the
idle wait. However, cpu->halted was never set, so cpu_thread_is_idle()
always returns false and the vCPU thread spins at 100% CPU per core
while the guest is idle.

Fix this by:

1. Setting cpu->halted = 1 in hvf_wfi() so the vCPU thread sleeps on
   halt_cond in qemu_process_cpu_events().

2. Arming a per-vCPU QEMU_CLOCK_VIRTUAL timer to fire when the guest's
   virtual timer (CNTV_CVAL_EL0) would expire. This is necessary
   because HVF only delivers HV_EXIT_REASON_VTIMER_ACTIVATED during
   hv_vcpu_run(), which is not called while the CPU is halted. The
   timer callback mirrors the VTIMER_ACTIVATED handler: it raises the
   vtimer IRQ through the GIC and marks vtimer_masked, causing the
   interrupt delivery chain to wake the vCPU via qemu_cpu_kick().

3. Clearing cpu->halted in hvf_arch_vcpu_exec() when cpu_has_work()
   indicates a pending interrupt, and cancelling the WFI timer.

4. Re-arming the WFI timer from hvf_vm_state_change() on the resume
   transition for any halted vCPU, since the QEMUTimer is per-instance
   state and is not migrated. After cpu_synchronize_all_states() the
   migrated vtimer state is mirrored in env, so we can read CNTV_CTL
   and CNTV_CVAL from there. If the vtimer has already expired by the
   time the destination resumes, hvf_wfi_timer_cb() is invoked
   directly so the halted vCPU is woken up.

All wfi_timer handling (allocation, arming, deletion, and the resume
re-arm) is gated on !hvf_irqchip_in_kernel(): with the Apple in-kernel
vGIC, HVF owns the vtimer and delivers wake-ups itself.

Note for stable backports: this commit won't apply to 11.0 as
it has changes to handle the hvf in-kernel irqchip support that
landed after the 11.0 release. The v3 version of this commit:
  https://patchew.org/QEMU/20260427195516.46256-1-scottjgo@gmail.com/
should be suitable for 11.0 backporting (it is essentially
identical except that it doesn't make the changes conditional
on !hvf_irqchip_in_kernel()).

Cc: qemu-stable@nongnu.org
Fixes: b5f8f77271 ("accel/hvf: Implement WFI without using pselect()")
Signed-off-by: Scott J. Goldman <scottjgo@gmail.com>
Reviewed-by: Mohamed Mediouni <mohamed@unpredictable.fr>
[PMM: added note about stable backports to commit message]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit a86024eb2df56f7664cef16ec8e9a50a1dc3dd2f)
(Mjt: add hvf_irqchip_in_kernel() define)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/include/system/hvf_int.h b/include/system/hvf_int.h
index 2621164cb2..58fb865eba 100644
--- a/include/system/hvf_int.h
+++ b/include/system/hvf_int.h
@@ -48,6 +48,7 @@ struct AccelCPUState {
     hv_vcpu_exit_t *exit;
     bool vtimer_masked;
     bool guest_debug_enabled;
+    struct QEMUTimer *wfi_timer;
 #endif
 };
 
diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 5fc8f6bbbd..5016783062 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -28,6 +28,7 @@
 #include "hw/core/boards.h"
 #include "hw/core/irq.h"
 #include "qemu/main-loop.h"
+#include "qemu/timer.h"
 #include "system/cpus.h"
 #include "arm-powerctl.h"
 #include "target/arm/cpu.h"
@@ -40,6 +41,8 @@
 
 #include "gdbstub/enums.h"
 
+#define hvf_irqchip_in_kernel() 0 /* stub for qemu 11.0.x */
+
 #define MDSCR_EL1_SS_SHIFT  0
 #define MDSCR_EL1_MDE_SHIFT 15
 
@@ -301,6 +304,8 @@ void hvf_arm_init_debug(void)
 #define TMR_CTL_IMASK   (1 << 1)
 #define TMR_CTL_ISTATUS (1 << 2)
 
+static void hvf_wfi_timer_cb(void *opaque);
+
 static uint32_t chosen_ipa_bit_size;
 
 typedef struct HVFVTimer {
@@ -1214,6 +1219,11 @@ void hvf_arch_vcpu_destroy(CPUState *cpu)
 {
     hv_return_t ret;
 
+    if (!hvf_irqchip_in_kernel()) {
+        timer_free(cpu->accel->wfi_timer);
+        cpu->accel->wfi_timer = NULL;
+    }
+
     ret = hv_vcpu_destroy(cpu->accel->fd);
     assert_hvf_ok(ret);
 }
@@ -1352,6 +1362,11 @@ int hvf_arch_init_vcpu(CPUState *cpu)
                               arm_cpu->isar.idregs[ID_AA64MMFR0_EL1_IDX]);
     assert_hvf_ok(ret);
 
+    if (!hvf_irqchip_in_kernel()) {
+        cpu->accel->wfi_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
+                                             hvf_wfi_timer_cb, cpu);
+    }
+
     aarch64_add_sme_properties(OBJECT(cpu));
     return 0;
 }
@@ -2027,6 +2042,62 @@ static uint64_t hvf_vtimer_val_raw(void)
     return mach_absolute_time() - hvf_state->vtimer_offset;
 }
 
+static void hvf_wfi_timer_cb(void *opaque)
+{
+    CPUState *cpu = opaque;
+    ARMCPU *arm_cpu = ARM_CPU(cpu);
+
+    /*
+     * vtimer expired while the CPU was halted for WFI.
+     * Mirror HV_EXIT_REASON_VTIMER_ACTIVATED: raise the vtimer
+     * interrupt and mark as masked so hvf_sync_vtimer() will
+     * check and unmask when the guest handles it.
+     *
+     * The interrupt delivery chain (GIC -> cpu_interrupt ->
+     * qemu_cpu_kick) wakes the vCPU thread from halt_cond.
+     */
+    qemu_set_irq(arm_cpu->gt_timer_outputs[GTIMER_VIRT], 1);
+    cpu->accel->vtimer_masked = true;
+}
+
+/*
+ * Arm a host-side QEMU_CLOCK_VIRTUAL timer to fire when the guest's
+ * vtimer (CNTV_CVAL_EL0) is scheduled to expire. HVF only delivers
+ * HV_EXIT_REASON_VTIMER_ACTIVATED during hv_vcpu_run(), which we won't
+ * call while the vCPU is halted, so we need this to wake the vCPU.
+ *
+ * QEMU_CLOCK_VIRTUAL pauses while the VM is stopped, which keeps the
+ * timer in lockstep with the guest's view of vtime across pause/resume.
+ *
+ * Caller must supply the current CNTV_CTL_EL0 and CNTV_CVAL_EL0 values,
+ * since the appropriate source (HVF vs. env) depends on context.
+ *
+ * Returns 0 if the timer was armed (or if the vtimer is disabled/masked
+ * and the vCPU should still halt waiting on another event), or -1 if
+ * the vtimer has already expired.
+ */
+static int hvf_arm_wfi_timer(CPUState *cpu, uint64_t ctl, uint64_t cval)
+{
+    ARMCPU *arm_cpu = ARM_CPU(cpu);
+    uint64_t now;
+    int64_t delta_ns;
+
+    if (!(ctl & TMR_CTL_ENABLE) || (ctl & TMR_CTL_IMASK)) {
+        return 0;
+    }
+
+    now = hvf_vtimer_val_raw();
+    if (cval <= now) {
+        return -1;
+    }
+
+    delta_ns = muldiv64(cval - now, NANOSECONDS_PER_SECOND,
+                        arm_cpu->gt_cntfrq_hz);
+    timer_mod(cpu->accel->wfi_timer,
+              qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + delta_ns);
+    return 0;
+}
+
 static int hvf_wfi(CPUState *cpu)
 {
     if (cpu_has_work(cpu)) {
@@ -2037,6 +2108,29 @@ static int hvf_wfi(CPUState *cpu)
         return 0;
     }
 
+    if (!hvf_irqchip_in_kernel()) {
+        uint64_t ctl, cval;
+        hv_return_t r;
+
+        /*
+         * Read the vtimer state directly from HVF. We're on the vCPU
+         * thread, just exited from hv_vcpu_run(), so HVF holds the
+         * authoritative values and env may be stale.
+         */
+        r = hv_vcpu_get_sys_reg(cpu->accel->fd, HV_SYS_REG_CNTV_CTL_EL0,
+                                &ctl);
+        assert_hvf_ok(r);
+        r = hv_vcpu_get_sys_reg(cpu->accel->fd, HV_SYS_REG_CNTV_CVAL_EL0,
+                                &cval);
+        assert_hvf_ok(r);
+
+        if (hvf_arm_wfi_timer(cpu, ctl, cval) < 0) {
+            /* vtimer already expired, don't halt */
+            return 0;
+        }
+    }
+
+    cpu->halted = 1;
     return EXCP_HLT;
 }
 
@@ -2332,7 +2426,13 @@ int hvf_arch_vcpu_exec(CPUState *cpu)
     hv_return_t r;
 
     if (cpu->halted) {
-        return EXCP_HLT;
+        if (!cpu_has_work(cpu)) {
+            return EXCP_HLT;
+        }
+        cpu->halted = 0;
+        if (!hvf_irqchip_in_kernel()) {
+            timer_del(cpu->accel->wfi_timer);
+        }
     }
 
     flush_cpu_state(cpu);
@@ -2381,6 +2481,46 @@ static void hvf_vm_state_change(void *opaque, bool running, RunState state)
         /* Update vtimer offset on all CPUs */
         hvf_state->vtimer_offset = mach_absolute_time() - s->vtimer_val;
         cpu_synchronize_all_states();
+
+        /*
+         * After migration restore (or any resume), the wfi_timer is not
+         * scheduled on this QEMU instance, so re-arm it for any halted
+         * vCPU with a pending vtimer. For a non-migration resume the
+         * QEMU_CLOCK_VIRTUAL timer was already scheduled; recomputing the
+         * deadline produces the same value and is a harmless no-op.
+         *
+         * cpu_synchronize_all_states() above ensures env mirrors the
+         * authoritative vtimer state (whether that came from HVF or from
+         * the migration stream), so we can safely read it here from the
+         * iothread.
+         *
+         * Only applies when we own the wfi_timer; with an in-kernel vGIC
+         * the timer is never allocated and HVF handles vtimer wake-ups.
+         */
+        if (!hvf_irqchip_in_kernel()) {
+            CPUState *cpu;
+
+            CPU_FOREACH(cpu) {
+                ARMCPU *arm_cpu;
+                uint64_t ctl, cval;
+
+                if (!cpu->accel || !cpu->halted) {
+                    continue;
+                }
+
+                arm_cpu = ARM_CPU(cpu);
+                ctl = arm_cpu->env.cp15.c14_timer[GTIMER_VIRT].ctl;
+                cval = arm_cpu->env.cp15.c14_timer[GTIMER_VIRT].cval;
+
+                if (hvf_arm_wfi_timer(cpu, ctl, cval) < 0) {
+                    /*
+                     * vtimer already expired while we were paused; raise
+                     * the IRQ now so the halted vCPU wakes up.
+                     */
+                    hvf_wfi_timer_cb(cpu);
+                }
+            }
+        }
     } else {
         /* Remember vtimer value on every pause */
         s->vtimer_val = hvf_vtimer_val_raw();
-- 
2.47.3


