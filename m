Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC74AC0218A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 20:18:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcrxl-00028C-GV; Tue, 28 Jan 2025 15:13:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tcrxk-00027W-Jn
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 15:13:32 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tcrxi-0001aZ-RD
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 15:13:32 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-438a3216fc2so62254775e9.1
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 12:13:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738095209; x=1738700009; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=7fwK0HVGmxgRXSNDyN8ycHXrfWgJUyub54CCwlOJt4s=;
 b=IYGps0yx+o12sJjAGVOuK0EGqdvavRs+6tvubEOHYzTtAwZ+5W+aoDxltHT9cyVbUA
 MxG78f/phIdKH5NIp2NYWKzRIBSt85Ndfu+Ae+xx/WE1LcnbD40Y9zWJx9HMNAiymspj
 C9k/Fn8XmFB8AL7sO3aLFu2iN3fMcB0uvJYMtA+FG90rjKLoTVa0FSfoB4WbPemDU77Z
 QTNMqBRs7XypJbMVEXgAZmcJYNLsAiI4sgqJTnbg6KssS5vhJRObj1gVLIL6IO0qa5HE
 NgtFfNWl0cZzsHUnkcyUpeSCRXmez5jWVyFpFfBZ1CCpUc16eKlUKdzLvtMsWDMpY4Bb
 dXWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738095209; x=1738700009;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7fwK0HVGmxgRXSNDyN8ycHXrfWgJUyub54CCwlOJt4s=;
 b=ZiMdtWN5ga4eAak5T7LN44t/WD6KKxtSGZCNnB7BXQyoYf7cdAQAM3/0VSLt+abukm
 4SDFaAkScJhOwoXOlF6JuwEBP8pAj2GZyt2WZ45yqAVvtrw+ojuCD8QRiX6wAF50mS/M
 wAiYHVcozpDS/Vu9xsQbPh1nVWPO24/2FbzO220m1jGw/dwwahaWG9VX/S7CFReB0+oN
 3rswAF9id2x1LVpbDu3B97UYVA8lewthj02hHaX+tq4GiZV4WW85I86iRBMMgXRygPJI
 8C9Kz5O0GnjiT+xFl8in1t/gYXJPk1PHhQR7cv+pFlOT3sE8TAFwhL+ch6OznLMEC8eG
 z6Yg==
X-Gm-Message-State: AOJu0Yxl3ADGF0Dh9Eo5rWw7N+mC1tbDUCkJIEhlgjaWXzgX7NSyJoyb
 PPYKRAh41wsW7mXH5wXSe3U8r2R7tgODHAckqDJIUleylLBVF11hLkLInUKPPv+ANqYlJGna3FF
 I
X-Gm-Gg: ASbGnctPwMtwttKR9ZfauJnwWuVfY3fuF3z0UWKJSdFk1p2g1U286BrGBCsFgsNdQsm
 ybCZkAWnKW5zdFzkDzBD/z0k5R9ra0mKijAW+OVdhdMSpGixZTonX2Q6zdiv67NreeBPxhISSyO
 3fcLcCBO1pNtwvbkVCvqL+BBRdPjKaWoT1CTWM/bwHBqFX+QPjsxYX1Abf+F4F2gIwlwOR+TbWh
 L3IGp3JYOqtAl5FeR/2iMkwe5m0ieFcSd6xU6kDg9rtZRVPsVy1Gl/rRFnEYoGyFRbejxv6DWsh
 YeHBiOcHa/i0wQW9fH17jg==
X-Google-Smtp-Source: AGHT+IHRQQLZA53dRNC4yTPEtjGiJ8iOqgUeXfC6Iq1IXGDs4rIZPTfOgqdyidFip+qtVOmjE8YACg==
X-Received: by 2002:a05:600c:4fd6:b0:434:ff30:a159 with SMTP id
 5b1f17b1804b1-438dc3360b9mr3020415e9.0.1738095209421; 
 Tue, 28 Jan 2025 12:13:29 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd4fa3efsm182524105e9.2.2025.01.28.12.13.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2025 12:13:28 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 12/36] hw/arm/stellaris: Map both I2C controllers
Date: Tue, 28 Jan 2025 20:12:50 +0000
Message-Id: <20250128201314.44038-13-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250128201314.44038-1-peter.maydell@linaro.org>
References: <20250128201314.44038-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

There are 2 I2C controllers, map them both, removing
the unimplemented one. Keep the OLED controller on the
first I2C bus.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20250110160204.74997-7-philmd@linaro.org
[PMM: tweak to appease maybe-use-uninitialized warning]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/stellaris.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/hw/arm/stellaris.c b/hw/arm/stellaris.c
index 82f935cb329..c3c3fd0410e 100644
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
+    DeviceState *i2c_dev[NUM_I2C] = { };
     DeviceState *dev;
     DeviceState *ssys_dev;
     int i;
@@ -1196,14 +1198,18 @@ static void stellaris_init(MachineState *ms, stellaris_board_info *board)
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
@@ -1382,7 +1388,6 @@ static void stellaris_init(MachineState *ms, stellaris_board_info *board)
     /* Add dummy regions for the devices we don't implement yet,
      * so guest accesses don't cause unlogged crashes.
      */
-    create_unimplemented_device("i2c-2", 0x40021000, 0x1000);
     create_unimplemented_device("PWM", 0x40028000, 0x1000);
     create_unimplemented_device("QEI-0", 0x4002c000, 0x1000);
     create_unimplemented_device("QEI-1", 0x4002d000, 0x1000);
-- 
2.34.1


