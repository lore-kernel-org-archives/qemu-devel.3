Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9DF6E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 04:14:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOUMY-00005H-2Z; Thu, 19 Dec 2024 23:11:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tOUMM-0008Qm-6W
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 23:11:31 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tOUMK-0006Nm-Rd
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 23:11:29 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2166022c5caso12522155ad.2
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 20:11:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734667887; x=1735272687; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ErYpV3fIN2iyazMtPdzOw45/hYntXah9WvXb1jyxFPI=;
 b=d3HyqZhtCkyNL1COP30X4hxu8ldFWEuQjj1f3lmsP0vlB3Cn8J5IzZznhu+PGDQgIr
 wbeLyPkE8lHWzUXU/sX+o3mzTttFDVNZU7Nlqm5ODQ9Vp215gt6NFI4Rxg4/1ngJajZ6
 lTV05ecwWnLrv08/iLcbTT5m+UVyWDRMIqu7v/4y/WfTPgjRoaoom2aJHvW7Ai2JEnKn
 aDt7WyGt98FH5hPZ6Hsqfn1kDBeEDzVFZtZMqEa97ccPHyAeOGUZ4iY82nMtBIroS3ug
 5Rmj4xSf7I+C76pJeyLdvmnLjsnRaRVPV6euQaL14YIO6VUSUHjkT++qFR6HowS84wWE
 10yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734667887; x=1735272687;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ErYpV3fIN2iyazMtPdzOw45/hYntXah9WvXb1jyxFPI=;
 b=CQBkkMME3/K4JImjIeLeDz0QvY4jJcJkq2YP04L7Xje1b6HiOpdManqw7NbJudMMJZ
 IjlvrPSmuzY24FkEGSosBc/qWbeHxQuB9W+W4kiOOs3JhNeWDhq0V83R7Ym8t7MHHZJ8
 JNDsX2ddbwI8BjTV6JDcP386JDmKQrYCKWniTDOt4bLfrdP1qteBHIvMiDH8aAiZENJd
 olGWYuxJ1Z05N9hdm+8KaegzelMStbILH7rLX2KCEV7mo6xeCyHid5l8PrsOUWnHQw/2
 cn3pABFs6mq+dzRiUJmpueBt1WWqUlEYkzFOar6RreZ57M0eHuPflSYHpzStyox4YMrT
 hRbA==
X-Gm-Message-State: AOJu0Yx/hnl+z4BQZp+5OlYkCQrrbN+6UFPpxk139a/yTuTQT6PHKong
 Tg3UNFC1iw+6UhssT37CNqoqHzIEZjJ4EnKbN92VWyJTgab6XxqekZZvjKMUijirNv37RpRhReH
 a
X-Gm-Gg: ASbGncvUTjpsEr6xv5wl9JZS2gIOayh8iO/2u0qFDNvOewPy7nEb2DkirQbOaHlag/z
 5DOTmtlri5dQvonEbzW1+iy53GVmi4wZU6LGWJUzNKL7x6bDm0PosOk/0KXeBIAPAeJQaTX+Enm
 jisNlbJl3dd8GWLX7T3dY93JELSfjvjnN57d1Vqun4Cna/dwcxHbJ3bt3rhijSDOKGcLwnYFemS
 LzcEzjVxfnpMKrX1iY7dNqoZOCsNtEtQIBNApbUI1pYeWdwbBqnaPM7/4FaaH4=
X-Google-Smtp-Source: AGHT+IEb//GitLKJCqdwDf/ha844alGaz4hey3hRe88hgd7qJTvn8qWRx6W8iMc9Wjj6/K7EYP7PdQ==
X-Received: by 2002:a17:90a:da84:b0:2ee:863e:9fe8 with SMTP id
 98e67ed59e1d1-2f452e38005mr2149258a91.18.1734667887428; 
 Thu, 19 Dec 2024 20:11:27 -0800 (PST)
Received: from stoup.. ([71.212.144.252]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f2ee26fc22sm4165260a91.51.2024.12.19.20.11.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 20:11:27 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 31/51] tcg/optimize: Use finish_folding in fold_remainder
Date: Thu, 19 Dec 2024 20:10:43 -0800
Message-ID: <20241220041104.53105-32-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241220041104.53105-1-richard.henderson@linaro.org>
References: <20241220041104.53105-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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
index a5a57bb914..868da884f1 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2169,7 +2169,7 @@ static bool fold_remainder(OptContext *ctx, TCGOp *op)
         fold_xx_to_i(ctx, op, 0)) {
         return true;
     }
-    return false;
+    return finish_folding(ctx, op);
 }
 
 static bool fold_setcond_zmask(OptContext *ctx, TCGOp *op, bool neg)
-- 
2.43.0


