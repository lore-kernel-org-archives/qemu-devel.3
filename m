Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66E1CE77188
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 18:25:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTPfA-0001cy-Nj; Thu, 02 Jan 2025 13:11:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tTPef-0007P9-Dp
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 13:10:47 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tTPeb-0006FS-Sp
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 13:10:44 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-21631789fcdso118475535ad.1
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2025 10:10:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735841440; x=1736446240; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=35aZrDQF7zISczEIeFsnTzZIWO3YHBHFUCMqODdsEQA=;
 b=Ds8R89o9zB93WUqIAyqVoGLSWC1I6SFSE7xIy/nszJ5GrBk68WISshQdhMfElmvMqh
 ukRgVzfdC2SaTusguzKybUzmHkj1YgIiWT7YC4OoBq/O6CoRol8uMToCIs2HnN9FjofB
 sR7WaHbVxGAyqka1ftnK4Hh5Srn8EccQpnjHj+FHJWxXXpuZ5VaOlDv3vUzndLOfR1zL
 B8s6EycVqRAOA1BtPZcXUuui43PGTV3kcmOuUY+FYRIKseI58+/+bglTdjjWxyYtwCDU
 JLrYN5e/Jmt3CFtZAf+O2kjg987QhfhlRbqVVx8Z1zF9vwItxifOAMycv+rqT9SdBbv9
 DVZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735841440; x=1736446240;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=35aZrDQF7zISczEIeFsnTzZIWO3YHBHFUCMqODdsEQA=;
 b=pL+HTv/YgPPQksKTpokQZaepdI6YgAq6wbvQbfrc8yrn8rTiKP2iYZrUcYTgdkSzep
 clZtieUtuBuh4y+Q2bk8MD+LjB+g4ZDNhqP4tHcMhkFdTWvVZA+grWb7jz4xFPLD45nn
 eoOuMN71xIfK6BbhisExiwlpT8Y7NTw0o1jBKEVsE+0QoEbs57I3+7ELaB7D8hgkTnTz
 DFPM46kAZjMv/rRmPWFDA2nBF9FNVu9LT7u3BnZBkXHRY7pvXzfY2SkSn9yTVoqkUtVr
 Nybf4oWs/+PCAK7vSn/P3F1FASyJMYgev6t3KuL+5NnJ1kXluMIMXKP/yCcCjKe9cGmd
 +Cgw==
X-Gm-Message-State: AOJu0YztxMm1n7pvWww+Ijy7YFT5gAKeZdko+8xzPq+oAOrPkKUbYSGP
 /MTP6/XkRgY3mA2uask0cm1szbCGryFOV9NizuhtGrmfO2+h5yy6HJgm9BsojccLTEHi0NrENCg
 S
X-Gm-Gg: ASbGnctLZKGpjkOPp7KAZNz07dmNLeBfDYygtJzm8YRusr3xmywUV+rrpcTb8ZM1N2r
 4uHrI2N4TJ0/v3ONFC8x8A64cH6sDEzw1o0D9tDaYNQZbFXeKJZNgUnG5pwo81EiEJ54X/aNF8o
 dFneUObEiCDrLW1EoIZgAtaToWghJ7qOAatjNMzx/c3mtWeACPkcA+xn+lNEqWLyrcuzjSdQWnB
 y9IPr8XxcMsSgOH9bu6OUbV0+nPbYXG4nSR7ZSwrtKq7V/npqf4TYwUgqXdBg==
X-Google-Smtp-Source: AGHT+IHKjssbIvLoin+QueA1gDcLuKqXQkE0ZexJ5HjAkEcqjXkUcpct/uNBsRASibadMxGO/mNBGg==
X-Received: by 2002:a05:6a00:6103:b0:72a:b292:1e96 with SMTP id
 d2e1a72fcca58-72ab2921ec7mr76876551b3a.12.1735841440464; 
 Thu, 02 Jan 2025 10:10:40 -0800 (PST)
Received: from stoup.. ([63.239.63.212]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8dbaf1sm24620827b3a.112.2025.01.02.10.10.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jan 2025 10:10:40 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 58/73] tcg/optimize: Remove OptContext.type
Date: Thu,  2 Jan 2025 10:06:38 -0800
Message-ID: <20250102180654.1420056-59-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250102180654.1420056-1-richard.henderson@linaro.org>
References: <20250102180654.1420056-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

The same type information is now present in TCGOp.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 119 ++++++++++++++++++++++---------------------------
 1 file changed, 53 insertions(+), 66 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index c591f93090..75c37d1148 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -63,9 +63,6 @@ typedef struct OptContext {
 
     IntervalTreeRoot mem_copy;
     QSIMPLEQ_HEAD(, MemCopyInfo) mem_free;
-
-    /* In flight values from optimization. */
-    TCGType type;
 } OptContext;
 
 static inline TempOptInfo *ts_info(TCGTemp *ts)
@@ -322,9 +319,8 @@ static TCGTemp *find_mem_copy_for(OptContext *ctx, TCGType type, intptr_t s)
     return NULL;
 }
 
-static TCGArg arg_new_constant(OptContext *ctx, uint64_t val)
+static TCGArg arg_new_constant(OptContext *ctx, TCGType type, uint64_t val)
 {
-    TCGType type = ctx->type;
     TCGTemp *ts;
 
     if (type == TCG_TYPE_I32) {
@@ -337,9 +333,9 @@ static TCGArg arg_new_constant(OptContext *ctx, uint64_t val)
     return temp_arg(ts);
 }
 
-static TCGArg arg_new_temp(OptContext *ctx)
+static TCGArg arg_new_temp(OptContext *ctx, TCGType type)
 {
-    TCGTemp *ts = tcg_temp_new_internal(ctx->type, TEMP_EBB);
+    TCGTemp *ts = tcg_temp_new_internal(type, TEMP_EBB);
     init_ts_info(ctx, ts);
     return temp_arg(ts);
 }
@@ -361,7 +357,7 @@ static bool tcg_opt_gen_mov(OptContext *ctx, TCGOp *op, TCGArg dst, TCGArg src)
     di = ts_info(dst_ts);
     si = ts_info(src_ts);
 
-    switch (ctx->type) {
+    switch (op->type) {
     case TCG_TYPE_I32:
         new_op = INDEX_op_mov_i32;
         break;
@@ -406,7 +402,7 @@ static bool tcg_opt_gen_movi(OptContext *ctx, TCGOp *op,
                              TCGArg dst, uint64_t val)
 {
     /* Convert movi to mov with constant temp. */
-    return tcg_opt_gen_mov(ctx, op, dst, arg_new_constant(ctx, val));
+    return tcg_opt_gen_mov(ctx, op, dst, arg_new_constant(ctx, op->type, val));
 }
 
 static uint64_t do_constant_folding_2(TCGOpcode op, uint64_t x, uint64_t y)
@@ -761,7 +757,7 @@ static int do_constant_folding_cond1(OptContext *ctx, TCGOp *op, TCGArg dest,
         *pcond = cond = tcg_swap_cond(cond);
     }
 
-    r = do_constant_folding_cond(ctx->type, *p1, *p2, cond);
+    r = do_constant_folding_cond(op->type, *p1, *p2, cond);
     if (r >= 0) {
         return r;
     }
@@ -774,32 +770,32 @@ static int do_constant_folding_cond1(OptContext *ctx, TCGOp *op, TCGArg dest,
      * TSTNE x,-1 -> NE x,0
      */
     if (args_are_copies(*p1, *p2) || arg_is_const_val(*p2, -1)) {
-        *p2 = arg_new_constant(ctx, 0);
+        *p2 = arg_new_constant(ctx, op->type, 0);
         *pcond = tcg_tst_eqne_cond(cond);
         return -1;
     }
 
     /* TSTNE x,sign -> LT x,0 */
-    if (arg_is_const_val(*p2, (ctx->type == TCG_TYPE_I32
+    if (arg_is_const_val(*p2, (op->type == TCG_TYPE_I32
                                ? INT32_MIN : INT64_MIN))) {
-        *p2 = arg_new_constant(ctx, 0);
+        *p2 = arg_new_constant(ctx, op->type, 0);
         *pcond = tcg_tst_ltge_cond(cond);
         return -1;
     }
 
     /* Expand to AND with a temporary if no backend support. */
     if (!TCG_TARGET_HAS_tst) {
-        TCGOpcode and_opc = (ctx->type == TCG_TYPE_I32
+        TCGOpcode and_opc = (op->type == TCG_TYPE_I32
                              ? INDEX_op_and_i32 : INDEX_op_and_i64);
         TCGOp *op2 = tcg_op_insert_before(ctx->tcg, op, and_opc, op->type, 3);
-        TCGArg tmp = arg_new_temp(ctx);
+        TCGArg tmp = arg_new_temp(ctx, op->type);
 
         op2->args[0] = tmp;
         op2->args[1] = *p1;
         op2->args[2] = *p2;
 
         *p1 = tmp;
-        *p2 = arg_new_constant(ctx, 0);
+        *p2 = arg_new_constant(ctx, op->type, 0);
         *pcond = tcg_tst_eqne_cond(cond);
     }
     return -1;
@@ -854,7 +850,7 @@ static int do_constant_folding_cond2(OptContext *ctx, TCGOp *op, TCGArg *args)
 
         /* TSTNE x,-1 -> NE x,0 */
         if (b == -1 && is_tst_cond(c)) {
-            args[3] = args[2] = arg_new_constant(ctx, 0);
+            args[3] = args[2] = arg_new_constant(ctx, op->type, 0);
             args[4] = tcg_tst_eqne_cond(c);
             return -1;
         }
@@ -876,7 +872,7 @@ static int do_constant_folding_cond2(OptContext *ctx, TCGOp *op, TCGArg *args)
 
         /* TSTNE x,x -> NE x,0 */
         if (is_tst_cond(c)) {
-            args[3] = args[2] = arg_new_constant(ctx, 0);
+            args[3] = args[2] = arg_new_constant(ctx, op->type, 0);
             args[4] = tcg_tst_eqne_cond(c);
             return -1;
         }
@@ -888,8 +884,8 @@ static int do_constant_folding_cond2(OptContext *ctx, TCGOp *op, TCGArg *args)
                                           INDEX_op_and_i32, TCG_TYPE_I32, 3);
         TCGOp *op2 = tcg_op_insert_before(ctx->tcg, op,
                                           INDEX_op_and_i32, TCG_TYPE_I32, 3);
-        TCGArg t1 = arg_new_temp(ctx);
-        TCGArg t2 = arg_new_temp(ctx);
+        TCGArg t1 = arg_new_temp(ctx, op->type);
+        TCGArg t2 = arg_new_temp(ctx, op->type);
 
         op1->args[0] = t1;
         op1->args[1] = al;
@@ -900,7 +896,7 @@ static int do_constant_folding_cond2(OptContext *ctx, TCGOp *op, TCGArg *args)
 
         args[0] = t1;
         args[1] = t2;
-        args[3] = args[2] = arg_new_constant(ctx, 0);
+        args[3] = args[2] = arg_new_constant(ctx, op->type, 0);
         args[4] = tcg_tst_eqne_cond(c);
     }
     return -1;
@@ -969,7 +965,7 @@ static bool fold_const1(OptContext *ctx, TCGOp *op)
         uint64_t t;
 
         t = arg_info(op->args[1])->val;
-        t = do_constant_folding(op->opc, ctx->type, t, 0);
+        t = do_constant_folding(op->opc, op->type, t, 0);
         return tcg_opt_gen_movi(ctx, op, op->args[0], t);
     }
     return false;
@@ -981,7 +977,7 @@ static bool fold_const2(OptContext *ctx, TCGOp *op)
         uint64_t t1 = arg_info(op->args[1])->val;
         uint64_t t2 = arg_info(op->args[2])->val;
 
-        t1 = do_constant_folding(op->opc, ctx->type, t1, t2);
+        t1 = do_constant_folding(op->opc, op->type, t1, t2);
         return tcg_opt_gen_movi(ctx, op, op->args[0], t1);
     }
     return false;
@@ -1023,7 +1019,7 @@ static bool fold_masks_zs(OptContext *ctx, TCGOp *op,
      * be reset properly for a 64-bit value when encountering the
      * type changing opcodes.
      */
-    if (ctx->type == TCG_TYPE_I32) {
+    if (op->type == TCG_TYPE_I32) {
         z_mask = (int32_t)z_mask;
         s_mask |= INT32_MIN;
     }
@@ -1064,7 +1060,7 @@ static bool fold_masks_s(OptContext *ctx, TCGOp *op, uint64_t s_mask)
  */
 static bool fold_affected_mask(OptContext *ctx, TCGOp *op, uint64_t a_mask)
 {
-    if (ctx->type == TCG_TYPE_I32) {
+    if (op->type == TCG_TYPE_I32) {
         a_mask = (uint32_t)a_mask;
     }
     if (a_mask == 0) {
@@ -1084,7 +1080,7 @@ static bool fold_to_not(OptContext *ctx, TCGOp *op, int idx)
     TCGOpcode not_op;
     bool have_not;
 
-    switch (ctx->type) {
+    switch (op->type) {
     case TCG_TYPE_I32:
         not_op = INDEX_op_not_i32;
         have_not = TCG_TARGET_HAS_not(TCG_TYPE_I32);
@@ -1097,7 +1093,7 @@ static bool fold_to_not(OptContext *ctx, TCGOp *op, int idx)
     case TCG_TYPE_V128:
     case TCG_TYPE_V256:
         not_op = INDEX_op_not_vec;
-        have_not = TCG_TARGET_HAS_not(ctx->type);
+        have_not = TCG_TARGET_HAS_not(op->type);
         break;
     default:
         g_assert_not_reached();
@@ -1218,7 +1214,7 @@ static bool fold_addsub2(OptContext *ctx, TCGOp *op, bool add)
         TCGArg rl, rh;
         TCGOp *op2;
 
-        if (ctx->type == TCG_TYPE_I32) {
+        if (op->type == TCG_TYPE_I32) {
             uint64_t a = deposit64(al, 32, 32, ah);
             uint64_t b = deposit64(bl, 32, 32, bh);
 
@@ -1264,10 +1260,10 @@ static bool fold_addsub2(OptContext *ctx, TCGOp *op, bool add)
         bl = -bl;
         bh = ~bh + !bl;
 
-        op->opc = (ctx->type == TCG_TYPE_I32
+        op->opc = (op->type == TCG_TYPE_I32
                    ? INDEX_op_add2_i32 : INDEX_op_add2_i64);
-        op->args[4] = arg_new_constant(ctx, bl);
-        op->args[5] = arg_new_constant(ctx, bh);
+        op->args[4] = arg_new_constant(ctx, op->type, bl);
+        op->args[5] = arg_new_constant(ctx, op->type, bh);
     }
     return finish_folding(ctx, op);
 }
@@ -1369,7 +1365,7 @@ static bool fold_bitsel_vec(OptContext *ctx, TCGOp *op)
                 return fold_not(ctx, op);
             } else {
                 op->opc = INDEX_op_xor_vec;
-                op->args[2] = arg_new_constant(ctx, -1);
+                op->args[2] = arg_new_constant(ctx, op->type, -1);
                 return fold_xor(ctx, op);
             }
         }
@@ -1525,7 +1521,7 @@ static bool fold_bswap(OptContext *ctx, TCGOp *op)
 
     if (ti_is_const(t1)) {
         return tcg_opt_gen_movi(ctx, op, op->args[0],
-                                do_constant_folding(op->opc, ctx->type,
+                                do_constant_folding(op->opc, op->type,
                                                     ti_const_val(t1),
                                                     op->args[2]));
     }
@@ -1648,13 +1644,13 @@ static bool fold_count_zeros(OptContext *ctx, TCGOp *op)
         uint64_t t = ti_const_val(t1);
 
         if (t != 0) {
-            t = do_constant_folding(op->opc, ctx->type, t, 0);
+            t = do_constant_folding(op->opc, op->type, t, 0);
             return tcg_opt_gen_movi(ctx, op, op->args[0], t);
         }
         return tcg_opt_gen_mov(ctx, op, op->args[0], op->args[2]);
     }
 
-    switch (ctx->type) {
+    switch (op->type) {
     case TCG_TYPE_I32:
         z_mask = 31;
         break;
@@ -1679,7 +1675,7 @@ static bool fold_ctpop(OptContext *ctx, TCGOp *op)
         return true;
     }
 
-    switch (ctx->type) {
+    switch (op->type) {
     case TCG_TYPE_I32:
         z_mask = 32 | 31;
         break;
@@ -1708,7 +1704,7 @@ static bool fold_deposit(OptContext *ctx, TCGOp *op)
                                           ti_const_val(t2)));
     }
 
-    switch (ctx->type) {
+    switch (op->type) {
     case TCG_TYPE_I32:
         and_opc = INDEX_op_and_i32;
         width = 32;
@@ -1727,7 +1723,7 @@ static bool fold_deposit(OptContext *ctx, TCGOp *op)
 
         op->opc = and_opc;
         op->args[1] = op->args[2];
-        op->args[2] = arg_new_constant(ctx, mask);
+        op->args[2] = arg_new_constant(ctx, op->type, mask);
         return fold_and(ctx, op);
     }
 
@@ -1736,7 +1732,7 @@ static bool fold_deposit(OptContext *ctx, TCGOp *op)
         uint64_t mask = deposit64(-1, ofs, len, 0);
 
         op->opc = and_opc;
-        op->args[2] = arg_new_constant(ctx, mask);
+        op->args[2] = arg_new_constant(ctx, op->type, mask);
         return fold_and(ctx, op);
     }
 
@@ -1952,7 +1948,7 @@ static bool fold_movcond(OptContext *ctx, TCGOp *op)
         TCGOpcode opc, negopc = 0;
         TCGCond cond = op->args[5];
 
-        switch (ctx->type) {
+        switch (op->type) {
         case TCG_TYPE_I32:
             opc = INDEX_op_setcond_i32;
             if (TCG_TARGET_HAS_negsetcond(TCG_TYPE_I32)) {
@@ -2198,7 +2194,7 @@ static int fold_setcond_zmask(OptContext *ctx, TCGOp *op, bool neg)
     b_val = arg_info(op->args[2])->val;
     cond = op->args[3];
 
-    if (ctx->type == TCG_TYPE_I32) {
+    if (op->type == TCG_TYPE_I32) {
         a_zmask = (uint32_t)a_zmask;
         b_val = (uint32_t)b_val;
     }
@@ -2256,7 +2252,7 @@ static int fold_setcond_zmask(OptContext *ctx, TCGOp *op, bool neg)
                 return tcg_opt_gen_mov(ctx, op, op->args[0], op->args[1]);
             }
 
-            switch (ctx->type) {
+            switch (op->type) {
             case TCG_TYPE_I32:
                 add_opc = INDEX_op_add_i32;
                 neg_opc = INDEX_op_neg_i32;
@@ -2275,10 +2271,10 @@ static int fold_setcond_zmask(OptContext *ctx, TCGOp *op, bool neg)
                 op->opc = neg_opc;
             } else if (neg) {
                 op->opc = add_opc;
-                op->args[2] = arg_new_constant(ctx, -1);
+                op->args[2] = arg_new_constant(ctx, op->type, -1);
             } else {
                 op->opc = xor_opc;
-                op->args[2] = arg_new_constant(ctx, 1);
+                op->args[2] = arg_new_constant(ctx, op->type, 1);
             }
             return -1;
         }
@@ -2308,7 +2304,7 @@ static void fold_setcond_tst_pow2(OptContext *ctx, TCGOp *op, bool neg)
     }
     sh = ctz64(val);
 
-    switch (ctx->type) {
+    switch (op->type) {
     case TCG_TYPE_I32:
         and_opc = INDEX_op_and_i32;
         sub_opc = INDEX_op_sub_i32;
@@ -2359,24 +2355,24 @@ static void fold_setcond_tst_pow2(OptContext *ctx, TCGOp *op, bool neg)
             op2 = tcg_op_insert_before(ctx->tcg, op, shr_opc, op->type, 3);
             op2->args[0] = ret;
             op2->args[1] = src1;
-            op2->args[2] = arg_new_constant(ctx, sh);
+            op2->args[2] = arg_new_constant(ctx, op->type, sh);
             src1 = ret;
         }
         op->opc = and_opc;
         op->args[1] = src1;
-        op->args[2] = arg_new_constant(ctx, 1);
+        op->args[2] = arg_new_constant(ctx, op->type, 1);
     }
 
     if (neg && inv) {
         op2 = tcg_op_insert_after(ctx->tcg, op, sub_opc, op->type, 3);
         op2->args[0] = ret;
         op2->args[1] = ret;
-        op2->args[2] = arg_new_constant(ctx, 1);
+        op2->args[2] = arg_new_constant(ctx, op->type, 1);
     } else if (inv) {
         op2 = tcg_op_insert_after(ctx->tcg, op, xor_opc, op->type, 3);
         op2->args[0] = ret;
         op2->args[1] = ret;
-        op2->args[2] = arg_new_constant(ctx, 1);
+        op2->args[2] = arg_new_constant(ctx, op->type, 1);
     } else if (neg) {
         op2 = tcg_op_insert_after(ctx->tcg, op, neg_opc, op->type, 2);
         op2->args[0] = ret;
@@ -2550,8 +2546,8 @@ static bool fold_shift(OptContext *ctx, TCGOp *op)
     if (ti_is_const(t2)) {
         int sh = ti_const_val(t2);
 
-        z_mask = do_constant_folding(op->opc, ctx->type, z_mask, sh);
-        s_mask = do_constant_folding(op->opc, ctx->type, s_mask, sh);
+        z_mask = do_constant_folding(op->opc, op->type, z_mask, sh);
+        s_mask = do_constant_folding(op->opc, op->type, s_mask, sh);
 
         return fold_masks_zs(ctx, op, z_mask, s_mask);
     }
@@ -2588,7 +2584,7 @@ static bool fold_sub_to_neg(OptContext *ctx, TCGOp *op)
         return false;
     }
 
-    switch (ctx->type) {
+    switch (op->type) {
     case TCG_TYPE_I32:
         neg_op = INDEX_op_neg_i32;
         have_neg = true;
@@ -2602,7 +2598,7 @@ static bool fold_sub_to_neg(OptContext *ctx, TCGOp *op)
     case TCG_TYPE_V256:
         neg_op = INDEX_op_neg_vec;
         have_neg = (TCG_TARGET_HAS_neg_vec &&
-                    tcg_can_emit_vec_op(neg_op, ctx->type, TCGOP_VECE(op)) > 0);
+                    tcg_can_emit_vec_op(neg_op, op->type, TCGOP_VECE(op)) > 0);
         break;
     default:
         g_assert_not_reached();
@@ -2639,9 +2635,9 @@ static bool fold_sub(OptContext *ctx, TCGOp *op)
     if (arg_is_const(op->args[2])) {
         uint64_t val = arg_info(op->args[2])->val;
 
-        op->opc = (ctx->type == TCG_TYPE_I32
+        op->opc = (op->type == TCG_TYPE_I32
                    ? INDEX_op_add_i32 : INDEX_op_add_i64);
-        op->args[2] = arg_new_constant(ctx, -val);
+        op->args[2] = arg_new_constant(ctx, op->type, -val);
     }
     return finish_folding(ctx, op);
 }
@@ -2657,7 +2653,7 @@ static bool fold_tcg_ld(OptContext *ctx, TCGOp *op)
     MemOp memop = op->args[3];
     unsigned size = memop_size(memop);
 
-    if (size == tcg_type_size(ctx->type)) {
+    if (size == tcg_type_size(op->type)) {
         TCGTemp *dst, *src;
         intptr_t ofs;
 
@@ -2692,7 +2688,7 @@ static bool fold_tcg_st(OptContext *ctx, TCGOp *op)
     unsigned size = memop_size(memop);
     intptr_t last = ofs + size - 1;
 
-    if (size == tcg_type_size(ctx->type)) {
+    if (size == tcg_type_size(op->type)) {
         TCGTemp *src = arg_temp(op->args[0]);
 
         if (op->args[1] != tcgv_ptr_arg(tcg_env)) {
@@ -2774,15 +2770,6 @@ void tcg_optimize(TCGContext *s)
         init_arguments(&ctx, op, def->nb_oargs + def->nb_iargs);
         copy_propagate(&ctx, op, def->nb_oargs, def->nb_iargs);
 
-        /* Pre-compute the type of the operation. */
-        if (def->flags & TCG_OPF_VECTOR) {
-            ctx.type = op->type;
-        } else if (def->flags & TCG_OPF_64BIT) {
-            ctx.type = TCG_TYPE_I64;
-        } else {
-            ctx.type = TCG_TYPE_I32;
-        }
-
         /*
          * Process each opcode.
          * Sorted alphabetically by opcode as much as possible.
-- 
2.43.0


