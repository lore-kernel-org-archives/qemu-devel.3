Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BAFEC54764
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 08:57:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcLuS-0006kx-4l; Tue, 20 Feb 2024 03:55:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rcLuL-00060e-3H
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 03:55:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rcLuI-0000EF-9Y
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 03:55:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708419317;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EOiW8q7P4pzVVYwIaTT/LehnKlk46W0+av4ne1E04p0=;
 b=KigbNH/k59oDEQJEU5VHBKjjlR9x2XlJ22wY+H9P2gcv4Vvjy0FfD/JkD7dONoIlONE/hm
 esx1D+co78/VMjlvY+EPi5FejJjuZjGjuXxIrHthaAHRbfsKMfyPCatVwjJvXq5UHevOBi
 BcAoQdzOcE04sQK8bZazaRBVTv8rCIw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-23VwSxKhN96O42tTYRtH0Q-1; Tue, 20 Feb 2024 03:55:13 -0500
X-MC-Unique: 23VwSxKhN96O42tTYRtH0Q-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8E5DD185A78E;
 Tue, 20 Feb 2024 08:55:13 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.168])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AFA15492BE2;
 Tue, 20 Feb 2024 08:55:11 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: John Snow <jsnow@redhat.com>,
	qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-block@nongnu.org
Subject: [PATCH v2 2/7] hw/ide: Split qdev.c into ide-bus.c and ide-dev.c
Date: Tue, 20 Feb 2024 09:55:00 +0100
Message-ID: <20240220085505.30255-3-thuth@redhat.com>
In-Reply-To: <20240220085505.30255-1-thuth@redhat.com>
References: <20240220085505.30255-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.072,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

qdev.c is a mixture between IDE bus specific functions and IDE device
functions. Let's split it up to make it more obvious which part is
related to bus handling and which part is related to device handling.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
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
2.43.2


