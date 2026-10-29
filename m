Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0D5606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 13:00:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMPjY-000263-Pj; Thu, 29 Oct 2026 08:59:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1xMPjP-000258-2f
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 08:59:48 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1xMPjL-0004GL-JR
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 08:59:46 -0400
Received: from loongson.cn (unknown [10.40.46.54])
 by gateway (Coremail) with SMTP id _____8Cx+9E7Q+NqhnUaAA--.11525S3;
 Thu, 29 Oct 2026 20:59:39 +0800 (CST)
Received: from fedora.loongson.cn (unknown [127.0.0.1])
 by front1 (Coremail) with SMTP id qMiowJCx9cw6Q+NqsDwxAA--.9638S4;
 Thu, 29 Oct 2026 20:59:39 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: Xianglai Li <lixianglai@loongson.cn>,
	qemu-devel@nongnu.org
Subject: [PATCH 2/2] target/loongarch: Change asrtle_d()/asrtgt_d() for signed
 integer comparison
Date: Thu, 29 Oct 2026 21:01:09 +0800
Message-ID: <20261029130109.185509-3-maobibo@loongson.cn>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261029130109.185509-1-maobibo@loongson.cn>
References: <20261029130109.185509-1-maobibo@loongson.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJCx9cw6Q+NqsDwxAA--.9638S4
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj9xXoWrZr1kAFW7ZFy3Kr4rCrWfJFc_yoWDKwc_ua
 n7Xr1kuw4xWw12kFn0vr95A348WF1kKFs0yFWUXF4Ikry5JFZ3Xr4qgF97Ar18uFyrGrnx
 Z39xtrnI9FnIvosvyTuYvTs0mTUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUj1kv1TuYvT
 s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
 cSsGvfJTRUUUb28YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
 vaj40_Wr0E3s1l1IIY67AEw4v_JF0_JFyl8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
 w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
 WUJVW8JwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
 6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
 Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE
 14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x
 0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
 7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcV
 C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF
 04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7
 CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jea0PUUUUU=
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Make the asrtle_d() and asrtgt_d() helpers perform signed integer
comparison. These helpers are used by the asrtle/asrtgt instructions.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 target/loongarch/tcg/op_helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/loongarch/tcg/op_helper.c b/target/loongarch/tcg/op_helper.c
index 25ed328753..f8a91bed5d 100644
--- a/target/loongarch/tcg/op_helper.c
+++ b/target/loongarch/tcg/op_helper.c
@@ -27,7 +27,7 @@ void HELPER(asrtle_d)(CPULoongArchState *env, target_ulong rj, target_ulong rk)
 {
     CPUSysState *sys = env_sys(env);
 
-    if (rj > rk) {
+    if ((target_long)rj > (target_long)rk) {
         sys->CSR_BADV = rj;
         do_raise_exception(env, EXCCODE_BCE, GETPC());
     }
@@ -37,7 +37,7 @@ void HELPER(asrtgt_d)(CPULoongArchState *env, target_ulong rj, target_ulong rk)
 {
     CPUSysState *sys = env_sys(env);
 
-    if (rj <= rk) {
+    if ((target_long)rj <= (target_long)rk) {
         sys->CSR_BADV = rj;
         do_raise_exception(env, EXCCODE_BCE, GETPC());
     }
-- 
2.54.0


