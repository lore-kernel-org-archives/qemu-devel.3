Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 535C2C8302B
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Jun 2025 15:33:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWGSB-0000cj-2P; Mon, 30 Jun 2025 11:29:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWGRs-0000Tm-8f
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 11:29:42 -0400
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWGRh-0008G5-1j
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 11:29:35 -0400
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-72c09f8369cso1287008a34.3
 for <qemu-devel@nongnu.org>; Mon, 30 Jun 2025 08:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751297360; x=1751902160; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N/2K77/QkthXYXM/f6m6RE27lMTOUzmm5oW44mp5NRw=;
 b=D+PXA9vUChuH6hvl/pRmbJncs3fvtOo0S9DMUZnWJ4Ss46apxAr//oFoAT17ZvlchG
 I28XGTtWvnJ/0hv69ITwuNtZHlvJWdYOKPzMDWiwOMQINOGKL7cZOYp7X2bcLEgQ8cmC
 lNezP5/l1W+5h2DjjcrDoDWWLHsQVt9QurwFLpsCDgTbfMoKmTBJfsVBg+L0O7nleMJf
 WMg929WwuheEaL0n74mvvfQVuFmk49cub31K7N0Ob4fcT3dDnssex0wzQ4IBo9lrzWhS
 JtJd0ZG+C5roN+WUnm0QoY0KyxCSiCPMnmdpc9++eWlFqCiAFTCwbw9c+nDeb0lUG4ZM
 g4Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751297360; x=1751902160;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N/2K77/QkthXYXM/f6m6RE27lMTOUzmm5oW44mp5NRw=;
 b=CkxiSjYNZXCSKEcy6B512KizNZ0biHRo1yV9xeB5Tr8etCYrVJJm+CIvfigCq0BYLD
 rGGyrTrsbDpUcvKnwH9IcchwDm2fZeI2c2sxV1fS0hYOn8GR+6CNBEARmSSotLStBAfd
 6GdYtgujWh1UC1rXMX5NfRNKIgzqMwlejMNLd/08fgIxNN51xHqmOJsDWjxNYfUNazKS
 cGJpQK/rFBjcXl+rTMVxKBzZD8p79S4vbRb6FZjcmHGNZQc5Wyq5Po4+nCJLrNX0Grjf
 yQt+XchNVYWoPD+QIypYzW8XimhvwEU5MliwgWBJ8HlbNWLgHnv3iuwzFupYCg069TVq
 LkSQ==
X-Gm-Message-State: AOJu0YwKfLrxMdGVzkyMRgFlwrn+fOkfDw5Hb9NL6ZlI30YOteGkAz71
 TUoB7B1N6TK15shAWbm36VqbjAlXN3ZzHrC4BXG3S2vzgwPlEteoWz1i5sqwM/3z9QOPXmhpa6H
 AKsoX
X-Gm-Gg: ASbGncsHOfEM1vskD4N5lvu49rcZI9anlXzjqyj8Jp7eoOgOTTDQB0yJFL0poRyeR23
 DO610T0det2xfpEuVYRGpCZLRyvgMlYslQkAjrLy40iLftm1gdJdSnWILpFuHyh94z9tB1KiTuf
 6nyJdyScO3X3UbWug6jEZDskk4YHemrabVppvnLVrc95W9PeAuGklrafKwc4h2dewAfacCOcXxx
 WpK26hy6MFk+fPaQpKklb7b213cb0CZMF9vHQTUfCMPjAz8xPYheFhofWDjga+ZQeTPE9vvNli0
 SiQTW5JIk8A8vVKthjj2j1P7+K2X0KnKfxDMcsG9iN7uu3El85j+YRKI996murbKPEbf3Q==
X-Google-Smtp-Source: AGHT+IGOvBDxLH2eSlvhS+b5r4efj5B8SJRXBdcn0ZgMS9s3GejJUz7hir5lhwLltVNy4zKa42sYmw==
X-Received: by 2002:a05:6830:3695:b0:727:3111:1416 with SMTP id
 46e09a7af769-73afc64cf53mr10515391a34.24.1751297360173; 
 Mon, 30 Jun 2025 08:29:20 -0700 (PDT)
Received: from stoup.. ([187.210.107.185]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73afb00c48asm1712478a34.27.2025.06.30.08.29.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Jun 2025 08:29:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 24/29] tcg/optimize: Simplify fold_and constant checks
Date: Mon, 30 Jun 2025 09:28:50 -0600
Message-ID: <20250630152855.148018-25-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250630152855.148018-1-richard.henderson@linaro.org>
References: <20250630152855.148018-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::330;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x330.google.com
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

If operand 2 is constant, then the computation of z_mask
and a_mask will produce the same results as the explicit
checks via fold_xi_to_i and fold_xi_to_x.  Shift the call
of fold_xx_to_x down below the ti_is_const(t2) check.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 06ccf39d64..f3a2328fe4 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1434,10 +1434,7 @@ static bool fold_and(OptContext *ctx, TCGOp *op)
     uint64_t z_mask, o_mask, s_mask, a_mask;
     TempOptInfo *t1, *t2;
 
-    if (fold_const2_commutative(ctx, op) ||
-        fold_xi_to_i(ctx, op, 0) ||
-        fold_xi_to_x(ctx, op, -1) ||
-        fold_xx_to_x(ctx, op)) {
+    if (fold_const2_commutative(ctx, op)) {
         return true;
     }
 
@@ -1473,6 +1470,8 @@ static bool fold_and(OptContext *ctx, TCGOp *op)
                     op->args[3] = len;
                 }
             }
+        } else {
+            fold_xx_to_x(ctx, op);
         }
     }
     return true;
-- 
2.43.0


