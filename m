Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01F30C25B4F
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 02:31:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4X5b-0001rP-TW; Tue, 07 May 2024 22:31:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1s4X50-0001dW-Cx; Tue, 07 May 2024 22:31:02 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>)
 id 1s4X4w-00018U-KT; Tue, 07 May 2024 22:30:50 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8DxNvDI4zpmyy4JAA--.24743S3;
 Wed, 08 May 2024 10:30:32 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8CxoFXH4zpmUQsVAA--.24166S2; 
 Wed, 08 May 2024 10:30:31 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: peter.maydell@linaro.org,
	mjt@tls.msk.ru
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org,
 richard.henderson@linaro.org, zhaotianrui@loongson.cn
Subject: [PATCH v2] hw/loongarch/virt: Fix memory leak
Date: Wed,  8 May 2024 10:30:31 +0800
Message-Id: <20240508023031.3127531-1-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxoFXH4zpmUQsVAA--.24166S2
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

The char pointer 'ramName' point to a block of memory, but never free it.
Use a small fixed-size buffer for 'ramName'.

Resolves: Coverity CID 1544773

Fixes: 0cf1478d6 ("hw/loongarch: Add numa support")
Signed-off-by: Song Gao <gaosong@loongson.cn>
---
v2:
  - Use a small fixed-size buffer for 'ramName'.
  - Link to V1: https://patchew.org/QEMU/20240507022239.3113987-1-gaosong@loongson.cn/ 

 hw/loongarch/virt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index c0999878df..ee690ad981 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -887,7 +887,7 @@ static void loongarch_init(MachineState *machine)
     const CPUArchIdList *possible_cpus;
     MachineClass *mc = MACHINE_GET_CLASS(machine);
     CPUState *cpu;
-    char *ramName = NULL;
+    char ramName[32];
 
     if (!cpu_model) {
         cpu_model = LOONGARCH_CPU_TYPE_NAME("la464");
@@ -946,7 +946,7 @@ static void loongarch_init(MachineState *machine)
 
     for (i = 1; i < nb_numa_nodes; i++) {
         MemoryRegion *nodemem = g_new(MemoryRegion, 1);
-        ramName = g_strdup_printf("loongarch.node%d.ram", i);
+        sprintf(ramName, "loongarch.node%d.ram", i);
         memory_region_init_alias(nodemem, NULL, ramName, machine->ram,
                                  offset,  numa_info[i].node_mem);
         memory_region_add_subregion(address_space_mem, phyAddr, nodemem);
-- 
2.25.1


