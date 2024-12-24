Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 187BEE7718D
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2024 20:13:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQBDY-000721-CP; Tue, 24 Dec 2024 15:09:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tQBDH-0005t9-GX
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 15:09:08 -0500
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tQBDE-0002vK-LN
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 15:09:06 -0500
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2efb17478adso5478252a91.1
 for <qemu-devel@nongnu.org>; Tue, 24 Dec 2024 12:09:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735070943; x=1735675743; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iOuFCqy4nAJ5B7qZ12n5+XuPYo2SCzX8rn+oDAFQ9fE=;
 b=oN17Czdvk9dIPVV0jH99tNlm2bltHi20tbFnT92jSnuvEdyMsuTgT5GHOZ8ffOjS0Z
 zKfnvNqdFKIL0Jpvii8dEpyNT06d0c4otsyFWDsm4BUTtoLM9eFB9cAx/X51eMcyPpz/
 ueNJ8f4bJII+C57gw+oaRjkUWyFFknPCQloxIF+vVqzWQh0T2xJWEDds+xiMpMjscvyi
 gCizhItnwmxRs80qu1vuT1uHKJdn3mBZrJ3wt2TdX6OKvKUCajGziExo/RMVQOxcZCly
 5dYEsx0JVodTQSjsdwlhrP+XWntY/9a56APAleqgfKSzcw8JM+vDlsESbCOiiDSd44t3
 5PnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735070943; x=1735675743;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iOuFCqy4nAJ5B7qZ12n5+XuPYo2SCzX8rn+oDAFQ9fE=;
 b=Ptwr3+kesQO0oQxoEV6ZeNGJMosYOjrlKlGy/7beZb40EM8kDXhO+o3HB69e9sqfVW
 X9Rj7xUifKyJegJhYw+lfGczBrSmziP0ofz1t3TV6WUaasg1kHggfukkkGRy1rXsQLv6
 rgmRr+0GqREBNNlMCXDT244AhRM7G03v8sv4nK6VKkb7MRHsox6iLmFXlNPkT05c7Od+
 E4GyQnR/2Wwy1tmkBYpjvSMtAv6zOWF7kEztXNUULW5nfxLN3HBoyyRr561me5NZHp+e
 4c9jrpOSrMwKsX6Sd8qO+bdQ7GiCGVtudTW0NPg0dRYe06mzbJT6SpgOMHkankXt4kSX
 41Jw==
X-Gm-Message-State: AOJu0Yz2Oc7d0JmxtJygW+Y75AlWPgh1qEzpvwJfOHULxxbP8zXWKQwo
 I2E1U/lbf5jqnF9P3wPKYojYV27XPg1EfxCeoHHa91d8KdQAEOt/J42wuF+t+da2h0xPlJn4a7v
 G6Ec=
X-Gm-Gg: ASbGncsPQL4fbwO+YTDyqq72CjnQIH2inAN192c6vHFpdp6YG2p+hKJpgZWb3tBn2Ff
 dJTsYWcf419eaE74/uzm3QyrzOeM/vkuPdRNeW8COk0g2vpjyPFoUubHaU9A85pCzMIuiQfIAHx
 uzRpY1CqE9PDhIP4TBoI3LLMu1scrQPsD3utkKcehwLwi/Xd02Q/HffM+d6tMN21+BSdqYS1HJr
 qiO70FlbZB3TFXNoKykGmx3EFR/OFzgHkEa80xOSAzaIEwBAYt+id6ESjMf2QMGW9R++LPEcXxz
 EJomaIVTW4HQmNnIN8GFodKAaw==
X-Google-Smtp-Source: AGHT+IHQNF3i7h50mK1Ol9vCvKhTO2wEE90FwV+BKW5JMFnczqvgQpk8q/C+pwSsNP34/Cgzag+JrA==
X-Received: by 2002:a05:6a00:3c84:b0:725:4615:a778 with SMTP id
 d2e1a72fcca58-72abdd7a148mr20442194b3a.7.1735070943279; 
 Tue, 24 Dec 2024 12:09:03 -0800 (PST)
Received: from stoup.. (syn-156-019-246-023.biz.spectrum.com. [156.19.246.23])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8309acsm10033521b3a.45.2024.12.24.12.09.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Dec 2024 12:09:02 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 43/72] tcg/optimize: Use fold_masks_zs,
 fold_masks_s in fold_shift
Date: Tue, 24 Dec 2024 12:04:52 -0800
Message-ID: <20241224200521.310066-44-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241224200521.310066-1-richard.henderson@linaro.org>
References: <20241224200521.310066-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102f.google.com
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

Avoid the use of the OptContext slots.  Find TempOptInfo once.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 2d634c8925..b70e9bdaf5 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2531,6 +2531,7 @@ static bool fold_sextract(OptContext *ctx, TCGOp *op)
 static bool fold_shift(OptContext *ctx, TCGOp *op)
 {
     uint64_t s_mask, z_mask, sign;
+    TempOptInfo *t1, *t2;
 
     if (fold_const2(ctx, op) ||
         fold_ix_to_i(ctx, op, 0) ||
@@ -2538,17 +2539,18 @@ static bool fold_shift(OptContext *ctx, TCGOp *op)
         return true;
     }
 
-    s_mask = arg_info(op->args[1])->s_mask;
-    z_mask = arg_info(op->args[1])->z_mask;
+    t1 = arg_info(op->args[1]);
+    t2 = arg_info(op->args[2]);
+    s_mask = t1->s_mask;
+    z_mask = t1->z_mask;
 
-    if (arg_is_const(op->args[2])) {
-        int sh = arg_info(op->args[2])->val;
-
-        ctx->z_mask = do_constant_folding(op->opc, ctx->type, z_mask, sh);
+    if (ti_is_const(t2)) {
+        int sh = ti_const_val(t2);
 
+        z_mask = do_constant_folding(op->opc, ctx->type, z_mask, sh);
         s_mask = do_constant_folding(op->opc, ctx->type, s_mask, sh);
 
-        return fold_masks(ctx, op);
+        return fold_masks_zs(ctx, op, z_mask, s_mask);
     }
 
     switch (op->opc) {
@@ -2557,23 +2559,22 @@ static bool fold_shift(OptContext *ctx, TCGOp *op)
          * Arithmetic right shift will not reduce the number of
          * input sign repetitions.
          */
-        ctx->s_mask = s_mask;
-        break;
+        return fold_masks_s(ctx, op, s_mask);
     CASE_OP_32_64(shr):
         /*
          * If the sign bit is known zero, then logical right shift
-         * will not reduced the number of input sign repetitions.
+         * will not reduce the number of input sign repetitions.
          */
-        sign = (s_mask & -s_mask) >> 1;
+        sign = -s_mask;
         if (sign && !(z_mask & sign)) {
-            ctx->s_mask = s_mask;
+            return fold_masks_s(ctx, op, s_mask);
         }
         break;
     default:
         break;
     }
 
-    return false;
+    return finish_folding(ctx, op);
 }
 
 static bool fold_sub_to_neg(OptContext *ctx, TCGOp *op)
-- 
2.43.0


