Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24244C021B3
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 16:23:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tl9J6-0006sP-I6; Thu, 20 Feb 2025 11:21:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tl9J5-0006re-FI
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 11:21:47 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tl9J3-0008Cg-Qq
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 11:21:47 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4397e5d5d99so7421675e9.1
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2025 08:21:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740068504; x=1740673304; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=hBoWtrDVPyHDSzSg/OfocB1lL8MLVaKLbdNJpvgSmCI=;
 b=TroAq0+MacuGRAkJON4DydToWFddUKqax5+UCOcGqrXV7Z+EgYXpK0ki4zWkGiWIxc
 YaoQs2WADz5NSDJIBWP7h3KOE5lbWaAP7f5rUB6r5dC4pMtDDSEDMj6bE+2SpM+XnXLd
 akx1VnMID8gynk1wWnKLvJ1T+MzefeWlf0NCvwu1G1Zv71XVJjDLBji/+ATQutCuEBuO
 dEJdXLGxDnuGGJ3N85Kf5YpZKyqra1bxM/m7mECWiw7Ne65FDF0kX2SvtiwhBwP1NuUq
 nL5HHAHBUXLI7gAT9sKUOfOWa7GCno/Fv/Ugj57XgbbHparryMNpdBGmJ1EOYk5c2lDy
 10IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740068504; x=1740673304;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hBoWtrDVPyHDSzSg/OfocB1lL8MLVaKLbdNJpvgSmCI=;
 b=bzzrv9n/sUo1M8xo1iKPOjuZu593ecmHRQG2yVG/VplWl+cFiVJeuBrhFF4UagU0/v
 Pau245f1exL6MT7Fboi5rpbmiu4WLOA0VD2GxR+xBQDxN+QyQJ1PDf+Ru4gw1Rt26hqV
 jbsHy3O3yj5C24/8juRMUUN6YUsUfgo8+yvXc0eMkI7u9yBm/NCcfcKJKWr2FUghYwJG
 zlWdC5A+eQZisAyJD+fbi2tJnJioYdOxXb6jTbk7yya8o6QujUoVlRjZKCDKc20KT8RV
 I6x5zxY+zWCqjtU48ti+yGjYohFBxUItmZRHUOxUInTJYzf71Wd3Gam34bClqzq1SjEs
 kCCA==
X-Gm-Message-State: AOJu0YzpzqSf0XTU27Mq+v0cylSsP0cgirqPX6wwoMiwf9vklbz0GPjg
 E4YIgtvKctKIvmoLjBdxRHy6SAjO0g3TtSDi9ERmTip/IId+HfEK1q85E7YqM374jGMy65OOspP
 u
X-Gm-Gg: ASbGncu/Q7ZBr2yseWA8k64kYE9EHIeA9vxE7/+Jh1b2E3waQxQw0TwMPvAYNZ8Z1sT
 sBJLaLm3BoNOJA1vkpASvZIKmJCJz1QkDi1yR7AD13S2W1oB5w5PZWEfSK3Zu+II7L04Ls8L6PH
 GRb3cIO9fT/C1xeSQV2ihFqFWA8QVI5SGEfbtxq67Le5V4s01w8D0HR+hccYqQjcgo/saHsEhVZ
 mVRnQlwd3KGR/B06SO7qWDWUt3oxEGmg/xkiYbYFrL0c/0iWLchNfV2/jo+Q3hPAxbg64kJQH3i
 UH8wjLsdVt+I3norXPlO5A==
X-Google-Smtp-Source: AGHT+IE90AnGM4oZ+oRC4LfY5zDILW1K7llDQXLD6welc6HfwdFeG0/dkNvk7Bx6eZZw7UsnDWVbfA==
X-Received: by 2002:a05:600c:154e:b0:439:a88f:8538 with SMTP id
 5b1f17b1804b1-439a88f85bcmr27774735e9.5.1740068504165; 
 Thu, 20 Feb 2025 08:21:44 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4399d55fc1asm48806415e9.35.2025.02.20.08.21.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2025 08:21:43 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 15/41] hw/arm/exynos4210: Replace magic 32 by proper
 'GIC_INTERNAL' definition
Date: Thu, 20 Feb 2025 16:20:56 +0000
Message-ID: <20250220162123.626941-16-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250220162123.626941-1-peter.maydell@linaro.org>
References: <20250220162123.626941-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

The 32 IRQ lines skipped are the GIC internal ones.
Use the GIC_INTERNAL definition for clarity.
No logical change.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250212154333.28644-2-philmd@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
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
2.43.0


