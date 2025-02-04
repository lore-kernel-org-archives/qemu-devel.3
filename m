Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98452C02197
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 12:52:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfIOF-0000gH-55; Tue, 04 Feb 2025 07:50:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tfINr-0008P6-41
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 07:50:38 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tfINj-0002CI-Jd
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 07:50:27 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-38be3bfb045so4313985f8f.0
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2025 04:50:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738673420; x=1739278220; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vewycir3LsXYBCZZr4GGAFtxfOcg8znbIbn2DHI7Kek=;
 b=zlEx0qkC1FPlr9lkVtjuUBMZcQcRlJEVkJPPBksoxNObMe/DpEsPMZcESi4V1II6cm
 BNTcdUcKDjWRB84xSWkdSEJo1z8RFJmecmlqooyUV1XWubmbbd7+4sll6AhH2kCjQwWv
 NdRKvD/4mcUqge+2amZwImhwk1oazKHMQPzRatXSehSCXdKdTJDxaOeVi78praW27TW1
 jPYyG3aw2jUxO/beuy5BpdE7PDfgNmmj6slKzvO8PA2CafIkzqgnT8jDi+zwC5aPP1G4
 9kr/I8C0xvkXJOODmt6ipQes0ylGAM2HODLbytcyg/6ErOc5TzoQkD+owodVTXXqm3io
 kRKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738673420; x=1739278220;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vewycir3LsXYBCZZr4GGAFtxfOcg8znbIbn2DHI7Kek=;
 b=i3g3eN8Wu8ADE9dT699rBVl3DWirtbBwxjD6P2PSaMzlnj6wOfZYIwkHzJyOT6kqr4
 n56vd65RyAbitHfKtsm7dwkmVTnn60Lx7INxxBtZ/QwiLwEuc7F4cPTLe7ywflhTvH9A
 8f+QuTb5sLq/3XNiQf4NO3fhacgpM/Eoe7hRVEu6Yiu+waHekJSqo3VRfvs6fk93Dkt4
 HjiZuY4eu8y36UtgB1EOxu0hUyZ9h01RGOddfMRSkEJfYv/4ppB+wvXXUvull0jFp/jh
 oUO/9mWJ/VvJ73dPxCZV3qFEKq7lAlegw8I5nRJKrr5BD9DVM1Mo7ujwmVKsja12nKvr
 ip7Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8X6M8dfQ4woWVerwEwX2NgT5sApT1ZQZv5GA6VY6w6TCZwk/H2ziqI+Chasq/Od/2NE5ULO05Wbc3@nongnu.org
X-Gm-Message-State: AOJu0YxLB2jFJyc+1HeEqbwR649tgmaVatH3mdTLVslwPuAsSdpwuDYO
 8zL8bejx2Daj9ybjtjDBSEvNYOZH4iUJLPqDgN2TV4jdM57bZ937q53V28kVCWVJ4vX6mIMKkDy
 8
X-Gm-Gg: ASbGnctdNTnWQya5mOhksxmbvqDLEXD+k7wfd7Z+Fnted1NR4/ptlVA7UUPmQ4HMqkK
 HiCmov4jLcZjYoVxGdn5ivT74EJQD/1nnz45sdfy+kXwtkTvKEjvT/8w4yu9/1GxVBiDMcEQZZv
 yB9jG3Bn6rRKsyEbWjUsQcBQCkhTsyB5uBQ3XPhw4IwtW84ubcQjvP6FLyRDl/nJ25P2eVgWJbH
 pHQW7ObH2pwrYueYQbS935wPYuGrlsVj7h9MwUKI70tGzyVoZ55itK31MI87E7mVOwMJqW2Dg1+
 AXczy23W/18X5VfUrDamDg==
X-Google-Smtp-Source: AGHT+IHl/OfJHZjDcYYCYWFSB8H18IO+6VB+QVpj1HwxaW8VSj4pss5fGQbNvQ24hIUQxGay3pEDKg==
X-Received: by 2002:adf:f54f:0:b0:385:e328:8908 with SMTP id
 ffacd0b85a97d-38da53d130emr1928487f8f.29.1738673420572; 
 Tue, 04 Feb 2025 04:50:20 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c5c122465sm15757919f8f.47.2025.02.04.04.50.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Feb 2025 04:50:20 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v3 9/9] hw/arm: enable secure EL2 timers for sbsa machine
Date: Tue,  4 Feb 2025 12:50:09 +0000
Message-Id: <20250204125009.2281315-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250204125009.2281315-1-peter.maydell@linaro.org>
References: <20250204125009.2281315-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42d.google.com
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

From: Alex Bennée <alex.bennee@linaro.org>

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/sbsa-ref.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index 6183111f2de..d69e7aaa95e 100644
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -484,6 +484,8 @@ static void create_gic(SBSAMachineState *sms, MemoryRegion *mem)
             [GTIMER_HYP]  = ARCH_TIMER_NS_EL2_IRQ,
             [GTIMER_SEC]  = ARCH_TIMER_S_EL1_IRQ,
             [GTIMER_HYPVIRT] = ARCH_TIMER_NS_EL2_VIRT_IRQ,
+            [GTIMER_S_EL2_PHYS] = ARCH_TIMER_S_EL2_IRQ,
+            [GTIMER_S_EL2_VIRT] = ARCH_TIMER_S_EL2_VIRT_IRQ,
         };
 
         for (irq = 0; irq < ARRAY_SIZE(timer_irq); irq++) {
-- 
2.34.1


