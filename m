Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FC70C54798
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 03:52:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhLq2-00086k-Ir; Mon, 04 Mar 2024 22:51:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lixianglai@loongson.cn>)
 id 1rhLpy-00086M-U6
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 22:51:31 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lixianglai@loongson.cn>) id 1rhLpw-0001hW-Pw
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 22:51:30 -0500
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8AxqvC9luZly4sUAA--.51492S3;
 Tue, 05 Mar 2024 11:51:25 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8AxjhO3luZlTEdOAA--.20921S3; 
 Tue, 05 Mar 2024 11:51:24 +0800 (CST)
From: Xianglai Li <lixianglai@loongson.cn>
To: qemu-devel@nongnu.org
Cc: maobibo@loongson.cn, Song Gao <gaosong@loongson.cn>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>, zhaotianrui@loongson.cn
Subject: [PATCH V2 1/1] target/loongarch: Fixed tlb huge page loading issue
Date: Tue,  5 Mar 2024 11:51:11 +0800
Message-Id: <5b23421ee1ebf59142c7d7a3bc1082fff910f2fa.1709610311.git.lixianglai@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1709610311.git.lixianglai@loongson.cn>
References: <cover.1709610311.git.lixianglai@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxjhO3luZlTEdOAA--.20921S3
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
 target/loongarch/cpu.h            |  1 +
 target/loongarch/tcg/tlb_helper.c | 21 ++++++++++++---------
 2 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index ec37579fd6..eab3e41c71 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -292,6 +292,7 @@ typedef struct CPUArchState {
     uint32_t fcsr0_mask;
 
     uint32_t cpucfg[21];
+    uint32_t lddir_ps;
 
     uint64_t lladdr; /* LL virtual address compared against SC */
     uint64_t llval;
diff --git a/target/loongarch/tcg/tlb_helper.c b/target/loongarch/tcg/tlb_helper.c
index a08c08b05a..3594c800b3 100644
--- a/target/loongarch/tcg/tlb_helper.c
+++ b/target/loongarch/tcg/tlb_helper.c
@@ -38,6 +38,7 @@ static void raise_mmu_exception(CPULoongArchState *env, target_ulong address,
             cs->exception_index = EXCCODE_PIF;
         }
         env->CSR_TLBRERA = FIELD_DP64(env->CSR_TLBRERA, CSR_TLBRERA, ISTLBR, 1);
+        env->lddir_ps = 0;
         break;
     case TLBRET_INVALID:
         /* TLB match with no valid bit */
@@ -488,13 +489,6 @@ target_ulong helper_lddir(CPULoongArchState *env, target_ulong base,
     uint64_t dir_base, dir_width;
     bool huge = (base >> LOONGARCH_PAGE_HUGE_SHIFT) & 0x1;
 
-    badvaddr = env->CSR_TLBRBADV;
-    base = base & TARGET_PHYS_MASK;
-
-    /* 0:64bit, 1:128bit, 2:192bit, 3:256bit */
-    shift = FIELD_EX64(env->CSR_PWCL, CSR_PWCL, PTEWIDTH);
-    shift = (shift + 1) * 3;
-
     if (huge) {
         return base;
     }
@@ -519,9 +513,18 @@ target_ulong helper_lddir(CPULoongArchState *env, target_ulong base,
         do_raise_exception(env, EXCCODE_INE, GETPC());
         return 0;
     }
+
+    /* 0:64bit, 1:128bit, 2:192bit, 3:256bit */
+    shift = FIELD_EX64(env->CSR_PWCL, CSR_PWCL, PTEWIDTH);
+    shift = (shift + 1) * 3;
+    badvaddr = env->CSR_TLBRBADV;
+    base = base & TARGET_PHYS_MASK;
     index = (badvaddr >> dir_base) & ((1 << dir_width) - 1);
     phys = base | index << shift;
     ret = ldq_phys(cs->as, phys) & TARGET_PHYS_MASK;
+    if (ret & BIT_ULL(LOONGARCH_PAGE_HUGE_SHIFT)) {
+        env->lddir_ps = dir_base;
+    }
     return ret;
 }
 
@@ -538,13 +541,13 @@ void helper_ldpte(CPULoongArchState *env, target_ulong base, target_ulong odd,
     base = base & TARGET_PHYS_MASK;
 
     if (huge) {
-        /* Huge Page. base is paddr */
         tmp0 = base ^ (1 << LOONGARCH_PAGE_HUGE_SHIFT);
         /* Move Global bit */
         tmp0 = ((tmp0 & (1 << LOONGARCH_HGLOBAL_SHIFT))  >>
                 LOONGARCH_HGLOBAL_SHIFT) << R_TLBENTRY_G_SHIFT |
                 (tmp0 & (~(1 << LOONGARCH_HGLOBAL_SHIFT)));
-        ps = ptbase + ptwidth - 1;
+
+        ps = env->lddir_ps - 1;
         if (odd) {
             tmp0 += MAKE_64BIT_MASK(ps, 1);
         }
-- 
2.39.1


