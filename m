Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67310E7718F
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Dec 2024 07:28:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tRniF-0007VD-In; Sun, 29 Dec 2024 02:27:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1tRnhz-0006nR-Me
 for qemu-devel@nongnu.org; Sun, 29 Dec 2024 02:27:35 -0500
Received: from mail-ed1-f41.google.com ([209.85.208.41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1tRnhv-0002D5-SI
 for qemu-devel@nongnu.org; Sun, 29 Dec 2024 02:27:30 -0500
Received: by mail-ed1-f41.google.com with SMTP id
 4fb4d7f45d1cf-5d3d479b1e6so11449794a12.2
 for <qemu-devel@nongnu.org>; Sat, 28 Dec 2024 23:27:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735457245; x=1736062045;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+3vAzuYZc9RRRWT5kph1vz0cBKumYJzBkalZjnIrAFY=;
 b=DYaZBiVa9Yc9N1rXTypxt8TlPCo7W5SOpt8NIB/1d7F30UCOufP140/Xv6Lo6SqOs7
 JM2ZPabx1qDcVkYBgKEIg0q83P/28hnS6J45Qff58+fj3hX62RiIg9s4RRig3FPDvTgA
 hgo923XqVL9uaHWC6bWFIjA3c9TNFKxe8ozW5m2rMWasL1ufQnSfon1Tr1zvGiosR9nW
 4KvRyntyHdID9Ha33+q6hK2abfHWGTE692r2vBAyirg4tmnETRkjTt7eWUZm56iTaOl7
 CmiJxNPh8nMnTh0OHz9oXKaGl6mAkv1zQ55ZAGt39m9A9KlMPMCv7NljHE5Hq0oX2IXM
 nEFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJ7+rNrH7Ipgwo45pjCuxAO63Cf2Yxam8sjculdK7XOFK1Qr3Z6/lkROvKB12bjxmPxHUU9+IZrpLc@nongnu.org
X-Gm-Message-State: AOJu0YwF4PkiiRMQOcOqxe1ZcPfDdG/9Q4FQZLDMFHEozjabLvtPYyHD
 99E6JQhGjQtHVySYmMWp/RWvtsqVQMquGuC2TaKgJ+yeCkSvyLDR
X-Gm-Gg: ASbGncsQStc2HoKVvpOJRQaZtyVIc6307UuJNgoqI2Op8YTel5L0x6Gx8SijiaMKhxP
 LrYD2bRqOc04Os7BIvF1KrIdW5mamKXOax1X/qjGSOdpK9//FCItIUTqQXxExCdjp3r8ix6pNLk
 1FhlWUWZUGjobCjCLLW9KR4MviA8P9R1/YAT1IqFv1w6lvPz2BX0eE/9tHrgMdQOT6VwAVf0xF2
 3KnTQjuD52Vk23soGSNFjQ/8puoHtnafER7hXmJaB18mnSGbl6RxJfiWBV6f/7d+EWGrto7mOiz
 2Ds=
X-Google-Smtp-Source: AGHT+IGzCg9KE49W/YIFU2JD7XUWItdi+KaHwdNlrFvkADcze917cwPKihlzAQCQYKBLQZ2vdUOkMg==
X-Received: by 2002:a50:cc48:0:b0:5d3:cf89:bd3e with SMTP id
 4fb4d7f45d1cf-5d81de1c92cmr60092193a12.30.1735457244875; 
 Sat, 28 Dec 2024 23:27:24 -0800 (PST)
Received: from tpx1.. (ip-109-42-49-90.web.vodafone.de. [109.42.49.90])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aac0e895194sm1329218666b.70.2024.12.28.23.27.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Dec 2024 23:27:23 -0800 (PST)
From: Thomas Huth <huth@tuxfamily.org>
To: Stefan Hajnoczi <stefanha@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PULL 25/35] next-cube: use named gpio to read RTC data bit in scr2
Date: Sun, 29 Dec 2024 08:25:16 +0100
Message-ID: <20241229072526.166555-26-huth@tuxfamily.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241229072526.166555-1-huth@tuxfamily.org>
References: <20241229072526.166555-1-huth@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.208.41; envelope-from=th.huth@gmail.com;
 helo=mail-ed1-f41.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.156, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

This is in preparation for moving NeXTRTC to its own separate device.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Thomas Huth <huth@tuxfamily.org>
Message-ID: <20241222130012.1013374-24-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Thomas Huth <huth@tuxfamily.org>
---
 hw/m68k/next-cube.c | 169 ++++++++++++++++++++++++--------------------
 1 file changed, 92 insertions(+), 77 deletions(-)

diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
index 1e9e662b40..0f24905525 100644
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
2.47.1


