Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00B25C3ABD9
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 08:10:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uF7Bz-0005Cd-SQ; Wed, 14 May 2025 04:10:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1uF7By-00059d-Ho
 for qemu-devel@nongnu.org; Wed, 14 May 2025 04:10:18 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1uF7Bv-0003FV-9C
 for qemu-devel@nongnu.org; Wed, 14 May 2025 04:10:17 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8Axz3PkTyRoGlvmAA--.46622S3;
 Wed, 14 May 2025 16:10:12 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by front1 (Coremail) with SMTP id qMiowMBxb8fjTyRozAbRAA--.6875S3;
 Wed, 14 May 2025 16:10:11 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: stefanha@gmail.com,
	maobibo@loongson.cn
Subject: [PULL 16/17] hw/intc/loongarch_pch: Merge three memory region into one
Date: Wed, 14 May 2025 15:47:55 +0800
Message-Id: <20250514074756.2424762-2-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20250514074756.2424762-1-gaosong@loongson.cn>
References: <20250514073927.2424543-1-gaosong@loongson.cn>
 <20250514074756.2424762-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMBxb8fjTyRozAbRAA--.6875S3
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

From: Bibo Mao <maobibo@loongson.cn>

Since memory region iomem supports memory access size with 1/2/4/8,
it can be used for memory region iomem8 and iomem32_high. Now remove
memory region iomem8 and iomem32_high, merge them into iomem together.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by: Song Gao <gaosong@loongson.cn>
Message-Id: <20250507023754.1877445-5-maobibo@loongson.cn>
Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 hw/intc/loongarch_pch_pic.c            | 66 +-------------------------
 hw/loongarch/virt.c                    |  6 ---
 include/hw/intc/loongarch_pic_common.h |  2 -
 3 files changed, 1 insertion(+), 73 deletions(-)

diff --git a/hw/intc/loongarch_pch_pic.c b/hw/intc/loongarch_pch_pic.c
index e9126a0c1f..cbba2fc284 100644
--- a/hw/intc/loongarch_pch_pic.c
+++ b/hw/intc/loongarch_pch_pic.c
@@ -230,34 +230,6 @@ static void loongarch_pch_pic_write(void *opaque, hwaddr addr,
     }
 }
 
-static uint64_t loongarch_pch_pic_high_readw(void *opaque, hwaddr addr,
-                                        unsigned size)
-{
-    addr += PCH_PIC_INT_STATUS;
-    return loongarch_pch_pic_read(opaque, addr, size);
-}
-
-static void loongarch_pch_pic_high_writew(void *opaque, hwaddr addr,
-                                     uint64_t value, unsigned size)
-{
-    addr += PCH_PIC_INT_STATUS;
-    loongarch_pch_pic_write(opaque, addr, value, size);
-}
-
-static uint64_t loongarch_pch_pic_readb(void *opaque, hwaddr addr,
-                                        unsigned size)
-{
-    addr += PCH_PIC_ROUTE_ENTRY;
-    return loongarch_pch_pic_read(opaque, addr, size);
-}
-
-static void loongarch_pch_pic_writeb(void *opaque, hwaddr addr,
-                                     uint64_t data, unsigned size)
-{
-    addr += PCH_PIC_ROUTE_ENTRY;
-    loongarch_pch_pic_write(opaque, addr, data, size);
-}
-
 static const MemoryRegionOps loongarch_pch_pic_ops = {
     .read = loongarch_pch_pic_read,
     .write = loongarch_pch_pic_write,
@@ -279,34 +251,6 @@ static const MemoryRegionOps loongarch_pch_pic_ops = {
     .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
-static const MemoryRegionOps loongarch_pch_pic_reg32_high_ops = {
-    .read = loongarch_pch_pic_high_readw,
-    .write = loongarch_pch_pic_high_writew,
-    .valid = {
-        .min_access_size = 4,
-        .max_access_size = 8,
-    },
-    .impl = {
-        .min_access_size = 4,
-        .max_access_size = 4,
-    },
-    .endianness = DEVICE_LITTLE_ENDIAN,
-};
-
-static const MemoryRegionOps loongarch_pch_pic_reg8_ops = {
-    .read = loongarch_pch_pic_readb,
-    .write = loongarch_pch_pic_writeb,
-    .valid = {
-        .min_access_size = 1,
-        .max_access_size = 1,
-    },
-    .impl = {
-        .min_access_size = 1,
-        .max_access_size = 1,
-    },
-    .endianness = DEVICE_LITTLE_ENDIAN,
-};
-
 static void loongarch_pic_reset_hold(Object *obj, ResetType type)
 {
     LoongarchPICClass *lpc = LOONGARCH_PIC_GET_CLASS(obj);
@@ -333,16 +277,8 @@ static void loongarch_pic_realize(DeviceState *dev, Error **errp)
     qdev_init_gpio_in(dev, pch_pic_irq_handler, s->irq_num);
     memory_region_init_io(&s->iomem, OBJECT(dev),
                           &loongarch_pch_pic_ops,
-                          s, TYPE_LOONGARCH_PIC, 0x100);
-    memory_region_init_io(&s->iomem8, OBJECT(dev), &loongarch_pch_pic_reg8_ops,
-                          s, PCH_PIC_NAME(.reg8), 0x2a0);
-    memory_region_init_io(&s->iomem32_high, OBJECT(dev),
-                          &loongarch_pch_pic_reg32_high_ops,
-                          s, PCH_PIC_NAME(.reg32_part2), 0xc60);
+                          s, TYPE_LOONGARCH_PIC, VIRT_PCH_REG_SIZE);
     sysbus_init_mmio(sbd, &s->iomem);
-    sysbus_init_mmio(sbd, &s->iomem8);
-    sysbus_init_mmio(sbd, &s->iomem32_high);
-
 }
 
 static void loongarch_pic_class_init(ObjectClass *klass, const void *data)
diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index ebcef0a92b..1b504047db 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -429,12 +429,6 @@ static void virt_irq_init(LoongArchVirtMachineState *lvms)
     sysbus_realize_and_unref(d, &error_fatal);
     memory_region_add_subregion(get_system_memory(), VIRT_IOAPIC_REG_BASE,
                             sysbus_mmio_get_region(d, 0));
-    memory_region_add_subregion(get_system_memory(),
-                            VIRT_IOAPIC_REG_BASE + PCH_PIC_ROUTE_ENTRY,
-                            sysbus_mmio_get_region(d, 1));
-    memory_region_add_subregion(get_system_memory(),
-                            VIRT_IOAPIC_REG_BASE + PCH_PIC_INT_STATUS,
-                            sysbus_mmio_get_region(d, 2));
 
     /* Connect pch_pic irqs to extioi */
     for (i = 0; i < num; i++) {
diff --git a/include/hw/intc/loongarch_pic_common.h b/include/hw/intc/loongarch_pic_common.h
index dc03056227..9349a055d0 100644
--- a/include/hw/intc/loongarch_pic_common.h
+++ b/include/hw/intc/loongarch_pic_common.h
@@ -66,8 +66,6 @@ struct LoongArchPICCommonState {
     uint8_t htmsi_vector[64]; /* 0x200 - 0x238 */
 
     MemoryRegion iomem;
-    MemoryRegion iomem32_high;
-    MemoryRegion iomem8;
     unsigned int irq_num;
 };
 
-- 
2.34.1


