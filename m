Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AACD6C71159
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Jun 2025 05:23:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uS7ic-0003HM-9z; Thu, 19 Jun 2025 01:21:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jackson88044@gmail.com>)
 id 1uS1r4-0006rn-Tu
 for qemu-devel@nongnu.org; Wed, 18 Jun 2025 19:06:06 -0400
Received: from mail-il1-x132.google.com ([2607:f8b0:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jackson88044@gmail.com>)
 id 1uS1r2-00065c-Au
 for qemu-devel@nongnu.org; Wed, 18 Jun 2025 19:06:06 -0400
Received: by mail-il1-x132.google.com with SMTP id
 e9e14a558f8ab-3dc9e7d10bdso680875ab.2
 for <qemu-devel@nongnu.org>; Wed, 18 Jun 2025 16:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750287963; x=1750892763; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KRYj8rEaeYKV08YM0H0JNx6pDU9r7YO11slIfaj7nMI=;
 b=cqEVyH8qKmwppuVd+B5oDjLTGE7CoRrd21XSl+4h6GZov41BWubAhsF1TxuQPz72Gz
 KtUTxtOwc0yrimVaNS0x04VdbmPGKgwDlkA9pqGz/NjgvJLHmjH8xIt+kdhYF15yV4z3
 EzIAkVzFUbzovjOQxZIbNn3hOqrraiKXbf9iMOIm3S5ms+5WGW/5wQvnk9z80kAhS9dl
 8jI+BFOHwwvjFVQHCo/b4okettPieuDm0bMmd+pd76/LBPjx51axUart3qu3lO0aJS8d
 sP0LoW6xREkT3r3rx4AnSMIwo++l0PwVCmrlDVlnhjo9wziKAImotxfihDlnU/BQSh3t
 ThBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750287963; x=1750892763;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KRYj8rEaeYKV08YM0H0JNx6pDU9r7YO11slIfaj7nMI=;
 b=gtlmbYtvivNtzT7ba6qpImNOVDNnq8iwmhSYK6VOsKwhHoI3bWwkRSTSJkQgzBsEeu
 Yqsk4zVUGQZX5fK1Wk26bMNykJMZFl+hToWnQGltMjRntK/VcLS8IzPep9p62kt7vsTI
 QnGgxV7LfBV2AjeYlYacylZJ4B9qFKZha/yG65+BX82G/87p1vqCPllg4BhRV6zWO370
 txw3/3pyKlZA3lLLYq2Q/uWFlMDV5lVosxcqAOeGrnfu+oL213zI2Ldjo3nkLb8em5Fu
 J4ScJjwNVto7XHFXCcHTRQMnu5BXanE2bXqnOJHIHX+/OOe7Zey272rpCvLD6wPG6CvE
 I5BA==
X-Gm-Message-State: AOJu0YxM8d/wH1yEyNOaR6yi87ZJcjSOnqd+UFwAirA7J4ybyZeM9atn
 Om+IhX/13S6hg5kI/IeX6gsy0aDAHM1ePLDb6v+7gp8HqUAAy8zmaastVNUMJgBVPzo=
X-Gm-Gg: ASbGncuTicNpKuRWpuyR55Szj+xkzzZFeS2otLY3JmEFAMj9SwFgz12DdgJQwQ+IyjX
 k1jSFoSeuQU9lodBY8lIZIojrNNEwCB8oLw1o+dVJX09sKl8ghYmwRrgyo8gKXKOUHQ93h3zq4n
 oglODeCU808Fdinzz6RuJxuBXh2deZMLcx1T9vuInPVV9kV6hEHWgn8C/kY57ThHChEPY4Ab5wn
 8qjZid7NJNarVu2N4EDy07eIfvQrGx11/rPPNhGaNzw41n/UaLGBpUKaRk9EsuuDra/fBxwt1zr
 WApYYj2RKXzdbHeKqNRZXguYRsCu/dM8lwm+d87KAmmjXzLSjS5eoRqj5GbZjYATFskWkn2neMX
 e+2yx
X-Google-Smtp-Source: AGHT+IHQMtBFcP21kZa2FsfI1u30sOvP77aUymTqKw5FS8m1tvyLzEKOla+SpM28JrFHq2dSyr5a6w==
X-Received: by 2002:a05:6e02:184a:b0:3db:7c22:303c with SMTP id
 e9e14a558f8ab-3de07cfe991mr200312265ab.8.1750287962740; 
 Wed, 18 Jun 2025 16:06:02 -0700 (PDT)
Received: from user-jcksn.hsd1.mi.comcast.net
 ([2601:401:101:1070:b57:773f:14d7:807b])
 by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-50149b9df11sm3036915173.54.2025.06.18.16.06.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Jun 2025 16:06:02 -0700 (PDT)
From: Jackson Donaldson <jackson88044@gmail.com>
X-Google-Original-From: Jackson Donaldson <jcksn@duck.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v2 05/11] MAX78000: Add UART to SOC
Date: Wed, 18 Jun 2025 19:05:43 -0400
Message-Id: <20250618230549.3351152-6-jcksn@duck.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250618230549.3351152-1-jcksn@duck.com>
References: <20250618230549.3351152-1-jcksn@duck.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::132;
 envelope-from=jackson88044@gmail.com; helo=mail-il1-x132.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 19 Jun 2025 01:21:41 -0400
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

This commit adds UART to max78000_soc

Signed-off-by: Jackson Donaldson <jcksn@duck.com>
---
 hw/arm/max78000_soc.c         | 28 ++++++++++++++++++++++++----
 include/hw/arm/max78000_soc.h |  3 +++
 2 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/hw/arm/max78000_soc.c b/hw/arm/max78000_soc.c
index 8d8d2dce61..7217924191 100644
--- a/hw/arm/max78000_soc.c
+++ b/hw/arm/max78000_soc.c
@@ -18,6 +18,10 @@
 #include "hw/misc/unimp.h"
 
 static const uint32_t max78000_icc_addr[] = {0x4002a000, 0x4002a800};
+static const uint32_t max78000_uart_addr[] = {0x40042000, 0x40043000,
+                                              0x40044000};
+
+static const int max78000_uart_irq[] = {14, 15, 34};
 
 static void max78000_soc_initfn(Object *obj)
 {
@@ -30,6 +34,11 @@ static void max78000_soc_initfn(Object *obj)
         object_initialize_child(obj, "icc[*]", &s->icc[i], TYPE_MAX78000_ICC);
     }
 
+    for (i = 0; i < MAX78000_NUM_UART; i++) {
+        object_initialize_child(obj, "uart[*]", &s->uart[i],
+                                TYPE_MAX78000_UART);
+    }
+
     s->sysclk = qdev_init_clock_in(DEVICE(s), "sysclk", NULL, NULL, 0);
 }
 
@@ -38,6 +47,7 @@ static void max78000_soc_realize(DeviceState *dev_soc, Error **errp)
     MAX78000State *s = MAX78000_SOC(dev_soc);
     MemoryRegion *system_memory = get_system_memory();
     DeviceState *dev, *armv7m;
+    SysBusDevice *busdev;
     Error *err = NULL;
     int i;
 
@@ -88,6 +98,20 @@ static void max78000_soc_realize(DeviceState *dev_soc, Error **errp)
         sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, max78000_icc_addr[i]);
     }
 
+    for (i = 0; i < MAX78000_NUM_UART; i++) {
+        dev = DEVICE(&(s->uart[i]));
+        qdev_prop_set_chr(dev, "chardev", serial_hd(i));
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->uart[i]), errp)) {
+            return;
+        }
+        dev->id = g_strdup_printf("uart%d", i);
+
+        busdev = SYS_BUS_DEVICE(dev);
+        sysbus_mmio_map(busdev, 0, max78000_uart_addr[i]);
+        sysbus_connect_irq(busdev, 0, qdev_get_gpio_in(armv7m,
+                                                       max78000_uart_irq[i]));
+    }
+
     create_unimplemented_device("globalControl",        0x40000000, 0x400);
     create_unimplemented_device("systemInterface",      0x40000400, 0x400);
     create_unimplemented_device("functionControl",      0x40000800, 0x400);
@@ -126,10 +150,6 @@ static void max78000_soc_realize(DeviceState *dev_soc, Error **errp)
     create_unimplemented_device("oneWireMaster",        0x4003d000, 0x1000);
     create_unimplemented_device("semaphore",            0x4003e000, 0x1000);
 
-    create_unimplemented_device("uart0",                0x40042000, 0x1000);
-    create_unimplemented_device("uart1",                0x40043000, 0x1000);
-    create_unimplemented_device("uart2",                0x40044000, 0x1000);
-
     create_unimplemented_device("spi1",                 0x40046000, 0x2000);
     create_unimplemented_device("trng",                 0x4004d000, 0x1000);
     create_unimplemented_device("i2s",                  0x40060000, 0x1000);
diff --git a/include/hw/arm/max78000_soc.h b/include/hw/arm/max78000_soc.h
index 27b506d6ee..57894f0035 100644
--- a/include/hw/arm/max78000_soc.h
+++ b/include/hw/arm/max78000_soc.h
@@ -12,6 +12,7 @@
 #include "hw/or-irq.h"
 #include "hw/arm/armv7m.h"
 #include "hw/misc/max78000_icc.h"
+#include "hw/char/max78000_uart.h"
 #include "qom/object.h"
 
 #define TYPE_MAX78000_SOC "max78000-soc"
@@ -24,6 +25,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(MAX78000State, MAX78000_SOC)
 
 /* The MAX78k has 2 instruction caches; only icc0 matters, icc1 is for RISC */
 #define MAX78000_NUM_ICC 2
+#define MAX78000_NUM_UART 3
 
 struct MAX78000State {
     SysBusDevice parent_obj;
@@ -34,6 +36,7 @@ struct MAX78000State {
     MemoryRegion flash;
 
     Max78000IccState icc[MAX78000_NUM_ICC];
+    Max78000UartState uart[MAX78000_NUM_UART];
 
     Clock *sysclk;
 };
-- 
2.34.1


