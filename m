Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 438A810ED659
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 11:23:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w65Di-00012B-W8; Fri, 27 Mar 2026 07:19:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w65CP-0007G7-JT
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 07:17:59 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w65CM-0008Td-VL
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 07:17:56 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-43b3d9d0695so1384636f8f.0
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2026 04:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774610272; x=1775215072; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vYFn49wK2CtOBKQI7tWyVSTEU2OnE1N9jg68K1dqW5o=;
 b=rqI5P0s1z3cQeV2g7BOrZCj33yT288ryAggrXkXuWhcJq1HIZcn/jelxXw2lam07uZ
 NyHEonKovebyYhEc+tDVvwSf1HAeh+6S9uQm4sV15lA7C9KvFdxqzQvH4Z5y2u1S52Lk
 gFbjswoVUJJjfOWQxYxMRI1PK0ypcv84+jFxRypIXyedXEbC0w2G2FjaUiOxSDKU2f2o
 mv4P4jjOJecw0FdVYyEVOuIn4v3syb6RruEjWNSbBYxyw9qFROYNCebqPADxlWZW8NUw
 YHpV3xZGHwU/Z1+bckGaBoEFipOwLax+DSO2qLhZlMIU2KR/eyQdifQl7bF8CRtPp1AU
 xRvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774610272; x=1775215072;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vYFn49wK2CtOBKQI7tWyVSTEU2OnE1N9jg68K1dqW5o=;
 b=QqE03u7u2ZhT2AnwvItX9eiYg5NsukPdGiTuQWqStbTchHhyta6CeCEs+0cGVax1yX
 eGZkjYRgB7kHiXBoOxNCxi+u4u7mvGIyIyf35+xEGOcM92DiJukX1MX1A4UKbD3JRbyI
 du0ZeRnfTFUgnq3WvHhgDzRPDNtI0MhBblR3lnHcPuYDf35nNXtUrKQbiydaoY60WfGy
 hUu7t+5yqqrOE1whE9M/3rUmToXev4a6GTpRjqxHilNiP5/HoJ6Yb71cREt7NRIguguN
 q6Pv7PgBAf2TRsl+jSbtwI5D06rB5PV5dJn7Ql52SDjr8JSdHrbvGDnJf4FxryT/7zoG
 XVkQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWnQSb3XpzcjYck2qqFipdhLj/5kNZxr/sm3BKIoMh4D/T97HNHNpsA7DvBWSaFNNVUrIXVaoAZRuju@nongnu.org
X-Gm-Message-State: AOJu0Yzui/MP47IlhSt6MHkA/xeapBzBZDV5yRk9xTZqdGNJ/jQ69VwD
 7V8PvgxtX7r/A+Fgo4OOiM64D1vDjbOpXYpvs5ANJCZjbgvGi0FjsMpeIqXXWgzq/NA=
X-Gm-Gg: ATEYQzwJrtDXQD6nNycOHuul2WILXgd7rZwTXpujz97d2enCOF8zahP8Tia6+6XafDM
 G66Plp6yF4RdX/nidyfsJgPpl+SjA5hbOJoDZVT0WD8mByTuGABv/IBPctQuCePMV7vytpB6jce
 uOvWknRWOuX+SBb1AVJhibSR5jawELqOTtAjJELFC+U1u9wZ7JYA/UdoqzA/4ikXY4yp0A3W11O
 lENQdpJHo7gozf+FriiH+fjcJOJDbkE7mW6Fzim2fVbV/ZLjnBQWizSwDcunz+0d5MsJ+WBhYHl
 z2CZILOxenzVCuTou9ViX/xWbCb78dLbY8BrCoeVCFaRkSmy1uKMD30E0K+HmebWNwHokYv96ng
 8DAlyTBmnxTo1dRlsbBEV5zDxBaxUUxzyCcJR/MJGG1pPMm1zGpTF0ay3eIr/8u5UfZGYzZv0Qo
 AUmNxva9i97zDW9BBWv6ckI9wj+BUiYe04fqKZEn8qTMNiJPLKLlgI5R7gXPIVbjZawMIRe02hP
 EXAa1ov2YYDPsTFvyxMl9MtQrw62z4=
X-Received: by 2002:a05:6000:2088:b0:43b:90ab:d326 with SMTP id
 ffacd0b85a97d-43b9eb27225mr3124227f8f.20.1774610272320; 
 Fri, 27 Mar 2026 04:17:52 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b919cf2b2sm15484227f8f.18.2026.03.27.04.17.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 04:17:51 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: [PATCH v2 53/65] target/arm: Connect internal interrupt sources up as
 GICv5 PPIs
Date: Fri, 27 Mar 2026 11:16:48 +0000
Message-ID: <20260327111700.795099-54-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260327111700.795099-1-peter.maydell@linaro.org>
References: <20260327111700.795099-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x432.google.com
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

The CPU has several interrupt sources which are exposed as GICv5
PPIs.  For QEMU, this means the generic timers and the PMU.

In GICv3, we implemented these as qemu_irq lines which connect up to
the external interrupt controller device.  In a GICv5, the PPIs are
handled entirely inside the CPU interface, so there are no external
signals.  Instead we provide a gicv5_update_ppi_state() function
which the emulated timer and PMU code uses to tell the CPU interface
about the new state of the PPI source.

We make the GICv5 function a no-op if there is no GICv5 present, so
that calling code can do both "update the old irq lines" and "update
the GICv5 PPI" without having to add conditionals.  (In a GICv5
system the old irq lines won't be connected to anything, so the
qemu_set_irq() will be a no-op.)

Updating PPIs via either mechanism is unnecessary in user-only mode;
we got away with not ifdeffing this away before because
qemu_set_irq() is built for user-only mode, but since the GICv5 cpuif
code is system-emulation only, we do need an ifdef now.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
---
 target/arm/cpregs-pmu.c      |  9 +++++++--
 target/arm/helper.c          | 20 ++++++++++++++++++++
 target/arm/internals.h       |  6 ++++++
 target/arm/tcg/gicv5-cpuif.c | 28 ++++++++++++++++++++++++++++
 target/arm/tcg/trace-events  |  1 +
 5 files changed, 62 insertions(+), 2 deletions(-)

diff --git a/target/arm/cpregs-pmu.c b/target/arm/cpregs-pmu.c
index 47e1e4652b..46df6597b1 100644
--- a/target/arm/cpregs-pmu.c
+++ b/target/arm/cpregs-pmu.c
@@ -428,9 +428,14 @@ static bool pmu_counter_enabled(CPUARMState *env, uint8_t counter)
 
 static void pmu_update_irq(CPUARMState *env)
 {
+#ifndef CONFIG_USER_ONLY
     ARMCPU *cpu = env_archcpu(env);
-    qemu_set_irq(cpu->pmu_interrupt, (env->cp15.c9_pmcr & PMCRE) &&
-            (env->cp15.c9_pminten & env->cp15.c9_pmovsr));
+    bool level = (env->cp15.c9_pmcr & PMCRE) &&
+        (env->cp15.c9_pminten & env->cp15.c9_pmovsr);
+
+    gicv5_update_ppi_state(env, GICV5_PPI_PMUIRQ, level);
+    qemu_set_irq(cpu->pmu_interrupt, level);
+#endif
 }
 
 static bool pmccntr_clockdiv_enabled(CPUARMState *env)
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 8faca360fc..488a91799e 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -1343,6 +1343,21 @@ uint64_t gt_get_countervalue(CPUARMState *env)
     return qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) / gt_cntfrq_period_ns(cpu);
 }
 
+static void gt_update_gicv5_ppi(CPUARMState *env, int timeridx, bool level)
+{
+    static int timeridx_to_ppi[] = {
+        [GTIMER_PHYS] = GICV5_PPI_CNTP,
+        [GTIMER_VIRT] = GICV5_PPI_CNTV,
+        [GTIMER_HYP] = GICV5_PPI_CNTHP,
+        [GTIMER_SEC] = GICV5_PPI_CNTPS,
+        [GTIMER_HYPVIRT] = GICV5_PPI_CNTHV,
+        [GTIMER_S_EL2_PHYS] = GICV5_PPI_CNTHPS,
+        [GTIMER_S_EL2_VIRT] = GICV5_PPI_CNTHVS,
+    };
+
+    gicv5_update_ppi_state(env, timeridx_to_ppi[timeridx], level);
+}
+
 static void gt_update_irq(ARMCPU *cpu, int timeridx)
 {
     CPUARMState *env = &cpu->env;
@@ -1361,6 +1376,11 @@ static void gt_update_irq(ARMCPU *cpu, int timeridx)
         irqstate = 0;
     }
 
+    /*
+     * We update both the GICv5 PPI and the external-GIC irq line
+     * (whichever of the two mechanisms is unused will do nothing)
+     */
+    gt_update_gicv5_ppi(env, timeridx, irqstate);
     qemu_set_irq(cpu->gt_timer_outputs[timeridx], irqstate);
     trace_arm_gt_update_irq(timeridx, irqstate);
 }
diff --git a/target/arm/internals.h b/target/arm/internals.h
index 9bde58cf00..afe893f49d 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1800,6 +1800,12 @@ void define_gcs_cpregs(ARMCPU *cpu);
 /* Add the cpreg definitions for the GICv5 CPU interface */
 void define_gicv5_cpuif_regs(ARMCPU *cpu);
 
+/*
+ * Update the state of the given GICv5 PPI for this CPU. Does nothing
+ * if the GICv5 is not present.
+ */
+void gicv5_update_ppi_state(CPUARMState *env, int ppi, bool level);
+
 /* Effective value of MDCR_EL2 */
 static inline uint64_t arm_mdcr_el2_eff(CPUARMState *env)
 {
diff --git a/target/arm/tcg/gicv5-cpuif.c b/target/arm/tcg/gicv5-cpuif.c
index 7caf2102a9..44b52a4013 100644
--- a/target/arm/tcg/gicv5-cpuif.c
+++ b/target/arm/tcg/gicv5-cpuif.c
@@ -309,6 +309,34 @@ void gicv5_forward_interrupt(ARMCPU *cpu, GICv5Domain domain)
     gicv5_update_irq_fiq(&cpu->env);
 }
 
+void gicv5_update_ppi_state(CPUARMState *env, int ppi, bool level)
+{
+    /*
+     * Update the state of the given PPI (which is connected to some
+     * CPU-internal source of interrupts, like the timers).  We can
+     * assume that the PPI is fixed as level-triggered, which means
+     * that its pending state exactly tracks the input (and the guest
+     * cannot separately change the pending state, because the pending
+     * bits are RO).
+     */
+    int oldlevel;
+
+    if (!cpu_isar_feature(aa64_gcie, env_archcpu(env))) {
+        return;
+    }
+
+    /* The architected PPIs are 0..63, so in the first PPI register. */
+    assert(ppi >= 0 && ppi < 64);
+    oldlevel = extract64(env->gicv5_cpuif.ppi_pend[0], ppi, 1);
+    if (oldlevel != level) {
+        trace_gicv5_update_ppi_state(ppi, level);
+
+        env->gicv5_cpuif.ppi_pend[0] =
+            deposit64(env->gicv5_cpuif.ppi_pend[0], ppi, 1, level);
+        gic_recalc_ppi_hppi(env);
+    }
+}
+
 static void gic_cddis_write(CPUARMState *env, const ARMCPRegInfo *ri,
                             uint64_t value)
 {
diff --git a/target/arm/tcg/trace-events b/target/arm/tcg/trace-events
index 2bfa8fc552..bf1803c872 100644
--- a/target/arm/tcg/trace-events
+++ b/target/arm/tcg/trace-events
@@ -8,3 +8,4 @@ gicv5_gicr_cdia(int domain, uint32_t id) "domain %d CDIA acknowledge of interrup
 gicv5_cdeoi(int domain) "domain %d CDEOI performing priority drop"
 gicv5_cddi(int domain, uint32_t id) "domain %d CDDI deactivating interrupt ID 0x%x"
 gicv5_update_irq_fiq(bool irq, bool fiq, bool nmi) "now IRQ %d FIQ %d NMI %d"
+gicv5_update_ppi_state(int ppi, bool level) "PPI %d source level now %d"
-- 
2.43.0


