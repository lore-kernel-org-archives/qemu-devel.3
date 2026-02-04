Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FD54E8B39C
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 05:26:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnVO8-0000Zh-TI; Wed, 04 Feb 2026 00:25:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vnVO2-0000Vo-RG
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 00:25:11 -0500
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vnVO1-0003HD-0d
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 00:25:10 -0500
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-3530715386cso4756484a91.2
 for <qemu-devel@nongnu.org>; Tue, 03 Feb 2026 21:25:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770182708; x=1770787508; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Aa9mZAXen3GNDGFdJHfEPbpr07SEJ40e/xyiM/mpQH8=;
 b=bASyJfjlHoRAy+6kI3xSDUSNrSzYYfZd98VvzbxmrfaKRd8NO9cofmE1tFA3iGzFic
 QeG755C1Afk5R+U6yhEc0+hT/9KHwhv3aYy2yawD+iHuR9JS4a7k09VC3i73nRQ9iP1U
 ifObuum5PhgSxRjtBW+7Gjyz+QP1rnlM2N8CZ/30KrYFupkRem4nBIeEuJlgwkDmMEqi
 3LDjM3nDPV5XcOnaQjcp3MCEJgVO+uWRSMtBXTnd2giP9mtm2w3elNAjzQkQWZQEYX7P
 82kuxQojaDdpz+mgdwaHn2BxqXf3l8y/b0mx1DZkuQQ4kC/MTjRYOqdrZqRsvCu9vMTO
 2wkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770182708; x=1770787508;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Aa9mZAXen3GNDGFdJHfEPbpr07SEJ40e/xyiM/mpQH8=;
 b=Pk3EvNdHI2ofUCsjZroW7Pd4MHIfSIgsrgMpZ2017dTRTCkghmBprRWw13mwSY64lD
 AqGoG/JWs/bnOHOkYw60SYCheIqlIPawxBGjUPcO+2AqI4MrAInWIo6SqIyzOne6FWd8
 lIDBF4bfKes3BtbYgqxa0uKYr6lA62fDUaT37RzK8e44JbjPK3Stsj9O5TA4D6bBPz7O
 ElH9I35pkp5lGa2AjP4N1guB1B/a86W2MK8wo/R1YleizV704KMJnguha3Nswbhuesu6
 uNwKupzlYirZhHLF3eAEqsGBL+JzXWh9vVrxkx7SOYXQS0MSmR1/BpsRtNqjsxs8/edU
 QJEg==
X-Gm-Message-State: AOJu0Yx2iZjUrpZhfbrTSBglxL8MWVCkwT33FN98dvxVs/3W/fY379Ez
 fy8hLNWQq5Mu7I7+gGN8TdESUmJwM414jnE2nbxjD9TquwzHYeocqAFiQ9yI9HunXHJS94S4aX5
 jsB9s1WY=
X-Gm-Gg: AZuq6aLMs/X/l9Dm8EU0eAdCGqf7qJrjD//1bEJroccb5S5HZAYDzMN813rgN9bL3Gh
 H+wXkQyLgUgHo6WUgRyhmRMabme6+y6mchcA9PPTt5j3zD+dMEC0KXQRJmeRutMAco7k+0Olz4T
 odMAFGzEyVFD26LSSota1XoIueyIJq+QBkt3yp6ZrR2IHCeTxgcbe1BcjGRF7M4fjbdGVob1zMu
 cCD1UieOEWLeGIPcg1frcDCdIGHNxxeejTthTU4XumDYaDSawidCgwtjeVZ/W4fN9Ze+z4ZQ6Hj
 kcjC4p3jG/T3Ee+5Zl0TzWSlv+Kh0BuciDiFDwMCmL5jvAm6bTadVbtQ2N4ahTiTPRZxammmxQ5
 Vpa/8sYluuwYtOCFQ9KehaZLGLUQxeTggYjKbOs2BDhYQ4yUNo+S968Dit9dWw397qTLHYtU+B0
 kLzYt1B7I0L6lkBAEu6/W5Fy0G03+UdBSSXfjrqhCulEOjYLCBvOc2bjd4CJg=
X-Received: by 2002:a17:90b:1643:b0:345:badf:f1b7 with SMTP id
 98e67ed59e1d1-354871db4e8mr1497664a91.28.1770182707562; 
 Tue, 03 Feb 2026 21:25:07 -0800 (PST)
Received: from stoup.. (bg30dhzlx7lnyrq74wrz.ip6.superloop.au.
 [2401:d002:dc0f:2100:1bc:fe1e:491:928e])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a933965c3esm10062015ad.67.2026.02.03.21.25.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Feb 2026 21:25:07 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH v2 2/6] tcg/optimize: Lower unsupported extract2 during
 optimize
Date: Wed,  4 Feb 2026 15:24:52 +1000
Message-ID: <20260204052456.970605-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260204052456.970605-1-richard.henderson@linaro.org>
References: <20260204052456.970605-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1031.google.com
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


