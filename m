Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B176FE7718F
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Dec 2024 01:35:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tS4ff-0004UW-Ab; Sun, 29 Dec 2024 20:34:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1tS4fd-0004Tf-96
 for qemu-devel@nongnu.org; Sun, 29 Dec 2024 20:34:13 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1tS4fa-0003dZ-IC
 for qemu-devel@nongnu.org; Sun, 29 Dec 2024 20:34:13 -0500
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8AxUa+L+HFnAqBbAA--.49799S3;
 Mon, 30 Dec 2024 09:34:03 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMAxfcWJ+HFnrEUNAA--.2779S5;
 Mon, 30 Dec 2024 09:34:03 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>,
	Huacai Chen <chenhuacai@kernel.org>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, Igor Mammedov <imammedo@redhat.com>,
 qemu-devel@nongnu.org
Subject: [PATCH v2 3/5] hw/intc/loongarch_ipi: Add cpu map table from physical
 cpu id
Date: Mon, 30 Dec 2024 09:33:59 +0800
Message-Id: <20241230013401.1564827-4-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20241230013401.1564827-1-maobibo@loongson.cn>
References: <20241230013401.1564827-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMAxfcWJ+HFnrEUNAA--.2779S5
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

Bitmap table present_cpu_map is added, it is to allocate logical cpu
when CPU object is created. Also present_cpu array is added to get
logical cpu from physical cpu id.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 hw/intc/loongarch_ipi.c         | 24 ++++++++++++++++++++++++
 include/hw/intc/loongarch_ipi.h | 10 ++++++++++
 include/hw/loongarch/virt.h     |  9 +++++++++
 3 files changed, 43 insertions(+)

diff --git a/hw/intc/loongarch_ipi.c b/hw/intc/loongarch_ipi.c
index 7ea65bcef3..80ea006e96 100644
--- a/hw/intc/loongarch_ipi.c
+++ b/hw/intc/loongarch_ipi.c
@@ -8,6 +8,7 @@
 #include "qemu/osdep.h"
 #include "hw/boards.h"
 #include "qemu/error-report.h"
+#include "qapi/error.h"
 #include "hw/intc/loongarch_ipi.h"
 #include "target/loongarch/cpu.h"
 
@@ -85,11 +86,33 @@ static void loongarch_cpu_unplug(HotplugHandler *hotplug_dev,
     }
 }
 
+static void loongarch_ipi_realize(DeviceState *dev, Error **errp)
+{
+    LoongarchIPIState *lis = LOONGARCH_IPI(dev);
+    LoongarchIPIClass *lic = LOONGARCH_IPI_GET_CLASS(dev);
+    Error *local_err = NULL;
+    int i;
+
+    lic->parent_realize(dev, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
+    for (i = 0; i < MAX_PHY_ID; i++) {
+        lis->devs[i].index = INVALID_CPU;
+    }
+}
+
 static void loongarch_ipi_class_init(ObjectClass *klass, void *data)
 {
+    DeviceClass *dc = DEVICE_CLASS(klass);
     LoongsonIPICommonClass *licc = LOONGSON_IPI_COMMON_CLASS(klass);
+    LoongarchIPIClass *lic = LOONGARCH_IPI_CLASS(klass);
     HotplugHandlerClass *hc = HOTPLUG_HANDLER_CLASS(klass);
 
+    device_class_set_parent_realize(dc, loongarch_ipi_realize,
+                                    &lic->parent_realize);
     licc->get_iocsr_as = get_iocsr_as;
     licc->cpu_by_arch_id = loongarch_cpu_by_arch_id;
     hc->plug = loongarch_cpu_plug;
@@ -100,6 +123,7 @@ static const TypeInfo loongarch_ipi_types[] = {
     {
         .name               = TYPE_LOONGARCH_IPI,
         .parent             = TYPE_LOONGSON_IPI_COMMON,
+        .instance_size      = sizeof(LoongarchIPIState),
         .class_init         = loongarch_ipi_class_init,
         .interfaces         = (InterfaceInfo[]) {
             { TYPE_HOTPLUG_HANDLER },
diff --git a/include/hw/intc/loongarch_ipi.h b/include/hw/intc/loongarch_ipi.h
index 276b3040a3..4bae6e0abe 100644
--- a/include/hw/intc/loongarch_ipi.h
+++ b/include/hw/intc/loongarch_ipi.h
@@ -10,16 +10,26 @@
 
 #include "qom/object.h"
 #include "hw/intc/loongson_ipi_common.h"
+#include "hw/loongarch/virt.h"
 
+#define INVALID_CPU         -1
 #define TYPE_LOONGARCH_IPI  "loongarch_ipi"
 OBJECT_DECLARE_TYPE(LoongarchIPIState, LoongarchIPIClass, LOONGARCH_IPI)
 
+typedef struct IPICPUState {
+    CPUState *cs;
+    int index;
+} IPICPUState;
+
 struct LoongarchIPIState {
     LoongsonIPICommonState parent_obj;
+    DECLARE_BITMAP(present_map, LOONGARCH_MAX_CPUS);
+    IPICPUState devs[MAX_PHY_ID];
 };
 
 struct LoongarchIPIClass {
     LoongsonIPICommonClass parent_class;
+    DeviceRealize parent_realize;
 };
 
 #endif
diff --git a/include/hw/loongarch/virt.h b/include/hw/loongarch/virt.h
index 9ba47793ef..7754c85f0b 100644
--- a/include/hw/loongarch/virt.h
+++ b/include/hw/loongarch/virt.h
@@ -14,6 +14,15 @@
 #include "hw/loongarch/boot.h"
 
 #define LOONGARCH_MAX_CPUS      256
+/*
+ * LoongArch Reference Manual Vol1, Chapter 7.4.12 CPU Identity
+ *  For CPU architecture, bit0 .. bit8 is valid for CPU id, max cpuid is 512
+ *  However for IPI/Eiointc interrupt controller, max supported cpu id for
+ *  irq routing is 256
+ *
+ *  Here max cpu id is 256 for virt machine
+ */
+#define MAX_PHY_ID              0x100
 
 #define VIRT_FWCFG_BASE         0x1e020000UL
 #define VIRT_BIOS_BASE          0x1c000000UL
-- 
2.39.3


