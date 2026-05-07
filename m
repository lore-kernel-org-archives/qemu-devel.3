Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC95DCD343F
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 15:58:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL11L-0003V3-DD; Thu, 07 May 2026 11:52:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wL11H-0003SW-FR
 for qemu-devel@nongnu.org; Thu, 07 May 2026 11:52:11 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wL11F-0003og-8z
 for qemu-devel@nongnu.org; Thu, 07 May 2026 11:52:11 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4893940bb5eso6532035e9.3
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 08:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778169127; x=1778773927; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=/TGTY2rfTF+tJN36KyHrpTad81jz0jTI68kPGEzG8y8=;
 b=x2QTAT1Psi0nFJ4UKpG65sXeLZDFlmplsbiuMr+TV9/18/lLZ8KPmh84lnwluRPO0c
 EtTAUHyafmTQLQWF+98q+jRJ0wun9uQ0B3hxEEO8u89DP4eFm81dLQcJucnFofO9zxO1
 TIBufesqMeXdnyIx7cNIiCp+quxQxkeU8nb0nWecW2UCHIjfsMSwRydu2bI/4skMcCTs
 /z+46200GpFo9x/T9b31A+/DXQSqvrZpDqde4/kzDoCbvB6sugYsfeNKl6HdxC14CMtO
 DTkiOnSRefKc+g76FcPkzL7Mav0p0szgs7lQ74m4ZIALcCCWJTgjh9D8ou8GZ41VkjrO
 9Fxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778169127; x=1778773927;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=/TGTY2rfTF+tJN36KyHrpTad81jz0jTI68kPGEzG8y8=;
 b=dzrPK5zTPGzMhGJENaTJRDO+9KTzaR8VwjrJeAb1xhz1vl+lOtEc+26vq26+UN59r8
 koWgYAJl5YEZr/aSKEFZohbz6PznAeXGLkfacHXCBC4E7AkCnimy6bQjSp0IQhZ11gdf
 FLhJcARnivBggSNnYZ41xpY/5unBk+KEIOc5VtK1nBsjDFVuUQsg2TN9aQ1xKzVjHSOc
 bDflxQyHIhQNRF5FDjaoUtW2z9F/jM/6kkuGblBA96p/RVVHJL4hB144wJbz+s6fhxYW
 wwVcAdGbCPkAG8cBJbikGn7bwziZUZfDEeMp72T8FuvKWotfhlhyLtERZ/4ZDRz3a9r2
 a64Q==
X-Gm-Message-State: AOJu0Ywqq1Z1DJ2m2TJR0HxluOrLsdKSAPxqu/dnXMciOM8dypgr3AcZ
 orgkqoERKJnvi+U7NKXs7KClL/hZh9qBrJKiIozBhE+cQEvKgM4B26iKBpc3a1xtcxzg/fd4Q7M
 /k1AS
X-Gm-Gg: AeBDiesSIKSoPLfp2OrmMIRdfBlTCZ8iM9sEe1O786rnIrx7KAg70zhCE4UGDmWKbKY
 Qdv5MZwty2I6QHmo2ss+BBKeMyjM5dj0qZl+XhnHKp0ccTTVerB9/PC0047VA4wDvobPXs603PV
 9muUeXMbDuHIoY6gXZqrvIHw8VnDSOkArULFl5Hva5YUMhLnFV/Q2MelI8MCoeGzhTo4OrTF14a
 tjoczmrjl/m+TzJPn3QxGCL2/9H/JT2k8fpqa9H77vDbmSqygWNOmhIMksYs71Mc3/z7ZkIsm8t
 4Um7Si5lR6zm4wZgmCXnbqv9r//iRxlkfLBYbj9WET9Z+5cMxHiEDkWziAh1D59qe+gmnUuOjua
 nNuuBLE+ROqHrg/OolKuMR/s9S1upwxdwVp+t7/s9CUiDsuqUNOHAaAD7TmDWcqQyG4liQNorgB
 DjoqV2+mOJe5YnuQRE3TOi4RGD3KPK96S9APQhjNz9Hs+qqvPg84isxo8oFjsxO8WssbfTwhE+u
 EOU6kZx6SmjTuquuO+YdqM0cPK8ICRruhL39wr3Kg==
X-Received: by 2002:a05:600c:a305:b0:489:2005:b36e with SMTP id
 5b1f17b1804b1-48e51f444e4mr91995585e9.19.1778169127512; 
 Thu, 07 May 2026 08:52:07 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e5312df8dsm41552195e9.18.2026.05.07.08.52.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 08:52:06 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 13/67] hw/intc/arm_gicv5: Add defines for GICv5 architected PPIs
Date: Thu,  7 May 2026 16:51:00 +0100
Message-ID: <20260507155154.1886557-14-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507155154.1886557-1-peter.maydell@linaro.org>
References: <20260507155154.1886557-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
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

The GICv5 defines architected numbers for the PPI sources like the
generic timer and the PMU; these are different from the ones
traditionally used by GICv2 and GICv3.  Add defines for them.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20260327111700.795099-14-peter.maydell@linaro.org
---
 include/hw/intc/arm_gicv5_types.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/include/hw/intc/arm_gicv5_types.h b/include/hw/intc/arm_gicv5_types.h
index 49dc1d6e95..7d23752ece 100644
--- a/include/hw/intc/arm_gicv5_types.h
+++ b/include/hw/intc/arm_gicv5_types.h
@@ -25,4 +25,24 @@ typedef enum GICv5Domain {
 
 #define NUM_GICV5_DOMAINS 4
 
+/* Architected GICv5 PPIs (as listed in R_XDVCM) */
+#define GICV5_PPI_S_DB_PPI 0
+#define GICV5_PPI_RL_DB_PPI 1
+#define GICV5_PPI_NS_DB_PPI 2
+#define GICV5_PPI_SW_PPI 3
+#define GICV5_PPI_HACDBSIRQ 15
+#define GICV5_PPI_CNTHVS 19
+#define GICV5_PPI_CNTHPS 20
+#define GICV5_PPI_PMBIRQ 21
+#define GICV5_PPI_COMMIRQ 22
+#define GICV5_PPI_PMUIRQ 23
+#define GICV5_PPI_CTIIRQ 24
+#define GICV5_PPI_GICMNT 25
+#define GICV5_PPI_CNTHP 26
+#define GICV5_PPI_CNTV 27
+#define GICV5_PPI_CNTHV 28
+#define GICV5_PPI_CNTPS 29
+#define GICV5_PPI_CNTP 30
+#define GICV5_PPI_TRBIRQ 31
+
 #endif
-- 
2.43.0


