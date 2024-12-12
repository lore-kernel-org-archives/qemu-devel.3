Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BDE7E7717F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 11:50:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLhfl-0000yJ-4O; Thu, 12 Dec 2024 06:48:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tLhfi-0000q6-1f
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 06:47:58 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tLhfg-0007K1-9C
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 06:47:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=DR6GrphDHBCkzFHNfpKJXnrT4MjOAPz81i0mZlcesyY=; b=q5nXljbnxUB6NL+9zlCmib9r9G
 zC0fuvZEv8IlTa7/M9wM7TBTpP0FbnZ1GqPgwolfxDf8H6ChFoWD2sUQAelePQo+JvEIzVi1LPqSS
 JOHEYCDg3Ea8QrtznomwvTP+vzgPfLn9pBJxy5n2g0HchVCYBVI3MdyjPnE9g0EShzIp/CY+e3ro8
 X+1igyWwz9e2bFdPn3eayg1+AsHRYhfM3xdpEFCpmZL+0SWrHIs3tKIKBOToUjhuDn2DvyNC0rDW8
 vBG7Ks4BeKEHMOlW8RiA714DgiBnEJisSQchk/2YZJuKoQL5dpODxzQsjNLDAB7lSYP+9SKG2HEkh
 C0MX1m6SI9TeIdNMLyaRt6h0wt42AvXpAoMb9dz5phI3M01hqY2txXlA7uikySCf6aeWKF+vvkSke
 J+Z434J5nXWDxGf9VDvuK8ogRgPXUu236BAJ1CKYTHl6Slu7nw8zxIf47N7I0irsokJ82VozOiWWZ
 oXjWOtIoPjCzjy99M1Rp0qRdMEZhG9tzsSBTxWAiOfeDR+DWHME3UUnaUKDXsa5z87fXiKEyJ6B8d
 8gVkTp1sL5j7eLqu6UCNLWF2RS5nUwhehOoS/pgyC3cz+5ojpOfnlX9O/Xd6Wdvo1YxRaRzzlVBMm
 MSeM5zMASw8oGAiy5eabcrMQt54iPedykUWDlUvbA=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tLhew-00070a-BR; Thu, 12 Dec 2024 11:47:14 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: huth@tuxfamily.org,
	qemu-devel@nongnu.org
Date: Thu, 12 Dec 2024 11:46:09 +0000
Message-Id: <20241212114620.549285-24-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241212114620.549285-1-mark.cave-ayland@ilande.co.uk>
References: <20241212114620.549285-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 23/34] next-cube: use named gpio to read RTC data bit in
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
index 89dd9f5b85..e13f46add2 100644
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


