Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD600C5B552
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Jun 2025 12:03:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOaPN-0005Cy-Do; Mon, 09 Jun 2025 07:11:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1uOaPJ-0005C8-Tg
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 07:11:13 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1uOaPG-00075S-Tm
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 07:11:13 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8DxDeNIwUZoUm4RAQ--.8877S3;
 Mon, 09 Jun 2025 19:11:04 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by front1 (Coremail) with SMTP id qMiowMAxzxtFwUZoiU0SAQ--.4222S7;
 Mon, 09 Jun 2025 19:11:04 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: maobibo@loongson.cn
Cc: qemu-devel@nongnu.org,
	philmd@linaro.org,
	jiaxun.yang@flygoat.com
Subject: [PATCH 05/10] hw/loongarch: AVEC controller add a MemoryRegion
Date: Mon,  9 Jun 2025 18:48:28 +0800
Message-Id: <20250609104833.839811-6-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20250609104833.839811-1-gaosong@loongson.cn>
References: <20250609104833.839811-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMAxzxtFwUZoiU0SAQ--.4222S7
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

the AVEC controller use 2ff00000-2fffffff Memory.

Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 hw/intc/loongarch_avec.c         | 25 ++++++++++++++++++++
 hw/loongarch/virt.c              | 39 +++++++++++++++++++++++++++++++-
 include/hw/intc/loongarch_avec.h |  1 +
 include/hw/loongarch/virt.h      |  1 +
 4 files changed, 65 insertions(+), 1 deletion(-)

diff --git a/hw/intc/loongarch_avec.c b/hw/intc/loongarch_avec.c
index 5a3e7ecc03..50956e7e4e 100644
--- a/hw/intc/loongarch_avec.c
+++ b/hw/intc/loongarch_avec.c
@@ -17,6 +17,24 @@
 #include "trace.h"
 #include "hw/qdev-properties.h"
 
+static uint64_t loongarch_avec_mem_read(void *opaque,
+                                        hwaddr addr, unsigned size)
+{
+    return 0;
+}
+
+static void loongarch_avec_mem_write(void *opaque, hwaddr addr,
+                                     uint64_t val, unsigned size)
+{
+    return;
+}
+
+
+static const MemoryRegionOps loongarch_avec_ops = {
+    .read = loongarch_avec_mem_read,
+    .write = loongarch_avec_mem_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+};
 
 static void loongarch_avec_realize(DeviceState *dev, Error **errp)
 {
@@ -39,6 +57,13 @@ static void loongarch_avec_unrealize(DeviceState *dev)
 
 static void loongarch_avec_init(Object *obj)
 {
+    LoongArchAVECState *s = LOONGARCH_AVEC(obj);
+    SysBusDevice *shd = SYS_BUS_DEVICE(obj);
+    memory_region_init_io(&s->avec_mmio, OBJECT(s), &loongarch_avec_ops,
+                          s, TYPE_LOONGARCH_AVEC, 0x100000);
+    sysbus_init_mmio(shd, &s->avec_mmio);
+    msi_nonbroken = true;
+
     return;
 }
 
diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index 35643a4e0b..272355da2d 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -28,6 +28,7 @@
 #include "hw/intc/loongarch_extioi.h"
 #include "hw/intc/loongarch_pch_pic.h"
 #include "hw/intc/loongarch_pch_msi.h"
+#include "hw/intc/loongarch_avec.h"
 #include "hw/pci-host/ls7a.h"
 #include "hw/pci-host/gpex.h"
 #include "hw/misc/unimp.h"
@@ -365,7 +366,7 @@ static void virt_cpu_irq_init(LoongArchVirtMachineState *lvms)
 static void virt_irq_init(LoongArchVirtMachineState *lvms)
 {
     DeviceState *pch_pic, *pch_msi;
-    DeviceState *ipi, *extioi;
+    DeviceState *ipi, *extioi, *avec;
     SysBusDevice *d;
     int i, start, num;
 
@@ -411,6 +412,33 @@ static void virt_irq_init(LoongArchVirtMachineState *lvms)
      *    +--------+ +---------+ +---------+
      *    | UARTs  | | Devices | | Devices |
      *    +--------+ +---------+ +---------+
+     *
+     *
+     *  Advanced Extended IRQ model
+     *
+     *  +-----+     +-----------------------+     +-------+
+     *  | IPI | --> |        CPUINTC        | <-- | Timer |
+     *  +-----+     +-----------------------+     +-------+
+     *               ^          ^          ^
+     *               |          |          |
+     *        +---------+ +----------+ +---------+     +-------+
+     *        | EIOINTC | | AVECINTC | | LIOINTC | <-- | UARTs |
+     *        +---------+ +----------+ +---------+     +-------+
+     *             ^            ^
+     *             |            |
+     *        +---------+  +---------+
+     *        | PCH-PIC |  | PCH-MSI |
+     *        +---------+  +---------+
+     *          ^     ^           ^
+     *          |     |           |
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
@@ -424,6 +452,15 @@ static void virt_irq_init(LoongArchVirtMachineState *lvms)
     memory_region_add_subregion(&lvms->system_iocsr, MAIL_SEND_ADDR,
                    sysbus_mmio_get_region(SYS_BUS_DEVICE(ipi), 1));
 
+    /* Create AVEC device*/
+    if (virt_is_avecintc_enabled(lvms)) {
+        avec = qdev_new(TYPE_LOONGARCH_AVEC);
+        lvms->avec = avec;
+        sysbus_realize_and_unref(SYS_BUS_DEVICE(avec), &error_fatal);
+        memory_region_add_subregion(get_system_memory(), VIRT_PCH_MSI_ADDR_LOW,
+                        sysbus_mmio_get_region(SYS_BUS_DEVICE(avec), 0));
+    }
+
     /* Create EXTIOI device */
     extioi = qdev_new(TYPE_LOONGARCH_EXTIOI);
     lvms->extioi = extioi;
diff --git a/include/hw/intc/loongarch_avec.h b/include/hw/intc/loongarch_avec.h
index 3c68593a7c..274b284641 100644
--- a/include/hw/intc/loongarch_avec.h
+++ b/include/hw/intc/loongarch_avec.h
@@ -23,6 +23,7 @@ typedef struct AVECCore {
 
 struct LoongArchAVECState {
     SysBusDevice parent_obj;
+    MemoryRegion avec_mmio;
     AVECCore *cpu;
     uint32_t num_cpu;
 };
diff --git a/include/hw/loongarch/virt.h b/include/hw/loongarch/virt.h
index 3a81f048e8..172f40711d 100644
--- a/include/hw/loongarch/virt.h
+++ b/include/hw/loongarch/virt.h
@@ -64,6 +64,7 @@ struct LoongArchVirtMachineState {
     struct loongarch_boot_info bootinfo;
     DeviceState *ipi;
     DeviceState *extioi;
+    DeviceState *avec;
 };
 
 #define TYPE_LOONGARCH_VIRT_MACHINE  MACHINE_TYPE_NAME("virt")
-- 
2.34.1


