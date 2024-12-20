Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A044E7718A
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 04:16:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOUM7-0008Mh-SU; Thu, 19 Dec 2024 23:11:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tOUM4-0008KL-64
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 23:11:12 -0500
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tOUM2-0006GQ-7c
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 23:11:11 -0500
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2ee786b3277so984832a91.1
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 20:11:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734667869; x=1735272669; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+TJ5IfnYTy94xBh6uHrxnvEXKZnmCMvGdvkeZvXUxGM=;
 b=L3EaXDcGu71FElBWglDSqRiBfD6ek4SopLanQzCV7mOSdiKOd94fw6NhYzVxF2+Eis
 +TsrQ9Qa4OHEjn11q4pKDrPNscqtb8rRqnyuilP7sjMjZlD5yU6bhScUihAYHUctVrh6
 Tc34RAMoS3UGyVGRfLySU5MqXLXA/SwBzkrUXS7ZdHzHFMaDG3zrxskiwhp794LMROEp
 9I2/Uq4n5Bm7f+XE1odEQLe1RjIlkQBW4XV9To4KGqHAdCIY2PERBna44V68JLdoJI+P
 ONteupoPkLY7CWB06xaWxa/9OzLxcwAS1eDS+HQI0/8CfX8gpxLjal/33VJk/dGc1zKM
 i4pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734667869; x=1735272669;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+TJ5IfnYTy94xBh6uHrxnvEXKZnmCMvGdvkeZvXUxGM=;
 b=KOgLotv4mzFgNSzqr9qEAu9Ym3UscTRX+Rk/vFU+XJED/zQDmMDyLY9pztV9ZzcJpS
 9N1RAY/Z11H/OycHyJo1He03SqRHWy7QGUBrLgJxUdiKQDeQmL+4nk1qgv7xlBzcdYFw
 Cg2tLAMcAHqtOAny4cTZmVrStT4u1poEoNy/JZHkpeLHVREkMlouWsm/62DnLYtb/8DV
 8y0OnLfZ1/IlcwY1b6g9/kyHYHsbVF1AhjJcxLhfK0sQdaqbH+TiFuCwXFOplYxMT9Ux
 XiVDgV0vxesCrsOFDZtLu1Kz8lXtbOnHLctRXWemTnLrGwjFlI4Ykbb5g+qRMhN3iZHL
 QgBg==
X-Gm-Message-State: AOJu0Yz8dfxqaN6PYuOi7iDTiMIo8UlIOvfFEgCEx7AQ/iN5JI0eugYB
 OSkW8HgFlm6yc8+GdXaLJxNkLEtXWrcHpdgAcufJl6Z5W44yQ33RY5HBf8XdNgfWQuBfoohjC7q
 C
X-Gm-Gg: ASbGnctNy63y1eRzrW12IgLidpxrUMMkt0dO3f2Ntw2bynpHDz3zCDAqVKoEbsEXz6G
 5PnQK/8+QAT7+hA2/FMboyBuVxyyDeEBjN8ZdFO9QBxQ9ar4S+OY0wrAcW6pVx2pxWvq0P3sfII
 DhUlZAlOMLxiVmz6W7kfYg22AlzXLEWZr1WMfA2pm9kfCuZavDXPziaFJEEXmnydxor8JataiYP
 71u4lzxVLr1STC0m+59ypv7GDLazUsIZi1ZOgFkCrxiau4BhpBATdZigo2/Bc8=
X-Google-Smtp-Source: AGHT+IGFvR7zeq7kxnnsbuSCTs3wnRQz0o35HpYaW+ox7SBZSptoNFKN9NC+bm+bemq9vgdf9jow3w==
X-Received: by 2002:a17:90b:5184:b0:2ee:d824:b594 with SMTP id
 98e67ed59e1d1-2f452eeb56cmr1929180a91.31.1734667868786; 
 Thu, 19 Dec 2024 20:11:08 -0800 (PST)
Received: from stoup.. ([71.212.144.252]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f2ee26fc22sm4165260a91.51.2024.12.19.20.11.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 20:11:08 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 05/51] tcg/optimize: Augment s_mask from z_mask in
 fold_masks_zs
Date: Thu, 19 Dec 2024 20:10:17 -0800
Message-ID: <20241220041104.53105-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241220041104.53105-1-richard.henderson@linaro.org>
References: <20241220041104.53105-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1036.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index d70127b88d..17b72fe759 100644
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
-- 
2.43.0


