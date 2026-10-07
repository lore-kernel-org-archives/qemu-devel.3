Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7FB2CA6007
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 10:12:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEOd2-000553-6G; Wed, 07 Oct 2026 06:12:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaurav.sharma_7@nxp.com>)
 id 1xEOcM-0004G3-E0; Wed, 07 Oct 2026 06:11:24 -0400
Received: from inva021.nxp.com ([92.121.34.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaurav.sharma_7@nxp.com>)
 id 1xEOcK-0004PU-9s; Wed, 07 Oct 2026 06:11:22 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 7B915200011;
 Wed,  7 Oct 2026 12:11:17 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 43E59200008;
 Wed,  7 Oct 2026 12:11:17 +0200 (CEST)
Received: from lsv031015.swis.in-blr01.nxp.com
 (lsv031015.swis.in-blr01.nxp.com [10.12.177.77])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 50AD7180006C;
 Wed,  7 Oct 2026 18:11:15 +0800 (+08)
From: Gaurav Sharma <gaurav.sharma_7@nxp.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, pbonzini@redhat.com, peter.maydell@linaro.org,
 shentey@gmail.com, pierrick.bouvier@oss.qualcomm.com,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>
Subject: [PATCHv4 04/11] hw/misc: Add i.MX8MP GPC (General Power Controller) IP
Date: Wed,  7 Oct 2026 15:40:58 +0530
Message-Id: <20261007101105.3917771-5-gaurav.sharma_7@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261007101105.3917771-1-gaurav.sharma_7@nxp.com>
References: <20261007101105.3917771-1-gaurav.sharma_7@nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Received-SPF: pass client-ip=92.121.34.21;
 envelope-from=gaurav.sharma_7@nxp.com; helo=inva021.nxp.com
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

Add a minimal emulation of the i.MX8MP General Power Controller
and wire it into the i.MX8MP SoC model.
The GPC manages power domains and clock-gating behavior for cores on the i.MX8MP SoC.
This is needed to support AMP boot of the Cortex-M7 core from Linux.

Signed-off-by: Gaurav Sharma <gaurav.sharma_7@nxp.com>
---
 docs/system/arm/imx8m.rst    |   1 +
 hw/arm/Kconfig               |   1 +
 hw/arm/fsl-imx8mp.c          |  10 +++
 hw/misc/Kconfig              |   3 +
 hw/misc/imx8mp_gpc.c         | 146 +++++++++++++++++++++++++++++++++++
 hw/misc/meson.build          |   1 +
 include/hw/arm/fsl-imx8mp.h  |   2 +
 include/hw/misc/imx8mp_gpc.h |  34 ++++++++
 8 files changed, 198 insertions(+)
 create mode 100644 hw/misc/imx8mp_gpc.c
 create mode 100644 include/hw/misc/imx8mp_gpc.h

diff --git a/docs/system/arm/imx8m.rst b/docs/system/arm/imx8m.rst
index 1bcb8255be..e9e970ce64 100644
--- a/docs/system/arm/imx8m.rst
+++ b/docs/system/arm/imx8m.rst
@@ -26,6 +26,7 @@ following devices:
  * 6 General Purpose Timers
  * Secure Non-Volatile Storage (SNVS) including an RTC
  * Clock Tree
+ * General Power Controller (GPC)
 
 Boot options
 ------------
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index eae06369b0..17450256db 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -594,6 +594,7 @@ config FSL_IMX8MP
     select CAN_FLEXCAN
     select FSL_IMX8MP_ANALOG
     select FSL_IMX8MP_CCM
+    select FSL_IMX8MP_GPC
     select IMX
     select IMX_FEC
     select IMX_I2C
diff --git a/hw/arm/fsl-imx8mp.c b/hw/arm/fsl-imx8mp.c
index f599e5e0a2..cc5f7080c2 100644
--- a/hw/arm/fsl-imx8mp.c
+++ b/hw/arm/fsl-imx8mp.c
@@ -204,6 +204,8 @@ static void fsl_imx8mp_init(Object *obj)
 
     object_initialize_child(obj, "snvs", &s->snvs, TYPE_IMX7_SNVS);
 
+    object_initialize_child(obj, "gpc", &s->gpc, TYPE_IMX8MP_GPC);
+
     for (i = 0; i < FSL_IMX8MP_NUM_UARTS; i++) {
         g_autofree char *name = g_strdup_printf("uart%d", i + 1);
         object_initialize_child(obj, name, &s->uart[i], TYPE_IMX_SERIAL);
@@ -427,6 +429,13 @@ static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
                            qdev_get_gpio_in(gicdev, serial_table[i].irq));
     }
 
+    /* GPC */
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->gpc), errp)) {
+        return;
+    }
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->gpc), 0,
+                    fsl_imx8mp_memmap[FSL_IMX8MP_GPC].addr);
+
     /* GPTs */
     object_property_set_int(OBJECT(&s->gpt5_gpt6_irq), "num-lines", 2,
                             &error_abort);
@@ -720,6 +729,7 @@ static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
         case FSL_IMX8MP_FLEXCAN1 ... FSL_IMX8MP_FLEXCAN2:
         case FSL_IMX8MP_GIC_DIST:
         case FSL_IMX8MP_GIC_REDIST:
+        case FSL_IMX8MP_GPC:
         case FSL_IMX8MP_GPIO1 ... FSL_IMX8MP_GPIO5:
         case FSL_IMX8MP_GPT1 ... FSL_IMX8MP_GPT6:
         case FSL_IMX8MP_ECSPI1 ... FSL_IMX8MP_ECSPI3:
diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index 46e3c03cc8..c17275441c 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -101,6 +101,9 @@ config FSL_IMX8MP_ANALOG
 config FSL_IMX8MP_CCM
     bool
 
+config FSL_IMX8MP_GPC
+    bool
+
 config STM32_RCC
     bool
 
diff --git a/hw/misc/imx8mp_gpc.c b/hw/misc/imx8mp_gpc.c
new file mode 100644
index 0000000000..9d8b93779d
--- /dev/null
+++ b/hw/misc/imx8mp_gpc.c
@@ -0,0 +1,146 @@
+/*
+ * i.MX 8M Plus GPC(General Power Controller)
+ *
+ * Copyright (c) 2026, NXP Semiconductors
+ * Author: Gaurav Sharma <gaurav.sharma_7@nxp.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+
+#include "qemu/osdep.h"
+#include "hw/core/resettable.h"
+#include "hw/misc/imx8mp_gpc.h"
+#include "migration/vmstate.h"
+
+#define IMX8MP_GPC_ACK_BIT31 0x80000000u
+
+#define IMX8MP_GPC_STAT_BUSY_BIT (1u << 5)
+
+static uint64_t imx8mp_gpc_read(void *opaque, hwaddr offset, unsigned size)
+{
+    IMX8MPGPCState *s = opaque;
+    uint32_t idx = offset >> 2;
+
+    if (size != 4 || (offset & 3) || offset >= IMX8MP_GPC_MMIO_SIZE) {
+        return 0;
+    }
+
+    /*
+     * CM7 firmware polls GPC+0xD8 and loops while bit5 is 1.
+     * Emulate "ready" by forcing bit5 low on reads.
+     */
+    if (idx == IMX8MP_GPC_PU_PGC_SW_PUP_REQ) {
+        return s->regs[idx] & ~IMX8MP_GPC_STAT_BUSY_BIT;
+    }
+
+    return s->regs[idx];
+}
+
+static void imx8mp_gpc_write(void *opaque, hwaddr offset, uint64_t value, unsigned size)
+{
+    IMX8MPGPCState *s = opaque;
+    uint32_t idx = offset >> 2;
+
+    if (size != 4 || (offset & 3) || offset >= IMX8MP_GPC_MMIO_SIZE) {
+        return;
+    }
+
+    /*
+     * CM7 firmware sets bit15 in GPC+0x190 and then polls until the value
+     * becomes negative (bit31 set). Emulate the hardware ACK by forcing
+     * bit31 high on writes to this register.
+     */
+    if (idx == IMX8MP_GPC_POLL_REG) {
+        s->regs[idx] = ((uint32_t)value) | IMX8MP_GPC_ACK_BIT31;
+    } else {
+        s->regs[idx] = (uint32_t)value;
+    }
+
+}
+
+static const MemoryRegionOps imx8mp_gpc_ops = {
+    .read = imx8mp_gpc_read,
+    .write = imx8mp_gpc_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    .unaligned = false,
+    },
+};
+
+static ResettablePhases imx8mp_gpc_parent_phases;
+
+static void imx8mp_gpc_reset_enter(Object *obj, ResetType type)
+{
+    IMX8MPGPCState *s = IMX8MP_GPC(obj);
+
+    if (imx8mp_gpc_parent_phases.enter) {
+        imx8mp_gpc_parent_phases.enter(obj, type);
+    }
+
+    memset(s->regs, 0, sizeof(s->regs));
+
+    /*
+     * Unblock CM7 firmware polling loop: return a negative value at 0x190.
+     * Any value with bit31 set works.
+     */
+    s->regs[IMX8MP_GPC_POLL_REG] = IMX8MP_GPC_ACK_BIT31;
+
+    /* Default "ready" for the earlier poll at 0xD8: ensure busy bit is clear */
+    s->regs[IMX8MP_GPC_PU_PGC_SW_PUP_REQ] = 0x00000000;
+
+}
+
+static void imx8mp_gpc_reset_hold(Object *obj, ResetType type)
+{
+    if (imx8mp_gpc_parent_phases.hold) {
+        imx8mp_gpc_parent_phases.hold(obj, type);
+    }
+}
+
+static const VMStateDescription imx8mp_gpc_vmstate = {
+    .name = TYPE_IMX8MP_GPC,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32_ARRAY(regs, IMX8MPGPCState, IMX8MP_GPC_MMIO_SIZE / 4),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
+static void imx8mp_gpc_init(Object *obj)
+{
+    IMX8MPGPCState *s = IMX8MP_GPC(obj);
+    memory_region_init_io(&s->iomem, obj, &imx8mp_gpc_ops, s,
+                          TYPE_IMX8MP_GPC, IMX8MP_GPC_MMIO_SIZE);
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->iomem);
+}
+
+static void imx8mp_gpc_class_init(ObjectClass *oc, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+    ResettableClass *rc = RESETTABLE_CLASS(oc);
+
+    resettable_class_set_parent_phases(rc,
+                                       imx8mp_gpc_reset_enter,
+                                       imx8mp_gpc_reset_hold,
+                                       NULL,
+                                       &imx8mp_gpc_parent_phases);
+
+    dc->vmsd = &imx8mp_gpc_vmstate;
+    dc->desc = "i.MX8MP GPC(General Power Controller)";
+}
+
+static const TypeInfo imx8mp_gpc_info[] = {
+    {
+    .name = TYPE_IMX8MP_GPC,
+    .parent = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(IMX8MPGPCState),
+    .instance_init = imx8mp_gpc_init,
+    .class_init = imx8mp_gpc_class_init,
+    }
+};
+
+DEFINE_TYPES(imx8mp_gpc_info);
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 9790afa104..ba9d586ec9 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -62,6 +62,7 @@ system_ss.add(when: 'CONFIG_ECCMEMCTL', if_true: files('eccmemctl.c'))
 system_ss.add(when: 'CONFIG_EXYNOS4', if_true: files('exynos4210_pmu.c', 'exynos4210_clk.c', 'exynos4210_rng.c'))
 system_ss.add(when: 'CONFIG_FSL_IMX8MP_ANALOG', if_true: files('imx8mp_analog.c'))
 system_ss.add(when: 'CONFIG_FSL_IMX8MP_CCM', if_true: files('imx8mp_ccm.c'))
+system_ss.add(when: 'CONFIG_FSL_IMX8MP_GPC', if_true: files('imx8mp_gpc.c'))
 system_ss.add(when: 'CONFIG_IMX', if_true: files(
   'imx25_ccm.c',
   'imx31_ccm.c',
diff --git a/include/hw/arm/fsl-imx8mp.h b/include/hw/arm/fsl-imx8mp.h
index 6f9bd8d2ce..7c13943afc 100644
--- a/include/hw/arm/fsl-imx8mp.h
+++ b/include/hw/arm/fsl-imx8mp.h
@@ -17,6 +17,7 @@
 #include "hw/misc/imx7_snvs.h"
 #include "hw/misc/imx8mp_analog.h"
 #include "hw/misc/imx8mp_ccm.h"
+#include "hw/misc/imx8mp_gpc.h"
 #include "hw/net/flexcan.h"
 #include "hw/net/imx_fec.h"
 #include "hw/core/or-irq.h"
@@ -56,6 +57,7 @@ struct FslImx8mpState {
 
     ARMCPU             cpu[FSL_IMX8MP_NUM_A53];
     GICv3State         gic;
+    IMX8MPGPCState     gpc;
     IMXGPTState        gpt[FSL_IMX8MP_NUM_GPTS];
     IMXGPIOState       gpio[FSL_IMX8MP_NUM_GPIOS];
     IMX8MPCCMState     ccm;
diff --git a/include/hw/misc/imx8mp_gpc.h b/include/hw/misc/imx8mp_gpc.h
new file mode 100644
index 0000000000..49a040e0c9
--- /dev/null
+++ b/include/hw/misc/imx8mp_gpc.h
@@ -0,0 +1,34 @@
+/*
+ * i.MX 8M Plus GPC(General Power Controller)
+ *
+ * Copyright (c) 2026, NXP Semiconductors
+ * Author: Gaurav Sharma <gaurav.sharma_7@nxp.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+
+#ifndef IMX8MP_GPC_H
+#define IMX8MP_GPC_H
+
+#include "hw/core/sysbus.h"
+#include "qom/object.h"
+
+#define IMX8MP_GPC_MMIO_SIZE 0x1000
+
+#define TYPE_IMX8MP_GPC "imx8mp.gpc"
+
+OBJECT_DECLARE_SIMPLE_TYPE(IMX8MPGPCState, IMX8MP_GPC)
+
+enum IMX8MPGPCRegisters {
+    IMX8MP_GPC_PU_PGC_SW_PUP_REQ = 0x0D8 / 4,
+    IMX8MP_GPC_POLL_REG          = 0x190 / 4,
+};
+
+struct IMX8MPGPCState {
+    SysBusDevice parent_obj;
+    MemoryRegion iomem;
+    uint32_t regs[IMX8MP_GPC_MMIO_SIZE / 4];
+};
+
+#endif /* IMX8MP_GPC_H */
-- 
2.34.1


