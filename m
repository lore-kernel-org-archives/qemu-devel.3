Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4F47C02181
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2025 20:41:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZyXP-0003xp-VL; Mon, 20 Jan 2025 15:38:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tZyXI-0003ua-HY; Mon, 20 Jan 2025 15:38:17 -0500
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tZyXG-0002WW-6t; Mon, 20 Jan 2025 15:38:16 -0500
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-aaeef97ff02so804202866b.1; 
 Mon, 20 Jan 2025 12:38:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737405490; x=1738010290; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EYY3al5WRrxC6R6b/f0OdeU+PLZylXq4p3ajVfNQGuw=;
 b=nJQQ6L+ntzpOM+JUp3DknX2Ng8w0aQFebuINE8R1uLew1X85km+YONA7s4eOQehNQv
 ztH4Y3Yd27Gzbj9VS/lcVYw+NV57WvOSc/Lcgx6SWLHYkmFfzogSYk7ZSC/WtyMbZKZ+
 serUmJm10VlNX3q/Cz+cY0g8L1L0MlosE2DpeG/TY0wR0bK3D9vqCh7L1g7wRRrfA/kC
 PT8dN9ft4ce7/p+hEkg+qC140T6Gv+9nHdRnkmmk7Mfs3khnqycryM5IDbkC3k7VCdFL
 ElzFcwrgnPBPht4Ouk0DK/i+wN7tieniDRbOyrKB+MBHsr0ioyKzZp39TmiMI/AWh2eI
 SL0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737405490; x=1738010290;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EYY3al5WRrxC6R6b/f0OdeU+PLZylXq4p3ajVfNQGuw=;
 b=sjXqzVnQ3WSZPtCnI3SNmJa09F7XfkB1OqGJuCEBR5wJjRs7XplMydG6BDx9ouvRxo
 cbFY0QbHkERHwSmlWLzB7GssaTBkCwiuUO1QiG7iPDPArjZktbW5LbriDbBzy+46wemj
 V+yMlFwxbtrb1/MgRZ1Pn2k3L56gEt//BL9Pv0s/uZG0HV4QeZOvJyckVUD+V4vrLYmI
 oKVmHjO1iV5odIz0r5DYrH0nkQhZRlQEWgoBZGT/CzfnXTxqmwPH61TnUQo14qg3LHpj
 wTUOa8X0vCdlM5pJpUMMnMiyF2eEdiTuDtIw/Yzd5GK51CFdm4cwQMLvV2UG5pxHEdDm
 PKVQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhefwpjR9bqB/dznI+Qu5KcQHTmOyuyioMG/b8R9fWGNWC9OfgnOoA82AuOpHiTounh8o62SUIAg==@nongnu.org
X-Gm-Message-State: AOJu0YxM4UxitKxhX/3lL34f91kmjvCvAsE1OkF8Xqh1Z6vxKudaQt7k
 A9nu6EkHts76+i5Mx6ULDfMKoSDX9RuI4C2niPCJde717LjNmA7uGjka/lJ/
X-Gm-Gg: ASbGnctv38KQ215TWavOl7frmQG8IKchKiaz+eJpEmTemPf9aRQ0ytviwf9hEAhSxFu
 NS+r7yBX62RYgOWvhct7x7jx0fcitFwsH2HukwWnDhVRDjwztOg/6tf13EblVqAcrji+FbGyrka
 JMkgeNZU8hg+yoyLRz7KHEUtK0XxJhqVJXBXCZkVupkRstWblxGiAi3eyeecMim1YM+DCzvaBGv
 nj9YhjDbf9P+vUf+GlRqygN84XmnoH5UR0u7gOvXl6qc4Ov8zrsoYdSHS7iYj1xrdnbYx/HLByU
 Fk3Dk7XrVPJBE7NsMKkYc2s61meN+5Yo3K3ODS702IjUtpxSDdhLJxhekZff
X-Google-Smtp-Source: AGHT+IFUUrZzlvt1XyXigpEsdzLk622XlHSOzDSApTpf3kpadKTCx4Dz33PrVb6sppQ4OKHAL4idOA==
X-Received: by 2002:a17:906:f598:b0:aa6:832b:8d76 with SMTP id
 a640c23a62f3a-ab38b1919f3mr1418008466b.12.1737405489821; 
 Mon, 20 Jan 2025 12:38:09 -0800 (PST)
Received: from Provence.localdomain
 (dynamic-077-183-181-102.77.183.pool.telefonica.de. [77.183.181.102])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5db7364258csm6021077a12.1.2025.01.20.12.38.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2025 12:38:09 -0800 (PST)
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
Subject: [PATCH 09/21] hw/arm/fsl-imx8mp: Add PCIe support
Date: Mon, 20 Jan 2025 21:37:36 +0100
Message-ID: <20250120203748.4687-10-shentey@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250120203748.4687-1-shentey@gmail.com>
References: <20250120203748.4687-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x636.google.com
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
 docs/system/arm/imx8mp-evk.rst      | 13 +++++
 include/hw/arm/fsl-imx8mp.h         | 10 ++++
 include/hw/pci-host/fsl_imx8m_phy.h | 27 +++++++++
 hw/arm/fsl-imx8mp.c                 | 30 ++++++++++
 hw/pci-host/fsl_imx8m_phy.c         | 88 +++++++++++++++++++++++++++++
 hw/arm/Kconfig                      |  3 +
 hw/pci-host/Kconfig                 |  3 +
 hw/pci-host/meson.build             |  1 +
 9 files changed, 177 insertions(+)
 create mode 100644 include/hw/pci-host/fsl_imx8m_phy.h
 create mode 100644 hw/pci-host/fsl_imx8m_phy.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 3c60581fe7..76b416831d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -826,8 +826,10 @@ S: Odd Fixes
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
index 1514bc5864..8d48580cb4 100644
--- a/docs/system/arm/imx8mp-evk.rst
+++ b/docs/system/arm/imx8mp-evk.rst
@@ -14,6 +14,7 @@ The ``imx8mp-evk`` machine implements the following devices:
  * Generic Interrupt Controller (GICv3)
  * 4 UARTs
  * 3 USDHC Storage Controllers
+ * 1 Designware PCI Express Controller
  * Secure Non-Volatile Storage (SNVS) including an RTC
  * Clock Tree
 
@@ -62,3 +63,15 @@ Now that everything is prepared the newly built image can be run in the QEMU
       -dtb imx8mp-evk-patched.dtb \
       -append "root=/dev/mmcblk2p2" \
       -drive file=sdcard.img,if=sd,bus=2,format=raw,id=mmcblk2
+
+Using PCI Devices
+-----------------
+
+The PCI Express controller spawns two PCI buses, of which only one can be used.
+By default QEMU assigns the wrong bus, so the correct one has to be specified
+manually by adding ``bus=dw-pcie``. For example, when adding an Intel e1000
+network card, the command line looks like:
+
+.. code-block:: bash
+
+  $ qemu-system-aarch64 -M imximp-evk ... -device virtio-net-pci,bus=dw-pcie
diff --git a/include/hw/arm/fsl-imx8mp.h b/include/hw/arm/fsl-imx8mp.h
index 9832c05e8c..bc80a21966 100644
--- a/include/hw/arm/fsl-imx8mp.h
+++ b/include/hw/arm/fsl-imx8mp.h
@@ -14,6 +14,8 @@
 #include "hw/intc/arm_gicv3_common.h"
 #include "hw/misc/imx7_snvs.h"
 #include "hw/misc/imx8mp_ccm.h"
+#include "hw/pci-host/designware.h"
+#include "hw/pci-host/fsl_imx8m_phy.h"
 #include "hw/sd/sdhci.h"
 #include "qom/object.h"
 #include "qemu/units.h"
@@ -41,6 +43,8 @@ struct FslImx8mpState {
     IMX7SNVSState      snvs;
     IMXSerialState     uart[FSL_IMX8MP_NUM_UARTS];
     SDHCIState         usdhc[FSL_IMX8MP_NUM_USDHCS];
+    DesignwarePCIEHost pcie;
+    FslImx8mPciePhyState   pcie_phy;
 };
 
 enum FslImx8mpMemoryRegions {
@@ -196,6 +200,12 @@ enum FslImx8mpIrqs {
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
index 612ea7bf93..d15dcaa9de 100644
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
index f880c03d35..f065718416 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -579,9 +579,12 @@ config FSL_IMX7
 
 config FSL_IMX8MP
     bool
+    imply PCI_DEVICES
     imply TEST_DEVICES
     select ARM_GIC
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


