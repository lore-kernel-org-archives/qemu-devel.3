Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 307C9C47422
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 13:36:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTMKS-0004h7-3r; Fri, 26 Jan 2024 08:33:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=5gEp=JE=kaod.org=clg@ozlabs.org>)
 id 1rTMKM-0004Kq-1n; Fri, 26 Jan 2024 08:33:04 -0500
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=5gEp=JE=kaod.org=clg@ozlabs.org>)
 id 1rTMKI-00089p-BR; Fri, 26 Jan 2024 08:33:01 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4TLzCW6b24z4x3D;
 Sat, 27 Jan 2024 00:32:55 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4TLzCV17rFz4wny;
 Sat, 27 Jan 2024 00:32:53 +1100 (AEDT)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Ninad Palsule <ninad@linux.ibm.com>, Andrew Jeffery <andrew@aj.id.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PULL 13/17] hw/fsi: Aspeed APB2OPB & On-chip peripheral bus
Date: Fri, 26 Jan 2024 14:32:12 +0100
Message-ID: <20240126133217.996306-14-clg@kaod.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240126133217.996306-1-clg@kaod.org>
References: <20240126133217.996306-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=5gEp=JE=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Ninad Palsule <ninad@linux.ibm.com>

This is a part of patchset where IBM's Flexible Service Interface is
introduced.

An APB-to-OPB bridge enabling access to the OPB from the ARM core in
the AST2600. Hardware limitations prevent the OPB from being directly
mapped into APB, so all accesses are indirect through the bridge.

The On-Chip Peripheral Bus (OPB): A low-speed bus typically found in
POWER processors. This now makes an appearance in the ASPEED SoC due
to tight integration of the FSI master IP with the OPB, mainly the
existence of an MMIO-mapping of the CFAM address straight onto a
sub-region of the OPB address space.

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
[ clg: - moved FSIMasterState under AspeedAPB2OPBState
       - modified fsi_opb_fsi_master_address() and
         fsi_opb_opb2fsi_address()
       - instroduced fsi_aspeed_apb2opb_init()
       - reworked fsi_aspeed_apb2opb_realize()
       - removed FSIMasterState object and fsi_opb_realize()
       - simplified OPBus ]
Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 include/hw/fsi/aspeed_apb2opb.h |  46 +++++
 hw/fsi/aspeed_apb2opb.c         | 329 ++++++++++++++++++++++++++++++++
 hw/arm/Kconfig                  |   1 +
 hw/fsi/Kconfig                  |   5 +
 hw/fsi/meson.build              |   1 +
 hw/fsi/trace-events             |   2 +
 6 files changed, 384 insertions(+)
 create mode 100644 include/hw/fsi/aspeed_apb2opb.h
 create mode 100644 hw/fsi/aspeed_apb2opb.c

diff --git a/include/hw/fsi/aspeed_apb2opb.h b/include/hw/fsi/aspeed_apb2opb.h
new file mode 100644
index 000000000000..f6a2387abf28
--- /dev/null
+++ b/include/hw/fsi/aspeed_apb2opb.h
@@ -0,0 +1,46 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ * Copyright (C) 2024 IBM Corp.
+ *
+ * ASPEED APB2OPB Bridge
+ * IBM On-Chip Peripheral Bus
+ */
+#ifndef FSI_ASPEED_APB2OPB_H
+#define FSI_ASPEED_APB2OPB_H
+
+#include "exec/memory.h"
+#include "hw/fsi/fsi-master.h"
+#include "hw/sysbus.h"
+
+#define TYPE_FSI_OPB "fsi.opb"
+
+#define TYPE_OP_BUS "opb"
+OBJECT_DECLARE_SIMPLE_TYPE(OPBus, OP_BUS)
+
+typedef struct OPBus {
+    BusState bus;
+
+    MemoryRegion mr;
+    AddressSpace as;
+} OPBus;
+
+#define TYPE_ASPEED_APB2OPB "aspeed.apb2opb"
+OBJECT_DECLARE_SIMPLE_TYPE(AspeedAPB2OPBState, ASPEED_APB2OPB)
+
+#define ASPEED_APB2OPB_NR_REGS ((0xe8 >> 2) + 1)
+
+#define ASPEED_FSI_NUM 2
+
+typedef struct AspeedAPB2OPBState {
+    SysBusDevice parent_obj;
+
+    MemoryRegion iomem;
+
+    uint32_t regs[ASPEED_APB2OPB_NR_REGS];
+    qemu_irq irq;
+
+    OPBus opb[ASPEED_FSI_NUM];
+    FSIMasterState fsi[ASPEED_FSI_NUM];
+} AspeedAPB2OPBState;
+
+#endif /* FSI_ASPEED_APB2OPB_H */
diff --git a/hw/fsi/aspeed_apb2opb.c b/hw/fsi/aspeed_apb2opb.c
new file mode 100644
index 000000000000..1e0c2032e04c
--- /dev/null
+++ b/hw/fsi/aspeed_apb2opb.c
@@ -0,0 +1,329 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ * Copyright (C) 2024 IBM Corp.
+ *
+ * ASPEED APB-OPB FSI interface
+ * IBM On-chip Peripheral Bus
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "qom/object.h"
+#include "qapi/error.h"
+#include "trace.h"
+
+#include "hw/fsi/aspeed_apb2opb.h"
+#include "hw/qdev-core.h"
+
+#define TO_REG(x) (x >> 2)
+
+#define APB2OPB_VERSION                    TO_REG(0x00)
+#define APB2OPB_TRIGGER                    TO_REG(0x04)
+
+#define APB2OPB_CONTROL                    TO_REG(0x08)
+#define   APB2OPB_CONTROL_OFF              BE_GENMASK(31, 13)
+
+#define APB2OPB_OPB2FSI                    TO_REG(0x0c)
+#define   APB2OPB_OPB2FSI_OFF              BE_GENMASK(31, 22)
+
+#define APB2OPB_OPB0_SEL                   TO_REG(0x10)
+#define APB2OPB_OPB1_SEL                   TO_REG(0x28)
+#define   APB2OPB_OPB_SEL_EN               BIT(0)
+
+#define APB2OPB_OPB0_MODE                  TO_REG(0x14)
+#define APB2OPB_OPB1_MODE                  TO_REG(0x2c)
+#define   APB2OPB_OPB_MODE_RD              BIT(0)
+
+#define APB2OPB_OPB0_XFER                  TO_REG(0x18)
+#define APB2OPB_OPB1_XFER                  TO_REG(0x30)
+#define   APB2OPB_OPB_XFER_FULL            BIT(1)
+#define   APB2OPB_OPB_XFER_HALF            BIT(0)
+
+#define APB2OPB_OPB0_ADDR                  TO_REG(0x1c)
+#define APB2OPB_OPB0_WRITE_DATA            TO_REG(0x20)
+
+#define APB2OPB_OPB1_ADDR                  TO_REG(0x34)
+#define APB2OPB_OPB1_WRITE_DATA                  TO_REG(0x38)
+
+#define APB2OPB_IRQ_STS                    TO_REG(0x48)
+#define   APB2OPB_IRQ_STS_OPB1_TX_ACK      BIT(17)
+#define   APB2OPB_IRQ_STS_OPB0_TX_ACK      BIT(16)
+
+#define APB2OPB_OPB0_WRITE_WORD_ENDIAN     TO_REG(0x4c)
+#define   APB2OPB_OPB0_WRITE_WORD_ENDIAN_BE 0x0011101b
+#define APB2OPB_OPB0_WRITE_BYTE_ENDIAN     TO_REG(0x50)
+#define   APB2OPB_OPB0_WRITE_BYTE_ENDIAN_BE 0x0c330f3f
+#define APB2OPB_OPB1_WRITE_WORD_ENDIAN     TO_REG(0x54)
+#define APB2OPB_OPB1_WRITE_BYTE_ENDIAN     TO_REG(0x58)
+#define APB2OPB_OPB0_READ_BYTE_ENDIAN      TO_REG(0x5c)
+#define APB2OPB_OPB1_READ_BYTE_ENDIAN      TO_REG(0x60)
+#define   APB2OPB_OPB0_READ_WORD_ENDIAN_BE  0x00030b1b
+
+#define APB2OPB_OPB0_READ_DATA         TO_REG(0x84)
+#define APB2OPB_OPB1_READ_DATA         TO_REG(0x90)
+
+/*
+ * The following magic values came from AST2600 data sheet
+ * The register values are defined under section "FSI controller"
+ * as initial values.
+ */
+static const uint32_t aspeed_apb2opb_reset[ASPEED_APB2OPB_NR_REGS] = {
+     [APB2OPB_VERSION]                = 0x000000a1,
+     [APB2OPB_OPB0_WRITE_WORD_ENDIAN] = 0x0044eee4,
+     [APB2OPB_OPB0_WRITE_BYTE_ENDIAN] = 0x0055aaff,
+     [APB2OPB_OPB1_WRITE_WORD_ENDIAN] = 0x00117717,
+     [APB2OPB_OPB1_WRITE_BYTE_ENDIAN] = 0xffaa5500,
+     [APB2OPB_OPB0_READ_BYTE_ENDIAN]  = 0x0044eee4,
+     [APB2OPB_OPB1_READ_BYTE_ENDIAN]  = 0x00117717
+};
+
+static void fsi_opb_fsi_master_address(FSIMasterState *fsi, hwaddr addr)
+{
+    memory_region_transaction_begin();
+    memory_region_set_address(&fsi->iomem, addr);
+    memory_region_transaction_commit();
+}
+
+static void fsi_opb_opb2fsi_address(FSIMasterState *fsi, hwaddr addr)
+{
+    memory_region_transaction_begin();
+    memory_region_set_address(&fsi->opb2fsi, addr);
+    memory_region_transaction_commit();
+}
+
+static uint64_t fsi_aspeed_apb2opb_read(void *opaque, hwaddr addr,
+                                        unsigned size)
+{
+    AspeedAPB2OPBState *s = ASPEED_APB2OPB(opaque);
+    unsigned int reg = TO_REG(addr);
+
+    trace_fsi_aspeed_apb2opb_read(addr, size);
+
+    if (reg >= ASPEED_APB2OPB_NR_REGS) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Out of bounds read: 0x%"HWADDR_PRIx" for %u\n",
+                      __func__, addr, size);
+        return 0;
+    }
+
+    return s->regs[reg];
+}
+
+static void fsi_aspeed_apb2opb_write(void *opaque, hwaddr addr, uint64_t data,
+                                     unsigned size)
+{
+    AspeedAPB2OPBState *s = ASPEED_APB2OPB(opaque);
+    unsigned int reg = TO_REG(addr);
+
+    trace_fsi_aspeed_apb2opb_write(addr, size, data);
+
+    if (reg >= ASPEED_APB2OPB_NR_REGS) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Out of bounds write: %"HWADDR_PRIx" for %u\n",
+                      __func__, addr, size);
+        return;
+    }
+
+    switch (reg) {
+    case APB2OPB_CONTROL:
+        fsi_opb_fsi_master_address(&s->fsi[0],
+                data & APB2OPB_CONTROL_OFF);
+        break;
+    case APB2OPB_OPB2FSI:
+        fsi_opb_opb2fsi_address(&s->fsi[0],
+                data & APB2OPB_OPB2FSI_OFF);
+        break;
+    case APB2OPB_OPB0_WRITE_WORD_ENDIAN:
+        if (data != APB2OPB_OPB0_WRITE_WORD_ENDIAN_BE) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "%s: Bridge needs to be driven as BE (0x%x)\n",
+                          __func__, APB2OPB_OPB0_WRITE_WORD_ENDIAN_BE);
+        }
+        break;
+    case APB2OPB_OPB0_WRITE_BYTE_ENDIAN:
+        if (data != APB2OPB_OPB0_WRITE_BYTE_ENDIAN_BE) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "%s: Bridge needs to be driven as BE (0x%x)\n",
+                          __func__, APB2OPB_OPB0_WRITE_BYTE_ENDIAN_BE);
+        }
+        break;
+    case APB2OPB_OPB0_READ_BYTE_ENDIAN:
+        if (data != APB2OPB_OPB0_READ_WORD_ENDIAN_BE) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "%s: Bridge needs to be driven as BE (0x%x)\n",
+                          __func__, APB2OPB_OPB0_READ_WORD_ENDIAN_BE);
+        }
+        break;
+    case APB2OPB_TRIGGER:
+    {
+        uint32_t opb, op_mode, op_size, op_addr, op_data;
+        MemTxResult result;
+        bool is_write;
+        int index;
+        AddressSpace *as;
+
+        assert((s->regs[APB2OPB_OPB0_SEL] & APB2OPB_OPB_SEL_EN) ^
+               (s->regs[APB2OPB_OPB1_SEL] & APB2OPB_OPB_SEL_EN));
+
+        if (s->regs[APB2OPB_OPB0_SEL] & APB2OPB_OPB_SEL_EN) {
+            opb = 0;
+            op_mode = s->regs[APB2OPB_OPB0_MODE];
+            op_size = s->regs[APB2OPB_OPB0_XFER];
+            op_addr = s->regs[APB2OPB_OPB0_ADDR];
+            op_data = s->regs[APB2OPB_OPB0_WRITE_DATA];
+        } else if (s->regs[APB2OPB_OPB1_SEL] & APB2OPB_OPB_SEL_EN) {
+            opb = 1;
+            op_mode = s->regs[APB2OPB_OPB1_MODE];
+            op_size = s->regs[APB2OPB_OPB1_XFER];
+            op_addr = s->regs[APB2OPB_OPB1_ADDR];
+            op_data = s->regs[APB2OPB_OPB1_WRITE_DATA];
+        } else {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "%s: Invalid operation: 0x%"HWADDR_PRIx" for %u\n",
+                          __func__, addr, size);
+            return;
+        }
+
+        if (op_size & ~(APB2OPB_OPB_XFER_HALF | APB2OPB_OPB_XFER_FULL)) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "OPB transaction failed: Unrecognized access width: %d\n",
+                          op_size);
+            return;
+        }
+
+        op_size += 1;
+        is_write = !(op_mode & APB2OPB_OPB_MODE_RD);
+        index = opb ? APB2OPB_OPB1_READ_DATA : APB2OPB_OPB0_READ_DATA;
+        as = &s->opb[opb].as;
+
+        result = address_space_rw(as, op_addr, MEMTXATTRS_UNSPECIFIED,
+                                  &op_data, op_size, is_write);
+        if (result != MEMTX_OK) {
+            qemu_log_mask(LOG_GUEST_ERROR, "%s: OPB %s failed @%08x\n",
+                          __func__, is_write ? "write" : "read", op_addr);
+            return;
+        }
+
+        if (!is_write) {
+            s->regs[index] = op_data;
+        }
+
+        s->regs[APB2OPB_IRQ_STS] |= opb ? APB2OPB_IRQ_STS_OPB1_TX_ACK
+            : APB2OPB_IRQ_STS_OPB0_TX_ACK;
+        break;
+    }
+    }
+
+    s->regs[reg] = data;
+}
+
+static const struct MemoryRegionOps aspeed_apb2opb_ops = {
+    .read = fsi_aspeed_apb2opb_read,
+    .write = fsi_aspeed_apb2opb_write,
+    .valid.max_access_size = 4,
+    .valid.min_access_size = 4,
+    .impl.max_access_size = 4,
+    .impl.min_access_size = 4,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+};
+
+static void fsi_aspeed_apb2opb_init(Object *o)
+{
+    AspeedAPB2OPBState *s = ASPEED_APB2OPB(o);
+    int i;
+
+    for (i = 0; i < ASPEED_FSI_NUM; i++) {
+        object_initialize_child(o, "fsi-master[*]", &s->fsi[i],
+                                TYPE_FSI_MASTER);
+    }
+}
+
+static void fsi_aspeed_apb2opb_realize(DeviceState *dev, Error **errp)
+{
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
+    AspeedAPB2OPBState *s = ASPEED_APB2OPB(dev);
+    int i;
+
+    /*
+     * TODO: The OPBus model initializes the OPB address space in
+     * the .instance_init handler and this is problematic for test
+     * device-introspect-test. To avoid a memory corruption and a QEMU
+     * crash, qbus_init() should be called from realize(). Something to
+     * improve. Possibly, OPBus could also be removed.
+     */
+    for (i = 0; i < ASPEED_FSI_NUM; i++) {
+        qbus_init(&s->opb[i], sizeof(s->opb[i]), TYPE_OP_BUS, DEVICE(s),
+                  NULL);
+    }
+
+    sysbus_init_irq(sbd, &s->irq);
+
+    memory_region_init_io(&s->iomem, OBJECT(s), &aspeed_apb2opb_ops, s,
+                          TYPE_ASPEED_APB2OPB, 0x1000);
+    sysbus_init_mmio(sbd, &s->iomem);
+
+    for (i = 0; i < ASPEED_FSI_NUM; i++) {
+        if (!qdev_realize(DEVICE(&s->fsi[i]), BUS(&s->opb[i]), errp)) {
+            return;
+        }
+
+        memory_region_add_subregion(&s->opb[i].mr, 0x80000000,
+                &s->fsi[i].iomem);
+
+        memory_region_add_subregion(&s->opb[i].mr, 0xa0000000,
+                &s->fsi[i].opb2fsi);
+    }
+}
+
+static void fsi_aspeed_apb2opb_reset(DeviceState *dev)
+{
+    AspeedAPB2OPBState *s = ASPEED_APB2OPB(dev);
+
+    memcpy(s->regs, aspeed_apb2opb_reset, ASPEED_APB2OPB_NR_REGS);
+}
+
+static void fsi_aspeed_apb2opb_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->desc = "ASPEED APB2OPB Bridge";
+    dc->realize = fsi_aspeed_apb2opb_realize;
+    dc->reset = fsi_aspeed_apb2opb_reset;
+}
+
+static const TypeInfo aspeed_apb2opb_info = {
+    .name = TYPE_ASPEED_APB2OPB,
+    .parent = TYPE_SYS_BUS_DEVICE,
+    .instance_init = fsi_aspeed_apb2opb_init,
+    .instance_size = sizeof(AspeedAPB2OPBState),
+    .class_init = fsi_aspeed_apb2opb_class_init,
+};
+
+static void aspeed_apb2opb_register_types(void)
+{
+    type_register_static(&aspeed_apb2opb_info);
+}
+
+type_init(aspeed_apb2opb_register_types);
+
+static void fsi_opb_init(Object *o)
+{
+    OPBus *opb = OP_BUS(o);
+
+    memory_region_init(&opb->mr, 0, TYPE_FSI_OPB, UINT32_MAX);
+    address_space_init(&opb->as, &opb->mr, TYPE_FSI_OPB);
+}
+
+static const TypeInfo opb_info = {
+    .name = TYPE_OP_BUS,
+    .parent = TYPE_BUS,
+    .instance_init = fsi_opb_init,
+    .instance_size = sizeof(OPBus),
+};
+
+static void fsi_opb_register_types(void)
+{
+    type_register_static(&opb_info);
+}
+
+type_init(fsi_opb_register_types);
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 218b454e97f6..744f05087fd0 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -574,6 +574,7 @@ config ASPEED_SOC
     select LED
     select PMBUS
     select MAX31785
+    select FSI_APB2OPB_ASPEED
 
 config MPS2
     bool
diff --git a/hw/fsi/Kconfig b/hw/fsi/Kconfig
index 9c34a418d700..9cee657a0f09 100644
--- a/hw/fsi/Kconfig
+++ b/hw/fsi/Kconfig
@@ -1,2 +1,7 @@
+config FSI_APB2OPB_ASPEED
+    bool
+    depends on ASPEED_SOC
+    select FSI
+
 config FSI
     bool
diff --git a/hw/fsi/meson.build b/hw/fsi/meson.build
index 7803b3afd191..a18a076552fc 100644
--- a/hw/fsi/meson.build
+++ b/hw/fsi/meson.build
@@ -1 +1,2 @@
 system_ss.add(when: 'CONFIG_FSI', if_true: files('lbus.c','fsi.c','cfam.c','fsi-master.c'))
+system_ss.add(when: 'CONFIG_FSI_APB2OPB_ASPEED', if_true: files('aspeed_apb2opb.c'))
diff --git a/hw/fsi/trace-events b/hw/fsi/trace-events
index bf417b6dc3c8..9e286d08d3c7 100644
--- a/hw/fsi/trace-events
+++ b/hw/fsi/trace-events
@@ -9,3 +9,5 @@ fsi_cfam_unimplemented_write(uint64_t addr, uint32_t size, uint64_t data) "@0x%"
 fsi_cfam_config_write_noaddr(uint64_t addr, uint32_t size, uint64_t data) "@0x%" PRIx64 " size=%d value=0x%"PRIx64
 fsi_master_read(uint64_t addr, uint32_t size) "@0x%" PRIx64 " size=%d"
 fsi_master_write(uint64_t addr, uint32_t size, uint64_t data) "@0x%" PRIx64 " size=%d value=0x%"PRIx64
+fsi_aspeed_apb2opb_read(uint64_t addr, uint32_t size) "@0x%" PRIx64 " size=%d"
+fsi_aspeed_apb2opb_write(uint64_t addr, uint32_t size, uint64_t data) "@0x%" PRIx64 " size=%d value=0x%"PRIx64
-- 
2.43.0


