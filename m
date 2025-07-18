Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71A12C83F1A
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Jul 2025 07:43:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucfjb-00034E-30; Fri, 18 Jul 2025 03:42:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1ucfW5-0002eD-FQ
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 03:28:25 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1ucfW0-0002jm-Rb
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 03:28:25 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8CxG6yN93loz8ksAQ--.51423S3;
 Fri, 18 Jul 2025 15:28:13 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowJCxocKI93lo0QwcAA--.17387S10;
 Fri, 18 Jul 2025 15:28:13 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v2 8/9] target/loongarch: Use correct page size when flush tlb
Date: Fri, 18 Jul 2025 15:28:06 +0800
Message-Id: <20250718072807.3585466-9-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250718072807.3585466-1-maobibo@loongson.cn>
References: <20250718072807.3585466-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJCxocKI93lo0QwcAA--.17387S10
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

On LoongArch system, there are two pages with one TLB entry. If the
whole TLB entry is flushed, two pages will be flushed. Otherwise if
tlb is flushed one by one, page size is one page at a time.

Also virtual address of odd page is fixed here.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 target/loongarch/tcg/tlb_helper.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/target/loongarch/tcg/tlb_helper.c b/target/loongarch/tcg/tlb_helper.c
index 76ec469341..47eb3ee318 100644
--- a/target/loongarch/tcg/tlb_helper.c
+++ b/target/loongarch/tcg/tlb_helper.c
@@ -112,20 +112,19 @@ static void invalidate_tlb_entry(CPULoongArchState *env, int index)
     }
 
     tlb_ps = FIELD_EX64(tlb->tlb_misc, TLB_MISC, PS);
-    pagesize = MAKE_64BIT_MASK(tlb_ps, 1);
-    mask = MAKE_64BIT_MASK(0, tlb_ps + 1);
+    pagesize = BIT_ULL(tlb_ps);
+    mask = ~((pagesize << 1) - 1) & TARGET_VIRT_MASK;
+    addr = (tlb_vppn << R_TLB_MISC_VPPN_SHIFT) & mask;
 
     if (tlb_v0) {
-        addr = (tlb_vppn << R_TLB_MISC_VPPN_SHIFT) & ~mask;    /* even */
         mmu_idx = BIT(FIELD_EX64(tlb->tlb_entry0, TLBENTRY, PLV));
         tlb_flush_range_by_mmuidx(env_cpu(env), addr, pagesize,
                                   mmu_idx, TARGET_LONG_BITS);
     }
 
     if (tlb_v1) {
-        addr = (tlb_vppn << R_TLB_MISC_VPPN_SHIFT) & pagesize;    /* odd */
         mmu_idx = BIT(FIELD_EX64(tlb->tlb_entry1, TLBENTRY, PLV));
-        tlb_flush_range_by_mmuidx(env_cpu(env), addr, pagesize,
+        tlb_flush_range_by_mmuidx(env_cpu(env), addr + pagesize, pagesize,
                                   mmu_idx, TARGET_LONG_BITS);
     }
 }
-- 
2.39.3


