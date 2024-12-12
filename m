Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 764F5E7717F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 11:49:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLhgG-0002tV-4t; Thu, 12 Dec 2024 06:48:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tLhg4-0002hH-JG
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 06:48:21 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tLhg2-0007NP-PE
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 06:48:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=zoHkEngcvlB0A7wPbGtV8HwZhML1pVDTzwVLODuoPDc=; b=so0X5ZQFl/t1P0T6m6xgugmCdB
 NuD9E/E9rlVDWEoEtEldD35RbT7nvcDeUBvgqTIh+h+Sda54NXE7swyrIc0eTuKMgUMz6iFz0bd/J
 y99MXWyr38cPH+yCE5nP3JcHooUDH3j2S4TMjlIpWdetxwZRxmxDIEuhYmQQgwfrrYDAO7MMGVTh/
 8a0iZT7b/d61YSpXf8efMWNBRYCTsEUTWp6a+RPWVA3+Xu5/gZDaqMKj7hV9juPjv5fsYUl4pEcxS
 WmNWHNZWrnLEl+9+/OjyeuEnIA0V9Xn2XK0Zs8IlI9S79Bo1XQHjP7CMVM2qgYwqDwuhXaVZVSbYQ
 sN8Pc2NteQzduZdfo6yfjQyBJ7q8032EZO82h7X0x0wtrZrrTg8O0YFCxQhFtwNj19bi5uUQfhFb9
 B9lUYKjv0KZRYy+OoNaVX696q/KeDS10PkAA6qdrYjVtJk/r7ESL/ErOPi9CYKieCP/s2Et96Ryvy
 jSnQCiXDKE0ZARIrBnsIEKmLf0RZuGcl+kZNDAuk2PpK92RkgRLtIVVCToWAn9xkWbmKsx2zf7hd9
 aEaVkwruzUaII+rSSQ9L1naOSmwSLGyp5cqGmgGf7aJ26vL4fPBbCFieEjbmrF/jvgP49imGFYL+w
 /BGMdosEmeeTK6A9wA0QP5CLKLry6t5dROjBZLbCA=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tLhfM-00070a-6k; Thu, 12 Dec 2024 11:47:36 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: huth@tuxfamily.org,
	qemu-devel@nongnu.org
Date: Thu, 12 Dec 2024 11:46:16 +0000
Message-Id: <20241212114620.549285-31-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241212114620.549285-1-mark.cave-ayland@ilande.co.uk>
References: <20241212114620.549285-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 30/34] next-cube: add rtc-power-out named gpio to trigger
 the NEXT_PWR_I interrupt
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

This allows us to decouple the next-pc and next-rtc devices from each
other in next_rtc_data_in_irq().

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/m68k/next-cube.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
index d61deda6e0..94a9b90171 100644
--- a/hw/m68k/next-cube.c
+++ b/hw/m68k/next-cube.c
@@ -58,6 +58,7 @@ struct NeXTRTC {
     uint8_t retval;
 
     qemu_irq data_out_irq;
+    qemu_irq power_irq;
 };
 
 #define TYPE_NEXT_SCSI "next-scsi"
@@ -106,7 +107,6 @@ struct NeXTPC {
     ESCCState escc;
 
     NeXTRTC rtc;
-    qemu_irq rtc_power_irq;
     qemu_irq rtc_data_irq;
     qemu_irq rtc_cmd_reset_irq;
 };
@@ -184,7 +184,6 @@ static bool next_rtc_cmd_is_write(uint8_t cmd)
 static void next_rtc_data_in_irq(void *opaque, int n, int level)
 {
     NeXTRTC *rtc = NEXT_RTC(opaque);
-    NeXTPC *s = NEXT_PC(container_of(rtc, NeXTPC, rtc));
 
     if (rtc->phase < 8) {
         rtc->command = (rtc->command << 1) | level;
@@ -256,7 +255,7 @@ static void next_rtc_data_in_irq(void *opaque, int n, int level)
             if (rtc->value & 0x04) {
                 /* clear FTU */
                 rtc->status = rtc->status & (~0x18);
-                qemu_irq_lower(s->rtc_power_irq);
+                qemu_irq_lower(rtc->power_irq);
             }
         }
     }
@@ -1044,6 +1043,8 @@ static void next_rtc_init(Object *obj)
                              "rtc-data-out", 1);
     qdev_init_gpio_in_named(DEVICE(obj), next_rtc_cmd_reset_irq,
                             "rtc-cmd-reset", 1);
+    qdev_init_gpio_out_named(DEVICE(obj), &rtc->power_irq,
+                             "rtc-power-out", 1);
 }
 
 static const VMStateDescription next_rtc_vmstate = {
@@ -1156,6 +1157,8 @@ static void next_pc_realize(DeviceState *dev, Error **errp)
                                                        "rtc-data-in", 0));
     qdev_connect_gpio_out_named(dev, "rtc-cmd-reset", 0,
                                 qdev_get_gpio_in_named(d, "rtc-cmd-reset", 0));
+    qdev_connect_gpio_out_named(d, "rtc-power-out", 0,
+                                qdev_get_gpio_in(dev, NEXT_PWR_I));
 }
 
 static void next_pc_init(Object *obj)
@@ -1191,7 +1194,6 @@ static void next_pc_init(Object *obj)
 
     object_initialize_child(obj, "rtc", &s->rtc, TYPE_NEXT_RTC);
 
-    s->rtc_power_irq = qdev_get_gpio_in(DEVICE(obj), NEXT_PWR_I);
     qdev_init_gpio_in_named(DEVICE(obj), next_pc_rtc_data_in_irq,
                             "rtc-data-in", 1);
     qdev_init_gpio_out_named(DEVICE(obj), &s->rtc_data_irq,
-- 
2.39.5


