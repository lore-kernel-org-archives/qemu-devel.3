Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 907E4C48285
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 19:04:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUtOs-000140-OG; Tue, 30 Jan 2024 14:04:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rUtOX-00011A-Bs
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 14:03:42 -0500
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rUtOV-0008WB-R8
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 14:03:41 -0500
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a35b32bd055so309767866b.2
 for <qemu-devel@nongnu.org>; Tue, 30 Jan 2024 11:03:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706641418; x=1707246218; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ONQQAhlWUJUIL1ohHT6vUP5FJscZaLW2vVSHJwIJiGk=;
 b=x8DGc7Qp6PVEjevdLESY+q5E2kZnQA3pON2QZ/YpLftR2FU0fmNUzlOXS+YCxfO9Uw
 yor3vj8avrEDdl/0F2lXwAxzGGjZEBjf6Sq5H2qBJwvWo4nFv3vQzg+wKJ0V3xSTU+/K
 FgmD6tSwpu6nBwYqjB63FqXaCAy7uzZ5DkIwTaqMOvPzeBEBf/NJOlSzzEpge/bIrhVo
 OzYq30c4+f2kwlHnap3sn2RR4QivwXGPYAlslHxFPxgBWXfF2IiXuTlEkYmhpwsnbpTM
 rHNGD/G4rgPUE1jR7svaVAR1tmtuM7E9K6afsNW1N/GZuYLED62PBbmNoM+7bCQY88Uq
 ekOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706641418; x=1707246218;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ONQQAhlWUJUIL1ohHT6vUP5FJscZaLW2vVSHJwIJiGk=;
 b=m0ogKN2iSW+L6oIEpe9zpQw05yYB2kZbN9+Dfp5H1F8K9K4KzAH6OMaKUBwQ0B/usK
 Sc0Ijs8r1nwwhA4QhADXLwwUfOAP4eIEfphAEPDEXrKNMAgxZsDivcD8V3HG0CJSqrhr
 5K0002nFxfsrcSJ2TNRvtRQkrY3HQ1t3Ato3o7bCG/NwsrZiNh52KHfPj+7DE8bx3Tol
 gU6j808589o3fQ+XayUWebVP0rQjvcxgGaMVDQyCiO2HIUDS6w2MBnpo78KlDxfKLRgp
 cgrQOatL6CChymNANUvs1BCGibM5HbEt1vlyr/7zSjisZGZ/DpgwRNXhYFpEiXa+TXWQ
 YAiQ==
X-Gm-Message-State: AOJu0Yzwu7NKT9qNY6uiyHvsgBtSWCQXwDZOWyKNsuIUsv6uufzVk/+p
 rCSH2MaOa4zO0RMvPVxxDlLRzX8S35sP3XBr/9UKep4AOtlX3+ukpx/nDKMHolEP/gY65ymJeac
 u
X-Google-Smtp-Source: AGHT+IE8PWbcJ05NYDH00NfSLE1CD3c6S6mwYY7iU9LPuHJIZONVOqT37jRPcX9gay+xSTR3cdS4PQ==
X-Received: by 2002:a17:906:f152:b0:a36:5d54:64b1 with SMTP id
 gw18-20020a170906f15200b00a365d5464b1mr212381ejb.73.1706641418290; 
 Tue, 30 Jan 2024 11:03:38 -0800 (PST)
Received: from m1x-phil.lan ([176.187.218.134])
 by smtp.gmail.com with ESMTPSA id
 l13-20020a1709066b8d00b00a32429e455asm5441536ejr.175.2024.01.30.11.03.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 30 Jan 2024 11:03:37 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Gustavo Romero <gustavo.romero@linaro.org>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 3/4] hw/arm/stellaris: Add missing QOM 'machine' parent
Date: Tue, 30 Jan 2024 20:03:16 +0100
Message-ID: <20240130190317.25692-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240130190317.25692-1-philmd@linaro.org>
References: <20240130190317.25692-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x636.google.com
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

QDev objects created with qdev_new() need to manually add
their parent relationship with object_property_add_child().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/stellaris.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/arm/stellaris.c b/hw/arm/stellaris.c
index 284b95005f..bb88b3ebde 100644
--- a/hw/arm/stellaris.c
+++ b/hw/arm/stellaris.c
@@ -1247,10 +1247,13 @@ static void stellaris_init(MachineState *ms, stellaris_board_info *board)
                                    &error_fatal);
 
             ssddev = qdev_new("ssd0323");
+            object_property_add_child(OBJECT(ms), "oled", OBJECT(ssddev));
             qdev_prop_set_uint8(ssddev, "cs", 1);
             qdev_realize_and_unref(ssddev, bus, &error_fatal);
 
             gpio_d_splitter = qdev_new(TYPE_SPLIT_IRQ);
+            object_property_add_child(OBJECT(ms), "splitter",
+                                      OBJECT(gpio_d_splitter));
             qdev_prop_set_uint32(gpio_d_splitter, "num-lines", 2);
             qdev_realize_and_unref(gpio_d_splitter, NULL, &error_fatal);
             qdev_connect_gpio_out(
@@ -1287,6 +1290,7 @@ static void stellaris_init(MachineState *ms, stellaris_board_info *board)
         DeviceState *gpad;
 
         gpad = qdev_new(TYPE_STELLARIS_GAMEPAD);
+        object_property_add_child(OBJECT(ms), "gamepad", OBJECT(gpad));
         for (i = 0; i < ARRAY_SIZE(gpad_keycode); i++) {
             qlist_append_int(gpad_keycode_list, gpad_keycode[i]);
         }
-- 
2.41.0


