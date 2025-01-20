Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97879C02185
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2025 20:39:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZyXB-0003sH-Ak; Mon, 20 Jan 2025 15:38:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tZyX9-0003qx-27; Mon, 20 Jan 2025 15:38:07 -0500
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tZyX7-0002Uh-0n; Mon, 20 Jan 2025 15:38:06 -0500
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5d4e2aa7ea9so9081690a12.2; 
 Mon, 20 Jan 2025 12:38:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737405482; x=1738010282; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KLFvPUTEzHTRcs1H1wLeCy8ZFAju0z66oOeORou2OaM=;
 b=nQT2d1L6xylXvUys3CCUUwlkQmHV8Zsi42QYAfioXZlka5n+UTXrO3xPmY2ZTFKkpJ
 QOkJwJ83i3nrEKvOZ+RLiK8zPEVsPcr71kFOLU/LUo/bUCslCoyOQPQs9X41NhOKOxMW
 fYV085LN85HoEmi5LKs9vrL7xTm9jBR1q8Gqid/JoqcUTTaruKgFIhOB7NcvsTgpiBN7
 /lL0zBppc/hunh2PjX+cNmCsHDIyHGv7mmH8iK8ZQp4sm3i/05Q7KAP2tYgmmPRtvT+d
 ffBwL/hfNSDWiuLyelOVpdrYh+6aUQhZkQvmIHx4kg9KesiUqLGfwjUaKW/QksI1b9cM
 0QXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737405482; x=1738010282;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KLFvPUTEzHTRcs1H1wLeCy8ZFAju0z66oOeORou2OaM=;
 b=PaacGHKPEmNswOi8Zu3SASktYN55KHees7fsiy6Wk0SMrdFLVPD9frUh+IcK88aw/1
 LIYg4OsUID8OxEuCMme2JmX+Mutq41Gh7vl39MIyXloLxwrOGaadIsCt8+l3MF/8gIFc
 ESMDlC5OGH9IJcBzYvNBHvRDRUaKgSvkLpthAiC0coMLreAC0YRgIGjhIq/oOueYXFEC
 MoSGJSYBVc7kGvsTD5zkqOe1D2BXaDs4MNnk/d61aouwKGLsTQ7LADSAwBoOAvOBZsna
 +sYb+VdXbdZqTZVGG70znd/L4ZnA8iUm0kX38ZBjQkqI6I2pmdCKW9LSOYcZvFRdcy6b
 U5sA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUNw/XoyHT0euMdLH57QYnV4jGAYvAedEaUCi2TgYPoqqrOGjHPOdqQwBMsaN5yZAezxaMJIVSVjw==@nongnu.org
X-Gm-Message-State: AOJu0Yy98cyacqqKZe8nf+SBGLeRkMQH4jIjiB2q0sC2p2rn+IqUQo/w
 srf5AOB82QO+S59FIIj8IoVJmfT6kXcIAMipBj3Z2lblZ1K3sgnU9IoyTEYD
X-Gm-Gg: ASbGnctaPz6JOV/mPO8qktfwd5m/tbLCmz/x683jYiiV/IJC8Ftp1A5VZyadvO5QeWj
 X2oW0H/MS1swE5X8fkJZgHr0okix5VdDRdJkeA7KAmYCPI7cjzGJ7kW8AkFMvjvYPrgVlxMKLmn
 ipil3iacwhDUJOpYX/PZzqY3jpKeLicqhlg784+g4fn4Wg6NPZhWfmGzU9eskqLEKE5C26PVbT1
 Yi0hdSoap9D9dCU+KYuBQmy8eMFArG+unVVNiykeEOkcb8BgA8UTd/8g5iVRC3hsCaQcLwln8Kp
 mHnovnibOLnWGzetEupUtdy6SMk+VU5GcFfWRjtiBAIUnXR0YwMGw4GH+cLS
X-Google-Smtp-Source: AGHT+IHLnUCoF89QuorRxWGtfqVOzMLnYXntqR9WWd3jOG44qRwSgD2jGyYt/5WVjK9euI2wKOn3Bg==
X-Received: by 2002:a05:6402:3590:b0:5db:67a7:e75c with SMTP id
 4fb4d7f45d1cf-5db7d2e87fcmr13205897a12.1.1737405481928; 
 Mon, 20 Jan 2025 12:38:01 -0800 (PST)
Received: from Provence.localdomain
 (dynamic-077-183-181-102.77.183.pool.telefonica.de. [77.183.181.102])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5db7364258csm6021077a12.1.2025.01.20.12.38.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2025 12:38:00 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-arm@nongnu.org,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 03/21] hw/pci-host/designware: Expose MSI IRQ
Date: Mon, 20 Jan 2025 21:37:30 +0100
Message-ID: <20250120203748.4687-4-shentey@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250120203748.4687-1-shentey@gmail.com>
References: <20250120203748.4687-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x533.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Fixes INTD and MSI interrupts poking the same IRQ line without keeping track of
each other's IRQ level. Furthermore, SoCs such as the i.MX 8M Plus don't share
the MSI IRQ with the INTx lines, so expose it as a dedicated pin.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 include/hw/arm/fsl-imx6.h        |  4 +++-
 include/hw/arm/fsl-imx7.h        |  4 +++-
 include/hw/pci-host/designware.h |  1 +
 hw/arm/fsl-imx6.c                | 13 ++++++++++++-
 hw/arm/fsl-imx7.c                | 13 ++++++++++++-
 hw/pci-host/designware.c         |  7 +++----
 hw/arm/Kconfig                   |  2 ++
 7 files changed, 36 insertions(+), 8 deletions(-)

diff --git a/include/hw/arm/fsl-imx6.h b/include/hw/arm/fsl-imx6.h
index 61c593ffd2..9da32fc189 100644
--- a/include/hw/arm/fsl-imx6.h
+++ b/include/hw/arm/fsl-imx6.h
@@ -33,6 +33,7 @@
 #include "hw/usb/chipidea.h"
 #include "hw/usb/imx-usb-phy.h"
 #include "hw/pci-host/designware.h"
+#include "hw/or-irq.h"
 #include "exec/memory.h"
 #include "cpu.h"
 #include "qom/object.h"
@@ -73,6 +74,7 @@ struct FslIMX6State {
     ChipideaState      usb[FSL_IMX6_NUM_USBS];
     IMXFECState        eth;
     DesignwarePCIEHost pcie;
+    OrIRQState         pcie4_msi_irq;
     MemoryRegion       rom;
     MemoryRegion       caam;
     MemoryRegion       ocram;
@@ -457,7 +459,7 @@ struct FslIMX6State {
 #define FSL_IMX6_PCIE1_IRQ 120
 #define FSL_IMX6_PCIE2_IRQ 121
 #define FSL_IMX6_PCIE3_IRQ 122
-#define FSL_IMX6_PCIE4_IRQ 123
+#define FSL_IMX6_PCIE4_MSI_IRQ 123
 #define FSL_IMX6_DCIC1_IRQ 124
 #define FSL_IMX6_DCIC2_IRQ 125
 #define FSL_IMX6_MLB150_HIGH_IRQ 126
diff --git a/include/hw/arm/fsl-imx7.h b/include/hw/arm/fsl-imx7.h
index 411fa1c2e3..aa7818c499 100644
--- a/include/hw/arm/fsl-imx7.h
+++ b/include/hw/arm/fsl-imx7.h
@@ -36,6 +36,7 @@
 #include "hw/net/imx_fec.h"
 #include "hw/pci-host/designware.h"
 #include "hw/usb/chipidea.h"
+#include "hw/or-irq.h"
 #include "cpu.h"
 #include "qom/object.h"
 #include "qemu/units.h"
@@ -85,6 +86,7 @@ struct FslIMX7State {
     IMX7GPRState       gpr;
     ChipideaState      usb[FSL_IMX7_NUM_USBS];
     DesignwarePCIEHost pcie;
+    OrIRQState         pcie4_msi_irq;
     MemoryRegion       rom;
     MemoryRegion       caam;
     MemoryRegion       ocram;
@@ -428,7 +430,7 @@ enum FslIMX7IRQs {
     FSL_IMX7_PCI_INTA_IRQ = 125,
     FSL_IMX7_PCI_INTB_IRQ = 124,
     FSL_IMX7_PCI_INTC_IRQ = 123,
-    FSL_IMX7_PCI_INTD_IRQ = 122,
+    FSL_IMX7_PCI_INTD_MSI_IRQ = 122,
 
     FSL_IMX7_UART7_IRQ    = 126,
 
diff --git a/include/hw/pci-host/designware.h b/include/hw/pci-host/designware.h
index c484e377a8..bf8b278978 100644
--- a/include/hw/pci-host/designware.h
+++ b/include/hw/pci-host/designware.h
@@ -86,6 +86,7 @@ struct DesignwarePCIEHost {
         MemoryRegion io;
 
         qemu_irq     irqs[4];
+        qemu_irq     msi;
     } pci;
 
     MemoryRegion mmio;
diff --git a/hw/arm/fsl-imx6.c b/hw/arm/fsl-imx6.c
index ac8c66e242..88b9ccff49 100644
--- a/hw/arm/fsl-imx6.c
+++ b/hw/arm/fsl-imx6.c
@@ -106,6 +106,8 @@ static void fsl_imx6_init(Object *obj)
     object_initialize_child(obj, "eth", &s->eth, TYPE_IMX_ENET);
 
     object_initialize_child(obj, "pcie", &s->pcie, TYPE_DESIGNWARE_PCIE_HOST);
+    object_initialize_child(obj, "pcie4-msi-irq", &s->pcie4_msi_irq,
+                            TYPE_OR_IRQ);
 }
 
 static void fsl_imx6_realize(DeviceState *dev, Error **errp)
@@ -435,14 +437,23 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
     sysbus_realize(SYS_BUS_DEVICE(&s->pcie), &error_abort);
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->pcie), 0, FSL_IMX6_PCIe_REG_ADDR);
 
+    object_property_set_int(OBJECT(&s->pcie4_msi_irq), "num-lines", 2,
+                            &error_abort);
+    qdev_realize(DEVICE(&s->pcie4_msi_irq), NULL, &error_abort);
+
+    irq = qdev_get_gpio_in(DEVICE(&s->a9mpcore), FSL_IMX6_PCIE4_MSI_IRQ);
+    qdev_connect_gpio_out(DEVICE(&s->pcie4_msi_irq), 0, irq);
+
     irq = qdev_get_gpio_in(DEVICE(&s->a9mpcore), FSL_IMX6_PCIE1_IRQ);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->pcie), 0, irq);
     irq = qdev_get_gpio_in(DEVICE(&s->a9mpcore), FSL_IMX6_PCIE2_IRQ);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->pcie), 1, irq);
     irq = qdev_get_gpio_in(DEVICE(&s->a9mpcore), FSL_IMX6_PCIE3_IRQ);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->pcie), 2, irq);
-    irq = qdev_get_gpio_in(DEVICE(&s->a9mpcore), FSL_IMX6_PCIE4_IRQ);
+    irq = qdev_get_gpio_in(DEVICE(&s->pcie4_msi_irq), 0);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->pcie), 3, irq);
+    irq = qdev_get_gpio_in(DEVICE(&s->pcie4_msi_irq), 1);
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->pcie), 4, irq);
 
     /*
      * PCIe PHY
diff --git a/hw/arm/fsl-imx7.c b/hw/arm/fsl-imx7.c
index 05e3389fbe..004bf49937 100644
--- a/hw/arm/fsl-imx7.c
+++ b/hw/arm/fsl-imx7.c
@@ -150,6 +150,8 @@ static void fsl_imx7_init(Object *obj)
      * PCIE
      */
     object_initialize_child(obj, "pcie", &s->pcie, TYPE_DESIGNWARE_PCIE_HOST);
+    object_initialize_child(obj, "pcie4-msi-irq", &s->pcie4_msi_irq,
+                            TYPE_OR_IRQ);
 
     /*
      * USBs
@@ -597,14 +599,23 @@ static void fsl_imx7_realize(DeviceState *dev, Error **errp)
     sysbus_realize(SYS_BUS_DEVICE(&s->pcie), &error_abort);
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->pcie), 0, FSL_IMX7_PCIE_REG_ADDR);
 
+    object_property_set_int(OBJECT(&s->pcie4_msi_irq), "num-lines", 2,
+                            &error_abort);
+    qdev_realize(DEVICE(&s->pcie4_msi_irq), NULL, &error_abort);
+
+    irq = qdev_get_gpio_in(DEVICE(&s->a7mpcore), FSL_IMX7_PCI_INTD_MSI_IRQ);
+    qdev_connect_gpio_out(DEVICE(&s->pcie4_msi_irq), 0, irq);
+
     irq = qdev_get_gpio_in(DEVICE(&s->a7mpcore), FSL_IMX7_PCI_INTA_IRQ);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->pcie), 0, irq);
     irq = qdev_get_gpio_in(DEVICE(&s->a7mpcore), FSL_IMX7_PCI_INTB_IRQ);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->pcie), 1, irq);
     irq = qdev_get_gpio_in(DEVICE(&s->a7mpcore), FSL_IMX7_PCI_INTC_IRQ);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->pcie), 2, irq);
-    irq = qdev_get_gpio_in(DEVICE(&s->a7mpcore), FSL_IMX7_PCI_INTD_IRQ);
+    irq = qdev_get_gpio_in(DEVICE(&s->pcie4_msi_irq), 0);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->pcie), 3, irq);
+    irq = qdev_get_gpio_in(DEVICE(&s->pcie4_msi_irq), 1);
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->pcie), 4, irq);
 
     /*
      * USBs
diff --git a/hw/pci-host/designware.c b/hw/pci-host/designware.c
index c3fc37b904..3e8c36e6a7 100644
--- a/hw/pci-host/designware.c
+++ b/hw/pci-host/designware.c
@@ -55,8 +55,6 @@
 #define DESIGNWARE_PCIE_ATU_DEVFN(x)               (((x) >> 16) & 0xff)
 #define DESIGNWARE_PCIE_ATU_UPPER_TARGET           0x91C
 
-#define DESIGNWARE_PCIE_IRQ_MSI                    3
-
 static DesignwarePCIEHost *
 designware_pcie_root_to_host(DesignwarePCIERoot *root)
 {
@@ -90,7 +88,7 @@ static void designware_pcie_root_msi_write(void *opaque, hwaddr addr,
     root->msi.intr[0].status |= BIT(val) & root->msi.intr[0].enable;
 
     if (root->msi.intr[0].status & ~root->msi.intr[0].mask) {
-        qemu_set_irq(host->pci.irqs[DESIGNWARE_PCIE_IRQ_MSI], 1);
+        qemu_set_irq(host->pci.msi, 1);
     }
 }
 
@@ -335,7 +333,7 @@ static void designware_pcie_root_config_write(PCIDevice *d, uint32_t address,
     case DESIGNWARE_PCIE_MSI_INTR0_STATUS:
         root->msi.intr[0].status ^= val;
         if (!root->msi.intr[0].status) {
-            qemu_set_irq(host->pci.irqs[DESIGNWARE_PCIE_IRQ_MSI], 0);
+            qemu_set_irq(host->pci.msi, 0);
         }
         break;
 
@@ -680,6 +678,7 @@ static void designware_pcie_host_realize(DeviceState *dev, Error **errp)
     for (i = 0; i < ARRAY_SIZE(s->pci.irqs); i++) {
         sysbus_init_irq(sbd, &s->pci.irqs[i]);
     }
+    sysbus_init_irq(sbd, &s->pci.msi);
 
     memory_region_init_io(&s->mmio,
                           OBJECT(s),
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index e779b5af95..fe47e259b8 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -513,6 +513,7 @@ config FSL_IMX6
     select IMX_I2C
     select IMX_USBPHY
     select WDT_IMX2
+    select OR_IRQ
     select PL310  # cache controller
     select PCI_EXPRESS_DESIGNWARE
     select SDHCI
@@ -571,6 +572,7 @@ config FSL_IMX7
     select IMX_FEC
     select IMX_I2C
     select WDT_IMX2
+    select OR_IRQ
     select PCI_EXPRESS_DESIGNWARE
     select SDHCI
     select UNIMP
-- 
2.48.1


