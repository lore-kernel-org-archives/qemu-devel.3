Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9F33E77180
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 11:48:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLhg9-0002oJ-0k; Thu, 12 Dec 2024 06:48:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tLhg4-0002av-0T
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 06:48:20 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tLhg2-0007NB-3Q
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 06:48:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=wxkqZJN7WGpCU476LgMyzZW/6PQxvfUmVKO47zRCx5w=; b=GVkX0TEV2Hn7zicLeyzcjMiq/g
 eBBCUMXPz+pPj2GNTkt/nHjGWBKByMB1MzWjvV1nmJ3I2DwmQGoPKOlw042pzpzczRGxdKiZhnI9t
 fsUCqWLcw8FvNKH+rNurcywmzJWfI46fvBZK7JJr/98pNlu6glKq1+I76C2OqJyw852W9cWyesMzL
 wl7lSjyV1RUOlqIfqOOcUUeVRAUFGHfK+wbvftP1cYYNEDXsxfYjNaqMCN3dbqmimdh6pKasnIkcF
 VuOs97nzU4+SKXjRqeGoqbdbgL6q8gVnAJBOHJ14ql97GSYEjzmduNkkJvdOGv7Z8CJyRvT5ZZAgI
 fMz6rTF16tEw/zUUuv254XbqY1Go1OiGFIVd91DcZI8ASVW3iMLdo9T4yE98qLLbQe4yjqi4+3XPj
 pfUwPvuN4u+hrb8i+J0awzOxkeZY/iY/yhpziMtZaZ/6lUD1v5/w3vwxLhlDLOGgyTcWZ3o/JH+ma
 Jo/eLAc8Qg67zCBAa5vWXnKWBBVXjijtJa1N8wugCqgnINrsvat0/JoWM2MmL5HtRyU0vrMFzh0FH
 uAL0b0dqA62ZP3QHFe1y+k60HUbmUbQUVrVS478ERsaFsI/WVaA7yK/5qTevXRPD5p4XOX1/uM7dg
 sC68gDAjUZS/sFQu+PU895fynSkPkt39768rPyARI=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tLhfH-00070a-PZ; Thu, 12 Dec 2024 11:47:36 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: huth@tuxfamily.org,
	qemu-devel@nongnu.org
Date: Thu, 12 Dec 2024 11:46:15 +0000
Message-Id: <20241212114620.549285-30-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241212114620.549285-1-mark.cave-ayland@ilande.co.uk>
References: <20241212114620.549285-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 29/34] next-cube: add rtc-cmd-reset named gpio to reset the
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
index 5d3ffebb93..d61deda6e0 100644
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


