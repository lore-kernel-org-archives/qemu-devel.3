Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B598EC87FCE
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Jul 2025 08:12:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufwM3-0006IO-Dj; Sun, 27 Jul 2025 04:03:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ufwLe-0005AI-8Z
 for qemu-devel@nongnu.org; Sun, 27 Jul 2025 04:03:11 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ufwLc-00042s-Re
 for qemu-devel@nongnu.org; Sun, 27 Jul 2025 04:03:10 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-23fe2be6061so4506145ad.0
 for <qemu-devel@nongnu.org>; Sun, 27 Jul 2025 01:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753603387; x=1754208187; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8A2p50fg2lrocPlTL2vHTdYXWv0sBXWf3nT/JIz8EKA=;
 b=C87E6EkqCknoLZoMSb/v9s4gIXy2tX1480zD183lDNVHer1rg/H9/LVMCdrVw/TVHw
 scavmGM+Ha/pLPZ4T0SicJxIxkD2RF+lETqCjAC97cBmBh34CTttRkYQ7dsCqi08eeTq
 L/gICFChno/HPXgBmDfK/15QidlYlctb6/OHfQD5aMAcz9QzyMm5HIH2MtZ/Av3yGnsH
 tldHlgYqExOwQrQ/u2QQ+C0R96dS3vR5dyE6aQyRE+aDnII2kfYdCXvXB2qa1IPGco7w
 dq+JmfThMV6fnIr4HooHzz+GFwcDzE/8TzT2bx/s/Vtqat48N6U28KgZnKo3rk2KEG2a
 z0xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753603387; x=1754208187;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8A2p50fg2lrocPlTL2vHTdYXWv0sBXWf3nT/JIz8EKA=;
 b=tAollbOBZOo9wceJqlok2dFdWACz+nRCXUpV03UkmHmYEY5ugtJUlK1lvY3ytEZ/6i
 7RDfjsJQJfV3yibriZF+dhYLfgDGAtGPCjJ+n7GcQ8rn5ahUrhjd7Gu/qiOWDTq7TlOY
 kKdwOoQd8BjYRu9yg/gxM3naVPXv1/ynV08uMwcU2Y6mIZ7wjy3ndJDyw2SHX8lHvY6E
 OUfaauFjXsiLUxF0qmZD/LnHaKkGU9nb7KPtRr9PRYel/vSQQQ3dW6JJyomiGmXpZpgn
 yFLM5sGAjcbuWBSWnoQ08Co5NYav95JDiE0pp9qF2OBkLj94b8W37YZ/2RLCE01wzEpv
 7qKw==
X-Gm-Message-State: AOJu0YwPHP907R1H6eUYyi6EhI14dJ1/I6haVXPTSRzH2aAlTPvB/S7M
 myhLT3gISj2wkYl8k6zqx7nheVzFktkudBf5Qf6MYZo0bJaU9DSo7jWgrYyTP/e3C58N3ntiSIA
 VgTPz
X-Gm-Gg: ASbGncvBDbpMiPQ4/yCEIkEmbnl8X5iT+2N+dwI68lCzdGMd4AFHYVVetgvhIPRjldv
 pkMYLdeamSf4Y3df+QnW63Cnac0cvTm8Fn5fJvztPJdKTcNfxNfqK4pfizNbKLdi5dLw6N3HZ7a
 6J/1vD3T1oD+2S3JeLby80iB6HbXKHkUnJGoH2I19bPVh5Nrs8a9QLX8zkOlG+TvQvk15Xu4EQX
 7T4i5opxlxmZaj3aR0QfpRioaANBB5J+jQcfpjma59TzmGhuc8rJ7ZycEZtdeUI4LYIgkaqjEug
 oq8XqtjVthlqR6mWYr/eHg4eou5mopwON0l10cJeHYKpOFMhN/WrLw0JE0FJjO827MZ/hP2zU7L
 BeITJdi4gUIbeFWUlUuV5J2by7vywZtMaaIbjB8qIPbSOuuBYno6RsXz3ba2Ty4MZnlzsyda6JH
 uis6/bEOYXmSEHoYFuB0sA
X-Google-Smtp-Source: AGHT+IHf3wJsHXONbsv6Uf4y5Yowp0JbTdoHUBtuq5S5db/3aMTJ1/U4pGseHJ2GiebRIvyL4dEnZQ==
X-Received: by 2002:a17:902:dacc:b0:231:fd73:f8e5 with SMTP id
 d9443c01a7336-23fb2cc0818mr114605865ad.24.1753603387243; 
 Sun, 27 Jul 2025 01:03:07 -0700 (PDT)
Received: from localhost.localdomain (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23fbe333efesm30016415ad.65.2025.07.27.01.03.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Jul 2025 01:03:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 08/82] target/arm: Remove outdated comment for ZCR_EL12
Date: Sat, 26 Jul 2025 22:01:40 -1000
Message-ID: <20250727080254.83840-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250727080254.83840-1-richard.henderson@linaro.org>
References: <20250727080254.83840-1-richard.henderson@linaro.org>
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
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The comment about not being included in the summary table
has been out of date for quite a while.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 20b69a12df..dc6c82b7e2 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -4566,11 +4566,6 @@ static void define_arm_vh_e2h_redirects_aliases(ARMCPU *cpu)
         { K(3, 0, 14, 1, 0), K(3, 4, 14, 1, 0), K(3, 5, 14, 1, 0),
           "CNTKCTL", "CNTHCTL_EL2", "CNTKCTL_EL12" },
 
-        /*
-         * Note that redirection of ZCR is mentioned in the description
-         * of ZCR_EL2, and aliasing in the description of ZCR_EL1, but
-         * not in the summary table.
-         */
         { K(3, 0,  1, 2, 0), K(3, 4,  1, 2, 0), K(3, 5, 1, 2, 0),
           "ZCR_EL1", "ZCR_EL2", "ZCR_EL12", isar_feature_aa64_sve },
         { K(3, 0,  1, 2, 6), K(3, 4,  1, 2, 6), K(3, 5, 1, 2, 6),
-- 
2.43.0


