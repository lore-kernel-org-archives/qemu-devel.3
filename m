Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7FC8C3ABAA
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 20:30:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uC2QG-0006tS-QN; Mon, 05 May 2025 16:28:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uC2Q7-0006n5-CO
 for qemu-devel@nongnu.org; Mon, 05 May 2025 16:28:11 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uC2Q4-0000Po-5V
 for qemu-devel@nongnu.org; Mon, 05 May 2025 16:28:10 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-73bf1cef6ceso4913519b3a.0
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 13:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746476884; x=1747081684; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4Z9U0xFGsHZfgRlzIcGtK3Ulm26TWyDjirsPoYKnSDE=;
 b=QJyeVGUq6Iv3qHCn3d+fkpUOSNw7pv7LEeYJ65Swbvh5WWmfmoT/dPtTnwRrAWU6OY
 U5BmA3E+U/Srdbt2WrY+9pMKeXNNeBO0wZvDOWRCKxrl2q2nrAF9hetoI/98Hw3FPRwq
 JKv21kFTrqAR3HIZHBgC7tJ2CUbxJ7+ukEmsakH2xOzQrL9zW3154d/iL+RKurIF4XJw
 yKi8mTFCmeEN46dAUjQC+yKBfhtaBz4BZf+v1iKogdHBPiaQv3eIvgv+6WrfF7InUcSA
 ABZUZbyJdKKlg5pps06x2Zl5xOhH7SswyLclRcOEvnttrER+axHTm7sipDt4kTMmz9r4
 uvsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746476884; x=1747081684;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4Z9U0xFGsHZfgRlzIcGtK3Ulm26TWyDjirsPoYKnSDE=;
 b=BQ3AXLFGHsf9bOed7CwoON+86WQmNN0VxeYsJgv6xf/d6lu1elZefqnoYMx73aKWOn
 IChyP+E2kYdb7PcHkABnA1cESO5dKbytApFovT3hB3oc7ghgp9Aepwv8o1HtIM6bCATQ
 ubzhqkQVtvwWcd7r8TvlQXiwf1VY19gtAU/kSRymIGMGKwKAdxeooTD3FKptUP8+8Dfv
 HyDxY2SOS1tzNVlYx8zT+fpFnp9rkpodZy+Z/u8H8BoWjKr1FPHA1pwLlzcTqFszNQwm
 nUgC9ub3EdhAQ6UY2qVhEBIPUWnIif+lpC20ya4yUc7uQ5S/Tw/BihjOKn0Y8gK45E22
 a3nA==
X-Gm-Message-State: AOJu0Yy17p7IhPWnlgn4gaMCtRTY3cFIri275m9G96rIkHPopYx+zSo1
 siUH53bwIa5B9o0lL+BIsWdsOzVksqU418ki+Ce7uXcfDPnc9H4GkLKGfEupuvTRZV1gHTz5nBX
 o
X-Gm-Gg: ASbGncv47fXbHpANCQ6qVSv5C244MGmqpa5++celoE2g4uU2oRfBGN5vvJUJnDzYtH3
 TprLovLX+Jrz/U39Mw/aPQR6gBrPIGDFPDQcHFDqkSiVNh8fSXu7GlB330rpyQ3Xb4jep2DUBmY
 KDz2Sy45whv9tMqvCab/Mw/sLKAjsobtlfVrtSs+ON6WJGjqXMbJAVATvCVUnXMpk234K6uraSx
 y4R5amkgbXqw3tvhJjlrjPR4XkY24+nh7uFnxVuGT5+G5gRaL9iABgHrB1UAHURt0ZPieleV3oR
 7nCwKhen438Haw7sjAIcz3uBWrSgBi0KgKLMd809i1LCxuZzjPnsb7CLc5/vQpYJJa/CtEtR3Ty
 YP2SU1+aPyg==
X-Google-Smtp-Source: AGHT+IHPPeOsO0yxfgIcWXSUv1qYIsIVlaihNY1HxXKRKgo70ewsDkv2Y1AqCGw+CJ/AY3fl90dBcw==
X-Received: by 2002:a05:6a00:2908:b0:732:2484:e0ce with SMTP id
 d2e1a72fcca58-7406f176b5fmr10428589b3a.17.1746476884488; 
 Mon, 05 May 2025 13:28:04 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74059021067sm7516485b3a.107.2025.05.05.13.28.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 May 2025 13:28:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 13/20] tcg/optimize: Build and use o_bits in fold_deposit
Date: Mon,  5 May 2025 13:27:44 -0700
Message-ID: <20250505202751.3510517-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250505202751.3510517-1-richard.henderson@linaro.org>
References: <20250505202751.3510517-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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
 tcg/optimize.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 2898a3f913..886947b82b 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1842,7 +1842,7 @@ static bool fold_deposit(OptContext *ctx, TCGOp *op)
     int ofs = op->args[3];
     int len = op->args[4];
     int width = 8 * tcg_type_size(ctx->type);
-    uint64_t z_mask, s_mask;
+    uint64_t z_mask, o_mask, s_mask;
 
     if (ti_is_const(t1) && ti_is_const(t2)) {
         return tcg_opt_gen_movi(ctx, op, op->args[0],
@@ -1877,7 +1877,9 @@ static bool fold_deposit(OptContext *ctx, TCGOp *op)
     }
 
     z_mask = deposit64(t1->z_mask, ofs, len, t2->z_mask);
-    return fold_masks_zs(ctx, op, z_mask, s_mask);
+    o_mask = deposit64(t1->o_mask, ofs, len, t2->o_mask);
+
+    return fold_masks_zos(ctx, op, z_mask, o_mask, s_mask);
 }
 
 static bool fold_divide(OptContext *ctx, TCGOp *op)
-- 
2.43.0


