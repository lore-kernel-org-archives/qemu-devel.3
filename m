Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 740ACCAC5BE
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Sep 2025 16:33:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v2uJy-00036x-6w; Sun, 28 Sep 2025 12:32:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v2uJv-00036C-9G
 for qemu-devel@nongnu.org; Sun, 28 Sep 2025 12:32:19 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v2uJk-0005yH-Js
 for qemu-devel@nongnu.org; Sun, 28 Sep 2025 12:32:16 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-27edcbbe7bfso39636865ad.0
 for <qemu-devel@nongnu.org>; Sun, 28 Sep 2025 09:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759077119; x=1759681919; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Tcjg7Rm+FO5sfmaU4y9Lv2rGxIIqFJaHxhAj+GUNfSg=;
 b=qAKNXKeZko/MuQfed4KI4yScIjo75+CLhNu+zB7+nAgWwFe6mTvZVK1u8sGKFmzbA6
 xu9knfQJhIJxRaEa5e/P6XbWzRWOcVEO8G2/46GEtxbw58004r3dRPVL7xnOf3uFpObx
 hP5hN8aMe4d85gxitjWgGeZnCjKGbP/uQg7indVWeVO7CZLZ9Tu3eSOtrJQWbX3AUR7/
 x0M31NOw1uacHACrEGNUvF4loq38uSD560wS+1msw38lTIiCtpCjJh980OB35cRfwv7j
 vgOxzZOasjodyUkiH6Oysi00+3HNXnXAuivnEuYpb6QjJsXCYh2cl+qMwgRDgIojymS/
 eo5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759077119; x=1759681919;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Tcjg7Rm+FO5sfmaU4y9Lv2rGxIIqFJaHxhAj+GUNfSg=;
 b=A9uA5gdkNKQ9dQYkD/YgDKsevs25wccXB5NXIT4zQhlUWXKT5ZVEfQkArr0KSuZts5
 MHOuYhF7tixuegcFs+J2gH8bBcjPwVDaEolau3nRjo+U0736YsqG++d66u20rV3MKwRX
 EIShS+FhOse6kpHpu3VsDrDFdcn4ZNKIJ1JxYQoL6Zzy2qeqQbTegqLBLO2CMrKuFzHI
 jwGhzQ6xqZR+QJcfUOr9xcOm3V0gTSm047161ANEj/9qeg0WSIgHuC6VdwAner/wNaro
 LIeSEWMX/Sx8EKaepb1tYEoRDfqBKwqS9vZO4ygHJsDEXgYvpQeFfKgXzuy6DE+dCMGU
 w1fQ==
X-Gm-Message-State: AOJu0Yw0ktEJ/W2AYw+7RSMO7EA0Dj9jjxTPbvHe11ymQaH6e8+Tagee
 cGOPiCxQhJwUK84gX1/tEL1q6iVav+fC6YNDaytmtYcKSgDc7rJ8dby8UMjps9rkIcghhEY7d02
 KE+d63fg=
X-Gm-Gg: ASbGncuaL4UNDY+2pHQZBK2xUw81O9VMZse2vIytUCCkWOkO/QgG0lb/s87O7euc6eb
 8X97d2sS5dAud/ExClh/SJyeDmIS4hOYdF5Cu90LdKNFCg9SJrQdko97lVu7ngEYK9zgewiSgmM
 m4hDdD8QKyZa3MhNtODsdZ4+Y195FlQ+26tBVLVIRyhpldtukEnyIRdzBh62vyxQh2VTt140Y92
 EyOZOEusutW1LuABu77b3pqodSpyEjZHnUtf1jdqqiiewRKp6sb6QgQrV0QTPErXWikvC3bBHo3
 XDdbr1S+PejMIX8X0+wQLWQk/Wp1oTmzStmuK6VTaGgXEKV5/G38McL1kTJA2gAw/jJ3SmI8VP7
 gdyiYqFiUNSNhdr6AkT3OrBTmq3JV
X-Google-Smtp-Source: AGHT+IGp6ercjt3fh1llC3cKIp5vfhOGTJdoLAHklItxZpyKW5P9dv5AFfBPbIQO2aJzox1u69An9Q==
X-Received: by 2002:a17:902:d4cd:b0:24c:7bc6:7ac7 with SMTP id
 d9443c01a7336-27ed49decddmr174525795ad.18.1759077118811; 
 Sun, 28 Sep 2025 09:31:58 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-27ed6996963sm107236335ad.104.2025.09.28.09.31.58
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Sep 2025 09:31:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/5] tcg/optimize: Lower unsupported extract2 during optimize
Date: Sun, 28 Sep 2025 09:31:53 -0700
Message-ID: <20250928163155.1472914-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250928163155.1472914-1-richard.henderson@linaro.org>
References: <20250928163155.1472914-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

The expansions that we chose in tcg-op.c may be less than optimial.
Delay lowering until optimize, so that we have propagated constants
and have computed known zero/one masks.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 63 ++++++++++++++++++++++++++++++++++++++++++++++----
 tcg/tcg-op.c   |  9 ++------
 2 files changed, 60 insertions(+), 12 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 5df57049c2..47fbcd73e3 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2161,21 +2161,74 @@ static bool fold_extract2(OptContext *ctx, TCGOp *op)
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
index abce307f26..4caf77da1e 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -1008,13 +1008,8 @@ void tcg_gen_extract2_i32(TCGv_i32 ret, TCGv_i32 al, TCGv_i32 ah,
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
 
@@ -2711,7 +2706,7 @@ void tcg_gen_extract2_i64(TCGv_i64 ret, TCGv_i64 al, TCGv_i64 ah,
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


