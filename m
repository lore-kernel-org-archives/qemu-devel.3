Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9270AC48292
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Feb 2024 21:46:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWkEo-000237-5s; Sun, 04 Feb 2024 16:41:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rWkEe-00021k-B5
 for qemu-devel@nongnu.org; Sun, 04 Feb 2024 16:41:12 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rWkEc-0003V4-OK
 for qemu-devel@nongnu.org; Sun, 04 Feb 2024 16:41:08 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1d8aadc624dso28244155ad.0
 for <qemu-devel@nongnu.org>; Sun, 04 Feb 2024 13:41:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707082865; x=1707687665; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rCOb1ACImxEyjzPr7SpomivAS+ARwGZqu81A17yuvPw=;
 b=zGWpGWIOOa+A83MIp4yQ6zsLh4cl206ZIRXifP8eX6UVIRyKrpE8Vu0QsfNBwngWe8
 WNIkVLoJdE27SZTKjqIZSTmlhwsa6gHjBFouxxribFTfIVoAwDkcAfc24LsIvUn1BNVJ
 dcHghuz8wRWORv+oT2sYWxUwPklwGZ65KcHlFf3bwjnkwNDXKyghlc6UZgyEQK2y1Vc3
 Y1xvjh3VPdziLxjk1Qtp9pUXtD4Qc7QmUdSwN5bTd7tXoRsdBP3taDnKf0zC5AMc/I4o
 HlDu2cNtaQScF4sDT9YWzQNIQD723SsHo4xsDwb4k7lJAxVp5BKk+Be8X1yHuB8ZZKbe
 Q2pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707082865; x=1707687665;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rCOb1ACImxEyjzPr7SpomivAS+ARwGZqu81A17yuvPw=;
 b=jC1etv/wI6lCOHE0No0bfsg+X2xCOruwVOox5WRZ7gvEVI/obXrOkGnnDq+lNBXzbC
 qjAagV1FAd80f3MfChUVUDHC/24Z7AQ2eIjfgsujiLPUK9u4GZxxcZKP47Lrol7ewvPp
 idFKZgcOmr4APVBz7lk7RjMEnKtpyHV79Dj3UNpxAr/PELftNsKXKlDVO3f5Zp6UgWJH
 8nWALsMXZnzPh42iONRv03Ixv9WlW2L5GbLOmrZ6gk9aXO2kV6elwfVssVGr69qq3hC3
 Is0iLTi7U/JIFBfEPYfc2l86/yi6cdV8BAX8dFDSbb2RFIJbAfJrDtanRxDKE3RuVhcu
 m8Lw==
X-Gm-Message-State: AOJu0YznWbqsSSy7aJh5x5XFySzmwrACx4TmfRYLl0ZJ5PQ1J3Lz7vIo
 750Ej5EmBNMYnb9L3XyyaBTHhVJife0AYE8SqZSvSKQSV6Gr0aXNjOFgi1ghcC8VdtA4WQ9X+QZ
 Kseg=
X-Google-Smtp-Source: AGHT+IG6q5Wqp7tCfYI+TyYwosLBsCPDYOXY5Q7XeRqP5hOboGvR472IiZnFHTawhnxTJRzOMTslqA==
X-Received: by 2002:a17:902:f681:b0:1d9:a50f:90eb with SMTP id
 l1-20020a170902f68100b001d9a50f90ebmr2284593plg.38.1707082865182; 
 Sun, 04 Feb 2024 13:41:05 -0800 (PST)
Received: from stoup.. ([43.252.112.156]) by smtp.gmail.com with ESMTPSA id
 mf11-20020a170902fc8b00b001d8f5560503sm4953670plb.222.2024.02.04.13.41.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Feb 2024 13:41:04 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 04/39] tcg/optimize: Split out do_constant_folding_cond1
Date: Mon,  5 Feb 2024 07:40:17 +1000
Message-Id: <20240204214052.5639-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240204214052.5639-1-richard.henderson@linaro.org>
References: <20240204214052.5639-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Handle modifications to the arguments and condition
in a single place.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 57 ++++++++++++++++++++++++--------------------------
 1 file changed, 27 insertions(+), 30 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 73019b9996..9c04dba099 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -796,6 +796,23 @@ static bool swap_commutative2(TCGArg *p1, TCGArg *p2)
     return false;
 }
 
+static int do_constant_folding_cond1(OptContext *ctx, TCGArg dest,
+                                     TCGArg *p1, TCGArg *p2, TCGArg *pcond)
+{
+    TCGCond cond;
+    bool swap;
+    int r;
+
+    swap = swap_commutative(dest, p1, p2);
+    cond = *pcond;
+    if (swap) {
+        *pcond = cond = tcg_swap_cond(cond);
+    }
+
+    r = do_constant_folding_cond(ctx->type, *p1, *p2, cond);
+    return r;
+}
+
 static void init_arguments(OptContext *ctx, TCGOp *op, int nb_args)
 {
     for (int i = 0; i < nb_args; i++) {
@@ -1193,14 +1210,8 @@ static bool fold_andc(OptContext *ctx, TCGOp *op)
 
 static bool fold_brcond(OptContext *ctx, TCGOp *op)
 {
-    TCGCond cond = op->args[2];
-    int i;
-
-    if (swap_commutative(NO_DEST, &op->args[0], &op->args[1])) {
-        op->args[2] = cond = tcg_swap_cond(cond);
-    }
-
-    i = do_constant_folding_cond(ctx->type, op->args[0], op->args[1], cond);
+    int i = do_constant_folding_cond1(ctx, NO_DEST, &op->args[0],
+                                      &op->args[1], &op->args[2]);
     if (i == 0) {
         tcg_op_remove(ctx->tcg, op);
         return true;
@@ -1695,21 +1706,18 @@ static bool fold_mov(OptContext *ctx, TCGOp *op)
 
 static bool fold_movcond(OptContext *ctx, TCGOp *op)
 {
-    TCGCond cond = op->args[5];
     int i;
 
-    if (swap_commutative(NO_DEST, &op->args[1], &op->args[2])) {
-        op->args[5] = cond = tcg_swap_cond(cond);
-    }
     /*
      * Canonicalize the "false" input reg to match the destination reg so
      * that the tcg backend can implement a "move if true" operation.
      */
     if (swap_commutative(op->args[0], &op->args[4], &op->args[3])) {
-        op->args[5] = cond = tcg_invert_cond(cond);
+        op->args[5] = tcg_invert_cond(op->args[5]);
     }
 
-    i = do_constant_folding_cond(ctx->type, op->args[1], op->args[2], cond);
+    i = do_constant_folding_cond1(ctx, NO_DEST, &op->args[1],
+                                  &op->args[2], &op->args[5]);
     if (i >= 0) {
         return tcg_opt_gen_mov(ctx, op, op->args[0], op->args[4 - i]);
     }
@@ -1723,6 +1731,7 @@ static bool fold_movcond(OptContext *ctx, TCGOp *op)
         uint64_t tv = arg_info(op->args[3])->val;
         uint64_t fv = arg_info(op->args[4])->val;
         TCGOpcode opc, negopc = 0;
+        TCGCond cond = op->args[5];
 
         switch (ctx->type) {
         case TCG_TYPE_I32:
@@ -1950,14 +1959,8 @@ static bool fold_remainder(OptContext *ctx, TCGOp *op)
 
 static bool fold_setcond(OptContext *ctx, TCGOp *op)
 {
-    TCGCond cond = op->args[3];
-    int i;
-
-    if (swap_commutative(op->args[0], &op->args[1], &op->args[2])) {
-        op->args[3] = cond = tcg_swap_cond(cond);
-    }
-
-    i = do_constant_folding_cond(ctx->type, op->args[1], op->args[2], cond);
+    int i = do_constant_folding_cond1(ctx, op->args[0], &op->args[1],
+                                      &op->args[2], &op->args[3]);
     if (i >= 0) {
         return tcg_opt_gen_movi(ctx, op, op->args[0], i);
     }
@@ -1969,14 +1972,8 @@ static bool fold_setcond(OptContext *ctx, TCGOp *op)
 
 static bool fold_negsetcond(OptContext *ctx, TCGOp *op)
 {
-    TCGCond cond = op->args[3];
-    int i;
-
-    if (swap_commutative(op->args[0], &op->args[1], &op->args[2])) {
-        op->args[3] = cond = tcg_swap_cond(cond);
-    }
-
-    i = do_constant_folding_cond(ctx->type, op->args[1], op->args[2], cond);
+    int i = do_constant_folding_cond1(ctx, op->args[0], &op->args[1],
+                                      &op->args[2], &op->args[3]);
     if (i >= 0) {
         return tcg_opt_gen_movi(ctx, op, op->args[0], -i);
     }
-- 
2.34.1


