Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 014AFCAC59A
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 12:50:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzaXI-0005cT-65; Fri, 19 Sep 2025 08:48:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wangrui@loongson.cn>)
 id 1uzaX7-0005b6-I5
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 08:48:13 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wangrui@loongson.cn>) id 1uzaWu-0004Gq-DJ
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 08:48:07 -0400
Received: from loongson.cn (unknown [223.64.28.119])
 by gateway (Coremail) with SMTP id _____8BxF9HtUM1ocT0MAA--.26253S3;
 Fri, 19 Sep 2025 20:47:42 +0800 (CST)
Received: from localhost (unknown [223.64.28.119])
 by front1 (Coremail) with SMTP id qMiowJCxH8LnUM1our+fAA--.62251S2;
 Fri, 19 Sep 2025 20:47:39 +0800 (CST)
From: WANG Rui <wangrui@loongson.cn>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org,
	qemu@hev.cc,
	WANG Rui <wangrui@loongson.cn>
Subject: [PATCH] tcg/optimize: Fix folding of vector bitsel
Date: Fri, 19 Sep 2025 20:49:01 +0800
Message-ID: <20250919124901.2756538-1-wangrui@loongson.cn>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJCxH8LnUM1our+fAA--.62251S2
X-CM-SenderInfo: pzdqw2txl6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj9xXoW7Wr13Cw17WFy3XF4UCFW3Arc_yoWDCrc_K3
 yfA3WkX34YgFs8Wr97Xa1UJryxW34qyFWj9r97GwsxW34Dt39YqF4kWF98JF17X3ykXry3
 AanrXr1xC3Z8GosvyTuYvTs0mTUanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvT
 s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
 cSsGvfJTRUUUbzAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
 vaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
 w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
 WUJVW8JwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0
 oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc02F4
 0EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_
 Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28IcxkI7VAKI4
 8JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xv
 wVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjx
 v20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20E
 Y4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267
 AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUwmhFDUUUU
Received-SPF: pass client-ip=114.242.206.163; envelope-from=wangrui@loongson.cn;
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

It looks like a typo. When the false value (C) is the constant -1, the
correct fold should be: R = B | ~A

Reproducer (LoongArch64 assembly):

     .text
     .globl  _start
 _start:
     vldi    $vr1, 3073
     vldi    $vr2, 1023
     vbitsel.v       $vr0, $vr2, $vr1, $vr2
     vpickve2gr.d    $a1, $vr0, 1
     xori    $a0, $a1, 1
     li.w    $a7, 93
     syscall 0

Fixes: e58b977238e3 ("tcg/optimize: Optimize bitsel_vec")
Link: https://github.com/llvm/llvm-project/issues/159610
Signed-off-by: WANG Rui <wangrui@loongson.cn>
---
 tcg/optimize.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 3638ab9fea..f69702b26e 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1568,9 +1568,10 @@ static bool fold_bitsel_vec(OptContext *ctx, TCGOp *op)
             return fold_and(ctx, op);
         }
         if (fv == -1 && TCG_TARGET_HAS_orc_vec) {
+            TCGArg ta = op->args[2];
             op->opc = INDEX_op_orc_vec;
             op->args[2] = op->args[1];
-            op->args[1] = op->args[3];
+            op->args[1] = ta;
             return fold_orc(ctx, op);
         }
     }
-- 
2.51.0


