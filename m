Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD514E77188
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2024 20:15:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQBAu-0003x9-Ur; Tue, 24 Dec 2024 15:06:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tQBA3-0002oy-HY
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 15:05:48 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tQBA0-0002a7-SH
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 15:05:47 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-21654fdd5daso55264825ad.1
 for <qemu-devel@nongnu.org>; Tue, 24 Dec 2024 12:05:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735070743; x=1735675543; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nPKsdrymAAbkS1XKYSlzg/E9Iz2RPvK/Ig74oqbHXos=;
 b=KtDNWgXBIbfNnxpSO+WVubHDXDaq82UBn5/iqJzo2oF5j1HYgsgqfI7PNnOCkvYd/r
 5i1zMqVjzPN6v9mKfheacMqR9ZKvlWoXgjqhXMLgH36M8VGbibYlFtRujAV9+u0Wm4LW
 eRInWLyEm2ifgWK7A04DkSU3JENgp+yq2a8n3ryb3X2bmurIE4k0cyydy8xVEltfgYQM
 sqI1I2iPcxonIeop6BS+9unXfef48x04AgVF4cQ+fJMjmrQyRn0hzsnuI2tLRQprTkTc
 r1hZ8ZwGpFutPnKSxbb10EYJX/AkNRicC8I8E79FdZ7N2aGQN4g/ArvCUsjc7o0EBb1s
 5Vvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735070743; x=1735675543;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nPKsdrymAAbkS1XKYSlzg/E9Iz2RPvK/Ig74oqbHXos=;
 b=cBwseDxNDu8gm6yepwd1GIaZg2MYPr53M93twH1sCKWtbexPcXUo7V4kS1CoYl4jYq
 5yV+biS4VaRlA4zNfN+Y4BW759uzEtjlsbtO3esUn6ebZF5dBZku4aBxnhHr1u8G7Vl9
 v9nYlfMfOe7yrPD3jtTPmyP42wpY453QKtrLjoxZC12s3PHGdZxnNDiJa4VqSX2qA3W1
 IGWSZw76YnuknnTutrrn2xy5+ZJNtQmUvdYoIlIj9xXd3LLrAVWd8bJefrGFIQXnvgoE
 7GbF4vOPM+bHhPjglBkD/RtCXNLF6fdvTz8rS4LRfXb5CqcRFnPZWV+AipNyMdrse6Nv
 ooiw==
X-Gm-Message-State: AOJu0Yxm6Iq0rf7nu8iDE6egM7+r7MDOBunBVD6/byCa31IVrZngbM/T
 KC27jAeo5U6xNmULBJ1lNZidHyl+bbYIpq8wzV+0Zh0qtpOl63DsCuhSKxc+igCcvve5wAHWKkT
 npKs=
X-Gm-Gg: ASbGncsavEErd9bPSzOcYjpJ4MmYATwSbz0wxtJAR6/h+prDKKvQOfRt6MBwrJKDQPL
 cwQRTwfFk3vWrlijBiPjtv8ln5rkTSQgjy32kuLHsnUdwzefhghjzyGir0Uid1iI2udI4jjKge8
 zh9IS13derva8ByTGmn3Sk6/AJFxLRtRSuRLPHArAH/CHL/c2QpN4uFZZmF8vImUGNKYoktm2KX
 O6ITeK63ZFMLwngs1ekIY04X1efULdDEaJUjkFrCwpBoiG6KUO6+FVA2CgCEMyHPkeU15VFq2rL
 PE4qC9UQuX+0yJyugJKUHDnqkQ==
X-Google-Smtp-Source: AGHT+IErVbyki5W6GzBGG/WE2+PDzd+Gk6d+Q5AmQ2rUW14Tyi7PnnSN4IASIFQGacfsSkR796xlSg==
X-Received: by 2002:a05:6a20:2d07:b0:1e1:b44f:cff1 with SMTP id
 adf61e73a8af0-1e5e07f9c06mr25390234637.33.1735070743264; 
 Tue, 24 Dec 2024 12:05:43 -0800 (PST)
Received: from stoup.. (syn-156-019-246-023.biz.spectrum.com. [156.19.246.23])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8fb895sm10027159b3a.162.2024.12.24.12.05.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Dec 2024 12:05:42 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 22/72] tcg/optimize: Use finish_folding in fold_extract2
Date: Tue, 24 Dec 2024 12:04:31 -0800
Message-ID: <20241224200521.310066-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241224200521.310066-1-richard.henderson@linaro.org>
References: <20241224200521.310066-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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
index 8111c120af..04ec6fdcef 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1773,7 +1773,7 @@ static bool fold_extract2(OptContext *ctx, TCGOp *op)
         }
         return tcg_opt_gen_movi(ctx, op, op->args[0], v1 | v2);
     }
-    return false;
+    return finish_folding(ctx, op);
 }
 
 static bool fold_exts(OptContext *ctx, TCGOp *op)
-- 
2.43.0


