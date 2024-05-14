Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29FB7C04FFE
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2024 11:53:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6qhj-0006F8-Sx; Tue, 14 May 2024 07:52:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1s6qhP-00068o-Dn
 for qemu-devel@nongnu.org; Tue, 14 May 2024 07:52:11 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1s6qhK-0007Ve-R8
 for qemu-devel@nongnu.org; Tue, 14 May 2024 07:52:01 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8CxiOlXUENmeqYMAA--.18296S3;
 Tue, 14 May 2024 19:51:51 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8DxG95XUENm0GQeAA--.54564S2; 
 Tue, 14 May 2024 19:51:51 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH] tests/libqos: Add loongarch virt machine node
Date: Tue, 14 May 2024 19:51:49 +0800
Message-Id: <20240514115149.3266369-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxG95XUENm0GQeAA--.54564S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

Add loongarch virt machine to the graph. It is a modified copy of
the existing riscv virtmachine in riscv-virt-machine.c

It contains a generic-pcihost controller, and an extra function
loongarch_config_qpci_bus() to configure GPEX pci host controller
information, such as ecam and pio_base addresses.

Also hotplug handle checking about TYPE_VIRTIO_IOMMU_PCI device is
added on loongarch virt machine, since virtio_mmu_pci device requires
it.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 hw/loongarch/virt.c                         |   2 +
 tests/qtest/libqos/loongarch-virt-machine.c | 114 ++++++++++++++++++++
 tests/qtest/libqos/meson.build              |   1 +
 3 files changed, 117 insertions(+)
 create mode 100644 tests/qtest/libqos/loongarch-virt-machine.c

diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index db43b2fe4b..7f5ef87be4 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -45,6 +45,7 @@
 #include "sysemu/tpm.h"
 #include "sysemu/block-backend.h"
 #include "hw/block/flash.h"
+#include "hw/virtio/virtio-iommu.h"
 #include "qemu/error-report.h"
 
 static PFlashCFI01 *virt_flash_create1(LoongArchVirtMachineState *lvms,
@@ -1212,6 +1213,7 @@ static HotplugHandler *virt_get_hotplug_handler(MachineState *machine,
     MachineClass *mc = MACHINE_GET_CLASS(machine);
 
     if (device_is_dynamic_sysbus(mc, dev) ||
+        object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_IOMMU_PCI) ||
         memhp_type_supported(dev)) {
         return HOTPLUG_HANDLER(machine);
     }
diff --git a/tests/qtest/libqos/loongarch-virt-machine.c b/tests/qtest/libqos/loongarch-virt-machine.c
new file mode 100644
index 0000000000..c12089c015
--- /dev/null
+++ b/tests/qtest/libqos/loongarch-virt-machine.c
@@ -0,0 +1,114 @@
+/*
+ * libqos driver framework
+ *
+ * Copyright (c) 2018 Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License version 2.1 as published by the Free Software Foundation.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>
+ */
+
+#include "qemu/osdep.h"
+#include "../libqtest.h"
+#include "qemu/module.h"
+#include "libqos-malloc.h"
+#include "qgraph.h"
+#include "virtio-mmio.h"
+#include "generic-pcihost.h"
+#include "hw/pci/pci_regs.h"
+
+#define LOONGARCH_PAGE_SIZE               0x1000
+#define LOONGARCH_VIRT_RAM_ADDR           0x100000
+#define LOONGARCH_VIRT_RAM_SIZE           0xFF00000
+
+#define LOONGARCH_VIRT_PIO_BASE           0x18000000
+#define LOONGARCH_VIRT_PCIE_PIO_OFFSET    0x4000
+#define LOONGARCH_VIRT_PCIE_PIO_LIMIT     0x10000
+#define LOONGARCH_VIRT_PCIE_ECAM_BASE     0x20000000
+#define LOONGARCH_VIRT_PCIE_MMIO32_BASE   0x40000000
+#define LOONGARCH_VIRT_PCIE_MMIO32_LIMIT  0x80000000
+
+typedef struct QVirtMachine QVirtMachine;
+
+struct QVirtMachine {
+    QOSGraphObject obj;
+    QGuestAllocator alloc;
+    QVirtioMMIODevice virtio_mmio;
+    QGenericPCIHost bridge;
+};
+
+static void virt_destructor(QOSGraphObject *obj)
+{
+    QVirtMachine *machine = (QVirtMachine *) obj;
+    alloc_destroy(&machine->alloc);
+}
+
+static void *virt_get_driver(void *object, const char *interface)
+{
+    QVirtMachine *machine = object;
+    if (!g_strcmp0(interface, "memory")) {
+        return &machine->alloc;
+    }
+
+    fprintf(stderr, "%s not present in loongarch/virtio\n", interface);
+    g_assert_not_reached();
+}
+
+static QOSGraphObject *virt_get_device(void *obj, const char *device)
+{
+    QVirtMachine *machine = obj;
+    if (!g_strcmp0(device, "generic-pcihost")) {
+        return &machine->bridge.obj;
+    } else if (!g_strcmp0(device, "virtio-mmio")) {
+        return &machine->virtio_mmio.obj;
+    }
+
+    fprintf(stderr, "%s not present in loongarch/virt\n", device);
+    g_assert_not_reached();
+}
+
+static void loongarch_config_qpci_bus(QGenericPCIBus *qpci)
+{
+    qpci->gpex_pio_base = LOONGARCH_VIRT_PIO_BASE;
+    qpci->bus.pio_alloc_ptr = LOONGARCH_VIRT_PCIE_PIO_OFFSET;
+    qpci->bus.pio_limit = LOONGARCH_VIRT_PCIE_PIO_LIMIT;
+    qpci->bus.mmio_alloc_ptr = LOONGARCH_VIRT_PCIE_MMIO32_BASE;
+    qpci->bus.mmio_limit = LOONGARCH_VIRT_PCIE_MMIO32_LIMIT;
+    qpci->ecam_alloc_ptr = LOONGARCH_VIRT_PCIE_ECAM_BASE;
+}
+
+static void *qos_create_machine_loongarch_virt(QTestState *qts)
+{
+    QVirtMachine *machine = g_new0(QVirtMachine, 1);
+
+    alloc_init(&machine->alloc, 0,
+               LOONGARCH_VIRT_RAM_ADDR,
+               LOONGARCH_VIRT_RAM_ADDR + LOONGARCH_VIRT_RAM_SIZE,
+               LOONGARCH_PAGE_SIZE);
+
+    qos_create_generic_pcihost(&machine->bridge, qts, &machine->alloc);
+    loongarch_config_qpci_bus(&machine->bridge.pci);
+
+    machine->obj.get_device = virt_get_device;
+    machine->obj.get_driver = virt_get_driver;
+    machine->obj.destructor = virt_destructor;
+    return machine;
+}
+
+static void virt_machine_register_nodes(void)
+{
+    qos_node_create_machine_args("loongarch64/virt",
+                                 qos_create_machine_loongarch_virt,
+                                 " -cpu la464");
+    qos_node_contains("loongarch64/virt", "generic-pcihost", NULL);
+}
+
+libqos_init(virt_machine_register_nodes);
diff --git a/tests/qtest/libqos/meson.build b/tests/qtest/libqos/meson.build
index 3aed6efcb8..558eb4c24b 100644
--- a/tests/qtest/libqos/meson.build
+++ b/tests/qtest/libqos/meson.build
@@ -61,6 +61,7 @@ libqos_srcs = files(
         'ppc64_pseries-machine.c',
         'x86_64_pc-machine.c',
         'riscv-virt-machine.c',
+        'loongarch-virt-machine.c',
 )
 
 if have_virtfs

base-commit: dafec285bdbfe415ac6823abdc510e0b92c3f094
-- 
2.39.3


