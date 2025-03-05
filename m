Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BB38C282E5
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 06:14:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpi0B-0000pU-L7; Wed, 05 Mar 2025 01:13:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1tpi08-0000nu-E7
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 01:13:04 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1tpi05-0004Gv-QO
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 01:13:04 -0500
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8AxDGtr68dnyt+KAA--.40770S3;
 Wed, 05 Mar 2025 14:12:59 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMBx3MRi68dnfRQ3AA--.5679S10;
 Wed, 05 Mar 2025 14:12:59 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, Song Gao <gaosong@loongson.cn>,
 Xianglai Li <lixianglai@loongson.cn>
Subject: [PULL 08/15] hw/loongarch/virt: Add CPU topology support
Date: Wed,  5 Mar 2025 14:12:43 +0800
Message-Id: <20250305061250.1908444-9-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250305061250.1908444-1-maobibo@loongson.cn>
References: <20250305061250.1908444-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMBx3MRi68dnfRQ3AA--.5679S10
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

Add topological relationships for Loongarch VCPU and initialize
topology member variables.

On LoongArch system there is socket/core/thread topo information,
physical CPU id is calculated from CPU topo, every topo sub-field is
aligned by power of 2. So it is different from logical cpu index.

Co-developed-by: Xianglai Li <lixianglai@loongson.cn>
Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 hw/loongarch/virt.c    | 59 ++++++++++++++++++++++++++++++++++++------
 target/loongarch/cpu.h |  6 +++++
 2 files changed, 57 insertions(+), 8 deletions(-)

diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index 907f965c54..2bbbbbfbcf 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -774,6 +774,48 @@ static void virt_initfn(Object *obj)
     virt_flash_create(lvms);
 }
 
+static void virt_get_topo_from_index(MachineState *ms,
+                                     LoongArchCPUTopo *topo, int index)
+{
+    topo->socket_id = index / (ms->smp.cores * ms->smp.threads);
+    topo->core_id = index / ms->smp.threads % ms->smp.cores;
+    topo->thread_id = index % ms->smp.threads;
+}
+
+static unsigned int topo_align_up(unsigned int count)
+{
+    g_assert(count >= 1);
+    count -= 1;
+    return BIT(count ? 32 - clz32(count) : 0);
+}
+
+/*
+ * LoongArch Reference Manual Vol1, Chapter 7.4.12 CPU Identity
+ *  For CPU architecture, bit0 .. bit8 is valid for CPU id, max cpuid is 512
+ *  However for IPI/Eiointc interrupt controller, max supported cpu id for
+ *  irq routingis 256
+ *
+ *  Here max cpu id is 256 for virt machine
+ */
+static int virt_get_arch_id_from_topo(MachineState *ms, LoongArchCPUTopo *topo)
+{
+    int arch_id, threads, cores, sockets;
+
+    threads = topo_align_up(ms->smp.threads);
+    cores = topo_align_up(ms->smp.cores);
+    sockets = topo_align_up(ms->smp.sockets);
+    if ((threads * cores * sockets) > 256) {
+        error_report("Exceeding max cpuid 256 with sockets[%d] cores[%d]"
+                     " threads[%d]", ms->smp.sockets, ms->smp.cores,
+                     ms->smp.threads);
+        exit(1);
+    }
+
+    arch_id = topo->thread_id + topo->core_id * threads;
+    arch_id += topo->socket_id * threads * cores;
+    return arch_id;
+}
+
 static bool memhp_type_supported(DeviceState *dev)
 {
     /* we only support pc dimm now */
@@ -873,8 +915,9 @@ static HotplugHandler *virt_get_hotplug_handler(MachineState *machine,
 
 static const CPUArchIdList *virt_possible_cpu_arch_ids(MachineState *ms)
 {
-    int n;
+    int n, arch_id;
     unsigned int max_cpus = ms->smp.max_cpus;
+    LoongArchCPUTopo topo;
 
     if (ms->possible_cpus) {
         assert(ms->possible_cpus->len == max_cpus);
@@ -885,17 +928,17 @@ static const CPUArchIdList *virt_possible_cpu_arch_ids(MachineState *ms)
                                   sizeof(CPUArchId) * max_cpus);
     ms->possible_cpus->len = max_cpus;
     for (n = 0; n < ms->possible_cpus->len; n++) {
+        virt_get_topo_from_index(ms, &topo, n);
+        arch_id = virt_get_arch_id_from_topo(ms, &topo);
         ms->possible_cpus->cpus[n].type = ms->cpu_type;
-        ms->possible_cpus->cpus[n].arch_id = n;
-
+        ms->possible_cpus->cpus[n].arch_id = arch_id;
+        ms->possible_cpus->cpus[n].vcpus_count = 1;
         ms->possible_cpus->cpus[n].props.has_socket_id = true;
-        ms->possible_cpus->cpus[n].props.socket_id  =
-                                   n / (ms->smp.cores * ms->smp.threads);
+        ms->possible_cpus->cpus[n].props.socket_id = topo.socket_id;
         ms->possible_cpus->cpus[n].props.has_core_id = true;
-        ms->possible_cpus->cpus[n].props.core_id =
-                                   n / ms->smp.threads % ms->smp.cores;
+        ms->possible_cpus->cpus[n].props.core_id = topo.core_id;
         ms->possible_cpus->cpus[n].props.has_thread_id = true;
-        ms->possible_cpus->cpus[n].props.thread_id = n % ms->smp.threads;
+        ms->possible_cpus->cpus[n].props.thread_id = topo.thread_id;
     }
     return ms->possible_cpus;
 }
diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index 83183a33ab..9dc71fa7f1 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -393,6 +393,12 @@ typedef struct CPUArchState {
 #endif
 } CPULoongArchState;
 
+typedef struct LoongArchCPUTopo {
+    int32_t socket_id;  /* socket-id of this VCPU */
+    int32_t core_id;    /* core-id of this VCPU */
+    int32_t thread_id;  /* thread-id of this VCPU */
+} LoongArchCPUTopo;
+
 /**
  * LoongArchCPU:
  * @env: #CPULoongArchState
-- 
2.43.5


