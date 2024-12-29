Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FC10E7718B
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Dec 2024 07:29:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tRniW-0000C9-DA; Sun, 29 Dec 2024 02:28:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1tRni9-0007A4-5j
 for qemu-devel@nongnu.org; Sun, 29 Dec 2024 02:27:42 -0500
Received: from mail-ej1-f43.google.com ([209.85.218.43])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1tRni3-0002Eo-8t
 for qemu-devel@nongnu.org; Sun, 29 Dec 2024 02:27:37 -0500
Received: by mail-ej1-f43.google.com with SMTP id
 a640c23a62f3a-aa67f31a858so1492577366b.2
 for <qemu-devel@nongnu.org>; Sat, 28 Dec 2024 23:27:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735457253; x=1736062053;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JC8R4FfjHmxhyioHHkX5WbR6EsnpGfoLaQR1PrvrBGo=;
 b=shsJ9bQ+yODZTX0ELJQpTd9t2OVbRz0Ti14MVKGtbp1UP6BY96sM/fd26w6UEovWHv
 aVC5JHlVlNwMLMudgsLx3eh+I3mOE2ZNoSBN+c3K3GvqE6v4mAJ806ttc3IG9X0IdTrF
 tLWQS9SN/sZhTlhGjv/12EuAaFptR5s1WXuP4f14ngehT9HzFv/zwXnfM8nTR5N/nuWM
 X3uktwohehwQm8iHXkUIJ+zqVa9WWGvf6+wVATfLubrAWmEPPpuUlmvd2w504/zDAwrW
 xpOcX/69MF47W7GpSrbp4dlSOX/mgIU9IvA2lnmFNwkEn0ArR+K7vL2iVbG2Byvo+//M
 H03Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVMM6I8WlptRSOraU7jprbLPrdJq1fFksmVcofUP06PCd7PCKXpZrhH8aTzcweKXYhuWBa2cs68CteQ@nongnu.org
X-Gm-Message-State: AOJu0Yyq3hn0rn41ugAizMKxdoK/gC30ElAaHrf4tKPtFl1clKRTHg7M
 Qc40s2mrpl130zodox1O3EPt+vpJWcj26qOLp11/KSBoiRg0+JHi1F8x3w==
X-Gm-Gg: ASbGncvO34DRWw3qjc1uoZyO4VVRiNHYWu+dUkNM95bqFXcdjIjcihZJBTXC1aRp2wn
 TRCTzkLtbJovDAArcYhprhmuxeeWl5oInIM40Qqxm507pBEBqu+P2znzmMeLRSstJK43uVQPiAS
 CC3O/LPM1vFVHHsQx7Fm/1kCFGC2c+WTk+qCCPkTaOOhlwCsUqZ0FUWAwYMTDU9dFjuMAbkY0na
 gsKOq8382yi5k1WM9SjdpvtBO91aUPw/bCrEf0NV31LKtAviRKzZpwlOgMNlw7V7OjISAHU0TRl
 WFo=
X-Google-Smtp-Source: AGHT+IHO5HqoCwSOlZR2j3HYiIvwCwh1wVbFOEpLtMvA/vOQt2eGvyniOaBanHRj7B7CNxwduC+Efg==
X-Received: by 2002:a17:906:9c8f:b0:aae:d199:6eae with SMTP id
 a640c23a62f3a-aaed1998ef7mr1925688766b.14.1735457253024; 
 Sat, 28 Dec 2024 23:27:33 -0800 (PST)
Received: from tpx1.. (ip-109-42-49-90.web.vodafone.de. [109.42.49.90])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aac0e895194sm1329218666b.70.2024.12.28.23.27.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Dec 2024 23:27:32 -0800 (PST)
From: Thomas Huth <huth@tuxfamily.org>
To: Stefan Hajnoczi <stefanha@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PULL 29/35] next-cube: move rtc-data-in gpio from next-pc to
 next-rtc device
Date: Sun, 29 Dec 2024 08:25:20 +0100
Message-ID: <20241229072526.166555-30-huth@tuxfamily.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241229072526.166555-1-huth@tuxfamily.org>
References: <20241229072526.166555-1-huth@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.218.43; envelope-from=th.huth@gmail.com;
 helo=mail-ej1-f43.google.com
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

Add a new rtc-data-out gpio to the next-pc device and wire it up to the next-rtc
rtc-data-in gpio using the standard qdev gpio APIs.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Thomas Huth <huth@tuxfamily.org>
Message-ID: <20241222130012.1013374-28-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Thomas Huth <huth@tuxfamily.org>
---
 hw/m68k/next-cube.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
index bd7c76c35e..69f5c7aaec 100644
--- a/hw/m68k/next-cube.c
+++ b/hw/m68k/next-cube.c
@@ -105,6 +105,7 @@ struct NeXTPC {
 
     NeXTRTC rtc;
     qemu_irq rtc_power_irq;
+    qemu_irq rtc_data_irq;
 };
 
 typedef struct next_dma {
@@ -179,8 +180,8 @@ static bool next_rtc_cmd_is_write(uint8_t cmd)
 
 static void next_rtc_data_in_irq(void *opaque, int n, int level)
 {
-    NeXTPC *s = NEXT_PC(opaque);
-    NeXTRTC *rtc = &s->rtc;
+    NeXTRTC *rtc = NEXT_RTC(opaque);
+    NeXTPC *s = NEXT_PC(container_of(rtc, NeXTPC, rtc));
 
     if (rtc->phase < 8) {
         rtc->command = (rtc->command << 1) | level;
@@ -274,13 +275,10 @@ static void next_scr2_rtc_update(NeXTPC *s)
         /* If we are in going down clock... do something */
         if (((old_scr2 & SCR2_RTCLK) != (scr2_2 & SCR2_RTCLK)) &&
                 ((scr2_2 & SCR2_RTCLK) == 0)) {
-            qemu_irq rtc_data_in_irq = qdev_get_gpio_in_named(
-                DEVICE(s), "rtc-data-in", 0);
-
             if (scr2_2 & SCR2_RTDATA) {
-                qemu_irq_raise(rtc_data_in_irq);
+                qemu_irq_raise(s->rtc_data_irq);
             } else {
-                qemu_irq_lower(rtc_data_in_irq);
+                qemu_irq_lower(s->rtc_data_irq);
             }
         }
     } else {
@@ -1028,6 +1026,12 @@ static void next_rtc_reset_hold(Object *obj, ResetType type)
     memcpy(rtc->ram, rtc_ram2, 32);
 }
 
+static void next_rtc_init(Object *obj)
+{
+    qdev_init_gpio_in_named(DEVICE(obj), next_rtc_data_in_irq,
+                            "rtc-data-in", 1);
+}
+
 static const VMStateDescription next_rtc_vmstate = {
     .name = "next-rtc",
     .version_id = 3,
@@ -1057,6 +1061,7 @@ static void next_rtc_class_init(ObjectClass *klass, void *data)
 static const TypeInfo next_rtc_info = {
     .name = TYPE_NEXT_RTC,
     .parent = TYPE_SYS_BUS_DEVICE,
+    .instance_init = next_rtc_init,
     .instance_size = sizeof(NeXTRTC),
     .class_init = next_rtc_class_init,
 };
@@ -1128,6 +1133,9 @@ static void next_pc_realize(DeviceState *dev, Error **errp)
     if (!sysbus_realize(SYS_BUS_DEVICE(d), errp)) {
         return;
     }
+    /* Data from NeXTPC to RTC */
+    qdev_connect_gpio_out_named(dev, "rtc-data-out", 0,
+                                qdev_get_gpio_in_named(d, "rtc-data-in", 0));
 }
 
 static void next_pc_init(Object *obj)
@@ -1166,8 +1174,8 @@ static void next_pc_init(Object *obj)
     s->rtc_power_irq = qdev_get_gpio_in(DEVICE(obj), NEXT_PWR_I);
     qdev_init_gpio_in_named(DEVICE(obj), next_pc_rtc_data_in_irq,
                             "pc-rtc-data-in", 1);
-    qdev_init_gpio_in_named(DEVICE(obj), next_rtc_data_in_irq,
-                            "rtc-data-in", 1);
+    qdev_init_gpio_out_named(DEVICE(obj), &s->rtc_data_irq,
+                             "rtc-data-out", 1);
 }
 
 /*
-- 
2.47.1


