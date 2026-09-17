Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F15EC982C1
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 08:18:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x77JC-0002ee-Fm; Thu, 17 Sep 2026 04:17:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x77J8-0002dz-NZ
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 04:17:27 -0400
Received: from mail-pz2-x0e.google.com ([2607:f8b0:4864:3b::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x77J5-0001tD-TS
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 04:17:26 -0400
Received: by mail-pz2-x0e.google.com with SMTP id
 41be03b00d2f7-cc1cea4c7a0so278805a12.1
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 01:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789633042; x=1790237842; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EpAG4+EMbhMQtyxJjh6eeHOBt/UelettsF65Syqgkq4=;
 b=GQE8eUULdVQwSK+bdIeNFCJs7diTpzlALy666U3VhHFnSee3foLj1fN7NvoHfKbpy7
 0fPmslUCr8bVq4NgbppqQeuPb1XEyM5aj2nDpaKIBE9wwJ/BQtdFyhUBwWRFM1IMEnEz
 ygCOk93/N9k1c3rWeiQRTIuU4tmnOU0i+yZVSAf6z2JUO4MLgcMTpg8U9w1I/64nEhVr
 pFpeTE8/Fs9cXeTHh5ABkq1hRUxAWJkK0xQgdijb0GpG+J0ASkwSGi++RuskU01SMYFB
 vsK2EWhetkgnTT7Ey/73RAcL6izZpSdGOghXAmkzseoJpgr0A6+EBJO/TBUi0naqE6ZY
 eAkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789633042; x=1790237842;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=EpAG4+EMbhMQtyxJjh6eeHOBt/UelettsF65Syqgkq4=;
 b=E0JcgoJ9aC6kH2VbyMXe++qDbpdgCZVUfaPDzxSm0G4ENdCvW5FQR6Dp+NSAbcdKO/
 BgfX0c+0UXbhgFgNWvpKKf4tEyPuGsL+EQvZgqdDaBGtWPeq4KEw8dDS+9Xg6C4F6lEe
 1ISmmAmWqL0849hk3nCVR4fbXYRySvQrQGJ9P1++tj1KL9fn7cf+gwBZ6E8g4xCvtePm
 3QtYwvCQxDsZ4mqzE+/2P032OcpSrUzamkL4Y1NMAXf0A2dx8j0vsBBD6KQZryVH50Rs
 XvDgT+aN0cIqyYwQNIAjGcE3w67iePfMqhP9pMNniCYcHGcx9HDsNKu+UsfQTULj3c0j
 DPJQ==
X-Gm-Message-State: AFuF++nZ/SaTe3yyuL+5DAZxbjFg9TYCgw/PL5OH23XFgnf9e/+kpOtJ
 6ASyjnTbE9ZRx9n2U+6PPKFb3xMMISW+K+eOTyWzeWUx+D5uPcJ9FwKuq+K0Z+9SnLalgJ1uxMB
 TTswy
X-Gm-Gg: AYBFou16U4TJyEO9JUoe39+bMLGHI/qMbrkGg69QW4N9Z3gONyCbGP5MelwZOUyMEqm
 xDwToSwZ9SP28X8GCcpwHnSMPvPZPjSp5nRO/DXH5/DWgWpG0tPA6EQ82/2bHQzTBla6Wzh8KRX
 YfQ3Ak6+tAVu84Do/N3A2y0ue5ND9sdvgLxweL3de/humHabQ1mar2Vcaf3MgXEsCjN54WxVVzt
 2GXIryZpZUC2wI637Ybi3buoXJzfWAEy8YPcZYkjuOerUXKG70usdvQGHxLjUOYlPqWsA3zGIk+
 kNVI/GQBtizc0gWqVfweI5FLFwEaFr0nl8gbIv+8gSq8kqVkUfdY1SPjn+pao6hPilcSXErUPU+
 Ovdzi8twlg7YSl7YMpklyGHxhRGpHQlW5Aj2T6puOW5e+IBE3F2YlWgwbpsMpWvMeTAkOhsRciN
 E4t3Vdj3uTQoTAU9MpO73nYBJb/dmeZw1AW+7IAtrRBUD09O9CxAWP2nG5wAR017fhRnhpm775c
 o4Ef5w=
X-Received: by 2002:a17:90b:524d:b0:39e:14db:437b with SMTP id
 98e67ed59e1d1-39e1e2e4890mr12827854a91.7.1789633042225; 
 Thu, 17 Sep 2026 01:17:22 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:325f:1938:d075:8c13])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33c1943f4bcsm127638eec.21.2026.09.17.01.17.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 01:17:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Matt Turner <mattst88@gmail.com>
Subject: [PATCH v2 03/16] tcg/optimize: Handle INDEX_op_lea
Date: Wed, 16 Sep 2026 22:17:03 -1000
Message-ID: <20260917081716.946668-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917081716.946668-1-richard.henderson@linaro.org>
References: <20260917081716.946668-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x0e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Reviewed-by: Matt Turner <mattst88@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 66 +++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 65 insertions(+), 1 deletion(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 1e4d2a0a425..a7f45bdd541 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2106,6 +2106,68 @@ static bool fold_extu(OptContext *ctx, TCGOp *op)
     return fold_masks_zo(ctx, op, z_mask, o_mask);
 }
 
+static bool fold_shift(OptContext *ctx, TCGOp *op);
+static bool fold_lea(OptContext *ctx, TCGOp *op)
+{
+    TCGArg sh = op->args[3];
+    TCGArg imm = op->args[4];
+    int var_mask = 0;
+
+    if (arg_is_const(op->args[1])) {
+        imm += arg_const_val(op->args[1]);
+    } else {
+        var_mask |= 1;
+    }
+    if (arg_is_const(op->args[2])) {
+        imm += arg_const_val(op->args[2]) << sh;
+    } else {
+        var_mask |= 2;
+    }
+
+    switch (var_mask) {
+    case 0:
+        return tcg_opt_gen_movi(ctx, op, op->args[0], imm);
+
+    case 1:
+        if (imm == 0) {
+            return tcg_opt_gen_mov(ctx, op, op->args[0], op->args[1]);
+        }
+        op->opc = INDEX_op_add;
+        op->args[2] = arg_new_constant(ctx, imm);
+        break;
+
+    case 2:
+        if (sh == 0) {
+            if (imm == 0) {
+                return tcg_opt_gen_mov(ctx, op, op->args[0], op->args[2]);
+            }
+            op->opc = INDEX_op_add;
+            op->args[1] = op->args[2];
+            op->args[2] = arg_new_constant(ctx, imm);
+            break;
+        }
+        if (imm == 0) {
+            op->opc = INDEX_op_shl;
+            op->args[1] = op->args[2];
+            op->args[2] = arg_new_constant(ctx, sh);
+            return fold_shift(ctx, op);
+        }
+
+        /* If arg1 was not already 0, fold the immediates. */
+        if (arg_const_val(op->args[1]) != 0) {
+            if (TCG_TARGET_lea_imm_valid(ctx->type, imm)) {
+                op->args[1] = arg_new_constant(ctx, 0);
+                op->args[4] = imm;
+            } else {
+                op->args[1] = arg_new_constant(ctx, imm);
+                op->args[4] = 0;
+            }
+        }
+        break;
+    }
+    return finish_folding(ctx, op);
+}
+
 static bool fold_mb(OptContext *ctx, TCGOp *op)
 {
     /* Eliminate duplicate and redundant fence instructions.  */
@@ -2218,7 +2280,6 @@ static bool fold_mul_highpart(OptContext *ctx, TCGOp *op)
     return finish_folding(ctx, op);
 }
 
-static bool fold_shift(OptContext *ctx, TCGOp *op);
 static bool fold_multiply2(OptContext *ctx, TCGOp *op)
 {
     swap_commutative(op->args[0], &op->args[2], &op->args[3]);
@@ -3211,6 +3272,9 @@ void tcg_optimize(TCGContext *s)
         case INDEX_op_st_vec:
             done = fold_tcg_st_memcopy(&ctx, op);
             break;
+        case INDEX_op_lea:
+            done = fold_lea(&ctx, op);
+            break;
         case INDEX_op_mb:
             done = fold_mb(&ctx, op);
             break;
-- 
2.53.0


