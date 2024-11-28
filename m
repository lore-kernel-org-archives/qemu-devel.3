Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA653D6D253
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2024 02:11:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGTzJ-0005kC-Ac; Wed, 27 Nov 2024 21:10:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1tGTzG-0005jB-PT
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 21:10:34 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1tGTzC-0006vI-Gx
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 21:10:33 -0500
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8DxQK8S0UdnJVRKAA--.55590S3;
 Thu, 28 Nov 2024 10:10:26 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMCxNMAQ0UdnfNJqAA--.46399S7;
 Thu, 28 Nov 2024 10:10:26 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>,
	Huacai Chen <chenhuacai@kernel.org>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, Igor Mammedov <imammedo@redhat.com>,
 qemu-devel@nongnu.org
Subject: [PATCH 5/5] hw/intc/loongarch_ipi: Optimize function cpu_by_arch_id
Date: Thu, 28 Nov 2024 10:10:24 +0800
Message-Id: <20241128021024.662057-6-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20241128021024.662057-1-maobibo@loongson.cn>
References: <20241128021024.662057-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMCxNMAQ0UdnfNJqAA--.46399S7
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

There is cpu mapping from physical cpu id inside, cpu_by_arch_id
can be optimized from cpu mapping table.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 hw/intc/loongarch_ipi.c | 47 ++++++++++-------------------------------
 1 file changed, 11 insertions(+), 36 deletions(-)

diff --git a/hw/intc/loongarch_ipi.c b/hw/intc/loongarch_ipi.c
index 579c9c830b..7fd237bd14 100644
--- a/hw/intc/loongarch_ipi.c
+++ b/hw/intc/loongarch_ipi.c
@@ -17,49 +17,24 @@ static AddressSpace *get_iocsr_as(CPUState *cpu)
     return LOONGARCH_CPU(cpu)->env.address_space_iocsr;
 }
 
-static int archid_cmp(const void *a, const void *b)
-{
-   CPUArchId *archid_a = (CPUArchId *)a;
-   CPUArchId *archid_b = (CPUArchId *)b;
-
-   return archid_a->arch_id - archid_b->arch_id;
-}
-
-static CPUArchId *find_cpu_by_archid(MachineState *ms, uint32_t id)
-{
-    CPUArchId apic_id, *found_cpu;
-
-    apic_id.arch_id = id;
-    found_cpu = bsearch(&apic_id, ms->possible_cpus->cpus,
-                        ms->possible_cpus->len,
-                        sizeof(*ms->possible_cpus->cpus),
-                        archid_cmp);
-
-    return found_cpu;
-}
-
 static int loongarch_cpu_by_arch_id(LoongsonIPICommonState *lics,
                                     int64_t arch_id, int *index, CPUState **pcs)
 {
-    MachineState *machine = MACHINE(qdev_get_machine());
-    CPUArchId *archid;
-    CPUState *cs;
-
-    archid = find_cpu_by_archid(machine, arch_id);
-    if (archid && archid->cpu) {
-        cs = archid->cpu;
-        if (index) {
-            *index = cs->cpu_index;
-        }
+    LoongarchIPIState *lis = LOONGARCH_IPI(lics);
 
-        if (pcs) {
-            *pcs = cs;
-        }
+    if ((arch_id >= MAX_PHY_ID) || (lis->cs[arch_id] == NULL)) {
+        return MEMTX_ERROR;
+    }
+
+    if (index) {
+        *index = lis->present_cpu[arch_id];
+    }
 
-        return MEMTX_OK;
+    if (pcs) {
+        *pcs = lis->cs[arch_id];
     }
 
-    return MEMTX_ERROR;
+    return MEMTX_OK;
 }
 
 static void loongarch_cpu_plug(HotplugHandler *hotplug_dev,
-- 
2.39.3


