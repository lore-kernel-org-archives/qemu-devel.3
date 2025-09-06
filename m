Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D291CA1002
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Sep 2025 07:06:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uumz1-0001XP-FC; Sat, 06 Sep 2025 03:05:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1uumyo-0001Hj-Cw
 for qemu-devel@nongnu.org; Sat, 06 Sep 2025 03:04:58 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1uumyf-0003LS-Vp
 for qemu-devel@nongnu.org; Sat, 06 Sep 2025 03:04:56 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8CxJ9EN3btoplgHAA--.15455S3;
 Sat, 06 Sep 2025 15:04:45 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowJDx_8MJ3btoC6OBAA--.17248S5;
 Sat, 06 Sep 2025 15:04:45 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v4 03/13] target/loongarch: Reduce TLB flush with helper_tlbwr
Date: Sat,  6 Sep 2025 15:04:31 +0800
Message-Id: <20250906070441.3749413-4-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250906070441.3749413-1-maobibo@loongson.cn>
References: <20250906070441.3749413-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJDx_8MJ3btoC6OBAA--.17248S5
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
updated. There are two PTE pages in one TLB entry called even/odd
pages. Supposing even/odd page is normal/none state, when odd page
is added, TLB entry is changed as normal/normal state and even page
keeps unchanged.

In this situation, it is not necessary to flush QEMU TLB since even
page keep unchanged and odd page is newly changed. Here check whether
PTE page is the same or not, TLB flush can be skipped if both are the
same or newly added.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/loongarch/tcg/tlb_helper.c | 29 ++++++++++++++++++++++++-----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/target/loongarch/tcg/tlb_helper.c b/target/loongarch/tcg/tlb_helper.c
index 25dbbd0d77..88dba9eb3e 100644
--- a/target/loongarch/tcg/tlb_helper.c
+++ b/target/loongarch/tcg/tlb_helper.c
@@ -302,16 +302,35 @@ void helper_tlbrd(CPULoongArchState *env)
 void helper_tlbwr(CPULoongArchState *env)
 {
     int index = FIELD_EX64(env->CSR_TLBIDX, CSR_TLBIDX, INDEX);
+    LoongArchTLB *old, new = {};
+    bool skip_inv = false;
+    uint8_t tlb_v0, tlb_v1;
 
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
+    fill_tlb_entry(env, &new);
+    /* Check whether ASID/VPPN is the same */
+    if (old->tlb_misc == new.tlb_misc) {
+        /* Check whether both even/odd pages is the same or invalid */
+        tlb_v0 = FIELD_EX64(old->tlb_entry0, TLBENTRY, V);
+        tlb_v1 = FIELD_EX64(old->tlb_entry1, TLBENTRY, V);
+        if ((!tlb_v0 || new.tlb_entry0 == old->tlb_entry0) &&
+            (!tlb_v1 || new.tlb_entry1 == old->tlb_entry1)) {
+            skip_inv = true;
+        }
+    }
+
+    /* flush tlb before updating the entry */
+    if (!skip_inv) {
+        invalidate_tlb(env, index);
+    }
+
+    *old = new;
 }
 
 void helper_tlbfill(CPULoongArchState *env)
-- 
2.39.3


