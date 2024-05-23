Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CDE9C25B78
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 01:47:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9xXd-0001gj-TI; Wed, 22 May 2024 21:46:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1s9xXc-0001fH-7C
 for qemu-devel@nongnu.org; Wed, 22 May 2024 21:46:48 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1s9xXY-000135-3J
 for qemu-devel@nongnu.org; Wed, 22 May 2024 21:46:47 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8BxWeoBoE5mp98CAA--.2708S3;
 Thu, 23 May 2024 09:46:41 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8AxDMf9n05mSDMGAA--.17472S7; 
 Thu, 23 May 2024 09:46:41 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
	Bibo Mao <maobibo@loongson.cn>
Subject: [PULL 05/10] hw/loongarch: Refine fadt memory table for numa memory
Date: Thu, 23 May 2024 09:46:32 +0800
Message-Id: <20240523014637.614872-6-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20240523014637.614872-1-gaosong@loongson.cn>
References: <20240523014637.614872-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxDMf9n05mSDMGAA--.17472S7
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
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

From: Bibo Mao <maobibo@loongson.cn>

One LoongArch virt machine platform, there is limitation for memory
map information. The minimum memory size is 256M and minimum memory
size for numa node0 is 256M also. With qemu numa qtest, it is possible
that memory size of numa node0 is 128M.

Limitations for minimum memory size for both total memory and numa
node0 is removed for fadt numa memory table creation.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by: Song Gao <gaosong@loongson.cn>
Message-Id: <20240515093927.3453674-3-maobibo@loongson.cn>
Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 hw/loongarch/virt.c | 46 ++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 43 insertions(+), 3 deletions(-)

diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index 95f9ed5cae..850729202f 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -474,6 +474,48 @@ static void fdt_add_memory_node(MachineState *ms,
     g_free(nodename);
 }
 
+static void fdt_add_memory_nodes(MachineState *ms)
+{
+    hwaddr base, size, ram_size, gap;
+    int i, nb_numa_nodes, nodes;
+    NodeInfo *numa_info;
+
+    ram_size = ms->ram_size;
+    base = VIRT_LOWMEM_BASE;
+    gap = VIRT_LOWMEM_SIZE;
+    nodes = nb_numa_nodes = ms->numa_state->num_nodes;
+    numa_info = ms->numa_state->nodes;
+    if (!nodes) {
+        nodes = 1;
+    }
+
+    for (i = 0; i < nodes; i++) {
+        if (nb_numa_nodes) {
+            size = numa_info[i].node_mem;
+        } else {
+            size = ram_size;
+        }
+
+        /*
+         * memory for the node splited into two part
+         *   lowram:  [base, +gap)
+         *   highram: [VIRT_HIGHMEM_BASE, +(len - gap))
+         */
+        if (size >= gap) {
+            fdt_add_memory_node(ms, base, gap, i);
+            size -= gap;
+            base = VIRT_HIGHMEM_BASE;
+            gap = ram_size - VIRT_LOWMEM_SIZE;
+        }
+
+        if (size) {
+            fdt_add_memory_node(ms, base, size, i);
+            base += size;
+            gap -= size;
+        }
+    }
+}
+
 static void virt_build_smbios(LoongArchVirtMachineState *lvms)
 {
     MachineState *ms = MACHINE(lvms);
@@ -921,10 +963,10 @@ static void virt_init(MachineState *machine)
         lacpu->phy_id = machine->possible_cpus->cpus[i].arch_id;
     }
     fdt_add_cpu_nodes(lvms);
+    fdt_add_memory_nodes(machine);
 
     /* Node0 memory */
     memmap_add_entry(VIRT_LOWMEM_BASE, VIRT_LOWMEM_SIZE, 1);
-    fdt_add_memory_node(machine, VIRT_LOWMEM_BASE, VIRT_LOWMEM_SIZE, 0);
     memory_region_init_alias(&lvms->lowmem, NULL, "loongarch.node0.lowram",
                              machine->ram, offset, VIRT_LOWMEM_SIZE);
     memory_region_add_subregion(address_space_mem, phyAddr, &lvms->lowmem);
@@ -938,7 +980,6 @@ static void virt_init(MachineState *machine)
     }
     phyAddr = VIRT_HIGHMEM_BASE;
     memmap_add_entry(phyAddr, highram_size, 1);
-    fdt_add_memory_node(machine, phyAddr, highram_size, 0);
     memory_region_init_alias(&lvms->highmem, NULL, "loongarch.node0.highram",
                               machine->ram, offset, highram_size);
     memory_region_add_subregion(address_space_mem, phyAddr, &lvms->highmem);
@@ -954,7 +995,6 @@ static void virt_init(MachineState *machine)
                                  offset,  numa_info[i].node_mem);
         memory_region_add_subregion(address_space_mem, phyAddr, nodemem);
         memmap_add_entry(phyAddr, numa_info[i].node_mem, 1);
-        fdt_add_memory_node(machine, phyAddr, numa_info[i].node_mem, i);
         offset += numa_info[i].node_mem;
         phyAddr += numa_info[i].node_mem;
     }
-- 
2.34.1


