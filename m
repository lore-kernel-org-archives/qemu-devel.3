Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D86C5E7718D
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2024 20:06:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQBAA-0002qC-Dn; Tue, 24 Dec 2024 15:05:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tQB9o-0002kf-Ra
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 15:05:34 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tQB9n-0002Xe-4K
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 15:05:32 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-21683192bf9so61841305ad.3
 for <qemu-devel@nongnu.org>; Tue, 24 Dec 2024 12:05:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735070730; x=1735675530; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UguTmxMFL4TTxOKQ146kQqPat3A///6xR4q4RSBU0vs=;
 b=ggxvILR3vS8BOiNzHCattKWGCWjrkje5nrcJRRaAiVG+DDOa/UO2s0Ymu5wCamRSJq
 OM+zbfXeW3AmLFx9O6hsnrrPDvYDIHXM23tllJeN9aiSdlEO9z02Vhs4e1g7VDuw9A7a
 Bgsx+yK3d0JzuAMqhHx1rgSpKsCECqTAElr++XrsVHton9pNFuwIY/GkswIVylufs1Mh
 C/LbzPa7cWSY3Y7v5YSXWGuYN/oOYeRwN2eP5D8onnQL+gQmpXo9ED/ZWcykPxx7UeSB
 kitqNVj30+gnwiILbWOnAehxewPf+5i9obQtdy0ieXEC90/XsEsAGD9f+hZ6TSS2K9sX
 OLjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735070730; x=1735675530;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UguTmxMFL4TTxOKQ146kQqPat3A///6xR4q4RSBU0vs=;
 b=m8ZAEzFdn2PlNsE3CxEMyrrmhqt3xKXK+1YM7tuZU7RmaD2AubymNo+97SntaELiki
 qG5Ajw+OcmrPmv7k7LDy34CFpDPzK5gGr+hs05yr3m6uqwnJWzAa9FrlfFg5k0lblOsL
 5kA2m2KkKkosG4i7U92I0IfzdVnpJtLGi3UAfAILjNmFrT8k7Ud/TPdk7kaDceMYQ+9q
 BPrb+teVIOlYvvH428odeJVS8ttanILwKkBZRwXzn0mJ/LQQ+C6qqciEAZCMeij33w1e
 LdhIa5c7FJn5ispOjnd926G+aRtTTOmFLYnRHUEzET1uHGFjUqSBTQK34Xr/ejUZHL2j
 ojLg==
X-Gm-Message-State: AOJu0YzqNGs7/BBTKzEh7YFodQYBKiMR+6Tjgq0KU4JTAehAynHjUvUo
 BGSQ5WsI2UKVFRabNTBnMIDjYmBUQlfXzQET42gOhoBunKOzX7XMPTFAgl8wCkMnHyZP4Mkicsp
 z6AI=
X-Gm-Gg: ASbGnctN6DdvrJQ6MYogbxIRt/Qn8f87mV9Pr9ibE69361FCLz+SGbjSLRvpq5BKSU4
 RvPZ2h0dhRnAD+MO0DMI9qSqPizBa5iPUkVRsZH/bNvHYS067M1AiZnCo6mBkKrO0xUpOojJHAO
 RwaXPAPNAKGJO9mJqwQlRyMhQ+ZSQWIRDQMDFlx2PdakzDjqqJd8brpEHUdyyiSzkSBpUQUY7+i
 0KNWdlGTFhUC9IB3Ze+x3uO/qeKb/j9wvLRCwePZBC9spOMcB8thV1OHQuA8WnKSW577F95mlts
 4MSUa2N4pK8e2AQvyW8hz9EBrg==
X-Google-Smtp-Source: AGHT+IG0muVRgUItzNqbZ/kO8QX09URxzbxu2YGbkWmT8+jSUsckR8sULBrMQh8g96FB1F531iBfWQ==
X-Received: by 2002:a05:6a00:44cb:b0:725:1d37:ebff with SMTP id
 d2e1a72fcca58-72abe0960c6mr24861733b3a.22.1735070729831; 
 Tue, 24 Dec 2024 12:05:29 -0800 (PST)
Received: from stoup.. (syn-156-019-246-023.biz.spectrum.com. [156.19.246.23])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8fb895sm10027159b3a.162.2024.12.24.12.05.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Dec 2024 12:05:29 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 08/72] tcg/optimize: Change representation of s_mask
Date: Tue, 24 Dec 2024 12:04:17 -0800
Message-ID: <20241224200521.310066-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241224200521.310066-1-richard.henderson@linaro.org>
References: <20241224200521.310066-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
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


