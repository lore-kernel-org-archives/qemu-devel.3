Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF887C021B2
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Feb 2025 11:51:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmASR-000067-8T; Sun, 23 Feb 2025 06:47:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tmASP-0008W0-0h; Sun, 23 Feb 2025 06:47:37 -0500
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tmASM-0005wx-PJ; Sun, 23 Feb 2025 06:47:36 -0500
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5e0373c7f55so5370283a12.0; 
 Sun, 23 Feb 2025 03:47:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740311252; x=1740916052; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zWmgMEXKLZZc2terg4VDfwYFyG0jpe4AFP380ivmD84=;
 b=krSeJe0kZ+SQ5l1qehJe4Q5gu8mA37gjz2ITU1I4j5phhpABlDWaGKSpytdJR6dMIK
 bpB6nFLGX9Fn403rwF8gnrT9RN0x47AEc0fIv5zUY1c0T63Yg1L9VA0yN0r6RoeIKJRP
 7tX5LzvulbRBInZoGJ81M64UBOLjfdX/3m/AE+2S9GQZmgmwYmmqKFXkUWC5WIUNRjTe
 o/CCDTEfjpD5Z/1UTl2ErAaV46BpaQos3MeQ4Z1akLApMqkP1h1bhkRFPAxEqYIi/H8x
 C87hVtNZEyGpoaDbkmkF2OSJGejFrn+mXuYUgrzAs8x2LQ47d9NrBot+C6dr6tLTKRQ5
 SlOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740311252; x=1740916052;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zWmgMEXKLZZc2terg4VDfwYFyG0jpe4AFP380ivmD84=;
 b=qlXy4EiCTR64w705ARtR+DDljlkWyn4MO0wWS8HHQ15KKYwHGzspeGqrXt9ETq0zNC
 iRGJJntJ7m41r3haTO2ZX/YJT63hengU+dKjACbkZtTczTvlMdWlrolvaKXxO+qoWSZU
 vqR4zzH2Fg0tC1TY3N8ddozc99qw6qQfPP5nSOUCekkygoclDoj4JQbXwrpjuzEceHVz
 aLgypBxVZaI6pEvzt/8z8U3RxfiTp6ztFi0Wdhk5yAsa9Cn7sVlTwyMkfs4fG30VaBMw
 xlo7Ma8xs+cf7jL01gvFDz1RXk0g3rcpN9WzTC/zQCxzyzPkzA409R9P7nmuYftecEo9
 uruw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWioXCqwatClptgwU/4bjHUtw+hcBLj6H/OSNVBDCZywyTrla6rJjxSHLrhogU8vvMSbgWLux6tKg==@nongnu.org
X-Gm-Message-State: AOJu0YzxKEL9698t1m9kXTOP5Zed8UNublC8idZPHRNRK/jnML3zTBP+
 VakxPcVw/CSZcEBOCS04W2iWEHR20XemdELhfnzZ5F3vrzHxpnvR6ND+sw==
X-Gm-Gg: ASbGncsbGxYFemPosNc59/pNV4uOGyWtf72ueqUs6tFGKcY9qk/uwlZ5RiqLuXALtq9
 znAfhaVV30YKi5LsNS7GigA9oHBr4Cy0ON4G0cq+e5pO2QkCT0/3DVttFULuLIyoSsnOUtk4aBq
 VROs6zSGWUgtOMWc9c97AHAbSSOVohKD1RRkfnuwvRTa9m+GHzB3bdMpwZnPAxiIY3jlUhIBmSp
 4rNTqrRovsOVYn6iAwjIHEZ8KiujwHxr0OyI8FY/DBSje1jV/pzNA48bsRqVvbh5Z0ViFGYHjCF
 Eb3cU91EuCZ3EYBbp3esTAzJy/CbMLetHWSpxP5l8r+0kjCrij/aswlWEZ1/4UKeK3V/q6F8cvU
 KT7yLcVaFDrXi
X-Google-Smtp-Source: AGHT+IH+ijoXMASxM1w1fdQI7XdOg4H4CXxwt8hFYRqlTqW5uoldOMLckJv3krcqN18tWqdBISElCA==
X-Received: by 2002:a17:907:9448:b0:abb:c647:a4c5 with SMTP id
 a640c23a62f3a-abc09bf5326mr988354066b.36.1740311252457; 
 Sun, 23 Feb 2025 03:47:32 -0800 (PST)
Received: from Provence.localdomain
 (dynamic-077-011-167-038.77.11.pool.telefonica.de. [77.11.167.38])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-abba4b9ee98sm1240515466b.167.2025.02.23.03.47.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Feb 2025 03:47:31 -0800 (PST)
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
Subject: [PATCH v2 08/18] hw/arm/fsl-imx8mp: Add PCIe support
Date: Sun, 23 Feb 2025 12:46:58 +0100
Message-ID: <20250223114708.1780-9-shentey@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250223114708.1780-1-shentey@gmail.com>
References: <20250223114708.1780-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x52b.google.com
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
index 8ea7fb4c7a..2e7fc6fa91 100644
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
index 879c822356..18a8fdd278 100644
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
index 0000000000..4f4875b37d
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
index ad26c1e2f0..791d24eec9 100644
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
index 0000000000..aa304b102b
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
index d2dda3213d..be5a2c02b7 100644
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


