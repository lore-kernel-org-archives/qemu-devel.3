Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04AA5C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 08:55:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rog4e-0003aD-9L; Mon, 25 Mar 2024 04:52:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruanjinjie@huawei.com>)
 id 1rog43-00035g-GW; Mon, 25 Mar 2024 04:52:21 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruanjinjie@huawei.com>)
 id 1rog3y-0007SA-Bc; Mon, 25 Mar 2024 04:52:18 -0400
Received: from mail.maildlp.com (unknown [172.19.163.174])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4V367B0sGpzXjVq;
 Mon, 25 Mar 2024 16:49:26 +0800 (CST)
Received: from kwepemi500008.china.huawei.com (unknown [7.221.188.139])
 by mail.maildlp.com (Postfix) with ESMTPS id 1603E1404D7;
 Mon, 25 Mar 2024 16:52:10 +0800 (CST)
Received: from huawei.com (10.67.174.55) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 25 Mar
 2024 16:52:03 +0800
To: <peter.maydell@linaro.org>, <eduardo@habkost.net>,
 <marcel.apfelbaum@gmail.com>, <philmd@linaro.org>, <wangyanan55@huawei.com>,
 <richard.henderson@linaro.org>, <qemu-devel@nongnu.org>,
 <qemu-arm@nongnu.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH v10 17/23] hw/intc/arm_gicv3: Add NMI handling CPU interface
 registers
Date: Mon, 25 Mar 2024 08:48:48 +0000
Message-ID: <20240325084854.3010562-18-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240325084854.3010562-1-ruanjinjie@huawei.com>
References: <20240325084854.3010562-1-ruanjinjie@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.67.174.55]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi500008.china.huawei.com (7.221.188.139)
Received-SPF: pass client-ip=45.249.212.188;
 envelope-from=ruanjinjie@huawei.com; helo=szxga02-in.huawei.com
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
 hw/intc/arm_gicv3_cpuif.c | 115 ++++++++++++++++++++++++++++++++++----
 hw/intc/gicv3_internal.h  |   5 ++
 hw/intc/trace-events      |   1 +
 3 files changed, 110 insertions(+), 11 deletions(-)

diff --git a/hw/intc/arm_gicv3_cpuif.c b/hw/intc/arm_gicv3_cpuif.c
index e1a60d8c15..76e2286e70 100644
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
@@ -825,11 +832,15 @@ static inline int icc_num_aprs(GICv3CPUState *cs)
     return aprmax;
 }
 
-static int icc_highest_active_prio(GICv3CPUState *cs)
+static uint64_t icc_highest_active_prio(GICv3CPUState *cs)
 {
     /* Calculate the current running priority based on the set bits
      * in the Active Priority Registers.
      */
+    ARMCPU *cpu = ARM_CPU(cs->cpu);
+    CPUARMState *env = &cpu->env;
+
+    uint64_t prio;
     int i;
 
     for (i = 0; i < icc_num_aprs(cs); i++) {
@@ -839,7 +850,32 @@ static int icc_highest_active_prio(GICv3CPUState *cs)
         if (!apr) {
             continue;
         }
-        return (i * 32 + ctz32(apr)) << (icc_min_bpr(cs) + 1);
+        prio = (i * 32 + ctz32(apr)) << (icc_min_bpr(cs) + 1);
+
+        if (cs->gic->nmi_support) {
+            if (cs->gic->gicd_ctlr & GICD_CTLR_DS) {
+                if ((cs->icc_apr[GICV3_G0][i] & ICC_AP1R_EL1_NMI) ||
+                    (cs->icc_apr[GICV3_G1][i] & ICC_AP1R_EL1_NMI) ||
+                    (cs->icc_apr[GICV3_G1NS][i] & ICC_AP1R_EL1_NMI)) {
+                    prio |= ICC_RPR_EL1_NMI;
+                }
+            } else if (!arm_is_secure(env)) {
+                if (cs->icc_apr[GICV3_G1NS][i] & ICC_AP1R_EL1_NMI) {
+                    prio |= ICC_RPR_EL1_NMI;
+                }
+            } else {
+                if (cs->icc_apr[GICV3_G1][i] & ICC_AP1R_EL1_NMI) {
+                    prio |= ICC_RPR_EL1_NMI;
+                }
+            }
+
+            if (arm_feature(env, ARM_FEATURE_EL3) &&
+                cs->icc_apr[GICV3_G1NS][i] & ICC_AP1R_EL1_NMI) {
+                prio |= ICC_RPR_EL1_NSNMI;
+            }
+        }
+
+        return prio;
     }
     /* No current active interrupts: return idle priority */
     return 0xff;
@@ -896,7 +932,7 @@ static bool icc_hppi_can_preempt(GICv3CPUState *cs)
     /* Return true if we have a pending interrupt of sufficient
      * priority to preempt.
      */
-    int rprio;
+    uint64_t rprio;
     uint32_t mask;
 
     if (icc_no_enabled_hppi(cs)) {
@@ -1034,7 +1070,7 @@ static void icc_pmr_write(CPUARMState *env, const ARMCPRegInfo *ri,
     gicv3_cpuif_update(cs);
 }
 
-static void icc_activate_irq(GICv3CPUState *cs, int irq)
+static void icc_activate_irq(GICv3CPUState *cs, int irq, bool nmi)
 {
     /* Move the interrupt from the Pending state to Active, and update
      * the Active Priority Registers
@@ -1047,6 +1083,10 @@ static void icc_activate_irq(GICv3CPUState *cs, int irq)
 
     cs->icc_apr[cs->hppi.grp][regno] |= (1 << regbit);
 
+    if (cs->gic->nmi_support) {
+        cs->icc_apr[cs->hppi.grp][regno] |= (nmi ? ICC_AP1R_EL1_NMI : 0);
+    }
+
     if (irq < GIC_INTERNAL) {
         cs->gicr_iactiver0 = deposit32(cs->gicr_iactiver0, irq, 1, 1);
         cs->gicr_ipendr0 = deposit32(cs->gicr_ipendr0, irq, 1, 0);
@@ -1097,7 +1137,8 @@ static uint64_t icc_hppir0_value(GICv3CPUState *cs, CPUARMState *env)
     return cs->hppi.irq;
 }
 
-static uint64_t icc_hppir1_value(GICv3CPUState *cs, CPUARMState *env)
+static uint64_t icc_hppir1_value(GICv3CPUState *cs, CPUARMState *env, bool hppi,
+                                 bool nmi)
 {
     /* Return the highest priority pending interrupt register value
      * for group 1.
@@ -1108,6 +1149,18 @@ static uint64_t icc_hppir1_value(GICv3CPUState *cs, CPUARMState *env)
         return INTID_SPURIOUS;
     }
 
+    if (!hppi) {
+        int el = arm_current_el(env);
+
+        if (nmi && (!cs->hppi.nmi)) {
+            return INTID_SPURIOUS;
+        }
+
+        if (!nmi && cs->hppi.nmi && env->cp15.sctlr_el[el] & SCTLR_NMI) {
+            return INTID_NMI;
+        }
+    }
+
     /* Check whether we can return the interrupt or if we should return
      * a special identifier, as per the CheckGroup1ForSpecialIdentifiers
      * pseudocode. (We can simplify a little because for us ICC_SRE_EL1.RM
@@ -1149,7 +1202,7 @@ static uint64_t icc_iar0_read(CPUARMState *env, const ARMCPRegInfo *ri)
     }
 
     if (!gicv3_intid_is_special(intid)) {
-        icc_activate_irq(cs, intid);
+        icc_activate_irq(cs, intid, false);
     }
 
     trace_gicv3_icc_iar0_read(gicv3_redist_affid(cs), intid);
@@ -1168,17 +1221,36 @@ static uint64_t icc_iar1_read(CPUARMState *env, const ARMCPRegInfo *ri)
     if (!icc_hppi_can_preempt(cs)) {
         intid = INTID_SPURIOUS;
     } else {
-        intid = icc_hppir1_value(cs, env);
+        intid = icc_hppir1_value(cs, env, false, false);
     }
 
     if (!gicv3_intid_is_special(intid)) {
-        icc_activate_irq(cs, intid);
+        icc_activate_irq(cs, intid, false);
     }
 
     trace_gicv3_icc_iar1_read(gicv3_redist_affid(cs), intid);
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
+    intid = icc_hppir1_value(cs, env, false, true);
+
+    if (!gicv3_intid_is_special(intid)) {
+        icc_activate_irq(cs, intid, true);
+    }
+
+    trace_gicv3_icc_nmiar1_read(gicv3_redist_affid(cs), intid);
+    return intid;
+}
+
 static void icc_drop_prio(GICv3CPUState *cs, int grp)
 {
     /* Drop the priority of the currently active interrupt in
@@ -1207,6 +1279,10 @@ static void icc_drop_prio(GICv3CPUState *cs, int grp)
         }
         /* Clear the lowest set bit */
         *papr &= *papr - 1;
+
+        if (cs->gic->nmi_support && (*papr & ICC_AP1R_EL1_NMI)) {
+            *papr &= (~ICC_AP1R_EL1_NMI);
+        }
         break;
     }
 
@@ -1555,7 +1631,7 @@ static uint64_t icc_hppir1_read(CPUARMState *env, const ARMCPRegInfo *ri)
         return icv_hppir_read(env, ri);
     }
 
-    value = icc_hppir1_value(cs, env);
+    value = icc_hppir1_value(cs, env, true, false);
     trace_gicv3_icc_hppir1_read(gicv3_redist_affid(cs), value);
     return value;
 }
@@ -1693,7 +1769,11 @@ static void icc_ap_write(CPUARMState *env, const ARMCPRegInfo *ri,
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
 
@@ -1783,7 +1863,7 @@ static void icc_dir_write(CPUARMState *env, const ARMCPRegInfo *ri,
 static uint64_t icc_rpr_read(CPUARMState *env, const ARMCPRegInfo *ri)
 {
     GICv3CPUState *cs = icc_cs_from_env(env);
-    int prio;
+    uint64_t prio;
 
     if (icv_access(env, HCR_FMO | HCR_IMO)) {
         return icv_rpr_read(env, ri);
@@ -2482,6 +2562,15 @@ static const ARMCPRegInfo gicv3_cpuif_icc_apxr23_reginfo[] = {
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
@@ -2838,6 +2927,10 @@ void gicv3_init_cpuif(GICv3State *s)
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


