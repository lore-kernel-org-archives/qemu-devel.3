Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BD56CAC5BB
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 03:00:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6gsg-00058Q-5F; Wed, 08 Oct 2025 22:59:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1v6gse-000584-LY
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 22:59:48 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1v6gsa-0002XL-AX
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 22:59:48 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8AxRNAVJedo7iIUAA--.42571S3;
 Thu, 09 Oct 2025 10:59:33 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowJDxrcEUJedoJwfWAA--.52991S4;
 Thu, 09 Oct 2025 10:59:33 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH 2/2] target/loongarch: Skip global TLB when calculating
 replaced TLB
Date: Thu,  9 Oct 2025 10:59:32 +0800
Message-Id: <20251009025932.2990219-3-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20251009025932.2990219-1-maobibo@loongson.cn>
References: <20251009025932.2990219-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJDxrcEUJedoJwfWAA--.52991S4
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

When new TLB entry is added, TLB index is calculated from invalid
entry at first and then from different ASID, and randomly at last.

With different ASID, global TLB should be skipped since ASID is not
useful when global TLB is added.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 target/loongarch/tcg/tlb_helper.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/target/loongarch/tcg/tlb_helper.c b/target/loongarch/tcg/tlb_helper.c
index f8fada5b9a..f1d183cb64 100644
--- a/target/loongarch/tcg/tlb_helper.c
+++ b/target/loongarch/tcg/tlb_helper.c
@@ -371,7 +371,7 @@ void helper_tlbfill(CPULoongArchState *env)
     uint16_t pagesize, stlb_ps;
     uint16_t asid, tlb_asid;
     LoongArchTLB *tlb;
-    uint8_t tlb_e;
+    uint8_t tlb_e, tlb_g;
 
     if (FIELD_EX64(env->CSR_TLBRERA, CSR_TLBRERA, ISTLBR)) {
         entryhi = env->CSR_TLBREHI;
@@ -400,7 +400,8 @@ void helper_tlbfill(CPULoongArchState *env)
             }
 
             tlb_asid = FIELD_EX64(tlb->tlb_misc, TLB_MISC, ASID);
-            if (asid != tlb_asid) {
+            tlb_g = FIELD_EX64(tlb->tlb_entry0, TLBENTRY, G);
+            if (tlb_g == 0 && asid != tlb_asid) {
                 set = i;
             }
         }
@@ -423,7 +424,8 @@ void helper_tlbfill(CPULoongArchState *env)
             }
 
             tlb_asid = FIELD_EX64(tlb->tlb_misc, TLB_MISC, ASID);
-            if (asid != tlb_asid) {
+            tlb_g = FIELD_EX64(tlb->tlb_entry0, TLBENTRY, G);
+            if (tlb_g == 0 && asid != tlb_asid) {
                 index = i;
             }
         }
-- 
2.39.3


