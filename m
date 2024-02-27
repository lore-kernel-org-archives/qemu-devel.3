Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B737C5478C
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 08:42:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ret2J-0000x4-1T; Tue, 27 Feb 2024 03:42:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ret25-00087Q-9n
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 03:41:49 -0500
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ret23-0008CH-2n
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 03:41:49 -0500
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a26fa294e56so677401966b.0
 for <qemu-devel@nongnu.org>; Tue, 27 Feb 2024 00:41:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709023304; x=1709628104; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lmW74QYufIRbTKyOkpXlvcTJBN9wQd/cfaQmVuqVO8w=;
 b=I2KHydPuyiDM6fM3+0GlkaBrRMuaSISIJAlZDkuPnrnTmdRXUbzPXQA1h/RxqqZQJz
 rh+Wsy0lXIFONeSjNAMNg/04Re7Ac9KHu0JqgSj3ojYA91Rvra05PETC4Urnhe2Lnq8I
 drmB0nubCZkn5JhzgaapC5Wgf9e7Le0yCnCFu5fa8XiiWAe5+t6K3B8UEpH+BGE3hIvx
 DeWbdMHSGrpgjW0EgsA35vveTTZDlz2jriifQCsGUadmL0FFJChmxn3twfmMX3TKAr/S
 StvF/uvlE7qtzHp3Qnf0eEG9gTmG6zp1aSSi7NB8TprOswjSMUQL7naf3P/r1qSzEJ3X
 MESg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709023304; x=1709628104;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lmW74QYufIRbTKyOkpXlvcTJBN9wQd/cfaQmVuqVO8w=;
 b=nZerJEbv+41Rbrl6teEtNNPEQIsfwtycWXzH8XPVW46wFS6oMCq8oy3PlbSWjgCCOB
 l6VMxeG733rifq8KlA97L8+Sj3S8ActkE3U+G7hQ1H1K5Noz8TGp4fxowE1H8vbVZ3w3
 YR/KEdw1j4mExhQwSBAimKUAPlMzgjq9xUSCQ4EHcaEBawIRJ4ClRcY1t+uJAHlmYTJN
 KTsnfkj23N5KEK1EUHRLqCEXxxhTFP8x/AwhDaFDFCnVWOL+eU8GBCjO9ptBOfMgDta1
 21tVbkwNK+pnVQuDFehzu1zkE2psBvhjEJbEA51j8kfoGf9tChu1a3KgPCsg599MZ4Pa
 AQjQ==
X-Gm-Message-State: AOJu0YxbAWqpdOKrN/VTGK6sSSHxSahoZGFldsJ1lu3dnk1+ZACPpQ6T
 NYSwrTiKx/zo+C65xwGLWZwp1P0nmH1cOZeHUioMzq9atdJ3ddnjJOfe8wcmQLNHvvga6AlgaAG
 E
X-Google-Smtp-Source: AGHT+IGW2atA/0oZ9Y6sWIYT32s6NIwjOB+0oCtJkLON++dGoRwR6OPmF/rlchLN4wITbFs0LFv8lA==
X-Received: by 2002:a17:906:796:b0:a3f:5c5c:33ac with SMTP id
 l22-20020a170906079600b00a3f5c5c33acmr7194711ejc.62.1709023304289; 
 Tue, 27 Feb 2024 00:41:44 -0800 (PST)
Received: from m1x-phil.lan (mic92-h03-176-184-33-214.dsl.sta.abo.bbox.fr.
 [176.184.33.214]) by smtp.gmail.com with ESMTPSA id
 hu21-20020a170907a09500b00a42eb167492sm533512ejc.116.2024.02.27.00.41.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 27 Feb 2024 00:41:43 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-block@nongnu.org, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL 18/30] hw/usb: extract sysbus-ohci to a separate file
Date: Tue, 27 Feb 2024 09:39:34 +0100
Message-ID: <20240227083948.5427-19-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240227083948.5427-1-philmd@linaro.org>
References: <20240227083948.5427-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

From: Paolo Bonzini <pbonzini@redhat.com>

Split the sysbus version to a separate file so that it is not
included in PCI-only machines, and adjust Kconfig for machines
that do need sysbus-ohci.  The copyrights are based on the
time and employer of balrog and Paul Brook's contributions.

While adjusting the SM501 dependency, move it to the right place
instead of keeping it in the R4D machine.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240223124406.234509-10-pbonzini@redhat.com>
[PMD: Rename some functions using 'ohci_sysbus_' prefix]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/usb/hcd-ohci-sysbus.c | 88 ++++++++++++++++++++++++++++++++++++++++
 hw/usb/hcd-ohci.c        | 58 --------------------------
 hw/arm/Kconfig           | 12 +++---
 hw/display/Kconfig       |  1 +
 hw/ppc/Kconfig           |  2 +-
 hw/sh4/Kconfig           |  1 -
 hw/usb/Kconfig           |  4 ++
 hw/usb/meson.build       |  1 +
 8 files changed, 102 insertions(+), 65 deletions(-)
 create mode 100644 hw/usb/hcd-ohci-sysbus.c

diff --git a/hw/usb/hcd-ohci-sysbus.c b/hw/usb/hcd-ohci-sysbus.c
new file mode 100644
index 0000000000..6fba7f50f8
--- /dev/null
+++ b/hw/usb/hcd-ohci-sysbus.c
@@ -0,0 +1,88 @@
+/*
+ * QEMU USB OHCI Emulation
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
+#include "hcd-ohci.h"
+
+
+static void ohci_sysbus_realize(DeviceState *dev, Error **errp)
+{
+    OHCISysBusState *s = SYSBUS_OHCI(dev);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
+    Error *err = NULL;
+
+    usb_ohci_init(&s->ohci, dev, s->num_ports, s->dma_offset,
+                  s->masterbus, s->firstport,
+                  &address_space_memory, ohci_sysbus_die, &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+    sysbus_init_irq(sbd, &s->ohci.irq);
+    sysbus_init_mmio(sbd, &s->ohci.mem);
+}
+
+static void ohci_sysbus_reset(DeviceState *dev)
+{
+    OHCISysBusState *s = SYSBUS_OHCI(dev);
+    OHCIState *ohci = &s->ohci;
+
+    ohci_hard_reset(ohci);
+}
+
+static Property ohci_sysbus_properties[] = {
+    DEFINE_PROP_STRING("masterbus", OHCISysBusState, masterbus),
+    DEFINE_PROP_UINT32("num-ports", OHCISysBusState, num_ports, 3),
+    DEFINE_PROP_UINT32("firstport", OHCISysBusState, firstport, 0),
+    DEFINE_PROP_DMAADDR("dma-offset", OHCISysBusState, dma_offset, 0),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void ohci_sysbus_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->realize = ohci_sysbus_realize;
+    set_bit(DEVICE_CATEGORY_USB, dc->categories);
+    dc->desc = "OHCI USB Controller";
+    device_class_set_props(dc, ohci_sysbus_properties);
+    dc->reset = ohci_sysbus_reset;
+}
+
+static const TypeInfo ohci_sysbus_types[] = {
+    {
+        .name          = TYPE_SYSBUS_OHCI,
+        .parent        = TYPE_SYS_BUS_DEVICE,
+        .instance_size = sizeof(OHCISysBusState),
+        .class_init    = ohci_sysbus_class_init,
+    },
+};
+
+DEFINE_TYPES(ohci_sysbus_types);
diff --git a/hw/usb/hcd-ohci.c b/hw/usb/hcd-ohci.c
index d73b53f33c..fc8fc91a1d 100644
--- a/hw/usb/hcd-ohci.c
+++ b/hw/usb/hcd-ohci.c
@@ -1955,31 +1955,6 @@ void ohci_sysbus_die(struct OHCIState *ohci)
     ohci_bus_stop(ohci);
 }
 
-static void ohci_realize_pxa(DeviceState *dev, Error **errp)
-{
-    OHCISysBusState *s = SYSBUS_OHCI(dev);
-    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
-    Error *err = NULL;
-
-    usb_ohci_init(&s->ohci, dev, s->num_ports, s->dma_offset,
-                  s->masterbus, s->firstport,
-                  &address_space_memory, ohci_sysbus_die, &err);
-    if (err) {
-        error_propagate(errp, err);
-        return;
-    }
-    sysbus_init_irq(sbd, &s->ohci.irq);
-    sysbus_init_mmio(sbd, &s->ohci.mem);
-}
-
-static void usb_ohci_reset_sysbus(DeviceState *dev)
-{
-    OHCISysBusState *s = SYSBUS_OHCI(dev);
-    OHCIState *ohci = &s->ohci;
-
-    ohci_hard_reset(ohci);
-}
-
 static const VMStateDescription vmstate_ohci_state_port = {
     .name = "ohci-core/port",
     .version_id = 1,
@@ -2054,36 +2029,3 @@ const VMStateDescription vmstate_ohci_state = {
         NULL
     }
 };
-
-static Property ohci_sysbus_properties[] = {
-    DEFINE_PROP_STRING("masterbus", OHCISysBusState, masterbus),
-    DEFINE_PROP_UINT32("num-ports", OHCISysBusState, num_ports, 3),
-    DEFINE_PROP_UINT32("firstport", OHCISysBusState, firstport, 0),
-    DEFINE_PROP_DMAADDR("dma-offset", OHCISysBusState, dma_offset, 0),
-    DEFINE_PROP_END_OF_LIST(),
-};
-
-static void ohci_sysbus_class_init(ObjectClass *klass, void *data)
-{
-    DeviceClass *dc = DEVICE_CLASS(klass);
-
-    dc->realize = ohci_realize_pxa;
-    set_bit(DEVICE_CATEGORY_USB, dc->categories);
-    dc->desc = "OHCI USB Controller";
-    device_class_set_props(dc, ohci_sysbus_properties);
-    dc->reset = usb_ohci_reset_sysbus;
-}
-
-static const TypeInfo ohci_sysbus_info = {
-    .name          = TYPE_SYSBUS_OHCI,
-    .parent        = TYPE_SYS_BUS_DEVICE,
-    .instance_size = sizeof(OHCISysBusState),
-    .class_init    = ohci_sysbus_class_init,
-};
-
-static void ohci_register_types(void)
-{
-    type_register_static(&ohci_sysbus_info);
-}
-
-type_init(ohci_register_types)
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index b372b819a4..7caebdd98e 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -185,7 +185,7 @@ config PXA2XX
     select SERIAL
     select SD
     select SSI
-    select USB_OHCI
+    select USB_OHCI_SYSBUS
     select PCMCIA
 
 config GUMSTIX
@@ -256,7 +256,7 @@ config REALVIEW
     select PL310  # cache controller
     select ARM_SBCON_I2C
     select DS1338 # I2C RTC+NVRAM
-    select USB_OHCI
+    select USB_OHCI_SYSBUS
 
 config SBSA_REF
     bool
@@ -339,7 +339,7 @@ config VERSATILE
     select PL080  # DMA controller
     select PL190  # Vector PIC
     select REALVIEW
-    select USB_OHCI
+    select USB_OHCI_SYSBUS
 
 config VEXPRESS
     bool
@@ -395,6 +395,7 @@ config ALLWINNER_A10
     select AXP2XX_PMU
     select SERIAL
     select UNIMP
+    select USB_OHCI_SYSBUS
 
 config ALLWINNER_H3
     bool
@@ -408,7 +409,7 @@ config ALLWINNER_H3
     select ARM_TIMER
     select ARM_GIC
     select UNIMP
-    select USB_OHCI
+    select USB_OHCI_SYSBUS
     select USB_EHCI_SYSBUS
     select SD
 
@@ -424,7 +425,7 @@ config ALLWINNER_R40
     select ARM_TIMER
     select ARM_GIC
     select UNIMP
-    select USB_OHCI
+    select USB_OHCI_SYSBUS
     select USB_EHCI_SYSBUS
     select SD
 
@@ -530,6 +531,7 @@ config NPCM7XX
     select SSI
     select UNIMP
     select PCA954X
+    select USB_OHCI_SYSBUS
 
 config FSL_IMX25
     bool
diff --git a/hw/display/Kconfig b/hw/display/Kconfig
index 1aafe1923d..07acb37dc6 100644
--- a/hw/display/Kconfig
+++ b/hw/display/Kconfig
@@ -77,6 +77,7 @@ config SM501
     select I2C
     select DDC
     select SERIAL
+    select USB_OHCI_SYSBUS
 
 config TCX
     bool
diff --git a/hw/ppc/Kconfig b/hw/ppc/Kconfig
index b664d0eb37..37ccf9cdca 100644
--- a/hw/ppc/Kconfig
+++ b/hw/ppc/Kconfig
@@ -70,7 +70,7 @@ config SAM460EX
     select SM501
     select SMBUS_EEPROM
     select USB_EHCI_SYSBUS
-    select USB_OHCI
+    select USB_OHCI_SYSBUS
     select FDT_PPC
 
 config AMIGAONE
diff --git a/hw/sh4/Kconfig b/hw/sh4/Kconfig
index ab733a3f76..e0c4ecd1a5 100644
--- a/hw/sh4/Kconfig
+++ b/hw/sh4/Kconfig
@@ -6,7 +6,6 @@ config R2D
     select I82378 if TEST_DEVICES
     select IDE_MMIO
     select PFLASH_CFI02
-    select USB_OHCI_PCI
     select PCI
     select SM501
     select SH7750
diff --git a/hw/usb/Kconfig b/hw/usb/Kconfig
index 0f486764ed..f569ed7eea 100644
--- a/hw/usb/Kconfig
+++ b/hw/usb/Kconfig
@@ -11,6 +11,10 @@ config USB_OHCI
     bool
     select USB
 
+config USB_OHCI_SYSBUS
+    bool
+    select USB_OHCI
+
 config USB_OHCI_PCI
     bool
     default y if PCI_DEVICES
diff --git a/hw/usb/meson.build b/hw/usb/meson.build
index 2c13c52878..94f0e3b034 100644
--- a/hw/usb/meson.build
+++ b/hw/usb/meson.build
@@ -15,6 +15,7 @@ system_ss.add(when: 'CONFIG_USB', if_true: files(
 system_ss.add(when: 'CONFIG_USB_UHCI', if_true: files('hcd-uhci.c'))
 system_ss.add(when: 'CONFIG_USB_OHCI', if_true: files('hcd-ohci.c'))
 system_ss.add(when: 'CONFIG_USB_OHCI_PCI', if_true: files('hcd-ohci-pci.c'))
+system_ss.add(when: 'CONFIG_USB_OHCI_SYSBUS', if_true: files('hcd-ohci-sysbus.c'))
 system_ss.add(when: 'CONFIG_USB_EHCI', if_true: files('hcd-ehci.c'))
 system_ss.add(when: 'CONFIG_USB_EHCI_PCI', if_true: files('hcd-ehci-pci.c'))
 system_ss.add(when: 'CONFIG_USB_EHCI_SYSBUS', if_true: files('hcd-ehci.c', 'hcd-ehci-sysbus.c'))
-- 
2.41.0


