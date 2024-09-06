Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B8EFCE7B02
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 12:28:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smY2V-0001Yu-Ty; Fri, 06 Sep 2024 08:26:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1smY2J-0000o4-SR; Fri, 06 Sep 2024 08:26:01 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1smY2H-00023m-Kx; Fri, 06 Sep 2024 08:25:59 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-718d79fb6f7so564817b3a.3; 
 Fri, 06 Sep 2024 05:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725625555; x=1726230355; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GbQ46H6zsgGVOuoM37E/78s+2ytMVMhlJsHBTOeVrp8=;
 b=OZcFcs9uS+yImDhsBr9FzzAo+TB39qfQh+06nFjoFOsSx/W1RTSxdckjTVcHcXCnnq
 btBWLi5EfRbXKWJSAZzuVICAzbpY5eY0BXojyXVOQAbhFZEStflw3Xju1sK3kOrnQyFC
 ebqu98jYx2KNO9RU0142ZzXzhL0h9fyFwPFTvhTMqeZgSwVoUiWi+vnPcfEqYTQGXlL4
 B2aWCFwauMUy9xQsDs1AVUFMyV6u5Aq1Qu/q3zB71VwhvBPGr8qbWeCgK5XxPwUoMq2Q
 kMiJwYQjMf5cBpbTvqBEAGXybOzxbCllfl4Dl4Ti2z8j7eViGm2ehzcrRZTEcRJNegKJ
 4+Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725625555; x=1726230355;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GbQ46H6zsgGVOuoM37E/78s+2ytMVMhlJsHBTOeVrp8=;
 b=qdnyNiTo6VJqTGmebRLSS9lnany35/8wxxgq75wqT00sdBI1kPA1tgxYwC5Z2aM7SN
 BoxbShOxFMEU6413/g9lLmcvtty+mkzdE4TfuaJhp5Vf5dci+6DxHqHY1ZDhxQp9gT+2
 27rpEXvXeIxLQSH1qS2G3F2XGNwvtgo0TdJbAgccf9aTkcjq8RjFFo8RDDdrzlS4dd2i
 c2QrxOaNYVnpgurygBuol8a8/+hC3me+VvUDIai9ZH7/Rc/6NBGcrJo0NTMsMr77gjuR
 kXwfiYpPiEgctZTkAtuXCeQdpIDaIs4RlnehwAnc2hAwQHc53VOToEIbcANoCfviq1Jc
 1f/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXW05sPwQhE99IOXjT3AO2lVayBOyP/q3EGqNEeQF4k0XJTcXnVp+eMBdfUph5FV6MrFVRQ0j2DIg==@nongnu.org
X-Gm-Message-State: AOJu0YxaRPcuMVhOlkJes7WabmAWq1e44/Xv1Ze3oBIrLG9O2ieS8aYx
 ntxkm0vS5fi7E7XmsAh6cNe1x1WoC7H2BX4AeczIP1W4pBjKzwZ9DdFVFw==
X-Google-Smtp-Source: AGHT+IFZILNMHRc2Hn3IeRNT4SC27kJrha7ZVbbZ5Q7cPNsvtLzshWu2OuZlVJyPO/xp4YwLnMpMzg==
X-Received: by 2002:a05:6a00:9194:b0:717:8dd1:c309 with SMTP id
 d2e1a72fcca58-718d5e1d033mr2413268b3a.9.1725625555302; 
 Fri, 06 Sep 2024 05:25:55 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7d50f75678bsm2066515a12.22.2024.09.06.05.25.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Sep 2024 05:25:54 -0700 (PDT)
From: Guenter Roeck <linux@roeck-us.net>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, BALATON Zoltan <balaton@eik.bme.hu>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Guenter Roeck <linux@roeck-us.net>
Subject: [RFC PATCH 5/8] usb/uhci: Add support for usb-uhci-sysbus
Date: Fri,  6 Sep 2024 05:25:39 -0700
Message-ID: <20240906122542.3808997-6-linux@roeck-us.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240906122542.3808997-1-linux@roeck-us.net>
References: <20240906122542.3808997-1-linux@roeck-us.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=groeck7@gmail.com; helo=mail-pf1-x42b.google.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 hw/arm/Kconfig           |   1 +
 hw/usb/Kconfig           |   4 ++
 hw/usb/hcd-uhci-sysbus.c | 100 +++++++++++++++++++++++++++++++++++++++
 hw/usb/hcd-uhci-sysbus.h |  23 +++++++++
 hw/usb/meson.build       |   1 +
 5 files changed, 129 insertions(+)
 create mode 100644 hw/usb/hcd-uhci-sysbus.c
 create mode 100644 hw/usb/hcd-uhci-sysbus.h

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 1ad60da7aa..8b1253fae5 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -606,6 +606,7 @@ config ASPEED_SOC
     select PMBUS
     select MAX31785
     select FSI_APB2OPB_ASPEED
+    select USB_UHCI_SYSBUS
 
 config MPS2
     bool
diff --git a/hw/usb/Kconfig b/hw/usb/Kconfig
index 7d034738ce..fe5375050c 100644
--- a/hw/usb/Kconfig
+++ b/hw/usb/Kconfig
@@ -11,6 +11,10 @@ config USB_UHCI_PCI
     depends on PCI
     select USB_UHCI
 
+config USB_UHCI_SYSBUS
+    bool
+    select USB_UHCI
+
 config USB_OHCI
     bool
     select USB
diff --git a/hw/usb/hcd-uhci-sysbus.c b/hw/usb/hcd-uhci-sysbus.c
new file mode 100644
index 0000000000..6f2428cc15
--- /dev/null
+++ b/hw/usb/hcd-uhci-sysbus.c
@@ -0,0 +1,100 @@
+/*
+ * QEMU USB UHCI Emulation
+ * Copyright (c) 2006 Openedhand Ltd.
+ * Copyright (c) 2010 CodeSourcery
+ * Copyright (c) 2024 Red Hat, Inc.
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
+ */
+
+#include "qemu/osdep.h"
+#include "hw/irq.h"
+#include "qapi/error.h"
+#include "qemu/module.h"
+#include "qemu/timer.h"
+#include "hw/usb.h"
+#include "migration/vmstate.h"
+#include "hw/sysbus.h"
+#include "hw/qdev-dma.h"
+#include "hw/qdev-properties.h"
+#include "trace.h"
+#include "hcd-uhci.h"
+#include "hcd-uhci-sysbus.h"
+
+static void uhci_sysbus_reset(UHCIState *uhci)
+{
+    uhci_state_reset(uhci);
+}
+
+static void uhci_sysbus_realize(DeviceState *dev, Error **errp)
+{
+    UHCISysBusState *s = SYSBUS_UHCI(dev);
+    UHCIState *uhci = &s->uhci;
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
+    Error *err = NULL;
+
+    uhci->masterbus = s->masterbus;
+    uhci->firstport = s->firstport;
+    uhci->maxframes = s->maxframes;
+    uhci->frame_bandwidth = s->frame_bandwidth;
+    uhci->as = &address_space_memory;
+    uhci->uhci_reset = uhci_sysbus_reset;
+
+    usb_uhci_init(uhci, dev, &err);
+
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+    sysbus_init_irq(sbd, &uhci->irq);
+    sysbus_init_mmio(sbd, &uhci->mem);
+}
+
+static void uhci_sysbus_reset_sysbus(DeviceState *dev)
+{
+    UHCISysBusState *s = SYSBUS_UHCI(dev);
+    UHCIState *uhci = &s->uhci;
+
+    uhci_sysbus_reset(uhci);
+}
+
+static Property uhci_sysbus_properties[] = {
+    DEFINE_PROP_STRING("masterbus", UHCISysBusState, masterbus),
+    DEFINE_PROP_UINT32("firstport", UHCISysBusState, firstport, 0),
+    DEFINE_PROP_UINT32("bandwidth", UHCISysBusState, frame_bandwidth, 1280),
+    DEFINE_PROP_UINT32("maxframes", UHCISysBusState, maxframes, 128),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void uhci_sysbus_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->realize = uhci_sysbus_realize;
+    set_bit(DEVICE_CATEGORY_USB, dc->categories);
+    dc->desc = "UHCI USB Controller";
+    device_class_set_props(dc, uhci_sysbus_properties);
+    dc->reset = uhci_sysbus_reset_sysbus;
+}
+
+static const TypeInfo uhci_sysbus_types[] = {
+    {
+        .name          = TYPE_SYSBUS_UHCI,
+        .parent        = TYPE_SYS_BUS_DEVICE,
+        .instance_size = sizeof(UHCISysBusState),
+        .class_init    = uhci_sysbus_class_init,
+    },
+};
+
+DEFINE_TYPES(uhci_sysbus_types);
diff --git a/hw/usb/hcd-uhci-sysbus.h b/hw/usb/hcd-uhci-sysbus.h
new file mode 100644
index 0000000000..c491b9fc92
--- /dev/null
+++ b/hw/usb/hcd-uhci-sysbus.h
@@ -0,0 +1,23 @@
+#ifndef HW_USB_HCD_UHCI_SYSBUS_H
+#define HW_USB_HCD_UHCI_SYSBUS_H
+
+#include "hcd-uhci.h"
+
+#define TYPE_SYSBUS_UHCI "sysbus-uhci"
+
+OBJECT_DECLARE_SIMPLE_TYPE(UHCISysBusState, SYSBUS_UHCI)
+
+struct UHCISysBusState {
+    /*< private >*/
+    SysBusDevice parent_obj;
+    /*< public >*/
+    UHCIState uhci;
+
+    char *masterbus;
+    uint32_t firstport;
+    uint32_t frame_bandwidth;
+    uint32_t maxframes;
+    uint32_t num_ports;
+};
+
+#endif /* HW_USB_HCD_UHCI_SYSBUS_H */
diff --git a/hw/usb/meson.build b/hw/usb/meson.build
index a41b54ac02..b0dd4b5169 100644
--- a/hw/usb/meson.build
+++ b/hw/usb/meson.build
@@ -14,6 +14,7 @@ system_ss.add(when: 'CONFIG_USB', if_true: files(
 # usb host adapters
 system_ss.add(when: 'CONFIG_USB_UHCI', if_true: files('hcd-uhci.c'))
 system_ss.add(when: 'CONFIG_USB_UHCI_PCI', if_true: files('hcd-uhci-pci.c'))
+system_ss.add(when: 'CONFIG_USB_UHCI_SYSBUS', if_true: files('hcd-uhci-sysbus.c'))
 system_ss.add(when: 'CONFIG_USB_OHCI', if_true: files('hcd-ohci.c'))
 system_ss.add(when: 'CONFIG_USB_OHCI_PCI', if_true: files('hcd-ohci-pci.c'))
 system_ss.add(when: 'CONFIG_USB_OHCI_SYSBUS', if_true: files('hcd-ohci-sysbus.c'))
-- 
2.45.2


