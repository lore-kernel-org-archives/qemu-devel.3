Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 098C7E7718D
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Dec 2024 13:10:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tPLdg-0003yv-En; Sun, 22 Dec 2024 08:04:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tPLat-0006EV-E9
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 08:02:07 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tPLar-0000pj-Dz
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 08:02:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=oQYl854qA6sF/D4hNBTousAZCJ8CnhbS3cCi7B4S5qs=; b=kMWdwslm4DnRSywL23hmFzw2AT
 baVcikhng5FxMYQldHiCAemWESSQJjd10bhm+qG6wa3mJTkJNERQBek9qpBvP96cpvIQUfo1np7WB
 N+Qxhx2GP3iOKyfxY3qypCs5nW5fcmL7E3YN+jWyuXMXhS0F7Bey9J5Rw+nioJQxsmbebMpcMhXx8
 ZeoXfKqiJohc8tYpJHekjS8JoOzBDU1X/xFiFZYKZeXgLG6d9p/XtClvwaBT+lcqA8aEq8jAyI5h3
 vkksoc4JkhBGodAaT9OrYg2f97QgGYV2v+yPY9BBhNQ91E8hJOIgJZDs2NqycoTWp8aFt150UxCT+
 WczCOITfkrSa6XBL5Z8kCsBDf0naD2dWSebxOA/T5+JXw4avDWrpvHZR7iM8+Mj3DTR2SZHkYMT+s
 oTVt1NToHtsCYaNqACbkFztmT3S8XWRv0SinbKs+kmALHlpt+NgifVFDnyn2tF5ArrLBJc4YX11WL
 7qmp+92MHIlgaKMqovPv1V0QbZL64230wNKUgS8MfCViq0bJggrkdLIYjHvXfV0whxyBkny0TFKmh
 uz7wmlfgOgOlfkLFKFqqOpC2ET/y8DEUBsOGqSYZ3SPNcq6avO4k5xoXUYmP8lWtcpkWVS36oLf0g
 QsV+1KrU9jMbrLabY12tWEmIolMUmqOBG/9DFC/rc=;
Received: from [2a02:8012:2f01:0:33a9:475d:1cd9:884]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tPLa2-0002L7-Li; Sun, 22 Dec 2024 13:01:14 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: huth@tuxfamily.org,
	qemu-devel@nongnu.org
Date: Sun, 22 Dec 2024 13:00:02 +0000
Message-Id: <20241222130012.1013374-24-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241222130012.1013374-1-mark.cave-ayland@ilande.co.uk>
References: <20241222130012.1013374-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:2f01:0:33a9:475d:1cd9:884
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v3 23/33] next-cube: use named gpio to read RTC data bit in
 scr2
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
Reviewed-by: Thomas Huth <huth@tuxfamily.org>
---
 hw/m68k/next-cube.c | 169 ++++++++++++++++++++++++--------------------
 1 file changed, 92 insertions(+), 77 deletions(-)

diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
index bc3afa7d54..53acf0a1c7 100644
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


