Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B8ADE77188
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2024 20:09:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQBAz-0004Iw-5U; Tue, 24 Dec 2024 15:06:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tQBAE-0002yL-RV
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 15:05:59 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tQBAD-0002e6-8r
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 15:05:58 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-21634338cfdso79720935ad.2
 for <qemu-devel@nongnu.org>; Tue, 24 Dec 2024 12:05:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735070756; x=1735675556; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KTUO0uF94ggO8DLruNGc154B1KXBI7ow/g7ffKKGvr4=;
 b=aeDKKiBsClZ3Hfde1gVNPsU5MzqNr+Sbe29iQUDirxarUNVY7EEbpnjgRGu/g9Mdj6
 Qu3AMohNY6S7piJ5j4jsLCH1vnpoQfCySit6B+dbVXlhSko8pAHLwVfHpaJGCjRTkoGM
 EN/Xyd41y6uCf5MW1hmRX97kHUXx74RfqsqPLQyUph8cLQa2aEdYQxfV+9kiFqXLTbdn
 JbEgyuPSOxHbh40kKK8is8eXilYNPp7XUPpkBxN2ol7h5B/jf70VXqAP/Vi9vq2tf0J1
 65dwl9YDV2BGr1L3JUuicH5mLq3eX2YLH/SAojMMxfaQn+mBbTPLaYLnTDXXneXhWEbO
 38gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735070756; x=1735675556;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KTUO0uF94ggO8DLruNGc154B1KXBI7ow/g7ffKKGvr4=;
 b=UbV9Vbee4u1zvsnyFLallbkmV1gKKIpeJk7oUUu9j05NKnHFmHBEejucG+LLq7SBhQ
 J939gWCda/mWevpRbl5eA+AmU/Zuk7zNKR2G68bojUPxSe2Xnrt5ciCOfjCKT/PeAmrR
 0JS5Tynnvy8QzkerhNSFd5fiRJ9nTB27e6yCXvhdxVZhy/Qh1Yw4XIBXFa7h4P0vk88k
 15cZ58E01L6eNOyka1fvNBYd3tFhRsZXO3ZIe4VJoOX391SvhMT7Ae6uWyFw/r91U+bQ
 ZEXO+DG21L7r/u4hd+b+Fk/9XUf6R7A3lj7WOdE0mhXm49as5dktMgD5HQUs68jF3CVr
 LUYw==
X-Gm-Message-State: AOJu0YwQ7bF4iBJBGMiplS0tmBxP2S3ugqF+sK2+fMNhDDZTc0RSeo/M
 3TkMA6uysmXmlRXRVPXnr2Wyp5Paf1S27z+fmxDo1ZGRUDpVUOsl4YmsIrNT2cE/6SShbP7HvPg
 pShA=
X-Gm-Gg: ASbGncsgt8JHsAS6xa9lLro8Zmr8cqSN0fAInlTQQtpVmBXCjTZl1+L1seGN6H64lX1
 lCiz88KSbm1Lk66lJHLkabEpu9q41i/oTkO+JrFNjiPMj3SSDpLZeyva2L7mmsNszVN6U1Fl3kF
 8itnHnjmiq2dSDn7yYyy/JkBch6E5zSmyHDPMwlV78RxeDLHRz6h9PnqgSpvO+pEBC+xUR+npCh
 k29o5tD710C+8rUboj3YpLGk5U/FihUdJcx9ZHNX8i8F5KplWgH0TqKGlbKEi9z68AlwXBjIj0U
 bWnA/8ABsRtNhbtfNnx0BK0o1g==
X-Google-Smtp-Source: AGHT+IH7hDttmrGY8SarAQL2EvDau3KT4ilPoFmFbfWryvVvi8NUagtsDO1Fez/8nbzgOIhWkZZavw==
X-Received: by 2002:a05:6a20:c907:b0:1e0:e07f:2f01 with SMTP id
 adf61e73a8af0-1e5df939d84mr25801344637.0.1735070756035; 
 Tue, 24 Dec 2024 12:05:56 -0800 (PST)
Received: from stoup.. (syn-156-019-246-023.biz.spectrum.com. [156.19.246.23])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8fb895sm10027159b3a.162.2024.12.24.12.05.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Dec 2024 12:05:55 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 36/72] tcg/optimize: Distinguish simplification in
 fold_setcond_zmask
Date: Tue, 24 Dec 2024 12:04:45 -0800
Message-ID: <20241224200521.310066-37-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241224200521.310066-1-richard.henderson@linaro.org>
References: <20241224200521.310066-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

Change return from bool to int; distinguish between
complete folding, simplification, and no change.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index e78f5a79a3..678015a94a 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2155,7 +2155,8 @@ static bool fold_remainder(OptContext *ctx, TCGOp *op)
     return finish_folding(ctx, op);
 }
 
-static bool fold_setcond_zmask(OptContext *ctx, TCGOp *op, bool neg)
+/* Return 1 if finished, -1 if simplified, 0 if unchanged. */
+static int fold_setcond_zmask(OptContext *ctx, TCGOp *op, bool neg)
 {
     uint64_t a_zmask, b_val;
     TCGCond cond;
@@ -2250,11 +2251,10 @@ static bool fold_setcond_zmask(OptContext *ctx, TCGOp *op, bool neg)
                 op->opc = xor_opc;
                 op->args[2] = arg_new_constant(ctx, 1);
             }
-            return false;
+            return -1;
         }
     }
-
-    return false;
+    return 0;
 }
 
 static void fold_setcond_tst_pow2(OptContext *ctx, TCGOp *op, bool neg)
@@ -2359,10 +2359,13 @@ static bool fold_setcond(OptContext *ctx, TCGOp *op)
         return tcg_opt_gen_movi(ctx, op, op->args[0], i);
     }
 
-    if (fold_setcond_zmask(ctx, op, false)) {
+    i = fold_setcond_zmask(ctx, op, false);
+    if (i > 0) {
         return true;
     }
-    fold_setcond_tst_pow2(ctx, op, false);
+    if (i == 0) {
+        fold_setcond_tst_pow2(ctx, op, false);
+    }
 
     ctx->z_mask = 1;
     return false;
@@ -2376,10 +2379,13 @@ static bool fold_negsetcond(OptContext *ctx, TCGOp *op)
         return tcg_opt_gen_movi(ctx, op, op->args[0], -i);
     }
 
-    if (fold_setcond_zmask(ctx, op, true)) {
+    i = fold_setcond_zmask(ctx, op, true);
+    if (i > 0) {
         return true;
     }
-    fold_setcond_tst_pow2(ctx, op, true);
+    if (i == 0) {
+        fold_setcond_tst_pow2(ctx, op, true);
+    }
 
     /* Value is {0,-1} so all bits are repetitions of the sign. */
     ctx->s_mask = -1;
-- 
2.43.0


