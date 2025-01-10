Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80B40E7719C
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 16:04:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWHTo-0007i3-TP; Fri, 10 Jan 2025 11:03:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tWHT9-0007KA-50
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 11:02:49 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tWHT2-0004Gv-32
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 11:02:40 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3862a921123so1455898f8f.3
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 08:02:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736524954; x=1737129754; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=11iHBCaGxzy1H3GllyQ3szfgtatw8IIZSrsd+4vXp4U=;
 b=NkvdhhWM97FlZ0SiKA3u++Pj6W6O/NWm0zAysZfRm+6NGAhHlvbZDeokZ2tC0P1vp9
 x8umtUCV9vyM5GuHyNeiVxibQ3VkLs3nqba1nlzudTeZnzSLmARocCHBwEUliTTrhiLl
 u5jbkOZz6q14VZUnld0J5rdZdK2oE9/ZtD8b85pPraFsgiEh2L59ysSGPOXbUHvCqKl1
 IRI6zk4JUW8BVLxIY8OzdReZCffma2RfX1ywHXniA9a1nC5ZrpxU0PEl7GozRIRYtcCl
 cGDtRdK2Lceu03kR7tlgoRmptJfq8feKF0m5KG+cLXTMiAzOtqdKUsH321pLgi400DXj
 I07A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736524954; x=1737129754;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=11iHBCaGxzy1H3GllyQ3szfgtatw8IIZSrsd+4vXp4U=;
 b=UeRmp9W+GnUUfzC4spxcwnQEdmy4l0SOu/1Kbze+2xcmV139wqgtC87kEA610zzt16
 7pkgzk+5qh9zqZQKxLBFhnwfQqJ3mfPOPnMU+tiwkUdYI21usEK3j/clwk1T/2YCCjE4
 er0/PdCSIKdnJuh8E9x8HFh+1kiRZAJUI1gEvdJrQ0Vc3S385z1DfMW7GX5Xyj00Q1zY
 2wcLND9wRHSBRfAkEdvwO4pknD4vyWtkEz0H40KVzOiW/rOokp8e0toM3Pfauh9HEfHq
 wfvqIvXIXa4CSWboAAoNJFi4l53Oc1DnkUs+V5NzhL5yZyp9ftwotPJ0tcGHzlKkgcK0
 J8FQ==
X-Gm-Message-State: AOJu0YwCSZjKbDzTvG4+InxqjoPsv365m/F0ArFdjc6QbsmFsovExUZB
 mispTMyRilu+m99W1jjLJpzgsH9zr37x97nF/2L6jlPERUzMAo8mvB0AvL0qTIMpLVhlsBYSKnW
 3RRA=
X-Gm-Gg: ASbGncvWVlTUjXkEiEzDqHOvQRQj02Qh3DjJEaB4zhzFJqh8/l7g1jY5SfW+467ys4i
 DrpoWyQ4NVDA30/xEesEkrHwyynJhAXkPIASt+56qlhpg/gh94UP6Rac+Fqn4wA03HBpx+Tahvq
 QwuA+UHUI909cG0Q9RkVqufglXtp4bodbhj6o92IYBCA+ZhEv07tO65AkdWf+tA6DgxaRBDLb++
 sxWdzMA8gn/za4YosVVcQ40nCyC2BXMwtXqqTFx6Vr5iYnXbFH0AY1rDRg/S46l7MgAhlZKW1Q+
 uy3Co5FQC5XKASkp2Zw0xvSyvekJ7y4=
X-Google-Smtp-Source: AGHT+IGlQS4xtNr4SQ0Omn6ay8VQdU6rlUxEcn18KeiFJkp6/hhg7pY7CIeJ93uVN331K9zYf7Ygnw==
X-Received: by 2002:a05:6000:1847:b0:386:3825:2c3b with SMTP id
 ffacd0b85a97d-38a87304672mr9420072f8f.18.1736524953527; 
 Fri, 10 Jan 2025 08:02:33 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e4c1967sm4765917f8f.86.2025.01.10.08.02.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 10 Jan 2025 08:02:33 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 6/9] hw/arm/stellaris: Map both I2C controllers
Date: Fri, 10 Jan 2025 17:02:01 +0100
Message-ID: <20250110160204.74997-7-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250110160204.74997-1-philmd@linaro.org>
References: <20250110160204.74997-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

There are 2 I2C controllers, map them both, removing
the unimplemented one. Keep the OLED controller on the
first I2C bus.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/stellaris.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/hw/arm/stellaris.c b/hw/arm/stellaris.c
index 64e6797553a..655bf85e89e 100644
--- a/hw/arm/stellaris.c
+++ b/hw/arm/stellaris.c
@@ -1021,6 +1021,8 @@ static void stellaris_init(MachineState *ms, stellaris_board_info *board)
       { 0x40004000, 0x40005000, 0x40006000, 0x40007000,
         0x40024000, 0x40025000, 0x40026000};
     static const int gpio_irq[NUM_GPIO] = {0, 1, 2, 3, 4, 30, 31};
+    static const uint32_t i2c_addr[NUM_I2C] = {0x40020000, 0x40021000};
+    static const int i2c_irq[NUM_I2C] = {8, 37};
 
     /* Memory map of SoC devices, from
      * Stellaris LM3S6965 Microcontroller Data Sheet (rev I)
@@ -1062,7 +1064,7 @@ static void stellaris_init(MachineState *ms, stellaris_board_info *board)
     qemu_irq adc;
     int sram_size;
     int flash_size;
-    I2CBus *i2c;
+    DeviceState *i2c_dev[NUM_I2C];
     DeviceState *dev;
     DeviceState *ssys_dev;
     int i;
@@ -1195,14 +1197,18 @@ static void stellaris_init(MachineState *ms, stellaris_board_info *board)
         }
     }
 
-    if (DEV_CAP(2, I2C(0))) {
-        dev = sysbus_create_simple(TYPE_STELLARIS_I2C, 0x40020000,
-                                   qdev_get_gpio_in(nvic, 8));
-        i2c = (I2CBus *)qdev_get_child_bus(dev, "i2c");
-        if (board->peripherals & BP_OLED_I2C) {
-            i2c_slave_create_simple(i2c, "ssd0303", 0x3d);
+    for (i = 0; i < NUM_I2C; i++) {
+        if (DEV_CAP(2, I2C(i))) {
+            i2c_dev[i] = sysbus_create_simple(TYPE_STELLARIS_I2C, i2c_addr[i],
+                                              qdev_get_gpio_in(nvic,
+                                                               i2c_irq[i]));
         }
     }
+    if (board->peripherals & BP_OLED_I2C) {
+        I2CBus *bus = (I2CBus *)qdev_get_child_bus(i2c_dev[0], "i2c");
+
+        i2c_slave_create_simple(bus, "ssd0303", 0x3d);
+    }
 
     for (i = 0; i < NUM_UART; i++) {
         if (DEV_CAP(2, UART(i))) {
@@ -1381,7 +1387,6 @@ static void stellaris_init(MachineState *ms, stellaris_board_info *board)
     /* Add dummy regions for the devices we don't implement yet,
      * so guest accesses don't cause unlogged crashes.
      */
-    create_unimplemented_device("i2c-2", 0x40021000, 0x1000);
     create_unimplemented_device("PWM", 0x40028000, 0x1000);
     create_unimplemented_device("QEI-0", 0x4002c000, 0x1000);
     create_unimplemented_device("QEI-1", 0x4002d000, 0x1000);
-- 
2.47.1


