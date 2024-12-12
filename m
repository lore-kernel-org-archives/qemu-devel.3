Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1302BE77182
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 11:52:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLhfX-00085J-2w; Thu, 12 Dec 2024 06:47:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tLhfW-00081E-0f
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 06:47:46 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tLhfU-0007IN-Ac
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 06:47:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=RSFdIpt1C5+V0SfsGpRxJv6QwcqHsAz67212xhv4bKI=; b=rPPAj7SM0ebP7cJ6fLqaSlnoUg
 LIPLl5/hcKoy/9YfjAW04rLjoqme0Uazx7xyUrw0o/Ik7WvJ2IUpEdV54e912Nj0wg08KIFHU1KTz
 P60/EeGy/+eV31C9Pb5NZqZxcWGvJB4Fyx16CXMAwfLK15DJr8bK7CWGNalefK3IFicrgkHzJvzNZ
 xe3di8khEb85h8KEYDwwAe/zv2/nsHrTEc2SzAFowRiASRiFuDSczzt3my9OwVBBGB73hkAncsK5b
 lIT4f1JKqrjT1zpraVqV1stoRwQKxSlvOPyf1KN4xmFV1R/dRUyEluO7FZQ/6arOw6/UmGtbAgv9h
 nDAL1F6bZp8e23wFb4J/WA4p+RckpSvzuBT5G/4+WcH7ZhGkTfQ3FpFBTRZdpWSdshKGuxK+cZDqy
 PwJTAl/qW8/l941LWXFK5c7tiz/UDL+T3yoFQVVCsE2QTyQlhM48dDg+m8GmGEM6r48FARM27axNl
 pixzAk+AAm2Q320RIX7WJTTBiyV5iWJfe1Oq3gbmX1tN+iD+i0FCDiwFI4OdTlFl31yZlujQBQYoT
 1j66do/41+2Pegbs1C7P+eZqkNoqGMNg5qv+xC5FRwE2ed30gEaseVVeiU7fkh3y6BlbNZXccGGsA
 +MBRNGGN4vz/3kLYyA3LqK9wHiCOR/BHrW0vP1AZ4=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tLhej-00070a-OP; Thu, 12 Dec 2024 11:47:01 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: huth@tuxfamily.org,
	qemu-devel@nongnu.org
Date: Thu, 12 Dec 2024 11:46:06 +0000
Message-Id: <20241212114620.549285-21-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241212114620.549285-1-mark.cave-ayland@ilande.co.uk>
References: <20241212114620.549285-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 20/34] next-cube: separate rtc read and write shift logic
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

Introduce a new next_rtc_cmd_is_write() function to determine if an rtc command
is a read or write, and start by using it to avoid shifting the rtc input value
if a rtc read command is executed.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Thomas Huth <huth@tuxfamily.org>
---
 hw/m68k/next-cube.c | 138 ++++++++++++++++++++++++--------------------
 1 file changed, 74 insertions(+), 64 deletions(-)

diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
index 7c6dc132fe..cc3dcad4e6 100644
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
2.39.5


