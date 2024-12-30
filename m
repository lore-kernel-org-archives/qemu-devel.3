Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E7F3E77188
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Dec 2024 07:10:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tS9v0-0005hC-EX; Mon, 30 Dec 2024 02:10:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <haomiao23s@ict.ac.cn>)
 id 1tS9uy-0005gk-7o
 for qemu-devel@nongnu.org; Mon, 30 Dec 2024 02:10:24 -0500
Received: from smtp81.cstnet.cn ([159.226.251.81] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <haomiao23s@ict.ac.cn>)
 id 1tS9uv-0004GI-P1
 for qemu-devel@nongnu.org; Mon, 30 Dec 2024 02:10:23 -0500
Received: from haooops-ThinkPad-P15v-Gen-1.. (unknown [159.226.43.8])
 by APP-03 (Coremail) with SMTP id rQCowAA3IDNUR3JnLFu+BA--.24940S2;
 Mon, 30 Dec 2024 15:10:12 +0800 (CST)
From: Miao Hao <haomiao23s@ict.ac.cn>
To: gaosong@loongson.cn
Cc: qemu-devel@nongnu.org,
	Miao Hao <haomiao23s@ict.ac.cn>
Subject: [PATCH v2] feat: add loongarch page table walker support for debugger
 memory access
Date: Mon, 30 Dec 2024 15:10:09 +0800
Message-Id: <20241230071009.140412-1-haomiao23s@ict.ac.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowAA3IDNUR3JnLFu+BA--.24940S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Jw4fAFykKF4xJFWfZF17trb_yoWxAF4rpr
 yxCrWayF48KrZ3Aasav390vFn8ur4akw4a9ayfKF9Ykw45XryfZFW0q3sxJF48J3y8Ww42
 gan8AF15Ca4UXFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUkq14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
 6r4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r
 xl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
 6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr
 0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkIecxEwVAFwVW8
 CwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r
 1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIxkGc2Ij
 64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr
 0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF
 0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUjVc_3UUUUU==
X-Originating-IP: [159.226.43.8]
X-CM-SenderInfo: 5kdrzx1drsj2g6lf3hldfou0/
Received-SPF: pass client-ip=159.226.251.81; envelope-from=haomiao23s@ict.ac.cn;
 helo=cstnet.cn
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Miao Hao <haomiao23s@ict.ac.cn>
---
  v1 -> v2:
    1. Addressed review comments.
    2. Fix the assignment of variable shift.

 target/loongarch/cpu_helper.c     | 106 ++++++++++++++++++++++++++++--
 target/loongarch/internals.h      |   4 +-
 target/loongarch/tcg/tlb_helper.c |   4 +-
 3 files changed, 106 insertions(+), 8 deletions(-)

diff --git a/target/loongarch/cpu_helper.c b/target/loongarch/cpu_helper.c
index 580362ac3e..9de7abfebf 100644
--- a/target/loongarch/cpu_helper.c
+++ b/target/loongarch/cpu_helper.c
@@ -141,9 +141,97 @@ bool loongarch_tlb_search(CPULoongArchState *env, target_ulong vaddr,
     return false;
 }
 
+static int loongarch_page_table_walker(CPULoongArchState *env, hwaddr *physical,
+                                 int *prot, target_ulong address)
+{
+    CPUState *cs = env_cpu(env);
+    target_ulong index, phys;
+    int shift;
+    uint64_t dir_base, dir_width;
+    uint64_t base;
+    int level;
+
+    /* 0:64bit, 1:128bit, 2:256bit, 3:512bit */
+    shift = FIELD_EX64(env->CSR_PWCL, CSR_PWCL, PTEWIDTH);
+    shift = shift + 3;
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
+        phys = base | index << shift;
+        base = ldq_phys(cs->as, phys) & TARGET_PHYS_MASK;
+        if (!FIELD_EX64(base, TLBENTRY, HUGE)) {
+            /* mask off page dir permission bits */
+            base &= TARGET_PAGE_MASK;
+        } else {
+            /* base is a huge pte */
+            break;
+        }
+
+        if (base == 0) {
+            return TLBRET_NOMATCH;
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
+        phys = base | index << shift;
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
 
@@ -151,6 +239,13 @@ static int loongarch_map_address(CPULoongArchState *env, hwaddr *physical,
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
@@ -158,7 +253,8 @@ static int loongarch_map_address(CPULoongArchState *env, hwaddr *physical,
 #else
 static int loongarch_map_address(CPULoongArchState *env, hwaddr *physical,
                                  int *prot, target_ulong address,
-                                 MMUAccessType access_type, int mmu_idx)
+                                 MMUAccessType access_type, int mmu_idx,
+                                 int is_debug)
 {
     return TLBRET_NOMATCH;
 }
@@ -178,7 +274,7 @@ static hwaddr dmw_va2pa(CPULoongArchState *env, target_ulong va,
 
 int get_physical_address(CPULoongArchState *env, hwaddr *physical,
                          int *prot, target_ulong address,
-                         MMUAccessType access_type, int mmu_idx)
+                         MMUAccessType access_type, int mmu_idx, int is_debug)
 {
     int user_mode = mmu_idx == MMU_USER_IDX;
     int kernel_mode = mmu_idx == MMU_KERNEL_IDX;
@@ -222,7 +318,7 @@ int get_physical_address(CPULoongArchState *env, hwaddr *physical,
 
     /* Mapped address */
     return loongarch_map_address(env, physical, prot, address,
-                                 access_type, mmu_idx);
+                                 access_type, mmu_idx, is_debug);
 }
 
 hwaddr loongarch_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
@@ -232,7 +328,7 @@ hwaddr loongarch_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
     int prot;
 
     if (get_physical_address(env, &phys_addr, &prot, addr, MMU_DATA_LOAD,
-                             cpu_mmu_index(cs, false)) != 0) {
+                             cpu_mmu_index(cs, false), 1) != 0) {
         return -1;
     }
     return phys_addr;
diff --git a/target/loongarch/internals.h b/target/loongarch/internals.h
index 1a02427627..bc2ca30746 100644
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
index 97f38fc391..564f336df9 100644
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
2.34.1


