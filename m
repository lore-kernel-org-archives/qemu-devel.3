Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15FD8EE6420
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 02:36:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soZgX-000480-Uf; Wed, 11 Sep 2024 22:35:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1soZgV-000411-KO
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 22:35:51 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1soZgQ-0003WT-8B
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 22:35:51 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8Axbep+U+JmaGMFAA--.12682S3;
 Thu, 12 Sep 2024 10:35:42 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMBxHeR5U+JmelsEAA--.25141S6;
 Thu, 12 Sep 2024 10:35:42 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Xianglai Li <lixianglai@loongson.cn>, qemu-devel@nongnu.org,
 bibo mao <maobibo@loongson.cn>
Subject: [PATCH 4/5] hw/intc/loongarch_pch: Inherit from loongarch_pic_common
Date: Thu, 12 Sep 2024 10:35:36 +0800
Message-Id: <20240912023537.1004979-5-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240912023537.1004979-1-maobibo@loongson.cn>
References: <20240912023537.1004979-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMBxHeR5U+JmelsEAA--.25141S6
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

From: bibo mao <maobibo@loongson.cn>

Set TYPE_LOONGARCH_PIC inherit from TYPE_LOONGARCH_PIC_COMMON object,
it shares vmsate and property of TYPE_LOONGARCH_PIC_COMMON, and has
its own realize() function.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 hw/intc/loongarch_pch_pic.c         | 65 +++++++++--------------------
 hw/intc/meson.build                 |  2 +-
 include/hw/intc/loongarch_pch_pic.h | 45 +++++++-------------
 3 files changed, 37 insertions(+), 75 deletions(-)

diff --git a/hw/intc/loongarch_pch_pic.c b/hw/intc/loongarch_pch_pic.c
index 02cf95dcf5..94b6ec09f3 100644
--- a/hw/intc/loongarch_pch_pic.c
+++ b/hw/intc/loongarch_pch_pic.c
@@ -379,13 +379,16 @@ static void loongarch_pch_pic_reset(DeviceState *d)
     s->int_polarity = 0x0;
 }
 
-static void loongarch_pch_pic_realize(DeviceState *dev, Error **errp)
+static void loongarch_pic_realize(DeviceState *dev, Error **errp)
 {
-    LoongArchPCHPIC *s = LOONGARCH_PCH_PIC(dev);
+    LoongArchPICCommonState *s = LOONGARCH_PIC_COMMON(dev);
+    LoongarchPICClass *lpc = LOONGARCH_PIC_GET_CLASS(dev);
+    Error *local_err = NULL;
     SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
 
-    if (!s->irq_num || s->irq_num  > VIRT_PCH_PIC_IRQ_NUM) {
-        error_setg(errp, "Invalid 'pic_irq_num'");
+    lpc->parent_realize(dev, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
         return;
     }
 
@@ -404,52 +407,24 @@ static void loongarch_pch_pic_realize(DeviceState *dev, Error **errp)
     sysbus_init_mmio(sbd, &s->iomem32_high);
 }
 
-static Property loongarch_pch_pic_properties[] = {
-    DEFINE_PROP_UINT32("pch_pic_irq_num",  LoongArchPCHPIC, irq_num, 0),
-    DEFINE_PROP_END_OF_LIST(),
-};
-
-static const VMStateDescription vmstate_loongarch_pch_pic = {
-    .name = TYPE_LOONGARCH_PCH_PIC,
-    .version_id = 1,
-    .minimum_version_id = 1,
-    .fields = (const VMStateField[]) {
-        VMSTATE_UINT64(int_mask, LoongArchPCHPIC),
-        VMSTATE_UINT64(htmsi_en, LoongArchPCHPIC),
-        VMSTATE_UINT64(intedge, LoongArchPCHPIC),
-        VMSTATE_UINT64(intclr, LoongArchPCHPIC),
-        VMSTATE_UINT64(auto_crtl0, LoongArchPCHPIC),
-        VMSTATE_UINT64(auto_crtl1, LoongArchPCHPIC),
-        VMSTATE_UINT8_ARRAY(route_entry, LoongArchPCHPIC, 64),
-        VMSTATE_UINT8_ARRAY(htmsi_vector, LoongArchPCHPIC, 64),
-        VMSTATE_UINT64(last_intirr, LoongArchPCHPIC),
-        VMSTATE_UINT64(intirr, LoongArchPCHPIC),
-        VMSTATE_UINT64(intisr, LoongArchPCHPIC),
-        VMSTATE_UINT64(int_polarity, LoongArchPCHPIC),
-        VMSTATE_END_OF_LIST()
-    }
-};
-
-static void loongarch_pch_pic_class_init(ObjectClass *klass, void *data)
+static void loongarch_pic_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
+    LoongarchPICClass *lpc = LOONGARCH_PIC_CLASS(klass);
 
-    dc->realize = loongarch_pch_pic_realize;
+    device_class_set_parent_realize(dc, loongarch_pic_realize,
+                                    &lpc->parent_realize);
     dc->reset = loongarch_pch_pic_reset;
-    dc->vmsd = &vmstate_loongarch_pch_pic;
-    device_class_set_props(dc, loongarch_pch_pic_properties);
 }
 
-static const TypeInfo loongarch_pch_pic_info = {
-    .name          = TYPE_LOONGARCH_PCH_PIC,
-    .parent        = TYPE_SYS_BUS_DEVICE,
-    .instance_size = sizeof(LoongArchPCHPIC),
-    .class_init    = loongarch_pch_pic_class_init,
+static const TypeInfo loongarch_pic_types[] = {
+    {
+        .name               = TYPE_LOONGARCH_PIC,
+        .parent             = TYPE_LOONGARCH_PIC_COMMON,
+        .instance_size      = sizeof(LoongarchPICState),
+        .class_size         = sizeof(LoongarchPICClass),
+        .class_init         = loongarch_pic_class_init,
+    }
 };
 
-static void loongarch_pch_pic_register_types(void)
-{
-    type_register_static(&loongarch_pch_pic_info);
-}
-
-type_init(loongarch_pch_pic_register_types)
+DEFINE_TYPES(loongarch_pic_types)
diff --git a/hw/intc/meson.build b/hw/intc/meson.build
index f4d81eb8e4..0b3538558e 100644
--- a/hw/intc/meson.build
+++ b/hw/intc/meson.build
@@ -72,6 +72,6 @@ specific_ss.add(when: 'CONFIG_M68K_IRQC', if_true: files('m68k_irqc.c'))
 specific_ss.add(when: 'CONFIG_LOONGSON_IPI_COMMON', if_true: files('loongson_ipi_common.c'))
 specific_ss.add(when: 'CONFIG_LOONGSON_IPI', if_true: files('loongson_ipi.c'))
 specific_ss.add(when: 'CONFIG_LOONGARCH_IPI', if_true: files('loongarch_ipi.c'))
-specific_ss.add(when: 'CONFIG_LOONGARCH_PCH_PIC', if_true: files('loongarch_pch_pic.c'))
+specific_ss.add(when: 'CONFIG_LOONGARCH_PCH_PIC', if_true: files('loongarch_pch_pic.c', 'loongarch_pic_common.c'))
 specific_ss.add(when: 'CONFIG_LOONGARCH_PCH_MSI', if_true: files('loongarch_pch_msi.c'))
 specific_ss.add(when: 'CONFIG_LOONGARCH_EXTIOI', if_true: files('loongarch_extioi.c'))
diff --git a/include/hw/intc/loongarch_pch_pic.h b/include/hw/intc/loongarch_pch_pic.h
index c71ee59de2..1bc9241203 100644
--- a/include/hw/intc/loongarch_pch_pic.h
+++ b/include/hw/intc/loongarch_pch_pic.h
@@ -11,35 +11,22 @@
 #include "hw/sysbus.h"
 #include "hw/intc/loongarch_pic_common.h"
 
-#define TYPE_LOONGARCH_PCH_PIC "loongarch_pch_pic"
-#define PCH_PIC_NAME(name) TYPE_LOONGARCH_PCH_PIC#name
-OBJECT_DECLARE_SIMPLE_TYPE(LoongArchPCHPIC, LOONGARCH_PCH_PIC)
-
-struct LoongArchPCHPIC {
-    SysBusDevice parent_obj;
-    qemu_irq parent_irq[64];
-    uint64_t int_mask; /*0x020 interrupt mask register*/
-    uint64_t htmsi_en; /*0x040 1=msi*/
-    uint64_t intedge; /*0x060 edge=1 level  =0*/
-    uint64_t intclr; /*0x080 for clean edge int,set 1 clean,set 0 is noused*/
-    uint64_t auto_crtl0; /*0x0c0*/
-    uint64_t auto_crtl1; /*0x0e0*/
-    uint64_t last_intirr;    /* edge detection */
-    uint64_t intirr; /* 0x380 interrupt request register */
-    uint64_t intisr; /* 0x3a0 interrupt service register */
-    /*
-     * 0x3e0 interrupt level polarity selection
-     * register 0 for high level trigger
-     */
-    uint64_t int_polarity;
-
-    uint8_t route_entry[64]; /*0x100 - 0x138*/
-    uint8_t htmsi_vector[64]; /*0x200 - 0x238*/
-
-    MemoryRegion iomem32_low;
-    MemoryRegion iomem32_high;
-    MemoryRegion iomem8;
-    unsigned int irq_num;
+#define TYPE_LOONGARCH_PIC  "loongarch_pic"
+#define PCH_PIC_NAME(name)  TYPE_LOONGARCH_PIC#name
+OBJECT_DECLARE_TYPE(LoongarchPICState, LoongarchPICClass, LOONGARCH_PIC)
+
+struct LoongarchPICState {
+    LoongArchPICCommonState parent_obj;
 };
 
+struct LoongarchPICClass {
+    LoongArchPICCommonClass parent_class;
+
+    DeviceRealize parent_realize;
+};
+
+#define TYPE_LOONGARCH_PCH_PIC TYPE_LOONGARCH_PIC
+typedef struct LoongArchPICCommonState LoongArchPCHPIC;
+#define LOONGARCH_PCH_PIC(obj)   ((struct LoongArchPICCommonState *)(obj))
+
 #endif /* HW_LOONGARCH_PCH_PIC_H */
-- 
2.39.3


