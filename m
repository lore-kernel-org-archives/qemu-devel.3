Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CDC1E7717F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 11:51:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLhg2-0002P2-AX; Thu, 12 Dec 2024 06:48:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tLhfz-0002Ep-Vo
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 06:48:16 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tLhfx-0007Md-R8
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 06:48:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=gOs4H+384JMlQVQn68q+WeAKmre7IyZcDaGglzAPO/k=; b=f78KqhTdAZ2dM+y3Crscs7CJ1r
 oeHC8t65hss1KI1S3xV6lC0OS3qduYtiRREujXxLYQJw7XKQUKMv2p1/T05NZF+r75giFfOo6Jc1V
 1E4VDnSmM4EI3F2r0FsfJF6qZ6e8LcYWDm6hbFruCUp4vNQp08JkUl/13lnjNhPWYOhzU73TTmlgh
 R5Ho3ye1+PSGwGGeSV2hrBXnTPgcRZ2ZYeutEdWfcilel3terjL0+MzIiC0quBP228nFJay28Z+qW
 g7I1sw06hBu0Obr3xOF9rXZvVOYjDtK9rRFQRV0ErmGpu3bt11em3PmAG35w8uGb2ZyXTLfKy8ryj
 8D8waKo18LGoZlwEEsp5If+vOUVZKJzTIlgflvN7fCn51UxHG5l/7FbD9NxkK5RsQd+4sKiRvTjwN
 H5aZmcwxCb1Pu9HkIV7d03J4r0PLRZ7g1YZXD1JffDzF/dOFMhh5KUPesS3wTnI8wmmwBYXXmr+nr
 qdUJg0FGfA99ugHMrGLWBz5nIMU/G1kfgr0MBALSbZ+TekJxLWC5MXZMyzXG97g5hDD/ZZFsax2Pl
 bqkrAGxgnGU0xPOXcqe+MfZfiOjyBXz6d74+L3r1moaVvoO2O0NlKMzAJAnAY+9eR58J8288rG9K6
 mPMvLRn+YOq82evBebuHOye+DJ+N8cJ40jLTaZUHg=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tLhfG-00070a-Ni; Thu, 12 Dec 2024 11:47:31 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: huth@tuxfamily.org,
	qemu-devel@nongnu.org
Date: Thu, 12 Dec 2024 11:46:14 +0000
Message-Id: <20241212114620.549285-29-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241212114620.549285-1-mark.cave-ayland@ilande.co.uk>
References: <20241212114620.549285-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 28/34] next-cube: use named gpio output for next-rtc data
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
index 35eeeb0d59..5d3ffebb93 100644
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


