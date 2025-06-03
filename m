Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2809DC5AE59
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 08:13:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMMkM-0006wS-3I; Tue, 03 Jun 2025 04:11:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uMMkJ-0006jP-Qy
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 04:11:44 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uMMkE-0005tH-QP
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 04:11:43 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3a0ac853894so4976704f8f.3
 for <qemu-devel@nongnu.org>; Tue, 03 Jun 2025 01:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748938296; x=1749543096; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H0aoE+Pz39j8pYHji37eDW/+OJ5q4qy3VlkGMlCSnDM=;
 b=V736SSssRmJVHvnTLXiXqIuF+WnS3snbcThovtb753l0j14u1xqvbfLu8Ow4YFYmSN
 yJ7cTiyM6jqaxzV3SeiZzd3VQ5GWWE2FokfvJNnOCpmYBnhaMoUNZzxqLFtN+TeyV0i8
 esMMTI4ckiAyWsYoQCMjne2dZPxOr9RVcHU4y6JPqe0NxlHrHloK0S03IUUM6h1vCZBX
 OJyUWRru/XQcnvs0LmaSxLHf8iH5itaOu0QMr6MnGEccFXbxG1KzMzXaKTd3uDxVm4dD
 zSMklTOl0v7AnrbpQ7KsO+0J6yVOn0Ew4U2A5PtdAUEmn57zvDTWrEILq1CKtY5gIHxl
 hN2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748938296; x=1749543096;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H0aoE+Pz39j8pYHji37eDW/+OJ5q4qy3VlkGMlCSnDM=;
 b=VNAyxfB/7u05Mbe+ZfwBbJplE89pnwCmTWiGHibkr9/8R7rFkxgdvXJ8SGJjRHc7eo
 e0jaModfgs87FctlfXFnEZH/Rj09saRl+vy9H/kUmsn8ETRw21YD2aGPbSwAVGoeBDf3
 zAZU/nzcyLBEOHBPzKPSIoUbkp6NQ00dpkYCqHy+TiA0xDTXyTrj6Zdvx1dqAjKmmR1X
 J44zYPGy6JsGzvk9LgidQTzo6vtpx1RoulTFQBvHyKZeiJis5RXYwm/Xqk0VVwepxVA2
 /ZO6q+Bo4ZLQp0dkiytY0ut8lUrqcaWwgAB/AjzLhWeTqV4OQCwYRFdjvuEPUFLekeSE
 HB1Q==
X-Gm-Message-State: AOJu0YzROztyxUgMZfHo8ZegIsrgO2iGiG49hYXnwIcrMYx+sUTynJrt
 tWZJhfRGexKEat90Llwjd41GZsGBPXVpo47a5e2WdbPwO51f3Sjf2OSAJM8p8JFUJZucDbaYwaa
 j5UzMzQI=
X-Gm-Gg: ASbGncuMGOulNzG9cOFmiEuhof2+U+nHNzw7OoRazA/x+mTQ70M40OyoJ9Hlw4Ve1Wt
 KVJJmQjMLe7SnGCp79klt70e3fWn/fUq2PojB3cz5nVG+B3UeYnGh3WXyUXvSYgP+PDOGjHOflC
 1p1zJTaZFPqyMm0Ex3Gm/tFf2Sj7SttkZ92omDpQckgyUNe7V9+9YUiBrmBnIfguB5gbl7tPZzS
 NRFEY8oimSOX9zb9R2M25puUBDQuP/MKXnq1spFCQ93QfVrUw5CZCHSEh5GVqpTjN7iGwfitr6s
 ykAv+kMZshBz7XYj2Le86TaIXMCIz/jUQGrdmeEw7z71bxJ7dwNNKWazl53TmPh8xbvsLHL2iZN
 tpmJHfKtjOBAK
X-Google-Smtp-Source: AGHT+IEe/5PX1YMMwUhiOQNpOoQOxV5RJMtUqO9QGabnVSS7V8jG8mHYpvfsx/SUv9nsbb8S5CGu3A==
X-Received: by 2002:adf:e28b:0:b0:3a5:1471:d89b with SMTP id
 ffacd0b85a97d-3a51471dbcdmr1095032f8f.53.1748938295631; 
 Tue, 03 Jun 2025 01:11:35 -0700 (PDT)
Received: from stoup.lan (host-80-41-64-133.as13285.net. [80.41.64.133])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4f009ff7asm17668852f8f.90.2025.06.03.01.11.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Jun 2025 01:11:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
Subject: [PATCH v2 23/27] tcg/optimize: Fold and to extract during optimize
Date: Tue,  3 Jun 2025 09:09:04 +0100
Message-ID: <20250603080908.559594-24-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250603080908.559594-1-richard.henderson@linaro.org>
References: <20250603080908.559594-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 33 ++++++++++++++++++++++++++++++---
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index aa64f15779..06ccf39d64 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1044,8 +1044,9 @@ static bool fold_const2_commutative(OptContext *ctx, TCGOp *op)
  * If z_mask allows, fold the output to constant zero.
  * The passed s_mask may be augmented by z_mask.
  */
-static bool fold_masks_zosa(OptContext *ctx, TCGOp *op, uint64_t z_mask,
-                            uint64_t o_mask, int64_t s_mask, uint64_t a_mask)
+static bool fold_masks_zosa_int(OptContext *ctx, TCGOp *op,
+                                uint64_t z_mask, uint64_t o_mask,
+                                int64_t s_mask, uint64_t a_mask)
 {
     const TCGOpDef *def = &tcg_op_defs[op->opc];
     TCGTemp *ts;
@@ -1095,6 +1096,13 @@ static bool fold_masks_zosa(OptContext *ctx, TCGOp *op, uint64_t z_mask,
     rep = MAX(rep - 1, 0);
     ti->s_mask = INT64_MIN >> rep;
 
+    return false;
+}
+
+static bool fold_masks_zosa(OptContext *ctx, TCGOp *op, uint64_t z_mask,
+                            uint64_t o_mask, int64_t s_mask, uint64_t a_mask)
+{
+    fold_masks_zosa_int(ctx, op, z_mask, o_mask, s_mask, -1);
     return true;
 }
 
@@ -1448,7 +1456,26 @@ static bool fold_and(OptContext *ctx, TCGOp *op)
     /* Affected bits are those not known zero, masked by those known one. */
     a_mask = t1->z_mask & ~t2->o_mask;
 
-    return fold_masks_zosa(ctx, op, z_mask, o_mask, s_mask, a_mask);
+    if (!fold_masks_zosa_int(ctx, op, z_mask, o_mask, s_mask, a_mask)) {
+        if (ti_is_const(t2)) {
+            /*
+             * Canonicalize on extract, if valid.  This aids x86 with its
+             * 2 operand MOVZBL and 2 operand AND, selecting the TCGOpcode
+             * which does not require matching operands.  Other backends can
+             * trivially expand the extract to AND during code generation.
+             */
+            uint64_t val = ti_const_val(t2);
+            if (!(val & (val + 1))) {
+                unsigned len = ctz64(~val);
+                if (TCG_TARGET_extract_valid(ctx->type, 0, len)) {
+                    op->opc = INDEX_op_extract;
+                    op->args[2] = 0;
+                    op->args[3] = len;
+                }
+            }
+        }
+    }
+    return true;
 }
 
 static bool fold_andc(OptContext *ctx, TCGOp *op)
-- 
2.43.0


