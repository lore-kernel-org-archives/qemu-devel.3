Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68BEAE77188
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2024 20:06:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQB9u-0002lw-Uk; Tue, 24 Dec 2024 15:05:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tQB9n-0002kT-Tj
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 15:05:32 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tQB9m-0002XW-Ax
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 15:05:31 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-21669fd5c7cso57784075ad.3
 for <qemu-devel@nongnu.org>; Tue, 24 Dec 2024 12:05:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735070729; x=1735675529; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0XbbAA6tPaSy58TXvgA24Kz1zz5lDy83D/6o1p8rm3g=;
 b=iyPogcdMBkfObjKqSzGho6xFZuGnanmIkOd2YZXZ0gJZHwWS+lSiMFSxYTOb5rZdM1
 P1tOLUimDiUQ/6YyWo2TnNY9ZPkjXswc8V67XjiVX9ogroX3AACuKGGGmW/g5uqLFuHk
 HgX/vEm8I2UIog0bbYbWlT/DGDyXHBY/yZ8qVFpPp1RI8LSOsIBW814defj2+lyZYulV
 7zqTh+EzZ2SB8015c1bQSsx8hjSFxc0BotZNv7AP+H9gr2i/KaHSwtPVdHtkrQIIOhuW
 9I9B6rqzhowMrBLR3IcqYJcesiu8acW25w5eh/HjqpL3Uqjhu3NeegJ8ofsFyfuXEMnT
 43fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735070729; x=1735675529;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0XbbAA6tPaSy58TXvgA24Kz1zz5lDy83D/6o1p8rm3g=;
 b=VX4FyZ73IOgMsSIja3MZUHhU668C7L2Q6dhRoiM0DV+P3lWqFMTFLw2YPxSbHBq1uo
 UVAmMLnwYtG9F4gZjkprZPWwalmo2YJa3ash8d5ZQLBaC+cpdn9hGvh2Nzei1pQaT4io
 EfSGdpxcTwLJpUlxiRI7gi1amJwx1O13PHqG2reLX4zVxS9A7WOOUWWgFiAzt+TAoYnG
 +hIhMXOWBPCQsFs8tn+dGgX+iCG/rdvS0X1EWRJMQDZsACGPcNmZtWZmgUwVV2aIvxhh
 riAsoYYvZbgk7TlIfBO4h6xb6SS3DF8YHIm84TiRO3wjcjMUB7mJ2kNFCca4PgG+9yAh
 2bog==
X-Gm-Message-State: AOJu0YwFKO2z/OsA6VhvH6+ad6eFezQ0AB1mhXb/2Z7DmjUZxTMpwYY5
 ODM/+74j/RM2u0/xYod/0ZXQErS1NfL8TVQbZfh/lACx/4EZHW3Y5l4SsLfufzLXqzJV4WrAj5j
 OMsA=
X-Gm-Gg: ASbGncveBmkC3O8hCV3NLKI502LYTX3Hzef29lKTSG1sd8+hdig/CphoJcmd5X0i5Bv
 k8ElVgOxBg4LscIVh0AkLV/cQ8NjqOgiwGE1i9Wobvp7/S2tkjO9S5eXNZc8os1lS/rEXaTZghB
 LDzzpDP1DXhUgfdZN4lCIgEbiUYQZ8qePCvNWfecbcymOYq+mrUeZGv74a40MINThVF5mAwEown
 hbKaVCpuWP8HtXYpgUIG9Kd9fBqQbEkfatXazKni+dtzRaPILQNBSYVaIOYvxQR4Hcp2anDptRK
 O9Wtl2AA+Cm5XAGnhinEu9LKVA==
X-Google-Smtp-Source: AGHT+IFBmVM1jFTBKb6tzrSei8LhDAUidJTRfiCAWRicFaZfa0E9JSf1qCKcxGtpjxePO7xJZPSbJg==
X-Received: by 2002:a05:6a00:889:b0:71d:eb7d:20d5 with SMTP id
 d2e1a72fcca58-72abdd7b8fdmr31105365b3a.8.1735070728843; 
 Tue, 24 Dec 2024 12:05:28 -0800 (PST)
Received: from stoup.. (syn-156-019-246-023.biz.spectrum.com. [156.19.246.23])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8fb895sm10027159b3a.162.2024.12.24.12.05.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Dec 2024 12:05:28 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 07/72] tcg/optimize: Augment s_mask from z_mask in fold_masks_zs
Date: Tue, 24 Dec 2024 12:04:16 -0800
Message-ID: <20241224200521.310066-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241224200521.310066-1-richard.henderson@linaro.org>
References: <20241224200521.310066-1-richard.henderson@linaro.org>
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

Consider the passed s_mask to be a minimum deduced from
either existing s_mask or from a sign-extension operation.
We may be able to deduce more from the set of known zeros.
Remove identical logic from several opcode folders.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index d70127b88d..d8f6542c4f 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1048,6 +1048,7 @@ static bool fold_const2_commutative(OptContext *ctx, TCGOp *op)
  * Record "zero" and "sign" masks for the single output of @op.
  * See TempOptInfo definition of z_mask and s_mask.
  * If z_mask allows, fold the output to constant zero.
+ * The passed s_mask may be augmented by z_mask.
  */
 static bool fold_masks_zs(OptContext *ctx, TCGOp *op,
                           uint64_t z_mask, uint64_t s_mask)
@@ -1080,7 +1081,7 @@ static bool fold_masks_zs(OptContext *ctx, TCGOp *op,
 
     ti = ts_info(ts);
     ti->z_mask = z_mask;
-    ti->s_mask = s_mask;
+    ti->s_mask = s_mask | smask_from_zmask(z_mask);
     return true;
 }
 
@@ -1519,8 +1520,8 @@ static bool fold_bswap(OptContext *ctx, TCGOp *op)
     default:
         g_assert_not_reached();
     }
-    s_mask = smask_from_zmask(z_mask);
 
+    s_mask = 0;
     switch (op->args[2] & (TCG_BSWAP_OZ | TCG_BSWAP_OS)) {
     case TCG_BSWAP_OZ:
         break;
@@ -1534,7 +1535,6 @@ static bool fold_bswap(OptContext *ctx, TCGOp *op)
     default:
         /* The high bits are undefined: force all bits above the sign to 1. */
         z_mask |= sign << 1;
-        s_mask = 0;
         break;
     }
     ctx->z_mask = z_mask;
@@ -1605,7 +1605,6 @@ static bool fold_count_zeros(OptContext *ctx, TCGOp *op)
         g_assert_not_reached();
     }
     ctx->z_mask = arg_info(op->args[2])->z_mask | z_mask;
-    ctx->s_mask = smask_from_zmask(ctx->z_mask);
     return false;
 }
 
@@ -1625,7 +1624,6 @@ static bool fold_ctpop(OptContext *ctx, TCGOp *op)
     default:
         g_assert_not_reached();
     }
-    ctx->s_mask = smask_from_zmask(ctx->z_mask);
     return false;
 }
 
@@ -1746,7 +1744,6 @@ static bool fold_extract(OptContext *ctx, TCGOp *op)
         return true;
     }
     ctx->z_mask = z_mask;
-    ctx->s_mask = smask_from_zmask(z_mask);
 
     return fold_masks(ctx, op);
 }
@@ -1851,7 +1848,6 @@ static bool fold_extu(OptContext *ctx, TCGOp *op)
     }
 
     ctx->z_mask = z_mask;
-    ctx->s_mask = smask_from_zmask(z_mask);
     if (!type_change && fold_affected_mask(ctx, op, z_mask_old ^ z_mask)) {
         return true;
     }
@@ -2116,10 +2112,10 @@ static bool fold_qemu_ld(OptContext *ctx, TCGOp *op)
     int width = 8 * memop_size(mop);
 
     if (width < 64) {
-        ctx->s_mask = MAKE_64BIT_MASK(width, 64 - width);
-        if (!(mop & MO_SIGN)) {
+        if (mop & MO_SIGN) {
+            ctx->s_mask = MAKE_64BIT_MASK(width, 64 - width);
+        } else {
             ctx->z_mask = MAKE_64BIT_MASK(0, width);
-            ctx->s_mask <<= 1;
         }
     }
 
@@ -2354,7 +2350,6 @@ static bool fold_setcond(OptContext *ctx, TCGOp *op)
     fold_setcond_tst_pow2(ctx, op, false);
 
     ctx->z_mask = 1;
-    ctx->s_mask = smask_from_zmask(1);
     return false;
 }
 
@@ -2455,7 +2450,6 @@ static bool fold_setcond2(OptContext *ctx, TCGOp *op)
     }
 
     ctx->z_mask = 1;
-    ctx->s_mask = smask_from_zmask(1);
     return false;
 
  do_setcond_const:
@@ -2649,21 +2643,18 @@ static bool fold_tcg_ld(OptContext *ctx, TCGOp *op)
         break;
     CASE_OP_32_64(ld8u):
         ctx->z_mask = MAKE_64BIT_MASK(0, 8);
-        ctx->s_mask = MAKE_64BIT_MASK(9, 55);
         break;
     CASE_OP_32_64(ld16s):
         ctx->s_mask = MAKE_64BIT_MASK(16, 48);
         break;
     CASE_OP_32_64(ld16u):
         ctx->z_mask = MAKE_64BIT_MASK(0, 16);
-        ctx->s_mask = MAKE_64BIT_MASK(17, 47);
         break;
     case INDEX_op_ld32s_i64:
         ctx->s_mask = MAKE_64BIT_MASK(32, 32);
         break;
     case INDEX_op_ld32u_i64:
         ctx->z_mask = MAKE_64BIT_MASK(0, 32);
-        ctx->s_mask = MAKE_64BIT_MASK(33, 31);
         break;
     default:
         g_assert_not_reached();
-- 
2.43.0


