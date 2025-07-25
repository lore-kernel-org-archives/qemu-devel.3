Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1BE1C83F26
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 01:40:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uf7PD-0001m5-8N; Thu, 24 Jul 2025 21:39:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1uf7Nh-0000ku-CE
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 21:37:53 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1uf7Nd-0002b8-7l
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 21:37:53 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8Bxjazo34JokZAxAQ--.1129S3;
 Fri, 25 Jul 2025 09:37:44 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowJCxdOTk34Joz5wlAA--.62171S12;
 Fri, 25 Jul 2025 09:37:44 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v3 10/17] target/loongarch: Add parameter mmu_context with
 loongarch_map_address
Date: Fri, 25 Jul 2025 09:37:32 +0800
Message-Id: <20250725013739.994437-11-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250725013739.994437-1-maobibo@loongson.cn>
References: <20250725013739.994437-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJCxdOTk34Joz5wlAA--.62171S12
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

With function loongarch_map_address(), parameter mmu_context is added
and remove parameter address, prot and address.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 target/loongarch/cpu_helper.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/target/loongarch/cpu_helper.c b/target/loongarch/cpu_helper.c
index 1e97687e1f..6abd7aa152 100644
--- a/target/loongarch/cpu_helper.c
+++ b/target/loongarch/cpu_helper.c
@@ -164,22 +164,15 @@ static int loongarch_page_table_walker(CPULoongArchState *env,
     return loongarch_check_pte(env, context, access_type, mmu_idx);
 }
 
-static int loongarch_map_address(CPULoongArchState *env, hwaddr *physical,
-                                 int *prot, target_ulong address,
+static int loongarch_map_address(CPULoongArchState *env, mmu_context *context,
                                  MMUAccessType access_type, int mmu_idx,
                                  int is_debug)
 {
     int ret;
-    mmu_context context;
 
-    context.vaddr = address;
     if (tcg_enabled()) {
-        ret = loongarch_get_addr_from_tlb(env, &context, access_type, mmu_idx);
+        ret = loongarch_get_addr_from_tlb(env, context, access_type, mmu_idx);
         if (ret != TLBRET_NOMATCH) {
-            if (ret == TLBRET_MATCH) {
-                *physical = context.physical;
-                *prot = context.prot;
-            }
             return ret;
         }
     }
@@ -190,7 +183,7 @@ static int loongarch_map_address(CPULoongArchState *env, hwaddr *physical,
          * legal mapping, even if the mapping is not yet in TLB. return 0 if
          * there is a valid map, else none zero.
          */
-        return loongarch_page_table_walker(env, &context, access_type, mmu_idx);
+        return loongarch_page_table_walker(env, context, access_type, mmu_idx);
     }
 
     return TLBRET_NOMATCH;
@@ -218,8 +211,11 @@ int get_physical_address(CPULoongArchState *env, hwaddr *physical,
     int64_t addr_high;
     uint8_t da = FIELD_EX64(env->CSR_CRMD, CSR_CRMD, DA);
     uint8_t pg = FIELD_EX64(env->CSR_CRMD, CSR_CRMD, PG);
+    mmu_context context;
+    int ret;
 
     /* Check PG and DA */
+    context.vaddr = address;
     if (da & !pg) {
         *physical = address & TARGET_PHYS_MASK;
         *prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
@@ -253,8 +249,12 @@ int get_physical_address(CPULoongArchState *env, hwaddr *physical,
     }
 
     /* Mapped address */
-    return loongarch_map_address(env, physical, prot, address,
-                                 access_type, mmu_idx, is_debug);
+    ret = loongarch_map_address(env, &context, access_type, mmu_idx, is_debug);
+    if (ret == TLBRET_MATCH) {
+        *physical = context.physical;
+        *prot = context.prot;
+    }
+    return ret;
 }
 
 hwaddr loongarch_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
-- 
2.39.3


