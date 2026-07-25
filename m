Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35DEAC531FC
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jul 2026 01:04:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnQmp-00021z-4v; Fri, 24 Jul 2026 21:02:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcelomanzo@gmail.com>)
 id 1wnQTD-0006uz-Qc
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 20:42:27 -0400
Received: from mail-ua1-x92b.google.com ([2607:f8b0:4864:20::92b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcelomanzo@gmail.com>)
 id 1wnQTC-0000mK-0t
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 20:42:27 -0400
Received: by mail-ua1-x92b.google.com with SMTP id
 a1e0cc1a2514c-9770e900464so722814241.0
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 17:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784940145; x=1785544945; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/ZpwvqzsmTV5HSzyBuGagGo6j+vN1oaZHeXOF2t6KiU=;
 b=Sy1ylTWz+6JLLKoTksZsmX2xN9eEiyhRetoSY0o0aH2+BCEQ10k7gtOfXif0hdThRH
 YUlkQYAC3hDNXiMZcPvBjyObik62acPoMeIaak9qkfPa4/QN6Ea67OBfMjwNF1WFKAGz
 IogCqLrHrgPRA0zxHfLoz/fnqtPNkdmJuQnVciUo+UKORIUJ2lNvw6YlxNcqzzOy8nSt
 bAcLAhUFb1MChHNKXWp3dMxeDFJIKoUWG3Z5podhl6fNbBhFGsKQtiDtv4g0Oz3yfI2l
 N/EE+uf+rb9goppOWGJ9QUaABFvHJybRhaBLCo5sG7W+hwGn/pBkEEUB6gSEMv2pjY08
 rK3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784940145; x=1785544945;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=/ZpwvqzsmTV5HSzyBuGagGo6j+vN1oaZHeXOF2t6KiU=;
 b=kI4RlIPmYW4xEzmmFJf2XdhDoBf/iCqi/G2t0HVmswrwazWvEtl6oDnVZIUiVM+wRh
 zLBhAiUBW9+wztgo3+PaGK67V06FoJeD11XKIZ77VKV09fYQZ3mR7JjNf9d+v0hyASmC
 rE+IAgCAP6ZjOk1pbyZ8wEccAiKvq4vsWiaH7U44HI7w0cpgegEXc8d8FCbPtOuCLgkQ
 aQla7KLqr8i/MHdhf624GSVWzc7l8QW5n92JKIry6Tnhy1VOPXdTloy/Xvbl/KkBec46
 s1jjTfCvn7NoRIYSKduXeFG+be0JxPr57pYL04VrXimRbr72znRyAzl5xh3vAvWmXLUs
 lzYg==
X-Gm-Message-State: AOJu0YwPyJufL37t5qireojc3kjRboogP4ERHWkn6l2c7h1RqgnYnnnc
 +53LxBNUo3Kv60n6MMAyxotLD0xdPlAbIjRo9ABWcGJLBPZM0DbwhnAwa/Pc6j8j
X-Gm-Gg: AR+sD11hycgoNUmc5pXq4aO0/JIljCeWgKX6LgVFMyKvOiQ0fMe5JmtjAzEOzVLZju3
 uRcIW+Z4Bo/IHRBbZbkDggdK0Ol5oVCJQrE+FcUT3UTMog05Xg3LI2DUPR0kfZ4JB2mTqNUQMBO
 yEiEKA2i1C/AzfvOIUGOqryk6l0nUNxGe3lJ+SQC94b3v51KHN0rlMZZStakD1ZtQ2mB8/XD4mm
 xsKTyFTX5lVs1dQZXR6/l2NR/HimtELEoGiTLHXP4h1fvHHR4j1Bihn6jsbZg80WYOkRET9KMRe
 VD60Lf1Z0s6uSuTjtRs9nJmyHc0Dd6b6HawUHFd5eBxEfgXHTcZrtFSKg1kNpqG8NOk4oY4FJbD
 rET7wBHqkYh6dC8QFB4Z1+5ugQyEjKsxQIzq9dG1JI/mMMkml3PPDiO5FBZtyo39dI7nkoKIU/0
 pJyFhA5+rfiFEXOUqtu9az7Mb4jLvfhc5m
X-Received: by 2002:a05:6102:1629:b0:73e:e4ab:1c84 with SMTP id
 ada2fe7eead31-75049b36993mr562527137.5.1784940144846; 
 Fri, 24 Jul 2026 17:42:24 -0700 (PDT)
Received: from localhost.localdomain ([146.71.8.128])
 by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-97774f12690sm930591241.12.2026.07.24.17.42.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 24 Jul 2026 17:42:24 -0700 (PDT)
From: Marcelo Manzo <marcelomanzo@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Jason Wang <jasowangio@gmail.com>,
 Sergey Kambalin <sergey.kambalin@auriga.com>,
 Marcelo Manzo <marcelomanzo@gmail.com>
Subject: [PATCH 03/19] hw/arm/bcm2838: enable BCM2838 PCIe host bridge
Date: Fri, 24 Jul 2026 20:42:02 -0400
Message-ID: <20260725004219.66222-4-marcelomanzo@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260725004219.66222-1-marcelomanzo@gmail.com>
References: <20260725004219.66222-1-marcelomanzo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::92b;
 envelope-from=marcelomanzo@gmail.com; helo=mail-ua1-x92b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 24 Jul 2026 21:02:39 -0400
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

Wire the BCM2838 PCIe host bridge (added in the previous two
patches) into the SoC: instantiate it in the peripherals block, map
its register and MMIO regions at the real BCM2711 physical
addresses, and route its interrupts through the GIC. Also stop
raspi4b from masking out the "brcm,bcm2711-pcie" device-tree node,
now that the controller it describes is actually implemented.

Adapted from patches 14-15/41 of Sergey Kambalin's Raspberry Pi 4B
series (patchwork series 829638) against current QEMU master.

Signed-off-by: Marcelo Manzo <marcelomanzo@gmail.com>
---
 hw/arm/bcm2838.c                     |  9 +++++++++
 hw/arm/bcm2838_peripherals.c         | 23 +++++++++++++++++++++++
 hw/arm/raspi4b.c                     |  1 -
 include/hw/arm/bcm2838_peripherals.h |  2 ++
 4 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/hw/arm/bcm2838.c b/hw/arm/bcm2838.c
index 089af412..fc56f879 100644
--- a/hw/arm/bcm2838.c
+++ b/hw/arm/bcm2838.c
@@ -230,6 +230,15 @@ static void bcm2838_realize(DeviceState *dev, Error **errp)
     qdev_connect_gpio_out(dma_9_10_irq_orgate, 0,
                           qdev_get_gpio_in(gicdev, GIC_SPI_INTERRUPT_DMA_9_10));
 
+    /* Connect PCIe host bridge to the interrupt controller */
+    for (int n = 0; n < BCM2838_PCIE_NUM_IRQS; n++) {
+        int int_n = GIC_SPI_INTERRUPT_PCI_INT_A + n;
+        sysbus_connect_irq(SYS_BUS_DEVICE(&ps->pcie_host), n,
+                           qdev_get_gpio_in(gicdev, int_n));
+        bcm2838_pcie_host_set_irq_num(BCM2838_PCIE_HOST(&ps->pcie_host), n,
+                                      int_n);
+    }
+
     /* Pass through inbound GPIO lines to the GIC */
     qdev_init_gpio_in(dev, bcm2838_gic_set_irq, GIC_NUM_IRQS);
 
diff --git a/hw/arm/bcm2838_peripherals.c b/hw/arm/bcm2838_peripherals.c
index 812b5b84..f71937ae 100644
--- a/hw/arm/bcm2838_peripherals.c
+++ b/hw/arm/bcm2838_peripherals.c
@@ -15,6 +15,11 @@
 #define CLOCK_ISP_OFFSET        0xc11000
 #define CLOCK_ISP_SIZE          0x100
 
+#define PCIE_RC_OFFSET          0x1500000
+#define PCIE_MMIO_OFFSET        0xc0000000
+#define PCIE_MMIO_ARM_OFFSET    0x600000000
+#define PCIE_MMIO_SIZE          0x40000000
+
 /* Lower peripheral base address on the VC (GPU) system bus */
 #define BCM2838_VC_PERI_LOW_BASE 0x7c000000
 
@@ -35,6 +40,10 @@ static void bcm2838_peripherals_init(Object *obj)
     /* Extended Mass Media Controller 2 */
     object_initialize_child(obj, "emmc2", &s->emmc2, TYPE_SYSBUS_SDHCI);
 
+    /* PCIe Host Bridge */
+    object_initialize_child(obj, "pcie-host", &s->pcie_host,
+                            TYPE_BCM2838_PCIE_HOST);
+
     /* GPIO */
     object_initialize_child(obj, "gpio", &s->gpio, TYPE_BCM2838_GPIO);
 
@@ -67,6 +76,8 @@ static void bcm2838_peripherals_realize(DeviceState *dev, Error **errp)
     MemoryRegion *mphi_mr;
     BCM2838PeripheralState *s = BCM2838_PERIPHERALS(dev);
     BCMSocPeripheralBaseState *s_base = BCM_SOC_PERIPHERALS_BASE(dev);
+    MemoryRegion *regs_mr;
+    MemoryRegion *mmio_mr;
     int n;
 
     bcm_soc_peripherals_common_realize(dev, errp);
@@ -182,6 +193,18 @@ static void bcm2838_peripherals_realize(DeviceState *dev, Error **errp)
     create_unimp(s_base, &s->clkisp, "bcm2835-clkisp", CLOCK_ISP_OFFSET,
                  CLOCK_ISP_SIZE);
 
+    /* PCIe Root Complex */
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->pcie_host), errp)) {
+        return;
+    }
+    /* RC registers region */
+    regs_mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->pcie_host), 0);
+    memory_region_add_subregion(&s->peri_low_mr, PCIE_RC_OFFSET, regs_mr);
+    /* MMIO region */
+    mmio_mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->pcie_host), 1);
+    memory_region_add_subregion(get_system_memory(), PCIE_MMIO_ARM_OFFSET,
+                                mmio_mr);
+
     /* GPIO */
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->gpio), errp)) {
         return;
diff --git a/hw/arm/raspi4b.c b/hw/arm/raspi4b.c
index 06aeb8db..038eefb2 100644
--- a/hw/arm/raspi4b.c
+++ b/hw/arm/raspi4b.c
@@ -64,7 +64,6 @@ static void raspi4_modify_dtb(const struct arm_boot_info *info, void *fdt)
 
     /* Temporarily disable following devices until they are implemented */
     const char *nodes_to_remove[] = {
-        "brcm,bcm2711-pcie",
         "brcm,bcm2711-rng200",
         "brcm,bcm2711-thermal",
         "brcm,bcm2711-genet-v5",
diff --git a/include/hw/arm/bcm2838_peripherals.h b/include/hw/arm/bcm2838_peripherals.h
index 0be97e67..56c0c209 100644
--- a/include/hw/arm/bcm2838_peripherals.h
+++ b/include/hw/arm/bcm2838_peripherals.h
@@ -10,6 +10,7 @@
 #define BCM2838_PERIPHERALS_H
 
 #include "hw/arm/bcm2835_peripherals.h"
+#include "hw/arm/bcm2838_pcie.h"
 #include "hw/sd/sdhci.h"
 #include "hw/gpio/bcm2838_gpio.h"
 
@@ -65,6 +66,7 @@ struct BCM2838PeripheralState {
     MemoryRegion mphi_mr_alias;
 
     SDHCIState emmc2;
+    BCM2838PcieHostState pcie_host;
     BCM2838GpioState gpio;
 
     OrIRQState mmc_irq_orgate;
-- 
2.47.1


