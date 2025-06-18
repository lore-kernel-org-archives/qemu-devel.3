Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 399B4C71159
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Jun 2025 05:23:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uS7ic-0003HN-H5; Thu, 19 Jun 2025 01:21:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jackson88044@gmail.com>)
 id 1uS1r7-0006uz-AP
 for qemu-devel@nongnu.org; Wed, 18 Jun 2025 19:06:09 -0400
Received: from mail-io1-xd31.google.com ([2607:f8b0:4864:20::d31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jackson88044@gmail.com>)
 id 1uS1r5-00066G-7J
 for qemu-devel@nongnu.org; Wed, 18 Jun 2025 19:06:09 -0400
Received: by mail-io1-xd31.google.com with SMTP id
 ca18e2360f4ac-86a464849c2so5503839f.1
 for <qemu-devel@nongnu.org>; Wed, 18 Jun 2025 16:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750287966; x=1750892766; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6SLCzEWpSBxp31R4JKsPKGH7xuaYhB4PdeuTSnMKsJc=;
 b=Zs30ZYLJYxvEcs0vkXluDXxqtDLfvXCJaJVyIQc6QYYXjyCfx3jsrWk3dQ0tXgxKZv
 jnC4wC4n8qpFh9qBjZBSR5T4rA+20EHUyQggcz/MW0a+rhDeX1MMqG7cUZViZb0QQPRf
 hFVr6bWtv50T3Tc16W3/zkgvXGuNdkzQkJNyBUozz1VvRKs2CFhZvNzmLe8F4MVG0zYp
 0QlyDn4Fc7eAFIIoz2JrHIn80sjTJ3OqJtzsp7cjBfHN0LIBh41kwKIIYZzcX5x3Bg1R
 VeaMgH3k/L/0l7auo9i83UhNPJ0qV2TNQVB1W7WA8YNISM/Q7iVRGLXYBL9JiWHY/TeD
 90Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750287966; x=1750892766;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6SLCzEWpSBxp31R4JKsPKGH7xuaYhB4PdeuTSnMKsJc=;
 b=u0JSQu5Vwo172JjqiXY0ak6HfdmhPpNFBcPtlwwz7V5jiHD3EXK1X+I1sTQ16ZD3nH
 pYqu167sTQEkXUtRYWLpI30mXK/oiImGLSIX7frweL2CkhFtFvgmWunlWoCOzZumEpco
 BTADKRDR1y4TGuXgyi0IOK0XWQ5n18/vG47y9FPY7GhPmAQqi/s40bxRQE3nqYULQXIE
 PJGAafvI1EbXF7FOQHuC3qZtVIy/Pr1DMdzxqC0HoEWKmRSKMTpNV+MslsY9RjoLQo8V
 3nsMDfkqjF0S1e/fq6e5J+pGNsgRHc2m+CgTW60HcdtFMEXDQFGzCZ2daFKk9M/c+00m
 QzSQ==
X-Gm-Message-State: AOJu0Yxx4SydOdJ1VLVpOUGcbTVlnTfy+1Fr8gTKtWvZcUhD7Jsndzch
 1BAAa45b/TpIaHnT9ZSTtKflppyWPE2xp/2zcLvkZ9FM1d/JLlb2xlY7EzNfSvfVk5M=
X-Gm-Gg: ASbGncup6nCiE5v7jmzEPFO4XxtQlfU8kgsGx42a7THdMETzVSwDSa3L/KdBmveRRfK
 0BwLrSeov7eeNztrI5oyGY7fGfKg0X0zDcHhNprp468ag+OwxcGPbvvy2aKD04sf9kAJ4ATaTvH
 jyIbg2mVR53ZgxFKpqYtdZamGY9OdFOpcuVEY4sbP40HcJ+dlO2rDRvUT7cvVCdHEiQtoWMCjOK
 aFVqIiDSdcMfgGzxlau/YsUbyetv29N+EX2L8PCkpd3YG/ZsFi5SwvlBTwlJ8bu84zyyeYqCMsN
 UpjSEXvAdar0orYQGbv18IWfip2SRuTvORqQ8q4asDB6fIzmsp//l7VS5NObqagmN3SiQu7CJuK
 zG9gS
X-Google-Smtp-Source: AGHT+IEeVsRIAY6b+w4EK8/rSyU15l8sm4ydY8fPzNTFZA/AQ/0mN/l4PcBkNYvdEeJUSbPx/TTTlA==
X-Received: by 2002:a05:6602:a108:b0:85e:d0ca:b635 with SMTP id
 ca18e2360f4ac-8761b670e64mr114269539f.2.1750287965686; 
 Wed, 18 Jun 2025 16:06:05 -0700 (PDT)
Received: from user-jcksn.hsd1.mi.comcast.net
 ([2601:401:101:1070:b57:773f:14d7:807b])
 by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-50149b9df11sm3036915173.54.2025.06.18.16.06.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Jun 2025 16:06:05 -0700 (PDT)
From: Jackson Donaldson <jackson88044@gmail.com>
X-Google-Original-From: Jackson Donaldson <jcksn@duck.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v2 08/11] MAX78000: TRNG Implementation
Date: Wed, 18 Jun 2025 19:05:46 -0400
Message-Id: <20250618230549.3351152-9-jcksn@duck.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250618230549.3351152-1-jcksn@duck.com>
References: <20250618230549.3351152-1-jcksn@duck.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::d31;
 envelope-from=jackson88044@gmail.com; helo=mail-io1-xd31.google.com
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

This commit implements the True Random Number
Generator for the MAX78000

Signed-off-by: Jackson Donaldson <jcksn@duck.com>
---
 hw/arm/Kconfig                  |   1 +
 hw/misc/Kconfig                 |   3 +
 hw/misc/max78000_gcr.c          |   6 ++
 hw/misc/max78000_trng.c         | 127 ++++++++++++++++++++++++++++++++
 hw/misc/meson.build             |   1 +
 include/hw/misc/max78000_gcr.h  |   1 +
 include/hw/misc/max78000_trng.h |  35 +++++++++
 7 files changed, 174 insertions(+)
 create mode 100644 hw/misc/max78000_trng.c
 create mode 100644 include/hw/misc/max78000_trng.h

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 41bb64458f..fcac62be6f 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -369,6 +369,7 @@ config MAX78000_SOC
     select MAX78000_ICC
     select MAX78000_UART
     select MAX78000_GCR
+    select MAX78000_TRNG
 
 config RASPI
     bool
diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index fde2266b8f..dd6a6e54da 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -53,6 +53,9 @@ config MAX78000_GCR
 config MAX78000_ICC
     bool
 
+config MAX78000_TRNG
+    bool
+
 config MOS6522
     bool
 
diff --git a/hw/misc/max78000_gcr.c b/hw/misc/max78000_gcr.c
index 8c282f3916..5916ee615a 100644
--- a/hw/misc/max78000_gcr.c
+++ b/hw/misc/max78000_gcr.c
@@ -14,6 +14,7 @@
 #include "migration/vmstate.h"
 #include "hw/qdev-properties.h"
 #include "hw/char/max78000_uart.h"
+#include "hw/misc/max78000_trng.h"
 #include "hw/misc/max78000_gcr.h"
 
 
@@ -157,6 +158,9 @@ static void max78000_gcr_write(void *opaque, hwaddr addr,
         if (val & UART0_RESET) {
             device_cold_reset(s->uart0);
         }
+        if (val & TRNG_RESET) {
+            device_cold_reset(s->trng);
+        }
         /* TODO: As other devices are implemented, add them here */
         break;
 
@@ -257,6 +261,8 @@ static const Property max78000_gcr_properties[] = {
                      TYPE_MAX78000_UART, DeviceState*),
     DEFINE_PROP_LINK("uart2", Max78000GcrState, uart2,
                      TYPE_MAX78000_UART, DeviceState*),
+    DEFINE_PROP_LINK("trng", Max78000GcrState, trng,
+                        TYPE_MAX78000_TRNG, DeviceState*),
 };
 
 static const MemoryRegionOps max78000_gcr_ops = {
diff --git a/hw/misc/max78000_trng.c b/hw/misc/max78000_trng.c
new file mode 100644
index 0000000000..f406681730
--- /dev/null
+++ b/hw/misc/max78000_trng.c
@@ -0,0 +1,127 @@
+/*
+ * MAX78000 True Random Number Generator
+ *
+ * Copyright (c) 2025 Jackson Donaldson <jcksn@duck.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "trace.h"
+#include "hw/irq.h"
+#include "migration/vmstate.h"
+#include "hw/misc/max78000_trng.h"
+#include "qemu/guest-random.h"
+
+static uint64_t max78000_trng_read(void *opaque, hwaddr addr,
+                                    unsigned int size)
+{
+    uint32_t data;
+
+    Max78000TrngState *s = opaque;
+    switch (addr) {
+    case CTRL:
+        return s->ctrl;
+
+    case STATUS:
+        return 1;
+
+    case DATA:
+        qemu_guest_getrandom_nofail(&data, sizeof(data));
+        return data;
+
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset 0x%"
+            HWADDR_PRIx "\n", __func__, addr);
+        break;
+    }
+    return 0;
+}
+
+static void max78000_trng_write(void *opaque, hwaddr addr,
+                    uint64_t val64, unsigned int size)
+{
+    Max78000TrngState *s = opaque;
+    uint32_t val = val64;
+    switch (addr) {
+    case CTRL:
+        /* TODO: implement AES keygen */
+        s->ctrl = val;
+        if (val & RND_IE) {
+            qemu_set_irq(s->irq, 1);
+        } else{
+            qemu_set_irq(s->irq, 0);
+        }
+        break;
+
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset 0x%"
+            HWADDR_PRIx "\n", __func__, addr);
+        break;
+    }
+}
+
+static void max78000_trng_reset_hold(Object *obj, ResetType type)
+{
+    Max78000TrngState *s = MAX78000_TRNG(obj);
+    s->ctrl = 0;
+    s->status = 0;
+    s->data = 0;
+}
+
+static const MemoryRegionOps max78000_trng_ops = {
+    .read = max78000_trng_read,
+    .write = max78000_trng_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid.min_access_size = 4,
+    .valid.max_access_size = 4,
+};
+
+static const VMStateDescription max78000_trng_vmstate = {
+    .name = TYPE_MAX78000_TRNG,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32(ctrl, Max78000TrngState),
+        VMSTATE_UINT32(status, Max78000TrngState),
+        VMSTATE_UINT32(data, Max78000TrngState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void max78000_trng_init(Object *obj)
+{
+    Max78000TrngState *s = MAX78000_TRNG(obj);
+    sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->irq);
+
+    memory_region_init_io(&s->mmio, obj, &max78000_trng_ops, s,
+                        TYPE_MAX78000_TRNG, 0x1000);
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
+
+}
+
+static void max78000_trng_class_init(ObjectClass *klass, const void *data)
+{
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    rc->phases.hold = max78000_trng_reset_hold;
+    dc->vmsd = &max78000_trng_vmstate;
+
+}
+
+static const TypeInfo max78000_trng_info = {
+    .name          = TYPE_MAX78000_TRNG,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(Max78000TrngState),
+    .instance_init = max78000_trng_init,
+    .class_init    = max78000_trng_class_init,
+};
+
+static void max78000_trng_register_types(void)
+{
+    type_register_static(&max78000_trng_info);
+}
+
+type_init(max78000_trng_register_types)
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 283d06dad4..c7c57d924b 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -72,6 +72,7 @@ system_ss.add(when: 'CONFIG_IMX', if_true: files(
 ))
 system_ss.add(when: 'CONFIG_MAX78000_GCR', if_true: files('max78000_gcr.c'))
 system_ss.add(when: 'CONFIG_MAX78000_ICC', if_true: files('max78000_icc.c'))
+system_ss.add(when: 'CONFIG_MAX78000_TRNG', if_true: files('max78000_trng.c'))
 system_ss.add(when: 'CONFIG_NPCM7XX', if_true: files(
   'npcm_clk.c',
   'npcm_gcr.c',
diff --git a/include/hw/misc/max78000_gcr.h b/include/hw/misc/max78000_gcr.h
index f04c8a3ee7..23ddf0885b 100644
--- a/include/hw/misc/max78000_gcr.h
+++ b/include/hw/misc/max78000_gcr.h
@@ -123,6 +123,7 @@ struct Max78000GcrState {
     DeviceState *uart0;
     DeviceState *uart1;
     DeviceState *uart2;
+    DeviceState *trng;
 
 };
 
diff --git a/include/hw/misc/max78000_trng.h b/include/hw/misc/max78000_trng.h
new file mode 100644
index 0000000000..c5a8129b6a
--- /dev/null
+++ b/include/hw/misc/max78000_trng.h
@@ -0,0 +1,35 @@
+/*
+ * MAX78000 True Random Number Generator
+ *
+ * Copyright (c) 2025 Jackson Donaldson <jcksn@duck.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#ifndef HW_MAX78000_TRNG_H
+#define HW_MAX78000_TRNG_H
+
+#include "hw/sysbus.h"
+#include "qom/object.h"
+
+#define TYPE_MAX78000_TRNG "max78000-trng"
+OBJECT_DECLARE_SIMPLE_TYPE(Max78000TrngState, MAX78000_TRNG)
+
+#define CTRL 0
+#define STATUS 4
+#define DATA 8
+
+#define RND_IE (1 << 1)
+
+struct Max78000TrngState {
+    SysBusDevice parent_obj;
+
+    MemoryRegion mmio;
+
+    uint32_t ctrl;
+    uint32_t status;
+    uint32_t data;
+
+    qemu_irq irq;
+};
+
+#endif
-- 
2.34.1


