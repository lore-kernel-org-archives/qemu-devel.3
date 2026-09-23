Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 044FCC98304
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 20:37:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9Tgn-0008JK-3J; Wed, 23 Sep 2026 16:35:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x9Tg4-00089d-Up
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 16:34:55 -0400
Received: from mail-pz2-x0d.google.com ([2607:f8b0:4864:3b::d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x9Tg2-0004zq-5N
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 16:34:52 -0400
Received: by mail-pz2-x0d.google.com with SMTP id
 d2e1a72fcca58-85469e25400so740458b3a.0
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 13:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790195689; x=1790800489; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=j6QG31ddBAoXf5XbCARtw7hjYTU4SqCkiNBwOj5mBjs=;
 b=eYS6yS7UFJ4mR5knmO3YhbNrwCUoW2+VkxG8Fn0iqORNdEconBmH5tDT+p7kGefWqg
 ZZDkPIOIZHY61yM6SeFAkiIV5wDWf3PqP/XPVoeglEfHQm08/Rfz4tfCwf5k9T4bfSo0
 RU6ZFmcg5hzejfUK3ZSlnmDhsG4rh2pmbBjTnHbbqPz5UYwPGkr9qJXSvCikjlgbRVLm
 avhpydrJkl5+qQNFZ0eGoE8Hhz10tFPj05LwLV3UDQMx8bQkIy3NJ1qeGKo032omYB4p
 dcnTIgL4mT+3mHvwaUryjEY2pxGsi+Jfm+heseSXc6ZQT2gxJL39XPZ/XRoyEJoqTqyW
 zDMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790195689; x=1790800489;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=j6QG31ddBAoXf5XbCARtw7hjYTU4SqCkiNBwOj5mBjs=;
 b=pIngyMelZ4XopUi0JL3Kb242RY7Q+BM8fFXdcBwB5uBI5gSqh4np7OBcNpBP4x1VjH
 UHcV7HeQmU6U7PWlgOB+/Btg/gyQ7lU6tFUDmOZpVntSLmYhR4GK6iLrsOPY7M3b2MYr
 Q7sZBmsRyS9oSRtRyILNi5oE+qIe7igYXba5TkOzeye5veoNkuc/+9F9TbZTYfUuYKvg
 BJ+311J5wRyvL2il8hk91Eyop0xpSO7BzEQuJ7GkmFoOVbpwqhm+7MCDPaIo+hR+6qR7
 CyjEwRX6SQ7M1kl7M915S9b1qoct/8QMgSkNPGZ91edymqJ7FwG5H4bN2iNV92m81O4r
 VgRA==
X-Gm-Message-State: AFuF++kP0GbIBsBlKh1WjxemjA6ROrM8t3yx7mqvHhvWgmccZI6/7pgU
 zUd8IyBcmrpy0WieCRp6kAX+mcuah0BP5pLqU9e2GqLP42GbQDll4yftie8R1CNn2yZpwwfjFux
 O6W5a
X-Gm-Gg: AYBFou3GUz+rYOCrhT7Niq+nHAJ8uobd/PXOfy9Vtem4fBVgR1Dl8BygXmzY2afv0qP
 taRBNJjBX3kEifXNSVT8K/Dye1oZEt/5Ouy5yg6rHA6rVLpkH2Dwxkk3olbvohnDRD7p+Waw2fc
 GbofNM3BU5DTBuNeBqiHWub1znzR4IqEPqce5cajiWwvlnraOjBHKt8/FxM9mPT1yuEUna8eRXj
 tWQIzP2f3vEcMfG9dCcS0U14R34o98D/8tk+ZiPGIr7d58z4SYAvxAKTvuNeNRKT1pkHUtn/RGp
 N70g1IemzPQbRRYIXvrDto4UmqwkuEfEzKdZ8IhyF9VQWF4hcVGn2r3Axwb7m//QDUhGxZw//8Q
 Hk2E7ND13OuX/QxQx2OkZgMXW+z0Wx7Rc/DLaRuZDvGqEtOEW1prZGIZhoR3DZGUD/YogQfbo7I
 8bY1gj4BKuzbjoigDbRiA0fZae35JCH+nCmqzatmfb3qL3y8k0mzGr9zl9eAMlfLWFT7r6H+281
 qZV/EbUtjU3ECy85G5IVi7CbT6dsQ==
X-Received: by 2002:a05:6a00:4b4f:b0:87d:d1bc:334d with SMTP id
 d2e1a72fcca58-87e9be77eafmr222447b3a.40.1790195688699; 
 Wed, 23 Sep 2026 13:34:48 -0700 (PDT)
Received: from stoup (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-87d3894211asm1678638b3a.36.2026.09.23.13.34.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 13:34:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
	Jim MacArthur <jim.macarthur@linaro.org>
Subject: [PULL 06/16] tcg/optimize: Fix fold_multiply2 vs 1
Date: Wed, 23 Sep 2026 13:34:31 -0700
Message-ID: <20260923203441.31276-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260923203441.31276-1-richard.henderson@linaro.org>
References: <20260923203441.31276-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x0d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

For muls2, we returned from fold_multiply2 without finish_folding
or any other mechanism to update value tracking for the rh output.
We might as well do this via fold_shift, which will also mark rh
as having all copies of the sign bit.

For the movi paths of multiply vs 0 or mulu2, we're better off tail
calling to tcg_opt_gen_movi rather than explicitly returning true.

Cc: qemu-stable@nongnu.org
Fixes: c9349965ce4 ("tcg: Optimize INDEX_op_mul[us]2 for 0 and 1")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4448
Reviewed-by: Jim MacArthur <jim.macarthur@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index d291c844ca8..bd91220650b 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2213,6 +2213,7 @@ static bool fold_mul_highpart(OptContext *ctx, TCGOp *op)
     return finish_folding(ctx, op);
 }
 
+static bool fold_shift(OptContext *ctx, TCGOp *op);
 static bool fold_multiply2(OptContext *ctx, TCGOp *op)
 {
     swap_commutative(op->args[0], &op->args[2], &op->args[3]);
@@ -2253,15 +2254,13 @@ static bool fold_multiply2(OptContext *ctx, TCGOp *op)
             /* The proper opcode is supplied by tcg_opt_gen_mov. */
             op2 = opt_insert_before(ctx, op, 0, 2);
             tcg_opt_gen_movi(ctx, op, rl, l);
-            tcg_opt_gen_movi(ctx, op2, rh, h);
-            return true;
+            return tcg_opt_gen_movi(ctx, op2, rh, h);
         }
 
         if (b == 0) {
             op2 = opt_insert_before(ctx, op, 0, 2);
             tcg_opt_gen_movi(ctx, op2, rl, 0);
-            tcg_opt_gen_movi(ctx, op, rh, 0);
-            return true;
+            return tcg_opt_gen_movi(ctx, op, rh, 0);
         }
         if (b == 1) {
             op2 = opt_insert_before(ctx, op, 0, 2);
@@ -2269,20 +2268,18 @@ static bool fold_multiply2(OptContext *ctx, TCGOp *op)
 
             switch (op->opc) {
             case INDEX_op_mulu2:
-                tcg_opt_gen_movi(ctx, op, rh, 0);
-                break;
+                return tcg_opt_gen_movi(ctx, op, rh, 0);
             case INDEX_op_muls2:
                 op->opc = INDEX_op_sar;
                 op->args[0] = rh;
                 op->args[1] = rl;
                 op->args[2] =
                     arg_new_constant(ctx, tcg_type_size(ctx->type) * 8 - 1);
-                break;
+                return fold_shift(ctx, op);
             default:
-                g_assert_not_reached();
+                break;
             }
-
-            return true;
+            g_assert_not_reached();
         }
     }
     return finish_folding(ctx, op);
-- 
2.53.0


