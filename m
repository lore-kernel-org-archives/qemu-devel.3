Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54A1AC4828F
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Feb 2024 21:45:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWkEp-00023b-AZ; Sun, 04 Feb 2024 16:41:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rWkEk-00022V-DG
 for qemu-devel@nongnu.org; Sun, 04 Feb 2024 16:41:14 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rWkEi-0003Va-NQ
 for qemu-devel@nongnu.org; Sun, 04 Feb 2024 16:41:14 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1d98fc5ebceso2084275ad.1
 for <qemu-devel@nongnu.org>; Sun, 04 Feb 2024 13:41:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707082871; x=1707687671; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zDxVow85zGZrsh8Lo3sBxluiD4KZqah1pBli11XwX78=;
 b=LOL9fgJsJcLWfTyAn/JLs4PU3Zh/qU7VF3iGqSXN7r3R+FtLmzI8EjntQ3FYO2D6jv
 2H0HL44WJYexqUso8/+eKxO7vpHZ6viAJksg2m5KPy49GebZASa5sZiFcWGKJRc+pU6K
 JR/ceoRx6XYBcQL1p4qOo7YOezWaWc+QERz6r6v1q8tIY6MbAroQmvcENZBWndx6WTm4
 07hL8gdHB/EGdSzWavAl7tkqjZBGRuiHJbH0yYoJhdUmvmcaB/YY+va6H3y6184s/TK8
 M+Njuwwq+s4dVbrCYFKZJmajP8XyYTUU1O2KwXERzmuXJMNYVxSKjKZOTrZ617ODssvc
 XqDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707082871; x=1707687671;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zDxVow85zGZrsh8Lo3sBxluiD4KZqah1pBli11XwX78=;
 b=nawOt+QfQXSao+xrZerno67ylarHimBiXQdbYkUKT8q2WrH1R3XUyAY/JL3vcZpFNP
 Yf4+jgVWbH2E2fFOQxzGcGoZt4Yx/Ecxp2MyDzB287RXAdRWRiIHj4bfIPd4S8C2YZam
 /J4Q9sHxLUup6HcQvvSyQmbH9mikB0Y624guDzGuwCIRvsB3oEeqDOWHCoS99/qoroB4
 BLQ6Ilc+zxFhhird7UwAOibP7Uhx3ZKuCsqj8w+mQAVt9DeimG1za2AU1xk+6EqC8Ku8
 8xp0JOtONXD30xpnnk25VadBoxYxpACqSbSKK+eAZkOoonxCC+Xf7XJBLo8t9yXpgiis
 Uo7w==
X-Gm-Message-State: AOJu0YzGh8hfHsLCZsuthTGHHzPxSyJRtRC2De5lXWLItAM8GOQEw1T5
 UMT2PId2yBFHemL1KHyA1LmzMGUWc93f9H6KO4SdzK16fLDe2PJLDKddYegqtY1mP5+5HWrDBQw
 AVVU=
X-Google-Smtp-Source: AGHT+IGpYL/F82Yl0BKFYkoYUb/RrmKrwQKLwG2v/zLlViRfH1fjRud2q01ETmDgt4dtKrQQx6J1zw==
X-Received: by 2002:a17:902:cec6:b0:1d9:4ebd:b94d with SMTP id
 d6-20020a170902cec600b001d94ebdb94dmr14796366plg.55.1707082871420; 
 Sun, 04 Feb 2024 13:41:11 -0800 (PST)
Received: from stoup.. ([43.252.112.156]) by smtp.gmail.com with ESMTPSA id
 mf11-20020a170902fc8b00b001d8f5560503sm4953670plb.222.2024.02.04.13.41.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Feb 2024 13:41:11 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 07/39] tcg/optimize: Lower TCG_COND_TST{EQ,NE} if unsupported
Date: Mon,  5 Feb 2024 07:40:20 +1000
Message-Id: <20240204214052.5639-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240204214052.5639-1-richard.henderson@linaro.org>
References: <20240204214052.5639-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

After having performed other simplifications, lower any
remaining test comparisons with AND.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-internal.h |  2 ++
 tcg/optimize.c     | 60 +++++++++++++++++++++++++++++++++++++++-------
 tcg/tcg.c          |  2 +-
 3 files changed, 55 insertions(+), 9 deletions(-)

diff --git a/tcg/tcg-internal.h b/tcg/tcg-internal.h
index 6c9d9e48db..9b0d982f65 100644
--- a/tcg/tcg-internal.h
+++ b/tcg/tcg-internal.h
@@ -83,6 +83,8 @@ static inline TCGv_i64 TCGV128_HIGH(TCGv_i128 t)
 
 bool tcg_target_has_memory_bswap(MemOp memop);
 
+TCGTemp *tcg_temp_new_internal(TCGType type, TCGTempKind kind);
+
 /*
  * Locate or create a read-only temporary that is a constant.
  * This kind of temporary need not be freed, but for convenience
diff --git a/tcg/optimize.c b/tcg/optimize.c
index 2ed6322f97..79e701652b 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -364,6 +364,13 @@ static TCGArg arg_new_constant(OptContext *ctx, uint64_t val)
     return temp_arg(ts);
 }
 
+static TCGArg arg_new_temp(OptContext *ctx)
+{
+    TCGTemp *ts = tcg_temp_new_internal(ctx->type, TEMP_EBB);
+    init_ts_info(ctx, ts);
+    return temp_arg(ts);
+}
+
 static bool tcg_opt_gen_mov(OptContext *ctx, TCGOp *op, TCGArg dst, TCGArg src)
 {
     TCGTemp *dst_ts = arg_temp(dst);
@@ -782,7 +789,7 @@ static bool swap_commutative2(TCGArg *p1, TCGArg *p2)
  * Return -1 if the condition can't be simplified,
  * and the result of the condition (0 or 1) if it can.
  */
-static int do_constant_folding_cond1(OptContext *ctx, TCGArg dest,
+static int do_constant_folding_cond1(OptContext *ctx, TCGOp *op, TCGArg dest,
                                      TCGArg *p1, TCGArg *p2, TCGArg *pcond)
 {
     TCGCond cond;
@@ -818,11 +825,28 @@ static int do_constant_folding_cond1(OptContext *ctx, TCGArg dest,
                                ? INT32_MIN : INT64_MIN))) {
         *p2 = arg_new_constant(ctx, 0);
         *pcond = tcg_tst_ltge_cond(cond);
+        return -1;
+    }
+
+    /* Expand to AND with a temporary if no backend support. */
+    if (!TCG_TARGET_HAS_tst) {
+        TCGOpcode and_opc = (ctx->type == TCG_TYPE_I32
+                             ? INDEX_op_and_i32 : INDEX_op_and_i64);
+        TCGOp *op2 = tcg_op_insert_before(ctx->tcg, op, and_opc, 3);
+        TCGArg tmp = arg_new_temp(ctx);
+
+        op2->args[0] = tmp;
+        op2->args[1] = *p1;
+        op2->args[2] = *p2;
+
+        *p1 = tmp;
+        *p2 = arg_new_constant(ctx, 0);
+        *pcond = tcg_tst_eqne_cond(cond);
     }
     return -1;
 }
 
-static int do_constant_folding_cond2(OptContext *ctx, TCGArg *args)
+static int do_constant_folding_cond2(OptContext *ctx, TCGOp *op, TCGArg *args)
 {
     TCGArg al, ah, bl, bh;
     TCGCond c;
@@ -898,6 +922,26 @@ static int do_constant_folding_cond2(OptContext *ctx, TCGArg *args)
             return -1;
         }
     }
+
+    /* Expand to AND with a temporary if no backend support. */
+    if (!TCG_TARGET_HAS_tst && is_tst_cond(c)) {
+        TCGOp *op1 = tcg_op_insert_before(ctx->tcg, op, INDEX_op_and_i32, 3);
+        TCGOp *op2 = tcg_op_insert_before(ctx->tcg, op, INDEX_op_and_i32, 3);
+        TCGArg t1 = arg_new_temp(ctx);
+        TCGArg t2 = arg_new_temp(ctx);
+
+        op1->args[0] = t1;
+        op1->args[1] = al;
+        op1->args[2] = bl;
+        op2->args[0] = t2;
+        op2->args[1] = ah;
+        op2->args[2] = bh;
+
+        args[0] = t1;
+        args[1] = t2;
+        args[3] = args[2] = arg_new_constant(ctx, 0);
+        args[4] = tcg_tst_eqne_cond(c);
+    }
     return -1;
 }
 
@@ -1298,7 +1342,7 @@ static bool fold_andc(OptContext *ctx, TCGOp *op)
 
 static bool fold_brcond(OptContext *ctx, TCGOp *op)
 {
-    int i = do_constant_folding_cond1(ctx, NO_DEST, &op->args[0],
+    int i = do_constant_folding_cond1(ctx, op, NO_DEST, &op->args[0],
                                       &op->args[1], &op->args[2]);
     if (i == 0) {
         tcg_op_remove(ctx->tcg, op);
@@ -1317,7 +1361,7 @@ static bool fold_brcond2(OptContext *ctx, TCGOp *op)
     TCGArg label;
     int i, inv = 0;
 
-    i = do_constant_folding_cond2(ctx, &op->args[0]);
+    i = do_constant_folding_cond2(ctx, op, &op->args[0]);
     cond = op->args[4];
     label = op->args[5];
     if (i >= 0) {
@@ -1815,7 +1859,7 @@ static bool fold_movcond(OptContext *ctx, TCGOp *op)
         op->args[5] = tcg_invert_cond(op->args[5]);
     }
 
-    i = do_constant_folding_cond1(ctx, NO_DEST, &op->args[1],
+    i = do_constant_folding_cond1(ctx, op, NO_DEST, &op->args[1],
                                   &op->args[2], &op->args[5]);
     if (i >= 0) {
         return tcg_opt_gen_mov(ctx, op, op->args[0], op->args[4 - i]);
@@ -2151,7 +2195,7 @@ static void fold_setcond_tst_pow2(OptContext *ctx, TCGOp *op, bool neg)
 
 static bool fold_setcond(OptContext *ctx, TCGOp *op)
 {
-    int i = do_constant_folding_cond1(ctx, op->args[0], &op->args[1],
+    int i = do_constant_folding_cond1(ctx, op, op->args[0], &op->args[1],
                                       &op->args[2], &op->args[3]);
     if (i >= 0) {
         return tcg_opt_gen_movi(ctx, op, op->args[0], i);
@@ -2165,7 +2209,7 @@ static bool fold_setcond(OptContext *ctx, TCGOp *op)
 
 static bool fold_negsetcond(OptContext *ctx, TCGOp *op)
 {
-    int i = do_constant_folding_cond1(ctx, op->args[0], &op->args[1],
+    int i = do_constant_folding_cond1(ctx, op, op->args[0], &op->args[1],
                                       &op->args[2], &op->args[3]);
     if (i >= 0) {
         return tcg_opt_gen_movi(ctx, op, op->args[0], -i);
@@ -2182,7 +2226,7 @@ static bool fold_setcond2(OptContext *ctx, TCGOp *op)
     TCGCond cond;
     int i, inv = 0;
 
-    i = do_constant_folding_cond2(ctx, &op->args[1]);
+    i = do_constant_folding_cond2(ctx, op, &op->args[1]);
     cond = op->args[5];
     if (i >= 0) {
         goto do_setcond_const;
diff --git a/tcg/tcg.c b/tcg/tcg.c
index eeeb9b0c70..60cb31c400 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1655,7 +1655,7 @@ TCGv_ptr tcg_global_mem_new_ptr(TCGv_ptr reg, intptr_t off, const char *name)
     return temp_tcgv_ptr(ts);
 }
 
-static TCGTemp *tcg_temp_new_internal(TCGType type, TCGTempKind kind)
+TCGTemp *tcg_temp_new_internal(TCGType type, TCGTempKind kind)
 {
     TCGContext *s = tcg_ctx;
     TCGTemp *ts;
-- 
2.34.1


