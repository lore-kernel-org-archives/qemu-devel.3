Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF8C5E77188
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Dec 2024 16:31:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tPOlp-0002qR-3E; Sun, 22 Dec 2024 11:25:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tPOlD-0002YP-Hy
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 11:24:55 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tPOlB-0002wx-F1
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 11:24:54 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2165448243fso36704645ad.1
 for <qemu-devel@nongnu.org>; Sun, 22 Dec 2024 08:24:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734884692; x=1735489492; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=xb4e6w7ahnBB6mbpBKhRckqM5FrOSeMfN/028Rd+wf0=;
 b=PMDvGyBfyIcl7LkXgz1NSfTl5ajUpRnXEGytqKtqvZV8KFmkwNS+56k33uwalpMoTi
 fvC9QjLb8WlkeZv519lzm7wJINuWat0uhKOEVHMyP+ebkzjcTvrjzdg5bVsJProCQta9
 jc0m61O8emHwcrb+7DEn9F/difoO01wC/0/CWilEcJxyhSP5LAnBaxvDlXqI8DS+1joJ
 o34+/2NGmfqzTP2wdCIHDp9NmGq6x5WnZtIio+QW7Cid9+PQzA/rCkPAb6q0TyPBqole
 18ct1Pggz1kBeZA3aGUMY+YcVhLlyc6it36SFmSxlrjR9bDnAIcLnhYzMlqip8XBVeKe
 dHag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734884692; x=1735489492;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xb4e6w7ahnBB6mbpBKhRckqM5FrOSeMfN/028Rd+wf0=;
 b=hnhUGERzel8/3k//K2q/J9V+zoAdSeKpggsm2Z9ZpJvP2xAPiOlskHoFOT2qz7JR8X
 SOu6E02Z1VnQGhc3bC9mv73OiZP0AoDAQ0IwDL8Zzy3eYJw/MwRL5gllQ46IPEEQOxCG
 WmmJ6P0eAe8X3Vv7aRcCiD9CPrjHTVjE5gmO7MTKr7ZTNZp0Fdn1sg/A5H8kQWTYsB7Y
 Ed0Ux9LF2svASBVOW/xsHnQdp3rsBKZipwfykd5dNy+VbKNA3Vv1vf5Y7GsmbuLorTpk
 H2Lxvau6mX0hD4/Gi4FiIqH5Qte3uE1HQpOPs91BGASUC+X0s1L/fFDsK3VRObQGX2lC
 Zuxw==
X-Gm-Message-State: AOJu0YypN6aqxzvXaVDqSsS/VhltzpuxvrpxC9W6FVrm9Q5sXFVcOGJJ
 msdQujg8J+1ohqi9waMXIVjp9k2bMJELwX8IJx7E0ztd0WqvfVSETu/IpKkONUWXGMbb7Ys45Wq
 rU3w=
X-Gm-Gg: ASbGncu29h5/+l5HoOx4ovYOnwVcm54eWg1Rzy1mYhxxq5ZVgVOaVX7XRa7uoCNbsw/
 qIB3fhuW9IstVZaWMmYTH6s7ruD2Lsp4b9uI5TerlKt1vsKZo33qDiFwrPmYmGC5ilKfJshF1RD
 sIx3IvKTw12ms8KyXOSBZqIz7idm0CnICosqtGdecXP+vDnAocLCaid4t+0kcam+N2vf8bNboTe
 7x0tvBLfO0AT8qOZ3QT5K0zOMTYS5Jf9U9JFngBb7T1NpndO8AgdCYnVB7VPdc=
X-Google-Smtp-Source: AGHT+IE81Y9K/sz/GNPeJy1IP876tC8o0oSTBkDsNgIMeZOnywmdDRLlBJEdI1L2SnIstynheovESA==
X-Received: by 2002:a17:902:e892:b0:216:73f0:ef63 with SMTP id
 d9443c01a7336-219e6f284e4mr148748365ad.49.1734884691781; 
 Sun, 22 Dec 2024 08:24:51 -0800 (PST)
Received: from stoup.. ([71.212.144.252]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc971814sm58461385ad.79.2024.12.22.08.24.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Dec 2024 08:24:51 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 06/51] tcg/optimize: Change representation of s_mask
Date: Sun, 22 Dec 2024 08:24:01 -0800
Message-ID: <20241222162446.2415717-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241222162446.2415717-1-richard.henderson@linaro.org>
References: <20241222162446.2415717-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

Change the representation from sign bit repetitions to all bits equal
to the sign bit, including the sign bit itself.

The previous format has a problem in that it is difficult to recreate
a valid sign mask after a shift operation: the "repetitions" part of
the previous format meant that applying the same shift as for the value
lead to an off-by-one value.

The new format, including the sign bit itself, means that the sign mask
can be manipulated in exactly the same way as the value, canonicalization
is easier.

Canonicalize the s_mask in fold_masks_zs, rather than requiring callers
to do so.  Treat 0 as a non-canonical but typeless input for no sign
information, which will be reset as appropriate for the data type.
We can easily fold in the data from z_mask while canonicalizing.

Temporarily disable optimizations using s_mask while each operation is
converted to use fold_masks_zs and to the new form.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 64 ++++++++++++--------------------------------------
 1 file changed, 15 insertions(+), 49 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index d8f6542c4f..fbc0dc5588 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -52,7 +52,7 @@ typedef struct TempOptInfo {
     QSIMPLEQ_HEAD(, MemCopyInfo) mem_copy;
     uint64_t val;
     uint64_t z_mask;  /* mask bit is 0 if and only if value bit is 0 */
-    uint64_t s_mask;  /* a left-aligned mask of clrsb(value) bits. */
+    uint64_t s_mask;  /* mask bit is 1 if value bit matches msb */
 } TempOptInfo;
 
 typedef struct OptContext {
@@ -65,49 +65,10 @@ typedef struct OptContext {
 
     /* In flight values from optimization. */
     uint64_t z_mask;  /* mask bit is 0 iff value bit is 0 */
-    uint64_t s_mask;  /* mask of clrsb(value) bits */
+    uint64_t s_mask;  /* mask bit is 1 if value bit matches msb */
     TCGType type;
 } OptContext;
 
-/* Calculate the smask for a specific value. */
-static uint64_t smask_from_value(uint64_t value)
-{
-    int rep = clrsb64(value);
-    return ~(~0ull >> rep);
-}
-
-/*
- * Calculate the smask for a given set of known-zeros.
- * If there are lots of zeros on the left, we can consider the remainder
- * an unsigned field, and thus the corresponding signed field is one bit
- * larger.
- */
-static uint64_t smask_from_zmask(uint64_t zmask)
-{
-    /*
-     * Only the 0 bits are significant for zmask, thus the msb itself
-     * must be zero, else we have no sign information.
-     */
-    int rep = clz64(zmask);
-    if (rep == 0) {
-        return 0;
-    }
-    rep -= 1;
-    return ~(~0ull >> rep);
-}
-
-/*
- * Recreate a properly left-aligned smask after manipulation.
- * Some bit-shuffling, particularly shifts and rotates, may
- * retain sign bits on the left, but may scatter disconnected
- * sign bits on the right.  Retain only what remains to the left.
- */
-static uint64_t smask_from_smask(int64_t smask)
-{
-    /* Only the 1 bits are significant for smask */
-    return smask_from_zmask(~smask);
-}
-
 static inline TempOptInfo *ts_info(TCGTemp *ts)
 {
     return ts->state_ptr;
@@ -173,7 +134,7 @@ static void init_ts_info(OptContext *ctx, TCGTemp *ts)
         ti->is_const = true;
         ti->val = ts->val;
         ti->z_mask = ts->val;
-        ti->s_mask = smask_from_value(ts->val);
+        ti->s_mask = INT64_MIN >> clrsb64(ts->val);
     } else {
         ti->is_const = false;
         ti->z_mask = -1;
@@ -992,7 +953,6 @@ static void finish_folding(OptContext *ctx, TCGOp *op)
          */
         if (i == 0) {
             ts_info(ts)->z_mask = ctx->z_mask;
-            ts_info(ts)->s_mask = ctx->s_mask;
         }
     }
 }
@@ -1051,11 +1011,12 @@ static bool fold_const2_commutative(OptContext *ctx, TCGOp *op)
  * The passed s_mask may be augmented by z_mask.
  */
 static bool fold_masks_zs(OptContext *ctx, TCGOp *op,
-                          uint64_t z_mask, uint64_t s_mask)
+                          uint64_t z_mask, int64_t s_mask)
 {
     const TCGOpDef *def = &tcg_op_defs[op->opc];
     TCGTemp *ts;
     TempOptInfo *ti;
+    int rep;
 
     /* Only single-output opcodes are supported here. */
     tcg_debug_assert(def->nb_oargs == 1);
@@ -1069,7 +1030,7 @@ static bool fold_masks_zs(OptContext *ctx, TCGOp *op,
      */
     if (ctx->type == TCG_TYPE_I32) {
         z_mask = (int32_t)z_mask;
-        s_mask |= MAKE_64BIT_MASK(32, 32);
+        s_mask |= INT32_MIN;
     }
 
     if (z_mask == 0) {
@@ -1081,7 +1042,13 @@ static bool fold_masks_zs(OptContext *ctx, TCGOp *op,
 
     ti = ts_info(ts);
     ti->z_mask = z_mask;
-    ti->s_mask = s_mask | smask_from_zmask(z_mask);
+
+    /* Canonicalize s_mask and incorporate data from z_mask. */
+    rep = clz64(~s_mask);
+    rep = MAX(rep, clz64(z_mask));
+    rep = MAX(rep - 1, 0);
+    ti->s_mask = INT64_MIN >> rep;
+
     return true;
 }
 
@@ -1807,7 +1774,7 @@ static bool fold_exts(OptContext *ctx, TCGOp *op)
 
     ctx->z_mask = z_mask;
     ctx->s_mask = s_mask;
-    if (!type_change && fold_affected_mask(ctx, op, s_mask & ~s_mask_old)) {
+    if (0 && !type_change && fold_affected_mask(ctx, op, s_mask & ~s_mask_old)) {
         return true;
     }
 
@@ -2509,7 +2476,7 @@ static bool fold_sextract(OptContext *ctx, TCGOp *op)
     s_mask |= MAKE_64BIT_MASK(len, 64 - len);
     ctx->s_mask = s_mask;
 
-    if (pos == 0 && fold_affected_mask(ctx, op, s_mask & ~s_mask_old)) {
+    if (0 && pos == 0 && fold_affected_mask(ctx, op, s_mask & ~s_mask_old)) {
         return true;
     }
 
@@ -2535,7 +2502,6 @@ static bool fold_shift(OptContext *ctx, TCGOp *op)
         ctx->z_mask = do_constant_folding(op->opc, ctx->type, z_mask, sh);
 
         s_mask = do_constant_folding(op->opc, ctx->type, s_mask, sh);
-        ctx->s_mask = smask_from_smask(s_mask);
 
         return fold_masks(ctx, op);
     }
-- 
2.43.0


