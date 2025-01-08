Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB276E77199
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 09:28:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVSKk-00048f-AL; Wed, 08 Jan 2025 04:26:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tVSKA-0003wm-5O; Wed, 08 Jan 2025 04:26:03 -0500
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tVSK7-0004my-7p; Wed, 08 Jan 2025 04:26:01 -0500
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5d3f28a4fccso275202a12.2; 
 Wed, 08 Jan 2025 01:25:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736328357; x=1736933157; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PM/8KKqiIECK3XXxRS6QtoZVzE/WoFutF5vWyHTxbog=;
 b=E3s2C/YSMC57cm9wHOnA+w0zFhkHLlJMAX3jJlipyiw7xGGpDS1FZHZ14j/x3bq1iT
 YGGqB9bXJy+9YFBcSGlIkm1lsV1KGYYbydcIaqUNMZPbxqeeXoM/hexvjveeqIDSZsVb
 swzCyytGuCZISErkFnSW6aSdFwD1xI7FQr3hhCc+a7UvBl4A9Zbf2TG8mJLpk/GJhxD/
 AAtk8irF7AAyDBp/QU/kb/Kf9C1X63U4EX5dgIKjGbjl9MWFI8y1kUVmuRDlJOzMGybz
 fHkKS9RCGGS2PsXuJpZwpMzfzZAdcMZeO8a9wnMGdW9p93xfqY5XCqDg9gSjq9qcmq/V
 p5MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736328357; x=1736933157;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PM/8KKqiIECK3XXxRS6QtoZVzE/WoFutF5vWyHTxbog=;
 b=Jx9Ejv1oLYqJPYv4qgXoOubn3ex8PkRl8/B7lbgwr0ygfAHFb+Q+AkleWx4VcMieBX
 ORyWf3Rsiwn7OgdpBMZ7MraTd5lqjNHBAYwIGYeyvPu7ORZegU/MyfxHb+yZ2eTylM3m
 sSAQbnIPUOZ0WE9MiJuHRXQYW23enEx6jzrjGs/k8hpP7qqV0pqEMRFOM4pLRqz8uGIB
 GELREcLQ3nkhgq1GAZeHhk8TP/8hNxbN5dWpQPs7APvKrxDJ9LH5kh+D/EfdJBDHmDzL
 qRUAYlp/Ck11PyVL3I8R6Qxaz4JXVl8ciXC4O5WuTGroD8tjGWmPJThLk/s7iOqq71Oc
 BTtQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUmvs1HGaq4JoJBi+ZJLML8B10qXEqIVjWWA+HlpRc969zI0Z7/77PmppsLpUEn5xdZ72qthJKqKw==@nongnu.org,
 AJvYcCXLjKNkB77xgz1FPLow3m4JSxtWh7uciyVcH6oXUtvgZfc6pOyWTPAw+MwmFxn1CCqPbuCmsXNOUpQZ9Q==@nongnu.org
X-Gm-Message-State: AOJu0Yzx0EidvLbcp6DnWWWTT4VJ4FF//Aja0PiDkb/miCrTTLOI1v1V
 SwZmBwu9rfvfB71pwBFUz7MKLnI7f9HSacuzTjVGyWqOhZ7Ut3j3UXpVW1NP
X-Gm-Gg: ASbGnctVwB2oXkV6MiSdan08S+mLfEcuMjtfi8Y31yo4n3KyVWSB3jteOTGVi0Jhc0/
 ikMCgWy1+mSozZpR+PQYGmJLk/jWEWUdldEjlfc3rVgi0nTIVnpzeSk2hXsKzO/XbwcY6ggqW52
 ZnCW3lM4+8JYAM34224drbRONgdMCPm2554zm2jyepF/N5WdQrG8xrTAXeaHrYRfOVH4eJCEdc5
 JGHnn7MdB6+sdB/Gr3Ue5S67mpxXSN70wfbB0DEp8GlNH7O6UaVrVkiKBRLglGnxc+fLdrxpNNP
 26Me5fcymFHQ26XodNGe7WvdiLWa1dRcgI/cGEJ3ozz9NtE=
X-Google-Smtp-Source: AGHT+IEdakuCjej9EJUNxs5Luvib7CIxx+NApOKVQiJ6uXZvv42n2n5as6KF5OgF5UZGQKM4shwGmQ==
X-Received: by 2002:a05:6402:278f:b0:5d0:e63e:21c3 with SMTP id
 4fb4d7f45d1cf-5d972e085d7mr1620432a12.14.1736328356339; 
 Wed, 08 Jan 2025 01:25:56 -0800 (PST)
Received: from Provence.localdomain
 (dynamic-077-188-106-228.77.188.pool.telefonica.de. [77.188.106.228])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5d806feddfasm26116096a12.58.2025.01.08.01.25.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jan 2025 01:25:55 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Bin Meng <bmeng.cn@gmail.com>, Fabiano Rosas <farosas@suse.de>,
 Guenter Roeck <linux@roeck-us.net>,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org,
 Laurent Vivier <lvivier@redhat.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 05/14] hw/pci-host/designware: Expose MSI IRQ
Date: Wed,  8 Jan 2025 10:25:29 +0100
Message-ID: <20250108092538.11474-6-shentey@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250108092538.11474-1-shentey@gmail.com>
References: <20250108092538.11474-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x534.google.com
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
index 61c593ffd2..4395b2ae5e 100644
--- a/include/hw/arm/fsl-imx6.h
+++ b/include/hw/arm/fsl-imx6.h
@@ -23,6 +23,7 @@
 #include "hw/misc/imx7_snvs.h"
 #include "hw/watchdog/wdt_imx2.h"
 #include "hw/char/imx_serial.h"
+#include "hw/core/shared-irq.h"
 #include "hw/timer/imx_gpt.h"
 #include "hw/timer/imx_epit.h"
 #include "hw/i2c/imx_i2c.h"
@@ -73,6 +74,7 @@ struct FslIMX6State {
     ChipideaState      usb[FSL_IMX6_NUM_USBS];
     IMXFECState        eth;
     DesignwarePCIEHost pcie;
+    SharedIRQ          pcie4_msi_irq;
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
index 411fa1c2e3..2dccc4db67 100644
--- a/include/hw/arm/fsl-imx7.h
+++ b/include/hw/arm/fsl-imx7.h
@@ -28,6 +28,7 @@
 #include "hw/watchdog/wdt_imx2.h"
 #include "hw/gpio/imx_gpio.h"
 #include "hw/char/imx_serial.h"
+#include "hw/core/shared-irq.h"
 #include "hw/timer/imx_gpt.h"
 #include "hw/timer/imx_epit.h"
 #include "hw/i2c/imx_i2c.h"
@@ -85,6 +86,7 @@ struct FslIMX7State {
     IMX7GPRState       gpr;
     ChipideaState      usb[FSL_IMX7_NUM_USBS];
     DesignwarePCIEHost pcie;
+    SharedIRQ          pcie4_msi_irq;
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
index ac8c66e242..d8c6685bac 100644
--- a/hw/arm/fsl-imx6.c
+++ b/hw/arm/fsl-imx6.c
@@ -106,6 +106,8 @@ static void fsl_imx6_init(Object *obj)
     object_initialize_child(obj, "eth", &s->eth, TYPE_IMX_ENET);
 
     object_initialize_child(obj, "pcie", &s->pcie, TYPE_DESIGNWARE_PCIE_HOST);
+    object_initialize_child(obj, "pcie4-msi-irq", &s->pcie4_msi_irq,
+                            TYPE_SHARED_IRQ);
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
index 05e3389fbe..801f49c94a 100644
--- a/hw/arm/fsl-imx7.c
+++ b/hw/arm/fsl-imx7.c
@@ -150,6 +150,8 @@ static void fsl_imx7_init(Object *obj)
      * PCIE
      */
     object_initialize_child(obj, "pcie", &s->pcie, TYPE_DESIGNWARE_PCIE_HOST);
+    object_initialize_child(obj, "pcie4-msi-irq", &s->pcie4_msi_irq,
+                            TYPE_SHARED_IRQ);
 
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
index e779b5af95..0c9ccd850d 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -516,6 +516,7 @@ config FSL_IMX6
     select PL310  # cache controller
     select PCI_EXPRESS_DESIGNWARE
     select SDHCI
+    select SHARED_IRQ
 
 config ASPEED_SOC
     bool
@@ -573,6 +574,7 @@ config FSL_IMX7
     select WDT_IMX2
     select PCI_EXPRESS_DESIGNWARE
     select SDHCI
+    select SHARED_IRQ
     select UNIMP
 
 config ARM_SMMUV3
-- 
2.47.1


