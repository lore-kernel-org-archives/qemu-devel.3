Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5600E7718B
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Dec 2024 07:31:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tRnie-0000ou-8V; Sun, 29 Dec 2024 02:28:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1tRnhr-0006mj-IQ
 for qemu-devel@nongnu.org; Sun, 29 Dec 2024 02:27:29 -0500
Received: from mail-ej1-f48.google.com ([209.85.218.48])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1tRnhn-0002CH-EF
 for qemu-devel@nongnu.org; Sun, 29 Dec 2024 02:27:21 -0500
Received: by mail-ej1-f48.google.com with SMTP id
 a640c23a62f3a-aaec111762bso1088817366b.2
 for <qemu-devel@nongnu.org>; Sat, 28 Dec 2024 23:27:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735457238; x=1736062038;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DzveOhRiIEBig4HvofWIGXADQFAE0L+6BqYli124gd8=;
 b=TqX5fgBMGBX/YIxDVzff+c8kZv0PdCDgVCscM0dVafrpe5dfXHsUAaXB2pZllEWoVA
 LyJXXxlf8rYAtNU9u9wEdcT92mSjULaTZACf05U8iN7k/Kj0wVJOK39gZvMayFVaV64a
 0Qvz/sZA8FcrfH/AOE54DjOll8LubpnwlZ64oYH9RoaYNT7ZcxhRQYAhbFDpfxJKy+pc
 V/AVNWqnaEWVd7AGh7hkWfvXGqWBXZ3DGLj3u8c/U6sgngw/d+iagONPWzHZCRLM/Ebp
 meCBLYX9qslKhScWeCB9CMjrsj0wI44TSSUA7iTK73dj9bGLO4rbQwcqfLIAbrA0K+13
 2oLQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWs2f9Zv34n9j3OaylXgcaz0s+wHwmD799Iwsc8DKmBVu1IdAkY4r1mpM660nmlXmRsKDq6xvWX4+DY@nongnu.org
X-Gm-Message-State: AOJu0YwYd98G8s65qCQvTFEzSysO5KnI5UdrYyQ65GfiJrnGg5fwgLeu
 aZlGpOqdf+Z1GsAZ6bXZ3yzmlWbk49X7dz0AQ9RFjBwDPyikJMd7w+UCKA==
X-Gm-Gg: ASbGncuCYG6UncTjYRwjfWw3236QVjbX4+/KJHPifiW6VkZeMIh3da7zlgle30Sk19w
 WMIS9vxXCpCow+6uDGBD1DVP7WfZNouWWGv8Udzk0dbNE82h25jWN1kZ1y5UNSiHmvx3i0OofbV
 rtTz561J+eq/n8SW+KS4ejSTtWCtPpmmVCNvCNIAcS4FY9FptGRjn8cUHY/wx/jbwO9nbwbbq2V
 R9I+o1oQVvN3xGUMBc2n9PacnHcyOPgi0925PdNrKD8DsWXepg2i3sxI2hQjlvROI2Brn35c447
 g64=
X-Google-Smtp-Source: AGHT+IF8p66uGfxFARLrByW0GB83ZMKxyby79MDcHRYemDv1UIYUfIBL6VhZRlenlEd4NvT4kXaOJA==
X-Received: by 2002:a17:907:1a4e:b0:aac:4324:977e with SMTP id
 a640c23a62f3a-aac432497bamr2509176966b.27.1735457237843; 
 Sat, 28 Dec 2024 23:27:17 -0800 (PST)
Received: from tpx1.. (ip-109-42-49-90.web.vodafone.de. [109.42.49.90])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aac0e895194sm1329218666b.70.2024.12.28.23.27.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Dec 2024 23:27:17 -0800 (PST)
From: Thomas Huth <huth@tuxfamily.org>
To: Stefan Hajnoczi <stefanha@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PULL 22/35] next-cube: separate rtc read and write shift logic
Date: Sun, 29 Dec 2024 08:25:13 +0100
Message-ID: <20241229072526.166555-23-huth@tuxfamily.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241229072526.166555-1-huth@tuxfamily.org>
References: <20241229072526.166555-1-huth@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.218.48; envelope-from=th.huth@gmail.com;
 helo=mail-ej1-f48.google.com
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

Introduce a new next_rtc_cmd_is_write() function to determine if an rtc command
is a read or write, and start by using it to avoid shifting the rtc input value
if a rtc read command is executed.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Thomas Huth <huth@tuxfamily.org>
Message-ID: <20241222130012.1013374-21-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Thomas Huth <huth@tuxfamily.org>
---
 hw/m68k/next-cube.c | 138 ++++++++++++++++++++++++--------------------
 1 file changed, 74 insertions(+), 64 deletions(-)

diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
index 12f8ecd2d4..eb7d3a9cbd 100644
--- a/hw/m68k/next-cube.c
+++ b/hw/m68k/next-cube.c
@@ -165,6 +165,12 @@ static void next_scr2_led_update(NeXTPC *s)
     }
 }
 
+static bool next_rtc_cmd_is_write(uint8_t cmd)
+{
+    return (cmd >= 0x80 && cmd <= 0x9f) ||
+           (cmd == 0xb1);
+}
+
 static void next_scr2_rtc_update(NeXTPC *s)
 {
     uint8_t old_scr2, scr2_2;
@@ -186,76 +192,80 @@ static void next_scr2_rtc_update(NeXTPC *s)
                                ((scr2_2 & SCR2_RTDATA) ? 1 : 0);
             }
             if (rtc->phase >= 8 && rtc->phase < 16) {
-                rtc->value = (rtc->value << 1) |
-                             ((scr2_2 & SCR2_RTDATA) ? 1 : 0);
-
-                /* if we read RAM register, output RT_DATA bit */
-                if (rtc->command <= 0x1F) {
-                    scr2_2 = scr2_2 & (~SCR2_RTDATA);
-                    if (rtc->ram[rtc->command] & (0x80 >> (rtc->phase - 8))) {
-                        scr2_2 |= SCR2_RTDATA;
-                    }
-
-                    rtc->retval = (rtc->retval << 1) |
-                                  ((scr2_2 & SCR2_RTDATA) ? 1 : 0);
-                }
-                /* read the status 0x30 */
-                if (rtc->command == 0x30) {
-                    scr2_2 = scr2_2 & (~SCR2_RTDATA);
-                    /* for now status = 0x98 (new rtc + FTU) */
-                    if (rtc->status & (0x80 >> (rtc->phase - 8))) {
-                        scr2_2 |= SCR2_RTDATA;
+                if (next_rtc_cmd_is_write(rtc->command)) {
+                    /* Shift in value to write */
+                    rtc->value = (rtc->value << 1) |
+                                 ((scr2_2 & SCR2_RTDATA) ? 1 : 0);
+                } else {
+                    /* Shift out value to read */
+
+                    /* if we read RAM register, output RT_DATA bit */
+                    if (rtc->command <= 0x1F) {
+                        scr2_2 = scr2_2 & (~SCR2_RTDATA);
+                        if (rtc->ram[rtc->command] &
+                            (0x80 >> (rtc->phase - 8))) {
+                                scr2_2 |= SCR2_RTDATA;
+                        }
+
+                        rtc->retval = (rtc->retval << 1) |
+                                      ((scr2_2 & SCR2_RTDATA) ? 1 : 0);
                     }
-
-                    rtc->retval = (rtc->retval << 1) |
-                                  ((scr2_2 & SCR2_RTDATA) ? 1 : 0);
-                }
-                /* read the status 0x31 */
-                if (rtc->command == 0x31) {
-                    scr2_2 = scr2_2 & (~SCR2_RTDATA);
-                    if (rtc->control & (0x80 >> (rtc->phase - 8))) {
-                        scr2_2 |= SCR2_RTDATA;
+                    /* read the status 0x30 */
+                    if (rtc->command == 0x30) {
+                        scr2_2 = scr2_2 & (~SCR2_RTDATA);
+                        /* for now status = 0x98 (new rtc + FTU) */
+                        if (rtc->status & (0x80 >> (rtc->phase - 8))) {
+                            scr2_2 |= SCR2_RTDATA;
+                        }
+
+                        rtc->retval = (rtc->retval << 1) |
+                                      ((scr2_2 & SCR2_RTDATA) ? 1 : 0);
                     }
-                    rtc->retval = (rtc->retval << 1) |
-                                  ((scr2_2 & SCR2_RTDATA) ? 1 : 0);
-                }
-
-                if ((rtc->command >= 0x20) && (rtc->command <= 0x2F)) {
-                    scr2_2 = scr2_2 & (~SCR2_RTDATA);
-                    /* for now 0x00 */
-                    time_t time_h = time(NULL);
-                    struct tm *info = localtime(&time_h);
-                    int ret = 0;
-
-                    switch (rtc->command) {
-                    case 0x20:
-                        ret = SCR2_TOBCD(info->tm_sec);
-                        break;
-                    case 0x21:
-                        ret = SCR2_TOBCD(info->tm_min);
-                        break;
-                    case 0x22:
-                        ret = SCR2_TOBCD(info->tm_hour);
-                        break;
-                    case 0x24:
-                        ret = SCR2_TOBCD(info->tm_mday);
-                        break;
-                    case 0x25:
-                        ret = SCR2_TOBCD((info->tm_mon + 1));
-                        break;
-                    case 0x26:
-                        ret = SCR2_TOBCD((info->tm_year - 100));
-                        break;
-
+                    /* read the status 0x31 */
+                    if (rtc->command == 0x31) {
+                        scr2_2 = scr2_2 & (~SCR2_RTDATA);
+                        if (rtc->control & (0x80 >> (rtc->phase - 8))) {
+                            scr2_2 |= SCR2_RTDATA;
+                        }
+                        rtc->retval = (rtc->retval << 1) |
+                                      ((scr2_2 & SCR2_RTDATA) ? 1 : 0);
                     }
 
-                    if (ret & (0x80 >> (rtc->phase - 8))) {
-                        scr2_2 |= SCR2_RTDATA;
+                    if ((rtc->command >= 0x20) && (rtc->command <= 0x2F)) {
+                        scr2_2 = scr2_2 & (~SCR2_RTDATA);
+                        /* for now 0x00 */
+                        time_t time_h = time(NULL);
+                        struct tm *info = localtime(&time_h);
+                        int ret = 0;
+
+                        switch (rtc->command) {
+                        case 0x20:
+                            ret = SCR2_TOBCD(info->tm_sec);
+                            break;
+                        case 0x21:
+                            ret = SCR2_TOBCD(info->tm_min);
+                            break;
+                        case 0x22:
+                            ret = SCR2_TOBCD(info->tm_hour);
+                            break;
+                        case 0x24:
+                            ret = SCR2_TOBCD(info->tm_mday);
+                            break;
+                        case 0x25:
+                            ret = SCR2_TOBCD((info->tm_mon + 1));
+                            break;
+                        case 0x26:
+                            ret = SCR2_TOBCD((info->tm_year - 100));
+                            break;
+                        }
+
+                        if (ret & (0x80 >> (rtc->phase - 8))) {
+                            scr2_2 |= SCR2_RTDATA;
+                        }
+                        rtc->retval = (rtc->retval << 1) |
+                                      ((scr2_2 & SCR2_RTDATA) ? 1 : 0);
                     }
-                    rtc->retval = (rtc->retval << 1) |
-                                  ((scr2_2 & SCR2_RTDATA) ? 1 : 0);
                 }
-
             }
 
             rtc->phase++;
-- 
2.47.1


