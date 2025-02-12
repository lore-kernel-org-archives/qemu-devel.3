Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80D50C021A4
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 15:44:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiEtw-0004Oj-NY; Wed, 12 Feb 2025 10:43:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tiEtu-0004Nl-53
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 10:43:46 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tiEtr-0006sK-KN
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 10:43:45 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43690d4605dso48146135e9.0
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2025 07:43:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739375020; x=1739979820; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UeIZFp/oTPSZTqhQVQuuyB79ED/0E39RbO6UofIGgaE=;
 b=MemEiYgbn7cz9bCXJgmJrLDGqBPFtCKQXZLXvDOeG1eZbz86R2qLw8gdVIZtbRD+pV
 2HqnPAEzVLHTyPajI7QdPU7rZwCvnGgOGQsOh4nwXx62NXlS89YH7yEDixXad5BEH6IB
 E4qgNIzRK9mprO8RoqzmW24l5/oWY3vGt2+rsKK/Zn97bzBOzhz/zstKNzCJxh2XAd/q
 3Rqwxvx2uScDCl3or8pDf2tstOlYnJnYvVCngvuRm4aS+aS5fA8uAXM9vuqtTpUqVsEF
 YQTBOIPDu5kO3WPYEHuLwJ17LVd5ilX83RMXnro8Hfe3YhRGkWz/QU7/1wYC4y76/NuM
 mmkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739375020; x=1739979820;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UeIZFp/oTPSZTqhQVQuuyB79ED/0E39RbO6UofIGgaE=;
 b=ICOrSEmD6Kd7e8UeokUrcIgGm3T5caN0GIaaPiPRY0uS0R8ssO+3+V5naJdpbN7dDd
 hBkRe27x+c3eNpV5rOsRaOGCg/PyE7SrzmHf5QOajxV/Zi0UE9ZR+VBhKf1gHVcwgISu
 KT/JlL0uF0iX6GsdxovGuwBGkvbch+BgT2tjbP8se8WnKdePFB2CnsQZXZhugHGlpTVr
 o6ZaIwMXi59jLwcugfYhpEG/DcO4/LB2mobiZaEaXwrQDc1IW/oO4UOqUDgjxSmVQkUO
 kTzHzJbK3ckDMOlYfSuCvgJJfZxWlDwv7X4DSf83NzMBMHU2QG3x4/lRWlgQRLP7EqDg
 4zng==
X-Gm-Message-State: AOJu0Ywlv9WrKeEEYq1FGwsrbUa8OiNbW7WtSAHaZUGlMpF3k7kGTMIa
 fJEFO4F0xzdhd90RItvR+bYhSmF3BF845goBU7q+igRouU+QvtQrdRkcmo+ZtH+3S0AErMcO0gf
 T/eo=
X-Gm-Gg: ASbGncuo9+rJjyay++PyYullOnvin+/CAzzyOJ+LtA4pedsMtf3j/8WgQZ4CMo59eRb
 w4bIwIa6+BbHJFU6fpaLDMeOws7+dAqyqpPtnTQqW/jXw6T7tJCPK9S9V/hMWN7wlTzYMF70BF+
 zw6xc5NsMlvCDJVnfHvJ9iqd9qr+i7M7xUCRIONb7qUVP0j4+v1n1W0ZRxKlJPCo0s9w435bMLH
 2uxCU5SsygqgZjyE3xIAW8o+ywFD+qK+ME/+7PbOjNAwPppnBJSKV6js9kJpvBa0IzCn4MhLvS7
 uFGQSS5Va+XYhOhnlfmftQJFqUwbRQW5g39xp8isq6wsUjmyb1PMFgRoxmFN0aKM65meDbQ=
X-Google-Smtp-Source: AGHT+IFrKzc09FEdRSJAcWB+MR349tffpREeexa3H210eVTiS/pMCiajyIKlsJhsxY7/ZAzxcaPfwQ==
X-Received: by 2002:a05:600c:4f85:b0:439:4376:cc0 with SMTP id
 5b1f17b1804b1-439581ca7fcmr29685005e9.25.1739375020549; 
 Wed, 12 Feb 2025 07:43:40 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dd8dee385sm10812262f8f.61.2025.02.12.07.43.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 12 Feb 2025 07:43:39 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>, Rob Herring <robh@kernel.org>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 1/8] hw/arm/exynos4210: Replace magic 32 by proper
 'GIC_INTERNAL' definition
Date: Wed, 12 Feb 2025 16:43:26 +0100
Message-ID: <20250212154333.28644-2-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250212154333.28644-1-philmd@linaro.org>
References: <20250212154333.28644-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

The 32 IRQ lines skipped are the GIC internal ones.
Use the GIC_INTERNAL definition for clarity.
No logical change.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/exynos4210.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/arm/exynos4210.c b/hw/arm/exynos4210.c
index dd0edc81d5c..b6537a2d64a 100644
--- a/hw/arm/exynos4210.c
+++ b/hw/arm/exynos4210.c
@@ -394,7 +394,8 @@ static void exynos4210_init_board_irqs(Exynos4210State *s)
         }
         if (irq_id) {
             qdev_connect_gpio_out(splitter, splitin,
-                                  qdev_get_gpio_in(extgicdev, irq_id - 32));
+                                  qdev_get_gpio_in(extgicdev,
+                                                   irq_id - GIC_INTERNAL));
         }
     }
     for (; n < EXYNOS4210_MAX_INT_COMBINER_IN_IRQ; n++) {
@@ -421,7 +422,8 @@ static void exynos4210_init_board_irqs(Exynos4210State *s)
             s->irq_table[n] = qdev_get_gpio_in(splitter, 0);
             qdev_connect_gpio_out(splitter, 0, qdev_get_gpio_in(intcdev, n));
             qdev_connect_gpio_out(splitter, 1,
-                                  qdev_get_gpio_in(extgicdev, irq_id - 32));
+                                  qdev_get_gpio_in(extgicdev,
+                                                   irq_id - GIC_INTERNAL));
         } else {
             s->irq_table[n] = qdev_get_gpio_in(intcdev, n);
         }
-- 
2.47.1


