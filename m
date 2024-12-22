Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8755E7718D
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Dec 2024 16:32:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tPOlr-0002uL-0F; Sun, 22 Dec 2024 11:25:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tPOlG-0002ZU-1i
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 11:24:59 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tPOlD-0002xm-GE
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 11:24:57 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-21634338cfdso44205305ad.2
 for <qemu-devel@nongnu.org>; Sun, 22 Dec 2024 08:24:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734884694; x=1735489494; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MtPJbyi6qGACA18TCvDtHVp8Rw/uvIg0oIMOG458ijo=;
 b=KPp54ctJVAC1vayLELyB3sRUc3eRmxdSH7f1kGP5ff3kMGpNFKYe43teV/7iEdIW+9
 h556M5wW8v5UO8KjGrtFyV9FZC+A3Vg0EGLRcynWQ4LrbHrPC2gXro3VW/56X1oj3fAe
 lAjvz3vuw0Y/s5XsfRsxXo1eJJyiwztmqm4nC2OKlw8Msp9yGrBEqPEpJK3MnMab3Wv2
 oRLApYPRGAA+E8XqItNs1LZBKaRc2VOzwW0cD1rj9w5gK20tOZ1aFy3OEHWrvrUu00GZ
 wGP8wn9d2QVxig1RjT6u4Wi8kfUftijsybY6a1iEqBxp5b62h9hRoV3YPFWjO9YP6+6N
 jbLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734884694; x=1735489494;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MtPJbyi6qGACA18TCvDtHVp8Rw/uvIg0oIMOG458ijo=;
 b=ayX9PkVR1AAv100VuZ363MkFa2cPa25XmxbASYoXyQTW4ki5KTszziSEGi2OuWbdOw
 lV8Fz2zTG+OHIUM1EYCyE7SGBMqvG/oFAQYi2NloYflVjXGFG5jAoL2Ih0RYLrFf+JXf
 /NJXYlj62DTZBdcOcaSfEVmTW8tmBTIxzfG6CG3S0hiYea0VawHMypIpKcMPQl8uVELd
 KfLz2nPrnWT89ZpfSpL3Hbte7fQ5rm8JZk57HxxcbuSn+z+RZrwUTD2iQGPXX5Bl4FzI
 wddHUPWdClBzLcV9Ru/RUenyi/JxWKcu538XrbN4o0Nke6XU2ZI1fTjBUCMmS1BazShC
 5CcQ==
X-Gm-Message-State: AOJu0YxJjAMEJAQHLtMmg2+0LzYewiogoXhhS0dWWFYXuTKAv69Dtq8A
 GOFyqzG+IQRdzTl7kKq9QJ4mE3S2mWIP8dB+Emi2I4i3vLoPax1sGL0vZFo8Mu5+b3QPn++Xt7d
 MawM=
X-Gm-Gg: ASbGncukCvtnw7EhpYKctgc17+sHWev0W2uhDGRcOuXk64qFxkf0+n0ypAjNm9ctuSG
 j/ct2RKU1o/YT9p1uEfyvsppC0qWTBV08DO//U/EYdqvvoPzz57vjibdEs3SzmG3eNJD7deBzBY
 qYM7QjvW4bRB6Rm6L3dfSvB7xTQKY5WFYaDxzSyZGozY9UTJ5/9HFMIwZW75ajujcKbaSZcZf2t
 PKxAzvd67zAhv3WSS3F6coUSdLxQRyIFn3ZTseKvqV5x3JdxItpVWVzl/QXoTE=
X-Google-Smtp-Source: AGHT+IHB1Al7nn/N2N5s/BBiN+AwB81HNL2BXL17v571pOKppCXEGG7PzbEOA1ORAIOPAzjkT91RfA==
X-Received: by 2002:a17:903:181:b0:216:66d2:f172 with SMTP id
 d9443c01a7336-219e6f4a86bmr118280835ad.56.1734884694198; 
 Sun, 22 Dec 2024 08:24:54 -0800 (PST)
Received: from stoup.. ([71.212.144.252]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc971814sm58461385ad.79.2024.12.22.08.24.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Dec 2024 08:24:53 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 10/51] tcg/optimize: Use fold_masks_zs in fold_bswap
Date: Sun, 22 Dec 2024 08:24:05 -0800
Message-ID: <20241222162446.2415717-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241222162446.2415717-1-richard.henderson@linaro.org>
References: <20241222162446.2415717-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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
Always set s_mask along the BSWAP_OS path, since the result is
being explicitly sign-extended.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index d13001e53a..27b8f90453 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1462,16 +1462,15 @@ static bool fold_brcond2(OptContext *ctx, TCGOp *op)
 static bool fold_bswap(OptContext *ctx, TCGOp *op)
 {
     uint64_t z_mask, s_mask, sign;
+    TempOptInfo *t1 = arg_info(op->args[1]);
 
-    if (arg_is_const(op->args[1])) {
-        uint64_t t = arg_info(op->args[1])->val;
-
-        t = do_constant_folding(op->opc, ctx->type, t, op->args[2]);
-        return tcg_opt_gen_movi(ctx, op, op->args[0], t);
+    if (t1->is_const) {
+        return tcg_opt_gen_movi(ctx, op, op->args[0],
+                                do_constant_folding(op->opc, ctx->type,
+                                                    t1->val, op->args[2]));
     }
 
-    z_mask = arg_info(op->args[1])->z_mask;
-
+    z_mask = t1->z_mask;
     switch (op->opc) {
     case INDEX_op_bswap16_i32:
     case INDEX_op_bswap16_i64:
@@ -1499,18 +1498,17 @@ static bool fold_bswap(OptContext *ctx, TCGOp *op)
         /* If the sign bit may be 1, force all the bits above to 1. */
         if (z_mask & sign) {
             z_mask |= sign;
-            s_mask = sign << 1;
         }
+        /* The value and therefore s_mask is explicitly sign-extended. */
+        s_mask = sign;
         break;
     default:
         /* The high bits are undefined: force all bits above the sign to 1. */
         z_mask |= sign << 1;
         break;
     }
-    ctx->z_mask = z_mask;
-    ctx->s_mask = s_mask;
 
-    return fold_masks(ctx, op);
+    return fold_masks_zs(ctx, op, z_mask, s_mask);
 }
 
 static bool fold_call(OptContext *ctx, TCGOp *op)
-- 
2.43.0


