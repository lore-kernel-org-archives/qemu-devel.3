Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 348E7CA5FFF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 10:13:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEOce-0004WG-0e; Wed, 07 Oct 2026 06:11:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaurav.sharma_7@nxp.com>)
 id 1xEOcN-0004GA-13; Wed, 07 Oct 2026 06:11:25 -0400
Received: from inva020.nxp.com ([92.121.34.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaurav.sharma_7@nxp.com>)
 id 1xEOcK-0004Pi-HZ; Wed, 07 Oct 2026 06:11:22 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 2D1F31A000F;
 Wed,  7 Oct 2026 12:11:19 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id EBD501A0021;
 Wed,  7 Oct 2026 12:11:18 +0200 (CEST)
Received: from lsv031015.swis.in-blr01.nxp.com
 (lsv031015.swis.in-blr01.nxp.com [10.12.177.77])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 02196180023B;
 Wed,  7 Oct 2026 18:11:16 +0800 (+08)
From: Gaurav Sharma <gaurav.sharma_7@nxp.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, pbonzini@redhat.com, peter.maydell@linaro.org,
 shentey@gmail.com, pierrick.bouvier@oss.qualcomm.com,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>
Subject: [PATCHv4 05/11] hw/misc: Add GPR (General Purpose Register) IP to
 iMX8MP
Date: Wed,  7 Oct 2026 15:40:59 +0530
Message-Id: <20261007101105.3917771-6-gaurav.sharma_7@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261007101105.3917771-1-gaurav.sharma_7@nxp.com>
References: <20261007101105.3917771-1-gaurav.sharma_7@nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Received-SPF: pass client-ip=92.121.34.13;
 envelope-from=gaurav.sharma_7@nxp.com; helo=inva020.nxp.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add IOMUXC General Purpose Registers IP and wire it into the i.MX8MP SoC model.
The GPR block provides system-level configuration registers on the i.MX8MP SoC.
It provides general purpose control bits and Cortex-M7 CPUWAIT gate needed for AMP boot

Signed-off-by: Gaurav Sharma <gaurav.sharma_7@nxp.com>
---
 docs/system/arm/imx8m.rst    |   1 +
 hw/arm/Kconfig               |   1 +
 hw/arm/fsl-imx8mp.c          |  10 +++
 hw/misc/Kconfig              |   3 +
 hw/misc/imx8mp_gpr.c         | 155 +++++++++++++++++++++++++++++++++++
 hw/misc/meson.build          |   1 +
 include/hw/arm/fsl-imx8mp.h  |   2 +
 include/hw/misc/imx8mp_gpr.h |  62 ++++++++++++++
 8 files changed, 235 insertions(+)
 create mode 100644 hw/misc/imx8mp_gpr.c
 create mode 100644 include/hw/misc/imx8mp_gpr.h

diff --git a/docs/system/arm/imx8m.rst b/docs/system/arm/imx8m.rst
index e9e970ce64..7813469154 100644
--- a/docs/system/arm/imx8m.rst
+++ b/docs/system/arm/imx8m.rst
@@ -27,6 +27,7 @@ following devices:
  * Secure Non-Volatile Storage (SNVS) including an RTC
  * Clock Tree
  * General Power Controller (GPC)
+ * General Purpose Register (GPR)
 
 Boot options
 ------------
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 17450256db..7b7378110c 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -595,6 +595,7 @@ config FSL_IMX8MP
     select FSL_IMX8MP_ANALOG
     select FSL_IMX8MP_CCM
     select FSL_IMX8MP_GPC
+    select FSL_IMX8MP_GPR
     select IMX
     select IMX_FEC
     select IMX_I2C
diff --git a/hw/arm/fsl-imx8mp.c b/hw/arm/fsl-imx8mp.c
index cc5f7080c2..75860d360c 100644
--- a/hw/arm/fsl-imx8mp.c
+++ b/hw/arm/fsl-imx8mp.c
@@ -206,6 +206,8 @@ static void fsl_imx8mp_init(Object *obj)
 
     object_initialize_child(obj, "gpc", &s->gpc, TYPE_IMX8MP_GPC);
 
+    object_initialize_child(obj, "gpr", &s->gpr, TYPE_IMX8MP_GPR);
+
     for (i = 0; i < FSL_IMX8MP_NUM_UARTS; i++) {
         g_autofree char *name = g_strdup_printf("uart%d", i + 1);
         object_initialize_child(obj, name, &s->uart[i], TYPE_IMX_SERIAL);
@@ -436,6 +438,13 @@ static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->gpc), 0,
                     fsl_imx8mp_memmap[FSL_IMX8MP_GPC].addr);
 
+    /* GPR */
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->gpr), errp)) {
+        return;
+    }
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->gpr), 0,
+                    fsl_imx8mp_memmap[FSL_IMX8MP_IOMUXC_GPR].addr);
+
     /* GPTs */
     object_property_set_int(OBJECT(&s->gpt5_gpt6_irq), "num-lines", 2,
                             &error_abort);
@@ -735,6 +744,7 @@ static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
         case FSL_IMX8MP_ECSPI1 ... FSL_IMX8MP_ECSPI3:
         case FSL_IMX8MP_ENET1:
         case FSL_IMX8MP_I2C1 ... FSL_IMX8MP_I2C6:
+        case FSL_IMX8MP_IOMUXC_GPR:
         case FSL_IMX8MP_OCRAM:
         case FSL_IMX8MP_PCIE1:
         case FSL_IMX8MP_PCIE_PHY1:
diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index c17275441c..5c2945200e 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -104,6 +104,9 @@ config FSL_IMX8MP_CCM
 config FSL_IMX8MP_GPC
     bool
 
+config FSL_IMX8MP_GPR
+    bool
+
 config STM32_RCC
     bool
 
diff --git a/hw/misc/imx8mp_gpr.c b/hw/misc/imx8mp_gpr.c
new file mode 100644
index 0000000000..7e1f44e6bc
--- /dev/null
+++ b/hw/misc/imx8mp_gpr.c
@@ -0,0 +1,155 @@
+/*
+ * i.MX 8M Plus IOMUXC GPR
+ *
+ * Copyright (c) 2026, NXP Semiconductors
+ * Author: Gaurav Sharma <gaurav.sharma_7@nxp.com>
+
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/misc/imx8mp_gpr.h"
+#include "hw/core/irq.h"
+#include "hw/core/resettable.h"
+#include "migration/vmstate.h"
+
+#define IMX8MP_GPR22_OFF     0x58
+#define IMX8MP_GPR22_CM7_CPUWAIT_BIT  (1u << 0)
+
+static inline void imx8mp_gpr_update_cm7_run(IMX8MPGPRState *s, uint32_t gpr22)
+{
+    /* CPUWAIT=0 => run, CPUWAIT=1 => stop */
+    bool run = ((gpr22 & IMX8MP_GPR22_CM7_CPUWAIT_BIT) == 0);
+    qemu_set_irq(s->cm7_run_irq, run);
+}
+
+static uint64_t imx8mp_gpr_read(void *opaque, hwaddr offset, unsigned size)
+{
+    IMX8MPGPRState *s = opaque;
+
+    return s->gpr[offset >> 2];
+}
+
+static void imx8mp_gpr_write(void *opaque, hwaddr offset,
+                              uint64_t value, unsigned size)
+{
+    IMX8MPGPRState *s = opaque;
+
+    s->gpr[offset >> 2] = (uint32_t)value;
+
+    /* Watch GPR22 bit0 (CM7_CPUWAIT) transitions */
+    if (offset == IMX8MP_GPR22_OFF) {
+        imx8mp_gpr_update_cm7_run(s, s->gpr[IMX8MP_GPR22_OFF >> 2]);
+    }
+
+}
+
+static const MemoryRegionOps imx8mp_gpr_ops = {
+    .read = imx8mp_gpr_read,
+    .write = imx8mp_gpr_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .impl = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    .unaligned = false,
+    },
+};
+
+static void imx8mp_gpr_reset_enter(Object *obj, ResetType type)
+{
+    IMX8MPGPRState *s = IMX8MP_GPR(obj);
+    IMX8MPGPRClass *gc = IMX8MP_GPR_GET_CLASS(obj);
+
+    if (gc->parent_phases.enter) {
+        gc->parent_phases.enter(obj, type);
+    }
+
+    memset(s->gpr, 0, sizeof(s->gpr));
+
+    s->gpr[IOMUXC_GPR_GPR0] = 0x00000000;
+    s->gpr[IOMUXC_GPR_GPR1] = 0x00010000;
+    s->gpr[IOMUXC_GPR_GPR2] = 0x00000000;
+    s->gpr[IOMUXC_GPR_GPR3] = 0x00000000;
+    s->gpr[IOMUXC_GPR_GPR4] = 0x00000000;
+    s->gpr[IOMUXC_GPR_GPR5] = 0x00000000;
+    s->gpr[IOMUXC_GPR_GPR6] = 0x00000000;
+    s->gpr[IOMUXC_GPR_GPR7] = 0x00000000;
+    s->gpr[IOMUXC_GPR_GPR8] = 0x00000000;
+    s->gpr[IOMUXC_GPR_GPR9] = 0x00000000;
+    s->gpr[IOMUXC_GPR_GPR10] = 0x00000008;
+    s->gpr[IOMUXC_GPR_GPR11] = 0x00000200;
+    s->gpr[IOMUXC_GPR_GPR12] = 0x00004000;
+    s->gpr[IOMUXC_GPR_GPR13] = 0x00000000;
+    s->gpr[IOMUXC_GPR_GPR14] = 0x03494000;
+    s->gpr[IOMUXC_GPR_GPR15] = 0x00000000;
+    s->gpr[IOMUXC_GPR_GPR16] = 0x00000000;
+    s->gpr[IOMUXC_GPR_GPR17] = 0x00000000;
+    s->gpr[IOMUXC_GPR_GPR18] = 0x00000000;
+    s->gpr[IOMUXC_GPR_GPR19] = 0x00000000;
+    s->gpr[IOMUXC_GPR_GPR20] = 0x00000000;
+    s->gpr[IOMUXC_GPR_GPR21] = 0x00000000;
+    s->gpr[IOMUXC_GPR_GPR22] = 0x00000001;
+    s->gpr[IOMUXC_GPR_GPR23] = 0x00000000;
+    s->gpr[IOMUXC_GPR_GPR24] = 0x00000000;
+}
+
+static void imx8mp_gpr_reset_hold(Object *obj, ResetType type)
+{
+    IMX8MPGPRState *s = IMX8MP_GPR(obj);
+    IMX8MPGPRClass *gc = IMX8MP_GPR_GET_CLASS(obj);
+
+    if (gc->parent_phases.hold) {
+        gc->parent_phases.hold(obj, type);
+    }
+
+    /* Drive cm7_run_irq output to match reset value of CPUWAIT */
+    imx8mp_gpr_update_cm7_run(s, s->gpr[IMX8MP_GPR22_OFF >> 2]);
+}
+
+static const VMStateDescription imx8mp_gpr_vmstate = {
+    .name = TYPE_IMX8MP_GPR,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32_ARRAY(gpr, IMX8MPGPRState, IOMUXC_GPR_MAX),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
+static void imx8mp_gpr_init(Object *obj)
+{
+    IMX8MPGPRState *s = IMX8MP_GPR(obj);
+    memory_region_init_io(&s->mmio, obj, &imx8mp_gpr_ops, s,
+                          TYPE_IMX8MP_GPR, sizeof(s->gpr));
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
+    sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->cm7_run_irq);
+}
+
+static void imx8mp_gpr_class_init(ObjectClass *oc, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+    ResettableClass *rc = RESETTABLE_CLASS(oc);
+    IMX8MPGPRClass *gc = IMX8MP_GPR_CLASS(oc);
+
+    resettable_class_set_parent_phases(rc,
+                                       imx8mp_gpr_reset_enter,
+                                       imx8mp_gpr_reset_hold,
+                                       NULL,
+                                       &gc->parent_phases);
+
+    dc->vmsd = &imx8mp_gpr_vmstate;
+    dc->desc = "i.MX8MP IOMUXC GPR";
+}
+
+static const TypeInfo imx8mp_gpr_info[] = {
+    {
+        .name = TYPE_IMX8MP_GPR,
+        .parent = TYPE_SYS_BUS_DEVICE,
+        .instance_size = sizeof(IMX8MPGPRState),
+        .class_size    = sizeof(IMX8MPGPRClass),
+        .instance_init = imx8mp_gpr_init,
+        .class_init = imx8mp_gpr_class_init,
+    }
+};
+
+DEFINE_TYPES(imx8mp_gpr_info);
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index ba9d586ec9..5eda094d34 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -63,6 +63,7 @@ system_ss.add(when: 'CONFIG_EXYNOS4', if_true: files('exynos4210_pmu.c', 'exynos
 system_ss.add(when: 'CONFIG_FSL_IMX8MP_ANALOG', if_true: files('imx8mp_analog.c'))
 system_ss.add(when: 'CONFIG_FSL_IMX8MP_CCM', if_true: files('imx8mp_ccm.c'))
 system_ss.add(when: 'CONFIG_FSL_IMX8MP_GPC', if_true: files('imx8mp_gpc.c'))
+system_ss.add(when: 'CONFIG_FSL_IMX8MP_GPR', if_true: files('imx8mp_gpr.c'))
 system_ss.add(when: 'CONFIG_IMX', if_true: files(
   'imx25_ccm.c',
   'imx31_ccm.c',
diff --git a/include/hw/arm/fsl-imx8mp.h b/include/hw/arm/fsl-imx8mp.h
index 7c13943afc..aacfbfd3a4 100644
--- a/include/hw/arm/fsl-imx8mp.h
+++ b/include/hw/arm/fsl-imx8mp.h
@@ -18,6 +18,7 @@
 #include "hw/misc/imx8mp_analog.h"
 #include "hw/misc/imx8mp_ccm.h"
 #include "hw/misc/imx8mp_gpc.h"
+#include "hw/misc/imx8mp_gpr.h"
 #include "hw/net/flexcan.h"
 #include "hw/net/imx_fec.h"
 #include "hw/core/or-irq.h"
@@ -58,6 +59,7 @@ struct FslImx8mpState {
     ARMCPU             cpu[FSL_IMX8MP_NUM_A53];
     GICv3State         gic;
     IMX8MPGPCState     gpc;
+    IMX8MPGPRState     gpr;
     IMXGPTState        gpt[FSL_IMX8MP_NUM_GPTS];
     IMXGPIOState       gpio[FSL_IMX8MP_NUM_GPIOS];
     IMX8MPCCMState     ccm;
diff --git a/include/hw/misc/imx8mp_gpr.h b/include/hw/misc/imx8mp_gpr.h
new file mode 100644
index 0000000000..aa94692e8a
--- /dev/null
+++ b/include/hw/misc/imx8mp_gpr.h
@@ -0,0 +1,62 @@
+/*
+ * i.MX 8M Plus IOMUXC GPR
+ *
+ * Copyright (c) 2026, NXP Semiconductors
+ * Author: Gaurav Sharma <gaurav.sharma_7@nxp.com>
+
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+
+#ifndef IMX8MP_GPR_H
+#define IMX8MP_GPR_H
+
+#include "hw/core/resettable.h"
+#include "hw/core/sysbus.h"
+#include "qom/object.h"
+
+#define TYPE_IMX8MP_GPR "imx8mp.gpr"
+OBJECT_DECLARE_TYPE(IMX8MPGPRState, IMX8MPGPRClass, IMX8MP_GPR)
+
+struct IMX8MPGPRClass {
+    SysBusDeviceClass parent_class;
+    ResettablePhases  parent_phases;
+};
+
+enum IMX8MPGPRRegisters {
+    IOMUXC_GPR_GPR0  = 0x000 / 4,
+    IOMUXC_GPR_GPR1  = 0x004 / 4,
+    IOMUXC_GPR_GPR2  = 0x008 / 4,
+    IOMUXC_GPR_GPR3  = 0x00C / 4,
+    IOMUXC_GPR_GPR4  = 0x010 / 4,
+    IOMUXC_GPR_GPR5  = 0x014 / 4,
+    IOMUXC_GPR_GPR6  = 0x018 / 4,
+    IOMUXC_GPR_GPR7  = 0x01C / 4,
+    IOMUXC_GPR_GPR8  = 0x020 / 4,
+    IOMUXC_GPR_GPR9  = 0x024 / 4,
+    IOMUXC_GPR_GPR10 = 0x028 / 4,
+    IOMUXC_GPR_GPR11 = 0x02C / 4,
+    IOMUXC_GPR_GPR12 = 0x030 / 4,
+    IOMUXC_GPR_GPR13 = 0x034 / 4,
+    IOMUXC_GPR_GPR14 = 0x038 / 4,
+    IOMUXC_GPR_GPR15 = 0x03C / 4,
+    IOMUXC_GPR_GPR16 = 0x040 / 4,
+    IOMUXC_GPR_GPR17 = 0x044 / 4,
+    IOMUXC_GPR_GPR18 = 0x048 / 4,
+    IOMUXC_GPR_GPR19 = 0x04C / 4,
+    IOMUXC_GPR_GPR20 = 0x050 / 4,
+    IOMUXC_GPR_GPR21 = 0x054 / 4,
+    IOMUXC_GPR_GPR22 = 0x058 / 4,
+    IOMUXC_GPR_GPR23 = 0x05C / 4,
+    IOMUXC_GPR_GPR24 = 0x060 / 4,
+    IOMUXC_GPR_MAX,
+};
+
+struct IMX8MPGPRState {
+    SysBusDevice parent_obj;
+    MemoryRegion mmio;
+    qemu_irq cm7_run_irq;
+    uint32_t gpr[IOMUXC_GPR_MAX];
+};
+
+#endif /* IMX8MP_GPR_H */
-- 
2.34.1


