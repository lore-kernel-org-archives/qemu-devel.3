Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79277E7718D
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2024 20:06:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQBAF-0002ud-Im; Tue, 24 Dec 2024 15:05:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tQB9z-0002nd-W2
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 15:05:44 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tQB9w-0002ZW-SY
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 15:05:42 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-21631789fcdso46982295ad.1
 for <qemu-devel@nongnu.org>; Tue, 24 Dec 2024 12:05:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735070739; x=1735675539; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rao1rvqabzx7DLwVY1TOu70R+eSLvWsnttr4yGctDGo=;
 b=WmxItP/S7QF9ctcufawOtNDdiNWBk/r9fCflyMZZphYnqAqMclwARtRG/3AGiFVgAb
 3REjllXoMo4g9Oz5neweLnErUvICTNKg3MePkz3cnRlQb1wvHb4Tvt+kH9TvdjHKtzkZ
 S0VINMdJyfiC5Zg5AJUnFr8zJQkzaZsUUT01fvDWuCcbQLnkRnlEWy5pIpEYqvvXbvG+
 evN1DOeygnALbMYLxk7lix8lmFRgwz/kyCZtlsbSqLm3sA5x+GI/O0K/Ylcy7IFxtCgy
 /b3CC5pmXLIA4tAHDjEDqIwBglSRkJzZ0OpXLpIYcJ9ZBz0mOqj3RiN3q5xs4Kr1EgfD
 uS6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735070739; x=1735675539;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rao1rvqabzx7DLwVY1TOu70R+eSLvWsnttr4yGctDGo=;
 b=Yq1HNW17z96wm7+zo7xykARo8OF8gLv263AOZ9Y67SwGGTLojKCMfm6MnVaC/WKXpV
 2ztuij6WA5sEYfII7oq2Dno1d9KfOLSDcfd/6XNaXuToeVBdyQVZFmJirBBsw0nMXnIl
 cDTTETQjz9OrADbSWA1Pc59ShdXsCDczLYsjHGnKCg0ySd3FAe5s6FqfLyMrAwBvdET8
 i5P3IkeMenSFDkgypYalCam0yGcklP7ZuJyIjZopIRk9QBrYRqYpbFi5NQC2uU8v/jyX
 XIQEhVfndEun4GuCk0KTQRgu4bbh0YTO1N6gx4x7OOX36hCvuE3ItNV6bBfXYKTCV40H
 eytQ==
X-Gm-Message-State: AOJu0YycygkGGrxIDBAm1KAqB/avq+zWvlQBd7U3ffm7V4uovlAT8woJ
 7cyxkBrzJkWwNovO4ypSM1a9NnEfkncoV/NXnFA5nrrpM4kl6znB6JsQvMVFyY1KejhOUtIZ5tU
 Hn+s=
X-Gm-Gg: ASbGnctw4K+oM704jl1R20QA1iGUqgyANRkcLMQ+ITzvh3eSIlja6IY6y1H645HWfRZ
 qHweDMkFBxY2x9zDAxPOitFbJjY2TPpb/nH4fPHukzAAzj4QiP7z8O1KoDUtM+YoMWtq18+sK3E
 q8Kttko4URNoCfBh017JdbBPo28DmTtG8lfuXrTvZ9K/Hi9DuWJQRxyj59rnxHxzAAIoh2BDIN1
 rpcQ8U2ouSDjO6sy2fCiuTpM3epcgNWEdtzdV/2MhlLRjC4GChp7xnIS9FrpTPin7/PQWLD80fP
 6qyMz6aPiSklaMVcyn/3BUp5VA==
X-Google-Smtp-Source: AGHT+IHYFzSImgd1G//M0utNhf5UnbO2e6Y/WuMcRLKsZ3NmbJNTZtZ9K7iYGy6zKBAtKk3Z9+bAZA==
X-Received: by 2002:a05:6a00:21c6:b0:725:4915:c0f with SMTP id
 d2e1a72fcca58-72abdbd7f45mr24738959b3a.11.1735070739384; 
 Tue, 24 Dec 2024 12:05:39 -0800 (PST)
Received: from stoup.. (syn-156-019-246-023.biz.spectrum.com. [156.19.246.23])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8fb895sm10027159b3a.162.2024.12.24.12.05.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Dec 2024 12:05:39 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 18/72] tcg/optimize: Use finish_folding in fold_divide
Date: Tue, 24 Dec 2024 12:04:27 -0800
Message-ID: <20241224200521.310066-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241224200521.310066-1-richard.henderson@linaro.org>
References: <20241224200521.310066-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index b774c96f49..a68221a027 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1688,7 +1688,7 @@ static bool fold_divide(OptContext *ctx, TCGOp *op)
         fold_xi_to_x(ctx, op, 1)) {
         return true;
     }
-    return false;
+    return finish_folding(ctx, op);
 }
 
 static bool fold_dup(OptContext *ctx, TCGOp *op)
-- 
2.43.0


