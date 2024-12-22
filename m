Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C324DE7718E
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Dec 2024 16:26:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tPOm0-00030o-R5; Sun, 22 Dec 2024 11:25:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tPOlW-0002dx-GF
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 11:25:18 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tPOlS-0003Co-3A
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 11:25:12 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-21644e6140cso32702085ad.1
 for <qemu-devel@nongnu.org>; Sun, 22 Dec 2024 08:25:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734884709; x=1735489509; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4BtN01qHf4NStr5HfnCgLN4wWtjyN28d7bH0qA/vFoE=;
 b=FuSoE+23Jmwwi8Uk0VsqhCjWo1k+JZru3SXVGiKY9a3+tW4WnqEQA3FbNLQRmOMDv2
 qTAHCDGMCHGRZn/En5dDxmenxddcbF/1d5FiZ1i5+vYOl8VbYf6cf7mmKbroaQbIT7nM
 zZL9giDj9Iq6yAXO0gDtrUNd6mMHkC1XNcH9l6dgK1SdZy1Lih3mNHdcl9nccemxV//w
 2e1O2tE0khtK5XxdIDX71Bw2V7ZylM7lMcnwfEdTFY90VHn7HeHmtJGy4f0pBzGSLE5L
 QUQBFgpE5Pk0qKzWdgwE4N7qNI6ajB5IfR3Bil1PUxQNoGlGt9X7eU7L9B/Qvi/xAYu/
 KhNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734884709; x=1735489509;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4BtN01qHf4NStr5HfnCgLN4wWtjyN28d7bH0qA/vFoE=;
 b=cfuIE/m9oR3CXD/fXDx50I6doA5Qj7RyeuICKI4M/PnaFNX9G10lJ+B2Ijrv3bqysU
 XD9uiwOL3Xi0i+Jtk740knyD+wgG2r1Z6w19pUHv189zyO8hoETlTUmn7Wvm22mIK8Dx
 cM5wZex3Fu3VjRXAo55LJAxvj0QZS3evX+lcauHcAu55MQMkcf2FSGTYxus7+RtlWwUp
 K0Nei87k8hHWK9Q8KjOwr6xxGZxGbvpud8kwJxKBp4zC9hd85HkTQ6lO6ycE0EbHnVtD
 8Rw8bJtSioDGDigiTlCxC8j1/o8S5X8ipeZK5Qp/rK5s7wXOz5px2domM4sGVUnWcNF8
 iviQ==
X-Gm-Message-State: AOJu0YxXlCKwkCxUFdM81QWp43Jjx1Ff+d/B0SIINSZgpe5Iw4fQySdv
 aHL2vV86F72SylFx654Vat0jpu+qSYCS1xDxPPGefPCui1Us8O4zK7M+jh9GDXREJ3OTqHGpc69
 hy6w=
X-Gm-Gg: ASbGncsEW/CYXM0yAMsBCVtF87753gMt5tdQjEo+vyLBqM7NcQhR+W6usAWcfIMki3F
 Vt1jJ+VNwZblN5n9NMowrzcNbbLY1sngunGQUkl7vsDb8MgPfWCQqgkN1stx7BXT6lSIDtYWgZw
 ONe5P9teiia8BdvGBRnA1mCXTMYG41ttVxEo4CA0LzdqhnzsB3FSn2h5TtMUYwIgvrAU/fi+pT0
 0etk/NboqNO8Fw2JjUlErEjVJFvQUG3VyT+VDjFLla0LB4TtiSHY1PzefJpErg=
X-Google-Smtp-Source: AGHT+IH/5/Yjj8yZqPNviJpNCz1qXYJq5tSJ2LY0w09UCqmFJJUr0uyLHw/zpYrc3Oh4Nfn7bp8Rsw==
X-Received: by 2002:a17:903:3203:b0:215:5d8c:7e43 with SMTP id
 d9443c01a7336-219e6f497b3mr137446965ad.54.1734884708780; 
 Sun, 22 Dec 2024 08:25:08 -0800 (PST)
Received: from stoup.. ([71.212.144.252]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc971814sm58461385ad.79.2024.12.22.08.25.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Dec 2024 08:25:08 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 33/51] tcg/optimize: Distinguish simplification in
 fold_setcond_zmask
Date: Sun, 22 Dec 2024 08:24:28 -0800
Message-ID: <20241222162446.2415717-34-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241222162446.2415717-1-richard.henderson@linaro.org>
References: <20241222162446.2415717-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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
index c44356cf73..b401287ce1 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2138,7 +2138,8 @@ static bool fold_remainder(OptContext *ctx, TCGOp *op)
     return finish_folding(ctx, op);
 }
 
-static bool fold_setcond_zmask(OptContext *ctx, TCGOp *op, bool neg)
+/* Return 1 if finished, -1 if simplified, 0 if unchanged. */
+static int fold_setcond_zmask(OptContext *ctx, TCGOp *op, bool neg)
 {
     uint64_t a_zmask, b_val;
     TCGCond cond;
@@ -2233,11 +2234,10 @@ static bool fold_setcond_zmask(OptContext *ctx, TCGOp *op, bool neg)
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
@@ -2342,10 +2342,13 @@ static bool fold_setcond(OptContext *ctx, TCGOp *op)
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


