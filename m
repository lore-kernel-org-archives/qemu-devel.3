Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19773E7718B
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Dec 2024 07:36:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tRniO-00084W-7f; Sun, 29 Dec 2024 02:27:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1tRniE-0007Lo-5H
 for qemu-devel@nongnu.org; Sun, 29 Dec 2024 02:27:46 -0500
Received: from mail-ej1-f47.google.com ([209.85.218.47])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1tRniA-0002Mb-Qs
 for qemu-devel@nongnu.org; Sun, 29 Dec 2024 02:27:45 -0500
Received: by mail-ej1-f47.google.com with SMTP id
 a640c23a62f3a-a9e44654ae3so1355187666b.1
 for <qemu-devel@nongnu.org>; Sat, 28 Dec 2024 23:27:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735457261; x=1736062061;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C/fX2BDzfuTauaBQ4WZcOdxemf3BdSm//8XQTAUOovs=;
 b=pQdSHhkaVbc05KDnfOqbYXORcWPaQtUv/8um1Bt0473fqJBOtma4dTOjBZupL2QZ1p
 gKKjv9IFNGe6U/0UzRW/MyKKMJATAdihZniYs/Nnc4uSGO9V/6npX6vv8b6QQf6cuO8E
 5RepKfafBLtsL+AJWOSl2GXIGRUbpyHUPG/V2Kxa84aifKbMlrU43pHprApHndXfdQTA
 VkjRXJYGpjVXJJv2OB6nmZQpaNtZGLCx4Lx7slbaFVbWHBabr2Ebme6Cc2HZ6CJcLCHw
 YK0CS6q0NsKhtDJiszA1a1IQXRzehd98sk+sSG0PPI9HtP1nQ6IMCOAzgJpgGvDya8gq
 cixg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVvb+AJ4n6wNDEcOXiYix/yTpaAXUskEp5A1l9jtk87HymwtNC10Yh5+F/zUI04UoGKJHbybUJdqDk9@nongnu.org
X-Gm-Message-State: AOJu0YzyxOaoBzwGFaxiHYeWOy2m+UnlK4Deq+49KwVXCtRc7W0nb0Fe
 zWl5oMgIoC8oqy0ICyn9FMLUm7+3Vcz9RVIsukgoHkop4Sq0R6nI/VX/+Q==
X-Gm-Gg: ASbGncuyyPedMQwZz+QbO7/t0ogj/KKYI/4RcJemsmOyPaSK9AURM5WERFYwyrWtUg0
 Uxd4u+CyiLnbqm5wlAnyycjoK5BZfkyLWoYVLiUVBwA9qBdG1Q/RYuSRqVc0hr/LSHwLYpB5iNB
 3dgdRV+wi8ttkytU5V026mYC3ZqO8jtY2p/5Kq+P+sptGQP3rHnniJPARkQGNunMRmUR8farGUs
 BLmhuH/MZIUWpHs81KpEcWIFQZIiqGWYv9d4TGWcGZ2Y50QCQsaj2phegCU2tNjQUevr1pXqCX/
 vmE=
X-Google-Smtp-Source: AGHT+IFdU81tXt5uzgvWKXxVy0jm8r/Irxp7ZSeQlWBpT4VFski1++LihhpN/LRAalOdxZnTjbWKXw==
X-Received: by 2002:a17:907:1c93:b0:aa6:2b8b:20c6 with SMTP id
 a640c23a62f3a-aac2ad8a628mr2255037866b.20.1735457260538; 
 Sat, 28 Dec 2024 23:27:40 -0800 (PST)
Received: from tpx1.. (ip-109-42-49-90.web.vodafone.de. [109.42.49.90])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aac0e895194sm1329218666b.70.2024.12.28.23.27.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Dec 2024 23:27:39 -0800 (PST)
From: Thomas Huth <huth@tuxfamily.org>
To: Stefan Hajnoczi <stefanha@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PULL 32/35] next-cube: add rtc-power-out named gpio to trigger the
 NEXT_PWR_I interrupt
Date: Sun, 29 Dec 2024 08:25:23 +0100
Message-ID: <20241229072526.166555-33-huth@tuxfamily.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241229072526.166555-1-huth@tuxfamily.org>
References: <20241229072526.166555-1-huth@tuxfamily.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.218.47; envelope-from=th.huth@gmail.com;
 helo=mail-ej1-f47.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.156, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

This allows us to decouple the next-pc and next-rtc devices from each
other in next_rtc_data_in_irq().

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <20241222130012.1013374-31-mark.cave-ayland@ilande.co.uk>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Thomas Huth <huth@tuxfamily.org>
---
 hw/m68k/next-cube.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
index 621e8dc832..9f40640b5d 100644
--- a/hw/m68k/next-cube.c
+++ b/hw/m68k/next-cube.c
@@ -58,6 +58,7 @@ struct NeXTRTC {
     uint8_t retval;
 
     qemu_irq data_out_irq;
+    qemu_irq power_irq;
 };
 
 #define TYPE_NEXT_SCSI "next-scsi"
@@ -106,7 +107,6 @@ struct NeXTPC {
     ESCCState escc;
 
     NeXTRTC rtc;
-    qemu_irq rtc_power_irq;
     qemu_irq rtc_data_irq;
     qemu_irq rtc_cmd_reset_irq;
 };
@@ -184,7 +184,6 @@ static bool next_rtc_cmd_is_write(uint8_t cmd)
 static void next_rtc_data_in_irq(void *opaque, int n, int level)
 {
     NeXTRTC *rtc = NEXT_RTC(opaque);
-    NeXTPC *s = NEXT_PC(container_of(rtc, NeXTPC, rtc));
 
     if (rtc->phase < 8) {
         rtc->command = (rtc->command << 1) | level;
@@ -256,7 +255,7 @@ static void next_rtc_data_in_irq(void *opaque, int n, int level)
             if (rtc->value & 0x04) {
                 /* clear FTU */
                 rtc->status = rtc->status & (~0x18);
-                qemu_irq_lower(s->rtc_power_irq);
+                qemu_irq_lower(rtc->power_irq);
             }
         }
     }
@@ -1044,6 +1043,8 @@ static void next_rtc_init(Object *obj)
                              "rtc-data-out", 1);
     qdev_init_gpio_in_named(DEVICE(obj), next_rtc_cmd_reset_irq,
                             "rtc-cmd-reset", 1);
+    qdev_init_gpio_out_named(DEVICE(obj), &rtc->power_irq,
+                             "rtc-power-out", 1);
 }
 
 static const VMStateDescription next_rtc_vmstate = {
@@ -1156,6 +1157,8 @@ static void next_pc_realize(DeviceState *dev, Error **errp)
                                                        "rtc-data-in", 0));
     qdev_connect_gpio_out_named(dev, "rtc-cmd-reset", 0,
                                 qdev_get_gpio_in_named(d, "rtc-cmd-reset", 0));
+    qdev_connect_gpio_out_named(d, "rtc-power-out", 0,
+                                qdev_get_gpio_in(dev, NEXT_PWR_I));
 }
 
 static void next_pc_init(Object *obj)
@@ -1191,7 +1194,6 @@ static void next_pc_init(Object *obj)
 
     object_initialize_child(obj, "rtc", &s->rtc, TYPE_NEXT_RTC);
 
-    s->rtc_power_irq = qdev_get_gpio_in(DEVICE(obj), NEXT_PWR_I);
     qdev_init_gpio_in_named(DEVICE(obj), next_pc_rtc_data_in_irq,
                             "rtc-data-in", 1);
     qdev_init_gpio_out_named(DEVICE(obj), &s->rtc_data_irq,
-- 
2.47.1


