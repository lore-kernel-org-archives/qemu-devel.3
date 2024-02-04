Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02945C48298
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Feb 2024 21:41:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWkEk-00022P-HB; Sun, 04 Feb 2024 16:41:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rWkEd-00021b-2a
 for qemu-devel@nongnu.org; Sun, 04 Feb 2024 16:41:07 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rWkEa-0003Us-JC
 for qemu-devel@nongnu.org; Sun, 04 Feb 2024 16:41:05 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1d746856d85so27597875ad.0
 for <qemu-devel@nongnu.org>; Sun, 04 Feb 2024 13:41:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707082863; x=1707687663; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XRwgTLH7x4qjGJwvWHPC6iD3rpKsmYUOnQgcGsFZM2o=;
 b=uBW8IHuqRwly/Aj6D2IGvXNk2hLAALkGiWqjZzK4dWmH5ZtyiItzGW7hSLpgtdBxKm
 Jhzf1eorGyeH1c9gvSeroHi+UI+U5oLYtD/dRrYcYGuY1SozxLxQVTOFipWxpknWm7de
 eS3J35OrAwbYUqUqaB2K7LH668lsGWELf+6gf/duGHT/cvmQqZCrW0QQwDjj/Zf7C2n0
 ZnM7kjGokUcKPuDWLVELyJErmFyaD+Ug6l1B5fl3K3/CjDfMo9TYMc4/TEvIXlfg1vUG
 9gtkabZmaH8EWH/XrblhDi6FvD5do3f7U/7sH2RRBF5SUNJlflrQTv0TZ1Z8N5VQ8Iyu
 R4ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707082863; x=1707687663;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XRwgTLH7x4qjGJwvWHPC6iD3rpKsmYUOnQgcGsFZM2o=;
 b=GVOyDl4nLPURxcmrkwmFcaAuHTdVTkcb79mSQmxrSSd/JWMW3v2N+5i5poWbxq20Qt
 NHjGUBcnzN4gKoi3sG/eqxcdFZuHN+gef9jtDbSKM0HDQD48m9HVOQ1/BA0YM7WF3Kvo
 buf3CF39wJuvWWJA14t/BU5QzgN36z3PMUnnuKbQHhQ1ZSDuksDTG1KrDEZrqG9s4lZm
 +kF4cFkJNBteAttI0UNT5CmW0wlCGKeuFzPv05GtFCXlCjOC2h1NExVaqZGw3eOqS02b
 C75u9jTM82HPwJaO8rA0clQY8UZg5r8nIX/4WMAqo7IfuQefCWnTPFaoUSyHmqKlk4tO
 4u7g==
X-Gm-Message-State: AOJu0YxU2avhzrv1lofKBhUyaweGoLPiofdveGKXWjuTExhyS3z86MaV
 UnIODfuBB7JW/u8vTwyqbGz76QM1aOevDhmznmus/BE6KMwEXKnS9R520aOpqUZK0+gI6gaLmNd
 Yrhc=
X-Google-Smtp-Source: AGHT+IHray5+pl80wOGeHbcXvMgKjx8d894RuLPF2jwNypSG7gJ/dAadiOrKGX1Zgos5ZDzb+iQj3w==
X-Received: by 2002:a17:902:d905:b0:1d4:e237:2c3f with SMTP id
 c5-20020a170902d90500b001d4e2372c3fmr6042973plz.28.1707082863123; 
 Sun, 04 Feb 2024 13:41:03 -0800 (PST)
Received: from stoup.. ([43.252.112.156]) by smtp.gmail.com with ESMTPSA id
 mf11-20020a170902fc8b00b001d8f5560503sm4953670plb.222.2024.02.04.13.41.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Feb 2024 13:41:02 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 03/39] tcg/optimize: Split out arg_is_const_val
Date: Mon,  5 Feb 2024 07:40:16 +1000
Message-Id: <20240204214052.5639-4-richard.henderson@linaro.org>
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 38 +++++++++++++++++++++++---------------
 1 file changed, 23 insertions(+), 15 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index f2d01654c5..73019b9996 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -124,11 +124,22 @@ static inline bool ts_is_const(TCGTemp *ts)
     return ts_info(ts)->is_const;
 }
 
+static inline bool ts_is_const_val(TCGTemp *ts, uint64_t val)
+{
+    TempOptInfo *ti = ts_info(ts);
+    return ti->is_const && ti->val == val;
+}
+
 static inline bool arg_is_const(TCGArg arg)
 {
     return ts_is_const(arg_temp(arg));
 }
 
+static inline bool arg_is_const_val(TCGArg arg, uint64_t val)
+{
+    return ts_is_const_val(arg_temp(arg), val);
+}
+
 static inline bool ts_is_copy(TCGTemp *ts)
 {
     return ts_info(ts)->next_copy != ts;
@@ -689,7 +700,7 @@ static int do_constant_folding_cond(TCGType type, TCGArg x,
         }
     } else if (args_are_copies(x, y)) {
         return do_constant_folding_cond_eq(c);
-    } else if (arg_is_const(y) && arg_info(y)->val == 0) {
+    } else if (arg_is_const_val(y, 0)) {
         switch (c) {
         case TCG_COND_LTU:
             return 0;
@@ -954,7 +965,7 @@ static bool fold_to_not(OptContext *ctx, TCGOp *op, int idx)
 /* If the binary operation has first argument @i, fold to @i. */
 static bool fold_ix_to_i(OptContext *ctx, TCGOp *op, uint64_t i)
 {
-    if (arg_is_const(op->args[1]) && arg_info(op->args[1])->val == i) {
+    if (arg_is_const_val(op->args[1], i)) {
         return tcg_opt_gen_movi(ctx, op, op->args[0], i);
     }
     return false;
@@ -963,7 +974,7 @@ static bool fold_ix_to_i(OptContext *ctx, TCGOp *op, uint64_t i)
 /* If the binary operation has first argument @i, fold to NOT. */
 static bool fold_ix_to_not(OptContext *ctx, TCGOp *op, uint64_t i)
 {
-    if (arg_is_const(op->args[1]) && arg_info(op->args[1])->val == i) {
+    if (arg_is_const_val(op->args[1], i)) {
         return fold_to_not(ctx, op, 2);
     }
     return false;
@@ -972,7 +983,7 @@ static bool fold_ix_to_not(OptContext *ctx, TCGOp *op, uint64_t i)
 /* If the binary operation has second argument @i, fold to @i. */
 static bool fold_xi_to_i(OptContext *ctx, TCGOp *op, uint64_t i)
 {
-    if (arg_is_const(op->args[2]) && arg_info(op->args[2])->val == i) {
+    if (arg_is_const_val(op->args[2], i)) {
         return tcg_opt_gen_movi(ctx, op, op->args[0], i);
     }
     return false;
@@ -981,7 +992,7 @@ static bool fold_xi_to_i(OptContext *ctx, TCGOp *op, uint64_t i)
 /* If the binary operation has second argument @i, fold to identity. */
 static bool fold_xi_to_x(OptContext *ctx, TCGOp *op, uint64_t i)
 {
-    if (arg_is_const(op->args[2]) && arg_info(op->args[2])->val == i) {
+    if (arg_is_const_val(op->args[2], i)) {
         return tcg_opt_gen_mov(ctx, op, op->args[0], op->args[1]);
     }
     return false;
@@ -990,7 +1001,7 @@ static bool fold_xi_to_x(OptContext *ctx, TCGOp *op, uint64_t i)
 /* If the binary operation has second argument @i, fold to NOT. */
 static bool fold_xi_to_not(OptContext *ctx, TCGOp *op, uint64_t i)
 {
-    if (arg_is_const(op->args[2]) && arg_info(op->args[2])->val == i) {
+    if (arg_is_const_val(op->args[2], i)) {
         return fold_to_not(ctx, op, 1);
     }
     return false;
@@ -1223,8 +1234,8 @@ static bool fold_brcond2(OptContext *ctx, TCGOp *op)
          * Simplify LT/GE comparisons vs zero to a single compare
          * vs the high word of the input.
          */
-        if (arg_is_const(op->args[2]) && arg_info(op->args[2])->val == 0 &&
-            arg_is_const(op->args[3]) && arg_info(op->args[3])->val == 0) {
+        if (arg_is_const_val(op->args[2], 0) &&
+            arg_is_const_val(op->args[3], 0)) {
             goto do_brcond_high;
         }
         break;
@@ -1448,9 +1459,7 @@ static bool fold_deposit(OptContext *ctx, TCGOp *op)
     }
 
     /* Inserting a value into zero at offset 0. */
-    if (arg_is_const(op->args[1])
-        && arg_info(op->args[1])->val == 0
-        && op->args[3] == 0) {
+    if (arg_is_const_val(op->args[1], 0) && op->args[3] == 0) {
         uint64_t mask = MAKE_64BIT_MASK(0, op->args[4]);
 
         op->opc = and_opc;
@@ -1461,8 +1470,7 @@ static bool fold_deposit(OptContext *ctx, TCGOp *op)
     }
 
     /* Inserting zero into a value. */
-    if (arg_is_const(op->args[2])
-        && arg_info(op->args[2])->val == 0) {
+    if (arg_is_const_val(op->args[2], 0)) {
         uint64_t mask = deposit64(-1, op->args[3], op->args[4], 0);
 
         op->opc = and_opc;
@@ -2000,8 +2008,8 @@ static bool fold_setcond2(OptContext *ctx, TCGOp *op)
          * Simplify LT/GE comparisons vs zero to a single compare
          * vs the high word of the input.
          */
-        if (arg_is_const(op->args[3]) && arg_info(op->args[3])->val == 0 &&
-            arg_is_const(op->args[4]) && arg_info(op->args[4])->val == 0) {
+        if (arg_is_const_val(op->args[3], 0) &&
+            arg_is_const_val(op->args[4], 0)) {
             goto do_setcond_high;
         }
         break;
-- 
2.34.1


