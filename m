Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DF17E7718A
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 04:17:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOUM4-0008Kk-Sq; Thu, 19 Dec 2024 23:11:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tOUM2-0008Jg-UK
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 23:11:11 -0500
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tOUM0-0006Fx-9a
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 23:11:10 -0500
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-820b825cbfcso2157999a12.1
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 20:11:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734667867; x=1735272667; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Y9RnxHpN0x96A+UA+qFx0eOiDNd9nU3BGhNBeQSd/Rg=;
 b=D3SizqZj5QjBT23cabkwuoVRwwYUlfoii6kzMCoxp5kJTUg5wGinVdRNk6VK14AwJt
 qYxy/FVYy/90BZs/eIPa6esIri1Fn8JuzLaeriyo1OqKOQpmt+w2wbwttfBKGBKFYZlU
 3NlNGjLmRIKnIaPP0TlPkrS5LbD+OLhpkEUxJJSrzLGbdgx3OmGgIZ7nHT4xm7vE9ewc
 PZ6yMH3SD5OWkwGCWHC7KmD+7eJDWSmJ9eazmhqqgDJHxQbr7cobfSXyotOw0Hi0SzLe
 ChnHEKhHWH2UY2l6NDSz6NdW2S6Q3KiyTagMYj38k850w1yUxECjiI1DZl6Pmlro396K
 SFYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734667867; x=1735272667;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y9RnxHpN0x96A+UA+qFx0eOiDNd9nU3BGhNBeQSd/Rg=;
 b=ktSwLajhOiexh6uaIruhGsis/+Eyx5NGjPWXPF56q/vUmU64in8BLSzTHMzX5YPOdC
 Pzh1A/bY34Ep66pfM+D7HeeEZev3AsrBWFfDgxSQkEHKTMCdByX97b3jRMadpTpwxgNE
 h2g/BA87sgp9JkYGQ8vxW+p3ISBkUk5ef5DaBxF7tjs38Mb9GV0S6J3M+L72+fVZXKJ0
 IqyNs8gC7hhcdjovpWoVVnkhGGQw7h9kC9O/k+sb0lefS0m7KeC3k+IwlmfbwflmUXI7
 uwi4siDcLWKW9UfBqTOBFZAG6E4vbJGNZ+RfGEsPfGLUG6osjN4B7TzSUMm+RoNY7Cjn
 vvbg==
X-Gm-Message-State: AOJu0Yyv4RJwX8ZVNxTWY5smaACE3j74ZtvdyNZulEqXL2WOJ28K06o4
 PPIv9yg18BVFEHudGK/1Q2oM4Tw1T5Y5B4mKFF7VloMX1lF1aaH3dxEYL2NpNWgn2axfZxtc4K8
 o
X-Gm-Gg: ASbGncuz5iLgT1Wfli7IUhUw5FugoBCeZ/kkilov0PpKzKXedpljRr0njZOCbZ15+ce
 3rrwtO+cnmoQU1VPuNZlhzCsF5wZEKKyMUNR4Odry7/BNk2SjpTjSM9N7gLkk9d7Nl4Pme74UGO
 R8jtHfY5l8MQj+BjVa0WYWew75YCgPlwwmskjttdtIhKsvbdZHzLq57nUoIJHY0udyGtKk0vUlj
 OBi+r5ovzpJjPtSQsqPDawcapMpS8QohzWiesYITHl9mjjy/cMWK18zxD4mWWI=
X-Google-Smtp-Source: AGHT+IGb9957OjpSfK5DpeQmJQVhPEoDu917eXQbfXzS6jGXJVLsMNWDZS42XZhPdbHigtlqjQH1Ng==
X-Received: by 2002:a17:90b:3a43:b0:2ee:94a0:255c with SMTP id
 98e67ed59e1d1-2f4536d25fcmr2140111a91.13.1734667866749; 
 Thu, 19 Dec 2024 20:11:06 -0800 (PST)
Received: from stoup.. ([71.212.144.252]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f2ee26fc22sm4165260a91.51.2024.12.19.20.11.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 20:11:06 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 02/51] tcg/optimize: Split out fold_affected_mask
Date: Thu, 19 Dec 2024 20:10:14 -0800
Message-ID: <20241220041104.53105-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241220041104.53105-1-richard.henderson@linaro.org>
References: <20241220041104.53105-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x530.google.com
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


