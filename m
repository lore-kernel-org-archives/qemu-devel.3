Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 260EAE77188
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2024 20:08:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQBAb-0003Xd-6r; Tue, 24 Dec 2024 15:06:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tQBA4-0002pA-Aq
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 15:05:48 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tQBA2-0002aR-QI
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 15:05:48 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-21644aca3a0so65832075ad.3
 for <qemu-devel@nongnu.org>; Tue, 24 Dec 2024 12:05:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735070745; x=1735675545; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k8tsF+Zaln0GqZenAMtz/m3flCsE/XhQzYQ3qzfdH28=;
 b=bKaTgyP7Uf1ixVkraHVLVwoDQadqXJJMeULt8uw9PwsoU01ysFu67Tbxo9wcZZ4+o9
 lmBXCNMav8qy8PhuAw62nmRZWKQ9Cud+4hTz7RMKznRHGaldsWV1X4P3OvOR25+3Idlt
 PH9CYFKeyuoffwYMyH0TcUB1MOUI+R/dUzthSoX8Qg9FVzLUfQkTUyVtbqzX/sReaQyM
 aDHqOMLq5hWFQ5dfWvNSoTQbxzyyj8qaPx8e9viRftlTe+oxNxPtQHR8vwArUFOB79Wa
 tIYvf4YU+60XqjFLZvuM9PR+rRBn4K9iK0QiZPolRYt1d8D1foOh+4pzr63eP4YjfTEd
 kcPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735070745; x=1735675545;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k8tsF+Zaln0GqZenAMtz/m3flCsE/XhQzYQ3qzfdH28=;
 b=T/siqLufsk0JvaEqLR/tNGC82pbbOHu//Jz5gHt0eIAbEZt+dypEEI50UgYpyZVVzT
 zZ/rEKI5iAjBhmyEB4HwwxcJUakWYvvTlZj2YqgQ7x8Soz3hRq6fJ4EGoezBH9DKsmzL
 DqnuGDoOuQ8vXFP2rBV5n1GDm8Ez3IBIgid+klYVVtA2Gx5/GyzUWkLLeIOxKxyCSYDW
 9yJBjELQJUiMplZtySAeE0OAYthw+OUa7oDD+kWFhogZaBwSPH7HeXUlDP4+s6a/S1/B
 gZK571yHdyrmpObkmMlu6zozPtS914OEWKr1BRFMRDotTYjGbnrpkQj7jOusiEv4rYbc
 octg==
X-Gm-Message-State: AOJu0Yw2KLNwgJERO5bSc/1oHqTMumiQyXOi2jkUnJ8eM3Y/uLbLx9DG
 K0uqn7H1MDoF6oH3Gk6CXsh4uLAF2ACWAW58rATp7LAA/h/2t4UBsYITrtTCWk0C9LVnL8t5F48
 n708=
X-Gm-Gg: ASbGncvUDHhZxYS2orJ4QxjXLTvE+HsV1pgcHRgr0LCfBySCmNV6QzQtnvBE6TVBWZI
 j5fz5FFmJmKEVKut4cM7oufsS0BoFcxodx11812qvc0S7aL/+yl6XEZWcDwkJ82c/LqQr2LpfEm
 N0gx0xMf0ha3plDP7ie4Dajc0z9W7/y1iu8i37dMZwT0MdNFbc3d7cm2zyb8pIX8gNA3hN88/HU
 ZBlziKRU01LX5B4UBykeIcplxs8aN5ZJSxc+RDMS4zBL5u/QUlNWkd0LY/HizCDG+OK+SFEMVa0
 oHPIGRMvHjHYPZd/1BOW5WPKAA==
X-Google-Smtp-Source: AGHT+IHlJrd/7c25mNQYyrwtlCGAtU/XPAdhnUKobxMH8nHdJPuho4gFdGqVctpk/PelbnvULrcJyA==
X-Received: by 2002:a05:6a21:2d05:b0:1e1:a647:8a54 with SMTP id
 adf61e73a8af0-1e5e05ac4cbmr28870806637.20.1735070745152; 
 Tue, 24 Dec 2024 12:05:45 -0800 (PST)
Received: from stoup.. (syn-156-019-246-023.biz.spectrum.com. [156.19.246.23])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8fb895sm10027159b3a.162.2024.12.24.12.05.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Dec 2024 12:05:44 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 24/72] tcg/optimize: Use fold_masks_z in fold_extu
Date: Tue, 24 Dec 2024 12:04:33 -0800
Message-ID: <20241224200521.310066-25-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241224200521.310066-1-richard.henderson@linaro.org>
References: <20241224200521.310066-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 3aafe039ed..f62e7adfe1 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1851,11 +1851,11 @@ static bool fold_extu(OptContext *ctx, TCGOp *op)
         g_assert_not_reached();
     }
 
-    ctx->z_mask = z_mask;
     if (!type_change && fold_affected_mask(ctx, op, z_mask_old ^ z_mask)) {
         return true;
     }
-    return fold_masks(ctx, op);
+
+    return fold_masks_z(ctx, op, z_mask);
 }
 
 static bool fold_mb(OptContext *ctx, TCGOp *op)
-- 
2.43.0


