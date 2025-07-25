Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 719D9C87FCD
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 01:40:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uf7Ox-0001bl-5E; Thu, 24 Jul 2025 21:39:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1uf7Ng-0000jR-UH
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 21:37:53 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1uf7Nc-0002az-FQ
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 21:37:52 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8Bxlmno34JojJAxAQ--.34631S3;
 Fri, 25 Jul 2025 09:37:44 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowJCxdOTk34Joz5wlAA--.62171S9;
 Fri, 25 Jul 2025 09:37:43 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v3 07/17] target/loongarch: Add parameter mmu_context with
 loongarch_page_table_walker
Date: Fri, 25 Jul 2025 09:37:29 +0800
Message-Id: <20250725013739.994437-8-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250725013739.994437-1-maobibo@loongson.cn>
References: <20250725013739.994437-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJCxdOTk34Joz5wlAA--.62171S9
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

With function loongarch_page_table_walker(), some output parameters
such as physical address and prot can be moved to structure mmu_context.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 target/loongarch/cpu_helper.c | 27 +++++++++++----------------
 1 file changed, 11 insertions(+), 16 deletions(-)

diff --git a/target/loongarch/cpu_helper.c b/target/loongarch/cpu_helper.c
index 9e6de2908f..a26bb8b11b 100644
--- a/target/loongarch/cpu_helper.c
+++ b/target/loongarch/cpu_helper.c
@@ -106,17 +106,18 @@ int loongarch_check_pte(CPULoongArchState *env, mmu_context *context,
     return TLBRET_MATCH;
 }
 
-static int loongarch_page_table_walker(CPULoongArchState *env, hwaddr *physical,
-                                       int *prot, target_ulong address,
+static int loongarch_page_table_walker(CPULoongArchState *env,
+                                       mmu_context *context,
                                        int access_type, int mmu_idx)
 {
     CPUState *cs = env_cpu(env);
     target_ulong index, phys;
     uint64_t dir_base, dir_width;
     uint64_t base;
-    int level, ret;
-    mmu_context context;
+    int level;
+    target_ulong address;
 
+    address = context->vaddr;
     if ((address >> 63) & 0x1) {
         base = env->CSR_PGDH;
     } else {
@@ -158,16 +159,9 @@ static int loongarch_page_table_walker(CPULoongArchState *env, hwaddr *physical,
         base = ldq_phys(cs->as, phys);
     }
 
-    context.vaddr = address;
-    context.ps = dir_base;
-    context.pte = base;
-    ret = loongarch_check_pte(env, &context, access_type, mmu_idx);
-    if (ret == TLBRET_MATCH) {
-        *physical = context.physical;
-        *prot = context.prot;
-    }
-
-    return ret;
+    context->ps = dir_base;
+    context->pte = base;
+    return loongarch_check_pte(env, context, access_type, mmu_idx);
 }
 
 static int loongarch_map_address(CPULoongArchState *env, hwaddr *physical,
@@ -176,7 +170,9 @@ static int loongarch_map_address(CPULoongArchState *env, hwaddr *physical,
                                  int is_debug)
 {
     int ret;
+    mmu_context context;
 
+    context.vaddr = address;
     if (tcg_enabled()) {
         ret = loongarch_get_addr_from_tlb(env, physical, prot, address,
                                           access_type, mmu_idx);
@@ -191,8 +187,7 @@ static int loongarch_map_address(CPULoongArchState *env, hwaddr *physical,
          * legal mapping, even if the mapping is not yet in TLB. return 0 if
          * there is a valid map, else none zero.
          */
-        return loongarch_page_table_walker(env, physical, prot, address,
-                                           access_type, mmu_idx);
+        return loongarch_page_table_walker(env, &context, access_type, mmu_idx);
     }
 
     return TLBRET_NOMATCH;
-- 
2.39.3


