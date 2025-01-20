Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3976DC02181
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2025 20:40:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZyXS-00040i-Um; Mon, 20 Jan 2025 15:38:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tZyXQ-0003z3-Ou; Mon, 20 Jan 2025 15:38:24 -0500
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tZyXO-0002Yo-MO; Mon, 20 Jan 2025 15:38:24 -0500
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5d0ac27b412so6604111a12.1; 
 Mon, 20 Jan 2025 12:38:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737405500; x=1738010300; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bHG6wePXgPdhlFbk3rWq8d69s0NWl8fhuOgIse1lEh4=;
 b=T9w8/zhedzK25hahG1qVjrhS2hAkjQ2+1fmCUSe63Omg8ZR/cmtdFQ7AEUYZqF3A3G
 HExjLZsBTjo0PoPkYTBD9UjsxcTMVed6RQe6KJEdHonorMDMrNB4JJqD+B3rUh7gOblg
 W5dAhGLQcE+9E5CO3aLVQDxpY0LGfQDi9KMFgNWkNFdzijPo/kdIyOzKIA7jcPVzmXgq
 bRssVA+cu8f3InLc++8G5kIHiorLVjc3HmIerahpwn3lw6YDWgdnfHOU/CIQPMIDO6C2
 4nQstQC1w5en6ku/KZYAVCq22j/yEJMtUZ/J8PJ3JWz4GHbOgHFNJgSsxFAEKy6Y7vre
 Zlzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737405500; x=1738010300;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bHG6wePXgPdhlFbk3rWq8d69s0NWl8fhuOgIse1lEh4=;
 b=VO6YZLVca4BbuxirGSFv6Ypqkia4LWUz6ivyacRiSunJ5jvi+fmf0LDLMrL4fPOXR/
 tRlcADLX5nsY25kV8YTExXucKRjUcnbbWifkWP8LdzbVZNyPHl6drl0gcOVuGa48TIgR
 pjrnKpkLlF7qAnzjle3uRsnuxN1O+klwiVqMfdF9d36aslAH4wU0RadUmUO5Invurx/B
 cM4EbWE7XpoWae6LbBk4OJloVqdfhRI1T4UqdV2H4mG01QN3P1zzf+P5TGOzHom+d//h
 n8vKSNjja4m7jpuIRp7Rrv9AyXVsryEgOUv2ttNIwrVejqahRFZ9Fj/JuPjOjmm5OasU
 Bv0Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWtYAjbhFms4EzB2eKPnAe5oaNwM5fbzVNBZLfchMpQQ/10bqojTdIV29bHmTiRLMhz073E/pMAvg==@nongnu.org
X-Gm-Message-State: AOJu0YxPTcaWLNfkbCLvQizQca+ECq076Oyd7ZWavySsjYPe82hzIuXg
 SJn7fJMQ1XY3U5cEc/lelZtOPlsewBIfxtT/PiGQrRWmMzz5JnZDmrgNQdhs
X-Gm-Gg: ASbGncuNuQkJe8pc+CfwyxtuRpp4e1J+7x/22JTRrPE/jyN8VR4KHcKejxi9wqdTnHD
 +Km2mF36NbEP5XYBTvaxTT+zZQy9Oxppl9th/Zo3aXmNh3DEPjRAwi1f746kP9RBj8NKkJnvwrf
 DZSpZCpAUV+xVmJXyHgBg1e7cDmz+gbCo8h7Wb6cDtJR0U7wrDDWbAn0wRRXYygDYpSpG80HLgC
 PX1R08fWoJgz/jbWPijhIY+DpzbRIqwhCXJvF9m80xeQEA4RSuC0NtxZeZH7LynI+k433U/lIRb
 AEIQIvuMRpwOWtmF9QY+P3Qm9IolTgRyQYSMGt+ixQ+5GR1xTGnogggrdSRn
X-Google-Smtp-Source: AGHT+IGBWXEJK+fw/KqbMDRIQJyMujKHqBz1x3tLWTjbuvQdUh/J/paGOMXP9d2EPUZ3MomDqnFCig==
X-Received: by 2002:a05:6402:2110:b0:5d3:ba42:ea03 with SMTP id
 4fb4d7f45d1cf-5db7d2f8135mr10165875a12.8.1737405499919; 
 Mon, 20 Jan 2025 12:38:19 -0800 (PST)
Received: from Provence.localdomain
 (dynamic-077-183-181-102.77.183.pool.telefonica.de. [77.183.181.102])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5db7364258csm6021077a12.1.2025.01.20.12.38.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2025 12:38:19 -0800 (PST)
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
Subject: [PATCH 16/21] hw/arm/fsl-imx8mp: Add USB support
Date: Mon, 20 Jan 2025 21:37:43 +0100
Message-ID: <20250120203748.4687-17-shentey@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250120203748.4687-1-shentey@gmail.com>
References: <20250120203748.4687-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x535.google.com
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

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 docs/system/arm/imx8mp-evk.rst |  1 +
 include/hw/arm/fsl-imx8mp.h    | 12 +++++++++++
 hw/arm/fsl-imx8mp.c            | 37 ++++++++++++++++++++++++++++++++--
 hw/arm/Kconfig                 |  1 +
 4 files changed, 49 insertions(+), 2 deletions(-)

diff --git a/docs/system/arm/imx8mp-evk.rst b/docs/system/arm/imx8mp-evk.rst
index a3a17fc41f..af1f02d8e8 100644
--- a/docs/system/arm/imx8mp-evk.rst
+++ b/docs/system/arm/imx8mp-evk.rst
@@ -16,6 +16,7 @@ The ``imx8mp-evk`` machine implements the following devices:
  * 3 USDHC Storage Controllers
  * 1 Designware PCI Express Controller
  * 1 Ethernet Controller
+ * 2 Designware USB 3 Controllers
  * 5 GPIO Controllers
  * 6 I2C Controllers
  * 3 SPI Controllers
diff --git a/include/hw/arm/fsl-imx8mp.h b/include/hw/arm/fsl-imx8mp.h
index 8fe27ac9bd..1b8a5cbbba 100644
--- a/include/hw/arm/fsl-imx8mp.h
+++ b/include/hw/arm/fsl-imx8mp.h
@@ -23,6 +23,7 @@
 #include "hw/sd/sdhci.h"
 #include "hw/ssi/imx_spi.h"
 #include "hw/timer/imx_gpt.h"
+#include "hw/usb/hcd-dwc3.h"
 #include "hw/watchdog/wdt_imx2.h"
 #include "qom/object.h"
 #include "qemu/units.h"
@@ -41,6 +42,7 @@ enum FslImx8mpConfiguration {
     FSL_IMX8MP_NUM_I2CS         = 6,
     FSL_IMX8MP_NUM_IRQS         = 160,
     FSL_IMX8MP_NUM_UARTS        = 4,
+    FSL_IMX8MP_NUM_USBS         = 2,
     FSL_IMX8MP_NUM_USDHCS       = 3,
     FSL_IMX8MP_NUM_WDTS         = 3,
 };
@@ -61,6 +63,7 @@ struct FslImx8mpState {
     IMXFECState        enet;
     SDHCIState         usdhc[FSL_IMX8MP_NUM_USDHCS];
     IMX2WdtState       wdt[FSL_IMX8MP_NUM_WDTS];
+    USBDWC3            usb[FSL_IMX8MP_NUM_USBS];
     DesignwarePCIEHost pcie;
     FslImx8mPciePhyState   pcie_phy;
     OrIRQState         gpt5_gpt6_irq;
@@ -198,6 +201,12 @@ enum FslImx8mpMemoryRegions {
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
@@ -233,6 +242,9 @@ enum FslImx8mpIrqs {
     FSL_IMX8MP_I2C3_IRQ     = 37,
     FSL_IMX8MP_I2C4_IRQ     = 38,
 
+    FSL_IMX8MP_USB1_IRQ     = 40,
+    FSL_IMX8MP_USB2_IRQ     = 41,
+
     FSL_IMX8MP_GPT1_IRQ      = 55,
     FSL_IMX8MP_GPT2_IRQ      = 54,
     FSL_IMX8MP_GPT3_IRQ      = 53,
diff --git a/hw/arm/fsl-imx8mp.c b/hw/arm/fsl-imx8mp.c
index 3bb719d0e8..5b9781a424 100644
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
@@ -233,6 +239,11 @@ static void fsl_imx8mp_init(Object *obj)
         object_initialize_child(obj, name, &s->usdhc[i], TYPE_IMX_USDHC);
     }
 
+    for (i = 0; i < FSL_IMX8MP_NUM_USBS; i++) {
+        snprintf(name, NAME_SIZE, "usb%d", i);
+        object_initialize_child(obj, name, &s->usb[i], TYPE_USB_DWC3);
+    }
+
     for (i = 0; i < FSL_IMX8MP_NUM_ECSPIS; i++) {
         snprintf(name, NAME_SIZE, "spi%d", i + 1);
         object_initialize_child(obj, name, &s->spi[i], TYPE_IMX_SPI);
@@ -528,6 +539,27 @@ static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
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
@@ -632,6 +664,7 @@ static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
         case FSL_IMX8MP_RAM:
         case FSL_IMX8MP_SNVS_HP:
         case FSL_IMX8MP_UART1 ... FSL_IMX8MP_UART4:
+        case FSL_IMX8MP_USB1 ... FSL_IMX8MP_USB2:
         case FSL_IMX8MP_USDHC1 ... FSL_IMX8MP_USDHC3:
         case FSL_IMX8MP_WDOG1 ... FSL_IMX8MP_WDOG3:
             /* device implemented and treated above */
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 0e49ac4d5c..c9b47270ac 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -591,6 +591,7 @@ config FSL_IMX8MP
     select PCI_EXPRESS_FSL_IMX8M_PHY
     select SDHCI
     select UNIMP
+    select USB_DWC3
     select WDT_IMX2
 
 config FSL_IMX8MP_EVK
-- 
2.48.1


