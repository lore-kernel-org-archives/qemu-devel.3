Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 030DECAC58E
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Sep 2025 07:22:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uy3Vc-0002It-G7; Mon, 15 Sep 2025 03:20:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1uy3Vb-0002Ie-0e
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 03:20:19 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1uy3VD-0000KY-Tw
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 03:20:18 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8Dxb_ATvsdo8mwKAA--.22659S3;
 Mon, 15 Sep 2025 15:19:47 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowJAxVOQSvsdoXteWAA--.24724S5;
 Mon, 15 Sep 2025 15:19:47 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH 3/8] hw/loongarch/virt: Add field gpx in
 LoongArchVirtMachineState
Date: Mon, 15 Sep 2025 15:19:41 +0800
Message-Id: <20250915071946.315171-4-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250915071946.315171-1-maobibo@loongson.cn>
References: <20250915071946.315171-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJAxVOQSvsdoXteWAA--.24724S5
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Add field gpex in structure LoongArchVirtMachineState, type of field
gpx is structure GPEXConfig and it is to record configuration
information about GPEX host bridge. And remove field pci_bus
in structure LoongArchVirtMachineState since it is in field
gpex already.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 hw/loongarch/virt-acpi-build.c | 13 +------------
 hw/loongarch/virt.c            |  9 ++++++++-
 include/hw/loongarch/virt.h    |  3 ++-
 3 files changed, 11 insertions(+), 14 deletions(-)

diff --git a/hw/loongarch/virt-acpi-build.c b/hw/loongarch/virt-acpi-build.c
index 8c2228a772..8f3f1afac5 100644
--- a/hw/loongarch/virt-acpi-build.c
+++ b/hw/loongarch/virt-acpi-build.c
@@ -384,18 +384,7 @@ build_la_ged_aml(Aml *dsdt, MachineState *machine)
 
 static void build_pci_device_aml(Aml *scope, LoongArchVirtMachineState *lvms)
 {
-    struct GPEXConfig cfg = {
-        .mmio64.base = VIRT_PCI_MEM_BASE,
-        .mmio64.size = VIRT_PCI_MEM_SIZE,
-        .pio.base    = VIRT_PCI_IO_BASE,
-        .pio.size    = VIRT_PCI_IO_SIZE,
-        .ecam.base   = VIRT_PCI_CFG_BASE,
-        .ecam.size   = VIRT_PCI_CFG_SIZE,
-        .irq         = VIRT_GSI_BASE + VIRT_DEVICE_IRQS,
-        .bus         = lvms->pci_bus,
-    };
-
-    acpi_dsdt_add_gpex(scope, &cfg);
+    acpi_dsdt_add_gpex(scope, &lvms->gpex);
 }
 
 static void build_flash_aml(Aml *scope, LoongArchVirtMachineState *lvms)
diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index 76e43c5f71..16846b3054 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -274,7 +274,14 @@ static void virt_devices_init(DeviceState *pch_pic,
     d = SYS_BUS_DEVICE(gpex_dev);
     sysbus_realize_and_unref(d, &error_fatal);
     pci_bus = PCI_HOST_BRIDGE(gpex_dev)->bus;
-    lvms->pci_bus = pci_bus;
+    lvms->gpex.mmio64.base = VIRT_PCI_MEM_BASE;
+    lvms->gpex.mmio64.size = VIRT_PCI_MEM_SIZE;
+    lvms->gpex.pio.base = VIRT_PCI_IO_BASE;
+    lvms->gpex.pio.size = VIRT_PCI_IO_SIZE;
+    lvms->gpex.ecam.base = VIRT_PCI_CFG_BASE;
+    lvms->gpex.ecam.size = VIRT_PCI_CFG_SIZE;
+    lvms->gpex.irq = VIRT_GSI_BASE + VIRT_DEVICE_IRQS;
+    lvms->gpex.bus = pci_bus;
 
     /* Map only part size_ecam bytes of ECAM space */
     ecam_alias = g_new0(MemoryRegion, 1);
diff --git a/include/hw/loongarch/virt.h b/include/hw/loongarch/virt.h
index 8b970d1753..a06e08f3ac 100644
--- a/include/hw/loongarch/virt.h
+++ b/include/hw/loongarch/virt.h
@@ -12,6 +12,7 @@
 #include "qemu/queue.h"
 #include "hw/block/flash.h"
 #include "hw/loongarch/boot.h"
+#include "hw/pci-host/gpex.h"
 
 #define LOONGARCH_MAX_CPUS      256
 
@@ -55,7 +56,6 @@ struct LoongArchVirtMachineState {
     DeviceState  *acpi_ged;
     int          fdt_size;
     DeviceState *platform_bus_dev;
-    PCIBus       *pci_bus;
     PFlashCFI01  *flash[2];
     MemoryRegion system_iocsr;
     MemoryRegion iocsr_mem;
@@ -66,6 +66,7 @@ struct LoongArchVirtMachineState {
     struct memmap_entry *memmap_table;
     unsigned int memmap_entries;
     hwaddr ram_end;
+    struct GPEXConfig gpex;
 };
 
 #define TYPE_LOONGARCH_VIRT_MACHINE  MACHINE_TYPE_NAME("virt")
-- 
2.39.3


