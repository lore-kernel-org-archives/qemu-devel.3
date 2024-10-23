Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3279AD2E02A
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 09:06:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3XFG-0006RO-58; Wed, 23 Oct 2024 05:01:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1t3XF8-0005rw-KA
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 05:01:29 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1t3XEq-0000fO-8u
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 05:01:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=9hgI9wHEp96S4mDM3UnvmlpnSfzsc5IbQTYXfl2EKP0=; b=hmmZMHKv6kbc9wGc9DfvqbRUjR
 nORnaO/vOyizyH8AH8C31J1kTMVpL45qbdWlXxXQi9nrxbFcjbrWskC73xY+BKhGK0UhmTDF+8QGW
 PLR8tL4K5f/B/naROgVnkCYFyvEmpqdt9UtMjb8ezeEcoaVQFUd7uiBbT9MysX+oHyCu3dSjBgMlO
 gAWF1aX+ftcymIsHHDmF1OKGFU/+8psQ0DKFaxJcPnXx6Gpvyu/TXn9+6NL3JWCAfm7/w1i6BAc66
 Np3fSmKpwhMwYgCXlzhRJOH93nl/XCB5/l5PrjL/RM7D/u8IIAsgn/aOownudkLFmwNehmuGANXOt
 eNnRzgAEK3wqcPHqTdCCuTD/Cz/S3JBpc7PNvIwwXZA0bX1C1JexYURA/fSRuJYjJeozxpxr1ONEM
 X1t9OUINZwhp1VsCjLOuZisALbVGTjysaqQM9BB80iXH490uTrw63AbgKKCvjiMbl81nx1vi9uMKq
 Bxau9wU+b5eU5FT3yX9sPWsM/tjsaY/lM1DMj8o+PhhU5DgL5u7Qy/SdpOO5/SfsLNljpECG49o1G
 p35Vl6dtrg+6IZnsWux6nuLDD1Agbp6U6i1ZrLGJqd1U7I+H2aQ1NA0Aj/2JQfZe3bQICId9xBckl
 5Ft1tjxTdjsmXBs36mD7vzLhjdLgIYx6/scq7UJEI=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1t3XEM-0008EL-3e; Wed, 23 Oct 2024 10:00:42 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: huth@tuxfamily.org,
	qemu-devel@nongnu.org
Date: Wed, 23 Oct 2024 09:58:47 +0100
Message-Id: <20241023085852.1061031-32-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241023085852.1061031-1-mark.cave-ayland@ilande.co.uk>
References: <20241023085852.1061031-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 31/36] next-cube: add rtc-cmd-reset named gpio to reset the
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
index bd24359913..16b16e9956 100644
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


