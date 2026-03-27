Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD8B910ED659
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 11:20:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w65Cc-0007pw-3Q; Fri, 27 Mar 2026 07:18:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w65CI-00076t-Fl
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 07:17:51 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w65CF-0008NE-Vp
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 07:17:50 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-43b871dd06eso1154739f8f.0
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2026 04:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774610266; x=1775215066; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+PpzUIdcaAGfh+t+PosoBjEM0xn6FihXvA5kZznGsJk=;
 b=GJUv4C5ehAF9a44rDUtuswEQY/b+Yx91eF+CGHZ9enpgYUV8jpOYQ36kOpVtgaPSis
 5G6mYVcv49yrVle4vod2AEAehNqAk32Pm32bjIL/hTlAYp82h7k6fRa3UChZRkml69Mv
 fSGIrrU9rTJ4WtoXy6MnvXBFpd+lKGvGqfpM3iQYaN8cX7RlH/ayYknnYtHsoGE0gOTo
 oDZQSqZwUxtV1zntl2Apx1+gteHPoFqtUvZTgR/tk9niIVUT4YiLgdYCnwa/a4LxNNFA
 Y+c00VsdCTWs2tNCzsE86zRLMZjtoiOUFsdvb8SdLnEP3BffZ689MVsRvZTWmDuk5fG0
 qm2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774610266; x=1775215066;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+PpzUIdcaAGfh+t+PosoBjEM0xn6FihXvA5kZznGsJk=;
 b=DAJrrFXdEBCIw4VRxepDlpleG/V6nIH4THrkfJxT1CwnJ8DV8kPGxxE2RY9r/jdnQl
 2mkX9ps27CjRYFmEtntLHmKHJ0LngIA4dNYn+bfoojznbKE2zO3Xm83cUNb8lvH8svFN
 wnVhzD8ZuDbXpHAQHOdfQx2iy+OAzKAk9TlgU1C4fDuOIX5GqStHFVgK13kpTwRSA4HF
 oOD41KqxaxAqv35ivy67YNdrc5flVh4LUX0gxaGWo5sX98J/IJCh7URPX89lpa/BYU6U
 3OjLZ0njB2jccG3Hvaee1a9fkg+NQbxy/kNH0aBqKaJ/lD/9twMGEiU7UIncezIF+Qqa
 nKLw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVr/gVRRYIbLcfbGJAlbNawsGqlmHX6fna6EZlvqZ1j+yOfGOYBDjRCn+lm7tie98k+QUDjrUrnOKdJ@nongnu.org
X-Gm-Message-State: AOJu0Yxisq4w/Pr4FZGQwX/E4N07EYjRZj00J4mQUJqCKfB2HUtJu69o
 VS0AUiFRAgN6UHDJrJAC3JBc69KwmmCWfLF+hjRbOhFKFbz5Gwbbqru6CiulX28ZIJY=
X-Gm-Gg: ATEYQzzDh5FkIavangXwGOwESl5jnAAkB7RL9CMrq0ff453R07jFlNZeRnnYmRJxmcb
 Sx4tJvWOA/ECDkYtHUbhoJ+N0MvIDFDhIBR5ik6wJoW03rbhkGbawcF5S9oY1M6cG39vdvcNO9Q
 5OayqfUdyLVJ45JJ7eqn/yHQKuaaS7nXnIeTBfjM3Z87EggUsqZnsBrUVF2oH7HbyF6LPaA+Tl9
 SGhvkR7Rpd8qI7hgWCdQu0Y8T5uDtw/eQRgUpSETgWa7kr88OISRqtCMP6hTjYCFe7CV5egrgfD
 47VgDt576IYL12quLEUw6PN1n+5hSrVRby5jVD6Tzqi6ol6IgvNXo66L4QB8e2Hv20iXgRvd1Fz
 Q3GBNsUia2EEoVziKsNI0/r5bGGql/0xxdAQxCvJwIk+KMdiRaY3t+T1B3zdTbvftJyTdlc3tBG
 jB/FawV+KYAxmN1KOGT44MxSKcR6GiygtRzxgbEB6547ag2+mDslxEbrg/mPGu6Poi9q+a0xe9p
 W/YFCeGyXatl8cmxOnCpvY3DnDTrNA=
X-Received: by 2002:a05:6000:22c8:b0:43b:4966:744a with SMTP id
 ffacd0b85a97d-43b9ea77b34mr3305556f8f.50.1774610265741; 
 Fri, 27 Mar 2026 04:17:45 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b919cf2b2sm15484227f8f.18.2026.03.27.04.17.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 04:17:45 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: [PATCH v2 46/65] target/arm: GICv5 cpuif: Implement ICC_HPPIR_EL1
Date: Fri, 27 Mar 2026 11:16:41 +0000
Message-ID: <20260327111700.795099-47-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260327111700.795099-1-peter.maydell@linaro.org>
References: <20260327111700.795099-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Implement ICC_HPPIR_EL1, which the guest can use to read the current
highest priority pending interrupt.  Like APR, PCR and CR0, this is
banked, with the _EL1 register reading the answer for the current
logical interrupt domain, and the _EL3 register reading the answer
for the EL3 interrupt domain.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
---
 hw/intc/arm_gicv5.c                | 10 +++++
 include/hw/intc/arm_gicv5_stream.h | 13 +++++++
 target/arm/tcg/gicv5-cpuif.c       | 61 ++++++++++++++++++++++++++++++
 3 files changed, 84 insertions(+)

diff --git a/hw/intc/arm_gicv5.c b/hw/intc/arm_gicv5.c
index 12cbf9c51e..605cf6fd6f 100644
--- a/hw/intc/arm_gicv5.c
+++ b/hw/intc/arm_gicv5.c
@@ -527,6 +527,16 @@ static void irs_recall_hppis(GICv5 *s, GICv5Domain domain)
     }
 }
 
+GICv5PendingIrq gicv5_get_hppi(GICv5Common *cs, GICv5Domain domain,
+                               uint32_t iaffid)
+{
+    GICv5 *s = ARM_GICV5(cs);
+    int cpuidx = irs_cpuidx_from_iaffid(cs, iaffid);
+
+    assert(cpuidx >= 0);
+    return s->hppi[domain][cpuidx];
+}
+
 static hwaddr l1_iste_addr(GICv5Common *cs, const GICv5ISTConfig *cfg,
                            uint32_t id)
 {
diff --git a/include/hw/intc/arm_gicv5_stream.h b/include/hw/intc/arm_gicv5_stream.h
index 60c470b84c..cc1c7cc438 100644
--- a/include/hw/intc/arm_gicv5_stream.h
+++ b/include/hw/intc/arm_gicv5_stream.h
@@ -175,4 +175,17 @@ uint64_t gicv5_request_config(GICv5Common *cs, uint32_t id, GICv5Domain domain,
  */
 void gicv5_forward_interrupt(ARMCPU *cpu, GICv5Domain domain);
 
+/**
+ * gicv5_get_hppi
+ * @cs: GIC IRS to query
+ * @domain: interrupt domain to act on
+ * @iaffid: IAFFID of this CPU interface
+ *
+ * Ask the IRS for the highest priority pending interrupt that it has
+ * for this CPU. This returns the equivalent of what in the stream
+ * protocol is the outstanding interrupt sent with a Forward packet.
+ */
+GICv5PendingIrq gicv5_get_hppi(GICv5Common *cs, GICv5Domain domain,
+                               uint32_t iaffid);
+
 #endif
diff --git a/target/arm/tcg/gicv5-cpuif.c b/target/arm/tcg/gicv5-cpuif.c
index b44b0d5398..36bbb70c4a 100644
--- a/target/arm/tcg/gicv5-cpuif.c
+++ b/target/arm/tcg/gicv5-cpuif.c
@@ -51,6 +51,10 @@ FIELD(ICC_CR0, PID, 38, 1)
 
 FIELD(ICC_PCR, PRIORITY, 0, 5)
 
+FIELD(ICC_HPPIR_EL1, ID, 0, 24)
+FIELD(ICC_HPPIR_EL1, TYPE, 29, 3)
+FIELD(ICC_HPPIR_EL1, HPPIV, 32, 1)
+
 /*
  * We implement 24 bits of interrupt ID, the mandated 5 bits of priority,
  * and no legacy GICv3.3 vcpu interface (yet)
@@ -114,6 +118,51 @@ static uint64_t gic_running_prio(CPUARMState *env, GICv5Domain domain)
     return hap < 32 ? hap : PRIO_IDLE;
 }
 
+static GICv5PendingIrq gic_hppi(CPUARMState *env, GICv5Domain domain)
+{
+    /*
+     * Return the current highest priority pending interrupt for the
+     * specified domain, if it has sufficient priority to preempt. The
+     * intid field of the return value will be in the format of the
+     * ICC_HPPIR register (and will be zero if and only if there is no
+     * interrupt that can preempt).
+     */
+
+    GICv5Common *gic = gicv5_get_gic(env);
+    GICv5PendingIrq best, irs_hppi;
+
+    if (!(env->gicv5_cpuif.icc_cr0[domain] & R_ICC_CR0_EN_MASK)) {
+        /* If cpuif is disabled there is no HPPI */
+        return (GICv5PendingIrq) { .intid = 0, .prio = PRIO_IDLE };
+    }
+
+    irs_hppi = gicv5_get_hppi(gic, domain, env->gicv5_iaffid);
+
+    /*
+     * If the best PPI and the best interrupt from the IRS have the
+     * same priority, it's IMPDEF which we pick (R_VVBPS). We choose
+     * the PPI.
+     */
+    if (env->gicv5_cpuif.ppi_hppi[domain].prio <= irs_hppi.prio) {
+        best = env->gicv5_cpuif.ppi_hppi[domain];
+    } else {
+        best = irs_hppi;
+    }
+
+    /*
+     * D_MSQKF: an interrupt has sufficient priority if its priority
+     * is higher than the current running priority and equal to or
+     * higher than the priority mask.
+     */
+    if (best.prio == PRIO_IDLE ||
+        best.prio > env->gicv5_cpuif.icc_pcr[domain] ||
+        best.prio >= gic_running_prio(env, domain)) {
+        return (GICv5PendingIrq) { .intid = 0, .prio = PRIO_IDLE };
+    }
+    best.intid |= R_ICC_HPPIR_EL1_HPPIV_MASK;
+    return best;
+}
+
 static void gic_recalc_ppi_hppi(CPUARMState *env)
 {
     /*
@@ -407,6 +456,13 @@ static void gic_icc_pcr_el1_reset(CPUARMState *env, const ARMCPRegInfo *ri)
     }
 }
 
+static uint64_t gic_icc_hppir_el1_read(CPUARMState *env, const ARMCPRegInfo *ri)
+{
+    GICv5Domain domain = gicv5_logical_domain(env);
+    GICv5PendingIrq hppi = gic_hppi(env, domain);
+    return hppi.intid;
+}
+
 static const ARMCPRegInfo gicv5_cpuif_reginfo[] = {
     /*
      * Barrier: wait until the effects of a cpuif system register
@@ -522,6 +578,11 @@ static const ARMCPRegInfo gicv5_cpuif_reginfo[] = {
         .fieldoffset = offsetof(CPUARMState, gicv5_cpuif.ppi_hm[1]),
         .resetvalue = PPI_HMR1_RESET,
     },
+    {   .name = "ICC_HPPIR_EL1", .state = ARM_CP_STATE_AA64,
+        .opc0 = 3, .opc1 = 0, .crn = 12, .crm = 10, .opc2 = 3,
+        .access = PL1_R, .type = ARM_CP_IO | ARM_CP_NO_RAW,
+        .readfn = gic_icc_hppir_el1_read,
+    },
     {   .name = "ICC_PPI_ENABLER0_EL1", .state = ARM_CP_STATE_AA64,
         .opc0 = 3, .opc1 = 0, .crn = 12, .crm = 10, .opc2 = 6,
         .access = PL1_RW, .type = ARM_CP_IO | ARM_CP_NO_RAW,
-- 
2.43.0


