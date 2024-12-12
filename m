Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D1F3E77180
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 11:10:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLh4n-0003Cq-Ff; Thu, 12 Dec 2024 06:09:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tLh4k-0003Ak-Cv; Thu, 12 Dec 2024 06:09:46 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tLh4i-0004Lo-6W; Thu, 12 Dec 2024 06:09:46 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-435004228c0so5271785e9.0; 
 Thu, 12 Dec 2024 03:09:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734001781; x=1734606581; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NYE8ly36JdIRhjdDqnewOgIWaw9/py5eadl9lzg2NvA=;
 b=Q2lFe5PMPwRxE6cSyuHIFLSPDCZyy6YqxSvxCI3AuYay6/SVArG/OWrwEMmP0lmO1f
 Yard3qtTM2itWo2N0Ff2tnXoFjugwWi0ewklGjjI4RHL/1a7qqiKArGBwUPD3SwUkqfG
 ecDfJI3hwec8MynpH4D5cDfvnXT2oYSI5cMsRhvYqVnrPy8D0Os67B8YUNpayj+KR1m/
 7DbncBegVxexsYZdbLrf2CgZdT+EPnhhaJDqJ6NWdyN+CPSoL6CiOKnnGvjekBY1FJXO
 dWjQJYUqX74Wk9OPRhhR/QhkRSSNNWWKqXFLroz8sHFphfXdxu5eTPFc0zm6EiU6EJ/Y
 qUfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734001781; x=1734606581;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NYE8ly36JdIRhjdDqnewOgIWaw9/py5eadl9lzg2NvA=;
 b=SNUJNFgMQ3QVo4QshJOTSZ/gSvh7JLu5a8/MFfEZEFiR2LUhhaX1fqPpNwEGsqg+71
 aNwja791hpR9HvtI13AQPJjOMrHiZEZ1g0shER7gMk6Pw8r5an8UUpAny4u9nW/vy42k
 cU88Nz1kbigPdAHMusrSk33DDIU+fI/qIC4ntbrqLS72kdDgql2F3xNuzUod6xwRlyeX
 Bv3PsJ6+EtQjlzuzEfQXj6ONAoZSqCDT+1qEurymplEMy6WI6+pUZhg11H5PCQ7HOq/W
 bUN60BqUbY5YfgUkI/LDrU2j9KkhBsan97wWamWvOuc1tQKKJA+10T/YuIKBKln0U7I5
 E7ew==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7Otsy3LNfGwINeyAfmNAGnbJIetaqUKJ/HiFtmDoAmgPV9G2/FjWkrGNGAdkanzwMOsOfN1Am3w==@nongnu.org,
 AJvYcCXZUf2fVc2C3ImeIscblAQkfyjoS7LR8sCoRAcMJrWpWNN6H3nYrVlolF36eC6yrX0pX0bkKIXaYk+GpA==@nongnu.org
X-Gm-Message-State: AOJu0YzNBJDU8NbLFhokRaREr6CJTtMC/ztj+uj8VvOwfoYcMLYbZjjI
 lHBvAlkzsa8XL+b/jAMnv+mALuT2rZf475UcPRlI+Bi7vJoYlQdQYdogPw==
X-Gm-Gg: ASbGnctgbl65xvgezXlV/CCAMESnoxcuyy4dWavnC1t1PeQA56Ut0Fpzyz42qVBzm5t
 jq2Mlzmc7jQwS8tAUjX0+vc9T/Ea0p5Cn7RivLiQpAnSWSz6xCgq6mnXzB2RysRhCv3bkt762tH
 1ghYfcxv2a+TzAG03yxEa6d6xga8HnTessxyGN4bTBpBcKscAsx4v3JGUNqU77Lsoctoy1+vaHv
 Bkun9TkWLxTniWl9eFh6jomYJDT/IRh1jd2j72HqG0+qViUX7trkIwqYo5lKMgakAMDHKjMbBZJ
 V5tqMmo19gD2c4OKRatMKwO5itySVTPcu9rN89OzgEw=
X-Google-Smtp-Source: AGHT+IEyvtk3pP3e4v3tgGC+VRPafLfZUqugVBubq3zLMjJNODEa39coC7s5vjH8jOgIX4Xd50D85w==
X-Received: by 2002:a05:600c:4f13:b0:434:ff45:cbbe with SMTP id
 5b1f17b1804b1-4361c3c7df9mr57832985e9.18.1734001781062; 
 Thu, 12 Dec 2024 03:09:41 -0800 (PST)
Received: from Provence.localdomain
 (dynamic-077-011-242-029.77.11.pool.telefonica.de. [77.11.242.29])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4362559ebe1sm13200725e9.19.2024.12.12.03.09.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Dec 2024 03:09:40 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-block@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Peter Xu <peterx@redhat.com>, qemu-arm@nongnu.org,
 John Snow <jsnow@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v4 2/2] hw/ide/ahci: Extract TYPE_SYSBUS_AHCI into dedicated
 file
Date: Thu, 12 Dec 2024 12:09:26 +0100
Message-ID: <20241212110926.23548-3-shentey@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212110926.23548-1-shentey@gmail.com>
References: <20241212110926.23548-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x333.google.com
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


