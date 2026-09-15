Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E1ADC88E75
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 01:41:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6IAm-0007v2-Tx; Mon, 14 Sep 2026 21:41:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6IAk-0007uB-N8
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 21:41:22 -0400
Received: from mail-pj2-x10.google.com ([2607:f8b0:4864:39::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6IAj-0003Z7-1q
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 21:41:22 -0400
Received: by mail-pj2-x10.google.com with SMTP id
 98e67ed59e1d1-396ccda24afso2159838a91.3
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 18:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789436479; x=1790041279; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HNq3g4tfFW2/BMyA45iK7whUuFTibZ5zcf0Ca4+nyL4=;
 b=qcadIg+42/j7m5mHNupBsGXF+sqOc0kK1r/riqtVcARSbKeJMP1n57fJfPwTKCaYxC
 qac0puPz5s0/kjMiAM28uoWsIsu1Iegpcvr3T7j2S7Za4VS9teZA94WFuZItRVDRx9Gt
 HR7d95vPUSHJ+kOkNd4YFbZIGba/NfGn+b3OM2F1FJuga8843pHqfJ7+lClmFDbpC6r/
 oz3BFLh1/IXAT7ufY0qb4UGqcdqGYdND2b6t8hkeZUQLkza2/8S/3bJTTCT0CrEb5i3A
 9HUubBuLyw0/jy1/S+Jt+s/u+pwOTEqA/pmWcYnNcCuMK7kC/I3pzV9f282Rx7hIEJXb
 SMIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789436479; x=1790041279;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=HNq3g4tfFW2/BMyA45iK7whUuFTibZ5zcf0Ca4+nyL4=;
 b=zcEfadWtGn2kZEXb+KM8Dra1jNBreXsH/yChgrs7as9donJpqt+JiIsoTDeuHepgZk
 00v4fAjpv9Ju9AncxKfXLhpPhHwbXzYgGm/edbYyc7agV+Z2PIZPGaUBNCkkrbUFviT7
 ICS/QCOhd6WBXkI/Cd0NVFO7rVA96pN+HJt2yro1MGNmxRunCLIRxZwZUOByxsbfBUn4
 pahoMA6xd9SDAdge2qHUGWfvWbXHt74InN3MU1dtCmdoEEWTxwTMz3hC9sjwGCqoHDNd
 q0sMRK1gvaPlxhHusrZUdxpzTLiCyuL+y0usZU82vC/d5fUm1C0DFK52Sdwrf4xNXq5/
 rABQ==
X-Gm-Message-State: AFuF++m0xel7e6wRHd5sp7MOHj4RnjKaVjwE8x6PRwC6ozijigaE+KpX
 2qM2tLbzrQQsWJN2nR77JOSGiW7Ch8ba0U62QshV0wFQhIjYOYG5SIAHnjN2RRPpVvzNbkEP1RI
 1i6Mx
X-Gm-Gg: AYBFou0j5ctUziulCanhN7tTm2FJIOB3yW6ukr2/Neb6ckYGkZXAd8l+GhgoJZuGJwr
 /0MCBQBLFp0tgUzRdQWS0GZWsIAu9oCoMA6RhfLfBHDl6jqqzmmPNOYFoPLNAvcYeDrRNnDX5Dt
 ysvU6hjyb2+AYZph+uLhy86FgEKRauGGcBwqOa537Hay9n6JwoFD3mmtbzNQaW1TvGaImU+baTY
 EgY3lq+XHHHfhIB+SYRmQlzxls9VTTuEAgSKZang9dehdItJB3lz3kHgEfOExvSOY7Ja5w3WFso
 CPm6oPCPZ1/57hqyyNcoA2VRKSf16+9Gg+/6nl8MgAkUTDrt3pFSAq0UhmY9Cq3vaQUyY3ngMUA
 D1l9bNGzr5bnyIs1mG6eSFmCx3CEkXG7/m9ciDbryFKkiLNGUKdgg9LNHqzjUspGEPUOaKea+pi
 7yjknB4y4Fi2fHyqeHfWhCF4HyQYLIlXBCxp7NiSB6sSWnlj82vsKgQixiS4ESs2mbF5ZO41tfn
 Eh91g==
X-Received: by 2002:a17:90a:d444:b0:39e:126:e9c9 with SMTP id
 98e67ed59e1d1-39e0126eb27mr2651228a91.18.1789436479299; 
 Mon, 14 Sep 2026 18:41:19 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:c119:8717:353:53c6])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4fb3ddasm26351702eec.30.2026.09.14.18.41.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 18:41:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
	qemu-stable@nongnu.org
Subject: [PATCH 1/2] tcg/optimize: Fix fold_multiply2 vs 1
Date: Mon, 14 Sep 2026 15:41:14 -1000
Message-ID: <20260915014115.1809286-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260915014115.1809286-1-richard.henderson@linaro.org>
References: <20260915014115.1809286-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::10;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x10.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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


