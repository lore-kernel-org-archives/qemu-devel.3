Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CF8CC3DA61
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 09:42:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYjLO-0003pQ-BH; Tue, 30 Jul 2024 05:40:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sYjLK-0003bA-La
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 05:40:30 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sYjLH-0000XD-Gg
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 05:40:30 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3686b554cfcso2036208f8f.1
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2024 02:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722332425; x=1722937225; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=jEc2SgYhHaxOGH0nqAsbg0clklAWKN/eCzhci1Lx38Q=;
 b=Rcua7EJ70PdjzzKLO9Ua2mzEwn5ThlwOx70bhXAk5LD4zKpg1ePpvWOdkqPaLwZCND
 MxSaIQi4nnQH6AO75fUB+U6mLJyH/V7KxE4H1yTyrH748PEHJYSI3lEF84Lob5Ld58Kb
 jLiI08UcA8H7C+uc7xV1j2hK9AE1f/8qzRNvGz4ykSVfNB3/kOZ+WBQwkn0kuJUZs31U
 JtHGg/7JXjg4KAydOIdD3wUQAelc9gPjzfRW+srv1jnOwNZ2T5j3n3BgQa/i6Lnq5DGE
 cmRomjLWfI+hB1ur/aXOG9BBvgNT/qqCm8ng+A3Uvq5WvDmvxVDaikFekgsIeoG7ICLb
 Xe1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722332425; x=1722937225;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jEc2SgYhHaxOGH0nqAsbg0clklAWKN/eCzhci1Lx38Q=;
 b=C4WghR5wififK4cRMjqNKvHxalCCTNLXM3WJR/mqhRH65BKd/HWUL0XZanE12XSF3k
 MWE46phyOIvfvkiflmTybqZC/UpMnwwV+sIFyxp40nQYXPUeWDmatN6BxZ3EE4mT0cVV
 NOo8kdUPxX3230uA/eVy0OHyUO62oxCQo1bD78j+TjUyVlzll31H9rldZke1HUwpi7IO
 z7OQsyqxaV3iFn97ppuz0asx4nJu1UFz1RfoMePNvzjuITll/+IcakOoxOI+LnKXlGFl
 g7F1r3PisIeXSpOemVkPb3ptAPMooueucGeZP8pbmoSbjq9ZKS81clG4z27Ywe9D1/m5
 Pccg==
X-Gm-Message-State: AOJu0YxXAejt7PlFTn5OoIbP2ElgnvybankeitDAd6VdZe+/sfWZGJ3b
 d2UBeiSKjSnV2cjxVFdSi/psIQdTZ0EBwgBFLN1z5sIXXa5Vgy5Er7DsTdfRwgYzIf+aeRd5D8H
 2
X-Google-Smtp-Source: AGHT+IGi0NTZkOHjElG33KuLW14FVfn5PnbZn7nYVM97IRDSJC2xbgtrNi77n9XMIxcHQKtYXjgBZA==
X-Received: by 2002:adf:ef48:0:b0:368:7e10:6995 with SMTP id
 ffacd0b85a97d-36b5ceef468mr6548012f8f.17.1722332425190; 
 Tue, 30 Jul 2024 02:40:25 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36b36862549sm14194974f8f.106.2024.07.30.02.40.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jul 2024 02:40:24 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/21] hvf: arm: Raise an exception for sysreg by default
Date: Tue, 30 Jul 2024 10:40:04 +0100
Message-Id: <20240730094020.2758637-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240730094020.2758637-1-peter.maydell@linaro.org>
References: <20240730094020.2758637-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42e.google.com
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

Any sysreg access results in an exception unless defined otherwise so
we should raise an exception by default.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/hvf/hvf.c | 174 +++++++++++++++++++++----------------------
 1 file changed, 85 insertions(+), 89 deletions(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index eb090e67a2f..1a749534fb0 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1199,57 +1199,56 @@ static bool hvf_sysreg_read_cp(CPUState *cpu, uint32_t reg, uint64_t *val)
     return false;
 }
 
-static int hvf_sysreg_read(CPUState *cpu, uint32_t reg, uint32_t rt)
+static int hvf_sysreg_read(CPUState *cpu, uint32_t reg, uint64_t *val)
 {
     ARMCPU *arm_cpu = ARM_CPU(cpu);
     CPUARMState *env = &arm_cpu->env;
-    uint64_t val = 0;
 
     switch (reg) {
     case SYSREG_CNTPCT_EL0:
-        val = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) /
+        *val = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) /
               gt_cntfrq_period_ns(arm_cpu);
-        break;
+        return 0;
     case SYSREG_PMCR_EL0:
-        val = env->cp15.c9_pmcr;
-        break;
+        *val = env->cp15.c9_pmcr;
+        return 0;
     case SYSREG_PMCCNTR_EL0:
         pmu_op_start(env);
-        val = env->cp15.c15_ccnt;
+        *val = env->cp15.c15_ccnt;
         pmu_op_finish(env);
-        break;
+        return 0;
     case SYSREG_PMCNTENCLR_EL0:
-        val = env->cp15.c9_pmcnten;
-        break;
+        *val = env->cp15.c9_pmcnten;
+        return 0;
     case SYSREG_PMOVSCLR_EL0:
-        val = env->cp15.c9_pmovsr;
-        break;
+        *val = env->cp15.c9_pmovsr;
+        return 0;
     case SYSREG_PMSELR_EL0:
-        val = env->cp15.c9_pmselr;
-        break;
+        *val = env->cp15.c9_pmselr;
+        return 0;
     case SYSREG_PMINTENCLR_EL1:
-        val = env->cp15.c9_pminten;
-        break;
+        *val = env->cp15.c9_pminten;
+        return 0;
     case SYSREG_PMCCFILTR_EL0:
-        val = env->cp15.pmccfiltr_el0;
-        break;
+        *val = env->cp15.pmccfiltr_el0;
+        return 0;
     case SYSREG_PMCNTENSET_EL0:
-        val = env->cp15.c9_pmcnten;
-        break;
+        *val = env->cp15.c9_pmcnten;
+        return 0;
     case SYSREG_PMUSERENR_EL0:
-        val = env->cp15.c9_pmuserenr;
-        break;
+        *val = env->cp15.c9_pmuserenr;
+        return 0;
     case SYSREG_PMCEID0_EL0:
     case SYSREG_PMCEID1_EL0:
         /* We can't really count anything yet, declare all events invalid */
-        val = 0;
-        break;
+        *val = 0;
+        return 0;
     case SYSREG_OSLSR_EL1:
-        val = env->cp15.oslsr_el1;
-        break;
+        *val = env->cp15.oslsr_el1;
+        return 0;
     case SYSREG_OSDLR_EL1:
         /* Dummy register */
-        break;
+        return 0;
     case SYSREG_ICC_AP0R0_EL1:
     case SYSREG_ICC_AP0R1_EL1:
     case SYSREG_ICC_AP0R2_EL1:
@@ -1276,9 +1275,8 @@ static int hvf_sysreg_read(CPUState *cpu, uint32_t reg, uint32_t rt)
     case SYSREG_ICC_SRE_EL1:
     case SYSREG_ICC_CTLR_EL1:
         /* Call the TCG sysreg handler. This is only safe for GICv3 regs. */
-        if (!hvf_sysreg_read_cp(cpu, reg, &val)) {
-            hvf_raise_exception(cpu, EXCP_UDEF, syn_uncategorized());
-            return 1;
+        if (hvf_sysreg_read_cp(cpu, reg, &val)) {
+            return 0;
         }
         break;
     case SYSREG_DBGBVR0_EL1:
@@ -1297,8 +1295,8 @@ static int hvf_sysreg_read(CPUState *cpu, uint32_t reg, uint32_t rt)
     case SYSREG_DBGBVR13_EL1:
     case SYSREG_DBGBVR14_EL1:
     case SYSREG_DBGBVR15_EL1:
-        val = env->cp15.dbgbvr[SYSREG_CRM(reg)];
-        break;
+        *val = env->cp15.dbgbvr[SYSREG_CRM(reg)];
+        return 0;
     case SYSREG_DBGBCR0_EL1:
     case SYSREG_DBGBCR1_EL1:
     case SYSREG_DBGBCR2_EL1:
@@ -1315,8 +1313,8 @@ static int hvf_sysreg_read(CPUState *cpu, uint32_t reg, uint32_t rt)
     case SYSREG_DBGBCR13_EL1:
     case SYSREG_DBGBCR14_EL1:
     case SYSREG_DBGBCR15_EL1:
-        val = env->cp15.dbgbcr[SYSREG_CRM(reg)];
-        break;
+        *val = env->cp15.dbgbcr[SYSREG_CRM(reg)];
+        return 0;
     case SYSREG_DBGWVR0_EL1:
     case SYSREG_DBGWVR1_EL1:
     case SYSREG_DBGWVR2_EL1:
@@ -1333,8 +1331,8 @@ static int hvf_sysreg_read(CPUState *cpu, uint32_t reg, uint32_t rt)
     case SYSREG_DBGWVR13_EL1:
     case SYSREG_DBGWVR14_EL1:
     case SYSREG_DBGWVR15_EL1:
-        val = env->cp15.dbgwvr[SYSREG_CRM(reg)];
-        break;
+        *val = env->cp15.dbgwvr[SYSREG_CRM(reg)];
+        return 0;
     case SYSREG_DBGWCR0_EL1:
     case SYSREG_DBGWCR1_EL1:
     case SYSREG_DBGWCR2_EL1:
@@ -1351,35 +1349,25 @@ static int hvf_sysreg_read(CPUState *cpu, uint32_t reg, uint32_t rt)
     case SYSREG_DBGWCR13_EL1:
     case SYSREG_DBGWCR14_EL1:
     case SYSREG_DBGWCR15_EL1:
-        val = env->cp15.dbgwcr[SYSREG_CRM(reg)];
-        break;
+        *val = env->cp15.dbgwcr[SYSREG_CRM(reg)];
+        return 0;
     default:
         if (is_id_sysreg(reg)) {
             /* ID system registers read as RES0 */
-            val = 0;
-            break;
+            *val = 0;
+            return 0;
         }
-        cpu_synchronize_state(cpu);
-        trace_hvf_unhandled_sysreg_read(env->pc, reg,
-                                        SYSREG_OP0(reg),
-                                        SYSREG_OP1(reg),
-                                        SYSREG_CRN(reg),
-                                        SYSREG_CRM(reg),
-                                        SYSREG_OP2(reg));
-        hvf_raise_exception(cpu, EXCP_UDEF, syn_uncategorized());
-        return 1;
     }
 
-    trace_hvf_sysreg_read(reg,
-                          SYSREG_OP0(reg),
-                          SYSREG_OP1(reg),
-                          SYSREG_CRN(reg),
-                          SYSREG_CRM(reg),
-                          SYSREG_OP2(reg),
-                          val);
-    hvf_set_reg(cpu, rt, val);
-
-    return 0;
+    cpu_synchronize_state(cpu);
+    trace_hvf_unhandled_sysreg_read(env->pc, reg,
+                                    SYSREG_OP0(reg),
+                                    SYSREG_OP1(reg),
+                                    SYSREG_CRN(reg),
+                                    SYSREG_CRM(reg),
+                                    SYSREG_OP2(reg));
+    hvf_raise_exception(cpu, EXCP_UDEF, syn_uncategorized());
+    return 1;
 }
 
 static void pmu_update_irq(CPUARMState *env)
@@ -1503,7 +1491,7 @@ static int hvf_sysreg_write(CPUState *cpu, uint32_t reg, uint64_t val)
         pmu_op_start(env);
         env->cp15.c15_ccnt = val;
         pmu_op_finish(env);
-        break;
+        return 0;
     case SYSREG_PMCR_EL0:
         pmu_op_start(env);
 
@@ -1523,45 +1511,45 @@ static int hvf_sysreg_write(CPUState *cpu, uint32_t reg, uint64_t val)
         env->cp15.c9_pmcr |= (val & PMCR_WRITABLE_MASK);
 
         pmu_op_finish(env);
-        break;
+        return 0;
     case SYSREG_PMUSERENR_EL0:
         env->cp15.c9_pmuserenr = val & 0xf;
-        break;
+        return 0;
     case SYSREG_PMCNTENSET_EL0:
         env->cp15.c9_pmcnten |= (val & pmu_counter_mask(env));
-        break;
+        return 0;
     case SYSREG_PMCNTENCLR_EL0:
         env->cp15.c9_pmcnten &= ~(val & pmu_counter_mask(env));
-        break;
+        return 0;
     case SYSREG_PMINTENCLR_EL1:
         pmu_op_start(env);
         env->cp15.c9_pminten |= val;
         pmu_op_finish(env);
-        break;
+        return 0;
     case SYSREG_PMOVSCLR_EL0:
         pmu_op_start(env);
         env->cp15.c9_pmovsr &= ~val;
         pmu_op_finish(env);
-        break;
+        return 0;
     case SYSREG_PMSWINC_EL0:
         pmu_op_start(env);
         pmswinc_write(env, val);
         pmu_op_finish(env);
-        break;
+        return 0;
     case SYSREG_PMSELR_EL0:
         env->cp15.c9_pmselr = val & 0x1f;
-        break;
+        return 0;
     case SYSREG_PMCCFILTR_EL0:
         pmu_op_start(env);
         env->cp15.pmccfiltr_el0 = val & PMCCFILTR_EL0;
         pmu_op_finish(env);
-        break;
+        return 0;
     case SYSREG_OSLAR_EL1:
         env->cp15.oslsr_el1 = val & 1;
-        break;
+        return 0;
     case SYSREG_OSDLR_EL1:
         /* Dummy register */
-        break;
+        return 0;
     case SYSREG_ICC_AP0R0_EL1:
     case SYSREG_ICC_AP0R1_EL1:
     case SYSREG_ICC_AP0R2_EL1:
@@ -1591,10 +1579,10 @@ static int hvf_sysreg_write(CPUState *cpu, uint32_t reg, uint64_t val)
         if (!hvf_sysreg_write_cp(cpu, reg, val)) {
             hvf_raise_exception(cpu, EXCP_UDEF, syn_uncategorized());
         }
-        break;
+        return 0;
     case SYSREG_MDSCR_EL1:
         env->cp15.mdscr_el1 = val;
-        break;
+        return 0;
     case SYSREG_DBGBVR0_EL1:
     case SYSREG_DBGBVR1_EL1:
     case SYSREG_DBGBVR2_EL1:
@@ -1612,7 +1600,7 @@ static int hvf_sysreg_write(CPUState *cpu, uint32_t reg, uint64_t val)
     case SYSREG_DBGBVR14_EL1:
     case SYSREG_DBGBVR15_EL1:
         env->cp15.dbgbvr[SYSREG_CRM(reg)] = val;
-        break;
+        return 0;
     case SYSREG_DBGBCR0_EL1:
     case SYSREG_DBGBCR1_EL1:
     case SYSREG_DBGBCR2_EL1:
@@ -1630,7 +1618,7 @@ static int hvf_sysreg_write(CPUState *cpu, uint32_t reg, uint64_t val)
     case SYSREG_DBGBCR14_EL1:
     case SYSREG_DBGBCR15_EL1:
         env->cp15.dbgbcr[SYSREG_CRM(reg)] = val;
-        break;
+        return 0;
     case SYSREG_DBGWVR0_EL1:
     case SYSREG_DBGWVR1_EL1:
     case SYSREG_DBGWVR2_EL1:
@@ -1648,7 +1636,7 @@ static int hvf_sysreg_write(CPUState *cpu, uint32_t reg, uint64_t val)
     case SYSREG_DBGWVR14_EL1:
     case SYSREG_DBGWVR15_EL1:
         env->cp15.dbgwvr[SYSREG_CRM(reg)] = val;
-        break;
+        return 0;
     case SYSREG_DBGWCR0_EL1:
     case SYSREG_DBGWCR1_EL1:
     case SYSREG_DBGWCR2_EL1:
@@ -1666,20 +1654,18 @@ static int hvf_sysreg_write(CPUState *cpu, uint32_t reg, uint64_t val)
     case SYSREG_DBGWCR14_EL1:
     case SYSREG_DBGWCR15_EL1:
         env->cp15.dbgwcr[SYSREG_CRM(reg)] = val;
-        break;
-    default:
-        cpu_synchronize_state(cpu);
-        trace_hvf_unhandled_sysreg_write(env->pc, reg,
-                                         SYSREG_OP0(reg),
-                                         SYSREG_OP1(reg),
-                                         SYSREG_CRN(reg),
-                                         SYSREG_CRM(reg),
-                                         SYSREG_OP2(reg));
-        hvf_raise_exception(cpu, EXCP_UDEF, syn_uncategorized());
-        return 1;
+        return 0;
     }
 
-    return 0;
+    cpu_synchronize_state(cpu);
+    trace_hvf_unhandled_sysreg_write(env->pc, reg,
+                                     SYSREG_OP0(reg),
+                                     SYSREG_OP1(reg),
+                                     SYSREG_CRN(reg),
+                                     SYSREG_CRM(reg),
+                                     SYSREG_OP2(reg));
+    hvf_raise_exception(cpu, EXCP_UDEF, syn_uncategorized());
+    return 1;
 }
 
 static int hvf_inject_interrupts(CPUState *cpu)
@@ -1944,7 +1930,17 @@ int hvf_vcpu_exec(CPUState *cpu)
         int sysreg_ret = 0;
 
         if (isread) {
-            sysreg_ret = hvf_sysreg_read(cpu, reg, rt);
+            sysreg_ret = hvf_sysreg_read(cpu, reg, &val);
+            if (!sysreg_ret) {
+                trace_hvf_sysreg_read(reg,
+                                      SYSREG_OP0(reg),
+                                      SYSREG_OP1(reg),
+                                      SYSREG_CRN(reg),
+                                      SYSREG_CRM(reg),
+                                      SYSREG_OP2(reg),
+                                      val);
+                hvf_set_reg(cpu, rt, val);
+            }
         } else {
             val = hvf_get_reg(cpu, rt);
             sysreg_ret = hvf_sysreg_write(cpu, reg, val);
-- 
2.34.1


