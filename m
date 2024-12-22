Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F4FDE77188
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Dec 2024 13:11:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tPLdX-0002ji-8q; Sun, 22 Dec 2024 08:04:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tPLb9-0006NG-Hg
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 08:02:19 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tPLb7-0000tE-0A
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 08:02:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=/KNxCC3IIVCG1PLFDGwnCD8MM0+BceuNwbRv85D9eDE=; b=YsnnjR2Z6+PDqCXlmYIrHZy8tA
 C/J9AbWJq4dofVkrC2Nc9Jm9Jz75KWnKS1gA4WZ7gmNmS6wF+yimkNu7lt33WfrWOy95gOCn1SeIu
 wYAJzqkf3TsrvxC+lRdfzmkl/XqNv2PTjoaMldM5wSD2ir+HNENF04QByqQy6ec0h8IKWnAWXySXV
 vDl4ChQhrcu7CSrV2X4YsBEjc/kzltLsZtvjUV5BvknWc7mztKR2qwTBMXCG8r/OvDKuVYKoGJDlp
 P5DpSmtaoCAybljZb9skbAewe/dIqSfNd5kE3VSPrgJBd0HnVWp5IEn55tLfJT28bTCSK5g3x6bGn
 4xAsyCZnIh6YYoTHi3mHDF+dNouifYHTXNxRQj0H2wQ8HzZ07lxptIFvBrLn9F5rtUEzxxEv1xcay
 X8SA7xZt7r4v160zf5nZ4iuncoE48UrXGkzXwjz2/D6Kl2kR8cFoZcK6pqSQqktDz35cRg6F7lbCV
 aA8OLSSuHHnNDs4As+QrtKi/5dyB+GAvjYdAu+ecl3T5YEbzb7XIbo2C7i4s9q73XT9UaOUoXtl2+
 CJXsRX75nphb21+tBKWaiYmqgUepMorbOtDZPLikScuXOy62+BZIG8N4HsztDegcL7BdQWV1BevgO
 F+JExYw7BCCAnXkWj2KFHWUhTf3nKRLx5xm85yaNE=;
Received: from [2a02:8012:2f01:0:33a9:475d:1cd9:884]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tPLaN-0002L7-Le; Sun, 22 Dec 2024 13:01:31 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: huth@tuxfamily.org,
	qemu-devel@nongnu.org
Date: Sun, 22 Dec 2024 13:00:07 +0000
Message-Id: <20241222130012.1013374-29-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241222130012.1013374-1-mark.cave-ayland@ilande.co.uk>
References: <20241222130012.1013374-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:2f01:0:33a9:475d:1cd9:884
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v3 28/33] next-cube: use named gpio output for next-rtc data
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
index 83154a3661..8edf51198e 100644
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


