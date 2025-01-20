Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05030C02181
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2025 20:41:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZyXS-00040k-VB; Mon, 20 Jan 2025 15:38:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tZyXP-0003xv-V8; Mon, 20 Jan 2025 15:38:23 -0500
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tZyXN-0002Ye-HN; Mon, 20 Jan 2025 15:38:23 -0500
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5d9f06f8cf2so9435444a12.3; 
 Mon, 20 Jan 2025 12:38:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737405499; x=1738010299; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C4sJtWI1vp8C09CMk8BR77gsUXnHFSl6SvV9Tp4EpLU=;
 b=BMCs2vQVhWD7XZxGjfN8vTAMjceS76uuauJLuDN6iHDlNAgicAaV0x6cqLVTlAioMq
 o96K9kZSbv9JGM+Qkb2q0icbNz4NPm+/MUJHAqOzHYFYPffZCSsxmt0/pCnTiJ/J+7pY
 kfkhrlhWp2US5gGem/aL9JKFyIjiRvIcipLhBvkTXlzREWvfk1WNkqsso9/KxZ2BNLAk
 vQBMh4SRQUQXgRDhYCPCgZLSdrRdZ9e3e+6CzamWeppCr4IkrqlRO0dNbRwXLSKODRo8
 klLYmX5yEe6H5dLhMBGSDqx97QyuTd7GXftheVvUY/xzhR2etX2mrKyqvIwXWcCvhY7b
 YGuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737405499; x=1738010299;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C4sJtWI1vp8C09CMk8BR77gsUXnHFSl6SvV9Tp4EpLU=;
 b=PzqOWR8EoxlNLrpvqNTeypmLHSOetrD4/2IsxncxrPCu772LUwuXwWzB+nS45f6YGo
 64cSSvAhVwQy2TirINdG4a/AFZY/YnLT6LKKet9FGEQV7GmzuH7xYlqJrE2hxvfgs6lQ
 TUjHKg1KsGjCbaVsq4t9hJKnZMBww/ONGLdm+AXAV69sP56DIy6H7NkecsZ+ueVb9dS6
 Vo7wnUwG9JyJWXqpNwXbdwADAYaSp6XZmcwxL2UgH+pYRgY/Lr1NnaOHTaky18dvVsR9
 EDf1Pzgc3NtQVu+P81xIG7cUAVXIEwRr/543jw9o44dA/s0vGBJLg29+Q3qC8qzr+PAK
 mYhw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUd00CYniobsbc8vmShlO5jWHX5wovZP2ZWzCmHMahQtPOnqcaGq8y2gSRdDluoHeeATdTUCHsXg==@nongnu.org
X-Gm-Message-State: AOJu0YxvwiKgdTYtr1igdSeoHzf71Zcndoco80JY5sUYj5sftiEnfVZU
 YR0fRyXtvCpGN2cw52SjmVmq3VcLI86Ly9FClQpu7Kwx03nuVK8KGorTEm4Y
X-Gm-Gg: ASbGncsuSANg7XLdbZ0dsRptWEW4U7Lw4W4CTHmaaHbtI8dU4ptwXXFR6nvc+w2CT8p
 fsq/ATp9fkC4cnZBjaiuH9rFV7i0+giuuOVJtF7ldplq0svz/b2zUYPnLeazoMJyZoSWtXjh6dI
 pg8+C3zl/hbRc+6QpSqWWATPrZ2vSkr8g3jMZ/fCp3CMj4Bv3O0zLxiFkCvSdJtu0/p4HdjOa3V
 1pZvR+Uxd2kldEOSfLTIIYLRJzrO+UTcbWwV07sN31qg371921N1xFR9+rN3TZAEZRTzJiIfkks
 qpYfMU6nW+xaOfBsgiPrLnofaPea45Qtzf4MOAhnAz2gHs24A6OvG3FWdh5D
X-Google-Smtp-Source: AGHT+IFYphbnwNHKYb9MwjU5FObRvN2DEOahE9sJN+uXrcXwofRLH3jO1Rka4XSK2Qmc+W+SaPADkQ==
X-Received: by 2002:a05:6402:2683:b0:5db:6880:360 with SMTP id
 4fb4d7f45d1cf-5db7d2f9bbcmr13104592a12.9.1737405499096; 
 Mon, 20 Jan 2025 12:38:19 -0800 (PST)
Received: from Provence.localdomain
 (dynamic-077-183-181-102.77.183.pool.telefonica.de. [77.183.181.102])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5db7364258csm6021077a12.1.2025.01.20.12.38.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2025 12:38:18 -0800 (PST)
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
Subject: [PATCH 15/21] hw/arm/fsl-imx8mp: Add Ethernet controller
Date: Mon, 20 Jan 2025 21:37:42 +0100
Message-ID: <20250120203748.4687-16-shentey@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250120203748.4687-1-shentey@gmail.com>
References: <20250120203748.4687-1-shentey@gmail.com>
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

The i.MX 8M Plus SoC actually has two ethernet controllers, the usual ENET one
and a Designware one. There is no device model for the latter, so only add the
ENET one.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 docs/system/arm/imx8mp-evk.rst |  1 +
 include/hw/arm/fsl-imx8mp.h    |  8 ++++++++
 hw/arm/fsl-imx8mp.c            | 24 ++++++++++++++++++++++++
 hw/arm/imx8mp-evk.c            |  1 +
 hw/arm/Kconfig                 |  1 +
 5 files changed, 35 insertions(+)

diff --git a/docs/system/arm/imx8mp-evk.rst b/docs/system/arm/imx8mp-evk.rst
index 8a17b170c0..a3a17fc41f 100644
--- a/docs/system/arm/imx8mp-evk.rst
+++ b/docs/system/arm/imx8mp-evk.rst
@@ -15,6 +15,7 @@ The ``imx8mp-evk`` machine implements the following devices:
  * 4 UARTs
  * 3 USDHC Storage Controllers
  * 1 Designware PCI Express Controller
+ * 1 Ethernet Controller
  * 5 GPIO Controllers
  * 6 I2C Controllers
  * 3 SPI Controllers
diff --git a/include/hw/arm/fsl-imx8mp.h b/include/hw/arm/fsl-imx8mp.h
index bceaf1ffd6..8fe27ac9bd 100644
--- a/include/hw/arm/fsl-imx8mp.h
+++ b/include/hw/arm/fsl-imx8mp.h
@@ -16,6 +16,7 @@
 #include "hw/intc/arm_gicv3_common.h"
 #include "hw/misc/imx7_snvs.h"
 #include "hw/misc/imx8mp_ccm.h"
+#include "hw/net/imx_fec.h"
 #include "hw/or-irq.h"
 #include "hw/pci-host/designware.h"
 #include "hw/pci-host/fsl_imx8m_phy.h"
@@ -57,11 +58,15 @@ struct FslImx8mpState {
     IMXSPIState        spi[FSL_IMX8MP_NUM_ECSPIS];
     IMXI2CState        i2c[FSL_IMX8MP_NUM_I2CS];
     IMXSerialState     uart[FSL_IMX8MP_NUM_UARTS];
+    IMXFECState        enet;
     SDHCIState         usdhc[FSL_IMX8MP_NUM_USDHCS];
     IMX2WdtState       wdt[FSL_IMX8MP_NUM_WDTS];
     DesignwarePCIEHost pcie;
     FslImx8mPciePhyState   pcie_phy;
     OrIRQState         gpt5_gpt6_irq;
+
+    uint32_t           phy_num;
+    bool               phy_connected;
 };
 
 enum FslImx8mpMemoryRegions {
@@ -252,6 +257,9 @@ enum FslImx8mpIrqs {
     FSL_IMX8MP_WDOG2_IRQ    = 79,
     FSL_IMX8MP_WDOG3_IRQ    = 10,
 
+    FSL_IMX8MP_ENET1_MAC_IRQ    = 118,
+    FSL_IMX6_ENET1_MAC_1588_IRQ = 121,
+
     FSL_IMX8MP_PCI_INTA_IRQ = 126,
     FSL_IMX8MP_PCI_INTB_IRQ = 125,
     FSL_IMX8MP_PCI_INTC_IRQ = 124,
diff --git a/hw/arm/fsl-imx8mp.c b/hw/arm/fsl-imx8mp.c
index c40811d078..3bb719d0e8 100644
--- a/hw/arm/fsl-imx8mp.c
+++ b/hw/arm/fsl-imx8mp.c
@@ -243,6 +243,8 @@ static void fsl_imx8mp_init(Object *obj)
         object_initialize_child(obj, name, &s->wdt[i], TYPE_IMX2_WDT);
     }
 
+    object_initialize_child(obj, "eth0", &s->enet, TYPE_IMX_ENET);
+
     object_initialize_child(obj, "pcie", &s->pcie, TYPE_DESIGNWARE_PCIE_HOST);
     object_initialize_child(obj, "pcie_phy", &s->pcie_phy,
                             TYPE_FSL_IMX8M_PCIE_PHY);
@@ -546,6 +548,21 @@ static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
                            qdev_get_gpio_in(gicdev, spi_table[i].irq));
     }
 
+    /* ENET1 */
+    object_property_set_uint(OBJECT(&s->enet), "phy-num", s->phy_num,
+                             &error_abort);
+    object_property_set_uint(OBJECT(&s->enet), "tx-ring-num", 3, &error_abort);
+    qemu_configure_nic_device(DEVICE(&s->enet), true, NULL);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->enet), errp)) {
+        return;
+    }
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->enet), 0,
+                    fsl_imx8mp_memmap[FSL_IMX8MP_ENET1].addr);
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->enet), 0,
+                       qdev_get_gpio_in(gicdev, FSL_IMX8MP_ENET1_MAC_IRQ));
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->enet), 1,
+                       qdev_get_gpio_in(gicdev, FSL_IMX6_ENET1_MAC_1588_IRQ));
+
     /* SNVS */
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->snvs), errp)) {
         return;
@@ -608,6 +625,7 @@ static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
         case FSL_IMX8MP_GIC_REDIST:
         case FSL_IMX8MP_GPIO1 ... FSL_IMX8MP_GPIO5:
         case FSL_IMX8MP_ECSPI1 ... FSL_IMX8MP_ECSPI3:
+        case FSL_IMX8MP_ENET1:
         case FSL_IMX8MP_I2C1 ... FSL_IMX8MP_I2C6:
         case FSL_IMX8MP_PCIE1:
         case FSL_IMX8MP_PCIE_PHY1:
@@ -628,10 +646,16 @@ static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
     }
 }
 
+static const Property fsl_imx8mp_properties[] = {
+    DEFINE_PROP_UINT32("fec1-phy-num", FslImx8mpState, phy_num, 0),
+    DEFINE_PROP_BOOL("fec1-phy-connected", FslImx8mpState, phy_connected, true),
+};
+
 static void fsl_imx8mp_class_init(ObjectClass *oc, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
 
+    device_class_set_props(dc, fsl_imx8mp_properties);
     dc->realize = fsl_imx8mp_realize;
 
     dc->desc = "i.MX 8M Plus SoC";
diff --git a/hw/arm/imx8mp-evk.c b/hw/arm/imx8mp-evk.c
index 27d9e9e8ee..e1a7892fd7 100644
--- a/hw/arm/imx8mp-evk.c
+++ b/hw/arm/imx8mp-evk.c
@@ -36,6 +36,7 @@ static void imx8mp_evk_init(MachineState *machine)
 
     s = FSL_IMX8MP(object_new(TYPE_FSL_IMX8MP));
     object_property_add_child(OBJECT(machine), "soc", OBJECT(s));
+    object_property_set_uint(OBJECT(s), "fec1-phy-num", 1, &error_fatal);
     qdev_realize(DEVICE(s), NULL, &error_fatal);
 
     memory_region_add_subregion(get_system_memory(), FSL_IMX8MP_RAM_START,
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 8ebcf3339e..0e49ac4d5c 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -584,6 +584,7 @@ config FSL_IMX8MP
     imply I2C_DEVICES
     select ARM_GIC
     select IMX
+    select IMX_FEC
     select IMX_I2C
     select OR_IRQ
     select PCI_EXPRESS_DESIGNWARE
-- 
2.48.1


