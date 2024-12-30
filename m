Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AE13E77188
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Dec 2024 07:27:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tSAAg-0003a1-VF; Mon, 30 Dec 2024 02:26:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <haomiao23s@ict.ac.cn>)
 id 1tSAAb-0003Zn-Ra
 for qemu-devel@nongnu.org; Mon, 30 Dec 2024 02:26:34 -0500
Received: from smtp81.cstnet.cn ([159.226.251.81] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <haomiao23s@ict.ac.cn>)
 id 1tSAAY-0005nU-QB
 for qemu-devel@nongnu.org; Mon, 30 Dec 2024 02:26:33 -0500
Received: from haooops-ThinkPad-P15v-Gen-1.. (unknown [159.226.43.8])
 by APP-03 (Coremail) with SMTP id rQCowAAH7zEXS3Jn9Mq+BA--.25674S2;
 Mon, 30 Dec 2024 15:26:16 +0800 (CST)
From: Miao Hao <haomiao23s@ict.ac.cn>
To: gaosong@loongson.cn
Cc: qemu-devel@nongnu.org,
	Miao Hao <haomiao23s@ict.ac.cn>
Subject: [PATCH] target/loongarch: Fix index calculation for variable length
 pte
Date: Mon, 30 Dec 2024 15:26:13 +0800
Message-Id: <20241230072613.152286-1-haomiao23s@ict.ac.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowAAH7zEXS3Jn9Mq+BA--.25674S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tF1DCF13Kr13XF1kuF4rZrb_yoW8JFyfpF
 47uw1jvF4rtrZ2yasrKayYvry7Za1UCa1xXa1xtryfAws5Xr97XF4kJ3sFgF1UJa1fZr42
 vanavr1UZFWxX3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUkq14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
 6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
 CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
 2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJV
 W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc2xSY4AK67AK6r4x
 MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr
 0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAwCIc40Y0x0E
 wIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJV
 W8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAI
 cVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUjX_-PUUUUU==
X-Originating-IP: [159.226.43.8]
X-CM-SenderInfo: 5kdrzx1drsj2g6lf3hldfou0/
Received-SPF: pass client-ip=159.226.251.81; envelope-from=haomiao23s@ict.ac.cn;
 helo=cstnet.cn
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Miao Hao <haomiao23s@ict.ac.cn>
---
 target/loongarch/tcg/tlb_helper.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/loongarch/tcg/tlb_helper.c b/target/loongarch/tcg/tlb_helper.c
index 97f38fc391..a57ddfe8ad 100644
--- a/target/loongarch/tcg/tlb_helper.c
+++ b/target/loongarch/tcg/tlb_helper.c
@@ -538,9 +538,9 @@ target_ulong helper_lddir(CPULoongArchState *env, target_ulong base,
     badvaddr = env->CSR_TLBRBADV;
     base = base & TARGET_PHYS_MASK;
 
-    /* 0:64bit, 1:128bit, 2:192bit, 3:256bit */
+    /* 0:64bit, 1:128bit, 2:256bit, 3:512bit */
     shift = FIELD_EX64(env->CSR_PWCL, CSR_PWCL, PTEWIDTH);
-    shift = (shift + 1) * 3;
+    shift = shift + 3;
 
     get_dir_base_width(env, &dir_base, &dir_width, level);
     index = (badvaddr >> dir_base) & ((1 << dir_width) - 1);
@@ -595,9 +595,9 @@ void helper_ldpte(CPULoongArchState *env, target_ulong base, target_ulong odd,
             tmp0 += MAKE_64BIT_MASK(ps, 1);
         }
     } else {
-        /* 0:64bit, 1:128bit, 2:192bit, 3:256bit */
+        /* 0:64bit, 1:128bit, 2:256bit, 3:512bit */
         shift = FIELD_EX64(env->CSR_PWCL, CSR_PWCL, PTEWIDTH);
-        shift = (shift + 1) * 3;
+        shift = shift + 3;
         badv = env->CSR_TLBRBADV;
 
         ptindex = (badv >> ptbase) & ((1 << ptwidth) - 1);
-- 
2.34.1


