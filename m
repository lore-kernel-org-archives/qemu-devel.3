Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32526E77188
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2024 20:10:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQBAy-0004E6-5N; Tue, 24 Dec 2024 15:06:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tQBAF-00030W-Vh
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 15:06:00 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tQBAE-0002eN-6D
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 15:05:59 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2163bd70069so55721945ad.0
 for <qemu-devel@nongnu.org>; Tue, 24 Dec 2024 12:05:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735070757; x=1735675557; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8h+Y/eSzKzpzMdEwoTVhqBqG5Af8LUZfpY4qbcHSiqE=;
 b=vCfSIZC6J9NwykaRVy+M8ysarYmX6Zyf1VpYCvABTbrg55FyCNHiHO4WYVFHhZUY27
 caZPspqae65GbcmJigVlqDtOg0mGhrVcwofLY0P2DMnbCYY2LJpZAYIY3buGfo3wDUAB
 4qjJioIMcZAO62qo4UG4LaXkjj0pSDuhiVdGRAjkrqBx6r+c43NxDZCqrebfUOYOUbdB
 VY7W4VeWgMkvCTs8qC4oB1ZA6zD8Z7hTGIEJjHuOHkPpnaLQIIg06U3cTYFoIcg9ipJb
 R/lOUY7eYG8aUiXicBt++OXddAQ74g3GsIOM7Tt95wSgMYLjV5/nGWv9Gx2ZhJHGeU5f
 /mqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735070757; x=1735675557;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8h+Y/eSzKzpzMdEwoTVhqBqG5Af8LUZfpY4qbcHSiqE=;
 b=HIwQz/jxnK11Rep7l9qg2DFJ2VZoUizVs8gffuJ8OjF16Lb4vRDESAzuMrEYPkXYrM
 OyIbBgcd1zdPM+MyX9mg2oWTBJlti1JiUm7tk0lqMcdBMXZ+idEcuD4CAC7hZoUNI02O
 XOtphRAz6jKmoS6P6Vl/CVyMUJFpobndnYRvaCk7xekhqaAHA8CbC11kL2C5hE/X9fIh
 jQQ+4r+jD6NmP42r2xFvmR/jAIqopeJyR3TRzh5DqCNXfgeGmuh7uA/xGBzVJ/WIbNpE
 qdnoexdEHddtB35Xuakw1j3o/BV19ISTywHT8pvFQssiZRcw7UHF5UyUJQjHCjN5WM86
 KBQQ==
X-Gm-Message-State: AOJu0YxOlNQXWhj+komtXWLQ6MW9hRepA0cLNQm4pw7ZSoazRH1beT0U
 btiLq3sadeuem5uaWBqI9xOlK/71JzQtubSDlIJvpRNUNSebOw6FpjRiZA0Mv5gmkn8KP0PPRvc
 SkGU=
X-Gm-Gg: ASbGncuy+XTkVgEkDql5SDDvup6QL2CoI+/21FzBBGjvsy6NBhvc9WhyArLhJwCTIs9
 yTVfLbmlKs3HkJcrq7MAbMsSmwJTbsfutz/OtAZjELmb2oiTubxr+/sDEtifyR+vmYZsdXoO5+D
 u6dl5KEe+Wxqoozzg5V2i5fT6Mabl8tfhY7iPKq9RDP+b6dfYVPAiap95i3BPdKW8pysfGM3Lua
 toXE7SVzBr/8ztOgvt1fvJkxURJGjA5FAvPECK5TEGmmODiaGwnHRR2tlw+oVHXQ5VzfXRr1+wO
 UEr5SN/1JeKdVcugcEBBJVdNpw==
X-Google-Smtp-Source: AGHT+IHgayS5U73VtZKb1EdZuWW/1r59vd+RxTBSpVMVW+x1e/2jiw9B+6okBe+BvgXy1Sl3hqFxyQ==
X-Received: by 2002:a05:6a00:3996:b0:725:9d70:6ace with SMTP id
 d2e1a72fcca58-72abdd8c362mr24044015b3a.6.1735070756949; 
 Tue, 24 Dec 2024 12:05:56 -0800 (PST)
Received: from stoup.. (syn-156-019-246-023.biz.spectrum.com. [156.19.246.23])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8fb895sm10027159b3a.162.2024.12.24.12.05.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Dec 2024 12:05:56 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 37/72] tcg/optimize: Use fold_masks_z in fold_setcond
Date: Tue, 24 Dec 2024 12:04:46 -0800
Message-ID: <20241224200521.310066-38-richard.henderson@linaro.org>
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

Avoid the use of the OptContext slots.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 678015a94a..74be827f51 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2367,8 +2367,7 @@ static bool fold_setcond(OptContext *ctx, TCGOp *op)
         fold_setcond_tst_pow2(ctx, op, false);
     }
 
-    ctx->z_mask = 1;
-    return false;
+    return fold_masks_z(ctx, op, 1);
 }
 
 static bool fold_negsetcond(OptContext *ctx, TCGOp *op)
-- 
2.43.0


