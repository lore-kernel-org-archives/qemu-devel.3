Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E2A8C83029
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Jun 2025 15:30:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWGRl-0000RA-VL; Mon, 30 Jun 2025 11:29:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWGRW-0000MY-QA
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 11:29:14 -0400
Received: from mail-oo1-xc2e.google.com ([2607:f8b0:4864:20::c2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWGRJ-0008Br-4V
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 11:29:06 -0400
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-611a7c617b4so1411821eaf.3
 for <qemu-devel@nongnu.org>; Mon, 30 Jun 2025 08:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751297338; x=1751902138; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9k8aWRJjxyTp4jNgYkvWpCY0WQOKjkozcD5mUGHV/AA=;
 b=bR1XR63jneIX+WC9li05ExO/VnB6mae82G9H1zY5cuJXMgfxDHESM8MU6AVPgnpxmp
 JVdC5ygXnioZ1oICLv50o2DEA6Uiz51WMAK96XsSrY6vy0/+UXSoCrxPixs09FCcmbwk
 LTmI9B5epHiDojHNUIdTsdEVP6ZH0ctGG0AG2o4f+FrCZpjRarRcWhnHuSVVg2IHJ015
 XyNewqoQicwNKr/+JptQeaTBskGjHi+19Gi05Re+AKZE9+9vyjZd6Ety6WvI7zPpq18t
 LUFCFAFFL+/S32NkYI85EDawTTL3ZkobLRtWgNm9bNknM1rRF9ys00Xm3leaSR+VOgj0
 KbwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751297338; x=1751902138;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9k8aWRJjxyTp4jNgYkvWpCY0WQOKjkozcD5mUGHV/AA=;
 b=N9HTEOcUoP6/O2s4KUqWLlnq6mLcw56Zde2+LTUXTozbuJ/KvHjIhjU/Qt6Krw/ded
 vM0FWdofZvGYoJXgF3QGRGAUh2YvHFKHtNME1MhKJSV/ME6lBUY3dChC/scZbp6cgfHw
 j4HmPmtdSd75eNRpZR3VcFV25qVvgRe6jC+o7M3L8FX2GPDtYaB3qIUtqeI5VVZR716S
 Ch7QvwnAJd2M1OUvB677gDD0wCGkcTdF/dOrt4QpzRwlFrLOhRj+/eisMoYyBsvqY7Fo
 TltGwOqM+k8LXJYWbKzSjrNXNwFlkXY16hr8oAnnZFlDKzUNUfxQ0oDCCN8bd/EsJJYQ
 heNw==
X-Gm-Message-State: AOJu0YzBTC0R3q6pRrkkve6zFfEMz2VIEOHZXvrrqu4tCu9cZLY4UKPz
 SWkYFxWhixuy92WmWaDbYBo3FSkiLhD7TD8BpqCw1btgirXGSfX9czhPsfymVQgepsQsv6pvwXR
 B/lhs
X-Gm-Gg: ASbGncv8fS6pKWu/Z1iU97T3PpvsnXXwCLfvKslzXJMKN6v98m+Y5uexTZ9IeVTaNBy
 VPfXQzsSC2yvKTH7m8odYWHPNLnyuK+Eh+hgrRft8asrqMfoOTQuFOCJiLIIeSYQFqLzsEv2wcB
 xX5EGcy41DAWCmCI+j/SygceOeeXf5qoH1/xoQ1rK9qLpvh5pMPEiqPq1IX6nclVNjFvqhW2oy2
 dM18WkjFALiQC6rfzrkx0bVcsZvsubv0s2jTiz4ImnagGtKRG/PAZD2W9REqzJ0wTDkpCc2hthX
 8uvu8C4iDae3yM2qv0CTpThe35+LQVQfDyDzAQ2pYMHBZcdzcya+GD+Hb7b15xxV7VllFw==
X-Google-Smtp-Source: AGHT+IF33+2//z+3eMWjjYxXF30OjZur30vqemPptNFaGIHP5MgoWzZZu6Mi+B1GWcltPXet+NivBQ==
X-Received: by 2002:a05:6871:588a:b0:29e:5de2:cffb with SMTP id
 586e51a60fabf-2efed4f26ffmr9086174fac.17.1751297338358; 
 Mon, 30 Jun 2025 08:28:58 -0700 (PDT)
Received: from stoup.. ([187.210.107.185]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73afb00c48asm1712478a34.27.2025.06.30.08.28.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Jun 2025 08:28:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 01/29] tcg/optimize: Introduce arg_const_val
Date: Mon, 30 Jun 2025 09:28:27 -0600
Message-ID: <20250630152855.148018-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250630152855.148018-1-richard.henderson@linaro.org>
References: <20250630152855.148018-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2e;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2e.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
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


