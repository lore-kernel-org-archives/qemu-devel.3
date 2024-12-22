Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 727ACE77188
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Dec 2024 13:05:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tPLcx-0007gY-Q6; Sun, 22 Dec 2024 08:04:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tPLb9-0006NH-Hd
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 08:02:19 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tPLb7-0000tN-Gm
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 08:02:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=Dhd9q4dprri5dDCffEVAkY2Gue7Wh4bBs8kcdbwy3j4=; b=VbLla8GiXoDnsF76VSCwDimzwJ
 IBvtjSCUcdDH5K4mo2WCWcAAE8fm7MrtYrOVgOwqPRWgcmbaghJrT8/fqA4tAR5Uj2GKR5HfX/iLS
 AOn8jBeeoZhOrPl4TiE2VEGVFfIpzhxHw+S2395JpC4i+ShBYcgo4ggrkUm67f0OHdYMow4dGDlds
 5nUjnCKgyRMWTZciOAoK3LKQHkZGsVdMEVAud/wjuHBgjL2RzCO+WGncEqOtQu9a1j8N0Yto4SvkY
 UsnB5AnnRGDFieToiGNJ12K7b+7mSITD9jaBdPyHvq4+VmYgSA2eQjfd4x4yrUmjk0fZA/tiRl+YH
 d7aYnAv9IkYSqJYSSG6kq/qy57XUWYCuR7Sa/+73qx8OHxX9Pw6obxScgT+hmc5poMbzCOFr/otnZ
 PcTRHJFE5SK3D9tlqAkA+XofHiCRXHIgAbWLi52qsA34uUOJ+Em7D4RJO+7SsL+4AwPPfiYSqiT6N
 07iUR3JATHnp2SbLWFrG0MOCW0u1xM1GCgjhpsQSr7GLbRmp4pBOW0M5OMkrGmFYmyNqEzvDfetu8
 bLSqy1Ht0OuOMabLJYPdOQY/L6kjhSNUdz4gbRsQZ8WEckpEm5CgZLaMM8DKvAvGl7QAF8cAWiUiv
 0JbrGyzXtLt7TlgtcQIHIa1M3xDistf3oqV6b9fA8=;
Received: from [2a02:8012:2f01:0:33a9:475d:1cd9:884]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tPLaO-0002L7-1n; Sun, 22 Dec 2024 13:01:32 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: huth@tuxfamily.org,
	qemu-devel@nongnu.org
Date: Sun, 22 Dec 2024 13:00:08 +0000
Message-Id: <20241222130012.1013374-30-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241222130012.1013374-1-mark.cave-ayland@ilande.co.uk>
References: <20241222130012.1013374-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:2f01:0:33a9:475d:1cd9:884
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v3 29/33] next-cube: add rtc-cmd-reset named gpio to reset the
 rtc state machine
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

This allows us to decouple the next-pc and next-rtc devices from each
other in next_scr2_rtc_update().

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/m68k/next-cube.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
index 8edf51198e..ba8c6bb1cd 100644
--- a/hw/m68k/next-cube.c
+++ b/hw/m68k/next-cube.c
@@ -108,6 +108,7 @@ struct NeXTPC {
     NeXTRTC rtc;
     qemu_irq rtc_power_irq;
     qemu_irq rtc_data_irq;
+    qemu_irq rtc_cmd_reset_irq;
 };
 
 typedef struct next_dma {
@@ -264,7 +265,6 @@ static void next_rtc_data_in_irq(void *opaque, int n, int level)
 static void next_scr2_rtc_update(NeXTPC *s)
 {
     uint8_t old_scr2, scr2_2;
-    NeXTRTC *rtc = &s->rtc;
 
     old_scr2 = extract32(s->old_scr2, 8, 8);
     scr2_2 = extract32(s->scr2, 8, 8);
@@ -282,9 +282,7 @@ static void next_scr2_rtc_update(NeXTPC *s)
         }
     } else {
         /* else end or abort */
-        rtc->phase = 0;
-        rtc->command = 0;
-        rtc->value = 0;
+        qemu_irq_raise(s->rtc_cmd_reset_irq);
     }
 }
 
@@ -1015,6 +1013,17 @@ static const MemoryRegionOps next_dummy_en_ops = {
     .endianness = DEVICE_BIG_ENDIAN,
 };
 
+static void next_rtc_cmd_reset_irq(void *opaque, int n, int level)
+{
+    NeXTRTC *rtc = NEXT_RTC(opaque);
+
+    if (level) {
+        rtc->phase = 0;
+        rtc->command = 0;
+        rtc->value = 0;
+    }
+}
+
 static void next_rtc_reset_hold(Object *obj, ResetType type)
 {
     NeXTRTC *rtc = NEXT_RTC(obj);
@@ -1033,6 +1042,8 @@ static void next_rtc_init(Object *obj)
                             "rtc-data-in", 1);
     qdev_init_gpio_out_named(DEVICE(obj), &rtc->data_out_irq,
                              "rtc-data-out", 1);
+    qdev_init_gpio_in_named(DEVICE(obj), next_rtc_cmd_reset_irq,
+                            "rtc-cmd-reset", 1);
 }
 
 static const VMStateDescription next_rtc_vmstate = {
@@ -1143,6 +1154,8 @@ static void next_pc_realize(DeviceState *dev, Error **errp)
     qdev_connect_gpio_out_named(d, "rtc-data-out", 0,
                                 qdev_get_gpio_in_named(dev,
                                                        "rtc-data-in", 0));
+    qdev_connect_gpio_out_named(dev, "rtc-cmd-reset", 0,
+                                qdev_get_gpio_in_named(d, "rtc-cmd-reset", 0));
 }
 
 static void next_pc_init(Object *obj)
@@ -1183,6 +1196,8 @@ static void next_pc_init(Object *obj)
                             "rtc-data-in", 1);
     qdev_init_gpio_out_named(DEVICE(obj), &s->rtc_data_irq,
                              "rtc-data-out", 1);
+    qdev_init_gpio_out_named(DEVICE(obj), &s->rtc_cmd_reset_irq,
+                             "rtc-cmd-reset", 1);
 }
 
 /*
-- 
2.39.5


