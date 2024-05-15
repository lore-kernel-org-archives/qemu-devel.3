Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B278C25B7A
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 09:40:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7B7N-0003ck-58; Wed, 15 May 2024 05:40:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1s7B6o-0003RB-W8
 for qemu-devel@nongnu.org; Wed, 15 May 2024 05:39:39 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1s7B6k-0001GZ-AL
 for qemu-devel@nongnu.org; Wed, 15 May 2024 05:39:38 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8DxmOnRgkRmigQNAA--.18967S3;
 Wed, 15 May 2024 17:39:29 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by localhost.localdomain (Coremail) with SMTP id AQAAf8Cx57nPgkRmVLEgAA--.5S3; 
 Wed, 15 May 2024 17:39:29 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v3 1/6] hw/loongarch: Refine acpi srat table for numa memory
Date: Wed, 15 May 2024 17:39:22 +0800
Message-Id: <20240515093927.3453674-2-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240515093927.3453674-1-maobibo@loongson.cn>
References: <20240515093927.3453674-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Cx57nPgkRmVLEgAA--.5S3
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

One LoongArch virt machine platform, there is limitation for memory
map information. The minimum memory size is 256M and minimum memory
size for numa node0 is 256M also. With qemu numa qtest, it is possible
that memory size of numa node0 is 128M.

Limitations for minimum memory size for both total memory and numa
node0 is removed for acpi srat table creation.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 hw/loongarch/acpi-build.c | 58 +++++++++++++++++++++++----------------
 1 file changed, 34 insertions(+), 24 deletions(-)

diff --git a/hw/loongarch/acpi-build.c b/hw/loongarch/acpi-build.c
index 5ef010d4da..af45ce526d 100644
--- a/hw/loongarch/acpi-build.c
+++ b/hw/loongarch/acpi-build.c
@@ -166,8 +166,9 @@ static void
 build_srat(GArray *table_data, BIOSLinker *linker, MachineState *machine)
 {
     int i, arch_id, node_id;
-    uint64_t mem_len, mem_base;
-    int nb_numa_nodes = machine->numa_state->num_nodes;
+    hwaddr len, base, gap;
+    NodeInfo *numa_info;
+    int nodes, nb_numa_nodes = machine->numa_state->num_nodes;
     LoongArchVirtMachineState *lvms = LOONGARCH_VIRT_MACHINE(machine);
     MachineClass *mc = MACHINE_GET_CLASS(lvms);
     const CPUArchIdList *arch_ids = mc->possible_cpu_arch_ids(machine);
@@ -196,35 +197,44 @@ build_srat(GArray *table_data, BIOSLinker *linker, MachineState *machine)
         build_append_int_noprefix(table_data, 0, 4); /* Reserved */
     }
 
-    /* Node0 */
-    build_srat_memory(table_data, VIRT_LOWMEM_BASE, VIRT_LOWMEM_SIZE,
-                      0, MEM_AFFINITY_ENABLED);
-    mem_base = VIRT_HIGHMEM_BASE;
-    if (!nb_numa_nodes) {
-        mem_len = machine->ram_size - VIRT_LOWMEM_SIZE;
-    } else {
-        mem_len = machine->numa_state->nodes[0].node_mem - VIRT_LOWMEM_SIZE;
+    base = VIRT_LOWMEM_BASE;
+    gap = VIRT_LOWMEM_SIZE;
+    numa_info = machine->numa_state->nodes;
+    nodes = nb_numa_nodes;
+    if (!nodes) {
+        nodes = 1;
     }
-    if (mem_len)
-        build_srat_memory(table_data, mem_base, mem_len, 0, MEM_AFFINITY_ENABLED);
-
-    /* Node1 - Nodemax */
-    if (nb_numa_nodes) {
-        mem_base += mem_len;
-        for (i = 1; i < nb_numa_nodes; ++i) {
-            if (machine->numa_state->nodes[i].node_mem > 0) {
-                build_srat_memory(table_data, mem_base,
-                                  machine->numa_state->nodes[i].node_mem, i,
-                                  MEM_AFFINITY_ENABLED);
-                mem_base += machine->numa_state->nodes[i].node_mem;
-            }
+
+    for (i = 0; i < nodes; i++) {
+        if (nb_numa_nodes) {
+            len = numa_info[i].node_mem;
+        } else {
+            len = machine->ram_size;
+        }
+
+        /*
+         * memory for the node splited into two part
+         *   lowram:  [base, +gap)
+         *   highram: [VIRT_HIGHMEM_BASE, +(len - gap))
+         */
+        if (len >= gap) {
+            build_srat_memory(table_data, base, len, i, MEM_AFFINITY_ENABLED);
+            len -= gap;
+            base = VIRT_HIGHMEM_BASE;
+            gap = machine->ram_size - VIRT_LOWMEM_SIZE;
+        }
+
+        if (len) {
+            build_srat_memory(table_data, base, len, i, MEM_AFFINITY_ENABLED);
+            base += len;
+            gap  -= len;
         }
     }
 
     if (machine->device_memory) {
         build_srat_memory(table_data, machine->device_memory->base,
                           memory_region_size(&machine->device_memory->mr),
-                          nb_numa_nodes - 1,
+                          nodes - 1,
                           MEM_AFFINITY_HOTPLUGGABLE | MEM_AFFINITY_ENABLED);
     }
 
-- 
2.39.3


