Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C9EBC3ABC9
	for <qemu-devel@archiver.kernel.org>; Fri,  9 May 2025 10:08:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDKeG-0006Ja-BY; Fri, 09 May 2025 06:08:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1uDKeA-0006BW-4u
 for qemu-devel@nongnu.org; Fri, 09 May 2025 06:08:02 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1uDKe5-00018g-8S
 for qemu-devel@nongnu.org; Fri, 09 May 2025 06:08:01 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8CxdXD30x1o+WLbAA--.32940S3;
 Fri, 09 May 2025 18:07:51 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMDxPcX00x1oMCfAAA--.29037S6;
 Fri, 09 May 2025 18:07:50 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, Huacai Chen <chenhuacai@kernel.org>,
 qemu-devel@nongnu.org, Xianglai Li <lixianglai@loongson.cn>
Subject: [PATCH 04/15] hw/intc/loongarch_ipi: Add irqchip-in-kernel property
Date: Fri,  9 May 2025 18:07:36 +0800
Message-Id: <20250509100747.1070094-5-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250509100747.1070094-1-maobibo@loongson.cn>
References: <20250509100747.1070094-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMDxPcX00x1oMCfAAA--.29037S6
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

With IPI irqchip, property irqchip-in-kernel is added to indicate whether
feature irqchip_in_kernel is supported or not. This property can be
enabled only if it works in KVM mode.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 hw/intc/loongarch_ipi.c         | 13 +++++++++++++
 include/hw/intc/loongarch_ipi.h |  1 +
 2 files changed, 14 insertions(+)

diff --git a/hw/intc/loongarch_ipi.c b/hw/intc/loongarch_ipi.c
index 74372a2039..64e0250958 100644
--- a/hw/intc/loongarch_ipi.c
+++ b/hw/intc/loongarch_ipi.c
@@ -11,6 +11,7 @@
 #include "qapi/error.h"
 #include "hw/intc/loongarch_ipi.h"
 #include "hw/qdev-properties.h"
+#include "system/kvm.h"
 #include "target/loongarch/cpu.h"
 
 static AddressSpace *get_iocsr_as(CPUState *cpu)
@@ -69,6 +70,7 @@ static void loongarch_ipi_realize(DeviceState *dev, Error **errp)
 {
     LoongsonIPICommonState *lics = LOONGSON_IPI_COMMON(dev);
     LoongarchIPIClass *lic = LOONGARCH_IPI_GET_CLASS(dev);
+    LoongarchIPIState *lis = LOONGARCH_IPI(dev);
     MachineState *machine = MACHINE(qdev_get_machine());
     MachineClass *mc = MACHINE_GET_CLASS(machine);
     const CPUArchIdList *id_list;
@@ -81,6 +83,11 @@ static void loongarch_ipi_realize(DeviceState *dev, Error **errp)
         return;
     }
 
+    if (lis->irqchip_in_kernel && !kvm_enabled()) {
+        error_setg(errp, "IPI irqchip_in_kernel works only in kvm mode");
+        return;
+    }
+
     assert(mc->possible_cpu_arch_ids);
     id_list = mc->possible_cpu_arch_ids(machine);
     lics->num_cpu = id_list->len;
@@ -166,6 +173,11 @@ static void loongarch_ipi_cpu_unplug(HotplugHandler *hotplug_dev,
     core->cpu = NULL;
 }
 
+static const Property loongarch_ipi_properties[] = {
+    DEFINE_PROP_BOOL("irqchip-in-kernel", LoongarchIPIState,
+                     irqchip_in_kernel, false),
+};
+
 static void loongarch_ipi_class_init(ObjectClass *klass, const void *data)
 {
     LoongsonIPICommonClass *licc = LOONGSON_IPI_COMMON_CLASS(klass);
@@ -178,6 +190,7 @@ static void loongarch_ipi_class_init(ObjectClass *klass, const void *data)
                                     &lic->parent_realize);
     resettable_class_set_parent_phases(rc, NULL, loongarch_ipi_reset_hold,
                                        NULL, &lic->parent_phases);
+    device_class_set_props(dc, loongarch_ipi_properties);
     licc->get_iocsr_as = get_iocsr_as;
     licc->cpu_by_arch_id = loongarch_cpu_by_arch_id;
     hc->plug = loongarch_ipi_cpu_plug;
diff --git a/include/hw/intc/loongarch_ipi.h b/include/hw/intc/loongarch_ipi.h
index a7c6bf85d3..d4eebd9a4d 100644
--- a/include/hw/intc/loongarch_ipi.h
+++ b/include/hw/intc/loongarch_ipi.h
@@ -16,6 +16,7 @@ OBJECT_DECLARE_TYPE(LoongarchIPIState, LoongarchIPIClass, LOONGARCH_IPI)
 
 struct LoongarchIPIState {
     LoongsonIPICommonState parent_obj;
+    bool irqchip_in_kernel;
 };
 
 struct LoongarchIPIClass {
-- 
2.39.3


