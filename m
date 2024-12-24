Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DB10E77188
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2024 20:07:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQBAn-0003ly-QC; Tue, 24 Dec 2024 15:06:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tQBA6-0002q1-Si
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 15:05:51 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tQBA5-0002b8-8Q
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 15:05:50 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2161eb94cceso39841595ad.2
 for <qemu-devel@nongnu.org>; Tue, 24 Dec 2024 12:05:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735070748; x=1735675548; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wktipe244FoeFQSExHME3WY9VZ8Aio+GMnAonDh7r1s=;
 b=BnOro3oGB/Td4mAwGj0+5N29eIiGPm7Hudg9feDOWU4skGkuEX1SzDGrKD7pY1Fg0/
 eRLqX+Bg8OMVStcLqn7kw9xlcRZOcc8bAH1Yy79EP9KIcd1bg1Z63PYADUHGm94PBuzS
 aUxqqDGyWKlMENtCt6OFxqzBvPMbU777fVPvhwq23pU/qZf8fHZnrqxT/i0mBZ7j4w2i
 +NdWe/rAssPvk2w5+ye9uP2vG33Rt1tPPMpGYs704fP7EKG89HPX3a6CgCZcwTTM5te3
 dQvzcmJGFIR2BSWVessEHgnWiQlfd0Uc6unwXYSVPOycwPSM/2biabI+eQyXK/y7WpPb
 0vLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735070748; x=1735675548;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wktipe244FoeFQSExHME3WY9VZ8Aio+GMnAonDh7r1s=;
 b=YV9SdUR+wvs0nwa4yAPOwUw4MJOlBJVHFIDJapbZ0WoxJQuuiLpGfR8tSeU2Ihz39K
 Xd0U2DqmKDutFTPY5+qRY+wJiVW509Oo+qdtKoSnuTQOsVdDt+JpIqMGVOsX+/mDtA9K
 54H2BjwT+HJfGqkj004ZMj26nEEUCl8frndy5DW41zlR/814DjOVxVrNewYMBKP+gG/e
 mFCYpgLMxhVg60+SjVKHjqqJiCUwCOkM8SUeRGmzDl+SSkUVPOY4GthXXp3oH+LiSRDf
 zkglCt/Nxm6NSJ2Zsu5bha4ZW5DlmziKSGSyQJGC0CR+3fM8YSKWPQlhTfCukQXHUzLU
 rwlQ==
X-Gm-Message-State: AOJu0YwWVVke2Za1/eul70N2BTBcSfrhz0oD3mAnbIvHCp8vkgMueLCn
 xwll/Du7zh832q/BKhQbK7Ya/IVdPP6L5zFyLwqqwY5Y3IgQjAsFtQ7OHw1e+XDj08MfSp1CGbG
 hxG0=
X-Gm-Gg: ASbGncv6JY7UzsyenMAOUrl3DgSXLcwZd47OKhQDkb3IreX4dCEwtKzUY4MH7RFJm0o
 1Y7iBXs7hYZtVEliBlV0Gqdb1jTdlehYlyuGFVKW1DEAc24JnJL7Xbgv7kXHNtvcg+U74N7u0xy
 dYYKUK7M11Hq80IjLSU8RcF/ffBfaO73TAODdidsou4J1DOqfoi7HNLuUCucN2mw+Ur8hz68hUC
 lENcoCmRShsJkA/8UziexhHseeVHqXBWfKaZMhHDY0wqnQFWBBU+f9eSzk9hxukFMHs+EUJBzPs
 Qvc642himYfOMttYoAfBwhMx5g==
X-Google-Smtp-Source: AGHT+IGk3vDEuFhD1Kxb4p6bO2w8WJ5BrQ9GNLjPd3/0tGPQeTj2NomanNDmvqvn0ZO04UdeQ4MC6Q==
X-Received: by 2002:a05:6a00:cd6:b0:729:a31:892d with SMTP id
 d2e1a72fcca58-72abdd9603cmr28693846b3a.8.1735070747929; 
 Tue, 24 Dec 2024 12:05:47 -0800 (PST)
Received: from stoup.. (syn-156-019-246-023.biz.spectrum.com. [156.19.246.23])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8fb895sm10027159b3a.162.2024.12.24.12.05.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Dec 2024 12:05:47 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 27/72] tcg/optimize: Use fold_masks_s in fold_nand
Date: Tue, 24 Dec 2024 12:04:36 -0800
Message-ID: <20241224200521.310066-28-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241224200521.310066-1-richard.henderson@linaro.org>
References: <20241224200521.310066-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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
 tcg/optimize.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 10d1376f62..7fe5bd6012 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2028,14 +2028,16 @@ static bool fold_multiply2(OptContext *ctx, TCGOp *op)
 
 static bool fold_nand(OptContext *ctx, TCGOp *op)
 {
+    uint64_t s_mask;
+
     if (fold_const2_commutative(ctx, op) ||
         fold_xi_to_not(ctx, op, -1)) {
         return true;
     }
 
-    ctx->s_mask = arg_info(op->args[1])->s_mask
-                & arg_info(op->args[2])->s_mask;
-    return false;
+    s_mask = arg_info(op->args[1])->s_mask
+           & arg_info(op->args[2])->s_mask;
+    return fold_masks_s(ctx, op, s_mask);
 }
 
 static bool fold_neg_no_const(OptContext *ctx, TCGOp *op)
-- 
2.43.0


