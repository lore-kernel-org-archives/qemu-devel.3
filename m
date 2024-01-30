Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1971C46CD2
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 19:05:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUtOO-0000ws-M4; Tue, 30 Jan 2024 14:03:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rUtOM-0000w1-J0
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 14:03:30 -0500
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rUtOK-0008UV-Gm
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 14:03:30 -0500
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-55f0b2c79cdso3656404a12.3
 for <qemu-devel@nongnu.org>; Tue, 30 Jan 2024 11:03:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706641406; x=1707246206; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Uha9WaUXkaJpBldRkVdewGQYlJYY1NU670ANqpxdAMg=;
 b=MSSwV83eNR9FGLpmJSssxUslPb6W8kIccTFl5XC672cIbn6RhLZOHKd2oN80hEXwkU
 nJJ2Ovd6rUPHIkWxzcaR64AFnh33WPKAOReWeyAbYQx51QEX5912SOZpqS71fhstQOKx
 SWlkqFm44H9nnjX4IarKtpio9aADYSYs2xKiZ6My2CAekgAsbs6osR6AoHboXTApTsQs
 3eFvzHIP7COPqMHwuzYX67cavcFC/e5/cfvgr3ey5wxnPla3hpJiKqviK0MvWtIrhFRf
 +lcBdsh4oheTrDH3KPFsj3l+yNhvr+hEAt1Y0rkhI2jKud6Wdjf7tIJy6tiUnlctFu77
 H5bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706641406; x=1707246206;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Uha9WaUXkaJpBldRkVdewGQYlJYY1NU670ANqpxdAMg=;
 b=wBkRVKEKrJ10AhTEojF0rKkIJSkFXSnOsyMJRED3OROPgU4/BGyaUS8ORy17YsFPcP
 8pnUtVuHM/Kg4zUflFa7v3usk3OE5scScYzFrHYabeFS+oLS31EVMrfFgeok2RX6xGkx
 o8CXsBGXZnxwcZStFSysMD5pvb4nBMx3nH7oFoYfyaaqBgzERF+rEGxu6kQrnurNrx1F
 6LY12kodLUxPSgpyJW6k1yiDKHRHMAMGLeOvWakGGidvr0oG2wmlumTXjQ0Vl7hGOpO8
 IRUCFPQqxt/VHJF6jqkeEv3ucsXDSOuhkBhgz2TdRfM7WvuP8Lg5etgWfb9Ca26FyqYT
 a6xg==
X-Gm-Message-State: AOJu0YxNeqI99ETrI53clkEH+arRsO/0wgYBwFU2OOD12b9XnCqQ7H/G
 FW0MvDv+AlcTMK9oH7wRVet7o5Ww1RTknLmz9WuIrYNd95c68TjzOFd2JMHlS29nsRin14vPA3z
 O
X-Google-Smtp-Source: AGHT+IF6GKUM9W+TShQCmadIiIypLMzxhcRP95s2YwcL+l3oWv0yFqov5ZU/8McJQbWqt9MM0sCVDw==
X-Received: by 2002:a17:906:489:b0:a35:ad04:dcb7 with SMTP id
 f9-20020a170906048900b00a35ad04dcb7mr5066014eja.17.1706641406542; 
 Tue, 30 Jan 2024 11:03:26 -0800 (PST)
Received: from m1x-phil.lan ([176.187.218.134])
 by smtp.gmail.com with ESMTPSA id
 rg9-20020a1709076b8900b00a35464aab52sm4190773ejc.96.2024.01.30.11.03.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 30 Jan 2024 11:03:26 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Gustavo Romero <gustavo.romero@linaro.org>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 1/4] hw/arm/stellaris: Convert ADC controller to Resettable
 interface
Date: Tue, 30 Jan 2024 20:03:14 +0100
Message-ID: <20240130190317.25692-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240130190317.25692-1-philmd@linaro.org>
References: <20240130190317.25692-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52d.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/stellaris.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/arm/stellaris.c b/hw/arm/stellaris.c
index d18b1144af..afbc83f1e6 100644
--- a/hw/arm/stellaris.c
+++ b/hw/arm/stellaris.c
@@ -773,8 +773,9 @@ static void stellaris_adc_trigger(void *opaque, int irq, int level)
     }
 }
 
-static void stellaris_adc_reset(StellarisADCState *s)
+static void stellaris_adc_reset_hold(Object *obj)
 {
+    StellarisADCState *s = STELLARIS_ADC(obj);
     int n;
 
     for (n = 0; n < 4; n++) {
@@ -946,7 +947,6 @@ static void stellaris_adc_init(Object *obj)
     memory_region_init_io(&s->iomem, obj, &stellaris_adc_ops, s,
                           "adc", 0x1000);
     sysbus_init_mmio(sbd, &s->iomem);
-    stellaris_adc_reset(s);
     qdev_init_gpio_in(dev, stellaris_adc_trigger, 1);
 }
 
@@ -1397,7 +1397,9 @@ static const TypeInfo stellaris_i2c_info = {
 static void stellaris_adc_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
 
+    rc->phases.hold = stellaris_adc_reset_hold;
     dc->vmsd = &vmstate_stellaris_adc;
 }
 
-- 
2.41.0


