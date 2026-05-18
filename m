Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD1FACD4F3C
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 05:32:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOqZ1-0008Cq-Sp; Mon, 18 May 2026 01:30:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wOqY2-0006tt-6J
 for qemu-devel@nongnu.org; Mon, 18 May 2026 01:29:50 -0400
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wOqXv-0003UW-Lb
 for qemu-devel@nongnu.org; Mon, 18 May 2026 01:29:46 -0400
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-4824b15c19eso1752972b6e.2
 for <qemu-devel@nongnu.org>; Sun, 17 May 2026 22:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779082177; x=1779686977; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lCm1V909eQzvanOLLp3AM+2hWgzt/YQUZTI+85aC+C8=;
 b=M/7T3yuSLg6W0AzP1mwueO4cCNf6tKTeeY2I4p5xdMUAn1eQN3eu9RIyS9fjppljBm
 eOW+oXYJd0eSb0BO7+sQFvAky/4wiS23fOkmr9s8TB+MVDIz40GArYnURPntq0smdslO
 sWEEyWcV85D7JShj4duV/uR48SynDVu5j0CArXbn1xKONXA3QN/1551M4ynV4cu16JPF
 uTzPpLok+hQB/HuUL8XVpNU0PSwd6CZ6U+4LBe8YxHc4HZk770B4anGvcHrl+KuDGXIt
 1WTmRcMPdVQXB+cY51n+NbLwkJpdmXg+XPiCPCDenSjcAEXSXc09Rh3wXiI18A5EwNnZ
 zNEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779082177; x=1779686977;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=lCm1V909eQzvanOLLp3AM+2hWgzt/YQUZTI+85aC+C8=;
 b=LZmz7VUtbNvutQER5RMW85g0m3IJDAIS8WN9PPHEhH7DzNfori6iG8TAnoDkLH/dmR
 WHC/tFZ9zznDTUzBpvfqnxHiJXPhWW/WwpcMTZqoRVFwZOd1O77hmzmVPh3X1UGUCj1H
 RE0nhpEkpIqNgAMNSY8/HWpOdz5qY2kTQ508IMuJk4B1mHnpwgYk/zu6mD7YvK7xcEaj
 mzootdoNOnFU+R5wmanb1AB9D3pyRpRVkPtGLUUu5fnvB3ZfVv7cIM9cdjVLTTjOEKx0
 71KwO7vx6b+gzYgIAH8HsMCnxrn9avozVgM07T5gx/VYLr3ASaZqnJ4S3s/bIUH9a5l7
 KZxA==
X-Gm-Message-State: AOJu0YxRKb4JiKHpBMDrgUI1Lj67aXne3dy9yiX6zsEKlSlcJF/m2kTc
 xo1S1FAWyKHO7sYncyt9SR8/LabaSao59pQtLujqYQFz/xKSfD2O2cc5
X-Gm-Gg: Acq92OEH/fsKURPVBXxupItuVbBvrpcKU0jmmiL7ClXcxliPAgkLj17sxFwlcScseWa
 /5PEBj0I1q2zYEccfl3rB4GjvRpKEkmu5lHC0G1fxvxhhf9Gnepxbbt6PrdNHoqmXa3u3I+GD/c
 AyZExjssXtje/rcjSFOTu1Wx39HO+w8QITkCQpfTNEwmbja2BMs42N6lm/YHafRHaUQrX0gTXSP
 eEzZYI0lvh2zZ+MNH2C2CqTzfq38CSvcb91is43cLPYO+sk/YM5jE6Z1pjAfz17uYkLQSeqyjHI
 vQkAqPjmB8Qnz6TxaRYqa4SEHYXxUiunS3FZ/bNKfYl4QfK756b/rcKG0tLvtHIfOi8BfnB2P0z
 SbWN2ArEXL3tzU+fOE7kPjIvqDcvXk4b6pkFdJ83WN6Nlk0A9jrJui9CbPlImmlppCp3JHrnheW
 gH7tgG+SRZpmB0tGBlX4JNkEVRs+OVkTpoKD9twUCVPCSCC+0JEJt9wcyKlrfJagKEaOHfMbHxy
 AHrFlmvRHPJzgo00+W7CxmshE3l+EjaVkDRG4KcfGlg0b/hNQ9FggcsvbQ7xI7WxvL41R3zyGWs
 iheVHw==
X-Received: by 2002:a05:6808:67c8:b0:479:ffcf:52d7 with SMTP id
 5614622812f47-482e5bc27d0mr9303749b6e.46.1779082176801; 
 Sun, 17 May 2026 22:29:36 -0700 (PDT)
Received: from mac.localdomain (71-218-255-245.hlrn.qwest.net.
 [71.218.255.245]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-482ee5349a5sm4628357b6e.15.2026.05.17.22.29.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 May 2026 22:29:36 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 17 May 2026 23:29:11 -0600
Subject: [PATCH v8 14/35] tcg: Optimize INDEX_op_mul[us]2 for 0 and 1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260517-mips-octeon-missing-insns-v2-v8-14-206151ee77ec@gmail.com>
References: <20260517-mips-octeon-missing-insns-v2-v8-0-206151ee77ec@gmail.com>
In-Reply-To: <20260517-mips-octeon-missing-insns-v2-v8-0-206151ee77ec@gmail.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::22c;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oi1-x22c.google.com
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


