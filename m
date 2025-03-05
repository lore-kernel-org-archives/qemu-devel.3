Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59FEFC282D3
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 06:15:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpi0K-0000rJ-KL; Wed, 05 Mar 2025 01:13:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1tpi0J-0000r7-3r
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 01:13:15 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1tpi0H-0004HW-3Z
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 01:13:14 -0500
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8CxNHBt68dn0N+KAA--.40572S3;
 Wed, 05 Mar 2025 14:13:01 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMBx3MRi68dnfRQ3AA--.5679S13;
 Wed, 05 Mar 2025 14:13:00 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, Song Gao <gaosong@loongson.cn>,
 Xianglai Li <lixianglai@loongson.cn>
Subject: [PULL 11/15] hw/loongarch/virt: Implement cpu unplug interface
Date: Wed,  5 Mar 2025 14:12:46 +0800
Message-Id: <20250305061250.1908444-12-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250305061250.1908444-1-maobibo@loongson.cn>
References: <20250305061250.1908444-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMBx3MRi68dnfRQ3AA--.5679S13
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

Implement cpu unplug interfaces including virt_cpu_unplug_request()
and virt_cpu_unplug().

Co-developed-by: Xianglai Li <lixianglai@loongson.cn>
Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 hw/loongarch/virt.c | 58 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index 2b4b60f718..297f71dc00 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -816,6 +816,19 @@ static int virt_get_arch_id_from_topo(MachineState *ms, LoongArchCPUTopo *topo)
     return arch_id;
 }
 
+/* Find cpu slot in machine->possible_cpus by arch_id */
+static CPUArchId *virt_find_cpu_slot(MachineState *ms, int arch_id)
+{
+    int n;
+    for (n = 0; n < ms->possible_cpus->len; n++) {
+        if (ms->possible_cpus->cpus[n].arch_id == arch_id) {
+            return &ms->possible_cpus->cpus[n];
+        }
+    }
+
+    return NULL;
+}
+
 static void virt_cpu_pre_plug(HotplugHandler *hotplug_dev,
                               DeviceState *dev, Error **errp)
 {
@@ -824,11 +837,56 @@ static void virt_cpu_pre_plug(HotplugHandler *hotplug_dev,
 static void virt_cpu_unplug_request(HotplugHandler *hotplug_dev,
                                     DeviceState *dev, Error **errp)
 {
+    LoongArchVirtMachineState *lvms = LOONGARCH_VIRT_MACHINE(hotplug_dev);
+    Error *err = NULL;
+    LoongArchCPU *cpu = LOONGARCH_CPU(dev);
+    CPUState *cs = CPU(dev);
+
+    if (cs->cpu_index == 0) {
+        error_setg(&err, "hot-unplug of boot cpu(id%d=%d:%d:%d) not supported",
+                   cs->cpu_index, cpu->socket_id,
+                   cpu->core_id, cpu->thread_id);
+        error_propagate(errp, err);
+        return;
+    }
+
+    hotplug_handler_unplug_request(HOTPLUG_HANDLER(lvms->acpi_ged), dev, &err);
+    if (err) {
+        error_propagate(errp, err);
+    }
 }
 
 static void virt_cpu_unplug(HotplugHandler *hotplug_dev,
                             DeviceState *dev, Error **errp)
 {
+    CPUArchId *cpu_slot;
+    Error *err = NULL;
+    LoongArchCPU *cpu = LOONGARCH_CPU(dev);
+    LoongArchVirtMachineState *lvms = LOONGARCH_VIRT_MACHINE(hotplug_dev);
+
+    /* Notify ipi and extioi irqchip to remove interrupt routing to CPU */
+    hotplug_handler_unplug(HOTPLUG_HANDLER(lvms->ipi), dev, &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+
+    hotplug_handler_unplug(HOTPLUG_HANDLER(lvms->extioi), dev, &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+
+    /* Notify acpi ged CPU removed */
+    hotplug_handler_unplug(HOTPLUG_HANDLER(lvms->acpi_ged), dev, &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+
+    cpu_slot = virt_find_cpu_slot(MACHINE(lvms), cpu->phy_id);
+    cpu_slot->cpu = NULL;
+    return;
 }
 
 static void virt_cpu_plug(HotplugHandler *hotplug_dev,
-- 
2.43.5


