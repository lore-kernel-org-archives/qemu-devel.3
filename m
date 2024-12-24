Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC1DCE7718D
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2024 20:07:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQBB2-0004kO-Ou; Tue, 24 Dec 2024 15:06:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tQBAC-0002uo-UE
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 15:05:57 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tQBAB-0002cu-Bu
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 15:05:56 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-215770613dbso41197775ad.2
 for <qemu-devel@nongnu.org>; Tue, 24 Dec 2024 12:05:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735070753; x=1735675553; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8qWTPWB/56xfTTsmE3Xx4A/juxFvaZTioQPwMgdB9OQ=;
 b=Ietb1wX8M8okc9D4fxzI64eMDaEgBb2ZkFENW/o8wSE+iix8ijO3YqhAB6xe83gPGN
 hj+PL8V8y0rxk86/1Sd9vFGKzqj6yms0j3mi7SYyzb4Yq7tg1rnLyJGeFL5F/TT7RDBC
 gIdynvtCa1h0w34yeHVPUjXYw71yZcHmvdmyoaYWuX4yo15NIkaMAxorPjyXlPnZWZxp
 WarYdPKGDMTEDYJVK2WuJoM3lriVR15R4nYeEKu9eULOoAwHKu5i8SuIgQA75skkuTlV
 W2TtHwYrPJ2Og2TLOd02/cYXfJUMWwBxMQinI9ltUliMnMKjrQGJKQUP9Vdm/nCT9/M0
 4fTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735070753; x=1735675553;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8qWTPWB/56xfTTsmE3Xx4A/juxFvaZTioQPwMgdB9OQ=;
 b=Tr3YzTRGggNBWt2teifUYkfSjGPZVhs1Jbvg+i+AtBNmhPSLq7oJcIs0W2JUAAyAO+
 8WXMEpH6Z+vJj3U7D3viRO/eLueEUEjrflvugJF9AT+nWilRrUhXZfU2jqXL0PI0XcDc
 aJRql7G9BRahNKQEpekYLtHZCA7RjvF2OXykkkx+WOn33zlLm8HcShWXiBWAGbnKTecN
 oyn45NUtqyHqCTJ8o9P0Rt6aDgY/ILZrlrjMqrBpkwz1ISmahCTqOKrt0UcAhBHBMetz
 Oung5pdmszFZibgnQC9cTrgXbGh29diXYYOWx/bGl4+Tmb0jU6IIS7yO2aja7EwWGc3J
 k4tw==
X-Gm-Message-State: AOJu0Yym5dwBgkYL5ep3IZCJOPaN4V+wpGfKEWQzJ0eVq5GFlrje9PIM
 msMRrZ3Ig8FSQlYz+Kb5H32uQK3XJ0A7btotDbPkOD+hTkCAM15HmbDW1/+pAbeug+E6kPaSsvf
 MRD4=
X-Gm-Gg: ASbGncsif1J9Pb4AGTRdR7UtwOU/qS4gNGCPNrj6ckhLziq18qMgXT2LX0WOlICsGLw
 1KxvoYe5enFadg+d4kMpijtuvkyAyNmAiw6ujaYJxFpWKsWjRb0MsofA1yhWCizl+8lvRYQ6TS9
 tPkgasj2Em3gckelWdFMPirZoCO8fieV8sNCUCCBY1rCeNMmjx6Q1i03uFGEZfMMrvTpIkJx244
 nFH9GmRHTQz9DUrL+ectYUnOa4YcJnCDEpeFOWCKT04vNz/b4enutGrYApDiRXzg2cVzSpTt7S1
 Cbsa5juTd9zU7sURSESjydCWHA==
X-Google-Smtp-Source: AGHT+IHEEBVpTCHCpszNFb3tbvhdsU5xyFfSRvDZ9LK+sELMDBEb3A+dhf+ho9q7Z5x9SOq2ijJcfw==
X-Received: by 2002:a05:6a20:c705:b0:1e1:afa9:d38a with SMTP id
 adf61e73a8af0-1e5e0447f45mr27489075637.1.1735070753476; 
 Tue, 24 Dec 2024 12:05:53 -0800 (PST)
Received: from stoup.. (syn-156-019-246-023.biz.spectrum.com. [156.19.246.23])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8fb895sm10027159b3a.162.2024.12.24.12.05.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Dec 2024 12:05:53 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 33/72] tcg/optimize: Use fold_masks_zs in fold_qemu_ld
Date: Tue, 24 Dec 2024 12:04:42 -0800
Message-ID: <20241224200521.310066-34-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241224200521.310066-1-richard.henderson@linaro.org>
References: <20241224200521.310066-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

Avoid the use of the OptContext slots.

Be careful not to call fold_masks_zs when the memory operation
is wide enough to require multiple outputs, so split into two
functions: fold_qemu_ld_1reg and fold_qemu_ld_2reg.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 81ed26a376..7bd17a36c7 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2110,24 +2110,33 @@ static bool fold_orc(OptContext *ctx, TCGOp *op)
     return fold_masks_s(ctx, op, s_mask);
 }
 
-static bool fold_qemu_ld(OptContext *ctx, TCGOp *op)
+static bool fold_qemu_ld_1reg(OptContext *ctx, TCGOp *op)
 {
     const TCGOpDef *def = &tcg_op_defs[op->opc];
     MemOpIdx oi = op->args[def->nb_oargs + def->nb_iargs];
     MemOp mop = get_memop(oi);
     int width = 8 * memop_size(mop);
+    uint64_t z_mask = -1, s_mask = 0;
 
     if (width < 64) {
         if (mop & MO_SIGN) {
-            ctx->s_mask = MAKE_64BIT_MASK(width, 64 - width);
+            s_mask = MAKE_64BIT_MASK(width - 1, 64 - (width - 1));
         } else {
-            ctx->z_mask = MAKE_64BIT_MASK(0, width);
+            z_mask = MAKE_64BIT_MASK(0, width);
         }
     }
 
     /* Opcodes that touch guest memory stop the mb optimization.  */
     ctx->prev_mb = NULL;
-    return false;
+
+    return fold_masks_zs(ctx, op, z_mask, s_mask);
+}
+
+static bool fold_qemu_ld_2reg(OptContext *ctx, TCGOp *op)
+{
+    /* Opcodes that touch guest memory stop the mb optimization.  */
+    ctx->prev_mb = NULL;
+    return finish_folding(ctx, op);
 }
 
 static bool fold_qemu_st(OptContext *ctx, TCGOp *op)
@@ -3012,11 +3021,18 @@ void tcg_optimize(TCGContext *s)
             break;
         case INDEX_op_qemu_ld_a32_i32:
         case INDEX_op_qemu_ld_a64_i32:
+            done = fold_qemu_ld_1reg(&ctx, op);
+            break;
         case INDEX_op_qemu_ld_a32_i64:
         case INDEX_op_qemu_ld_a64_i64:
+            if (TCG_TARGET_REG_BITS == 64) {
+                done = fold_qemu_ld_1reg(&ctx, op);
+                break;
+            }
+            QEMU_FALLTHROUGH;
         case INDEX_op_qemu_ld_a32_i128:
         case INDEX_op_qemu_ld_a64_i128:
-            done = fold_qemu_ld(&ctx, op);
+            done = fold_qemu_ld_2reg(&ctx, op);
             break;
         case INDEX_op_qemu_st8_a32_i32:
         case INDEX_op_qemu_st8_a64_i32:
-- 
2.43.0


