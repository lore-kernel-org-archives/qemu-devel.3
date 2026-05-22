Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B7E2CD5BB0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 19:39:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQVfx-0001cJ-92; Fri, 22 May 2026 15:36:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wQVft-0001bR-RT
 for qemu-devel@nongnu.org; Fri, 22 May 2026 15:36:50 -0400
Received: from mail-oi1-x236.google.com ([2607:f8b0:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wQVfs-0000Qm-71
 for qemu-devel@nongnu.org; Fri, 22 May 2026 15:36:49 -0400
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-485462d9290so1117007b6e.1
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 12:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779478607; x=1780083407; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=JKF4Q/fd29mnWV/NByXIaIABCsq7UsmokkILVWMv7cY=;
 b=JBzSutTmtiZCrbQyQ7nGUbNw53s0dnEPfG7s/DXWjXZ644cIVVbYH8fJKaWwEhQIOi
 DjuZOYiAzGkqiqmqs+KcB03aEpcPRMFTsw+UkZS2yAh6+dgqy3tTEnJ58sKA35dZHPcQ
 d3jU7BudbvJdu+jqt0y1RbEuAFXsbCcW0m4L9iCBudbBY3yZzW3945uuRoCMa5lRDwGE
 EgoJsQPLaXaYwpbptBLH0RhVgUgA8wIImPBoboX799Sm9rPhWDkIZiNQcZtSItBxbB+Y
 cWN4zVl+TCVfgZiDpyosgBUOvI/tRoMS9SMOuaWSJOmqG3r4bQVY+vpDzHGGE+JJ02Xs
 1zWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779478607; x=1780083407;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=JKF4Q/fd29mnWV/NByXIaIABCsq7UsmokkILVWMv7cY=;
 b=Cfw9yJZrvS4hN0A58rNRBE2u9sItnMWo6ZIEGjk28/rEKwfWUGWF/6B3wvChHkaKJU
 JJGrLzaFDCayDYFIZFBM+jakvi/12vBurh+GIqnaRmdutfHdKhOI5v0rvGQFrphLHr86
 ZOofeiD7fA9cnYjknMWjnC0OCXXIn3PKOGY31kaplMhu4PoBefriKjicTk4rJpikVJpc
 1UasC8ZKE3B3cOlHHks47BG4P1nxt9TceAiolIS3PHjUhlv12nmUiTdAWJPurFZWjEk9
 EjZctzFG+q1eQu4e/lEC2Vi5jGzhF3Wp7I4tKpQ2VV9MbpUqj2MmzPXBimB2cRGU1gTs
 8hPA==
X-Gm-Message-State: AOJu0YwWVif0RdNFDtMg9xgzfdixeElp+0x583VBz0Jqcrw3d0P04gPd
 D+2Ip/iwZLeQqzu1VwOi/tBqsZS0ifTVD/RqcQdgt/ZIe5ftBdIxkWbv
X-Gm-Gg: Acq92OHAoDpsM+qA0t+NYGNQmdMyXtlUqTGz+2g7JQg8+8WBUU62XLeK6wkn5ntJ4CX
 3ZUD+PwfrxVOUT7RQWhcB9g44CEXczTSI779b8uoJv/l83SN6LzBqER6AdQErGX3y5pP3+SbUPQ
 4pAMe73iVcyxitJtYbZsiNCNp0eYiSM+iE2MGrrmz8hA7vbNxj6Ih69k+/IuOgsnJm5HnxyAt6w
 Rs8cczNlfHSAM2RWzyMJfsnLol5SSZCTbbmFAfENtGNa/SIb9nnfZPbhFEYKDikb4UryaC6pBaV
 E1Nwb5ENnQ874l9t5ywagGCjqwSdbWi30a4BAxQyfKkB8kE/UDFW+jA8GLcHD6nhsgKJH5TSKYk
 9e/i4Pfrs9qyMxop5PusYCsri/Xr9PidDKdRu5K97K6gGfOuECrJkas5qkdRarqxjMFA6fmdU9T
 rem3Vv9Wvw83rY1Bx+6N0jXM/hZHoiG0um8salj0FJZb9rrcscoVHJPW503BjgElPw4xaEQgBeu
 KUTyV9MSr/wFVeNqEibrdS23BaZbpli5wRILQ6w5i1+vKTw4ltoe7/RrcBpsAM7/xymege/90AL
 PZs=
X-Received: by 2002:a05:6808:4fe5:b0:482:e9e4:9e8 with SMTP id
 5614622812f47-4854aacdaeemr2216741b6e.1.1779478606981; 
 Fri, 22 May 2026 12:36:46 -0700 (PDT)
Received: from mac.localdomain (184-96-131-78.hlrn.qwest.net. [184.96.131.78])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-48554757d5dsm995297b6e.15.2026.05.22.12.36.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 12:36:46 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 22 May 2026 13:36:32 -0600
Subject: [PATCH v15 01/22] tcg: Optimize INDEX_op_mul[us]2 for 0 and 1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260522-mips-octeon-missing-insns-v2-v15-1-f8731a588dc2@gmail.com>
References: <20260522-mips-octeon-missing-insns-v2-v15-0-f8731a588dc2@gmail.com>
In-Reply-To: <20260522-mips-octeon-missing-insns-v2-v15-0-f8731a588dc2@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::236;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oi1-x236.google.com
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
Changes v9 -> v10:
  - Restore the original constant-fold output ordering.

Changes v7 -> v8:
  - New patch from Richard Henderson's v7.5 multiplier rework.
---
 tcg/optimize.c | 92 ++++++++++++++++++++++++++++++++++++++--------------------
 1 file changed, 60 insertions(+), 32 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index b1abec69a5..fcdef25bee 100644
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
+            tcg_opt_gen_movi(ctx, op, rl, l);
+            tcg_opt_gen_movi(ctx, op2, rh, h);
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


