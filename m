Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A4B4C0218A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2025 18:26:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdZEl-0001Q1-4Z; Thu, 30 Jan 2025 13:26:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdZEL-0000kX-GJ
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 13:25:33 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdZEJ-00014j-QO
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 13:25:33 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3862b40a6e0so785198f8f.0
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2025 10:25:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738261530; x=1738866330; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t2o07b5g0HyyxOGpJQed/+y7o4V48M+fBcZRdRcyuiw=;
 b=PwILAHdr1WZj/+x/ejnmhC/tD7zPsERQNUOwSvHjj71pcwdElvf0y4lUKXzzXUPBhP
 gy4R1rl5sr3Hylt8H8FjfxKMV5vWQvtbP0FMNUBsAWf9PHICxbrr6YzcWc6nmyr4YIUK
 WSrGkxmah73cJVaRAtCJjOh7UOfOhIT3krE2xtNLMqDKhqwASwvvYKpM/e4hj83RBow0
 WKwPBl4Wf/HnvSPfw0eTxLioUwxOp9CFjlUvjh69byKfhlchner4faop/d/JQ/sq1DgT
 JF3GfySerCQKn9GW3Wpcc7JLzJOtjRIz82c+nC/KWZ9jGzNiGkrzsAIVCjgTWpFvzbJ2
 ebxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738261530; x=1738866330;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t2o07b5g0HyyxOGpJQed/+y7o4V48M+fBcZRdRcyuiw=;
 b=gXikOKBz2e+cYQ5y6SG6ICW/rS7zk2+ZUdPdwYp0ZXEsQNbJhOu+j4CXL5EsAT9C8K
 IFf6E8Hs0sQRwMmy3p2XyxEa8KkhljcbpZuaZ+Ij0lw+YRD6napGlT7aJGXVxRm/8ANn
 E/HH6JIg19guzoOIGkjuAX4cv/KFOon2mDu8vOdV93wSjlTbJBf1R+kc9nRIHrn2z+8a
 KpMhStd6/OPl8QKNa4vN1ualiUtzz8wNdI4sLwfbJ1IbV2tbPCtr/AUx7RhFu0S4f4k/
 HhZJk5SX+s8wfPM4Lf2txwDrzUMGAqy6m02EKvUo47Fw3IDPOzmHqV/fRvETxqdCKuaI
 jjFg==
X-Gm-Message-State: AOJu0YzNWkog5ReFyks8XEAfF2xc186DZVoDmGE9p28mtCJ4qIfq3VSY
 USGv3ewEB2rKHLm8qLcV95gGBLWTRi1XgFQjPn3byd/65/NHqVPLdvnl7/RvftC6SX/2hq1FvYX
 XYco=
X-Gm-Gg: ASbGncsPYy9PY8J6hAM7SeBs1P0QN8KYwffi6K/oGioBtRjh2MwPmfZk4HCkbE7QKHb
 waL7lez3k+vDWnsbEh3N93yYmC2ePODnFMVjgSfBMES2Rp9j0TZJpFuHM0zmNcFGE3KvKABiqqx
 unwAvEEg4kzjKaVFFYj7N5i6oIC/UwbyhGBsPLqPJG88AiQjUubg2QRsqfU63uaALKONzZ7QkLX
 1gzkQ28Yot3mux3x3YqjfyB82Z6qSfgs9suIShQpYXfRbylcjfx0LJghqpi8FaZpO7243Imywiv
 w6vFf9W334q6LxBOZSY0d4jaZkirXelSse26rPa1fLTRUMCT0n/tntfk+FWAvb8hVw==
X-Google-Smtp-Source: AGHT+IEnd37AOkXrN46UJvHrpeP9814E7CaHA5PfaeV4unfjn/p2NgrbC8UYeTDUK5HRwBMXSmyVYw==
X-Received: by 2002:a05:6000:1788:b0:385:ef39:6ce9 with SMTP id
 ffacd0b85a97d-38c5194c69amr9501640f8f.21.1738261529733; 
 Thu, 30 Jan 2025 10:25:29 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c5c13a0efsm2733042f8f.60.2025.01.30.10.25.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 30 Jan 2025 10:25:29 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Rob Herring <robh@kernel.org>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 1/8] hw/arm/exynos4210: Replace magic 32 by proper
 'GIC_INTERNAL' definition
Date: Thu, 30 Jan 2025 19:24:34 +0100
Message-ID: <20250130182441.40480-2-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250130182441.40480-1-philmd@linaro.org>
References: <20250130182441.40480-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

The 32 IRQ lines skipped are the GIC internal ones.
Use the GIC_INTERNAL definition for clarity.
No logical change.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/exynos4210.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/arm/exynos4210.c b/hw/arm/exynos4210.c
index dd0edc81d5c..99b05a175d6 100644
--- a/hw/arm/exynos4210.c
+++ b/hw/arm/exynos4210.c
@@ -393,8 +393,9 @@ static void exynos4210_init_board_irqs(Exynos4210State *s)
             }
         }
         if (irq_id) {
+            irq_id -= GIC_INTERNAL;
             qdev_connect_gpio_out(splitter, splitin,
-                                  qdev_get_gpio_in(extgicdev, irq_id - 32));
+                                  qdev_get_gpio_in(extgicdev, irq_id));
         }
     }
     for (; n < EXYNOS4210_MAX_INT_COMBINER_IN_IRQ; n++) {
@@ -413,6 +414,7 @@ static void exynos4210_init_board_irqs(Exynos4210State *s)
         }
 
         if (irq_id) {
+            irq_id -= GIC_INTERNAL;
             assert(splitcount < EXYNOS4210_NUM_SPLITTERS);
             splitter = DEVICE(&s->splitter[splitcount]);
             qdev_prop_set_uint16(splitter, "num-lines", 2);
@@ -421,7 +423,7 @@ static void exynos4210_init_board_irqs(Exynos4210State *s)
             s->irq_table[n] = qdev_get_gpio_in(splitter, 0);
             qdev_connect_gpio_out(splitter, 0, qdev_get_gpio_in(intcdev, n));
             qdev_connect_gpio_out(splitter, 1,
-                                  qdev_get_gpio_in(extgicdev, irq_id - 32));
+                                  qdev_get_gpio_in(extgicdev, irq_id));
         } else {
             s->irq_table[n] = qdev_get_gpio_in(intcdev, n);
         }
-- 
2.47.1


