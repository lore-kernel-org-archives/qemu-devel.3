Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91E4EE7718D
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Dec 2024 13:10:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tPLdW-0002ff-Le; Sun, 22 Dec 2024 08:04:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tPLbE-0006Qr-2e
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 08:02:29 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tPLbB-0000u6-Rm
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 08:02:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=zQ96sHjgEgOCl4clXeFWzZdnF79RQbMk9OMgRM7v0cM=; b=Tl534yMBA/TqQGEKWC99lSWaAv
 vvI/GHqe7bJ+WlIut6gIrZXIhdmu0XMU3ucQ/V7OjP7rUV8fantjKwQUl97DauLisrgr0z2C82kuY
 z3afTj26hifCGagRgEfikU/fg8FAoWAtQIHS4zfAmsZJA3m12d52o/bLtxBiEcYec6k1rTPKXBdzt
 7b+8ENFVprxxaNdQpQHrC+OOP6TQJBi52yqoVsbvsl6HSndzV2R6m9CeZ1aGQ9zxaBZ/k8i8DLxUj
 M1csS9R/TQFMkwNPNHxMrzVSwh7v04wplW4uYUrY26VHaA9Vv2gTTQnCXVoCoAqpt+Opj+WUjH2Vc
 IbV++dloHi8QVaIa4aU7wtGkcpjeLXwq+sKw7JkO1atMwBsfSS+2CI/Y+BtBObqYAlp73NYmsC2VK
 jSeyBwH/q569w3UW+0oFtFlks5BByCHHm6tGYVxcfGYlft46P7APihWrmu1xCKLDBr/yvzsLSbk/l
 2onAebkgUNhyYtrSrbU8xLnC9d5Ak7X7YlvojyQgEdPTnGnQfGy86DBbeTTQnGAHCo++lZkNPdhs+
 GfcH6jiLKkm+yNWw6V2hhlAbfOY81N3PkJv6V1T7GUkx4QFByNJ9eU+RRT/i/DCSjIxeBJ9MpxDwm
 7UDfr++QVO4yzpiZEB9UDu3OfX4UD6AM9ZX2w79EA=;
Received: from [2a02:8012:2f01:0:33a9:475d:1cd9:884]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tPLaO-0002L7-Nx; Sun, 22 Dec 2024 13:01:36 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: huth@tuxfamily.org,
	qemu-devel@nongnu.org
Date: Sun, 22 Dec 2024 13:00:10 +0000
Message-Id: <20241222130012.1013374-32-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241222130012.1013374-1-mark.cave-ayland@ilande.co.uk>
References: <20241222130012.1013374-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:2f01:0:33a9:475d:1cd9:884
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v3 31/33] next-cube: move next_rtc_cmd_is_write() and
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
Reviewed-by: Thomas Huth <huth@tuxfamily.org>
---
 hw/m68k/next-cube.c | 172 ++++++++++++++++++++++----------------------
 1 file changed, 86 insertions(+), 86 deletions(-)

diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
index dd7a98b603..cf64f982cc 100644
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


