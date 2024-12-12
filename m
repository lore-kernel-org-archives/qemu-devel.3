Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFF5EE7717F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 11:50:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLhfc-0000Db-4A; Thu, 12 Dec 2024 06:47:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tLhfa-0008WN-72
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 06:47:50 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tLhfY-0007JB-0l
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 06:47:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=APhrWd5QZZ6jEOlqUpuPjsOprvLQsBuxV5UucnhwLT4=; b=UKS81G/4DFGrZaKUvg06Q0p12l
 nRtWmUqSGnW5hJHJ7Du95a1ZvZX2KTRUCl/kYvDRzkpgcLREHpCK7YFSEldvaDwAwEDWHfhJk1t0P
 b1fBQisvUyeBfEHvEiUHsVGMjbF4fsYlchIeFaKA0q8wLIYbPmVhusNNlxxMWZt0gvGCdbSmtiuhd
 ae9KQcZNBjTAly6+aQG4zpiQs09HuXACTlFqMQiskXLTX9p/NE/T1nt+fj8UF/9LaQhefnGmXhxqI
 iRx9HTpAtnkXtLwNkBiW/6juLBY6mFxdDccgSZynbgjC7SwRYCCe03tQBRpOKY9tume6lgeOwZ3K9
 x0/KL+kfi891QcUxl/OuErMBGliFHH+YQWbrjSbqmns7wAjlmpvO68ecNbSNR7BbJfDf67OZ5ozoM
 7H02UeQ1pWgObRHv2J+nlT0cTD8op5p5NmKaqM28/l1WcI/cJbS17DIVTURMgYw8QLWaRhJ5jMmiP
 jO8VDyVGwZxILv9Ht7NNVU1Kr2FWjG0rk27N7BRVg35mYTg7mcvyXjRQ3aDOSpcKFlx27xFLRoX7H
 SHV8+1v7mcQOdgWRmiIsjRNAHYmaFlCSgfCOAFpmgfjcJzqoxRA3uoQGO03sILepAVMATuM8D42F9
 Z/1maFycbx8j22mw9D6RaGH4+hg5CxKn0ImROo5+4=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tLhen-00070a-Uu; Thu, 12 Dec 2024 11:47:06 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: huth@tuxfamily.org,
	qemu-devel@nongnu.org
Date: Thu, 12 Dec 2024 11:46:07 +0000
Message-Id: <20241212114620.549285-22-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241212114620.549285-1-mark.cave-ayland@ilande.co.uk>
References: <20241212114620.549285-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 21/34] next-cube: always use retval to return rtc read
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
index cc3dcad4e6..b5abc2b822 100644
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


