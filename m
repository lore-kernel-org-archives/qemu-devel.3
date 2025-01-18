Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2538C02185
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jan 2025 07:10:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZ2xh-0003HW-3n; Sat, 18 Jan 2025 02:09:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tZ2xf-0003HN-7w
 for qemu-devel@nongnu.org; Sat, 18 Jan 2025 02:09:39 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tZ2xc-0007rV-Tg
 for qemu-devel@nongnu.org; Sat, 18 Jan 2025 02:09:38 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2165cb60719so52201175ad.0
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 23:09:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737184175; x=1737788975; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2jKdz++y7gS8MzwMLxg2+Nc3pBzePH5ZRQnJ2/K0PAc=;
 b=g49Izu3FeyFMM83QbCbLhgC5bgiqznKOjZrNCcjKgMUy5qFaEUMvdPkyNRRPrIvKo1
 wSvGNfMEz/tbyKvB7rG40rNqKHKrwi2JusKHMo4Z7hK1DRYt3vjBoeGEoLtGvI+Qj13m
 hW78deftRng0KfSNZwXPe0TJDv/JNXpc/COjOdN4ukWzRj67YXL1ofIOkAkMkvzq3+gZ
 dQitvQJ6YSXMCqOTlrxSewQBRAj+KNGhXLZ3IK7iIb4UDu1VIs8RBVyrMYNKpE9YSeVk
 g+MYkZdEik6yxBpNa76g2PcvSIYGi0zKOQdrDAsmF45YnZf4LwGaVwdF2k/qxWHhESd/
 9WIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737184175; x=1737788975;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2jKdz++y7gS8MzwMLxg2+Nc3pBzePH5ZRQnJ2/K0PAc=;
 b=AeBbVBMBYwwZ6j3MJQdIRnfvGgmwDR/Y8H/JLDnn+PTHfPcGkYw1kKYC23f7m6c/Di
 SVvGuCf7KhEcjnqnoL9WJIczyYQw2eJ/91+8rm3XXGtj9zIqfUmrZT4JWxRhiJ7ttWIP
 pKs7L7iCXJCPk7qAfIl7/Lcd68Nd94xtt0/WDxz1IDdgZ/AQghhIjjQrozNzzkQZux7Z
 br5CL25kKW/BYK9eIpTiRew82qb501LH0xFEzcpXWdDZY9+bJQAFcPF0ujKldisx74cb
 PYDwb337kJG13B8IKFzom1mdTnYPmTPmTFXML+H5nWmEGQsip6epA4tYJGEZ5OYAG5L5
 Yubg==
X-Gm-Message-State: AOJu0YwmN5Lhh28OEtcDgIep1cTYh5BZ4K7LrrjtdR2SuOGFafhk/9kM
 rXzNAdJ5ibxDxvxFe6Bhxzebm87vvZrdD1ptjCs4f0ZgeZ+t2KV5WP44vg==
X-Gm-Gg: ASbGncvbjGmvykjHzem3wwl1f90KfBc9kcNwWk83VEWV4qHcO69FWKyQp+DnjHPe2XG
 scOCBFXgV0t9xxI6EuA80OSytqfT3bY1QCxmgDtnvQnFIs/7Wa/cLD6Qojv53zVI0NROpSxaCnI
 //rTLUr55EGSUqchFj1OJUAJ52Zb8WNhrL3GXXvwL2kqsyL9i5UhWIRYDpeMuM8y5SrdvHn+dSJ
 9moH7bOwCzZ0nV8CMR9bmg3YJTI28bHJVSPJv9KLgYNGIHS6ctALh1mzJAZPazTBoEwnoziQzdO
 eNbZn+c0pp1cgn1/qMgeiszs4bJ6
X-Google-Smtp-Source: AGHT+IHYDT2JiR4upm5IC6RzmFUuZFP8xCL10bMZqVsO1pigeXX2rxhFyrDUnBTp88n2JxMotJbHlA==
X-Received: by 2002:a05:6a21:789a:b0:1e6:51d2:c8e3 with SMTP id
 adf61e73a8af0-1eb215f52a7mr10765445637.35.1737184175069; 
 Fri, 17 Jan 2025 23:09:35 -0800 (PST)
Received: from wheely.local0.net (124-169-212-233.tpgi.com.au.
 [124.169.212.233]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72dab9c95adsm3192880b3a.107.2025.01.17.23.09.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 23:09:34 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>
Subject: [PATCH v2 8/8] hw/usb/hcd-xhci-pci: Add TI TUSB73X0 XHCI controller
 model
Date: Sat, 18 Jan 2025 17:08:53 +1000
Message-ID: <20250118070853.653778-9-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250118070853.653778-1-npiggin@gmail.com>
References: <20250118070853.653778-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x632.google.com
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

xhci qtests are added for this device.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 include/hw/pci/pci_ids.h        |  1 +
 include/hw/usb/xhci.h           |  1 +
 hw/usb/hcd-xhci-ti.c            | 88 +++++++++++++++++++++++++++++++++
 tests/qtest/usb-hcd-xhci-test.c |  4 ++
 hw/usb/Kconfig                  |  5 ++
 hw/usb/meson.build              |  1 +
 6 files changed, 100 insertions(+)
 create mode 100644 hw/usb/hcd-xhci-ti.c

diff --git a/include/hw/pci/pci_ids.h b/include/hw/pci/pci_ids.h
index f1a53fea8d6..fdb692db513 100644
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
index 00000000000..c2f8fb04a52
--- /dev/null
+++ b/hw/usb/hcd-xhci-ti.c
@@ -0,0 +1,88 @@
+/*
+ * USB xHCI controller emulation
+ * Datasheet https://www.ti.com/product/TUSB7340
+ *
+ * Copyright (c) 2011 Securiforest
+ * Date: 2011-05-11 ;  Author: Hector Martin <hector@marcansoft.com>
+ * Based on usb-xhci-nec.c, emulates TI TUSB73X0
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
+static Property ti_xhci_properties[] = {
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
+static void ti_xhci_class_init(ObjectClass *klass, void *data)
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
index 4efe7b69d4f..dc438cf35c7 100644
--- a/tests/qtest/usb-hcd-xhci-test.c
+++ b/tests/qtest/usb-hcd-xhci-test.c
@@ -65,6 +65,8 @@ typedef struct XHCIQState {
                       PCI_VENDOR_ID_REDHAT)
 #define XHCI_NEC_ID (PCI_DEVICE_ID_NEC_UPD720200 << 16 | \
                      PCI_VENDOR_ID_NEC)
+#define XHCI_TI_ID  (PCI_DEVICE_ID_TI_TUSB73X0 << 16 | \
+                     PCI_VENDOR_ID_TI)
 
 /**
  * Locate, verify, and return a handle to the XHCI device.
@@ -85,6 +87,7 @@ static QPCIDevice *get_xhci_device(QTestState *qts, uint32_t *fingerprint)
     switch (xhci_fingerprint) {
     case XHCI_QEMU_ID:
     case XHCI_NEC_ID:
+    case XHCI_TI_ID:
         break;
     default:
         /* Unknown device. */
@@ -610,6 +613,7 @@ int main(int argc, char **argv)
     TestData td[] = {
         { .device = "qemu-xhci", },
         { .device = "nec-usb-xhci", },
+        { .device = "ti-usb-xhci", },
     };
 
     g_test_init(&argc, &argv, NULL);
diff --git a/hw/usb/Kconfig b/hw/usb/Kconfig
index 5fbecd2f43b..8e5c4747af9 100644
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
index 1b4d1507e41..b874a93f16e 100644
--- a/hw/usb/meson.build
+++ b/hw/usb/meson.build
@@ -23,6 +23,7 @@ system_ss.add(when: 'CONFIG_USB_XHCI', if_true: files('hcd-xhci.c'))
 system_ss.add(when: 'CONFIG_USB_XHCI_PCI', if_true: files('hcd-xhci-pci.c'))
 system_ss.add(when: 'CONFIG_USB_XHCI_SYSBUS', if_true: files('hcd-xhci-sysbus.c'))
 system_ss.add(when: 'CONFIG_USB_XHCI_NEC', if_true: files('hcd-xhci-nec.c'))
+system_ss.add(when: 'CONFIG_USB_XHCI_TI', if_true: files('hcd-xhci-ti.c'))
 system_ss.add(when: 'CONFIG_USB_DWC2', if_true: files('hcd-dwc2.c'))
 system_ss.add(when: 'CONFIG_USB_DWC3', if_true: files('hcd-dwc3.c'))
 
-- 
2.45.2


