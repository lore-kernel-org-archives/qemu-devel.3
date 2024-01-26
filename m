Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BFDEC47422
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 14:35:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTNHR-0002gv-Ez; Fri, 26 Jan 2024 09:34:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rTNHN-0002Tw-TY
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 09:34:01 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rTNHM-0007zs-4D
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 09:34:01 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-40ee82d040dso3000995e9.3
 for <qemu-devel@nongnu.org>; Fri, 26 Jan 2024 06:33:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706279639; x=1706884439; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=cnb5Te5JjfcRGo6jPAixA7Wqdmj5tk2fqhvny4CjP+g=;
 b=T4azvJksRFtPeuOdxxgL8EKfEp+GQpolXgJomkUd6EuLYkrrS5vataOqrdvQ/gwcIR
 TSL4txLbrIHIAoAtg/8f6c0L68jO+lxxD0RLpFAS5YSgtt36Eo2698Pfqyf1ylyqW4fS
 QR7LKlGJBcnAMhTgqkHgauCmWESkcEEU41vNogDuqtpZfBu5CrPHoqroWkAX6cE7TIRm
 WqTFjnLPs01Q4NWPKYF605jkht4aLdxEbi+n9qAgOmV6vnXhxHF42IzWRwK1AF0Rk4Tf
 xkkUVkrR/izZ745UJ5uArv0QzGlcCszobUpBo6PUctIguhusaxGEhQlDDpTHdTOMWYB3
 sF6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706279639; x=1706884439;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cnb5Te5JjfcRGo6jPAixA7Wqdmj5tk2fqhvny4CjP+g=;
 b=Ze8i08eA96/GUmfQ6uDpVBeTeC2MXGB93rg5MbRLWvNoyAx6QtUsbXOfPfNXspwiVx
 1x/G7FlvX/crgKfF05ypMZ7JuU+niaLDwKJjP7Ldolk8AlqKCbkKdw8N+36gM70xNd6+
 oHSEwMX1EQdBXUealkbn4Gon7RVNcyCZ3wRkm+Vf9phA9s4Pe1946wvnbujQaTORdka8
 dNOnT0zUQ5sF1KY/QnLsoMFJOHXpwkYTm065J8e/OLfW/GQVTx80Q4SV/IfJjy8tNnjG
 Wyf89dzR4ll15Da5bZ2pDSBOXQLVnGZNAuQ4E8O7MSTiBAMspMEPFUiPCaCujmEWEqbm
 uxBw==
X-Gm-Message-State: AOJu0Ywk1t6wVdPLG+/wDM5I6hlzb62/ngH9Q0GCLcjHiJSU1/4JZkPg
 3O0ac4XX3L1fuxjcEqDuZegeAy6tvRyHPCVPH7mBhvtIl9WxRueWVTFbX1JJ1CdoJ/wWWxNRoh8
 Y
X-Google-Smtp-Source: AGHT+IFRks21zxJWNIwnmulnhvp3FOA5KZgILQLkUUfx9azBNWwAchU+hte5H0I+vixK5uDnlklh8w==
X-Received: by 2002:a7b:c8da:0:b0:40e:53f4:f979 with SMTP id
 f26-20020a7bc8da000000b0040e53f4f979mr973177wml.164.1706279638798; 
 Fri, 26 Jan 2024 06:33:58 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 n5-20020a5d4845000000b00337f722e5ccsm1396207wrs.65.2024.01.26.06.33.58
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jan 2024 06:33:58 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 36/36] hw/arm: add PCIe to Freescale i.MX6
Date: Fri, 26 Jan 2024 14:33:41 +0000
Message-Id: <20240126143341.2101237-37-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240126143341.2101237-1-peter.maydell@linaro.org>
References: <20240126143341.2101237-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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

From: Nikita Ostrenkov <n.ostrenkov@gmail.com>

Signed-off-by: Nikita Ostrenkov <n.ostrenkov@gmail.com>
Message-id: 20240108140325.1291-1-n.ostrenkov@gmail.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/fsl-imx6.h | 44 ++++++++++++++++++++-------------------
 hw/arm/fsl-imx6.c         | 25 ++++++++++++++++++++++
 hw/arm/Kconfig            |  2 ++
 3 files changed, 50 insertions(+), 21 deletions(-)

diff --git a/include/hw/arm/fsl-imx6.h b/include/hw/arm/fsl-imx6.h
index 519b871014a..61c593ffd24 100644
--- a/include/hw/arm/fsl-imx6.h
+++ b/include/hw/arm/fsl-imx6.h
@@ -32,6 +32,7 @@
 #include "hw/net/imx_fec.h"
 #include "hw/usb/chipidea.h"
 #include "hw/usb/imx-usb-phy.h"
+#include "hw/pci-host/designware.h"
 #include "exec/memory.h"
 #include "cpu.h"
 #include "qom/object.h"
@@ -55,27 +56,28 @@ struct FslIMX6State {
     DeviceState parent_obj;
 
     /*< public >*/
-    ARMCPU         cpu[FSL_IMX6_NUM_CPUS];
-    A9MPPrivState  a9mpcore;
-    IMX6CCMState   ccm;
-    IMX6SRCState   src;
-    IMX7SNVSState  snvs;
-    IMXSerialState uart[FSL_IMX6_NUM_UARTS];
-    IMXGPTState    gpt;
-    IMXEPITState   epit[FSL_IMX6_NUM_EPITS];
-    IMXI2CState    i2c[FSL_IMX6_NUM_I2CS];
-    IMXGPIOState   gpio[FSL_IMX6_NUM_GPIOS];
-    SDHCIState     esdhc[FSL_IMX6_NUM_ESDHCS];
-    IMXSPIState    spi[FSL_IMX6_NUM_ECSPIS];
-    IMX2WdtState   wdt[FSL_IMX6_NUM_WDTS];
-    IMXUSBPHYState usbphy[FSL_IMX6_NUM_USB_PHYS];
-    ChipideaState  usb[FSL_IMX6_NUM_USBS];
-    IMXFECState    eth;
-    MemoryRegion   rom;
-    MemoryRegion   caam;
-    MemoryRegion   ocram;
-    MemoryRegion   ocram_alias;
-    uint32_t       phy_num;
+    ARMCPU             cpu[FSL_IMX6_NUM_CPUS];
+    A9MPPrivState      a9mpcore;
+    IMX6CCMState       ccm;
+    IMX6SRCState       src;
+    IMX7SNVSState      snvs;
+    IMXSerialState     uart[FSL_IMX6_NUM_UARTS];
+    IMXGPTState        gpt;
+    IMXEPITState       epit[FSL_IMX6_NUM_EPITS];
+    IMXI2CState        i2c[FSL_IMX6_NUM_I2CS];
+    IMXGPIOState       gpio[FSL_IMX6_NUM_GPIOS];
+    SDHCIState         esdhc[FSL_IMX6_NUM_ESDHCS];
+    IMXSPIState        spi[FSL_IMX6_NUM_ECSPIS];
+    IMX2WdtState       wdt[FSL_IMX6_NUM_WDTS];
+    IMXUSBPHYState     usbphy[FSL_IMX6_NUM_USB_PHYS];
+    ChipideaState      usb[FSL_IMX6_NUM_USBS];
+    IMXFECState        eth;
+    DesignwarePCIEHost pcie;
+    MemoryRegion       rom;
+    MemoryRegion       caam;
+    MemoryRegion       ocram;
+    MemoryRegion       ocram_alias;
+    uint32_t           phy_num;
 };
 
 
diff --git a/hw/arm/fsl-imx6.c b/hw/arm/fsl-imx6.c
index 42f90588251..b7f93d8d9ce 100644
--- a/hw/arm/fsl-imx6.c
+++ b/hw/arm/fsl-imx6.c
@@ -22,6 +22,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "hw/arm/fsl-imx6.h"
+#include "hw/misc/unimp.h"
 #include "hw/usb/imx-usb-phy.h"
 #include "hw/boards.h"
 #include "hw/qdev-properties.h"
@@ -103,6 +104,8 @@ static void fsl_imx6_init(Object *obj)
 
 
     object_initialize_child(obj, "eth", &s->eth, TYPE_IMX_ENET);
+
+    object_initialize_child(obj, "pcie", &s->pcie, TYPE_DESIGNWARE_PCIE_HOST);
 }
 
 static void fsl_imx6_realize(DeviceState *dev, Error **errp)
@@ -110,6 +113,7 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
     MachineState *ms = MACHINE(qdev_get_machine());
     FslIMX6State *s = FSL_IMX6(dev);
     uint16_t i;
+    qemu_irq irq;
     unsigned int smp_cpus = ms->smp.cpus;
 
     if (smp_cpus > FSL_IMX6_NUM_CPUS) {
@@ -425,6 +429,27 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
                                             FSL_IMX6_WDOGn_IRQ[i]));
     }
 
+    /*
+     * PCIe
+     */
+    sysbus_realize(SYS_BUS_DEVICE(&s->pcie), &error_abort);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->pcie), 0, FSL_IMX6_PCIe_REG_ADDR);
+
+    irq = qdev_get_gpio_in(DEVICE(&s->a9mpcore), FSL_IMX6_PCIE1_IRQ);
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->pcie), 0, irq);
+    irq = qdev_get_gpio_in(DEVICE(&s->a9mpcore), FSL_IMX6_PCIE2_IRQ);
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->pcie), 1, irq);
+    irq = qdev_get_gpio_in(DEVICE(&s->a9mpcore), FSL_IMX6_PCIE3_IRQ);
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->pcie), 2, irq);
+    irq = qdev_get_gpio_in(DEVICE(&s->a9mpcore), FSL_IMX6_PCIE4_IRQ);
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->pcie), 3, irq);
+
+    /*
+     * PCIe PHY
+     */
+    create_unimplemented_device("pcie-phy", FSL_IMX6_PCIe_ADDR,
+                                FSL_IMX6_PCIe_SIZE);
+
     /* ROM memory */
     if (!memory_region_init_rom(&s->rom, OBJECT(dev), "imx6.rom",
                                 FSL_IMX6_ROM_SIZE, errp)) {
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 2bc3ea3425e..f927878152a 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -547,6 +547,7 @@ config FSL_IMX31
 
 config FSL_IMX6
     bool
+    imply PCIE_DEVICES
     imply I2C_DEVICES
     select A9MPCORE
     select IMX
@@ -555,6 +556,7 @@ config FSL_IMX6
     select IMX_USBPHY
     select WDT_IMX2
     select PL310  # cache controller
+    select PCI_EXPRESS_DESIGNWARE
     select SDHCI
 
 config ASPEED_SOC
-- 
2.34.1


