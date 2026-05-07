Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4345CD3442
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 15:58:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL11o-0004mb-MV; Thu, 07 May 2026 11:52:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wL11n-0004ZW-0t
 for qemu-devel@nongnu.org; Thu, 07 May 2026 11:52:43 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wL11k-0003yl-SU
 for qemu-devel@nongnu.org; Thu, 07 May 2026 11:52:42 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-488b3f8fa2bso21634665e9.1
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 08:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778169159; x=1778773959; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=kWpQNIQ4Q8qcCBMqzQLlRZfn9wSrTR/FaBxSyEWVI9s=;
 b=WXZRmv0ha3e7cL69UkWNRwiEZKT1I5OA4SdBfeC2N8z+UthPnAC00iYrAYm/gWQfnK
 l+U1SbYFzCPrAYMto1D6by1slT225F197XYNTFECUyV/WGRkEU6aVa0e5RnU3ChzLHkR
 ZpCLa3KXrjaTE9UEsb2AwdQSZcuaz6Zi3KCojFFZ9hRmA+D7diNvoSTOIeifgIN/W6M/
 8AqOjib4axSW1NQ6Uea3ica/oto/IAxLWTWuAO9RuEsuDNdeOA8eGxi1E1JM3vrKfkmc
 O/wk5q7p6nTAI1haVGc/qVGz1CqT0F56QCq9Ke7W3F8kCMpJyHFvtkuEogf2fq8GEqU3
 PSXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778169159; x=1778773959;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=kWpQNIQ4Q8qcCBMqzQLlRZfn9wSrTR/FaBxSyEWVI9s=;
 b=BVV2xI4+VWYKkn2bpOkoWFgmn2iCEy/o9R0mq/5s2/XeQmB/FDrSUglkMN9Z5pfR9v
 YKgljzPS/ndyVBCGy7g5e1RGx/8jWYpQWUTV4Lq3VHyaMBkCyumb8BXBhB/S5QSyAxjR
 nxszvoSzYK9+O54RVujcd2S5zrTievVt1tThz7hGHBuY6ji5SKkXT2yeefLHGy5794A7
 LsBnkPVwfZbrObfmVqPYUy8qiCPgPIpx10u5+AdUNICliXQz2OWpVafpI1eenfgO4Dg/
 AlSrfxxEc4pnx8tZzZWkIGXyiWUDVFh/vMZVIkRbWDA8JVHuo5QCH0SBaHiXQwZZDKFK
 Zp7A==
X-Gm-Message-State: AOJu0YxuZFXfTUrNQFe203DxNUzw4wGqwxXcZL86t/OFdZi61gCpyYVU
 BKfUaHV3uorznAYZR+DpDX+zoEisd3uXu4/tQUg8PEfiYg/OSa52kBHc3+5kvi2AFCMvSAoQCi1
 dn+RT
X-Gm-Gg: AeBDievqIHVnVHQaUPukVgVLbzby8WMpJhO2Vdv/tBu4IlpMHSAIL1VHrZOH97ypTou
 e48iTPd6GdwIw1vjQxPcG/jX3pbIhNTuiFIUJ+xytTvZtDJQLvgbSAP2G5RNdL6gAg4yEGqiOxz
 RUzZKs1qEX5FMZC2JrqW7+FW09BiVx8JtLJoMsAqKHSRM5nYcYMbJRWtigfrWYfGSI5LmBtnJDl
 +poBX96imke2HRHEFPGO8uvFwOsMT3HL80TF0I6OZ3uZ29arbflU2FfuAIGd6oqB9qfmVliNMN4
 yqmnNzpHpFl7TNTBenATerokbyEmaL11K0MJNxfZ6XmbqBIMu2cxzg5UqolMqwHFh6TOpN+3DeS
 wRD6NI/t0lyAwCCI70FjhKFs2AZtdu0BnXku8XymAxC+CwgXVXvvfeA5s4eznwnQzgtaYJg1l6q
 pvXOR80eQsqGTElyHNsWOmnFUZ4Crv7TiljbsKLz45DTFgx6dP89XdDfphUlNlvNWYkF3Il8vkI
 K/YM9Zc3VQS4Nak0s3Nhqo71WTJQYQ=
X-Received: by 2002:a05:600c:4e56:b0:489:1abb:5559 with SMTP id
 5b1f17b1804b1-48e5dfd6508mr52806055e9.5.1778169159208; 
 Thu, 07 May 2026 08:52:39 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e5312df8dsm41552195e9.18.2026.05.07.08.52.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 08:52:38 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 45/67] target/arm: GICv5 cpuif: Implement ICC_PCR_EL1
Date: Thu,  7 May 2026 16:51:32 +0100
Message-ID: <20260507155154.1886557-46-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507155154.1886557-1-peter.maydell@linaro.org>
References: <20260507155154.1886557-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
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
Message-id: 20260327111700.795099-46-peter.maydell@linaro.org
---
 target/arm/cpu.h             |  1 +
 target/arm/tcg/gicv5-cpuif.c | 31 +++++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index afe7f71a04..9d2c27f7df 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -605,6 +605,7 @@ typedef struct CPUArchState {
         uint64_t icc_icsr_el1;
         uint64_t icc_apr[NUM_GICV5_DOMAINS];
         uint64_t icc_cr0[NUM_GICV5_DOMAINS];
+        uint64_t icc_pcr[NUM_GICV5_DOMAINS];
         /* Most PPI registers have 1 bit per PPI, so 64 PPIs to a register */
         uint64_t ppi_active[GICV5_NUM_PPIS / 64];
         uint64_t ppi_hm[GICV5_NUM_PPIS / 64];
diff --git a/target/arm/tcg/gicv5-cpuif.c b/target/arm/tcg/gicv5-cpuif.c
index 23d51bd798..07ebe3a816 100644
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


