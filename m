Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2360CAC5B8
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 03:56:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3RS2-00017Y-S9; Mon, 29 Sep 2025 23:54:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1v3RS0-00017F-Jg
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 23:54:52 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1v3RRt-0002NI-8X
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 23:54:52 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8Axjr9AVNto1GsQAA--.33149S3;
 Tue, 30 Sep 2025 11:53:36 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowJBxC8E8VNtoak+_AA--.40492S11;
 Tue, 30 Sep 2025 11:53:36 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v4 09/13] target/loongarch: Move last PTE lookup into page
 table walker loop
Date: Tue, 30 Sep 2025 11:53:28 +0800
Message-Id: <20250930035332.2609520-10-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250930035332.2609520-1-maobibo@loongson.cn>
References: <20250930035332.2609520-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJBxC8E8VNtoak+_AA--.40492S11
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

The last PTE lookup sentence is much similiar with the whole page
table walker loop, move it into the whole loop.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 target/loongarch/cpu_helper.c | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/target/loongarch/cpu_helper.c b/target/loongarch/cpu_helper.c
index 07087c68b8..09fb1e46d4 100644
--- a/target/loongarch/cpu_helper.c
+++ b/target/loongarch/cpu_helper.c
@@ -124,7 +124,7 @@ static TLBRet loongarch_ptw(CPULoongArchState *env, MMUContext *context,
     }
     base &= TARGET_PHYS_MASK;
 
-    for (level = 4; level > 0; level--) {
+    for (level = 4; level >= 0; level--) {
         get_dir_base_width(env, &dir_base, &dir_width, level);
 
         if (dir_width == 0) {
@@ -135,17 +135,19 @@ static TLBRet loongarch_ptw(CPULoongArchState *env, MMUContext *context,
         index = (address >> dir_base) & ((1 << dir_width) - 1);
         phys = base | index << 3;
         base = ldq_phys(cs->as, phys);
-        if (FIELD_EX64(base, TLBENTRY, HUGE)) {
-            /* base is a huge pte */
-            break;
-        } else {
-            /* Discard high bits with page directory table */
-            base &= TARGET_PHYS_MASK;
+        if (level) {
+            if (FIELD_EX64(base, TLBENTRY, HUGE)) {
+                /* base is a huge pte */
+                break;
+            } else {
+                /* Discard high bits with page directory table */
+                base &= TARGET_PHYS_MASK;
+            }
         }
     }
 
     /* pte */
-    if (FIELD_EX64(base, TLBENTRY, HUGE)) {
+    if (level > 0) {
         /* Huge Page. base is pte */
         base = FIELD_DP64(base, TLBENTRY, LEVEL, 0);
         base = FIELD_DP64(base, TLBENTRY, HUGE, 0);
@@ -153,12 +155,6 @@ static TLBRet loongarch_ptw(CPULoongArchState *env, MMUContext *context,
             base = FIELD_DP64(base, TLBENTRY, HGLOBAL, 0);
             base = FIELD_DP64(base, TLBENTRY, G, 1);
         }
-    } else {
-        /* Normal Page. base points to pte */
-        get_dir_base_width(env, &dir_base, &dir_width, 0);
-        index = (address >> dir_base) & ((1 << dir_width) - 1);
-        phys = base | index << 3;
-        base = ldq_phys(cs->as, phys);
     }
 
     context->ps = dir_base;
-- 
2.39.3


