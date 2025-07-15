Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 321B2C83F1A
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 00:02:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubT6R-00023v-1g; Mon, 14 Jul 2025 20:00:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jackson88044@gmail.com>)
 id 1ubT6N-0001qC-Jd
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 20:00:55 -0400
Received: from mail-qk1-x735.google.com ([2607:f8b0:4864:20::735])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jackson88044@gmail.com>)
 id 1ubT6L-00086E-Om
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 20:00:55 -0400
Received: by mail-qk1-x735.google.com with SMTP id
 af79cd13be357-7d95b08634fso313837785a.2
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 17:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1752537652; x=1753142452; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=49cgo57NmECVgjxbtN5bwRKsawdIzTQJeJdTf1yIFQ0=;
 b=RhmkLly+fWdgv83bea3O8eSNsm2Rih0ELAJ7k6Oj4kZPnm9x6MnegmWIZ6dSXL3Rc0
 Jebjsj7eArcO9XP9I0kdeRpON/U13St2atjoJOFxk3tWNYjf2HAQgjiY1YROU39x7bLr
 LcbPV1AQvqXIF+siS4x2AAoZgRYFqRCEEwbjDDUb3HSN+l3V3VTF1YcaQOXRnmmDq3LB
 ljCuaTCT6pmFyjDtEfYsoPY5d8inaf1cjmWU2nQsgC/VnrMw7oQMWizOJlUv54HM2jB4
 YU2qAapPZdwH3LYs0+xaq3sMC/CgIi0lUuXTCKRqqx8VSBMTXNEsk8Y4BYIhPLaHIlgu
 pDng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752537652; x=1753142452;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=49cgo57NmECVgjxbtN5bwRKsawdIzTQJeJdTf1yIFQ0=;
 b=HiN1wvKXn+InyR0pzNzm/SdFH0HemokUiA9P7UE6AENWyQzDck6db/ryyejz7Jd6Ro
 DoSfQcAaU4xOfVs2w/heqA01dXauHAg6nda9EGrsNjAt7JG2Ge2tPONfzjS7YtwfEo6F
 E2VfVBknj8lSl4O8AFVqaTdbFpMindASsneEhxTyP5mIUVeT9tfgCBWUzu3U3qYdabed
 GOvFzLATDsKkZFrKLphMAODqT0soiSGq02gUhWFz6ThfDF+Zb8XeM1HpbYX/jH4amjcj
 aefdQaQVMmUrJwYRZwbK3MYrZ9qslegQFDy+0dydly/CfQBmZu2XpfX7tM1I7CBmB0l2
 /OnA==
X-Gm-Message-State: AOJu0Yzc2YDY+0T05uGsGX/EB/5SnAeb6FDhMWuOgh6+sg9NrqrABg16
 utjSxgxX6UFCf2g7G6oGyXZubSx8XLFYvg8zEBakn98h6C/eAvGpUHbp/T+oQw==
X-Gm-Gg: ASbGncuSwp7VqS2XbkXq7CIbDCUTDc4d/HWFEfQRsRvBoJ8vqDwaNLIjOKBeaBf+ciG
 qNYw3RFd1sBYRQ4MiuS+crZUfwLPelAk9IIVXeeBXKEqiCokaA4rQprnAWQjkSqP7j21pf0yMKS
 KsVaIm6ebVzoPEOjE/yHNYWhLMTkGrMbBg6eqGN9gjOCJ0JScunheuIwj2dc9RbRE+Nr8XbBAnD
 llisqU5upk/mNF2nVBN3CVt7ke2cfSe7f3feKtlqQW1rOnF8rr2MEPysU4+6p7VnHEchj6KnSZF
 0r7cmCbT7jT4oOl3QZ6PeKA2MIyfhqfbtM17TCh33iAg5jxVa+NpKvlPJDVJ4zL7epVfipR8MrO
 3JpUE8tNQmEwiUnnq/gZm0z+Mkz52u/OMBb6rL6MsG4K/tto=
X-Google-Smtp-Source: AGHT+IERiphSZDkR1mvBVPi18GnAHKYgBrepiEuk+t1Vbq2I/GzAPp+9lvzCZFlQ/ab1/bCZgiN+Gg==
X-Received: by 2002:a05:620a:2619:b0:7e1:a534:54c5 with SMTP id
 af79cd13be357-7e1a534582bmr824546485a.45.1752537652245; 
 Mon, 14 Jul 2025 17:00:52 -0700 (PDT)
Received: from user-jcksn.mynetworksettings.com
 ([2600:4040:b51a:4200:2f17:e99b:e0cd:fdf7])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-70497d8eee2sm52296276d6.97.2025.07.14.17.00.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 17:00:51 -0700 (PDT)
From: Jackson Donaldson <jackson88044@gmail.com>
X-Google-Original-From: Jackson Donaldson <jcksn@duck.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v5 07/11] MAX78000: Add GCR to SOC
Date: Mon, 14 Jul 2025 20:00:41 -0400
Message-Id: <20250715000045.57332-8-jcksn@duck.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250715000045.57332-1-jcksn@duck.com>
References: <20250715000045.57332-1-jcksn@duck.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::735;
 envelope-from=jackson88044@gmail.com; helo=mail-qk1-x735.google.com
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

This commit adds the Global Control Register to
max78000_soc

Signed-off-by: Jackson Donaldson <jcksn@duck.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/max78000_soc.c         | 18 ++++++++++++++++--
 include/hw/arm/max78000_soc.h |  2 ++
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/hw/arm/max78000_soc.c b/hw/arm/max78000_soc.c
index 2f93ab882d..45c6088312 100644
--- a/hw/arm/max78000_soc.c
+++ b/hw/arm/max78000_soc.c
@@ -30,6 +30,8 @@ static void max78000_soc_initfn(Object *obj)
 
     object_initialize_child(obj, "armv7m", &s->armv7m, TYPE_ARMV7M);
 
+    object_initialize_child(obj, "gcr", &s->gcr, TYPE_MAX78000_GCR);
+
     for (i = 0; i < MAX78000_NUM_ICC; i++) {
         g_autofree char *name = g_strdup_printf("icc%d", i);
         object_initialize_child(obj, name, &s->icc[i], TYPE_MAX78000_ICC);
@@ -48,7 +50,7 @@ static void max78000_soc_realize(DeviceState *dev_soc, Error **errp)
 {
     MAX78000State *s = MAX78000_SOC(dev_soc);
     MemoryRegion *system_memory = get_system_memory();
-    DeviceState *dev, *armv7m;
+    DeviceState *dev, *gcrdev, *armv7m;
     SysBusDevice *busdev;
     Error *err = NULL;
     int i;
@@ -69,6 +71,11 @@ static void max78000_soc_realize(DeviceState *dev_soc, Error **errp)
 
     memory_region_init_ram(&s->sram, NULL, "MAX78000.sram", SRAM_SIZE,
                            &err);
+
+    gcrdev = DEVICE(&s->gcr);
+    object_property_set_link(OBJECT(gcrdev), "sram", OBJECT(&s->sram),
+                                 &err);
+
     if (err != NULL) {
         error_propagate(errp, err);
         return;
@@ -101,19 +108,26 @@ static void max78000_soc_realize(DeviceState *dev_soc, Error **errp)
     }
 
     for (i = 0; i < MAX78000_NUM_UART; i++) {
+        g_autofree char *link = g_strdup_printf("uart%d", i);
         dev = DEVICE(&(s->uart[i]));
         qdev_prop_set_chr(dev, "chardev", serial_hd(i));
         if (!sysbus_realize(SYS_BUS_DEVICE(&s->uart[i]), errp)) {
             return;
         }
 
+        object_property_set_link(OBJECT(gcrdev), link, OBJECT(dev),
+                                 &err);
+
         busdev = SYS_BUS_DEVICE(dev);
         sysbus_mmio_map(busdev, 0, max78000_uart_addr[i]);
         sysbus_connect_irq(busdev, 0, qdev_get_gpio_in(armv7m,
                                                        max78000_uart_irq[i]));
     }
 
-    create_unimplemented_device("globalControl",        0x40000000, 0x400);
+    dev = DEVICE(&s->gcr);
+    sysbus_realize(SYS_BUS_DEVICE(dev), errp);
+    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, 0x40000000);
+
     create_unimplemented_device("systemInterface",      0x40000400, 0x400);
     create_unimplemented_device("functionControl",      0x40000800, 0x400);
     create_unimplemented_device("watchdogTimer0",       0x40003000, 0x400);
diff --git a/include/hw/arm/max78000_soc.h b/include/hw/arm/max78000_soc.h
index 57894f0035..919aca0855 100644
--- a/include/hw/arm/max78000_soc.h
+++ b/include/hw/arm/max78000_soc.h
@@ -11,6 +11,7 @@
 
 #include "hw/or-irq.h"
 #include "hw/arm/armv7m.h"
+#include "hw/misc/max78000_gcr.h"
 #include "hw/misc/max78000_icc.h"
 #include "hw/char/max78000_uart.h"
 #include "qom/object.h"
@@ -35,6 +36,7 @@ struct MAX78000State {
     MemoryRegion sram;
     MemoryRegion flash;
 
+    Max78000GcrState gcr;
     Max78000IccState icc[MAX78000_NUM_ICC];
     Max78000UartState uart[MAX78000_NUM_UART];
 
-- 
2.34.1


