Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8329AEF070B
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Feb 2026 05:23:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpJje-0007pG-08; Mon, 09 Feb 2026 00:22:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ashish.a6@samsung.com>)
 id 1vpJja-0007ol-L7
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 00:22:54 -0500
Received: from mailout3.samsung.com ([203.254.224.33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ashish.a6@samsung.com>)
 id 1vpJjW-0002cv-Km
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 00:22:54 -0500
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
 by mailout3.samsung.com (KnoxPortal) with ESMTP id
 20260209052239epoutp0311b83262492875d534971625ba8cbb0f~SfI96nlq70967409674epoutp03E
 for <qemu-devel@nongnu.org>; Mon,  9 Feb 2026 05:22:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com
 20260209052239epoutp0311b83262492875d534971625ba8cbb0f~SfI96nlq70967409674epoutp03E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1770614559;
 bh=juNaRrWDo4GQDp3nBOsF/0BME6e3zW9FUkvdZPAYw4Y=;
 h=From:To:Cc:Subject:Date:References:From;
 b=HoNCN0lzTR1T03geDZmf4O25OoaGAyKi8gQKYTeacfmZoLeNJ7vezmrdUE2eVQ2bs
 hygm84slZrIdFOYc3kwSuXTxunw9eEDtD5MF19g3w4g/BeIHYU6nih6r9RmUR1Zf//
 cV+pIN4Jtz2YWPsFTRy5j9E1DVhLAn0ezq+v+lOs=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
 epcas5p2.samsung.com (KnoxPortal) with ESMTPS id
 20260209052238epcas5p2504c25e9cedae41140f6ea400e04d032~SfI9XrODq3048530485epcas5p26;
 Mon,  9 Feb 2026 05:22:38 +0000 (GMT)
Received: from epcas5p2.samsung.com (unknown [182.195.38.94]) by
 epsnrtp02.localdomain (Postfix) with ESMTP id 4f8Y3x49K0z2SSKX; Mon,  9 Feb
 2026 05:22:37 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
 epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
 20260209052236epcas5p4039ffceb22c042b5d12a01f4694ccee3~SfI7TntcN1005610056epcas5p4z;
 Mon,  9 Feb 2026 05:22:36 +0000 (GMT)
Received: from test-System-Product-Name.samsungds.net (unknown
 [107.99.41.85]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20260209052233epsmtip279e0203f54b67a81188b8de97e8f8248~SfI494M_w1548415484epsmtip2_;
 Mon,  9 Feb 2026 05:22:33 +0000 (GMT)
From: Ashish Anand <ashish.a6@samsung.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, saurabh@samsung.com,
 vishwa.mg@samsung.com, y.kaushal@samsung.com, ashish.anand202@gmail.com,
 Ashish Anand <ashish.a6@samsung.com>
Subject: [PATCH v4] target/arm: Implement WFE, SEV and SEVONPEND for Cortex-M
Date: Mon,  9 Feb 2026 10:49:31 +0530
Message-ID: <20260209051931.122531-1-ashish.a6@samsung.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260209052236epcas5p4039ffceb22c042b5d12a01f4694ccee3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260209052236epcas5p4039ffceb22c042b5d12a01f4694ccee3
References: <CGME20260209052236epcas5p4039ffceb22c042b5d12a01f4694ccee3@epcas5p4.samsung.com>
Received-SPF: pass client-ip=203.254.224.33;
 envelope-from=ashish.a6@samsung.com; helo=mailout3.samsung.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Currently, QEMU implements the 'Wait For Event' (WFE) instruction as a
simple yield. This causes high host CPU usage because guest
RTOS idle loops effectively become busy-wait loops.

To improve efficiency, this patch transitions WFE to use the architectural
'Halt' state (EXCP_HLT) for M-profile CPUs. This allows the host thread
to sleep when the guest is idle.

To support this transition, we implement the full architectural behavior
required for WFE, specifically the 'Event Register', 'SEVONPEND' logic,
and 'R_BPBR' exception handling requirements defined in the ARM
Architecture Reference Manual.

This patch enables resource-efficient idle emulation for Cortex-M.

Signed-off-by: Ashish Anand <ashish.a6@samsung.com>
---

Changes in v4:
1. Simplified nvic_update_pending_state() to determine scr_bank internally
   using exc_targets_secure() instead of requiring it as a parameter. (Peter Maydell)

Link to v3 - https://lore.kernel.org/qemu-devel/20260203130257.3263336-1-ashish.a6@samsung.com

 hw/intc/armv7m_nvic.c      | 79 +++++++++++++++++++++++++++++---------
 target/arm/cpu.c           |  6 +++
 target/arm/cpu.h           |  7 ++++
 target/arm/machine.c       | 19 +++++++++
 target/arm/tcg/helper.h    |  1 +
 target/arm/tcg/m_helper.c  |  5 +++
 target/arm/tcg/op_helper.c | 56 +++++++++++++++++++++++----
 target/arm/tcg/t16.decode  |  5 ++-
 target/arm/tcg/t32.decode  |  5 ++-
 target/arm/tcg/translate.c | 29 ++++++++++++--
 10 files changed, 179 insertions(+), 33 deletions(-)

diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index 28b34e9944..a7651f831e 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -221,6 +221,29 @@ static int exc_group_prio(NVICState *s, int rawprio, bool targets_secure)
     return rawprio;
 }
 
+/*
+ * Update the pending state of an exception vector.
+ * This is the central function for all updates to vec->pending.
+ * Handles SEVONPEND: if this is a 0->1 transition on an external interrupt
+ * and SEVONPEND is set in the appropriate SCR, sets the event register.
+ */
+static void nvic_update_pending_state(NVICState *s, VecInfo *vec,
+                                      int irq, uint8_t next_pending_val)
+{
+    uint8_t prev_pending_val = vec->pending;
+    vec->pending = next_pending_val;
+
+    /* Check for 0->1 transition on interrupts (>= NVIC_FIRST_IRQ) only */
+    if (!prev_pending_val && next_pending_val && irq >= NVIC_FIRST_IRQ) {
+        int scr_bank = exc_targets_secure(s, irq) ? M_REG_S : M_REG_NS;
+        /* SEVONPEND: interrupt going to pending is a WFE wakeup event */
+        if (s->cpu->env.v7m.scr[scr_bank] & R_V7M_SCR_SEVONPEND_MASK) {
+            s->cpu->env.event_register = true;
+            qemu_cpu_kick(CPU(s->cpu));
+        }
+    }
+}
+
 /* Recompute vectpending and exception_prio for a CPU which implements
  * the Security extension
  */
@@ -516,7 +539,7 @@ static void armv7m_nvic_clear_pending(NVICState *s, int irq, bool secure)
     }
     trace_nvic_clear_pending(irq, secure, vec->enabled, vec->prio);
     if (vec->pending) {
-        vec->pending = 0;
+        nvic_update_pending_state(s, vec, irq, 0);
         nvic_irq_update(s);
     }
 }
@@ -656,7 +679,7 @@ static void do_armv7m_nvic_set_pending(void *opaque, int irq, bool secure,
     }
 
     if (!vec->pending) {
-        vec->pending = 1;
+        nvic_update_pending_state(s, vec, irq, 1);
         nvic_irq_update(s);
     }
 }
@@ -753,7 +776,7 @@ void armv7m_nvic_set_pending_lazyfp(NVICState *s, int irq, bool secure)
         s->cpu->env.v7m.hfsr |= R_V7M_HFSR_FORCED_MASK;
     }
     if (!vec->pending) {
-        vec->pending = 1;
+        nvic_update_pending_state(s, vec, irq, 1);
         /*
          * We do not call nvic_irq_update(), because we know our caller
          * is going to handle causing us to take the exception by
@@ -790,7 +813,7 @@ void armv7m_nvic_acknowledge_irq(NVICState *s)
     trace_nvic_acknowledge_irq(pending, s->vectpending_prio);
 
     vec->active = 1;
-    vec->pending = 0;
+    nvic_update_pending_state(s, vec, pending, 0);
 
     write_v7m_exception(env, s->vectpending);
 
@@ -898,7 +921,7 @@ int armv7m_nvic_complete_irq(NVICState *s, int irq, bool secure)
          * happens for external IRQs
          */
         assert(irq >= NVIC_FIRST_IRQ);
-        vec->pending = 1;
+        nvic_update_pending_state(s, vec, irq, 1);
     }
 
     nvic_irq_update(s);
@@ -1657,7 +1680,7 @@ static void nvic_writel(NVICState *s, uint32_t offset, uint32_t value,
         }
         /* We don't implement deep-sleep so these bits are RAZ/WI.
          * The other bits in the register are banked.
-         * QEMU's implementation ignores SEVONPEND and SLEEPONEXIT, which
+         * QEMU's implementation ignores SLEEPONEXIT, which
          * is architecturally permitted.
          */
         value &= ~(R_V7M_SCR_SLEEPDEEP_MASK | R_V7M_SCR_SLEEPDEEPS_MASK);
@@ -1722,38 +1745,57 @@ static void nvic_writel(NVICState *s, uint32_t offset, uint32_t value,
                 (value & (1 << 10)) != 0;
             s->sec_vectors[ARMV7M_EXCP_SYSTICK].active =
                 (value & (1 << 11)) != 0;
-            s->sec_vectors[ARMV7M_EXCP_USAGE].pending =
-                (value & (1 << 12)) != 0;
-            s->sec_vectors[ARMV7M_EXCP_MEM].pending = (value & (1 << 13)) != 0;
-            s->sec_vectors[ARMV7M_EXCP_SVC].pending = (value & (1 << 15)) != 0;
+            nvic_update_pending_state(s, &s->sec_vectors[ARMV7M_EXCP_USAGE],
+                                      ARMV7M_EXCP_USAGE,
+                                      (value & (1 << 12)) != 0);
+            nvic_update_pending_state(s, &s->sec_vectors[ARMV7M_EXCP_MEM],
+                                      ARMV7M_EXCP_MEM,
+                                      (value & (1 << 13)) != 0);
+            nvic_update_pending_state(s, &s->sec_vectors[ARMV7M_EXCP_SVC],
+                                      ARMV7M_EXCP_SVC,
+                                      (value & (1 << 15)) != 0);
             s->sec_vectors[ARMV7M_EXCP_MEM].enabled = (value & (1 << 16)) != 0;
             s->sec_vectors[ARMV7M_EXCP_BUS].enabled = (value & (1 << 17)) != 0;
             s->sec_vectors[ARMV7M_EXCP_USAGE].enabled =
                 (value & (1 << 18)) != 0;
-            s->sec_vectors[ARMV7M_EXCP_HARD].pending = (value & (1 << 21)) != 0;
+            nvic_update_pending_state(s, &s->sec_vectors[ARMV7M_EXCP_HARD],
+                                      ARMV7M_EXCP_HARD,
+                                      (value & (1 << 21)) != 0);
             /* SecureFault not banked, but RAZ/WI to NS */
             s->vectors[ARMV7M_EXCP_SECURE].active = (value & (1 << 4)) != 0;
             s->vectors[ARMV7M_EXCP_SECURE].enabled = (value & (1 << 19)) != 0;
-            s->vectors[ARMV7M_EXCP_SECURE].pending = (value & (1 << 20)) != 0;
+            nvic_update_pending_state(s, &s->vectors[ARMV7M_EXCP_SECURE],
+                                      ARMV7M_EXCP_SECURE,
+                                      (value & (1 << 20)) != 0);
         } else {
             s->vectors[ARMV7M_EXCP_MEM].active = (value & (1 << 0)) != 0;
             if (arm_feature(&cpu->env, ARM_FEATURE_V8)) {
                 /* HARDFAULTPENDED is not present in v7M */
-                s->vectors[ARMV7M_EXCP_HARD].pending = (value & (1 << 21)) != 0;
+                nvic_update_pending_state(s, &s->vectors[ARMV7M_EXCP_HARD],
+                                          ARMV7M_EXCP_HARD,
+                                          (value & (1 << 21)) != 0);
             }
             s->vectors[ARMV7M_EXCP_USAGE].active = (value & (1 << 3)) != 0;
             s->vectors[ARMV7M_EXCP_SVC].active = (value & (1 << 7)) != 0;
             s->vectors[ARMV7M_EXCP_PENDSV].active = (value & (1 << 10)) != 0;
             s->vectors[ARMV7M_EXCP_SYSTICK].active = (value & (1 << 11)) != 0;
-            s->vectors[ARMV7M_EXCP_USAGE].pending = (value & (1 << 12)) != 0;
-            s->vectors[ARMV7M_EXCP_MEM].pending = (value & (1 << 13)) != 0;
-            s->vectors[ARMV7M_EXCP_SVC].pending = (value & (1 << 15)) != 0;
+            nvic_update_pending_state(s, &s->vectors[ARMV7M_EXCP_USAGE],
+                                      ARMV7M_EXCP_USAGE,
+                                      (value & (1 << 12)) != 0);
+            nvic_update_pending_state(s, &s->vectors[ARMV7M_EXCP_MEM],
+                                      ARMV7M_EXCP_MEM,
+                                      (value & (1 << 13)) != 0);
+            nvic_update_pending_state(s, &s->vectors[ARMV7M_EXCP_SVC],
+                                      ARMV7M_EXCP_SVC,
+                                      (value & (1 << 15)) != 0);
             s->vectors[ARMV7M_EXCP_MEM].enabled = (value & (1 << 16)) != 0;
             s->vectors[ARMV7M_EXCP_USAGE].enabled = (value & (1 << 18)) != 0;
         }
         if (attrs.secure || (cpu->env.v7m.aircr & R_V7M_AIRCR_BFHFNMINS_MASK)) {
             s->vectors[ARMV7M_EXCP_BUS].active = (value & (1 << 1)) != 0;
-            s->vectors[ARMV7M_EXCP_BUS].pending = (value & (1 << 14)) != 0;
+            nvic_update_pending_state(s, &s->vectors[ARMV7M_EXCP_BUS],
+                                      ARMV7M_EXCP_BUS,
+                                      (value & (1 << 14)) != 0);
             s->vectors[ARMV7M_EXCP_BUS].enabled = (value & (1 << 17)) != 0;
         }
         /* NMIACT can only be written if the write is of a zero, with
@@ -2389,7 +2431,8 @@ static MemTxResult nvic_sysreg_write(void *opaque, hwaddr addr,
                 (attrs.secure || s->itns[startvec + i]) &&
                 !(setval == 0 && s->vectors[startvec + i].level &&
                   !s->vectors[startvec + i].active)) {
-                s->vectors[startvec + i].pending = setval;
+                nvic_update_pending_state(s, &s->vectors[startvec + i],
+                                          startvec + i, setval);
             }
         }
         nvic_irq_update(s);
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 586202071d..e9bf516c92 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -143,6 +143,12 @@ static bool arm_cpu_has_work(CPUState *cs)
 {
     ARMCPU *cpu = ARM_CPU(cs);
 
+    if (arm_feature(&cpu->env, ARM_FEATURE_M)) {
+        if (cpu->env.event_register) {
+            return true;
+        }
+    }
+
     return (cpu->power_state != PSCI_OFF)
         && cpu_test_interrupt(cs,
                CPU_INTERRUPT_FIQ | CPU_INTERRUPT_HARD
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 21fee5e840..5ea9accba3 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -760,6 +760,13 @@ typedef struct CPUArchState {
     /* Optional fault info across tlb lookup. */
     ARMMMUFaultInfo *tlb_fi;
 
+    /*
+     * The event register is shared by all ARM profiles (A/R/M),
+     * so it is stored in the top-level CPU state.
+     * WFE/SEV handling is currently implemented only for M-profile.
+     */
+    bool event_register;
+
     /* Fields up to this point are cleared by a CPU reset */
     struct {} end_reset_fields;
 
diff --git a/target/arm/machine.c b/target/arm/machine.c
index 0befdb0b28..bbaae34449 100644
--- a/target/arm/machine.c
+++ b/target/arm/machine.c
@@ -508,6 +508,24 @@ static const VMStateDescription vmstate_m_mve = {
     },
 };
 
+static bool event_needed(void *opaque)
+{
+    ARMCPU *cpu = opaque;
+
+    return cpu->env.event_register;
+}
+
+static const VMStateDescription vmstate_event = {
+    .name = "cpu/event",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = event_needed,
+    .fields = (const VMStateField[]) {
+        VMSTATE_BOOL(env.event_register, ARMCPU),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static const VMStateDescription vmstate_m = {
     .name = "cpu/m",
     .version_id = 4,
@@ -1210,6 +1228,7 @@ const VMStateDescription vmstate_arm_cpu = {
         &vmstate_wfxt_timer,
         &vmstate_syndrome64,
         &vmstate_pstate64,
+        &vmstate_event,
         NULL
     }
 };
diff --git a/target/arm/tcg/helper.h b/target/arm/tcg/helper.h
index 4636d1bc03..5a10a9fba3 100644
--- a/target/arm/tcg/helper.h
+++ b/target/arm/tcg/helper.h
@@ -60,6 +60,7 @@ DEF_HELPER_1(yield, void, env)
 DEF_HELPER_1(pre_hvc, void, env)
 DEF_HELPER_2(pre_smc, void, env, i32)
 DEF_HELPER_1(vesb, void, env)
+DEF_HELPER_1(sev, void, env)
 
 DEF_HELPER_3(cpsr_write, void, env, i32, i32)
 DEF_HELPER_2(cpsr_write_eret, void, env, i32)
diff --git a/target/arm/tcg/m_helper.c b/target/arm/tcg/m_helper.c
index 3fb24c7790..0c3832a47f 100644
--- a/target/arm/tcg/m_helper.c
+++ b/target/arm/tcg/m_helper.c
@@ -962,7 +962,9 @@ static void v7m_exception_taken(ARMCPU *cpu, uint32_t lr, bool dotailchain,
      * Now we've done everything that might cause a derived exception
      * we can go ahead and activate whichever exception we're going to
      * take (which might now be the derived exception).
+     * Exception entry sets the event register (ARM ARM R_BPBR)
      */
+    env->event_register = true;
     armv7m_nvic_acknowledge_irq(env->nvic);
 
     /* Switch to target security state -- must do this before writing SPSEL */
@@ -1906,6 +1908,9 @@ static void do_v7m_exception_exit(ARMCPU *cpu)
     /* Otherwise, we have a successful exception exit. */
     arm_clear_exclusive(env);
     arm_rebuild_hflags(env);
+
+    /* Exception return sets the event register (ARM ARM R_BPBR) */
+    env->event_register = true;
     qemu_log_mask(CPU_LOG_INT, "...successful exception return\n");
 }
 
diff --git a/target/arm/tcg/op_helper.c b/target/arm/tcg/op_helper.c
index 4fbd219555..c7ab462d1d 100644
--- a/target/arm/tcg/op_helper.c
+++ b/target/arm/tcg/op_helper.c
@@ -469,16 +469,58 @@ void HELPER(wfit)(CPUARMState *env, uint64_t timeout)
 #endif
 }
 
+void HELPER(sev)(CPUARMState *env)
+{
+    CPUState *cs = env_cpu(env);
+    CPU_FOREACH(cs) {
+        ARMCPU *target_cpu = ARM_CPU(cs);
+        if (arm_feature(&target_cpu->env, ARM_FEATURE_M)) {
+            target_cpu->env.event_register = true;
+        }
+        if (!qemu_cpu_is_self(cs)) {
+            qemu_cpu_kick(cs);
+        }
+    }
+}
+
 void HELPER(wfe)(CPUARMState *env)
 {
-    /* This is a hint instruction that is semantically different
-     * from YIELD even though we currently implement it identically.
-     * Don't actually halt the CPU, just yield back to top
-     * level loop. This is not going into a "low power state"
-     * (ie halting until some event occurs), so we never take
-     * a configurable trap to a different exception level.
+#ifdef CONFIG_USER_ONLY
+    /*
+     * WFE in the user-mode emulator is a NOP. Real-world user-mode code
+     * shouldn't execute WFE, but if it does, we make it a NOP rather than
+     * aborting when we try to raise EXCP_HLT.
+     */
+    return;
+#else
+    /*
+     * WFE (Wait For Event) is a hint instruction.
+     * For Cortex-M (M-profile), we implement the strict architectural behavior:
+     * 1. Check the Event Register (set by SEV or SEVONPEND).
+     * 2. If set, clear it and continue (consume the event).
      */
-    HELPER(yield)(env);
+    if (arm_feature(env, ARM_FEATURE_M)) {
+        CPUState *cs = env_cpu(env);
+
+        if (env->event_register) {
+            env->event_register = false;
+            return;
+        }
+
+        cs->exception_index = EXCP_HLT;
+        cs->halted = 1;
+        cpu_loop_exit(cs);
+    } else {
+        /*
+         * For A-profile and others, we rely on the existing "yield" behavior.
+         * Don't actually halt the CPU, just yield back to top
+         * level loop. This is not going into a "low power state"
+         * (ie halting until some event occurs), so we never take
+         * a configurable trap to a different exception level
+         */
+        HELPER(yield)(env);
+    }
+#endif
 }
 
 void HELPER(yield)(CPUARMState *env)
diff --git a/target/arm/tcg/t16.decode b/target/arm/tcg/t16.decode
index 646c74929d..778fbf1627 100644
--- a/target/arm/tcg/t16.decode
+++ b/target/arm/tcg/t16.decode
@@ -228,8 +228,9 @@ REVSH           1011 1010 11 ... ...            @rdm
     WFE         1011 1111 0010 0000
     WFI         1011 1111 0011 0000
 
-    # TODO: Implement SEV, SEVL; may help SMP performance.
-    # SEV       1011 1111 0100 0000
+    # M-profile SEV is implemented.
+    # TODO: Implement SEV for other profiles, and SEVL for all profiles; may help SMP performance.
+    SEV         1011 1111 0100 0000
     # SEVL      1011 1111 0101 0000
 
     # The canonical nop has the second nibble as 0000, but the whole of the
diff --git a/target/arm/tcg/t32.decode b/target/arm/tcg/t32.decode
index d327178829..49b8d0037e 100644
--- a/target/arm/tcg/t32.decode
+++ b/target/arm/tcg/t32.decode
@@ -369,8 +369,9 @@ CLZ              1111 1010 1011 ---- 1111 .... 1000 ....      @rdm
         WFE      1111 0011 1010 1111 1000 0000 0000 0010
         WFI      1111 0011 1010 1111 1000 0000 0000 0011
 
-        # TODO: Implement SEV, SEVL; may help SMP performance.
-        # SEV    1111 0011 1010 1111 1000 0000 0000 0100
+        # M-profile SEV is implemented.
+        # TODO: Implement SEV for other profiles, and SEVL for all profiles; may help SMP performance.
+        SEV      1111 0011 1010 1111 1000 0000 0000 0100
         # SEVL   1111 0011 1010 1111 1000 0000 0000 0101
 
         ESB      1111 0011 1010 1111 1000 0000 0001 0000
diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index 63735d9789..c90b0106f7 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -3241,14 +3241,30 @@ static bool trans_YIELD(DisasContext *s, arg_YIELD *a)
     return true;
 }
 
+static bool trans_SEV(DisasContext *s, arg_SEV *a)
+{
+    /*
+     * Currently SEV is a NOP for non-M-profile and in user-mode emulation.
+     * For system-mode M-profile, it sets the event register.
+     */
+#ifndef CONFIG_USER_ONLY
+    if (arm_dc_feature(s, ARM_FEATURE_M)) {
+        gen_helper_sev(tcg_env);
+    }
+#endif
+    return true;
+}
+
 static bool trans_WFE(DisasContext *s, arg_WFE *a)
 {
     /*
      * When running single-threaded TCG code, use the helper to ensure that
-     * the next round-robin scheduled vCPU gets a crack.  In MTTCG mode we
-     * just skip this instruction.  Currently the SEV/SEVL instructions,
-     * which are *one* of many ways to wake the CPU from WFE, are not
-     * implemented so we can't sleep like WFI does.
+     * the next round-robin scheduled vCPU gets a crack.
+     *
+     * For Cortex-M, we implement the architectural WFE behavior (sleeping
+     * until an event occurs or the Event Register is set).
+     * For other profiles, we currently treat this as a NOP or yield,
+     * to preserve existing performance characteristics.
      */
     if (!(tb_cflags(s->base.tb) & CF_PARALLEL)) {
         gen_update_pc(s, curr_insn_len(s));
@@ -6807,6 +6823,11 @@ static void arm_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
             break;
         case DISAS_WFE:
             gen_helper_wfe(tcg_env);
+            /*
+             * The helper can return if the event register is set, so we
+             * must go back to the main loop to check for events.
+             */
+            tcg_gen_exit_tb(NULL, 0);
             break;
         case DISAS_YIELD:
             gen_helper_yield(tcg_env);
-- 
2.43.0


