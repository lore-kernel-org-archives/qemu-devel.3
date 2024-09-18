Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03EAEEE6426
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2024 06:56:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqoaN-0003UW-5O; Wed, 18 Sep 2024 02:54:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1sqoaE-0002zO-FM
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 02:54:39 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1sqoa9-0005Ou-MR
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 02:54:36 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8Cxyukneepmwn4KAA--.23726S3;
 Wed, 18 Sep 2024 14:54:31 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMAxSeYieepmKlQJAA--.53115S10;
 Wed, 18 Sep 2024 14:54:31 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v2 8/8] hw/intc/loongarch_pch: Code cleanup about
 loongarch_pch_pic
Date: Wed, 18 Sep 2024 14:54:26 +0800
Message-Id: <20240918065426.2341823-9-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240918065426.2341823-1-maobibo@loongson.cn>
References: <20240918065426.2341823-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMAxSeYieepmKlQJAA--.53115S10
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

Remove definition about LoongArchPCHPIC and LOONGARCH_PCH_PIC, and
replace them with LoongArchPICCommonState and LOONGARCH_PIC_COMMON
separately. Also remove unnecessary header files.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 hw/intc/loongarch_pch_pic.c         | 24 ++++++++++--------------
 hw/loongarch/virt.c                 |  2 +-
 include/hw/intc/loongarch_pch_pic.h |  4 ----
 3 files changed, 11 insertions(+), 19 deletions(-)

diff --git a/hw/intc/loongarch_pch_pic.c b/hw/intc/loongarch_pch_pic.c
index 11effd4cc9..acd75ccb0c 100644
--- a/hw/intc/loongarch_pch_pic.c
+++ b/hw/intc/loongarch_pch_pic.c
@@ -7,17 +7,13 @@
 
 #include "qemu/osdep.h"
 #include "qemu/bitops.h"
-#include "hw/sysbus.h"
-#include "hw/loongarch/virt.h"
-#include "hw/pci-host/ls7a.h"
 #include "hw/irq.h"
 #include "hw/intc/loongarch_pch_pic.h"
-#include "hw/qdev-properties.h"
-#include "migration/vmstate.h"
 #include "trace.h"
 #include "qapi/error.h"
 
-static void pch_pic_update_irq(LoongArchPCHPIC *s, uint64_t mask, int level)
+static void pch_pic_update_irq(LoongArchPICCommonState *s, uint64_t mask,
+                               int level)
 {
     uint64_t val;
     int irq;
@@ -45,7 +41,7 @@ static void pch_pic_update_irq(LoongArchPCHPIC *s, uint64_t mask, int level)
 
 static void pch_pic_irq_handler(void *opaque, int irq, int level)
 {
-    LoongArchPCHPIC *s = LOONGARCH_PCH_PIC(opaque);
+    LoongArchPICCommonState *s = LOONGARCH_PIC_COMMON(opaque);
     uint64_t mask = 1ULL << irq;
 
     assert(irq < s->irq_num);
@@ -78,7 +74,7 @@ static void pch_pic_irq_handler(void *opaque, int irq, int level)
 static uint64_t loongarch_pch_pic_low_readw(void *opaque, hwaddr addr,
                                             unsigned size)
 {
-    LoongArchPCHPIC *s = LOONGARCH_PCH_PIC(opaque);
+    LoongArchPICCommonState *s = LOONGARCH_PIC_COMMON(opaque);
     uint64_t val = 0;
     uint32_t offset = addr & 0xfff;
 
@@ -136,7 +132,7 @@ static uint64_t get_writew_val(uint64_t value, uint32_t target, bool hi)
 static void loongarch_pch_pic_low_writew(void *opaque, hwaddr addr,
                                          uint64_t value, unsigned size)
 {
-    LoongArchPCHPIC *s = LOONGARCH_PCH_PIC(opaque);
+    LoongArchPICCommonState *s = LOONGARCH_PIC_COMMON(opaque);
     uint32_t offset, old_valid, data = (uint32_t)value;
     uint64_t old, int_mask;
     offset = addr & 0xfff;
@@ -208,7 +204,7 @@ static void loongarch_pch_pic_low_writew(void *opaque, hwaddr addr,
 static uint64_t loongarch_pch_pic_high_readw(void *opaque, hwaddr addr,
                                         unsigned size)
 {
-    LoongArchPCHPIC *s = LOONGARCH_PCH_PIC(opaque);
+    LoongArchPICCommonState *s = LOONGARCH_PIC_COMMON(opaque);
     uint64_t val = 0;
     uint32_t offset = addr & 0xfff;
 
@@ -236,7 +232,7 @@ static uint64_t loongarch_pch_pic_high_readw(void *opaque, hwaddr addr,
 static void loongarch_pch_pic_high_writew(void *opaque, hwaddr addr,
                                      uint64_t value, unsigned size)
 {
-    LoongArchPCHPIC *s = LOONGARCH_PCH_PIC(opaque);
+    LoongArchPICCommonState *s = LOONGARCH_PIC_COMMON(opaque);
     uint32_t offset, data = (uint32_t)value;
     offset = addr & 0xfff;
 
@@ -263,7 +259,7 @@ static void loongarch_pch_pic_high_writew(void *opaque, hwaddr addr,
 static uint64_t loongarch_pch_pic_readb(void *opaque, hwaddr addr,
                                         unsigned size)
 {
-    LoongArchPCHPIC *s = LOONGARCH_PCH_PIC(opaque);
+    LoongArchPICCommonState *s = LOONGARCH_PIC_COMMON(opaque);
     uint64_t val = 0;
     uint32_t offset = (addr & 0xfff) + PCH_PIC_ROUTE_ENTRY_OFFSET;
     int64_t offset_tmp;
@@ -292,7 +288,7 @@ static uint64_t loongarch_pch_pic_readb(void *opaque, hwaddr addr,
 static void loongarch_pch_pic_writeb(void *opaque, hwaddr addr,
                                      uint64_t data, unsigned size)
 {
-    LoongArchPCHPIC *s = LOONGARCH_PCH_PIC(opaque);
+    LoongArchPICCommonState *s = LOONGARCH_PIC_COMMON(opaque);
     int32_t offset_tmp;
     uint32_t offset = (addr & 0xfff) + PCH_PIC_ROUTE_ENTRY_OFFSET;
 
@@ -360,7 +356,7 @@ static const MemoryRegionOps loongarch_pch_pic_reg8_ops = {
 
 static void loongarch_pch_pic_reset(DeviceState *d)
 {
-    LoongArchPCHPIC *s = LOONGARCH_PCH_PIC(d);
+    LoongArchPICCommonState *s = LOONGARCH_PIC_COMMON(d);
     int i;
 
     s->int_mask = -1;
diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index 81b1f9486f..4471a9eb05 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -855,7 +855,7 @@ static void virt_irq_init(LoongArchVirtMachineState *lvms)
     /* Add Extend I/O Interrupt Controller node */
     fdt_add_eiointc_node(lvms, &cpuintc_phandle, &eiointc_phandle);
 
-    pch_pic = qdev_new(TYPE_LOONGARCH_PCH_PIC);
+    pch_pic = qdev_new(TYPE_LOONGARCH_PIC);
     num = VIRT_PCH_PIC_IRQ_NUM;
     qdev_prop_set_uint32(pch_pic, "pch_pic_irq_num", num);
     d = SYS_BUS_DEVICE(pch_pic);
diff --git a/include/hw/intc/loongarch_pch_pic.h b/include/hw/intc/loongarch_pch_pic.h
index f84be0ac62..481cc58aed 100644
--- a/include/hw/intc/loongarch_pch_pic.h
+++ b/include/hw/intc/loongarch_pch_pic.h
@@ -24,8 +24,4 @@ struct LoongarchPICClass {
     DeviceRealize parent_realize;
 };
 
-#define TYPE_LOONGARCH_PCH_PIC TYPE_LOONGARCH_PIC
-typedef struct LoongArchPICCommonState LoongArchPCHPIC;
-#define LOONGARCH_PCH_PIC(obj)   ((struct LoongArchPICCommonState *)(obj))
-
 #endif /* HW_LOONGARCH_PCH_PIC_H */
-- 
2.39.3


