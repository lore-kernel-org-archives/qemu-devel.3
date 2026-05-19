Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1D71CD4F5E
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 16:24:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPNDe-0006g7-Oo; Tue, 19 May 2026 12:22:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wPNDY-0006dz-CM
 for qemu-devel@nongnu.org; Tue, 19 May 2026 12:22:54 -0400
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wPNDW-0000gF-NB
 for qemu-devel@nongnu.org; Tue, 19 May 2026 12:22:52 -0400
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7e5c85b47c6so436116a34.0
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 09:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779207769; x=1779812569; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lCm1V909eQzvanOLLp3AM+2hWgzt/YQUZTI+85aC+C8=;
 b=mk1TZFvfte3U9lRd1i4bbcFHyGcVXibLF7P6bLzT5SflunF2uBXY94HFhrWNtcCzPU
 bdDIONVMFVw5Tzm+X541h1Gw4G/6kJu/jT62qmV7vb6THRLX6s/jR+GQD6Dom0LA3tAi
 mPsTNHeXJiVc/ykj4IepkB2wuwiheYQVqnaFWsUGJQWoIjYvd4qQx1wqnqG7IavvSlCl
 SCAUBjBRWBTVql5OAxHK+PzOjgaUkMkndRgo9oED12TaxzVqP12bkRukdAZ4Y8M5M95Z
 LYRHfqRrKgxxw3V/tsSgJ9WhOi0qcTa88uJsHxbuhvNuUxt+dmUHbmCgexSjhCyTByVC
 HMeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779207769; x=1779812569;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=lCm1V909eQzvanOLLp3AM+2hWgzt/YQUZTI+85aC+C8=;
 b=OsnFCNz6EmEr+Dok4fu7myyaaHAE4nqT2KxXCA6hSOMueuOWxXZ1Mey9oLeDEDj4M9
 c6VCYVIwzFJW8r3nDF55G01Bxu3NUbtCGw5LMfeWk9UTmb7OE5W0DmsDGyG3otImsdcu
 3J7Bu19qsxW3nuCWLuJ2TLTdKqyPSQe389Op96Cy/q1G3T7C0a2V0uPuaMmdgZbGqfQJ
 bKznqyKL+WiK/5PHJx0bMRzmgT2R4wqVEUZFngxcjNPqMekkehEe2lrSIBlEBCKTWZUD
 UDS+QR2n1sYSI0Kerog4+36Du668119W9wCS63mh5ZVdeWZ21IvaSYMt8bYWL6vDdbYF
 alMw==
X-Gm-Message-State: AOJu0YwVaVsCpMtOtWxkGWk5wiMespuLWtAqZj+xvidh213l/tTs+OV2
 XJO8uL2oBhiFPfmU0CbPOTnUyZSqoVVBEm3BQLfgbGX36cq1tFwQgBoo
X-Gm-Gg: Acq92OEZf2LUOkdvIWAqtQz7n/+STw7nU6Iu4/1wA7VIKiPM3G99tfYWTjqIaLCu6WL
 Y7qQUBEDvQlsA6Dakv6dzCO7ABlCPFOIhIcBSRRVVaRRkijBb5NBk9tyrwZPeapAWoFVB2gwV99
 bMNCTuOQpKPyKCC+e60L7WTWZiJelOiy37oVD0YylaLrrw0zfJYvySLe5sUqR2G8QcukU0vxVnw
 h3zoumHgqfZlgVWxocnYKnRqvYuRkg9flUS5zz73PMCIxU3/4U2f7iXzi2ld8piQIN3OtJvtNWg
 55Se4zyLjjtfA6MZig72OG3bliaeFxvMZOOWjISDHhfvhL2QEQNphMs6tbQIFyLeT+lf8bpp1I+
 RG2q0pA0sPNJQb//jni3/l6aZC5bMrhATwdqRqDQkTgBpKnNYerlU1Y79fwp4C1reT4WfaJkoSp
 DG/EXBSo8gRclJ04qYMeYukTPFKq412gwxc25XcP9i83Hm2Mz3FonxkXiMtAYOEHGemBASfUnHr
 7TxYQGlWOSiIisw++qxiF9dYhjZ/a8aSSEDcOjHDFV8zjaLzkIDzlfO0lakU4KNilZO
X-Received: by 2002:a05:6820:1625:b0:694:9d3d:e040 with SMTP id
 006d021491bc7-69c94367940mr12066616eaf.31.1779207769012; 
 Tue, 19 May 2026 09:22:49 -0700 (PDT)
Received: from mac.localdomain (184-96-146-19.hlrn.qwest.net. [184.96.146.19])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-43a95762ceasm7056296fac.13.2026.05.19.09.22.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 09:22:48 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 19 May 2026 10:22:16 -0600
Subject: [PATCH v9 14/40] tcg: Optimize INDEX_op_mul[us]2 for 0 and 1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-mips-octeon-missing-insns-v2-v9-14-d7dd735ecddd@gmail.com>
References: <20260519-mips-octeon-missing-insns-v2-v9-0-d7dd735ecddd@gmail.com>
In-Reply-To: <20260519-mips-octeon-missing-insns-v2-v9-0-d7dd735ecddd@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::331;
 envelope-from=james.hilliard1@gmail.com; helo=mail-ot1-x331.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Richard Henderson <richard.henderson@linaro.org>

Zero operands produce a zero high and low product. One operands produce
a copy of the other operand and a zero or sign extension in the high
half.

Fold those cases during TCG optimization so wide-multiply idioms used by
target translators can collapse before code generation.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

---
Changes v7 -> v8:
  - New patch from Richard Henderson's v7.5 multiplier rework.
---
 tcg/optimize.c | 92 ++++++++++++++++++++++++++++++++++++++--------------------
 1 file changed, 60 insertions(+), 32 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index b1abec69a5..a42ab16fb4 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2173,45 +2173,73 @@ static bool fold_multiply2(OptContext *ctx, TCGOp *op)
 {
     swap_commutative(op->args[0], &op->args[2], &op->args[3]);
 
-    if (arg_is_const(op->args[2]) && arg_is_const(op->args[3])) {
-        uint64_t a = arg_const_val(op->args[2]);
+    if (arg_is_const(op->args[3])) {
         uint64_t b = arg_const_val(op->args[3]);
-        uint64_t h, l;
-        TCGArg rl, rh;
+        TCGArg rl = op->args[0];
+        TCGArg rh = op->args[1];
         TCGOp *op2;
 
-        switch (op->opc) {
-        case INDEX_op_mulu2:
-            if (ctx->type == TCG_TYPE_I32) {
-                l = (uint64_t)(uint32_t)a * (uint32_t)b;
-                h = (int32_t)(l >> 32);
-                l = (int32_t)l;
-            } else {
-                mulu64(&l, &h, a, b);
-            }
-            break;
-        case INDEX_op_muls2:
-            if (ctx->type == TCG_TYPE_I32) {
-                l = (int64_t)(int32_t)a * (int32_t)b;
-                h = l >> 32;
-                l = (int32_t)l;
-            } else {
-                muls64(&l, &h, a, b);
+        if (arg_is_const(op->args[2])) {
+            uint64_t a = arg_const_val(op->args[2]);
+            uint64_t h, l;
+
+            switch (op->opc) {
+            case INDEX_op_mulu2:
+                if (ctx->type == TCG_TYPE_I32) {
+                    l = (uint64_t)(uint32_t)a * (uint32_t)b;
+                    h = (int32_t)(l >> 32);
+                    l = (int32_t)l;
+                } else {
+                    mulu64(&l, &h, a, b);
+                }
+                break;
+            case INDEX_op_muls2:
+                if (ctx->type == TCG_TYPE_I32) {
+                    l = (int64_t)(int32_t)a * (int32_t)b;
+                    h = l >> 32;
+                    l = (int32_t)l;
+                } else {
+                    muls64(&l, &h, a, b);
+                }
+                break;
+            default:
+                g_assert_not_reached();
             }
-            break;
-        default:
-            g_assert_not_reached();
-        }
 
-        rl = op->args[0];
-        rh = op->args[1];
+            /* The proper opcode is supplied by tcg_opt_gen_mov. */
+            op2 = opt_insert_before(ctx, op, 0, 2);
+            tcg_opt_gen_movi(ctx, op2, rl, l);
+            tcg_opt_gen_movi(ctx, op, rh, h);
+            return true;
+        }
 
-        /* The proper opcode is supplied by tcg_opt_gen_mov. */
-        op2 = opt_insert_before(ctx, op, 0, 2);
+        if (b == 0) {
+            op2 = opt_insert_before(ctx, op, 0, 2);
+            tcg_opt_gen_movi(ctx, op2, rl, 0);
+            tcg_opt_gen_movi(ctx, op, rh, 0);
+            return true;
+        }
+        if (b == 1) {
+            op2 = opt_insert_before(ctx, op, 0, 2);
+            tcg_opt_gen_mov(ctx, op2, rl, op->args[2]);
+
+            switch (op->opc) {
+            case INDEX_op_mulu2:
+                tcg_opt_gen_movi(ctx, op, rh, 0);
+                break;
+            case INDEX_op_muls2:
+                op->opc = INDEX_op_sar;
+                op->args[0] = rh;
+                op->args[1] = rl;
+                op->args[2] =
+                    arg_new_constant(ctx, tcg_type_size(ctx->type) * 8 - 1);
+                break;
+            default:
+                g_assert_not_reached();
+            }
 
-        tcg_opt_gen_movi(ctx, op, rl, l);
-        tcg_opt_gen_movi(ctx, op2, rh, h);
-        return true;
+            return true;
+        }
     }
     return finish_folding(ctx, op);
 }

-- 
2.54.0


