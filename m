Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF12AD2E02A
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 09:02:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3XEU-0002bA-W2; Wed, 23 Oct 2024 05:00:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1t3XEL-0002NK-PW
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 05:00:43 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1t3XEF-0000bz-RM
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 05:00:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=w8gCVyqkhRz2bCL7+5ToSXDZkWqzb+mPrbuIc1HGRDQ=; b=ANx5FMAiX1KKzZlEacNA4RLVc6
 UDpCgRTh6BnY93WHBihkUKLV8b20YoFUxxBTjRg6QosWBUk5l0JNC2JCiPmPNhf7VoR8e6UNXsavB
 CIMIPwiZcl0x/pDaQARFtHNtG0i/dOLUBFUC2eT9ovPmJEjUZerK55jzcGyRZtdemAZe1LfuWdGns
 yke15NbiiOc08AAQAjwlxRbTwq7aJyyBvc1oUkIiUsMWGUJObNeklh8KD2spgzltvIOtlP+6g36Bo
 o17WsE8nSCZBSRaxy8z1Dp9omJKPIR0y/G+ErdSlo3C5hWArwWIct+/Wi6nUoHIV3lXm1an1WHgvV
 2zo66R5kx/wzqdclQcGvFNaB3S20fwYdzm2+rQ0uC5ceeEb1NzZpQ4qwXV3exMcjr6iSAwupvkQcg
 lEKAIQkFA8rzer/Mh1CnB5jOidw5THW4HpFJmDQx/YXbJ6yYajsvWbTXipocU9tuK7KKt/wPkgKqe
 O3NCxDSZBh98pXFh9ySMrXfz9pXKnIQgBuy6sK8nzQtWBfzFQKtDrDW3mckrznW5eR1KgWqYn9txA
 KT5Xpx1HrWqNyrdktDAcEpodZExCf8LZ/69rFJrkJaV1nNZ6Y5vIDqOgt8ugGyPb3QDd6NxShzoG4
 RsIezOsBG13vn1c1hjVQM3meaTNbSdcyaAEeYQiGo=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1t3XDl-0008EL-EH; Wed, 23 Oct 2024 10:00:05 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: huth@tuxfamily.org,
	qemu-devel@nongnu.org
Date: Wed, 23 Oct 2024 09:58:38 +0100
Message-Id: <20241023085852.1061031-23-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241023085852.1061031-1-mark.cave-ayland@ilande.co.uk>
References: <20241023085852.1061031-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 22/36] next-cube: separate rtc read and write shift logic
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
---
 hw/m68k/next-cube.c | 138 ++++++++++++++++++++++++--------------------
 1 file changed, 74 insertions(+), 64 deletions(-)

diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
index bb375b63ca..4aed80c9fe 100644
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


