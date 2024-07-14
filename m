Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 558A9C3DA49
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jul 2024 07:49:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sStyv-0005LI-Jj; Sun, 14 Jul 2024 03:49:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sStyr-0005Hw-IR
 for qemu-devel@nongnu.org; Sun, 14 Jul 2024 03:49:14 -0400
Received: from mail-ua1-x933.google.com ([2607:f8b0:4864:20::933])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sStyp-0007fJ-5i
 for qemu-devel@nongnu.org; Sun, 14 Jul 2024 03:49:13 -0400
Received: by mail-ua1-x933.google.com with SMTP id
 a1e0cc1a2514c-810418672f9so1213498241.1
 for <qemu-devel@nongnu.org>; Sun, 14 Jul 2024 00:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1720943350; x=1721548150;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=98E8dJlFqRnilc3EcOnsbhM2ggIX+Do5H9shCOBykdE=;
 b=Mql1bZ8HFmW4bYLuO7u80idpwaOoPIs8+ptKDHVfDjrMXklcWQZ85dwi+2sDN+lFLu
 pnM/SwnVkgmLmeRJWtN+i1RUujbJWXFMK1DGCCd7ry7EsTSt8nsDyTn4EE1g1BXz2r7p
 ilQXgQG7NO5DsrYRK23wdzP6/+R9Pn9gMOz3BnXlgaYuUQpdKt9W/G2O3XeGGrOS2MHv
 u9xsmTjI2Muyk6FGYUzH0zMAdr+GEtPZYXvKrIL+j4/RUgqfuCNXySkGlQsecSdut/7c
 2bWQfdL6igjNVkFQZm836M4GtFyga5UoQWvqJUtWV8adBFnfWQMCz5iPZGB6w6v6s/Jo
 4lfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720943350; x=1721548150;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=98E8dJlFqRnilc3EcOnsbhM2ggIX+Do5H9shCOBykdE=;
 b=q1OfeSH9fvHs51tubafnFQvmZaQOBXeZcsgH2zGondD/waDRjccdTNJCj/ZsZcoyyM
 J1jnlA73x5m9MU+uiPjhKKo4Ya/K09ubaholPsNVksuPEdyUQwpxodeq4YYha7maVYK0
 9spIaibB6YsyXn6bFBVjz1zjxVWwCi29E6mgSlZcA8NjjwXwOB/zesTmGaBTevvj/RvT
 TksRLQ1NAMYCljTNAo+F10pcAUAmI5o8TjBnsorEhQ3W/2LmANwskIJDnrbCyLsWUhO+
 6JRAC0XdLzHsEbPMfdXjrNE6+rPsHVMlHTeg6iUZQx9bH5VH3in+METt0NrwQPQQft7m
 Li7w==
X-Gm-Message-State: AOJu0YziUkD6CurjQSHPSD/mfIFJ5udSbEBBoYkoTbpxkkcHYUCW1v+S
 4KVIeQwA8ysnBlwQ1SxmoQu16QEsPmK34asDGZ/tCEN7eBh2O+ZX/P58UPfBeaI=
X-Google-Smtp-Source: AGHT+IFHRqceqA90G09KSQ0EhV+eyEA9xYfaE5iTpHjEDPo2TmkBZcHB6d7yj1i3X1jb4IrN3nknXQ==
X-Received: by 2002:a05:6102:3e84:b0:491:110e:cb03 with SMTP id
 ada2fe7eead31-491110ece05mr11502911137.32.1720943349951; 
 Sun, 14 Jul 2024 00:49:09 -0700 (PDT)
Received: from localhost ([157.82.204.135])
 by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-70b7eb9c856sm2211238b3a.4.2024.07.14.00.49.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 14 Jul 2024 00:49:09 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sun, 14 Jul 2024 16:48:33 +0900
Subject: [PATCH v2 3/4] hw/pci: Convert rom_bar into OnOffAuto
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240714-rombar-v2-3-af1504ef55de@daynix.com>
References: <20240714-rombar-v2-0-af1504ef55de@daynix.com>
In-Reply-To: <20240714-rombar-v2-0-af1504ef55de@daynix.com>
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, 
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, 
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>, 
 Klaus Jensen <its@irrelevant.dk>, Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::933;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-ua1-x933.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

rom_bar is tristate but was defined as uint32_t so convert it into
OnOffAuto to clarify that. For compatibility, a uint32 value set via
QOM will be converted into OnOffAuto.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 docs/about/deprecated.rst         |  7 +++++
 docs/igd-assign.txt               |  2 +-
 include/hw/pci/pci_device.h       |  2 +-
 hw/pci/pci.c                      | 57 +++++++++++++++++++++++++++++++++++++--
 hw/vfio/pci-quirks.c              |  2 +-
 hw/vfio/pci.c                     | 11 ++++----
 hw/xen/xen_pt_load_rom.c          |  4 +--
 tests/qtest/virtio-net-failover.c | 32 +++++++++++-----------
 8 files changed, 88 insertions(+), 29 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 20b7a17cf07e..ac8d40fd0e84 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -389,6 +389,13 @@ recommending to switch to their stable counterparts:
 SD physical layer specification v2.00 supersedes the v1.10 one.
 v2.00 is the default since QEMU 3.0.0.
 
+Integer specification of PCI device's ``rombar`` property (since 9.1)
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+Specifying an integer for the ``rombar`` property of a PCI device is being
+deprecated starting in 9.1 due to obscurity of such an specification. Replace
+zero with ``off`` and a non-zero value with ``on``, respectively.
+
 Block device options
 ''''''''''''''''''''
 
diff --git a/docs/igd-assign.txt b/docs/igd-assign.txt
index e17bb50789ad..35c6c8e28493 100644
--- a/docs/igd-assign.txt
+++ b/docs/igd-assign.txt
@@ -35,7 +35,7 @@ IGD has two different modes for assignment using vfio-pci:
       ISA/LPC bridge device (vfio-pci-igd-lpc-bridge) on the root bus at
       PCI address 1f.0.
     * The IGD device must have a VGA ROM, either provided via the romfile
-      option or loaded automatically through vfio (standard).  rombar=0
+      option or loaded automatically through vfio (standard).  rombar=off
       will disable legacy mode support.
     * Hotplug of the IGD device is not supported.
     * The IGD device must be a SandyBridge or newer model device.
diff --git a/include/hw/pci/pci_device.h b/include/hw/pci/pci_device.h
index ca151325085d..49b341ce2e27 100644
--- a/include/hw/pci/pci_device.h
+++ b/include/hw/pci/pci_device.h
@@ -147,7 +147,7 @@ struct PCIDevice {
     uint32_t romsize;
     bool has_rom;
     MemoryRegion rom;
-    uint32_t rom_bar;
+    OnOffAuto rom_bar;
 
     /* INTx routing notifier */
     PCIINTxRoutingNotifier intx_routing_notifier;
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 4c7be5295110..ca8fb5383765 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -67,11 +67,64 @@ static char *pcibus_get_fw_dev_path(DeviceState *dev);
 static void pcibus_reset_hold(Object *obj, ResetType type);
 static bool pcie_has_upstream_port(PCIDevice *dev);
 
+static void rom_bar_get(Object *obj, Visitor *v, const char *name, void *opaque,
+                        Error **errp)
+{
+    Property *prop = opaque;
+    int *ptr = object_field_prop_ptr(obj, prop);
+
+    visit_type_enum(v, name, ptr, prop->info->enum_table, errp);
+}
+
+static void rom_bar_set(Object *obj, Visitor *v, const char *name, void *opaque,
+                        Error **errp)
+{
+    Property *prop = opaque;
+    Error *local_err = NULL;
+    int *ptr = object_field_prop_ptr(obj, prop);
+    uint32_t value;
+
+    visit_type_enum(v, name, ptr, prop->info->enum_table, &local_err);
+    if (!local_err) {
+        return;
+    }
+
+    if (visit_type_uint32(v, name, &value, NULL)) {
+        if (value) {
+            *ptr = ON_OFF_AUTO_ON;
+            warn_report("Specifying a number for rombar is deprecated; replace a non-zero value with 'on'");
+        } else {
+            *ptr = ON_OFF_AUTO_OFF;
+            warn_report("Specifying a number for rombar is deprecated; replace 0 with 'off'");
+        }
+
+        return;
+    }
+
+    error_propagate(errp, local_err);
+}
+
+static void rom_bar_set_default_value(ObjectProperty *op, const Property *prop)
+{
+    object_property_set_default_str(op,
+        qapi_enum_lookup(prop->info->enum_table, prop->defval.i));
+}
+
+static const PropertyInfo qdev_prop_rom_bar = {
+    .name = "OnOffAuto",
+    .description = "on/off/auto",
+    .enum_table = &OnOffAuto_lookup,
+    .get = rom_bar_get,
+    .set = rom_bar_set,
+    .set_default_value = rom_bar_set_default_value,
+};
+
 static Property pci_props[] = {
     DEFINE_PROP_PCI_DEVFN("addr", PCIDevice, devfn, -1),
     DEFINE_PROP_STRING("romfile", PCIDevice, romfile),
     DEFINE_PROP_UINT32("romsize", PCIDevice, romsize, UINT32_MAX),
-    DEFINE_PROP_UINT32("rombar",  PCIDevice, rom_bar, 1),
+    DEFINE_PROP_SIGNED("rombar",  PCIDevice, rom_bar, ON_OFF_AUTO_AUTO,
+                       qdev_prop_rom_bar, OnOffAuto),
     DEFINE_PROP_BIT("multifunction", PCIDevice, cap_present,
                     QEMU_PCI_CAP_MULTIFUNCTION_BITNR, false),
     DEFINE_PROP_BIT("x-pcie-lnksta-dllla", PCIDevice, cap_present,
@@ -2334,7 +2387,7 @@ static void pci_add_option_rom(PCIDevice *pdev, bool is_default_rom,
         return;
     }
 
-    if (!pdev->rom_bar) {
+    if (pdev->rom_bar == ON_OFF_AUTO_OFF) {
         /*
          * Load rom via fw_cfg instead of creating a rom bar,
          * for 0.11 compatibility.
diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
index 39dae72497e0..0e920ed0691a 100644
--- a/hw/vfio/pci-quirks.c
+++ b/hw/vfio/pci-quirks.c
@@ -33,7 +33,7 @@
  * execution as noticed with the BCM 57810 card for lack of a
  * more better way to handle such issues.
  * The  user can still override by specifying a romfile or
- * rombar=1.
+ * rombar=on.
  * Please see https://bugs.launchpad.net/qemu/+bug/1284874
  * for an analysis of the 57810 card hang. When adding
  * a new vendor id/device id combination below, please also add
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index e03d9f3ba546..502ee2ed0489 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -902,7 +902,7 @@ static void vfio_pci_load_rom(VFIOPCIDevice *vdev)
         error_report("vfio-pci: Cannot read device rom at "
                     "%s", vdev->vbasedev.name);
         error_printf("Device option ROM contents are probably invalid "
-                    "(check dmesg).\nSkip option ROM probe with rombar=0, "
+                    "(check dmesg).\nSkip option ROM probe with rombar=off, "
                     "or load from file with romfile=\n");
         return;
     }
@@ -1012,11 +1012,10 @@ static void vfio_pci_size_rom(VFIOPCIDevice *vdev)
 {
     uint32_t orig, size = cpu_to_le32((uint32_t)PCI_ROM_ADDRESS_MASK);
     off_t offset = vdev->config_offset + PCI_ROM_ADDRESS;
-    DeviceState *dev = DEVICE(vdev);
     char *name;
     int fd = vdev->vbasedev.fd;
 
-    if (vdev->pdev.romfile || !vdev->pdev.rom_bar) {
+    if (vdev->pdev.romfile || vdev->pdev.rom_bar == ON_OFF_AUTO_OFF) {
         /* Since pci handles romfile, just print a message and return */
         if (vfio_opt_rom_in_denylist(vdev) && vdev->pdev.romfile) {
             warn_report("Device at %s is known to cause system instability"
@@ -1046,17 +1045,17 @@ static void vfio_pci_size_rom(VFIOPCIDevice *vdev)
     }
 
     if (vfio_opt_rom_in_denylist(vdev)) {
-        if (dev->opts && qdict_haskey(dev->opts, "rombar")) {
+        if (vdev->pdev.rom_bar == ON_OFF_AUTO_ON) {
             warn_report("Device at %s is known to cause system instability"
                         " issues during option rom execution",
                         vdev->vbasedev.name);
             error_printf("Proceeding anyway since user specified"
-                         " non zero value for rombar\n");
+                         " on for rombar\n");
         } else {
             warn_report("Rom loading for device at %s has been disabled"
                         " due to system instability issues",
                         vdev->vbasedev.name);
-            error_printf("Specify rombar=1 or romfile to force\n");
+            error_printf("Specify rombar=on or romfile to force\n");
             return;
         }
     }
diff --git a/hw/xen/xen_pt_load_rom.c b/hw/xen/xen_pt_load_rom.c
index 6bc64acd3352..025a6b25a916 100644
--- a/hw/xen/xen_pt_load_rom.c
+++ b/hw/xen/xen_pt_load_rom.c
@@ -26,7 +26,7 @@ void *pci_assign_dev_load_option_rom(PCIDevice *dev,
     Object *owner = OBJECT(dev);
 
     /* If loading ROM from file, pci handles it */
-    if (dev->romfile || !dev->rom_bar) {
+    if (dev->romfile || dev->rom_bar == ON_OFF_AUTO_OFF) {
         return NULL;
     }
 
@@ -71,7 +71,7 @@ void *pci_assign_dev_load_option_rom(PCIDevice *dev,
     if (!fread(ptr, 1, st.st_size, fp)) {
         error_report("pci-assign: Cannot read from host %s", rom_file);
         error_printf("Device option ROM contents are probably invalid "
-                     "(check dmesg).\nSkip option ROM probe with rombar=0, "
+                     "(check dmesg).\nSkip option ROM probe with rombar=off, "
                      "or load from file with romfile=\n");
         goto close_rom;
     }
diff --git a/tests/qtest/virtio-net-failover.c b/tests/qtest/virtio-net-failover.c
index 73dfabc2728b..f65b97683fb6 100644
--- a/tests/qtest/virtio-net-failover.c
+++ b/tests/qtest/virtio-net-failover.c
@@ -568,7 +568,7 @@ static void test_hotplug_2_reverse(void)
                          "{'bus': 'root0',"
                          "'failover': true,"
                          "'netdev': 'hs0',"
-                         "'rombar': 0,"
+                         "'rombar': 'off',"
                          "'romfile': '',"
                          "'mac': '"MAC_STANDBY0"'}");
 
@@ -655,7 +655,7 @@ static void test_migrate_out(gconstpointer opaque)
                          "{'bus': 'root1',"
                          "'failover_pair_id': 'standby0',"
                          "'netdev': 'hs1',"
-                         "'rombar': 0,"
+                         "'rombar': 'off',"
                          "'romfile': '',"
                          "'mac': '"MAC_PRIMARY0"'}");
 
@@ -765,7 +765,7 @@ static void test_migrate_in(gconstpointer opaque)
                          "{'bus': 'root1',"
                          "'failover_pair_id': 'standby0',"
                          "'netdev': 'hs1',"
-                         "'rombar': 0,"
+                         "'rombar': 'off',"
                          "'romfile': '',"
                          "'mac': '"MAC_PRIMARY0"'}");
 
@@ -819,7 +819,7 @@ static void test_off_migrate_out(gconstpointer opaque)
                          "{'bus': 'root1',"
                          "'failover_pair_id': 'standby0',"
                          "'netdev': 'hs1',"
-                         "'rombar': 0,"
+                         "'rombar': 'off',"
                          "'romfile': '',"
                          "'mac': '"MAC_PRIMARY0"'}");
 
@@ -887,7 +887,7 @@ static void test_off_migrate_in(gconstpointer opaque)
                          "{'bus': 'root1',"
                          "'failover_pair_id': 'standby0',"
                          "'netdev': 'hs1',"
-                         "'rombar': 0,"
+                         "'rombar': 'off',"
                          "'romfile': '',"
                          "'mac': '"MAC_PRIMARY0"'}");
 
@@ -938,7 +938,7 @@ static void test_guest_off_migrate_out(gconstpointer opaque)
                          "{'bus': 'root1',"
                          "'failover_pair_id': 'standby0',"
                          "'netdev': 'hs1',"
-                         "'rombar': 0,"
+                         "'rombar': 'off',"
                          "'romfile': '',"
                          "'mac': '"MAC_PRIMARY0"'}");
 
@@ -1014,7 +1014,7 @@ static void test_guest_off_migrate_in(gconstpointer opaque)
                          "{'bus': 'root1',"
                          "'failover_pair_id': 'standby0',"
                          "'netdev': 'hs1',"
-                         "'rombar': 0,"
+                         "'rombar': 'off',"
                          "'romfile': '',"
                          "'mac': '"MAC_PRIMARY0"'}");
 
@@ -1065,7 +1065,7 @@ static void test_migrate_guest_off_abort(gconstpointer opaque)
                          "{'bus': 'root1',"
                          "'failover_pair_id': 'standby0',"
                          "'netdev': 'hs1',"
-                         "'rombar': 0,"
+                         "'rombar': 'off',"
                          "'romfile': '',"
                          "'mac': '"MAC_PRIMARY0"'}");
 
@@ -1170,7 +1170,7 @@ static void test_migrate_abort_wait_unplug(gconstpointer opaque)
                          "{'bus': 'root1',"
                          "'failover_pair_id': 'standby0',"
                          "'netdev': 'hs1',"
-                         "'rombar': 0,"
+                         "'rombar': 'off',"
                          "'romfile': '',"
                          "'mac': '"MAC_PRIMARY0"'}");
 
@@ -1259,7 +1259,7 @@ static void test_migrate_abort_active(gconstpointer opaque)
                          "{'bus': 'root1',"
                          "'failover_pair_id': 'standby0',"
                          "'netdev': 'hs1',"
-                         "'rombar': 0,"
+                         "'rombar': 'off',"
                          "'romfile': '',"
                          "'mac': '"MAC_PRIMARY0"'}");
 
@@ -1358,7 +1358,7 @@ static void test_migrate_off_abort(gconstpointer opaque)
                          "{'bus': 'root1',"
                          "'failover_pair_id': 'standby0',"
                          "'netdev': 'hs1',"
-                         "'rombar': 0,"
+                         "'rombar': 'off',"
                          "'romfile': '',"
                          "'mac': '"MAC_PRIMARY0"'}");
 
@@ -1450,7 +1450,7 @@ static void test_migrate_abort_timeout(gconstpointer opaque)
                          "{'bus': 'root1',"
                          "'failover_pair_id': 'standby0',"
                          "'netdev': 'hs1',"
-                         "'rombar': 0,"
+                         "'rombar': 'off',"
                          "'romfile': '',"
                          "'mac': '"MAC_PRIMARY0"'}");
 
@@ -1543,7 +1543,7 @@ static void test_multi_out(gconstpointer opaque)
                          "{'bus': 'root1',"
                          "'failover_pair_id': 'standby0',"
                          "'netdev': 'hs1',"
-                         "'rombar': 0,"
+                         "'rombar': 'off',"
                          "'romfile': '',"
                          "'mac': '"MAC_PRIMARY0"'}");
 
@@ -1574,7 +1574,7 @@ static void test_multi_out(gconstpointer opaque)
                          "{'bus': 'root3',"
                          "'failover_pair_id': 'standby1',"
                          "'netdev': 'hs3',"
-                         "'rombar': 0,"
+                         "'rombar': 'off',"
                          "'romfile': '',"
                          "'mac': '"MAC_PRIMARY1"'}");
 
@@ -1713,7 +1713,7 @@ static void test_multi_in(gconstpointer opaque)
                          "{'bus': 'root1',"
                          "'failover_pair_id': 'standby0',"
                          "'netdev': 'hs1',"
-                         "'rombar': 0,"
+                         "'rombar': 'off',"
                          "'romfile': '',"
                          "'mac': '"MAC_PRIMARY0"'}");
 
@@ -1737,7 +1737,7 @@ static void test_multi_in(gconstpointer opaque)
                          "{'bus': 'root3',"
                          "'failover_pair_id': 'standby1',"
                          "'netdev': 'hs3',"
-                         "'rombar': 0,"
+                         "'rombar': 'off',"
                          "'romfile': '',"
                          "'mac': '"MAC_PRIMARY1"'}");
 

-- 
2.45.2


