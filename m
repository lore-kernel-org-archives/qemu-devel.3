Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA7CB10ED659
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 11:18:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w65CC-00070q-8S; Fri, 27 Mar 2026 07:17:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w65CA-0006yu-Ed
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 07:17:42 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w65C8-0008DE-Ib
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 07:17:42 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-439b2965d4bso1506874f8f.2
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2026 04:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774610258; x=1775215058; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=62e2nWfA5UikkCDTdbvEyXi6vb3nI0AfG+OjttEGIxs=;
 b=maJExtiXHHPD2dnugJGFKFyTEEdfvf7qtHCKFRYiBe1gM2MltJt74HYutGAswTiNkz
 lgSGKYG/6Q9Vij+xtjz6leS15nhfzEBIUOIFLOgu0zBtYCsC5FW4WShhPiefMxUJwCSB
 KojC/g9sfUQbnyxWFH7B1KdnzRr65hxPvTxN5aEomJkIX4HMk4fAWWY8Z9pX/zJbWntg
 EaFTNjq2w4UC74pZLEtD30NATJEGmCTKcxZs89FHeo73AcxJimDTP/7PnyR2YPaoHjDM
 D1fRL1ibmONj7hKfR7TLqYaYCQ2ngSVTBaNX/pXSeouhTE6njYrDttmrX5JtpAlL5X0D
 tpDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774610258; x=1775215058;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=62e2nWfA5UikkCDTdbvEyXi6vb3nI0AfG+OjttEGIxs=;
 b=bv9cHgWLmQGH4/DESREEdtyGe/XzAo6HHRD0Gkqf9pFBMpOm1VJPMF8rWICUYyELMx
 Cdcl2tZagI6YxHOpMR9xfe/vxXTzz6Y4qekwiKMGAaNyYsIKMNPuNTZ5jlg77bfOPtWf
 2nnW3WmzfZe45p94iGae++EeRhCNXxvmcfBimiGyaOzEI/yifbl4ZhfUuafPBzdTrJwt
 Xsh5WGQSgvxgA5VaRBiJsd1vLTjsXFZnys4O+q+CP8j/jvEIfRjt4c2DV/LV+9JLKDOg
 JvZkI0NZ0RTJXllU29aPI6S0vLmrynnXVyqqpDnredLO9QVGjxTIPttIfmh8IKJmG7fh
 Ctsg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWKxB6xC8Puz9vbPSqb+R6gJi4ASU0QEUDoH0OT3GSuqYJhIUcMDNg3xETQVw6QQpRsC92Y6Epgnrkf@nongnu.org
X-Gm-Message-State: AOJu0YzgeYCkS4/9VILFAk7ANj3cI2sk/n4+pW6Vovp2qOsUERRMFJey
 oLufW4C5q1HYJpoOkMQlCpZYH0oK29m3zUK9ps3Q9YQr+wj+nRBzJscQryGVph8kQRw=
X-Gm-Gg: ATEYQzxveZXZgupnDZBn6XTSOLRy34KAgnIFVbNIm/RuwUPrX2Sjyei2oegMTA/9snV
 WB/xMugFY/dD/hqAWBDO53mP321J3wBbi96T/WcGOdTsbtAAfXPpdIv+kSI4JU8r00tAyNRgVYq
 h86L5hnXld+o522xYd2pcbyS9JwM42NkfNBOI+g20M6pE1WKs1ytlpupm6FRTlGEaoH2Kf+vK5M
 w6HO/4MxTTiiQk3XZ+Zmi06UgQ+lcmAx6Ha82F4tc0r3Oo+spnAkKucUbDnOR5+JeUYaQSP+KCx
 yOunhaCOMPXBERlI6M3VVGABzb3Z0/IUfwSuK+F3oZ3gT1ByULsKUUqvvIAAOS+y3s5KzHcNvhL
 8+u2ocFvk27axUscKF6Im27PfBIw0ViATvQ8XB4jDQewzrnP3FffnqNNh7XnJg5mwVComCm/nSF
 kTt50U57CtnTtKeSIbroIPNcOPlwyAdyvJSbsendQcmB213dn8rJMn0Y6Qpo+zX250nLXOvbC/e
 X5Uaz6MOhQSZ5+Azdi2R6ymNpt8oKg=
X-Received: by 2002:a05:6000:2409:b0:43b:4ef0:e13 with SMTP id
 ffacd0b85a97d-43b9e9e8225mr3079631f8f.12.1774610258405; 
 Fri, 27 Mar 2026 04:17:38 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b919cf2b2sm15484227f8f.18.2026.03.27.04.17.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 04:17:37 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: [PATCH v2 38/65] target/arm: GICv5 cpuif: Implement PPI pending
 status registers
Date: Fri, 27 Mar 2026 11:16:33 +0000
Message-ID: <20260327111700.795099-39-peter.maydell@linaro.org>
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

The GICv5 PPI pending status is handled by two registers, one of
which is write-1-to-set and one of which is write-1-to-clear.  The
pending state is read-only for PPIs where the handling mode is Edge.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
---
 target/arm/cpu.h             |  1 +
 target/arm/tcg/gicv5-cpuif.c | 44 ++++++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 4574f7005d..980abda3ca 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -606,6 +606,7 @@ typedef struct CPUArchState {
         /* Most PPI registers have 1 bit per PPI, so 64 PPIs to a register */
         uint64_t ppi_active[GICV5_NUM_PPIS / 64];
         uint64_t ppi_hm[GICV5_NUM_PPIS / 64];
+        uint64_t ppi_pend[GICV5_NUM_PPIS / 64];
     } gicv5_cpuif;
 
     struct {
diff --git a/target/arm/tcg/gicv5-cpuif.c b/target/arm/tcg/gicv5-cpuif.c
index e65bd56b3d..ee97d98d7e 100644
--- a/target/arm/tcg/gicv5-cpuif.c
+++ b/target/arm/tcg/gicv5-cpuif.c
@@ -199,6 +199,26 @@ static void gic_ppi_sactive_write(CPUARMState *env, const ARMCPRegInfo *ri,
     raw_write(env, ri, old | value);
 }
 
+static void gic_ppi_cpend_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                                uint64_t value)
+{
+    uint64_t old = raw_read(env, ri);
+    /* If ICC_PPI_HMR_EL1[n].HM is 1, PEND bits are RO */
+    uint64_t hm = env->gicv5_cpuif.ppi_hm[ri->opc2 & 1];
+    value &= ~hm;
+    raw_write(env, ri, old & ~value);
+}
+
+static void gic_ppi_spend_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                                uint64_t value)
+{
+    uint64_t old = raw_read(env, ri);
+    /* If ICC_PPI_HMR_EL1[n].HM is 1, PEND bits are RO */
+    uint64_t hm = env->gicv5_cpuif.ppi_hm[ri->opc2 & 1];
+    value &= ~hm;
+    raw_write(env, ri, old | value);
+}
+
 static const ARMCPRegInfo gicv5_cpuif_reginfo[] = {
     /*
      * Barrier: wait until the effects of a cpuif system register
@@ -314,6 +334,30 @@ static const ARMCPRegInfo gicv5_cpuif_reginfo[] = {
         .fieldoffset = offsetof(CPUARMState, gicv5_cpuif.ppi_hm[1]),
         .resetvalue = PPI_HMR1_RESET,
     },
+    {   .name = "ICC_PPI_CPENDR0_EL1", .state = ARM_CP_STATE_AA64,
+        .opc0 = 3, .opc1 = 0, .crn = 12, .crm = 13, .opc2 = 4,
+        .access = PL1_RW, .type = ARM_CP_ALIAS | ARM_CP_IO | ARM_CP_NO_RAW,
+        .fieldoffset = offsetof(CPUARMState, gicv5_cpuif.ppi_pend[0]),
+        .writefn = gic_ppi_cpend_write,
+    },
+    {   .name = "ICC_PPI_CPENDR1_EL1", .state = ARM_CP_STATE_AA64,
+        .opc0 = 3, .opc1 = 0, .crn = 12, .crm = 13, .opc2 = 5,
+        .access = PL1_RW, .type = ARM_CP_ALIAS | ARM_CP_IO | ARM_CP_NO_RAW,
+        .fieldoffset = offsetof(CPUARMState, gicv5_cpuif.ppi_pend[1]),
+        .writefn = gic_ppi_cpend_write,
+    },
+    {   .name = "ICC_PPI_SPENDR0_EL1", .state = ARM_CP_STATE_AA64,
+        .opc0 = 3, .opc1 = 0, .crn = 12, .crm = 13, .opc2 = 6,
+        .access = PL1_RW, .type = ARM_CP_IO | ARM_CP_NO_RAW,
+        .fieldoffset = offsetof(CPUARMState, gicv5_cpuif.ppi_pend[0]),
+        .writefn = gic_ppi_spend_write,
+    },
+    {   .name = "ICC_PPI_SPENDR0_EL1", .state = ARM_CP_STATE_AA64,
+        .opc0 = 3, .opc1 = 0, .crn = 12, .crm = 13, .opc2 = 7,
+        .access = PL1_RW, .type = ARM_CP_IO | ARM_CP_NO_RAW,
+        .fieldoffset = offsetof(CPUARMState, gicv5_cpuif.ppi_pend[1]),
+        .writefn = gic_ppi_spend_write,
+    },
 };
 
 void define_gicv5_cpuif_regs(ARMCPU *cpu)
-- 
2.43.0


