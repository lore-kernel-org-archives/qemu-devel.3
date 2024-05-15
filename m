Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DBC0C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 09:41:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7B6q-0003Rh-7A; Wed, 15 May 2024 05:39:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1s7B6o-0003Qb-5O
 for qemu-devel@nongnu.org; Wed, 15 May 2024 05:39:38 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1s7B6j-0001Gb-Kj
 for qemu-devel@nongnu.org; Wed, 15 May 2024 05:39:37 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8AxTevSgkRmjgQNAA--.24777S3;
 Wed, 15 May 2024 17:39:30 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by localhost.localdomain (Coremail) with SMTP id AQAAf8Cx57nPgkRmVLEgAA--.5S5; 
 Wed, 15 May 2024 17:39:30 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v3 3/6] hw/loongarch: Refine fwcfg memory map
Date: Wed, 15 May 2024 17:39:24 +0800
Message-Id: <20240515093927.3453674-4-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240515093927.3453674-1-maobibo@loongson.cn>
References: <20240515093927.3453674-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Cx57nPgkRmVLEgAA--.5S5
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

Memory map table for fwcfg is used for UEFI BIOS, UEFI BIOS uses the first
entry from fwcfg memory map as the first memory HOB, the second memory HOB
will be used if the first memory HOB is used up.

Memory map table for fwcfg does not care about numa node, however in
generic the first memory HOB is part of numa node0, so that runtime
memory of UEFI which is allocated from the first memory HOB is located
at numa node0.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 hw/loongarch/virt.c | 60 ++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 57 insertions(+), 3 deletions(-)

diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index c996305d87..b67d691fa5 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -912,6 +912,62 @@ static const MemoryRegionOps virt_iocsr_misc_ops = {
     },
 };
 
+static void fw_cfg_add_memory(MachineState *ms)
+{
+    hwaddr base, size, ram_size, gap;
+    int nb_numa_nodes, nodes;
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
+    /* add fw_cfg memory map of node0 */
+    if (nb_numa_nodes) {
+        size = numa_info[0].node_mem;
+    } else {
+        size = ram_size;
+    }
+
+    if (size >= gap) {
+        memmap_add_entry(base, gap, 1);
+        size -= gap;
+        base = VIRT_HIGHMEM_BASE;
+        gap = ram_size - VIRT_LOWMEM_SIZE;
+    }
+
+    if (size) {
+        memmap_add_entry(base, size, 1);
+        base += size;
+    }
+
+    if (nodes < 2) {
+        return;
+    }
+
+    /* add fw_cfg memory map of other nodes */
+    size = ram_size - numa_info[0].node_mem;
+    gap  = VIRT_LOWMEM_BASE + VIRT_LOWMEM_SIZE;
+    if (base < gap && (base + size) > gap) {
+        /*
+         * memory map for the maining nodes splited into two part
+         *   lowram:  [base, +(gap - base))
+         *   highram: [VIRT_HIGHMEM_BASE, +(size - (gap - base)))
+         */
+        memmap_add_entry(base, gap - base, 1);
+        size -= gap - base;
+        base = VIRT_HIGHMEM_BASE;
+    }
+
+   if (size)
+        memmap_add_entry(base, size, 1);
+}
+
 static void virt_init(MachineState *machine)
 {
     LoongArchCPU *lacpu;
@@ -958,9 +1014,9 @@ static void virt_init(MachineState *machine)
     }
     fdt_add_cpu_nodes(lvms);
     fdt_add_memory_nodes(machine);
+    fw_cfg_add_memory(machine);
 
     /* Node0 memory */
-    memmap_add_entry(VIRT_LOWMEM_BASE, VIRT_LOWMEM_SIZE, 1);
     memory_region_init_alias(&lvms->lowmem, NULL, "loongarch.node0.lowram",
                              machine->ram, offset, VIRT_LOWMEM_SIZE);
     memory_region_add_subregion(address_space_mem, phyAddr, &lvms->lowmem);
@@ -973,7 +1029,6 @@ static void virt_init(MachineState *machine)
         highram_size = ram_size - VIRT_LOWMEM_SIZE;
     }
     phyAddr = VIRT_HIGHMEM_BASE;
-    memmap_add_entry(phyAddr, highram_size, 1);
     memory_region_init_alias(&lvms->highmem, NULL, "loongarch.node0.highram",
                               machine->ram, offset, highram_size);
     memory_region_add_subregion(address_space_mem, phyAddr, &lvms->highmem);
@@ -988,7 +1043,6 @@ static void virt_init(MachineState *machine)
         memory_region_init_alias(nodemem, NULL, ramName, machine->ram,
                                  offset,  numa_info[i].node_mem);
         memory_region_add_subregion(address_space_mem, phyAddr, nodemem);
-        memmap_add_entry(phyAddr, numa_info[i].node_mem, 1);
         offset += numa_info[i].node_mem;
         phyAddr += numa_info[i].node_mem;
     }
-- 
2.39.3


