Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7F6EC02194
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 21:06:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgVXs-0005PN-MI; Fri, 07 Feb 2025 16:05:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1tgVXr-0005P4-5p
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 16:05:51 -0500
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1tgVXo-0001rt-Li
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 16:05:50 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id EF3995C71B2;
 Fri,  7 Feb 2025 21:05:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58E6AC4CEE4;
 Fri,  7 Feb 2025 21:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1738962345;
 bh=XqqcKTiqr37pWU6TZ9vOOlIFt2Td5Ilt6/cULAw4RFo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=mOx1VzdbWGWQgiKFVrZvoX9BW29mYsFqSd+3DPej7RWn91XN2YA+cyXX4q8iba1ve
 4gUyndrhtsqbASVNQfEwnKe5U13tbSIW1xXvEB9CFz76civ5Ph38s75gJsaXHfmynK
 Cr+Hh65zaasxVKbWigPTGg9VGBipg4/HGLp28hPGcjRxTUFYvrtfyE/aqy1dbtmvuq
 yo9nUya5joGd8g22DkLDLJtDwIzGfa3EV8ljnvpgBzjEyAYlRgcuYuSOy2yGs7o8Mh
 cx0D9gBQvgbQ0KaDA2ThxpFWlETio2WWmmFLePwX/UZfH2ZPIH6qnhPIoP0wkSFkwg
 pHcWF0KTq2zkw==
From: deller@kernel.org
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>
Subject: [PULL 1/6] hw/char: Add emulation of Diva GSP PCI management boards
Date: Fri,  7 Feb 2025 22:05:35 +0100
Message-ID: <20250207210540.24594-2-deller@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250207210540.24594-1-deller@kernel.org>
References: <20250207210540.24594-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2604:1380:4641:c500::1;
 envelope-from=deller@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

From: Helge Deller <deller@gmx.de>

The Diva GSP ("Guardian Service Processor") PCI boards are Remote
Management cards for PA-RISC machines.  They come with built-in 16550A
UARTs for serial consoles and modem functionalities, as well as a
mailbox-like memory area for hardware auto-reboot functionality.

Latest generation HP PA-RISC server machines use those Diva cards
for console output.

Signed-off-by: Helge Deller <deller@gmx.de>
---
 MAINTAINERS         |   1 +
 hw/char/Kconfig     |   3 +
 hw/char/diva-gsp.c  | 297 ++++++++++++++++++++++++++++++++++++++++++++
 hw/char/meson.build |   1 +
 4 files changed, 302 insertions(+)
 create mode 100644 hw/char/diva-gsp.c

diff --git a/MAINTAINERS b/MAINTAINERS
index bf737eb6db..e09a8d2791 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1193,6 +1193,7 @@ M: Richard Henderson <richard.henderson@linaro.org>
 M: Helge Deller <deller@gmx.de>
 S: Maintained
 F: configs/devices/hppa-softmmu/default.mak
+F: hw/char/diva-gsp.c
 F: hw/display/artist.c
 F: hw/hppa/
 F: hw/input/lasips2.c
diff --git a/hw/char/Kconfig b/hw/char/Kconfig
index 1dc20ee4c2..3f702565e6 100644
--- a/hw/char/Kconfig
+++ b/hw/char/Kconfig
@@ -66,6 +66,9 @@ config RENESAS_SCI
 config AVR_USART
     bool
 
+config DIVA_GSP
+    bool
+
 config MCHP_PFSOC_MMUART
     bool
     select SERIAL
diff --git a/hw/char/diva-gsp.c b/hw/char/diva-gsp.c
new file mode 100644
index 0000000000..ecec1f7bb1
--- /dev/null
+++ b/hw/char/diva-gsp.c
@@ -0,0 +1,297 @@
+/*
+ * HP Diva GSP controller
+ *
+ * The Diva PCI boards are Remote Management cards for PA-RISC machines.
+ * They come with built-in 16550A multi UARTs for serial consoles
+ * and a mailbox-like memory area for hardware auto-reboot functionality.
+ * GSP stands for "Guardian Service Processor". Later products were marketed
+ * "Management Processor" (MP).
+ *
+ * Diva cards are multifunctional cards. The first part, the aux port,
+ * is on physical machines not useable but we still try to mimic it here.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Copyright (c) 2025 Helge Deller <deller@gmx.de>
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/units.h"
+#include "hw/char/serial.h"
+#include "hw/irq.h"
+#include "hw/pci/pci_device.h"
+#include "hw/qdev-properties.h"
+#include "hw/qdev-properties-system.h"
+#include "migration/vmstate.h"
+
+#define PCI_DEVICE_ID_HP_DIVA           0x1048
+/* various DIVA GSP cards: */
+#define PCI_DEVICE_ID_HP_DIVA_TOSCA1    0x1049
+#define PCI_DEVICE_ID_HP_DIVA_TOSCA2    0x104A
+#define PCI_DEVICE_ID_HP_DIVA_MAESTRO   0x104B
+#define PCI_DEVICE_ID_HP_REO_IOC        0x10f1
+#define PCI_DEVICE_ID_HP_DIVA_HALFDOME  0x1223
+#define PCI_DEVICE_ID_HP_DIVA_KEYSTONE  0x1226
+#define PCI_DEVICE_ID_HP_DIVA_POWERBAR  0x1227
+#define PCI_DEVICE_ID_HP_DIVA_EVEREST   0x1282
+#define PCI_DEVICE_ID_HP_DIVA_AUX       0x1290
+#define PCI_DEVICE_ID_HP_DIVA_RMP3      0x1301
+#define PCI_DEVICE_ID_HP_DIVA_HURRICANE 0x132a
+
+
+#define PCI_SERIAL_MAX_PORTS 4
+
+typedef struct PCIDivaSerialState {
+    PCIDevice    dev;
+    MemoryRegion membar;        /* for serial ports */
+    MemoryRegion mailboxbar;    /* for hardware mailbox */
+    uint32_t     subvendor;
+    uint32_t     ports;
+    char         *name[PCI_SERIAL_MAX_PORTS];
+    SerialState  state[PCI_SERIAL_MAX_PORTS];
+    uint32_t     level[PCI_SERIAL_MAX_PORTS];
+    qemu_irq     *irqs;
+    uint8_t      prog_if;
+    bool         disable;
+} PCIDivaSerialState;
+
+static void diva_pci_exit(PCIDevice *dev)
+{
+    PCIDivaSerialState *pci = DO_UPCAST(PCIDivaSerialState, dev, dev);
+    SerialState *s;
+    int i;
+
+    for (i = 0; i < pci->ports; i++) {
+        s = pci->state + i;
+        qdev_unrealize(DEVICE(s));
+        memory_region_del_subregion(&pci->membar, &s->io);
+        g_free(pci->name[i]);
+    }
+    qemu_free_irqs(pci->irqs, pci->ports);
+}
+
+static void multi_serial_irq_mux(void *opaque, int n, int level)
+{
+    PCIDivaSerialState *pci = opaque;
+    int i, pending = 0;
+
+    pci->level[n] = level;
+    for (i = 0; i < pci->ports; i++) {
+        if (pci->level[i]) {
+            pending = 1;
+        }
+    }
+    pci_set_irq(&pci->dev, pending);
+}
+
+struct diva_info {
+    unsigned int nports:4; /* number of serial ports */
+    unsigned int omask:12; /* offset mask: BIT(1) -> offset 8 */
+};
+
+static struct diva_info diva_get_diva_info(PCIDeviceClass *pc)
+{
+    switch (pc->subsystem_id) {
+    case PCI_DEVICE_ID_HP_DIVA_POWERBAR:
+    case PCI_DEVICE_ID_HP_DIVA_HURRICANE:
+        return (struct diva_info) { .nports = 1,
+                        .omask = BIT(0) };
+    case PCI_DEVICE_ID_HP_DIVA_TOSCA2:
+        return (struct diva_info) { .nports = 2,
+                        .omask = BIT(0) | BIT(1) };
+    case PCI_DEVICE_ID_HP_DIVA_TOSCA1:
+    case PCI_DEVICE_ID_HP_DIVA_HALFDOME:
+    case PCI_DEVICE_ID_HP_DIVA_KEYSTONE:
+        return (struct diva_info) { .nports = 3,
+                        .omask = BIT(0) | BIT(1) | BIT(2) };
+    case PCI_DEVICE_ID_HP_DIVA_EVEREST: /* e.g. in rp3410 */
+        return (struct diva_info) { .nports = 3,
+                        .omask = BIT(0) | BIT(2) | BIT(7) };
+    case PCI_DEVICE_ID_HP_DIVA_MAESTRO:
+        return (struct diva_info) { .nports = 4,
+                        .omask = BIT(0) | BIT(1) | BIT(2) | BIT(7) };
+    }
+    g_assert_not_reached();
+}
+
+
+static void diva_pci_realize(PCIDevice *dev, Error **errp)
+{
+    PCIDeviceClass *pc = PCI_DEVICE_GET_CLASS(dev);
+    PCIDivaSerialState *pci = DO_UPCAST(PCIDivaSerialState, dev, dev);
+    SerialState *s;
+    struct diva_info di = diva_get_diva_info(pc);
+    size_t i, offset = 0;
+    size_t portmask = di.omask;
+
+    pci->dev.config[PCI_CLASS_PROG] = pci->prog_if;
+    pci->dev.config[PCI_INTERRUPT_PIN] = 0x01;
+    memory_region_init(&pci->membar, OBJECT(pci), "serial_ports", 4096);
+    pci_register_bar(&pci->dev, 0, PCI_BASE_ADDRESS_SPACE_MEMORY, &pci->membar);
+    pci->irqs = qemu_allocate_irqs(multi_serial_irq_mux, pci, di.nports);
+
+    for (i = 0; i < di.nports; i++) {
+        s = pci->state + i;
+        if (!qdev_realize(DEVICE(s), NULL, errp)) {
+            diva_pci_exit(dev);
+            return;
+        }
+        s->irq = pci->irqs[i];
+        pci->name[i] = g_strdup_printf("uart #%zu", i + 1);
+        memory_region_init_io(&s->io, OBJECT(pci), &serial_io_ops, s,
+                              pci->name[i], 8);
+
+        /* calculate offset of given port based on bitmask */
+        while ((portmask & BIT(0)) == 0) {
+            offset += 8;
+            portmask >>= 1;
+        }
+        memory_region_add_subregion(&pci->membar, offset, &s->io);
+        offset += 8;
+        portmask >>= 1;
+        pci->ports++;
+    }
+
+    /* mailbox bar */
+    memory_region_init(&pci->mailboxbar, OBJECT(pci), "mailbox", 128 * KiB);
+    pci_register_bar(&pci->dev, 1, PCI_BASE_ADDRESS_SPACE_MEMORY |
+                     PCI_BASE_ADDRESS_MEM_PREFETCH, &pci->mailboxbar);
+}
+
+static const VMStateDescription vmstate_pci_diva = {
+    .name = "pci-diva-serial",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_PCI_DEVICE(dev, PCIDivaSerialState),
+        VMSTATE_STRUCT_ARRAY(state, PCIDivaSerialState, PCI_SERIAL_MAX_PORTS,
+                             0, vmstate_serial, SerialState),
+        VMSTATE_UINT32_ARRAY(level, PCIDivaSerialState, PCI_SERIAL_MAX_PORTS),
+        VMSTATE_BOOL(disable, PCIDivaSerialState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static const Property diva_serial_properties[] = {
+    DEFINE_PROP_BOOL("disable",  PCIDivaSerialState, disable, false),
+    DEFINE_PROP_CHR("chardev1",  PCIDivaSerialState, state[0].chr),
+    DEFINE_PROP_CHR("chardev2",  PCIDivaSerialState, state[1].chr),
+    DEFINE_PROP_CHR("chardev3",  PCIDivaSerialState, state[2].chr),
+    DEFINE_PROP_CHR("chardev4",  PCIDivaSerialState, state[3].chr),
+    DEFINE_PROP_UINT8("prog_if",  PCIDivaSerialState, prog_if, 0x02),
+    DEFINE_PROP_UINT32("subvendor", PCIDivaSerialState, subvendor,
+                                    PCI_DEVICE_ID_HP_DIVA_TOSCA1),
+};
+
+static void diva_serial_class_initfn(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    PCIDeviceClass *pc = PCI_DEVICE_CLASS(klass);
+    pc->realize = diva_pci_realize;
+    pc->exit = diva_pci_exit;
+    pc->vendor_id = PCI_VENDOR_ID_HP;
+    pc->device_id = PCI_DEVICE_ID_HP_DIVA;
+    pc->subsystem_vendor_id = PCI_VENDOR_ID_HP;
+    pc->subsystem_id = PCI_DEVICE_ID_HP_DIVA_TOSCA1;
+    pc->revision = 3;
+    pc->class_id = PCI_CLASS_COMMUNICATION_SERIAL;
+    dc->vmsd = &vmstate_pci_diva;
+    device_class_set_props(dc, diva_serial_properties);
+    set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
+}
+
+static void diva_serial_init(Object *o)
+{
+    PCIDevice *dev = PCI_DEVICE(o);
+    PCIDivaSerialState *pms = DO_UPCAST(PCIDivaSerialState, dev, dev);
+    struct diva_info di = diva_get_diva_info(PCI_DEVICE_GET_CLASS(dev));
+    size_t i;
+
+    for (i = 0; i < di.nports; i++) {
+        object_initialize_child(o, "serial[*]", &pms->state[i], TYPE_SERIAL);
+    }
+}
+
+
+/* Diva-aux is the driver for portion 0 of the multifunction PCI device */
+
+struct DivaAuxState {
+    PCIDevice dev;
+    MemoryRegion mem;
+    qemu_irq irq;
+};
+
+#define TYPE_DIVA_AUX "diva-aux"
+OBJECT_DECLARE_SIMPLE_TYPE(DivaAuxState, DIVA_AUX)
+
+static void diva_aux_realize(PCIDevice *dev, Error **errp)
+{
+    DivaAuxState *pci = DO_UPCAST(DivaAuxState, dev, dev);
+
+    pci->dev.config[PCI_CLASS_PROG] = 0x02;
+    pci->dev.config[PCI_INTERRUPT_PIN] = 0x01;
+    pci->irq = pci_allocate_irq(&pci->dev);
+
+    memory_region_init(&pci->mem, OBJECT(pci), "mem", 16);
+    pci_register_bar(&pci->dev, 0, PCI_BASE_ADDRESS_SPACE_MEMORY, &pci->mem);
+}
+
+static void diva_aux_exit(PCIDevice *dev)
+{
+    DivaAuxState *pci = DO_UPCAST(DivaAuxState, dev, dev);
+    qemu_free_irq(pci->irq);
+}
+
+static void diva_aux_class_initfn(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    PCIDeviceClass *pc = PCI_DEVICE_CLASS(klass);
+    pc->realize = diva_aux_realize;
+    pc->exit = diva_aux_exit;
+    pc->vendor_id = PCI_VENDOR_ID_HP;
+    pc->device_id = PCI_DEVICE_ID_HP_DIVA_AUX;
+    pc->subsystem_vendor_id = PCI_VENDOR_ID_HP;
+    pc->subsystem_id = 0x1291;
+    pc->revision = 1;
+    pc->class_id = PCI_CLASS_COMMUNICATION_MULTISERIAL;
+    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
+    dc->user_creatable = false;
+}
+
+static void diva_aux_init(Object *o)
+{
+}
+
+static const TypeInfo diva_aux_info = {
+    .name          = TYPE_DIVA_AUX,
+    .parent        = TYPE_PCI_DEVICE,
+    .instance_size = sizeof(DivaAuxState),
+    .instance_init = diva_aux_init,
+    .class_init    = diva_aux_class_initfn,
+    .interfaces = (InterfaceInfo[]) {
+        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
+        { },
+    },
+};
+
+
+
+static const TypeInfo diva_serial_pci_info = {
+    .name          = "diva-gsp",
+    .parent        = TYPE_PCI_DEVICE,
+    .instance_size = sizeof(PCIDivaSerialState),
+    .instance_init = diva_serial_init,
+    .class_init    = diva_serial_class_initfn,
+    .interfaces = (InterfaceInfo[]) {
+        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
+        { },
+    },
+};
+
+static void diva_pci_register_type(void)
+{
+    type_register_static(&diva_serial_pci_info);
+    type_register_static(&diva_aux_info);
+}
+
+type_init(diva_pci_register_type)
diff --git a/hw/char/meson.build b/hw/char/meson.build
index ed3529cbbb..86ee808cae 100644
--- a/hw/char/meson.build
+++ b/hw/char/meson.build
@@ -20,6 +20,7 @@ system_ss.add(when: 'CONFIG_SHAKTI_UART', if_true: files('shakti_uart.c'))
 system_ss.add(when: 'CONFIG_VIRTIO_SERIAL', if_true: files('virtio-console.c'))
 system_ss.add(when: 'CONFIG_XEN_BUS', if_true: files('xen_console.c'))
 system_ss.add(when: 'CONFIG_XILINX', if_true: files('xilinx_uartlite.c'))
+system_ss.add(when: 'CONFIG_DIVA_GSP', if_true: files('diva-gsp.c'))
 
 system_ss.add(when: 'CONFIG_AVR_USART', if_true: files('avr_usart.c'))
 system_ss.add(when: 'CONFIG_COLDFIRE', if_true: files('mcf_uart.c'))
-- 
2.47.0


