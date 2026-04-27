Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EC13FF8862
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 12:55:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHLOv-0000jS-MV; Mon, 27 Apr 2026 08:49:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHLNa-0007tW-Mb
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 08:48:12 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHLNR-0005VG-VV
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 08:48:00 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-48a3e9862f0so54014845e9.1
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 05:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777294072; x=1777898872; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=9V9ypQhZMA6beD24MyNKWxp8/BYxr4ugvwVwFV1KVGM=;
 b=Gfbni2pnj91UleX8weTK6IgZNpB2fbnt1nNNfdlthigKuP6Xb5sKukMcywZF7c9Mu5
 myrsFy4EeOhVpj0q0U86vEmsqHxzTYVD2duCYaARWA1NL7S0QWdPPVhfVECC7Hxi/QUE
 vr8txEfeOC56zkBes2lyTct8tO0Sz+PxfcdnvZWItdIyp3XYTYo+PTd4E+YxPDXnV0dF
 1pzciNGlzj6qPwfr9P4lNFUtF9ufC4fIJQC1/VMUGMyANb42ugfd6tgfdnWRGU3aa5P5
 cQ21h3YnVWoyUqxnu5cJyGeBjG6tcNwOn51pYTTq1ehRK/Drgb+aEU51FFNh57MFPwd1
 061w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777294072; x=1777898872;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=9V9ypQhZMA6beD24MyNKWxp8/BYxr4ugvwVwFV1KVGM=;
 b=Rru4pbe4GJa5oVzy+k6VRnCw27DiM3y4u7axlRazhRVgXxsKB4ZYJbdJYihyTPHdzv
 A39TU5hVTMpOokOjtpQFe+RaNTCW5a3s962kc+Os0MYNgYfXsAoR1EaRkMtDAiqlirTh
 aje+g6z9e8Cgem24iduSHpYXs0USb1pRYbUIe98giZGkDGvt0e1ichvl94IPYfrAMQn2
 IXht5OThpslwfuWUzrOUVlbNzmPBJ07cb7jN7sTkZqr513UGfRUl1SJCQmdkMDZ9+oIp
 Lj1tFXIwmMrbcVTDLDG9JqUjrl6E2POzELptqKtcdU71xzHseFYPxiTioQMB/pHq+BRD
 JBCg==
X-Gm-Message-State: AOJu0YzsRHFbwTi84ZYny7T/3MG1qcLwrlEar6ZX5F6JLKJRsV4AhlhK
 kyr1RajKL0Ll/oPmaCwbPux2CP9WjG2IcTwCUjPo3cdn8GlaO5A+QL8DLOGQWJXs0xPwoklzVFo
 lcTea
X-Gm-Gg: AeBDievqIPH5oqcKYrwlff7MNod/WnXPzklA3LgrBSrjETgtS85KJJrhcUJQbuWwQlw
 mBSgR+mGTrgWpAwDPmar22S2Xhz9nPZipZALQbmw/PZX7awwNpHt6jD4U715ut0olLsT4eHEjLJ
 uPQYBB07PPu9lVYyYPoVPp2cQ76jXi5/WjzO1PlvmDfB6Xza3H2s+DFWR0lTwM0ixy2It1XDE2y
 qFx9BZSMvMCsSKgydx9iboou5AVyBYJwm2TICHDio8ypwRkYK2v8xDq7H+NvQbCPdVXyp4p36kG
 hfl44nX5fT36uI5aAW1tt+Jd9Ilnsn/ToyhJMVWRffWRfb78LKArTuvFWnh2YefBrXrcnZDBH0u
 p0ujq7yjGDz2D4iLTNRcIltRjDgTIN6+85IKJNFTkVR01rlPEZjGXkOn5RZuCmItXx4Z2DdCOcb
 G7PFojjQcXWppK7OYXyudxzHeVw/x4UC6qv4VEgpZB9ok9JYGXt52za54AWPMPUK6e76hQu8h05
 Skzr/11HJ9hQOBPjqBZ6TnpxkE9nbr+pBm/xRPzB6Bp/ZcQI3Ol
X-Received: by 2002:a05:600d:8447:b0:486:f893:56c6 with SMTP id
 5b1f17b1804b1-488fb8b18d1mr423170665e9.10.1777294072114; 
 Mon, 27 Apr 2026 05:47:52 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488ffc5e3f4sm448974115e9.2.2026.04.27.05.47.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 05:47:51 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 15/63] hw/arm/fsl-imx8mm: Adding support for USB controller
Date: Mon, 27 Apr 2026 13:46:49 +0100
Message-ID: <20260427124738.966578-16-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260427124738.966578-1-peter.maydell@linaro.org>
References: <20260427124738.966578-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
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

From: Gaurav Sharma <gaurav.sharma_7@nxp.com>

It enables emulation of USB on iMX8MM
Enables testing and debugging of USB drivers

Reviewed-by: Philippe Mathieu-Daude <philmd@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Bernhard Beschow <shentey@gmail.com>
Signed-off-by: Gaurav Sharma <gaurav.sharma_7@nxp.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/Kconfig              |  1 +
 hw/arm/fsl-imx8mm.c         | 27 +++++++++++++++++++++++++++
 include/hw/arm/fsl-imx8mm.h |  6 ++++++
 3 files changed, 34 insertions(+)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 104954d90d..b940af9345 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -631,6 +631,7 @@ config FSL_IMX8MM
     select SDHCI
     select PCI_EXPRESS_DESIGNWARE
     select PCI_EXPRESS_FSL_IMX8M_PHY
+    select USB_DWC3
     select WDT_IMX2
 
 config FSL_IMX8MM_EVK
diff --git a/hw/arm/fsl-imx8mm.c b/hw/arm/fsl-imx8mm.c
index f1c173dbec..97c3f8542c 100644
--- a/hw/arm/fsl-imx8mm.c
+++ b/hw/arm/fsl-imx8mm.c
@@ -202,6 +202,11 @@ static void fsl_imx8mm_init(Object *obj)
         object_initialize_child(obj, name, &s->usdhc[i], TYPE_IMX_USDHC);
     }
 
+    for (i = 0; i < FSL_IMX8MM_NUM_USBS; i++) {
+        g_autofree char *name = g_strdup_printf("usb%d", i);
+        object_initialize_child(obj, name, &s->usb[i], TYPE_USB_DWC3);
+    }
+
     for (i = 0; i < FSL_IMX8MM_NUM_ECSPIS; i++) {
         g_autofree char *name = g_strdup_printf("spi%d", i + 1);
         object_initialize_child(obj, name, &s->spi[i], TYPE_IMX_SPI);
@@ -529,6 +534,27 @@ static void fsl_imx8mm_realize(DeviceState *dev, Error **errp)
                            qdev_get_gpio_in(gicdev, usdhc_table[i].irq));
     }
 
+    /* USBs */
+    for (i = 0; i < FSL_IMX8MM_NUM_USBS; i++) {
+        static const struct {
+            hwaddr addr;
+            unsigned int irq;
+        } usb_table[FSL_IMX8MM_NUM_USBS] = {
+            { fsl_imx8mm_memmap[FSL_IMX8MM_USB1].addr, FSL_IMX8MM_USB1_IRQ },
+            { fsl_imx8mm_memmap[FSL_IMX8MM_USB2].addr, FSL_IMX8MM_USB2_IRQ },
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
     for (i = 0; i < FSL_IMX8MM_NUM_ECSPIS; i++) {
         static const struct {
@@ -635,6 +661,7 @@ static void fsl_imx8mm_realize(DeviceState *dev, Error **errp)
         case FSL_IMX8MM_OCRAM:
         case FSL_IMX8MM_SNVS_HP:
         case FSL_IMX8MM_UART1 ... FSL_IMX8MM_UART4:
+        case FSL_IMX8MM_USB1 ... FSL_IMX8MM_USB2:
         case FSL_IMX8MM_USDHC1 ... FSL_IMX8MM_USDHC3:
         case FSL_IMX8MM_WDOG1 ... FSL_IMX8MM_WDOG3:
             /* device implemented and treated above */
diff --git a/include/hw/arm/fsl-imx8mm.h b/include/hw/arm/fsl-imx8mm.h
index bc5a0922ad..60d79a6e3c 100644
--- a/include/hw/arm/fsl-imx8mm.h
+++ b/include/hw/arm/fsl-imx8mm.h
@@ -25,6 +25,7 @@
 #include "hw/sd/sdhci.h"
 #include "hw/ssi/imx_spi.h"
 #include "hw/timer/imx_gpt.h"
+#include "hw/usb/hcd-dwc3.h"
 #include "hw/watchdog/wdt_imx2.h"
 #include "qom/object.h"
 #include "qemu/units.h"
@@ -43,6 +44,7 @@ enum FslImx8mmConfiguration {
     FSL_IMX8MM_NUM_I2CS         = 4,
     FSL_IMX8MM_NUM_IRQS         = 128,
     FSL_IMX8MM_NUM_UARTS        = 4,
+    FSL_IMX8MM_NUM_USBS         = 2,
     FSL_IMX8MM_NUM_USDHCS       = 3,
     FSL_IMX8MM_NUM_WDTS         = 3,
 };
@@ -64,6 +66,7 @@ struct FslImx8mmState {
     IMXFECState        enet;
     SDHCIState         usdhc[FSL_IMX8MM_NUM_USDHCS];
     IMX2WdtState       wdt[FSL_IMX8MM_NUM_WDTS];
+    USBDWC3            usb[FSL_IMX8MM_NUM_USBS];
     DesignwarePCIEHost pcie;
     FslImx8mPciePhyState   pcie_phy;
     OrIRQState         gpt5_gpt6_irq;
@@ -202,6 +205,9 @@ enum FslImx8mmIrqs {
     FSL_IMX8MM_I2C3_IRQ     = 37,
     FSL_IMX8MM_I2C4_IRQ     = 38,
 
+    FSL_IMX8MM_USB1_IRQ     = 40,
+    FSL_IMX8MM_USB2_IRQ     = 41,
+
     FSL_IMX8MM_GPT1_IRQ      = 55,
     FSL_IMX8MM_GPT2_IRQ      = 54,
     FSL_IMX8MM_GPT3_IRQ      = 53,
-- 
2.43.0


