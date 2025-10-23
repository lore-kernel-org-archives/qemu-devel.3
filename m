Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B388CCD1BC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 12:09:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBu6q-0006Bq-Ly; Thu, 23 Oct 2025 08:08:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1vBu6P-000665-7D
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 08:07:36 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1vBu6I-0004vZ-Ux
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 08:07:32 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8BxH9N7Gvpocb0ZAA--.55933S3;
 Thu, 23 Oct 2025 20:07:23 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowJDx_8NuGvporJkDAQ--.47140S13;
 Thu, 23 Oct 2025 20:07:23 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>
Subject: [PULL 11/14] target/loongarch: Add common interface update_tlb_index()
Date: Thu, 23 Oct 2025 20:07:07 +0800
Message-Id: <20251023120710.3086556-12-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20251023120710.3086556-1-maobibo@loongson.cn>
References: <20251023120710.3086556-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJDx_8NuGvporJkDAQ--.47140S13
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

Common API update_tlb_index() is added here, it is to update TLB entry
with specified index. It is called by helper_tlbwr() now, also it can
be used by HW PTW when adding new TLB entry.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by: Song Gao <gaosong@loongson.cn>
---
 target/loongarch/tcg/tlb_helper.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/target/loongarch/tcg/tlb_helper.c b/target/loongarch/tcg/tlb_helper.c
index 8d962ce3e3..92f89841b0 100644
--- a/target/loongarch/tcg/tlb_helper.c
+++ b/target/loongarch/tcg/tlb_helper.c
@@ -350,21 +350,14 @@ void helper_tlbrd(CPULoongArchState *env)
     }
 }
 
-void helper_tlbwr(CPULoongArchState *env)
+static void update_tlb_index(CPULoongArchState *env, MMUContext *context,
+                             int index)
 {
-    int index = FIELD_EX64(env->CSR_TLBIDX, CSR_TLBIDX, INDEX);
     LoongArchTLB *old, new = {};
     bool skip_inv = false, tlb_v0, tlb_v1;
-    MMUContext context;
 
     old = env->tlb + index;
-    if (FIELD_EX64(env->CSR_TLBIDX, CSR_TLBIDX, NE)) {
-        invalidate_tlb(env, index);
-        return;
-    }
-
-    sptw_prepare_context(env, &context);
-    fill_tlb_entry(env, &new, &context);
+    fill_tlb_entry(env, &new, context);
     /* Check whether ASID/VPPN is the same */
     if (old->tlb_misc == new.tlb_misc) {
         /* Check whether both even/odd pages is the same or invalid */
@@ -384,6 +377,20 @@ void helper_tlbwr(CPULoongArchState *env)
     *old = new;
 }
 
+void helper_tlbwr(CPULoongArchState *env)
+{
+    int index = FIELD_EX64(env->CSR_TLBIDX, CSR_TLBIDX, INDEX);
+    MMUContext context;
+
+    if (FIELD_EX64(env->CSR_TLBIDX, CSR_TLBIDX, NE)) {
+        invalidate_tlb(env, index);
+        return;
+    }
+
+    sptw_prepare_context(env, &context);
+    update_tlb_index(env, &context, index);
+}
+
 static int get_tlb_random_index(CPULoongArchState *env, vaddr addr,
                                 int pagesize)
 {
-- 
2.43.5


