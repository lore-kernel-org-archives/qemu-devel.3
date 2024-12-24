Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A345E7718F
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2024 20:08:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQBAS-0003Gr-G6; Tue, 24 Dec 2024 15:06:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tQB9v-0002mD-Oi
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 15:05:40 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tQB9t-0002Yq-W3
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 15:05:39 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-219f8263ae0so23702555ad.0
 for <qemu-devel@nongnu.org>; Tue, 24 Dec 2024 12:05:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735070736; x=1735675536; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LsfMpsMqMxq0FC0omwsdymCcUELXX5bANXU+yD+lCsQ=;
 b=Djw7fbvCvS95UCcvWdkqoDt401bZcC08Sohu8lmFAL0o2NW0oNCrxLhyZ/eKEnQLLH
 HxGW2Z0wjVFbQep2dUcYc1RaUvPWEz6RsBoehleLdNj72pefL0Wt7SNi3yClFzY0r1oC
 wpn7pFDPRu3Mz94f2Q/sb+FpC2IVAy0xS3SEkHD/BBP/dOmV6K028ValZw+Oaeu7BMuP
 TF6qNbZoICc0my4iuIQl2WFO4oi1/TtHCJGPppreCtB57JpM5/zY0caiwe+93i+gHrsl
 x6jVYg6Zh6zhsApB9kPjbhBCsM++y6aY8yJ4ZKDH3na6pJxD+aQKoIUEUajpy4adYCDK
 hv7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735070736; x=1735675536;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LsfMpsMqMxq0FC0omwsdymCcUELXX5bANXU+yD+lCsQ=;
 b=M90fbkuhAkClrXFczqSMMbdJi97Y99VEkWU42QXv7zqJKRV9skXA6RL0k52xvhikEb
 P0fBaTySftpwSSCkW+bQ4ROp4z9bpngevyRgr2/xy0vgtRyJn3v3VsmiKkWvgpgPo5s3
 Vkx9ZYJCq2mu8drt0s7tgNNBpEdqaf7yIq46/3WAs2JFjfWWAOoTK+/QLhD5KOcK7icj
 RV7Wb96dvxA0Z6PIWp9JeLwOyrSLa0uvONozgOlYveOXnvmibEYxFBT/7SrgyBmh9EGK
 zgU3YDcfAISSVcPHFvGLaaPIjKPkA0urLHzKTuwtWpvxuFwmpfqAEWgZ2VSNFiJAhKW0
 vo0g==
X-Gm-Message-State: AOJu0Ywqa+kVM09TgIeEmRu8vAMAkY6ayV0qTElnKlBzIpQZARjXMq+g
 NbJ5jh1RwygBO10K2+BFSt7HtRJdWV551Dh0UMRUP1KxHfsI2YqmMO2LU4F0tIgI03A2MfPFgx9
 k13w=
X-Gm-Gg: ASbGncsA8XzLI+W002O+K5GGf755XaeiJM+yDO0UQVf+ewnY6wTAFq95WL+pDbwGfSj
 r/3Sfi3G+Oa1n8UyhB+xeJTdDtJxelVr4/3oyzAOhM76DGo8orlAy0SNrJXNLZ3d9QZovlt4kQ9
 /t+wD+RBlDDdW8DQZiOc4n+ykctKtfELYhmn37eFrmnlClr5AVvXucZUj4NSI5Ko8EYtM+38ejy
 KaVbLC+BPvxX6yC4B0rDrTw0Iry9RYddLF/h0FyJHt562nR+fuuzzUHafakFYeLVucQn7zABmxa
 d4tcBD2Jy5BAyjLKPf+4UOavaA==
X-Google-Smtp-Source: AGHT+IG2U84kseABWX3u8yzvXMyQp6VOXzW9uEWSyT8xiQ3hhJWZvBHYGOUvrkFpbkDoTp4sBhbemQ==
X-Received: by 2002:a05:6a21:100f:b0:1e1:a693:d5fd with SMTP id
 adf61e73a8af0-1e5e04a3432mr29074598637.25.1735070736528; 
 Tue, 24 Dec 2024 12:05:36 -0800 (PST)
Received: from stoup.. (syn-156-019-246-023.biz.spectrum.com. [156.19.246.23])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8fb895sm10027159b3a.162.2024.12.24.12.05.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Dec 2024 12:05:36 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 15/72] tcg/optimize: Use fold_masks_z in fold_ctpop
Date: Tue, 24 Dec 2024 12:04:24 -0800
Message-ID: <20241224200521.310066-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241224200521.310066-1-richard.henderson@linaro.org>
References: <20241224200521.310066-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

Add fold_masks_z as a trivial wrapper around fold_masks_zs.
Avoid the use of the OptContext slots.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 0766a452b5..2f5030c899 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1067,6 +1067,11 @@ static bool fold_masks_zs(OptContext *ctx, TCGOp *op,
     return true;
 }
 
+static bool fold_masks_z(OptContext *ctx, TCGOp *op, uint64_t z_mask)
+{
+    return fold_masks_zs(ctx, op, z_mask, 0);
+}
+
 static bool fold_masks(OptContext *ctx, TCGOp *op)
 {
     return fold_masks_zs(ctx, op, ctx->z_mask, ctx->s_mask);
@@ -1599,21 +1604,23 @@ static bool fold_count_zeros(OptContext *ctx, TCGOp *op)
 
 static bool fold_ctpop(OptContext *ctx, TCGOp *op)
 {
+    uint64_t z_mask;
+
     if (fold_const1(ctx, op)) {
         return true;
     }
 
     switch (ctx->type) {
     case TCG_TYPE_I32:
-        ctx->z_mask = 32 | 31;
+        z_mask = 32 | 31;
         break;
     case TCG_TYPE_I64:
-        ctx->z_mask = 64 | 63;
+        z_mask = 64 | 63;
         break;
     default:
         g_assert_not_reached();
     }
-    return false;
+    return fold_masks_z(ctx, op, z_mask);
 }
 
 static bool fold_deposit(OptContext *ctx, TCGOp *op)
-- 
2.43.0


