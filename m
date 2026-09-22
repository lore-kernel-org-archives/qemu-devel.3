Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4755AC98302
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 20:28:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x975W-0006Cr-Ku; Tue, 22 Sep 2026 16:27:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x972O-0001LK-Uc
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:24:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x972L-0000b3-4e
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:24:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790108658;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ArBsudPGq56rGaGjJckWrplo0/hGiKQk5vOivYLgX9k=;
 b=gHxATfeOzUyTXMGXEozJzAjcRaveZeeXQadR+3fNyx2S556ryu8szG/rm6UAnG9DcMf2j+
 k+MH1+RcarpHNfJWd+8qFwZOQiPbLeS3q04SnBgjjiOjC12PPNQ41gv2Tp5eimsVnuLitW
 d92aSzyPUpNEWtp1fdBWEXzNJqZhCO8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-684-Ljz03s7FNHWwafDBITVPiw-1; Tue,
 22 Sep 2026 16:24:17 -0400
X-MC-Unique: Ljz03s7FNHWwafDBITVPiw-1
X-Mimecast-MFC-AGG-ID: Ljz03s7FNHWwafDBITVPiw_1790108656
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 28C9C19772E4; Tue, 22 Sep 2026 20:24:16 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5100141D; Tue, 22 Sep 2026 20:24:13 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 23 Sep 2026 00:18:32 +0400
Subject: [PATCH 85/88] qdev: add x-query-qtree QMP command
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260923-nohmp-v1-85-ebc029d4bd80@redhat.com>
References: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
In-Reply-To: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
 Amit Shah <amit@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Stefano Stabellini <sstabellini@kernel.org>, 
 Anthony PERARD <anthony@xenproject.org>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 xen-devel@lists.xenproject.org, qemu-rust@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=22716;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=kgwmlhrAVDXi4XANRljYDT/ER4YlpkwkFlzObaLlJCI=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqsuK0thVU45gjDBEnQecKc50CZGgIu1NnS+HpQ
 rZ5RvqAZ+eJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCarLitAAKCRDa6OEJdZac
 5b9tD/4kNJbyz4x+KPGlvhyk8IVrVHJKZHe5UYHPfmbGRKG3E/CkRpYoSW1VZREd5AXbD30foTk
 uH2iuDdZSIVyKgvaXZ7nI5VUgdRygOG4goAHwzLFHxxhq3Vclj4UBupzOvP0tPftLwnrGsOF4+p
 TYYtzzoFntv8G+lZZandIG3ufOMhbd+YxevKBYq3enEueT7AqZQZZ1ASg38GYKqxTaqtcj3gQ/p
 13tMoUCCnxkpLfRr9R3+4ZYMWXoaE9ORpoiK8yxM22Esgy4mTBrQxYpib+lhhY4TtgsuBa0YIqV
 soeVaFz8aT2ePEv3xAjpVz6sIj6WqNFoQF2DN/9t7Z0AtT3InmQKtWd3YgA9zKYYwRcJYyR6x3m
 8Fk/M4VVDAweUT4vsJc1/PgrRp+Ll66Rhe/Xc2Vcmi0sy8Fu5zhpXlE2gid+F5Cxo8sn5E1Sz9D
 8XSclNJ44UE1JsizmaE27ACxJM73V4DHmoQap/RElPzw3KQ/HzT2/UShIHIUqzEwTWCaBgoNn7r
 hQbqa9uiSvX4TpmFSQ3JFg9RaqcKlNJaZKIi7sjB042G13pfc52ZVxT2zvSzculhKrJxk5Wza5U
 hnukq7c231Kr1MQI6F87bTKMT7GXKQrxiJah4/1xyrbK9ZfTjfo+yDV7uv0DZpTujvcd7Ht/igg
 DtXX3YvV6KvoVZg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Add x-query-qtree QMP command returning HumanReadableText with the
device tree. Supports an optional "brief" parameter to omit device
properties, matching the -b flag of "info qtree".

Refactor the BusClass print_dev callback and qbus_print/qdev_print
functions to write to a GString buffer instead of requiring a Monitor,
so the QMP command can collect the output directly without needing
monitor internals.

Rewire hmp_info_qtree to use the new QMP command.

Eventually, qom-list and properties retrieval should be enhanced to
do tree traversal and make this pretty-printing method obsolete and
return structured data instead.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/char/virtio-serial-bus.c     | 23 ++++++++--------------
 hw/core/sysbus.c                | 17 +++++------------
 hw/misc/auxbus.c                | 22 ++++++++-------------
 hw/pci/pci-hmp-cmds.c           | 38 -------------------------------------
 hw/pci/pci-internal.h           |  2 +-
 hw/pci/pci.c                    | 40 +++++++++++++++++++++++++++++++++++++--
 hw/usb/bus.c                    | 23 ++++++++--------------
 hw/xen/xen-bus.c                | 12 +++---------
 include/hw/core/qdev.h          |  4 +---
 qapi/qdev.json                  | 31 ++++++++++++++++++++++++++++++
 rust/bindings/hwcore-sys/lib.rs |  2 +-
 system/qdev-monitor.c           | 42 +++++++++++++++++++++++++++--------------
 12 files changed, 132 insertions(+), 124 deletions(-)

diff --git a/hw/char/virtio-serial-bus.c b/hw/char/virtio-serial-bus.c
index c36e18a4cfb5..af438316f1a4 100644
--- a/hw/char/virtio-serial-bus.c
+++ b/hw/char/virtio-serial-bus.c
@@ -24,8 +24,6 @@
 #include "qemu/main-loop.h"
 #include "qemu/module.h"
 #include "migration/qemu-file-types.h"
-#include "monitor/monitor.h"
-#include "monitor/hmp.h"
 #include "qemu/error-report.h"
 #include "qemu/queue.h"
 #include "hw/core/qdev-properties.h"
@@ -818,9 +816,7 @@ static int virtio_serial_load_device(VirtIODevice *vdev, QEMUFile *f,
     return 0;
 }
 
-#ifdef CONFIG_HMP
-static void virtser_bus_dev_print(MonitorHMP *hmp, DeviceState *qdev, int indent);
-#endif
+static void virtser_bus_dev_print(GString *buf, DeviceState *qdev, int indent);
 
 static const Property virtser_props[] = {
     DEFINE_PROP_UINT32("nr", VirtIOSerialPort, id, VIRTIO_CONSOLE_BAD_ID),
@@ -829,10 +825,8 @@ static const Property virtser_props[] = {
 
 static void virtser_bus_class_init(ObjectClass *klass, const void *data)
 {
-#ifdef CONFIG_HMP
     BusClass *k = BUS_CLASS(klass);
     k->print_dev = virtser_bus_dev_print;
-#endif
 }
 
 static const TypeInfo virtser_bus_info = {
@@ -842,18 +836,17 @@ static const TypeInfo virtser_bus_info = {
     .class_init = virtser_bus_class_init,
 };
 
-#ifdef CONFIG_HMP
-static void virtser_bus_dev_print(MonitorHMP *hmp, DeviceState *qdev, int indent)
+static void virtser_bus_dev_print(GString *buf, DeviceState *qdev, int indent)
 {
     VirtIOSerialPort *port = VIRTIO_SERIAL_PORT(qdev);
 
-    monitor_hmp_printf(hmp, "%*sport %d, guest %s, host %s, throttle %s\n",
-                       indent, "", port->id,
-                       port->guest_connected ? "on" : "off",
-                       port->host_connected ? "on" : "off",
-                       port->throttled ? "on" : "off");
+    g_string_append_printf(buf,
+                           "%*sport %d, guest %s, host %s, throttle %s\n",
+                           indent, "", port->id,
+                           port->guest_connected ? "on" : "off",
+                           port->host_connected ? "on" : "off",
+                           port->throttled ? "on" : "off");
 }
-#endif
 
 /* This function is only used if a port id is not provided by the user */
 static uint32_t find_free_port_id(VirtIOSerial *vser)
diff --git a/hw/core/sysbus.c b/hw/core/sysbus.c
index fe8f867a8d9c..3a5fd52192d8 100644
--- a/hw/core/sysbus.c
+++ b/hw/core/sysbus.c
@@ -20,13 +20,9 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "hw/core/sysbus.h"
-#include "monitor/monitor.h"
-#include "monitor/hmp.h"
 #include "system/address-spaces.h"
 
-#ifdef CONFIG_HMP
-static void sysbus_dev_print(MonitorHMP *hmp, DeviceState *dev, int indent);
-#endif
+static void sysbus_dev_print(GString *buf, DeviceState *dev, int indent);
 static char *sysbus_get_fw_dev_path(DeviceState *dev);
 
 typedef struct SysBusFind {
@@ -78,9 +74,7 @@ static void system_bus_class_init(ObjectClass *klass, const void *data)
 {
     BusClass *k = BUS_CLASS(klass);
 
-#ifdef CONFIG_HMP
     k->print_dev = sysbus_dev_print;
-#endif
     k->get_fw_dev_path = sysbus_get_fw_dev_path;
 }
 
@@ -253,8 +247,7 @@ bool sysbus_realize_and_unref(SysBusDevice *dev, Error **errp)
     return qdev_realize_and_unref(DEVICE(dev), sysbus_get_default(), errp);
 }
 
-#ifdef CONFIG_HMP
-static void sysbus_dev_print(MonitorHMP *hmp, DeviceState *dev, int indent)
+static void sysbus_dev_print(GString *buf, DeviceState *dev, int indent)
 {
     SysBusDevice *s = SYS_BUS_DEVICE(dev);
     hwaddr size;
@@ -262,11 +255,11 @@ static void sysbus_dev_print(MonitorHMP *hmp, DeviceState *dev, int indent)
 
     for (i = 0; i < s->num_mmio; i++) {
         size = memory_region_size(s->mmio[i].memory);
-        monitor_hmp_printf(hmp, "%*smmio " HWADDR_FMT_plx "/" HWADDR_FMT_plx "\n",
-                           indent, "", s->mmio[i].addr, size);
+        g_string_append_printf(buf, "%*smmio "
+                               HWADDR_FMT_plx "/" HWADDR_FMT_plx "\n",
+                               indent, "", s->mmio[i].addr, size);
     }
 }
-#endif
 
 static char *sysbus_get_fw_dev_path(DeviceState *dev)
 {
diff --git a/hw/misc/auxbus.c b/hw/misc/auxbus.c
index 3f17784d9b8a..17033433147a 100644
--- a/hw/misc/auxbus.c
+++ b/hw/misc/auxbus.c
@@ -32,8 +32,6 @@
 #include "qemu/module.h"
 #include "hw/misc/auxbus.h"
 #include "hw/i2c/i2c.h"
-#include "monitor/monitor.h"
-#include "monitor/hmp.h"
 #include "qapi/error.h"
 
 #ifndef DEBUG_AUX
@@ -47,22 +45,18 @@
 } while (0)
 
 
-#ifdef CONFIG_HMP
-static void aux_slave_dev_print(MonitorHMP *hmp, DeviceState *dev, int indent);
-#endif
+static void aux_slave_dev_print(GString *buf, DeviceState *dev, int indent);
 static inline I2CBus *aux_bridge_get_i2c_bus(AUXTOI2CState *bridge);
 
 /* aux-bus implementation (internal not public) */
 static void aux_bus_class_init(ObjectClass *klass, const void *data)
 {
-#ifdef CONFIG_HMP
     BusClass *k = BUS_CLASS(klass);
 
     /* AUXSlave has an MMIO so we need to change the way we print information
      * in monitor.
      */
     k->print_dev = aux_slave_dev_print;
-#endif
 }
 
 AUXBus *aux_bus_init(DeviceState *parent, const char *name)
@@ -287,13 +281,12 @@ static const TypeInfo aux_to_i2c_type_info = {
 };
 
 /* aux-slave implementation */
-#ifdef CONFIG_HMP
 static bool aux_bus_is_bridge(AUXBus *bus, DeviceState *dev)
 {
     return (dev == DEVICE(bus->bridge));
 }
 
-static void aux_slave_dev_print(MonitorHMP *hmp, DeviceState *dev, int indent)
+static void aux_slave_dev_print(GString *buf, DeviceState *dev, int indent)
 {
     AUXBus *bus = AUX_BUS(qdev_get_parent_bus(dev));
     AUXSlave *s;
@@ -305,12 +298,13 @@ static void aux_slave_dev_print(MonitorHMP *hmp, DeviceState *dev, int indent)
 
     s = AUX_SLAVE(dev);
 
-    monitor_hmp_printf(hmp, "%*smemory " HWADDR_FMT_plx "/" HWADDR_FMT_plx "\n",
-                       indent, "",
-                       object_property_get_uint(OBJECT(s->mmio), "addr", NULL),
-                       memory_region_size(s->mmio));
+    g_string_append_printf(buf,
+                           "%*smemory " HWADDR_FMT_plx "/" HWADDR_FMT_plx "\n",
+                           indent, "",
+                           object_property_get_uint(OBJECT(s->mmio),
+                                                    "addr", NULL),
+                           memory_region_size(s->mmio));
 }
-#endif
 
 void aux_init_mmio(AUXSlave *aux_slave, MemoryRegion *mmio)
 {
diff --git a/hw/pci/pci-hmp-cmds.c b/hw/pci/pci-hmp-cmds.c
index 879011da1384..776762f18fa5 100644
--- a/hw/pci/pci-hmp-cmds.c
+++ b/hw/pci/pci-hmp-cmds.c
@@ -135,44 +135,6 @@ void hmp_info_pci(MonitorHMP *hmp, const QDict *qdict)
     qapi_free_PciInfoList(info_list);
 }
 
-#ifdef CONFIG_HMP
-void pcibus_dev_print(MonitorHMP *hmp, DeviceState *dev, int indent)
-{
-    PCIDevice *d = (PCIDevice *)dev;
-    int class = pci_get_word(d->config + PCI_CLASS_DEVICE);
-    const pci_class_desc *desc = get_class_desc(class);
-    char ctxt[64];
-    PCIIORegion *r;
-    int i;
-
-    if (desc->desc) {
-        snprintf(ctxt, sizeof(ctxt), "%s", desc->desc);
-    } else {
-        snprintf(ctxt, sizeof(ctxt), "Class %04x", class);
-    }
-
-    monitor_hmp_printf(hmp, "%*sclass %s, addr %02x:%02x.%x, "
-                       "pci id %04x:%04x (sub %04x:%04x)\n",
-                       indent, "", ctxt, pci_dev_bus_num(d),
-                       PCI_SLOT(d->devfn), PCI_FUNC(d->devfn),
-                       pci_get_word(d->config + PCI_VENDOR_ID),
-                       pci_get_word(d->config + PCI_DEVICE_ID),
-                       pci_get_word(d->config + PCI_SUBSYSTEM_VENDOR_ID),
-                       pci_get_word(d->config + PCI_SUBSYSTEM_ID));
-    for (i = 0; i < PCI_NUM_REGIONS; i++) {
-        r = &d->io_regions[i];
-        if (!r->size) {
-            continue;
-        }
-        monitor_hmp_printf(hmp, "%*sbar %d: %s at 0x%"FMT_PCIBUS
-                           " [0x%"FMT_PCIBUS"]\n",
-                           indent, "",
-                           i, r->type & PCI_BASE_ADDRESS_SPACE_IO ? "i/o" : "mem",
-                           r->addr, r->addr + r->size - 1);
-    }
-}
-#endif
-
 void hmp_pcie_aer_inject_error(MonitorHMP *hmp, const QDict *qdict)
 {
     Error *err = NULL;
diff --git a/hw/pci/pci-internal.h b/hw/pci/pci-internal.h
index b7231fab5dc9..68a169488d09 100644
--- a/hw/pci/pci-internal.h
+++ b/hw/pci/pci-internal.h
@@ -16,7 +16,7 @@ extern PCIHostStateList pci_host_bridges;
 
 const pci_class_desc *get_class_desc(int class);
 PCIBus *pci_find_bus_nr(PCIBus *bus, int bus_num);
-void pcibus_dev_print(MonitorHMP *mon, DeviceState *dev, int indent);
+void pcibus_dev_print(GString *buf, DeviceState *dev, int indent);
 
 int pcie_aer_parse_error_string(const char *error_name,
                                 uint32_t *status, bool *correctable);
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 0efb4eb4bb03..433568440853 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -293,9 +293,7 @@ static void pci_bus_class_init(ObjectClass *klass, const void *data)
     ResettableClass *rc = RESETTABLE_CLASS(klass);
     FWCfgDataGeneratorClass *fwgc = FW_CFG_DATA_GENERATOR_CLASS(klass);
 
-#ifdef CONFIG_HMP
     k->print_dev = pcibus_dev_print;
-#endif
     k->get_dev_path = pcibus_get_dev_path;
     k->get_fw_dev_path = pcibus_get_fw_dev_path;
     k->realize = pci_bus_realize;
@@ -2094,6 +2092,44 @@ const pci_class_desc *get_class_desc(int class)
     return desc;
 }
 
+void pcibus_dev_print(GString *buf, DeviceState *dev, int indent)
+{
+    PCIDevice *d = (PCIDevice *)dev;
+    int class = pci_get_word(d->config + PCI_CLASS_DEVICE);
+    const pci_class_desc *desc = get_class_desc(class);
+    char ctxt[64];
+    PCIIORegion *r;
+    int i;
+
+    if (desc->desc) {
+        snprintf(ctxt, sizeof(ctxt), "%s", desc->desc);
+    } else {
+        snprintf(ctxt, sizeof(ctxt), "Class %04x", class);
+    }
+
+    g_string_append_printf(buf, "%*sclass %s, addr %02x:%02x.%x, "
+                           "pci id %04x:%04x (sub %04x:%04x)\n",
+                           indent, "", ctxt, pci_dev_bus_num(d),
+                           PCI_SLOT(d->devfn), PCI_FUNC(d->devfn),
+                           pci_get_word(d->config + PCI_VENDOR_ID),
+                           pci_get_word(d->config + PCI_DEVICE_ID),
+                           pci_get_word(d->config + PCI_SUBSYSTEM_VENDOR_ID),
+                           pci_get_word(d->config + PCI_SUBSYSTEM_ID));
+    for (i = 0; i < PCI_NUM_REGIONS; i++) {
+        r = &d->io_regions[i];
+        if (!r->size) {
+            continue;
+        }
+        g_string_append_printf(buf, "%*sbar %d: %s at 0x%"FMT_PCIBUS
+                               " [0x%"FMT_PCIBUS"]\n",
+                               indent, "",
+                               i,
+                               r->type & PCI_BASE_ADDRESS_SPACE_IO
+                                   ? "i/o" : "mem",
+                               r->addr, r->addr + r->size - 1);
+    }
+}
+
 void pci_init_nic_devices(PCIBus *bus, const char *default_model)
 {
     qemu_create_nic_bus_devices(&bus->qbus, TYPE_PCI_DEVICE, default_model,
diff --git a/hw/usb/bus.c b/hw/usb/bus.c
index 5cc5ffec33a1..c6d65274771f 100644
--- a/hw/usb/bus.c
+++ b/hw/usb/bus.c
@@ -8,14 +8,10 @@
 #include "qemu/module.h"
 #include "system/system.h"
 #include "migration/vmstate.h"
-#include "monitor/monitor.h"
-#include "monitor/hmp.h"
 #include "trace.h"
 #include "qemu/cutils.h"
 
-#ifdef CONFIG_HMP
-static void usb_bus_dev_print(MonitorHMP *hmp, DeviceState *qdev, int indent);
-#endif
+static void usb_bus_dev_print(GString *buf, DeviceState *qdev, int indent);
 
 static char *usb_get_dev_path(DeviceState *dev);
 static char *usb_get_fw_dev_path(DeviceState *qdev);
@@ -34,9 +30,7 @@ static void usb_bus_class_init(ObjectClass *klass, const void *data)
     BusClass *k = BUS_CLASS(klass);
     HotplugHandlerClass *hc = HOTPLUG_HANDLER_CLASS(klass);
 
-#ifdef CONFIG_HMP
     k->print_dev = usb_bus_dev_print;
-#endif
     k->get_dev_path = usb_get_dev_path;
     k->get_fw_dev_path = usb_get_fw_dev_path;
     hc->unplug = qdev_simple_device_unplug_cb;
@@ -548,19 +542,18 @@ static const char *usb_speed(unsigned int speed)
     return txt[speed];
 }
 
-#ifdef CONFIG_HMP
-static void usb_bus_dev_print(MonitorHMP *hmp, DeviceState *qdev, int indent)
+static void usb_bus_dev_print(GString *buf, DeviceState *qdev, int indent)
 {
     USBDevice *dev = USB_DEVICE(qdev);
     USBBus *bus = usb_bus_from_device(dev);
 
-    monitor_hmp_printf(hmp, "%*saddr %d.%d, port %s, speed %s, name %s%s\n",
-                       indent, "", bus->busnr, dev->addr,
-                       dev->port ? dev->port->path : "-",
-                       usb_speed(dev->speed), dev->product_desc,
-                       dev->attached ? ", attached" : "");
+    g_string_append_printf(buf,
+                           "%*saddr %d.%d, port %s, speed %s, name %s%s\n",
+                           indent, "", bus->busnr, dev->addr,
+                           dev->port ? dev->port->path : "-",
+                           usb_speed(dev->speed), dev->product_desc,
+                           dev->attached ? ", attached" : "");
 }
-#endif
 
 static char *usb_get_dev_path(DeviceState *qdev)
 {
diff --git a/hw/xen/xen-bus.c b/hw/xen/xen-bus.c
index 8def3bb68bc6..cc98034230e8 100644
--- a/hw/xen/xen-bus.c
+++ b/hw/xen/xen-bus.c
@@ -16,8 +16,6 @@
 #include "hw/xen/xen-legacy-backend.h" /* xen_be_init() */
 #include "hw/xen/xen-bus.h"
 #include "hw/xen/xen-bus-helper.h"
-#include "monitor/monitor.h"
-#include "monitor/hmp.h"
 #include "qapi/error.h"
 #include "qobject/qdict.h"
 #include "system/system.h"
@@ -101,15 +99,13 @@ abort:
     qemu_xen_xs_transaction_end(xenbus->xsh, tid, true);
 }
 
-#ifdef CONFIG_HMP
-static void xen_bus_print_dev(MonitorHMP *hmp, DeviceState *dev, int indent)
+static void xen_bus_print_dev(GString *buf, DeviceState *dev, int indent)
 {
     XenDevice *xendev = XEN_DEVICE(dev);
 
-    monitor_hmp_printf(hmp, "%*sname = '%s' frontend_id = %u\n",
-                       indent, "", xendev->name, xendev->frontend_id);
+    g_string_append_printf(buf, "%*sname = '%s' frontend_id = %u\n",
+                           indent, "", xendev->name, xendev->frontend_id);
 }
-#endif
 
 static char *xen_bus_get_dev_path(DeviceState *dev)
 {
@@ -388,9 +384,7 @@ static void xen_bus_class_init(ObjectClass *class, const void *data)
     BusClass *bus_class = BUS_CLASS(class);
     HotplugHandlerClass *hotplug_class = HOTPLUG_HANDLER_CLASS(class);
 
-#ifdef CONFIG_HMP
     bus_class->print_dev = xen_bus_print_dev;
-#endif
     bus_class->get_dev_path = xen_bus_get_dev_path;
     bus_class->realize = xen_bus_realize;
     bus_class->unrealize = xen_bus_unrealize;
diff --git a/include/hw/core/qdev.h b/include/hw/core/qdev.h
index 1f6bf3fc1abf..e8399d8541fb 100644
--- a/include/hw/core/qdev.h
+++ b/include/hw/core/qdev.h
@@ -323,10 +323,8 @@ DECLARE_OBJ_CHECKERS(BusState, BusClass,
 struct BusClass {
     ObjectClass parent_class;
 
-#ifdef CONFIG_HMP
     /* FIXME first arg should be BusState */
-    void (*print_dev)(MonitorHMP *mon, DeviceState *dev, int indent);
-#endif
+    void (*print_dev)(GString *buf, DeviceState *dev, int indent);
     /*
      * Return a newly allocated string containing the path of the
      * device on this bus.
diff --git a/qapi/qdev.json b/qapi/qdev.json
index 974cf9c5830e..4b5ccfb37687 100644
--- a/qapi/qdev.json
+++ b/qapi/qdev.json
@@ -165,6 +165,37 @@
 { 'event': 'DEVICE_UNPLUG_GUEST_ERROR',
   'data': { '*device': 'str', 'path': 'str' } }
 
+##
+# @x-query-qtree:
+#
+# Query device tree
+#
+# @brief: if true, omit device properties.  (default: false)
+#
+# Features:
+#
+# @unstable: This command is meant for debugging.
+#
+# Returns: device tree
+#
+# Since: 11.2
+#
+# .. qmp-example::
+#
+#     -> { "execute": "x-query-qtree" }
+#     <- { "return": { "human-readable-text": "..." } }
+#
+# .. qmp-example::
+#
+#     -> { "execute": "x-query-qtree",
+#          "arguments": { "brief": true } }
+#     <- { "return": { "human-readable-text": "..." } }
+##
+{ 'command': 'x-query-qtree',
+  'data': { '*brief': 'bool' },
+  'returns': 'HumanReadableText',
+  'features': [ 'unstable' ] }
+
 ##
 # @device-sync-config:
 #
diff --git a/rust/bindings/hwcore-sys/lib.rs b/rust/bindings/hwcore-sys/lib.rs
index cecbf808dd09..a28f5ab90f69 100644
--- a/rust/bindings/hwcore-sys/lib.rs
+++ b/rust/bindings/hwcore-sys/lib.rs
@@ -21,7 +21,7 @@
 
 use chardev_sys::Chardev;
 use common::Zeroable;
-use glib_sys::GSList;
+use glib_sys::{GSList, GString};
 use migration_sys::VMStateDescription;
 use qom_sys::{
     InterfaceClass, Object, ObjectClass, ObjectProperty, ObjectPropertyAccessor,
diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
index 8185822daa71..1a4af35f9db1 100644
--- a/system/qdev-monitor.c
+++ b/system/qdev-monitor.c
@@ -27,6 +27,7 @@
 #include "system/runstate.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-qdev.h"
+#include "qapi/type-helpers.h"
 #include "qapi/qmp-registry.h"
 #include "qobject/qdict.h"
 #include "qapi/qmp/qerror.h"
@@ -770,11 +771,10 @@ DeviceState *qdev_device_add(QemuOpts *opts, Error **errp)
     return ret;
 }
 
-#ifdef CONFIG_HMP
 #define qdev_printf(fmt, ...) \
-    monitor_hmp_printf(hmp, "%*s" fmt, indent, "", ## __VA_ARGS__)
+    g_string_append_printf(buf, "%*s" fmt, indent, "", ## __VA_ARGS__)
 
-static void qdev_print_props(MonitorHMP *hmp, DeviceState *dev, DeviceClass *dc,
+static void qdev_print_props(GString *buf, DeviceState *dev, DeviceClass *dc,
                              int indent)
 {
     for (int i = 0, n = dc->props_count_; i < n; ++i) {
@@ -798,16 +798,17 @@ static void qdev_print_props(MonitorHMP *hmp, DeviceState *dev, DeviceClass *dc,
     }
 }
 
-static void bus_print_dev(BusState *bus, MonitorHMP *hmp, DeviceState *dev, int indent)
+static void bus_print_dev(BusState *bus, GString *buf, DeviceState *dev,
+                          int indent)
 {
     BusClass *bc = BUS_GET_CLASS(bus);
 
     if (bc->print_dev) {
-        bc->print_dev(hmp, dev, indent);
+        bc->print_dev(buf, dev, indent);
     }
 }
 
-static void qdev_print(MonitorHMP *hmp, DeviceState *dev, int indent)
+static void qdev_print(GString *buf, DeviceState *dev, int indent)
 {
     ObjectClass *class;
     NamedGPIOList *ngl;
@@ -832,13 +833,13 @@ static void qdev_print(MonitorHMP *hmp, DeviceState *dev, int indent)
     }
     class = object_get_class(OBJECT(dev));
     do {
-        qdev_print_props(hmp, dev, DEVICE_CLASS(class), indent);
+        qdev_print_props(buf, dev, DEVICE_CLASS(class), indent);
         class = object_class_get_parent(class);
     } while (class != object_class_by_name(TYPE_DEVICE));
-    bus_print_dev(dev->parent_bus, hmp, dev, indent);
+    bus_print_dev(dev->parent_bus, buf, dev, indent);
 }
 
-static void qbus_print(MonitorHMP *hmp, BusState *bus, int indent, bool details)
+static void qbus_print(GString *buf, BusState *bus, int indent, bool details)
 {
     BusChild *kid;
 
@@ -851,22 +852,35 @@ static void qbus_print(MonitorHMP *hmp, BusState *bus, int indent, bool details)
         qdev_printf("dev: %s, id \"%s\"\n", object_get_typename(OBJECT(dev)),
                     dev->id ? dev->id : "");
         if (details) {
-            qdev_print(hmp, dev, indent + 2);
+            qdev_print(buf, dev, indent + 2);
         }
         QLIST_FOREACH(child_bus, &dev->child_bus, sibling) {
-            qbus_print(hmp, child_bus, indent + 2, details);
+            qbus_print(buf, child_bus, indent + 2, details);
         }
     }
 }
 #undef qdev_printf
 
-void hmp_info_qtree(MonitorHMP *hmp, const QDict *qdict)
+HumanReadableText *qmp_x_query_qtree(bool has_brief, bool brief, Error **errp)
 {
-    bool details = !qdict_get_try_bool(qdict, "brief", false);
+    g_autoptr(GString) buf = g_string_new("");
+    bool details = !(has_brief && brief);
 
     if (sysbus_get_default()) {
-        qbus_print(hmp, sysbus_get_default(), 0, details);
+        qbus_print(buf, sysbus_get_default(), 0, details);
     }
+
+    return human_readable_text_from_str(buf);
+}
+
+#ifdef CONFIG_HMP
+void hmp_info_qtree(MonitorHMP *hmp, const QDict *qdict)
+{
+    bool brief = qdict_get_try_bool(qdict, "brief", false);
+    g_autoptr(HumanReadableText) info =
+        qmp_x_query_qtree(true, brief, &error_abort);
+
+    monitor_hmp_printf(hmp, "%s", info->human_readable_text);
 }
 
 void hmp_info_qdm(MonitorHMP *hmp, const QDict *qdict)

-- 
2.56.0.rc0.29.g47ce80527c56


