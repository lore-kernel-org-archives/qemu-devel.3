Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E74D1C87FCC
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 01:41:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uf7Pb-00027s-2A; Thu, 24 Jul 2025 21:39:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1uf7Nq-0000rH-HW
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 21:38:09 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1uf7Nl-0002bE-BQ
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 21:38:01 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8BxJHDp34JolJAxAQ--.59173S3;
 Fri, 25 Jul 2025 09:37:45 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowJCxdOTk34Joz5wlAA--.62171S13;
 Fri, 25 Jul 2025 09:37:44 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v3 11/17] target/loongarch: Add parameter mmu_context with
 get_physical_address
Date: Fri, 25 Jul 2025 09:37:33 +0800
Message-Id: <20250725013739.994437-12-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250725013739.994437-1-maobibo@loongson.cn>
References: <20250725013739.994437-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJCxdOTk34Joz5wlAA--.62171S13
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

With function get_physical_address(), parameter mmu_context is added
and remove parameter address, prot and address.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 target/loongarch/cpu-mmu.h        |  3 +--
 target/loongarch/cpu_helper.c     | 31 ++++++++++++-------------------
 target/loongarch/tcg/tlb_helper.c |  8 +++++---
 3 files changed, 18 insertions(+), 24 deletions(-)

diff --git a/target/loongarch/cpu-mmu.h b/target/loongarch/cpu-mmu.h
index 62b3acfbc7..9d909d36ec 100644
--- a/target/loongarch/cpu-mmu.h
+++ b/target/loongarch/cpu-mmu.h
@@ -30,8 +30,7 @@ typedef struct mmu_context {
 bool check_ps(CPULoongArchState *ent, uint8_t ps);
 int loongarch_check_pte(CPULoongArchState *env, mmu_context *context,
                         int access_type, int mmu_idx);
-int get_physical_address(CPULoongArchState *env, hwaddr *physical,
-                         int *prot, target_ulong address,
+int get_physical_address(CPULoongArchState *env, mmu_context *context,
                          MMUAccessType access_type, int mmu_idx, int is_debug);
 void get_dir_base_width(CPULoongArchState *env, uint64_t *dir_base,
                                uint64_t *dir_width, target_ulong level);
diff --git a/target/loongarch/cpu_helper.c b/target/loongarch/cpu_helper.c
index 6abd7aa152..9f64cb40cf 100644
--- a/target/loongarch/cpu_helper.c
+++ b/target/loongarch/cpu_helper.c
@@ -201,8 +201,7 @@ static hwaddr dmw_va2pa(CPULoongArchState *env, target_ulong va,
     }
 }
 
-int get_physical_address(CPULoongArchState *env, hwaddr *physical,
-                         int *prot, target_ulong address,
+int get_physical_address(CPULoongArchState *env, mmu_context *context,
                          MMUAccessType access_type, int mmu_idx, int is_debug)
 {
     int user_mode = mmu_idx == MMU_USER_IDX;
@@ -211,14 +210,13 @@ int get_physical_address(CPULoongArchState *env, hwaddr *physical,
     int64_t addr_high;
     uint8_t da = FIELD_EX64(env->CSR_CRMD, CSR_CRMD, DA);
     uint8_t pg = FIELD_EX64(env->CSR_CRMD, CSR_CRMD, PG);
-    mmu_context context;
-    int ret;
+    target_ulong address;
 
     /* Check PG and DA */
-    context.vaddr = address;
+    address = context->vaddr;
     if (da & !pg) {
-        *physical = address & TARGET_PHYS_MASK;
-        *prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
+        context->physical = address & TARGET_PHYS_MASK;
+        context->prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
         return TLBRET_MATCH;
     }
 
@@ -236,8 +234,8 @@ int get_physical_address(CPULoongArchState *env, hwaddr *physical,
             base_c = FIELD_EX64(env->CSR_DMW[i], CSR_DMW_32, VSEG);
         }
         if ((plv & env->CSR_DMW[i]) && (base_c == base_v)) {
-            *physical = dmw_va2pa(env, address, env->CSR_DMW[i]);
-            *prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
+            context->physical = dmw_va2pa(env, address, env->CSR_DMW[i]);
+            context->prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
             return TLBRET_MATCH;
         }
     }
@@ -249,23 +247,18 @@ int get_physical_address(CPULoongArchState *env, hwaddr *physical,
     }
 
     /* Mapped address */
-    ret = loongarch_map_address(env, &context, access_type, mmu_idx, is_debug);
-    if (ret == TLBRET_MATCH) {
-        *physical = context.physical;
-        *prot = context.prot;
-    }
-    return ret;
+    return loongarch_map_address(env, context, access_type, mmu_idx, is_debug);
 }
 
 hwaddr loongarch_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
 {
     CPULoongArchState *env = cpu_env(cs);
-    hwaddr phys_addr;
-    int prot;
+    mmu_context context;
 
-    if (get_physical_address(env, &phys_addr, &prot, addr, MMU_DATA_LOAD,
+    context.vaddr = addr;
+    if (get_physical_address(env, &context, MMU_DATA_LOAD,
                              cpu_mmu_index(cs, false), 1) != 0) {
         return -1;
     }
-    return phys_addr;
+    return context.physical;
 }
diff --git a/target/loongarch/tcg/tlb_helper.c b/target/loongarch/tcg/tlb_helper.c
index a875ac251e..d1d19c5e70 100644
--- a/target/loongarch/tcg/tlb_helper.c
+++ b/target/loongarch/tcg/tlb_helper.c
@@ -515,15 +515,17 @@ bool loongarch_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
                             bool probe, uintptr_t retaddr)
 {
     CPULoongArchState *env = cpu_env(cs);
+    mmu_context context;
     hwaddr physical;
     int prot;
     int ret;
 
     /* Data access */
-    ret = get_physical_address(env, &physical, &prot, address,
-                               access_type, mmu_idx, 0);
-
+    context.vaddr = address;
+    ret = get_physical_address(env, &context, access_type, mmu_idx, 0);
     if (ret == TLBRET_MATCH) {
+        physical = context.physical;
+        prot = context.prot;
         tlb_set_page(cs, address & TARGET_PAGE_MASK,
                      physical & TARGET_PAGE_MASK, prot,
                      mmu_idx, TARGET_PAGE_SIZE);
-- 
2.39.3


