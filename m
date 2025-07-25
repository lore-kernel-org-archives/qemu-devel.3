Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FB89C83F26
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 01:48:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uf7XO-0007mZ-QU; Thu, 24 Jul 2025 21:47:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1uf7XH-0007kR-6V
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 21:47:47 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1uf7XE-00058G-Oi
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 21:47:46 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8DxDeM+4oJo8pExAQ--.64564S3;
 Fri, 25 Jul 2025 09:47:42 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowJCxocI74oJo3Z8lAA--.61220S2;
 Fri, 25 Jul 2025 09:47:40 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v3 16/17] target/loongarch: Reduce TLB flush with helper_tlbwr
Date: Fri, 25 Jul 2025 09:47:39 +0800
Message-Id: <20250725014739.1031030-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250725013739.994437-1-maobibo@loongson.cn>
References: <20250725013739.994437-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJCxocI74oJo3Z8lAA--.61220S2
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

With function helper_tlbwr(), specified LoongArch TLB entry will be
updated. There are two PTE pages in one TLB entry, it is not
necessary to flush QEMU TLB when one PTE page keeps unchanged and
ther other PTE page is newly added.

Here check whether PTE page is the same or not, TLB flush can be
skipped if both are the same or newly added.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 target/loongarch/tcg/tlb_helper.c | 36 ++++++++++++++++++++++++++-----
 1 file changed, 31 insertions(+), 5 deletions(-)

diff --git a/target/loongarch/tcg/tlb_helper.c b/target/loongarch/tcg/tlb_helper.c
index 1ed2471e0a..6ac102862b 100644
--- a/target/loongarch/tcg/tlb_helper.c
+++ b/target/loongarch/tcg/tlb_helper.c
@@ -327,16 +327,42 @@ void helper_tlbrd(CPULoongArchState *env)
 void helper_tlbwr(CPULoongArchState *env)
 {
     int index = FIELD_EX64(env->CSR_TLBIDX, CSR_TLBIDX, INDEX);
+    LoongArchTLB *old, new;
+    int skip_inv = 0;
+    uint8_t tlb_v;
 
-    invalidate_tlb(env, index);
-
+    old = env->tlb + index;
     if (FIELD_EX64(env->CSR_TLBIDX, CSR_TLBIDX, NE)) {
-        env->tlb[index].tlb_misc = FIELD_DP64(env->tlb[index].tlb_misc,
-                                              TLB_MISC, E, 0);
+        invalidate_tlb(env, index);
+        old->tlb_misc = FIELD_DP64(old->tlb_misc, TLB_MISC, E, 0);
         return;
     }
 
-    fill_tlb_entry(env, env->tlb + index);
+    new.tlb_misc = 0;
+    new.tlb_entry0 = 0;
+    new.tlb_entry1 = 0;
+    fill_tlb_entry(env, &new);
+    /* Check whether ASID/VPPN is the same */
+    if (old->tlb_misc == new.tlb_misc) {
+        tlb_v = FIELD_EX64(old->tlb_entry0, TLBENTRY, V);
+        /* Check whether even pte the same or invalid */
+        if (!tlb_v || new.tlb_entry0 == old->tlb_entry0) {
+            skip_inv = 1;
+        }
+
+        /* Check whether odd pte the same or invalid */
+        tlb_v = FIELD_EX64(old->tlb_entry1, TLBENTRY, V);
+        if (!tlb_v || new.tlb_entry1 == old->tlb_entry1) {
+            skip_inv &= 1;
+        }
+    }
+
+    if (!skip_inv) {
+        invalidate_tlb(env, index);
+    }
+    old->tlb_misc = new.tlb_misc;
+    old->tlb_entry0 = new.tlb_entry0;
+    old->tlb_entry1 = new.tlb_entry1;
 }
 
 void helper_tlbfill(CPULoongArchState *env)
-- 
2.39.3


