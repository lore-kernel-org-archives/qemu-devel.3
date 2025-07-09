Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8543BC8303C
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Jul 2025 00:47:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZIx2-0003rR-7r; Tue, 08 Jul 2025 20:46:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1uZIwg-0003j7-0m
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 20:45:58 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1uZIwb-0004Lu-Su
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 20:45:57 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8DxCeG9u21oI+gkAQ--.37841S3;
 Wed, 09 Jul 2025 08:45:49 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowJCxM+S6u21o0TEPAA--.22142S8;
 Wed, 09 Jul 2025 08:45:48 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH 6/6] target/loongarch: Use loongarch_check_pte() with page
 table walking
Date: Wed,  9 Jul 2025 08:45:46 +0800
Message-Id: <20250709004546.3005275-7-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250709004546.3005275-1-maobibo@loongson.cn>
References: <20250709004546.3005275-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJCxM+S6u21o0TEPAA--.22142S8
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

Function loongarch_check_pte() can get physical address and access
priviledge, it works on both TLB entry and pte entry. It can be used
at page table walking.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 target/loongarch/cpu_helper.c | 35 ++++++++++-------------------------
 1 file changed, 10 insertions(+), 25 deletions(-)

diff --git a/target/loongarch/cpu_helper.c b/target/loongarch/cpu_helper.c
index ed72ca1640..e185273950 100644
--- a/target/loongarch/cpu_helper.c
+++ b/target/loongarch/cpu_helper.c
@@ -108,13 +108,15 @@ int loongarch_check_pte(CPULoongArchState *env, hwaddr *physical, int *prot,
 }
 
 static int loongarch_page_table_walker(CPULoongArchState *env, hwaddr *physical,
-                                 int *prot, target_ulong address)
+                                       int *prot, target_ulong address,
+                                       int access_type, int mmu_idx)
 {
     CPUState *cs = env_cpu(env);
     target_ulong index, phys;
     uint64_t dir_base, dir_width;
     uint64_t base;
     int level;
+    pte_context context;
 
     if ((address >> 63) & 0x1) {
         base = env->CSR_PGDH;
@@ -157,29 +159,11 @@ static int loongarch_page_table_walker(CPULoongArchState *env, hwaddr *physical,
         base = ldq_phys(cs->as, phys);
     }
 
-    /* TODO: check plv and other bits? */
-
-    /* base is pte, in normal pte format */
-    if (!FIELD_EX64(base, TLBENTRY, V)) {
-        return TLBRET_NOMATCH;
-    }
-
-    if (!FIELD_EX64(base, TLBENTRY, D)) {
-        *prot = PAGE_READ;
-    } else {
-        *prot = PAGE_READ | PAGE_WRITE;
-    }
-
-    /* get TARGET_PAGE_SIZE aligned physical address */
-    base += (address & TARGET_PHYS_MASK) & ((1 << dir_base) - 1);
-    /* mask RPLV, NX, NR bits */
-    base = FIELD_DP64(base, TLBENTRY_64, RPLV, 0);
-    base = FIELD_DP64(base, TLBENTRY_64, NX, 0);
-    base = FIELD_DP64(base, TLBENTRY_64, NR, 0);
-    /* mask other attribute bits */
-    *physical = base & TARGET_PAGE_MASK;
-
-    return 0;
+    context.vaddr = address;
+    context.page_shift = dir_base;
+    context.pte = base;
+    return loongarch_check_pte(env, physical, prot, &context, access_type,
+                               mmu_idx);
 }
 
 static int loongarch_map_address(CPULoongArchState *env, hwaddr *physical,
@@ -203,7 +187,8 @@ static int loongarch_map_address(CPULoongArchState *env, hwaddr *physical,
          * legal mapping, even if the mapping is not yet in TLB. return 0 if
          * there is a valid map, else none zero.
          */
-        return loongarch_page_table_walker(env, physical, prot, address);
+        return loongarch_page_table_walker(env, physical, prot, address,
+                                           access_type, mmu_idx);
     }
 
     return TLBRET_NOMATCH;
-- 
2.39.3


