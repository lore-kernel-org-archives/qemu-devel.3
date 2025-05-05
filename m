Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40E11C3ABAA
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 20:31:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uC2QD-0006r9-Gn; Mon, 05 May 2025 16:28:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uC2Q7-0006n4-AX
 for qemu-devel@nongnu.org; Mon, 05 May 2025 16:28:11 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uC2Q4-0000Px-5i
 for qemu-devel@nongnu.org; Mon, 05 May 2025 16:28:10 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-7370a2d1981so4053874b3a.2
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 13:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746476886; x=1747081686; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Js2PHkGKWnIWePR4QAI//TgTXL4kXU/lMnkleDrme+o=;
 b=WnZK5JRcVL1IvJUDNZsaqMOrPgW2vqwWiyOsYxJmwkQK6+em2rp3BMeL4LivTMMDDZ
 IYXvOOs+oYoupMy7j5shBjPH70ZPRAx9lz5X9H3MEFAyDorVpfMB74ZVocUAQOTnJOkU
 55dA6MlErmc90CHpKpt6nkp0C/kwwCBt6rWN7laAwEk76tohpG3AZqRIqfaanCyGWYGs
 FR2+Xw2REXKrEKaJPEmC2PFMeUC1E3CLCHlnGP6uRBhiRzzIXV8B4K8Bt2YZ4aZFoxxC
 k79yxh55Fg2lz2VTthZ/9fcLHFKwI4wf5DbbPLq3DAKnHQd3e+klHPXhsfYXqDDs8M32
 vpcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746476886; x=1747081686;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Js2PHkGKWnIWePR4QAI//TgTXL4kXU/lMnkleDrme+o=;
 b=Nu4+5MJ1XOT1iwDl5yieWWUTfqqLbyHBJorfeX0THaackm+CuYde0Fuv1l3ZVBUA8c
 38WVPefldlRF426U3drQZRQ6nm6gBGRbJ0tjygqaiuQLPsdjcpUClNPE7hcZ0o9DmOU4
 ofc3oOXE4Ez1rdGBCM+fobSce0St5AJA818/19yCyT4TEwvqA7dtag4LkwHVHWj5lO3Z
 JXBFPqP7f2+P2sWA6hsMckwR1SDMXjUis1S37ZcK183fJEZDQx5FaD5KPDtytxsgmhWX
 8TdN+Hiezz/a3QYJyVx+0xJ4tbn7tQ5BkejkHHOeCNPs6oX57CffEEVPU5lJ3JVxNTEQ
 nA6A==
X-Gm-Message-State: AOJu0YyNzyEyq1fsUuQyhMi4TSzJfEHE3Dg19WpntZjCM7FoZr/DHFEQ
 OLweKICgPUmqNopTCG+8l1RfDDIpAgdNa0oxI2Jd01RbvkGY7bR3G84IMbOovSNcaFcy1Q5UBLD
 9
X-Gm-Gg: ASbGncuV+dO/KYT7ODVb1aQbJ2k0SNgq1sCDlw1LnT82T2RTBOXeQ/gWnZ684pdckEt
 37Y+XMRMoH81ou82jqPqc5d3zfa8Sz2XmICROiAJS23LB3Bg/vKWUQ6wqeLt5ZwrsRgj4wCSR6M
 uljl2ojMVZG+TZ7khXWGPqhgJPJsC4sZnUCeqSaYTzVcBBEf+9oDrZbOkQrWWh1XG2iRJhB76hW
 ar7rIFjuGomNIkR3i4qaQW0iOU2M2/qusLzWKnxD8yhvVgR0WJerd5mKLxbnoOu8dijeiD+2IXz
 lHa5BFjqzLnDHt559lBj0GtQjIgtiV5xwSkORfeLKBeIG2kD9zkaqlAzfLaWhDdNA7R/BBlgiQc
 =
X-Google-Smtp-Source: AGHT+IHzsnyiBXAuIumTz5PhiLPi3fa4la7/IcHch8qfFcpbZXl4WM3hlvEB6oO8fPgX89ww4bKx1Q==
X-Received: by 2002:a05:6a20:c90e:b0:20a:4698:9d3 with SMTP id
 adf61e73a8af0-20e9620568dmr13897661637.8.1746476885799; 
 Mon, 05 May 2025 13:28:05 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74059021067sm7516485b3a.107.2025.05.05.13.28.05
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 May 2025 13:28:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 15/20] tcg/optimize: Build and use z_bits and o_bits in
 fold_extract2
Date: Mon,  5 May 2025 13:27:46 -0700
Message-ID: <20250505202751.3510517-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250505202751.3510517-1-richard.henderson@linaro.org>
References: <20250505202751.3510517-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 40 ++++++++++++++++++++++++++++------------
 1 file changed, 28 insertions(+), 12 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index c5243392af..424fd57922 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1986,21 +1986,37 @@ static bool fold_extract(OptContext *ctx, TCGOp *op)
 
 static bool fold_extract2(OptContext *ctx, TCGOp *op)
 {
-    if (arg_is_const(op->args[1]) && arg_is_const(op->args[2])) {
-        uint64_t v1 = arg_const_val(op->args[1]);
-        uint64_t v2 = arg_const_val(op->args[2]);
-        int shr = op->args[3];
+    TempOptInfo *t1 = arg_info(op->args[1]);
+    TempOptInfo *t2 = arg_info(op->args[2]);
+    uint64_t v1 = ti_const_val(t1);
+    uint64_t v2 = ti_const_val(t2);
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
+    if (ctx->type == TCG_TYPE_I32) {
+        v1 = (uint32_t)v1 >> shr;
+        z1 = (uint32_t)z1 >> shr;
+        o1 = (uint32_t)o1 >> shr;
+        v2 = (uint64_t)((int32_t)v2 << (32 - shr));
+        z2 = (uint64_t)((int32_t)z2 << (32 - shr));
+        o2 = (uint64_t)((int32_t)o2 << (32 - shr));
+    } else {
+        v1 >>= shr;
+        z1 >>= shr;
+        o1 >>= shr;
+        v2 <<= 64 - shr;
+        z2 <<= 64 - shr;
+        o2 <<= 64 - shr;
+    }
+
+    if (ti_is_const(t1) && ti_is_const(t2)) {
         return tcg_opt_gen_movi(ctx, op, op->args[0], v1 | v2);
     }
-    return finish_folding(ctx, op);
+
+    return fold_masks_zo(ctx, op, z1 | z2, o1 | o2);
 }
 
 static bool fold_exts(OptContext *ctx, TCGOp *op)
-- 
2.43.0


