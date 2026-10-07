Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E7D7CA6009
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 10:13:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEOd1-0004zA-1L; Wed, 07 Oct 2026 06:12:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaurav.sharma_7@nxp.com>)
 id 1xEOcP-0004Gs-NX; Wed, 07 Oct 2026 06:11:30 -0400
Received: from inva020.nxp.com ([92.121.34.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaurav.sharma_7@nxp.com>)
 id 1xEOcM-0004Q1-FR; Wed, 07 Oct 2026 06:11:25 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 209C41A0024;
 Wed,  7 Oct 2026 12:11:21 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id C18C21A0021;
 Wed,  7 Oct 2026 12:11:20 +0200 (CEST)
Received: from lsv031015.swis.in-blr01.nxp.com
 (lsv031015.swis.in-blr01.nxp.com [10.12.177.77])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id A9BF3180023E;
 Wed,  7 Oct 2026 18:11:18 +0800 (+08)
From: Gaurav Sharma <gaurav.sharma_7@nxp.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, pbonzini@redhat.com, peter.maydell@linaro.org,
 shentey@gmail.com, pierrick.bouvier@oss.qualcomm.com,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>
Subject: [PATCHv4 06/11] hw/misc: Add SRC (System Reset Controller) to i.MX8MP
Date: Wed,  7 Oct 2026 15:41:00 +0530
Message-Id: <20261007101105.3917771-7-gaurav.sharma_7@nxp.com>
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

Add emulation of the i.MX8MP System Reset Controller.
The SRC manages reset control for various subsystems on the i.MX8MP SoC.
SRC registers are used to start/stop/poll the M7 core, hence needed for
AMP boot.

Signed-off-by: Gaurav Sharma <gaurav.sharma_7@nxp.com>
---
 docs/system/arm/imx8m.rst    |   5 +-
 hw/arm/Kconfig               |   1 +
 hw/arm/fsl-imx8mp.c          |  10 +
 hw/misc/Kconfig              |   3 +
 hw/misc/imx8mp_src.c         | 397 +++++++++++++++++++++++++++++++++++
 hw/misc/meson.build          |   1 +
 hw/misc/trace-events         |   5 +
 include/hw/arm/fsl-imx8mp.h  |   2 +
 include/hw/misc/imx8mp_src.h |  47 +++++
 9 files changed, 469 insertions(+), 2 deletions(-)
 create mode 100644 hw/misc/imx8mp_src.c
 create mode 100644 include/hw/misc/imx8mp_src.h

diff --git a/docs/system/arm/imx8m.rst b/docs/system/arm/imx8m.rst
index 7813469154..38f4e31443 100644
--- a/docs/system/arm/imx8m.rst
+++ b/docs/system/arm/imx8m.rst
@@ -26,8 +26,9 @@ following devices:
  * 6 General Purpose Timers
  * Secure Non-Volatile Storage (SNVS) including an RTC
  * Clock Tree
- * General Power Controller (GPC)
- * General Purpose Register (GPR)
+ * General Power Controller
+ * General Purpose Register
+ * System Reset Controller
 
 Boot options
 ------------
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 7b7378110c..2ab57b7c53 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -596,6 +596,7 @@ config FSL_IMX8MP
     select FSL_IMX8MP_CCM
     select FSL_IMX8MP_GPC
     select FSL_IMX8MP_GPR
+    select FSL_IMX8MP_SRC
     select IMX
     select IMX_FEC
     select IMX_I2C
diff --git a/hw/arm/fsl-imx8mp.c b/hw/arm/fsl-imx8mp.c
index 75860d360c..63513b3ff3 100644
--- a/hw/arm/fsl-imx8mp.c
+++ b/hw/arm/fsl-imx8mp.c
@@ -208,6 +208,8 @@ static void fsl_imx8mp_init(Object *obj)
 
     object_initialize_child(obj, "gpr", &s->gpr, TYPE_IMX8MP_GPR);
 
+    object_initialize_child(obj, "src", &s->src, TYPE_IMX8MP_SRC);
+
     for (i = 0; i < FSL_IMX8MP_NUM_UARTS; i++) {
         g_autofree char *name = g_strdup_printf("uart%d", i + 1);
         object_initialize_child(obj, name, &s->uart[i], TYPE_IMX_SERIAL);
@@ -431,6 +433,13 @@ static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
                            qdev_get_gpio_in(gicdev, serial_table[i].irq));
     }
 
+    /* SRC */
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->src), errp)) {
+        return;
+    }
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->src), 0,
+                    fsl_imx8mp_memmap[FSL_IMX8MP_SRC].addr);
+
     /* GPC */
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->gpc), errp)) {
         return;
@@ -750,6 +759,7 @@ static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
         case FSL_IMX8MP_PCIE_PHY1:
         case FSL_IMX8MP_RAM:
         case FSL_IMX8MP_SNVS_HP:
+        case FSL_IMX8MP_SRC:
         case FSL_IMX8MP_UART1 ... FSL_IMX8MP_UART4:
         case FSL_IMX8MP_USB1 ... FSL_IMX8MP_USB2:
         case FSL_IMX8MP_USDHC1 ... FSL_IMX8MP_USDHC3:
diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index 5c2945200e..d9e904ae2f 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -107,6 +107,9 @@ config FSL_IMX8MP_GPC
 config FSL_IMX8MP_GPR
     bool
 
+config FSL_IMX8MP_SRC
+    bool
+
 config STM32_RCC
     bool
 
diff --git a/hw/misc/imx8mp_src.c b/hw/misc/imx8mp_src.c
new file mode 100644
index 0000000000..cb998550e7
--- /dev/null
+++ b/hw/misc/imx8mp_src.c
@@ -0,0 +1,397 @@
+/*
+ * i.MX 8M Plus System Reset Controller
+ *
+ * Copyright (c) 2026, NXP Semiconductors
+ * Author: Gaurav Sharma <gaurav.sharma_7@nxp.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/misc/imx8mp_src.h"
+#include "hw/misc/imx8mp_gpr.h"
+#include "hw/core/qdev-properties.h"
+#include "hw/core/resettable.h"
+#include "hw/core/registerfields.h"
+#include "qapi/error.h"
+#include "migration/vmstate.h"
+#include "qemu/log.h"
+#include "target/arm/arm-powerctl.h"
+#include "target/arm/cpu.h"
+#include "trace.h"
+
+REG32(SRC_SCR, 0x0000)
+
+REG32(SRC_A53RCR0, 0x0004)
+
+REG32(SRC_A53RCR1, 0x0008)
+
+REG32(SRC_M7RCR, 0x000c)
+REG32(SRC_SUPERMIX_RCR, 0x0018)
+REG32(SRC_AUDIOMIX_RCR, 0x001c)
+REG32(SRC_USBPHY1_RCR, 0x0020)
+REG32(SRC_USBPHY2_RCR, 0x0024)
+REG32(SRC_MLMIX_RCR, 0x0028)
+REG32(SRC_PCIEPHY_RCR, 0x002c)
+REG32(SRC_HDMI_RCR, 0x0030)
+REG32(SRC_MEDIA_RCR, 0x0034)
+REG32(SRC_GPU2D_RCR, 0x0038)
+REG32(SRC_GPU3D_RCR, 0x003c)
+REG32(SRC_GPU_RCR, 0x0040)
+REG32(SRC_VPU_RCR, 0x0044)
+REG32(SRC_VPU_G1_RCR, 0x0048)
+REG32(SRC_VPU_G2_RCR, 0x004c)
+REG32(SRC_VPUVC8KE_RCR, 0x0050)
+REG32(SRC_NOC_RCR, 0x0054)
+REG32(SRC_SBMR1, 0x0058)
+REG32(SRC_SRSR, 0x005c)
+REG32(SRC_SISR, 0x0068)
+REG32(SRC_SIMR, 0x006c)
+
+REG32(SRC_SBMR2, 0x0070)
+
+REG32(SRC_GPR1, 0x0074)
+REG32(SRC_GPR2, 0x0078)
+REG32(SRC_GPR3, 0x007c)
+REG32(SRC_GPR4, 0x0080)
+REG32(SRC_GPR5, 0x0084)
+REG32(SRC_GPR6, 0x0088)
+REG32(SRC_GPR7, 0x008c)
+REG32(SRC_GPR8, 0x0090)
+REG32(SRC_GPR9, 0x0094)
+REG32(SRC_GPR10, 0x0098)
+REG32(SRC_DDRC_RCR, 0x1000)
+REG32(SRC_HDMIPHY_RCR, 0x1008)
+REG32(SRC_MIPIPHY1_RCR, 0x100c)
+REG32(SRC_MIPIPHY2_RCR, 0x1010)
+REG32(SRC_HSIO_RCR, 0x1014)
+REG32(SRC_MEDIAISPDWP_RCR, 0x1018)
+
+static const char *fsl_imx8mp_src_reg_name(uint32_t reg)
+{
+    switch (reg) {
+    case R_SRC_SCR:
+        return " (SRC_SCR)";
+    case R_SRC_A53RCR0:
+        return " (SRC_A53RCR0)";
+    case R_SRC_A53RCR1:
+        return " (SRC_A53RCR1)";
+    case R_SRC_M7RCR:
+        return " (SRC_M7RCR)";
+    case R_SRC_SUPERMIX_RCR:
+        return " (SRC_SUPERMIX_RCR)";
+    case R_SRC_AUDIOMIX_RCR:
+        return " (SRC_AUDIOMIX_RCR)";
+    case R_SRC_USBPHY1_RCR:
+        return " (SRC_USBPHY1_RCR)";
+    case R_SRC_USBPHY2_RCR:
+        return " (SRC_USBPHY2_RCR)";
+    case R_SRC_MLMIX_RCR:
+        return " (SRC_MLMIX_RCR)";
+    case R_SRC_PCIEPHY_RCR:
+        return " (SRC_PCIEPHY_RCR)";
+    case R_SRC_HDMI_RCR:
+        return " (SRC_HDMI_RCR)";
+    case R_SRC_MEDIA_RCR:
+        return " (SRC_MEDIA_RCR)";
+    case R_SRC_GPU2D_RCR:
+        return " (SRC_GPU2D_RCR)";
+    case R_SRC_GPU3D_RCR:
+        return " (SRC_GPU3D_RCR)";
+    case R_SRC_GPU_RCR:
+        return " (SRC_GPU_RCR)";
+    case R_SRC_VPU_RCR:
+        return " (SRC_VPU_RCR)";
+    case R_SRC_VPU_G1_RCR:
+        return " (SRC_VPU_G1_RCR)";
+    case R_SRC_VPU_G2_RCR:
+        return " (SRC_VPU_G2_RCR)";
+    case R_SRC_VPUVC8KE_RCR:
+        return " (SRC_VPUVC8KE_RCR)";
+    case R_SRC_NOC_RCR:
+        return " (SRC_NOC_RCR)";
+    case R_SRC_SBMR1:
+        return " (SRC_SBMR1)";
+    case R_SRC_SRSR:
+        return " (SRC_SRSR)";
+    case R_SRC_SISR:
+        return " (SRC_SISR)";
+    case R_SRC_SIMR:
+        return " (SRC_SIMR)";
+    case R_SRC_SBMR2:
+        return " (SRC_SBMR2)";
+    case R_SRC_GPR1:
+        return " (SRC_GPR1)";
+    case R_SRC_GPR2:
+        return " (SRC_GPR2)";
+    case R_SRC_GPR3:
+        return " (SRC_GPR3)";
+    case R_SRC_GPR4:
+        return " (SRC_GPR4)";
+    case R_SRC_GPR5:
+        return " (SRC_GPR5)";
+    case R_SRC_GPR6:
+        return " (SRC_GPR6)";
+    case R_SRC_GPR7:
+        return " (SRC_GPR7)";
+    case R_SRC_GPR8:
+        return " (SRC_GPR8)";
+    case R_SRC_GPR9:
+        return " (SRC_GPR9)";
+    case R_SRC_GPR10:
+        return " (SRC_GPR10)";
+    case R_SRC_DDRC_RCR:
+        return " (SRC_DDRC_RCR)";
+    case R_SRC_HDMIPHY_RCR:
+        return " (SRC_HDMIPHY_RCR)";
+    case R_SRC_MIPIPHY1_RCR:
+        return " (SRC_MIPIPHY1_RCR)";
+    case R_SRC_MIPIPHY2_RCR:
+        return " (SRC_MIPIPHY2_RCR)";
+    case R_SRC_HSIO_RCR:
+        return " (SRC_HSIO_RCR)";
+    case R_SRC_MEDIAISPDWP_RCR:
+        return " (SRC_MEDIAISPDWP_RCR)";
+    default:
+        return " (reserved)";
+    }
+}
+
+static uint32_t imx8mp_src_cm7_vbase(FslImx8mpSrcState *s)
+{
+    uint32_t gpr6 = s->gpr ? s->gpr->gpr[IOMUXC_GPR_GPR6] : 0;
+
+    return gpr6 & 0xffffff80;
+}
+
+static void imx8mp_src_cm7_reset_run(CPUState *cpu, run_on_cpu_data data)
+{
+    FslImx8mpSrcState *s = data.host_ptr;
+    ARMCPU *m7 = ARM_CPU(cpu);
+
+    m7->init_nsvtor = imx8mp_src_cm7_vbase(s);
+    arm_set_cpu_on_and_reset(arm_cpu_mp_affinity(m7));
+}
+
+static void imx8mp_src_cm7_off(CPUState *cpu, run_on_cpu_data data)
+{
+    arm_set_cpu_off(arm_cpu_mp_affinity(ARM_CPU(cpu)));
+}
+
+static void imx8mp_src_cm7_reset_request(FslImx8mpSrcState *s)
+{
+    if (!s->cm7_cpu) {
+        return;
+    }
+    if (s->cm7_cpuwait) {
+        async_run_on_cpu(CPU(s->cm7_cpu), imx8mp_src_cm7_off,
+                         RUN_ON_CPU_HOST_PTR(s));
+    } else {
+        async_run_on_cpu(CPU(s->cm7_cpu), imx8mp_src_cm7_reset_run,
+                         RUN_ON_CPU_HOST_PTR(s));
+    }
+}
+
+/*
+ * React to a CPUWAIT level change.
+ * level=1: CPUWAIT cleared (run); level=0: CPUWAIT set (halt).
+ */
+static void imx8mp_src_cm7_set_cpuwait(FslImx8mpSrcState *s, bool run)
+{
+    if (!s->cm7_cpu) {
+        return;
+    }
+    if (run) {
+        CPUState *cpu = CPU(s->cm7_cpu);
+        if (cpu->halted) {
+            async_run_on_cpu(cpu, imx8mp_src_cm7_reset_run,
+                             RUN_ON_CPU_HOST_PTR(s));
+        }
+    } else {
+        async_run_on_cpu(CPU(s->cm7_cpu), imx8mp_src_cm7_off,
+                         RUN_ON_CPU_HOST_PTR(s));
+    }
+}
+
+static uint64_t fsl_imx8mp_src_read(void *opaque, hwaddr offset,
+                                    unsigned size)
+{
+    FslImx8mpSrcState *s = opaque;
+    const uint32_t reg = offset / 4;
+    uint32_t value = 0;
+
+    if (reg < FSL_IMX8MP_SRC_NUM_REGS) {
+        value = s->regs[reg];
+    } else {
+        qemu_log_mask(LOG_UNIMP, "[%s]%s: Unimplemented register at offset 0x%"
+                      HWADDR_PRIx "\n", TYPE_IMX8MP_SRC, __func__,
+                      offset);
+    }
+
+    trace_fsl_imx8mp_src_read(offset, fsl_imx8mp_src_reg_name(reg), value);
+
+    return value;
+}
+
+static void fsl_imx8mp_src_write(void *opaque, hwaddr offset, uint64_t value,
+                                 unsigned size)
+{
+    FslImx8mpSrcState *s = opaque;
+    const uint32_t reg = offset / 4;
+
+    if (reg >= FSL_IMX8MP_SRC_NUM_REGS) {
+        qemu_log_mask(LOG_UNIMP, "[%s]%s: Unimplemented register at offset 0x%"
+                      HWADDR_PRIx "\n", TYPE_IMX8MP_SRC, __func__,
+                      offset);
+        goto done;
+    }
+
+    switch (reg) {
+    case R_SRC_M7RCR: {
+        uint32_t old_value = s->regs[reg];
+        uint32_t new_value = (uint32_t)value;
+        uint32_t changed;
+        bool reset_pulse = false;
+
+        /*
+         * SW_M7C_RST (bit1) is self-clearing on real HW: writing 1 triggers
+         * an M7 core-reset pulse and the bit reads back 0.
+         */
+        if (new_value & SRC_M7RCR_SW_M7C_RST) {
+            reset_pulse = true;
+            new_value &= ~SRC_M7RCR_SW_M7C_RST;
+        }
+
+        s->regs[reg] = new_value;
+        changed = old_value ^ new_value;
+
+        if (reset_pulse) {
+            /* Self-clearing core-reset pulse -> reset (honoring CPUWAIT). */
+            imx8mp_src_cm7_reset_request(s);
+            break;
+        }
+
+        if (changed & SRC_M7RCR_SW_M7C_NON_SCLR_RST) {
+            bool held = new_value & SRC_M7RCR_SW_M7C_NON_SCLR_RST;
+            /* NON_SCLR latch: 1 = hold in reset (off); 0 = release. */
+            if (held) {
+                if (s->cm7_cpu) {
+                    async_run_on_cpu(CPU(s->cm7_cpu), imx8mp_src_cm7_off,
+                                     RUN_ON_CPU_HOST_PTR(s));
+                }
+            } else {
+                imx8mp_src_cm7_reset_request(s);
+            }
+        }
+        break;
+    }
+    default:
+        s->regs[reg] = value;
+        break;
+    }
+
+done:
+
+    trace_fsl_imx8mp_src_write(offset, fsl_imx8mp_src_reg_name(reg), value);
+}
+
+static const struct MemoryRegionOps imx8mp_src_ops = {
+    .read = fsl_imx8mp_src_read,
+    .write = fsl_imx8mp_src_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
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
+static void imx8mp_src_reset_enter(Object *obj, ResetType type)
+{
+    FslImx8mpSrcState *s = IMX8MP_SRC(obj);
+    FslImx8mpSrcClass *sc = IMX8MP_SRC_GET_CLASS(obj);
+
+    if (sc->parent_phases.enter) {
+        sc->parent_phases.enter(obj, type);
+    }
+
+    memset(s->regs, 0, sizeof(s->regs));
+
+    /*
+     * Default CM7 STOP state for Linux imx-rproc MMIO mode detection.
+     */
+    s->regs[R_SRC_M7RCR] = 0x000000A8;
+}
+
+static void imx8mp_src_cm7_cpuwait_handler(void *opaque, int n, int level)
+{
+    FslImx8mpSrcState *s = opaque;
+
+    s->cm7_cpuwait = !level;
+    imx8mp_src_cm7_set_cpuwait(s, (bool)level);
+}
+
+static void imx8mp_src_realize(DeviceState *dev, Error **errp)
+{
+    FslImx8mpSrcState *s = IMX8MP_SRC(dev);
+
+    memory_region_init_io(&s->iomem, OBJECT(dev), &imx8mp_src_ops, s,
+                          TYPE_IMX8MP_SRC, 0x1000);
+    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->iomem);
+    qdev_init_gpio_in_named(dev, imx8mp_src_cm7_cpuwait_handler, "cm7-cpuwait", 1);
+}
+
+static const VMStateDescription imx8mp_src_vmstate = {
+    .name = TYPE_IMX8MP_SRC,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32_ARRAY(regs, FslImx8mpSrcState, FSL_IMX8MP_SRC_NUM_REGS),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
+static const Property imx8mp_src_properties[] = {
+    DEFINE_PROP_UINT32("cm7-vector-base", FslImx8mpSrcState, cm7_vector_base,
+                       0x80000000),
+    DEFINE_PROP_LINK("cm7-cpu", FslImx8mpSrcState, cm7_cpu,
+                     TYPE_ARM_CPU, ARMCPU *),
+    DEFINE_PROP_LINK("gpr", FslImx8mpSrcState, gpr,
+                     TYPE_IMX8MP_GPR, IMX8MPGPRState *),
+};
+
+static void imx8mp_src_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
+
+    FslImx8mpSrcClass *sc = IMX8MP_SRC_CLASS(klass);
+
+    resettable_class_set_parent_phases(rc,
+                                       imx8mp_src_reset_enter,
+                                       NULL,
+                                       NULL,
+                                       &sc->parent_phases);
+    dc->realize = imx8mp_src_realize;
+    dc->vmsd = &imx8mp_src_vmstate;
+    device_class_set_props(dc, imx8mp_src_properties);
+    dc->desc = "i.MX 8M Plus System Reset Controller";
+}
+
+static const TypeInfo imx8mp_src_types[] = {
+    {
+        .name          = TYPE_IMX8MP_SRC,
+        .parent        = TYPE_SYS_BUS_DEVICE,
+        .instance_size = sizeof(FslImx8mpSrcState),
+        .class_size    = sizeof(FslImx8mpSrcClass),
+        .class_init    = imx8mp_src_class_init,
+    },
+};
+
+DEFINE_TYPES(imx8mp_src_types)
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 5eda094d34..79954586e8 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -64,6 +64,7 @@ system_ss.add(when: 'CONFIG_FSL_IMX8MP_ANALOG', if_true: files('imx8mp_analog.c'
 system_ss.add(when: 'CONFIG_FSL_IMX8MP_CCM', if_true: files('imx8mp_ccm.c'))
 system_ss.add(when: 'CONFIG_FSL_IMX8MP_GPC', if_true: files('imx8mp_gpc.c'))
 system_ss.add(when: 'CONFIG_FSL_IMX8MP_GPR', if_true: files('imx8mp_gpr.c'))
+system_ss.add(when: 'CONFIG_FSL_IMX8MP_SRC', if_true: files('imx8mp_src.c'))
 system_ss.add(when: 'CONFIG_IMX', if_true: files(
   'imx25_ccm.c',
   'imx31_ccm.c',
diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index 6db4934dc5..6239200f37 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -131,6 +131,11 @@ imx7_gpr_write(uint64_t offset, uint64_t value) "addr 0x%08" PRIx64 "value 0x%08
 imx7_snvs_read(uint64_t offset, uint64_t value, unsigned size) "i.MX SNVS read: offset 0x%08" PRIx64 " value 0x%08" PRIx64 " size %u"
 imx7_snvs_write(uint64_t offset, uint64_t value, unsigned size) "i.MX SNVS write: offset 0x%08" PRIx64 " value 0x%08" PRIx64 " size %u"
 
+# imx8mp_src.c
+fsl_imx8mp_src_read(uint64_t offset, const char *reg_name, uint32_t value) "[0x%" PRIx64 "%s] <- 0x%" PRIx32
+fsl_imx8mp_src_write(uint64_t offset, const char *reg_name, uint64_t value) "[0x%" PRIx64 "%s] <- 0x%" PRIx64
+fsl_imx8mp_src_clear_reset_bit(const char *reg_name, uint32_t value) "reg[%s] <= 0x%" PRIx32
+
 # mos6522.c
 mos6522_set_counter(int index, unsigned int val) "T%d.counter=%d"
 mos6522_get_next_irq_time(uint16_t latch, int64_t d, int64_t delta) "latch=%d counter=0x%"PRIx64 " delta_next=0x%"PRIx64
diff --git a/include/hw/arm/fsl-imx8mp.h b/include/hw/arm/fsl-imx8mp.h
index aacfbfd3a4..9b626e5d98 100644
--- a/include/hw/arm/fsl-imx8mp.h
+++ b/include/hw/arm/fsl-imx8mp.h
@@ -19,6 +19,7 @@
 #include "hw/misc/imx8mp_ccm.h"
 #include "hw/misc/imx8mp_gpc.h"
 #include "hw/misc/imx8mp_gpr.h"
+#include "hw/misc/imx8mp_src.h"
 #include "hw/net/flexcan.h"
 #include "hw/net/imx_fec.h"
 #include "hw/core/or-irq.h"
@@ -66,6 +67,7 @@ struct FslImx8mpState {
     IMX8MPAnalogState  analog;
     IMX7SNVSState      snvs;
     IMXSPIState        spi[FSL_IMX8MP_NUM_ECSPIS];
+    FslImx8mpSrcState  src;
     IMXI2CState        i2c[FSL_IMX8MP_NUM_I2CS];
     IMXSerialState     uart[FSL_IMX8MP_NUM_UARTS];
     IMXFECState        enet;
diff --git a/include/hw/misc/imx8mp_src.h b/include/hw/misc/imx8mp_src.h
new file mode 100644
index 0000000000..cf6a5c6e9b
--- /dev/null
+++ b/include/hw/misc/imx8mp_src.h
@@ -0,0 +1,47 @@
+/*
+ * i.MX 8M Plus System Reset Controller
+ *
+ * Copyright (c) 2026, NXP Semiconductors
+ * Author: Gaurav Sharma <gaurav.sharma_7@nxp.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef FSL_IMX8MP_SRC_H
+#define FSL_IMX8MP_SRC_H
+
+#include "hw/core/resettable.h"
+#include "hw/core/sysbus.h"
+#include "system/memory.h"
+#include "qom/object.h"
+#include "target/arm/cpu-qom.h"
+
+typedef struct IMX8MPGPRState IMX8MPGPRState;
+
+#define TYPE_IMX8MP_SRC "fsl-imx8mp-src"
+OBJECT_DECLARE_TYPE(FslImx8mpSrcState, FslImx8mpSrcClass, IMX8MP_SRC)
+
+struct FslImx8mpSrcClass {
+    SysBusDeviceClass parent_class;
+    ResettablePhases parent_phases;
+};
+
+#define FSL_IMX8MP_SRC_NUM_REGS (0x100 / 4)
+
+#define SRC_M7RCR_SW_M7C_NON_SCLR_RST  (1u << 0)  /* latching core reset */
+#define SRC_M7RCR_SW_M7C_RST           (1u << 1)  /* self-clearing pulse  */
+
+struct FslImx8mpSrcState {
+    SysBusDevice parent_obj;
+
+    MemoryRegion iomem;
+
+    uint32_t regs[FSL_IMX8MP_SRC_NUM_REGS];
+
+    ARMCPU           *cm7_cpu;
+    IMX8MPGPRState   *gpr;
+    bool              cm7_cpuwait;
+    uint32_t          cm7_vector_base;
+};
+
+#endif /* FSL_IMX8MP_SRC_H */
-- 
2.34.1


