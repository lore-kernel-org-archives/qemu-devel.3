Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BC01C83029
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Jun 2025 15:31:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWGS9-0000ch-C7; Mon, 30 Jun 2025 11:29:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWGRh-0000SG-9X
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 11:29:28 -0400
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWGRZ-0008EJ-8i
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 11:29:21 -0400
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-735a6faec9eso1242930a34.3
 for <qemu-devel@nongnu.org>; Mon, 30 Jun 2025 08:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751297354; x=1751902154; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IHWQ9jZt0RU2JCkb2dK4Qaoa+rz63y9Og4hJnbZwLYw=;
 b=SZjwAqNQJmKw2ESgvgvL4xmo0m/bsDYXkyo9g3IHgxS1/Z4OW/UgBvGrC8WdZ/4iz0
 m/ipQn+96+oR5ZGyaZupCpXw7OMNbPVJ8yO/0KFYwW+QcUVp0GPzAYzyuP4m/8CvqW4q
 rDlFsnNA5oN96tSfKttaXsMaXXldc3aGDhsfv5ma6kER+2bZBmxojhLc92TOnGTwmjzh
 pKfZJkJugsU61dYx1m36pF8cHamuw3fOtFaJzbVsnJN1zTyXRhCuOhsVyA3UNrmkLup7
 PtsxPUCuCX80ExhbkGIUVA28LhGhwo1mOm2cbqBoPbCAUXdtE2vif0e+tiY61E+V8URw
 MEnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751297354; x=1751902154;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IHWQ9jZt0RU2JCkb2dK4Qaoa+rz63y9Og4hJnbZwLYw=;
 b=leTJ3+NJpo0MLUr5BVdIS6olRtQQpPZQau17RzfnammcarXRoGOMw5MOx8HnUDT1Qj
 EkOQZNyZQP+8F5tUm8KKw0Efuqz69+njeLoKwyzYCZmATdmE7gxum7A5LRHhvBQNjqV9
 OOvX7midzKzA2yZl0b4hnfW4BQsCdY0cnVWGEcnbobv38lcjzA4meOfSVqKlXZZ5ypD6
 GbPtJYNLsuSqhqLASdIH4FWWgFsvEQ9GhEz+jE4/Hvz9AN78NXY6puVjOLislCXzWOgt
 gmasentEn98KdNapBiMNG7THkJSppT8ebSQvBPkdzgV2PRUVICOpzyBRn+dPxgEW4ruw
 dWvQ==
X-Gm-Message-State: AOJu0YyPgqr+CsInDoipZtyE0J73p0Q4N8vT2wfS89yvcMpB6ECn7tZN
 109kcV3wntu98/6qc/lEe7pKIJSCQrNh4LyOjRiNabenjPFIcNh/Hw3C5EulEP8gu9SnpBTaLbo
 l69Nx
X-Gm-Gg: ASbGncsdBo8uM8i5JW0Begp2HG83shTniz1RlRG4U6XaAl5Q1L8rMGKMSz8yzVYUiss
 hN5oiaH6TWMARweXui8bSNiTrUdTb8UXB3GlS5u7Nb63Pm/ofKKRvs+yshQD2Gzzuk/QNIv5AZa
 tDrECub/Ljxh9sgWNatHo+JzWAzLK5kdgVYbgrIyzIoZq7A8H0wjICHPrtGRBfv01BxinUzofWU
 FszQBNgwwNrqTriB+HRK1ioSoIVhs6Ap4uE6z+sK7itqfRaCYdaGJEVHPLqJYqImdvItrWe7aj+
 Ebgm06aNvpgS/AiGRdt+osLETYcDmzu6X6lJY4DtxqGggwrtvEJF4IYzCyId9cmkKkz5RA==
X-Google-Smtp-Source: AGHT+IHDKHVY5OjsZXBPx5e6hI03G79lclH4mk9cyO2yBCczfjGnX2j/CjvHE7Wr3imqNfdpaZdyNg==
X-Received: by 2002:a05:6830:2c06:b0:736:8a4:6835 with SMTP id
 46e09a7af769-73afc39b3c0mr7339256a34.2.1751297354522; 
 Mon, 30 Jun 2025 08:29:14 -0700 (PDT)
Received: from stoup.. ([187.210.107.185]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73afb00c48asm1712478a34.27.2025.06.30.08.29.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Jun 2025 08:29:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 16/29] tcg/optimize: Build and use z_bits and o_bits in
 fold_extract2
Date: Mon, 30 Jun 2025 09:28:42 -0600
Message-ID: <20250630152855.148018-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250630152855.148018-1-richard.henderson@linaro.org>
References: <20250630152855.148018-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::333;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x333.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 38 +++++++++++++++++++++++++-------------
 1 file changed, 25 insertions(+), 13 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index f5fc0cfff9..86d958267a 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1099,6 +1099,12 @@ static bool fold_masks_zos(OptContext *ctx, TCGOp *op,
     return fold_masks_zosa(ctx, op, z_mask, o_mask, s_mask, -1);
 }
 
+static bool fold_masks_zo(OptContext *ctx, TCGOp *op,
+                          uint64_t z_mask, uint64_t o_mask)
+{
+    return fold_masks_zosa(ctx, op, z_mask, o_mask, 0, -1);
+}
+
 static bool fold_masks_zs(OptContext *ctx, TCGOp *op,
                           uint64_t z_mask, uint64_t s_mask)
 {
@@ -1982,21 +1988,27 @@ static bool fold_extract(OptContext *ctx, TCGOp *op)
 
 static bool fold_extract2(OptContext *ctx, TCGOp *op)
 {
-    if (arg_is_const(op->args[1]) && arg_is_const(op->args[2])) {
-        uint64_t v1 = arg_const_val(op->args[1]);
-        uint64_t v2 = arg_const_val(op->args[2]);
-        int shr = op->args[3];
+    TempOptInfo *t1 = arg_info(op->args[1]);
+    TempOptInfo *t2 = arg_info(op->args[2]);
+    uint64_t z1 = t1->z_mask;
+    uint64_t z2 = t2->z_mask;
+    uint64_t o1 = t1->o_mask;
+    uint64_t o2 = t2->o_mask;
+    int shr = op->args[3];
 
-        if (ctx->type == TCG_TYPE_I32) {
-            v1 = (uint32_t)v1 >> shr;
-            v2 = (uint64_t)((int32_t)v2 << (32 - shr));
-        } else {
-            v1 >>= shr;
-            v2 <<= 64 - shr;
-        }
-        return tcg_opt_gen_movi(ctx, op, op->args[0], v1 | v2);
+    if (ctx->type == TCG_TYPE_I32) {
+        z1 = (uint32_t)z1 >> shr;
+        o1 = (uint32_t)o1 >> shr;
+        z2 = (uint64_t)((int32_t)z2 << (32 - shr));
+        o2 = (uint64_t)((int32_t)o2 << (32 - shr));
+    } else {
+        z1 >>= shr;
+        o1 >>= shr;
+        z2 <<= 64 - shr;
+        o2 <<= 64 - shr;
     }
-    return finish_folding(ctx, op);
+
+    return fold_masks_zo(ctx, op, z1 | z2, o1 | o2);
 }
 
 static bool fold_exts(OptContext *ctx, TCGOp *op)
-- 
2.43.0


