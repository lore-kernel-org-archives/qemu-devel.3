Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C280E7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 15:32:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL26X-0004aJ-P8; Tue, 10 Dec 2024 10:24:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL26L-0004JB-6R
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 10:24:42 -0500
Received: from mail-oi1-x236.google.com ([2607:f8b0:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL26G-0008Mg-DZ
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 10:24:38 -0500
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-3eb6734004dso668689b6e.2
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 07:24:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733844275; x=1734449075; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Y9jt0KFPXZyKiMoWsnkqwHtvAy3ExqCj7/xmYuraDMg=;
 b=zC2WCdkhNZ2OOKQvUp8CppY3CycHd6WRVD8u9tp2Ek+iKWZFHknmZIk7/leRc1GWTa
 0eewv4AXsRQdlj/IV0FPw9uidaCl/3WxAyHJO841cYNDa7gs4VFL2fWgAXgej8sBgdrg
 OWPAvsNB5+/qmqEhzlvlVKAt/fY51IZmt3n2iLcBRTk5G3fRIvBgOjjG5fdKUChMtJYJ
 qm/EHdKp6RPipwF7TeF27yWHVfcgOSrO3dA7QyImE4waZ9LT3yeabaO16Zv0Q5eW7O15
 17FUzv2WlBHJPtvDs/3fJ+akTJ9Ium0T/G/ZhLTT5CZsePwVSphhnjB7qC5+QQNEsa1k
 KoWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733844275; x=1734449075;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y9jt0KFPXZyKiMoWsnkqwHtvAy3ExqCj7/xmYuraDMg=;
 b=NpdV43F4wiAhzb92qEFegbE+aFVXF/h2hS2vv7ktCDTeA/bzoxIeADWLQ8mlypwKwI
 C4rhWNVmRH9yGvv2fbbM9ICGPGloHFJtrX834g5XQ9jHBuYWPg8Av4tCyVslvfyvVLM8
 Q8vKwhpr6Kzpj6Nhw5fbPZD4FrzaHSvSNKrE3+99PQrW1x6AwfDc43KGCR/WPcXrOpAn
 xOmlu1hvEuPWWz+KRYYf9uB8PkZ5qFY8YvynGzQPgsDKFXDr0U/ZqyAkP0OHw5RbpPy4
 HBKIVOa4dMYv5gfHPvNg8aWR7vUh6ADhHCBZ0FvSxcGRBkfjLeQdGPxkjPQTvLpo4F3t
 Ak3Q==
X-Gm-Message-State: AOJu0Yz7xHicdHkSbnJQUwuPFY5T27esWNv/VnfZWKhOhL2NMetrp1E8
 Iz++x2yuxBD6Gnu+CE2Vsz4QV6IgtXFtmOTymlQmz5KAuh4UNB7EKZy1W9R2UxdzDBNlcXFQyBx
 MEEw4QZ1z
X-Gm-Gg: ASbGnculC0K0t5KoUzDBj6tUKiLARCMZkIdamTyJWiAcxGPAgARLcMUNvLQt0r0Dk4M
 vFvjNatvnzbhRkRnjMM6bBjQF5gzPoEyHw7gtLccTedtTZRrA6KgdTGoUjQSjhahDYrz9n68ltu
 7BIfjy6vh4Hn4YaDWdviZkLKRAmwYOv3vXxoSrKUZ6yAZMjgW9mAa9NlXe+UPPpP5Dfl9MfJQoP
 eDBObTyzbHgCu4zOpj0cK7F/X3oMz7xUymrG0I230voc37aYdTchBuKgMLphg==
X-Google-Smtp-Source: AGHT+IGPP3uettGPaPa8QOgZecIP9LmlLwfCfkANBFM5cWDxekd5UH57dssu0WBV3ieSh0SyeQCd1A==
X-Received: by 2002:a05:6808:1992:b0:3eb:74ca:4409 with SMTP id
 5614622812f47-3eb74ca44c5mr1330348b6e.6.1733844275412; 
 Tue, 10 Dec 2024 07:24:35 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3eb076b9168sm2776435b6e.14.2024.12.10.07.24.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2024 07:24:34 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 21/46] tcg/optimize: Use fold_masks_zs in fold_nand
Date: Tue, 10 Dec 2024 09:23:36 -0600
Message-ID: <20241210152401.1823648-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241210152401.1823648-1-richard.henderson@linaro.org>
References: <20241210152401.1823648-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::236;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x236.google.com
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
 tcg/optimize.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 111969c2e3..924ee165ba 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2011,14 +2011,16 @@ static bool fold_multiply2(OptContext *ctx, TCGOp *op)
 
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
+    return fold_masks_zs(ctx, op, -1, s_mask);
 }
 
 static bool fold_neg_no_const(OptContext *ctx, TCGOp *op)
-- 
2.43.0


