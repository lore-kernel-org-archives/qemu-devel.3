Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA1A9C83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 16:58:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXjjJ-000727-DW; Fri, 04 Jul 2025 12:57:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jackson88044@gmail.com>)
 id 1uXjjI-0006ys-AK
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:57:40 -0400
Received: from mail-qk1-x732.google.com ([2607:f8b0:4864:20::732])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jackson88044@gmail.com>)
 id 1uXjjG-0000PE-Bq
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:57:40 -0400
Received: by mail-qk1-x732.google.com with SMTP id
 af79cd13be357-7c5b8d13f73so116350585a.0
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 09:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751648257; x=1752253057; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GY7MJBZ+jVGFNfvqDhRAHNzOKhw8Qpr4ty2QBdtSrdE=;
 b=BL2/GGOVaiKZOprZ/Vc2rZzSHngwwNMeuET99JpxGZE7H5bKXma1YL7fq/u4JnzXv8
 iKDzoExhF+mD8s+ytdkerNB7sUwj7foGt94cCKLi7r4Jhwxa6/6mE3ieqBPAakfkxMns
 +YlZVOi45hWm6xVO5Zul+L59LwslxTHnH4YdmhbyGDipZU5RvMCsnXjGjaMmh20NW3rd
 +Vd45O1CvRgV+bbuqhC+Dz/T1P6Jtzb7+8mX0Z2amj4yDs1hRMmaPc8SXxpfSO2AGJQR
 szfL3k4SFAqu2A+ao/wkZ2y/wi0fARgtmIl6QRAvBh1rjjbmIKsODDpG1SKXh8YO7jnP
 iLjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751648257; x=1752253057;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GY7MJBZ+jVGFNfvqDhRAHNzOKhw8Qpr4ty2QBdtSrdE=;
 b=M9lYQR0wd5xO7c6lSzKkaa+2T1j3gVIeC+OFBjfTITannLMNOcLerspmzUC7TrZ6DF
 lHN3nihAsvHu/o5F7C2FoTsE3fFF+M2tg51t/zhbMKA8MD6aKdYyO/ahvLuCmP2+eDXQ
 eao18SXFrPUbtjBIRHNidurvJSa29l7FCW8ouKoQ0uRhc5VcCT4sp1WP9hEgpuyw0Qkt
 YnPXoJ85ybo2zSlRlI5S033KlGT5HWlm9IMVrImr7NulYd4iR+/A6AAKf/mD07x3xml5
 7YSwBduu1Of5CpMhU3Iz3D3zeJwMCOrcj0ro6Mr/KptZsHaZHS1bzxSHvABuo79vgK2m
 o2IA==
X-Gm-Message-State: AOJu0YzGnpWvs5+LXmP2ceXuJ3Aj+VQoxcd2ai7wcm0F72AHyUrJaHyL
 Om3eChEJeeKNAq5Frw7oA56ktc7dm6c5dDAeAUswSp9QhYwv4TuXUg3H38JjKQ==
X-Gm-Gg: ASbGnctOxvSWc4sol/JryMBnsoYfeMnajKku0TqMWBJGho7+m6n2qqeXMKFNq8cs09D
 GTztgNjaIzpjQ6NdYlU0p0LQyw0/2bwOiry1G2Fg+GaYxDXbDf1I9H4NiAyPkFZVERFo2kGoyJb
 +4VJiYKL3Pnw+0JQSPgMJVI1TJiFqXbwJoTt/VQMbw2ceW2OpwGZKN3Oxk5vyyPlna8iXvhCb+L
 kTXSCI9fZW3LL96dsQfil7pu2gtX0YS6j0mAgfzwnzfRP1usPplrTfQNruJJIcDFKPEgJSb3F3Z
 SbIZnqGzOuHhbZcO1t6tGchUNH8zD7y9MB5jIAPW1m36piLI1313j3aTzwutksOfWNEtJW5oN2K
 9Ln9i
X-Google-Smtp-Source: AGHT+IEWwT51sLRg2hCyfFN+d9oR89PiAj5gqRRuHu0fhhvBVSj5Tp8UgNoAHsAcmQgxtR8fWeZtJQ==
X-Received: by 2002:a05:620a:1929:b0:7d4:4b09:e326 with SMTP id
 af79cd13be357-7d5df152b2bmr356790785a.30.1751648256851; 
 Fri, 04 Jul 2025 09:57:36 -0700 (PDT)
Received: from user-jcksn.myfiosgateway.com
 ([2600:4040:2bcd:3800:e3f4:4cee:828f:52d])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-702c4ccc6easm15345826d6.26.2025.07.04.09.57.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 09:57:36 -0700 (PDT)
From: Jackson Donaldson <jackson88044@gmail.com>
X-Google-Original-From: Jackson Donaldson <jcksn@duck.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v3 08/11] MAX78000: TRNG Implementation
Date: Fri,  4 Jul 2025 12:57:26 -0400
Message-Id: <20250704165729.208381-9-jcksn@duck.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250704165729.208381-1-jcksn@duck.com>
References: <20250704165729.208381-1-jcksn@duck.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::732;
 envelope-from=jackson88044@gmail.com; helo=mail-qk1-x732.google.com
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

This commit implements the True Random Number
Generator for the MAX78000

Signed-off-by: Jackson Donaldson <jcksn@duck.com>
---
 hw/arm/Kconfig                  |   1 +
 hw/misc/Kconfig                 |   3 +
 hw/misc/max78000_gcr.c          |   6 ++
 hw/misc/max78000_trng.c         | 139 ++++++++++++++++++++++++++++++++
 hw/misc/meson.build             |   1 +
 include/hw/misc/max78000_gcr.h  |   1 +
 include/hw/misc/max78000_trng.h |  35 ++++++++
 7 files changed, 186 insertions(+)
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
index 0000000000..ecdaef53b6
--- /dev/null
+++ b/hw/misc/max78000_trng.c
@@ -0,0 +1,139 @@
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
+        /*
+         * When interrupts are enabled, reading random data should cause a
+         * new interrupt to be generated; since there's always a random number
+         * available, we could qemu_set_irq(s->irq, s->ctrl & RND_IE). Because
+         * of how trng_write is set up, this is always a noop, so don't
+         */
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
+
+        /*
+         * This device models random number generation as taking 0 time.
+         * A new random number is always available, so the condition for the
+         * RND interrupt is always fulfilled; we can just set irq to 1.
+         */
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


