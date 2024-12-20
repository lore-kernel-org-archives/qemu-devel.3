Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 078B8E7718B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 04:16:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOUM8-0008Mx-Gr; Thu, 19 Dec 2024 23:11:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tOUM4-0008KT-E7
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 23:11:12 -0500
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tOUM2-0006Gh-Vi
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 23:11:12 -0500
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-7feb6871730so964035a12.2
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 20:11:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734667869; x=1735272669; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IKiuA+O0PzoDklDp6nENMYQ6rVNeilXqGGPdsOwMo3c=;
 b=BrR1h7FksGwxQEEX9bWYnW9LXtB1VsbzPa21OoIKCw2h5XAGjZvYnnWA70DO+QkhnA
 wQueOII8tPQfCnY+1GkhA51qL0euJrpkWQxGuPstw3B7ventN3T4wY3sOG1Sn10CneWi
 4X270mUzGdkeuFz/NqEIYoKjFipi4EF0BXI5QtQaxXD1QjryvpDNT+B6HjU+yIaPosw5
 YeWZijhjnJD+WI2C3SJZXW5xg3FKDjXl4XYlVQ5iHR0rAT++rO2+ADfyx3+cKuY5rTfQ
 wSeTgPBdItZbqeoluUehL9bPQ0MMZBWVQ0QH5wj1cDGAkhirA9ak71/PH0veAq2VkNwD
 k7/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734667869; x=1735272669;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IKiuA+O0PzoDklDp6nENMYQ6rVNeilXqGGPdsOwMo3c=;
 b=jFTuAh9pkKXzbsE0XNqY6YWvVfWoR3dsAkqaK82nEuaTsiVQMPTzO7KFgO9JGmi7XC
 e1t/NV+zncoasiPSZ7JRKjZpUw6uM0laZeCpBiVSDxx5KvK3Bsdq0NBPagJhqS6aBKZJ
 IZnikIWazSuFnhO36TGOm0yFUeNi81gY85UqrCwT3dw2bcCmS/GwEf+mDAgdNMHv5DQq
 jnrZi/BQDAzoUGVVik2xWkuO5lbv6OQ+LiNJ9b2xWai2DlY8snmv1C5mnI+TnnT2RNsv
 cQUBuBiAxz7aLzfn42U/UB/vgqPAuBse9eW80L7H3JofHb3yu8StvSdrF4bV2JrCluNz
 Sing==
X-Gm-Message-State: AOJu0YwTdZ6k1g0SxW/Z/s1nPFrhW+o+Ayc2AddJVohYCKfp+aPuCq5E
 u60OLGxIR2ZfaFTzRdO8GIdOW5+pmLzi0zerD/FqzJURYHebmyae4UljDKNEdqWpb8FJA5LXZBm
 g
X-Gm-Gg: ASbGnctuooXTWTcf58oBTvT0ZO6u2XKZoC84xk0PzQnKiFgYkhdpQPZJ8ZcwekFb9CM
 HKYOWEEaAZE/rJwPCE8hIq3UIwYVU3K4F5evUzlBBfrq/KOBz+ygD+87kDuJghph6M4ovNAlHJk
 y+B+uhUWLGYVUvTM3Vv6vmLJE38HJfo/BxOfCzPkvC/A1lysebTNIlOOhPWJXox7KX9BqhtltRT
 GacpuhY5uFNYP8/a3b1tLE5C02+fHoIE8MQC0BUagyOs32wcgcAotVOqO8rZgo=
X-Google-Smtp-Source: AGHT+IEy2P89cbnZ2Esj6YifdJxkld27YuEqpl/3/6NdhhUJq+6gkhL8Sj1BXWSlYEM4gcjckanO+A==
X-Received: by 2002:a17:90b:2dc8:b0:2ee:c797:e276 with SMTP id
 98e67ed59e1d1-2f452d3000cmr2701038a91.0.1734667869508; 
 Thu, 19 Dec 2024 20:11:09 -0800 (PST)
Received: from stoup.. ([71.212.144.252]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f2ee26fc22sm4165260a91.51.2024.12.19.20.11.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 20:11:09 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 06/51] tcg/optimize: Use finish_folding in fold_add,
 fold_add_vec, fold_addsub2
Date: Thu, 19 Dec 2024 20:10:18 -0800
Message-ID: <20241220041104.53105-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241220041104.53105-1-richard.henderson@linaro.org>
References: <20241220041104.53105-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x536.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 17b72fe759..41fd69365b 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -977,7 +977,7 @@ static void finish_ebb(OptContext *ctx)
     remove_mem_copy_all(ctx);
 }
 
-static void finish_folding(OptContext *ctx, TCGOp *op)
+static bool finish_folding(OptContext *ctx, TCGOp *op)
 {
     const TCGOpDef *def = &tcg_op_defs[op->opc];
     int i, nb_oargs;
@@ -995,6 +995,7 @@ static void finish_folding(OptContext *ctx, TCGOp *op)
             ts_info(ts)->s_mask = ctx->s_mask;
         }
     }
+    return true;
 }
 
 /*
@@ -1221,7 +1222,7 @@ static bool fold_add(OptContext *ctx, TCGOp *op)
         fold_xi_to_x(ctx, op, 0)) {
         return true;
     }
-    return false;
+    return finish_folding(ctx, op);
 }
 
 /* We cannot as yet do_constant_folding with vectors. */
@@ -1231,7 +1232,7 @@ static bool fold_add_vec(OptContext *ctx, TCGOp *op)
         fold_xi_to_x(ctx, op, 0)) {
         return true;
     }
-    return false;
+    return finish_folding(ctx, op);
 }
 
 static bool fold_addsub2(OptContext *ctx, TCGOp *op, bool add)
@@ -1298,7 +1299,7 @@ static bool fold_addsub2(OptContext *ctx, TCGOp *op, bool add)
         op->args[4] = arg_new_constant(ctx, bl);
         op->args[5] = arg_new_constant(ctx, bh);
     }
-    return false;
+    return finish_folding(ctx, op);
 }
 
 static bool fold_add2(OptContext *ctx, TCGOp *op)
-- 
2.43.0


