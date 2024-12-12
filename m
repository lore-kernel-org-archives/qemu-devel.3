Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0990E77183
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 08:53:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLew3-0002Om-Vg; Thu, 12 Dec 2024 03:52:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tLevt-0002Nt-Bk
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 03:52:30 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tLevr-0002xP-4K
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 03:52:29 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-21628b3fe7dso2857365ad.3
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2024 00:52:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733993545; x=1734598345; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jnVG7KQCzrcIK1m42/aEsBiaqhK1sFzEc206MK4Psm0=;
 b=DAhUntAd070s0D1DYI12c2IohV4/KGdszH8IvBPwU9tydTTuIHz8SBISKn0gwlxvv+
 ay31cmu4gP3POMyBz34vi9cnUf0Ou+fXa28R6nsV5gE7+Rtw4e2/aPat065ylRHnIRoH
 DYuOqnNuc5PRbk8f/M8ujLDYo5SRuO+yESAZZhQJcQaalJk5sx9kM6zTTdMZQMmIKcg5
 eIfYCdaySJMME+Qs0CHFRH7ZAE7OkTzqQ3xymAP9pxZiujWEUf0zVenyO25sr/TaVr3r
 eSFsdbhNf6hcJj+s/A5ZL7I8WAqVf/q+nNbLZTDUvWe8SR1GlWY7ZsH2Vb3OAxiKHBQJ
 p+Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733993545; x=1734598345;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jnVG7KQCzrcIK1m42/aEsBiaqhK1sFzEc206MK4Psm0=;
 b=jld124i6HpHQ8MiBy3MlbjT/K+pVrFU1rSPjRDygSAxYae8UZq97K8cnlnPmOnW7Ax
 b6tloZ7ZJS85pYHuZnbbd+W+JtZmYK+aP28E0BJ/TvJ974Qre/wQHYn0z9FRxX0ivBdo
 OIeB/csjthYIHXVuighIYYQfwIBa6vPfID99ium8NuuuMEq55iQkpbhyC3dP+mRUiCy2
 YXmQ/Uxr6zBpEWC4GJaRcoDHf0Z89B45PLrT6DVBbIa9fJTUx4gRxAFpBWILRuuKr+fI
 NY5ImtZHM5ZboI8T19+XLkfGVqhqYxBx/ngkxtuKBNhxscVaHDVy0x4Nz21M8X1wtaAu
 K7dQ==
X-Gm-Message-State: AOJu0YzH1JMZMhSmlG+c1WI6oZy7dWMombQoDqWkaSKMzQhTP701oaiZ
 DCfcWSsWWfnJbhum3Ozkh6S/eAjqwxaWk6JZtOM8sRB9zSfljfNZJvXW+Q==
X-Gm-Gg: ASbGncvZAWmMFMYKctjNEv5G6dg99J/CGiBCkQesWSBjnhL78j1dpERkgv76rpxkt1U
 NkIBg+1finoGEg/ZQ70xyYct0dRD8xTtH+wKmT/eyHG70XgxoEDBhX8pAehp6SFhazKQFvfBgyj
 GUkHqxQtU/4b9X/UrxzlGQCflZ0BuCHsr22og6ZaPqWw1xbDpqURFCglOZutYD1PnbUHCJhhnv6
 Yv9PMTra4EcZ/BBIT9yHQQXI4Mw3NNAb4xEvXdfSeeKFWIU12ino82prlI=
X-Google-Smtp-Source: AGHT+IFBwZx8S+rzZzA8z13gzweUicjF3fY26sVGWE06NLNwdDLwHFs62Fn/Agdl2585KGetE2kNUg==
X-Received: by 2002:a17:902:ea05:b0:216:2a36:5b2a with SMTP id
 d9443c01a7336-2178af005femr45156495ad.47.1733993545170; 
 Thu, 12 Dec 2024 00:52:25 -0800 (PST)
Received: from wheely.local0.net ([1.146.48.169])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-215f8f0a736sm118402375ad.217.2024.12.12.00.52.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Dec 2024 00:52:24 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 2/2] hw/usb/hcd-xhci-pci: Add TI TUSB73X0 XHCI controller
 model
Date: Thu, 12 Dec 2024 18:52:07 +1000
Message-ID: <20241212085207.1439501-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241212085207.1439501-1-npiggin@gmail.com>
References: <20241212085207.1439501-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x633.google.com
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

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 include/hw/pci/pci_ids.h        |  1 +
 include/hw/usb/xhci.h           |  1 +
 hw/usb/hcd-xhci-ti.c            | 92 +++++++++++++++++++++++++++++++++
 tests/qtest/usb-hcd-xhci-test.c | 21 +++++---
 hw/usb/Kconfig                  |  5 ++
 hw/usb/meson.build              |  1 +
 6 files changed, 115 insertions(+), 6 deletions(-)
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
index 00000000000..6d4b44f6aaf
--- /dev/null
+++ b/hw/usb/hcd-xhci-ti.c
@@ -0,0 +1,92 @@
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
+    /*< private >*/
+    XHCIPciState parent_obj;
+    /*< public >*/
+    uint32_t intrs;
+    uint32_t slots;
+};
+
+static Property ti_xhci_properties[] = {
+    DEFINE_PROP_ON_OFF_AUTO("msi", XHCIPciState, msi, ON_OFF_AUTO_AUTO),
+    DEFINE_PROP_ON_OFF_AUTO("msix", XHCIPciState, msix, ON_OFF_AUTO_AUTO),
+    DEFINE_PROP_UINT32("intrs", XHCITiState, intrs, 8),
+    DEFINE_PROP_UINT32("slots", XHCITiState, slots, XHCI_MAXSLOTS),
+    DEFINE_PROP_END_OF_LIST(),
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
index 93614e55461..d4a0d8cc217 100644
--- a/tests/qtest/usb-hcd-xhci-test.c
+++ b/tests/qtest/usb-hcd-xhci-test.c
@@ -59,6 +59,9 @@ typedef struct XHCIQState {
 #define XHCI_NEC_ID (PCI_DEVICE_ID_NEC_UPD720200 << 16 | \
                      PCI_VENDOR_ID_NEC)
 
+#define XHCI_TI_ID  (PCI_DEVICE_ID_TI_TUSB73X0 << 16 | \
+                     PCI_VENDOR_ID_TI)
+
 /**
  * Locate, verify, and return a handle to the XHCI device.
  */
@@ -78,6 +81,8 @@ static QPCIDevice *get_xhci_device(QTestState *qts, uint32_t *fingerprint)
     switch (xhci_fingerprint) {
     case XHCI_NEC_ID:
         break;
+    case XHCI_TI_ID:
+        break;
     default:
         /* Unknown device. */
         g_assert_not_reached();
@@ -134,11 +139,12 @@ static XHCIQState *xhci_boot(const char *cli, ...)
         va_end(ap);
     } else {
         s = xhci_boot("-M q35 "
-                      "-device nec-usb-xhci,id=xhci,bus=pcie.0,addr=1d.0 "
+                      "-device %s,id=xhci,bus=pcie.0,addr=1d.0 "
                       "-drive id=drive0,if=none,file=null-co://,"
-                          "file.read-zeroes=on,format=raw");
+                          "file.read-zeroes=on,format=raw",
+                      qtest_has_device("ti-usb-xhci") ?
+                          "ti-usb-xhci" : "nec-usb-xhci");
     }
-
     return s;
 }
 
@@ -392,10 +398,12 @@ static void pci_xhci_stress_rings(void)
     int i;
 
     s = xhci_boot("-M q35 "
-            "-device nec-usb-xhci,id=xhci,bus=pcie.0,addr=1d.0 "
+            "-device %s,id=xhci,bus=pcie.0,addr=1d.0 "
             "-device usb-storage,bus=xhci.0,drive=drive0 "
             "-drive id=drive0,if=none,file=null-co://,"
-                "file.read-zeroes=on,format=raw "
+                "file.read-zeroes=on,format=raw ",
+            qtest_has_device("ti-usb-xhci") ?
+                "ti-usb-xhci" : "nec-usb-xhci"
             );
 
     hcsparams1 = xhci_cap_readl(s, 0x4); /* HCSPARAMS1 */
@@ -567,7 +575,8 @@ int main(int argc, char **argv)
         return 0;
     }
 
-    if (!qtest_has_device("nec-usb-xhci")) {
+    if (!qtest_has_device("nec-usb-xhci") &&
+        !qtest_has_device("ti-usb-xhci")) {
         return 0;
     }
 
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


