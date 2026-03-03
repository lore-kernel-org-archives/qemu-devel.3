Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E3D7EB3641
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 01:09:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxEFm-0000Em-FY; Mon, 02 Mar 2026 20:08:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vxEFl-0000Ea-Mc
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 20:08:49 -0500
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vxEFk-00071r-08
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 20:08:49 -0500
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-824ba8f0acaso2596461b3a.1
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 17:08:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772500126; x=1773104926; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i3/78IdtRTsOqh21jFMFzpUC2ndX+m3gcPFQQTfoeDI=;
 b=A4MOVPgptsVtaT7UvLrdCG1VDHXheP07gpCDlhULRJ/SxymvL1cUrbUqAj7AM0tcJa
 MaB2nq+KQLj5trrpmPjWOJigI5d5T+ajlTJBM+m6ubX0i166mIwkwEF4yofkPsYoNyGw
 +DjilHr8358r2yWExklSF56GMvuYD4W+kdjkwQP2NTcC1Yk7bRFMlACOzMaELHQRvRUS
 4Xo3wdB4nFUK/D0HXpDNFPABaig5B1hvALeTKhQZYp5Y5321O0Q6wkxPtw2czhgLQArN
 QAwsP6hjMSg7HGL+PgjPdwk21UU9ZgmDBdW147xcdV9j6tk8oK0mzaqdR++aFLtStrTD
 q2Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772500126; x=1773104926;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=i3/78IdtRTsOqh21jFMFzpUC2ndX+m3gcPFQQTfoeDI=;
 b=h0bSxtDOZ3ONtTCQHPFkVA+auzqKZC+Z00GMHfNSXsovFeGGTr7BGD256NJ2syQ9KM
 QBXMVq7/c8utzNwSBdxLMlL5d/Cka9OvV4mnOUQa/JbcXOPum9hA41vflP8ddNsM6U7m
 2RjeJEh8CInSbjijIs16AaETgD5kjr3ZJqWUPeCYE51E+RHjn1lVJZBZN6tH1reZQIVN
 fQIK/eV/cOOPsQtxq/iX9tTPlXhl1+14Ma673T2ddEBHguUV1gbWJ8K1xKJ6qn4IiE4U
 4SUuga3jhHWjxZuvJFa8v/Q8AjQeejgTnxJs7B5klWD0bX0AHspSc7TNsfExo6ri2v9d
 /0HQ==
X-Gm-Message-State: AOJu0YysDMO9K07EC1CW+VxVbR7BqbYdsS17aw1h/oAEn+9JbZEQsUoC
 vTxmmuxQUvFxVuh6T9iFmOhxZBVknpwm3QSTrtGLxR4NiRmv8oNpaNoPpGYNPw2k6azbXjt0wV/
 uPv82Sas=
X-Gm-Gg: ATEYQzwxZ4GOJVnN2L8GuNIVZSFirI57aqIvAbIdWEUSR0g6AKuWpwIMGgNVqIfb5Us
 BwVWKsHlzccKDXWt/JXXXMoJusHgqzY57LlIA7ev8o/xhJqMEiQDdiz/P4AuK1g48eFUFNFNWm8
 nEl7YYKz83XsbAKIvk3u2nX11Ruf1ijzIaZbWZ8K7/TpKUWIT+uF8dIIX/pS1MGksgVZE36JaP7
 kerO5ZfA6UgALs3Qbk/923ORwHq82/cHA2UNdRtWifrcV83nKLgcFoFTMh7Ge302f6D4n+JxPT8
 53hzbdkKDs/vFXGfUY3Uvc31X5Qnyqn2M3tANiNhAy+6LfLXZkS+S9usTwrOLex2rgyM/b2xKMY
 LV1aowJpSwhIVyRXvq8ILIQlEegmuGjBfrwTcFmQKBqeZHW0eIEHdjlBzTxIh/h4d5DOsXygTh1
 xgmYbD7PlnK9S/c5DB6v7TETpF0RS6Zg==
X-Received: by 2002:a05:6a00:3a03:b0:81f:49cc:ea11 with SMTP id
 d2e1a72fcca58-8274da2a022mr10143435b3a.65.1772500126311; 
 Mon, 02 Mar 2026 17:08:46 -0800 (PST)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82739d94de6sm14484988b3a.24.2026.03.02.17.08.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 17:08:45 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, jim.macarthur@linaro.org,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH v3 3/7] tcg/optimize: Lower unsupported extract2 during
 optimize
Date: Tue,  3 Mar 2026 12:08:28 +1100
Message-ID: <20260303010833.1115741-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260303010833.1115741-1-richard.henderson@linaro.org>
References: <20260303010833.1115741-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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

Reviewed-by: Jim MacArthur <jim.macarthur@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 63 ++++++++++++++++++++++++++++++++++++++++++++++----
 tcg/tcg-op.c   | 14 ++---------
 2 files changed, 60 insertions(+), 17 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 42637c12fa..59761c2c84 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1918,21 +1918,74 @@ static bool fold_extract2(OptContext *ctx, TCGOp *op)
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
index 96f72ba381..fc2254f54a 100644
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
 
@@ -2221,13 +2216,8 @@ void tcg_gen_extract2_i64(TCGv_i64 ret, TCGv_i64 al, TCGv_i64 ah,
         tcg_gen_mov_i64(ret, ah);
     } else if (al == ah) {
         tcg_gen_rotri_i64(ret, al, ofs);
-    } else if (tcg_op_supported(INDEX_op_extract2, TCG_TYPE_I64, 0)) {
-        tcg_gen_op4i_i64(INDEX_op_extract2, ret, al, ah, ofs);
     } else {
-        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
-        tcg_gen_shri_i64(t0, al, ofs);
-        tcg_gen_deposit_i64(ret, t0, ah, 64 - ofs, ofs);
-        tcg_temp_free_i64(t0);
+        tcg_gen_op4i_i64(INDEX_op_extract2, ret, al, ah, ofs);
     }
 }
 
-- 
2.43.0


