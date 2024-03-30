Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE54CCD128E
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Mar 2024 10:36:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rqW1n-0000ae-0C; Sat, 30 Mar 2024 06:33:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruanjinjie@huawei.com>)
 id 1rqW1W-0000Pu-6S; Sat, 30 Mar 2024 06:33:18 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruanjinjie@huawei.com>)
 id 1rqW1R-0000tT-E5; Sat, 30 Mar 2024 06:33:17 -0400
Received: from mail.maildlp.com (unknown [172.19.163.44])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4V6D9v623mz1GDSS;
 Sat, 30 Mar 2024 18:32:35 +0800 (CST)
Received: from kwepemi500008.china.huawei.com (unknown [7.221.188.139])
 by mail.maildlp.com (Postfix) with ESMTPS id AEFC41400D3;
 Sat, 30 Mar 2024 18:33:09 +0800 (CST)
Received: from huawei.com (10.67.174.55) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Sat, 30 Mar
 2024 18:33:03 +0800
To: <peter.maydell@linaro.org>, <eduardo@habkost.net>,
 <marcel.apfelbaum@gmail.com>, <philmd@linaro.org>, <wangyanan55@huawei.com>,
 <richard.henderson@linaro.org>, <qemu-devel@nongnu.org>,
 <qemu-arm@nongnu.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH v11 17/23] hw/intc/arm_gicv3: Add NMI handling CPU interface
 registers
Date: Sat, 30 Mar 2024 10:31:22 +0000
Message-ID: <20240330103128.3185962-18-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240330103128.3185962-1-ruanjinjie@huawei.com>
References: <20240330103128.3185962-1-ruanjinjie@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.67.174.55]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi500008.china.huawei.com (7.221.188.139)
Received-SPF: pass client-ip=45.249.212.191;
 envelope-from=ruanjinjie@huawei.com; helo=szxga05-in.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add the NMIAR CPU interface registers which deal with acknowledging NMI.

When introduce NMI interrupt, there are some updates to the semantics for the
register ICC_IAR1_EL1 and ICC_HPPIR1_EL1. For ICC_IAR1_EL1 register, it
should return 1022 if the intid has non-maskable property. And for
ICC_NMIAR1_EL1 register, it should return 1023 if the intid do not have
non-maskable property. Howerever, these are not necessary for ICC_HPPIR1_EL1
register.

And the APR and RPR has NMI bits which should be handled correctly.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
v11:
- Handle NMI priority in icc_highest_active_prio() and handle NMI RPR in
  icc_rpr_read() separately.
- Only set NMI bit for a NMI and and ordinary priority bit for a non-NMI in
  icc_activate_irq().
- Only clear APR bit for AP1R0 in icc_drop_prio().
- Check special INTID_* in callers instead of passing two extra boolean args
  for ack functions.
- Handle NMI in icc_hppi_can_preempt() and icc_highest_active_group().
- Also check icc_hppi_can_preempt() for icc_nmiar1_read().
v10:
- is_nmi -> nmi.
- is_hppi -> hppi.
- Exchange the order of nmi and hppi parameters.
- superprio -> nmi.
- Handle APR and RPR NMI bits.
- Update the commit message, super priority -> non-maskable property.
v7:
- Add Reviewed-by.
v4:
- Define ICC_NMIAR1_EL1 only if FEAT_GICv3_NMI is implemented.
- Check sctrl_elx.SCTLR_NMI to return 1022 for icc_iar1_read().
- Add gicv3_icc_nmiar1_read() trace event.
- Do not check icc_hppi_can_preempt() for icc_nmiar1_read().
- Add icv_nmiar1_read() and call it when EL2Enabled() and HCR_EL2.IMO == '1'
---
 hw/intc/arm_gicv3_cpuif.c | 137 ++++++++++++++++++++++++++++++++++++--
 hw/intc/gicv3_internal.h  |   5 ++
 hw/intc/trace-events      |   1 +
 3 files changed, 138 insertions(+), 5 deletions(-)

diff --git a/hw/intc/arm_gicv3_cpuif.c b/hw/intc/arm_gicv3_cpuif.c
index e1a60d8c15..f99f2570a6 100644
--- a/hw/intc/arm_gicv3_cpuif.c
+++ b/hw/intc/arm_gicv3_cpuif.c
@@ -795,6 +795,13 @@ static uint64_t icv_iar_read(CPUARMState *env, const ARMCPRegInfo *ri)
     return intid;
 }
 
+static uint64_t icv_nmiar1_read(CPUARMState *env, const ARMCPRegInfo *ri)
+{
+    /* todo */
+    uint64_t intid = INTID_SPURIOUS;
+    return intid;
+}
+
 static uint32_t icc_fullprio_mask(GICv3CPUState *cs)
 {
     /*
@@ -832,6 +839,23 @@ static int icc_highest_active_prio(GICv3CPUState *cs)
      */
     int i;
 
+    if (cs->gic->nmi_support) {
+        /*
+         * If an NMI is active this takes precedence over anything else
+         * for priority purposes; the NMI bit is only in the AP1R0 bit.
+         * We return here the effective priority of the NMI, which is
+         * either 0x0 or 0x80. Callers will need to check NMI again for
+         * purposes of either setting the RPR register bits or for
+         * prioritization of NMI vs non-NMI.
+         */
+        if (cs->icc_apr[GICV3_G1][0] & ICC_AP1R_EL1_NMI) {
+            return 0;
+        }
+        if (cs->icc_apr[GICV3_G1NS][0] & ICC_AP1R_EL1_NMI) {
+            return (cs->gic->gicd_ctlr & GICD_CTLR_DS) ? 0 : 0x80;
+        }
+    }
+
     for (i = 0; i < icc_num_aprs(cs); i++) {
         uint32_t apr = cs->icc_apr[GICV3_G0][i] |
             cs->icc_apr[GICV3_G1][i] | cs->icc_apr[GICV3_G1NS][i];
@@ -898,12 +922,24 @@ static bool icc_hppi_can_preempt(GICv3CPUState *cs)
      */
     int rprio;
     uint32_t mask;
+    ARMCPU *cpu = ARM_CPU(cs->cpu);
+    CPUARMState *env = &cpu->env;
 
     if (icc_no_enabled_hppi(cs)) {
         return false;
     }
 
-    if (cs->hppi.prio >= cs->icc_pmr_el1) {
+    if (cs->gic->nmi_support && cs->hppi.nmi) {
+        if (!(cs->gic->gicd_ctlr & GICD_CTLR_DS) &&
+            cs->hppi.grp == GICV3_G1NS) {
+            if (cs->icc_pmr_el1 < 0x80) {
+                return false;
+            }
+            if (arm_is_secure(env) && cs->icc_pmr_el1 == 0x80) {
+                return false;
+            }
+        }
+    } else if (cs->hppi.prio >= cs->icc_pmr_el1) {
         /* Priority mask masks this interrupt */
         return false;
     }
@@ -923,6 +959,18 @@ static bool icc_hppi_can_preempt(GICv3CPUState *cs)
         return true;
     }
 
+    if (cs->gic->nmi_support && cs->hppi.nmi &&
+        (cs->hppi.prio & mask) == (rprio & mask)) {
+        if ((cs->hppi.grp == GICV3_G1NS) &&
+            !(cs->icc_apr[GICV3_G1NS][0] & ICC_AP1R_EL1_NMI)) {
+            return true;
+        }
+        if ((cs->hppi.grp == GICV3_G1) &&
+            !(cs->icc_apr[GICV3_G1][0] & ICC_AP1R_EL1_NMI)) {
+            return true;
+        }
+    }
+
     return false;
 }
 
@@ -1044,8 +1092,13 @@ static void icc_activate_irq(GICv3CPUState *cs, int irq)
     int aprbit = prio >> (8 - cs->prebits);
     int regno = aprbit / 32;
     int regbit = aprbit % 32;
+    bool nmi = cs->hppi.nmi;
 
-    cs->icc_apr[cs->hppi.grp][regno] |= (1 << regbit);
+    if (cs->gic->nmi_support && nmi) {
+        cs->icc_apr[cs->hppi.grp][regno] |= ICC_AP1R_EL1_NMI;
+    } else {
+        cs->icc_apr[cs->hppi.grp][regno] |= (1 << regbit);
+    }
 
     if (irq < GIC_INTERNAL) {
         cs->gicr_iactiver0 = deposit32(cs->gicr_iactiver0, irq, 1, 1);
@@ -1159,13 +1212,16 @@ static uint64_t icc_iar0_read(CPUARMState *env, const ARMCPRegInfo *ri)
 static uint64_t icc_iar1_read(CPUARMState *env, const ARMCPRegInfo *ri)
 {
     GICv3CPUState *cs = icc_cs_from_env(env);
+    int el = arm_current_el(env);
     uint64_t intid;
 
     if (icv_access(env, HCR_IMO)) {
         return icv_iar_read(env, ri);
     }
 
-    if (!icc_hppi_can_preempt(cs)) {
+    if (cs->hppi.nmi && env->cp15.sctlr_el[el] & SCTLR_NMI) {
+        intid = INTID_NMI;
+    } else if (!icc_hppi_can_preempt(cs)) {
         intid = INTID_SPURIOUS;
     } else {
         intid = icc_hppir1_value(cs, env);
@@ -1179,6 +1235,29 @@ static uint64_t icc_iar1_read(CPUARMState *env, const ARMCPRegInfo *ri)
     return intid;
 }
 
+static uint64_t icc_nmiar1_read(CPUARMState *env, const ARMCPRegInfo *ri)
+{
+    GICv3CPUState *cs = icc_cs_from_env(env);
+    uint64_t intid;
+
+    if (icv_access(env, HCR_IMO)) {
+        return icv_nmiar1_read(env, ri);
+    }
+
+    if (!cs->hppi.nmi || !icc_hppi_can_preempt(cs)) {
+        intid = INTID_SPURIOUS;
+    } else {
+        intid = icc_hppir1_value(cs, env);
+    }
+
+    if (!gicv3_intid_is_special(intid)) {
+        icc_activate_irq(cs, intid);
+    }
+
+    trace_gicv3_icc_nmiar1_read(gicv3_redist_affid(cs), intid);
+    return intid;
+}
+
 static void icc_drop_prio(GICv3CPUState *cs, int grp)
 {
     /* Drop the priority of the currently active interrupt in
@@ -1205,6 +1284,12 @@ static void icc_drop_prio(GICv3CPUState *cs, int grp)
         if (!*papr) {
             continue;
         }
+
+        if (i == 0 && cs->gic->nmi_support && (*papr & ICC_AP1R_EL1_NMI)) {
+            *papr &= (~ICC_AP1R_EL1_NMI);
+            break;
+        }
+
         /* Clear the lowest set bit */
         *papr &= *papr - 1;
         break;
@@ -1239,6 +1324,15 @@ static int icc_highest_active_group(GICv3CPUState *cs)
      */
     int i;
 
+    if (cs->gic->nmi_support) {
+        if (cs->icc_apr[GICV3_G1][0] & ICC_AP1R_EL1_NMI) {
+            return GICV3_G1;
+        }
+        if (cs->icc_apr[GICV3_G1NS][0] & ICC_AP1R_EL1_NMI) {
+            return GICV3_G1NS;
+        }
+    }
+
     for (i = 0; i < ARRAY_SIZE(cs->icc_apr[0]); i++) {
         int g0ctz = ctz32(cs->icc_apr[GICV3_G0][i]);
         int g1ctz = ctz32(cs->icc_apr[GICV3_G1][i]);
@@ -1693,7 +1787,11 @@ static void icc_ap_write(CPUARMState *env, const ARMCPRegInfo *ri,
         return;
     }
 
-    cs->icc_apr[grp][regno] = value & 0xFFFFFFFFU;
+    if (cs->gic->nmi_support) {
+        cs->icc_apr[grp][regno] = value & (0xFFFFFFFFU | ICC_AP1R_EL1_NMI);
+    } else {
+        cs->icc_apr[grp][regno] = value & 0xFFFFFFFFU;
+    }
     gicv3_cpuif_update(cs);
 }
 
@@ -1783,7 +1881,7 @@ static void icc_dir_write(CPUARMState *env, const ARMCPRegInfo *ri,
 static uint64_t icc_rpr_read(CPUARMState *env, const ARMCPRegInfo *ri)
 {
     GICv3CPUState *cs = icc_cs_from_env(env);
-    int prio;
+    uint64_t prio;
 
     if (icv_access(env, HCR_FMO | HCR_IMO)) {
         return icv_rpr_read(env, ri);
@@ -1803,6 +1901,22 @@ static uint64_t icc_rpr_read(CPUARMState *env, const ARMCPRegInfo *ri)
         }
     }
 
+    if (cs->gic->nmi_support) {
+        /* NMI info is reported in the high bits of RPR */
+        if (arm_feature(env, ARM_FEATURE_EL3) && !arm_is_secure(env)) {
+            if (cs->icc_apr[GICV3_G1NS][0] & ICC_AP1R_EL1_NMI) {
+                prio |= ICC_RPR_EL1_NSNMI;
+            }
+        } else {
+            if (cs->icc_apr[GICV3_G1NS][0] & ICC_AP1R_EL1_NMI) {
+                prio |= ICC_RPR_EL1_NSNMI;
+            }
+            if (cs->icc_apr[GICV3_G1][0] & ICC_AP1R_EL1_NMI) {
+                prio |= ICC_RPR_EL1_NMI;
+            }
+        }
+    }
+
     trace_gicv3_icc_rpr_read(gicv3_redist_affid(cs), prio);
     return prio;
 }
@@ -2482,6 +2596,15 @@ static const ARMCPRegInfo gicv3_cpuif_icc_apxr23_reginfo[] = {
     },
 };
 
+static const ARMCPRegInfo gicv3_cpuif_gicv3_nmi_reginfo[] = {
+    { .name = "ICC_NMIAR1_EL1", .state = ARM_CP_STATE_BOTH,
+      .opc0 = 3, .opc1 = 0, .crn = 12, .crm = 9, .opc2 = 5,
+      .type = ARM_CP_IO | ARM_CP_NO_RAW,
+      .access = PL1_R, .accessfn = gicv3_irq_access,
+      .readfn = icc_nmiar1_read,
+    },
+};
+
 static uint64_t ich_ap_read(CPUARMState *env, const ARMCPRegInfo *ri)
 {
     GICv3CPUState *cs = icc_cs_from_env(env);
@@ -2838,6 +2961,10 @@ void gicv3_init_cpuif(GICv3State *s)
          */
         define_arm_cp_regs(cpu, gicv3_cpuif_reginfo);
 
+        if (s->nmi_support) {
+            define_arm_cp_regs(cpu, gicv3_cpuif_gicv3_nmi_reginfo);
+        }
+
         /*
          * The CPU implementation specifies the number of supported
          * bits of physical priority. For backwards compatibility
diff --git a/hw/intc/gicv3_internal.h b/hw/intc/gicv3_internal.h
index 8d793243f4..81200eb90e 100644
--- a/hw/intc/gicv3_internal.h
+++ b/hw/intc/gicv3_internal.h
@@ -194,6 +194,10 @@ FIELD(GICR_VPENDBASER, VALID, 63, 1)
 #define ICC_CTLR_EL3_A3V (1U << 15)
 #define ICC_CTLR_EL3_NDS (1U << 17)
 
+#define ICC_AP1R_EL1_NMI (1ULL << 63)
+#define ICC_RPR_EL1_NSNMI (1ULL << 62)
+#define ICC_RPR_EL1_NMI (1ULL << 63)
+
 #define ICH_VMCR_EL2_VENG0_SHIFT 0
 #define ICH_VMCR_EL2_VENG0 (1U << ICH_VMCR_EL2_VENG0_SHIFT)
 #define ICH_VMCR_EL2_VENG1_SHIFT 1
@@ -511,6 +515,7 @@ FIELD(VTE, RDBASE, 42, RDBASE_PROCNUM_LENGTH)
 /* Special interrupt IDs */
 #define INTID_SECURE 1020
 #define INTID_NONSECURE 1021
+#define INTID_NMI 1022
 #define INTID_SPURIOUS 1023
 
 /* Functions internal to the emulated GICv3 */
diff --git a/hw/intc/trace-events b/hw/intc/trace-events
index 1ef29d0256..94030550d5 100644
--- a/hw/intc/trace-events
+++ b/hw/intc/trace-events
@@ -116,6 +116,7 @@ gicv3_cpuif_set_irqs(uint32_t cpuid, int fiqlevel, int irqlevel) "GICv3 CPU i/f
 gicv3_icc_generate_sgi(uint32_t cpuid, int irq, int irm, uint32_t aff, uint32_t targetlist) "GICv3 CPU i/f 0x%x generating SGI %d IRM %d target affinity 0x%xxx targetlist 0x%x"
 gicv3_icc_iar0_read(uint32_t cpu, uint64_t val) "GICv3 ICC_IAR0 read cpu 0x%x value 0x%" PRIx64
 gicv3_icc_iar1_read(uint32_t cpu, uint64_t val) "GICv3 ICC_IAR1 read cpu 0x%x value 0x%" PRIx64
+gicv3_icc_nmiar1_read(uint32_t cpu, uint64_t val) "GICv3 ICC_NMIAR1 read cpu 0x%x value 0x%" PRIx64
 gicv3_icc_eoir_write(int grp, uint32_t cpu, uint64_t val) "GICv3 ICC_EOIR%d write cpu 0x%x value 0x%" PRIx64
 gicv3_icc_hppir0_read(uint32_t cpu, uint64_t val) "GICv3 ICC_HPPIR0 read cpu 0x%x value 0x%" PRIx64
 gicv3_icc_hppir1_read(uint32_t cpu, uint64_t val) "GICv3 ICC_HPPIR1 read cpu 0x%x value 0x%" PRIx64
-- 
2.34.1


