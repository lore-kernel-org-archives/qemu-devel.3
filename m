Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F526CF07B5
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2024 06:54:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syn31-00018D-Ic; Thu, 10 Oct 2024 02:53:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1syn2z-00017h-Vy
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 02:53:18 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1syn2w-00040b-5N
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 02:53:17 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8AxjnPVeQdn9OIRAA--.25757S3;
 Thu, 10 Oct 2024 14:53:09 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by front1 (Coremail) with SMTP id qMiowMBxXuTTeQdnBiAiAA--.41709S6;
 Thu, 10 Oct 2024 14:53:09 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
	maobibo@loongson.cn,
	philmd@linaro.org
Subject: [PATCH v2 4/5] target/loongarch: Add get_random_tlb_index()
Date: Thu, 10 Oct 2024 14:35:35 +0800
Message-Id: <20241010063536.2276871-5-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20241010063536.2276871-1-gaosong@loongson.cn>
References: <20241010063536.2276871-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMBxXuTTeQdnBiAiAA--.41709S6
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
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

get_random_tlb_index() is used to get a random tlb index.

Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 target/loongarch/tcg/tlb_helper.c | 34 +++++++++++++++++++++----------
 1 file changed, 23 insertions(+), 11 deletions(-)

diff --git a/target/loongarch/tcg/tlb_helper.c b/target/loongarch/tcg/tlb_helper.c
index bc6d708484..463e9be7f2 100644
--- a/target/loongarch/tcg/tlb_helper.c
+++ b/target/loongarch/tcg/tlb_helper.c
@@ -291,19 +291,12 @@ void helper_tlbwr(CPULoongArchState *env)
     fill_tlb_entry(env, index);
 }
 
-void helper_tlbfill(CPULoongArchState *env)
+static int get_random_tlb_index(CPULoongArchState *env,
+                                uint64_t entryhi, uint16_t pagesize)
 {
-    uint64_t address, entryhi;
+    uint64_t address;
+    uint16_t stlb_ps;
     int index, set, stlb_idx;
-    uint16_t pagesize, stlb_ps;
-
-    if (FIELD_EX64(env->CSR_TLBRERA, CSR_TLBRERA, ISTLBR)) {
-        entryhi = env->CSR_TLBREHI;
-        pagesize = FIELD_EX64(env->CSR_TLBREHI, CSR_TLBREHI, PS);
-    } else {
-        entryhi = env->CSR_TLBEHI;
-        pagesize = FIELD_EX64(env->CSR_TLBIDX, CSR_TLBIDX, PS);
-    }
 
     stlb_ps = FIELD_EX64(env->CSR_STLBPS, CSR_STLBPS, PS);
 
@@ -323,6 +316,25 @@ void helper_tlbfill(CPULoongArchState *env)
         index = get_random_tlb(LOONGARCH_STLB, LOONGARCH_TLB_MAX - 1);
     }
 
+    return index;
+}
+
+void helper_tlbfill(CPULoongArchState *env)
+{
+    uint64_t entryhi;
+    uint16_t pagesize;
+    int index;
+
+    if (FIELD_EX64(env->CSR_TLBRERA, CSR_TLBRERA, ISTLBR)) {
+        entryhi = env->CSR_TLBREHI;
+        pagesize = FIELD_EX64(env->CSR_TLBREHI, CSR_TLBREHI, PS);
+    } else {
+        entryhi = env->CSR_TLBEHI;
+        pagesize = FIELD_EX64(env->CSR_TLBIDX, CSR_TLBIDX, PS);
+    }
+
+    index = get_random_tlb_index(env, entryhi, pagesize);
+
     invalidate_tlb(env, index);
     fill_tlb_entry(env, index);
 }
-- 
2.33.0


