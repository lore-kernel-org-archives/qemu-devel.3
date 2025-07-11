Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 228E8C83F1B
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 13:35:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaDuI-0004nX-3a; Fri, 11 Jul 2025 09:35:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uaDtl-0004Oz-Oz
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 09:34:47 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uaDtg-0002yp-Hq
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 09:34:45 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-455b00283a5so3368835e9.0
 for <qemu-devel@nongnu.org>; Fri, 11 Jul 2025 06:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752240879; x=1752845679; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=IbWkS2Lz1RSDDCgrF//hw5Y0E8siEDxPmbN3bJe1c5E=;
 b=SsVIDv3Ayhuajf0B7/8SGqYhIwbJyPJWLRwZLWQaioOlwr0HzYjvcfAnXXHUuGB08b
 7ZcYVtvHRMjm5z5CuF9aEFN47mDnmz+hwzI1lrN9z403et1os4MkRLug/c4QaUfFjTA4
 S4/NrP3pBwbh5xuWqmOWY4uPALj7T+K690kIJ+LI8tspu5NZHNEP6EWdTo7iEJkWiEQh
 FIziX8fEfnhcLml+eCEjKayq4kAbMlEZVAXdIrJOmk/c2uafIc2DlCDPvVkWoXhnQaQu
 C+k+ayMW9OKQJJatauhhokt3ddXqt/DVFuiXJWxB+mZGv6Waxemr0uRJIHXv/Inrez7y
 SBQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752240879; x=1752845679;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IbWkS2Lz1RSDDCgrF//hw5Y0E8siEDxPmbN3bJe1c5E=;
 b=ciKEistixG8ct66ugW3xg4SJPxiZtejDGsZsGuaBPYHImTuZTFlXLV4VX+UlZ1nb6W
 7zZJoiJ047vR+6gtEImHNtd15KAXIU2Ss1vkR1sYrJ4S+rPk3KjDr7B8BQgLafcM86Rd
 KdpkAmFu+YG3ukBxYyR61J0E3uU6l+AyFL/JNX17E7DxpKUZcpG+UlDB2lgFip33TYuL
 TdNZI0J/6enkYJYxtdvxJMr4goWqONkOm4HWlnQ3cbSv3pL1xu6N9qmz8HTF5xX2SR93
 G6a1FtirCIyabWDWPAZKEjcaZuUeeX+81sVU3Pzx0wZKINa0UK2/NGvnZzNAAcMn5KXY
 HCIg==
X-Gm-Message-State: AOJu0YxGi4oSirpn5f5DktB8NQs+XJJ3ZWeW7ZHZeKouvO+a8zLXfp/X
 ul4VsfIs+kIzEvdRtuk0/sl+SmPvsoxcvrenT6AWm7GxUcbN+/iKKscMBb0hc4UE7QziqoV5Zss
 utWvp
X-Gm-Gg: ASbGncu0i0hFjc0eta8NlDJ9GO/o4tMvnmV8EW+R4DDrKD9bj1jQ0jZVR3raTdY0Fea
 I/AIRGe7r+2oWmprwKrcyDxAwly7X0dSbNq5t+PDRD1UzKtx9pFwjmxPjdSU7ZY6AvcFPpxmS2t
 DyKPPMwaGiO0PAjRbTy2DNsmvUwqEZxGz5Pdn9+kHQ6dd+vbO/jBThc07CZedE2vLwInZvTOzk0
 W6DbYfaWKkWwuFRnkpL4RJenpU6yev63cs+ZbyBe1fdofHt2zwVuZ4sjLNmjkBMl3diOYA8+2f2
 jiY8Rmms7lUXMNu1AqUoulC4VfIb/ULz6B23yvFrT/VkdH8+7w0ABYS1AUHjqEjXgEcDBsB8z2h
 ELAKQ3rZOmHc9/qxFfAliOndrlunP
X-Google-Smtp-Source: AGHT+IHqBOdlFqG4x8i1tcRtlMZBbp7X07oaWyTABDd7wdZktH0Q02TwNIE9ot4cFpmqcXMYEDAUlw==
X-Received: by 2002:a05:600c:3b05:b0:43c:f513:958a with SMTP id
 5b1f17b1804b1-454ec16cc0fmr33497755e9.13.1752240878871; 
 Fri, 11 Jul 2025 06:34:38 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454d50df0cdsm89734145e9.25.2025.07.11.06.34.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Jul 2025 06:34:38 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/36] MAX78000: Add GCR to SOC
Date: Fri, 11 Jul 2025 14:34:00 +0100
Message-ID: <20250711133429.1423030-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250711133429.1423030-1-peter.maydell@linaro.org>
References: <20250711133429.1423030-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Jackson Donaldson <jackson88044@gmail.com>

This commit adds the Global Control Register to
max78000_soc

Signed-off-by: Jackson Donaldson <jcksn@duck.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20250704223239.248781-8-jcksn@duck.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/max78000_soc.h |  2 ++
 hw/arm/max78000_soc.c         | 18 ++++++++++++++++--
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/include/hw/arm/max78000_soc.h b/include/hw/arm/max78000_soc.h
index 57894f00359..919aca0855f 100644
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
 
diff --git a/hw/arm/max78000_soc.c b/hw/arm/max78000_soc.c
index 2f93ab882d4..45c60883121 100644
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
-- 
2.43.0


