Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5F46CA5FFF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 10:13:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEOd1-00053r-L0; Wed, 07 Oct 2026 06:12:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaurav.sharma_7@nxp.com>)
 id 1xEOcR-0004Hk-OF; Wed, 07 Oct 2026 06:11:31 -0400
Received: from inva020.nxp.com ([92.121.34.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaurav.sharma_7@nxp.com>)
 id 1xEOcO-0004QW-Gs; Wed, 07 Oct 2026 06:11:27 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id C72EE1A002E;
 Wed,  7 Oct 2026 12:11:22 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 7384C1A002F;
 Wed,  7 Oct 2026 12:11:22 +0200 (CEST)
Received: from lsv031015.swis.in-blr01.nxp.com
 (lsv031015.swis.in-blr01.nxp.com [10.12.177.77])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 7F2BC1800226;
 Wed,  7 Oct 2026 18:11:20 +0800 (+08)
From: Gaurav Sharma <gaurav.sharma_7@nxp.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, pbonzini@redhat.com, peter.maydell@linaro.org,
 shentey@gmail.com, pierrick.bouvier@oss.qualcomm.com,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>
Subject: [PATCHv4 07/11] hw/misc: Add MU (Messaging Unit) IP to i.MX8MP device
 model
Date: Wed,  7 Oct 2026 15:41:01 +0530
Message-Id: <20261007101105.3917771-8-gaurav.sharma_7@nxp.com>
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

Add emulation of the Messaging Unit and wire it into the
i.MX8MP SoC model. The MU provides inter-processor
communication between the Cortex-A53 and Cortex-M7 cores on the
i.MX8MP SoC. It is used by the Linux remoteproc framework as a
mailbox for lifecycle management and message passing with the
Cortex-M7 in an AMP configuration.

Signed-off-by: Gaurav Sharma <gaurav.sharma_7@nxp.com>
---
 docs/system/arm/imx8m.rst   |   1 +
 hw/arm/Kconfig              |   1 +
 hw/arm/fsl-imx8mp.c         |  41 +++++
 hw/misc/Kconfig             |   3 +
 hw/misc/imx8mp_mu.c         | 346 ++++++++++++++++++++++++++++++++++++
 hw/misc/meson.build         |   1 +
 include/hw/arm/fsl-imx8mp.h |  11 ++
 include/hw/misc/imx8mp_mu.h |  53 ++++++
 8 files changed, 457 insertions(+)
 create mode 100644 hw/misc/imx8mp_mu.c
 create mode 100644 include/hw/misc/imx8mp_mu.h

diff --git a/docs/system/arm/imx8m.rst b/docs/system/arm/imx8m.rst
index 38f4e31443..cdf862a456 100644
--- a/docs/system/arm/imx8m.rst
+++ b/docs/system/arm/imx8m.rst
@@ -29,6 +29,7 @@ following devices:
  * General Power Controller
  * General Purpose Register
  * System Reset Controller
+ * Messaging Unit
 
 Boot options
 ------------
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 2ab57b7c53..d92239fd4e 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -597,6 +597,7 @@ config FSL_IMX8MP
     select FSL_IMX8MP_GPC
     select FSL_IMX8MP_GPR
     select FSL_IMX8MP_SRC
+    select FSL_IMX8MP_MU
     select IMX
     select IMX_FEC
     select IMX_I2C
diff --git a/hw/arm/fsl-imx8mp.c b/hw/arm/fsl-imx8mp.c
index 63513b3ff3..c168c97d1a 100644
--- a/hw/arm/fsl-imx8mp.c
+++ b/hw/arm/fsl-imx8mp.c
@@ -210,6 +210,16 @@ static void fsl_imx8mp_init(Object *obj)
 
     object_initialize_child(obj, "src", &s->src, TYPE_IMX8MP_SRC);
 
+    /*
+     * MU instances: MU_1..MU_3, each with A/B endpoints
+     */
+    for (i = 0; i < FSL_IMX8MP_NUM_MU; i++) {
+        g_autofree char *name_a = g_strdup_printf("mu%d_a", i + 1);
+        g_autofree char *name_b = g_strdup_printf("mu%d_b", i + 1);
+        object_initialize_child(obj, name_a, &s->mu[i].a, TYPE_IMX8MP_MU);
+        object_initialize_child(obj, name_b, &s->mu[i].b, TYPE_IMX8MP_MU);
+    }
+
     for (i = 0; i < FSL_IMX8MP_NUM_UARTS; i++) {
         g_autofree char *name = g_strdup_printf("uart%d", i + 1);
         object_initialize_child(obj, name, &s->uart[i], TYPE_IMX_SERIAL);
@@ -500,6 +510,36 @@ static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
         }
     }
 
+    /* MU */
+    static const int mu_mmio_map[FSL_IMX8MP_NUM_MU][2] = {
+    [0] = { FSL_IMX8MP_MU_1_A, FSL_IMX8MP_MU_1_B },
+    [1] = { FSL_IMX8MP_MU_2_A, FSL_IMX8MP_MU_2_B },
+    [2] = { FSL_IMX8MP_MU_3_A, FSL_IMX8MP_MU_3_B },
+    };
+
+    for (i = 0; i < FSL_IMX8MP_NUM_MU; i++) {
+        hwaddr addr_a = fsl_imx8mp_memmap[mu_mmio_map[i][0]].addr;
+        hwaddr addr_b = fsl_imx8mp_memmap[mu_mmio_map[i][1]].addr;
+
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->mu[i].a), errp)) {
+            return;
+        }
+        sysbus_mmio_map(SYS_BUS_DEVICE(&s->mu[i].a), 0, addr_a);
+
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->mu[i].b), errp)) {
+            return;
+        }
+        sysbus_mmio_map(SYS_BUS_DEVICE(&s->mu[i].b), 0, addr_b);
+
+        s->mu[i].a.peer = &s->mu[i].b;
+        s->mu[i].b.peer = &s->mu[i].a;
+    }
+
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->mu[0].a), 0,
+                       qdev_get_gpio_in(gicdev, FSL_IMX8MP_MU1_A_IRQ));
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->mu[0].b), 0,
+                       qdev_get_gpio_in(gicdev, FSL_IMX8MP_MU1_B_IRQ));
+
     /* I2Cs */
     for (i = 0; i < FSL_IMX8MP_NUM_I2CS; i++) {
         struct {
@@ -754,6 +794,7 @@ static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
         case FSL_IMX8MP_ENET1:
         case FSL_IMX8MP_I2C1 ... FSL_IMX8MP_I2C6:
         case FSL_IMX8MP_IOMUXC_GPR:
+        case FSL_IMX8MP_MU_1_A ... FSL_IMX8MP_MU_3_B:
         case FSL_IMX8MP_OCRAM:
         case FSL_IMX8MP_PCIE1:
         case FSL_IMX8MP_PCIE_PHY1:
diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index d9e904ae2f..1e3b14b2a9 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -110,6 +110,9 @@ config FSL_IMX8MP_GPR
 config FSL_IMX8MP_SRC
     bool
 
+config FSL_IMX8MP_MU
+    bool
+
 config STM32_RCC
     bool
 
diff --git a/hw/misc/imx8mp_mu.c b/hw/misc/imx8mp_mu.c
new file mode 100644
index 0000000000..a5dac2a218
--- /dev/null
+++ b/hw/misc/imx8mp_mu.c
@@ -0,0 +1,346 @@
+/*
+ * NXP i.MX Messaging Unit (MU)
+ *
+ * Copyright (c) 2026, NXP Semiconductors
+ * Author: Gaurav Sharma <gaurav.sharma_7@nxp.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+
+#include "hw/misc/imx8mp_mu.h"
+#include "hw/core/irq.h"
+#include "hw/core/qdev-properties.h"
+#include "hw/core/resettable.h"
+#include "migration/vmstate.h"
+
+
+#define MU_SR_RFn_V1(x)   (1u << (24 + (3 - (x))))
+#define MU_SR_TEn_V1(x)   (1u << (20 + (3 - (x))))
+#define MU_SR_GIPn_V1(x)  (1u << (28 + (3 - (x))))
+#define MU_CR_RIEn_V1(x)  (1u << (24 + (3 - (x))))
+#define MU_CR_TIEn_V1(x)  (1u << (20 + (3 - (x))))
+#define MU_CR_GIEn_V1(x)  (1u << (28 + (3 - (x))))
+#define MU_CR_GIRn_V1(x)  (1u << (16 + (3 - (x))))
+
+
+static inline IMX8MPMUState *imx8mp_mu_peer(IMX8MPMUState *s)
+{
+    return s->peer;
+}
+
+static void imx8mp_mu_update_irq(IMX8MPMUState *s)
+{
+
+    bool pending = false;
+    uint32_t sr = s->mu[MU_SR];
+    uint32_t cr = s->mu[MU_CR];
+
+    for (int i = 0; i < 4; i++) {
+        /* TX done interrupt (TEn + TIEn) */
+        if ((sr & MU_SR_TEn_V1(i)) && (cr & MU_CR_TIEn_V1(i))) {
+            pending = true;
+            break;
+         }
+
+        /* RX data interrupt (RFn + RIEn) */
+        if ((sr & MU_SR_RFn_V1(i)) && (cr & MU_CR_RIEn_V1(i))) {
+            pending = true;
+            break;
+        }
+
+        /* Doorbell interrupt (GIPn + GIEn) - keep for completeness */
+        if ((sr & MU_SR_GIPn_V1(i)) && (cr & MU_CR_GIEn_V1(i))) {
+            pending = true;
+            break;
+        }
+    }
+    qemu_set_irq(s->irq, pending);
+}
+
+static uint64_t imx8mp_mu_read(void *opaque, hwaddr offset, unsigned size)
+{
+    IMX8MPMUState *s = opaque;
+    unsigned int reg;
+
+    if (size != 4) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "imx8mp_mu: invalid read size %u @0x%" HWADDR_PRIx "\n",
+                      size, offset);
+        return 0;
+    }
+
+    if (offset & 3) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "imx8mp_mu: unaligned read @0x%"
+              HWADDR_PRIx "\n", offset);
+        return 0;
+    }
+
+    reg = offset >> 2;
+    if (reg >= MU_MAX) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "imx8mp_mu: bad read @0x%" HWADDR_PRIx "\n",
+                      offset);
+        return 0;
+    }
+
+    if (reg < MU_RR0) {
+        unsigned int tr = reg - MU_TR0;
+        if (s->strict_access) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "imx8mp_mu: strict: read from TR%u"
+              " @0x%" HWADDR_PRIx "\n", tr, offset);
+            return 0;
+        }
+        return s->mu[MU_TR0 + tr];
+    }
+
+    if (reg >= MU_RR0 && reg < MU_SR) {
+        unsigned int rr = reg - MU_RR0;
+        uint32_t v = s->mu[MU_RR0 + rr];
+        IMX8MPMUState *p = imx8mp_mu_peer(s);
+
+        if (s->strict_access && !(s->mu[MU_SR] & MU_SR_RFn_V1(rr))) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "imx8mp_mu: strict: read from empty RR%u"
+              " @0x%" HWADDR_PRIx "\n", rr, offset);
+            return 0;
+        }
+
+        if (s->mu[MU_SR] & MU_SR_RFn_V1(rr)) {
+            s->mu[MU_SR] &= ~MU_SR_RFn_V1(rr);
+            if (p) {
+                p->mu[MU_SR] |= MU_SR_TEn_V1(rr);
+                imx8mp_mu_update_irq(p);
+            }
+        }
+        imx8mp_mu_update_irq(s);
+        return v;
+    }
+
+    switch (reg) {
+    case MU_SR:
+        return s->mu[MU_SR];
+    case MU_CR:
+        return s->mu[MU_CR];
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "imx8mp_mu: bad read @0x%" HWADDR_PRIx "\n", offset);
+        return 0;
+    }
+}
+
+static void imx8mp_mu_write(void *opaque, hwaddr offset,
+                             uint64_t value, unsigned size)
+{
+    IMX8MPMUState *s = opaque;
+    unsigned int reg;
+
+    if (size != 4) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "imx8mp_mu: invalid write size %u @0x%" HWADDR_PRIx "\n",
+                      size, offset);
+        return;
+    }
+
+    if (offset & 3) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "imx8mp_mu: unaligned write @0x%"
+                      HWADDR_PRIx "\n", offset);
+        return;
+    }
+
+    reg = offset >> 2;
+    if (reg >= MU_MAX) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "imx8mp_mu: bad write @0x%" HWADDR_PRIx
+                      " = 0x%08" PRIx64 "\n",
+                      offset, value);
+        return;
+    }
+    /* TR0..TR3 */
+    if (reg < MU_RR0) {
+        unsigned int tr = reg - MU_TR0;
+        uint32_t v = (uint32_t)value;
+        IMX8MPMUState *p = imx8mp_mu_peer(s);
+
+        if (s->strict_access && !(s->mu[MU_SR] & MU_SR_TEn_V1(tr))) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "imx8mp_mu: strict: write to non-empty"
+                          " TR%u @0x%" HWADDR_PRIx "\n",
+                          tr, offset);
+            return;
+        }
+
+        s->mu[MU_TR0 + tr] = v;
+
+        /*
+         * Writing TR consumes local TX-empty (TE=0) and delivers the word
+         * into peer RR while setting peer RX-full (RF=1).
+         *
+         */
+        s->mu[MU_SR] &= ~MU_SR_TEn_V1(tr); /* TE=0 */
+        if (p) {
+            p->mu[MU_RR0 + tr] = v;
+            p->mu[MU_SR] |= MU_SR_RFn_V1(tr); /* RF=1 */
+            imx8mp_mu_update_irq(p);
+        }
+
+        imx8mp_mu_update_irq(s);
+        return;
+    }
+
+    /* RR are read-only from this side */
+    if (reg >= MU_RR0 && reg < MU_SR) {
+        unsigned int rr = reg - MU_RR0;
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "imx8mp_mu: write to RR%d ignored\n", rr);
+        return;
+    }
+
+    switch (reg) {
+    case MU_CR: {
+        uint32_t v = (uint32_t)value;
+        IMX8MPMUState *p = imx8mp_mu_peer(s);
+        uint32_t gir_mask = 0;
+
+        for (int i = 0; i < 4; i++) {
+            gir_mask |= MU_CR_GIRn_V1(i);
+        }
+
+        if (p) {
+            for (int i = 0; i < 4; i++) {
+                if (v & MU_CR_GIRn_V1(i)) {
+                    /* Set peer doorbell pending */
+                    p->mu[MU_SR] |= MU_SR_GIPn_V1(i);
+                }
+            }
+            imx8mp_mu_update_irq(p);
+        }
+
+        /*
+         * Model GIRn as write-to-trigger (self-clearing) and keep other CR
+         * bits latched.
+         */
+        v &= ~gir_mask;
+
+        s->mu[MU_CR] = v;
+        imx8mp_mu_update_irq(s);
+        return;
+    }
+
+    case MU_SR: {
+
+        /* Write-1-to-clear for doorbell bits */
+        uint32_t v = (uint32_t)value;
+        for (int i = 0; i < 4; i++) {
+            if (v & MU_SR_GIPn_V1(i)) {
+                s->mu[MU_SR] &= ~MU_SR_GIPn_V1(i);
+            }
+        }
+        imx8mp_mu_update_irq(s);
+        return;
+    }
+
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "imx8mp_mu: bad write @0x%" HWADDR_PRIx
+              " = 0x%08" PRIx64 "\n", offset, value);
+        return;
+    }
+}
+
+static ResettablePhases imx8mp_mu_parent_phases;
+
+static void imx8mp_mu_reset_enter(Object *obj, ResetType type)
+{
+    IMX8MPMUState *s = IMX8MP_MU(obj);
+
+    if (imx8mp_mu_parent_phases.enter) {
+        imx8mp_mu_parent_phases.enter(obj, type);
+    }
+    memset(s->mu, 0, sizeof(s->mu));
+
+    s->mu[MU_SR] = 0x00F00080;
+}
+
+static void imx8mp_mu_reset_hold(Object *obj, ResetType type)
+{
+    IMX8MPMUState *s = IMX8MP_MU(obj);
+    if (imx8mp_mu_parent_phases.hold) {
+        imx8mp_mu_parent_phases.hold(obj, type);
+    }
+
+    imx8mp_mu_update_irq(s);
+}
+
+static const MemoryRegionOps imx8mp_mu_ops = {
+    .read = imx8mp_mu_read,
+    .write = imx8mp_mu_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .impl = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    .unaligned = false,
+    },
+};
+
+static const VMStateDescription imx8mp_mu_vmstate = {
+    .name = TYPE_IMX8MP_MU,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+    VMSTATE_UINT32_ARRAY(mu, IMX8MPMUState, MU_MAX),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
+static void imx8mp_mu_init(Object *obj)
+{
+    IMX8MPMUState *s = IMX8MP_MU(obj);
+    SysBusDevice *sd = SYS_BUS_DEVICE(obj);
+
+    /* Default to strict hardware-like access semantics. */
+    s->strict_access = true;
+
+    memory_region_init(&s->mmio.container, obj, TYPE_IMX8MP_MU,
+                       IMX8MP_MU_MMIO_SIZE);
+
+    /* Implemented subset as an IO subregion at offset 0 */
+    memory_region_init_io(&s->mmio.regs, obj, &imx8mp_mu_ops, s,
+                          TYPE_IMX8MP_MU ".regs", sizeof(s->mu));
+    memory_region_add_subregion(&s->mmio.container, 0, &s->mmio.regs);
+
+    sysbus_init_mmio(sd, &s->mmio.container);
+    sysbus_init_irq(sd, &s->irq);
+}
+
+static void imx8mp_mu_class_init(ObjectClass *oc, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+    ResettableClass *rc = RESETTABLE_CLASS(oc);
+
+    resettable_class_set_parent_phases(rc,
+                                       imx8mp_mu_reset_enter,
+                                       imx8mp_mu_reset_hold,
+                                       NULL,
+                                       &imx8mp_mu_parent_phases);
+    dc->vmsd = &imx8mp_mu_vmstate;
+    dc->desc  = "i.MX 8M Plus Messaging Unit";
+}
+
+static const TypeInfo imx8mp_mu_type_info[] = {
+    {
+        .name = TYPE_IMX8MP_MU,
+        .parent = TYPE_SYS_BUS_DEVICE,
+        .instance_size = sizeof(IMX8MPMUState),
+        .instance_init = imx8mp_mu_init,
+        .class_init = imx8mp_mu_class_init,
+    }
+};
+
+DEFINE_TYPES(imx8mp_mu_type_info);
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 79954586e8..e9c21f06bb 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -65,6 +65,7 @@ system_ss.add(when: 'CONFIG_FSL_IMX8MP_CCM', if_true: files('imx8mp_ccm.c'))
 system_ss.add(when: 'CONFIG_FSL_IMX8MP_GPC', if_true: files('imx8mp_gpc.c'))
 system_ss.add(when: 'CONFIG_FSL_IMX8MP_GPR', if_true: files('imx8mp_gpr.c'))
 system_ss.add(when: 'CONFIG_FSL_IMX8MP_SRC', if_true: files('imx8mp_src.c'))
+system_ss.add(when: 'CONFIG_FSL_IMX8MP_MU', if_true: files('imx8mp_mu.c'))
 system_ss.add(when: 'CONFIG_IMX', if_true: files(
   'imx25_ccm.c',
   'imx31_ccm.c',
diff --git a/include/hw/arm/fsl-imx8mp.h b/include/hw/arm/fsl-imx8mp.h
index 9b626e5d98..f3e134cdc0 100644
--- a/include/hw/arm/fsl-imx8mp.h
+++ b/include/hw/arm/fsl-imx8mp.h
@@ -20,6 +20,7 @@
 #include "hw/misc/imx8mp_gpc.h"
 #include "hw/misc/imx8mp_gpr.h"
 #include "hw/misc/imx8mp_src.h"
+#include "hw/misc/imx8mp_mu.h"
 #include "hw/net/flexcan.h"
 #include "hw/net/imx_fec.h"
 #include "hw/core/or-irq.h"
@@ -40,6 +41,9 @@ OBJECT_DECLARE_SIMPLE_TYPE(FslImx8mpState, FSL_IMX8MP)
 #define FSL_IMX8MP_RAM_START        0x40000000
 #define FSL_IMX8MP_RAM_SIZE_MAX     (8 * GiB)
 
+#define FSL_IMX8MP_MU1_A_IRQ  88
+#define FSL_IMX8MP_MU1_B_IRQ  97
+
 enum FslImx8mpConfiguration {
     FSL_IMX8MP_NUM_CANS         = 2,
     FSL_IMX8MP_NUM_A53          = 4,
@@ -48,12 +52,18 @@ enum FslImx8mpConfiguration {
     FSL_IMX8MP_NUM_GPTS         = 6,
     FSL_IMX8MP_NUM_I2CS         = 6,
     FSL_IMX8MP_NUM_IRQS         = 160,
+    FSL_IMX8MP_NUM_MU           = 3,
     FSL_IMX8MP_NUM_UARTS        = 4,
     FSL_IMX8MP_NUM_USBS         = 2,
     FSL_IMX8MP_NUM_USDHCS       = 3,
     FSL_IMX8MP_NUM_WDTS         = 3,
 };
 
+typedef struct IMX8MPMUPair {
+    IMX8MPMUState a;
+    IMX8MPMUState b;
+} IMX8MPMUPair;
+
 struct FslImx8mpState {
     SysBusDevice   parent_obj;
 
@@ -67,6 +77,7 @@ struct FslImx8mpState {
     IMX8MPAnalogState  analog;
     IMX7SNVSState      snvs;
     IMXSPIState        spi[FSL_IMX8MP_NUM_ECSPIS];
+    IMX8MPMUPair       mu[FSL_IMX8MP_NUM_MU];
     FslImx8mpSrcState  src;
     IMXI2CState        i2c[FSL_IMX8MP_NUM_I2CS];
     IMXSerialState     uart[FSL_IMX8MP_NUM_UARTS];
diff --git a/include/hw/misc/imx8mp_mu.h b/include/hw/misc/imx8mp_mu.h
new file mode 100644
index 0000000000..4801708402
--- /dev/null
+++ b/include/hw/misc/imx8mp_mu.h
@@ -0,0 +1,53 @@
+/*
+ * NXP i.MX 8M Plus  Messaging Unit (MU)
+ *
+ * Copyright (c) 2026, NXP Semiconductors
+ * Author: Gaurav Sharma <gaurav.sharma_7@nxp.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+
+#ifndef IMX8MP_MU_H
+#define IMX8MP_MU_H
+
+#include "hw/core/sysbus.h"
+#include "qom/object.h"
+
+#define IMX8MP_MU_MMIO_SIZE 0x10000
+
+enum IMX8MPMURegisters {
+    MU_TR0     = 0x000 / 4,
+    MU_TR1     = 0x004 / 4,
+    MU_TR2     = 0x008 / 4,
+    MU_TR3     = 0x00C / 4,
+    MU_RR0     = 0x010 / 4,
+    MU_RR1     = 0x014 / 4,
+    MU_RR2     = 0x018 / 4,
+    MU_RR3     = 0x01C / 4,
+    MU_SR      = 0x020 / 4,
+    MU_CR      = 0x024 / 4,
+    MU_MAX,
+};
+
+#define TYPE_IMX8MP_MU "imx8mp-mu"
+OBJECT_DECLARE_SIMPLE_TYPE(IMX8MPMUState, IMX8MP_MU)
+
+typedef struct IMX8MPMUState {
+    SysBusDevice parent_obj;
+
+    struct {
+        MemoryRegion container;
+        MemoryRegion regs;
+    } mmio;
+
+    qemu_irq irq;
+
+    struct IMX8MPMUState *peer;
+    uint32_t mu[MU_MAX];
+
+    bool strict_access;
+
+} IMX8MPMUState;
+
+#endif /* IMX8MP_MU_H */
-- 
2.34.1


