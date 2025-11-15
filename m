Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52750CEACFC
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Nov 2025 06:53:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vKA90-0006VT-MD; Sat, 15 Nov 2025 01:52:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaurav.sharma_7@nxp.com>)
 id 1vKA8v-0006Sg-SM
 for qemu-devel@nongnu.org; Sat, 15 Nov 2025 01:52:17 -0500
Received: from inva021.nxp.com ([92.121.34.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaurav.sharma_7@nxp.com>)
 id 1vKA8t-0008Kv-1E
 for qemu-devel@nongnu.org; Sat, 15 Nov 2025 01:52:17 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id DB07E202BCC;
 Sat, 15 Nov 2025 07:52:12 +0100 (CET)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 7EBF02013C7;
 Sat, 15 Nov 2025 07:52:12 +0100 (CET)
Received: from lsv031015.swis.in-blr01.nxp.com
 (lsv031015.swis.in-blr01.nxp.com [10.12.177.77])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id A306E1800087;
 Sat, 15 Nov 2025 14:52:11 +0800 (+08)
From: Gaurav Sharma <gaurav.sharma_7@nxp.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, peter.maydell@linaro.org,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>
Subject: [PATCHv2 02/13] hw/arm/fsl-imx8mm: Implemented CCM(Clock Control
 Module) and Analog IP
Date: Sat, 15 Nov 2025 12:20:48 +0530
Message-Id: <20251115065059.1884980-3-gaurav.sharma_7@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251115065059.1884980-1-gaurav.sharma_7@nxp.com>
References: <20251115065059.1884980-1-gaurav.sharma_7@nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Received-SPF: pass client-ip=92.121.34.21;
 envelope-from=gaurav.sharma_7@nxp.com; helo=inva021.nxp.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Implemented Analog device model
Implemented CCM device model

Signed-off-by: Gaurav Sharma <gaurav.sharma_7@nxp.com>
---
 docs/system/arm/imx8mm-evk.rst  |   1 +
 hw/arm/Kconfig                  |   2 +
 hw/arm/fsl-imx8mm.c             |  20 ++++
 hw/misc/Kconfig                 |   6 ++
 hw/misc/imx8mm_analog.c         | 160 +++++++++++++++++++++++++++++
 hw/misc/imx8mm_ccm.c            | 175 ++++++++++++++++++++++++++++++++
 hw/misc/meson.build             |   2 +
 include/hw/arm/fsl-imx8mm.h     |   4 +
 include/hw/misc/imx8mm_analog.h |  81 +++++++++++++++
 include/hw/misc/imx8mm_ccm.h    |  30 ++++++
 10 files changed, 481 insertions(+)
 create mode 100644 hw/misc/imx8mm_analog.c
 create mode 100644 hw/misc/imx8mm_ccm.c
 create mode 100644 include/hw/misc/imx8mm_analog.h
 create mode 100644 include/hw/misc/imx8mm_ccm.h

diff --git a/docs/system/arm/imx8mm-evk.rst b/docs/system/arm/imx8mm-evk.rst
index 1f5a94c2db..5b1267adce 100644
--- a/docs/system/arm/imx8mm-evk.rst
+++ b/docs/system/arm/imx8mm-evk.rst
@@ -12,6 +12,7 @@ The ``imx8mm-evk`` machine implements the following devices:
  * Up to 4 Cortex-A53 cores
  * Generic Interrupt Controller (GICv3)
  * 4 UARTs
+ * Clock Tree
 
 Boot options
 ------------
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 7c66f3c3cd..314ffcd315 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -629,6 +629,8 @@ config FSL_IMX8MP_EVK
 config FSL_IMX8MM
     bool
     select ARM_GIC
+    select FSL_IMX8MM_ANALOG
+    select FSL_IMX8MM_CCM
     select IMX
 
 config FSL_IMX8MM_EVK
diff --git a/hw/arm/fsl-imx8mm.c b/hw/arm/fsl-imx8mm.c
index 0c658141cf..5425dc8a53 100644
--- a/hw/arm/fsl-imx8mm.c
+++ b/hw/arm/fsl-imx8mm.c
@@ -166,6 +166,10 @@ static void fsl_imx8mm_init(Object *obj)
 
     object_initialize_child(obj, "gic", &s->gic, gicv3_class_name());
 
+    object_initialize_child(obj, "ccm", &s->ccm, TYPE_IMX8MM_CCM);
+
+    object_initialize_child(obj, "analog", &s->analog, TYPE_IMX8MM_ANALOG);
+
     for (i = 0; i < FSL_IMX8MM_NUM_UARTS; i++) {
         g_autofree char *name = g_strdup_printf("uart%d", i + 1);
         object_initialize_child(obj, name, &s->uart[i], TYPE_IMX_SERIAL);
@@ -300,6 +304,20 @@ static void fsl_imx8mm_realize(DeviceState *dev, Error **errp)
         }
     }
 
+    /* CCM */
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->ccm), errp)) {
+        return;
+    }
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->ccm), 0,
+                    fsl_imx8mm_memmap[FSL_IMX8MM_CCM].addr);
+
+    /* Analog */
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->analog), errp)) {
+        return;
+    }
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->analog), 0,
+                    fsl_imx8mm_memmap[FSL_IMX8MM_ANA_PLL].addr);
+
     /* UARTs */
     for (i = 0; i < FSL_IMX8MM_NUM_UARTS; i++) {
         static const struct {
@@ -325,6 +343,8 @@ static void fsl_imx8mm_realize(DeviceState *dev, Error **errp)
     /* Unimplemented devices */
     for (i = 0; i < ARRAY_SIZE(fsl_imx8mm_memmap); i++) {
         switch (i) {
+        case FSL_IMX8MM_ANA_PLL:
+        case FSL_IMX8MM_CCM:
         case FSL_IMX8MM_GIC_DIST:
         case FSL_IMX8MM_GIC_REDIST:
         case FSL_IMX8MM_RAM:
diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index fccd735c24..56248ba3c2 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -96,6 +96,12 @@ config FSL_IMX8MP_ANALOG
 config FSL_IMX8MP_CCM
     bool
 
+config FSL_IMX8MM_ANALOG
+    bool
+
+config FSL_IMX8MM_CCM
+    bool
+
 config STM32_RCC
     bool
 
diff --git a/hw/misc/imx8mm_analog.c b/hw/misc/imx8mm_analog.c
new file mode 100644
index 0000000000..d6ba1344d3
--- /dev/null
+++ b/hw/misc/imx8mm_analog.c
@@ -0,0 +1,160 @@
+/*
+ * Copyright (c) 2025 Gaurav Sharma <gaurav.sharma_7@nxp.com>
+ *
+ * i.MX 8MM ANALOG IP block emulation code
+ *
+ * Based on hw/misc/imx7_ccm.c
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+
+#include "hw/misc/imx8mm_analog.h"
+#include "migration/vmstate.h"
+
+#define ANALOG_PLL_LOCK BIT(31)
+
+static void imx8mm_analog_reset(DeviceState *dev)
+{
+    IMX8MMAnalogState *s = IMX8MM_ANALOG(dev);
+
+    memset(s->analog, 0, sizeof(s->analog));
+
+    s->analog[ANALOG_AUDIO_PLL1_GEN_CTRL] = 0x00002010;
+    s->analog[ANALOG_AUDIO_PLL1_FDIV_CTL0] = 0x00145032;
+    s->analog[ANALOG_AUDIO_PLL1_FDIV_CTL1] = 0x00000000;
+    s->analog[ANALOG_AUDIO_PLL1_SSCG_CTRL] = 0x00000000;
+    s->analog[ANALOG_AUDIO_PLL1_MNIT_CTRL] = 0x00100103;
+    s->analog[ANALOG_AUDIO_PLL2_GEN_CTRL] = 0x00002010;
+    s->analog[ANALOG_AUDIO_PLL2_FDIV_CTL0] = 0x00145032;
+    s->analog[ANALOG_AUDIO_PLL2_FDIV_CTL1] = 0x00000000;
+    s->analog[ANALOG_AUDIO_PLL2_SSCG_CTRL] = 0x00000000;
+    s->analog[ANALOG_AUDIO_PLL2_MNIT_CTRL] = 0x00100103;
+    s->analog[ANALOG_VIDEO_PLL1_GEN_CTRL] = 0x00002010;
+    s->analog[ANALOG_VIDEO_PLL1_FDIV_CTL0] = 0x00145032;
+    s->analog[ANALOG_VIDEO_PLL1_FDIV_CTL1] = 0x00000000;
+    s->analog[ANALOG_VIDEO_PLL1_SSCG_CTRL] = 0x00000000;
+    s->analog[ANALOG_VIDEO_PLL1_MNIT_CTRL] = 0x00100103;
+    s->analog[ANALOG_DRAM_PLL_GEN_CTRL] = 0x00002010;
+    s->analog[ANALOG_DRAM_PLL_FDIV_CTL0] = 0x0012c032;
+    s->analog[ANALOG_DRAM_PLL_FDIV_CTL1] = 0x00000000;
+    s->analog[ANALOG_DRAM_PLL_SSCG_CTRL] = 0x00000000;
+    s->analog[ANALOG_DRAM_PLL_MNIT_CTRL] = 0x00100103;
+    s->analog[ANALOG_GPU_PLL_GEN_CTRL] = 0x00000810;
+    s->analog[ANALOG_GPU_PLL_FDIV_CTL0] = 0x000c8031;
+    s->analog[ANALOG_GPU_PLL_LOCKD_CTRL] = 0x0010003f;
+    s->analog[ANALOG_GPU_PLL_MNIT_CTRL] = 0x00280081;
+    s->analog[ANALOG_VPU_PLL_GEN_CTRL] = 0x00000810;
+    s->analog[ANALOG_VPU_PLL_FDIV_CTL0] = 0x0012c032;
+    s->analog[ANALOG_VPU_PLL_LOCKD_CTRL] = 0x0010003f;
+    s->analog[ANALOG_VPU_PLL_MNIT_CTRL] = 0x00280081;
+    s->analog[ANALOG_ARM_PLL_GEN_CTRL] = 0x00000810;
+    s->analog[ANALOG_ARM_PLL_FDIV_CTL0] = 0x000fa030;
+    s->analog[ANALOG_ARM_PLL_LOCKD_CTRL] = 0x0010003f;
+    s->analog[ANALOG_ARM_PLL_MNIT_CTRL] = 0x00280081;
+    s->analog[ANALOG_SYS_PLL1_GEN_CTRL] = 0x0aaaa810;
+    s->analog[ANALOG_SYS_PLL1_FDIV_CTL0] = 0x00190032;
+    s->analog[ANALOG_SYS_PLL1_LOCKD_CTRL] = 0x0010003f;
+    s->analog[ANALOG_SYS_PLL1_MNIT_CTRL] = 0x00280081;
+    s->analog[ANALOG_SYS_PLL2_GEN_CTRL] = 0x0aaaa810;
+    s->analog[ANALOG_SYS_PLL2_FDIV_CTL0] = 0x000fa031;
+    s->analog[ANALOG_SYS_PLL2_LOCKD_CTRL] = 0x0010003f;
+    s->analog[ANALOG_SYS_PLL2_MNIT_CTRL] = 0x00280081;
+    s->analog[ANALOG_SYS_PLL3_GEN_CTRL] = 0x00000810;
+    s->analog[ANALOG_SYS_PLL3_FDIV_CTL0] = 0x000fa031;
+    s->analog[ANALOG_SYS_PLL3_LOCKD_CTRL] = 0x0010003f;
+    s->analog[ANALOG_SYS_PLL3_MNIT_CTRL] = 0x00280081;
+    s->analog[ANALOG_OSC_MISC_CFG] = 0x00000000;
+    s->analog[ANALOG_ANAMIX_PLL_MNIT_CTL] = 0x00000000;
+    s->analog[ANALOG_DIGPROG] = 0x00824010;
+
+    /* all PLLs need to be locked */
+    s->analog[ANALOG_AUDIO_PLL1_GEN_CTRL] |= ANALOG_PLL_LOCK;
+    s->analog[ANALOG_AUDIO_PLL2_GEN_CTRL] |= ANALOG_PLL_LOCK;
+    s->analog[ANALOG_VIDEO_PLL1_GEN_CTRL] |= ANALOG_PLL_LOCK;
+    s->analog[ANALOG_DRAM_PLL_GEN_CTRL] |= ANALOG_PLL_LOCK;
+    s->analog[ANALOG_GPU_PLL_GEN_CTRL] |= ANALOG_PLL_LOCK;
+    s->analog[ANALOG_VPU_PLL_GEN_CTRL] |= ANALOG_PLL_LOCK;
+    s->analog[ANALOG_ARM_PLL_GEN_CTRL] |= ANALOG_PLL_LOCK;
+    s->analog[ANALOG_SYS_PLL1_GEN_CTRL] |= ANALOG_PLL_LOCK;
+    s->analog[ANALOG_SYS_PLL2_GEN_CTRL] |= ANALOG_PLL_LOCK;
+    s->analog[ANALOG_SYS_PLL3_GEN_CTRL] |= ANALOG_PLL_LOCK;
+}
+
+static uint64_t imx8mm_analog_read(void *opaque, hwaddr offset, unsigned size)
+{
+    IMX8MMAnalogState *s = opaque;
+
+    return s->analog[offset >> 2];
+}
+
+static void imx8mm_analog_write(void *opaque, hwaddr offset,
+                                uint64_t value, unsigned size)
+{
+    IMX8MMAnalogState *s = opaque;
+
+    if (offset >> 2 == ANALOG_DIGPROG) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "Guest write to read-only ANALOG_DIGPROG register\n");
+    } else {
+        s->analog[offset >> 2] = value;
+    }
+}
+
+static const struct MemoryRegionOps imx8mm_analog_ops = {
+    .read = imx8mm_analog_read,
+    .write = imx8mm_analog_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+    .impl = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+        .unaligned = false,
+    },
+};
+
+static void imx8mm_analog_init(Object *obj)
+{
+    IMX8MMAnalogState *s = IMX8MM_ANALOG(obj);
+    SysBusDevice *sd = SYS_BUS_DEVICE(obj);
+
+    memory_region_init(&s->mmio.container, obj, TYPE_IMX8MM_ANALOG, 0x10000);
+
+    memory_region_init_io(&s->mmio.analog, obj, &imx8mm_analog_ops, s,
+                          TYPE_IMX8MM_ANALOG, sizeof(s->analog));
+    memory_region_add_subregion(&s->mmio.container, 0, &s->mmio.analog);
+
+    sysbus_init_mmio(sd, &s->mmio.container);
+}
+
+static const VMStateDescription imx8mm_analog_vmstate = {
+    .name = TYPE_IMX8MM_ANALOG,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32_ARRAY(analog, IMX8MMAnalogState, ANALOG_MAX),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
+static void imx8mm_analog_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    device_class_set_legacy_reset(dc, imx8mm_analog_reset);
+    dc->vmsd  = &imx8mm_analog_vmstate;
+    dc->desc  = "i.MX 8MM Analog Module";
+}
+
+static const TypeInfo imx8mm_analog_types[] = {
+    {
+        .name          = TYPE_IMX8MM_ANALOG,
+        .parent        = TYPE_SYS_BUS_DEVICE,
+        .instance_size = sizeof(IMX8MMAnalogState),
+        .instance_init = imx8mm_analog_init,
+        .class_init    = imx8mm_analog_class_init,
+    }
+};
+
+DEFINE_TYPES(imx8mm_analog_types);
diff --git a/hw/misc/imx8mm_ccm.c b/hw/misc/imx8mm_ccm.c
new file mode 100644
index 0000000000..352a6ee188
--- /dev/null
+++ b/hw/misc/imx8mm_ccm.c
@@ -0,0 +1,175 @@
+/*
+ * Copyright (c) 2025 Gaurav Sharma <gaurav.sharma_7@nxp.com>
+ *
+ * i.MX 8MM CCM IP block emulation code
+ *
+ * Based on hw/misc/imx7_ccm.c
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+
+#include "hw/misc/imx8mm_ccm.h"
+#include "migration/vmstate.h"
+
+#include "trace.h"
+
+#define CKIH_FREQ 16000000 /* 16MHz crystal input */
+
+static void imx8mm_ccm_reset(DeviceState *dev)
+{
+    IMX8MMCCMState *s = IMX8MM_CCM(dev);
+
+    memset(s->ccm, 0, sizeof(s->ccm));
+}
+
+#define CCM_INDEX(offset)   (((offset) & ~(hwaddr)0xF) / sizeof(uint32_t))
+#define CCM_BITOP(offset)   ((offset) & (hwaddr)0xF)
+
+enum {
+    CCM_BITOP_NONE = 0x00,
+    CCM_BITOP_SET  = 0x04,
+    CCM_BITOP_CLR  = 0x08,
+    CCM_BITOP_TOG  = 0x0C,
+};
+
+static uint64_t imx8mm_set_clr_tog_read(void *opaque, hwaddr offset,
+                                        unsigned size)
+{
+    const uint32_t *mmio = opaque;
+
+    return mmio[CCM_INDEX(offset)];
+}
+
+static void imx8mm_set_clr_tog_write(void *opaque, hwaddr offset,
+                                     uint64_t value, unsigned size)
+{
+    const uint8_t  bitop = CCM_BITOP(offset);
+    const uint32_t index = CCM_INDEX(offset);
+    uint32_t *mmio = opaque;
+
+    switch (bitop) {
+    case CCM_BITOP_NONE:
+        mmio[index]  = value;
+        break;
+    case CCM_BITOP_SET:
+        mmio[index] |= value;
+        break;
+    case CCM_BITOP_CLR:
+        mmio[index] &= ~value;
+        break;
+    case CCM_BITOP_TOG:
+        mmio[index] ^= value;
+        break;
+    };
+}
+
+static const struct MemoryRegionOps imx8mm_set_clr_tog_ops = {
+    .read = imx8mm_set_clr_tog_read,
+    .write = imx8mm_set_clr_tog_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+    .impl = {
+        /*
+         * Our device would not work correctly if the guest was doing
+         * unaligned access. This might not be a limitation on the real
+         * device but in practice there is no reason for a guest to access
+         * this device unaligned.
+         */
+        .min_access_size = 4,
+        .max_access_size = 4,
+        .unaligned = false,
+    },
+};
+
+static void imx8mm_ccm_init(Object *obj)
+{
+    SysBusDevice *sd = SYS_BUS_DEVICE(obj);
+    IMX8MMCCMState *s = IMX8MM_CCM(obj);
+
+    memory_region_init_io(&s->iomem,
+                          obj,
+                          &imx8mm_set_clr_tog_ops,
+                          s->ccm,
+                          TYPE_IMX8MM_CCM ".ccm",
+                          sizeof(s->ccm));
+
+    sysbus_init_mmio(sd, &s->iomem);
+}
+
+static const VMStateDescription imx8mm_ccm_vmstate = {
+    .name = TYPE_IMX8MM_CCM,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32_ARRAY(ccm, IMX8MMCCMState, CCM_MAX),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
+static uint32_t imx8mm_ccm_get_clock_frequency(IMXCCMState *dev, IMXClk clock)
+{
+    /*
+     * This function is "consumed" by GPT emulation code. Some clocks
+     * have fixed frequencies and we can provide requested frequency
+     * easily. However for CCM provided clocks (like IPG) each GPT
+     * timer can have its own clock root.
+     * This means we need additional information when calling this
+     * function to know the requester's identity.
+     */
+    uint32_t freq = 0;
+
+    switch (clock) {
+    case CLK_NONE:
+        break;
+    case CLK_32k:
+        freq = CKIL_FREQ;
+        break;
+    case CLK_HIGH:
+        freq = CKIH_FREQ;
+        break;
+    case CLK_IPG:
+    case CLK_IPG_HIGH:
+        /*
+         * For now we don't have a way to figure out the device this
+         * function is called for. Until then the IPG derived clocks
+         * are left unimplemented.
+         */
+        qemu_log_mask(LOG_GUEST_ERROR, "[%s]%s: Clock %d Not implemented\n",
+                      TYPE_IMX8MM_CCM, __func__, clock);
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR, "[%s]%s: unsupported clock %d\n",
+                      TYPE_IMX8MM_CCM, __func__, clock);
+        break;
+    }
+
+    trace_ccm_clock_freq(clock, freq);
+
+    return freq;
+}
+
+static void imx8mm_ccm_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    IMXCCMClass *ccm = IMX_CCM_CLASS(klass);
+
+    device_class_set_legacy_reset(dc, imx8mm_ccm_reset);
+    dc->vmsd  = &imx8mm_ccm_vmstate;
+    dc->desc  = "i.MX 8MM Clock Control Module";
+
+    ccm->get_clock_frequency = imx8mm_ccm_get_clock_frequency;
+}
+
+static const TypeInfo imx8mm_ccm_types[] = {
+    {
+        .name          = TYPE_IMX8MM_CCM,
+        .parent        = TYPE_IMX_CCM,
+        .instance_size = sizeof(IMX8MMCCMState),
+        .instance_init = imx8mm_ccm_init,
+        .class_init    = imx8mm_ccm_class_init,
+    },
+};
+
+DEFINE_TYPES(imx8mm_ccm_types);
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index b1d8d8e5d2..556daea9bc 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -57,6 +57,8 @@ system_ss.add(when: 'CONFIG_ECCMEMCTL', if_true: files('eccmemctl.c'))
 system_ss.add(when: 'CONFIG_EXYNOS4', if_true: files('exynos4210_pmu.c', 'exynos4210_clk.c', 'exynos4210_rng.c'))
 system_ss.add(when: 'CONFIG_FSL_IMX8MP_ANALOG', if_true: files('imx8mp_analog.c'))
 system_ss.add(when: 'CONFIG_FSL_IMX8MP_CCM', if_true: files('imx8mp_ccm.c'))
+system_ss.add(when: 'CONFIG_FSL_IMX8MM_ANALOG', if_true: files('imx8mm_analog.c'))
+system_ss.add(when: 'CONFIG_FSL_IMX8MM_CCM', if_true: files('imx8mm_ccm.c'))
 system_ss.add(when: 'CONFIG_IMX', if_true: files(
   'imx25_ccm.c',
   'imx31_ccm.c',
diff --git a/include/hw/arm/fsl-imx8mm.h b/include/hw/arm/fsl-imx8mm.h
index aa954ea00b..0716484429 100644
--- a/include/hw/arm/fsl-imx8mm.h
+++ b/include/hw/arm/fsl-imx8mm.h
@@ -12,6 +12,8 @@
 #include "cpu.h"
 #include "hw/char/imx_serial.h"
 #include "hw/intc/arm_gicv3_common.h"
+#include "hw/misc/imx8mm_analog.h"
+#include "hw/misc/imx8mm_ccm.h"
 #include "qom/object.h"
 #include "qemu/units.h"
 
@@ -32,6 +34,8 @@ struct FslImx8mmState {
 
     ARMCPU             cpu[FSL_IMX8MM_NUM_CPUS];
     GICv3State         gic;
+    IMX8MMCCMState     ccm;
+    IMX8MMAnalogState  analog;
     IMXSerialState     uart[FSL_IMX8MM_NUM_UARTS];
 };
 
diff --git a/include/hw/misc/imx8mm_analog.h b/include/hw/misc/imx8mm_analog.h
new file mode 100644
index 0000000000..e16e2a0cf1
--- /dev/null
+++ b/include/hw/misc/imx8mm_analog.h
@@ -0,0 +1,81 @@
+/*
+ * Copyright (c) 2025 Gaurav Sharma <gaurav.sharma_7@nxp.com>
+ *
+ * i.MX8MM ANALOG IP block emulation code
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef IMX8MM_ANALOG_H
+#define IMX8MM_ANALOG_H
+
+#include "qom/object.h"
+#include "hw/sysbus.h"
+
+enum IMX8MMAnalogRegisters {
+    ANALOG_AUDIO_PLL1_GEN_CTRL = 0x000 / 4,
+    ANALOG_AUDIO_PLL1_FDIV_CTL0 = 0x004 / 4,
+    ANALOG_AUDIO_PLL1_FDIV_CTL1 = 0x008 / 4,
+    ANALOG_AUDIO_PLL1_SSCG_CTRL = 0x00c / 4,
+    ANALOG_AUDIO_PLL1_MNIT_CTRL = 0x010 / 4,
+    ANALOG_AUDIO_PLL2_GEN_CTRL = 0x014 / 4,
+    ANALOG_AUDIO_PLL2_FDIV_CTL0 = 0x018 / 4,
+    ANALOG_AUDIO_PLL2_FDIV_CTL1 = 0x01c / 4,
+    ANALOG_AUDIO_PLL2_SSCG_CTRL = 0x020 / 4,
+    ANALOG_AUDIO_PLL2_MNIT_CTRL = 0x024 / 4,
+    ANALOG_VIDEO_PLL1_GEN_CTRL = 0x028 / 4,
+    ANALOG_VIDEO_PLL1_FDIV_CTL0 = 0x02c / 4,
+    ANALOG_VIDEO_PLL1_FDIV_CTL1 = 0x030 / 4,
+    ANALOG_VIDEO_PLL1_SSCG_CTRL = 0x034 / 4,
+    ANALOG_VIDEO_PLL1_MNIT_CTRL = 0x038 / 4,
+    ANALOG_DRAM_PLL_GEN_CTRL = 0x050 / 4,
+    ANALOG_DRAM_PLL_FDIV_CTL0 = 0x054 / 4,
+    ANALOG_DRAM_PLL_FDIV_CTL1 = 0x058 / 4,
+    ANALOG_DRAM_PLL_SSCG_CTRL = 0x05c / 4,
+    ANALOG_DRAM_PLL_MNIT_CTRL = 0x060 / 4,
+    ANALOG_GPU_PLL_GEN_CTRL = 0x064 / 4,
+    ANALOG_GPU_PLL_FDIV_CTL0 = 0x068 / 4,
+    ANALOG_GPU_PLL_LOCKD_CTRL = 0x06c / 4,
+    ANALOG_GPU_PLL_MNIT_CTRL = 0x070 / 4,
+    ANALOG_VPU_PLL_GEN_CTRL = 0x074 / 4,
+    ANALOG_VPU_PLL_FDIV_CTL0 = 0x078 / 4,
+    ANALOG_VPU_PLL_LOCKD_CTRL = 0x07c / 4,
+    ANALOG_VPU_PLL_MNIT_CTRL = 0x080 / 4,
+    ANALOG_ARM_PLL_GEN_CTRL = 0x084 / 4,
+    ANALOG_ARM_PLL_FDIV_CTL0 = 0x088 / 4,
+    ANALOG_ARM_PLL_LOCKD_CTRL = 0x08c / 4,
+    ANALOG_ARM_PLL_MNIT_CTRL = 0x090 / 4,
+    ANALOG_SYS_PLL1_GEN_CTRL = 0x094 / 4,
+    ANALOG_SYS_PLL1_FDIV_CTL0 = 0x098 / 4,
+    ANALOG_SYS_PLL1_LOCKD_CTRL = 0x09c / 4,
+    ANALOG_SYS_PLL1_MNIT_CTRL = 0x100 / 4,
+    ANALOG_SYS_PLL2_GEN_CTRL = 0x104 / 4,
+    ANALOG_SYS_PLL2_FDIV_CTL0 = 0x108 / 4,
+    ANALOG_SYS_PLL2_LOCKD_CTRL = 0x10c / 4,
+    ANALOG_SYS_PLL2_MNIT_CTRL = 0x110 / 4,
+    ANALOG_SYS_PLL3_GEN_CTRL = 0x114 / 4,
+    ANALOG_SYS_PLL3_FDIV_CTL0 = 0x118 / 4,
+    ANALOG_SYS_PLL3_LOCKD_CTRL = 0x11c / 4,
+    ANALOG_SYS_PLL3_MNIT_CTRL = 0x120 / 4,
+    ANALOG_OSC_MISC_CFG = 0x124 / 4,
+    ANALOG_ANAMIX_PLL_MNIT_CTL = 0x128 / 4,
+
+    ANALOG_DIGPROG = 0x800 / 4,
+    ANALOG_MAX,
+};
+
+#define TYPE_IMX8MM_ANALOG "imx8mm.analog"
+OBJECT_DECLARE_SIMPLE_TYPE(IMX8MMAnalogState, IMX8MM_ANALOG)
+
+struct IMX8MMAnalogState {
+    SysBusDevice parent_obj;
+
+    struct {
+        MemoryRegion container;
+        MemoryRegion analog;
+    } mmio;
+
+    uint32_t analog[ANALOG_MAX];
+};
+
+#endif /* IMX8MM_ANALOG_H */
diff --git a/include/hw/misc/imx8mm_ccm.h b/include/hw/misc/imx8mm_ccm.h
new file mode 100644
index 0000000000..e02e25f178
--- /dev/null
+++ b/include/hw/misc/imx8mm_ccm.h
@@ -0,0 +1,30 @@
+/*
+ * Copyright (c) 2025 Gaurav Sharma <gaurav.sharma_7@nxp.com>
+ *
+ * i.MX 8MM CCM IP block emulation code
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef IMX8MM_CCM_H
+#define IMX8MM_CCM_H
+
+#include "hw/misc/imx_ccm.h"
+#include "qom/object.h"
+
+enum IMX8MMCCMRegisters {
+    CCM_MAX = 0xc6fc / sizeof(uint32_t) + 1,
+};
+
+#define TYPE_IMX8MM_CCM "imx8mm.ccm"
+OBJECT_DECLARE_SIMPLE_TYPE(IMX8MMCCMState, IMX8MM_CCM)
+
+struct IMX8MMCCMState {
+    IMXCCMState parent_obj;
+
+    MemoryRegion iomem;
+
+    uint32_t ccm[CCM_MAX];
+};
+
+#endif /* IMX8MM_CCM_H */
-- 
2.34.1


