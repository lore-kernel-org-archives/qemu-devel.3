Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53DCBE7718A
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 04:14:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOUMX-00005F-Fp; Thu, 19 Dec 2024 23:11:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tOUMM-0008RA-MW
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 23:11:31 -0500
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tOUML-0006Nv-8o
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 23:11:30 -0500
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2eeb4d643a5so1396874a91.3
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 20:11:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734667888; x=1735272688; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7JAIS9jf3/vTegmrONjuLySkdEA9/VNp6mDNTKWpQWM=;
 b=slaoGemb8D/JFK6Y0RQRY1qbDCCY7LlSm8Plal28dzYfEabxD4ETi4yIrAbzSTJhO+
 w/dW6MbC3gt9WDi+bL6c9PXww95P7JnwbbNfRxWpRLx2vZw9BcmF2gtzYKmFAy1x7gwc
 worx/cwe5CH6BH9/F8V4+rWtyeM/MtR3yGQ9StOOKSW/DhINsz5XfZFTe9zFJXIaDX6H
 h1+HPlw7sbZLn7TyH1cMFvQYDJ8uwwWXp1eExuuLnWuiy9zJXKM4oC3a68G39GRKQNAs
 9JX91qlvmpthilKPi7K0KmF6R0nyXktlWWgtD7uDdIxtjveq23szPzIJzsm0eBEhW8Wa
 YFWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734667888; x=1735272688;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7JAIS9jf3/vTegmrONjuLySkdEA9/VNp6mDNTKWpQWM=;
 b=nkd/oxW0GvzG/TdUbvK0RF6mcU6b70E0LomR4yj7stDdNmTLIugptoPjwhbpCZknIe
 F7kv+3GlP3ZW4r3fYycu4y2vsB1CADCwpSStFXDEvEkYUSwpcLfKJAk97Tg40BzcR5YO
 +3kRf/L/O/+Xe3tf4B4bYg/W5QeMbw145joUoRSlmUmIGFNWkgWYcbduROQINUBpDnY6
 UaCqq2LhsnQKCe4N1bXu78s5+aKOvcXSrqQQtkBMcjD3yDs8FtJlK7BWdpvBh3ipFLbz
 7qzH2uZ7OdEhS+19B1YUJygw9M54BoSPBK6Qi3jhpGjyMoG/W++e1658IAPTzBxpmcCN
 ehLQ==
X-Gm-Message-State: AOJu0YyNl7jxuitpSgcuEnrxJpsZ7rtWnrLcia1w9QyVkuVL3mzWrm54
 ipLrk67K0d3x2PG+lQETdfkcmxksBQMUXOj4xms4qMf0NOalygfoCB+UqZmPvTX/pgdgst9Pkvh
 7
X-Gm-Gg: ASbGncvv/z2eqU1grh613N67F1/TVESa3s/ji16T2yHe5YhQwiPgQnRv8Lj9cKRYsvt
 Dh7JuG9BJXpHxWEz4XvM+2y7gxn9vleD7x4Rdd3u5L5+GQSbI+3CIIOvSqCZi46gqus4BsNtEXu
 Woo372yfgqapgwPlWplDHKkjBVwhjvt6lvsmYOpRbO7Jt08ukV7U5Jbtu5DwxV82Etmr5qA1EG6
 w2Ha9ocNtqzm2SPZ36eYAINNXu+48pToiwD/XfGz7WyEDFZp0nnbj19dQyyvm4=
X-Google-Smtp-Source: AGHT+IHKwLryWjmnVnge3EsIQ4REYoZTY6MXDsUBgCOyRC0pMOWkBjqLav4aj2voSjSsyk4z4utL1A==
X-Received: by 2002:a17:90b:2545:b0:2ee:74a1:fba2 with SMTP id
 98e67ed59e1d1-2f452e3e83cmr2253204a91.20.1734667888075; 
 Thu, 19 Dec 2024 20:11:28 -0800 (PST)
Received: from stoup.. ([71.212.144.252]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f2ee26fc22sm4165260a91.51.2024.12.19.20.11.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 20:11:27 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 32/51] tcg/optimize: Distinguish simplification in
 fold_setcond_zmask
Date: Thu, 19 Dec 2024 20:10:44 -0800
Message-ID: <20241220041104.53105-33-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241220041104.53105-1-richard.henderson@linaro.org>
References: <20241220041104.53105-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102b.google.com
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
index 868da884f1..9c4bb1fb91 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2172,7 +2172,8 @@ static bool fold_remainder(OptContext *ctx, TCGOp *op)
     return finish_folding(ctx, op);
 }
 
-static bool fold_setcond_zmask(OptContext *ctx, TCGOp *op, bool neg)
+/* Return 1 if finished, -1 if simplified, 0 if unchanged. */
+static int fold_setcond_zmask(OptContext *ctx, TCGOp *op, bool neg)
 {
     uint64_t a_zmask, b_val;
     TCGCond cond;
@@ -2267,11 +2268,10 @@ static bool fold_setcond_zmask(OptContext *ctx, TCGOp *op, bool neg)
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
@@ -2376,10 +2376,13 @@ static bool fold_setcond(OptContext *ctx, TCGOp *op)
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
@@ -2393,10 +2396,13 @@ static bool fold_negsetcond(OptContext *ctx, TCGOp *op)
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


