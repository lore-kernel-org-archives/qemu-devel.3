Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C456CD1294
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Apr 2024 10:23:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrxhO-000165-NS; Wed, 03 Apr 2024 06:18:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruanjinjie@huawei.com>)
 id 1rrxgw-0000sC-SO; Wed, 03 Apr 2024 06:18:02 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruanjinjie@huawei.com>)
 id 1rrxgr-0006fZ-UW; Wed, 03 Apr 2024 06:18:02 -0400
Received: from mail.maildlp.com (unknown [172.19.163.174])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4V8gbt6bdkzwR8K;
 Wed,  3 Apr 2024 18:15:06 +0800 (CST)
Received: from kwepemi500008.china.huawei.com (unknown [7.221.188.139])
 by mail.maildlp.com (Postfix) with ESMTPS id BF9EE140FAF;
 Wed,  3 Apr 2024 18:17:54 +0800 (CST)
Received: from huawei.com (10.67.174.55) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 3 Apr
 2024 18:17:54 +0800
To: <peter.maydell@linaro.org>, <eduardo@habkost.net>,
 <marcel.apfelbaum@gmail.com>, <philmd@linaro.org>, <wangyanan55@huawei.com>,
 <richard.henderson@linaro.org>, <qemu-devel@nongnu.org>,
 <qemu-arm@nongnu.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH v12 18/23] hw/intc/arm_gicv3: Handle icv_nmiar1_read() for
 icc_nmiar1_read()
Date: Wed, 3 Apr 2024 10:16:06 +0000
Message-ID: <20240403101611.3204086-19-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240403101611.3204086-1-ruanjinjie@huawei.com>
References: <20240403101611.3204086-1-ruanjinjie@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.67.174.55]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500008.china.huawei.com (7.221.188.139)
Received-SPF: pass client-ip=45.249.212.187;
 envelope-from=ruanjinjie@huawei.com; helo=szxga01-in.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-to:  Jinjie Ruan <ruanjinjie@huawei.com>
From:  Jinjie Ruan via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Implement icv_nmiar1_read() for icc_nmiar1_read(), so add definition for
ICH_LR_EL2.NMI and ICH_AP1R_EL2.NMI bit.

If FEAT_GICv3_NMI is supported, ich_ap_write() should consider ICV_AP1R_EL1.NMI
bit. In icv_activate_irq() and icv_eoir_write(), the ICV_AP1R_EL1.NMI bit
should be set or clear according to the Non-maskable property. And the RPR
priority should also update the NMI bit according to the APR priority NMI bit.

By the way, add gicv3_icv_nmiar1_read trace event.

If the hpp irq is a NMI, the icv iar read should return 1022 and trap for
NMI again

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
v12:
- When NMI is 1, the virtual interrupt's priority is 0x0.
- Make the thisnmi logic more concisely in hppvi_index().
- Use is_nmi to simplify the code and check is_nmi before comparing vpmr.
- Remove redundant nmi_support check in ich_highest_active_virt_prio(),
  hppvi_index(), icv_hppi_can_preempt(), icv_rpr_read() and icv_activate_irq().
- Also check sctlrx.NMI in icv_iar_read().
- Check icv_hppi_can_preempt() for icv_nmiar1_read().
- Check ICH_LR_EL2.NMI after check icv_hppi_can_preempt() as icv_iar_read()
  do it in icv_nmiar1_read().
- Fix the comment style in icv_nmiar1_read().
- Correct thisnmi to bool in icv_eoir_write().
- Check thisnmi and nmi both true instead of identical in icv_eoir_write().
v11:
- Deal with NMI in the callers instead of ich_highest_active_virt_prio().
- Set either NMI or a group-priority bit, not both.
- Only set AP NMI bits in the 0 reg.
- Handle NMI in hppvi_index(), icv_hppi_can_preempt() and icv_eoir_write().
v10:
- Rename ICH_AP1R_EL2_NMI to ICV_AP1R_EL1_NMI.
- Add ICV_RPR_EL1_NMI definition.
- Set ICV_RPR_EL1.NMI according to the ICV_AP1R<n>_EL1.NMI in
  ich_highest_active_virt_prio().
v9:
- Correct the INTID_NMI logic.
v8:
- Fix an unexpected interrupt bug when sending VNMI by running qemu VM.
v7:
- Add Reviewed-by.
v6:
- Implement icv_nmiar1_read().
---
 hw/intc/arm_gicv3_cpuif.c | 100 +++++++++++++++++++++++++++++++++-----
 hw/intc/gicv3_internal.h  |   4 ++
 hw/intc/trace-events      |   1 +
 3 files changed, 93 insertions(+), 12 deletions(-)

diff --git a/hw/intc/arm_gicv3_cpuif.c b/hw/intc/arm_gicv3_cpuif.c
index a5a1ef93ca..526740aa7e 100644
--- a/hw/intc/arm_gicv3_cpuif.c
+++ b/hw/intc/arm_gicv3_cpuif.c
@@ -157,6 +157,10 @@ static int ich_highest_active_virt_prio(GICv3CPUState *cs)
     int i;
     int aprmax = ich_num_aprs(cs);
 
+    if (cs->ich_apr[GICV3_G1NS][0] & ICV_AP1R_EL1_NMI) {
+        return 0x0;
+    }
+
     for (i = 0; i < aprmax; i++) {
         uint32_t apr = cs->ich_apr[GICV3_G0][i] |
             cs->ich_apr[GICV3_G1NS][i];
@@ -191,6 +195,7 @@ static int hppvi_index(GICv3CPUState *cs)
      * correct behaviour.
      */
     int prio = 0xff;
+    bool nmi = false;
 
     if (!(cs->ich_vmcr_el2 & (ICH_VMCR_EL2_VENG0 | ICH_VMCR_EL2_VENG1))) {
         /* Both groups disabled, definitely nothing to do */
@@ -199,6 +204,7 @@ static int hppvi_index(GICv3CPUState *cs)
 
     for (i = 0; i < cs->num_list_regs; i++) {
         uint64_t lr = cs->ich_lr_el2[i];
+        bool thisnmi;
         int thisprio;
 
         if (ich_lr_state(lr) != ICH_LR_EL2_STATE_PENDING) {
@@ -217,10 +223,12 @@ static int hppvi_index(GICv3CPUState *cs)
             }
         }
 
+        thisnmi = lr & ICH_LR_EL2_NMI;
         thisprio = ich_lr_prio(lr);
 
-        if (thisprio < prio) {
+        if ((thisprio < prio) || ((thisprio == prio) && (thisnmi & (!nmi)))) {
             prio = thisprio;
+            nmi = thisnmi;
             idx = i;
         }
     }
@@ -289,6 +297,7 @@ static bool icv_hppi_can_preempt(GICv3CPUState *cs, uint64_t lr)
      * equivalent of these checks.
      */
     int grp;
+    bool is_nmi;
     uint32_t mask, prio, rprio, vpmr;
 
     if (!(cs->ich_hcr_el2 & ICH_HCR_EL2_EN)) {
@@ -301,10 +310,11 @@ static bool icv_hppi_can_preempt(GICv3CPUState *cs, uint64_t lr)
      */
 
     prio = ich_lr_prio(lr);
+    is_nmi = lr & ICH_LR_EL2_NMI;
     vpmr = extract64(cs->ich_vmcr_el2, ICH_VMCR_EL2_VPMR_SHIFT,
                      ICH_VMCR_EL2_VPMR_LENGTH);
 
-    if (prio >= vpmr) {
+    if (!is_nmi && prio >= vpmr) {
         /* Priority mask masks this interrupt */
         return false;
     }
@@ -326,6 +336,11 @@ static bool icv_hppi_can_preempt(GICv3CPUState *cs, uint64_t lr)
         return true;
     }
 
+    if ((prio & mask) == (rprio & mask) && is_nmi &&
+        !(cs->ich_apr[GICV3_G1NS][0] & ICV_AP1R_EL1_NMI)) {
+        return true;
+    }
+
     return false;
 }
 
@@ -550,7 +565,11 @@ static void icv_ap_write(CPUARMState *env, const ARMCPRegInfo *ri,
 
     trace_gicv3_icv_ap_write(ri->crm & 1, regno, gicv3_redist_affid(cs), value);
 
-    cs->ich_apr[grp][regno] = value & 0xFFFFFFFFU;
+    if (cs->gic->nmi_support) {
+        cs->ich_apr[grp][regno] = value & (0xFFFFFFFFU | ICV_AP1R_EL1_NMI);
+    } else {
+        cs->ich_apr[grp][regno] = value & 0xFFFFFFFFU;
+    }
 
     gicv3_cpuif_virt_irq_fiq_update(cs);
     return;
@@ -697,7 +716,11 @@ static void icv_ctlr_write(CPUARMState *env, const ARMCPRegInfo *ri,
 static uint64_t icv_rpr_read(CPUARMState *env, const ARMCPRegInfo *ri)
 {
     GICv3CPUState *cs = icc_cs_from_env(env);
-    int prio = ich_highest_active_virt_prio(cs);
+    uint64_t prio = ich_highest_active_virt_prio(cs);
+
+    if (cs->ich_apr[GICV3_G1NS][0] & ICV_AP1R_EL1_NMI) {
+        prio |= ICV_RPR_EL1_NMI;
+    }
 
     trace_gicv3_icv_rpr_read(gicv3_redist_affid(cs), prio);
     return prio;
@@ -736,13 +759,19 @@ static void icv_activate_irq(GICv3CPUState *cs, int idx, int grp)
      */
     uint32_t mask = icv_gprio_mask(cs, grp);
     int prio = ich_lr_prio(cs->ich_lr_el2[idx]) & mask;
+    bool nmi = cs->ich_lr_el2[idx] & ICH_LR_EL2_NMI;
     int aprbit = prio >> (8 - cs->vprebits);
     int regno = aprbit / 32;
     int regbit = aprbit % 32;
 
     cs->ich_lr_el2[idx] &= ~ICH_LR_EL2_STATE_PENDING_BIT;
     cs->ich_lr_el2[idx] |= ICH_LR_EL2_STATE_ACTIVE_BIT;
-    cs->ich_apr[grp][regno] |= (1 << regbit);
+
+    if (nmi) {
+        cs->ich_apr[grp][regno] |= ICV_AP1R_EL1_NMI;
+    } else {
+        cs->ich_apr[grp][regno] |= (1 << regbit);
+    }
 }
 
 static void icv_activate_vlpi(GICv3CPUState *cs)
@@ -763,6 +792,7 @@ static uint64_t icv_iar_read(CPUARMState *env, const ARMCPRegInfo *ri)
     int grp = ri->crm == 8 ? GICV3_G0 : GICV3_G1NS;
     int idx = hppvi_index(cs);
     uint64_t intid = INTID_SPURIOUS;
+    int el = arm_current_el(env);
 
     if (idx == HPPVI_INDEX_VLPI) {
         if (cs->hppvlpi.grp == grp && icv_hppvlpi_can_preempt(cs)) {
@@ -772,11 +802,16 @@ static uint64_t icv_iar_read(CPUARMState *env, const ARMCPRegInfo *ri)
     } else if (idx >= 0) {
         uint64_t lr = cs->ich_lr_el2[idx];
         int thisgrp = (lr & ICH_LR_EL2_GROUP) ? GICV3_G1NS : GICV3_G0;
+        bool nmi = env->cp15.sctlr_el[el] & SCTLR_NMI && lr & ICH_LR_EL2_NMI;
 
         if (thisgrp == grp && icv_hppi_can_preempt(cs, lr)) {
             intid = ich_lr_vintid(lr);
             if (!gicv3_intid_is_special(intid)) {
-                icv_activate_irq(cs, idx, grp);
+                if (!nmi) {
+                    icv_activate_irq(cs, idx, grp);
+                } else {
+                    intid = INTID_NMI;
+                }
             } else {
                 /* Interrupt goes from Pending to Invalid */
                 cs->ich_lr_el2[idx] &= ~ICH_LR_EL2_STATE_PENDING_BIT;
@@ -797,8 +832,37 @@ static uint64_t icv_iar_read(CPUARMState *env, const ARMCPRegInfo *ri)
 
 static uint64_t icv_nmiar1_read(CPUARMState *env, const ARMCPRegInfo *ri)
 {
-    /* todo */
+    GICv3CPUState *cs = icc_cs_from_env(env);
+    int idx = hppvi_index(cs);
     uint64_t intid = INTID_SPURIOUS;
+
+    if (idx >= 0 && idx != HPPVI_INDEX_VLPI) {
+        uint64_t lr = cs->ich_lr_el2[idx];
+        int thisgrp = (lr & ICH_LR_EL2_GROUP) ? GICV3_G1NS : GICV3_G0;
+
+        if ((thisgrp == GICV3_G1NS) && icv_hppi_can_preempt(cs, lr)) {
+            intid = ich_lr_vintid(lr);
+            if (!gicv3_intid_is_special(intid)) {
+                if (lr & ICH_LR_EL2_NMI) {
+                    icv_activate_irq(cs, idx, GICV3_G1NS);
+                } else {
+                    intid = INTID_SPURIOUS;
+                }
+            } else {
+                /* Interrupt goes from Pending to Invalid */
+                cs->ich_lr_el2[idx] &= ~ICH_LR_EL2_STATE_PENDING_BIT;
+                /*
+                 * We will now return the (bogus) ID from the list register,
+                 * as per the pseudocode.
+                 */
+            }
+        }
+    }
+
+    trace_gicv3_icv_nmiar1_read(gicv3_redist_affid(cs), intid);
+
+    gicv3_cpuif_virt_update(cs);
+
     return intid;
 }
 
@@ -1423,7 +1487,7 @@ static void icv_increment_eoicount(GICv3CPUState *cs)
                                 ICH_HCR_EL2_EOICOUNT_LENGTH, eoicount + 1);
 }
 
-static int icv_drop_prio(GICv3CPUState *cs)
+static int icv_drop_prio(GICv3CPUState *cs, bool *nmi)
 {
     /* Drop the priority of the currently active virtual interrupt
      * (favouring group 0 if there is a set active bit at
@@ -1445,6 +1509,12 @@ static int icv_drop_prio(GICv3CPUState *cs)
             continue;
         }
 
+        if (i == 0 && cs->gic->nmi_support && (*papr1 & ICV_AP1R_EL1_NMI)) {
+            *papr1 &= (~ICV_AP1R_EL1_NMI);
+            *nmi = true;
+            return 0xff;
+        }
+
         /* We can't just use the bit-twiddling hack icc_drop_prio() does
          * because we need to return the bit number we cleared so
          * it can be compared against the list register's priority field.
@@ -1504,6 +1574,7 @@ static void icv_eoir_write(CPUARMState *env, const ARMCPRegInfo *ri,
     int irq = value & 0xffffff;
     int grp = ri->crm == 8 ? GICV3_G0 : GICV3_G1NS;
     int idx, dropprio;
+    bool nmi = false;
 
     trace_gicv3_icv_eoir_write(ri->crm == 8 ? 0 : 1,
                                gicv3_redist_affid(cs), value);
@@ -1516,8 +1587,8 @@ static void icv_eoir_write(CPUARMState *env, const ARMCPRegInfo *ri,
      * error checks" (because that lets us avoid scanning the AP
      * registers twice).
      */
-    dropprio = icv_drop_prio(cs);
-    if (dropprio == 0xff) {
+    dropprio = icv_drop_prio(cs, &nmi);
+    if (dropprio == 0xff && !nmi) {
         /* No active interrupt. It is CONSTRAINED UNPREDICTABLE
          * whether the list registers are checked in this
          * situation; we choose not to.
@@ -1539,8 +1610,9 @@ static void icv_eoir_write(CPUARMState *env, const ARMCPRegInfo *ri,
         uint64_t lr = cs->ich_lr_el2[idx];
         int thisgrp = (lr & ICH_LR_EL2_GROUP) ? GICV3_G1NS : GICV3_G0;
         int lr_gprio = ich_lr_prio(lr) & icv_gprio_mask(cs, grp);
+        bool thisnmi = lr & ICH_LR_EL2_NMI;
 
-        if (thisgrp == grp && lr_gprio == dropprio) {
+        if (thisgrp == grp && (lr_gprio == dropprio || (thisnmi & nmi))) {
             if (!icv_eoi_split(env, cs) || irq >= GICV3_LPI_INTID_START) {
                 /*
                  * Priority drop and deactivate not split: deactivate irq now.
@@ -2626,7 +2698,11 @@ static void ich_ap_write(CPUARMState *env, const ARMCPRegInfo *ri,
 
     trace_gicv3_ich_ap_write(ri->crm & 1, regno, gicv3_redist_affid(cs), value);
 
-    cs->ich_apr[grp][regno] = value & 0xFFFFFFFFU;
+    if (cs->gic->nmi_support) {
+        cs->ich_apr[grp][regno] = value & (0xFFFFFFFFU | ICV_AP1R_EL1_NMI);
+    } else {
+        cs->ich_apr[grp][regno] = value & 0xFFFFFFFFU;
+    }
     gicv3_cpuif_virt_irq_fiq_update(cs);
 }
 
diff --git a/hw/intc/gicv3_internal.h b/hw/intc/gicv3_internal.h
index 81200eb90e..bc9f518fe8 100644
--- a/hw/intc/gicv3_internal.h
+++ b/hw/intc/gicv3_internal.h
@@ -246,6 +246,7 @@ FIELD(GICR_VPENDBASER, VALID, 63, 1)
 #define ICH_LR_EL2_PRIORITY_SHIFT 48
 #define ICH_LR_EL2_PRIORITY_LENGTH 8
 #define ICH_LR_EL2_PRIORITY_MASK (0xffULL << ICH_LR_EL2_PRIORITY_SHIFT)
+#define ICH_LR_EL2_NMI (1ULL << 59)
 #define ICH_LR_EL2_GROUP (1ULL << 60)
 #define ICH_LR_EL2_HW (1ULL << 61)
 #define ICH_LR_EL2_STATE_SHIFT 62
@@ -277,6 +278,9 @@ FIELD(GICR_VPENDBASER, VALID, 63, 1)
 #define ICH_VTR_EL2_PREBITS_SHIFT 26
 #define ICH_VTR_EL2_PRIBITS_SHIFT 29
 
+#define ICV_AP1R_EL1_NMI (1ULL << 63)
+#define ICV_RPR_EL1_NMI (1ULL << 63)
+
 /* ITS Registers */
 
 FIELD(GITS_BASER, SIZE, 0, 8)
diff --git a/hw/intc/trace-events b/hw/intc/trace-events
index 94030550d5..47340b5bc1 100644
--- a/hw/intc/trace-events
+++ b/hw/intc/trace-events
@@ -152,6 +152,7 @@ gicv3_icv_rpr_read(uint32_t cpu, uint64_t val) "GICv3 ICV_RPR read cpu 0x%x valu
 gicv3_icv_hppir_read(int grp, uint32_t cpu, uint64_t val) "GICv3 ICV_HPPIR%d read cpu 0x%x value 0x%" PRIx64
 gicv3_icv_dir_write(uint32_t cpu, uint64_t val) "GICv3 ICV_DIR write cpu 0x%x value 0x%" PRIx64
 gicv3_icv_iar_read(int grp, uint32_t cpu, uint64_t val) "GICv3 ICV_IAR%d read cpu 0x%x value 0x%" PRIx64
+gicv3_icv_nmiar1_read(uint32_t cpu, uint64_t val) "GICv3 ICV_NMIAR1 read cpu 0x%x value 0x%" PRIx64
 gicv3_icv_eoir_write(int grp, uint32_t cpu, uint64_t val) "GICv3 ICV_EOIR%d write cpu 0x%x value 0x%" PRIx64
 gicv3_cpuif_virt_update(uint32_t cpuid, int idx, int hppvlpi, int grp, int prio) "GICv3 CPU i/f 0x%x virt HPPI update LR index %d HPPVLPI %d grp %d prio %d"
 gicv3_cpuif_virt_set_irqs(uint32_t cpuid, int fiqlevel, int irqlevel) "GICv3 CPU i/f 0x%x virt HPPI update: setting FIQ %d IRQ %d"
-- 
2.34.1


