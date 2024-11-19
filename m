Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F2C6D44162
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2024 14:25:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDP8b-0005q6-6n; Tue, 19 Nov 2024 09:23:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tDP8Z-0005pK-FK
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 09:23:27 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tDP8X-0006CB-9T
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 09:23:27 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43167ff0f91so39259445e9.1
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2024 06:23:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732026203; x=1732631003; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Uf4u1FQII+EcRWfJ9x1uUFpYR7e3NkroR87Xx7eXM1M=;
 b=amB41AV/u2T3TP4oyevnnMvuWWdsKBJLndE01rvlDvpciPLw/vEwMeXG1QHXYEGbtC
 FvW7Eufw1xTkTz7xeh2/34YWWJbU+j+nRfeiLC40x/DrZM1c4Qk3e3vHZj5v6HBxXjlt
 qZF/PTDQvWD5dabnshNFLRNssjCuFeN5ekCTUYDsDINDFt1hywjhIOXvsu4yGXRsXyHU
 sXeKgMKhS/YGkcX8noVl/WgRKGmE8tXQyHZKMedamvRVZRUpM9Go95znuNqBqwXhqkj6
 YHUyVgmx4dMdtTDcGKW4aun+519N2x8fcIaQBT7N9RSyzAvy5TsJe2q7ny6End1uHZUD
 CqAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732026203; x=1732631003;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Uf4u1FQII+EcRWfJ9x1uUFpYR7e3NkroR87Xx7eXM1M=;
 b=bRNtluvcHV5DB7pJMlkn7CTgynJjy0KWezsMaHJ5bM5WElrDYfio2INuBTOAKuK2ZU
 QaaPCNlOWiPC+1sCylzOSeXH3zM6dR75MQIGt6AZtd+vqF5pIefZaEVhirJcxlwTvhm9
 4Lp9JA48PcQgTmLYknBTbczLodmcy+XoV6s9qSd6/eKqnmd9RZQJEjqLWnYobNgCTmOI
 oMydEF8mkc7ZFVR0EwJGOz4p5DKEevv693DxsZFHZSQMm4GlT5+ZXqoF6gqhCLADcgmC
 75cdO7Sod0NIXEKFGJqmkQorSLZQ/+rg1dkncx7XXcBYdMW/zyZpqb5FoAXEUiqRK+fR
 yjJQ==
X-Gm-Message-State: AOJu0YwFUqHG5RqAHPq1RLQnST0glA1oPnoeSjiBPpVm685a6rQcYiaH
 HsBc5gx4MdMDNq/m35LNsQfsWK2p0niUclUvxzUTeFMudr8p5groS1AU5V9ZFB49GHBiRoQVSMO
 M
X-Google-Smtp-Source: AGHT+IEiW2dYC8JTrIAAGIkBUY6xCyqcj3IIIDaT6lWA0Ne3nUmin7D09uHAJ4uFtSYk5wtGacPvpw==
X-Received: by 2002:a5d:59a6:0:b0:382:503f:a323 with SMTP id
 ffacd0b85a97d-382503fa505mr1478473f8f.19.1732026203335; 
 Tue, 19 Nov 2024 06:23:23 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432dac21a15sm193049985e9.38.2024.11.19.06.23.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Nov 2024 06:23:23 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 01/15] hw/timer/exynos4210_mct: fix possible int overflow
Date: Tue, 19 Nov 2024 14:23:07 +0000
Message-Id: <20241119142321.1853732-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241119142321.1853732-1-peter.maydell@linaro.org>
References: <20241119142321.1853732-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
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

From: Dmitry Frolov <frolov@swemel.ru>

The product "icnto * s->tcntb" may overflow uint32_t.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Dmitry Frolov <frolov@swemel.ru>
Message-id: 20241106083801.219578-2-frolov@swemel.ru
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/timer/exynos4210_mct.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/timer/exynos4210_mct.c b/hw/timer/exynos4210_mct.c
index e807fe2de90..5c6e139b202 100644
--- a/hw/timer/exynos4210_mct.c
+++ b/hw/timer/exynos4210_mct.c
@@ -815,7 +815,7 @@ static uint32_t exynos4210_ltick_cnt_get_cnto(struct tick_timer *s)
         /* Both are counting */
         icnto = remain / s->tcntb;
         if (icnto) {
-            tcnto = remain % (icnto * s->tcntb);
+            tcnto = remain % ((uint64_t)icnto * s->tcntb);
         } else {
             tcnto = remain % s->tcntb;
         }
-- 
2.34.1


