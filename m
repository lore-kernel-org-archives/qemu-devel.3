Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7EBF10ED65E
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 11:25:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w65CN-0007D0-GL; Fri, 27 Mar 2026 07:17:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w65CH-00075S-2q
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 07:17:49 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w65CE-0008Mi-It
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 07:17:48 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-48558d6ef83so18690575e9.3
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2026 04:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774610265; x=1775215065; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SXyrPHrNeuNNGz1d/8IK0Sz1v5blPipkCHt4LvQFUGQ=;
 b=HqKr8RpycMwHJTiydBjRkSsLu16gqDwVlY1zhgcV+5YWkFFKwnxptMDdddvEU1qp1p
 D7HrIipZnBQPqp9i6ZWGCisET0L9iOId39HBy8VkGPD4lB0IQknkOdx6BMWKf3Igyh2t
 /D4MOQ9b/Brrqp+0ZKO1N6Z/EXWJCQvuegvn+KbEiGGpi2ZP6KuX/rB8PzG1NAOzQEH2
 sHm0tsxRI8NbNL66G92DfsoHDC4SSfFlZPTZ822yZBYfsw5EaOaIOF2VjA84cWPkpGcY
 IcLA+WIS+XBR8pT+NOTZ889VBAW1iNmSSCD+oIxX8OmKZR04hrRvrClwca3UQsNKf6Mi
 ZG+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774610265; x=1775215065;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SXyrPHrNeuNNGz1d/8IK0Sz1v5blPipkCHt4LvQFUGQ=;
 b=Vgl8r5lnbz2c4oA0xUduE4mReq+TPH8IlTpM5Tz1KBQ5nqEhpAFyv6LX6Lb7CDCvPg
 lYtLhwVU+FEDsUBBbIz862rljMKqlFIirDDnOsVtPLojt2NpgwL65pY+7INDaeA4QgF6
 iuHsq+D5bT2iJe23E2h2cpoBOGZn5owVsAbkwJ0RTVFjd8ZSR9WbfEvCsRudPbjfUJ/B
 1ZgWW4BUsh/rBWd4LVxXJCRhZAR8MW/tLNYKvdzv3W+VNlheV834RdW0XEwhwY61Lvtt
 2/mO60iaWZaclKwBT7wTWuaaE0/ijRgn+CfcSvra/kd66558uTzseNoPmsKo/GYTjT9N
 +Q9A==
X-Forwarded-Encrypted: i=1;
 AJvYcCV9yca5ea7RxbFnkVnR0WfqMsY2Z9Bg/4lGQkj2iMcAcN/M9NEp2JiDu6Em4xT6+bitr+9pk5So33j1@nongnu.org
X-Gm-Message-State: AOJu0Yz8Gp/fIuBDjHjIFzJ4597nFqoAC5TOl2wYA8vEW04xqBx7Gh5M
 sTeOEIiHguCzSxGQ2Ha40Kxw2U9y9bhz4sA18JIGOoL4tWP7P0BbCYcXsgc21gkNpZk=
X-Gm-Gg: ATEYQzxcd8TLWRqTt+9HVTb/tas0X9gDzEdNc5kEGnA/ZglWIzEPw/0morBlfkoV/Cw
 KGZq8fSTgwlnhzuCTfmHNTGidX8VwgEhV/vw9o3ZDg4o4v6EaV2ia/XbcZt0eq490DXHgBOXNqq
 Ma6SdMERvD2owqctnIzImzuhXUUwovm799TIcX93TCESgTFQKbu/XYnPJlEj2q1m3rOujYtxkuR
 QqLidWFxlCv04XSTwLrDr5+v2QMYNwZEsysL1d2eILYba0i0NljNZE56Hr+7Smc4zOYVfP+C6Cx
 46ufBpWcNHhQ/coowikShhpvQOvBp7bCwmAvSen9iEc1H/KnSu+eZ5UwzwxDdpojDojV+b79w+V
 J0Tcgp3FOEkumcE4kJAAjbLZvPnWqJRQfPzPRz5ZL0UFgsu96MnbRH/d6a1I9OB0nu3A6AdPlV0
 4P4aiKAuJ/pVmcYasrhRiqUmFFs07RQgk4WfeiDwRGV8sWtMdaMna+4Y3yfYZymQd3pmk8Omni3
 bKppVJFMvrGG7uR+mH34tBgfGhVJtA=
X-Received: by 2002:a05:600c:3586:b0:487:1fbf:e0bb with SMTP id
 5b1f17b1804b1-48727d5a17cmr37323865e9.6.1774610264855; 
 Fri, 27 Mar 2026 04:17:44 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b919cf2b2sm15484227f8f.18.2026.03.27.04.17.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 04:17:44 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: [PATCH v2 45/65] target/arm: GICv5 cpuif: Implement ICC_PCR_EL1
Date: Fri, 27 Mar 2026 11:16:40 +0000
Message-ID: <20260327111700.795099-46-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260327111700.795099-1-peter.maydell@linaro.org>
References: <20260327111700.795099-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
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

Implement the ICC_PCR_* registers.  These hold the physical priority
mask for each interrupt domain -- an HPPI is only sufficiently high
priority to preempt if it is higher priority than this mask value.
Here we just implement the access to this data.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
---
 target/arm/cpu.h             |  1 +
 target/arm/tcg/gicv5-cpuif.c | 31 +++++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 1263841a1d..651fccd59b 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -606,6 +606,7 @@ typedef struct CPUArchState {
         uint64_t icc_icsr_el1;
         uint64_t icc_apr[NUM_GICV5_DOMAINS];
         uint64_t icc_cr0[NUM_GICV5_DOMAINS];
+        uint64_t icc_pcr[NUM_GICV5_DOMAINS];
         /* Most PPI registers have 1 bit per PPI, so 64 PPIs to a register */
         uint64_t ppi_active[GICV5_NUM_PPIS / 64];
         uint64_t ppi_hm[GICV5_NUM_PPIS / 64];
diff --git a/target/arm/tcg/gicv5-cpuif.c b/target/arm/tcg/gicv5-cpuif.c
index 50aa81d74f..b44b0d5398 100644
--- a/target/arm/tcg/gicv5-cpuif.c
+++ b/target/arm/tcg/gicv5-cpuif.c
@@ -49,6 +49,8 @@ FIELD(ICC_CR0, LINK_IDLE, 2, 1)
 FIELD(ICC_CR0, IPPT, 32, 6)
 FIELD(ICC_CR0, PID, 38, 1)
 
+FIELD(ICC_PCR, PRIORITY, 0, 5)
+
 /*
  * We implement 24 bits of interrupt ID, the mandated 5 bits of priority,
  * and no legacy GICv3.3 vcpu interface (yet)
@@ -383,6 +385,28 @@ static void gic_icc_cr0_el1_reset(CPUARMState *env, const ARMCPRegInfo *ri)
     }
 }
 
+static uint64_t gic_icc_pcr_el1_read(CPUARMState *env, const ARMCPRegInfo *ri)
+{
+    GICv5Domain domain = gicv5_logical_domain(env);
+    return env->gicv5_cpuif.icc_pcr[domain];
+}
+
+static void gic_icc_pcr_el1_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                                  uint64_t value)
+{
+    GICv5Domain domain = gicv5_logical_domain(env);
+
+    value &= R_ICC_PCR_PRIORITY_MASK;
+    env->gicv5_cpuif.icc_pcr[domain] = value;
+}
+
+static void gic_icc_pcr_el1_reset(CPUARMState *env, const ARMCPRegInfo *ri)
+{
+    for (int i = 0; i < ARRAY_SIZE(env->gicv5_cpuif.icc_pcr); i++) {
+        env->gicv5_cpuif.icc_pcr[i] = 0;
+    }
+}
+
 static const ARMCPRegInfo gicv5_cpuif_reginfo[] = {
     /*
      * Barrier: wait until the effects of a cpuif system register
@@ -548,6 +572,13 @@ static const ARMCPRegInfo gicv5_cpuif_reginfo[] = {
         .writefn = gic_icc_cr0_el1_write,
         .resetfn = gic_icc_cr0_el1_reset,
     },
+    {   .name = "ICC_PCR_EL1", .state = ARM_CP_STATE_AA64,
+        .opc0 = 3, .opc1 = 1, .crn = 12, .crm = 0, .opc2 = 2,
+        .access = PL1_RW, .type = ARM_CP_IO | ARM_CP_NO_RAW,
+        .readfn = gic_icc_pcr_el1_read,
+        .writefn = gic_icc_pcr_el1_write,
+        .resetfn = gic_icc_pcr_el1_reset,
+    },
     {   .name = "ICC_HAPR_EL1", .state = ARM_CP_STATE_AA64,
         .opc0 = 3, .opc1 = 1, .crn = 12, .crm = 0, .opc2 = 3,
         .access = PL1_R, .type = ARM_CP_IO | ARM_CP_NO_RAW,
-- 
2.43.0


