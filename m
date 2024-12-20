Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77456E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 04:14:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOUMg-00009q-1l; Thu, 19 Dec 2024 23:11:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tOUML-0008Qa-3A
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 23:11:30 -0500
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tOUMI-0006N2-DL
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 23:11:28 -0500
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-7fd17f2312bso1114388a12.0
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 20:11:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734667885; x=1735272685; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C1oOVeQtXZQwGm0E7MKnqUzsP3l72cl2b6h7Zprs2aQ=;
 b=Q3e7tRkHrbuftw3DhY964Z9YGRCSGkL9gsPAJjQGn76d99gdwXj7dMqTOWvUSv+24c
 TShaZA2VEuVI+R93E16nHKE6cXM+SUtNoy3C1dMwoIthhCWYZcL2TFLqLf2SvvbxGYlP
 6hokPUpNpighxgUi0AFO60sv1+VdzyE1AL5cmJbJBVsv3m1nHKeisrJg7TdgfVlTdQKu
 hZo0nI/xIVKcgNqXlhJTxh4haYiMQCdbr1K8pof6WeKE1jUp85b3WFr2zINg7Vawo3pk
 7VTJUf9h53yFJjC+WaGniTfxcP6ilFmfNTy6yBrJPXyIjGiuk4CAJgzhWAPXwfMP6CLY
 kzrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734667885; x=1735272685;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C1oOVeQtXZQwGm0E7MKnqUzsP3l72cl2b6h7Zprs2aQ=;
 b=rcFztXZxPpVmAKORWfruzMBuHiF5cqOg31WOVhgMkdswDdF5cQjmWpdL/nPCy6WLON
 lIx4KUHZ+Fo1o2S8cNVOavk6KpiCikrJU8DkczQq3UEdFUEGtGyZmNGJDelHvbkMjvG8
 vEpfL/HOFbmqMiMFYiW0Pefpps62KIsZ/3McRSEzsHgRYnBm8HfsqXmRkeaM05lMIGyj
 g/8nA9PH2NCmifTcS9IKej4H/bMN3ZZCGrroOYvk0F+cHLJEoT1CqfS9qXjKDDvRGygs
 GncpMc1NOnKVNhDvP75j97gCAGHWTCdusBm+JnstYR5yy4J3UG47xalcNbxQE4w+M/j3
 YP7Q==
X-Gm-Message-State: AOJu0YwqWvN3pJKSKVXSqu6tHEFEs2MIGzEun42jKsMfVuFUvutBhV3A
 XY7PChGIVL7LL3PMt/eyma24FSqC0JfuicDrWWNtvJH5pouSxrffUYgHLOMVdkCLNB2yhKm/HMk
 5
X-Gm-Gg: ASbGncvVX/jI0k1gU/mPl4SAEczjwL8supj1pDT08pOu6taGQfuTVzVNumcY7KuPI1i
 /DwJi4fKvXMnLeLfKx1WDyKoepnzcmCXW7evaKG04lGwS3ONR8FTnJ6cE4nITrF4HbeT61Jm/MR
 XwwciZ1qzz4im5gTGU5/UW9CZ2hJJ8XTiPGvPTQg+PihKGue45c4XuXelGuST34PwiYeQ6njgUs
 jAMT0DcUiqJt+wqAjNR6RsuKkXaCpEpLwrsZc+2eW+SLC+/Qu0G9fQGCaBqFbU=
X-Google-Smtp-Source: AGHT+IGxlQUH//I6G62f7pg6rmB7hQbNTs6jnEnA4//6Rpa/StTTfsaSgCItsLkSALLKYbr0Yph2cw==
X-Received: by 2002:a17:90b:53c5:b0:2ee:74a1:fb92 with SMTP id
 98e67ed59e1d1-2f452dfd236mr2228302a91.6.1734667884834; 
 Thu, 19 Dec 2024 20:11:24 -0800 (PST)
Received: from stoup.. ([71.212.144.252]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f2ee26fc22sm4165260a91.51.2024.12.19.20.11.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 20:11:24 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 28/51] tcg/optimize: Use fold_masks_zs in fold_orc
Date: Thu, 19 Dec 2024 20:10:40 -0800
Message-ID: <20241220041104.53105-29-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241220041104.53105-1-richard.henderson@linaro.org>
References: <20241220041104.53105-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x531.google.com
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
index 9b351f0521..da9c8c4669 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2113,6 +2113,8 @@ static bool fold_or(OptContext *ctx, TCGOp *op)
 
 static bool fold_orc(OptContext *ctx, TCGOp *op)
 {
+    uint64_t s_mask;
+
     if (fold_const2(ctx, op) ||
         fold_xx_to_i(ctx, op, -1) ||
         fold_xi_to_x(ctx, op, -1) ||
@@ -2120,9 +2122,9 @@ static bool fold_orc(OptContext *ctx, TCGOp *op)
         return true;
     }
 
-    ctx->s_mask = arg_info(op->args[1])->s_mask
-                & arg_info(op->args[2])->s_mask;
-    return false;
+    s_mask = arg_info(op->args[1])->s_mask
+           & arg_info(op->args[2])->s_mask;
+    return fold_masks_s(ctx, op, s_mask);
 }
 
 static bool fold_qemu_ld(OptContext *ctx, TCGOp *op)
-- 
2.43.0


