Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 975E4CD5BAA
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 04:40:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPYgc-00018p-8t; Wed, 20 May 2026 00:37:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wPYga-000184-V9
 for qemu-devel@nongnu.org; Wed, 20 May 2026 00:37:37 -0400
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wPYgX-0003ne-EL
 for qemu-devel@nongnu.org; Wed, 20 May 2026 00:37:36 -0400
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-4824176bbbeso1442382b6e.0
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 21:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779251851; x=1779856651; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=JKF4Q/fd29mnWV/NByXIaIABCsq7UsmokkILVWMv7cY=;
 b=XQxm7A3KU+dsN3f2tXFf51mNiIXDabnuTcezzZb0COK8IX3dlXSL1xVidNB77gMGoa
 6rM/C/uO9zNGZbWDtome1IX4fVH7x8K9maHizLJRRgOE7nsUG5rdxKJJJFF0k05sBvZE
 YHvAYzr8b6eeDvSGq5C4pmfR2bq1uUw7l+F45E02zuBAUcOU+pTFRD0DxdE3NMYEaQF9
 /ZRAA5WvzdVRUutR22GL6+3/6/ao4d5bEaYVd3CAvwtG/9Iiru2OcOlvSQrcAgKa6qIt
 ze7MDsF5/17CPiaCFtqr9NHAbeAJv//aNacbbxLAxgRLsHS1Xqx0Eqj8j/fE1V/4J9if
 6KHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779251851; x=1779856651;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=JKF4Q/fd29mnWV/NByXIaIABCsq7UsmokkILVWMv7cY=;
 b=Kyqxcgp2g+tY2lbxeNjigrJuYIs+JSCuUcX/BTtJtSqW4XJoZZ2klTD3p/PEgyFg2s
 AT0DKZtkq099u7KcSrxhJDmnnyyx/v4JrpEpo9+jCDiwHDoUpmyNLyj4K90vB10LAwM2
 wVJzJx5VjWnJ6VG37FRYhv/LIPVA/Vg0kRIR2xlfiUVrs1QSCz/fzFXfSt1BDac7EWb6
 Ca+yD95LFY/jeVTgpqFSsUlsXzdwmfgZJcyjzodV1/RU5a3QXe5rrOBvYwiH18jcP7Qe
 0/daU3Un+xlAtnY3s4cay/Rzt3/1ynJdRth6KQvB2y9WLiYWv5nrIiM3EJi6+atRmKrg
 yC1g==
X-Gm-Message-State: AOJu0YyzJvXzIedCzqZZqGsegC6xkfjzKqK0oHqs7MHnDkiI4kR0RX2l
 Hn2WO11YEuEhHMJt0Br6jRJSZ10Q30MRzZit1dhgdI0U42npnFIovP8U
X-Gm-Gg: Acq92OFMdaVAc4ZtEKttn/5rjA5oh38E84mT7Hl5r6jVARGNW5Y3o7sSZJX8C1vMw++
 nJoVWpkd+qsVX7HDxExXox5MCUgBZXE/v1eXxMZiqKUL5fjq/DQQ8f+2ozVmK/nNdom+xFhIOa9
 wFBJKacfF5OFvYF5y6kmtPIPI1DOqUWb72Obhp/mehIV5R3z8zAmiTQBGmYMLN/iPDBq65DXeyX
 ccFu18WFViNlMEJhSERdAR+g9hxy/17zN3As7Gotr/hiJkrttjS3vzPLCt4b6LO4rbRQHiuSKtB
 8WU8+BijhB5T43TjB0wjr93vEekHJsqDIGuyQY6scOFAmSASxSNGRdoXaJBaLBionykPJ7WdiVZ
 AW8a2W/WpO08GY7FDmnBAoK+ZdyBmg3DUw+bY313QCg6Y/wmISFcuul6EfWoLTX8YClUvQFzksy
 bE/Kv6BnXlDdCreXM5cDM7rm3LLRqBOXVpiShhl9Xfgpg14y6t7yjTOZqwM/otRaDuZgqK4E+pz
 cQrZ2iMJWeMAYY0kHclYNiAqlNcy0wc058hkC7YRcok2FLNzdoxZmW0IwC4hETBkkLa4zG8Wbmr
 xdmrVZ6n8Fkl0g==
X-Received: by 2002:a05:6808:1381:b0:485:50b:f585 with SMTP id
 5614622812f47-485050bf945mr3042091b6e.42.1779251851141; 
 Tue, 19 May 2026 21:37:31 -0700 (PDT)
Received: from mac.localdomain (184-96-146-19.hlrn.qwest.net. [184.96.146.19])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55bc4f04fsm11574634a34.27.2026.05.19.21.37.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 21:37:30 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 19 May 2026 22:37:08 -0600
Subject: [PATCH v10 14/45] tcg: Optimize INDEX_op_mul[us]2 for 0 and 1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-mips-octeon-missing-insns-v2-v10-14-306f9edfe15b@gmail.com>
References: <20260519-mips-octeon-missing-insns-v2-v10-0-306f9edfe15b@gmail.com>
In-Reply-To: <20260519-mips-octeon-missing-insns-v2-v10-0-306f9edfe15b@gmail.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::235;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oi1-x235.google.com
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


