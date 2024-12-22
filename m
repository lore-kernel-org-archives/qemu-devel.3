Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7CADE7718E
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Dec 2024 16:31:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tPOlt-0002vC-Mz; Sun, 22 Dec 2024 11:25:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tPOlC-0002YO-HM
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 11:24:55 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tPOlA-0002wu-Iz
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 11:24:54 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-21644aca3a0so36717695ad.3
 for <qemu-devel@nongnu.org>; Sun, 22 Dec 2024 08:24:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734884691; x=1735489491; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0XbbAA6tPaSy58TXvgA24Kz1zz5lDy83D/6o1p8rm3g=;
 b=rZK5jRYlN/Vgzlcx0BJWFazwuuPnecBgIqX4nM2Q1NE2X8nzhYd+L86ICBfO4qy6/n
 qzVM3C0S7lxRkgsKCkcyUMjR4y35tw5qgKc2vBH2wd5WSrrRcFtLOTYYIV2xGQgYWP/w
 7KvBgFvolUtWaexiZBLYsoaRXrTIHX4QdywfCBcJ2RRoFXPAgK1wmVtSvLaM+itEVD4W
 eQDgvpJHKvqkeW1OI7DCaZFE+yX+2gCPJ5g0lEKs6fblIiYtiiXaYsqit37po9sKbmeR
 IM8anrxYZeE/czAuP5WwGzS4DoLb6qBe8uoURrMyY5oy/GMeCn7e5AMZ+pUk5Usjv9Xc
 HqIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734884691; x=1735489491;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0XbbAA6tPaSy58TXvgA24Kz1zz5lDy83D/6o1p8rm3g=;
 b=LZPqIw3wUi4hWjFOjEmbGHd0RECPCjcywq/i55di7tqidi1KVXhoIRYlMK6tdGZd43
 p2RG+q34Goa64kgbL6yK8PQEWd7+15gHGEnBQOa+IV++FBb32LQo4jd9lsGaa01dwY17
 PZd7XHZGwdzWrgTDkip4SdV2o/We0WKmESOuuci68AgxVUX4KO7GYiMqLA3vtReaIGAE
 KhWxucKYKqpGNLi8H/q671kef/zLemTj8Z29RKhZI5SVySYGqdwJQeyTiQyCi/WZGIN8
 8cFXK6gt/tLqAI5Ih4ZJW0bhzFRWg7dDTh17JyjmxTCttWNwrAOBP9gqdMCmYxjG6Dpd
 JDxA==
X-Gm-Message-State: AOJu0Yww//OU/a1j4aT7iCKfE8zI+M6qvuzJeNqCfgkTOA5nNeQD1XbT
 R4J5VV50Vdj24OsR2bKXeRSqPNKhcUL5qPwjQtunELUXFMBqX6E4KKNuDnEuZHgTCI9K2z/MkMx
 mY/M=
X-Gm-Gg: ASbGncsNpWgEVWy3rUSwIW3iw7x8SeojPyrbmdnow9Gs72fiQN7VSLbgEBb4HHY25ju
 EWxcXXe9AmU1cwC/LAHl2Z2cIMX5BtLmBqe4WqsCnJDPvbx/zK70AMqqtmHnxeQs3IOWydAwAES
 DqGATRB3NbxJcycWpT9XQqEYfLmTnuQsDZbuv3XS+gfvZZeWaSHGke/qSyJbL/gMzJt9gcV6jYt
 cwwPL7shr+VbYa+qAu+GdfQ06Ywc+PB7TXtBWW3csPrg6jkPYis+qdr/yPjHQ8=
X-Google-Smtp-Source: AGHT+IE0SKwje3F08HzFL/roL7IaqRNRIwnXvbkD3eISG/gjtSAYkn0Qg10+Ikln8dEz1c4xW0/g+A==
X-Received: by 2002:a17:902:ce86:b0:215:a57e:88e7 with SMTP id
 d9443c01a7336-219e6e89215mr98982445ad.3.1734884691191; 
 Sun, 22 Dec 2024 08:24:51 -0800 (PST)
Received: from stoup.. ([71.212.144.252]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc971814sm58461385ad.79.2024.12.22.08.24.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Dec 2024 08:24:50 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 05/51] tcg/optimize: Augment s_mask from z_mask in
 fold_masks_zs
Date: Sun, 22 Dec 2024 08:24:00 -0800
Message-ID: <20241222162446.2415717-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241222162446.2415717-1-richard.henderson@linaro.org>
References: <20241222162446.2415717-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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


