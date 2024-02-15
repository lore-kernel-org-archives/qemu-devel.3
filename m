Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0239BC48BEF
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 18:05:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rag2q-000292-Tq; Thu, 15 Feb 2024 13:01:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rag2d-0001qa-Ic
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 13:01:03 -0500
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rag2b-0002NV-9M
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 13:00:59 -0500
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-563d32ee33aso389800a12.2
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 10:00:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708020055; x=1708624855; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wCixPc5ejXKwZhVB9bkkxqa2YbnJN4g2k4IE6KKAtos=;
 b=lLWAjgXK22LykSCnqz+Y+qSbXQTrmuACIeHqtsiTCmPPjbeufEaNFzBokhVhkXRUnO
 Y34zX95dSc46+VZpEOAi7xQAlEFT71KdXTu7ydNsrIxwOwUBAnYR9Z88T5CCrkL013xa
 09yZgPNfWV1hEwRLjVXTi/PIygdcfUYWi5U6K7OOxLHwD6gc5jgVGZA8SCA2Q9BSG0bc
 /dxA0aQ5+j2V7gl1STx5den4B340pmfoxM4K4s0s/KONWeWL+R0NYrJFceZaIAMnKwMw
 s/5M7Tev8dKnz8bYSMWTIOE/BRcfW/edOjosQ9WQofkB2QI6/jj7qR3UrThJCphUEHSX
 evIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708020055; x=1708624855;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wCixPc5ejXKwZhVB9bkkxqa2YbnJN4g2k4IE6KKAtos=;
 b=X5cVgKj6lUtT4c82Eqz03/yYNX1XIGUs8sYg41V0yHuLsaFMc0xCJ0oAMq3t+qC50J
 ojQbrDbW+Pd8Bp+vH5BUTBGZfHIU9upv0pyeEpd0CDSsr+DhgmvfNY0Mocunr4fRMfF2
 O2qe5QkUJL21oqGLmrfrbDZAQ69LvUc8bkem043dQdUiwFt5t+sWsPydnewZQNOxFKXd
 FBt1H/c9GTXmJN0DpeQe9yBXmUociET/pac9wvFwqySkmWQnIhYG1/aw2tCmRO3pUf+i
 U46hXxera6Qv+JXpO/oitFnjFwBUzzhXcbWltsjf9E0TENc59QBGIfswKmHZZ5dr2TDy
 5PqQ==
X-Gm-Message-State: AOJu0YzJLNQwxJ00d6eniSvpT/VftSeT+9H7uHMG/dbL4UKtA+tPkyxr
 FnkzJdqSUds5FAYS4XEGO/n5ClGG6W0Jdv1lm7Nu4QtJp+xB2+zBo+SKooycr+4q2kcG9EpkJXi
 zbqo=
X-Google-Smtp-Source: AGHT+IEGo1l95C6gX8jXmf36kvSMU9RqyIDd79hxzK0LRyd2FFUxkmT0VHHhfT42srN7qBrwNQ7irw==
X-Received: by 2002:aa7:cfc7:0:b0:561:51a0:2e07 with SMTP id
 r7-20020aa7cfc7000000b0056151a02e07mr1803461edy.26.1708020055331; 
 Thu, 15 Feb 2024 10:00:55 -0800 (PST)
Received: from m1x-phil.lan ([176.187.193.50])
 by smtp.gmail.com with ESMTPSA id
 g6-20020aa7c586000000b005619eea3d52sm754712edq.8.2024.02.15.10.00.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 15 Feb 2024 10:00:54 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Richard Henderson <richard.henderson@linaro.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Subject: [PULL 27/56] hw/sparc/sun4m: Realize DMA controller before accessing
 it
Date: Thu, 15 Feb 2024 18:57:21 +0100
Message-ID: <20240215175752.82828-28-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240215175752.82828-1-philmd@linaro.org>
References: <20240215175752.82828-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x532.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

We should not wire IRQs on unrealized device.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240213130341.1793-9-philmd@linaro.org>
---
 hw/sparc/sun4m.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
index e782c8ec7a..d52e6a7213 100644
--- a/hw/sparc/sun4m.c
+++ b/hw/sparc/sun4m.c
@@ -312,13 +312,11 @@ static void *sparc32_dma_init(hwaddr dma_base,
     dma = qdev_new(TYPE_SPARC32_DMA);
     espdma = SPARC32_ESPDMA_DEVICE(object_resolve_path_component(
                                    OBJECT(dma), "espdma"));
-    sysbus_connect_irq(SYS_BUS_DEVICE(espdma), 0, espdma_irq);
 
     esp = SYSBUS_ESP(object_resolve_path_component(OBJECT(espdma), "esp"));
 
     ledma = SPARC32_LEDMA_DEVICE(object_resolve_path_component(
                                  OBJECT(dma), "ledma"));
-    sysbus_connect_irq(SYS_BUS_DEVICE(ledma), 0, ledma_irq);
 
     lance = SYSBUS_PCNET(object_resolve_path_component(
                          OBJECT(ledma), "lance"));
@@ -332,6 +330,11 @@ static void *sparc32_dma_init(hwaddr dma_base,
     }
 
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dma), &error_fatal);
+
+    sysbus_connect_irq(SYS_BUS_DEVICE(espdma), 0, espdma_irq);
+
+    sysbus_connect_irq(SYS_BUS_DEVICE(ledma), 0, ledma_irq);
+
     sysbus_mmio_map(SYS_BUS_DEVICE(dma), 0, dma_base);
 
     sysbus_mmio_map(SYS_BUS_DEVICE(esp), 0, esp_base);
-- 
2.41.0


