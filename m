Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE8CAC54E66
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Mar 2024 01:34:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkZz3-000184-2B; Wed, 13 Mar 2024 21:34:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lixianglai@loongson.cn>)
 id 1rkZyw-00017n-0e
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 21:34:06 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lixianglai@loongson.cn>) id 1rkZyo-0004PX-Fi
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 21:34:05 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8Axuuj+U_JlB+0YAA--.40496S3;
 Thu, 14 Mar 2024 09:33:50 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8Ax3c79U_Jl3GJZAA--.38291S2; 
 Thu, 14 Mar 2024 09:33:49 +0800 (CST)
From: Xianglai Li <lixianglai@loongson.cn>
To: qemu-devel@nongnu.org
Cc: maobibo@loongson.cn, Song Gao <gaosong@loongson.cn>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>, zhaotianrui@loongson.cn,
 yijun@loongson.cn, wuruiyang@loongson.cn
Subject: [PATCH V4 1/1] target/loongarch: Fixed tlb huge page loading issue
Date: Thu, 14 Mar 2024 09:33:44 +0800
Message-Id: <0e940b2aee9a5c29bb41d6a9611955482d250325.1710379781.git.lixianglai@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1710379781.git.lixianglai@loongson.cn>
References: <cover.1710379781.git.lixianglai@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Ax3c79U_Jl3GJZAA--.38291S2
X-CM-SenderInfo: 5ol0xt5qjotxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163;
 envelope-from=lixianglai@loongson.cn; helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

When we use qemu tcg simulation, the page size of bios is 4KB.
When using the level 2 super large page (page size is 1G) to create the page table,
it is found that the content of the corresponding address space is abnormal,
resulting in the bios can not start the operating system and graphical interface normally.

The lddir and ldpte instruction emulation has
a problem with the use of super large page processing above level 2.
The page size is not correctly calculated,
resulting in the wrong page size of the table entry found by tlb.

Cc: maobibo@loongson.cn
Cc: Song Gao <gaosong@loongson.cn>
Cc: Xiaojuan Yang <yangxiaojuan@loongson.cn>
Cc: zhaotianrui@loongson.cn
Cc: yijun@loongson.cn
Cc: wuruiyang@loongson.cn

Signed-off-by: Xianglai Li <lixianglai@loongson.cn>
---
 target/loongarch/cpu-csr.h        |   3 +
 target/loongarch/internals.h      |   5 --
 target/loongarch/tcg/tlb_helper.c | 105 ++++++++++++++++++++----------
 3 files changed, 74 insertions(+), 39 deletions(-)

Changes log:
V3->V4:
Optimize the huge page calculation method,
use the FIELD macro for bit calculation.

V2->V3:
Delete the intermediate variable LDDIR_PS, and implement lddir and ldpte
huge pages by referring to the latest architecture reference manual.

V1->V2:
Modified the patch title format and Enrich the commit mesg description

diff --git a/target/loongarch/cpu-csr.h b/target/loongarch/cpu-csr.h
index c59d7a9fcb..b0775cf6bf 100644
--- a/target/loongarch/cpu-csr.h
+++ b/target/loongarch/cpu-csr.h
@@ -67,6 +67,9 @@ FIELD(TLBENTRY, D, 1, 1)
 FIELD(TLBENTRY, PLV, 2, 2)
 FIELD(TLBENTRY, MAT, 4, 2)
 FIELD(TLBENTRY, G, 6, 1)
+FIELD(TLBENTRY, HUGE, 6, 1)
+FIELD(TLBENTRY, HG, 12, 1)
+FIELD(TLBENTRY, LEVEL, 13, 2)
 FIELD(TLBENTRY_32, PPN, 8, 24)
 FIELD(TLBENTRY_64, PPN, 12, 36)
 FIELD(TLBENTRY_64, NR, 61, 1)
diff --git a/target/loongarch/internals.h b/target/loongarch/internals.h
index a2fc54c8a7..944153b180 100644
--- a/target/loongarch/internals.h
+++ b/target/loongarch/internals.h
@@ -16,11 +16,6 @@
 #define TARGET_PHYS_MASK MAKE_64BIT_MASK(0, TARGET_PHYS_ADDR_SPACE_BITS)
 #define TARGET_VIRT_MASK MAKE_64BIT_MASK(0, TARGET_VIRT_ADDR_SPACE_BITS)
 
-/* Global bit used for lddir/ldpte */
-#define LOONGARCH_PAGE_HUGE_SHIFT   6
-/* Global bit for huge page */
-#define LOONGARCH_HGLOBAL_SHIFT     12
-
 void loongarch_translate_init(void);
 
 void loongarch_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
diff --git a/target/loongarch/tcg/tlb_helper.c b/target/loongarch/tcg/tlb_helper.c
index 22be031ac7..b9a8633791 100644
--- a/target/loongarch/tcg/tlb_helper.c
+++ b/target/loongarch/tcg/tlb_helper.c
@@ -17,6 +17,34 @@
 #include "exec/log.h"
 #include "cpu-csr.h"
 
+static void get_dir_base_width(CPULoongArchState *env, uint64_t *dir_base,
+                               uint64_t *dir_width, target_ulong level)
+{
+    switch (level) {
+    case 1:
+        *dir_base = FIELD_EX64(env->CSR_PWCL, CSR_PWCL, DIR1_BASE);
+        *dir_width = FIELD_EX64(env->CSR_PWCL, CSR_PWCL, DIR1_WIDTH);
+        break;
+    case 2:
+        *dir_base = FIELD_EX64(env->CSR_PWCL, CSR_PWCL, DIR2_BASE);
+        *dir_width = FIELD_EX64(env->CSR_PWCL, CSR_PWCL, DIR2_WIDTH);
+        break;
+    case 3:
+        *dir_base = FIELD_EX64(env->CSR_PWCH, CSR_PWCH, DIR3_BASE);
+        *dir_width = FIELD_EX64(env->CSR_PWCH, CSR_PWCH, DIR3_WIDTH);
+        break;
+    case 4:
+        *dir_base = FIELD_EX64(env->CSR_PWCH, CSR_PWCH, DIR4_BASE);
+        *dir_width = FIELD_EX64(env->CSR_PWCH, CSR_PWCH, DIR4_WIDTH);
+        break;
+    default:
+        /* level may be zero for ldpte */
+        *dir_base = FIELD_EX64(env->CSR_PWCL, CSR_PWCL, PTBASE);
+        *dir_width = FIELD_EX64(env->CSR_PWCL, CSR_PWCL, PTWIDTH);
+        break;
+    }
+}
+
 static void raise_mmu_exception(CPULoongArchState *env, target_ulong address,
                                 MMUAccessType access_type, int tlb_error)
 {
@@ -485,7 +513,23 @@ target_ulong helper_lddir(CPULoongArchState *env, target_ulong base,
     target_ulong badvaddr, index, phys, ret;
     int shift;
     uint64_t dir_base, dir_width;
-    bool huge = (base >> LOONGARCH_PAGE_HUGE_SHIFT) & 0x1;
+
+    if (unlikely((level == 0) || (level > 4))) {
+        return base;
+    }
+
+    if (FIELD_EX64(base, TLBENTRY, HUGE)) {
+        if (FIELD_EX64(base, TLBENTRY, LEVEL)) {
+            return base;
+        } else {
+            return  FIELD_DP64(base, TLBENTRY, LEVEL, level);
+        }
+
+        if (unlikely(level == 4)) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "Attempted use of level %lu huge page\n", level);
+        }
+    }
 
     badvaddr = env->CSR_TLBRBADV;
     base = base & TARGET_PHYS_MASK;
@@ -494,33 +538,12 @@ target_ulong helper_lddir(CPULoongArchState *env, target_ulong base,
     shift = FIELD_EX64(env->CSR_PWCL, CSR_PWCL, PTEWIDTH);
     shift = (shift + 1) * 3;
 
-    if (huge) {
-        return base;
-    }
-    switch (level) {
-    case 1:
-        dir_base = FIELD_EX64(env->CSR_PWCL, CSR_PWCL, DIR1_BASE);
-        dir_width = FIELD_EX64(env->CSR_PWCL, CSR_PWCL, DIR1_WIDTH);
-        break;
-    case 2:
-        dir_base = FIELD_EX64(env->CSR_PWCL, CSR_PWCL, DIR2_BASE);
-        dir_width = FIELD_EX64(env->CSR_PWCL, CSR_PWCL, DIR2_WIDTH);
-        break;
-    case 3:
-        dir_base = FIELD_EX64(env->CSR_PWCH, CSR_PWCH, DIR3_BASE);
-        dir_width = FIELD_EX64(env->CSR_PWCH, CSR_PWCH, DIR3_WIDTH);
-        break;
-    case 4:
-        dir_base = FIELD_EX64(env->CSR_PWCH, CSR_PWCH, DIR4_BASE);
-        dir_width = FIELD_EX64(env->CSR_PWCH, CSR_PWCH, DIR4_WIDTH);
-        break;
-    default:
-        do_raise_exception(env, EXCCODE_INE, GETPC());
-        return 0;
-    }
+    get_dir_base_width(env, &dir_base, &dir_width, level);
+
     index = (badvaddr >> dir_base) & ((1 << dir_width) - 1);
     phys = base | index << shift;
     ret = ldq_phys(cs->as, phys) & TARGET_PHYS_MASK;
+
     return ret;
 }
 
@@ -530,20 +553,34 @@ void helper_ldpte(CPULoongArchState *env, target_ulong base, target_ulong odd,
     CPUState *cs = env_cpu(env);
     target_ulong phys, tmp0, ptindex, ptoffset0, ptoffset1, ps, badv;
     int shift;
-    bool huge = (base >> LOONGARCH_PAGE_HUGE_SHIFT) & 0x1;
     uint64_t ptbase = FIELD_EX64(env->CSR_PWCL, CSR_PWCL, PTBASE);
     uint64_t ptwidth = FIELD_EX64(env->CSR_PWCL, CSR_PWCL, PTWIDTH);
+    uint64_t dir_base, dir_width;
 
     base = base & TARGET_PHYS_MASK;
+    if (FIELD_EX64(base, TLBENTRY, HUGE)) {
+        /*
+         * Gets the huge page level and Gets huge page size
+         * Clears the huge page level information in the address
+         * Clears huge page bit
+         */
+        get_dir_base_width(env, &dir_base, &dir_width,
+                           FIELD_EX64(base, TLBENTRY, LEVEL));
+
+        FIELD_DP64(base, TLBENTRY, LEVEL, 0);
+        FIELD_DP64(base, TLBENTRY, HUGE, 0);
+        if (FIELD_EX64(base, TLBENTRY, HG)) {
+            FIELD_DP64(base, TLBENTRY, HG, 0);
+            FIELD_DP64(base, TLBENTRY, G, 1);
+        }
 
-    if (huge) {
-        /* Huge Page. base is paddr */
-        tmp0 = base ^ (1 << LOONGARCH_PAGE_HUGE_SHIFT);
-        /* Move Global bit */
-        tmp0 = ((tmp0 & (1 << LOONGARCH_HGLOBAL_SHIFT))  >>
-                LOONGARCH_HGLOBAL_SHIFT) << R_TLBENTRY_G_SHIFT |
-                (tmp0 & (~(1 << LOONGARCH_HGLOBAL_SHIFT)));
-        ps = ptbase + ptwidth - 1;
+        /*
+         * Huge pages are evenly split into parity pages
+         * when loaded into the tlb,
+         * so the tlb page size needs to be divided by 2.
+         */
+        ps = dir_base + dir_width - 1;
+        tmp0 = base;
         if (odd) {
             tmp0 += MAKE_64BIT_MASK(ps, 1);
         }
-- 
2.39.1


