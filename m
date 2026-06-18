Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4588CD98E2
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 09:37:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wa9Aj-0003tg-90; Thu, 18 Jun 2026 05:36:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wa9Ah-0003tJ-DF
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 05:36:27 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wa9Af-0006BN-TI
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 05:36:27 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-490c1915793so5230485e9.2
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 02:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781775384; x=1782380184; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=rSiZndLvMJS0Q2dZVj2p/qMhwV43uRpLGeTiVqh9RAU=;
 b=buBN/FBI+kRWAsw/DC0swwoWmbR8UBATne9QTaW8M5zN7w4f63YGHl1p0kmYcSSQuV
 2tqHDrAL5xYYJ305JrFjVq9fqJL8jEUgXokagjoINMiFK2+gAwt8e3nIueKoEkwEo8En
 W40VMrolpFLGS1e6J4CWj8X3zLFh4mXmuFtSaRie8MaKlDcbYtP7iKX94pRwLLFqqEks
 Qsqz/1iboIhAJG271Lo8JqFTecam683NQLHbjNh8VlqIBPdUvv7K2oejkUyZCwOEgJOL
 JE8HMnfJluGE+pI3ccyeepTUHQP5y1rKuJMbbINgUlaBcq6YBh+krkpgWmhmc1UpET/v
 8gCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781775384; x=1782380184;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rSiZndLvMJS0Q2dZVj2p/qMhwV43uRpLGeTiVqh9RAU=;
 b=HTEwfkLEWmDKwBg76WkdfKaCEL0WUdtohSsgKLft+8SvGI8X9AIzKARq4w3LhI3Yed
 PPEImKO//OXvFesiPjOMUd11s9U+s0esL17t+Z1ydch8K6RAMyeerwrcpDtK4dJCpba0
 JwqKjgEF1Vpv4Tm7VNwl7Nin007RpWQB2ezbJtkK7Jtt9hajn3gFYUHq2mhLFqe9qeOE
 5+5CQMmEiZNArlbbeFsfmjmzszgwNHRAj+NbBy9fHztSfNEjURoTDucQlndlnT1ukfVU
 sygBDqEuiFJFcT1q1/q5KifoZ3qEdz8g8nrbmJJFIVyAVBVfMma4GEwmPLs6fsq16QYX
 jVaA==
X-Gm-Message-State: AOJu0YzHUQx9m5qJcCAGpW/8NGeS++NJfxP7Q+MYtbVKkePE+XCtg9Ou
 6tmHNyhiN3c4bDZjonnogr5JO1tZAPn/RiMCeo402vjw/a8nUPHDbUBRLPvtqCaFMhc=
X-Gm-Gg: AfdE7cnpKzfKxolIavByhnLTPjTzsYH58o7DGEEYwwqDGO6colOSC6Gi4ObhJL+E5tY
 NEQzaBi+bpHNiH5YmDFjNrrZETQmd1hriJSmWmK9SnXMZSfIdObxZ4XRLsfuce6h2oGMoIFwR/n
 w8UxjxAkAx6BvCXSAau/CEaMgQh2Y9JBfDqXxkRAXe8c0xk0+Ckq0ncOMLNIrBEexxGxHwPtKgk
 sBd/i3MUon01xK0hyN5VJAV8VKPGVV/ksbaavObAhD6GRT+YDAg6hxHEP2CX01dbi9qke11FSLm
 /WuVAr4aSLZHYYic62xt4veiuVyx0Mgj/G2r6moKnW1j2MXqj4y5q9AAeEKgm4Ln6YyCiJhpbwo
 UIMkh6PTkSQDzPZo5TqJDANpmF84cklNjs644hmdluMDOQQeXbMYpIklkjIZ+H18+v1bzGnNvJb
 2F8zn7wEKEQi/0
X-Received: by 2002:a05:600d:4453:10b0:48f:e3e7:3d39 with SMTP id
 5b1f17b1804b1-492341086a1mr88900985e9.11.1781775383667; 
 Thu, 18 Jun 2026 02:36:23 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4923a1d3fcdsm29456835e9.1.2026.06.18.02.36.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jun 2026 02:36:22 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B739B5F905;
 Thu, 18 Jun 2026 10:36:21 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Arnd Bergmann <arnd@linaro.org>, Tyrone Ting <kfting@nuvoton.com>,
 Hao Wu <wuhaotsh@google.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org (open list:Nuvoton NPCM7xx)
Subject: [RFC PATCH] hw/arm: use correct base address when setting CBAR
Date: Thu, 18 Jun 2026 10:36:15 +0100
Message-ID: <20260618093615.3793919-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32b.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This should point at the base of the Cortex-A9 MPCore private address
space. If it doesn't we will confuse the Linux kernel as it probes the
SCU registers and erroneously assumes the system is a buggy Aegis SOC
and nerf the emission of SEV instructions, deadlocking any WFE's in
the kernel (or QEMU smpboot code).

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Suggested-by: Arnd Bergmann <arnd@linaro.org>
---
 hw/arm/npcm7xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/npcm7xx.c b/hw/arm/npcm7xx.c
index c2bbcd89dbc..c27f149c04a 100644
--- a/hw/arm/npcm7xx.c
+++ b/hw/arm/npcm7xx.c
@@ -492,7 +492,7 @@ static void npcm7xx_realize(DeviceState *dev, Error **errp)
     /* CPUs */
     for (i = 0; i < nc->num_cpus; i++) {
         object_property_set_int(OBJECT(&s->cpu[i]), "reset-cbar",
-                                NPCM7XX_GIC_CPU_IF_ADDR, &error_abort);
+                                NPCM7XX_CPUP_BA, &error_abort);
         object_property_set_bool(OBJECT(&s->cpu[i]), "reset-hivecs", true,
                                  &error_abort);
 
-- 
2.47.3


