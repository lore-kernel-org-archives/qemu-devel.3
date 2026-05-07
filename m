Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16728CD343F
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 15:57:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL11g-00043M-AT; Thu, 07 May 2026 11:52:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wL11d-00040Q-Nv
 for qemu-devel@nongnu.org; Thu, 07 May 2026 11:52:33 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wL11c-0003w4-5Q
 for qemu-devel@nongnu.org; Thu, 07 May 2026 11:52:33 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-488a88aeec9so12900005e9.2
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 08:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778169151; x=1778773951; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=DrRjECe0L7G9Owd4QfAts2Da6Pk4ELwgWzfZ+b6EEn4=;
 b=asgJ0mDkeASEbykiZc6U/dVqEcXPMeVxH5ecPR6b+gABNZflYKqq+7cuDxjazNZCf3
 SVS1lbm9fvAftTwhZbsd5UVQ6u2OejRMqMDdjOl6Oxq3spgy6Zb+1C4b7dRgGDJ8lqD4
 SjRKvYI3WoOpITGbQJtVBr6cOYBCPP32NXbrcGXsTwZRop15SKLpVj0fEcev62BW0Kdh
 ItH2WpGi7uAKCTD+KpUURmbFjRqp9rU0qygz4XLyvtF5nAGOUBngHvD88H0CHpZNHc35
 ZeeHVHXPi0X7t1MkzSIufJJxgpLGOaZL9nozop+vkxXFH47EswsWHXO9D4fPOXOhC2Ei
 MJng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778169151; x=1778773951;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=DrRjECe0L7G9Owd4QfAts2Da6Pk4ELwgWzfZ+b6EEn4=;
 b=ge2YZKnFloRamI7ZvP6tVF4mT2r0S90A5VGuq8ra0HtEzxmZdB12JQ9ldLmmFtCwh5
 AcOiyWXJIt/ytbI5DfmyDoU6Xn9LJWWmhOCwo5J85KKcUyvS3tRfXEnxTWPhp4iVJ+rg
 AV2J2sesECdJAB05E9H6WBqmRVnSgcmRs3Tl7T2fed1J9CEDSFwCYD5HOF4UPVEHweIH
 Av624r0JlftQtk4TF22p6NNGGhhnfcQFFsl/BSfprErxiPNcJ/0WmikuRmLH9NRVfeMH
 0zMulCFxce3oMBDYO4wrmHsQ0Za5Oin1J6tX/wSeaQMfvek2xT6toa9EYvgmjHJ5d+38
 SX7w==
X-Gm-Message-State: AOJu0YzJOyqxjxSipg3jeKuFiCgCfK2vUVVll0/unC74VSCIxcCrM0yr
 lhxnrrwgN1u+0WCEtr5m4XQvelgFcWx5s9NHyFzUtwVn0/1/E8jBcouZsnhL405NbX0nICSbDyD
 btS2b
X-Gm-Gg: AeBDietgw9j79kSIVD7A0MknjqZqRDsZG9flkISEBTyZiUQkvUocVU2Y6QcwZoOk2yi
 aUZ9+eajGhPQHFHqRpwajwEQAcNngTKCirSnBTGSNPWhwrNA2G3y3o/l0+ZbAKAEZjd3tfnDdcQ
 t1xTjJVxodlI6IF0vNLXgt0C9XCS1oSRGb5efJxIwZfXpc2JHo50fP3M+u/73TKAVyuqvwhH3vf
 /4Ty+D5mjyqmCelTfz9nmfbNNvbD+3McgAIP2lqaai3k83VHteBL91+8Jl/XhpTsnWGtc7C7Bnl
 cOUUcY3bU4ETVCNXd9ia5YE0crOUNpuQLKiCrlJN+cdCiSROrZQwWSkAnJnTazBRcahQIt/zjpN
 Aj89cD8h9cNxUmwlj5vCrCF3fC8aXWd3YaYyAEimJe8w/fsv7/x5muTcRPhwMHA9Pnlaq03fbpq
 BQHrztBSoh4emy5cJlQ8rX2+tfyPqi9OfEPRr5YdRMlNWQYucuqTAXq1skCQ7pQkgIjA6zF+3fp
 PyV1OhyfTkgGXNaoJ2U0ia9q+LjYTK/BIaoL7w6Juab+5erird0
X-Received: by 2002:a05:600c:47d3:b0:48a:9428:5522 with SMTP id
 5b1f17b1804b1-48e51f37358mr86808755e9.16.1778169150464; 
 Thu, 07 May 2026 08:52:30 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e5312df8dsm41552195e9.18.2026.05.07.08.52.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 08:52:29 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 35/67] target/arm: GICv5 cpuif: Implement ICC_IDR0_EL1
Date: Thu,  7 May 2026 16:51:22 +0100
Message-ID: <20260507155154.1886557-36-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507155154.1886557-1-peter.maydell@linaro.org>
References: <20260507155154.1886557-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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

ICC_IDR0_EL1 is an identification register; we can implement this as
a simple constant value.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Message-id: 20260327111700.795099-36-peter.maydell@linaro.org
---
 target/arm/tcg/gicv5-cpuif.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/target/arm/tcg/gicv5-cpuif.c b/target/arm/tcg/gicv5-cpuif.c
index 005e2fa8d2..497c09474b 100644
--- a/target/arm/tcg/gicv5-cpuif.c
+++ b/target/arm/tcg/gicv5-cpuif.c
@@ -38,6 +38,18 @@ FIELD(GIC_CDHM, HM, 32, 1)
 FIELD(GIC_CDRCFG, ID, 0, 24)
 FIELD(GIC_CDRCFG, TYPE, 29, 3)
 
+FIELD(ICC_IDR0_EL1, ID_BITS, 0, 4)
+FIELD(ICC_IDR0_EL1, PRI_BITS, 4, 4)
+FIELD(ICC_IDR0_EL1, GCIE_LEGACY, 8, 4)
+
+/*
+ * We implement 24 bits of interrupt ID, the mandated 5 bits of priority,
+ * and no legacy GICv3.3 vcpu interface (yet)
+ */
+#define QEMU_ICC_IDR0 \
+    ((4 << R_ICC_IDR0_EL1_PRI_BITS_SHIFT) |     \
+     (1 << R_ICC_IDR0_EL1_ID_BITS_SHIFT))
+
 static GICv5Common *gicv5_get_gic(CPUARMState *env)
 {
     return env->gicv5state;
@@ -220,6 +232,11 @@ static const ARMCPRegInfo gicv5_cpuif_reginfo[] = {
         .access = PL1_W, .type = ARM_CP_IO | ARM_CP_NO_RAW,
         .writefn = gic_cdhm_write,
     },
+    {   .name = "ICC_IDR0_EL1", .state = ARM_CP_STATE_AA64,
+        .opc0 = 3, .opc1 = 0, .crn = 12, .crm = 10, .opc2 = 2,
+        .access = PL1_R, .type = ARM_CP_CONST | ARM_CP_NO_RAW,
+        .resetvalue = QEMU_ICC_IDR0,
+    },
     {   .name = "ICC_ICSR_EL1", .state = ARM_CP_STATE_AA64,
         .opc0 = 3, .opc1 = 0, .crn = 12, .crm = 10, .opc2 = 4,
         .access = PL1_RW, .type = ARM_CP_NO_RAW,
-- 
2.43.0


