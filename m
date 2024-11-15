Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47635D68BCE
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2024 17:26:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tC05C-0004Sa-C7; Fri, 15 Nov 2024 12:26:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tC04s-0004Dn-DH
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 12:25:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tC04q-0001Xp-9K
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 12:25:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731691547;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j8dMChsOuS9jlDOz1J3yQmZCZaUyvVQsjl8ffWhr/CU=;
 b=Qw+4Kv/ytGkgb9n9X2vguu01nU/lmzboH02CTk/8jncvauPCpIxfoj9VIOPnZqB/K7P+ph
 Z73+3gAGtQSP/4rjgWsHe81ZUBHPb56R6vwjoaQTM83gt2aL9iQxnakQ8+h7zW3qGkJ/kJ
 xBIG2A+Lqjq8XmqappK/WTXW79ZxwOU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-146-GOKYSBTGN8ycXl4Zi5f1Mw-1; Fri,
 15 Nov 2024 12:25:46 -0500
X-MC-Unique: GOKYSBTGN8ycXl4Zi5f1Mw-1
X-Mimecast-MFC-AGG-ID: GOKYSBTGN8ycXl4Zi5f1Mw
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 59BAC195608C
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2024 17:25:45 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.102])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9B89C3003B74; Fri, 15 Nov 2024 17:25:43 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v3 8/9] convert code to qdev_new_dynamic() where appropriate
Date: Fri, 15 Nov 2024 17:25:20 +0000
Message-ID: <20241115172521.504102-9-berrange@redhat.com>
In-Reply-To: <20241115172521.504102-1-berrange@redhat.com>
References: <20241115172521.504102-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.12,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

In cases where qdev_new() is not being passed a static, const
string, the caller cannot be sure what type they are instantiating.
There is a risk that instantiation could fail, if it is an abstract
type.

Convert such cases over to use qdev_new_dynamic() such that they
are forced to expect failure. In some cases failure can be easily
propagated, but in others using &error_abort or &error_fatal will
maintain existing behaviour.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 hw/arm/aspeed.c            | 2 +-
 hw/arm/npcm7xx_boards.c    | 2 +-
 hw/arm/sbsa-ref.c          | 4 ++--
 hw/arm/vexpress.c          | 2 +-
 hw/arm/virt.c              | 4 ++--
 hw/audio/soundhw.c         | 2 +-
 hw/block/xen-block.c       | 7 ++++++-
 hw/core/sysbus.c           | 2 +-
 hw/i2c/core.c              | 2 +-
 hw/isa/isa-bus.c           | 2 +-
 hw/pci/pci.c               | 2 +-
 hw/ppc/pnv.c               | 2 +-
 hw/s390x/s390-virtio-ccw.c | 2 +-
 hw/scsi/scsi-bus.c         | 5 ++++-
 hw/ssi/ssi.c               | 2 +-
 include/hw/usb.h           | 2 +-
 include/qom/object.h       | 4 ++--
 net/net.c                  | 4 ++--
 system/qdev-monitor.c      | 5 ++++-
 19 files changed, 34 insertions(+), 23 deletions(-)

diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index 71196b0a4b..19dbcee64a 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -320,7 +320,7 @@ void aspeed_board_init_flashes(AspeedSMCState *s, const char *flashtype,
         DriveInfo *dinfo = drive_get(IF_MTD, 0, unit0 + i);
         DeviceState *dev;
 
-        dev = qdev_new(flashtype);
+        dev = qdev_new_dynamic(flashtype, &error_fatal);
         if (dinfo) {
             qdev_prop_set_drive(dev, "drive", blk_by_legacy_dinfo(dinfo));
         }
diff --git a/hw/arm/npcm7xx_boards.c b/hw/arm/npcm7xx_boards.c
index e229efb447..098beeab63 100644
--- a/hw/arm/npcm7xx_boards.c
+++ b/hw/arm/npcm7xx_boards.c
@@ -83,7 +83,7 @@ static void npcm7xx_connect_flash(NPCM7xxFIUState *fiu, int cs_no,
     DeviceState *flash;
     qemu_irq flash_cs;
 
-    flash = qdev_new(flash_type);
+    flash = qdev_new_dynamic(flash_type, &error_fatal);
     if (dinfo) {
         qdev_prop_set_drive(flash, "drive", blk_by_legacy_dinfo(dinfo));
     }
diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index a0006c9af0..12e0a70981 100644
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -419,7 +419,7 @@ static void create_its(SBSAMachineState *sms)
     const char *itsclass = its_class_name();
     DeviceState *dev;
 
-    dev = qdev_new(itsclass);
+    dev = qdev_new_dynamic(itsclass, &error_fatal);
 
     object_property_set_link(OBJECT(dev), "parent-gicv3", OBJECT(sms->gic),
                              &error_abort);
@@ -438,7 +438,7 @@ static void create_gic(SBSAMachineState *sms, MemoryRegion *mem)
 
     gictype = gicv3_class_name();
 
-    sms->gic = qdev_new(gictype);
+    sms->gic = qdev_new_dynamic(gictype, &error_fatal);
     qdev_prop_set_uint32(sms->gic, "revision", 3);
     qdev_prop_set_uint32(sms->gic, "num-cpu", smp_cpus);
     /*
diff --git a/hw/arm/vexpress.c b/hw/arm/vexpress.c
index 98ad6299a8..e13c66b838 100644
--- a/hw/arm/vexpress.c
+++ b/hw/arm/vexpress.c
@@ -239,7 +239,7 @@ static void init_cpus(MachineState *ms, const char *cpu_type,
      * this must happen after the CPUs are created because a15mpcore_priv
      * wires itself up to the CPU's generic_timer gpio out lines.
      */
-    dev = qdev_new(privdev);
+    dev = qdev_new_dynamic(privdev, &error_fatal);
     qdev_prop_set_uint32(dev, "num-cpu", smp_cpus);
     busdev = SYS_BUS_DEVICE(dev);
     sysbus_realize_and_unref(busdev, &error_fatal);
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index f80ab50d41..57b1735380 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -715,7 +715,7 @@ static void create_its(VirtMachineState *vms)
         return;
     }
 
-    dev = qdev_new(itsclass);
+    dev = qdev_new_dynamic(itsclass, &error_fatal);
 
     object_property_set_link(OBJECT(dev), "parent-gicv3", OBJECT(vms->gic),
                              &error_abort);
@@ -791,7 +791,7 @@ static void create_gic(VirtMachineState *vms, MemoryRegion *mem)
     default:
         g_assert_not_reached();
     }
-    vms->gic = qdev_new(gictype);
+    vms->gic = qdev_new_dynamic(gictype, &error_fatal);
     qdev_prop_set_uint32(vms->gic, "revision", revision);
     qdev_prop_set_uint32(vms->gic, "num-cpu", smp_cpus);
     /* Note that the num-irq property counts both internal and external
diff --git a/hw/audio/soundhw.c b/hw/audio/soundhw.c
index d18fd9fa05..17ed3a8084 100644
--- a/hw/audio/soundhw.c
+++ b/hw/audio/soundhw.c
@@ -132,7 +132,7 @@ void soundhw_init(void)
     }
 
     if (c->typename) {
-        DeviceState *dev = qdev_new(c->typename);
+        DeviceState *dev = qdev_new_dynamic(c->typename, &error_fatal);
         qdev_prop_set_string(dev, "audiodev", audiodev_id);
         qdev_realize_and_unref(dev, bus, &error_fatal);
     } else {
diff --git a/hw/block/xen-block.c b/hw/block/xen-block.c
index aed1d5c330..fd5fa7b6e7 100644
--- a/hw/block/xen-block.c
+++ b/hw/block/xen-block.c
@@ -1034,6 +1034,7 @@ static void xen_block_device_create(XenBackendInstance *backend,
     XenDevice *xendev = NULL;
     const char *type;
     XenBlockDevice *blockdev;
+    DeviceState *dev;
 
     if (qemu_strtoul(name, NULL, 10, &number)) {
         error_setg(errp, "failed to parse name '%s'", name);
@@ -1075,7 +1076,11 @@ static void xen_block_device_create(XenBackendInstance *backend,
         goto fail;
     }
 
-    xendev = XEN_DEVICE(qdev_new(type));
+    dev = qdev_new_dynamic(type, errp);
+    if (!dev) {
+        goto fail;
+    }
+    xendev = XEN_DEVICE(dev);
     blockdev = XEN_BLOCK_DEVICE(xendev);
 
     if (!object_property_set_str(OBJECT(xendev), "vdev", vdev,
diff --git a/hw/core/sysbus.c b/hw/core/sysbus.c
index e64d99c8ed..e472a969f1 100644
--- a/hw/core/sysbus.c
+++ b/hw/core/sysbus.c
@@ -221,7 +221,7 @@ DeviceState *sysbus_create_varargs(const char *name,
     qemu_irq irq;
     int n;
 
-    dev = qdev_new(name);
+    dev = qdev_new_dynamic(name, &error_fatal);
     s = SYS_BUS_DEVICE(dev);
     sysbus_realize_and_unref(s, &error_fatal);
     if (addr != (hwaddr)-1) {
diff --git a/hw/i2c/core.c b/hw/i2c/core.c
index 4cf30b2c86..a430f4e767 100644
--- a/hw/i2c/core.c
+++ b/hw/i2c/core.c
@@ -369,7 +369,7 @@ I2CSlave *i2c_slave_new(const char *name, uint8_t addr)
 {
     DeviceState *dev;
 
-    dev = qdev_new(name);
+    dev = qdev_new_dynamic(name, &error_fatal);
     qdev_prop_set_uint8(dev, "address", addr);
     return I2C_SLAVE(dev);
 }
diff --git a/hw/isa/isa-bus.c b/hw/isa/isa-bus.c
index 8aaf44a3ef..34330547cb 100644
--- a/hw/isa/isa-bus.c
+++ b/hw/isa/isa-bus.c
@@ -155,7 +155,7 @@ int isa_register_portio_list(ISADevice *dev,
 
 ISADevice *isa_new(const char *name)
 {
-    return ISA_DEVICE(qdev_new(name));
+    return ISA_DEVICE(qdev_new_dynamic(name, &error_fatal));
 }
 
 ISADevice *isa_create_simple(ISABus *bus, const char *name)
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 1416ae202c..51338320c1 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -2186,7 +2186,7 @@ static PCIDevice *pci_new_internal(int devfn, bool multifunction,
 {
     DeviceState *dev;
 
-    dev = qdev_new(name);
+    dev = qdev_new_dynamic(name, &error_fatal);
     qdev_prop_set_int32(dev, "addr", devfn);
     qdev_prop_set_bit(dev, "multifunction", multifunction);
     return PCI_DEVICE(dev);
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 75420c9413..e81c562967 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -1115,7 +1115,7 @@ static void pnv_init(MachineState *machine)
     pnv->chips = g_new0(PnvChip *, pnv->num_chips);
     for (i = 0; i < pnv->num_chips; i++) {
         char chip_name[32];
-        Object *chip = OBJECT(qdev_new(chip_typename));
+        Object *chip = OBJECT(qdev_new_dynamic(chip_typename, &error_fatal));
         uint64_t chip_ram_size =  pnv_chip_get_ram_size(pnv, i);
 
         pnv->chips[i] = PNV_CHIP(chip);
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 5441dc4c32..b276b5e77f 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -242,7 +242,7 @@ static void s390_create_sclpconsole(SCLPDevice *sclp,
     BusState *ev_fac_bus = sclp_get_event_facility_bus(ef);
     DeviceState *dev;
 
-    dev = qdev_new(type);
+    dev = qdev_new_dynamic(type, &error_fatal);
     object_property_add_child(OBJECT(ef), type, OBJECT(dev));
     qdev_prop_set_chr(dev, "chardev", chardev);
     qdev_realize_and_unref(dev, ev_fac_bus, &error_fatal);
diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
index 53eff5dd3d..23be8ebca4 100644
--- a/hw/scsi/scsi-bus.c
+++ b/hw/scsi/scsi-bus.c
@@ -396,7 +396,10 @@ SCSIDevice *scsi_bus_legacy_add_drive(SCSIBus *bus, BlockBackend *blk,
             driver = "scsi-hd";
         }
     }
-    dev = qdev_new(driver);
+    dev = qdev_new_dynamic(driver, errp);
+    if (!dev) {
+        return NULL;
+    }
     name = g_strdup_printf("legacy[%d]", unit);
     object_property_add_child(OBJECT(bus), name, OBJECT(dev));
     g_free(name);
diff --git a/hw/ssi/ssi.c b/hw/ssi/ssi.c
index 3f357e8f16..712bb1781c 100644
--- a/hw/ssi/ssi.c
+++ b/hw/ssi/ssi.c
@@ -141,7 +141,7 @@ bool ssi_realize_and_unref(DeviceState *dev, SSIBus *bus, Error **errp)
 
 DeviceState *ssi_create_peripheral(SSIBus *bus, const char *name)
 {
-    DeviceState *dev = qdev_new(name);
+    DeviceState *dev = qdev_new_dynamic(name, &error_fatal);
 
     ssi_realize_and_unref(dev, bus, &error_fatal);
     return dev;
diff --git a/include/hw/usb.h b/include/hw/usb.h
index bb778cb844..bb90098d39 100644
--- a/include/hw/usb.h
+++ b/include/hw/usb.h
@@ -581,7 +581,7 @@ void usb_pcap_data(USBPacket *p, bool setup);
 
 static inline USBDevice *usb_new(const char *name)
 {
-    return USB_DEVICE(qdev_new(name));
+    return USB_DEVICE(qdev_new_dynamic(name, &error_fatal));
 }
 
 static inline bool usb_realize_and_unref(USBDevice *dev, USBBus *bus, Error **errp)
diff --git a/include/qom/object.h b/include/qom/object.h
index 2d5a0d84b5..4e660da84a 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -654,7 +654,7 @@ Object *object_new_internal(const char *typename);
  * @typename: The name of the type of the object to instantiate.
  * @errp: pointer to be filled with error details on failure
  *
- * This method should be used where @typename is dynamically chosen
+ * This method must be used where @typename is dynamically chosen
  * at runtime, which has the possibility of unexpected choices leading
  * to failures.
  *
@@ -663,7 +663,7 @@ Object *object_new_internal(const char *typename);
  * the last reference is dropped.
  *
  * If an instance of @typename is not permitted to be instantiated, an
- * error will be raised. This can happen if @typename is abstract.
+ * error will be reported. This can happen if @typename is abstract.
  *
  * Returns: The newly allocated and instantiated object.
  */
diff --git a/net/net.c b/net/net.c
index fbbfe602a4..fa89ec8e03 100644
--- a/net/net.c
+++ b/net/net.c
@@ -1175,7 +1175,7 @@ DeviceState *qemu_create_nic_device(const char *typename, bool match_default,
         return NULL;
     }
 
-    dev = qdev_new(typename);
+    dev = qdev_new_dynamic(typename, &error_fatal);
     qdev_set_nic_properties(dev, nd);
     return dev;
 }
@@ -1225,7 +1225,7 @@ void qemu_create_nic_bus_devices(BusState *bus, const char *parent_type,
             continue;
         }
 
-        dev = qdev_new(model);
+        dev = qdev_new_dynamic(model, &error_fatal);
         qdev_set_nic_properties(dev, nd);
         qdev_realize_and_unref(dev, bus, &error_fatal);
     }
diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
index 4c09b38ffb..3138192cf8 100644
--- a/system/qdev-monitor.c
+++ b/system/qdev-monitor.c
@@ -686,7 +686,10 @@ DeviceState *qdev_device_add_from_qdict(const QDict *opts,
     }
 
     /* create device */
-    dev = qdev_new(driver);
+    dev = qdev_new_dynamic(driver, errp);
+    if (!dev) {
+        return NULL;
+    }
 
     /* Check whether the hotplug is allowed by the machine */
     if (phase_check(PHASE_MACHINE_READY)) {
-- 
2.46.0


