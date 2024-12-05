Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DD4EE7716C
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 13:21:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJBmK-0005w8-Hc; Thu, 05 Dec 2024 08:20:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tJBmG-0005pL-Ut; Thu, 05 Dec 2024 08:20:22 -0500
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tJBmB-0002R4-56; Thu, 05 Dec 2024 08:20:19 -0500
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a9a977d6cc7so125944766b.3; 
 Thu, 05 Dec 2024 05:20:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733404809; x=1734009609; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NYE8ly36JdIRhjdDqnewOgIWaw9/py5eadl9lzg2NvA=;
 b=lQDZoYpH3hhjN9a6CLJdi00QOfICWqpDZhkYdnefQAWizXpD1X5qXcZd7HRYEYHQ7g
 MmgS1JvjbTrL32xb16uvhigdKcH0SymnNk0yvriYaeWOxXc7hMVmnygAqCGHjzRJ7cu5
 kdbUUfWsy06a+sPSZ0cBP1QvpwV8o4rJpmdV9jqx5Ptm2AyJtgi6jR90Qqn5KgQTG0eM
 of2o6crX62rrUoTLHeaW603HimzvOKsaKdVn73H16T/jfx/fhhAoPSCF7nfrZOBuu0L2
 /z9W50xOsoedIFYkLy02lPSG3yII6R4YZVxH1ScHq5vlIP0z9kO4r7zkX6248juUEEqJ
 ohhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733404809; x=1734009609;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NYE8ly36JdIRhjdDqnewOgIWaw9/py5eadl9lzg2NvA=;
 b=IkCm2QPdX4yrxcQTmuyGh4nn8LPq3Ymd3cAZYPvL6IihJSjcVne5xhRTNIbYA6HAdT
 ZRw01lBncxAtZ3rdr3NRgPjREB1PuTPgpSfw5VS6NvlGbKh9S/v5SlijYB+7bvZXHhMt
 u8J+FA/hKDh+0uTQ0oDd7BNOYUJu5ROiEnHylRCfDPc2hZyE8ZfiY0xvaTHP99qzrqLn
 d/q0U2wP10SMBF2/02v4B/rJSazXd1tIR0FH8kQgiQFtBH7TvvLK5VlANNTU3Oiq7cKr
 3PHZlmataqhDJJ2DmvSlGqT6LhPqZJn9tZ8rmgkjiV1K3D4UjDArTGI3pUScgBjIc2At
 VUnw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUd+TaHG5HVX4vBht4aHMGeG+djJntivxayDm1ECfXyS2rMGst9adYEAX7TqDklL9/hJMICsNBmog==@nongnu.org,
 AJvYcCW5k++c6LxdZe6CaSVvaeAaPrARaBvjRLpOdivCWko5w0Y2pGrucMIxyXd9wRo3JBbGFYatV1POi5KCbQ==@nongnu.org
X-Gm-Message-State: AOJu0YyOk/bkHmx1x1VQVr5hXJ+LQvaTHCP0Io3ljW4q7W+XvfrDoidh
 mSRYxkhEZ02ETF2ohLcAqUIInp6HH3pYcQsHjlF7mjP8BspnNx9hZ4I9TQ==
X-Gm-Gg: ASbGncu57ZMBwiKC1op9bDQEQZxrqlgMzz8+Engtx2Ref1/kbW5+7lH8waipXLC9qJy
 hLF578UJRJwVuaMp7G3S24ftJNA80qXtMrJj8pCIHNBkWuGPl87vwIFYEb33GjB2TtJxZWs5wG1
 xIosntbAc+9UOp+IZI7Q/R+apx/HIkKZIz8SJGasOMtoh1p005Z2ZPMxmfeEiGB+Ncb6QSMQl+1
 jUjKQxSKUx9Z/gsmSaavpGrbTj9FOBOL/Mai63Ox0xihOex4vzwkTlnkddJpfMT4+LccGPO17Gd
 35jSnTRT1uUtowNhBbtOj1ZqHvpI1jZOV5Y=
X-Google-Smtp-Source: AGHT+IERdSqJngbOC2eA+yOhXWguQrpdDfrdTjyZki9aWAT1RvIquwoU27U60g97qjz7RceYrT1Luw==
X-Received: by 2002:a05:6402:4021:b0:5d2:7396:b0ed with SMTP id
 4fb4d7f45d1cf-5d27396b1ccmr3440341a12.14.1733404808732; 
 Thu, 05 Dec 2024 05:20:08 -0800 (PST)
Received: from Provence.localdomain
 (dynamic-078-054-030-063.78.54.pool.telefonica.de. [78.54.30.63])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa625e92a58sm91959066b.48.2024.12.05.05.20.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Dec 2024 05:20:08 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 qemu-block@nongnu.org, Peter Xu <peterx@redhat.com>,
 John Snow <jsnow@redhat.com>, Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v3 2/2] hw/ide/ahci: Extract TYPE_SYSBUS_AHCI into dedicated
 file
Date: Thu,  5 Dec 2024 14:19:37 +0100
Message-ID: <20241205131937.32833-3-shentey@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241205131937.32833-1-shentey@gmail.com>
References: <20241205131937.32833-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Implement in dedicated file, just like TYPE_ICH9_AHCI.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/ide/ahci-sysbus.c | 91 ++++++++++++++++++++++++++++++++++++++++++++
 hw/ide/ahci.c        | 67 --------------------------------
 hw/arm/Kconfig       | 10 ++---
 hw/ide/Kconfig       |  4 ++
 hw/ide/meson.build   |  1 +
 5 files changed, 101 insertions(+), 72 deletions(-)
 create mode 100644 hw/ide/ahci-sysbus.c

diff --git a/hw/ide/ahci-sysbus.c b/hw/ide/ahci-sysbus.c
new file mode 100644
index 0000000000..d43db0923f
--- /dev/null
+++ b/hw/ide/ahci-sysbus.c
@@ -0,0 +1,91 @@
+/*
+ * QEMU AHCI Emulation (MMIO-mapped devices)
+ *
+ * Copyright (c) 2010 qiaochong@loongson.cn
+ * Copyright (c) 2010 Roland Elek <elek.roland@gmail.com>
+ * Copyright (c) 2010 Sebastian Herbszt <herbszt@gmx.de>
+ * Copyright (c) 2010 Alexander Graf <agraf@suse.de>
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.1 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "exec/address-spaces.h"
+#include "hw/qdev-properties.h"
+#include "migration/vmstate.h"
+
+#include "hw/ide/ahci-sysbus.h"
+#include "ahci-internal.h"
+
+static const VMStateDescription vmstate_sysbus_ahci = {
+    .name = "sysbus-ahci",
+    .fields = (const VMStateField[]) {
+        VMSTATE_AHCI(ahci, SysbusAHCIState),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
+static void sysbus_ahci_reset(DeviceState *dev)
+{
+    SysbusAHCIState *s = SYSBUS_AHCI(dev);
+
+    ahci_reset(&s->ahci);
+}
+
+static void sysbus_ahci_init(Object *obj)
+{
+    SysbusAHCIState *s = SYSBUS_AHCI(obj);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
+
+    ahci_init(&s->ahci, DEVICE(obj));
+
+    sysbus_init_mmio(sbd, &s->ahci.mem);
+    sysbus_init_irq(sbd, &s->ahci.irq);
+}
+
+static void sysbus_ahci_realize(DeviceState *dev, Error **errp)
+{
+    SysbusAHCIState *s = SYSBUS_AHCI(dev);
+
+    ahci_realize(&s->ahci, dev, &address_space_memory);
+}
+
+static Property sysbus_ahci_properties[] = {
+    DEFINE_PROP_UINT32("num-ports", SysbusAHCIState, ahci.ports, 1),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void sysbus_ahci_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->realize = sysbus_ahci_realize;
+    dc->vmsd = &vmstate_sysbus_ahci;
+    device_class_set_props(dc, sysbus_ahci_properties);
+    device_class_set_legacy_reset(dc, sysbus_ahci_reset);
+    set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
+}
+
+static const TypeInfo sysbus_ahci_types[] = {
+    {
+        .name          = TYPE_SYSBUS_AHCI,
+        .parent        = TYPE_SYS_BUS_DEVICE,
+        .instance_size = sizeof(SysbusAHCIState),
+        .instance_init = sysbus_ahci_init,
+        .class_init    = sysbus_ahci_class_init,
+    },
+};
+
+DEFINE_TYPES(sysbus_ahci_types)
diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index 5836aa924b..c02357735e 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -23,16 +23,13 @@
 
 #include "qemu/osdep.h"
 #include "hw/irq.h"
-#include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
 
 #include "qemu/error-report.h"
 #include "qemu/log.h"
 #include "qemu/main-loop.h"
-#include "qemu/module.h"
 #include "sysemu/block-backend.h"
 #include "sysemu/dma.h"
-#include "hw/ide/ahci-sysbus.h"
 #include "ahci-internal.h"
 #include "ide-internal.h"
 
@@ -1803,70 +1800,6 @@ const VMStateDescription vmstate_ahci = {
     },
 };
 
-static const VMStateDescription vmstate_sysbus_ahci = {
-    .name = "sysbus-ahci",
-    .fields = (const VMStateField[]) {
-        VMSTATE_AHCI(ahci, SysbusAHCIState),
-        VMSTATE_END_OF_LIST()
-    },
-};
-
-static void sysbus_ahci_reset(DeviceState *dev)
-{
-    SysbusAHCIState *s = SYSBUS_AHCI(dev);
-
-    ahci_reset(&s->ahci);
-}
-
-static void sysbus_ahci_init(Object *obj)
-{
-    SysbusAHCIState *s = SYSBUS_AHCI(obj);
-    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
-
-    ahci_init(&s->ahci, DEVICE(obj));
-
-    sysbus_init_mmio(sbd, &s->ahci.mem);
-    sysbus_init_irq(sbd, &s->ahci.irq);
-}
-
-static void sysbus_ahci_realize(DeviceState *dev, Error **errp)
-{
-    SysbusAHCIState *s = SYSBUS_AHCI(dev);
-
-    ahci_realize(&s->ahci, dev, &address_space_memory);
-}
-
-static Property sysbus_ahci_properties[] = {
-    DEFINE_PROP_UINT32("num-ports", SysbusAHCIState, ahci.ports, 1),
-    DEFINE_PROP_END_OF_LIST(),
-};
-
-static void sysbus_ahci_class_init(ObjectClass *klass, void *data)
-{
-    DeviceClass *dc = DEVICE_CLASS(klass);
-
-    dc->realize = sysbus_ahci_realize;
-    dc->vmsd = &vmstate_sysbus_ahci;
-    device_class_set_props(dc, sysbus_ahci_properties);
-    device_class_set_legacy_reset(dc, sysbus_ahci_reset);
-    set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
-}
-
-static const TypeInfo sysbus_ahci_info = {
-    .name          = TYPE_SYSBUS_AHCI,
-    .parent        = TYPE_SYS_BUS_DEVICE,
-    .instance_size = sizeof(SysbusAHCIState),
-    .instance_init = sysbus_ahci_init,
-    .class_init    = sysbus_ahci_class_init,
-};
-
-static void sysbus_ahci_register_types(void)
-{
-    type_register_static(&sysbus_ahci_info);
-}
-
-type_init(sysbus_ahci_register_types)
-
 void ahci_ide_create_devs(AHCIState *ahci, DriveInfo **hd)
 {
     int i;
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 1b25e73578..e779b5af95 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -71,7 +71,7 @@ config HIGHBANK
     depends on TCG && ARM
     select A9MPCORE
     select A15MPCORE
-    select AHCI
+    select AHCI_SYSBUS
     select ARM_TIMER # sp804
     select ARM_V7M
     select PL011 if !HAVE_RUST # UART
@@ -192,7 +192,7 @@ config SBSA_REF
     depends on TCG && AARCH64
     imply PCI_DEVICES
     select DEVICE_TREE
-    select AHCI
+    select AHCI_SYSBUS
     select ARM_SMMUV3
     select GPIO_KEY
     select PCI_EXPRESS
@@ -319,7 +319,7 @@ config ARM_V7M
 
 config ALLWINNER_A10
     bool
-    select AHCI
+    select AHCI_SYSBUS
     select ALLWINNER_A10_PIT
     select ALLWINNER_A10_PIC
     select ALLWINNER_A10_CCM
@@ -352,7 +352,7 @@ config ALLWINNER_H3
 config ALLWINNER_R40
     bool
     default y if TCG && ARM
-    select AHCI
+    select AHCI_SYSBUS
     select ALLWINNER_SRAMC
     select ALLWINNER_A10_PIT
     select ALLWINNER_WDT
@@ -422,7 +422,7 @@ config XLNX_ZYNQMP_ARM
     bool
     default y if PIXMAN
     depends on TCG && AARCH64
-    select AHCI
+    select AHCI_SYSBUS
     select ARM_GIC
     select CADENCE
     select CPU_CLUSTER
diff --git a/hw/ide/Kconfig b/hw/ide/Kconfig
index 2e22b677da..b55507b836 100644
--- a/hw/ide/Kconfig
+++ b/hw/ide/Kconfig
@@ -54,6 +54,10 @@ config AHCI_ICH9
     depends on PCI
     select AHCI
 
+config AHCI_SYSBUS
+    bool
+    select AHCI
+
 config IDE_SII3112
     bool
     select IDE_PCI
diff --git a/hw/ide/meson.build b/hw/ide/meson.build
index 90ea861423..ddd7066040 100644
--- a/hw/ide/meson.build
+++ b/hw/ide/meson.build
@@ -1,5 +1,6 @@
 system_ss.add(when: 'CONFIG_AHCI', if_true: files('ahci.c'))
 system_ss.add(when: 'CONFIG_AHCI_ICH9', if_true: files('ich.c'))
+system_ss.add(when: 'CONFIG_AHCI_SYSBUS', if_true: files('ahci-sysbus.c'))
 system_ss.add(when: 'CONFIG_ALLWINNER_A10', if_true: files('ahci-allwinner.c'))
 system_ss.add(when: 'CONFIG_IDE_BUS', if_true: files('ide-bus.c'))
 system_ss.add(when: 'CONFIG_IDE_CF', if_true: files('cf.c'))
-- 
2.47.1


