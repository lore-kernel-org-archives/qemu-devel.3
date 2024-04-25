Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39B1AC4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 10:44:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzwWf-0002Os-B0; Thu, 25 Apr 2024 06:40:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rzwWV-00021y-9g
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 06:40:15 -0400
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rzwWR-0007CS-BU
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 06:40:14 -0400
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2db101c11beso8673651fa.0
 for <qemu-devel@nongnu.org>; Thu, 25 Apr 2024 03:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714041610; x=1714646410; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5htmrfELNsneNGmKSlA9Gw3MrpMWp51ddAIN8u/Ht+I=;
 b=fHjfoLlJ6VmFd+f7YYcXbpXo4yzltqDDOrpGJPMrDSOm5gbUsv/hhiB287NGvyWS4h
 m/VtjBe7RTrC/EZ5oO5WUhV/cu2c+4ARCLdUgUpoO6nn4NtV6V2ToxR382j4/wYtCzgi
 S0BBXfNOEyg4vlEDI3QjUkrE0ta3qAKE211poNgDbKvWJPnm7l1eUNJom6CZP8sKK39p
 YK4FyGCRnrLphBRLay1c4/Y32XKEg6s9zWgz5YEKmp1m3N/otEP9O4MXb6ovJSmFVjo0
 oCe2ZqiEhFwaKaQxpt03G6RiKGt5vBj9sPOUBOLG7uBesx4I9LeSm59hGCKPbXlMZ2ZO
 gtXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714041610; x=1714646410;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5htmrfELNsneNGmKSlA9Gw3MrpMWp51ddAIN8u/Ht+I=;
 b=pLMmg36ve7OnM9YODfPmeTg3Q6fOldhNRnM2CjD/5BnI0sc8awUMrEqwfpBvg7I09C
 AQvaEztnKBgt8dGK05NChbl9cRxKJk6S9f1ws2OGapVWeIEuOkAQkGW5Huh4q/qVFK1I
 yBEo+jEt8YsNAZwWSQyHJ9B78NVcIt8wK8goYYW54r4+CBlRu6P/QHQWAVB/iYK3fSKn
 HZofy17RyyiWnD3/VrZDPGO4TsQJ9be4j4SBh4NP5fYQ/7HI0SMiS6sYcgmC1920B000
 Kb2MG5Ho8TwPT8gf4eOeoGukASTKny2csrLpw52gZv43Kjz9RrjzCwx/JtmzNe3x/Ggb
 s6iA==
X-Gm-Message-State: AOJu0Yzu8QPaLX7q05Kc5Jto/PnCkfEpMBWwZqPLfCa7PdzCA12aCt07
 y0hu64Tz2AqJGAy+a7UwXRQO0Lx4KJn5sd52UuWnmtV7dx2oAbQS3ayVldWNsfhppT9MWrkNx7V
 +
X-Google-Smtp-Source: AGHT+IFpL9BbEaWGLc7yKR43/3QXGzuhaK2TZi+hpvPDbAvwOTKYOM+zSEaLets4DNgtonIQG1rUFw==
X-Received: by 2002:a05:651c:102a:b0:2d4:9fbe:b5f with SMTP id
 w10-20020a05651c102a00b002d49fbe0b5fmr3635838ljm.36.1714041609722; 
 Thu, 25 Apr 2024 03:40:09 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 h15-20020a056000000f00b003434c764f01sm19485768wrx.107.2024.04.25.03.40.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Apr 2024 03:40:09 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 18/37] hw/intc/arm_gicv3: Add NMI handling CPU interface
 registers
Date: Thu, 25 Apr 2024 11:39:39 +0100
Message-Id: <20240425103958.3237225-19-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240425103958.3237225-1-peter.maydell@linaro.org>
References: <20240425103958.3237225-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22b;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
[PMM: Separate out whether cpuif supports NMI from whether the
 GIC proper (IRI) supports NMI]
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20240407081733.3231820-19-ruanjinjie@huawei.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/gicv3_internal.h           |   5 +
 include/hw/intc/arm_gicv3_common.h |   7 ++
 hw/intc/arm_gicv3_cpuif.c          | 147 ++++++++++++++++++++++++++++-
 hw/intc/trace-events               |   1 +
 4 files changed, 155 insertions(+), 5 deletions(-)

diff --git a/hw/intc/gicv3_internal.h b/hw/intc/gicv3_internal.h
index 8d793243f4e..81200eb90e3 100644
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
diff --git a/include/hw/intc/arm_gicv3_common.h b/include/hw/intc/arm_gicv3_common.h
index 88533749ebb..cd09bee3bc4 100644
--- a/include/hw/intc/arm_gicv3_common.h
+++ b/include/hw/intc/arm_gicv3_common.h
@@ -225,6 +225,13 @@ struct GICv3CPUState {
 
     /* This is temporary working state, to avoid a malloc in gicv3_update() */
     bool seenbetter;
+
+    /*
+     * Whether the CPU interface has NMI support (FEAT_GICv3_NMI). The
+     * CPU interface may support NMIs even when the GIC proper (what the
+     * spec calls the IRI; the redistributors and distributor) does not.
+     */
+    bool nmi_support;
 };
 
 /*
diff --git a/hw/intc/arm_gicv3_cpuif.c b/hw/intc/arm_gicv3_cpuif.c
index 67d8fd07b7f..715909d0f7d 100644
--- a/hw/intc/arm_gicv3_cpuif.c
+++ b/hw/intc/arm_gicv3_cpuif.c
@@ -21,6 +21,7 @@
 #include "hw/irq.h"
 #include "cpu.h"
 #include "target/arm/cpregs.h"
+#include "target/arm/cpu-features.h"
 #include "sysemu/tcg.h"
 #include "sysemu/qtest.h"
 
@@ -795,6 +796,13 @@ static uint64_t icv_iar_read(CPUARMState *env, const ARMCPRegInfo *ri)
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
@@ -832,6 +840,23 @@ static int icc_highest_active_prio(GICv3CPUState *cs)
      */
     int i;
 
+    if (cs->nmi_support) {
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
@@ -898,12 +923,24 @@ static bool icc_hppi_can_preempt(GICv3CPUState *cs)
      */
     int rprio;
     uint32_t mask;
+    ARMCPU *cpu = ARM_CPU(cs->cpu);
+    CPUARMState *env = &cpu->env;
 
     if (icc_no_enabled_hppi(cs)) {
         return false;
     }
 
-    if (cs->hppi.prio >= cs->icc_pmr_el1) {
+    if (cs->hppi.nmi) {
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
@@ -923,6 +960,12 @@ static bool icc_hppi_can_preempt(GICv3CPUState *cs)
         return true;
     }
 
+    if (cs->hppi.nmi && (cs->hppi.prio & mask) == (rprio & mask)) {
+        if (!(cs->icc_apr[cs->hppi.grp][0] & ICC_AP1R_EL1_NMI)) {
+            return true;
+        }
+    }
+
     return false;
 }
 
@@ -1044,8 +1087,13 @@ static void icc_activate_irq(GICv3CPUState *cs, int irq)
     int aprbit = prio >> (8 - cs->prebits);
     int regno = aprbit / 32;
     int regbit = aprbit % 32;
+    bool nmi = cs->hppi.nmi;
 
-    cs->icc_apr[cs->hppi.grp][regno] |= (1 << regbit);
+    if (nmi) {
+        cs->icc_apr[cs->hppi.grp][regno] |= ICC_AP1R_EL1_NMI;
+    } else {
+        cs->icc_apr[cs->hppi.grp][regno] |= (1 << regbit);
+    }
 
     if (irq < GIC_INTERNAL) {
         cs->gicr_iactiver0 = deposit32(cs->gicr_iactiver0, irq, 1, 1);
@@ -1159,6 +1207,7 @@ static uint64_t icc_iar0_read(CPUARMState *env, const ARMCPRegInfo *ri)
 static uint64_t icc_iar1_read(CPUARMState *env, const ARMCPRegInfo *ri)
 {
     GICv3CPUState *cs = icc_cs_from_env(env);
+    int el = arm_current_el(env);
     uint64_t intid;
 
     if (icv_access(env, HCR_IMO)) {
@@ -1172,13 +1221,44 @@ static uint64_t icc_iar1_read(CPUARMState *env, const ARMCPRegInfo *ri)
     }
 
     if (!gicv3_intid_is_special(intid)) {
-        icc_activate_irq(cs, intid);
+        if (cs->hppi.nmi && env->cp15.sctlr_el[el] & SCTLR_NMI) {
+            intid = INTID_NMI;
+        } else {
+            icc_activate_irq(cs, intid);
+        }
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
+    if (!icc_hppi_can_preempt(cs)) {
+        intid = INTID_SPURIOUS;
+    } else {
+        intid = icc_hppir1_value(cs, env);
+    }
+
+    if (!gicv3_intid_is_special(intid)) {
+        if (!cs->hppi.nmi) {
+            intid = INTID_SPURIOUS;
+        } else {
+            icc_activate_irq(cs, intid);
+        }
+    }
+
+    trace_gicv3_icc_nmiar1_read(gicv3_redist_affid(cs), intid);
+    return intid;
+}
+
 static void icc_drop_prio(GICv3CPUState *cs, int grp)
 {
     /* Drop the priority of the currently active interrupt in
@@ -1205,6 +1285,12 @@ static void icc_drop_prio(GICv3CPUState *cs, int grp)
         if (!*papr) {
             continue;
         }
+
+        if (i == 0 && cs->nmi_support && (*papr & ICC_AP1R_EL1_NMI)) {
+            *papr &= (~ICC_AP1R_EL1_NMI);
+            break;
+        }
+
         /* Clear the lowest set bit */
         *papr &= *papr - 1;
         break;
@@ -1239,6 +1325,15 @@ static int icc_highest_active_group(GICv3CPUState *cs)
      */
     int i;
 
+    if (cs->nmi_support) {
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
@@ -1693,7 +1788,11 @@ static void icc_ap_write(CPUARMState *env, const ARMCPRegInfo *ri,
         return;
     }
 
-    cs->icc_apr[grp][regno] = value & 0xFFFFFFFFU;
+    if (cs->nmi_support) {
+        cs->icc_apr[grp][regno] = value & (0xFFFFFFFFU | ICC_AP1R_EL1_NMI);
+    } else {
+        cs->icc_apr[grp][regno] = value & 0xFFFFFFFFU;
+    }
     gicv3_cpuif_update(cs);
 }
 
@@ -1783,7 +1882,7 @@ static void icc_dir_write(CPUARMState *env, const ARMCPRegInfo *ri,
 static uint64_t icc_rpr_read(CPUARMState *env, const ARMCPRegInfo *ri)
 {
     GICv3CPUState *cs = icc_cs_from_env(env);
-    int prio;
+    uint64_t prio;
 
     if (icv_access(env, HCR_FMO | HCR_IMO)) {
         return icv_rpr_read(env, ri);
@@ -1803,6 +1902,22 @@ static uint64_t icc_rpr_read(CPUARMState *env, const ARMCPRegInfo *ri)
         }
     }
 
+    if (cs->nmi_support) {
+        /* NMI info is reported in the high bits of RPR */
+        if (arm_feature(env, ARM_FEATURE_EL3) && !arm_is_secure(env)) {
+            if (cs->icc_apr[GICV3_G1NS][0] & ICC_AP1R_EL1_NMI) {
+                prio |= ICC_RPR_EL1_NMI;
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
@@ -2482,6 +2597,15 @@ static const ARMCPRegInfo gicv3_cpuif_icc_apxr23_reginfo[] = {
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
@@ -2838,6 +2962,19 @@ void gicv3_init_cpuif(GICv3State *s)
          */
         define_arm_cp_regs(cpu, gicv3_cpuif_reginfo);
 
+        /*
+         * If the CPU implements FEAT_NMI and FEAT_GICv3 it must also
+         * implement FEAT_GICv3_NMI, which is the CPU interface part
+         * of NMI support. This is distinct from whether the GIC proper
+         * (redistributors and distributor) have NMI support. In QEMU
+         * that is a property of the GIC device in s->nmi_support;
+         * cs->nmi_support indicates the CPU interface's support.
+         */
+        if (cpu_isar_feature(aa64_nmi, cpu)) {
+            cs->nmi_support = true;
+            define_arm_cp_regs(cpu, gicv3_cpuif_gicv3_nmi_reginfo);
+        }
+
         /*
          * The CPU implementation specifies the number of supported
          * bits of physical priority. For backwards compatibility
diff --git a/hw/intc/trace-events b/hw/intc/trace-events
index 1ef29d0256a..94030550d5a 100644
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


