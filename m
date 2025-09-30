Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E443CAC5B9
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 03:58:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3RVP-00073V-NP; Mon, 29 Sep 2025 23:58:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1v3RVO-00073N-Gk
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 23:58:22 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1v3RVL-0003WQ-C1
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 23:58:21 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8Axjr9XVdtoj2wQAA--.33158S3;
 Tue, 30 Sep 2025 11:58:15 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowJBxzsFXVdtoaFG_AA--.50748S2;
 Tue, 30 Sep 2025 11:58:15 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v4 13/13] target/loongarch: Add bit A/D checking in TLB entry
 with PTW supported
Date: Tue, 30 Sep 2025 11:58:15 +0800
Message-Id: <20250930035815.2609613-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250930035332.2609520-1-maobibo@loongson.cn>
References: <20250930035332.2609520-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJBxzsFXVdtoaFG_AA--.50748S2
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

With read/write access, add bit A/D checking if hardware PTW is
supported. If no matched, hardware page table walk is called. And
then bit A/D is updated in PTE entry and TLB entry is updated also.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 target/loongarch/tcg/tlb_helper.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/target/loongarch/tcg/tlb_helper.c b/target/loongarch/tcg/tlb_helper.c
index f3596a5154..fabbca6164 100644
--- a/target/loongarch/tcg/tlb_helper.c
+++ b/target/loongarch/tcg/tlb_helper.c
@@ -618,6 +618,22 @@ bool loongarch_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
     /* Data access */
     context.addr = address;
     ret = get_physical_address(env, &context, access_type, mmu_idx, 0);
+    if (ret == TLBRET_MATCH && context.mmu_index != MMU_DA_IDX
+        && cpu_has_ptw(env)) {
+        bool need_update = true;
+
+        if (access_type == MMU_DATA_STORE && pte_dirty(context.pte)) {
+            need_update = false;
+        } else if (access_type != MMU_DATA_STORE && pte_access(context.pte)) {
+            need_update = false;
+        }
+
+        if (need_update) {
+            /* Need update bit A/D in PTE entry, take PTW again */
+            ret = TLBRET_NOMATCH;
+        }
+    }
+
     if (ret != TLBRET_MATCH && cpu_has_ptw(env)) {
         /* Take HW PTW if TLB missed or bit P is zero */
         if (ret == TLBRET_NOMATCH || ret == TLBRET_INVALID) {
-- 
2.39.3


