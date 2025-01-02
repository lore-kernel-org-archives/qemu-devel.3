Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15613E77194
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 07:55:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTG25-0005pN-GH; Thu, 02 Jan 2025 02:54:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1tTG24-0005p2-Ak
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 02:54:16 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1tTG22-0000Yh-8m
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 02:54:16 -0500
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8DxmeAXRnZnyy5dAA--.52635S3;
 Thu, 02 Jan 2025 15:53:59 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMDx_8cVRnZn0i8RAA--.16082S4;
 Thu, 02 Jan 2025 15:53:58 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH 2/3] hw/intc/loongarch_extioi: Remove num-cpu property
Date: Thu,  2 Jan 2025 15:53:56 +0800
Message-Id: <20250102075357.2541410-3-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250102075357.2541410-1-maobibo@loongson.cn>
References: <20250102075357.2541410-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMDx_8cVRnZn0i8RAA--.16082S4
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

Since cpu number can be acquired from possible_cpu_arch_ids(),
num-cpu property is not necessary. Here remove num-cpu property
for object TYPE_LOONGARCH_EXTIOI_COMMON object.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 hw/intc/loongarch_extioi.c        |  8 --------
 hw/intc/loongarch_extioi_common.c | 14 --------------
 hw/loongarch/virt.c               |  1 -
 3 files changed, 23 deletions(-)

diff --git a/hw/intc/loongarch_extioi.c b/hw/intc/loongarch_extioi.c
index 2ce2f83196..ec7a72a686 100644
--- a/hw/intc/loongarch_extioi.c
+++ b/hw/intc/loongarch_extioi.c
@@ -318,20 +318,12 @@ static const MemoryRegionOps extioi_virt_ops = {
 static void loongarch_extioi_realize(DeviceState *dev, Error **errp)
 {
     LoongArchExtIOICommonState *s = LOONGARCH_EXTIOI_COMMON(dev);
-    LoongArchExtIOIClass *lec = LOONGARCH_EXTIOI_GET_CLASS(dev);
     SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
     MachineState *machine = MACHINE(qdev_get_machine());
     MachineClass *mc = MACHINE_GET_CLASS(machine);
     const CPUArchIdList *id_list;
-    Error *local_err = NULL;
     int i, pin;
 
-    lec->parent_realize(dev, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
-        return;
-    }
-
     for (i = 0; i < EXTIOI_IRQS; i++) {
         sysbus_init_irq(sbd, &s->irq[i]);
     }
diff --git a/hw/intc/loongarch_extioi_common.c b/hw/intc/loongarch_extioi_common.c
index e4c1cc3c98..7bb2c740ac 100644
--- a/hw/intc/loongarch_extioi_common.c
+++ b/hw/intc/loongarch_extioi_common.c
@@ -10,16 +10,6 @@
 #include "hw/intc/loongarch_extioi_common.h"
 #include "migration/vmstate.h"
 
-static void loongarch_extioi_common_realize(DeviceState *dev, Error **errp)
-{
-    LoongArchExtIOICommonState *s = (LoongArchExtIOICommonState *)dev;
-
-    if (s->num_cpu == 0) {
-        error_setg(errp, "num-cpu must be at least 1");
-        return;
-    }
-}
-
 static int loongarch_extioi_common_pre_save(void *opaque)
 {
     LoongArchExtIOICommonState *s = (LoongArchExtIOICommonState *)opaque;
@@ -82,7 +72,6 @@ static const VMStateDescription vmstate_loongarch_extioi = {
 };
 
 static const Property extioi_properties[] = {
-    DEFINE_PROP_UINT32("num-cpu", LoongArchExtIOICommonState, num_cpu, 1),
     DEFINE_PROP_BIT("has-virtualization-extension", LoongArchExtIOICommonState,
                     features, EXTIOI_HAS_VIRT_EXTENSION, 0),
 };
@@ -90,10 +79,7 @@ static const Property extioi_properties[] = {
 static void loongarch_extioi_common_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
-    LoongArchExtIOICommonClass *lecc = LOONGARCH_EXTIOI_COMMON_CLASS(klass);
 
-    device_class_set_parent_realize(dc, loongarch_extioi_common_realize,
-                                    &lecc->parent_realize);
     device_class_set_props(dc, extioi_properties);
     dc->vmsd = &vmstate_loongarch_extioi;
 }
diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index 99594a13a0..038910fa44 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -921,7 +921,6 @@ static void virt_irq_init(LoongArchVirtMachineState *lvms)
 
     /* Create EXTIOI device */
     extioi = qdev_new(TYPE_LOONGARCH_EXTIOI);
-    qdev_prop_set_uint32(extioi, "num-cpu", ms->smp.cpus);
     if (virt_is_veiointc_enabled(lvms)) {
         qdev_prop_set_bit(extioi, "has-virtualization-extension", true);
     }
-- 
2.39.3


