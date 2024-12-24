Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD18CE77188
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2024 20:06:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQB9u-0002ly-Vq; Tue, 24 Dec 2024 15:05:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tQB9l-0002jX-9j
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 15:05:30 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tQB9j-0002Ws-MR
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 15:05:29 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2166f1e589cso67033785ad.3
 for <qemu-devel@nongnu.org>; Tue, 24 Dec 2024 12:05:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735070726; x=1735675526; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iOzpxqZ9VNfy3l9f3NLQHzVfPYu5zW7VkQL9KwFwxnA=;
 b=xcLWc0LJluNu9CiKwHB1b/v9WGr0iy/kgAYBBZ+mTVb6eIkwlSIpvg/ATl8PDZ3aoL
 OSP4HLFLoJ/pmYZHtDCQiaCYxJ5gVTrbIJGOVSM8akb0oIkNALvNevi4ljpkYU6amBHm
 i4YynXDzU0joKD+Onsi7bcjcXzlOAjHmaMgVTL4+Led/2DKhXOB/3eTzU5PJqZpKL+Cv
 SBYfKnx6Jx161YUUl0qMZgRbP5lreHVeqt5MmbawIsEIen5q9GauClEGagOkf1SkKmHw
 xYMP/ZLHhgLd4xvKRLfl3N2SC0O6KmL1U6VfjndhAsCTU6ie/C/KsAGd7lMHokn4BCSx
 M+2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735070726; x=1735675526;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iOzpxqZ9VNfy3l9f3NLQHzVfPYu5zW7VkQL9KwFwxnA=;
 b=SNfLUhF5nN2rSGa9SwHrZVfMmXNNVaV3EtNyn6lnbBJ4HL+SJ7qZvoPToatoJasT9Z
 z8YHkzQt3vpkU8KyXkYaM+16fmT++H07Jy4GLV4GQDFTfvQ+yOza4AFS1adP2sOtWG7K
 aIbor6cty7yL0V4p85gtECMRD/6h/sObLr1z60llmzwj0vaoIvQ3ufrYD3z/GBpC66v0
 gkRmFPYew52k/Kj0x8GrADWK7Rl8KiDpuLZ2XZc6IU6H4MyKFj7F4aMvVg/rXlRLAYdp
 nI96LhzLRsHpLnY1kcgMr8G4KKMf0vFr6i7fDgI9laKfXoyOz+WMVWxryiYCdVOepg/X
 /hoQ==
X-Gm-Message-State: AOJu0YyPDLpwtdlqvhs2B0tEZ6hYcslk/jMrGnAqMpgp2amfYcqxgH8X
 hD/TIroyi1+40GQmkgGoZM3+VmMc9HiBkhKvdOwVdQkS18hhyST2CYKQiO0/D9rDP9CjVV5xVY0
 af54=
X-Gm-Gg: ASbGncv7psoRQMr7filob/BdTdEXhOJ6DN/kNSEUAl+Xu18RyYI8fBPgxW1W++ISlcG
 WD3FdDOXBFVrJu+y21dm0S+Rudm1A2Sy8gB5guoKBbcxq+8m4ZFj9Z30kcXebxBUsIzyRS2Pq4U
 7y01TWK2s2AFICSOd9vnN3ADcX+cLgyMA+9fJ9l3rcE8qsLVgw4Xmu5JzY8jCzD1gW6qV7a61QB
 cEBQ6OHx8ivna6tWac7zEa8d1sTclXtZuI8diqG5JzCqtvshDWlMRHn/Lj7gjsGGs6nMNTurm0M
 KLg8NnhJXO+neIJgy5t2Az4fpw==
X-Google-Smtp-Source: AGHT+IFX+rO/BfMWuku7Q9xzFRU3p3Nn4e8mGAzI0HIjaO78nybOXFotFdlMEt5qPX4z7c+1UkiWbA==
X-Received: by 2002:a05:6a21:3103:b0:1e1:a932:4a40 with SMTP id
 adf61e73a8af0-1e5e043f517mr25728596637.4.1735070726119; 
 Tue, 24 Dec 2024 12:05:26 -0800 (PST)
Received: from stoup.. (syn-156-019-246-023.biz.spectrum.com. [156.19.246.23])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8fb895sm10027159b3a.162.2024.12.24.12.05.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Dec 2024 12:05:25 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 04/72] tcg/optimize: Split out fold_affected_mask
Date: Tue, 24 Dec 2024 12:04:13 -0800
Message-ID: <20241224200521.310066-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241224200521.310066-1-richard.henderson@linaro.org>
References: <20241224200521.310066-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

There are only a few logical operations which can compute
an "affected" mask.  Split out handling of this optimization
to a separate function, only to be called when applicable.

Remove the a_mask field from OptContext, as the mask is
no longer stored anywhere.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 42 +++++++++++++++++++++++++++---------------
 1 file changed, 27 insertions(+), 15 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 453e8c43bd..6757fe0036 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -64,7 +64,6 @@ typedef struct OptContext {
     QSIMPLEQ_HEAD(, MemCopyInfo) mem_free;
 
     /* In flight values from optimization. */
-    uint64_t a_mask;  /* mask bit is 0 iff value identical to first input */
     uint64_t z_mask;  /* mask bit is 0 iff value bit is 0 */
     uint64_t s_mask;  /* mask of clrsb(value) bits */
     TCGType type;
@@ -1047,7 +1046,6 @@ static bool fold_const2_commutative(OptContext *ctx, TCGOp *op)
 
 static bool fold_masks(OptContext *ctx, TCGOp *op)
 {
-    uint64_t a_mask = ctx->a_mask;
     uint64_t z_mask = ctx->z_mask;
     uint64_t s_mask = ctx->s_mask;
 
@@ -1059,7 +1057,6 @@ static bool fold_masks(OptContext *ctx, TCGOp *op)
      * type changing opcodes.
      */
     if (ctx->type == TCG_TYPE_I32) {
-        a_mask = (int32_t)a_mask;
         z_mask = (int32_t)z_mask;
         s_mask |= MAKE_64BIT_MASK(32, 32);
         ctx->z_mask = z_mask;
@@ -1069,6 +1066,19 @@ static bool fold_masks(OptContext *ctx, TCGOp *op)
     if (z_mask == 0) {
         return tcg_opt_gen_movi(ctx, op, op->args[0], 0);
     }
+    return false;
+}
+
+/*
+ * An "affected" mask bit is 0 if and only if the result is identical
+ * to the first input.  Thus if the entire mask is 0, the operation
+ * is equivalent to a copy.
+ */
+static bool fold_affected_mask(OptContext *ctx, TCGOp *op, uint64_t a_mask)
+{
+    if (ctx->type == TCG_TYPE_I32) {
+        a_mask = (uint32_t)a_mask;
+    }
     if (a_mask == 0) {
         return tcg_opt_gen_mov(ctx, op, op->args[0], op->args[1]);
     }
@@ -1305,8 +1315,9 @@ static bool fold_and(OptContext *ctx, TCGOp *op)
      * Known-zeros does not imply known-ones.  Therefore unless
      * arg2 is constant, we can't infer affected bits from it.
      */
-    if (arg_is_const(op->args[2])) {
-        ctx->a_mask = z1 & ~z2;
+    if (arg_is_const(op->args[2]) &&
+        fold_affected_mask(ctx, op, z1 & ~z2)) {
+        return true;
     }
 
     return fold_masks(ctx, op);
@@ -1331,7 +1342,9 @@ static bool fold_andc(OptContext *ctx, TCGOp *op)
      */
     if (arg_is_const(op->args[2])) {
         uint64_t z2 = ~arg_info(op->args[2])->z_mask;
-        ctx->a_mask = z1 & ~z2;
+        if (fold_affected_mask(ctx, op, z1 & ~z2)) {
+            return true;
+        }
         z1 &= z2;
     }
     ctx->z_mask = z1;
@@ -1709,8 +1722,8 @@ static bool fold_extract(OptContext *ctx, TCGOp *op)
 
     z_mask_old = arg_info(op->args[1])->z_mask;
     z_mask = extract64(z_mask_old, pos, len);
-    if (pos == 0) {
-        ctx->a_mask = z_mask_old ^ z_mask;
+    if (pos == 0 && fold_affected_mask(ctx, op, z_mask_old ^ z_mask)) {
+        return true;
     }
     ctx->z_mask = z_mask;
     ctx->s_mask = smask_from_zmask(z_mask);
@@ -1777,8 +1790,8 @@ static bool fold_exts(OptContext *ctx, TCGOp *op)
 
     ctx->z_mask = z_mask;
     ctx->s_mask = s_mask;
-    if (!type_change) {
-        ctx->a_mask = s_mask & ~s_mask_old;
+    if (!type_change && fold_affected_mask(ctx, op, s_mask & ~s_mask_old)) {
+        return true;
     }
 
     return fold_masks(ctx, op);
@@ -1819,8 +1832,8 @@ static bool fold_extu(OptContext *ctx, TCGOp *op)
 
     ctx->z_mask = z_mask;
     ctx->s_mask = smask_from_zmask(z_mask);
-    if (!type_change) {
-        ctx->a_mask = z_mask_old ^ z_mask;
+    if (!type_change && fold_affected_mask(ctx, op, z_mask_old ^ z_mask)) {
+        return true;
     }
     return fold_masks(ctx, op);
 }
@@ -2482,8 +2495,8 @@ static bool fold_sextract(OptContext *ctx, TCGOp *op)
     s_mask |= MAKE_64BIT_MASK(len, 64 - len);
     ctx->s_mask = s_mask;
 
-    if (pos == 0) {
-        ctx->a_mask = s_mask & ~s_mask_old;
+    if (pos == 0 && fold_affected_mask(ctx, op, s_mask & ~s_mask_old)) {
+        return true;
     }
 
     return fold_masks(ctx, op);
@@ -2843,7 +2856,6 @@ void tcg_optimize(TCGContext *s)
         }
 
         /* Assume all bits affected, no bits known zero, no sign reps. */
-        ctx.a_mask = -1;
         ctx.z_mask = -1;
         ctx.s_mask = 0;
 
-- 
2.43.0


