Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EA6ECAC5BB
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Sep 2025 09:49:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v2o14-0001hj-TA; Sun, 28 Sep 2025 05:48:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1v2o11-0001gU-39
 for qemu-devel@nongnu.org; Sun, 28 Sep 2025 05:48:23 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1v2o0i-0006Th-I3
 for qemu-devel@nongnu.org; Sun, 28 Sep 2025 05:48:22 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8CxK9JLBNlogs4PAA--.31750S3;
 Sun, 28 Sep 2025 17:47:55 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by front1 (Coremail) with SMTP id qMiowJDx_8NCBNloMpa5AA--.63673S8;
 Sun, 28 Sep 2025 17:47:55 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: Bibo Mao <maobibo@loongson.cn>
Subject: [PULL v2 06/11] hw/loongarch: DINTC add a MemoryRegion
Date: Sun, 28 Sep 2025 17:24:03 +0800
Message-Id: <20250928092408.948035-7-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20250928092408.948035-1-gaosong@loongson.cn>
References: <20250928092408.948035-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJDx_8NCBNloMpa5AA--.63673S8
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

the DINTC use [2fe00000-2ff00000) Memory.

Signed-off-by: Song Gao <gaosong@loongson.cn>
Reviewed-by: Bibo Mao <maobibo@loongson.cn>
Message-ID: <20250916122109.749813-7-gaosong@loongson.cn>
---
 hw/intc/loongarch_dintc.c         | 24 +++++++++++++++++++
 hw/loongarch/virt.c               | 38 ++++++++++++++++++++++++++++++-
 include/hw/intc/loongarch_dintc.h |  1 +
 include/hw/loongarch/virt.h       |  1 +
 include/hw/pci-host/ls7a.h        |  2 ++
 5 files changed, 65 insertions(+), 1 deletion(-)

diff --git a/hw/intc/loongarch_dintc.c b/hw/intc/loongarch_dintc.c
index b2465cb022..7173a6aa29 100644
--- a/hw/intc/loongarch_dintc.c
+++ b/hw/intc/loongarch_dintc.c
@@ -17,6 +17,24 @@
 #include "trace.h"
 #include "hw/qdev-properties.h"
 
+static uint64_t loongarch_dintc_mem_read(void *opaque,
+                                        hwaddr addr, unsigned size)
+{
+    return 0;
+}
+
+static void loongarch_dintc_mem_write(void *opaque, hwaddr addr,
+                                     uint64_t val, unsigned size)
+{
+    return;
+}
+
+
+static const MemoryRegionOps loongarch_dintc_ops = {
+    .read = loongarch_dintc_mem_read,
+    .write = loongarch_dintc_mem_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+};
 
 static void loongarch_dintc_realize(DeviceState *dev, Error **errp)
 {
@@ -39,6 +57,12 @@ static void loongarch_dintc_unrealize(DeviceState *dev)
 
 static void loongarch_dintc_init(Object *obj)
 {
+    LoongArchDINTCState *s = LOONGARCH_DINTC(obj);
+    SysBusDevice *shd = SYS_BUS_DEVICE(obj);
+    memory_region_init_io(&s->dintc_mmio, OBJECT(s), &loongarch_dintc_ops,
+                          s, TYPE_LOONGARCH_DINTC, VIRT_DINTC_SIZE);
+    sysbus_init_mmio(shd, &s->dintc_mmio);
+    msi_nonbroken = true;
     return;
 }
 
diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index a89d1a1ca1..a7171a5ecc 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -28,6 +28,7 @@
 #include "hw/intc/loongarch_extioi.h"
 #include "hw/intc/loongarch_pch_pic.h"
 #include "hw/intc/loongarch_pch_msi.h"
+#include "hw/intc/loongarch_dintc.h"
 #include "hw/pci-host/ls7a.h"
 #include "hw/pci-host/gpex.h"
 #include "hw/misc/unimp.h"
@@ -386,7 +387,7 @@ static void virt_cpu_irq_init(LoongArchVirtMachineState *lvms)
 static void virt_irq_init(LoongArchVirtMachineState *lvms)
 {
     DeviceState *pch_pic, *pch_msi;
-    DeviceState *ipi, *extioi;
+    DeviceState *ipi, *extioi, *dintc;
     SysBusDevice *d;
     int i, start, num;
 
@@ -432,6 +433,33 @@ static void virt_irq_init(LoongArchVirtMachineState *lvms)
      *    +--------+ +---------+ +---------+
      *    | UARTs  | | Devices | | Devices |
      *    +--------+ +---------+ +---------+
+     *
+     *
+     *  Advanced Extended IRQ model
+     *
+     *  +-----+     +---------------------------------+     +-------+
+     *  | IPI | --> |        CPUINTC                  | <-- | Timer |
+     *  +-----+     +---------------------------------+     +-------+
+     *                      ^            ^          ^
+     *                      |            |          |
+     *             +-------------+ +----------+ +---------+     +-------+
+     *             |   EIOINTC   | |   DINTC  | | LIOINTC | <-- | UARTs |
+     *             +-------------+ +----------+ +---------+     +-------+
+     *             ^            ^       ^
+     *             |            |       |
+     *        +---------+  +---------+  |
+     *        | PCH-PIC |  | PCH-MSI |  |
+     *        +---------+  +---------+  |
+     *          ^     ^           ^     |
+     *          |     |           |     |
+     *  +---------+ +---------+ +---------+
+     *  | Devices | | PCH-LPC | | Devices |
+     *  +---------+ +---------+ +---------+
+     *                  ^
+     *                  |
+     *             +---------+
+     *             | Devices |
+     *             +---------+
      */
 
     /* Create IPI device */
@@ -439,6 +467,14 @@ static void virt_irq_init(LoongArchVirtMachineState *lvms)
     lvms->ipi = ipi;
     sysbus_realize_and_unref(SYS_BUS_DEVICE(ipi), &error_fatal);
 
+    /* Create DINTC device*/
+    if (virt_has_dmsi(lvms)) {
+        dintc = qdev_new(TYPE_LOONGARCH_DINTC);
+        lvms->dintc = dintc;
+        sysbus_realize_and_unref(SYS_BUS_DEVICE(dintc), &error_fatal);
+        sysbus_mmio_map(SYS_BUS_DEVICE(dintc), 0, VIRT_DINTC_BASE);
+    }
+
     /* Create EXTIOI device */
     extioi = qdev_new(TYPE_LOONGARCH_EXTIOI);
     lvms->extioi = extioi;
diff --git a/include/hw/intc/loongarch_dintc.h b/include/hw/intc/loongarch_dintc.h
index aa94cd1003..0b0b5347b2 100644
--- a/include/hw/intc/loongarch_dintc.h
+++ b/include/hw/intc/loongarch_dintc.h
@@ -23,6 +23,7 @@ typedef struct DINTCCore {
 
 struct LoongArchDINTCState {
     SysBusDevice parent_obj;
+    MemoryRegion dintc_mmio;
     DINTCCore *cpu;
     uint32_t num_cpu;
 };
diff --git a/include/hw/loongarch/virt.h b/include/hw/loongarch/virt.h
index 98e9bf0737..cd97bdfb8d 100644
--- a/include/hw/loongarch/virt.h
+++ b/include/hw/loongarch/virt.h
@@ -89,6 +89,7 @@ struct LoongArchVirtMachineState {
     unsigned int memmap_entries;
     uint64_t misc_feature;
     uint64_t misc_status;
+    DeviceState *dintc;
 };
 
 #define TYPE_LOONGARCH_VIRT_MACHINE  MACHINE_TYPE_NAME("virt")
diff --git a/include/hw/pci-host/ls7a.h b/include/hw/pci-host/ls7a.h
index 79d4ea8501..bfdbfe3614 100644
--- a/include/hw/pci-host/ls7a.h
+++ b/include/hw/pci-host/ls7a.h
@@ -24,6 +24,8 @@
 #define VIRT_PCH_REG_BASE        0x10000000UL
 #define VIRT_IOAPIC_REG_BASE     (VIRT_PCH_REG_BASE)
 #define VIRT_PCH_MSI_ADDR_LOW    0x2FF00000UL
+#define VIRT_DINTC_SIZE          0x100000UL
+#define VIRT_DINTC_BASE          0x2FE00000UL
 #define VIRT_PCH_REG_SIZE        0x400
 #define VIRT_PCH_MSI_SIZE        0x8
 
-- 
2.47.0


