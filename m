Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76324C531C9
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jul 2026 01:27:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnRA6-0004yw-9T; Fri, 24 Jul 2026 21:26:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcelomanzo@gmail.com>)
 id 1wnRA5-0004y8-1o
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 21:26:45 -0400
Received: from mail-ua1-x932.google.com ([2607:f8b0:4864:20::932])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcelomanzo@gmail.com>)
 id 1wnRA2-0006FU-UV
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 21:26:44 -0400
Received: by mail-ua1-x932.google.com with SMTP id
 a1e0cc1a2514c-96935063700so591126241.0
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 18:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784942802; x=1785547602; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+yMeDOMb0pwkug1K7IkktsL81hktue6I1jYBC2y5MTY=;
 b=a8HbTCzk9cmMAng0eztf/glTgkVBj79Gwp2J3pv9Td+juPEfwqOfjtBCYtrvF1d/gi
 u/DtuwH+PtpnMpjg/AuUXziET17N/jWAiPQcE11hYI/bDtt4YC/8OFt+MrPNzc8NgK/N
 nXdi4M0YpFuzFhyX3ZiXCPN2goldlQbR3EAp9SeMkRxp6tJWF04tdVDloANCYCgwU18I
 3a4a6s/jqFDtT4cZU9DrOUG7rBcLTTGFH2hsndibnUt1zLBYMh0bj2vAmf4Tz4fqWI3i
 SVDS6+SfFURB3NTE2ejoCD03n0wG3yQLjvmx5tWVmsKWHcskSdzSxESMfEgPKClWn4OM
 kVZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784942802; x=1785547602;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=+yMeDOMb0pwkug1K7IkktsL81hktue6I1jYBC2y5MTY=;
 b=JU7N8XgJ4XNyGvL4tknca9DLPQC7746QfHlwxG1xydUPt5lLcddgsopB1lpjA+MMIs
 EaAeBx0CdpCNBYrt9vSMCCy62ojBLSUwi806he3K71P5YWUX0hJZorN266VIMmE58nD4
 jJQ0+QlPzLGWG8aPWz1PZuTxy77ARA/yjyaukD5r43znALTWqv65ElGKSH590UeNmIiY
 QrClMkSi2LZRUsbH+LhMDH+TIBBf8fUF6G7+faWoaD0qpyAFS1E7hamEaX1isUHvds9O
 ZF0d7uaCTNj50fmOnc2RPRolUtvd8MII2EKIONXx5PTJ4DLQ1qm+hiHTjIgqBW9v7156
 OeMw==
X-Gm-Message-State: AOJu0YyCDEWL9pj4qHPFkAfBj0vakMCJCo6jvtWAFjBVINr4f5TE/P0z
 JwgQPb8yX1q8StoShNEXV+Pv8pANwQl1TeXrx3vLCUG/Q+ravq+vDKtc+IDqPt33
X-Gm-Gg: AR+sD10TJy28NTPNMlyUmeG+/C+BIk1HjebOF9iecdcrKMGSLTyn3Tj8e8oo2NzISBK
 6Wb663i6bjZpXueNq7D2o8SzhfcgfdqdrywV61EzGqriJqpCKYwvE/yCvtSfM61n1JHNtd8W+jo
 XM1GQ0KXM3wafdaC9JJaFB9E5WdreU1dEWAJpGpGmc6aoXl/sx3P3LjZO+62bhWs+hd5jCv4/lG
 Z7R1ueNhT7dLiJqp2IlTG+xEh36fQwG1u2VtehLNyA2ZuOA5jNFTTT8aoQyQEN4WS6n1qLXbJuw
 6RyBSY62DWkGKhe1qDa08uRu2069P/XFdmvRbkRB2UlH4tbLzCUdKHmsDzmEHG3MREqPQ9udD9W
 J99g23k7Se/AcG/1ptQiZXtBrcV88ZaxTC/OBa1BEIt7IoVo3ELN3c3D7UzJ5Q0Mh+sTheaUCn2
 tFVaCcAJh1bQm6ZcSTl7V7qeaXgNMQ2P+QD/fVbO5Lbjg=
X-Received: by 2002:a05:6102:f86:b0:6c5:d55d:c093 with SMTP id
 ada2fe7eead31-7503e66dbe3mr802868137.8.1784942801771; 
 Fri, 24 Jul 2026 18:26:41 -0700 (PDT)
Received: from localhost.localdomain ([146.71.8.128])
 by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-97774c388d7sm1092856241.1.2026.07.24.18.26.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 24 Jul 2026 18:26:41 -0700 (PDT)
From: Marcelo Manzo <marcelomanzo@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Sergey Kambalin <sergey.kambalin@auriga.com>,
 Marcelo Manzo <marcelomanzo@gmail.com>
Subject: [PATCH 2/5] hw/arm/bcm2838: enable BCM2838 RNG200
Date: Fri, 24 Jul 2026 21:26:32 -0400
Message-ID: <20260725012635.4925-3-marcelomanzo@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260725012635.4925-1-marcelomanzo@gmail.com>
References: <20260725012635.4925-1-marcelomanzo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::932;
 envelope-from=marcelomanzo@gmail.com; helo=mail-ua1-x932.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Wire the BCM2838 RNG200 device (added in the previous patch) into
the SoC: instantiate it in the peripherals block, map its register
region at the real BCM2711 physical address, and connect its
interrupt through both the GIC and the legacy GPU interrupt
controller path (matching how the device's own realize() wires it,
mirroring the pattern used for the older BCM2835 RNG on raspi0-3).
Also stop raspi4b from masking out the "brcm,bcm2711-rng200"
device-tree node, now that the controller it describes is actually
implemented.

Adapted from patch 16/41 of Sergey Kambalin's Raspberry Pi 4B series
(patchwork series 829638) against current QEMU master.

Signed-off-by: Marcelo Manzo <marcelomanzo@gmail.com>
---
 hw/arm/bcm2838.c                     |  4 ++++
 hw/arm/bcm2838_peripherals.c         | 17 +++++++++++++++++
 hw/arm/raspi4b.c                     |  1 -
 include/hw/arm/bcm2838_peripherals.h |  2 ++
 4 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/hw/arm/bcm2838.c b/hw/arm/bcm2838.c
index f47b96c3..9d96dc11 100644
--- a/hw/arm/bcm2838.c
+++ b/hw/arm/bcm2838.c
@@ -209,6 +209,10 @@ static void bcm2838_realize(DeviceState *dev, Error **errp)
     sysbus_connect_irq(SYS_BUS_DEVICE(&ps_base->dwc2), 0,
                        qdev_get_gpio_in(gicdev, GIC_SPI_INTERRUPT_DWC2));
 
+    /* Connect RNG200 to the interrupt controller */
+    sysbus_connect_irq(SYS_BUS_DEVICE(&ps->rng200), 0,
+                       qdev_get_gpio_in(gicdev, GIC_SPI_INTERRUPT_RNG200));
+
     /* Connect DMA 0-6 to the interrupt controller */
     for (int n = GIC_SPI_INTERRUPT_DMA_0; n <= GIC_SPI_INTERRUPT_DMA_6; n++) {
         sysbus_connect_irq(SYS_BUS_DEVICE(&ps_base->dma),
diff --git a/hw/arm/bcm2838_peripherals.c b/hw/arm/bcm2838_peripherals.c
index de49f48b..7c202b00 100644
--- a/hw/arm/bcm2838_peripherals.c
+++ b/hw/arm/bcm2838_peripherals.c
@@ -40,6 +40,9 @@ static void bcm2838_peripherals_init(Object *obj)
     /* Extended Mass Media Controller 2 */
     object_initialize_child(obj, "emmc2", &s->emmc2, TYPE_SYSBUS_SDHCI);
 
+    /* Random Number Generator */
+    object_initialize_child(obj, "rng200", &s->rng200, TYPE_BCM2838_RNG200);
+
     /* PCIe Host Bridge */
     object_initialize_child(obj, "pcie-host", &s->pcie_host,
                             TYPE_BCM2838_PCIE_HOST);
@@ -82,6 +85,8 @@ static void bcm2838_peripherals_realize(DeviceState *dev, Error **errp)
     BCMSocPeripheralBaseState *s_base = BCM_SOC_PERIPHERALS_BASE(dev);
     MemoryRegion *regs_mr;
     MemoryRegion *mmio_mr;
+    MemoryRegion *rng200_mr;
+    qemu_irq rng_200_irq;
     int n;
 
     bcm_soc_peripherals_common_realize(dev, errp);
@@ -94,6 +99,18 @@ static void bcm2838_peripherals_realize(DeviceState *dev, Error **errp)
                                         BCM2838_VC_PERI_LOW_BASE,
                                         &s->peri_low_mr_alias, 1);
 
+    /* Random Number Generator */
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->rng200), errp)) {
+        return;
+    }
+
+    rng200_mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->rng200), 0);
+    memory_region_add_subregion(&s_base->peri_mr, RNG_OFFSET, rng200_mr);
+
+    rng_200_irq = qdev_get_gpio_in_named(DEVICE(&s_base->ic),
+                                         BCM2835_IC_GPU_IRQ, INTERRUPT_RNG);
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->rng200), 0, rng_200_irq);
+
     /* Extended Mass Media Controller 2 */
     object_property_set_uint(OBJECT(&s->emmc2), "sd-spec-version", 3,
                              &error_abort);
diff --git a/hw/arm/raspi4b.c b/hw/arm/raspi4b.c
index 79f60932..1c063a1c 100644
--- a/hw/arm/raspi4b.c
+++ b/hw/arm/raspi4b.c
@@ -64,7 +64,6 @@ static void raspi4_modify_dtb(const struct arm_boot_info *info, void *fdt)
 
     /* Temporarily disable following devices until they are implemented */
     const char *nodes_to_remove[] = {
-        "brcm,bcm2711-rng200",
         "brcm,bcm2711-thermal",
     };
 
diff --git a/include/hw/arm/bcm2838_peripherals.h b/include/hw/arm/bcm2838_peripherals.h
index 5da340f2..52eabf67 100644
--- a/include/hw/arm/bcm2838_peripherals.h
+++ b/include/hw/arm/bcm2838_peripherals.h
@@ -10,6 +10,7 @@
 #define BCM2838_PERIPHERALS_H
 
 #include "hw/arm/bcm2835_peripherals.h"
+#include "hw/misc/bcm2838_rng200.h"
 #include "hw/arm/bcm2838_pcie.h"
 #include "hw/net/bcm2838_genet.h"
 #include "hw/sd/sdhci.h"
@@ -68,6 +69,7 @@ struct BCM2838PeripheralState {
     MemoryRegion peri_low_mr_alias;
     MemoryRegion mphi_mr_alias;
 
+    BCM2838Rng200State rng200;
     SDHCIState emmc2;
     BCM2838PcieHostState pcie_host;
     BCM2838GenetState genet;
-- 
2.47.1


