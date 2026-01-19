Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE365C98315
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 00:08:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhcoX-00020f-Da; Sun, 18 Jan 2026 19:08:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vhcoE-0001mu-8S
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 19:07:54 -0500
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vhcoC-00015P-Gi
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 19:07:54 -0500
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-81db1530173so1643040b3a.1
 for <qemu-devel@nongnu.org>; Sun, 18 Jan 2026 16:07:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768781271; x=1769386071; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Aa9mZAXen3GNDGFdJHfEPbpr07SEJ40e/xyiM/mpQH8=;
 b=nMsdTJCBcBi0fiZw77kVgJ3Di1scBncIH4GjuEgVOrFXrXVOsv++3wH9ZHfrGROC1b
 /yDVAM/9hWvAeh/ZIsr+jBXeaI4uHoJqPM/Uj8JIMg0aQ1yeACmyVncOzm+koQNJf03L
 dIRlnNJY908RdSMBHt5d57Jr+fgY/vo8tvO92+aBP4OGZfsWCQBDi0O8wvDCDuUzZSdl
 PrH0HVXPKb9b/3hT5lxw1yPr7VllH8x5zdPuSIHmF7FBBwLfnoa8MYbZXYlLqdHq3Se6
 Bv7k7GHMQNMt/PLakJ9FwDIz/rvahTuYq+xpxyGpf9GMfGl7rh8yZMqqpKYH6HsC4Bl/
 k2wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768781271; x=1769386071;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Aa9mZAXen3GNDGFdJHfEPbpr07SEJ40e/xyiM/mpQH8=;
 b=K+cTYkRmwvSaaw7HIrdTtsOL8bMWM+GKJWniK74M2mFh0E6Yhs+c6nSKzbFYl4QpvH
 Uvf4nrNOtLkIb+HfaeFSorXFE0xTDMUt6dG5uJCCIhOUlhNyhf8ak+XWdWLVfYrtUt/x
 CQsfvLtHdyOrROp5h57XtmiBa9vhxxXJGYDc5RBMTe+U5GPe3epPfmh0SSlr5LoyjUHa
 vfcFYr51TrGbwpUpDGSMZpg6TdNzCEDzZwJ9pZ6XZAGxFo/fG0ZVSbFe53NzftJmX/Tf
 yXLLPgbpi3TuXAmiFVw17MGoVzYnVSdEbVfFK2xTJ0vxJwsQibAWpx0nCcDA2m7ZYrxK
 Jyhw==
X-Gm-Message-State: AOJu0YyFl86YIduQiKQV5D964aeeTp/2unARw2e+79y5WxqhW2Lkb8+f
 Xs/gmxmqZkRgQUhkdtbmnYD+ca/2tZDQLY2tKgaVHEdRsQSBZiy6EPggevNRrhpvWgd5MbANEe5
 29QOMCx4PcQ==
X-Gm-Gg: AY/fxX7sehvaFDmzcOQZj2PSoicuPGzhR650th5e04dsxkBHQKNL3hJ/3BfBfyVmOuu
 asDfVoZTDF1Z8WiVwAdRszgVjtBZlJYt+gGagHIHrPgEgaXsvbv15rIkzEjgTtd5XTlssLNuI7N
 HlKU3tod1Zqc2Xw9abSN7sLkpXARgq9awe+vwBiMZsepWdVwzprtjn16ePfDz42oPrSvakkIAcl
 gQLMH6S9yqC3wwo/du7DdMnz75SPpgWQU6ohr3M+zMtW8cR4KfcegnZtx/BKJLZBrHPA5UvyucW
 itkVP1Z0TOLBSaiwQ1GLXwvVJvOgkjeG2xdLS9bSeeJK6f6T5NkkTnCk5++Nlh3fo/+Z9WaTYci
 hUn+aIlZYrS65yuR9YI7IZvKHOsY10e+iscV2cFsmEFvHUFY9x1qEVOEw04bD2NLF/MZ1kUT7GW
 BvqHiaEZBUnXZ0qD9BJQ==
X-Received: by 2002:a05:6a20:3c90:b0:38b:d9b0:e943 with SMTP id
 adf61e73a8af0-38dfe6f7ec5mr8173102637.38.1768781271009; 
 Sun, 18 Jan 2026 16:07:51 -0800 (PST)
Received: from stoup.. ([180.233.125.201]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a7190eee39sm74872145ad.45.2026.01.18.16.07.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jan 2026 16:07:50 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, jim.macarthur@linaro.org,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH 2/3] tcg/optimize: Lower unsupported extract2 during optimize
Date: Mon, 19 Jan 2026 11:07:39 +1100
Message-ID: <20260119000740.50516-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260119000740.50516-1-richard.henderson@linaro.org>
References: <20260119000740.50516-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The expansions that we chose in tcg-op.c may be less than optimial.
Delay lowering until optimize, so that we have propagated constants
and have computed known zero/one masks.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 63 ++++++++++++++++++++++++++++++++++++++++++++++----
 tcg/tcg-op.c   |  9 ++------
 2 files changed, 60 insertions(+), 12 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 890c8068fb..e6a16921c9 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1933,21 +1933,74 @@ static bool fold_extract2(OptContext *ctx, TCGOp *op)
     uint64_t z2 = t2->z_mask;
     uint64_t o1 = t1->o_mask;
     uint64_t o2 = t2->o_mask;
+    uint64_t zr, or;
     int shr = op->args[3];
+    int shl;
 
     if (ctx->type == TCG_TYPE_I32) {
         z1 = (uint32_t)z1 >> shr;
         o1 = (uint32_t)o1 >> shr;
-        z2 = (uint64_t)((int32_t)z2 << (32 - shr));
-        o2 = (uint64_t)((int32_t)o2 << (32 - shr));
+        shl = 32 - shr;
+        z2 = (uint64_t)((int32_t)z2 << shl);
+        o2 = (uint64_t)((int32_t)o2 << shl);
     } else {
         z1 >>= shr;
         o1 >>= shr;
-        z2 <<= 64 - shr;
-        o2 <<= 64 - shr;
+        shl = 64 - shr;
+        z2 <<= shl;
+        o2 <<= shl;
+    }
+    zr = z1 | z2;
+    or = o1 | o2;
+
+    if (zr == or) {
+        return tcg_opt_gen_movi(ctx, op, op->args[0], zr);
     }
 
-    return fold_masks_zo(ctx, op, z1 | z2, o1 | o2);
+    if (z2 == 0) {
+        /* High part zeros folds to simple right shift. */
+        op->opc = INDEX_op_shr;
+        op->args[2] = arg_new_constant(ctx, shr);
+    } else if (z1 == 0) {
+        /* Low part zeros folds to simple left shift. */
+        op->opc = INDEX_op_shl;
+        op->args[1] = op->args[2];
+        op->args[2] = arg_new_constant(ctx, shl);
+    } else if (!tcg_op_supported(INDEX_op_extract2, ctx->type, 0)) {
+        TCGArg tmp = arg_new_temp(ctx);
+        TCGOp *op2 = opt_insert_before(ctx, op, INDEX_op_shr, 3);
+
+        op2->args[0] = tmp;
+        op2->args[1] = op->args[1];
+        op2->args[2] = arg_new_constant(ctx, shr);
+
+        if (TCG_TARGET_deposit_valid(ctx->type, shl, shr)) {
+            /*
+             * Deposit has more arguments than extract2,
+             * so we need to create a new TCGOp.
+             */
+            op2 = opt_insert_before(ctx, op, INDEX_op_deposit, 5);
+            op2->args[0] = op->args[0];
+            op2->args[1] = tmp;
+            op2->args[2] = op->args[2];
+            op2->args[3] = shl;
+            op2->args[4] = shr;
+
+            tcg_op_remove(ctx->tcg, op);
+            op = op2;
+        } else {
+            op2 = opt_insert_before(ctx, op, INDEX_op_shl, 3);
+            op2->args[0] = op->args[0];
+            op2->args[1] = op->args[2];
+            op2->args[2] = arg_new_constant(ctx, shl);
+
+            op->opc = INDEX_op_or;
+            op->args[1] = op->args[0];
+            op->args[2] = tmp;
+        }
+    }
+
+    return fold_masks_zo(ctx, op, zr, or);
 }
 
 static bool fold_exts(OptContext *ctx, TCGOp *op)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 96f72ba381..8a4fd14ad5 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -1000,13 +1000,8 @@ void tcg_gen_extract2_i32(TCGv_i32 ret, TCGv_i32 al, TCGv_i32 ah,
         tcg_gen_mov_i32(ret, ah);
     } else if (al == ah) {
         tcg_gen_rotri_i32(ret, al, ofs);
-    } else if (tcg_op_supported(INDEX_op_extract2, TCG_TYPE_I32, 0)) {
-        tcg_gen_op4i_i32(INDEX_op_extract2, ret, al, ah, ofs);
     } else {
-        TCGv_i32 t0 = tcg_temp_ebb_new_i32();
-        tcg_gen_shri_i32(t0, al, ofs);
-        tcg_gen_deposit_i32(ret, t0, ah, 32 - ofs, ofs);
-        tcg_temp_free_i32(t0);
+        tcg_gen_op4i_i32(INDEX_op_extract2, ret, al, ah, ofs);
     }
 }
 
@@ -2221,7 +2216,7 @@ void tcg_gen_extract2_i64(TCGv_i64 ret, TCGv_i64 al, TCGv_i64 ah,
         tcg_gen_mov_i64(ret, ah);
     } else if (al == ah) {
         tcg_gen_rotri_i64(ret, al, ofs);
-    } else if (tcg_op_supported(INDEX_op_extract2, TCG_TYPE_I64, 0)) {
+    } else if (TCG_TARGET_REG_BITS == 64) {
         tcg_gen_op4i_i64(INDEX_op_extract2, ret, al, ah, ofs);
     } else {
         TCGv_i64 t0 = tcg_temp_ebb_new_i64();
-- 
2.43.0


