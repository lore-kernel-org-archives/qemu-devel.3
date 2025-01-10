Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 262A9E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 09:05:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWAxG-00029g-If; Fri, 10 Jan 2025 04:05:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1tWAwm-0001fX-VF
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 04:04:58 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1tWAwi-0005O0-Dt
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 04:04:52 -0500
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8BxeeCn4oBn2A9hAA--.59151S3;
 Fri, 10 Jan 2025 17:04:39 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMDx7sWk4oBn718cAA--.42742S5;
 Fri, 10 Jan 2025 17:04:38 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH 3/4] hw/intc/loongarch_extioi: Implment cpu hotplug interface
Date: Fri, 10 Jan 2025 17:04:35 +0800
Message-Id: <20250110090436.2831690-4-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250110090436.2831690-1-maobibo@loongson.cn>
References: <20250110090436.2831690-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMDx7sWk4oBn718cAA--.42742S5
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
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

When cpu is added, connect extioi gpio irq to CPU irq pin.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 hw/intc/loongarch_extioi_common.c | 45 +++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/hw/intc/loongarch_extioi_common.c b/hw/intc/loongarch_extioi_common.c
index 19e19a9f73..ff3974f2a1 100644
--- a/hw/intc/loongarch_extioi_common.c
+++ b/hw/intc/loongarch_extioi_common.c
@@ -12,28 +12,73 @@
 #include "migration/vmstate.h"
 #include "target/loongarch/cpu.h"
 
+static ExtIOICore *loongarch_extioi_get_cpu(LoongArchExtIOICommonState *s,
+                                            DeviceState *dev)
+{
+    CPUClass *k = CPU_GET_CLASS(dev);
+    uint64_t arch_id = k->get_arch_id(CPU(dev));
+    int i;
+
+    for (i = 0; i < s->num_cpu; i++) {
+        if (s->cpu[i].arch_id == arch_id) {
+            return &s->cpu[i];
+        }
+    }
+
+    return NULL;
+}
+
 static void loongarch_extioi_cpu_plug(HotplugHandler *hotplug_dev,
                                       DeviceState *dev, Error **errp)
 {
+    LoongArchExtIOICommonState *s = LOONGARCH_EXTIOI_COMMON(hotplug_dev);
     Object *obj = OBJECT(dev);
+    ExtIOICore *core;
+    int pin, index;
 
     if (!object_dynamic_cast(obj, TYPE_LOONGARCH_CPU)) {
         warn_report("LoongArch extioi: Invalid %s device type",
                                        object_get_typename(obj));
         return;
     }
+
+    core = loongarch_extioi_get_cpu(s, dev);
+    if (!core) {
+        return;
+    }
+
+    core->cpu = CPU(dev);
+    index = core - s->cpu;
+
+    /*
+     * connect extioi irq to the cpu irq
+     * cpu_pin[LS3A_INTC_IP + 2 : 2] <= intc_pin[LS3A_INTC_IP : 0]
+     */
+    for (pin = 0; pin < LS3A_INTC_IP; pin++) {
+        qdev_connect_gpio_out(DEVICE(s), index * LS3A_INTC_IP + pin,
+                              qdev_get_gpio_in(dev, pin + 2));
+    }
 }
 
 static void loongarch_extioi_cpu_unplug(HotplugHandler *hotplug_dev,
                                         DeviceState *dev, Error **errp)
 {
+    LoongArchExtIOICommonState *s = LOONGARCH_EXTIOI_COMMON(hotplug_dev);
     Object *obj = OBJECT(dev);
+    ExtIOICore *core;
 
     if (!object_dynamic_cast(obj, TYPE_LOONGARCH_CPU)) {
         warn_report("LoongArch extioi: Invalid %s device type",
                                        object_get_typename(obj));
         return;
     }
+
+    core = loongarch_extioi_get_cpu(s, dev);
+    if (!core) {
+        return;
+    }
+
+    core->cpu = NULL;
 }
 
 static void loongarch_extioi_common_realize(DeviceState *dev, Error **errp)
-- 
2.39.3


