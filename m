Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E0CAE7717D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2024 23:37:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKnJa-000756-U4; Mon, 09 Dec 2024 18:37:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pisa@fel.cvut.cz>) id 1tKnJW-00074C-5C
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 18:37:19 -0500
Received: from smtpx.feld.cvut.cz ([147.32.210.153] helo=smtpx.fel.cvut.cz)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_CHACHA20_POLY1305:256)
 (Exim 4.90_1) (envelope-from <pisa@fel.cvut.cz>) id 1tKnJT-0007E0-Uy
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 18:37:17 -0500
Received: from localhost (unknown [192.168.200.27])
 by smtpx.fel.cvut.cz (Postfix) with ESMTP id D36DC40F31;
 Tue, 10 Dec 2024 00:37:14 +0100 (CET)
X-Virus-Scanned: IMAP STYX AMAVIS
Received: from smtpx.fel.cvut.cz ([192.168.200.2])
 by localhost (cerokez-250.feld.cvut.cz [192.168.200.27]) (amavis, port 10060)
 with ESMTP id G9qVESoiyBo7; Tue, 10 Dec 2024 00:37:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fel.cvut.cz;
 s=felmail; t=1733787195;
 bh=kzpjSFnN2RI3BECn4f5AS7pHbn6XfXoctEfzUuqTZA0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=d4exUnrz7aWnSQjRtsfEReZG29J/sZQFJ+fQ41Eu8aPpdzRYSEHpx7CSnFGMHJ9lp
 7Uy3+S2QAui6y+xReUhEkBzQdOg0j6NsUeC++eBeDY/9UEx+Ht2rC3gsIJu00nFBR3
 6o4qSnA22mJZ8EBK8MHjz4xYmQvzVGOnFWZg0zAO4N4H85koD1vlf8rp5jh+mt8khK
 eMhVgKPWLio7xWSbDfOOA4R/eJb3seb7t9Pq++pQXYmxTskRGDqU2dPG362RE8jII5
 PJC7VppJTAifiAUniG3f/6y4tYS53E5kcSNIUTpQyHrBDxaHKn1DPit683Ad4QCget
 XGvF6p0f2AaNQ==
Received: from fel.cvut.cz (static-84-242-78-234.bb.vodafone.cz
 [84.242.78.234])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: pisa)
 by smtpx.fel.cvut.cz (Postfix) with ESMTPSA id ED51C40CB9;
 Tue, 10 Dec 2024 00:33:14 +0100 (CET)
From: Pavel Pisa <pisa@fel.cvut.cz>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pavel Pisa <pisa@cmp.felk.cvut.cz>
Subject: [RFC 1/3] hw/net/can: WIP CTU CAN FD IP core mapping to the platform
 bus
Date: Tue, 10 Dec 2024 00:32:51 +0100
Message-Id: <4baca743c8d3f6fa4ff10455560f940a84490aba.1733783500.git.pisa@cmp.felk.cvut.cz>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1733783500.git.pisa@cmp.felk.cvut.cz>
References: <cover.1733783500.git.pisa@cmp.felk.cvut.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=147.32.210.153; envelope-from=pisa@fel.cvut.cz;
 helo=smtpx.fel.cvut.cz
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_MED=-2.3,
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

From: Pavel Pisa <pisa@cmp.felk.cvut.cz>

It is initial attempt (IRQ not working yet) to provide
alternative to PCIe mapping. In this case, the platform
bus is used to match FPGA design for Xilinx Zynq MZ_APO
education kit with four CTU CAN FD cores on branch
mz_apo-2x-xcan-4x-ctu of repo

  https://gitlab.fel.cvut.cz/canbus/zynq/zynq-can-sja1000-top

The system is started by command

  qemu-system-arm -m 1G -M xilinx-zynq-a9 \
      -kernel kernel-zynq \
      -dtb zynq-microzed-uart1-2x-xcan-4x-ctu-axi.dtb \
      -initrd ramdisk.cpio \
      -serial null -serial mon:stdio \
      -nographic \
      -object can-bus,id=canbus0-bus \
      -object can-host-socketcan,if=can0,canbus=canbus0-bus,id=canbus0-socketcan \
      -device ctucan_mm,iobase=0x43c30000,irq=29,canbus=canbus0-bus \
      -device ctucan_mm,iobase=0x43c70000,irq=30,canbus=canbus0-bus \
      -device ctucan_mm,iobase=0x43bf0000,irq=31,canbus=canbus0-bus \
      -device ctucan_mm,iobase=0x43bb0000,irq=32,canbus=canbus0-bus \

Signed-off-by: Pavel Pisa <pisa@cmp.felk.cvut.cz>
---
 hw/arm/xilinx_zynq.c   |   1 +
 hw/net/can/ctucan_mm.c | 279 +++++++++++++++++++++++++++++++++++++++++
 hw/net/can/meson.build |   1 +
 3 files changed, 281 insertions(+)
 create mode 100644 hw/net/can/ctucan_mm.c

diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
index fde4d946b7..cd6444a6fe 100644
--- a/hw/arm/xilinx_zynq.c
+++ b/hw/arm/xilinx_zynq.c
@@ -473,6 +473,7 @@ static void zynq_machine_class_init(ObjectClass *oc, void *data)
                                           "Supported boot modes:"
                                           " jtag qspi sd nor");
     object_property_set_default_str(prop, "qspi");
+    machine_class_allow_dynamic_sysbus_dev(mc, "ctucan_mm");
 }
 
 static const TypeInfo zynq_machine_type = {
diff --git a/hw/net/can/ctucan_mm.c b/hw/net/can/ctucan_mm.c
new file mode 100644
index 0000000000..43e6823b73
--- /dev/null
+++ b/hw/net/can/ctucan_mm.c
@@ -0,0 +1,279 @@
+/*
+ * CTU CAN FD memory mapped device emulation
+ * http://canbus.pages.fel.cvut.cz/
+ *
+ * Copyright (c) 2024 Pavel Pisa (pisa@cmp.felk.cvut.cz)
+ *
+ * Based on Kvaser PCI CAN device (SJA1000 based) emulation implemented by
+ * Jin Yang and Pavel Pisa
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/event_notifier.h"
+#include "qemu/module.h"
+#include "qemu/thread.h"
+#include "qemu/sockets.h"
+#include "qapi/error.h"
+#include "chardev/char.h"
+#include "hw/irq.h"
+#include "hw/sysbus.h"
+#include "hw/qdev-properties.h"
+#include "migration/vmstate.h"
+#include "net/can_emu.h"
+
+#include "ctucan_core.h"
+
+#define TYPE_CTUCAN_MM_DEV "ctucan_mm"
+
+typedef struct CtuCanMmState CtuCanMmState;
+DECLARE_INSTANCE_CHECKER(CtuCanMmState, CTUCAN_MM_DEV,
+                         TYPE_CTUCAN_MM_DEV)
+
+#define CTUCAN_MM_CORE_COUNT     1
+#define CTUCAN_MM_CORE_RANGE     0x1000
+
+#define CTUCAN_MM_BYTES_PER_CORE 0x1000
+
+struct CtuCanMmState {
+    /*< private >*/
+    SysBusDevice    parent_obj;
+    /*< public >*/
+
+    struct {
+        uint64_t    iobase;
+        uint32_t    irq;
+    } cfg;
+
+    MemoryRegion    ctucan_io_region;
+
+    CtuCanCoreState ctucan_state[CTUCAN_MM_CORE_COUNT];
+    qemu_irq        irq;
+
+    char            *model;
+    CanBusState     *canbus[CTUCAN_MM_CORE_COUNT];
+};
+
+static void ctucan_mm_reset(DeviceState *dev)
+{
+    CtuCanMmState *d = CTUCAN_MM_DEV(dev);
+    int i;
+
+    for (i = 0 ; i < CTUCAN_MM_CORE_COUNT; i++) {
+        ctucan_hardware_reset(&d->ctucan_state[i]);
+    }
+}
+
+static uint64_t ctucan_mm_cores_io_read(void *opaque, hwaddr addr,
+                                          unsigned size)
+{
+    CtuCanMmState *d = opaque;
+    CtuCanCoreState *s;
+    hwaddr core_num = addr / CTUCAN_MM_BYTES_PER_CORE;
+
+    if (core_num >= CTUCAN_MM_CORE_COUNT) {
+        return 0;
+    }
+
+    s = &d->ctucan_state[core_num];
+
+    return ctucan_mem_read(s, addr % CTUCAN_MM_BYTES_PER_CORE, size);
+}
+
+static void ctucan_mm_cores_io_write(void *opaque, hwaddr addr, uint64_t data,
+                             unsigned size)
+{
+    CtuCanMmState *d = opaque;
+    CtuCanCoreState *s;
+    hwaddr core_num = addr / CTUCAN_MM_BYTES_PER_CORE;
+
+    if (core_num >= CTUCAN_MM_CORE_COUNT) {
+        return;
+    }
+
+    s = &d->ctucan_state[core_num];
+
+    return ctucan_mem_write(s, addr % CTUCAN_MM_BYTES_PER_CORE, data, size);
+}
+
+static const MemoryRegionOps ctucan_mm_cores_io_ops = {
+    .read = ctucan_mm_cores_io_read,
+    .write = ctucan_mm_cores_io_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .impl.min_access_size = 1,
+    .impl.max_access_size = 4,
+    .valid.min_access_size = 1,
+    .valid.max_access_size = 4,
+};
+
+static void ctucan_mm_realize(DeviceState *dev, Error **errp)
+{
+    CtuCanMmState *d = CTUCAN_MM_DEV(dev);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
+    int i;
+
+    for (i = 0 ; i < CTUCAN_MM_CORE_COUNT; i++) {
+        ctucan_init(&d->ctucan_state[i], d->irq);
+    }
+
+    for (i = 0 ; i < CTUCAN_MM_CORE_COUNT; i++) {
+        if (ctucan_connect_to_bus(&d->ctucan_state[i], d->canbus[i]) < 0) {
+            error_setg(errp, "ctucan_connect_to_bus failed");
+            return;
+        }
+    }
+
+    /* memory_region_add_subregion(get_system_memory(), 0x43c30000, &d->ctucan_io_region); */
+    if (d->cfg.iobase != 0) {
+        sysbus_mmio_map(sbd, 0, d->cfg.iobase);
+    }
+    if (d->cfg.irq != 0) {
+        //const char *id = "/machine/unattached/device[3]/gic";
+        const char *id = "/machine/unattached/device[3]";
+        Object *obj = object_resolve_path_at(container_get(qdev_get_machine(), "/peripheral"), id);
+        DeviceState *gicdev;
+        if (!obj) {
+            error_set(errp, ERROR_CLASS_DEVICE_NOT_FOUND, "Device '%s' not found", id);
+            return;
+        }
+        gicdev = (DeviceState *)object_dynamic_cast(obj, TYPE_DEVICE);
+        if (!gicdev) {
+            error_setg(errp, "%s is not a hotpluggable device", id);
+            return;
+        }
+        sysbus_connect_irq(sbd, 0, qdev_get_gpio_in(gicdev, d->cfg.irq));
+    }
+}
+
+/*
+static void ctucan_mm_exit(Object *obj)
+{
+    CtuCanMmState *d = CTUCAN_MM_DEV(obj);
+    int i;
+
+    for (i = 0 ; i < CTUCAN_MM_CORE_COUNT; i++) {
+        ctucan_disconnect(&d->ctucan_state[i]);
+    }
+
+    qemu_free_irq(d->irq);
+}
+*/
+
+static void ctucan_mm_reset_init(Object *obj, ResetType type)
+{
+    CtuCanMmState *d = CTUCAN_MM_DEV(obj);
+    unsigned int i;
+
+    for (i = 0 ; i < CTUCAN_MM_CORE_COUNT; i++) {
+        ctucan_init(&d->ctucan_state[i], d->irq);
+    }
+}
+
+static void ctucan_mm_reset_hold(Object *obj, ResetType type)
+{
+    CtuCanMmState *d = CTUCAN_MM_DEV(obj);
+    unsigned int i;
+
+    for (i = 0 ; i < CTUCAN_MM_CORE_COUNT; i++) {
+        ctucan_init(&d->ctucan_state[i], d->irq);
+    }
+}
+
+static const VMStateDescription vmstate_ctucan_mm = {
+    .name = "ctucan_mm",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_STRUCT(ctucan_state[0], CtuCanMmState, 0, vmstate_ctucan,
+                       CtuCanCoreState),
+#if CTUCAN_MM_CORE_COUNT >= 2
+        VMSTATE_STRUCT(ctucan_state[1], CtuCanMmState, 0, vmstate_ctucan,
+                       CtuCanCoreState),
+#endif
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void ctucan_mm_instance_init(Object *obj)
+{
+    CtuCanMmState *d = CTUCAN_MM_DEV(obj);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
+
+#if CTUCAN_MM_CORE_COUNT <= 1
+    object_property_add_link(obj, "canbus", TYPE_CAN_BUS,
+                             (Object **)&d->canbus[0],
+                             qdev_prop_allow_set_link_before_realize, 0);
+#else /* CTUCAN_MM_CORE_COUNT >= 2 */
+    object_property_add_link(obj, "canbus0", TYPE_CAN_BUS,
+                             (Object **)&d->canbus[0],
+                             qdev_prop_allow_set_link_before_realize, 0);
+    object_property_add_link(obj, "canbus1", TYPE_CAN_BUS,
+                             (Object **)&d->canbus[1],
+                             qdev_prop_allow_set_link_before_realize, 0);
+#endif
+    memory_region_init_io(&d->ctucan_io_region, OBJECT(d),
+                          &ctucan_mm_cores_io_ops, d,
+                          "ctucan_mm", CTUCAN_MM_CORE_RANGE);
+
+    sysbus_init_mmio(sbd, &d->ctucan_io_region);
+    sysbus_init_irq(sbd, &d->irq);
+}
+
+static Property ctucan_mm_properties[] = {
+    //DEFINE_PROP_UNSIGNED_NODEFAULT("base", CtuCanMmState, cfg.base,
+    //                               qdev_prop_uint64, uint64_t),
+    DEFINE_PROP_UINT64("iobase", CtuCanMmState, cfg.iobase, 0),
+    DEFINE_PROP_UINT32("irq", CtuCanMmState, cfg.irq, 0),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void ctucan_mm_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
+
+    rc->phases.enter = ctucan_mm_reset_init;
+    rc->phases.hold = ctucan_mm_reset_hold;
+    dc->realize = ctucan_mm_realize;
+    /* ->exit = ctucan_mm_exit; */
+    dc->desc = "CTU CAN MM";
+    dc->vmsd = &vmstate_ctucan_mm;
+    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
+    dc->user_creatable = true;
+    /* dc->reset = ctucan_mm_reset; */
+    device_class_set_legacy_reset(dc, ctucan_mm_reset);
+
+    device_class_set_props(dc, ctucan_mm_properties);
+}
+
+static const TypeInfo ctucan_mm_info = {
+    .name          = TYPE_CTUCAN_MM_DEV,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(CtuCanMmState),
+    .class_init    = ctucan_mm_class_init,
+    .instance_init = ctucan_mm_instance_init,
+};
+
+static void ctucan_mm_register_types(void)
+{
+    type_register_static(&ctucan_mm_info);
+}
+
+type_init(ctucan_mm_register_types)
diff --git a/hw/net/can/meson.build b/hw/net/can/meson.build
index 7382344628..de25fdbd1c 100644
--- a/hw/net/can/meson.build
+++ b/hw/net/can/meson.build
@@ -3,6 +3,7 @@ system_ss.add(when: 'CONFIG_CAN_PCI', if_true: files('can_kvaser_pci.c'))
 system_ss.add(when: 'CONFIG_CAN_PCI', if_true: files('can_pcm3680_pci.c'))
 system_ss.add(when: 'CONFIG_CAN_PCI', if_true: files('can_mioe3680_pci.c'))
 system_ss.add(when: 'CONFIG_CAN_CTUCANFD', if_true: files('ctucan_core.c'))
+system_ss.add(when: 'CONFIG_CAN_CTUCANFD', if_true: files('ctucan_mm.c'))
 system_ss.add(when: 'CONFIG_CAN_CTUCANFD_PCI', if_true: files('ctucan_pci.c'))
 system_ss.add(when: 'CONFIG_XLNX_ZYNQMP', if_true: files('xlnx-zynqmp-can.c'))
 system_ss.add(when: 'CONFIG_XLNX_VERSAL', if_true: files('xlnx-versal-canfd.c'))
-- 
2.39.5


