Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CC2DE7718B
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Dec 2024 07:33:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tRniM-0007rg-6j; Sun, 29 Dec 2024 02:27:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1tRnhx-0006nH-S1
 for qemu-devel@nongnu.org; Sun, 29 Dec 2024 02:27:34 -0500
Received: from mail-ed1-f48.google.com ([209.85.208.48])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1tRnhs-0002Cg-Bs
 for qemu-devel@nongnu.org; Sun, 29 Dec 2024 02:27:25 -0500
Received: by mail-ed1-f48.google.com with SMTP id
 4fb4d7f45d1cf-5d7e527becaso13380571a12.3
 for <qemu-devel@nongnu.org>; Sat, 28 Dec 2024 23:27:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735457243; x=1736062043;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uANl3b4vNRW+zDDFjIkJDoWOvGKMQzBH26IA3gV2sTw=;
 b=R4vSBH9IaTJgS6QFwxDgm/88kpGSRG16Omj7EIeK1oKN8EPOIrrXVTX6mYXRDUBcrH
 grU/5W5n92jKBTbMnhSvYyRtYy4TXDHZN6gcXCH47AMSD9hIa6PcdpUmfqUb7Oe4YOa7
 NfECbrQuupeV6CKEiQghSQi5NDAn8ZTCI4+7S3EiqfR19nn1yiULU9WkxIFHwkKcl5gM
 BrMW2LM+JKXruurGq8iOZeCKd/aW/jmzexnPJ5+KiJ4/Su54A5qwaZ7K3kpvdRGQ+WPd
 QG16D8rv62LilVYWAX1RESjmqyj0KgrVCa+LmqjytF32HoeFcsfFtaNgd20zCLSnai96
 5eEw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/UfdOkJ1PgFWGd1hJ/Wb9IVG3d+7vN5x3ji73+7WKcTelNBehylYHs43OeJMUPpfcqAF+JnJ/q9pq@nongnu.org
X-Gm-Message-State: AOJu0YwIWBik1oQ10w/4WO1yPH1H67Vziy6hIFDw+npime/q7WHceVmR
 SBkIXudkOm8qD7bPpDM+dcTfuQD7pWgGM2RQZ8XTZHDHCLDUgXYb
X-Gm-Gg: ASbGncvmcoLAELyTB6rKVVqpWOmxW+eCZu5yUkf598AQ9oyLdxfuMBjfpD3vxPLElrQ
 ZlnI73u5vDmBkFO74ZQhfWQYbdbC3I6pAHaQciel/8sGviXMxCzwlSPgSatMtgCcU1AQt00bRuU
 E2jPqhIz5WHtpaJW3jtpSeHWWcj3J5GtZvvQgFVI/pBOuRi0w2trdGvkG0EQr712OkrHXZnm0P5
 hWby4jzebwRH8kOjP+HyF8D7gnb5gb7FT6U0OUM6BZSw+3OKEnVtrNIvClRRUvv7MrcWv33685S
 Cqs=
X-Google-Smtp-Source: AGHT+IGtGGdK0WUC2QLWuqlRm0vebD+hSNcMGx8zOkBZbmeqlUKbY6PeX/uPlyHku+1x3R6LhymRyw==
X-Received: by 2002:a05:6402:270d:b0:5d0:fb56:3f with SMTP id
 4fb4d7f45d1cf-5d81dd9cdf0mr70073860a12.12.1735457242541; 
 Sat, 28 Dec 2024 23:27:22 -0800 (PST)
Received: from tpx1.. (ip-109-42-49-90.web.vodafone.de. [109.42.49.90])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aac0e895194sm1329218666b.70.2024.12.28.23.27.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Dec 2024 23:27:21 -0800 (PST)
From: Thomas Huth <huth@tuxfamily.org>
To: Stefan Hajnoczi <stefanha@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PULL 24/35] next-cube: use named gpio to set RTC data bit in scr2
Date: Sun, 29 Dec 2024 08:25:15 +0100
Message-ID: <20241229072526.166555-25-huth@tuxfamily.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241229072526.166555-1-huth@tuxfamily.org>
References: <20241229072526.166555-1-huth@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.208.48; envelope-from=th.huth@gmail.com;
 helo=mail-ed1-f48.google.com
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

This is in preparation for moving NeXTRTC to its own separate device.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Thomas Huth <huth@tuxfamily.org>
Message-ID: <20241222130012.1013374-23-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Thomas Huth <huth@tuxfamily.org>
---
 hw/m68k/next-cube.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
index a39117144c..1e9e662b40 100644
--- a/hw/m68k/next-cube.c
+++ b/hw/m68k/next-cube.c
@@ -240,10 +240,13 @@ static void next_scr2_rtc_update(NeXTPC *s)
                                  ((scr2_2 & SCR2_RTDATA) ? 1 : 0);
                 } else {
                     /* Shift out value to read */
+                    qemu_irq rtc_data_in_irq = qdev_get_gpio_in_named(
+                        DEVICE(s), "pc-rtc-data-in", 0);
+
                     if (rtc->retval & (0x80 >> (rtc->phase - 8))) {
-                        scr2_2 |= SCR2_RTDATA;
+                        qemu_irq_raise(rtc_data_in_irq);
                     } else {
-                        scr2_2 &= ~SCR2_RTDATA;
+                        qemu_irq_lower(rtc_data_in_irq);
                     }
                 }
             }
@@ -270,8 +273,6 @@ static void next_scr2_rtc_update(NeXTPC *s)
         rtc->command = 0;
         rtc->value = 0;
     }
-
-    s->scr2 = deposit32(s->scr2, 8, 8, scr2_2);
 }
 
 static uint64_t next_mmio_read(void *opaque, hwaddr addr, unsigned size)
@@ -1001,6 +1002,20 @@ static const MemoryRegionOps next_dummy_en_ops = {
     .endianness = DEVICE_BIG_ENDIAN,
 };
 
+static void next_pc_rtc_data_in_irq(void *opaque, int n, int level)
+{
+    NeXTPC *s = NEXT_PC(opaque);
+    uint8_t scr2_2 = extract32(s->scr2, 8, 8);
+
+    if (level) {
+        scr2_2 |= SCR2_RTDATA;
+    } else {
+        scr2_2 &= ~SCR2_RTDATA;
+    }
+
+    s->scr2 = deposit32(s->scr2, 8, 8, scr2_2);
+}
+
 static void next_pc_reset_hold(Object *obj, ResetType type)
 {
     NeXTPC *s = NEXT_PC(obj);
@@ -1087,6 +1102,8 @@ static void next_pc_init(Object *obj)
     sysbus_init_mmio(sbd, &s->timer_mem);
 
     s->rtc_power_irq = qdev_get_gpio_in(DEVICE(obj), NEXT_PWR_I);
+    qdev_init_gpio_in_named(DEVICE(obj), next_pc_rtc_data_in_irq,
+                            "pc-rtc-data-in", 1);
 }
 
 /*
-- 
2.47.1


