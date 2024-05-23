Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 214B2C25B78
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 01:48:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9xXf-0001iQ-Gm; Wed, 22 May 2024 21:46:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1s9xXc-0001fV-EI
 for qemu-devel@nongnu.org; Wed, 22 May 2024 21:46:48 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1s9xXY-00013C-CY
 for qemu-devel@nongnu.org; Wed, 22 May 2024 21:46:48 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8DxQK8BoE5mq98CAA--.2614S3;
 Thu, 23 May 2024 09:46:41 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8AxDMf9n05mSDMGAA--.17472S9; 
 Thu, 23 May 2024 09:46:41 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
	Bibo Mao <maobibo@loongson.cn>
Subject: [PULL 07/10] hw/loongarch: Refine system dram memory region
Date: Thu, 23 May 2024 09:46:34 +0800
Message-Id: <20240523014637.614872-8-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20240523014637.614872-1-gaosong@loongson.cn>
References: <20240523014637.614872-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxDMf9n05mSDMGAA--.17472S9
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

For system dram memory region, it is not necessary to use numa node
information. There is only low memory region and high memory region.

Remove numa node information for ddr memory region here, it can reduce
memory region number on LoongArch virt machine.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by: Song Gao <gaosong@loongson.cn>
Message-Id: <20240515093927.3453674-5-maobibo@loongson.cn>
Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 hw/loongarch/virt.c | 53 +++++++++++++++------------------------------
 1 file changed, 17 insertions(+), 36 deletions(-)

diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index 449050cba5..4ec2b9a061 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -978,14 +978,10 @@ static void virt_init(MachineState *machine)
 {
     LoongArchCPU *lacpu;
     const char *cpu_model = machine->cpu_type;
-    ram_addr_t offset = 0;
-    ram_addr_t ram_size = machine->ram_size;
-    uint64_t highram_size = 0, phyAddr = 0;
     MemoryRegion *address_space_mem = get_system_memory();
     LoongArchVirtMachineState *lvms = LOONGARCH_VIRT_MACHINE(machine);
-    int nb_numa_nodes = machine->numa_state->num_nodes;
-    NodeInfo *numa_info = machine->numa_state->nodes;
     int i;
+    hwaddr base, size, ram_size = machine->ram_size;
     const CPUArchIdList *possible_cpus;
     MachineClass *mc = MACHINE_GET_CLASS(machine);
     CPUState *cpu;
@@ -1023,40 +1019,27 @@ static void virt_init(MachineState *machine)
     fw_cfg_add_memory(machine);
 
     /* Node0 memory */
-    memory_region_init_alias(&lvms->lowmem, NULL, "loongarch.node0.lowram",
-                             machine->ram, offset, VIRT_LOWMEM_SIZE);
-    memory_region_add_subregion(address_space_mem, phyAddr, &lvms->lowmem);
-
-    offset += VIRT_LOWMEM_SIZE;
-    if (nb_numa_nodes > 0) {
-        assert(numa_info[0].node_mem > VIRT_LOWMEM_SIZE);
-        highram_size = numa_info[0].node_mem - VIRT_LOWMEM_SIZE;
-    } else {
-        highram_size = ram_size - VIRT_LOWMEM_SIZE;
+    size = ram_size;
+    base = VIRT_LOWMEM_BASE;
+    if (size > VIRT_LOWMEM_SIZE) {
+        size = VIRT_LOWMEM_SIZE;
     }
-    phyAddr = VIRT_HIGHMEM_BASE;
-    memory_region_init_alias(&lvms->highmem, NULL, "loongarch.node0.highram",
-                              machine->ram, offset, highram_size);
-    memory_region_add_subregion(address_space_mem, phyAddr, &lvms->highmem);
-
-    /* Node1 - Nodemax memory */
-    offset += highram_size;
-    phyAddr += highram_size;
-
-    for (i = 1; i < nb_numa_nodes; i++) {
-        MemoryRegion *nodemem = g_new(MemoryRegion, 1);
-        g_autofree char *ramName = g_strdup_printf("loongarch.node%d.ram", i);
-        memory_region_init_alias(nodemem, NULL, ramName, machine->ram,
-                                 offset,  numa_info[i].node_mem);
-        memory_region_add_subregion(address_space_mem, phyAddr, nodemem);
-        offset += numa_info[i].node_mem;
-        phyAddr += numa_info[i].node_mem;
+
+    memory_region_init_alias(&lvms->lowmem, NULL, "loongarch.lowram",
+                              machine->ram, base, size);
+    memory_region_add_subregion(address_space_mem, base, &lvms->lowmem);
+    base += size;
+    if (ram_size - size) {
+        base = VIRT_HIGHMEM_BASE;
+        memory_region_init_alias(&lvms->highmem, NULL, "loongarch.highram",
+                machine->ram, VIRT_LOWMEM_BASE + size, ram_size - size);
+        memory_region_add_subregion(address_space_mem, base, &lvms->highmem);
+        base += ram_size - size;
     }
 
     /* initialize device memory address space */
     if (machine->ram_size < machine->maxram_size) {
         ram_addr_t device_mem_size = machine->maxram_size - machine->ram_size;
-        hwaddr device_mem_base;
 
         if (machine->ram_slots > ACPI_MAX_RAM_SLOTS) {
             error_report("unsupported amount of memory slots: %"PRIu64,
@@ -1070,9 +1053,7 @@ static void virt_init(MachineState *machine)
                          "%d bytes", TARGET_PAGE_SIZE);
             exit(EXIT_FAILURE);
         }
-        /* device memory base is the top of high memory address. */
-        device_mem_base = ROUND_UP(VIRT_HIGHMEM_BASE + highram_size, 1 * GiB);
-        machine_memory_devices_init(machine, device_mem_base, device_mem_size);
+        machine_memory_devices_init(machine, base, device_mem_size);
     }
 
     /* load the BIOS image. */
-- 
2.34.1


