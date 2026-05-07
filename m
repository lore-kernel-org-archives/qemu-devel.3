Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35DE6CD343F
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 15:56:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL11h-00045I-An; Thu, 07 May 2026 11:52:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wL11g-00043Q-BL
 for qemu-devel@nongnu.org; Thu, 07 May 2026 11:52:36 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wL11e-0003wt-Ja
 for qemu-devel@nongnu.org; Thu, 07 May 2026 11:52:36 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-48334ee0aeaso8131745e9.1
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 08:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778169153; x=1778773953; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=vyF3xatdii2EbkKcDtk1f097Dh6knDLHwXdlLIZ+UoU=;
 b=AkAvMW4cNJnZR9eFc7yCd869Pr6MWpEbbrOLLT3UtsTUsWZwg4GiyU6JT72CGfuP7Y
 Urev1yBZG3m+GqjPtH0AgO8cqjenrBtTp+TEjbZyjSSQmcKRnHdsFzEUCOIYFtY8yFME
 o1Wv5hXSXmuk2MMNdvcm3zIkqWgah28WN43Kmy5fNLCIhkEX2M3kvicxDBIfEIPdbj6H
 CpcaNlgGY5RrLNgf+ca5/nzWUFd/YB6PXZWa4fznUiIvGgrFeKCuecsF5RbRBW+FBkdf
 I3r41PZKdhkAKQqUmiIx+T8P6MFt/PVxyHKiUOcJhDdpkHtCPJlGn7d2GByerbV5Opcw
 f50g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778169153; x=1778773953;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=vyF3xatdii2EbkKcDtk1f097Dh6knDLHwXdlLIZ+UoU=;
 b=nPa5GbiPDk5DwqVI0WJPm8OTOSN/aW00PUVl0jq8CpVQtHTieP9EFhfCQJH8bFvTfN
 szvUd6snp006UfruyaiIAzmz4AN3n7BoT46dra3YZyZbDMG9SiwU70/AjCG1advl1/Ew
 c558grk1UKTKRUuD66Pxm8TfkxCanaMIq8oTLPUefQcdC5Akfq0vGO3LrnWJpbk7Jwfk
 ir7rQsWOP2u3Q+hGq6bXcKpw7hTMW83IQmXc6BEcPF9GxzpxenWh9Bz2RLFC+Weanl5U
 lOrBLrTupLz+PfC7Sn5p9hA8thu4rBDkBY6+0o5phr8x7z54wm8HlS+aL8QzxU0vrnL3
 PP2w==
X-Gm-Message-State: AOJu0YwumiWQNOQxDmaeQ6ALzHnjEXOmaR4DGZckCRLfb5kAevioEMre
 SD5+wdPNRV7axlmcAMm8yCJ719oYAepH3i44y3BiH3418nLx6Recfj6Ky5gOzBAhm6q/6W77Rfx
 zkuSw
X-Gm-Gg: AeBDiesFRH6pH0ejr4GfISRsXNuxE4cAXEA0QCwOEcwfJvC+a5WK1FQ+LiZbjbALhC8
 80QldZpB/chrNX/8jSaM36Npp0q3+5zI9857C3onfrBzkMptcanpz90M36nthrptLNTRPB+Pzl2
 0Pe+Twyh+OWDlFSv0q9z43ZitFLnwJWNaGK23oNAyUbuInmruesRgIoqXcL8heJWOqSSePOXrIk
 JH2jv1fgK2xxi1M9xG1idC2jHYOb5pjiN6sDVnU7Yeyf5ccQZ18WUaOrgUwMn5vhRHgh7YZp9DR
 /zJrhLbAEUFnSnFSRPooMDCrHNg6vlFvaX5rZAxBKLWbwLxIzsgdSPQ4cY6X9FFfoBjhFR8bqur
 M1pPRyKujrpK6KKrRzW07TPwNdXYBYdJL7vQX8VLBLMNAN70T3pY66ss2J4Z5qY5xWnPyR/Pf9M
 7wuUob/2HsRGyuYc6A3HbcNSPd8+BwgFO31Tzwa6XWPwVhBjtX1ZEr2SYZQFcpbf2XltrCAbfal
 LOF/LgUpL9qS3d/qGFe8Z8r2OCRS9Y8kyXiQ5hjEA==
X-Received: by 2002:a05:600c:354b:b0:486:f634:ef1 with SMTP id
 5b1f17b1804b1-48e51f32a7amr141627975e9.17.1778169152958; 
 Thu, 07 May 2026 08:52:32 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e5312df8dsm41552195e9.18.2026.05.07.08.52.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 08:52:32 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 38/67] target/arm: GICv5 cpuif: Implement PPI pending status
 registers
Date: Thu,  7 May 2026 16:51:25 +0100
Message-ID: <20260507155154.1886557-39-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507155154.1886557-1-peter.maydell@linaro.org>
References: <20260507155154.1886557-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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
Message-id: 20260327111700.795099-39-peter.maydell@linaro.org
---
 target/arm/cpu.h             |  1 +
 target/arm/tcg/gicv5-cpuif.c | 44 ++++++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index b8bbc91a16..b0fc90a994 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -605,6 +605,7 @@ typedef struct CPUArchState {
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


