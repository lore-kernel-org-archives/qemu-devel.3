Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E044FC8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 16:58:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXjjJ-00072Y-HE; Fri, 04 Jul 2025 12:57:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jackson88044@gmail.com>)
 id 1uXjjH-0006x1-6h
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:57:39 -0400
Received: from mail-qv1-xf36.google.com ([2607:f8b0:4864:20::f36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jackson88044@gmail.com>)
 id 1uXjjF-0000Ov-KY
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:57:38 -0400
Received: by mail-qv1-xf36.google.com with SMTP id
 6a1803df08f44-6fafb6899c2so13477206d6.0
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 09:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751648256; x=1752253056; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BE/lzW3BfqV/5f1khJmZ2eb1cV7GZIIrYgpYenAgyy0=;
 b=at2uhNEyzPWuJSwDKoa2+jCFAdueIbHMo8EXtByf8sd2qpEpy5Q33W9oVjln31Wm1O
 4AP++aOyjIg6u5WZzPOsDksE0kWb94Mw03SgV3fDLfVtjjp9ZMWRkyg7Xgn5hnKjkjM9
 jw6XWvOIcvmFVUcQM3CmdcCktlewEOzic+lOqQD5X/hP746Sky1NEtqt1S6iB/r2QZ/t
 KLYjMNydvBodawY7CkgCtpjDWJL52fKM2vJz3ez9qRuqYvOdWetG22RYrR1DT/YhC45T
 A2EwAl6J28/MjFbIqJFm41x4Tb4fygyL7IxYXyy7imnrZFJwWS6sM60n5mzWgdxoLsU5
 pKnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751648256; x=1752253056;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BE/lzW3BfqV/5f1khJmZ2eb1cV7GZIIrYgpYenAgyy0=;
 b=LYd1obV2lGUQo0gRVKSgngBtYeTa7A5BFxrUsLF3Tqh8HC+2ZPRfdEWqQfJ7boDiAy
 RokLySaRTOJuHwSK3QxXzPh3uCrd76uWRnAkEte+QVo3LqZT6ysk9xYFPxifhcByD3db
 jy8kLkrnMUX/c35s4ecemF+quXAgMzkgw8vpB6R+FNr6LQvreYOINlW9jBuMSZFqqUTk
 PERm76oLwNQKo0leaVw3vmbDBTd3xqtENPZx34KMaQ1llsNuSIkD9FlcTdho+tOWFVx1
 lLOVKYPsZyhQhqhzI4urddace8UkSudBxeKODgC86sukUORiwbTIYy/vcnmYP8g2gPMy
 qq9A==
X-Gm-Message-State: AOJu0YwfI5wXXJ/sYha69MOxcgXjiWCyrCFNjj0Djgimf7qY/9l0kyVb
 4/FWgjnNmIhQs+jgJUHT67HPm1lE4IYoxvYU+BNY9D3xAYv5o5hONXpFaEGsKA==
X-Gm-Gg: ASbGncuFpBa/DywJPz07HQ8El6QvG7B10kbolq5kmG0MOqqryJfUmJcFk6rE7ZHeIvr
 pSG6INHNvTyYKkb0t+UdUP6O1YWTyBHn2GyK4DOB+Iciy+L67jurpg84OshCN2S5apKVcOcY8s1
 GKV02E+l28+PNBX1UdbVQ4oedEfxvwBfv55iUvpreVXaPNpZy2ssqb/sd26uIcMvSUbAMU6dAUN
 cp+NtIAnPk0UmKUuAsFGxn4lkbSECA8/hN27FyA3iNBpJhAznFkh5swmho+oZKCI926Z6avJmvU
 h9RWhme7NHonFGdkHSvoeZ4hZdiiiK8IBJaVFVIaHwPMxzpMLItyAeLoIvBVTGgtYS+l0lxE3S4
 Nj/6Q
X-Google-Smtp-Source: AGHT+IEVnc5jNqgqKsAeXk/s8mDMFw/ZEkKYuQzmVsHQ6fBGK/Gd7Dh/TB6rkPk1Av+PmuSTSdwW7Q==
X-Received: by 2002:a05:6214:23c5:b0:6fa:ae40:3023 with SMTP id
 6a1803df08f44-702c56cd9f1mr52899336d6.7.1751648256211; 
 Fri, 04 Jul 2025 09:57:36 -0700 (PDT)
Received: from user-jcksn.myfiosgateway.com
 ([2600:4040:2bcd:3800:e3f4:4cee:828f:52d])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-702c4ccc6easm15345826d6.26.2025.07.04.09.57.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 09:57:35 -0700 (PDT)
From: Jackson Donaldson <jackson88044@gmail.com>
X-Google-Original-From: Jackson Donaldson <jcksn@duck.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v3 07/11] MAX78000: Add GCR to SOC
Date: Fri,  4 Jul 2025 12:57:25 -0400
Message-Id: <20250704165729.208381-8-jcksn@duck.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250704165729.208381-1-jcksn@duck.com>
References: <20250704165729.208381-1-jcksn@duck.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f36;
 envelope-from=jackson88044@gmail.com; helo=mail-qv1-xf36.google.com
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
---
 hw/arm/max78000_soc.c         | 22 ++++++++++++++++++++--
 include/hw/arm/max78000_soc.h |  2 ++
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/hw/arm/max78000_soc.c b/hw/arm/max78000_soc.c
index 2f93ab882d..eddd9616f0 100644
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
@@ -94,12 +101,14 @@ static void max78000_soc_realize(DeviceState *dev_soc, Error **errp)
         return;
     }
 
+
     for (i = 0; i < MAX78000_NUM_ICC; i++) {
         dev = DEVICE(&(s->icc[i]));
         sysbus_realize(SYS_BUS_DEVICE(dev), errp);
         sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, max78000_icc_addr[i]);
     }
 
+
     for (i = 0; i < MAX78000_NUM_UART; i++) {
         dev = DEVICE(&(s->uart[i]));
         qdev_prop_set_chr(dev, "chardev", serial_hd(i));
@@ -107,13 +116,22 @@ static void max78000_soc_realize(DeviceState *dev_soc, Error **errp)
             return;
         }
 
+        g_autofree char *link = g_strdup_printf("uart%d", i);
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
+
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


