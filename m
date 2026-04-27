Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA348FF8867
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 19:59:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHS6U-000411-NU; Mon, 27 Apr 2026 15:58:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <scottjgo@gmail.com>)
 id 1wHS6J-0003nB-QE
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 15:58:43 -0400
Received: from mail-dl1-x122d.google.com ([2607:f8b0:4864:20::122d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <scottjgo@gmail.com>)
 id 1wHS6E-00032G-Kq
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 15:58:39 -0400
Received: by mail-dl1-x122d.google.com with SMTP id
 a92af1059eb24-12c6df0b9bbso1221750c88.1
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 12:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777319913; x=1777924713; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8jgHfKteQ6Y95ijog+Upvmsgb+UL3IMJGtNmXlOgJv4=;
 b=UJSKXaOkadLBX5nopnjuG8Gk44GN/CB4dEi9vtYHAD/E3QXWH9vIfE9PDp2EdI1+VT
 57L4Frg3vy5p8765treFPDU55a4zrXedFpHYDgAzWD6M7r1lvT1uTJxM6e840nflhtI+
 bWGjvpbmNu7vjzb4kkWt/IMvzrZH3rZiJUauL8DzZ5yUsxkIe3mHRyMTf3covzanYkQh
 22w2E8lsvvGS4i7bHMmZ7iAtbinX7S9fsHIHxMoVueev7asY/lsr0HlTkjUkLPcRpfnN
 irIBxcZCl6xKhZ4pP7plYukqRmP81os8dWt1AG0NR/jjT7c4zjll7uEwmMX2HL37F6rZ
 Q9Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777319913; x=1777924713;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8jgHfKteQ6Y95ijog+Upvmsgb+UL3IMJGtNmXlOgJv4=;
 b=npIlub27Laj8RY5d0C6QEYlzzUnYi1J+Ygxeht040A+3l5YkgLaqHYP+jzsqYnjNJ0
 +Di6p4zczpnGvuP5dnhKEhBe8wQTH3MzZIRaJppNz/GUtiY/GQedIVW4ftexxUMg2pDP
 4Ecyn5VnxL3KyAnbdh4bT7KpaRANuh8VpMgPPoRgs0wGgN/KuVZDcjVXeRzcANBS5dZ5
 SFeTT92Zzun8fW1u5SOBoSXzGxVCoVd8IQoQUrNQfE3c8Zd0/MIDcSXrh/rvpgCUBy5q
 npc8kib/tvIRyQ2zMd8ryidS/cwNro5j6FZ+Kh2ij071mp6PADJdzOYWFCPJ1YX8HHez
 wgUg==
X-Gm-Message-State: AOJu0YwjMhYRk+VQx4sX6ZhxF5aB32NNFHOWZiXzzy1HS436e/kuLT2v
 lADWyfJ8sKQJNY391ODQQJ9Ha9sHK4WbgK4posg0EQ1USMay/jm0QK80/0jhzXopeOU=
X-Gm-Gg: AeBDiesiipp3PVp4lx1YW5aXCYDr3DEPJunoDMO9JRL7Q7RVisfQin2tPqsHUaUQonp
 sbHBLd5cr9Sd5FakJ8ZjTMfDsK9ytYeo8ImveqlqYKAihDEBHA3tVCC3LnG4eNsNpV95L+u9V/V
 DpEH85xuUBzvUwat5soZ+sutQw3uUU59mrrSwEo63GyKg97DzfUzPAH/g8zauYjRxa4sFyoWXD7
 vY8SWjjiir+jBLFumQRgFqB8+NKdaJKp+eSeG/zUfDrKo5IXCHgIZUejlI02huSQ5e+VBEp9dBv
 UKsOqrLkukwmqsD3XXCRIJV4Rt6TKgWzxZ8Nyl8fpy5LeTIgQJ/SsRDEPOfZMZxPnMVwlcSjICL
 oe6AHdZWFwmFtX1RqanpRisodigPZ8f3xiwoimR1RLXGOT/IWoLsEXDiRInwhMI44uJRJKTYOam
 ygRW0BSCrNO+sDvZsfPgZh1mUmk1D3QY0k4VqNFTIZZZw/hSDRBNk7cBFkMDkTYCUKtijWl64OV
 r2c9gY34OE1h1MVaiCoCLUhXiAIYL7p6xWP7w==
X-Received: by 2002:a05:7022:e28:b0:128:d51a:5161 with SMTP id
 a92af1059eb24-12ddd9dceb7mr164546c88.27.1777319912386; 
 Mon, 27 Apr 2026 12:58:32 -0700 (PDT)
Received: from localhost.localdomain ([2601:645:8200:47:f4a5:bd04:3ca7:5727])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12ddd927c5fsm347084c88.3.2026.04.27.12.58.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 27 Apr 2026 12:58:31 -0700 (PDT)
From: "Scott J. Goldman" <scottjgo@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, Phil Dennis-Jordan <phil@philjordan.eu>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Scott J. Goldman" <scottjgo@gmail.com>
Subject: [PATCH v3] target/arm/hvf: Fix WFI halting to stop idle vCPU spinning
Date: Mon, 27 Apr 2026 12:55:16 -0700
Message-ID: <20260427195516.46256-1-scottjgo@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260410055045.63001-1-scottjgo@gmail.com>
References: <20260410055045.63001-1-scottjgo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::122d;
 envelope-from=scottjgo@gmail.com; helo=mail-dl1-x122d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Fixes: b5f8f77271 ("accel/hvf: Implement WFI without using pselect()")
Signed-off-by: Scott J. Goldman <scottjgo@gmail.com>
---
Changes since v2:
 - Use QEMU_CLOCK_VIRTUAL instead of QEMU_CLOCK_HOST so the timer
   pauses with the VM and a halted vCPU isn't woken (or its IRQ
   raised) while the user has stopped the guest. (Peter)
 - Convert vtimer ticks to nanoseconds with muldiv64() to avoid
   intermediate overflow. (Peter)
 - Re-arm the WFI timer from hvf_vm_state_change() on the resume
   transition so a halted vCPU on the migration destination is
   woken when its vtimer expires (the QEMUTimer is per-instance
   state and isn't migrated). (Peter)
v2: https://lore.kernel.org/qemu-devel/20260410055045.63001-1-scottjgo@gmail.com/
v1: https://lore.kernel.org/qemu-devel/20260410044726.61853-1-scottjgo@gmail.com/

 include/system/hvf_int.h |   1 +
 target/arm/hvf/hvf.c     | 124 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 124 insertions(+), 1 deletion(-)

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
index 678afe5c8e..a19d7a5e1f 100644
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
@@ -301,6 +302,8 @@ void hvf_arm_init_debug(void)
 #define TMR_CTL_IMASK   (1 << 1)
 #define TMR_CTL_ISTATUS (1 << 2)
 
+static void hvf_wfi_timer_cb(void *opaque);
+
 static uint32_t chosen_ipa_bit_size;
 
 typedef struct HVFVTimer {
@@ -1214,6 +1217,9 @@ void hvf_arch_vcpu_destroy(CPUState *cpu)
 {
     hv_return_t ret;
 
+    timer_free(cpu->accel->wfi_timer);
+    cpu->accel->wfi_timer = NULL;
+
     ret = hv_vcpu_destroy(cpu->accel->fd);
     assert_hvf_ok(ret);
 }
@@ -1352,6 +1358,9 @@ int hvf_arch_init_vcpu(CPUState *cpu)
                               arm_cpu->isar.idregs[ID_AA64MMFR0_EL1_IDX]);
     assert_hvf_ok(ret);
 
+    cpu->accel->wfi_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
+                                          hvf_wfi_timer_cb, cpu);
+
     aarch64_add_sme_properties(OBJECT(cpu));
     return 0;
 }
@@ -2027,8 +2036,67 @@ static uint64_t hvf_vtimer_val_raw(void)
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
+    uint64_t ctl, cval;
+    hv_return_t r;
+
     if (cpu_has_work(cpu)) {
         /*
          * Don't bother to go into our "low power state" if
@@ -2037,6 +2105,22 @@ static int hvf_wfi(CPUState *cpu)
         return 0;
     }
 
+    /*
+     * Read the vtimer state directly from HVF. We're on the vCPU thread,
+     * just exited from hv_vcpu_run(), so HVF holds the authoritative
+     * values and env may be stale.
+     */
+    r = hv_vcpu_get_sys_reg(cpu->accel->fd, HV_SYS_REG_CNTV_CTL_EL0, &ctl);
+    assert_hvf_ok(r);
+    r = hv_vcpu_get_sys_reg(cpu->accel->fd, HV_SYS_REG_CNTV_CVAL_EL0, &cval);
+    assert_hvf_ok(r);
+
+    if (hvf_arm_wfi_timer(cpu, ctl, cval) < 0) {
+        /* vtimer already expired, don't halt */
+        return 0;
+    }
+
+    cpu->halted = 1;
     return EXCP_HLT;
 }
 
@@ -2332,7 +2416,11 @@ int hvf_arch_vcpu_exec(CPUState *cpu)
     hv_return_t r;
 
     if (cpu->halted) {
-        return EXCP_HLT;
+        if (!cpu_has_work(cpu)) {
+            return EXCP_HLT;
+        }
+        cpu->halted = 0;
+        timer_del(cpu->accel->wfi_timer);
     }
 
     flush_cpu_state(cpu);
@@ -2376,11 +2464,45 @@ static const VMStateDescription vmstate_hvf_vtimer = {
 static void hvf_vm_state_change(void *opaque, bool running, RunState state)
 {
     HVFVTimer *s = opaque;
+    CPUState *cpu;
 
     if (running) {
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
+         */
+        CPU_FOREACH(cpu) {
+            ARMCPU *arm_cpu;
+            uint64_t ctl, cval;
+
+            if (!cpu->accel || !cpu->halted) {
+                continue;
+            }
+
+            arm_cpu = ARM_CPU(cpu);
+            ctl = arm_cpu->env.cp15.c14_timer[GTIMER_VIRT].ctl;
+            cval = arm_cpu->env.cp15.c14_timer[GTIMER_VIRT].cval;
+
+            if (hvf_arm_wfi_timer(cpu, ctl, cval) < 0) {
+                /*
+                 * vtimer already expired while we were paused; raise the
+                 * IRQ now so the halted vCPU wakes up.
+                 */
+                hvf_wfi_timer_cb(cpu);
+            }
+        }
     } else {
         /* Remember vtimer value on every pause */
         s->vtimer_val = hvf_vtimer_val_raw();
-- 
2.50.1 (Apple Git-155)


