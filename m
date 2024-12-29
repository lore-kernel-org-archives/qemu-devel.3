Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8C48E7718B
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Dec 2024 07:35:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tRniD-0007I2-S7; Sun, 29 Dec 2024 02:27:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1tRnhp-0006jV-0Z
 for qemu-devel@nongnu.org; Sun, 29 Dec 2024 02:27:26 -0500
Received: from mail-ed1-f53.google.com ([209.85.208.53])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1tRnhm-0002C5-U1
 for qemu-devel@nongnu.org; Sun, 29 Dec 2024 02:27:20 -0500
Received: by mail-ed1-f53.google.com with SMTP id
 4fb4d7f45d1cf-5d3ecae02beso10066151a12.0
 for <qemu-devel@nongnu.org>; Sat, 28 Dec 2024 23:27:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735457236; x=1736062036;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LIkWul9PfyaP4XPHUd7oxej4ykz8QWuqnHdgbRarPHo=;
 b=DVfF3DENlGr9n8Y0rGThYsgJyKhZn5IX5DRuI0UyuMJUODuQfssxHfzU4fO3qj2IY4
 oKDHYrrD5y3Qjigr1M4cCh6TuNUwkke0GyRdu11hXN5yWhtT49Q6tin2EMewW2z0msQj
 F2FZqirZkwsHvntIXB/iETlkWug7Q9WG2YgY7OtJ4Z5MOoakfgS0eRrSVplal5zMPqNJ
 jstAwbtZdqYdGhXVDgSqTWllNHi/39rCYbPGFp476Cwk2Cjc8Wam/gNRBtfbtWSzfwFm
 k8a1RRa/cZpuGDuAfFjHoItExjmUDQvpDdMfh3KILoiSaUiG2v+B1Cg/h0OwD60OW+KD
 Jirg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWH4VaGmy9fnZz1m+l9clMNU2yFxJ7WfUqzfsGqv9JufJg+ujcLj/bbrtb4e3vLoQRqHvySroIbzITL@nongnu.org
X-Gm-Message-State: AOJu0YxQlsjRgPP32n2ViOxG+FYdFfGU+VNPO0/nt35i1623zekrQuJN
 Qef8vU6BFsv+S3Mg+K92VC2M/DCuGiHiZgM+AgGUu1WamdavScS/
X-Gm-Gg: ASbGncsk4zI9VJecIMoVIf0O+7Rcm5Fe6MF8NZNmNVA8ZoX7wCL4WJOtRcBFVzTRQR3
 A1Z81ZnxARwiz2RJrgBIi6ICpQa0w8pSTrHV1hT2A38vregm4PCotvYdhhA1JKyHVlPp+vnaTJk
 Ez7h1AlcBC0jwl6o95NS8ftmvGkdlKuOzmz+ofFFs/GLO0qKNOh6hIycQdA+LkQcpvF6M+Yv5C5
 44mwatRl8l+gP2N5BUpm2KP5lI56CU/tnTQBaStl0TMpqBDxVs/kux3jyka9f41pT6eTtuYrAAC
 dX0=
X-Google-Smtp-Source: AGHT+IEs+LhNzEyWbFqwFEOlA9BBoc30YAbFirkdvlCgPr6hp+kqoYxoZFJfKngSUiQQO5TaeKHh6w==
X-Received: by 2002:a17:906:c14b:b0:aa6:6c6b:15fd with SMTP id
 a640c23a62f3a-aac2ad9ae60mr2807969766b.20.1735457235946; 
 Sat, 28 Dec 2024 23:27:15 -0800 (PST)
Received: from tpx1.. (ip-109-42-49-90.web.vodafone.de. [109.42.49.90])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aac0e895194sm1329218666b.70.2024.12.28.23.27.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Dec 2024 23:27:14 -0800 (PST)
From: Thomas Huth <huth@tuxfamily.org>
To: Stefan Hajnoczi <stefanha@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PULL 21/35] next-cube: use qemu_irq to drive int_status in
 next_scr2_rtc_update()
Date: Sun, 29 Dec 2024 08:25:12 +0100
Message-ID: <20241229072526.166555-22-huth@tuxfamily.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241229072526.166555-1-huth@tuxfamily.org>
References: <20241229072526.166555-1-huth@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.208.53; envelope-from=th.huth@gmail.com;
 helo=mail-ed1-f53.google.com
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

Rather than directly clear bit 3 in int_status in next_scr2_rtc_update(), use
a qemu_irq to drive the equivalent NEXT_PWR_I signal.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Thomas Huth <huth@tuxfamily.org>
Message-ID: <20241222130012.1013374-20-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Thomas Huth <huth@tuxfamily.org>
---
 hw/m68k/next-cube.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
index 19b9100094..12f8ecd2d4 100644
--- a/hw/m68k/next-cube.c
+++ b/hw/m68k/next-cube.c
@@ -98,6 +98,7 @@ struct NeXTPC {
     ESCCState escc;
 
     NeXTRTC rtc;
+    qemu_irq rtc_power_irq;
 };
 
 typedef struct next_dma {
@@ -267,7 +268,7 @@ static void next_scr2_rtc_update(NeXTPC *s)
                     /* clear FTU */
                     if (rtc->value & 0x04) {
                         rtc->status = rtc->status & (~0x18);
-                        s->int_status = s->int_status & (~0x04);
+                        qemu_irq_lower(s->rtc_power_irq);
                     }
                 }
             }
@@ -1093,6 +1094,8 @@ static void next_pc_init(Object *obj)
     memory_region_init_io(&s->timer_mem, OBJECT(s), &next_timer_ops, s,
                           "next.timer", 4);
     sysbus_init_mmio(sbd, &s->timer_mem);
+
+    s->rtc_power_irq = qdev_get_gpio_in(DEVICE(obj), NEXT_PWR_I);
 }
 
 /*
-- 
2.47.1


