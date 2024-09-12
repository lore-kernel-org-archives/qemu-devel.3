Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6643AEE6420
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 02:36:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soZgW-000416-NC; Wed, 11 Sep 2024 22:35:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1soZgU-0003zK-47
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 22:35:50 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1soZgQ-0003WP-96
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 22:35:49 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8Bxfep9U+JmY2MFAA--.13388S3;
 Thu, 12 Sep 2024 10:35:41 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMBxHeR5U+JmelsEAA--.25141S4;
 Thu, 12 Sep 2024 10:35:41 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Xianglai Li <lixianglai@loongson.cn>, qemu-devel@nongnu.org,
 bibo mao <maobibo@loongson.cn>
Subject: [PATCH 2/5] hw/intc/loongarch_pch: Merge instance_init() into
 realize()
Date: Thu, 12 Sep 2024 10:35:34 +0800
Message-Id: <20240912023537.1004979-3-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240912023537.1004979-1-maobibo@loongson.cn>
References: <20240912023537.1004979-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMBxHeR5U+JmelsEAA--.25141S4
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

Memory region is created in instance_init(), merge it into function
realize(). There is no special class_init() for loongarch_pch object.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 hw/intc/loongarch_pch_pic.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/hw/intc/loongarch_pch_pic.c b/hw/intc/loongarch_pch_pic.c
index 2d5e65abff..02cf95dcf5 100644
--- a/hw/intc/loongarch_pch_pic.c
+++ b/hw/intc/loongarch_pch_pic.c
@@ -382,6 +382,7 @@ static void loongarch_pch_pic_reset(DeviceState *d)
 static void loongarch_pch_pic_realize(DeviceState *dev, Error **errp)
 {
     LoongArchPCHPIC *s = LOONGARCH_PCH_PIC(dev);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
 
     if (!s->irq_num || s->irq_num  > VIRT_PCH_PIC_IRQ_NUM) {
         error_setg(errp, "Invalid 'pic_irq_num'");
@@ -390,25 +391,17 @@ static void loongarch_pch_pic_realize(DeviceState *dev, Error **errp)
 
     qdev_init_gpio_out(dev, s->parent_irq, s->irq_num);
     qdev_init_gpio_in(dev, pch_pic_irq_handler, s->irq_num);
-}
-
-static void loongarch_pch_pic_init(Object *obj)
-{
-    LoongArchPCHPIC *s = LOONGARCH_PCH_PIC(obj);
-    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
-
-    memory_region_init_io(&s->iomem32_low, obj,
+    memory_region_init_io(&s->iomem32_low, OBJECT(dev),
                           &loongarch_pch_pic_reg32_low_ops,
                           s, PCH_PIC_NAME(.reg32_part1), 0x100);
-    memory_region_init_io(&s->iomem8, obj, &loongarch_pch_pic_reg8_ops,
+    memory_region_init_io(&s->iomem8, OBJECT(dev), &loongarch_pch_pic_reg8_ops,
                           s, PCH_PIC_NAME(.reg8), 0x2a0);
-    memory_region_init_io(&s->iomem32_high, obj,
+    memory_region_init_io(&s->iomem32_high, OBJECT(dev),
                           &loongarch_pch_pic_reg32_high_ops,
                           s, PCH_PIC_NAME(.reg32_part2), 0xc60);
     sysbus_init_mmio(sbd, &s->iomem32_low);
     sysbus_init_mmio(sbd, &s->iomem8);
     sysbus_init_mmio(sbd, &s->iomem32_high);
-
 }
 
 static Property loongarch_pch_pic_properties[] = {
@@ -451,7 +444,6 @@ static const TypeInfo loongarch_pch_pic_info = {
     .name          = TYPE_LOONGARCH_PCH_PIC,
     .parent        = TYPE_SYS_BUS_DEVICE,
     .instance_size = sizeof(LoongArchPCHPIC),
-    .instance_init = loongarch_pch_pic_init,
     .class_init    = loongarch_pch_pic_class_init,
 };
 
-- 
2.39.3


