Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 750D6E77183
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 23:35:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMF9N-0004Sw-NK; Fri, 13 Dec 2024 18:32:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tMF93-0003us-T8
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 18:32:33 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tMF91-000381-HH
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 18:32:29 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-436202dd730so16559415e9.2
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 15:32:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734132745; x=1734737545; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a3TtnTiO9UzBRUmGvf6bhUHZ7y2QwBk8czB0sZAw/do=;
 b=KXFgtcybdfezlfy5dRt7cnXcThG2woWVuUIKnmQLprhA3nX6opoJnOg6J17PB6EUBP
 ORaAaLumpUGqGyquhh8LktSTZLRKYmzcdXTzCkwU8Son7OS2nmazchMqi7KCufJXPNSB
 Yt5oui2JULdIPoGHdUZ3/Ra7v2OFJr5Ift2gRPPI9zjehEKbTIwdcY4O/UDpM96iGtBC
 8jhDS+DzYqVoLfyBywFo/yTenSHhiRZg++lkzYbTS481dgFGEK47mnJk4A+8D3KKDpI1
 vV11OThlNa0zxcek+n+fIl8Mq1giQzm8ow+nsGJENDw2zkMFuxpahA6S6TC+hImgCT1I
 iqTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734132745; x=1734737545;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a3TtnTiO9UzBRUmGvf6bhUHZ7y2QwBk8czB0sZAw/do=;
 b=vYF0+3nVy4g/77fq1ow7gjzI/4wUS4V4egnjNb9pJ6rag+QSIHJHNAmpvDlvLYn0uu
 dnDhvoOazYH7iHpT8kS/yJ4WYeFHYrFTUOhodIVcvk2h1fKARnIzF1VXHuH8kdGiwVjD
 /YJcPwcoWvA0TMI8Gka+cVXVMJniCYuoOG7G8Tyh80QFMLu/WMqTMlZOkmWBz1PHqb6a
 afaWCwrSog+Utszn8hhlCu4ChpR4IsJ9rPqJs0/Cbu3QkvfE7RccRmQMjK6aEn5/x9+F
 kXRAwy2OiSGU71UOZJs6CJGYXa+waMAARlUAWMMXEJyEwr8bmjmuDBIbYGOeo9bWxmrj
 jWLQ==
X-Gm-Message-State: AOJu0YyGlQ/qUEgLj2nP7EAcyHcFZzfK9371gQ+PPCb5e+zmW7nHgJRa
 4vpCtQyHE/iAQaIb6yvMwBh4iBBnLFmK5n3RNAk0FC7kWfKwKhoHcd7c0pq9rt9EgO3LBObhPfX
 DHDw=
X-Gm-Gg: ASbGnctBlnCB5c7LtE6LA8sn6tv+EUbXCpGThCClFdcPz0Wgj2NchaGJZhOYK31Fbsv
 tA8zd6cU4NC6o2iLy+yP92kI0VlWbLf4J10Y1ISWsfy2SGMfkVl2Y68zgDQDxsJEXjxg1fNbIZ/
 KOJT1L0I9fSs2yHBUgcBuCwmKfOx7vVWdfzun6KbEJEFe7lYtbKF9zW47/BW+xRMSPirXVFUjkK
 nsTOdVan+uQHcIylWraaUeN5O2SQgawrC21fKGTILDvqb0wYnQff2F1A67yWAv2QNhkueJUqY4C
 elE/HA==
X-Google-Smtp-Source: AGHT+IFLTaIoPuBlUHMXG89W9bEFd5FgiEdXf6f5G7N+vppsxPfOdbXtlxw+55kx/7hZug8KZ4FZOg==
X-Received: by 2002:a05:600c:cc9:b0:434:fec5:4ef5 with SMTP id
 5b1f17b1804b1-4362aa43bcbmr43962645e9.14.1734132745363; 
 Fri, 13 Dec 2024 15:32:25 -0800 (PST)
Received: from localhost.localdomain ([45.93.146.194])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436255531b1sm64714755e9.2.2024.12.13.15.32.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 13 Dec 2024 15:32:23 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 17/20] hw/ide/ahci: Extract TYPE_SYSBUS_AHCI into dedicated file
Date: Sat, 14 Dec 2024 00:30:52 +0100
Message-ID: <20241213233055.39574-18-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241213233055.39574-1-philmd@linaro.org>
References: <20241213233055.39574-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Bernhard Beschow <shentey@gmail.com>

Implement in dedicated file, just like TYPE_ICH9_AHCI.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20241212110926.23548-3-shentey@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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
index 00000000000..d43db0923f1
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
index 5836aa924bb..c02357735ed 100644
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
index 1b25e73578e..e779b5af958 100644
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
index 2e22b677da3..b55507b836e 100644
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
index 90ea8614233..ddd70660400 100644
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
2.45.2


