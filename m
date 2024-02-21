Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDAB0C5478A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 21:22:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rctzi-0003GV-Ns; Wed, 21 Feb 2024 16:19:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rctzS-0001Yc-GK
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 16:18:55 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rctzP-0001G3-Ce
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 16:18:54 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-41278553016so7281805e9.2
 for <qemu-devel@nongnu.org>; Wed, 21 Feb 2024 13:18:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708550329; x=1709155129; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8/bWYrGiGEWbiVuhkyiTI2lY8MFAALvypRNrUgC8WXQ=;
 b=M6GoplIu/4g4e/IxtZiQHiQW2XL8OauYwCApC45ZYurAvJAWNZ4bPBy1ojnnolz6Qe
 /0PWFkwb9/4pFkOEJf5jyOJh6tVFt32XW0foHG1GtzlVJ2l43QxoelRpntYnzK5R15oC
 WGcm4jFh2yoJwaReRJgdXg/7wPX5h5aSihI9SFyNAsi2s/bBedV9roG0Q7BJQKpYXVf0
 CvB+5JLeNnyx0EFeO8BiDFWyDuL49VNSD3aFEH1UaRPZm8hPeKg3rZv+ODGma3svG8cW
 UMa06RedVY4wfs8jwbPCkrSs5S0WzgjR6m/dt7bqSNdvWuYIsdDRL8bsV4JoiRVr9Y3t
 aGSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708550329; x=1709155129;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8/bWYrGiGEWbiVuhkyiTI2lY8MFAALvypRNrUgC8WXQ=;
 b=u5/WQWepTQzGntiDTfaA9iWaQt6p2x+EhogLUT+xtZg8OlHR+BM+5YvtXwkSDfO5fD
 MrQks/oMtm1DatbW/F+Q/GoGTToazReS2c6a2LWxNenLVDcHbVzx5i6VV1SrDjnO0Ik0
 Cxl14CXYlL0AADi/YJRHx10RWMQSV0w0IvOypCwrf4MTppK1oJW5HfPg6d2oZTTx3V/a
 jflRv8PTy3Rp0tfEwj733X5nY4++RDO062MVVlJgiM3fBvIWe5/JFk0+E32Ec5wsrW7J
 fDGCBxCsvxIw1J1WT0AGUoLrYkbOEjoIkHSPg1ve9p/uyb2v6DmgeRTzeIk+x3Wrsb9a
 ngjg==
X-Gm-Message-State: AOJu0YycgTLJQeF/Ou7SJa+TX2s1bLib/g05wUiJjt6hdrHFL9EhUgyu
 90jh5hBnRleuBPO80RTKdj5K8VtsmppTymDmtEFF0stacrQFFV8JuALSxFUjPDLOotiNSyzbVhi
 mQpA=
X-Google-Smtp-Source: AGHT+IExIkDxL7ccgo+Yr3grPpKEh0AY/Xt6vjnSBuBu2nNrL+hmOFf/n4Dp9IAaZCt/EacX9AQxYA==
X-Received: by 2002:a05:600c:35d2:b0:410:8ab6:8c72 with SMTP id
 r18-20020a05600c35d200b004108ab68c72mr13531087wmq.31.1708550329348; 
 Wed, 21 Feb 2024 13:18:49 -0800 (PST)
Received: from m1x-phil.lan ([176.187.211.34])
 by smtp.gmail.com with ESMTPSA id
 d2-20020adfef82000000b0033b75b39aebsm18035057wro.11.2024.02.21.13.18.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 21 Feb 2024 13:18:48 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-block@nongnu.org, qemu-ppc@nongnu.org,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, John Snow <jsnow@redhat.com>
Subject: [PULL 19/25] hw/ide: Split qdev.c into ide-bus.c and ide-dev.c
Date: Wed, 21 Feb 2024 22:16:19 +0100
Message-ID: <20240221211626.48190-20-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240221211626.48190-1-philmd@linaro.org>
References: <20240221211626.48190-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

From: Thomas Huth <thuth@redhat.com>

qdev.c is a mixture between IDE bus specific functions and IDE device
functions. Let's split it up to make it more obvious which part is
related to bus handling and which part is related to device handling.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Acked-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <20240220085505.30255-3-thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/ide/ide-bus.c             | 111 +++++++++++++++++++++++++++++++++++
 hw/ide/{qdev.c => ide-dev.c} |  87 +--------------------------
 hw/arm/Kconfig               |   2 +
 hw/ide/Kconfig               |  30 ++++++----
 hw/ide/meson.build           |   3 +-
 5 files changed, 134 insertions(+), 99 deletions(-)
 create mode 100644 hw/ide/ide-bus.c
 rename hw/ide/{qdev.c => ide-dev.c} (78%)

diff --git a/hw/ide/ide-bus.c b/hw/ide/ide-bus.c
new file mode 100644
index 0000000000..57fe67b29c
--- /dev/null
+++ b/hw/ide/ide-bus.c
@@ -0,0 +1,111 @@
+/*
+ * ide bus support for qdev.
+ *
+ * Copyright (c) 2009 Gerd Hoffmann <kraxel@redhat.com>
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
+#include "qapi/error.h"
+#include "qemu/error-report.h"
+#include "qemu/module.h"
+#include "hw/ide/internal.h"
+#include "sysemu/block-backend.h"
+#include "sysemu/blockdev.h"
+#include "sysemu/runstate.h"
+
+static char *idebus_get_fw_dev_path(DeviceState *dev);
+static void idebus_unrealize(BusState *qdev);
+
+static void ide_bus_class_init(ObjectClass *klass, void *data)
+{
+    BusClass *k = BUS_CLASS(klass);
+
+    k->get_fw_dev_path = idebus_get_fw_dev_path;
+    k->unrealize = idebus_unrealize;
+}
+
+static void idebus_unrealize(BusState *bus)
+{
+    IDEBus *ibus = IDE_BUS(bus);
+
+    if (ibus->vmstate) {
+        qemu_del_vm_change_state_handler(ibus->vmstate);
+    }
+}
+
+static const TypeInfo ide_bus_info = {
+    .name = TYPE_IDE_BUS,
+    .parent = TYPE_BUS,
+    .instance_size = sizeof(IDEBus),
+    .class_init = ide_bus_class_init,
+};
+
+void ide_bus_init(IDEBus *idebus, size_t idebus_size, DeviceState *dev,
+                 int bus_id, int max_units)
+{
+    qbus_init(idebus, idebus_size, TYPE_IDE_BUS, dev, NULL);
+    idebus->bus_id = bus_id;
+    idebus->max_units = max_units;
+}
+
+static char *idebus_get_fw_dev_path(DeviceState *dev)
+{
+    char path[30];
+
+    snprintf(path, sizeof(path), "%s@%x", qdev_fw_name(dev),
+             ((IDEBus *)dev->parent_bus)->bus_id);
+
+    return g_strdup(path);
+}
+
+IDEDevice *ide_bus_create_drive(IDEBus *bus, int unit, DriveInfo *drive)
+{
+    DeviceState *dev;
+
+    dev = qdev_new(drive->media_cd ? "ide-cd" : "ide-hd");
+    qdev_prop_set_uint32(dev, "unit", unit);
+    qdev_prop_set_drive_err(dev, "drive", blk_by_legacy_dinfo(drive),
+                            &error_fatal);
+    qdev_realize_and_unref(dev, &bus->qbus, &error_fatal);
+    return DO_UPCAST(IDEDevice, qdev, dev);
+}
+
+int ide_get_geometry(BusState *bus, int unit,
+                     int16_t *cyls, int8_t *heads, int8_t *secs)
+{
+    IDEState *s = &DO_UPCAST(IDEBus, qbus, bus)->ifs[unit];
+
+    if (s->drive_kind != IDE_HD || !s->blk) {
+        return -1;
+    }
+
+    *cyls = s->cylinders;
+    *heads = s->heads;
+    *secs = s->sectors;
+    return 0;
+}
+
+int ide_get_bios_chs_trans(BusState *bus, int unit)
+{
+    return DO_UPCAST(IDEBus, qbus, bus)->ifs[unit].chs_trans;
+}
+
+static void ide_bus_register_type(void)
+{
+    type_register_static(&ide_bus_info);
+}
+
+type_init(ide_bus_register_type)
diff --git a/hw/ide/qdev.c b/hw/ide/ide-dev.c
similarity index 78%
rename from hw/ide/qdev.c
rename to hw/ide/ide-dev.c
index 4189313d30..15d088fd06 100644
--- a/hw/ide/qdev.c
+++ b/hw/ide/ide-dev.c
@@ -1,5 +1,5 @@
 /*
- * ide bus support for qdev.
+ * IDE device functions
  *
  * Copyright (c) 2009 Gerd Hoffmann <kraxel@redhat.com>
  *
@@ -18,71 +18,21 @@
  */
 
 #include "qemu/osdep.h"
-#include "sysemu/dma.h"
 #include "qapi/error.h"
 #include "qapi/qapi-types-block.h"
 #include "qemu/error-report.h"
-#include "qemu/main-loop.h"
 #include "qemu/module.h"
 #include "hw/ide/ide-dev.h"
 #include "sysemu/block-backend.h"
 #include "sysemu/blockdev.h"
 #include "sysemu/sysemu.h"
-#include "sysemu/runstate.h"
 #include "qapi/visitor.h"
 
-/* --------------------------------- */
-
-static char *idebus_get_fw_dev_path(DeviceState *dev);
-static void idebus_unrealize(BusState *qdev);
-
 static Property ide_props[] = {
     DEFINE_PROP_UINT32("unit", IDEDevice, unit, -1),
     DEFINE_PROP_END_OF_LIST(),
 };
 
-static void ide_bus_class_init(ObjectClass *klass, void *data)
-{
-    BusClass *k = BUS_CLASS(klass);
-
-    k->get_fw_dev_path = idebus_get_fw_dev_path;
-    k->unrealize = idebus_unrealize;
-}
-
-static void idebus_unrealize(BusState *bus)
-{
-    IDEBus *ibus = IDE_BUS(bus);
-
-    if (ibus->vmstate) {
-        qemu_del_vm_change_state_handler(ibus->vmstate);
-    }
-}
-
-static const TypeInfo ide_bus_info = {
-    .name = TYPE_IDE_BUS,
-    .parent = TYPE_BUS,
-    .instance_size = sizeof(IDEBus),
-    .class_init = ide_bus_class_init,
-};
-
-void ide_bus_init(IDEBus *idebus, size_t idebus_size, DeviceState *dev,
-                 int bus_id, int max_units)
-{
-    qbus_init(idebus, idebus_size, TYPE_IDE_BUS, dev, NULL);
-    idebus->bus_id = bus_id;
-    idebus->max_units = max_units;
-}
-
-static char *idebus_get_fw_dev_path(DeviceState *dev)
-{
-    char path[30];
-
-    snprintf(path, sizeof(path), "%s@%x", qdev_fw_name(dev),
-             ((IDEBus*)dev->parent_bus)->bus_id);
-
-    return g_strdup(path);
-}
-
 static void ide_qdev_realize(DeviceState *qdev, Error **errp)
 {
     IDEDevice *dev = IDE_DEVICE(qdev);
@@ -121,40 +71,6 @@ static void ide_qdev_realize(DeviceState *qdev, Error **errp)
     dc->realize(dev, errp);
 }
 
-IDEDevice *ide_bus_create_drive(IDEBus *bus, int unit, DriveInfo *drive)
-{
-    DeviceState *dev;
-
-    dev = qdev_new(drive->media_cd ? "ide-cd" : "ide-hd");
-    qdev_prop_set_uint32(dev, "unit", unit);
-    qdev_prop_set_drive_err(dev, "drive", blk_by_legacy_dinfo(drive),
-                            &error_fatal);
-    qdev_realize_and_unref(dev, &bus->qbus, &error_fatal);
-    return DO_UPCAST(IDEDevice, qdev, dev);
-}
-
-int ide_get_geometry(BusState *bus, int unit,
-                     int16_t *cyls, int8_t *heads, int8_t *secs)
-{
-    IDEState *s = &DO_UPCAST(IDEBus, qbus, bus)->ifs[unit];
-
-    if (s->drive_kind != IDE_HD || !s->blk) {
-        return -1;
-    }
-
-    *cyls = s->cylinders;
-    *heads = s->heads;
-    *secs = s->sectors;
-    return 0;
-}
-
-int ide_get_bios_chs_trans(BusState *bus, int unit)
-{
-    return DO_UPCAST(IDEBus, qbus, bus)->ifs[unit].chs_trans;
-}
-
-/* --------------------------------- */
-
 void ide_dev_initfn(IDEDevice *dev, IDEDriveKind kind, Error **errp)
 {
     IDEBus *bus = DO_UPCAST(IDEBus, qbus, dev->qdev.parent_bus);
@@ -347,7 +263,6 @@ static const TypeInfo ide_device_type_info = {
 
 static void ide_register_types(void)
 {
-    type_register_static(&ide_bus_info);
     type_register_static(&ide_hd_info);
     type_register_static(&ide_cd_info);
     type_register_static(&ide_device_type_info);
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 29abe1da29..b372b819a4 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -275,6 +275,8 @@ config SBSA_REF
     select USB_XHCI_SYSBUS
     select WDT_SBSA
     select BOCHS_DISPLAY
+    select IDE_BUS
+    select IDE_DEV
 
 config SABRELITE
     bool
diff --git a/hw/ide/Kconfig b/hw/ide/Kconfig
index b93d6743d5..6dfc5a2129 100644
--- a/hw/ide/Kconfig
+++ b/hw/ide/Kconfig
@@ -1,51 +1,58 @@
 config IDE_CORE
     bool
 
-config IDE_QDEV
+config IDE_BUS
     bool
     select IDE_CORE
 
+config IDE_DEV
+    bool
+    depends on IDE_BUS
+
 config IDE_PCI
     bool
     depends on PCI
-    select IDE_QDEV
+    select IDE_BUS
+    select IDE_DEV
 
 config IDE_ISA
     bool
     depends on ISA_BUS
-    select IDE_QDEV
+    select IDE_BUS
+    select IDE_DEV
 
 config IDE_PIIX
     bool
     select IDE_PCI
-    select IDE_QDEV
 
 config IDE_CMD646
     bool
     select IDE_PCI
-    select IDE_QDEV
 
 config IDE_MACIO
     bool
-    select IDE_QDEV
+    select IDE_BUS
+    select IDE_DEV
 
 config IDE_MMIO
     bool
-    select IDE_QDEV
+    select IDE_BUS
+    select IDE_DEV
 
 config IDE_VIA
     bool
     select IDE_PCI
-    select IDE_QDEV
 
 config MICRODRIVE
     bool
-    select IDE_QDEV
+    select IDE_BUS
+    select IDE_DEV
     depends on PCMCIA
 
 config AHCI
     bool
-    select IDE_QDEV
+    select IDE_BUS
+    select IDE_DEV
 
 config AHCI_ICH9
     bool
@@ -56,8 +63,7 @@ config AHCI_ICH9
 config IDE_SII3112
     bool
     select IDE_PCI
-    select IDE_QDEV
 
 config IDE_CF
     bool
-    default y if IDE_QDEV
+    default y if IDE_BUS
diff --git a/hw/ide/meson.build b/hw/ide/meson.build
index d2e5b45c9e..d09705cac0 100644
--- a/hw/ide/meson.build
+++ b/hw/ide/meson.build
@@ -1,15 +1,16 @@
 system_ss.add(when: 'CONFIG_AHCI', if_true: files('ahci.c'))
 system_ss.add(when: 'CONFIG_AHCI_ICH9', if_true: files('ich.c'))
 system_ss.add(when: 'CONFIG_ALLWINNER_A10', if_true: files('ahci-allwinner.c'))
+system_ss.add(when: 'CONFIG_IDE_BUS', if_true: files('ide-bus.c'))
 system_ss.add(when: 'CONFIG_IDE_CF', if_true: files('cf.c'))
 system_ss.add(when: 'CONFIG_IDE_CMD646', if_true: files('cmd646.c'))
 system_ss.add(when: 'CONFIG_IDE_CORE', if_true: files('core.c', 'atapi.c'))
+system_ss.add(when: 'CONFIG_IDE_DEV', if_true: files('ide-dev.c'))
 system_ss.add(when: 'CONFIG_IDE_ISA', if_true: files('isa.c', 'ioport.c'))
 system_ss.add(when: 'CONFIG_IDE_MACIO', if_true: files('macio.c'))
 system_ss.add(when: 'CONFIG_IDE_MMIO', if_true: files('mmio.c'))
 system_ss.add(when: 'CONFIG_IDE_PCI', if_true: files('pci.c'))
 system_ss.add(when: 'CONFIG_IDE_PIIX', if_true: files('piix.c', 'ioport.c'))
-system_ss.add(when: 'CONFIG_IDE_QDEV', if_true: files('qdev.c'))
 system_ss.add(when: 'CONFIG_IDE_SII3112', if_true: files('sii3112.c'))
 system_ss.add(when: 'CONFIG_IDE_VIA', if_true: files('via.c'))
 system_ss.add(when: 'CONFIG_MICRODRIVE', if_true: files('microdrive.c'))
-- 
2.41.0


