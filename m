Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 380BBC83F17
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 00:02:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubT6P-00021o-Rz; Mon, 14 Jul 2025 20:00:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jackson88044@gmail.com>)
 id 1ubT6M-0001kC-Am
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 20:00:54 -0400
Received: from mail-qv1-xf2f.google.com ([2607:f8b0:4864:20::f2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jackson88044@gmail.com>)
 id 1ubT6K-00085f-KO
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 20:00:54 -0400
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-6fabb948e5aso57708276d6.1
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 17:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1752537651; x=1753142451; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=phiEmK1lePLVsDmAzYR/sL9R07HKqn5H6z1VgPvevG0=;
 b=nlNoc1MYOpMoIwPO5qtVEgKBIYymWBa6E61uYfeP2XKsZTzmrU95jMCaFXQkPXgbGB
 Xk9te7bjle1dP8zdqG/pNi8YGL1/lZ0GR4jfo538cXwfcABnzwyst6AqEHUYu/bJMnmM
 kPqMqDuBQwIk63qoyKcvWP/vmFsxC6FsSMC2UfbacoVagTsH9HGXl+rblTgRcSAiGhIZ
 fOCpnKKkENlNA9vxkxq/w3RabAdvieLKMYVWea2f+Cmu/W3+3lBGRwGlLYXJrQ/VIK3Y
 5dMPLquyWDJGE3cekBB2wroPNTB3NffUpRvDP4r3JpFmCOTMNN6J8QyQpnd2Nw7BZhdV
 zNpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752537651; x=1753142451;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=phiEmK1lePLVsDmAzYR/sL9R07HKqn5H6z1VgPvevG0=;
 b=nrOAYgldJN8i4JZWifUFz1+ClREXHHUXLsuzgZJO4pA/Px8fa+NOmSduDgNoMjY7An
 upzbCePihma4DYCVIosbi2zfTfRVvQEFxCkrCE+JVdRuYmAaug9GzkPzZyTkJllzDJU+
 2rRlD8frwji2xOsyVdSYbP2akKNylbqOCdmTz5DhXH9cZVD055xXFQGsl2PnAOjPx2qq
 J40FKOhgQH0+vpMv3Eqx/0iGifyeOi2o7OhuiUCQXPfS5VZVyRIY8pAhFVvj4BWoDzws
 fyusyteB6qqD6n2leNkpgbi60QLf6O7EQOhSijR2E/FZZUSMc/uU/h0LmqzAcs+Mx8wq
 Eu8g==
X-Gm-Message-State: AOJu0YyvMW+tAf3EpWcKrskGRPblfmrXgo+54+fHi6g8EHH7xW2Arf+T
 krpbTX7/3WgEzm6ARuj5xLiN6k6W6uwUI6w/Xy5XhwD5RDhmFm9OfAX9eDS42Q==
X-Gm-Gg: ASbGnctvmewBSSbR7sexlVg1LHYiv57VMqOL6IemK/Qa2oSHX6J9CjejWut0HbESkzj
 FODsuYLqSUy/VvvcQ9saw3AlElb9IK87j92GNTW0UF8aoeyYfdHN1+OK7cF3Gr9SqrTRuGST3Im
 j7ZIfHqGF2mUflAvfMDjgKhCtPouNkoK3fppz/Pp7I0gQ/OSnsfW++HcXEzWj01y+nth5srX6o9
 YTdQ/fQNWY2QDZSmpRNSrpxY5aJOUZOpBB4MQbACBsKc4+nu2v+ZDxhPTkR8Y9tD1I/t0W5GZRe
 URt0cxArm59/Y2y0hXkAew/baoPl4R6efVC0gy0j7I91yBBkyVO815iLWPcZ1GpY8UrIUqc/Iad
 VfALlKXwIKDssUtPoKlgFxhYBHjbWqWt1lrvheEEhVEilmN+XGtbQnDsWnw==
X-Google-Smtp-Source: AGHT+IHgfFOABnq52eiOdn0E8xeDMqhfIQZ51c8LRLn/ojAYhZ6Zmw+KMCvHvdpZ+gZOyzSaMAUC0Q==
X-Received: by 2002:a05:6214:20e8:b0:6fa:bb74:8d72 with SMTP id
 6a1803df08f44-704a3d1496fmr228857466d6.0.1752537651002; 
 Mon, 14 Jul 2025 17:00:51 -0700 (PDT)
Received: from user-jcksn.mynetworksettings.com
 ([2600:4040:b51a:4200:2f17:e99b:e0cd:fdf7])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-70497d8eee2sm52296276d6.97.2025.07.14.17.00.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 17:00:50 -0700 (PDT)
From: Jackson Donaldson <jackson88044@gmail.com>
X-Google-Original-From: Jackson Donaldson <jcksn@duck.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v5 05/11] MAX78000: Add UART to SOC
Date: Mon, 14 Jul 2025 20:00:39 -0400
Message-Id: <20250715000045.57332-6-jcksn@duck.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250715000045.57332-1-jcksn@duck.com>
References: <20250715000045.57332-1-jcksn@duck.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2f;
 envelope-from=jackson88044@gmail.com; helo=mail-qv1-xf2f.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

This commit adds UART to max78000_soc

Signed-off-by: Jackson Donaldson <jcksn@duck.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/max78000_soc.c         | 28 ++++++++++++++++++++++++----
 include/hw/arm/max78000_soc.h |  3 +++
 2 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/hw/arm/max78000_soc.c b/hw/arm/max78000_soc.c
index 0c83b08eca..2f93ab882d 100644
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
@@ -31,6 +35,12 @@ static void max78000_soc_initfn(Object *obj)
         object_initialize_child(obj, name, &s->icc[i], TYPE_MAX78000_ICC);
     }
 
+    for (i = 0; i < MAX78000_NUM_UART; i++) {
+        g_autofree char *name = g_strdup_printf("uart%d", i);
+        object_initialize_child(obj, name, &s->uart[i],
+                                TYPE_MAX78000_UART);
+    }
+
     s->sysclk = qdev_init_clock_in(DEVICE(s), "sysclk", NULL, NULL, 0);
 }
 
@@ -39,6 +49,7 @@ static void max78000_soc_realize(DeviceState *dev_soc, Error **errp)
     MAX78000State *s = MAX78000_SOC(dev_soc);
     MemoryRegion *system_memory = get_system_memory();
     DeviceState *dev, *armv7m;
+    SysBusDevice *busdev;
     Error *err = NULL;
     int i;
 
@@ -89,6 +100,19 @@ static void max78000_soc_realize(DeviceState *dev_soc, Error **errp)
         sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, max78000_icc_addr[i]);
     }
 
+    for (i = 0; i < MAX78000_NUM_UART; i++) {
+        dev = DEVICE(&(s->uart[i]));
+        qdev_prop_set_chr(dev, "chardev", serial_hd(i));
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->uart[i]), errp)) {
+            return;
+        }
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
@@ -127,10 +151,6 @@ static void max78000_soc_realize(DeviceState *dev_soc, Error **errp)
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


