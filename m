Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39265CD4F54
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 21:54:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPord-0000qX-NH; Wed, 20 May 2026 17:54:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wPorI-00082Z-AJ
 for qemu-devel@nongnu.org; Wed, 20 May 2026 17:53:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wPorF-000537-7a
 for qemu-devel@nongnu.org; Wed, 20 May 2026 17:53:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779314020;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D1/Vzw2Y3LIUw5pYZS7KurEux7ztNC/IdWyyYaMXw5Y=;
 b=SHwwFaWN/QA2IDds4xIb0e3lLQMKsa2IQKpIE8EedahceJ3cGEpUxX2Bt8yynOV30gBPUn
 6ZQvWJArVwkYY35XWJO8pOlqugRucd9w448stoSZtXCnhRBI5/Wws1vjncdmx6fmmTZC31
 AP4oZg11CuLW7hT4jtefwOqDNbNl9m4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-632-SH6ilo03OMqyIdw8iA3BSw-1; Wed,
 20 May 2026 17:53:39 -0400
X-MC-Unique: SH6ilo03OMqyIdw8iA3BSw-1
X-Mimecast-MFC-AGG-ID: SH6ilo03OMqyIdw8iA3BSw_1779314018
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3CDF1195608F
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 21:53:38 +0000 (UTC)
Received: from localhost (unknown [10.44.24.26])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D17E81956053; Wed, 20 May 2026 21:53:36 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 21 May 2026 01:49:37 +0400
Subject: [PATCH 36/40] hw: guard BusClass::print_dev with CONFIG_HMP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260521-qemu-no-hmp-v1-36-d104f809e145@redhat.com>
References: <20260521-qemu-no-hmp-v1-0-d104f809e145@redhat.com>
In-Reply-To: <20260521-qemu-no-hmp-v1-0-d104f809e145@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=10016;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=9G23734F58rnWXSfmVKDClokceOql9t+p0azHa4YjYA=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqDiyEDgBjCrRfAUxoRPdxiEYgiG6EbGT19MLjN
 FxdvNE85TiJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCag4shAAKCRDa6OEJdZac
 5SL1EACPYy2CZIqWg5yAc5qKkz2Awe8jSikWcVQ8lffr9rbSONTiEhYlqKhrTKoTRwwfk831+sg
 5pTRLKFNK6Cqh0/5XoUALWAgSv5bNg6+dOQusPDczGqfGx2t+jzVmxDu1/ELJ6zDzL5Xf00NGOh
 yEOH6/09ofuz6gEYjOIeyxqNYUre30zvFRt2wpnO9YNzHErOIZoVGUby6332lpRq5e5U6KD4PtK
 GGy+QV06WXn5UQAjI5LHsWlf8Ug7+2GMnV0xtVs6thvoPh2hKbItBAyX0GDxov4ZCBEfkZewYKu
 9UKxlgOdsfi6CuInjFmDyHnOxEgBy7mdpKnqypN4Q/zTFwj4CnI3K7bWwdb1LV0QRTpwjO0Dkb8
 IwoEZm1rzsBchTTaZ/yCGvTKuXGdgv52jMLKKXoE1vswYlIZlcyVA+8aDB3kwTcgkN66sFR9jJm
 O9ZyksYDI+WYW0XJp3ZSBii+WV3ruAqZdgulQJlg/DtOcy0DJFkaug6Tq7LsODJqMo+ACILtaN+
 bYJ3jNv3fFRcz2/uTRGbc1uEjW/34qc+A0PPoPbNsG76SnK9r5zhUxTjBYCxL4RboGlcMOMh88f
 lSNkyL+rJcqK2nlnoa3IwvEpxik9EQi11HKXzqWNpcLJC5Y1Nxw8QgQMaWuncoBBluCUFIWsKpS
 v2o0guctvD8xK2Q==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
 include/hw/core/qdev.h      |  2 ++
 hw/char/virtio-serial-bus.c |  6 ++++++
 hw/core/sysbus.c            |  6 ++++++
 hw/misc/auxbus.c            | 16 +++++++++++-----
 hw/pci/pci-hmp-cmds.c       |  2 ++
 hw/pci/pci.c                |  2 ++
 hw/usb/bus.c                |  6 ++++++
 hw/xen/xen-bus.c            |  4 ++++
 system/qdev-monitor.c       |  2 ++
 9 files changed, 41 insertions(+), 5 deletions(-)

diff --git a/include/hw/core/qdev.h b/include/hw/core/qdev.h
index e1476223411..22dd143acf0 100644
--- a/include/hw/core/qdev.h
+++ b/include/hw/core/qdev.h
@@ -322,8 +322,10 @@ DECLARE_OBJ_CHECKERS(BusState, BusClass,
 struct BusClass {
     ObjectClass parent_class;
 
+#ifdef CONFIG_HMP
     /* FIXME first arg should be BusState */
     void (*print_dev)(Monitor *mon, DeviceState *dev, int indent);
+#endif
     /*
      * Return a newly allocated string containing the path of the
      * device on this bus.
diff --git a/hw/char/virtio-serial-bus.c b/hw/char/virtio-serial-bus.c
index cd234dc6db1..34a723a8715 100644
--- a/hw/char/virtio-serial-bus.c
+++ b/hw/char/virtio-serial-bus.c
@@ -833,7 +833,9 @@ static int virtio_serial_load_device(VirtIODevice *vdev, QEMUFile *f,
     return 0;
 }
 
+#ifdef CONFIG_HMP
 static void virtser_bus_dev_print(Monitor *mon, DeviceState *qdev, int indent);
+#endif
 
 static const Property virtser_props[] = {
     DEFINE_PROP_UINT32("nr", VirtIOSerialPort, id, VIRTIO_CONSOLE_BAD_ID),
@@ -842,8 +844,10 @@ static const Property virtser_props[] = {
 
 static void virtser_bus_class_init(ObjectClass *klass, const void *data)
 {
+#ifdef CONFIG_HMP
     BusClass *k = BUS_CLASS(klass);
     k->print_dev = virtser_bus_dev_print;
+#endif
 }
 
 static const TypeInfo virtser_bus_info = {
@@ -853,6 +857,7 @@ static const TypeInfo virtser_bus_info = {
     .class_init = virtser_bus_class_init,
 };
 
+#ifdef CONFIG_HMP
 static void virtser_bus_dev_print(Monitor *mon, DeviceState *qdev, int indent)
 {
     VirtIOSerialPort *port = VIRTIO_SERIAL_PORT(qdev);
@@ -863,6 +868,7 @@ static void virtser_bus_dev_print(Monitor *mon, DeviceState *qdev, int indent)
                    port->host_connected ? "on" : "off",
                    port->throttled ? "on" : "off");
 }
+#endif
 
 /* This function is only used if a port id is not provided by the user */
 static uint32_t find_free_port_id(VirtIOSerial *vser)
diff --git a/hw/core/sysbus.c b/hw/core/sysbus.c
index 3e1160ee921..0b970d6b64f 100644
--- a/hw/core/sysbus.c
+++ b/hw/core/sysbus.c
@@ -23,7 +23,9 @@
 #include "monitor/monitor.h"
 #include "system/address-spaces.h"
 
+#ifdef CONFIG_HMP
 static void sysbus_dev_print(Monitor *mon, DeviceState *dev, int indent);
+#endif
 static char *sysbus_get_fw_dev_path(DeviceState *dev);
 
 typedef struct SysBusFind {
@@ -75,7 +77,9 @@ static void system_bus_class_init(ObjectClass *klass, const void *data)
 {
     BusClass *k = BUS_CLASS(klass);
 
+#ifdef CONFIG_HMP
     k->print_dev = sysbus_dev_print;
+#endif
     k->get_fw_dev_path = sysbus_get_fw_dev_path;
 }
 
@@ -248,6 +252,7 @@ bool sysbus_realize_and_unref(SysBusDevice *dev, Error **errp)
     return qdev_realize_and_unref(DEVICE(dev), sysbus_get_default(), errp);
 }
 
+#ifdef CONFIG_HMP
 static void sysbus_dev_print(Monitor *mon, DeviceState *dev, int indent)
 {
     SysBusDevice *s = SYS_BUS_DEVICE(dev);
@@ -260,6 +265,7 @@ static void sysbus_dev_print(Monitor *mon, DeviceState *dev, int indent)
                        indent, "", s->mmio[i].addr, size);
     }
 }
+#endif
 
 static char *sysbus_get_fw_dev_path(DeviceState *dev)
 {
diff --git a/hw/misc/auxbus.c b/hw/misc/auxbus.c
index 877f3456062..dd0629620ac 100644
--- a/hw/misc/auxbus.c
+++ b/hw/misc/auxbus.c
@@ -46,18 +46,22 @@
 } while (0)
 
 
+#ifdef CONFIG_HMP
 static void aux_slave_dev_print(Monitor *mon, DeviceState *dev, int indent);
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
@@ -90,11 +94,6 @@ void aux_map_slave(AUXSlave *aux_dev, hwaddr addr)
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
@@ -287,6 +286,12 @@ static const TypeInfo aux_to_i2c_type_info = {
 };
 
 /* aux-slave implementation */
+#ifdef CONFIG_HMP
+static bool aux_bus_is_bridge(AUXBus *bus, DeviceState *dev)
+{
+    return (dev == DEVICE(bus->bridge));
+}
+
 static void aux_slave_dev_print(Monitor *mon, DeviceState *dev, int indent)
 {
     AUXBus *bus = AUX_BUS(qdev_get_parent_bus(dev));
@@ -304,6 +309,7 @@ static void aux_slave_dev_print(Monitor *mon, DeviceState *dev, int indent)
                    object_property_get_uint(OBJECT(s->mmio), "addr", NULL),
                    memory_region_size(s->mmio));
 }
+#endif
 
 void aux_init_mmio(AUXSlave *aux_slave, MemoryRegion *mmio)
 {
diff --git a/hw/pci/pci-hmp-cmds.c b/hw/pci/pci-hmp-cmds.c
index a5f6483cc3d..3e378eadfaa 100644
--- a/hw/pci/pci-hmp-cmds.c
+++ b/hw/pci/pci-hmp-cmds.c
@@ -134,6 +134,7 @@ void hmp_info_pci(Monitor *mon, const QDict *qdict)
     qapi_free_PciInfoList(info_list);
 }
 
+#ifdef CONFIG_HMP
 void pcibus_dev_print(Monitor *mon, DeviceState *dev, int indent)
 {
     PCIDevice *d = (PCIDevice *)dev;
@@ -169,6 +170,7 @@ void pcibus_dev_print(Monitor *mon, DeviceState *dev, int indent)
                        r->addr, r->addr + r->size - 1);
     }
 }
+#endif
 
 void hmp_pcie_aer_inject_error(Monitor *mon, const QDict *qdict)
 {
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 4298adf5a0a..c67aeb67f4c 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -283,7 +283,9 @@ static void pci_bus_class_init(ObjectClass *klass, const void *data)
     ResettableClass *rc = RESETTABLE_CLASS(klass);
     FWCfgDataGeneratorClass *fwgc = FW_CFG_DATA_GENERATOR_CLASS(klass);
 
+#ifdef CONFIG_HMP
     k->print_dev = pcibus_dev_print;
+#endif
     k->get_dev_path = pcibus_get_dev_path;
     k->get_fw_dev_path = pcibus_get_fw_dev_path;
     k->realize = pci_bus_realize;
diff --git a/hw/usb/bus.c b/hw/usb/bus.c
index 3b6fbd46ac3..753f2d9be56 100644
--- a/hw/usb/bus.c
+++ b/hw/usb/bus.c
@@ -12,7 +12,9 @@
 #include "trace.h"
 #include "qemu/cutils.h"
 
+#ifdef CONFIG_HMP
 static void usb_bus_dev_print(Monitor *mon, DeviceState *qdev, int indent);
+#endif
 
 static char *usb_get_dev_path(DeviceState *dev);
 static char *usb_get_fw_dev_path(DeviceState *qdev);
@@ -31,7 +33,9 @@ static void usb_bus_class_init(ObjectClass *klass, const void *data)
     BusClass *k = BUS_CLASS(klass);
     HotplugHandlerClass *hc = HOTPLUG_HANDLER_CLASS(klass);
 
+#ifdef CONFIG_HMP
     k->print_dev = usb_bus_dev_print;
+#endif
     k->get_dev_path = usb_get_dev_path;
     k->get_fw_dev_path = usb_get_fw_dev_path;
     hc->unplug = qdev_simple_device_unplug_cb;
@@ -543,6 +547,7 @@ static const char *usb_speed(unsigned int speed)
     return txt[speed];
 }
 
+#ifdef CONFIG_HMP
 static void usb_bus_dev_print(Monitor *mon, DeviceState *qdev, int indent)
 {
     USBDevice *dev = USB_DEVICE(qdev);
@@ -554,6 +559,7 @@ static void usb_bus_dev_print(Monitor *mon, DeviceState *qdev, int indent)
                    usb_speed(dev->speed), dev->product_desc,
                    dev->attached ? ", attached" : "");
 }
+#endif
 
 static char *usb_get_dev_path(DeviceState *qdev)
 {
diff --git a/hw/xen/xen-bus.c b/hw/xen/xen-bus.c
index dfad2bc5085..439cd47e849 100644
--- a/hw/xen/xen-bus.c
+++ b/hw/xen/xen-bus.c
@@ -100,6 +100,7 @@ abort:
     qemu_xen_xs_transaction_end(xenbus->xsh, tid, true);
 }
 
+#ifdef CONFIG_HMP
 static void xen_bus_print_dev(Monitor *mon, DeviceState *dev, int indent)
 {
     XenDevice *xendev = XEN_DEVICE(dev);
@@ -107,6 +108,7 @@ static void xen_bus_print_dev(Monitor *mon, DeviceState *dev, int indent)
     monitor_printf(mon, "%*sname = '%s' frontend_id = %u\n",
                    indent, "", xendev->name, xendev->frontend_id);
 }
+#endif
 
 static char *xen_bus_get_dev_path(DeviceState *dev)
 {
@@ -385,7 +387,9 @@ static void xen_bus_class_init(ObjectClass *class, const void *data)
     BusClass *bus_class = BUS_CLASS(class);
     HotplugHandlerClass *hotplug_class = HOTPLUG_HANDLER_CLASS(class);
 
+#ifdef CONFIG_HMP
     bus_class->print_dev = xen_bus_print_dev;
+#endif
     bus_class->get_dev_path = xen_bus_get_dev_path;
     bus_class->realize = xen_bus_realize;
     bus_class->unrealize = xen_bus_unrealize;
diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
index e5b55e3004c..7ed2008d81f 100644
--- a/system/qdev-monitor.c
+++ b/system/qdev-monitor.c
@@ -763,6 +763,7 @@ DeviceState *qdev_device_add(QemuOpts *opts, Error **errp)
     return ret;
 }
 
+#ifdef CONFIG_HMP
 #define qdev_printf(fmt, ...) monitor_printf(mon, "%*s" fmt, indent, "", ## __VA_ARGS__)
 
 static void qdev_print_props(Monitor *mon, DeviceState *dev, DeviceClass *dc,
@@ -864,6 +865,7 @@ void hmp_info_qdm(Monitor *mon, const QDict *qdict)
 {
     qdev_print_devinfos(true);
 }
+#endif
 
 void qmp_device_add(QDict *qdict, QObject **ret_data, Error **errp)
 {

-- 
2.54.0


