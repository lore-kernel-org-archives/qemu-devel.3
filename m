Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCB3BC48260
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Feb 2024 11:04:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raw0E-0006Fn-Od; Fri, 16 Feb 2024 06:03:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1raw0A-0006C2-KT
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 06:03:31 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1raw05-0000nL-MD
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 06:03:30 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-412529f671aso1185275e9.2
 for <qemu-devel@nongnu.org>; Fri, 16 Feb 2024 03:03:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708081403; x=1708686203; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eo0SdoR6qSJ49xsDZEZ0yqz4VDVUEvJcVdzt8nM06Fc=;
 b=oVkk7Hq5kNVZHb9M5Sg0jrWnn6XpqE+Lcq+BnZM/XsAACDTAdO50z4VhjTxf431+NJ
 BSlLLLGOFhgGI08RjkYjIyTgr2QIvBz5EJ12W+5IAURw6Z6rzzh5Ws80m5DeKOoyJkgN
 hj3q5Gm7DWJoPn6xzBtA+8uWzxru6SWCH70aDHhrb2fSxjilV7WojaU14UA2CEUAw+6d
 mGJvwEOxM0BFij11r3GXNiQxwuKMk4Urh4R0EFUrqvjyX39J3PTwuImTWAJO1Jv1j40c
 kie1w2Mtb7nMqeVGTEF9++GWYM2EWc9gwftaLDsJCvy/gFGshNjxzQ1yCL8aT5gqx0Iv
 UlbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708081403; x=1708686203;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eo0SdoR6qSJ49xsDZEZ0yqz4VDVUEvJcVdzt8nM06Fc=;
 b=rq+AlFwkS/0YsYgfYQa62cHE5gaVlNXCqakX1Mu0PLiWPQXurvynvVwb8CF1Ozsvry
 KRXCgbPa0ArjDvsIIR4PjnXUo+iP+niXkHNN6KlxRrb3SFY49esOsHxDPafSWOGkFGIx
 9NhFQtkaEr73w97sm1tswni9wkTB/NkJEprA1XYZ19JNSbc4aGCd8qAYb0hNk3TU6O/F
 HuSOzVvYMQWmO/J5DKPsyIQ1gloRiBypiQjdR2TOPBW4xGPU8+fVNt1YiSawdKkXdlVV
 sJKATUHU5n2dWzRzmGvnUDZoPpADCeq46h8gqFqHGtlplY5oliG/mmy4x1BzSzkCsny1
 zzNw==
X-Gm-Message-State: AOJu0YzQBEDzRfX7IlD7a9IcaDC5qG32RWWrAhyfokNva1vIPVZaqPNZ
 F7M35NlWwiXTqG+zFE/9CbOC8yr+VenufldC9qTu5Fq+noEzDND4Vw1BmC/dkGvDgZLr4Bx8eGV
 T
X-Google-Smtp-Source: AGHT+IFRPbYqzsy3VeU5xODQnVp/7Dem5fsYgmSpSJj6Ft2wlOkDWP2xTmx5sLzZuvaMqygYty/suA==
X-Received: by 2002:a05:600c:1e09:b0:412:457f:7094 with SMTP id
 ay9-20020a05600c1e0900b00412457f7094mr977358wmb.29.1708081403143; 
 Fri, 16 Feb 2024 03:03:23 -0800 (PST)
Received: from m1x-phil.lan ([176.187.210.246])
 by smtp.gmail.com with ESMTPSA id
 b7-20020a05600c11c700b00411c3c2fc55sm1934681wmi.45.2024.02.16.03.03.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 16 Feb 2024 03:03:22 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org,
 qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH 01/21] hw/i386/pc: Do not use C99 mixed-declarations style
Date: Fri, 16 Feb 2024 12:02:52 +0100
Message-ID: <20240216110313.17039-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240216110313.17039-1-philmd@linaro.org>
References: <20240216110313.17039-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

QEMU's coding style generally forbids C99 mixed declarations.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/i386/pc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 196827531a..3c00a87317 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1227,6 +1227,7 @@ void pc_basic_device_init(struct PCMachineState *pcms,
      */
     if (pcms->hpet_enabled) {
         qemu_irq rtc_irq;
+        uint8_t compat;
 
         hpet = qdev_try_new(TYPE_HPET);
         if (!hpet) {
@@ -1238,8 +1239,7 @@ void pc_basic_device_init(struct PCMachineState *pcms,
          * use IRQ16~23, IRQ8 and IRQ2.  If the user has already set
          * the property, use whatever mask they specified.
          */
-        uint8_t compat = object_property_get_uint(OBJECT(hpet),
-                HPET_INTCAP, NULL);
+        compat = object_property_get_uint(OBJECT(hpet), HPET_INTCAP, NULL);
         if (!compat) {
             qdev_prop_set_uint32(hpet, HPET_INTCAP, hpet_irqs);
         }
-- 
2.41.0


