Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30F35C0218F
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 09:23:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfF85-0005aB-1m; Tue, 04 Feb 2025 04:22:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tfF7m-00054P-FF; Tue, 04 Feb 2025 04:21:43 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tfF7k-000566-AH; Tue, 04 Feb 2025 04:21:42 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-436202dd7f6so61910725e9.0; 
 Tue, 04 Feb 2025 01:21:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738660898; x=1739265698; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=42R2aSml+VKTf0LoVp/saQ6KjzZL2IBFiJZ1dmWdk5A=;
 b=UcqTS11ZTtaIjhtasp65i5oq4SZ9LYS0tOb2mkZ6q21FYZkgtQS0cgnLgCpnGzSvA2
 ishB2MdG6FuY5NzeiSxMAe5tx46HzKCqk2adAqHPigAGfFn93p9BWXaTO6skLQgM5Geh
 ptJIETqiE4LkDGCTuDf7KYnV4Lkj55HKdfKxNJWxebtQyn0BcaOdXdTgDKfqIRn1EfBh
 CCRxxZftcHWSLCFzIRbWouP12Ozo3sHboOOeFRtPlHrCSHjiejle33CMUp5fXYX3axFN
 fN6/d5F8NRGsgZA8KLgWug4A6IYNTcRlnoGBYvyKvp9q8wmZFY3FmaA5YZ3P8g7/T1Tm
 5m/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738660898; x=1739265698;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=42R2aSml+VKTf0LoVp/saQ6KjzZL2IBFiJZ1dmWdk5A=;
 b=pg4n61AH7DZhi9C6EFHmxY1smBUwaDZFzKRuNPFw/u9MqFhdH4TmmlesiHh87bebfA
 nCNN6uQSCZp5G2m5mrFJpk4PuvuAzzPS3C8D5uz4mYWBMnOWx21GhF2jQmTF8vb3H5OW
 ufbAmWuTwnJDazy8AJIJBHuIVSCIj7UMdv9OGORmnQB2dWLazfv7/QnQOZBp22y6rEhd
 clUILiL1rVe+9jTGgwEOB2XsFbjXSMNnbBpegT9MoOnush8bztc8POozV+ydBhTqgEUH
 2wwzXQj6PYaoM/EY7l+y1dymUZdcAPkYKG5VKuCfSlIVHSJQD2FF2NHD0kX1Sb5S1V2N
 3M8w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJWo4pcxxfV/IQXzUuh7iK+lrDqv0VV3QCuIMe91aiVLxa3O4x778hmKUlJ9v1sqFwd0DlTQm7rw==@nongnu.org
X-Gm-Message-State: AOJu0YzfmV2ebD8Hx2kFHNAh0L4SzWT3Vnid786t/7oApbT6sB6psvdq
 2GZAAow9Q7j6gfb7XHE6BqOHi247AMaCW2+ykz3/NSVapsX9gCw/yXx7/Q==
X-Gm-Gg: ASbGncsgKxtqrCzFMsAZZCYKkQCYjDqvb4YQie6DazBO7nlLOdI62G/RIrxVFzn2Bb7
 +TkxgMngWze6x97IgfiyUNmhQPWa+eBGr8BpPOCSJWAmJ906TTJOGMZvjPpf0AzVIkahrILABlo
 ucBDsHP/xi7SXLvO7Je/uyFjEZLBT3ImQhqq0qNJZsGo9X1mVJovcfLp4AG2kuWzs3Wj9yGMsti
 IIM2SeXVBPWc7yas4QQP6Seg4Bze+4RN5GG262W7YeoSAmuG7zEJi2W3mDOub8UCk1bizOYseC8
 N1Id1hC2IBigfSMfMoKb2ZxkDTX/NAtFyIKOd7/3sbyxFi6QFUXj1yAfWNZtOGHgzcIFPYXon1k
 McL/juawAiw==
X-Google-Smtp-Source: AGHT+IFJi0jf3t4vxeDW75IcC+9zECOvDD/dxHiTASQ5vx0oJ07ky/sHwYSIq4WKuIdlJ9R+sKO3cA==
X-Received: by 2002:a05:600c:1d83:b0:434:a781:f5d5 with SMTP id
 5b1f17b1804b1-438dc43540bmr225404965e9.30.1738660897620; 
 Tue, 04 Feb 2025 01:21:37 -0800 (PST)
Received: from Georg-PC.fritz.box
 (p200300faaf0043006a2cae69f03f1c85.dip0.t-ipconnect.de.
 [2003:fa:af00:4300:6a2c:ae69:f03f:1c85])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438e23d42c7sm187233595e9.3.2025.02.04.01.21.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Feb 2025 01:21:36 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Bernhard Beschow <shentey@gmail.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 15/18] hw/arm/fsl-imx8mp: Add USB support
Date: Tue,  4 Feb 2025 10:21:09 +0100
Message-ID: <20250204092112.26957-16-shentey@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250204092112.26957-1-shentey@gmail.com>
References: <20250204092112.26957-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x330.google.com
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
index 4109387b6e..b3d657be10 100644
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
index 665123cf9c..14d696957a 100644
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
index 7767a8725a..6daa9c651f 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -592,6 +592,7 @@ config FSL_IMX8MP
     select PCI_EXPRESS_FSL_IMX8M_PHY
     select SDHCI
     select UNIMP
+    select USB_DWC3
     select WDT_IMX2
 
 config FSL_IMX8MP_EVK
-- 
2.48.1


