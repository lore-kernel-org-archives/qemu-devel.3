Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C68DC54E4A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 13:44:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rexb2-0001A2-ML; Tue, 27 Feb 2024 08:34:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rexaW-0000ng-5v
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 08:33:40 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rexaP-0002un-Rj
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 08:33:39 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-33d6f26ff33so3022307f8f.0
 for <qemu-devel@nongnu.org>; Tue, 27 Feb 2024 05:33:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709040812; x=1709645612; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=uwmzSpK9oNER9eZ+AlpbFKclBhof2k/XtIYq2ahmcKc=;
 b=aUhqAZiSxzuxJ2lxUAGqEv2vBe0dCQzMSrs4UMjQ5DHlf/TYjkGR39z/Kg3zGbPUxY
 kpTKtoGM6qESB8nbm/HqnW5zNWbiO14lCNHDhuMdj0UyC8OYhgYB3vwdKXjh8TwfXwqW
 zzWKSeQVfOYIoBhIbvzBKrCnY6uiAI9T7uyNDzRw62S0Jex/0DjiyVwiqqqrxOISHNut
 UP1n81mqAOVmNkInbCrQJs/EA00g9IvngF/WoCbThdlC16uc/XPSzANiZdV+Is//QYD2
 vWrRe6z7QO3/w5+Ek1tzAyHh02MvkTCpdYs3XrtfNfZ5WvxLmCcMvI7cekLYfCHmExmR
 48uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709040812; x=1709645612;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uwmzSpK9oNER9eZ+AlpbFKclBhof2k/XtIYq2ahmcKc=;
 b=v/EmazjdlDMQ5PCFGgN9wmgO0OCHBocyVQYnlybpAT1Nc+8iyCRKSvJkmg3ND96WQ6
 a4wsUfxsu0lrAR+486GbJF5Lahk2t6hkSuILudPvtG+LpUZ2BbzU03gX0fOXI9rk3SMj
 CEL6cKqvL2Lnuh56nkkqekNhn1wqJBiJlTl7ff+z1966HiZHy54qI5nRAz7aORCMrYJM
 t85mLyitBZoZvJiH+u7ZdQE+ge4Z7CthOWn65QYnEDXjbPlUq5Fra2SD9eHCBYgOM5Kp
 0y/RscFu0HdVceH/A1SbwkShL3CM36FuPIqzpkkgeTsV2ieqtFEE9oO9TVfztKmByTDX
 fXKg==
X-Gm-Message-State: AOJu0YxH0iKk1b6GAPw2z/fGoZjk8jlkMAEjfgfD7tVgsW+AGXwlwIvV
 yR29y8YKdI56MXdgvUVktX8pDMDqKBmDIyZKKRJZB798dH/CaTWdVlhVc4Q1KO0uLHfJu1ORKBc
 8
X-Google-Smtp-Source: AGHT+IGnThLkHMNbvd4rChdwA0Nj5v6kJE7b/A7I+quyDRI0zwL6w+nqdDsmJtriwgwVQoq7rlYwMQ==
X-Received: by 2002:a5d:526a:0:b0:33d:f3c4:6002 with SMTP id
 l10-20020a5d526a000000b0033df3c46002mr941875wrc.1.1709040812214; 
 Tue, 27 Feb 2024 05:33:32 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 i13-20020adfe48d000000b0033ae7d768b2sm11319552wrm.117.2024.02.27.05.33.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Feb 2024 05:33:32 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 32/45] hw/arm: Add memory region for BCM2837 RPiVid ASB
Date: Tue, 27 Feb 2024 13:33:01 +0000
Message-Id: <20240227133314.1721857-33-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240227133314.1721857-1-peter.maydell@linaro.org>
References: <20240227133314.1721857-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Sergey Kambalin <serg.oker@gmail.com>

Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20240226000259.2752893-13-sergey.kambalin@auriga.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/bcm2838_peripherals.h | 2 ++
 include/hw/arm/raspi_platform.h      | 2 +-
 hw/arm/bcm2838_peripherals.c         | 3 +++
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/hw/arm/bcm2838_peripherals.h b/include/hw/arm/bcm2838_peripherals.h
index 86b0d96944e..af085934c92 100644
--- a/include/hw/arm/bcm2838_peripherals.h
+++ b/include/hw/arm/bcm2838_peripherals.h
@@ -69,6 +69,8 @@ struct BCM2838PeripheralState {
     OrIRQState mmc_irq_orgate;
     OrIRQState dma_7_8_irq_orgate;
     OrIRQState dma_9_10_irq_orgate;
+
+    UnimplementedDeviceState asb;
 };
 
 struct BCM2838PeripheralClass {
diff --git a/include/hw/arm/raspi_platform.h b/include/hw/arm/raspi_platform.h
index 0db146e5920..7bc4807fa51 100644
--- a/include/hw/arm/raspi_platform.h
+++ b/include/hw/arm/raspi_platform.h
@@ -73,7 +73,7 @@ uint64_t board_ram_size(uint32_t board_rev);
 #define MPHI_OFFSET             0x6000   /* Message-based Parallel Host Intf. */
 #define DMA_OFFSET              0x7000   /* DMA controller, channels 0-14 */
 #define ARBA_OFFSET             0x9000
-#define BRDG_OFFSET             0xa000
+#define BRDG_OFFSET             0xa000   /* RPiVid ASB for BCM2838 (BCM2711) */
 #define ARM_OFFSET              0xB000   /* ARM control block */
 #define ARMCTRL_OFFSET          (ARM_OFFSET + 0x000)
 #define ARMCTRL_IC_OFFSET       (ARM_OFFSET + 0x200) /* Interrupt controller */
diff --git a/hw/arm/bcm2838_peripherals.c b/hw/arm/bcm2838_peripherals.c
index 55ae56733f4..ca2f37b2606 100644
--- a/hw/arm/bcm2838_peripherals.c
+++ b/hw/arm/bcm2838_peripherals.c
@@ -185,6 +185,9 @@ static void bcm2838_peripherals_realize(DeviceState *dev, Error **errp)
         sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->gpio), 0));
 
     object_property_add_alias(OBJECT(s), "sd-bus", OBJECT(&s->gpio), "sd-bus");
+
+    /* BCM2838 RPiVid ASB must be mapped to prevent kernel crash */
+    create_unimp(s_base, &s->asb, "bcm2838-asb", BRDG_OFFSET, 0x24);
 }
 
 static void bcm2838_peripherals_class_init(ObjectClass *oc, void *data)
-- 
2.34.1


