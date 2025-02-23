Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F233DC021B2
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Feb 2025 11:51:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmASp-0000Gy-1x; Sun, 23 Feb 2025 06:48:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tmASc-0000Bo-4s; Sun, 23 Feb 2025 06:47:50 -0500
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tmASY-0005yv-Ur; Sun, 23 Feb 2025 06:47:48 -0500
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5e050b1491eso8002756a12.0; 
 Sun, 23 Feb 2025 03:47:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740311263; x=1740916063; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I4GmIdRpUqH2XNbPavazDuVcaQRX+2fYsZ8ddV0Ui3o=;
 b=ThuEmLk3sMYMUh4gq6yKhtZhitX5NgQkobG0sZJvKS0+r2rLNDplbcWTl8mJgIil1l
 dysxVwQsdTjkkSav2v6LBLJ1H3yfJZvy2/oekHcLafxu7NsXJQggm5nqdabokfjxMSF9
 ycpiHzAAG+L/kJwpCSmnLRJVwqig7YOkda/ALc95Id24APBbVf84sawymS3f4LNe3xpG
 /Y1uF6yGLrpdqdlKn+sF4hX2gW1wQo8jfgM464ESAHMZg8NtplQpDV3z7zqgPFJ7Phj0
 YsSMUFFC7muZGy0lJJc7zMUhJzldvDcnTBfg5jKnNnapYSblz4YRztZaYPPhR5HAkqQA
 YrRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740311263; x=1740916063;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I4GmIdRpUqH2XNbPavazDuVcaQRX+2fYsZ8ddV0Ui3o=;
 b=BDjCY8c54/KCHkVTIxyCgTFmWEo2bXK26Y9Cs7be99530pNDzvROriQLharoLdhXQi
 7JMot/95Dd1W6iOlZpZijZjItn3A9DoH2RqeTTELZLH+SMaAn7pOl3UGdy528EgWUDdp
 mnPgnFD/N+nbQquKkgPiRAuJhwOvKD6tmbMhMr/JgVinisWma30zQ0PCXc3QJzRUD0FC
 J3wopyN7XKpwfLmbUgJ0bnLm2Yvq+9vpCQ+doMhmUngGAZfVU2M/56JHg3+NJNS7JNVX
 JCLqfSCJodU2LmYSPpgo+vVy+aKAXCK08fuD/lWj65hs4mkW8/M83228+IctJOCT41TO
 z7ew==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/yH/a50wdB9bh3Fe6/GnAYGtXpXnyb6Rk1CjG2YN68M13BRqM2km1PfF1WrxPlRCkhnrOSr7KZg==@nongnu.org
X-Gm-Message-State: AOJu0YwsUnmqV8I6qdY6rnGYxTaKvKede9dP2WDLXw9Jy4vVk6LFU+Ey
 /v4qbzvfQgFQ5nAxX8XDM8MEp+GvY/Mz7GLhBq7Sm+/k3Rgv3lDEk1EEJQ==
X-Gm-Gg: ASbGnctSe/9HujJN/t+XNO0oTp+lMTopqfG1XGW5nJNnMTIXGJNqAflcSwEp0QOEBnf
 1MuAEI2XmJDhmevds5UeBqIoJLP2Orc3jSqZfuW7Q6eaYBUeXGqi298eN6PUeghcokocvFIQ5f3
 wD7A2YoGGDwZLJG1nMRY3EEMbrBY58/oJpaG4L+rX6+49AKjnlJzw5OqnBddRQzsOJoe9DPhXvH
 0SLurrwBgcJ2/7UUcsSxdihbgzyicZp2FbJFMQMBD1Nr0JtuFu3kwX699e/bNXKgZ+9HFeAdtFI
 i20u7/Cr0+Ia1d/g78ajlwxS4geZLYnOeJ5Fo4g5j/4To5VbdqhAr3Z6a4DmoHkpXAuqjGgDqt0
 yBarnLTLuGoBm
X-Google-Smtp-Source: AGHT+IEgfDIwZzEyvVrB/G8rbB5Vb7ymXetKXmX7r3PloZwhEavKRYFgc4isnavMijhUbds2qZJtfw==
X-Received: by 2002:a17:907:a317:b0:ab7:46c4:a7be with SMTP id
 a640c23a62f3a-abbeda28000mr1233047666b.2.1740311263219; 
 Sun, 23 Feb 2025 03:47:43 -0800 (PST)
Received: from Provence.localdomain
 (dynamic-077-011-167-038.77.11.pool.telefonica.de. [77.11.167.38])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-abba4b9ee98sm1240515466b.167.2025.02.23.03.47.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Feb 2025 03:47:42 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 Bernhard Beschow <shentey@gmail.com>, Fabiano Rosas <farosas@suse.de>,
 Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 15/18] hw/arm/fsl-imx8mp: Add USB support
Date: Sun, 23 Feb 2025 12:47:05 +0100
Message-ID: <20250223114708.1780-16-shentey@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250223114708.1780-1-shentey@gmail.com>
References: <20250223114708.1780-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x52f.google.com
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

Split the USB MMIO regions to better keep track of the implemented vs.
unimplemented regions.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 docs/system/arm/imx8mp-evk.rst |  1 +
 include/hw/arm/fsl-imx8mp.h    | 12 +++++++++++
 hw/arm/fsl-imx8mp.c            | 37 ++++++++++++++++++++++++++++++++--
 hw/arm/Kconfig                 |  1 +
 4 files changed, 49 insertions(+), 2 deletions(-)

diff --git a/docs/system/arm/imx8mp-evk.rst b/docs/system/arm/imx8mp-evk.rst
index 917c1d5176..00527b0cbe 100644
--- a/docs/system/arm/imx8mp-evk.rst
+++ b/docs/system/arm/imx8mp-evk.rst
@@ -15,6 +15,7 @@ The ``imx8mp-evk`` machine implements the following devices:
  * 3 USDHC Storage Controllers
  * 1 Designware PCI Express Controller
  * 1 Ethernet Controller
+ * 2 Designware USB 3 Controllers
  * 5 GPIO Controllers
  * 6 I2C Controllers
  * 3 SPI Controllers
diff --git a/include/hw/arm/fsl-imx8mp.h b/include/hw/arm/fsl-imx8mp.h
index e292c31a3d..5247e972b8 100644
--- a/include/hw/arm/fsl-imx8mp.h
+++ b/include/hw/arm/fsl-imx8mp.h
@@ -24,6 +24,7 @@
 #include "hw/sd/sdhci.h"
 #include "hw/ssi/imx_spi.h"
 #include "hw/timer/imx_gpt.h"
+#include "hw/usb/hcd-dwc3.h"
 #include "hw/watchdog/wdt_imx2.h"
 #include "qom/object.h"
 #include "qemu/units.h"
@@ -42,6 +43,7 @@ enum FslImx8mpConfiguration {
     FSL_IMX8MP_NUM_I2CS         = 6,
     FSL_IMX8MP_NUM_IRQS         = 160,
     FSL_IMX8MP_NUM_UARTS        = 4,
+    FSL_IMX8MP_NUM_USBS         = 2,
     FSL_IMX8MP_NUM_USDHCS       = 3,
     FSL_IMX8MP_NUM_WDTS         = 3,
 };
@@ -62,6 +64,7 @@ struct FslImx8mpState {
     IMXFECState        enet;
     SDHCIState         usdhc[FSL_IMX8MP_NUM_USDHCS];
     IMX2WdtState       wdt[FSL_IMX8MP_NUM_WDTS];
+    USBDWC3            usb[FSL_IMX8MP_NUM_USBS];
     DesignwarePCIEHost pcie;
     FslImx8mPciePhyState   pcie_phy;
     OrIRQState         gpt5_gpt6_irq;
@@ -199,6 +202,12 @@ enum FslImx8mpMemoryRegions {
     FSL_IMX8MP_UART4,
     FSL_IMX8MP_USB1,
     FSL_IMX8MP_USB2,
+    FSL_IMX8MP_USB1_DEV,
+    FSL_IMX8MP_USB2_DEV,
+    FSL_IMX8MP_USB1_OTG,
+    FSL_IMX8MP_USB2_OTG,
+    FSL_IMX8MP_USB1_GLUE,
+    FSL_IMX8MP_USB2_GLUE,
     FSL_IMX8MP_USDHC1,
     FSL_IMX8MP_USDHC2,
     FSL_IMX8MP_USDHC3,
@@ -234,6 +243,9 @@ enum FslImx8mpIrqs {
     FSL_IMX8MP_I2C3_IRQ     = 37,
     FSL_IMX8MP_I2C4_IRQ     = 38,
 
+    FSL_IMX8MP_USB1_IRQ     = 40,
+    FSL_IMX8MP_USB2_IRQ     = 41,
+
     FSL_IMX8MP_GPT1_IRQ      = 55,
     FSL_IMX8MP_GPT2_IRQ      = 54,
     FSL_IMX8MP_GPT3_IRQ      = 53,
diff --git a/hw/arm/fsl-imx8mp.c b/hw/arm/fsl-imx8mp.c
index 935279ee68..f0d5980300 100644
--- a/hw/arm/fsl-imx8mp.c
+++ b/hw/arm/fsl-imx8mp.c
@@ -40,8 +40,14 @@ static const struct {
     [FSL_IMX8MP_VPU_VC8000E_ENCODER] = { 0x38320000, 2 * MiB, "vpu_vc8000e_encoder" },
     [FSL_IMX8MP_VPU_G2_DECODER] = { 0x38310000, 2 * MiB, "vpu_g2_decoder" },
     [FSL_IMX8MP_VPU_G1_DECODER] = { 0x38300000, 2 * MiB, "vpu_g1_decoder" },
-    [FSL_IMX8MP_USB2] = { 0x38200000, 1 * MiB, "usb2" },
-    [FSL_IMX8MP_USB1] = { 0x38100000, 1 * MiB, "usb1" },
+    [FSL_IMX8MP_USB2_GLUE] = { 0x382f0000, 0x100, "usb2_glue" },
+    [FSL_IMX8MP_USB2_OTG] = { 0x3820cc00, 0x100, "usb2_otg" },
+    [FSL_IMX8MP_USB2_DEV] = { 0x3820c700, 0x500, "usb2_dev" },
+    [FSL_IMX8MP_USB2] = { 0x38200000, 0xc700, "usb2" },
+    [FSL_IMX8MP_USB1_GLUE] = { 0x381f0000, 0x100, "usb1_glue" },
+    [FSL_IMX8MP_USB1_OTG] = { 0x3810cc00, 0x100, "usb1_otg" },
+    [FSL_IMX8MP_USB1_DEV] = { 0x3810c700, 0x500, "usb1_dev" },
+    [FSL_IMX8MP_USB1] = { 0x38100000, 0xc700, "usb1" },
     [FSL_IMX8MP_GPU2D] = { 0x38008000, 32 * KiB, "gpu2d" },
     [FSL_IMX8MP_GPU3D] = { 0x38000000, 32 * KiB, "gpu3d" },
     [FSL_IMX8MP_QSPI1_RX_BUFFER] = { 0x34000000, 32 * MiB, "qspi1_rx_buffer" },
@@ -230,6 +236,11 @@ static void fsl_imx8mp_init(Object *obj)
         object_initialize_child(obj, name, &s->usdhc[i], TYPE_IMX_USDHC);
     }
 
+    for (i = 0; i < FSL_IMX8MP_NUM_USBS; i++) {
+        g_autofree char *name = g_strdup_printf("usb%d", i);
+        object_initialize_child(obj, name, &s->usb[i], TYPE_USB_DWC3);
+    }
+
     for (i = 0; i < FSL_IMX8MP_NUM_ECSPIS; i++) {
         g_autofree char *name = g_strdup_printf("spi%d", i + 1);
         object_initialize_child(obj, name, &s->spi[i], TYPE_IMX_SPI);
@@ -524,6 +535,27 @@ static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
                            qdev_get_gpio_in(gicdev, usdhc_table[i].irq));
     }
 
+    /* USBs */
+    for (i = 0; i < FSL_IMX8MP_NUM_USBS; i++) {
+        static const struct {
+            hwaddr addr;
+            unsigned int irq;
+        } usb_table[FSL_IMX8MP_NUM_USBS] = {
+            { fsl_imx8mp_memmap[FSL_IMX8MP_USB1].addr, FSL_IMX8MP_USB1_IRQ },
+            { fsl_imx8mp_memmap[FSL_IMX8MP_USB2].addr, FSL_IMX8MP_USB2_IRQ },
+        };
+
+        qdev_prop_set_uint32(DEVICE(&s->usb[i].sysbus_xhci), "p2", 1);
+        qdev_prop_set_uint32(DEVICE(&s->usb[i].sysbus_xhci), "p3", 1);
+        qdev_prop_set_uint32(DEVICE(&s->usb[i].sysbus_xhci), "slots", 2);
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->usb[i]), errp)) {
+            return;
+        }
+        sysbus_mmio_map(SYS_BUS_DEVICE(&s->usb[i]), 0, usb_table[i].addr);
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->usb[i].sysbus_xhci), 0,
+                           qdev_get_gpio_in(gicdev, usb_table[i].irq));
+    }
+
     /* ECSPIs */
     for (i = 0; i < FSL_IMX8MP_NUM_ECSPIS; i++) {
         static const struct {
@@ -628,6 +660,7 @@ static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
         case FSL_IMX8MP_RAM:
         case FSL_IMX8MP_SNVS_HP:
         case FSL_IMX8MP_UART1 ... FSL_IMX8MP_UART4:
+        case FSL_IMX8MP_USB1 ... FSL_IMX8MP_USB2:
         case FSL_IMX8MP_USDHC1 ... FSL_IMX8MP_USDHC3:
         case FSL_IMX8MP_WDOG1 ... FSL_IMX8MP_WDOG3:
             /* device implemented and treated above */
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 4d642db970..faa00d1db3 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -608,6 +608,7 @@ config FSL_IMX8MP
     select PCI_EXPRESS_FSL_IMX8M_PHY
     select SDHCI
     select UNIMP
+    select USB_DWC3
     select WDT_IMX2
 
 config FSL_IMX8MP_EVK
-- 
2.48.1


