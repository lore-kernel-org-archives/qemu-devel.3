Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06A6ECAC580
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Sep 2025 07:11:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uun4Y-0000dP-91; Sat, 06 Sep 2025 03:10:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1uun4W-0000d7-PF
 for qemu-devel@nongnu.org; Sat, 06 Sep 2025 03:10:52 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1uun4N-0004b2-Cg
 for qemu-devel@nongnu.org; Sat, 06 Sep 2025 03:10:52 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8CxbNJv3rtoNFkHAA--.15686S3;
 Sat, 06 Sep 2025 15:10:39 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowJAxQMJv3rto8aaBAA--.11354S2;
 Sat, 06 Sep 2025 15:10:39 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v4 13/13] target/loongarch: Only flush one TLB entry in
 helper_invtlb_page_asid()
Date: Sat,  6 Sep 2025 15:10:37 +0800
Message-Id: <20250906071037.3749544-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250906070441.3749413-1-maobibo@loongson.cn>
References: <20250906070441.3749413-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJAxQMJv3rto8aaBAA--.11354S2
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

With function helper_invtlb_page_asid(), only one TLB entry in
LoongArch emulated TLB is invalidated. so with QEMU TLB, it is not
necessary to flush all QEMU TLB, only flush address range specified
LoongArch emulated TLB is ok. Here invalidate_tlb_entry() is called
so that only QEMU TLB entry with specified address range is flushed.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/loongarch/tcg/tlb_helper.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/target/loongarch/tcg/tlb_helper.c b/target/loongarch/tcg/tlb_helper.c
index 243f945612..8cfce48a29 100644
--- a/target/loongarch/tcg/tlb_helper.c
+++ b/target/loongarch/tcg/tlb_helper.c
@@ -541,8 +541,7 @@ void helper_invtlb_page_asid(CPULoongArchState *env, target_ulong info,
     func = tlb_match_asid;
     tlb = loongarch_tlb_search_cb(env, addr, asid, func);
     if (tlb) {
-        tlb->tlb_misc = FIELD_DP64(tlb->tlb_misc, TLB_MISC, E, 0);
-        tlb_flush(env_cpu(env));
+        invalidate_tlb(env, tlb - env->tlb);
     }
 }
 
-- 
2.39.3


