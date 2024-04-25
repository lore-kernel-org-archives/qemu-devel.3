Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF9A9C19F4F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 11:09:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzwuK-0002u4-0Y; Thu, 25 Apr 2024 07:04:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rzwtJ-0000Az-So
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 07:04:01 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rzwtA-0000Ia-SM
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 07:03:44 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-41a72f3a1edso6922155e9.2
 for <qemu-devel@nongnu.org>; Thu, 25 Apr 2024 04:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714043016; x=1714647816; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q5xgdXCGND9O0mxiiZCYBTt0WDd2teRijPgGqLuPJXs=;
 b=KLiWuHsUAeuPx4sl4ND4n1oy5qSZ+UIdFxCcJey6GEAV02TWen3HmX6Tb5RcYbDIRU
 5Zes31VVjrwyd487fvDRHZ38g7tFP+xqrf16DtPLJJfzITgoAQoPcfKUPLmwHn3Ae4FM
 2FgqqNOv5ernMV70wfkFg+oVOXTF/y3gmPJ3ZaC3+vgY/5zN+oJJDLYdosCbHxAk7wNe
 HJhG9pSmv2EPUN0Z1wInparDlwG+HMrCgmSj3wrj1D6Zvgd6CCsDpn2xrWZzzZ5cPA+z
 2JJgXhrdQM7NbxE2Xv+79vOmTwWqu77cHQVpiAlMtRjadSMx6mC4NgKmBwuZgaZ36msP
 i31g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714043016; x=1714647816;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q5xgdXCGND9O0mxiiZCYBTt0WDd2teRijPgGqLuPJXs=;
 b=Uk0T8iZCSMJYoF3oVAkId5WkQUJKnXMUgnCgyv1SEyaur7XYufm29/0acWNKR0c/x+
 HVoT2jhwNekIsa674jYCZRiIdPQTTU5CZ6YpChpFalIsT2A4uCyfTDNEsyjf9sOFvKOh
 VTAY51LwfhglnR/IIF2KsD8bTQca3p2Y5jOmDthZszynY2btzdUaanEA9WfMyzcG6VVw
 SWHFvi/QNsGb6hpvQ1G2bzR5aH9X1ysY14XuJNIrQVCl6EJHbJDHzPzsxCMiCsSa0yzU
 KIOZs8ACPrdmjkKIs1oS1FLr3Dl2+lNHPmQWe/BwlOHbk6qrNGd3daIdZEApjC3KfM9x
 LEcQ==
X-Gm-Message-State: AOJu0YwCk/YTshnfUICUioSjN62ffRRrKEMn9fFjQNNqFgCZ9SIGjmRn
 TrvmILOaxEipb4NezEyHJ0a02RsezCnJ+3E5purXQp3VNcHQ5A53kUONxGxenJnIbPp+kPe4Wh2
 T
X-Google-Smtp-Source: AGHT+IGo4/4ds+aqwK0mOG61Mddx3imkACop4W8f2nNt+x5+kxgtBIL46K0+6irigKjFcRzE/192Mw==
X-Received: by 2002:adf:f146:0:b0:343:b686:89a0 with SMTP id
 y6-20020adff146000000b00343b68689a0mr3968839wro.13.1714043016769; 
 Thu, 25 Apr 2024 04:03:36 -0700 (PDT)
Received: from localhost.localdomain ([92.88.170.77])
 by smtp.gmail.com with ESMTPSA id
 x13-20020a5d54cd000000b0034335e47102sm19464539wrv.113.2024.04.25.04.03.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 25 Apr 2024 04:03:36 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?q?In=C3=A8s=20Varhol?= <ines.varhol@telecom-paris.fr>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Arnaud Minier <arnaud.minier@telecom-paris.fr>
Subject: [PULL 17/22] hw/misc : Correct 5 spaces indents in stm32l4x5_exti
Date: Thu, 25 Apr 2024 13:01:50 +0200
Message-ID: <20240425110157.20328-18-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240425110157.20328-1-philmd@linaro.org>
References: <20240425110157.20328-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

From: Inès Varhol <ines.varhol@telecom-paris.fr>

Signed-off-by: Inès Varhol <ines.varhol@telecom-paris.fr>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240421141455.116548-1-ines.varhol@telecom-paris.fr>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/misc/stm32l4x5_exti.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/misc/stm32l4x5_exti.c b/hw/misc/stm32l4x5_exti.c
index 9fd859160d..5c55ee4268 100644
--- a/hw/misc/stm32l4x5_exti.c
+++ b/hw/misc/stm32l4x5_exti.c
@@ -59,22 +59,22 @@ static const uint32_t exti_romask[EXTI_NUM_REGISTER] = {
 
 static unsigned regbank_index_by_irq(unsigned irq)
 {
-     return irq >= EXTI_MAX_IRQ_PER_BANK ? 1 : 0;
+    return irq >= EXTI_MAX_IRQ_PER_BANK ? 1 : 0;
 }
 
 static unsigned regbank_index_by_addr(hwaddr addr)
 {
-     return addr >= EXTI_IMR2 ? 1 : 0;
+    return addr >= EXTI_IMR2 ? 1 : 0;
 }
 
 static unsigned valid_mask(unsigned bank)
 {
-     return MAKE_64BIT_MASK(0, irqs_per_bank[bank]);
+    return MAKE_64BIT_MASK(0, irqs_per_bank[bank]);
 }
 
 static unsigned configurable_mask(unsigned bank)
 {
-     return valid_mask(bank) & ~exti_romask[bank];
+    return valid_mask(bank) & ~exti_romask[bank];
 }
 
 static void stm32l4x5_exti_reset_hold(Object *obj)
-- 
2.41.0


