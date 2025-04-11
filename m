Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7F78C36010
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Apr 2025 08:01:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u39JR-0003Bi-70; Fri, 11 Apr 2025 04:00:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1u39Ib-0002SD-U2
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 03:59:44 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1u39IY-0003tn-CP
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 03:59:40 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-739be717eddso1281157b3a.2
 for <qemu-devel@nongnu.org>; Fri, 11 Apr 2025 00:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744358375; x=1744963175; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PStPfV/DBFgVrzOHWESxSBDoSjpwhlDzCP9C76+g8oI=;
 b=V//bl1trdIX1EebSnqAYVsaJ5l4oz3jjpI8JT1tEBjWESjXDrApcIhGoJYarwbyb8+
 1lgEw/zu47zP33JpXYJMZIk4s/l3OANkziozub9v/4PWZoa1gBTaMtizY/NDCAkv//nk
 SO2syxc4L3/3IRzqS/o+S+0iDZ7xdLMtMGqwDaZun1tDhIkzhZlSrlr0R906huTIBqmY
 GUarQ7cQC7kUp/HTnvHGyYOL6VlwShUz9rckebG6faF7+4htFaYS9QwmSlhqdct3QQ+E
 VhZiAYqop4uwWS2R9tYt4TU8sAbqa8eOtsMKfVrB+bxSe+eDGqf3lttexphC5qdVVUws
 yETg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744358375; x=1744963175;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PStPfV/DBFgVrzOHWESxSBDoSjpwhlDzCP9C76+g8oI=;
 b=J/6a8GSSzI+Oaaostu8P2Ht4p7H1r5imGEaY7VtKByuu0YK2If7sO8Z1w/iBzjISDS
 c4GuODv3l2Xbw45Tlwu4ImF1uyaCZ+PBr82fIgze8UqUm0CIRWt3HCcZDXaSgTyssV4n
 GP3sVKf/SPuwc/APsLX+V/HNED8780f/MXAupLS8zyidn9xhMFFdzXs9P7UNnHYd/VbG
 wVD2I3NMzzC5voOrhjOCcKaPPHKg9DogG3T+mYbZJhWL/nEv2fzgG4JquVP716nOZqhw
 b7IYNa+bZkfX6CbWZVsrE5/QutQc89QUnkiwLOJS26bYDZgvURqv1rw/xnC97+3i10Rh
 /8iA==
X-Gm-Message-State: AOJu0Yx3bdVnTfm+YvCS0wNcHYkL1JA/al9iGs3BctM7Ccr+D4M1DK3S
 QaGLveDsY6UuMt9yfoS8vO9+drS8AXzPKAQ0Xnyq6RBImdW54ywxu8xO+g==
X-Gm-Gg: ASbGnctjLiWpSy7F+e5LEw/frbifkV1aA8hQU+NmD+ho5i0C049x6uwaMid3RQvG1Om
 ssnyLmcnjGVjJd8lTkKcKFPvLsPd369WKxMaAtpoz9524VeJWSSpo7E+1bY01rpjhp+rvhVgNt7
 uhY9J8Lzdvue56W1TqM9fIGyXZ7lZ6tySbbS3d8yEEroYY6VEIOhwcigUI9Vi7IN99QWePSIElI
 Tcx9iwHdx/S0fYXfOl8MWQEuc+ybvqeiBVDOTBBzfcyiIS8VHgEJkwkKCa+FcY61E814fequI2j
 OvB9BmVg1QZ6oQppuB38XTE6sXwS5dMvKDREc9W6d5Ow
X-Google-Smtp-Source: AGHT+IE1EicbAe6mzh+9+ojxoowZU2Kd2eAZdQy3+wwuMzxVhwjLgvbVnoU5ZCv4WquUMF44Fupgqg==
X-Received: by 2002:a05:6a00:1829:b0:736:4e67:d631 with SMTP id
 d2e1a72fcca58-73bd12b0207mr2880199b3a.23.1744358374608; 
 Fri, 11 Apr 2025 00:59:34 -0700 (PDT)
Received: from wheely.local0.net ([220.253.99.94])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73bd233554asm851687b3a.180.2025.04.11.00.59.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Apr 2025 00:59:34 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v3 8/8] hw/usb/hcd-xhci-pci: Add TI TUSB73X0 XHCI controller
 model
Date: Fri, 11 Apr 2025 17:58:50 +1000
Message-ID: <20250411075851.206995-9-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250411075851.206995-1-npiggin@gmail.com>
References: <20250411075851.206995-1-npiggin@gmail.com>
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
index 00000000000..9ad9d6edf7a
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


