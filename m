Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0046C02193
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 09:23:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfF7k-00050a-UN; Tue, 04 Feb 2025 04:21:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tfF7i-0004xR-7x; Tue, 04 Feb 2025 04:21:38 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tfF7f-00054i-PK; Tue, 04 Feb 2025 04:21:37 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-38dae70f5d9so139175f8f.1; 
 Tue, 04 Feb 2025 01:21:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738660892; x=1739265692; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pPk3Zz5sV2k7GKT+6nmWnPhElsFP+GWx5fqykFCdBYs=;
 b=A1y587QTHy2S9+Yo9eKIdeHkf+io4khXvHC5zzfkoPAHvIKP/1wbbtFwvMYWChAFUZ
 EKSbn4odbTr2miznVkQrKA/QLP+jZntEpQtBtPGQWMpzE0J6znX4Q+PVghGMWrAwGbcu
 wv9vML/dz4fA5PYer7G7F1yNFMIQlUXS40ul1S/isUGx3C1kCpO2bVkzNeF53Ot5FWVb
 +O9vnOR6U05hIbA/oag7KvIlApfhq7ffslQv5GzaaNtY80uKglyek/6cg78uuxDtSENe
 k+SIMJ+sAcsUMIqjATBno8i/MlN3fzxvjO9TfXAwOVM4Av2GU34YMgEwANnWi6UIb7b0
 lE/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738660892; x=1739265692;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pPk3Zz5sV2k7GKT+6nmWnPhElsFP+GWx5fqykFCdBYs=;
 b=HPxDBi3QUxRPeNwCojelQpyFuO0vSYZmE7mz72M8OuzrsxuIDjWFTk+lGznA56hi53
 GRJevmb9oVhejPGJgUsLj162VSh5bYLUBsLWDgoMpNssyxSs1RKCvYnWOBxqz4M0uaC6
 P3fapZmcfZHad0asGkuuyB1zLkQWjddxU1M0N4F+W7f6gWhKwHt5CMwnieWvzn0sHnNU
 JiyQ36qxFPym3N1G0JXqtwsLvhuKyUQm0BOiQz0jVqTOgLqQdzEwx1Cp5XOOIFucDFH0
 VmE+xHtsgNCeHOrNYRhnk3pzZwps2DPjLvYImSQpIH+W1EV5UoSPFFO/X0/GJLETJ4rU
 5knw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWdYX9ZW6JhhumgzNCiKpLrmph1qZmM77BlTPoeNQQB6IKB491yYfrtBQcbCNN6RSWYRqSh5w/q1g==@nongnu.org
X-Gm-Message-State: AOJu0YziN8kXgMIQaGp1AkZKak3k9c6f+ek0NPM8ACsDOV+NCeWVlAP0
 utdXkZ3Nv4i/MVq3NXT/T/yoXZPL6xCtvOMRZPJo4nO+gEr+Vxfo/98aOA==
X-Gm-Gg: ASbGncuUiXdD6clB2e3CsuNaqh/mMEtQpl4LDFXcmphqp45r2bzJls2ns6oT4rCdCgx
 gSQ7qmNk4wXZwujQxVmgF+ot1NjMudNvjMTxGhap83reIrqxCuL9M4W3nWUs6gyzuJltDLCL7OW
 VRQQ6WuNieCxdfrxuNzvyOWAQ3SmMM1xJZ7CC7E7gZevY6QYGv038fIKNVAGr6U2p0OHuq51jxH
 SSIqOeBWxJ5qyzetywPZtIn/jaTrjWeThO8M3L02aQUatgrbPTguGMU5lORS/kaaClB3cacmEMW
 qczdvYOuvn0G0/wdmulYWJb48Dmox1NDtG8C4u4FgpFZHar6Y1DUVkOUk4cMpDyEdgRza8OHUil
 17VJ+M3/PQw==
X-Google-Smtp-Source: AGHT+IEe8NP80nniLBOEWYcuaGgWah+0YJ26hAvKFCGs2AYABvcZlqJqi4RoLJt1QxROpDaQzAxyLA==
X-Received: by 2002:a5d:6110:0:b0:385:f220:f788 with SMTP id
 ffacd0b85a97d-38c520b6a59mr17190138f8f.48.1738660890274; 
 Tue, 04 Feb 2025 01:21:30 -0800 (PST)
Received: from Georg-PC.fritz.box
 (p200300faaf0043006a2cae69f03f1c85.dip0.t-ipconnect.de.
 [2003:fa:af00:4300:6a2c:ae69:f03f:1c85])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438e23d42c7sm187233595e9.3.2025.02.04.01.21.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Feb 2025 01:21:29 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Bernhard Beschow <shentey@gmail.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 08/18] hw/arm/fsl-imx8mp: Add PCIe support
Date: Tue,  4 Feb 2025 10:21:02 +0100
Message-ID: <20250204092112.26957-9-shentey@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250204092112.26957-1-shentey@gmail.com>
References: <20250204092112.26957-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=shentey@gmail.com; helo=mail-wr1-x42f.google.com
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

Linux checks for the PLLs in the PHY to be locked, so implement a model
emulating that.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 MAINTAINERS                         |  2 +
 docs/system/arm/imx8mp-evk.rst      |  1 +
 include/hw/arm/fsl-imx8mp.h         | 10 ++++
 include/hw/pci-host/fsl_imx8m_phy.h | 27 +++++++++
 hw/arm/fsl-imx8mp.c                 | 30 ++++++++++
 hw/pci-host/fsl_imx8m_phy.c         | 88 +++++++++++++++++++++++++++++
 hw/arm/Kconfig                      |  3 +
 hw/pci-host/Kconfig                 |  3 +
 hw/pci-host/meson.build             |  1 +
 9 files changed, 165 insertions(+)
 create mode 100644 include/hw/pci-host/fsl_imx8m_phy.h
 create mode 100644 hw/pci-host/fsl_imx8m_phy.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 5b5b0d0bed..94af3d90e4 100644
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
index 475c42d76a..39df695df7 100644
--- a/docs/system/arm/imx8mp-evk.rst
+++ b/docs/system/arm/imx8mp-evk.rst
@@ -14,6 +14,7 @@ The ``imx8mp-evk`` machine implements the following devices:
  * Generic Interrupt Controller (GICv3)
  * 4 UARTs
  * 3 USDHC Storage Controllers
+ * 1 Designware PCI Express Controller
  * Secure Non-Volatile Storage (SNVS) including an RTC
  * Clock Tree
 
diff --git a/include/hw/arm/fsl-imx8mp.h b/include/hw/arm/fsl-imx8mp.h
index 349d55ca88..4c70c887a8 100644
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
index 0000000000..385a904fff
--- /dev/null
+++ b/include/hw/pci-host/fsl_imx8m_phy.h
@@ -0,0 +1,27 @@
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
+
+OBJECT_DECLARE_SIMPLE_TYPE(FslImx8mPciePhyState, FSL_IMX8M_PCIE_PHY)
+
+struct FslImx8mPciePhyState {
+    SysBusDevice parent_obj;
+
+    MemoryRegion iomem;
+    uint8_t data[0x800];
+};
+
+#endif
diff --git a/hw/arm/fsl-imx8mp.c b/hw/arm/fsl-imx8mp.c
index 3e9fedf988..faa6ada183 100644
--- a/hw/arm/fsl-imx8mp.c
+++ b/hw/arm/fsl-imx8mp.c
@@ -215,6 +215,10 @@ static void fsl_imx8mp_init(Object *obj)
         snprintf(name, NAME_SIZE, "usdhc%d", i + 1);
         object_initialize_child(obj, name, &s->usdhc[i], TYPE_IMX_USDHC);
     }
+
+    object_initialize_child(obj, "pcie", &s->pcie, TYPE_DESIGNWARE_PCIE_HOST);
+    object_initialize_child(obj, "pcie_phy", &s->pcie_phy,
+                            TYPE_FSL_IMX8M_PCIE_PHY);
 }
 
 static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
@@ -384,6 +388,30 @@ static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
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
@@ -391,6 +419,8 @@ static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
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
index 0000000000..2f70e15c91
--- /dev/null
+++ b/hw/pci-host/fsl_imx8m_phy.c
@@ -0,0 +1,88 @@
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
+    .endianness = DEVICE_NATIVE_ENDIAN,
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
+static const VMStateDescription fsl_imx8m_pcie_phy_vmstate = {
+    .name = "fsl-imx8m-pcie-phy",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT8_ARRAY(data, FslImx8mPciePhyState,
+                            ARRAY_SIZE(((FslImx8mPciePhyState *)NULL)->data)),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void fsl_imx8m_pcie_phy_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->realize = fsl_imx8m_pcie_phy_realize;
+    dc->vmsd = &fsl_imx8m_pcie_phy_vmstate;
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
index 7af8337354..f1e140a29d 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -579,10 +579,13 @@ config FSL_IMX7
 
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
index c91880b237..35c0415242 100644
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
index 3001e93a43..937a0f72ac 100644
--- a/hw/pci-host/meson.build
+++ b/hw/pci-host/meson.build
@@ -28,6 +28,7 @@ pci_ss.add(when: 'CONFIG_ARTICIA', if_true: files('articia.c'))
 pci_ss.add(when: 'CONFIG_MV64361', if_true: files('mv64361.c'))
 
 # ARM devices
+pci_ss.add(when: 'CONFIG_PCI_EXPRESS_FSL_IMX8M_PHY', if_true: files('fsl_imx8m_phy.c'))
 pci_ss.add(when: 'CONFIG_VERSATILE_PCI', if_true: files('versatile.c'))
 
 # HPPA devices
-- 
2.48.1


