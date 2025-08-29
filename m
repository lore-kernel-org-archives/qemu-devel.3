Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0857BCA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 15:10:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usN3g-0001qm-A8; Sat, 30 Aug 2025 11:00:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1urpHC-0008TA-2j
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 22:55:42 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1urpH8-0007B5-3y
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 22:55:40 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8AxidGYFrFov24EAA--.8862S3;
 Fri, 29 Aug 2025 10:55:20 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowJDxbMGMFrFoKstvAA--.33085S16;
 Fri, 29 Aug 2025 10:55:20 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 14/14] target/loongarch: Use correct address when flush tlb
Date: Fri, 29 Aug 2025 10:55:07 +0800
Message-Id: <20250829025507.2315073-15-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250829025507.2315073-1-maobibo@loongson.cn>
References: <20250829025507.2315073-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJDxbMGMFrFoKstvAA--.33085S16
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

With tlb_flush_range_by_mmuidx(), the virtual address is 64 bit.
However on LoongArch TLB emulation system, virtual address is
48 bit. It is necessary to signed-extend 48 bit address to 64 bit when
flush tlb, also fix address calculation issue with odd page.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/loongarch/tcg/tlb_helper.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/loongarch/tcg/tlb_helper.c b/target/loongarch/tcg/tlb_helper.c
index 7d3f98633d..9365860c8c 100644
--- a/target/loongarch/tcg/tlb_helper.c
+++ b/target/loongarch/tcg/tlb_helper.c
@@ -115,16 +115,16 @@ static void invalidate_tlb_entry(CPULoongArchState *env, int index)
     tlb_ps = FIELD_EX64(tlb->tlb_misc, TLB_MISC, PS);
     pagesize = MAKE_64BIT_MASK(tlb_ps, 1);
     mask = MAKE_64BIT_MASK(0, tlb_ps + 1);
+    addr = (tlb_vppn << R_TLB_MISC_VPPN_SHIFT) & ~mask;
+    addr = sextract64(addr, 0, TARGET_VIRT_ADDR_SPACE_BITS);
 
     if (tlb_v0) {
-        addr = (tlb_vppn << R_TLB_MISC_VPPN_SHIFT) & ~mask;    /* even */
         tlb_flush_range_by_mmuidx(env_cpu(env), addr, pagesize,
                                   mmu_idx, TARGET_LONG_BITS);
     }
 
     if (tlb_v1) {
-        addr = (tlb_vppn << R_TLB_MISC_VPPN_SHIFT) & pagesize;    /* odd */
-        tlb_flush_range_by_mmuidx(env_cpu(env), addr, pagesize,
+        tlb_flush_range_by_mmuidx(env_cpu(env), addr + pagesize, pagesize,
                                   mmu_idx, TARGET_LONG_BITS);
     }
 }
-- 
2.43.5


