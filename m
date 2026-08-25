Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15A2DC61DC2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 19:14:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wywZw-0003sj-3I; Tue, 25 Aug 2026 15:13:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wywZu-0003nR-5i
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 15:12:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wywZq-0004WJ-Lq
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 15:12:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787685173;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S+aPoqqisu2J1a6Pr1LukLQArfAFqh3ZKUjQId9ja9Q=;
 b=GTDjEDY96iGN3Ih7joQsmUCbvbBOyrPCXesDqv/RBh503YU/Duh/aspOXNfbQrj3iBK2UC
 enUXPi+ahxeiKVlLyJEXqrxZUPjOLGu6ZqRtNkxDP0Zt9QYe82R2YXvwwT7KwhftkUwdJO
 3jzecdDdw+xBrFSIIls0gOOOKVug6aM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-448-eR1SK0X7NtqLKSA6GRE-jQ-1; Tue,
 25 Aug 2026 15:12:50 -0400
X-MC-Unique: eR1SK0X7NtqLKSA6GRE-jQ-1
X-Mimecast-MFC-AGG-ID: eR1SK0X7NtqLKSA6GRE-jQ_1787685168
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CC4B41955F1F; Tue, 25 Aug 2026 19:12:47 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 96F2B1955F0C; Tue, 25 Aug 2026 19:12:46 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 25 Aug 2026 23:09:49 +0400
Subject: [PATCH v4 42/49] hw: guard BusClass::print_dev with CONFIG_HMP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260825-qemu-no-hmp-v4-42-af60857c2fbe@redhat.com>
References: <20260825-qemu-no-hmp-v4-0-af60857c2fbe@redhat.com>
In-Reply-To: <20260825-qemu-no-hmp-v4-0-af60857c2fbe@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 dave@treblig.org, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
 Amit Shah <amit@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Stefano Stabellini <sstabellini@kernel.org>, 
 Anthony PERARD <anthony@xenproject.org>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 xen-devel@lists.xenproject.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=9448;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=DXclgUj/8CLlvYxtSJ1BdyFBBPgVkYBaEJYVSnhsRxE=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqjeiIY3eGI48Kf0/aoiQ/MKgC5Wp2woFurnxxS
 F0lWsgFNX2JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCao3oiAAKCRDa6OEJdZac
 5WsND/wPl9/v92x/AquvMWdZ7rOg9DwenVSjQrgi/syQ0XPxEnuU+BHW+vlRlhR589DQBK2JWux
 whjt1aLkn4GALepRB5E0sb//roHo1ZL/q/NtTCm80KMl2DIzoYmHMRE9ti0jia4yXhEB+/5weh3
 duFyQM6L0T4VjWf5hCEXQObSK6tFNjpo5lHKh2221Olk/39vrXFGBZ09tkm8FEM9O4Tmw+mdRX/
 TdmN2/TPQh8IIqBG4IcNi7b+cSdn6jN03LH1RvlObtcX+EPfGmR7yUY5tqT/St87Q9wkK64jVH6
 Z5kUu/8yyyN9UBFJMb9WRHgqZxz6XPeyJLm1oGjuRndTjsa/yqey+0blEI82/jvIc2IVRSWoRRg
 NwUE48TuAh18Z/y/nRdL9EJezQidLYFunldTAf9esvGjqRfePHAGmUVA4sdzydMGSmlukuD3I27
 VfOTAYt4VNVzvz0ti0VZ3pJ/gTrQeUgaUygsEFts4ch3cGiUdeJNikOW8WRp2Udgp/KRyjyhAph
 AwHY9BCRwoYna9TwznrW18P8ZXhM5+rzu2VsuCYAvgC3tQnslsSut1QiLmA8FOmZBxrh7TpRP0b
 1Zej4GBAE74/uaZ+3jqzzvr/VXTr9u21Yxa+Zt0wQTcy+ymsoP3nG5p2waObhk1gXBP4xBVVBbU
 fsT43EF7iIos1fQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
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

The print_dev callback is only used by HMP 'info qtree'. Guard the field
in BusClass, all implementations, and the caller with CONFIG_HMP.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/char/virtio-serial-bus.c |  6 ++++++
 hw/core/sysbus.c            |  6 ++++++
 hw/misc/auxbus.c            | 16 +++++++++++-----
 hw/pci/pci-hmp-cmds.c       |  2 ++
 hw/pci/pci.c                |  2 ++
 hw/usb/bus.c                |  6 ++++++
 hw/xen/xen-bus.c            |  4 ++++
 include/hw/core/qdev.h      |  2 ++
 8 files changed, 39 insertions(+), 5 deletions(-)

diff --git a/hw/char/virtio-serial-bus.c b/hw/char/virtio-serial-bus.c
index 4dcc4516e45e..83a033ce8555 100644
--- a/hw/char/virtio-serial-bus.c
+++ b/hw/char/virtio-serial-bus.c
@@ -814,7 +814,9 @@ static int virtio_serial_load_device(VirtIODevice *vdev, QEMUFile *f,
     return 0;
 }
 
+#ifdef CONFIG_HMP
 static void virtser_bus_dev_print(MonitorHMP *hmp, DeviceState *qdev, int indent);
+#endif
 
 static const Property virtser_props[] = {
     DEFINE_PROP_UINT32("nr", VirtIOSerialPort, id, VIRTIO_CONSOLE_BAD_ID),
@@ -823,8 +825,10 @@ static const Property virtser_props[] = {
 
 static void virtser_bus_class_init(ObjectClass *klass, const void *data)
 {
+#ifdef CONFIG_HMP
     BusClass *k = BUS_CLASS(klass);
     k->print_dev = virtser_bus_dev_print;
+#endif
 }
 
 static const TypeInfo virtser_bus_info = {
@@ -834,6 +838,7 @@ static const TypeInfo virtser_bus_info = {
     .class_init = virtser_bus_class_init,
 };
 
+#ifdef CONFIG_HMP
 static void virtser_bus_dev_print(MonitorHMP *hmp, DeviceState *qdev, int indent)
 {
     VirtIOSerialPort *port = VIRTIO_SERIAL_PORT(qdev);
@@ -844,6 +849,7 @@ static void virtser_bus_dev_print(MonitorHMP *hmp, DeviceState *qdev, int indent
                        port->host_connected ? "on" : "off",
                        port->throttled ? "on" : "off");
 }
+#endif
 
 /* This function is only used if a port id is not provided by the user */
 static uint32_t find_free_port_id(VirtIOSerial *vser)
diff --git a/hw/core/sysbus.c b/hw/core/sysbus.c
index 31c4fdf79d48..fe8f867a8d9c 100644
--- a/hw/core/sysbus.c
+++ b/hw/core/sysbus.c
@@ -24,7 +24,9 @@
 #include "monitor/hmp.h"
 #include "system/address-spaces.h"
 
+#ifdef CONFIG_HMP
 static void sysbus_dev_print(MonitorHMP *hmp, DeviceState *dev, int indent);
+#endif
 static char *sysbus_get_fw_dev_path(DeviceState *dev);
 
 typedef struct SysBusFind {
@@ -76,7 +78,9 @@ static void system_bus_class_init(ObjectClass *klass, const void *data)
 {
     BusClass *k = BUS_CLASS(klass);
 
+#ifdef CONFIG_HMP
     k->print_dev = sysbus_dev_print;
+#endif
     k->get_fw_dev_path = sysbus_get_fw_dev_path;
 }
 
@@ -249,6 +253,7 @@ bool sysbus_realize_and_unref(SysBusDevice *dev, Error **errp)
     return qdev_realize_and_unref(DEVICE(dev), sysbus_get_default(), errp);
 }
 
+#ifdef CONFIG_HMP
 static void sysbus_dev_print(MonitorHMP *hmp, DeviceState *dev, int indent)
 {
     SysBusDevice *s = SYS_BUS_DEVICE(dev);
@@ -261,6 +266,7 @@ static void sysbus_dev_print(MonitorHMP *hmp, DeviceState *dev, int indent)
                            indent, "", s->mmio[i].addr, size);
     }
 }
+#endif
 
 static char *sysbus_get_fw_dev_path(DeviceState *dev)
 {
diff --git a/hw/misc/auxbus.c b/hw/misc/auxbus.c
index 0bb89c5a60ab..3f17784d9b8a 100644
--- a/hw/misc/auxbus.c
+++ b/hw/misc/auxbus.c
@@ -47,18 +47,22 @@
 } while (0)
 
 
+#ifdef CONFIG_HMP
 static void aux_slave_dev_print(MonitorHMP *hmp, DeviceState *dev, int indent);
+#endif
 static inline I2CBus *aux_bridge_get_i2c_bus(AUXTOI2CState *bridge);
 
 /* aux-bus implementation (internal not public) */
 static void aux_bus_class_init(ObjectClass *klass, const void *data)
 {
+#ifdef CONFIG_HMP
     BusClass *k = BUS_CLASS(klass);
 
     /* AUXSlave has an MMIO so we need to change the way we print information
      * in monitor.
      */
     k->print_dev = aux_slave_dev_print;
+#endif
 }
 
 AUXBus *aux_bus_init(DeviceState *parent, const char *name)
@@ -91,11 +95,6 @@ void aux_map_slave(AUXSlave *aux_dev, hwaddr addr)
     memory_region_add_subregion(bus->aux_io, addr, aux_dev->mmio);
 }
 
-static bool aux_bus_is_bridge(AUXBus *bus, DeviceState *dev)
-{
-    return (dev == DEVICE(bus->bridge));
-}
-
 I2CBus *aux_get_i2c_bus(AUXBus *bus)
 {
     return aux_bridge_get_i2c_bus(bus->bridge);
@@ -288,6 +287,12 @@ static const TypeInfo aux_to_i2c_type_info = {
 };
 
 /* aux-slave implementation */
+#ifdef CONFIG_HMP
+static bool aux_bus_is_bridge(AUXBus *bus, DeviceState *dev)
+{
+    return (dev == DEVICE(bus->bridge));
+}
+
 static void aux_slave_dev_print(MonitorHMP *hmp, DeviceState *dev, int indent)
 {
     AUXBus *bus = AUX_BUS(qdev_get_parent_bus(dev));
@@ -305,6 +310,7 @@ static void aux_slave_dev_print(MonitorHMP *hmp, DeviceState *dev, int indent)
                        object_property_get_uint(OBJECT(s->mmio), "addr", NULL),
                        memory_region_size(s->mmio));
 }
+#endif
 
 void aux_init_mmio(AUXSlave *aux_slave, MemoryRegion *mmio)
 {
diff --git a/hw/pci/pci-hmp-cmds.c b/hw/pci/pci-hmp-cmds.c
index bcccfaf07f4d..879011da1384 100644
--- a/hw/pci/pci-hmp-cmds.c
+++ b/hw/pci/pci-hmp-cmds.c
@@ -135,6 +135,7 @@ void hmp_info_pci(MonitorHMP *hmp, const QDict *qdict)
     qapi_free_PciInfoList(info_list);
 }
 
+#ifdef CONFIG_HMP
 void pcibus_dev_print(MonitorHMP *hmp, DeviceState *dev, int indent)
 {
     PCIDevice *d = (PCIDevice *)dev;
@@ -170,6 +171,7 @@ void pcibus_dev_print(MonitorHMP *hmp, DeviceState *dev, int indent)
                            r->addr, r->addr + r->size - 1);
     }
 }
+#endif
 
 void hmp_pcie_aer_inject_error(MonitorHMP *hmp, const QDict *qdict)
 {
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index d3191609e283..9e5db9529379 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -290,7 +290,9 @@ static void pci_bus_class_init(ObjectClass *klass, const void *data)
     ResettableClass *rc = RESETTABLE_CLASS(klass);
     FWCfgDataGeneratorClass *fwgc = FW_CFG_DATA_GENERATOR_CLASS(klass);
 
+#ifdef CONFIG_HMP
     k->print_dev = pcibus_dev_print;
+#endif
     k->get_dev_path = pcibus_get_dev_path;
     k->get_fw_dev_path = pcibus_get_fw_dev_path;
     k->realize = pci_bus_realize;
diff --git a/hw/usb/bus.c b/hw/usb/bus.c
index 8bd25a9d872a..5cc5ffec33a1 100644
--- a/hw/usb/bus.c
+++ b/hw/usb/bus.c
@@ -13,7 +13,9 @@
 #include "trace.h"
 #include "qemu/cutils.h"
 
+#ifdef CONFIG_HMP
 static void usb_bus_dev_print(MonitorHMP *hmp, DeviceState *qdev, int indent);
+#endif
 
 static char *usb_get_dev_path(DeviceState *dev);
 static char *usb_get_fw_dev_path(DeviceState *qdev);
@@ -32,7 +34,9 @@ static void usb_bus_class_init(ObjectClass *klass, const void *data)
     BusClass *k = BUS_CLASS(klass);
     HotplugHandlerClass *hc = HOTPLUG_HANDLER_CLASS(klass);
 
+#ifdef CONFIG_HMP
     k->print_dev = usb_bus_dev_print;
+#endif
     k->get_dev_path = usb_get_dev_path;
     k->get_fw_dev_path = usb_get_fw_dev_path;
     hc->unplug = qdev_simple_device_unplug_cb;
@@ -544,6 +548,7 @@ static const char *usb_speed(unsigned int speed)
     return txt[speed];
 }
 
+#ifdef CONFIG_HMP
 static void usb_bus_dev_print(MonitorHMP *hmp, DeviceState *qdev, int indent)
 {
     USBDevice *dev = USB_DEVICE(qdev);
@@ -555,6 +560,7 @@ static void usb_bus_dev_print(MonitorHMP *hmp, DeviceState *qdev, int indent)
                        usb_speed(dev->speed), dev->product_desc,
                        dev->attached ? ", attached" : "");
 }
+#endif
 
 static char *usb_get_dev_path(DeviceState *qdev)
 {
diff --git a/hw/xen/xen-bus.c b/hw/xen/xen-bus.c
index b81a067e7753..1762816bf469 100644
--- a/hw/xen/xen-bus.c
+++ b/hw/xen/xen-bus.c
@@ -101,6 +101,7 @@ abort:
     qemu_xen_xs_transaction_end(xenbus->xsh, tid, true);
 }
 
+#ifdef CONFIG_HMP
 static void xen_bus_print_dev(MonitorHMP *hmp, DeviceState *dev, int indent)
 {
     XenDevice *xendev = XEN_DEVICE(dev);
@@ -108,6 +109,7 @@ static void xen_bus_print_dev(MonitorHMP *hmp, DeviceState *dev, int indent)
     monitor_hmp_printf(hmp, "%*sname = '%s' frontend_id = %u\n",
                        indent, "", xendev->name, xendev->frontend_id);
 }
+#endif
 
 static char *xen_bus_get_dev_path(DeviceState *dev)
 {
@@ -386,7 +388,9 @@ static void xen_bus_class_init(ObjectClass *class, const void *data)
     BusClass *bus_class = BUS_CLASS(class);
     HotplugHandlerClass *hotplug_class = HOTPLUG_HANDLER_CLASS(class);
 
+#ifdef CONFIG_HMP
     bus_class->print_dev = xen_bus_print_dev;
+#endif
     bus_class->get_dev_path = xen_bus_get_dev_path;
     bus_class->realize = xen_bus_realize;
     bus_class->unrealize = xen_bus_unrealize;
diff --git a/include/hw/core/qdev.h b/include/hw/core/qdev.h
index 1391dc060caf..f054a214fc6a 100644
--- a/include/hw/core/qdev.h
+++ b/include/hw/core/qdev.h
@@ -323,8 +323,10 @@ DECLARE_OBJ_CHECKERS(BusState, BusClass,
 struct BusClass {
     ObjectClass parent_class;
 
+#ifdef CONFIG_HMP
     /* FIXME first arg should be BusState */
     void (*print_dev)(MonitorHMP *mon, DeviceState *dev, int indent);
+#endif
     /*
      * Return a newly allocated string containing the path of the
      * device on this bus.

-- 
2.55.0.543.g5ebe2ebe4ea8


