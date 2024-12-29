Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4D1DE77191
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Dec 2024 07:33:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tRnib-0000X8-NG; Sun, 29 Dec 2024 02:28:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1tRni9-0007AE-7B
 for qemu-devel@nongnu.org; Sun, 29 Dec 2024 02:27:42 -0500
Received: from mail-ed1-f52.google.com ([209.85.208.52])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1tRni5-0002FY-8j
 for qemu-devel@nongnu.org; Sun, 29 Dec 2024 02:27:40 -0500
Received: by mail-ed1-f52.google.com with SMTP id
 4fb4d7f45d1cf-5d84179ef26so10556293a12.3
 for <qemu-devel@nongnu.org>; Sat, 28 Dec 2024 23:27:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735457255; x=1736062055;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QOPz+HDDyrtt7om/GXISvDlgUY8tOSmNDX0mLPvWlak=;
 b=qeOsj4bzkN09Jeg2Lx8RY9dVnYi2Y9iGRZ96fzdjVghJTLdYbWyAh9tsmz8+bvJqo/
 cJcJZUcjOs/VXNzYnayqL1b+5BIZn+vWMCbQGw74MY0N9AFSra+jYzMz+K7zZyoTR7iu
 FlqCYgOqvl74iwROtp5mJw28e9Fd1TmgpZWaKWgvLmbLSZApbTibEXOgCUEJ2IPADFt3
 w5B0KnmAM6JIbvuH/bldnaLR1jk3LB7PiVhYdsk4lCiKe3xrdEqDt6jCU04cAoe9KbPt
 w7W7mJGPy75WkAg0o4j0m8zhw6LOvIBEDXaYWSlkFeob2R5OUOvgl56E6/ZOqW+s4TyZ
 QqjQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWh6fKI4mursrhqbw9Mw4QSGJeozQfZKvsIFUAj7smnA3T3rvt/8vdDS61EZvFFSV6l1NGdgosba9yP@nongnu.org
X-Gm-Message-State: AOJu0Yy1P8OqocGQfTAU4/scvVG00ASN1BZwyafFYJsmvure9QU3Q3ET
 CkoXHZFMe+fVC0kPqwyvT4/AZvgCzC1xVe3VnZs07VAAJ89VVSZU
X-Gm-Gg: ASbGncsRrb9yIMF/CG1QOrCdpXLQpKODZsw5kHLF4VpnECd8D2wcyJIv6Pqjr/NklKR
 pKfdH79X7zh1od0w+FjrjXUlLR+O8ZelxB1A2EXel8N8p36u1NMy4LGTS5UEeHbVvZGb50WnF8+
 WNnmWmBz+hVMFGagO/rr3hfIlDSUWp2HDDDgaNMTtW9d6h21sITjts+Jz50NhxOl6YyKREG+2Q7
 6AT+bZgk2+uiT2xgZlhBM4HyLn4tXYoLP8IkOgtnirl3GRm5eJH+h46KIcaEJd3B5J6GP4baEOq
 eEQ=
X-Google-Smtp-Source: AGHT+IFmP+2YTSgma0G9OIaBN3ZRpElOOLZjgJVbfr6M55zXo/WvNtWRFwsjB7TUuo59r6CLAb40+Q==
X-Received: by 2002:a05:6402:3585:b0:5d0:ea2a:726c with SMTP id
 4fb4d7f45d1cf-5d81dd8faaamr26154473a12.8.1735457255361; 
 Sat, 28 Dec 2024 23:27:35 -0800 (PST)
Received: from tpx1.. (ip-109-42-49-90.web.vodafone.de. [109.42.49.90])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aac0e895194sm1329218666b.70.2024.12.28.23.27.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Dec 2024 23:27:34 -0800 (PST)
From: Thomas Huth <huth@tuxfamily.org>
To: Stefan Hajnoczi <stefanha@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PULL 30/35] next-cube: use named gpio output for next-rtc data
Date: Sun, 29 Dec 2024 08:25:21 +0100
Message-ID: <20241229072526.166555-31-huth@tuxfamily.org>
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

Add a named gpio output for the next-rtc data and then update
next_rtc_data_in_irq() to drive the IRQ directly. This enables the next-rtc to
next-pc data to be wired up using the standard qdev gpio APIs.

At the same time rename the pc-rtc-data-in gpio to rtc-data-in which is possible
now that the previous rtc-data-in gpio has been moved to the next-rtc device.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <20241222130012.1013374-29-mark.cave-ayland@ilande.co.uk>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Thomas Huth <huth@tuxfamily.org>
---
 hw/m68k/next-cube.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
index 69f5c7aaec..2bc6d49c34 100644
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
2.47.1


