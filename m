Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52178D2E029
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 09:04:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3XEa-0003LW-Bf; Wed, 23 Oct 2024 05:00:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1t3XEX-0002vA-AK
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 05:00:49 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1t3XEV-0000dC-Eq
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 05:00:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=QY10F09QlfEQvbT6rSAMeZBWG/Liys0PzYKyrLbJLYk=; b=W8iNuhefZVgu383uoNHrH8aSTA
 C6sFGJCp0E2vGBlj/1vDsFnq5JFxGi6GsNHru4zcShsxE+JYGo13YuJxfabIVnqkbBUX9Mj2GKEj9
 pIgIRWFcnYhrNtF+w/q9eV9ts/ZjQm18Y3F9j2ZUJX+emaxFVTnryf+Wa5tFHmbVG4pEv3Vv0khzR
 Jf2JJpCTY/xrClxBzPOdwCdljoONHL+pqhqi8ry5JCUdaSjLkdf+i9i1pTABRIHVDY8jSL1yGGCAB
 FzgCtCO+Gs9VatH1vhZ/EnMqZSyBRPBgq6zB7LrM4l1Fl8P+s86UbIcmy0ytayLFoP8APVpCWIJHr
 N+wY8qzS5mOYmxsdwgQ51UPivKy8W9R7tx/+GartFp/uttL71YEXzlDVfp5D5m6rFfNNnHp6yHYBu
 YdGThEEFj8MBuGI/8taLUDSGDTxvjQhYuD8KmH7tfy1vQ5nz78fhFQJ6R7y7C0ONbPo0ojEr7yWWC
 lyxEgZj0IMe8e80yw6LpYWlrh3CGR5Xc19EXdDHnqxjFMOvv69DfZO8ZUQovYdVr3FH5VtAdvU1yB
 wToQExVwFFEOnjFfyVekR14cNvK323R48Q7z64TvsxBJ37s6cCq71JrRj8M3cs4SELAnVjJfEWXTH
 4Zr91GcWds7cLujuEUl3vZPdlwHImN8yo1yQn453w=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1t3XDy-0008EL-VD; Wed, 23 Oct 2024 10:00:19 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: huth@tuxfamily.org,
	qemu-devel@nongnu.org
Date: Wed, 23 Oct 2024 09:58:41 +0100
Message-Id: <20241023085852.1061031-26-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241023085852.1061031-1-mark.cave-ayland@ilande.co.uk>
References: <20241023085852.1061031-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 25/36] next-cube: use named gpio to read RTC data bit in scr2
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

This is in preparation for moving NeXTRTC to its own separate device.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/m68k/next-cube.c | 169 ++++++++++++++++++++++++--------------------
 1 file changed, 92 insertions(+), 77 deletions(-)

diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
index 2a2e970830..43b2c775c0 100644
--- a/hw/m68k/next-cube.c
+++ b/hw/m68k/next-cube.c
@@ -171,6 +171,90 @@ static bool next_rtc_cmd_is_write(uint8_t cmd)
            (cmd == 0xb1);
 }
 
+static void next_rtc_data_in_irq(void *opaque, int n, int level)
+{
+    NeXTPC *s = NEXT_PC(opaque);
+    NeXTRTC *rtc = &s->rtc;
+
+    if (rtc->phase < 8) {
+        rtc->command = (rtc->command << 1) | level;
+
+        if (rtc->phase == 7 && !next_rtc_cmd_is_write(rtc->command)) {
+            if (rtc->command <= 0x1f) {
+                /* RAM registers */
+                rtc->retval = rtc->ram[rtc->command];
+            }
+            if ((rtc->command >= 0x20) && (rtc->command <= 0x2f)) {
+                /* RTC */
+                time_t time_h = time(NULL);
+                struct tm *info = localtime(&time_h);
+                rtc->retval = 0;
+
+                switch (rtc->command) {
+                case 0x20:
+                    rtc->retval = SCR2_TOBCD(info->tm_sec);
+                    break;
+                case 0x21:
+                    rtc->retval = SCR2_TOBCD(info->tm_min);
+                    break;
+                case 0x22:
+                    rtc->retval = SCR2_TOBCD(info->tm_hour);
+                    break;
+                case 0x24:
+                    rtc->retval = SCR2_TOBCD(info->tm_mday);
+                    break;
+                case 0x25:
+                    rtc->retval = SCR2_TOBCD((info->tm_mon + 1));
+                    break;
+                case 0x26:
+                    rtc->retval = SCR2_TOBCD((info->tm_year - 100));
+                    break;
+                }
+            }
+            if (rtc->command == 0x30) {
+                /* read the status 0x30 */
+                rtc->retval = rtc->status;
+            }
+            if (rtc->command == 0x31) {
+                /* read the control 0x31 */
+                rtc->retval = rtc->control;
+            }
+        }
+    }
+    if (rtc->phase >= 8 && rtc->phase < 16) {
+        if (next_rtc_cmd_is_write(rtc->command)) {
+            /* Shift in value to write */
+            rtc->value = (rtc->value << 1) | level;
+        } else {
+            /* Shift out value to read */
+            qemu_irq rtc_data_in_irq = qdev_get_gpio_in_named(
+                DEVICE(s), "pc-rtc-data-in", 0);
+
+            if (rtc->retval & (0x80 >> (rtc->phase - 8))) {
+                qemu_irq_raise(rtc_data_in_irq);
+            } else {
+                qemu_irq_lower(rtc_data_in_irq);
+            }
+        }
+    }
+
+    rtc->phase++;
+    if (rtc->phase == 16 && next_rtc_cmd_is_write(rtc->command)) {
+        if (rtc->command >= 0x80 && rtc->command <= 0x9f) {
+            /* RAM registers */
+            rtc->ram[rtc->command - 0x80] = rtc->value;
+        }
+        if (rtc->command == 0xb1) {
+            /* write to 0x30 register */
+            if (rtc->value & 0x04) {
+                /* clear FTU */
+                rtc->status = rtc->status & (~0x18);
+                qemu_irq_lower(s->rtc_power_irq);
+            }
+        }
+    }
+}
+
 static void next_scr2_rtc_update(NeXTPC *s)
 {
     uint8_t old_scr2, scr2_2;
@@ -187,84 +271,13 @@ static void next_scr2_rtc_update(NeXTPC *s)
         /* If we are in going down clock... do something */
         if (((old_scr2 & SCR2_RTCLK) != (scr2_2 & SCR2_RTCLK)) &&
                 ((scr2_2 & SCR2_RTCLK) == 0)) {
-            if (rtc->phase < 8) {
-                rtc->command = (rtc->command << 1) |
-                               ((scr2_2 & SCR2_RTDATA) ? 1 : 0);
-
-                if (rtc->phase == 7 && !next_rtc_cmd_is_write(rtc->command)) {
-                    if (rtc->command <= 0x1f) {
-                        /* RAM registers */
-                        rtc->retval = rtc->ram[rtc->command];
-                    }
-                    if ((rtc->command >= 0x20) && (rtc->command <= 0x2F)) {
-                        /* RTC */
-                        time_t time_h = time(NULL);
-                        struct tm *info = localtime(&time_h);
-                        rtc->retval = 0;
-
-                        switch (rtc->command) {
-                        case 0x20:
-                            rtc->retval = SCR2_TOBCD(info->tm_sec);
-                            break;
-                        case 0x21:
-                            rtc->retval = SCR2_TOBCD(info->tm_min);
-                            break;
-                        case 0x22:
-                            rtc->retval = SCR2_TOBCD(info->tm_hour);
-                            break;
-                        case 0x24:
-                            rtc->retval = SCR2_TOBCD(info->tm_mday);
-                            break;
-                        case 0x25:
-                            rtc->retval = SCR2_TOBCD((info->tm_mon + 1));
-                            break;
-                        case 0x26:
-                            rtc->retval = SCR2_TOBCD((info->tm_year - 100));
-                            break;
-                        }
-                    }
-                    if (rtc->command == 0x30) {
-                        /* read the status 0x30 */
-                        rtc->retval = rtc->status;
-                    }
-                    if (rtc->command == 0x31) {
-                        /* read the control 0x31 */
-                        rtc->retval = rtc->control;
-                    }
-                }
-            }
-            if (rtc->phase >= 8 && rtc->phase < 16) {
-                if (next_rtc_cmd_is_write(rtc->command)) {
-                    /* Shift in value to write */
-                    rtc->value = (rtc->value << 1) |
-                                 ((scr2_2 & SCR2_RTDATA) ? 1 : 0);
-                } else {
-                    /* Shift out value to read */
-                    qemu_irq rtc_data_in_irq = qdev_get_gpio_in_named(
-                        DEVICE(s), "pc-rtc-data-in", 0);
-
-                    if (rtc->retval & (0x80 >> (rtc->phase - 8))) {
-                        qemu_irq_raise(rtc_data_in_irq);
-                    } else {
-                        qemu_irq_lower(rtc_data_in_irq);
-                    }
-                }
-            }
+            qemu_irq rtc_data_in_irq = qdev_get_gpio_in_named(
+                DEVICE(s), "rtc-data-in", 0);
 
-            rtc->phase++;
-            if (rtc->phase == 16 && next_rtc_cmd_is_write(rtc->command)) {
-                if (rtc->command >= 0x80 && rtc->command <= 0x9f) {
-                    /* RAM registers */
-                    rtc->ram[rtc->command - 0x80] = rtc->value;
-                }
-                if (rtc->command == 0xb1) {
-                    /* write to 0x30 register */
-                    if (rtc->value & 0x04) {
-                        /* clear FTU */
-                        rtc->status = rtc->status & (~0x18);
-                        qemu_irq_lower(s->rtc_power_irq);
-                    }
-                }
+            if (scr2_2 & SCR2_RTDATA) {
+                qemu_irq_raise(rtc_data_in_irq);
+            } else {
+                qemu_irq_lower(rtc_data_in_irq);
             }
         }
     } else {
@@ -1104,6 +1117,8 @@ static void next_pc_init(Object *obj)
     s->rtc_power_irq = qdev_get_gpio_in(DEVICE(obj), NEXT_PWR_I);
     qdev_init_gpio_in_named(DEVICE(obj), next_pc_rtc_data_in_irq,
                             "pc-rtc-data-in", 1);
+    qdev_init_gpio_in_named(DEVICE(obj), next_rtc_data_in_irq,
+                            "rtc-data-in", 1);
 }
 
 /*
-- 
2.39.5


