Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06C46C3ABBC
	for <qemu-devel@archiver.kernel.org>; Fri,  9 May 2025 10:10:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDKgA-0004fO-1w; Fri, 09 May 2025 06:10:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1uDKfx-0004Tn-7f
 for qemu-devel@nongnu.org; Fri, 09 May 2025 06:09:55 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1uDKfu-0001Ia-N1
 for qemu-devel@nongnu.org; Fri, 09 May 2025 06:09:52 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8CxvnL70x1oEmPbAA--.32546S3;
 Fri, 09 May 2025 18:07:55 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMDxPcX00x1oMCfAAA--.29037S12;
 Fri, 09 May 2025 18:07:54 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, Huacai Chen <chenhuacai@kernel.org>,
 qemu-devel@nongnu.org, Xianglai Li <lixianglai@loongson.cn>
Subject: [PATCH 10/15] hw/intc/loongarch_pch: Add irqchip-in-kernel property
Date: Fri,  9 May 2025 18:07:42 +0800
Message-Id: <20250509100747.1070094-11-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250509100747.1070094-1-maobibo@loongson.cn>
References: <20250509100747.1070094-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMDxPcX00x1oMCfAAA--.29037S12
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

With PCH PCI irqchip, property irqchip-in-kernel is added to indicate
whether feature irqchip_in_kernel is supported or not. This property can
be enabled only if it works in KVM mode.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 hw/intc/loongarch_pch_pic.c         | 14 ++++++++++++++
 include/hw/intc/loongarch_pch_pic.h |  1 +
 2 files changed, 15 insertions(+)

diff --git a/hw/intc/loongarch_pch_pic.c b/hw/intc/loongarch_pch_pic.c
index cbba2fc284..3729ab9700 100644
--- a/hw/intc/loongarch_pch_pic.c
+++ b/hw/intc/loongarch_pch_pic.c
@@ -10,6 +10,8 @@
 #include "qemu/log.h"
 #include "hw/irq.h"
 #include "hw/intc/loongarch_pch_pic.h"
+#include "hw/qdev-properties.h"
+#include "system/kvm.h"
 #include "trace.h"
 #include "qapi/error.h"
 
@@ -264,6 +266,7 @@ static void loongarch_pic_realize(DeviceState *dev, Error **errp)
 {
     LoongArchPICCommonState *s = LOONGARCH_PIC_COMMON(dev);
     LoongarchPICClass *lpc = LOONGARCH_PIC_GET_CLASS(dev);
+    LoongarchPICState *lps = LOONGARCH_PIC(dev);
     SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
     Error *local_err = NULL;
 
@@ -273,6 +276,11 @@ static void loongarch_pic_realize(DeviceState *dev, Error **errp)
         return;
     }
 
+    if (lps->irqchip_in_kernel && !kvm_enabled()) {
+        error_setg(errp, "PCH_PCI irqchip_in_kernel works only in kvm mode");
+        return;
+    }
+
     qdev_init_gpio_out(dev, s->parent_irq, s->irq_num);
     qdev_init_gpio_in(dev, pch_pic_irq_handler, s->irq_num);
     memory_region_init_io(&s->iomem, OBJECT(dev),
@@ -281,6 +289,11 @@ static void loongarch_pic_realize(DeviceState *dev, Error **errp)
     sysbus_init_mmio(sbd, &s->iomem);
 }
 
+static const Property loongarch_pic_properties[] = {
+    DEFINE_PROP_BOOL("irqchip-in-kernel", LoongarchPICState,
+                     irqchip_in_kernel, false),
+};
+
 static void loongarch_pic_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -291,6 +304,7 @@ static void loongarch_pic_class_init(ObjectClass *klass, const void *data)
                                        NULL, &lpc->parent_phases);
     device_class_set_parent_realize(dc, loongarch_pic_realize,
                                     &lpc->parent_realize);
+    device_class_set_props(dc, loongarch_pic_properties);
 }
 
 static const TypeInfo loongarch_pic_types[] = {
diff --git a/include/hw/intc/loongarch_pch_pic.h b/include/hw/intc/loongarch_pch_pic.h
index 839a59a43b..40fe550c0b 100644
--- a/include/hw/intc/loongarch_pch_pic.h
+++ b/include/hw/intc/loongarch_pch_pic.h
@@ -16,6 +16,7 @@ OBJECT_DECLARE_TYPE(LoongarchPICState, LoongarchPICClass, LOONGARCH_PIC)
 
 struct LoongarchPICState {
     LoongArchPICCommonState parent_obj;
+    bool irqchip_in_kernel;
 };
 
 struct LoongarchPICClass {
-- 
2.39.3


