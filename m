Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 847FCE77180
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 15:25:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL26h-0004rN-Lm; Tue, 10 Dec 2024 10:25:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL26T-0004PT-4r
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 10:24:49 -0500
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL26R-0008Ok-JA
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 10:24:48 -0500
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-3ea696c4dcaso2750952b6e.2
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 07:24:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733844286; x=1734449086; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lIaqwHIAjwY7azknBwNtOhCbYad08/pBvrAzkfqNf5k=;
 b=Tgn0h1KYizpzxPOuYhlxZYT44Jv+FIuANeC7NFgOdk9rfGN1KQqjziZeOvl/i9+rZH
 e39+0S/jIya8LrnImwhbarY9NlhclB1LKEsyoEVUDU5A8N40x3NBpxWah7BJrEU2HysS
 AC47LCYkAXzqwrAyH91ea+RLITbft7bopoyvEC6p+hm++FXv/gW1UCvUtyWYF8x34CGi
 wmzoRJpIhD72EWkQx5A12L4qYyN23jPNDEaiVUSZJEGcI4BFke3uZfH7nuizPjG9wOF0
 MzS4bbEwW49DUOpDZ9AjbTSZdmygt1NKqg96jfaD9GB9gBXuLJVKettm2ec+YiC31eo7
 3TbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733844286; x=1734449086;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lIaqwHIAjwY7azknBwNtOhCbYad08/pBvrAzkfqNf5k=;
 b=qoOwTR9AkuzL1FDXSj4vKBRakET2hgBuoaUpIAT2bZ9hgxsl1wfEQF1K4fHvh9wtKM
 hzWHWFGj3S/RIzVkEXo9SwL2hfvOYfZDSW6sKoSMEzj7PJR+pUbH1Qu41BNKyG5q8d7B
 4gjEqF0PnIkGxEDi56rtoVhWKe+KxcmDykZIT9wUQSMgA0xuVN0CnJ0fP5v3+iGSJ15l
 7N/cZmqizpVyVpl1zftGYJRhVJ3vkuIeioIIc6gF3I6yCmgoobgnqghZZ0eKeTIr6Ilc
 8ug43c0KWvWm/75nDvsSSvm34aqyZ7E+YKiKLXYF2tzXgcip0TVCujgFxRhlqXPu6e9k
 FFOA==
X-Gm-Message-State: AOJu0YxOk8DNlby/OuGVXX1GbZFLKD07sYVs2bo/xC3EHc6i07ai3n12
 tMp+Ns2v4eUSQU3Mtbvm2P/gNzNhPkl3yes3quTRQ0xpyPga+3DRWAzMQthQa8spZyUu30pXy5P
 vgFoCNqCF
X-Gm-Gg: ASbGncsoUuS93BPLNXpRl7VaGT0izlqQCOVI25dnQgLYUQybU5+AEZatmmt9ReTMPj+
 YFwUD0u7AerFTqZM2MsnZZWMfiXEMrbEBaidtXdWlYFWo7u1QQaWvjXd8d+r4bxsXtflVyQuvv/
 coSzHv3YYPcVqMNt/BT/UGwcsYpPtJnIiGZUr9n+qFFQPwhM9gI92kAwWpExT91jPaw/XPU027z
 HRbfP7ekDpW+784N4N6sp/O/6NGTgcbDg/CMf/+4uXkiPU39iAH5D45U2HFoQ==
X-Google-Smtp-Source: AGHT+IEd7GcZzFyeQ+Ib9m/nDb8fv9RqIUtRVEvUHghNCA1sSjA6JRBGeEhOC8ks7IH0V8Vet8uOPw==
X-Received: by 2002:a05:6808:1790:b0:3eb:7399:29d3 with SMTP id
 5614622812f47-3eb73992f5fmr806183b6e.43.1733844286379; 
 Tue, 10 Dec 2024 07:24:46 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3eb076b9168sm2776435b6e.14.2024.12.10.07.24.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2024 07:24:46 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 30/46] tcg/optimize: Distinguish simplification in
 fold_setcond_zmask
Date: Tue, 10 Dec 2024 09:23:45 -0600
Message-ID: <20241210152401.1823648-31-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241210152401.1823648-1-richard.henderson@linaro.org>
References: <20241210152401.1823648-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22a;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22a.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index eac5ef5eec..7b1d437c27 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2137,7 +2137,8 @@ static bool fold_remainder(OptContext *ctx, TCGOp *op)
     return finish_folding(ctx, op);
 }
 
-static bool fold_setcond_zmask(OptContext *ctx, TCGOp *op, bool neg)
+/* Return 1 if finished, -1 if simplified, 0 if unchanged. */
+static int fold_setcond_zmask(OptContext *ctx, TCGOp *op, bool neg)
 {
     uint64_t a_zmask, b_val;
     TCGCond cond;
@@ -2232,11 +2233,10 @@ static bool fold_setcond_zmask(OptContext *ctx, TCGOp *op, bool neg)
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
@@ -2341,10 +2341,13 @@ static bool fold_setcond(OptContext *ctx, TCGOp *op)
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
     ctx->s_mask = smask_from_zmask(1);
@@ -2359,10 +2362,13 @@ static bool fold_negsetcond(OptContext *ctx, TCGOp *op)
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


