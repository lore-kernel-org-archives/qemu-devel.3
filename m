Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35949E77191
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Dec 2024 07:33:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tRniM-0007sp-7n; Sun, 29 Dec 2024 02:27:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1tRniD-0007Ev-0E
 for qemu-devel@nongnu.org; Sun, 29 Dec 2024 02:27:45 -0500
Received: from mail-ed1-f52.google.com ([209.85.208.52])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1tRni8-0002Hz-W2
 for qemu-devel@nongnu.org; Sun, 29 Dec 2024 02:27:43 -0500
Received: by mail-ed1-f52.google.com with SMTP id
 4fb4d7f45d1cf-5d0d32cd31aso11793722a12.0
 for <qemu-devel@nongnu.org>; Sat, 28 Dec 2024 23:27:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735457258; x=1736062058;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qfS3GhF1awVp92+r32OqyA+kFgYxtyMS0V30YdbjWn4=;
 b=aS9ZK5nkiut17wehgY/OXESl0nsGdDdjpiPgPkWpjceCVeeNJd7C6mD+Hq0+YcF6jN
 SH5S49pwQIPiGKsm0OwrVgdKoOqlyyE8wiEFK6Vxb0RxTRcrzMjw5yWb9Vj6o5n57KtM
 +Q3JL44CyX3OXe7yI29BUD/JK07bgs6ThlytVJvXbr92TltTXXH9itae1yQ+9AX7epw+
 a23pXkUoIJZlvO71mfj6md+q8e6HFbI85xboKmtDm6ejZfagcO/XBhUCDVUDT3mQjjjU
 ZPaLvRqOj/viSnAiuIrhJY41DO6p8MoD4JhmR0HrbpyZCU1MbVee9bpvqvZQEQy1Hqpd
 D98g==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+u7Fff1DzAi8B6izmUpSPPxSe09A0uXphp/HTu/xjI93HuERa5QslMogrK83XMtVl5gEyeBzb8GZ+@nongnu.org
X-Gm-Message-State: AOJu0Yw2+V9G5v1FDKhX/EhTaQiujEiO0Frpth8j/PzPyINis5C/sUvH
 qFc5boMG2mcDZnLH5Adiubvq+AqAJkCU4y2uz0o4BcaNMIQimphC
X-Gm-Gg: ASbGncvak67dy1UM4Q0J5tRFN3fCCYAJ1ruqyPtcl1LwyskYaRz82qNQJgQRqKftI/c
 egEbkEpGPNOBZqZ2uwo1FXhs0JyEFhwRRIDrqbkxJ9uWVhrct3c3iwE5uw7/3IdkY/T0Rp9vwBl
 4cg+91J7DyrRuyOWnDCJJHKxl1hfOXEsGi7hLDxV+9/kC7PP2KpG9uzzVPh7vlk0OnXtsKfXRyL
 Uf7PLL3xtj6Qhku8dtztqnyZI7GmmOZ56wmfEVXvB88yYF0TH6DDuEVGV8OvnlopldbdF7a1ZSY
 CSc=
X-Google-Smtp-Source: AGHT+IEFWQ0SXvXdJpB4ZTHsVEYUFuat4UCm7vjFw62q80Z22GimPubsrFz1a4dweYk6B8qa7RFe1w==
X-Received: by 2002:a05:6402:3206:b0:5d1:2377:5af3 with SMTP id
 4fb4d7f45d1cf-5d81dd83b23mr70704841a12.5.1735457257944; 
 Sat, 28 Dec 2024 23:27:37 -0800 (PST)
Received: from tpx1.. (ip-109-42-49-90.web.vodafone.de. [109.42.49.90])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aac0e895194sm1329218666b.70.2024.12.28.23.27.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Dec 2024 23:27:36 -0800 (PST)
From: Thomas Huth <huth@tuxfamily.org>
To: Stefan Hajnoczi <stefanha@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PULL 31/35] next-cube: add rtc-cmd-reset named gpio to reset the rtc
 state machine
Date: Sun, 29 Dec 2024 08:25:22 +0100
Message-ID: <20241229072526.166555-32-huth@tuxfamily.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241229072526.166555-1-huth@tuxfamily.org>
References: <20241229072526.166555-1-huth@tuxfamily.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.208.52; envelope-from=th.huth@gmail.com;
 helo=mail-ed1-f52.google.com
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
other in next_scr2_rtc_update().

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <20241222130012.1013374-30-mark.cave-ayland@ilande.co.uk>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Thomas Huth <huth@tuxfamily.org>
---
 hw/m68k/next-cube.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
index 2bc6d49c34..621e8dc832 100644
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
2.47.1


