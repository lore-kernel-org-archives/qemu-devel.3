Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50C33C5DF7D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 17:04:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwNCo-0007eH-LR; Tue, 18 Aug 2026 13:02:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wwNCo-0007d8-1A
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 13:02:30 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wwNCm-0004ph-ED
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 13:02:29 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-ca80d708489so1003364a12.1
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 10:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787072547; x=1787677347; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=6SRnGhlJ6x873gxevWnXJrkMCnx0Y6HHKAzPtz2nuUk=;
 b=hA/gCTz6MWdvCiSR0DgWVmk5jLTBztvOhO15lzjuDaBXYpNKqna+vx9Wnkn2uzEkqv
 8RB0a2fvRQxTASNx+L58i3AL9VtMTb8gUMbJ39rBMs8qCcPrrHD15ImGC1RsYpMb2hES
 MSYEEdWA+hzOI8zDJ/AWvLplRFT5zIi6RP1Ved67LTXQdElnZdxJolAGeCB42yt6zcCP
 ANzvHGKEYTOLhju7hxhII0JTyNghfaoGodbajn8S/ndevg/SOww5iXknwo4oB5RkNI/u
 EkC/dRfgCOELM2tnCe0iT0kum89xbitrkmuIxQZ/A0cNcXI7JjKuQN/42eU51z4f00+A
 NueA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787072547; x=1787677347;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6SRnGhlJ6x873gxevWnXJrkMCnx0Y6HHKAzPtz2nuUk=;
 b=pUp70WeLJCEsSveNMb9KefKCMnJA+U8iWUGfwD/uIj7Wp0mVD9+dhAMDZlr2luLpjq
 uJMUmXVKekQRqSzi0z7zngGp9WOf+JpHF3i12FE5oLYGNSG2tnUcPlwB+99A4MWE32GA
 6z6ctnthrUkkGNi1c3qIMRfPM00c+kuWRWMBU25KfUL1d5yEd0w3YTHLsIRZ5un/HigV
 igGekk1d6R31pCBzeULqjEYpPPa4l7Hf+9zt1z4O0fCZdUPCrFQJvXAUxpAq20C+1QcZ
 wAafPS33yTsI45VVDvOg6QcWt7HFWKeaYOYCEcyJddsE81PZH/mwJdODe8dNTRg1VurD
 bclA==
X-Gm-Message-State: AOJu0YyrzaT3ZOH1tmGKhw8nvYJ/BGwOYos5nHvgA1cPJYdwEtef4AXk
 rgkvHckxzSlTsUJprON/wQnNVT58lQL6eOZks7uPBj6ME+vrH8eTZXy3q+IhIAlnXgzTOFWXIr8
 YW98eaK4=
X-Gm-Gg: AR+sD12L4/40eYiykplm929BxJZBa5xKLxOo/pvlrXFltrBTolkeRoSlJEXLTlwL+D2
 TIOy6IoTtnIeCijUdahgFSaP+1M3gvz/pZKpUPBlMULd27J0CYOMp7iqi7BlvMP4Z3PPEq0p9Y0
 Sk5q0bEfPx2puvlo51yAztQuk1bnbSL2tl2la5U8yhdM5zOD7vvX0D114eoXUsN1N4vcTquPLQk
 EJuXR5kLkx7rOGlJq80ZMz/qa0jL3V+gQXApxF9InbuPTw6pPw3Pt3H3UyGvSTde3XwYIe6mvLZ
 eroutlxdUjVNR/+WyDJmU0DJterjwGFEO5V4K1syP14xc/Dkdh2bEl7qE7WlywZCvEkgbbI89Xr
 Khr7ggBidjEVK4Bt8wFGCnQ9eaEfxM4Oy3HvvZPst8y1Wm/JiwL0byq75FvXKCDnvgvTHykqIbv
 JdbIPYTNTAu7g9rwwwkiR8Y95qHqxCdAykan1O+wS/pQq1h9auvrlhzBSG9yIcg5r9Ukj703yRe
 6X3UO+SlSERB/JDueJPXbqGUbDES0JGYF8=
X-Received: by 2002:a05:6a00:10cf:b0:847:9dd7:2683 with SMTP id
 d2e1a72fcca58-851bc380e98mr7772143b3a.9.1787072546872; 
 Tue, 18 Aug 2026 10:02:26 -0700 (PDT)
Received: from stoup.. (c-73-181-156-132.hsd1.wa.comcast.net. [73.181.156.132])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-851b401e10bsm2108314b3a.12.2026.08.18.10.02.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 10:02:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 24/38] tcg/optimize: Handle min/max opcodes
Date: Tue, 18 Aug 2026 10:01:41 -0700
Message-ID: <20260818170155.1907006-25-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818170155.1907006-1-richard.henderson@linaro.org>
References: <20260818170155.1907006-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x529.google.com
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

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index facf4c1e0f..d291c844ca 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -597,6 +597,30 @@ static uint64_t do_constant_folding_2(TCGOpcode op, TCGType type,
         }
         return (uint64_t)x % ((uint64_t)y ? : 1);
 
+    case INDEX_op_smax:
+        if (type == TCG_TYPE_I32) {
+            return MAX((int32_t)x, (int32_t)y);
+        }
+        return MAX((int64_t)x, (int64_t)y);
+
+    case INDEX_op_smin:
+        if (type == TCG_TYPE_I32) {
+            return MIN((int32_t)x, (int32_t)y);
+        }
+        return MIN((int64_t)x, (int64_t)y);
+
+    case INDEX_op_umax:
+        if (type == TCG_TYPE_I32) {
+            return MAX((uint32_t)x, (uint32_t)y);
+        }
+        return MAX((uint64_t)x, (uint64_t)y);
+
+    case INDEX_op_umin:
+        if (type == TCG_TYPE_I32) {
+            return MIN((uint32_t)x, (uint32_t)y);
+        }
+        return MIN((uint64_t)x, (uint64_t)y);
+
     default:
         g_assert_not_reached();
     }
@@ -2101,6 +2125,16 @@ static bool fold_mb(OptContext *ctx, TCGOp *op)
     return true;
 }
 
+static bool fold_minmax(OptContext *ctx, TCGOp *op, uint64_t bound)
+{
+    if (fold_const2_commutative(ctx, op) ||
+        fold_xi_to_i(ctx, op, bound) ||
+        fold_xx_to_x(ctx, op)) {
+        return true;
+    }
+    return finish_folding(ctx, op);
+}
+
 static bool fold_mov(OptContext *ctx, TCGOp *op)
 {
     return tcg_opt_gen_mov(ctx, op, op->args[0], op->args[1]);
@@ -3258,6 +3292,14 @@ void tcg_optimize(TCGContext *s)
         case INDEX_op_sextract:
             done = fold_sextract(&ctx, op);
             break;
+        case INDEX_op_smax:
+            done = fold_minmax(&ctx, op, (ctx.type == TCG_TYPE_I32
+                                          ? INT32_MAX : INT64_MAX));
+            break;
+        case INDEX_op_smin:
+            done = fold_minmax(&ctx, op, (ctx.type == TCG_TYPE_I32
+                                          ? INT32_MIN : INT64_MIN));
+            break;
         case INDEX_op_sub:
             done = fold_sub(&ctx, op);
             break;
@@ -3273,6 +3315,16 @@ void tcg_optimize(TCGContext *s)
         case INDEX_op_sub_vec:
             done = fold_sub_vec(&ctx, op);
             break;
+        case INDEX_op_umax:
+            /*
+             * Note that 32-bit constants are stored sign extended,
+             * so (int32_t)UINT32_MAX == -1.
+             */
+            done = fold_minmax(&ctx, op, -1);
+            break;
+        case INDEX_op_umin:
+            done = fold_minmax(&ctx, op, 0);
+            break;
         case INDEX_op_xor:
         case INDEX_op_xor_vec:
             done = fold_xor(&ctx, op);
-- 
2.43.0


