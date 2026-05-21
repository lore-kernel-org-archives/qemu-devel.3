Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F19F3CD5BAF
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 18:07:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ7mq-00009k-9R; Thu, 21 May 2026 14:06:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wQ7mo-00009V-Oe
 for qemu-devel@nongnu.org; Thu, 21 May 2026 14:06:22 -0400
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wQ7ml-00021N-Sr
 for qemu-devel@nongnu.org; Thu, 21 May 2026 14:06:22 -0400
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-7d4c383f2fcso5599107a34.0
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 11:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779386778; x=1779991578; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=JKF4Q/fd29mnWV/NByXIaIABCsq7UsmokkILVWMv7cY=;
 b=WSwDWG1ev37VguntIrpg4cNFNtXGKUZ7mdc/cAGJDysycIV/YNcM4JJDAPsS/p5Nlc
 UXvj3acvwKP/yuqfdVqqRvMwUZjT++GtCTKdpV5ucw05MWtHruO1MSUclehvoCvNh1y1
 OvIDOpupSH55uhaMbxR3SGhqTdzsAdqFoTiYOBpueCfHg2NHHj6weapuq3wFS0Svtrda
 AQvVnm0w2g2q9/j4ixNvQSO8uDKvWhnPJ8PqTIvO6RKfvgczabYLWmXF78jksCoWuPzQ
 GamYR42AKPBZ7IbXAg9K6PG/cQVnPHUJmBFduGPA6o7siI+YmkHHYpXDgXZnGEx+4hNu
 08uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779386778; x=1779991578;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=JKF4Q/fd29mnWV/NByXIaIABCsq7UsmokkILVWMv7cY=;
 b=qvtw7A2vvx05pqQlCgTv/FVUnnQ1r6bVKZIMJIlqaTDESMk5ULqXgRAR5aH3tyXIXi
 yPXukj1AWKU3olF2IEZf4ijBWN7+5/wtI2pVQKmJjSkz+FwNthCz/24vtNcHWmTc0g0j
 6o6pyGLGtgShWeJ6KgGJluYp9m2L7vjHH6wZjz4cZKRFDXz6Hyfo5wVynThAQ3cA97iM
 GDKhIxnOyT1Q942nxjNVPjjcWU0XPbIcrhyCnpbvHrduKBF86bhQHTZBwmyHneU+h5pl
 cvK0GgJL6ikzwUdaY0Qm/cR11Y1Yiq6Idq48bt/DCEdbDFaeFndl1eIwVGn+idOeKToT
 d0CQ==
X-Gm-Message-State: AOJu0Yx3N6bKYaRb/m8TaFvAYT/jQOQnwA0UyuLv8LTM2kiJHYeFXp+n
 WAY9s9LMsqEZDRpgcaSqlg2aX9zW7ibCPghG0DKC/VjLdz6Rp7wGXo4x
X-Gm-Gg: Acq92OG/QHj1GBIsaLdKST+o6O2KY30Cyskp38KddT9Sf1+r8fLU8jXcCchYaWZZYgg
 NQlc7P8sKZe/TgPhjHKZuDI1vtEkuH9GNxVdUfgUcJ/jj4KmEbNCoSw/IF465e8KrO7g+V9haB7
 Z5PiPrSTaHIV45E3BO6NSq4fAkWum17rMZVmf7vcGvlE2lm+PpxfFfPjSV0lvjYvZUEEgsEAC+K
 v1Wzpfqjd/5O/YvYV6mHEwEU5nVHzV//dHwsQr35YSXXUM3ScVVBHjQfGpipTgQL07QLFXgU7Sr
 ZCK0jZH18Qac/X/HONwvzgH4woqWJk+8jzImoJVsf0JGNUz3V4cievbhuEJoo88wl+fsxuNAc1+
 qJcjWuwrlcMUZsyxW5FwgekLGubpOw6MSob4Yg75SPPyc0WagjPRzTf8mZePvFHyd0Wy1ELTp/Y
 /CSP4eGlVX3o2BI9zyji8MhYerFwDtOja5RtEzIrM0rQu0HNVuwf5mY/v2OCGrQhRzR8PTsnQw2
 wLImyi25ZBtDHWDCSRYSI8Xg8ZOY7Jgb/Oa+R70uyEyBDzQG6ZHboUlaekocOXcFv1d6Bo0qJo4
 beg=
X-Received: by 2002:a05:6830:3c88:b0:7dc:d967:63de with SMTP id
 46e09a7af769-7e5feded159mr171189a34.3.1779386778379; 
 Thu, 21 May 2026 11:06:18 -0700 (PDT)
Received: from mac.localdomain (184-96-131-78.hlrn.qwest.net. [184.96.131.78])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e5f6ee286fsm903089a34.25.2026.05.21.11.06.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 11:06:18 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 21 May 2026 12:05:54 -0600
Subject: [PATCH v13 01/22] tcg: Optimize INDEX_op_mul[us]2 for 0 and 1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260521-mips-octeon-missing-insns-v2-v13-1-5a4cb8ec9cd3@gmail.com>
References: <20260521-mips-octeon-missing-insns-v2-v13-0-5a4cb8ec9cd3@gmail.com>
In-Reply-To: <20260521-mips-octeon-missing-insns-v2-v13-0-5a4cb8ec9cd3@gmail.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::336;
 envelope-from=james.hilliard1@gmail.com; helo=mail-ot1-x336.google.com
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


