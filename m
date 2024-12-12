Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D347E77182
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 11:49:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLhgI-000390-8s; Thu, 12 Dec 2024 06:48:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tLhg5-0002mX-EJ
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 06:48:21 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tLhg3-0007Nf-3e
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 06:48:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=3yA20NBt6M6g87M1rHFQUcoesnQCGl0+GNmfTJjjil0=; b=niRtKAOxmgjDC9RzRc+tglKu5j
 OOTRh44iW0VkRYzmIgNX/Czfl5PqNbkzmhoe1JZIw/Iu/soXxo7o/kxvshrSzR0KeYEgERldcs97r
 +sUq8MwVsTcFy2mbflgjUYVQtFgTxrz5nkF8fINtCu9AIXiTLBqebl+lfMH28ny5LfHLlydxqWxwy
 N2ux9sCWtgBPZ3q//SQVqzceKP4IcUd5EHm9Jsp6d2n+twkjNbL0AXqCPhPk1GorOtSH5uEnJuXcK
 axil/Ht4SxOTl1JRLLgOGHnVbEuCZ4eRjpMMwwC+Hv2gM7DoEJmuVEZXC1gOlkm8yKs6xp4+CEdH0
 VX3IKQ9ECcu4ey34zQTCoes6uQhQIlnl1OGGh6v4rVxnSfBjwr8lcgib/eH9So4XPQL93j7VYLVda
 9rJrBz3rDW+qZASr2uBLuSo4hcycnNhQX2uXr+jUEz2PR8SOmh6orTmT3IZ4Zjv5gRY63/mJ40XGa
 8BnCtIAKL4NUlUAKPMCrkE8DuAUUpO3HdVMxRd+OMRYz+deC2uNOkTc5YNupE9r3dOFhUka04UgKq
 yNvhANZWnUg7HY/akbCHpXfZAcLfrqa3BygUT/mmylbGRDWgXfatcHsjbC1bcjBybW4wX+nprhV+M
 /kzIc0CHL45EYrZ4FJLorpaVarIUAt4f3S+DpoFUY=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tLhfM-00070a-Lf; Thu, 12 Dec 2024 11:47:37 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: huth@tuxfamily.org,
	qemu-devel@nongnu.org
Date: Thu, 12 Dec 2024 11:46:17 +0000
Message-Id: <20241212114620.549285-32-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241212114620.549285-1-mark.cave-ayland@ilande.co.uk>
References: <20241212114620.549285-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 31/34] next-cube: move next_rtc_cmd_is_write() and
 next_rtc_data_in_irq() functions
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

Move these functions in next-cube.c so that they are with the rest of the
next-rtc functions.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/m68k/next-cube.c | 172 ++++++++++++++++++++++----------------------
 1 file changed, 86 insertions(+), 86 deletions(-)

diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
index 94a9b90171..12d31dfaad 100644
--- a/hw/m68k/next-cube.c
+++ b/hw/m68k/next-cube.c
@@ -175,92 +175,6 @@ static void next_scr2_led_update(NeXTPC *s)
     }
 }
 
-static bool next_rtc_cmd_is_write(uint8_t cmd)
-{
-    return (cmd >= 0x80 && cmd <= 0x9f) ||
-           (cmd == 0xb1);
-}
-
-static void next_rtc_data_in_irq(void *opaque, int n, int level)
-{
-    NeXTRTC *rtc = NEXT_RTC(opaque);
-
-    if (rtc->phase < 8) {
-        rtc->command = (rtc->command << 1) | level;
-
-        if (rtc->phase == 7 && !next_rtc_cmd_is_write(rtc->command)) {
-            if (rtc->command <= 0x1f) {
-                /* RAM registers */
-                rtc->retval = rtc->ram[rtc->command];
-            }
-            if ((rtc->command >= 0x20) && (rtc->command <= 0x2f)) {
-                /* RTC */
-                time_t time_h = time(NULL);
-                struct tm *info = localtime(&time_h);
-                rtc->retval = 0;
-
-                switch (rtc->command) {
-                case 0x20:
-                    rtc->retval = SCR2_TOBCD(info->tm_sec);
-                    break;
-                case 0x21:
-                    rtc->retval = SCR2_TOBCD(info->tm_min);
-                    break;
-                case 0x22:
-                    rtc->retval = SCR2_TOBCD(info->tm_hour);
-                    break;
-                case 0x24:
-                    rtc->retval = SCR2_TOBCD(info->tm_mday);
-                    break;
-                case 0x25:
-                    rtc->retval = SCR2_TOBCD((info->tm_mon + 1));
-                    break;
-                case 0x26:
-                    rtc->retval = SCR2_TOBCD((info->tm_year - 100));
-                    break;
-                }
-            }
-            if (rtc->command == 0x30) {
-                /* read the status 0x30 */
-                rtc->retval = rtc->status;
-            }
-            if (rtc->command == 0x31) {
-                /* read the control 0x31 */
-                rtc->retval = rtc->control;
-            }
-        }
-    }
-    if (rtc->phase >= 8 && rtc->phase < 16) {
-        if (next_rtc_cmd_is_write(rtc->command)) {
-            /* Shift in value to write */
-            rtc->value = (rtc->value << 1) | level;
-        } else {
-            /* Shift out value to read */
-            if (rtc->retval & (0x80 >> (rtc->phase - 8))) {
-                qemu_irq_raise(rtc->data_out_irq);
-            } else {
-                qemu_irq_lower(rtc->data_out_irq);
-            }
-        }
-    }
-
-    rtc->phase++;
-    if (rtc->phase == 16 && next_rtc_cmd_is_write(rtc->command)) {
-        if (rtc->command >= 0x80 && rtc->command <= 0x9f) {
-            /* RAM registers */
-            rtc->ram[rtc->command - 0x80] = rtc->value;
-        }
-        if (rtc->command == 0xb1) {
-            /* write to 0x30 register */
-            if (rtc->value & 0x04) {
-                /* clear FTU */
-                rtc->status = rtc->status & (~0x18);
-                qemu_irq_lower(rtc->power_irq);
-            }
-        }
-    }
-}
-
 static void next_scr2_rtc_update(NeXTPC *s)
 {
     uint8_t old_scr2, scr2_2;
@@ -1012,6 +926,92 @@ static const MemoryRegionOps next_dummy_en_ops = {
     .endianness = DEVICE_BIG_ENDIAN,
 };
 
+static bool next_rtc_cmd_is_write(uint8_t cmd)
+{
+    return (cmd >= 0x80 && cmd <= 0x9f) ||
+           (cmd == 0xb1);
+}
+
+static void next_rtc_data_in_irq(void *opaque, int n, int level)
+{
+    NeXTRTC *rtc = NEXT_RTC(opaque);
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
+            if (rtc->retval & (0x80 >> (rtc->phase - 8))) {
+                qemu_irq_raise(rtc->data_out_irq);
+            } else {
+                qemu_irq_lower(rtc->data_out_irq);
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
+                qemu_irq_lower(rtc->power_irq);
+            }
+        }
+    }
+}
+
 static void next_rtc_cmd_reset_irq(void *opaque, int n, int level)
 {
     NeXTRTC *rtc = NEXT_RTC(opaque);
-- 
2.39.5


