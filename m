Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0508BC02180
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 02:19:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYFS3-0004co-PJ; Wed, 15 Jan 2025 21:17:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1tYFRz-0004b5-GB
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 21:17:39 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1tYFRv-0006CQ-2O
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 21:17:38 -0500
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8CxCeE8bIhnajJkAA--.65511S3;
 Thu, 16 Jan 2025 10:17:32 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMAx+8QnbIhnhWokAA--.14648S3;
 Thu, 16 Jan 2025 10:17:31 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, Song Gao <gaosong@loongson.cn>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Huacai Chen <chenhuacai@kernel.org>,
 Miao Hao <haomiao23s@ict.ac.cn>
Subject: [PULL 1/8] target/loongarch: Add page table walker support for
 debugger usage
Date: Thu, 16 Jan 2025 10:17:03 +0800
Message-Id: <20250116021710.251648-2-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250116021710.251648-1-maobibo@loongson.cn>
References: <20250116021710.251648-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMAx+8QnbIhnhWokAA--.14648S3
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

From: Miao Hao <haomiao23s@ict.ac.cn>

When dump memory content with gva address, software page table walker is
necessary to get responding gpa address.

Here page table walker is added for debugger usage.

Signed-off-by: Miao Hao <haomiao23s@ict.ac.cn>
Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by: Bibo Mao <maobibo@loongson.cn>
---
 target/loongarch/cpu_helper.c     | 94 +++++++++++++++++++++++++++++--
 target/loongarch/internals.h      |  4 +-
 target/loongarch/tcg/tlb_helper.c |  4 +-
 3 files changed, 94 insertions(+), 8 deletions(-)

diff --git a/target/loongarch/cpu_helper.c b/target/loongarch/cpu_helper.c
index 580362ac3e..930466ca48 100644
--- a/target/loongarch/cpu_helper.c
+++ b/target/loongarch/cpu_helper.c
@@ -141,9 +141,85 @@ bool loongarch_tlb_search(CPULoongArchState *env, target_ulong vaddr,
     return false;
 }
 
+static int loongarch_page_table_walker(CPULoongArchState *env, hwaddr *physical,
+                                 int *prot, target_ulong address)
+{
+    CPUState *cs = env_cpu(env);
+    target_ulong index, phys;
+    uint64_t dir_base, dir_width;
+    uint64_t base;
+    int level;
+
+    if ((address >> 63) & 0x1) {
+        base = env->CSR_PGDH;
+    } else {
+        base = env->CSR_PGDL;
+    }
+    base &= TARGET_PHYS_MASK;
+
+    for (level = 4; level > 0; level--) {
+        get_dir_base_width(env, &dir_base, &dir_width, level);
+
+        if (dir_width == 0) {
+            continue;
+        }
+
+        /* get next level page directory */
+        index = (address >> dir_base) & ((1 << dir_width) - 1);
+        phys = base | index << 3;
+        base = ldq_phys(cs->as, phys) & TARGET_PHYS_MASK;
+        if (FIELD_EX64(base, TLBENTRY, HUGE)) {
+            /* base is a huge pte */
+            break;
+        }
+    }
+
+    /* pte */
+    if (FIELD_EX64(base, TLBENTRY, HUGE)) {
+        /* Huge Page. base is pte */
+        base = FIELD_DP64(base, TLBENTRY, LEVEL, 0);
+        base = FIELD_DP64(base, TLBENTRY, HUGE, 0);
+        if (FIELD_EX64(base, TLBENTRY, HGLOBAL)) {
+            base = FIELD_DP64(base, TLBENTRY, HGLOBAL, 0);
+            base = FIELD_DP64(base, TLBENTRY, G, 1);
+        }
+    } else {
+        /* Normal Page. base points to pte */
+        get_dir_base_width(env, &dir_base, &dir_width, 0);
+        index = (address >> dir_base) & ((1 << dir_width) - 1);
+        phys = base | index << 3;
+        base = ldq_phys(cs->as, phys);
+    }
+
+    /* TODO: check plv and other bits? */
+
+    /* base is pte, in normal pte format */
+    if (!FIELD_EX64(base, TLBENTRY, V)) {
+        return TLBRET_NOMATCH;
+    }
+
+    if (!FIELD_EX64(base, TLBENTRY, D)) {
+        *prot = PAGE_READ;
+    } else {
+        *prot = PAGE_READ | PAGE_WRITE;
+    }
+
+    /* get TARGET_PAGE_SIZE aligned physical address */
+    base += (address & TARGET_PHYS_MASK) & ((1 << dir_base) - 1);
+    /* mask RPLV, NX, NR bits */
+    base = FIELD_DP64(base, TLBENTRY_64, RPLV, 0);
+    base = FIELD_DP64(base, TLBENTRY_64, NX, 0);
+    base = FIELD_DP64(base, TLBENTRY_64, NR, 0);
+    /* mask other attribute bits */
+    *physical = base & TARGET_PAGE_MASK;
+
+    return 0;
+}
+
 static int loongarch_map_address(CPULoongArchState *env, hwaddr *physical,
                                  int *prot, target_ulong address,
-                                 MMUAccessType access_type, int mmu_idx)
+                                 MMUAccessType access_type, int mmu_idx,
+                                 int is_debug)
 {
     int index, match;
 
@@ -151,6 +227,13 @@ static int loongarch_map_address(CPULoongArchState *env, hwaddr *physical,
     if (match) {
         return loongarch_map_tlb_entry(env, physical, prot,
                                        address, access_type, index, mmu_idx);
+    } else if (is_debug) {
+        /*
+         * For debugger memory access, we want to do the map when there is a
+         * legal mapping, even if the mapping is not yet in TLB. return 0 if
+         * there is a valid map, else none zero.
+         */
+        return loongarch_page_table_walker(env, physical, prot, address);
     }
 
     return TLBRET_NOMATCH;
@@ -158,7 +241,8 @@ static int loongarch_map_address(CPULoongArchState *env, hwaddr *physical,
 #else
 static int loongarch_map_address(CPULoongArchState *env, hwaddr *physical,
                                  int *prot, target_ulong address,
-                                 MMUAccessType access_type, int mmu_idx)
+                                 MMUAccessType access_type, int mmu_idx,
+                                 int is_debug)
 {
     return TLBRET_NOMATCH;
 }
@@ -178,7 +262,7 @@ static hwaddr dmw_va2pa(CPULoongArchState *env, target_ulong va,
 
 int get_physical_address(CPULoongArchState *env, hwaddr *physical,
                          int *prot, target_ulong address,
-                         MMUAccessType access_type, int mmu_idx)
+                         MMUAccessType access_type, int mmu_idx, int is_debug)
 {
     int user_mode = mmu_idx == MMU_USER_IDX;
     int kernel_mode = mmu_idx == MMU_KERNEL_IDX;
@@ -222,7 +306,7 @@ int get_physical_address(CPULoongArchState *env, hwaddr *physical,
 
     /* Mapped address */
     return loongarch_map_address(env, physical, prot, address,
-                                 access_type, mmu_idx);
+                                 access_type, mmu_idx, is_debug);
 }
 
 hwaddr loongarch_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
@@ -232,7 +316,7 @@ hwaddr loongarch_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
     int prot;
 
     if (get_physical_address(env, &phys_addr, &prot, addr, MMU_DATA_LOAD,
-                             cpu_mmu_index(cs, false)) != 0) {
+                             cpu_mmu_index(cs, false), 1) != 0) {
         return -1;
     }
     return phys_addr;
diff --git a/target/loongarch/internals.h b/target/loongarch/internals.h
index ad9cf4fc7a..7b254c5f49 100644
--- a/target/loongarch/internals.h
+++ b/target/loongarch/internals.h
@@ -56,7 +56,9 @@ bool loongarch_tlb_search(CPULoongArchState *env, target_ulong vaddr,
                           int *index);
 int get_physical_address(CPULoongArchState *env, hwaddr *physical,
                          int *prot, target_ulong address,
-                         MMUAccessType access_type, int mmu_idx);
+                         MMUAccessType access_type, int mmu_idx, int is_debug);
+void get_dir_base_width(CPULoongArchState *env, uint64_t *dir_base,
+                               uint64_t *dir_width, target_ulong level);
 hwaddr loongarch_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
 
 #ifdef CONFIG_TCG
diff --git a/target/loongarch/tcg/tlb_helper.c b/target/loongarch/tcg/tlb_helper.c
index 8c61fe728c..a323606e5a 100644
--- a/target/loongarch/tcg/tlb_helper.c
+++ b/target/loongarch/tcg/tlb_helper.c
@@ -18,7 +18,7 @@
 #include "exec/log.h"
 #include "cpu-csr.h"
 
-static void get_dir_base_width(CPULoongArchState *env, uint64_t *dir_base,
+void get_dir_base_width(CPULoongArchState *env, uint64_t *dir_base,
                                uint64_t *dir_width, target_ulong level)
 {
     switch (level) {
@@ -485,7 +485,7 @@ bool loongarch_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
 
     /* Data access */
     ret = get_physical_address(env, &physical, &prot, address,
-                               access_type, mmu_idx);
+                               access_type, mmu_idx, 0);
 
     if (ret == TLBRET_MATCH) {
         tlb_set_page(cs, address & TARGET_PAGE_MASK,
-- 
2.43.5


