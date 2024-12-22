Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F5F3E7718D
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Dec 2024 13:05:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tPLdN-0001ek-PL; Sun, 22 Dec 2024 08:04:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tPLal-0006Bc-2v
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 08:02:07 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tPLah-0000oM-KH
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 08:01:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=JmReS6lxO6hk1QShQxhRESrBS8h+LgzPPfGMqPjpxMA=; b=Wx9WJ+cz+dec+ALvhh7CY5dclM
 3ptns7j8k4BgCg7CBZD6of6tpW5JHXxtAS9r9Z4oHV69I0FFftganN0DdKRr84atII7DoTQfVQA0u
 fhx/78xmG80GztRCZOzJCzKb8Je2k7BCEDlHstsQ/0WWb7cCk5wMldopK/AiKORJEg8CuNWIUtKBr
 NJIUHcKd6Hy2uZAKdQNFYY6IUDxC9lZdGhnaMmpmdSfHncK8ztzpR87kdLw/7EE8Y7s7+6zxYJVXv
 u1SGmGYjFS4BsZr/a0U7Bs+bKfBuUzATErmwoAnQvmSEMrZRNQ8Q4Ewki2wHulL+MROwa8O8jTN+Q
 g6ylLVyo5D0RAY0E6pZZRW3FR8YDDXz0G/SaZPmXvZoIo4dGe0gMNLvSNItKUe2g8T/IRsbUTtDQ1
 dSaai+opGJd7DPSLVbSQTdltp94VMgV2g1KLItza2mfCwTosvDUmQ4N+PQSdyyD65ZqMqhvUewtfM
 Gnhfp6m6ULgPZgVoId7M7PTKxqfbeE9rM0XzAeH5ld/vwbMtBn4PJbLrOHimOOkM9PblY8Krl+STD
 lwHN9nzzBfVGmWOL/BbUNIFlQ1uPPSdt8YQxDG929i+I6YDX6ZIyWQLVEi/A0Yb+5Re1Wy8o5ssIP
 n9uxE7F2nUTiqiBP8ZT8m4bI9wnyYdQ4Pz8uO+eA0=;
Received: from [2a02:8012:2f01:0:33a9:475d:1cd9:884]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tPLZu-0002L7-Bc; Sun, 22 Dec 2024 13:01:06 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: huth@tuxfamily.org,
	qemu-devel@nongnu.org
Date: Sun, 22 Dec 2024 13:00:00 +0000
Message-Id: <20241222130012.1013374-22-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241222130012.1013374-1-mark.cave-ayland@ilande.co.uk>
References: <20241222130012.1013374-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:2f01:0:33a9:475d:1cd9:884
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v3 21/33] next-cube: always use retval to return rtc read
 values
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

Instead of shifting out rtc read values from individual rtc registers, change
the logic so that rtc read commands are executed when the last bit of the rtc
command is received and the result stored in retval. This simplifies the rtc
read logic such that the shift out logic can be consolidated for rtc phases
between 8 and 16.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/m68k/next-cube.c | 99 ++++++++++++++++++---------------------------
 1 file changed, 40 insertions(+), 59 deletions(-)

diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
index 2c2790bf75..1fb09fee7d 100644
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
2.39.5


