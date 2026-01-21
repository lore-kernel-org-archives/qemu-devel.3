Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B163C4452F
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 13:28:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viYFN-0002zu-JE; Wed, 21 Jan 2026 08:27:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ashish.a6@samsung.com>)
 id 1viYFE-0002xP-5l
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 08:27:40 -0500
Received: from mailout4.samsung.com ([203.254.224.34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ashish.a6@samsung.com>)
 id 1viYF9-0005ZW-DT
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 08:27:35 -0500
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
 by mailout4.samsung.com (KnoxPortal) with ESMTP id
 20260121132718epoutp047f6e489cf21230eaf2806bda2db974cb~Mwfs7mPKP0379103791epoutp047
 for <qemu-devel@nongnu.org>; Wed, 21 Jan 2026 13:27:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com
 20260121132718epoutp047f6e489cf21230eaf2806bda2db974cb~Mwfs7mPKP0379103791epoutp047
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1769002038;
 bh=Gwi1TxQwmoZPtcBbpA+OJn2qQ9CTofn5+hjRbCesp9I=;
 h=From:To:Cc:Subject:Date:References:From;
 b=YMSyEbdsGi1BDgAENI1qL+DhWggaaUGiY/p6t4zy2336GCTDCgzJxkTB8AyZRzfxh
 PRA/fe8vWpK+IYsWPa6GkAUwR4tWtbvHPxSRgBtG+9mNYK6+fL9XrJmh7hoc4J7c+A
 6kouqrOskpLHTJS6KKpnNZjMIPNfqfUXVsq+iiZ8=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
 epcas5p2.samsung.com (KnoxPortal) with ESMTPS id
 20260121132717epcas5p2f74288df36f59c6fd92828dc5355ca44~MwfsAUxJ51144411444epcas5p2e;
 Wed, 21 Jan 2026 13:27:17 +0000 (GMT)
Received: from epcas5p3.samsung.com (unknown [182.195.38.92]) by
 epsnrtp01.localdomain (Postfix) with ESMTP id 4dx4jw3KhFz6B9m7; Wed, 21 Jan
 2026 13:27:16 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
 epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
 20260121132716epcas5p1cab4021fbcd469b95d13ef4b4adc757f~MwfqsRN1k3003430034epcas5p1k;
 Wed, 21 Jan 2026 13:27:16 +0000 (GMT)
Received: from test-System-Product-Name.samsungds.net (unknown
 [107.99.41.85]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20260121132714epsmtip1236b07de3006579a5b0315605f27635f~MwfpmHgkg3097530975epsmtip14;
 Wed, 21 Jan 2026 13:27:14 +0000 (GMT)
From: Ashish Anand <ashish.a6@samsung.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, saurabh@samsung.com,
 vishwa.mg@samsung.com, y.kaushal@samsung.com, ashish.anand202@gmail.com,
 Ashish Anand <ashish.a6@samsung.com>
Subject: [PATCH v2] target/arm: Implement WFE, SEV and SEVONPEND for Cortex-M
Date: Wed, 21 Jan 2026 18:54:21 +0530
Message-ID: <20260121132421.2220928-1-ashish.a6@samsung.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260121132716epcas5p1cab4021fbcd469b95d13ef4b4adc757f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260121132716epcas5p1cab4021fbcd469b95d13ef4b4adc757f
References: <CGME20260121132716epcas5p1cab4021fbcd469b95d13ef4b4adc757f@epcas5p1.samsung.com>
Received-SPF: pass client-ip=203.254.224.34;
 envelope-from=ashish.a6@samsung.com; helo=mailout4.samsung.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.069,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Changes in v2:
1. Added R_BPBR handling as required by the Armv8-M architecture.
2. Unified pending-state updates to detect interrupt transitions for SEVONPEND.
3. Moved the Event Register to the top-level ARM CPU state, since it is
   architecturally shared between A-profile and M-profile CPUs.
4. Updated migration handling to be profile-agnostic so the state can be
   reused if A-profile WFE support is implemented in the future. 
5. Added CONFIG_USER_ONLY handling for WFE/SEV and tightened profile checks.
6. Addressed review comments and fixes raised during v1 discussion. 

Link to v1 - https://lore.kernel.org/qemu-devel/20251223120012.541777-1-ashish.a6@samsung.com/


 hw/intc/armv7m_nvic.c      | 85 ++++++++++++++++++++++++++++++--------
 target/arm/cpu.c           |  6 +++
 target/arm/cpu.h           |  7 ++++
 target/arm/machine.c       | 19 +++++++++
 target/arm/tcg/helper.h    |  1 +
 target/arm/tcg/m_helper.c  |  5 +++
 target/arm/tcg/op_helper.c | 56 +++++++++++++++++++++----
 target/arm/tcg/t16.decode  |  5 ++-
 target/arm/tcg/t32.decode  |  5 ++-
 target/arm/tcg/translate.c | 29 +++++++++++--
 10 files changed, 185 insertions(+), 33 deletions(-)

diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index 3a31eb56f3..854d27e413 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -221,6 +221,40 @@ static int exc_group_prio(NVICState *s, int rawprio, bool targets_secure)
     return rawprio;
 }
 
+/*
+ * Update the pending state of an exception vector.
+ * This is the central function for all updates to vec->pending.
+ * Handles SEVONPEND: if this is a 0->1 transition on an external interrupt
+ * and SEVONPEND is set in the appropriate SCR, sets the event register.
+ */
+static void nvic_update_pending_state(NVICState *s, int irq, bool secure,
+                                      uint8_t next_pending_val)
+{
+    VecInfo *vec;
+    int scr_bank;
+    uint8_t prev_pending_val;
+
+    if (secure && exc_is_banked(irq)) {
+        vec = &s->sec_vectors[irq];
+        scr_bank = M_REG_S;
+    } else {
+        vec = &s->vectors[irq];
+        scr_bank = M_REG_NS;
+    }
+
+    prev_pending_val = vec->pending;
+    vec->pending = next_pending_val;
+
+    /* Check for 0->1 transition on interrupts (>= NVIC_FIRST_IRQ) only */
+    if (!prev_pending_val && next_pending_val && irq >= NVIC_FIRST_IRQ) {
+        /* SEVONPEND: interrupt going to pending is a WFE wakeup event */
+        if (s->cpu->env.v7m.scr[scr_bank] & R_V7M_SCR_SEVONPEND_MASK) {
+            s->cpu->env.event_register = 1;
+            qemu_cpu_kick(CPU(s->cpu));
+        }
+    }
+}
+
 /* Recompute vectpending and exception_prio for a CPU which implements
  * the Security extension
  */
@@ -516,7 +550,7 @@ static void armv7m_nvic_clear_pending(NVICState *s, int irq, bool secure)
     }
     trace_nvic_clear_pending(irq, secure, vec->enabled, vec->prio);
     if (vec->pending) {
-        vec->pending = 0;
+        nvic_update_pending_state(s, irq, secure, 0);
         nvic_irq_update(s);
     }
 }
@@ -656,7 +690,7 @@ static void do_armv7m_nvic_set_pending(void *opaque, int irq, bool secure,
     }
 
     if (!vec->pending) {
-        vec->pending = 1;
+        nvic_update_pending_state(s, irq, secure, 1);
         nvic_irq_update(s);
     }
 }
@@ -753,7 +787,7 @@ void armv7m_nvic_set_pending_lazyfp(NVICState *s, int irq, bool secure)
         s->cpu->env.v7m.hfsr |= R_V7M_HFSR_FORCED_MASK;
     }
     if (!vec->pending) {
-        vec->pending = 1;
+        nvic_update_pending_state(s, irq, secure, 1);
         /*
          * We do not call nvic_irq_update(), because we know our caller
          * is going to handle causing us to take the exception by
@@ -790,7 +824,12 @@ void armv7m_nvic_acknowledge_irq(NVICState *s)
     trace_nvic_acknowledge_irq(pending, s->vectpending_prio);
 
     vec->active = 1;
-    vec->pending = 0;
+    /*
+     * s->vectpending_is_s_banked already represents secure && exc_is_banked()
+     * nvic_update_pending_state uses the secure parameter with exc_is_banked()
+     * internally to select the right vector, so we can pass this directly.
+     */
+    nvic_update_pending_state(s, pending, s->vectpending_is_s_banked, 0);
 
     write_v7m_exception(env, s->vectpending);
 
@@ -898,7 +937,7 @@ int armv7m_nvic_complete_irq(NVICState *s, int irq, bool secure)
          * happens for external IRQs
          */
         assert(irq >= NVIC_FIRST_IRQ);
-        vec->pending = 1;
+        nvic_update_pending_state(s, irq, secure, 1);
     }
 
     nvic_irq_update(s);
@@ -1657,7 +1696,7 @@ static void nvic_writel(NVICState *s, uint32_t offset, uint32_t value,
         }
         /* We don't implement deep-sleep so these bits are RAZ/WI.
          * The other bits in the register are banked.
-         * QEMU's implementation ignores SEVONPEND and SLEEPONEXIT, which
+         * QEMU's implementation ignores SLEEPONEXIT, which
          * is architecturally permitted.
          */
         value &= ~(R_V7M_SCR_SLEEPDEEP_MASK | R_V7M_SCR_SLEEPDEEPS_MASK);
@@ -1722,38 +1761,47 @@ static void nvic_writel(NVICState *s, uint32_t offset, uint32_t value,
                 (value & (1 << 10)) != 0;
             s->sec_vectors[ARMV7M_EXCP_SYSTICK].active =
                 (value & (1 << 11)) != 0;
-            s->sec_vectors[ARMV7M_EXCP_USAGE].pending =
-                (value & (1 << 12)) != 0;
-            s->sec_vectors[ARMV7M_EXCP_MEM].pending = (value & (1 << 13)) != 0;
-            s->sec_vectors[ARMV7M_EXCP_SVC].pending = (value & (1 << 15)) != 0;
+            nvic_update_pending_state(s, ARMV7M_EXCP_USAGE, attrs.secure,
+                                      (value & (1 << 12)) != 0);
+            nvic_update_pending_state(s, ARMV7M_EXCP_MEM, attrs.secure,
+                                      (value & (1 << 13)) != 0);
+            nvic_update_pending_state(s, ARMV7M_EXCP_SVC, attrs.secure,
+                                      (value & (1 << 15)) != 0);
             s->sec_vectors[ARMV7M_EXCP_MEM].enabled = (value & (1 << 16)) != 0;
             s->sec_vectors[ARMV7M_EXCP_BUS].enabled = (value & (1 << 17)) != 0;
             s->sec_vectors[ARMV7M_EXCP_USAGE].enabled =
                 (value & (1 << 18)) != 0;
-            s->sec_vectors[ARMV7M_EXCP_HARD].pending = (value & (1 << 21)) != 0;
+            nvic_update_pending_state(s, ARMV7M_EXCP_HARD, attrs.secure,
+                                      (value & (1 << 21)) != 0);
             /* SecureFault not banked, but RAZ/WI to NS */
             s->vectors[ARMV7M_EXCP_SECURE].active = (value & (1 << 4)) != 0;
             s->vectors[ARMV7M_EXCP_SECURE].enabled = (value & (1 << 19)) != 0;
-            s->vectors[ARMV7M_EXCP_SECURE].pending = (value & (1 << 20)) != 0;
+            nvic_update_pending_state(s, ARMV7M_EXCP_SECURE, attrs.secure,
+                                      (value & (1 << 20)) != 0);
         } else {
             s->vectors[ARMV7M_EXCP_MEM].active = (value & (1 << 0)) != 0;
             if (arm_feature(&cpu->env, ARM_FEATURE_V8)) {
                 /* HARDFAULTPENDED is not present in v7M */
-                s->vectors[ARMV7M_EXCP_HARD].pending = (value & (1 << 21)) != 0;
+                nvic_update_pending_state(s, ARMV7M_EXCP_HARD, attrs.secure,
+                                          (value & (1 << 21)) != 0);
             }
             s->vectors[ARMV7M_EXCP_USAGE].active = (value & (1 << 3)) != 0;
             s->vectors[ARMV7M_EXCP_SVC].active = (value & (1 << 7)) != 0;
             s->vectors[ARMV7M_EXCP_PENDSV].active = (value & (1 << 10)) != 0;
             s->vectors[ARMV7M_EXCP_SYSTICK].active = (value & (1 << 11)) != 0;
-            s->vectors[ARMV7M_EXCP_USAGE].pending = (value & (1 << 12)) != 0;
-            s->vectors[ARMV7M_EXCP_MEM].pending = (value & (1 << 13)) != 0;
-            s->vectors[ARMV7M_EXCP_SVC].pending = (value & (1 << 15)) != 0;
+            nvic_update_pending_state(s, ARMV7M_EXCP_USAGE, attrs.secure,
+                                      (value & (1 << 12)) != 0);
+            nvic_update_pending_state(s, ARMV7M_EXCP_MEM, attrs.secure,
+                                      (value & (1 << 13)) != 0);
+            nvic_update_pending_state(s, ARMV7M_EXCP_SVC, attrs.secure,
+                                      (value & (1 << 15)) != 0);
             s->vectors[ARMV7M_EXCP_MEM].enabled = (value & (1 << 16)) != 0;
             s->vectors[ARMV7M_EXCP_USAGE].enabled = (value & (1 << 18)) != 0;
         }
         if (attrs.secure || (cpu->env.v7m.aircr & R_V7M_AIRCR_BFHFNMINS_MASK)) {
             s->vectors[ARMV7M_EXCP_BUS].active = (value & (1 << 1)) != 0;
-            s->vectors[ARMV7M_EXCP_BUS].pending = (value & (1 << 14)) != 0;
+            nvic_update_pending_state(s, ARMV7M_EXCP_BUS, attrs.secure,
+                                      (value & (1 << 14)) != 0);
             s->vectors[ARMV7M_EXCP_BUS].enabled = (value & (1 << 17)) != 0;
         }
         /* NMIACT can only be written if the write is of a zero, with
@@ -2389,7 +2437,8 @@ static MemTxResult nvic_sysreg_write(void *opaque, hwaddr addr,
                 (attrs.secure || s->itns[startvec + i]) &&
                 !(setval == 0 && s->vectors[startvec + i].level &&
                   !s->vectors[startvec + i].active)) {
-                s->vectors[startvec + i].pending = setval;
+                nvic_update_pending_state(s, startvec + i, attrs.secure,
+                                          setval);
             }
         }
         nvic_irq_update(s);
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 05fa3339b1..9fc93b51bb 100644
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
index 2f124d1b15..bf3a2ef03e 100644
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
+    uint32_t event_register;
+
     /* Fields up to this point are cleared by a CPU reset */
     struct {} end_reset_fields;
 
diff --git a/target/arm/machine.c b/target/arm/machine.c
index 0befdb0b28..814a74745f 100644
--- a/target/arm/machine.c
+++ b/target/arm/machine.c
@@ -508,6 +508,24 @@ static const VMStateDescription vmstate_m_mve = {
     },
 };
 
+static bool event_needed(void *opaque)
+{
+    ARMCPU *cpu = opaque;
+    /* Only save the state if the event register is set (non-zero) */
+    return cpu->env.event_register != 0;
+}
+
+static const VMStateDescription vmstate_event = {
+    .name = "cpu/event",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = event_needed,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32(env.event_register, ARMCPU),
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
index 3fb24c7790..2a2224c996 100644
--- a/target/arm/tcg/m_helper.c
+++ b/target/arm/tcg/m_helper.c
@@ -962,7 +962,9 @@ static void v7m_exception_taken(ARMCPU *cpu, uint32_t lr, bool dotailchain,
      * Now we've done everything that might cause a derived exception
      * we can go ahead and activate whichever exception we're going to
      * take (which might now be the derived exception).
+     * Exception entry sets the event register (ARM ARM R_BPBR)
      */
+    env->event_register = 1;
     armv7m_nvic_acknowledge_irq(env->nvic);
 
     /* Switch to target security state -- must do this before writing SPSEL */
@@ -1906,6 +1908,9 @@ static void do_v7m_exception_exit(ARMCPU *cpu)
     /* Otherwise, we have a successful exception exit. */
     arm_clear_exclusive(env);
     arm_rebuild_hflags(env);
+
+    /* Exception return sets the event register (ARM ARM R_BPBR) */
+    env->event_register = 1;
     qemu_log_mask(CPU_LOG_INT, "...successful exception return\n");
 }
 
diff --git a/target/arm/tcg/op_helper.c b/target/arm/tcg/op_helper.c
index 4fbd219555..9f385dae6d 100644
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
+            target_cpu->env.event_register = 1;
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
+            env->event_register = 0;
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


