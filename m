Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CDB7C48BF6
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 07:37:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ri8Jn-0007Gz-60; Thu, 07 Mar 2024 02:37:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lixianglai@loongson.cn>)
 id 1ri8Ji-0007Bp-A3
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 02:37:27 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lixianglai@loongson.cn>) id 1ri8Jg-000523-7Y
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 02:37:26 -0500
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8BxXeutbullx7AVAA--.53831S3;
 Thu, 07 Mar 2024 15:37:17 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8Dxfs2qbulld+9PAA--.14088S3; 
 Thu, 07 Mar 2024 15:37:15 +0800 (CST)
From: Xianglai Li <lixianglai@loongson.cn>
To: qemu-devel@nongnu.org
Cc: maobibo@loongson.cn, Song Gao <gaosong@loongson.cn>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>, zhaotianrui@loongson.cn
Subject: [PATCH V3 1/1] target/loongarch: Fixed tlb huge page loading issue
Date: Thu,  7 Mar 2024 15:37:03 +0800
Message-Id: <de249feeab14b46d4b7bd842335a4e6e4b654681.1709796364.git.lixianglai@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1709796364.git.lixianglai@loongson.cn>
References: <cover.1709796364.git.lixianglai@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Dxfs2qbulld+9PAA--.14088S3
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

Signed-off-by: Xianglai Li <lixianglai@loongson.cn>
Cc: maobibo@loongson.cn
Cc: Song Gao <gaosong@loongson.cn>
Cc: Xiaojuan Yang <yangxiaojuan@loongson.cn>
Cc: zhaotianrui@loongson.cn
---
 target/loongarch/internals.h      |  8 +++
 target/loongarch/tcg/tlb_helper.c | 92 +++++++++++++++++++++++--------
 2 files changed, 76 insertions(+), 24 deletions(-)

diff --git a/target/loongarch/internals.h b/target/loongarch/internals.h
index a2fc54c8a7..55ceb4c079 100644
--- a/target/loongarch/internals.h
+++ b/target/loongarch/internals.h
@@ -16,6 +16,14 @@
 #define TARGET_PHYS_MASK MAKE_64BIT_MASK(0, TARGET_PHYS_ADDR_SPACE_BITS)
 #define TARGET_VIRT_MASK MAKE_64BIT_MASK(0, TARGET_VIRT_ADDR_SPACE_BITS)
 
+/*
+ * The [13..14]bits of the entry base address of the lddir/ldpte
+ * directive are used to represent the level of the large page
+ * when processing the huge page entry
+ */
+#define HUGE_PAGE_LEVEL_SHIFT   13
+#define HUGE_PAGE_LEVEL_MASK MAKE_64BIT_MASK(HUGE_PAGE_LEVEL_SHIFT, 2)
+
 /* Global bit used for lddir/ldpte */
 #define LOONGARCH_PAGE_HUGE_SHIFT   6
 /* Global bit for huge page */
diff --git a/target/loongarch/tcg/tlb_helper.c b/target/loongarch/tcg/tlb_helper.c
index a08c08b05a..2db77b48c5 100644
--- a/target/loongarch/tcg/tlb_helper.c
+++ b/target/loongarch/tcg/tlb_helper.c
@@ -17,6 +17,9 @@
 #include "exec/log.h"
 #include "cpu-csr.h"
 
+static int get_dir_base_width(CPULoongArchState *env, uint64_t *dir_base,
+                              uint64_t *dir_width, target_ulong level);
+
 static void raise_mmu_exception(CPULoongArchState *env, target_ulong address,
                                 MMUAccessType access_type, int tlb_error)
 {
@@ -487,6 +490,16 @@ target_ulong helper_lddir(CPULoongArchState *env, target_ulong base,
     int shift;
     uint64_t dir_base, dir_width;
     bool huge = (base >> LOONGARCH_PAGE_HUGE_SHIFT) & 0x1;
+    uint64_t huge_page_level = base & HUGE_PAGE_LEVEL_MASK;
+
+    if (huge) {
+        if (huge_page_level) {
+            return base;
+        } else {
+            huge_page_level = (level & 0x3) << HUGE_PAGE_LEVEL_SHIFT;
+            return base | huge_page_level;
+        }
+    }
 
     badvaddr = env->CSR_TLBRBADV;
     base = base & TARGET_PHYS_MASK;
@@ -495,30 +508,10 @@ target_ulong helper_lddir(CPULoongArchState *env, target_ulong base,
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
+    if (get_dir_base_width(env, &dir_base, &dir_width, level) != 0) {
         return 0;
     }
+
     index = (badvaddr >> dir_base) & ((1 << dir_width) - 1);
     phys = base | index << shift;
     ret = ldq_phys(cs->as, phys) & TARGET_PHYS_MASK;
@@ -534,17 +527,38 @@ void helper_ldpte(CPULoongArchState *env, target_ulong base, target_ulong odd,
     bool huge = (base >> LOONGARCH_PAGE_HUGE_SHIFT) & 0x1;
     uint64_t ptbase = FIELD_EX64(env->CSR_PWCL, CSR_PWCL, PTBASE);
     uint64_t ptwidth = FIELD_EX64(env->CSR_PWCL, CSR_PWCL, PTWIDTH);
+    uint64_t dir_base, dir_width;
+    uint64_t huge_page_level;
 
     base = base & TARGET_PHYS_MASK;
 
     if (huge) {
-        /* Huge Page. base is paddr */
+        /*
+         * Gets the huge page level
+         * Clears the huge page level information in the address
+         * Clears huge page bit
+         * Gets huge page size
+         */
+        huge_page_level = (base & HUGE_PAGE_LEVEL_MASK) >>
+                          HUGE_PAGE_LEVEL_SHIFT;
+
+        base &= ~HUGE_PAGE_LEVEL_MASK;
+
         tmp0 = base ^ (1 << LOONGARCH_PAGE_HUGE_SHIFT);
         /* Move Global bit */
         tmp0 = ((tmp0 & (1 << LOONGARCH_HGLOBAL_SHIFT))  >>
                 LOONGARCH_HGLOBAL_SHIFT) << R_TLBENTRY_G_SHIFT |
                 (tmp0 & (~(1 << LOONGARCH_HGLOBAL_SHIFT)));
-        ps = ptbase + ptwidth - 1;
+
+        huge_page_level++;
+        get_dir_base_width(env, &dir_base, &dir_width, huge_page_level);
+
+        /*
+         * Huge pages are evenly split into parity pages
+         * when loaded into the tlb,
+         * so the tlb page size needs to be divided by 2.
+         */
+        ps = dir_base - 1;
         if (odd) {
             tmp0 += MAKE_64BIT_MASK(ps, 1);
         }
@@ -571,3 +585,33 @@ void helper_ldpte(CPULoongArchState *env, target_ulong base, target_ulong odd,
     }
     env->CSR_TLBREHI = FIELD_DP64(env->CSR_TLBREHI, CSR_TLBREHI, PS, ps);
 }
+
+static int get_dir_base_width(CPULoongArchState *env, uint64_t *dir_base,
+                              uint64_t *dir_width, target_ulong level)
+{
+    int ret = 0;
+
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
+        do_raise_exception(env, EXCCODE_INE, GETPC());
+        ret = -1;
+    }
+
+    return ret;
+}
-- 
2.39.1


