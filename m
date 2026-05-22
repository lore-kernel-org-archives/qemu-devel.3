Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50948CD5BB3
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 05:23:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQIJ5-0002SJ-J5; Fri, 22 May 2026 01:20:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wQIJ0-0002PP-7R
 for qemu-devel@nongnu.org; Fri, 22 May 2026 01:20:19 -0400
Received: from mail-oi1-x229.google.com ([2607:f8b0:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wQIIx-0001mB-0t
 for qemu-devel@nongnu.org; Fri, 22 May 2026 01:20:16 -0400
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-484d3c0855aso2756215b6e.3
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 22:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779427214; x=1780032014; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=JKF4Q/fd29mnWV/NByXIaIABCsq7UsmokkILVWMv7cY=;
 b=qu4K8T4UJUX7S5pmE6iCMWveT2hzCDifbUUyCA/e9jh7gow/8PtF+McCOsxeFam946
 leWGQTK4F4OgVXSbC9Hw6PUqAnFL5+Bk9A3YZgc44it5kNK7lgm4x+etLXYkjco9LJbk
 jJ+4plplVBzyAVHlV7jmG5mDVBWddw6dYOmxS75LuPGVJHmqL/DpaWn4AlVkohVJk3+C
 CmuspGnKQXo7sXC8jQde+W2vrChmecBMSElsqEfhxqtLmhHi8aHp0qSFWtfZzFtmG3Ab
 QBcDz7kTUhSWV3eg3L2XxI1uk+9hXM+JjfPJvFSgSNqJkwbAtwpRgQtsnwAs8DaeNngx
 X3dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779427214; x=1780032014;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=JKF4Q/fd29mnWV/NByXIaIABCsq7UsmokkILVWMv7cY=;
 b=kSroQBAU5PZaAjb/JrHJHKWRmKFLhTnr+x+iQwnC09MLvc+1o4OEKhasTa/4jXek8g
 wNc60BO6FW0gWJ7CrePnVswZXrdlEs7jKwdfrJ3ZuuvOw1B3KEeAIpqsFO2WmAI6YcbZ
 NsuoirjjPZ8LPYGf3Q6MZ2V9teHw3u2VWbDASvSKOiQHxuk2dPUbMDUejm9o8PRtC7qs
 MzvmnAoKpIEQlJ6A+Fu7+gLlrLPDMyzA+wTKrhCBMfiROhjGQajcBN/hQdLCKlakDEMu
 +olS4bdgnCV6nvOJVejSUbCFcWy7MBRTbFf97kUNaM4MGNOBt4/lRB7+Eql3zgOeurML
 rF5g==
X-Gm-Message-State: AOJu0YyNF+RPV/NA6wcSS7O+UECkBsloGWp7oz+TwsU9IbqhR1vRN9Cl
 gUaquhE21ZjhrJLYqWcxan30B76l+RASyUtPVXo85wiJIoWXWcJ7431u
X-Gm-Gg: Acq92OGX0AVJFfzjJV+KhVMP0qXRvN6hwZLSyX3SHLWEwwLKAX/Z0jiW/O4MaYQVE95
 ISH316gRgJpE+lmSV4gx2HtSeOyGpHSu1145vrDNFjXMvvmLXCb6V/IJp2n5BhOiLIqAK7bC/IM
 nPPAPjB3zNeR4cyAy1ONa3rw3QBk+SfKnDvhS36L6wcKl7VW9KHa6GfCno7OfEyrGlV6k9EPBb4
 B2MUfL9W3Rdi7qErLjsXY4eryjMIN67NUZxoY1OkNgre2vPc7DE9TbAkOGZIiPDjn8IDg4XM1QZ
 SkGHjeQ9Q1C3Olx8yZdx3FxVPmaLRvAHejNGow7tELJh1zu7XhXSWREfJKarqPVU2dKVjoPM33f
 OpcCfFEfddF0QX5Nlx1VFxKgzAz9jO2XtF7/ZHbdO9HAgxoGjVhUVGXZZf4Tugf2tRVb8fO7htP
 nn8WZp55Jm3vFi4SUfkwt6guZTtUUbuDDy+Db3PBfr+GpCQzf+E/Bw/tnHwBJXrKPHwEty03SZA
 w/yp41Wkw8cAOF1eehIqDlRdGP2/2C86cWiPuUu7uyAs5d601jgiggKHJHFoXDT+kXZfGVu1RVB
 ZJOMs6RwbF1UKA==
X-Received: by 2002:a05:6808:23c2:b0:482:6b8a:33a6 with SMTP id
 5614622812f47-4854a279b51mr1462253b6e.23.1779427213687; 
 Thu, 21 May 2026 22:20:13 -0700 (PDT)
Received: from mac.localdomain (184-96-131-78.hlrn.qwest.net. [184.96.131.78])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4855476ab77sm59690b6e.17.2026.05.21.22.20.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 22:20:13 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 21 May 2026 23:19:43 -0600
Subject: [PATCH v14 01/22] tcg: Optimize INDEX_op_mul[us]2 for 0 and 1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260521-mips-octeon-missing-insns-v2-v14-1-fbf08e164830@gmail.com>
References: <20260521-mips-octeon-missing-insns-v2-v14-0-fbf08e164830@gmail.com>
In-Reply-To: <20260521-mips-octeon-missing-insns-v2-v14-0-fbf08e164830@gmail.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::229;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oi1-x229.google.com
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


