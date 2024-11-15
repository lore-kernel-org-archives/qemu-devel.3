Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3317D68BCE
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2024 17:27:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tC04c-000423-7X; Fri, 15 Nov 2024 12:25:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tC04a-00040z-7h
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 12:25:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tC04Y-0001Vi-HY
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 12:25:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731691529;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iM/IEvnr121ZAVLNB7YYGElME2ngtP8fjYEvWEWPm9k=;
 b=UNshaZCzNM3qz9s4NEOVVn6RMlTKDSAz6qVRYasEW6cIaB2fWCiTgHW2ZGxLLafP611Ree
 iaorQbrGukyvQLZa3Mr6hxCEYlS45Ojn6w95f+tgLhZy0hvY93zMF2j1kerEqFUzvM7zxm
 y4frgPdex917RM0HQXrF3sCxAU8h9DY=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-637-G5myefujMZiqFFa5KeMbWA-1; Fri,
 15 Nov 2024 12:25:28 -0500
X-MC-Unique: G5myefujMZiqFFa5KeMbWA-1
X-Mimecast-MFC-AGG-ID: G5myefujMZiqFFa5KeMbWA
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D07CB1977319
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2024 17:25:27 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.102])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E9EC83003B74; Fri, 15 Nov 2024 17:25:25 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v3 1/9] hw: eliminate qdev_try_new, isa_try_new & usb_try_new
Date: Fri, 15 Nov 2024 17:25:13 +0000
Message-ID: <20241115172521.504102-2-berrange@redhat.com>
In-Reply-To: <20241115172521.504102-1-berrange@redhat.com>
References: <20241115172521.504102-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.12,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.658,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

These functions all return NULL rather than asserting, if the requested
type is not registered and also cannot be dynamically loaded.

In several cases their usage is pointless, since the caller then just
reports an error & exits anyway. Easier to just let qdev_new fail
with &error_fatal.

In other cases, the desired semantics are clearer to understand if the
caller directly checks module_object_class_by_name(), before calling
the regular qdev_new (or specialized equiv) function.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 hw/core/qdev.c              |  9 ---------
 hw/i386/pc.c                | 22 ++++++++++------------
 hw/isa/isa-bus.c            |  5 -----
 hw/s390x/s390-pci-bus.c     |  6 +-----
 hw/usb/bus.c                |  6 ++----
 include/hw/isa/isa.h        |  1 -
 include/hw/net/ne2000-isa.h | 16 ++++++----------
 include/hw/qdev-core.h      | 12 ------------
 include/hw/usb.h            |  5 -----
 9 files changed, 19 insertions(+), 63 deletions(-)

diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 5f13111b77..960a704a96 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -149,15 +149,6 @@ DeviceState *qdev_new(const char *name)
     return DEVICE(object_new(name));
 }
 
-DeviceState *qdev_try_new(const char *name)
-{
-    ObjectClass *oc = module_object_class_by_name(name);
-    if (!oc) {
-        return NULL;
-    }
-    return DEVICE(object_new_with_class(oc));
-}
-
 static QTAILQ_HEAD(, DeviceListener) device_listeners
     = QTAILQ_HEAD_INITIALIZER(device_listeners);
 
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index f9147fecbd..d668970bee 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -596,9 +596,11 @@ static gboolean pc_init_ne2k_isa(ISABus *bus, NICInfo *nd, Error **errp)
                    "maximum number of ISA NE2000 devices exceeded");
         return false;
     }
-    isa_ne2000_init(bus, ne2000_io[nb_ne2k],
-                    ne2000_irq[nb_ne2k], nd);
-    nb_ne2k++;
+    if (module_object_class_by_name(TYPE_ISA_NE2000)) {
+        isa_ne2000_init(bus, ne2000_io[nb_ne2k],
+                        ne2000_irq[nb_ne2k], nd);
+        nb_ne2k++;
+    }
     return true;
 }
 
@@ -1087,7 +1089,7 @@ static void pc_superio_init(ISABus *isa_bus, bool create_fdctrl,
     int i;
     DriveInfo *fd[MAX_FD];
     qemu_irq *a20_line;
-    ISADevice *i8042, *port92, *vmmouse;
+    ISADevice *i8042, *port92, *vmmouse = NULL;
 
     serial_hds_isa_init(isa_bus, 0, MAX_ISA_SERIAL_PORTS);
     parallel_hds_isa_init(isa_bus, MAX_PARALLEL_PORTS);
@@ -1117,9 +1119,9 @@ static void pc_superio_init(ISABus *isa_bus, bool create_fdctrl,
     i8042 = isa_create_simple(isa_bus, TYPE_I8042);
     if (!no_vmport) {
         isa_create_simple(isa_bus, TYPE_VMPORT);
-        vmmouse = isa_try_new("vmmouse");
-    } else {
-        vmmouse = NULL;
+        if (module_object_class_by_name("vmmouse")) {
+            vmmouse = isa_new("vmmouse");
+        }
     }
     if (vmmouse) {
         object_property_set_link(OBJECT(vmmouse), TYPE_I8042, OBJECT(i8042),
@@ -1163,11 +1165,7 @@ void pc_basic_device_init(struct PCMachineState *pcms,
     if (pcms->hpet_enabled) {
         qemu_irq rtc_irq;
 
-        hpet = qdev_try_new(TYPE_HPET);
-        if (!hpet) {
-            error_report("couldn't create HPET device");
-            exit(1);
-        }
+        hpet = qdev_new(TYPE_HPET);
         /*
          * For pc-piix-*, hpet's intcap is always IRQ2. For pc-q35-*,
          * use IRQ16~23, IRQ8 and IRQ2.  If the user has already set
diff --git a/hw/isa/isa-bus.c b/hw/isa/isa-bus.c
index f1e0f14007..8aaf44a3ef 100644
--- a/hw/isa/isa-bus.c
+++ b/hw/isa/isa-bus.c
@@ -158,11 +158,6 @@ ISADevice *isa_new(const char *name)
     return ISA_DEVICE(qdev_new(name));
 }
 
-ISADevice *isa_try_new(const char *name)
-{
-    return ISA_DEVICE(qdev_try_new(name));
-}
-
 ISADevice *isa_create_simple(ISABus *bus, const char *name)
 {
     ISADevice *dev;
diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index 40b2567aa7..558f17d3ba 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -922,11 +922,7 @@ static S390PCIBusDevice *s390_pci_device_new(S390pciState *s,
     Error *local_err = NULL;
     DeviceState *dev;
 
-    dev = qdev_try_new(TYPE_S390_PCI_DEVICE);
-    if (!dev) {
-        error_setg(errp, "zPCI device could not be created");
-        return NULL;
-    }
+    dev = qdev_new(TYPE_S390_PCI_DEVICE);
 
     if (!object_property_set_str(OBJECT(dev), "target", target, &local_err)) {
         object_unparent(OBJECT(dev));
diff --git a/hw/usb/bus.c b/hw/usb/bus.c
index bfab2807d7..002f7737e4 100644
--- a/hw/usb/bus.c
+++ b/hw/usb/bus.c
@@ -394,7 +394,6 @@ void usb_claim_port(USBDevice *dev, Error **errp)
 {
     USBBus *bus = usb_bus_from_device(dev);
     USBPort *port;
-    USBDevice *hub;
 
     assert(dev->port == NULL);
 
@@ -412,9 +411,8 @@ void usb_claim_port(USBDevice *dev, Error **errp)
     } else {
         if (bus->nfree == 1 && strcmp(object_get_typename(OBJECT(dev)), "usb-hub") != 0) {
             /* Create a new hub and chain it on */
-            hub = usb_try_new("usb-hub");
-            if (hub) {
-                usb_realize_and_unref(hub, bus, NULL);
+            if (module_object_class_by_name("usb-hub")) {
+                usb_realize_and_unref(usb_new("usb-hub"), bus, NULL);
             }
         }
         if (bus->nfree == 0) {
diff --git a/include/hw/isa/isa.h b/include/hw/isa/isa.h
index 40d6224a4e..8475120849 100644
--- a/include/hw/isa/isa.h
+++ b/include/hw/isa/isa.h
@@ -81,7 +81,6 @@ IsaDma *isa_bus_get_dma(ISABus *bus, int nchan);
  */
 qemu_irq isa_bus_get_irq(ISABus *bus, unsigned irqnum);
 ISADevice *isa_new(const char *name);
-ISADevice *isa_try_new(const char *name);
 bool isa_realize_and_unref(ISADevice *dev, ISABus *bus, Error **errp);
 ISADevice *isa_create_simple(ISABus *bus, const char *name);
 
diff --git a/include/hw/net/ne2000-isa.h b/include/hw/net/ne2000-isa.h
index 73bae10ad1..aeb3e2bfd5 100644
--- a/include/hw/net/ne2000-isa.h
+++ b/include/hw/net/ne2000-isa.h
@@ -20,17 +20,13 @@
 static inline ISADevice *isa_ne2000_init(ISABus *bus, int base, int irq,
                                          NICInfo *nd)
 {
-    ISADevice *d;
+    ISADevice *d = isa_new(TYPE_ISA_NE2000);
+    DeviceState *dev = DEVICE(d);
 
-    d = isa_try_new(TYPE_ISA_NE2000);
-    if (d) {
-        DeviceState *dev = DEVICE(d);
-
-        qdev_prop_set_uint32(dev, "iobase", base);
-        qdev_prop_set_uint32(dev, "irq",    irq);
-        qdev_set_nic_properties(dev, nd);
-        isa_realize_and_unref(d, bus, &error_fatal);
-    }
+    qdev_prop_set_uint32(dev, "iobase", base);
+    qdev_prop_set_uint32(dev, "irq",    irq);
+    qdev_set_nic_properties(dev, nd);
+    isa_realize_and_unref(d, bus, &error_fatal);
     return d;
 }
 
diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index 5be9844412..020417d027 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -443,18 +443,6 @@ compat_props_add(GPtrArray *arr,
  */
 DeviceState *qdev_new(const char *name);
 
-/**
- * qdev_try_new: Try to create a device on the heap
- * @name: device type to create
- *
- * This is like qdev_new(), except it returns %NULL when type @name
- * does not exist, rather than asserting.
- *
- * Return: a derived DeviceState object with a reference count of 1 or
- * NULL if type @name does not exist.
- */
-DeviceState *qdev_try_new(const char *name);
-
 /**
  * qdev_is_realized() - check if device is realized
  * @dev: The device to check.
diff --git a/include/hw/usb.h b/include/hw/usb.h
index d46d96779a..bb778cb844 100644
--- a/include/hw/usb.h
+++ b/include/hw/usb.h
@@ -584,11 +584,6 @@ static inline USBDevice *usb_new(const char *name)
     return USB_DEVICE(qdev_new(name));
 }
 
-static inline USBDevice *usb_try_new(const char *name)
-{
-    return USB_DEVICE(qdev_try_new(name));
-}
-
 static inline bool usb_realize_and_unref(USBDevice *dev, USBBus *bus, Error **errp)
 {
     return qdev_realize_and_unref(&dev->qdev, &bus->qbus, errp);
-- 
2.46.0


