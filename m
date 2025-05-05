Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0061C3ABB6
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 20:30:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uC2Q9-0006oY-6z; Mon, 05 May 2025 16:28:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uC2Pw-0006ic-SG
 for qemu-devel@nongnu.org; Mon, 05 May 2025 16:28:01 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uC2Ps-0000Mu-R4
 for qemu-devel@nongnu.org; Mon, 05 May 2025 16:28:00 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-7396f13b750so5916559b3a.1
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 13:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746476874; x=1747081674; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lzo/fe/Ua4ApmzVfrV8jd465bb3JX7SLeAZUoYkEF7U=;
 b=qOMzazxi42ncoW7ois7GricBVB4F5pkCkvbMDN+M4+LGqddq2NUsxdBGHzCXFzD4vi
 nTcJEND7sE+q5ejpye+yeY0+Ah/WLFkhlNLVu3O2V7y8geVfTWzWssNF765zE+ahmX+g
 WL5QkhZI7wX/RZhhhk9i8uFlB5QdqsJH8V6LWE1J46rSeqFyp6e1IQWOwqoS3JWIg7b6
 XztvalwKqRkcUa/Dc05UIBuiWhsOFtAIsUg7iZWFaetT5fC11yv4RR9ENYUQCVwJXS3F
 3+vQtVniEBvckpodLjqyYymFkAV3BQNXTj/IhpMZIGtY4rIug8cQMJaYhEAhvIal68GW
 SbVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746476874; x=1747081674;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lzo/fe/Ua4ApmzVfrV8jd465bb3JX7SLeAZUoYkEF7U=;
 b=RxlsBzU7JWAXJ9XE2fQ1stMGltYMu14pcc7OKm0JfJvFzDsS4iI0BarDrfLfp95IrH
 LQlwQntkDaGtjORHMOUFIQ5MiGcjH26sc+jgUpWKrRZ6yQwimPvEBG8GsVfrqJL64nI3
 nnpJkeuVKRhv1a+wBYmjr0uUTbvTC/tH2XceOtXXUaHn33CjSeE9PpMPgRDb9bL7oZpu
 34ElXfOSU5afJIw/jgHtwgrcynr24g91+GchzXfIXH1qReGPjTjYXjOiVCvEf1Ucd1ZJ
 R1BzhpHE3csuBMWtw5L9DvglllUpuSFV2/WMCS6c7dAPUAWnUx5fFPkRWV1DLKukAy6b
 jSUQ==
X-Gm-Message-State: AOJu0YzBeh7Y8D3q95zE8fj0bZazBc+Pzi6J7oWUspOPmdUMO4IhD6wt
 l3B03ke1TZ4tLNHmjq7wlDGrwWhXGgOcMGSVyagAK4t1lP6+iT0aLiPjGS8B2w8wMeRcfexrOi2
 K
X-Gm-Gg: ASbGnctRchFOr5YCedb4hYDdwv7ai/jH4nx/OG+WZrUAuPNJnBrQ/3wPQL+GZUP8NAW
 PL7wlPTkEIm3/JmyehJRQQkf5IlaIqEjSEPezsOme6Dq6T0PtEFu5c6cg9SjlSKa/mMYWvp3hz6
 /1YU1f1Lec49A/F8JTCRagqEqOilz1cr1JcSjNiznjVyC2dzWHUZtIiJMgRJ2Q+UY6FxKKEjsJN
 JA2DeobrHEiv55qQrjkZap5lk0VtmMHdS0lESZrDlg+EquMvq60OVtQwT8cA6ilFhPCN4q5pE2+
 DsOHVDFLIfSj/n9gU4zBX2ojhJUsZMyGmvdNp+PAKI3HNt7Wan0eCpPY6l1oM/a61iXCKgdU5bE
 =
X-Google-Smtp-Source: AGHT+IHcUxhYkPStHTdfC9Cj+pHOv1Ewilbk5h5xJ/x3WTwWre3n+DLmLFXQaf5M4hu3dg26Jrd6Aw==
X-Received: by 2002:a05:6a00:908c:b0:73e:30dc:bb9b with SMTP id
 d2e1a72fcca58-74091a01224mr777083b3a.2.1746476874455; 
 Mon, 05 May 2025 13:27:54 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74059021067sm7516485b3a.107.2025.05.05.13.27.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 May 2025 13:27:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 01/20] tcg/optimize: Introduce arg_const_val
Date: Mon,  5 May 2025 13:27:32 -0700
Message-ID: <20250505202751.3510517-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250505202751.3510517-1-richard.henderson@linaro.org>
References: <20250505202751.3510517-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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

Use arg_const_val instead of direct access to the TempOptInfo val
member.  Rename both val and is_const to catch all direct accesses.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 78 ++++++++++++++++++++++++++------------------------
 1 file changed, 41 insertions(+), 37 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 10a76c5461..73a272eeb3 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -39,11 +39,11 @@ typedef struct MemCopyInfo {
 } MemCopyInfo;
 
 typedef struct TempOptInfo {
-    bool is_const;
+    bool is_const_;
     TCGTemp *prev_copy;
     TCGTemp *next_copy;
     QSIMPLEQ_HEAD(, MemCopyInfo) mem_copy;
-    uint64_t val;
+    uint64_t val_;
     uint64_t z_mask;  /* mask bit is 0 if and only if value bit is 0 */
     uint64_t s_mask;  /* mask bit is 1 if value bit matches msb */
 } TempOptInfo;
@@ -73,12 +73,12 @@ static inline TempOptInfo *arg_info(TCGArg arg)
 
 static inline bool ti_is_const(TempOptInfo *ti)
 {
-    return ti->is_const;
+    return ti->is_const_;
 }
 
 static inline uint64_t ti_const_val(TempOptInfo *ti)
 {
-    return ti->val;
+    return ti->val_;
 }
 
 static inline bool ti_is_const_val(TempOptInfo *ti, uint64_t val)
@@ -101,6 +101,11 @@ static inline bool arg_is_const(TCGArg arg)
     return ts_is_const(arg_temp(arg));
 }
 
+static inline uint64_t arg_const_val(TCGArg arg)
+{
+    return ti_const_val(arg_info(arg));
+}
+
 static inline bool arg_is_const_val(TCGArg arg, uint64_t val)
 {
     return ts_is_const_val(arg_temp(arg), val);
@@ -137,12 +142,12 @@ static void init_ts_info(OptContext *ctx, TCGTemp *ts)
     ti->prev_copy = ts;
     QSIMPLEQ_INIT(&ti->mem_copy);
     if (ts->kind == TEMP_CONST) {
-        ti->is_const = true;
-        ti->val = ts->val;
+        ti->is_const_ = true;
+        ti->val_ = ts->val;
         ti->z_mask = ts->val;
         ti->s_mask = INT64_MIN >> clrsb64(ts->val);
     } else {
-        ti->is_const = false;
+        ti->is_const_ = false;
         ti->z_mask = -1;
         ti->s_mask = 0;
     }
@@ -229,7 +234,7 @@ static void reset_ts(OptContext *ctx, TCGTemp *ts)
     pi->next_copy = ti->next_copy;
     ti->next_copy = ts;
     ti->prev_copy = ts;
-    ti->is_const = false;
+    ti->is_const_ = false;
     ti->z_mask = -1;
     ti->s_mask = 0;
 
@@ -394,8 +399,8 @@ static bool tcg_opt_gen_mov(OptContext *ctx, TCGOp *op, TCGArg dst, TCGArg src)
         di->prev_copy = src_ts;
         ni->prev_copy = dst_ts;
         si->next_copy = dst_ts;
-        di->is_const = si->is_const;
-        di->val = si->val;
+        di->is_const_ = si->is_const_;
+        di->val_ = si->val_;
 
         if (!QSIMPLEQ_EMPTY(&si->mem_copy)
             && cmp_better_copy(src_ts, dst_ts) == dst_ts) {
@@ -687,8 +692,8 @@ static int do_constant_folding_cond(TCGType type, TCGArg x,
                                     TCGArg y, TCGCond c)
 {
     if (arg_is_const(x) && arg_is_const(y)) {
-        uint64_t xv = arg_info(x)->val;
-        uint64_t yv = arg_info(y)->val;
+        uint64_t xv = arg_const_val(x);
+        uint64_t yv = arg_const_val(y);
 
         switch (type) {
         case TCG_TYPE_I32:
@@ -801,14 +806,14 @@ static int do_constant_folding_cond1(OptContext *ctx, TCGOp *op, TCGArg dest,
      * TSTNE x,i -> NE x,0 if i includes all nonzero bits of x
      */
     if (args_are_copies(*p1, *p2) ||
-        (arg_is_const(*p2) && (i1->z_mask & ~arg_info(*p2)->val) == 0)) {
+        (arg_is_const(*p2) && (i1->z_mask & ~arg_const_val(*p2)) == 0)) {
         *p2 = arg_new_constant(ctx, 0);
         *pcond = tcg_tst_eqne_cond(cond);
         return -1;
     }
 
     /* TSTNE x,i -> LT x,0 if i only includes sign bit copies */
-    if (arg_is_const(*p2) && (arg_info(*p2)->val & ~i1->s_mask) == 0) {
+    if (arg_is_const(*p2) && (arg_const_val(*p2) & ~i1->s_mask) == 0) {
         *p2 = arg_new_constant(ctx, 0);
         *pcond = tcg_tst_ltge_cond(cond);
         return -1;
@@ -849,13 +854,13 @@ static int do_constant_folding_cond2(OptContext *ctx, TCGOp *op, TCGArg *args)
     bh = args[3];
 
     if (arg_is_const(bl) && arg_is_const(bh)) {
-        tcg_target_ulong blv = arg_info(bl)->val;
-        tcg_target_ulong bhv = arg_info(bh)->val;
+        tcg_target_ulong blv = arg_const_val(bl);
+        tcg_target_ulong bhv = arg_const_val(bh);
         uint64_t b = deposit64(blv, 32, 32, bhv);
 
         if (arg_is_const(al) && arg_is_const(ah)) {
-            tcg_target_ulong alv = arg_info(al)->val;
-            tcg_target_ulong ahv = arg_info(ah)->val;
+            tcg_target_ulong alv = arg_const_val(al);
+            tcg_target_ulong ahv = arg_const_val(ah);
             uint64_t a = deposit64(alv, 32, 32, ahv);
 
             r = do_constant_folding_cond_64(a, b, c);
@@ -989,9 +994,8 @@ static bool finish_folding(OptContext *ctx, TCGOp *op)
 static bool fold_const1(OptContext *ctx, TCGOp *op)
 {
     if (arg_is_const(op->args[1])) {
-        uint64_t t;
+        uint64_t t = arg_const_val(op->args[1]);
 
-        t = arg_info(op->args[1])->val;
         t = do_constant_folding(op->opc, ctx->type, t, 0);
         return tcg_opt_gen_movi(ctx, op, op->args[0], t);
     }
@@ -1001,8 +1005,8 @@ static bool fold_const1(OptContext *ctx, TCGOp *op)
 static bool fold_const2(OptContext *ctx, TCGOp *op)
 {
     if (arg_is_const(op->args[1]) && arg_is_const(op->args[2])) {
-        uint64_t t1 = arg_info(op->args[1])->val;
-        uint64_t t2 = arg_info(op->args[2])->val;
+        uint64_t t1 = arg_const_val(op->args[1]);
+        uint64_t t2 = arg_const_val(op->args[2]);
 
         t1 = do_constant_folding(op->opc, ctx->type, t1, t2);
         return tcg_opt_gen_movi(ctx, op, op->args[0], t1);
@@ -1486,8 +1490,8 @@ static bool fold_bitsel_vec(OptContext *ctx, TCGOp *op)
     }
 
     if (arg_is_const(op->args[2]) && arg_is_const(op->args[3])) {
-        uint64_t tv = arg_info(op->args[2])->val;
-        uint64_t fv = arg_info(op->args[3])->val;
+        uint64_t tv = arg_const_val(op->args[2]);
+        uint64_t fv = arg_const_val(op->args[3]);
 
         if (tv == -1 && fv == 0) {
             return tcg_opt_gen_mov(ctx, op, op->args[0], op->args[1]);
@@ -1504,7 +1508,7 @@ static bool fold_bitsel_vec(OptContext *ctx, TCGOp *op)
         }
     }
     if (arg_is_const(op->args[2])) {
-        uint64_t tv = arg_info(op->args[2])->val;
+        uint64_t tv = arg_const_val(op->args[2]);
         if (tv == -1) {
             op->opc = INDEX_op_or_vec;
             op->args[2] = op->args[3];
@@ -1518,7 +1522,7 @@ static bool fold_bitsel_vec(OptContext *ctx, TCGOp *op)
         }
     }
     if (arg_is_const(op->args[3])) {
-        uint64_t fv = arg_info(op->args[3])->val;
+        uint64_t fv = arg_const_val(op->args[3]);
         if (fv == 0) {
             op->opc = INDEX_op_and_vec;
             return fold_and(ctx, op);
@@ -1876,7 +1880,7 @@ static bool fold_divide(OptContext *ctx, TCGOp *op)
 static bool fold_dup(OptContext *ctx, TCGOp *op)
 {
     if (arg_is_const(op->args[1])) {
-        uint64_t t = arg_info(op->args[1])->val;
+        uint64_t t = arg_const_val(op->args[1]);
         t = dup_const(TCGOP_VECE(op), t);
         return tcg_opt_gen_movi(ctx, op, op->args[0], t);
     }
@@ -1886,8 +1890,8 @@ static bool fold_dup(OptContext *ctx, TCGOp *op)
 static bool fold_dup2(OptContext *ctx, TCGOp *op)
 {
     if (arg_is_const(op->args[1]) && arg_is_const(op->args[2])) {
-        uint64_t t = deposit64(arg_info(op->args[1])->val, 32, 32,
-                               arg_info(op->args[2])->val);
+        uint64_t t = deposit64(arg_const_val(op->args[1]), 32, 32,
+                               arg_const_val(op->args[2]));
         return tcg_opt_gen_movi(ctx, op, op->args[0], t);
     }
 
@@ -1958,8 +1962,8 @@ static bool fold_extract(OptContext *ctx, TCGOp *op)
 static bool fold_extract2(OptContext *ctx, TCGOp *op)
 {
     if (arg_is_const(op->args[1]) && arg_is_const(op->args[2])) {
-        uint64_t v1 = arg_info(op->args[1])->val;
-        uint64_t v2 = arg_info(op->args[2])->val;
+        uint64_t v1 = arg_const_val(op->args[1]);
+        uint64_t v2 = arg_const_val(op->args[2]);
         int shr = op->args[3];
 
         if (ctx->type == TCG_TYPE_I32) {
@@ -2127,8 +2131,8 @@ static bool fold_multiply2(OptContext *ctx, TCGOp *op)
     swap_commutative(op->args[0], &op->args[2], &op->args[3]);
 
     if (arg_is_const(op->args[2]) && arg_is_const(op->args[3])) {
-        uint64_t a = arg_info(op->args[2])->val;
-        uint64_t b = arg_info(op->args[3])->val;
+        uint64_t a = arg_const_val(op->args[2]);
+        uint64_t b = arg_const_val(op->args[3]);
         uint64_t h, l;
         TCGArg rl, rh;
         TCGOp *op2;
@@ -2330,7 +2334,7 @@ static int fold_setcond_zmask(OptContext *ctx, TCGOp *op, bool neg)
     }
 
     a_zmask = arg_info(op->args[1])->z_mask;
-    b_val = arg_info(op->args[2])->val;
+    b_val = arg_const_val(op->args[2]);
     cond = op->args[3];
 
     if (ctx->type == TCG_TYPE_I32) {
@@ -2418,7 +2422,7 @@ static void fold_setcond_tst_pow2(OptContext *ctx, TCGOp *op, bool neg)
     }
 
     src2 = op->args[2];
-    val = arg_info(src2)->val;
+    val = arg_const_val(src2);
     if (!is_power_of_2(val)) {
         return;
     }
@@ -2669,7 +2673,7 @@ static bool fold_sub_to_neg(OptContext *ctx, TCGOp *op)
     TCGOpcode neg_op;
     bool have_neg;
 
-    if (!arg_is_const(op->args[1]) || arg_info(op->args[1])->val != 0) {
+    if (!arg_is_const_val(op->args[1], 0)) {
         return false;
     }
 
@@ -2719,7 +2723,7 @@ static bool fold_sub(OptContext *ctx, TCGOp *op)
 
     /* Fold sub r,x,i to add r,x,-i */
     if (arg_is_const(op->args[2])) {
-        uint64_t val = arg_info(op->args[2])->val;
+        uint64_t val = arg_const_val(op->args[2]);
 
         op->opc = INDEX_op_add;
         op->args[2] = arg_new_constant(ctx, -val);
-- 
2.43.0


