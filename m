Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3454E7718D
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Dec 2024 16:31:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tPOlp-0002qP-2f; Sun, 22 Dec 2024 11:25:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tPOlB-0002YL-Q0
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 11:24:55 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tPOl8-0002we-Qz
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 11:24:52 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-21683192bf9so35224425ad.3
 for <qemu-devel@nongnu.org>; Sun, 22 Dec 2024 08:24:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734884689; x=1735489489; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iOzpxqZ9VNfy3l9f3NLQHzVfPYu5zW7VkQL9KwFwxnA=;
 b=RukDIfTjiBL+tFgl+qHb1XCgNvw6ZpLPrrNacHwWQkh1bu1HGQR0DF9uSk49nWUUP7
 kZ7EFY9e5PC4Wq+eI16ld+xenENxYSXRVPbm0Rm/5aTcVvlHKdHJNzLqKN7U55ZQdxTn
 9wY5XiDJ9Zcr+l06PiAZiCb8B+d9HBq+8oe7VlMtUUqFXgvhPtH+xE5t6gu7Pp3Hr5n3
 KB48Cw69uqG+FeEegUXEfZpJZUmvi+ih4mLCVj6k+ICO+63qkiVmHWLidwiiYtsmnow1
 gIBpaKikWv98Qhu/82cI/oVZYttRLymY5PEL0EZmaRTFviMqqSp9ylDApJ3AUaC/9nLk
 wDRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734884689; x=1735489489;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iOzpxqZ9VNfy3l9f3NLQHzVfPYu5zW7VkQL9KwFwxnA=;
 b=YJhCD+1W78ckRULSOfVix+gk56VYHEm98YORt7Zm2RPPlSl6wHlmw0L/j3NZry8txm
 vQvTq5aEOLA+MfQZtOqNFpgAVsSBhDAdO4dx8W943vQjLalyVZ9vdv3Ks8HJoZIBktDN
 /IdVDHKhp7hHN6J7Jn/cg/YAFNHuWW2SnAN/gb6LmkpbNj5rwK5w+Tseg3TaFFdkrZUg
 /C/3djDaie3PoeFCBlCouucouDI20PN77DdC45OpmR5sJfSi8IoHmzQg6T9T34mMaJMJ
 wYGgvIOyQWddQcyO4IDSimzCOlog8N7itBpdU3KeD6Pe5GyGjWMhu5CQ5V7nfBf49e0q
 S3Jg==
X-Gm-Message-State: AOJu0YySlcJkNGVFVGjVuVevLoy7tWQr8opnBN09/sa9S3Nxdqd0gyUd
 RHsz5Uf5sQE+4+gdyat81WiSrRcvFEV4FuL17++eYyWvz8gOTWlAujjNYbCqnPObCecdL2hyi8B
 RcrE=
X-Gm-Gg: ASbGncsTIDOIQ13r7Q5vvBmj+z38aAVhZvGcY/fu2x1laQKfqBcxODg/64Tu3vH5E/m
 pKIKvM2lBvSmhpBhQ6FpHxvtWdPR5RcU4BHJMs/S8w4dXKb+pB1/Z/bfVVve8vw2rQdUk7H+yvY
 mbPa2c6lj+eahW9D6or5sUrbK4J5ad5i5kLQa2Rj1y2u5jBFOkg94cpnWuLC0mFVW3TXUy+zius
 IvMECdSeIqPzRFkWN6KecUK5+w2iOVA6uzI7zUdNpfHOjSQMbf8owujZbALjr0=
X-Google-Smtp-Source: AGHT+IFqCOlKF+JgurAqfIDzDUe6Kfxzp2IGFmzqnl0om3uOgh5intQmV0rvJSEMuErtvRmDnbXxOA==
X-Received: by 2002:a17:902:ea03:b0:216:69ca:7707 with SMTP id
 d9443c01a7336-219e6ebaf4bmr131453925ad.30.1734884689193; 
 Sun, 22 Dec 2024 08:24:49 -0800 (PST)
Received: from stoup.. ([71.212.144.252]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc971814sm58461385ad.79.2024.12.22.08.24.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Dec 2024 08:24:48 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 02/51] tcg/optimize: Split out fold_affected_mask
Date: Sun, 22 Dec 2024 08:23:57 -0800
Message-ID: <20241222162446.2415717-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241222162446.2415717-1-richard.henderson@linaro.org>
References: <20241222162446.2415717-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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


