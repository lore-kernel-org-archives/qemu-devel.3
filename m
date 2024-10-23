Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F041CD2E029
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 09:07:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3XEp-0005Ie-VF; Wed, 23 Oct 2024 05:01:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1t3XEn-00054J-65
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 05:01:05 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1t3XEl-0000eo-LV
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 05:01:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=NnhCv+sFCvIgZI3uwsFTJLbSMye2vSV27nRH83CfyJ8=; b=gWPC/0Tbb5ubm2JiDS6l1VMXml
 0v9b96dYukAQ0X737vtPELif3pfsGXkbocM4sYnpUbhBl32OszKhK3n2dBELiq9cgRd0RRihSp1IW
 O8Xei16xBR7l0E0Fe512GKu+a7bHU/fxC1byHyNAX+FSVLCWCrDK96xlznVLVE1KTnbQ49wFCSi/E
 onF7xw647qIpiziPz4eN9IMBcHeCnzjQSupbxX1qYl7tluL4o0PItjTTD0vHBoTMX8vwj85SaNPHD
 gtXSs7rhfDsj8uA5HWrfyphfQaSPEbf6pqXBkn3iyVoGM9zc2Fx8mIxAJ+IuuQGdv7FgaIJ/wXAur
 1BaBG4eYi7C7fSs/aAbxwXek7HLb9KUBPBqZZaDXd1C8Aimjaj1SE/i/rdN0W4tBJVrFUZ9wKmTV2
 nJh5QlLDHJmUgOcobdgMW2jbowwshDJNrdGK/BpDV/9d5FXYRkuKaYVgotcimVIqLfoQK6cE/Ow5g
 0OtmQDOfcxqs+psZlGRGFARRk3JsAmaM4x1zfr/u8ObgFgptdac6z6CC62pJuPkuiKFLs1QzxjhQu
 j4QMx7LCiagTqKmwGP1eJYvSQoj3zE86cXp9yqzRNojdxAO9qZT2uTM45o1i+DUu1xif8zYFJo8EE
 uPx1bF2Ozm6sJsiwhYoozpC7bk/6b4JWHriBaJezg=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1t3XEH-0008EL-HV; Wed, 23 Oct 2024 10:00:37 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: huth@tuxfamily.org,
	qemu-devel@nongnu.org
Date: Wed, 23 Oct 2024 09:58:46 +0100
Message-Id: <20241023085852.1061031-31-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241023085852.1061031-1-mark.cave-ayland@ilande.co.uk>
References: <20241023085852.1061031-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 30/36] next-cube: use named gpio output for next-rtc data
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

Add a named gpio output for the next-rtc data and then update
next_rtc_data_in_irq() to drive the IRQ directly. This enables the next-rtc to
next-pc data to be wired up using the standard qdev gpio APIs.

At the same time rename the pc-rtc-data-in gpio to rtc-data-in which is possible
now that the previous rtc-data-in gpio has been moved to the next-rtc device.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/m68k/next-cube.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
index 111a2c0311..bd24359913 100644
--- a/hw/m68k/next-cube.c
+++ b/hw/m68k/next-cube.c
@@ -56,6 +56,8 @@ struct NeXTRTC {
     uint8_t status;
     uint8_t control;
     uint8_t retval;
+
+    qemu_irq data_out_irq;
 };
 
 #define TYPE_NEXT_SCSI "next-scsi"
@@ -234,13 +236,10 @@ static void next_rtc_data_in_irq(void *opaque, int n, int level)
             rtc->value = (rtc->value << 1) | level;
         } else {
             /* Shift out value to read */
-            qemu_irq rtc_data_in_irq = qdev_get_gpio_in_named(
-                DEVICE(s), "pc-rtc-data-in", 0);
-
             if (rtc->retval & (0x80 >> (rtc->phase - 8))) {
-                qemu_irq_raise(rtc_data_in_irq);
+                qemu_irq_raise(rtc->data_out_irq);
             } else {
-                qemu_irq_lower(rtc_data_in_irq);
+                qemu_irq_lower(rtc->data_out_irq);
             }
         }
     }
@@ -1028,8 +1027,12 @@ static void next_rtc_reset_hold(Object *obj, ResetType type)
 
 static void next_rtc_init(Object *obj)
 {
+    NeXTRTC *rtc = NEXT_RTC(obj);
+
     qdev_init_gpio_in_named(DEVICE(obj), next_rtc_data_in_irq,
                             "rtc-data-in", 1);
+    qdev_init_gpio_out_named(DEVICE(obj), &rtc->data_out_irq,
+                             "rtc-data-out", 1);
 }
 
 static const VMStateDescription next_rtc_vmstate = {
@@ -1136,6 +1139,10 @@ static void next_pc_realize(DeviceState *dev, Error **errp)
     /* Data from NeXTPC to RTC */
     qdev_connect_gpio_out_named(dev, "rtc-data-out", 0,
                                 qdev_get_gpio_in_named(d, "rtc-data-in", 0));
+    /* Data from RTC to NeXTPC */
+    qdev_connect_gpio_out_named(d, "rtc-data-out", 0,
+                                qdev_get_gpio_in_named(dev,
+                                                       "rtc-data-in", 0));
 }
 
 static void next_pc_init(Object *obj)
@@ -1173,7 +1180,7 @@ static void next_pc_init(Object *obj)
 
     s->rtc_power_irq = qdev_get_gpio_in(DEVICE(obj), NEXT_PWR_I);
     qdev_init_gpio_in_named(DEVICE(obj), next_pc_rtc_data_in_irq,
-                            "pc-rtc-data-in", 1);
+                            "rtc-data-in", 1);
     qdev_init_gpio_out_named(DEVICE(obj), &s->rtc_data_irq,
                              "rtc-data-out", 1);
 }
-- 
2.39.5


