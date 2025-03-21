Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5568C35FFF
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 03:14:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvSow-0002Mk-FM; Thu, 20 Mar 2025 23:13:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1tvSor-0002L2-HG
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 23:13:13 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1tvSom-0005Ks-Ms
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 23:13:12 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8DxdWlB2dxnC5WfAA--.7431S3;
 Fri, 21 Mar 2025 11:13:05 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMCxLcU82dxnczRXAA--.54409S6;
 Fri, 21 Mar 2025 11:13:05 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>,
	Markus Armbruster <armbru@redhat.com>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v6 4/6] hw/loongarch/virt: Eliminate error_propagate()
Date: Fri, 21 Mar 2025 11:12:57 +0800
Message-Id: <20250321031259.2419842-5-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250321031259.2419842-1-maobibo@loongson.cn>
References: <20250321031259.2419842-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMCxLcU82dxnczRXAA--.54409S6
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

When there is an error, it is put into a local variable and then
propagated to somewhere else. Instead the error can be set right
away, error propagation can be removed.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
---
 hw/loongarch/virt.c | 32 +++++++++++---------------------
 1 file changed, 11 insertions(+), 21 deletions(-)

diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index 503362a69e..562e44e112 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -859,30 +859,29 @@ static void virt_cpu_pre_plug(HotplugHandler *hotplug_dev,
     LoongArchCPU *cpu = LOONGARCH_CPU(dev);
     CPUState *cs = CPU(dev);
     CPUArchId *cpu_slot;
-    Error *err = NULL;
     LoongArchCPUTopo topo;
     int arch_id;
 
     if (lvms->acpi_ged) {
         if ((cpu->thread_id < 0) || (cpu->thread_id >= ms->smp.threads)) {
-            error_setg(&err,
+            error_setg(errp,
                        "Invalid thread-id %u specified, must be in range 1:%u",
                        cpu->thread_id, ms->smp.threads - 1);
-            goto out;
+            return;
         }
 
         if ((cpu->core_id < 0) || (cpu->core_id >= ms->smp.cores)) {
-            error_setg(&err,
+            error_setg(errp,
                        "Invalid core-id %u specified, must be in range 1:%u",
                        cpu->core_id, ms->smp.cores - 1);
-            goto out;
+            return;
         }
 
         if ((cpu->socket_id < 0) || (cpu->socket_id >= ms->smp.sockets)) {
-            error_setg(&err,
+            error_setg(errp,
                        "Invalid socket-id %u specified, must be in range 1:%u",
                        cpu->socket_id, ms->smp.sockets - 1);
-            goto out;
+            return;
         }
 
         topo.socket_id = cpu->socket_id;
@@ -891,11 +890,11 @@ static void virt_cpu_pre_plug(HotplugHandler *hotplug_dev,
         arch_id =  virt_get_arch_id_from_topo(ms, &topo);
         cpu_slot = virt_find_cpu_slot(ms, arch_id);
         if (CPU(cpu_slot->cpu)) {
-            error_setg(&err,
+            error_setg(errp,
                        "cpu(id%d=%d:%d:%d) with arch-id %" PRIu64 " exists",
                        cs->cpu_index, cpu->socket_id, cpu->core_id,
                        cpu->thread_id, cpu_slot->arch_id);
-            goto out;
+            return;
         }
     } else {
         /* For cold-add cpu, find empty cpu slot */
@@ -911,33 +910,24 @@ static void virt_cpu_pre_plug(HotplugHandler *hotplug_dev,
     cpu->env.address_space_iocsr = &lvms->as_iocsr;
     cpu->phy_id = cpu_slot->arch_id;
     cs->cpu_index = cpu_slot - ms->possible_cpus->cpus;
-    numa_cpu_pre_plug(cpu_slot, dev, &err);
-out:
-    if (err) {
-        error_propagate(errp, err);
-    }
+    numa_cpu_pre_plug(cpu_slot, dev, errp);
 }
 
 static void virt_cpu_unplug_request(HotplugHandler *hotplug_dev,
                                     DeviceState *dev, Error **errp)
 {
     LoongArchVirtMachineState *lvms = LOONGARCH_VIRT_MACHINE(hotplug_dev);
-    Error *err = NULL;
     LoongArchCPU *cpu = LOONGARCH_CPU(dev);
     CPUState *cs = CPU(dev);
 
     if (cs->cpu_index == 0) {
-        error_setg(&err, "hot-unplug of boot cpu(id%d=%d:%d:%d) not supported",
+        error_setg(errp, "hot-unplug of boot cpu(id%d=%d:%d:%d) not supported",
                    cs->cpu_index, cpu->socket_id,
                    cpu->core_id, cpu->thread_id);
-        error_propagate(errp, err);
         return;
     }
 
-    hotplug_handler_unplug_request(HOTPLUG_HANDLER(lvms->acpi_ged), dev, &err);
-    if (err) {
-        error_propagate(errp, err);
-    }
+    hotplug_handler_unplug_request(HOTPLUG_HANDLER(lvms->acpi_ged), dev, errp);
 }
 
 static void virt_cpu_unplug(HotplugHandler *hotplug_dev,
-- 
2.39.3


