Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F047E7718B
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Dec 2024 07:34:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tRniD-0007Gy-RK; Sun, 29 Dec 2024 02:27:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1tRnhw-0006n2-Ja
 for qemu-devel@nongnu.org; Sun, 29 Dec 2024 02:27:33 -0500
Received: from mail-ej1-f49.google.com ([209.85.218.49])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1tRnhq-0002CZ-PR
 for qemu-devel@nongnu.org; Sun, 29 Dec 2024 02:27:25 -0500
Received: by mail-ej1-f49.google.com with SMTP id
 a640c23a62f3a-aaec111762bso1088819666b.2
 for <qemu-devel@nongnu.org>; Sat, 28 Dec 2024 23:27:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735457240; x=1736062040;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1CKmsiBxDsEcPgpVnWfaRNwB5nXqfB3bWSG3OJN/nu8=;
 b=HZwfiMT4z+sIipzSK8oLd2vJQb1NmaXqALHKuVdZsD8+evEWRjhEhlOpKnBc8PGGIg
 s9sP93aQc9Ug5Gcu6CaFV+SXZiLC0q87CUYO4evroLE8VXTz7qLtQ/xmy9UPkWFs3ztP
 1mO4gODR43EWzjkOXuv21tZdKLIi6+qIibk8xT3yl8tSUsVkegqH8zzeK2hZGCTzZgnE
 F7u9nfZzdRhqTtGlh9WinzBEQlQG8C7KIaRnwu2uSbJhsS0d1rNI94gWYgX/BXtYGAwA
 IRBdMKN7Gbffr8kKCsYO8iiPNd1QBPxF/iQTYdfeMqQ+yePG9QEaF9qKi4VQ06SwlQ7i
 uZqw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVuMocMHieuE8qTgGJ1ZBqtK+kTLAR52IDq0bYCJ8CQSLZqxuP+h/lnlSsYhK5i661fk7LoDK6Zl9Nd@nongnu.org
X-Gm-Message-State: AOJu0Yy+qJIlWg8NnnkaNESIKuMlxsj6elEATOps40IswajcHBOc0ot+
 04ULpvt/wYpofuh/pR+5LMISr6Oe9O1lzOs/sIIA43rams9hvMd6DtishQ==
X-Gm-Gg: ASbGncuxUaXcORmTibO9Np0SAxu8zfVxscnrAUd/DOYyTQh2NoieP2i+9w9aZwZYk98
 qKzQNn3gCMM7Zt3xfkGri3P2TaMgXyuwAsHK4nM4y4PMLb1PiG76+/qsr/TFls7LRZhLXswgsJp
 HIvVTtrkTRtVb8gvwo7EdBsHw0oPNzVh+1T+PlEKWERq2dvz95npeBPh1dCHiQLIZ1P3W0w32Cs
 0+OcJYW97crYUq0Vmd+q+myP3nhhwBWM/yj9F+d3DJXN7rg83HgFYEiNRSDiZ5rF6ALfeYhD56v
 R5o=
X-Google-Smtp-Source: AGHT+IGhIzZ3iM8xN5fzSaXW/rbb7Lu2jkIa8x1BN6wjSry39XeIVzBcFBVxa4Xok+rO4CxgMTWwPQ==
X-Received: by 2002:a17:907:9722:b0:aa6:6fa5:65b3 with SMTP id
 a640c23a62f3a-aac3352c204mr2881754366b.47.1735457240275; 
 Sat, 28 Dec 2024 23:27:20 -0800 (PST)
Received: from tpx1.. (ip-109-42-49-90.web.vodafone.de. [109.42.49.90])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aac0e895194sm1329218666b.70.2024.12.28.23.27.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Dec 2024 23:27:19 -0800 (PST)
From: Thomas Huth <huth@tuxfamily.org>
To: Stefan Hajnoczi <stefanha@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PULL 23/35] next-cube: always use retval to return rtc read values
Date: Sun, 29 Dec 2024 08:25:14 +0100
Message-ID: <20241229072526.166555-24-huth@tuxfamily.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241229072526.166555-1-huth@tuxfamily.org>
References: <20241229072526.166555-1-huth@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.218.49; envelope-from=th.huth@gmail.com;
 helo=mail-ej1-f49.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.156, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Instead of shifting out rtc read values from individual rtc registers, change
the logic so that rtc read commands are executed when the last bit of the rtc
command is received and the result stored in retval. This simplifies the rtc
read logic such that the shift out logic can be consolidated for rtc phases
between 8 and 16.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <20241222130012.1013374-22-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Thomas Huth <huth@tuxfamily.org>
---
 hw/m68k/next-cube.c | 99 ++++++++++++++++++---------------------------
 1 file changed, 40 insertions(+), 59 deletions(-)

diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
index eb7d3a9cbd..a39117144c 100644
--- a/hw/m68k/next-cube.c
+++ b/hw/m68k/next-cube.c
@@ -190,93 +190,74 @@ static void next_scr2_rtc_update(NeXTPC *s)
             if (rtc->phase < 8) {
                 rtc->command = (rtc->command << 1) |
                                ((scr2_2 & SCR2_RTDATA) ? 1 : 0);
-            }
-            if (rtc->phase >= 8 && rtc->phase < 16) {
-                if (next_rtc_cmd_is_write(rtc->command)) {
-                    /* Shift in value to write */
-                    rtc->value = (rtc->value << 1) |
-                                 ((scr2_2 & SCR2_RTDATA) ? 1 : 0);
-                } else {
-                    /* Shift out value to read */
 
-                    /* if we read RAM register, output RT_DATA bit */
-                    if (rtc->command <= 0x1F) {
-                        scr2_2 = scr2_2 & (~SCR2_RTDATA);
-                        if (rtc->ram[rtc->command] &
-                            (0x80 >> (rtc->phase - 8))) {
-                                scr2_2 |= SCR2_RTDATA;
-                        }
-
-                        rtc->retval = (rtc->retval << 1) |
-                                      ((scr2_2 & SCR2_RTDATA) ? 1 : 0);
-                    }
-                    /* read the status 0x30 */
-                    if (rtc->command == 0x30) {
-                        scr2_2 = scr2_2 & (~SCR2_RTDATA);
-                        /* for now status = 0x98 (new rtc + FTU) */
-                        if (rtc->status & (0x80 >> (rtc->phase - 8))) {
-                            scr2_2 |= SCR2_RTDATA;
-                        }
-
-                        rtc->retval = (rtc->retval << 1) |
-                                      ((scr2_2 & SCR2_RTDATA) ? 1 : 0);
-                    }
-                    /* read the status 0x31 */
-                    if (rtc->command == 0x31) {
-                        scr2_2 = scr2_2 & (~SCR2_RTDATA);
-                        if (rtc->control & (0x80 >> (rtc->phase - 8))) {
-                            scr2_2 |= SCR2_RTDATA;
-                        }
-                        rtc->retval = (rtc->retval << 1) |
-                                      ((scr2_2 & SCR2_RTDATA) ? 1 : 0);
+                if (rtc->phase == 7 && !next_rtc_cmd_is_write(rtc->command)) {
+                    if (rtc->command <= 0x1f) {
+                        /* RAM registers */
+                        rtc->retval = rtc->ram[rtc->command];
                     }
-
                     if ((rtc->command >= 0x20) && (rtc->command <= 0x2F)) {
-                        scr2_2 = scr2_2 & (~SCR2_RTDATA);
-                        /* for now 0x00 */
+                        /* RTC */
                         time_t time_h = time(NULL);
                         struct tm *info = localtime(&time_h);
-                        int ret = 0;
+                        rtc->retval = 0;
 
                         switch (rtc->command) {
                         case 0x20:
-                            ret = SCR2_TOBCD(info->tm_sec);
+                            rtc->retval = SCR2_TOBCD(info->tm_sec);
                             break;
                         case 0x21:
-                            ret = SCR2_TOBCD(info->tm_min);
+                            rtc->retval = SCR2_TOBCD(info->tm_min);
                             break;
                         case 0x22:
-                            ret = SCR2_TOBCD(info->tm_hour);
+                            rtc->retval = SCR2_TOBCD(info->tm_hour);
                             break;
                         case 0x24:
-                            ret = SCR2_TOBCD(info->tm_mday);
+                            rtc->retval = SCR2_TOBCD(info->tm_mday);
                             break;
                         case 0x25:
-                            ret = SCR2_TOBCD((info->tm_mon + 1));
+                            rtc->retval = SCR2_TOBCD((info->tm_mon + 1));
                             break;
                         case 0x26:
-                            ret = SCR2_TOBCD((info->tm_year - 100));
+                            rtc->retval = SCR2_TOBCD((info->tm_year - 100));
                             break;
                         }
-
-                        if (ret & (0x80 >> (rtc->phase - 8))) {
-                            scr2_2 |= SCR2_RTDATA;
-                        }
-                        rtc->retval = (rtc->retval << 1) |
-                                      ((scr2_2 & SCR2_RTDATA) ? 1 : 0);
+                    }
+                    if (rtc->command == 0x30) {
+                        /* read the status 0x30 */
+                        rtc->retval = rtc->status;
+                    }
+                    if (rtc->command == 0x31) {
+                        /* read the control 0x31 */
+                        rtc->retval = rtc->control;
+                    }
+                }
+            }
+            if (rtc->phase >= 8 && rtc->phase < 16) {
+                if (next_rtc_cmd_is_write(rtc->command)) {
+                    /* Shift in value to write */
+                    rtc->value = (rtc->value << 1) |
+                                 ((scr2_2 & SCR2_RTDATA) ? 1 : 0);
+                } else {
+                    /* Shift out value to read */
+                    if (rtc->retval & (0x80 >> (rtc->phase - 8))) {
+                        scr2_2 |= SCR2_RTDATA;
+                    } else {
+                        scr2_2 &= ~SCR2_RTDATA;
                     }
                 }
             }
 
             rtc->phase++;
-            if (rtc->phase == 16) {
-                if (rtc->command >= 0x80 && rtc->command <= 0x9F) {
+            if (rtc->phase == 16 && next_rtc_cmd_is_write(rtc->command)) {
+                if (rtc->command >= 0x80 && rtc->command <= 0x9f) {
+                    /* RAM registers */
                     rtc->ram[rtc->command - 0x80] = rtc->value;
                 }
-                /* write to x30 register */
-                if (rtc->command == 0xB1) {
-                    /* clear FTU */
+                if (rtc->command == 0xb1) {
+                    /* write to 0x30 register */
                     if (rtc->value & 0x04) {
+                        /* clear FTU */
                         rtc->status = rtc->status & (~0x18);
                         qemu_irq_lower(s->rtc_power_irq);
                     }
-- 
2.47.1


