Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49A1BE7718D
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Dec 2024 13:07:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tPLdO-0001lB-Va; Sun, 22 Dec 2024 08:04:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tPLah-0006AH-LM
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 08:01:58 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tPLad-0000nl-9N
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 08:01:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=asqk+C+mnPCOf2X7Oz5YB0cynC0owfsP8zB012RqmDM=; b=KCEdsPAjCH3eGyeVhzBo1PZD4E
 AfK2t8oziXHesibmKzXVVaVXWzq1dddd3hB1dfMuG8iVbB1U+r9ytI3dqRXfdqzszn/cyieu+Unzq
 /f6oCGZjOUVuI4QDRzQC8HluazqVDWD6tyHRTGi6/CJyeC/zwgGaNSIGbgSPKfzlFvCB15KDcORab
 wuuNyi658du/k5jxkY0xEBqyQuSR72MhqD7djsYrFtFB0hWfNurTSGVaZ3QJ53LBxrXb50SDWCw3U
 200xSIP8CZKp0tZ2uB9gRYBsxOvvdldp716szFXvoHXbtE6C+vdYo43CsEhogHw0e1dWw14VZTHu9
 Rgpj+dvyElVWUPDLAMV++N7CRntcRBNuc45Qb9HDVJSf4AO/6aDeGsks9ZLNVo2NtKlWEIE8gC/yS
 2WEl8/ADgGicoEy6j/JDUCZu2chM+OhjMZe8TYasww1AaheHbJGslFFsjAxf+m73FoFDAkcmerDHb
 6mcfXyPH/M9O4JCd02YGdgcWizDszyQ0S7eV+zpqQTDXPw8gugHbny4kx5o+prUxKQWV+g5O1bFNd
 k1yjvDX8w0yuJ/+5UZrsOrYPJ44E4NhOZpnzxiN9R0zitsfFbJe5FEvwmvqkel7udk57XX7PDVqon
 cg7h593fqSXTekPqlUG8UvS2Cd0/2r9sqC6mAwJOY=;
Received: from [2a02:8012:2f01:0:33a9:475d:1cd9:884]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tPLZq-0002L7-1s; Sun, 22 Dec 2024 13:01:02 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: huth@tuxfamily.org,
	qemu-devel@nongnu.org
Date: Sun, 22 Dec 2024 12:59:59 +0000
Message-Id: <20241222130012.1013374-21-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241222130012.1013374-1-mark.cave-ayland@ilande.co.uk>
References: <20241222130012.1013374-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:2f01:0:33a9:475d:1cd9:884
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v3 20/33] next-cube: separate rtc read and write shift logic
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
index 39cc883fd0..2c2790bf75 100644
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


