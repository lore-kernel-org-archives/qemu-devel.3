Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1D63C3ABA3
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 03:32:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAh80-0004Zb-9k; Thu, 01 May 2025 23:31:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1uAh7y-0004WX-F2
 for qemu-devel@nongnu.org; Thu, 01 May 2025 23:31:54 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1uAh7v-0001IU-R2
 for qemu-devel@nongnu.org; Thu, 01 May 2025 23:31:54 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-73bf1cef6ceso1737948b3a.0
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 20:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746156710; x=1746761510; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+bwaHMNOhN5/3SiuCmSg59LLWnyBqFKfT3s/956qIKI=;
 b=naXZOCuKMbln2EwyNdzPTxi2OdpR/f+ULwHYmGxNuUwvsFTOKHk892hkvOM4QmV98c
 F8ZDWd1R+YKu4uh10ImIQxs2snRfy90yXtbf30wIHL8/jXOGaKCUFdSRJZz5VsULZglG
 /iI7Tgf6ee9vf3wdDzeDapyhJDFS7EfC1JSSTmBrLDMQ2/IWywyXn0qudzHJ9USJ7eWy
 MiBPfDOnceOT8ySApCuk4bs1V9fPYIK2gErV3UKfB2EwkNPHc8kT2uZ90CaYHtbzLJUq
 g8Tv0fSuGG7a6G1LzbemWz5EwriGyuCgDnH9gz5iFRHj2RabdCdCTMyN3KYuqkaKVvWl
 11bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746156710; x=1746761510;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+bwaHMNOhN5/3SiuCmSg59LLWnyBqFKfT3s/956qIKI=;
 b=T9Rky0G68Ru2wvG18O3oL5PIMw8V4T4OF9bUUewHqvI9dwI7O5rY9wTJEmnId+3Evq
 puxHWSmwD8oJXCgd7q4/fo4HvHdguT6kuYMaHP1rpce37Iingsh/pncUnc7KdZa+ZBay
 7hIuDtRB6ZHFXcrFwy3ABGI/07MrtrOODaSaYtLJn4BDO5NyswA71edqfuaUxcSM6LZR
 jtP5SchTblxCrmuKGJid5UEjdlQI3CE+mE9LbrjdJahU2QNX7gWW7b0GqO+ZD5QVKQp0
 H0DkGsgfyTPQBPBZxWWw6tI3xklfhPJKz+fWKJHZjFe3QOIb6PI74x5zOojEQfdkwvA1
 m5tA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+YlQmgxVxsafdm9lGcTZtEjGG42c/SL/wIycbwPPVUSrV1h/KgtSYSAbBeq7jwRZ/E/8aGcobV1Fv@nongnu.org
X-Gm-Message-State: AOJu0YzSFxG8sSpOoYDJW5gknIl6B8926zfb3AXPLleuOo9YYkI36Uec
 nfiDIn7ksmsqk4Hb++wwBmEVliy1nYtJU/FoGvy6hQovMXIo4m1ghaxJZg==
X-Gm-Gg: ASbGncvfZ6RBtHuoJR5Xg38AvJAXTWAlcTgQdGfPqmssAXOD8O4GF4Ya52LEBkFQqSG
 HX9nUgesxcH5lyho9L8/StaMVPzyP6z3IUWZEqKv1anuKb94tjQcNV1/OgUIy2t1R8/u7Q9NS6H
 rUT8zIu09E/IiU+wNgmSbmkVwVBip9OMWFBH4Cc0WvIff5ImP8m9N3HuOKDXCZOofZrqlbqDPbS
 uOFgiSW4z8KhaWHbW3EzAa6yTj5T+caybXrtCKqyU/RpQX/RvT26MBWFzxFNUCgo+XwMRtkl6m7
 tMkg0WkgMAKay+vlFrlMWmcE2MYV14CqF+6yNghzrtvS
X-Google-Smtp-Source: AGHT+IHjrZ7ck+RMRIwwbbdv/PdV8MsbmCit/9MQ2zf4wf4kR5zJEBrh7MGlKCFk/VCr2QlY08E2Kw==
X-Received: by 2002:a05:6a00:428f:b0:736:6ac4:d204 with SMTP id
 d2e1a72fcca58-74058a4e54amr1659312b3a.11.1746156710501; 
 Thu, 01 May 2025 20:31:50 -0700 (PDT)
Received: from wheely.local0.net ([220.253.99.94])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74059063f6esm488055b3a.139.2025.05.01.20.31.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 May 2025 20:31:50 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 10/22] hw/usb/hcd-xhci-pci: Add TI TUSB73X0 XHCI controller
 model
Date: Fri,  2 May 2025 13:30:34 +1000
Message-ID: <20250502033047.102465-11-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250502033047.102465-1-npiggin@gmail.com>
References: <20250502033047.102465-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x434.google.com
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

The TI TUSB73X0 controller has some interesting differences from NEC,
notably a separate BAR for MSIX, and PM capabilities. The spec is freely
available without sign-up.

This controller is accepted by IBM Power proprietary firmware and
software (when the subsystem IDs are set to Power servers, which is not
done here). IBM code is picky about device support, so the NEC device
can not be used.

xhci qtests are enabled for this device.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 include/hw/pci/pci_ids.h        |  1 +
 include/hw/usb/xhci.h           |  1 +
 hw/usb/hcd-xhci-ti.c            | 77 +++++++++++++++++++++++++++++++++
 tests/qtest/usb-hcd-xhci-test.c |  3 ++
 hw/usb/Kconfig                  |  5 +++
 hw/usb/meson.build              |  1 +
 6 files changed, 88 insertions(+)
 create mode 100644 hw/usb/hcd-xhci-ti.c

diff --git a/include/hw/pci/pci_ids.h b/include/hw/pci/pci_ids.h
index 33e2898be95..99fe751703f 100644
--- a/include/hw/pci/pci_ids.h
+++ b/include/hw/pci/pci_ids.h
@@ -182,6 +182,7 @@
 #define PCI_VENDOR_ID_HP                 0x103c
 
 #define PCI_VENDOR_ID_TI                 0x104c
+#define PCI_DEVICE_ID_TI_TUSB73X0        0x8241
 
 #define PCI_VENDOR_ID_MOTOROLA           0x1057
 #define PCI_DEVICE_ID_MOTOROLA_MPC106    0x0002
diff --git a/include/hw/usb/xhci.h b/include/hw/usb/xhci.h
index 5c90e1373e5..203ec1fca32 100644
--- a/include/hw/usb/xhci.h
+++ b/include/hw/usb/xhci.h
@@ -3,6 +3,7 @@
 
 #define TYPE_XHCI "base-xhci"
 #define TYPE_NEC_XHCI "nec-usb-xhci"
+#define TYPE_TI_XHCI "ti-usb-xhci"
 #define TYPE_QEMU_XHCI "qemu-xhci"
 #define TYPE_XHCI_SYSBUS "sysbus-xhci"
 
diff --git a/hw/usb/hcd-xhci-ti.c b/hw/usb/hcd-xhci-ti.c
new file mode 100644
index 00000000000..b7bb71c62e8
--- /dev/null
+++ b/hw/usb/hcd-xhci-ti.c
@@ -0,0 +1,77 @@
+/*
+ * USB xHCI TI TUSB73X0 controller emulation
+ * Datasheet https://www.ti.com/product/TUSB7340
+ *
+ * Copyright (c) 2025 IBM Corporation
+ * Derived from hcd-xhci-nec.c, copyright accordingly.
+ *
+ * SPDX-License-Identifier: LGPL-2.1-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/usb.h"
+#include "qemu/module.h"
+#include "hw/pci/pci.h"
+#include "hw/qdev-properties.h"
+
+#include "hcd-xhci-pci.h"
+
+OBJECT_DECLARE_SIMPLE_TYPE(XHCITiState, TI_XHCI)
+
+struct XHCITiState {
+    XHCIPciState parent_obj;
+
+    uint32_t intrs;
+    uint32_t slots;
+};
+
+static const Property ti_xhci_properties[] = {
+    DEFINE_PROP_UINT32("intrs", XHCITiState, intrs, 8),
+    DEFINE_PROP_UINT32("slots", XHCITiState, slots, XHCI_MAXSLOTS),
+};
+
+static void ti_xhci_instance_init(Object *obj)
+{
+    XHCIPciState *pci = XHCI_PCI(obj);
+    XHCITiState *ti = TI_XHCI(obj);
+
+    pci->xhci.numintrs = ti->intrs;
+    pci->xhci.numslots = ti->slots;
+
+    /* Taken from datasheet */
+    pci->cache_line_size = 0x0;
+    pci->pm_cap_off = 0x40;
+    pci->pcie_cap_off = 0x70;
+    pci->msi_cap_off = 0x48;
+    pci->msix_cap_off = 0xc0;
+    pci->msix_bar_nr = 0x2;
+    pci->msix_bar_size = 0x800000;
+    pci->msix_table_off = 0x0;
+    pci->msix_pba_off = 0x1000;
+}
+
+static void ti_xhci_class_init(ObjectClass *klass, const void *data)
+{
+    PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    device_class_set_props(dc, ti_xhci_properties);
+    k->vendor_id    = PCI_VENDOR_ID_TI;
+    k->device_id    = PCI_DEVICE_ID_TI_TUSB73X0;
+    k->revision     = 0x02;
+}
+
+static const TypeInfo ti_xhci_info = {
+    .name          = TYPE_TI_XHCI,
+    .parent        = TYPE_XHCI_PCI,
+    .instance_size = sizeof(XHCITiState),
+    .instance_init = ti_xhci_instance_init,
+    .class_init    = ti_xhci_class_init,
+};
+
+static void ti_xhci_register_types(void)
+{
+    type_register_static(&ti_xhci_info);
+}
+
+type_init(ti_xhci_register_types)
diff --git a/tests/qtest/usb-hcd-xhci-test.c b/tests/qtest/usb-hcd-xhci-test.c
index 2eecc8d9f26..428200d9e41 100644
--- a/tests/qtest/usb-hcd-xhci-test.c
+++ b/tests/qtest/usb-hcd-xhci-test.c
@@ -71,6 +71,8 @@ typedef struct XHCIQState {
                       PCI_VENDOR_ID_REDHAT)
 #define XHCI_NEC_ID (PCI_DEVICE_ID_NEC_UPD720200 << 16 | \
                      PCI_VENDOR_ID_NEC)
+#define XHCI_TI_ID  (PCI_DEVICE_ID_TI_TUSB73X0 << 16 | \
+                     PCI_VENDOR_ID_TI)
 
 /**
  * Locate, verify, and return a handle to the XHCI device.
@@ -932,6 +934,7 @@ int main(int argc, char **argv)
     TestData td[] = {
         { .device = "qemu-xhci", .fingerprint = XHCI_QEMU_ID, },
         { .device = "nec-usb-xhci", .fingerprint = XHCI_NEC_ID, },
+        { .device = "ti-usb-xhci", .fingerprint = XHCI_TI_ID, },
     };
 
     g_test_init(&argc, &argv, NULL);
diff --git a/hw/usb/Kconfig b/hw/usb/Kconfig
index 69c663be52f..00d82a97211 100644
--- a/hw/usb/Kconfig
+++ b/hw/usb/Kconfig
@@ -49,6 +49,11 @@ config USB_XHCI_NEC
     default y if PCI_DEVICES
     select USB_XHCI_PCI
 
+config USB_XHCI_TI
+    bool
+    default y if PCI_DEVICES
+    select USB_XHCI_PCI
+
 config USB_XHCI_SYSBUS
     bool
     select USB_XHCI
diff --git a/hw/usb/meson.build b/hw/usb/meson.build
index 17360a5b5a4..375fa420be6 100644
--- a/hw/usb/meson.build
+++ b/hw/usb/meson.build
@@ -23,6 +23,7 @@ system_ss.add(when: 'CONFIG_USB_XHCI', if_true: files('hcd-xhci.c'))
 system_ss.add(when: 'CONFIG_USB_XHCI_PCI', if_true: files('hcd-xhci-pci.c'))
 system_ss.add(when: 'CONFIG_USB_XHCI_SYSBUS', if_true: files('hcd-xhci-sysbus.c'))
 system_ss.add(when: 'CONFIG_USB_XHCI_NEC', if_true: files('hcd-xhci-nec.c'))
+system_ss.add(when: 'CONFIG_USB_XHCI_TI', if_true: files('hcd-xhci-ti.c'))
 system_ss.add(when: 'CONFIG_USB_DWC2', if_true: files('hcd-dwc2.c'))
 system_ss.add(when: 'CONFIG_USB_DWC3', if_true: files('hcd-dwc3.c'))
 system_ss.add(when: 'CONFIG_USB_CHIPIDEA', if_true: files('chipidea.c'))
-- 
2.47.1


