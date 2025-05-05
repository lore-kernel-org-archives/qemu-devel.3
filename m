Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D472C3ABAA
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 20:32:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uC2QA-0006p1-Lr; Mon, 05 May 2025 16:28:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uC2Q4-0006lb-JX
 for qemu-devel@nongnu.org; Mon, 05 May 2025 16:28:10 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uC2Q0-0000PE-0m
 for qemu-devel@nongnu.org; Mon, 05 May 2025 16:28:05 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-22435603572so61176015ad.1
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 13:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746476883; x=1747081683; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=kofwy185EEZLPzQB92vqtuKiKqq4yoFm/cvXaDrv7JU=;
 b=kKigjx+ilSvP290+4FV1AgQs0abmGmyww05F3yNgx50gFpuXma2XLwTo14cYVGxCOD
 KqaRdQut6BN16v0WilgyxCPBhfVQ3VElSVsBHWv1I5hBRz/mKm8yhM1kbRIrUirqg4+u
 EbontWlYZT7OZD2OTK4fXdIUQQhEASldltYHLff4l/2xZ8msmD0IH4360r1X3jIVK0dn
 rGH1zDfAXGEJ1sd279d+SB36nJf5hws20Jobliv1iKT4gQ3enVgc/VORgnA4gjaQtWtP
 sIB3avA7zQ8sdpvQ9x5CjY7C0SBOPWv/5bmtcrynMhmAZAXI/URZKICnVlOkhtl0FEB7
 AlJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746476883; x=1747081683;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kofwy185EEZLPzQB92vqtuKiKqq4yoFm/cvXaDrv7JU=;
 b=Xs3nyElSHAU/GDHxvIg2jr3nfQccbczRrJQkSCCsQinreZQQCdOItvS8HfsnSJMP20
 1NjSIyE8UCIf8FvNVlZ2bLiv8QollJyAkpFlbt0Mj/9io/kOg9MbJ4qDUCCXBmfpaBwd
 qTs5vZU6HttXVr+8CY4FgDI4BjS49PBl/V+6xm4fWf4HMLw3N33FlNGmQw3BXXSfcomz
 CpAQot3QOesawrgVsj7UcWfII5Q8GvgdQucLPYN355dAETgf115SD9hkXcYhodzWrDyD
 P5KiT+IIEDFMivRb3kY8EzKb9gRYCzCGgzTzfCb+b+oXzqCTwKRyHIERkbUTAZEy5c2s
 DnKw==
X-Gm-Message-State: AOJu0Yyez7iB46awrGz6BMjID3ZQtLGDTsQXOPW8G8jYKCkZo0PexXhy
 Pka4AM90y62ZZmW5VGvXFTakfKxnGjdBo/82Mvu4vDeyLEaMCxIzLIG+on+jJH//EzMBJPAXLTM
 +
X-Gm-Gg: ASbGncskkegCNAQmoUnP6sY3EQsRqWOmWbvEHAEAs3vrES5NLT/+Fkncjp4D58T9qmC
 N0hKk4ps5Fm6BWJiFwPzEUkf7nrW5T6kQx42mVIAlFE1DCiAxs3iHUGYKKerWetam32cCB7Q+qd
 Fe0cSNKee2ISj4LXsSAgcW4Ubz4USOVEljJxmBC8SrtMRteh+/qSgMZ5CzTBkrh779MyrfZ2dtG
 FJrh0JgZg67aWtdD4YrmD3wPvVnY42RFbMzemUsK8xAJTUc9ZC/pdw64EHRPJ///YDnXp5hq16q
 WDAkNnkLUTkwJGQ5WO8gfv1sPnHoiY2pD5nXdJYKdvIfLJ+GEeqQRUUtO4W+1hk77bA0OVeZhU4
 =
X-Google-Smtp-Source: AGHT+IFeTWXzFemncHkEADvcuuCqE8stSN1r5OefmrfbUlWY9rU+J8Uc8qMAvD+s5kQctk8cJYk2Qw==
X-Received: by 2002:a17:902:cece:b0:223:66a1:4503 with SMTP id
 d9443c01a7336-22e1ea36e9amr120547385ad.30.1746476882737; 
 Mon, 05 May 2025 13:28:02 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74059021067sm7516485b3a.107.2025.05.05.13.28.02
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 May 2025 13:28:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 11/20] tcg/optimize: Build and use o_bits in fold_xor
Date: Mon,  5 May 2025 13:27:42 -0700
Message-ID: <20250505202751.3510517-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250505202751.3510517-1-richard.henderson@linaro.org>
References: <20250505202751.3510517-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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
 tcg/optimize.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 5081e3db1f..a61c7ca376 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -3038,7 +3038,7 @@ static bool fold_tcg_st_memcopy(OptContext *ctx, TCGOp *op)
 
 static bool fold_xor(OptContext *ctx, TCGOp *op)
 {
-    uint64_t z_mask, s_mask;
+    uint64_t z_mask, o_mask, s_mask;
     TempOptInfo *t1, *t2;
 
     if (fold_const2_commutative(ctx, op) ||
@@ -3050,9 +3050,12 @@ static bool fold_xor(OptContext *ctx, TCGOp *op)
 
     t1 = arg_info(op->args[1]);
     t2 = arg_info(op->args[2]);
-    z_mask = t1->z_mask | t2->z_mask;
+
+    z_mask = (t1->z_mask | t2->z_mask) & ~(t1->o_mask & t2->o_mask);
+    o_mask = (t1->o_mask & ~t2->z_mask) | (t2->o_mask & ~t1->z_mask);
     s_mask = t1->s_mask & t2->s_mask;
-    return fold_masks_zs(ctx, op, z_mask, s_mask);
+
+    return fold_masks_zos(ctx, op, z_mask, o_mask, s_mask);
 }
 
 /* Propagate constants and copies, fold constant expressions. */
-- 
2.43.0


