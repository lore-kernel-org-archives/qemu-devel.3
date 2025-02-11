Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03E59C0219E
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 06:54:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thkA0-0007tq-RL; Tue, 11 Feb 2025 01:54:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1thk9r-0007sO-Br
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 01:54:12 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1thk9m-0001nh-J7
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 01:54:10 -0500
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8AxaeEJ9KpnrfpxAA--.23445S3;
 Tue, 11 Feb 2025 14:54:01 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMCxPscJ9KpnPqELAA--.46044S2;
 Tue, 11 Feb 2025 14:54:01 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Xianglai Li <lixianglai@loongson.cn>, qemu-devel@nongnu.org
Subject: [PATCH v5 7/7] hw/loongarch/virt: Enable cpu hotplug feature on virt
 machine
Date: Tue, 11 Feb 2025 14:53:58 +0800
Message-Id: <20250211065358.3277168-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250211030834.3276732-1-maobibo@loongson.cn>
References: <20250211030834.3276732-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMCxPscJ9KpnPqELAA--.46044S2
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

On virt machine, enable CPU hotplug feature has_hotpluggable_cpus. For
hot-added CPUs, there is socket-id/core-id/thread-id property set,
arch_id can be caculated from these properties. So that cpu slot can be
searched from its arch_id.

Co-developed-by: Xianglai Li <lixianglai@loongson.cn>
Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 hw/loongarch/virt.c | 44 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 42 insertions(+), 2 deletions(-)

diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index 5619ce3c44..661c8a5446 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -869,10 +869,42 @@ static void virt_cpu_pre_plug(HotplugHandler *hotplug_dev,
     CPUArchId *cpu_slot;
     Error *err = NULL;
     LoongArchCPUTopo topo;
+    int arch_id;
 
     if (lvms->acpi_ged) {
-        error_setg(&err, "CPU hotplug not supported");
-        goto out;
+        if ((cpu->thread_id < 0) || (cpu->thread_id >= ms->smp.threads)) {
+            error_setg(&err,
+                       "Invalid thread-id %u specified, must be in range 1:%u",
+                       cpu->thread_id, ms->smp.threads - 1);
+            goto out;
+        }
+
+        if ((cpu->core_id < 0) || (cpu->core_id >= ms->smp.cores)) {
+            error_setg(&err,
+                       "Invalid core-id %u specified, must be in range 1:%u",
+                       cpu->core_id, ms->smp.cores - 1);
+            goto out;
+        }
+
+        if ((cpu->socket_id < 0) || (cpu->socket_id >= ms->smp.sockets)) {
+            error_setg(&err,
+                       "Invalid socket-id %u specified, must be in range 1:%u",
+                       cpu->socket_id, ms->smp.sockets - 1);
+            goto out;
+        }
+
+        topo.socket_id = cpu->socket_id;
+        topo.core_id = cpu->core_id;
+        topo.thread_id = cpu->thread_id;
+        arch_id =  virt_get_arch_id_from_topo(ms, &topo);
+        cpu_slot = virt_find_cpu_slot(ms, arch_id);
+        if (CPU(cpu_slot->cpu)) {
+            error_setg(&err,
+                       "cpu(id%d=%d:%d:%d) with arch-id %" PRIu64 " exists",
+                       cs->cpu_index, cpu->socket_id, cpu->core_id,
+                       cpu->thread_id, cpu_slot->arch_id);
+            goto out;
+        }
     } else {
         /* For cold-add cpu, find empty cpu slot */
         cpu_slot = virt_find_empty_cpu_slot(ms);
@@ -975,6 +1007,13 @@ static void virt_cpu_plug(HotplugHandler *hotplug_dev,
         }
     }
 
+    if (lvms->acpi_ged) {
+        hotplug_handler_plug(HOTPLUG_HANDLER(lvms->acpi_ged), dev, &err);
+        if (err) {
+            error_propagate(errp, err);
+        }
+    }
+
     return;
 }
 
@@ -1157,6 +1196,7 @@ static void virt_class_init(ObjectClass *oc, void *data)
     mc->numa_mem_supported = true;
     mc->auto_enable_numa_with_memhp = true;
     mc->auto_enable_numa_with_memdev = true;
+    mc->has_hotpluggable_cpus = true;
     mc->get_hotplug_handler = virt_get_hotplug_handler;
     mc->default_nic = "virtio-net-pci";
     hc->plug = virt_device_plug_cb;
-- 
2.39.3


