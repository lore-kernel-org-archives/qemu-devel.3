Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD4EECD3439
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 15:58:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL11t-00059O-Dx; Thu, 07 May 2026 11:52:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wL11r-0004xX-1G
 for qemu-devel@nongnu.org; Thu, 07 May 2026 11:52:47 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wL11p-0003zv-4Y
 for qemu-devel@nongnu.org; Thu, 07 May 2026 11:52:46 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-488b3f8fa2bso21634945e9.1
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 08:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778169164; x=1778773964; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Xs/VyWB1wsEFra+dTiNs9oicQWO6xGZ5XUVh0iNByNg=;
 b=g8aZXcxC2TAoKEawpJxKY0RAGrrpb3SOrKVqMrCr1uAc38FG9VTKrIDSlShWINFE24
 PddnEeG78m41T80EqYtIaVza7R7mo2+NjHAQvbafAMeA14u2hLycZkWkGX1f2rckt8UH
 EMnTFfLja82LW6xR/0i9CE22FLC0GXw/AR9IyPsOV3Y6MxFo0XBdP5UaV3866WmV3Aiq
 tumq6eUt536kbkXwF3GJ0/YBV6KLhMoRZlkM8KMmQMWa2NNx5dVLG2Ttl1g4DW8Qh9zX
 /7O2Nvi2Qno6adR0pMV8RHVqT37n82M2wV8w19hpIKOPHOb2hhWEY0p21ybH0n6afnv4
 J7Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778169164; x=1778773964;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Xs/VyWB1wsEFra+dTiNs9oicQWO6xGZ5XUVh0iNByNg=;
 b=N/S9iOsbjjQuJR/soS6/qbsL4X34cUSRBt6IPPj1Z96WHaYCu64uo6pq5vGt6LNWSS
 2Jypgv8SeMi8H72imU6nHvID7cR0UfPrVmb0FZDkPVkrsGTh+RE3GI7rOsBQaCXfUiGI
 /okxotDT95SELRJKDNaO/lXFGjEHvFNyZ1KX4i9bCuKKh0v8Chrfw+VbhFcw9LL/2StU
 KWheOndWZ58tyhQZJP3jEV3pW0GuRGSTN+KjHFM0B2IhFO96Mf9xozwszV2u6K7puZJL
 eElnmFEwmC7txZ4EdqpmeU1Kb11eBYbBrGSe1C2yvHHKfOvQU9lZ3xa9qX/zhw5WhsbU
 83HQ==
X-Gm-Message-State: AOJu0YwWqUHqwJmLGx3qI0Oa9wlwFg6p4Y0i0LDmhJ8C6hCA3pkhmedN
 qHTOnouJYjVilNdzE+pNe1G2U7tYsxRMYKEDA80tgiSQpAk7TuOnXkXe2Bkph2FEajRYlhVVpYn
 8MbWA
X-Gm-Gg: AeBDiet8sq13ssHITDPu8eOEU7zbrUpOZSqck7PHSJUsUG83KCYwtCvMAYGEe8VsU6e
 uP/qN90kvKzkwKjpSjo4oiloCOOM4BDOUab3x+tEpj9SRBhK0RWKDQKIwtXiKrPTqCHSH1kRtsN
 t29HlF1xwARCgRNOWH176otjaYBnZZZjEpQkbuDZ4t5d5FHa9FPNDcIxtCR8tYiZxG56WkSsoxw
 jjXZCIgzFLcN/W/6tzVpBbfQa7ax0xFiLE5VwIJ6SGJ1t3aHj69db2bTvdQwyeiZjPXkMeb1aL+
 AWgiWtfr9x8u8KjTQAyt9W/KOHRqbNfg+W+z1i+IGb/sfsYcsdcjsVq9FPGi7XtGrVsr1YG1Pp6
 IMXJ2CBqLzNIhrdfDjJaMM1qeRHvP/t1EzHL1GcfVG7BsTmiBNv3qRLTdPBuM5sytlBOQhRLBjP
 1B44igVM4Tkth6IYOP1tGQKvsH9TLBTXr/xjduJCuEyXKPCXPPjL3BAWlnR+X6tPRdh22OyPrDB
 1pPzwGs1tEaZbkjrv5fthU9HiDOmAs=
X-Received: by 2002:a05:600c:a10a:b0:48d:50a:6ef4 with SMTP id
 5b1f17b1804b1-48e5dffab24mr40395615e9.11.1778169163627; 
 Thu, 07 May 2026 08:52:43 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e5312df8dsm41552195e9.18.2026.05.07.08.52.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 08:52:43 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 48/67] target/arm: GICv5 cpuif: Implement GICR CDIA command
Date: Thu,  7 May 2026 16:51:35 +0100
Message-ID: <20260507155154.1886557-49-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507155154.1886557-1-peter.maydell@linaro.org>
References: <20260507155154.1886557-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
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

The GICR CDIA system instruction is what the guest uses to
acknowledge the highest priority pending interrupt.  It returns a
value corresponding to the HPPI for the current physical interrupt
domain, if any, and moves that interrupt to being Active.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Message-id: 20260327111700.795099-49-peter.maydell@linaro.org
---
 target/arm/tcg/gicv5-cpuif.c | 101 +++++++++++++++++++++++++++++++++++
 target/arm/tcg/trace-events  |   2 +
 2 files changed, 103 insertions(+)

diff --git a/target/arm/tcg/gicv5-cpuif.c b/target/arm/tcg/gicv5-cpuif.c
index e7fe4f0fa1..52abe175bb 100644
--- a/target/arm/tcg/gicv5-cpuif.c
+++ b/target/arm/tcg/gicv5-cpuif.c
@@ -39,6 +39,10 @@ FIELD(GIC_CDHM, HM, 32, 1)
 FIELD(GIC_CDRCFG, ID, 0, 24)
 FIELD(GIC_CDRCFG, TYPE, 29, 3)
 
+FIELD(GICR_CDIA, ID, 0, 24)
+FIELD(GICR_CDIA, TYPE, 29, 3)
+FIELD(GICR_CDIA, VALID, 32, 1)
+
 FIELD(ICC_IDR0_EL1, ID_BITS, 0, 4)
 FIELD(ICC_IDR0_EL1, PRI_BITS, 4, 4)
 FIELD(ICC_IDR0_EL1, GCIE_LEGACY, 8, 4)
@@ -463,6 +467,93 @@ static uint64_t gic_icc_hppir_el1_read(CPUARMState *env, const ARMCPRegInfo *ri)
     return hppi.intid;
 }
 
+static bool gic_hppi_is_nmi(CPUARMState *env, GICv5PendingIrq hppi,
+                            GICv5Domain domain)
+{
+    /*
+     * For GICv5 an interrupt is an NMI if it is signaled with
+     * Superpriority and SCTLR_ELx.NMI for the current EL is 1.  GICR
+     * CDIA/CDNMIA always work on the current interrupt domain, so we
+     * do not need to consider preemptive interrupts. This means that
+     * the interrupt has Superpriority if and only if it has priority 0.
+     */
+    return hppi.prio == 0 && arm_sctlr(env, arm_current_el(env)) & SCTLR_NMI;
+}
+
+static uint64_t gicr_cdia_read(CPUARMState *env, const ARMCPRegInfo *ri)
+{
+    /* Acknowledge HPPI in the current interrupt domain */
+    GICv5Common *gic = gicv5_get_gic(env);
+    GICv5Domain domain = gicv5_current_phys_domain(env);
+    GICv5PendingIrq hppi = gic_hppi(env, domain);
+    GICv5IntType type = FIELD_EX64(hppi.intid, INTID, TYPE);
+    uint32_t id = FIELD_EX64(hppi.intid, INTID, ID);
+
+    bool cdnmia = ri->opc2 == 1;
+
+    if (!hppi.intid) {
+        /* No interrupt available to acknowledge */
+        trace_gicv5_gicr_cdia_fail(domain,
+                                   "no available interrupt to acknowledge");
+        return 0;
+    }
+    assert(hppi.prio != PRIO_IDLE);
+
+    if (gic_hppi_is_nmi(env, hppi, domain) != cdnmia) {
+        /* GICR CDIA only acknowledges non-NMI; GICR CDNMIA only NMI */
+        trace_gicv5_gicr_cdia_fail(domain,
+                                   cdnmia ? "CDNMIA but HPPI is not NMI" :
+                                   "CDIA but HPPI is NMI");
+        return 0;
+    }
+
+    trace_gicv5_gicr_cdia(domain, hppi.intid);
+
+    /*
+     * The interrupt becomes Active. If the handling mode of the
+     * interrupt is Edge then we also clear the pending state.
+     */
+
+    /*
+     * Set the appropriate bit in the APR to track active priorities.
+     * We do this now so that when gic_recalc_ppi_hppi() or
+     * gicv5_activate() cause a re-evaluation of HPPIs they use the
+     * right (new) running priority.
+     */
+    env->gicv5_cpuif.icc_apr[domain] |= (1 << hppi.prio);
+    switch (type) {
+    case GICV5_PPI:
+    {
+        uint32_t ppireg, ppibit;
+
+        assert(id < GICV5_NUM_PPIS);
+        ppireg = id / 64;
+        ppibit = 1 << (id % 64);
+
+        env->gicv5_cpuif.ppi_active[ppireg] |= ppibit;
+        if (!(env->gicv5_cpuif.ppi_hm[ppireg] & ppibit)) {
+            /* handling mode is Edge: clear pending */
+            env->gicv5_cpuif.ppi_pend[ppireg] &= ~ppibit;
+        }
+        gic_recalc_ppi_hppi(env);
+        break;
+    }
+    case GICV5_LPI:
+    case GICV5_SPI:
+        /*
+         * Send an Activate command to the IRS, which, despite the
+         * name of the stream command, does both "set Active" and
+         * "maybe set not Pending" as a single atomic action.
+         */
+        gicv5_activate(gic, id, domain, type, false);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
+    return hppi.intid | R_GICR_CDIA_VALID_MASK;
+}
+
 static const ARMCPRegInfo gicv5_cpuif_reginfo[] = {
     /*
      * Barrier: wait until the effects of a cpuif system register
@@ -520,6 +611,16 @@ static const ARMCPRegInfo gicv5_cpuif_reginfo[] = {
         .access = PL1_W, .type = ARM_CP_IO | ARM_CP_NO_RAW,
         .writefn = gic_cdhm_write,
     },
+    {   .name = "GICR_CDIA", .state = ARM_CP_STATE_AA64,
+        .opc0 = 1, .opc1 = 0, .crn = 12, .crm = 3, .opc2 = 0,
+        .access = PL1_R, .type = ARM_CP_IO | ARM_CP_NO_RAW,
+        .readfn = gicr_cdia_read,
+    },
+    {   .name = "GICR_CDNMIA", .state = ARM_CP_STATE_AA64,
+        .opc0 = 1, .opc1 = 0, .crn = 12, .crm = 3, .opc2 = 1,
+        .access = PL1_R, .type = ARM_CP_IO | ARM_CP_NO_RAW,
+        .readfn = gicr_cdia_read,
+    },
     {   .name = "ICC_IDR0_EL1", .state = ARM_CP_STATE_AA64,
         .opc0 = 3, .opc1 = 0, .crn = 12, .crm = 10, .opc2 = 2,
         .access = PL1_R, .type = ARM_CP_CONST | ARM_CP_NO_RAW,
diff --git a/target/arm/tcg/trace-events b/target/arm/tcg/trace-events
index 7dc5f781c5..13e15cfcfc 100644
--- a/target/arm/tcg/trace-events
+++ b/target/arm/tcg/trace-events
@@ -3,3 +3,5 @@
 
 # gicv5-cpuif.c
 gicv5_recalc_ppi_hppi(int domain, uint32_t id, uint8_t prio) "domain %d new PPI HPPI id 0x%x prio %u"
+gicv5_gicr_cdia_fail(int domain, const char *reason) "domain %d CDIA attempt failed: %s"
+gicv5_gicr_cdia(int domain, uint32_t id) "domain %d CDIA acknowledge of interrupt 0x%x"
-- 
2.43.0


