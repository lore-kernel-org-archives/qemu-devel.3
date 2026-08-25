Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23A92C61DB9
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 19:14:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wywZi-0002XL-W6; Tue, 25 Aug 2026 15:12:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wywZg-0002GA-De
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 15:12:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wywZd-0004Rp-G8
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 15:12:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787685157;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=57QfcTR5j/zJ5KMJTDu3qOnAc1zj+QlnuAt4vX2DJrQ=;
 b=PAx+BzE98XqQZeEyqzz9YnYCYb3+XeTS6t3WAt01LmhAxLxS++s5zxJjumMfpcYEGDIoxe
 S0LfhlmehVseeS0VjsJvN4S+Da29w0c7SCyfLItqbL7+v/LtwfyrjzK3TP4b/h6rBKLuPE
 BP9wM0g4SRZ/GWzD9JTFdn9NnV1QQ8c=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-613-jc1F5kuNMgCFWJ1OoF_V0A-1; Tue,
 25 Aug 2026 15:12:34 -0400
X-MC-Unique: jc1F5kuNMgCFWJ1OoF_V0A-1
X-Mimecast-MFC-AGG-ID: jc1F5kuNMgCFWJ1OoF_V0A_1787685152
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9DB4618C0FEF; Tue, 25 Aug 2026 19:12:32 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 79C8F30002F7; Tue, 25 Aug 2026 19:12:31 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 25 Aug 2026 23:09:45 +0400
Subject: [PATCH v4 38/49] qdev-monitor: make print_dev() callback take
 MonitorHMP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260825-qemu-no-hmp-v4-38-af60857c2fbe@redhat.com>
References: <20260825-qemu-no-hmp-v4-0-af60857c2fbe@redhat.com>
In-Reply-To: <20260825-qemu-no-hmp-v4-0-af60857c2fbe@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 dave@treblig.org, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Laurent Vivier <lvivier@redhat.com>, Amit Shah <amit@kernel.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Stefano Stabellini <sstabellini@kernel.org>, 
 Anthony PERARD <anthony@xenproject.org>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 xen-devel@lists.xenproject.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=8798;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=TnV/ecEwZ8dNWntwBJ1/B+qLywO2KqD7Jgy5xW81cUE=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqjeiI1ORwMVhtLFs/MqLkfYMW91qiIkX2bbWKf
 zaoUdClu3aJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCao3oiAAKCRDa6OEJdZac
 5RPJD/9voh4Ssrd7KFIE0Of1vZrgv5Zzbs1/rJAoLNlOOYasoOJkkCKkLa1JiPZnapucPEmaZgk
 tJIpDEUZjgDr4MYLEMX1Ef67nCjqNJwWZvZSNzmdPaCqtjfCwtQ0Ssq8pz5nBHaqwn2bw/pPXap
 yRtz7/QjwE8RGAx8ARfyqqRjiqMFbCAqF0Dy4m2povT+XADWrKkocSmET2f8/6r0yW+AvLzX8Y7
 mIdXyGQyPOPdtz7Sw5wUs6Oi84opLDTv3E0IqvqXlGgWTwDfFClnuf49OFxYDv7OlLFjtkBtxQf
 Q9Zohr7W0CcYFy4H1vYfFTSE0EG2On8Ko+M5o0JsLwmXHwsQCxbuAiIgNnVzWbNOR5nokD5489P
 KwZaItJuo8vmzQ9I24Dw8GQxZ29/qh1ARZFs5ppqgXxIxT992Ll8s3ZknfqZ2MOPNj2zwm62K2I
 99ZzagmgL8Q5tdL3yRe2h3qiMjxbm5dFHZEzHtrxELmoV5qjP5HkMkiQ6WN0mquoT0Frsk4k31l
 HrOA5RjvIhGOF2v3QBPw4pSC4fPyLA3yzimjelERjskqygwttoTQ9z+StNDCsTfqDTmE7f+FvAk
 swtTMwRUm96FjFpwGc5LQ3aOEWOM1hiKl1vYkgo9DgXXyt7/BldDn4F+MT5ItYID3qGc9eYB3Yc
 IPsRMZMFKhJfXJA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The callback is specific to HMP context, avoid unsafe MONITOR_HMP()
cast.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/char/virtio-serial-bus.c | 6 +++---
 hw/core/sysbus.c            | 5 ++---
 hw/misc/auxbus.c            | 7 +++----
 hw/pci/pci-hmp-cmds.c       | 3 +--
 hw/pci/pci-internal.h       | 2 +-
 hw/usb/bus.c                | 5 ++---
 hw/xen/xen-bus.c            | 3 +--
 include/hw/core/qdev.h      | 3 ++-
 system/qdev-monitor.c       | 7 +++----
 9 files changed, 18 insertions(+), 23 deletions(-)

diff --git a/hw/char/virtio-serial-bus.c b/hw/char/virtio-serial-bus.c
index 33fdc0846ac3..4dcc4516e45e 100644
--- a/hw/char/virtio-serial-bus.c
+++ b/hw/char/virtio-serial-bus.c
@@ -814,7 +814,7 @@ static int virtio_serial_load_device(VirtIODevice *vdev, QEMUFile *f,
     return 0;
 }
 
-static void virtser_bus_dev_print(Monitor *mon, DeviceState *qdev, int indent);
+static void virtser_bus_dev_print(MonitorHMP *hmp, DeviceState *qdev, int indent);
 
 static const Property virtser_props[] = {
     DEFINE_PROP_UINT32("nr", VirtIOSerialPort, id, VIRTIO_CONSOLE_BAD_ID),
@@ -834,11 +834,11 @@ static const TypeInfo virtser_bus_info = {
     .class_init = virtser_bus_class_init,
 };
 
-static void virtser_bus_dev_print(Monitor *mon, DeviceState *qdev, int indent)
+static void virtser_bus_dev_print(MonitorHMP *hmp, DeviceState *qdev, int indent)
 {
     VirtIOSerialPort *port = VIRTIO_SERIAL_PORT(qdev);
 
-    monitor_hmp_printf(MONITOR_HMP(mon), "%*sport %d, guest %s, host %s, throttle %s\n",
+    monitor_hmp_printf(hmp, "%*sport %d, guest %s, host %s, throttle %s\n",
                        indent, "", port->id,
                        port->guest_connected ? "on" : "off",
                        port->host_connected ? "on" : "off",
diff --git a/hw/core/sysbus.c b/hw/core/sysbus.c
index 82130ba04698..31c4fdf79d48 100644
--- a/hw/core/sysbus.c
+++ b/hw/core/sysbus.c
@@ -24,7 +24,7 @@
 #include "monitor/hmp.h"
 #include "system/address-spaces.h"
 
-static void sysbus_dev_print(Monitor *mon, DeviceState *dev, int indent);
+static void sysbus_dev_print(MonitorHMP *hmp, DeviceState *dev, int indent);
 static char *sysbus_get_fw_dev_path(DeviceState *dev);
 
 typedef struct SysBusFind {
@@ -249,10 +249,9 @@ bool sysbus_realize_and_unref(SysBusDevice *dev, Error **errp)
     return qdev_realize_and_unref(DEVICE(dev), sysbus_get_default(), errp);
 }
 
-static void sysbus_dev_print(Monitor *mon, DeviceState *dev, int indent)
+static void sysbus_dev_print(MonitorHMP *hmp, DeviceState *dev, int indent)
 {
     SysBusDevice *s = SYS_BUS_DEVICE(dev);
-    MonitorHMP *hmp = MONITOR_HMP(mon);
     hwaddr size;
     int i;
 
diff --git a/hw/misc/auxbus.c b/hw/misc/auxbus.c
index ffa76f83016b..0bb89c5a60ab 100644
--- a/hw/misc/auxbus.c
+++ b/hw/misc/auxbus.c
@@ -47,7 +47,7 @@
 } while (0)
 
 
-static void aux_slave_dev_print(Monitor *mon, DeviceState *dev, int indent);
+static void aux_slave_dev_print(MonitorHMP *hmp, DeviceState *dev, int indent);
 static inline I2CBus *aux_bridge_get_i2c_bus(AUXTOI2CState *bridge);
 
 /* aux-bus implementation (internal not public) */
@@ -288,7 +288,7 @@ static const TypeInfo aux_to_i2c_type_info = {
 };
 
 /* aux-slave implementation */
-static void aux_slave_dev_print(Monitor *mon, DeviceState *dev, int indent)
+static void aux_slave_dev_print(MonitorHMP *hmp, DeviceState *dev, int indent)
 {
     AUXBus *bus = AUX_BUS(qdev_get_parent_bus(dev));
     AUXSlave *s;
@@ -300,8 +300,7 @@ static void aux_slave_dev_print(Monitor *mon, DeviceState *dev, int indent)
 
     s = AUX_SLAVE(dev);
 
-    monitor_hmp_printf(MONITOR_HMP(mon),
-                       "%*smemory " HWADDR_FMT_plx "/" HWADDR_FMT_plx "\n",
+    monitor_hmp_printf(hmp, "%*smemory " HWADDR_FMT_plx "/" HWADDR_FMT_plx "\n",
                        indent, "",
                        object_property_get_uint(OBJECT(s->mmio), "addr", NULL),
                        memory_region_size(s->mmio));
diff --git a/hw/pci/pci-hmp-cmds.c b/hw/pci/pci-hmp-cmds.c
index 500f821246a9..bcccfaf07f4d 100644
--- a/hw/pci/pci-hmp-cmds.c
+++ b/hw/pci/pci-hmp-cmds.c
@@ -135,9 +135,8 @@ void hmp_info_pci(MonitorHMP *hmp, const QDict *qdict)
     qapi_free_PciInfoList(info_list);
 }
 
-void pcibus_dev_print(Monitor *mon, DeviceState *dev, int indent)
+void pcibus_dev_print(MonitorHMP *hmp, DeviceState *dev, int indent)
 {
-    MonitorHMP *hmp = MONITOR_HMP(mon);
     PCIDevice *d = (PCIDevice *)dev;
     int class = pci_get_word(d->config + PCI_CLASS_DEVICE);
     const pci_class_desc *desc = get_class_desc(class);
diff --git a/hw/pci/pci-internal.h b/hw/pci/pci-internal.h
index a7d6d8a7324e..b7231fab5dc9 100644
--- a/hw/pci/pci-internal.h
+++ b/hw/pci/pci-internal.h
@@ -16,7 +16,7 @@ extern PCIHostStateList pci_host_bridges;
 
 const pci_class_desc *get_class_desc(int class);
 PCIBus *pci_find_bus_nr(PCIBus *bus, int bus_num);
-void pcibus_dev_print(Monitor *mon, DeviceState *dev, int indent);
+void pcibus_dev_print(MonitorHMP *mon, DeviceState *dev, int indent);
 
 int pcie_aer_parse_error_string(const char *error_name,
                                 uint32_t *status, bool *correctable);
diff --git a/hw/usb/bus.c b/hw/usb/bus.c
index fe3dbfa2227c..8bd25a9d872a 100644
--- a/hw/usb/bus.c
+++ b/hw/usb/bus.c
@@ -13,7 +13,7 @@
 #include "trace.h"
 #include "qemu/cutils.h"
 
-static void usb_bus_dev_print(Monitor *mon, DeviceState *qdev, int indent);
+static void usb_bus_dev_print(MonitorHMP *hmp, DeviceState *qdev, int indent);
 
 static char *usb_get_dev_path(DeviceState *dev);
 static char *usb_get_fw_dev_path(DeviceState *qdev);
@@ -544,9 +544,8 @@ static const char *usb_speed(unsigned int speed)
     return txt[speed];
 }
 
-static void usb_bus_dev_print(Monitor *mon, DeviceState *qdev, int indent)
+static void usb_bus_dev_print(MonitorHMP *hmp, DeviceState *qdev, int indent)
 {
-    MonitorHMP *hmp = MONITOR_HMP(mon);
     USBDevice *dev = USB_DEVICE(qdev);
     USBBus *bus = usb_bus_from_device(dev);
 
diff --git a/hw/xen/xen-bus.c b/hw/xen/xen-bus.c
index 4075b5b001ae..b81a067e7753 100644
--- a/hw/xen/xen-bus.c
+++ b/hw/xen/xen-bus.c
@@ -101,9 +101,8 @@ abort:
     qemu_xen_xs_transaction_end(xenbus->xsh, tid, true);
 }
 
-static void xen_bus_print_dev(Monitor *mon, DeviceState *dev, int indent)
+static void xen_bus_print_dev(MonitorHMP *hmp, DeviceState *dev, int indent)
 {
-    MonitorHMP *hmp = MONITOR_HMP(mon);
     XenDevice *xendev = XEN_DEVICE(dev);
 
     monitor_hmp_printf(hmp, "%*sname = '%s' frontend_id = %u\n",
diff --git a/include/hw/core/qdev.h b/include/hw/core/qdev.h
index 37f7d3355193..1391dc060caf 100644
--- a/include/hw/core/qdev.h
+++ b/include/hw/core/qdev.h
@@ -10,6 +10,7 @@
 #include "qom/object.h"
 #include "hw/core/hotplug.h"
 #include "hw/core/resettable.h"
+#include "monitor/hmp.h"
 
 /**
  * DOC: The QEMU Device API
@@ -323,7 +324,7 @@ struct BusClass {
     ObjectClass parent_class;
 
     /* FIXME first arg should be BusState */
-    void (*print_dev)(Monitor *mon, DeviceState *dev, int indent);
+    void (*print_dev)(MonitorHMP *mon, DeviceState *dev, int indent);
     /*
      * Return a newly allocated string containing the path of the
      * device on this bus.
diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
index 3860ada2a237..13ac9f8f3be1 100644
--- a/system/qdev-monitor.c
+++ b/system/qdev-monitor.c
@@ -790,18 +790,17 @@ static void qdev_print_props(MonitorHMP *hmp, DeviceState *dev, DeviceClass *dc,
     }
 }
 
-static void bus_print_dev(BusState *bus, Monitor *mon, DeviceState *dev, int indent)
+static void bus_print_dev(BusState *bus, MonitorHMP *hmp, DeviceState *dev, int indent)
 {
     BusClass *bc = BUS_GET_CLASS(bus);
 
     if (bc->print_dev) {
-        bc->print_dev(mon, dev, indent);
+        bc->print_dev(hmp, dev, indent);
     }
 }
 
 static void qdev_print(MonitorHMP *hmp, DeviceState *dev, int indent)
 {
-    Monitor *mon = MONITOR(hmp);
     ObjectClass *class;
     NamedGPIOList *ngl;
     NamedClockList *ncl;
@@ -828,7 +827,7 @@ static void qdev_print(MonitorHMP *hmp, DeviceState *dev, int indent)
         qdev_print_props(hmp, dev, DEVICE_CLASS(class), indent);
         class = object_class_get_parent(class);
     } while (class != object_class_by_name(TYPE_DEVICE));
-    bus_print_dev(dev->parent_bus, mon, dev, indent);
+    bus_print_dev(dev->parent_bus, hmp, dev, indent);
 }
 
 static void qbus_print(MonitorHMP *hmp, BusState *bus, int indent, bool details)

-- 
2.55.0.543.g5ebe2ebe4ea8


