Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AF7DC021B8
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 18:13:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmzM9-0007CN-KR; Tue, 25 Feb 2025 13:08:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tmzJi-0000I1-H1
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 13:06:11 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tmzJc-0002Lq-IK
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 13:05:59 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-38f2f391864so3400748f8f.3
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2025 10:05:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740506753; x=1741111553; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=8TfRpvVjP1td9lDamMe8/fHW/3L3sNQR50jxgFyPklo=;
 b=HKXWr2xoYD6TW5hdi5GMr6FI9/FsmpLsoSmeDZwPYUqE8XJpqjG1x4AOIzTNjVC13n
 AklROgxGuxZofqk9b2HZqw78Zv6FTkPRV/VbUC1bN5aKhNB7zbz602HYys0NPCiYk5pv
 Hx53fnpDRQZ5LjmwhnJ/MA5lZm3go6gVoRbR6VptR/pN5y1Kbz75eChM53ZVmgBFmmiO
 Q2vZi9zRV8AxcR/O+pfuMdjyxPkREZmpnJxUy/38CGKJ1Q8Ws0fuvzm00heb5qw95cyN
 7SA9RwEY6v3fjkINcnUnI8tXOnOlYKzGS7WoOQGxKZ+4pjfPrUaDXmK2A3WzUTbSG0dl
 uKVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740506753; x=1741111553;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8TfRpvVjP1td9lDamMe8/fHW/3L3sNQR50jxgFyPklo=;
 b=oEdlMfzvkfenwetdHvIJW5ESa78aaOItmhMZ1zmRMMgm5AbUANQy1aHMTjoAfcQV2s
 aZWYX0v19EY+gMQg0nx/weowiIIYnWc6eZlC3IS+ZtUzMA4a3wBG+oFJUKTfsoemfOMk
 W0kUG2sget3Eja/vo8YFZ6EbGjH/EtUdG2tb5D40QOmfGq6jCTDlVzX+FEviX5Wamw68
 JXUPUrVXIHItp42jrxLEz55onSGZYhWZazOQSlkqLJQ/yEhnDmRn+S6cYwuldmLsHzRm
 lHCitMsgoEHgMGYDtb7rA/Vfi/IXM0lsuJAnTDdp+zOLF5tIu/UmeuyV58Ap2n488/qp
 yqpw==
X-Gm-Message-State: AOJu0YxYr8+wSEGY6qe82lKXYpiEpMm0f/O3EMy/oQYH0sh0aObOywNJ
 1kQuNoLenxGfAPRBKi47j5kAHNOh3fwlkCeIGebmnYxxbx3+ho6HGBeG/A5WpNhp97Q9yqebs87
 u
X-Gm-Gg: ASbGnctHC/+PjsZoI2HRQyNU5eskgD/sPLUZdU9rEJQdFu3YdWZcGgJwtFaxlZ+zGTd
 /eqm+goy8n5s8vvtO7pvXpQiutxpISmcrWWs8sTU/oDqQEl17VNlsuirHCI4nsLU0b0lgwehDa0
 g1YTQAGwk1Z0/3/DArHX/w4iap/r7dZ74yvesupk6Wpcp1w74BdY+XqRuuisSpkeWCvRU3BS+Ka
 LaR/V5PSespA+bLVk3jNEYaukBJ59BEkG6u1PaQFBBXGpRzV+ZMyKTCBWWC/EndEMBmqVY8Sdwq
 xP2v/Nt2J4ia0SdGyUpOTtbydGOlmWdW
X-Google-Smtp-Source: AGHT+IFffE+yoPy0aazj//KQ6kUEO8gQMc1ouR8nXoVgrC6Z4MYvDTjzJXPn+8VVgZIt6i/Pi5HGZQ==
X-Received: by 2002:a05:6000:4013:b0:38d:d4b5:84cf with SMTP id
 ffacd0b85a97d-390d4f3681cmr174940f8f.5.1740506752838; 
 Tue, 25 Feb 2025 10:05:52 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ab156a136sm35147875e9.35.2025.02.25.10.05.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2025 10:05:52 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 35/43] hw/arm/fsl-imx8mp: Add PCIe support
Date: Tue, 25 Feb 2025 18:05:01 +0000
Message-ID: <20250225180510.1318207-36-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250225180510.1318207-1-peter.maydell@linaro.org>
References: <20250225180510.1318207-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42e.google.com
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

From: Bernhard Beschow <shentey@gmail.com>

Linux checks for the PLLs in the PHY to be locked, so implement a model
emulating that.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Message-id: 20250223114708.1780-9-shentey@gmail.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 MAINTAINERS                         |  2 +
 docs/system/arm/imx8mp-evk.rst      |  1 +
 include/hw/arm/fsl-imx8mp.h         | 10 +++
 include/hw/pci-host/fsl_imx8m_phy.h | 28 +++++++++
 hw/arm/fsl-imx8mp.c                 | 30 +++++++++
 hw/pci-host/fsl_imx8m_phy.c         | 98 +++++++++++++++++++++++++++++
 hw/arm/Kconfig                      |  3 +
 hw/pci-host/Kconfig                 |  3 +
 hw/pci-host/meson.build             |  1 +
 9 files changed, 176 insertions(+)
 create mode 100644 include/hw/pci-host/fsl_imx8m_phy.h
 create mode 100644 hw/pci-host/fsl_imx8m_phy.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 8ea7fb4c7a0..2e7fc6fa912 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -827,8 +827,10 @@ S: Maintained
 F: hw/arm/imx8mp-evk.c
 F: hw/arm/fsl-imx8mp.c
 F: hw/misc/imx8mp_*.c
+F: hw/pci-host/fsl_imx8m_phy.c
 F: include/hw/arm/fsl-imx8mp.h
 F: include/hw/misc/imx8mp_*.h
+F: include/hw/pci-host/fsl_imx8m_phy.h
 F: docs/system/arm/imx8mp-evk.rst
 
 MPS2 / MPS3
diff --git a/docs/system/arm/imx8mp-evk.rst b/docs/system/arm/imx8mp-evk.rst
index 879c822356f..18a8fdd2785 100644
--- a/docs/system/arm/imx8mp-evk.rst
+++ b/docs/system/arm/imx8mp-evk.rst
@@ -13,6 +13,7 @@ The ``imx8mp-evk`` machine implements the following devices:
  * Generic Interrupt Controller (GICv3)
  * 4 UARTs
  * 3 USDHC Storage Controllers
+ * 1 Designware PCI Express Controller
  * Secure Non-Volatile Storage (SNVS) including an RTC
  * Clock Tree
 
diff --git a/include/hw/arm/fsl-imx8mp.h b/include/hw/arm/fsl-imx8mp.h
index 349d55ca88d..4c70c887a89 100644
--- a/include/hw/arm/fsl-imx8mp.h
+++ b/include/hw/arm/fsl-imx8mp.h
@@ -15,6 +15,8 @@
 #include "hw/misc/imx7_snvs.h"
 #include "hw/misc/imx8mp_analog.h"
 #include "hw/misc/imx8mp_ccm.h"
+#include "hw/pci-host/designware.h"
+#include "hw/pci-host/fsl_imx8m_phy.h"
 #include "hw/sd/sdhci.h"
 #include "qom/object.h"
 #include "qemu/units.h"
@@ -42,6 +44,8 @@ struct FslImx8mpState {
     IMX7SNVSState      snvs;
     IMXSerialState     uart[FSL_IMX8MP_NUM_UARTS];
     SDHCIState         usdhc[FSL_IMX8MP_NUM_USDHCS];
+    DesignwarePCIEHost pcie;
+    FslImx8mPciePhyState   pcie_phy;
 };
 
 enum FslImx8mpMemoryRegions {
@@ -197,6 +201,12 @@ enum FslImx8mpIrqs {
     FSL_IMX8MP_UART4_IRQ    = 29,
     FSL_IMX8MP_UART5_IRQ    = 30,
     FSL_IMX8MP_UART6_IRQ    = 16,
+
+    FSL_IMX8MP_PCI_INTA_IRQ = 126,
+    FSL_IMX8MP_PCI_INTB_IRQ = 125,
+    FSL_IMX8MP_PCI_INTC_IRQ = 124,
+    FSL_IMX8MP_PCI_INTD_IRQ = 123,
+    FSL_IMX8MP_PCI_MSI_IRQ  = 140,
 };
 
 #endif /* FSL_IMX8MP_H */
diff --git a/include/hw/pci-host/fsl_imx8m_phy.h b/include/hw/pci-host/fsl_imx8m_phy.h
new file mode 100644
index 00000000000..4f4875b37d7
--- /dev/null
+++ b/include/hw/pci-host/fsl_imx8m_phy.h
@@ -0,0 +1,28 @@
+/*
+ * i.MX8 PCIe PHY emulation
+ *
+ * Copyright (c) 2025 Bernhard Beschow <shentey@gmail.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_PCIHOST_FSLIMX8MPCIEPHY_H
+#define HW_PCIHOST_FSLIMX8MPCIEPHY_H
+
+#include "hw/sysbus.h"
+#include "qom/object.h"
+#include "exec/memory.h"
+
+#define TYPE_FSL_IMX8M_PCIE_PHY "fsl-imx8m-pcie-phy"
+OBJECT_DECLARE_SIMPLE_TYPE(FslImx8mPciePhyState, FSL_IMX8M_PCIE_PHY)
+
+#define FSL_IMX8M_PCIE_PHY_DATA_SIZE 0x800
+
+struct FslImx8mPciePhyState {
+    SysBusDevice parent_obj;
+
+    MemoryRegion iomem;
+    uint8_t data[FSL_IMX8M_PCIE_PHY_DATA_SIZE];
+};
+
+#endif
diff --git a/hw/arm/fsl-imx8mp.c b/hw/arm/fsl-imx8mp.c
index da9eaeb6ff0..1ee681ac1d7 100644
--- a/hw/arm/fsl-imx8mp.c
+++ b/hw/arm/fsl-imx8mp.c
@@ -212,6 +212,10 @@ static void fsl_imx8mp_init(Object *obj)
         g_autofree char *name = g_strdup_printf("usdhc%d", i + 1);
         object_initialize_child(obj, name, &s->usdhc[i], TYPE_IMX_USDHC);
     }
+
+    object_initialize_child(obj, "pcie", &s->pcie, TYPE_DESIGNWARE_PCIE_HOST);
+    object_initialize_child(obj, "pcie_phy", &s->pcie_phy,
+                            TYPE_FSL_IMX8M_PCIE_PHY);
 }
 
 static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
@@ -380,6 +384,30 @@ static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->snvs), 0,
                     fsl_imx8mp_memmap[FSL_IMX8MP_SNVS_HP].addr);
 
+    /* PCIe */
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->pcie), errp)) {
+        return;
+    }
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->pcie), 0,
+                    fsl_imx8mp_memmap[FSL_IMX8MP_PCIE1].addr);
+
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->pcie), 0,
+                       qdev_get_gpio_in(gicdev, FSL_IMX8MP_PCI_INTA_IRQ));
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->pcie), 1,
+                       qdev_get_gpio_in(gicdev, FSL_IMX8MP_PCI_INTB_IRQ));
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->pcie), 2,
+                       qdev_get_gpio_in(gicdev, FSL_IMX8MP_PCI_INTC_IRQ));
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->pcie), 3,
+                       qdev_get_gpio_in(gicdev, FSL_IMX8MP_PCI_INTD_IRQ));
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->pcie), 4,
+                       qdev_get_gpio_in(gicdev, FSL_IMX8MP_PCI_MSI_IRQ));
+
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->pcie_phy), errp)) {
+        return;
+    }
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->pcie_phy), 0,
+                    fsl_imx8mp_memmap[FSL_IMX8MP_PCIE_PHY1].addr);
+
     /* Unimplemented devices */
     for (i = 0; i < ARRAY_SIZE(fsl_imx8mp_memmap); i++) {
         switch (i) {
@@ -387,6 +415,8 @@ static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
         case FSL_IMX8MP_CCM:
         case FSL_IMX8MP_GIC_DIST:
         case FSL_IMX8MP_GIC_REDIST:
+        case FSL_IMX8MP_PCIE1:
+        case FSL_IMX8MP_PCIE_PHY1:
         case FSL_IMX8MP_RAM:
         case FSL_IMX8MP_SNVS_HP:
         case FSL_IMX8MP_UART1 ... FSL_IMX8MP_UART4:
diff --git a/hw/pci-host/fsl_imx8m_phy.c b/hw/pci-host/fsl_imx8m_phy.c
new file mode 100644
index 00000000000..aa304b102b3
--- /dev/null
+++ b/hw/pci-host/fsl_imx8m_phy.c
@@ -0,0 +1,98 @@
+/*
+ * i.MX8 PCIe PHY emulation
+ *
+ * Copyright (c) 2025 Bernhard Beschow <shentey@gmail.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/pci-host/fsl_imx8m_phy.h"
+#include "hw/resettable.h"
+#include "migration/vmstate.h"
+
+#define CMN_REG075 0x1d4
+#define ANA_PLL_LOCK_DONE BIT(1)
+#define ANA_PLL_AFC_DONE BIT(0)
+
+static uint64_t fsl_imx8m_pcie_phy_read(void *opaque, hwaddr offset,
+                                        unsigned size)
+{
+    FslImx8mPciePhyState *s = opaque;
+
+    if (offset == CMN_REG075) {
+        return s->data[offset] | ANA_PLL_LOCK_DONE | ANA_PLL_AFC_DONE;
+    }
+
+    return s->data[offset];
+}
+
+static void fsl_imx8m_pcie_phy_write(void *opaque, hwaddr offset,
+                                     uint64_t value, unsigned size)
+{
+    FslImx8mPciePhyState *s = opaque;
+
+    s->data[offset] = value;
+}
+
+static const MemoryRegionOps fsl_imx8m_pcie_phy_ops = {
+    .read = fsl_imx8m_pcie_phy_read,
+    .write = fsl_imx8m_pcie_phy_write,
+    .impl = {
+        .min_access_size = 1,
+        .max_access_size = 1,
+    },
+    .valid = {
+        .min_access_size = 1,
+        .max_access_size = 8,
+    },
+    .endianness = DEVICE_LITTLE_ENDIAN,
+};
+
+static void fsl_imx8m_pcie_phy_realize(DeviceState *dev, Error **errp)
+{
+    FslImx8mPciePhyState *s = FSL_IMX8M_PCIE_PHY(dev);
+
+    memory_region_init_io(&s->iomem, OBJECT(s), &fsl_imx8m_pcie_phy_ops, s,
+                          TYPE_FSL_IMX8M_PCIE_PHY, ARRAY_SIZE(s->data));
+    sysbus_init_mmio(SYS_BUS_DEVICE(s), &s->iomem);
+}
+
+static void fsl_imx8m_pcie_phy_reset_hold(Object *obj, ResetType type)
+{
+    FslImx8mPciePhyState *s = FSL_IMX8M_PCIE_PHY(obj);
+
+    memset(s->data, 0, sizeof(s->data));
+}
+
+static const VMStateDescription fsl_imx8m_pcie_phy_vmstate = {
+    .name = "fsl-imx8m-pcie-phy",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT8_ARRAY(data, FslImx8mPciePhyState,
+                            FSL_IMX8M_PCIE_PHY_DATA_SIZE),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void fsl_imx8m_pcie_phy_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
+
+    dc->realize = fsl_imx8m_pcie_phy_realize;
+    dc->vmsd = &fsl_imx8m_pcie_phy_vmstate;
+    rc->phases.hold = fsl_imx8m_pcie_phy_reset_hold;
+}
+
+static const TypeInfo fsl_imx8m_pcie_phy_types[] = {
+    {
+        .name = TYPE_FSL_IMX8M_PCIE_PHY,
+        .parent = TYPE_SYS_BUS_DEVICE,
+        .instance_size = sizeof(FslImx8mPciePhyState),
+        .class_init = fsl_imx8m_pcie_phy_class_init,
+    }
+};
+
+DEFINE_TYPES(fsl_imx8m_pcie_phy_types)
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index d2dda3213db..be5a2c02b74 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -595,10 +595,13 @@ config FSL_IMX7
 
 config FSL_IMX8MP
     bool
+    imply PCI_DEVICES
     select ARM_GIC
     select FSL_IMX8MP_ANALOG
     select FSL_IMX8MP_CCM
     select IMX
+    select PCI_EXPRESS_DESIGNWARE
+    select PCI_EXPRESS_FSL_IMX8M_PHY
     select SDHCI
     select UNIMP
 
diff --git a/hw/pci-host/Kconfig b/hw/pci-host/Kconfig
index c91880b2370..35c04152428 100644
--- a/hw/pci-host/Kconfig
+++ b/hw/pci-host/Kconfig
@@ -99,6 +99,9 @@ config ASTRO
     bool
     select PCI
 
+config PCI_EXPRESS_FSL_IMX8M_PHY
+    bool
+
 config GT64120
     bool
     select PCI
diff --git a/hw/pci-host/meson.build b/hw/pci-host/meson.build
index 3001e93a437..937a0f72acf 100644
--- a/hw/pci-host/meson.build
+++ b/hw/pci-host/meson.build
@@ -28,6 +28,7 @@ pci_ss.add(when: 'CONFIG_ARTICIA', if_true: files('articia.c'))
 pci_ss.add(when: 'CONFIG_MV64361', if_true: files('mv64361.c'))
 
 # ARM devices
+pci_ss.add(when: 'CONFIG_PCI_EXPRESS_FSL_IMX8M_PHY', if_true: files('fsl_imx8m_phy.c'))
 pci_ss.add(when: 'CONFIG_VERSATILE_PCI', if_true: files('versatile.c'))
 
 # HPPA devices
-- 
2.43.0


