Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A4A2CEF151
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 10:58:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sy7tq-0003Mk-QN; Tue, 08 Oct 2024 06:57:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1sy7tA-00023I-Sc
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 06:56:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1sy7t8-0001mF-KL
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 06:56:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728384981;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=69hri59KYylWZ5oi8AQj7hjywQm9gem6vRXNxK6MfZA=;
 b=eP3zN1o4hLWTvb8ta1YEDvxLCYCyLGCx5K31wbP+dKHGPFxWc/mXjE3SzJvz1+nEnKLj8n
 KOPIukSOrOwos7rGkhv9P+PassjjCnAaZRd07vWJdH30AAubjMsP+srT3aIQ5DcaI+1t6s
 p9K3/9K/gDqLuuilqj0gkO++LX/3dAs=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-347-pDsFdSc0NDab7TkZd1lx4g-1; Tue,
 08 Oct 2024 06:56:16 -0400
X-MC-Unique: pDsFdSc0NDab7TkZd1lx4g-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 323261955DCE; Tue,  8 Oct 2024 10:56:15 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.22.16.102])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EBD0119560A3; Tue,  8 Oct 2024 10:56:09 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, David Hildenbrand <david@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>
Subject: [PATCH v2 13/14] s390x/virtio-ccw: add support for virtio based
 memory devices
Date: Tue,  8 Oct 2024 12:54:54 +0200
Message-ID: <20241008105455.2302628-14-david@redhat.com>
In-Reply-To: <20241008105455.2302628-1-david@redhat.com>
References: <20241008105455.2302628-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.153,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Let's implement support for abstract virtio based memory devices, using
the virtio-pci implementation as an orientation. Wire them up in the
machine hotplug handler, taking care of s390x page size limitations.

As we neither support virtio-mem or virtio-pmem yet, the code is
effectively unused. We'll implement support for virtio-mem based on this
next.

Note that we won't wire up the virtio-pci variant (should currently be
impossible due to lack of support for MSI-X), but we'll add a safety net
to reject plugging them in the pre-plug handler.

Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 MAINTAINERS                    |   3 +
 hw/s390x/meson.build           |   3 +
 hw/s390x/s390-virtio-ccw.c     |  47 +++++++++-
 hw/s390x/virtio-ccw-md-stubs.c |  24 ++++++
 hw/s390x/virtio-ccw-md.c       | 153 +++++++++++++++++++++++++++++++++
 hw/s390x/virtio-ccw-md.h       |  44 ++++++++++
 hw/virtio/Kconfig              |   1 +
 7 files changed, 274 insertions(+), 1 deletion(-)
 create mode 100644 hw/s390x/virtio-ccw-md-stubs.c
 create mode 100644 hw/s390x/virtio-ccw-md.c
 create mode 100644 hw/s390x/virtio-ccw-md.h

diff --git a/MAINTAINERS b/MAINTAINERS
index d7a11fe601..1b337f52d1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2325,6 +2325,9 @@ F: include/hw/virtio/virtio-crypto.h
 virtio based memory device
 M: David Hildenbrand <david@redhat.com>
 S: Supported
+F: hw/s390x/virtio-ccw-md.c
+F: hw/s390x/virtio-ccw-md.h
+F: hw/s390x/virtio-ccw-md-stubs.c
 F: hw/virtio/virtio-md-pci.c
 F: include/hw/virtio/virtio-md-pci.h
 F: stubs/virtio-md-pci.c
diff --git a/hw/s390x/meson.build b/hw/s390x/meson.build
index 71ec747f4c..28bbe4b06c 100644
--- a/hw/s390x/meson.build
+++ b/hw/s390x/meson.build
@@ -48,8 +48,11 @@ endif
 virtio_ss.add(when: 'CONFIG_VHOST_SCSI', if_true: files('vhost-scsi-ccw.c'))
 virtio_ss.add(when: 'CONFIG_VHOST_VSOCK', if_true: files('vhost-vsock-ccw.c'))
 virtio_ss.add(when: 'CONFIG_VHOST_USER_FS', if_true: files('vhost-user-fs-ccw.c'))
+virtio_ss.add(when: 'CONFIG_VIRTIO_MD', if_true: files('virtio-ccw-md.c'))
 s390x_ss.add_all(when: 'CONFIG_VIRTIO_CCW', if_true: virtio_ss)
 
+s390x_ss.add(when: 'CONFIG_VIRTIO_MD', if_false: files('virtio-ccw-md-stubs.c'))
+
 hw_arch += {'s390x': s390x_ss}
 
 hw_s390x_modules = {}
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 65f266a78f..16be9f25e8 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -46,6 +46,8 @@
 #include "qapi/visitor.h"
 #include "hw/s390x/cpu-topology.h"
 #include "kvm/kvm_s390x.h"
+#include "hw/virtio/virtio-md-pci.h"
+#include "hw/s390x/virtio-ccw-md.h"
 #include CONFIG_DEVICES
 
 static Error *pv_mig_blocker;
@@ -559,11 +561,39 @@ static void s390_machine_reset(MachineState *machine, ResetType type)
     s390_ipl_clear_reset_request();
 }
 
+static void s390_machine_device_pre_plug(HotplugHandler *hotplug_dev,
+                                         DeviceState *dev, Error **errp)
+{
+    if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MD_CCW)) {
+        virtio_ccw_md_pre_plug(VIRTIO_MD_CCW(dev), MACHINE(hotplug_dev), errp);
+    } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MD_PCI)) {
+        error_setg(errp,
+                   "PCI-attached virtio based memory devices not supported");
+    }
+}
+
 static void s390_machine_device_plug(HotplugHandler *hotplug_dev,
                                      DeviceState *dev, Error **errp)
 {
+    S390CcwMachineState *s390ms = S390_CCW_MACHINE(hotplug_dev);
+
     if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
         s390_cpu_plug(hotplug_dev, dev, errp);
+    } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MD_CCW)) {
+        /*
+         * At this point, the device is realized and set all memdevs mapped, so
+         * qemu_maxrampagesize() will pick up the page sizes of these memdevs
+         * as well. Before we plug the device and expose any RAM memory regions
+         * to the system, make sure we don't exceed the previously set max page
+         * size. While only relevant for KVM, there is not really any use case
+         * for this with TCG, so we'll unconditionally reject it.
+         */
+        if (qemu_maxrampagesize() != s390ms->max_pagesize) {
+            error_setg(errp, "Memory device uses a bigger page size than"
+                       " initial memory");
+            return;
+        }
+        virtio_ccw_md_plug(VIRTIO_MD_CCW(dev), MACHINE(hotplug_dev), errp);
     }
 }
 
@@ -573,9 +603,20 @@ static void s390_machine_device_unplug_request(HotplugHandler *hotplug_dev,
     if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
         error_setg(errp, "CPU hot unplug not supported on this machine");
         return;
+    } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MD_CCW)) {
+        virtio_ccw_md_unplug_request(VIRTIO_MD_CCW(dev), MACHINE(hotplug_dev),
+                                     errp);
     }
 }
 
+static void s390_machine_device_unplug(HotplugHandler *hotplug_dev,
+                                       DeviceState *dev, Error **errp)
+{
+    if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MD_CCW)) {
+        virtio_ccw_md_unplug(VIRTIO_MD_CCW(dev), MACHINE(hotplug_dev), errp);
+     }
+ }
+
 static CpuInstanceProperties s390_cpu_index_to_props(MachineState *ms,
                                                      unsigned cpu_index)
 {
@@ -622,7 +663,9 @@ static const CPUArchIdList *s390_possible_cpu_arch_ids(MachineState *ms)
 static HotplugHandler *s390_get_hotplug_handler(MachineState *machine,
                                                 DeviceState *dev)
 {
-    if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
+    if (object_dynamic_cast(OBJECT(dev), TYPE_CPU) ||
+        object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MD_CCW) ||
+        object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MD_PCI)) {
         return HOTPLUG_HANDLER(machine);
     }
     return NULL;
@@ -798,8 +841,10 @@ static void ccw_machine_class_init(ObjectClass *oc, void *data)
     mc->possible_cpu_arch_ids = s390_possible_cpu_arch_ids;
     /* it is overridden with 'host' cpu *in kvm_arch_init* */
     mc->default_cpu_type = S390_CPU_TYPE_NAME("qemu");
+    hc->pre_plug = s390_machine_device_pre_plug;
     hc->plug = s390_machine_device_plug;
     hc->unplug_request = s390_machine_device_unplug_request;
+    hc->unplug = s390_machine_device_unplug;
     nc->nmi_monitor_handler = s390_nmi;
     mc->default_ram_id = "s390.ram";
     mc->default_nic = "virtio-net-ccw";
diff --git a/hw/s390x/virtio-ccw-md-stubs.c b/hw/s390x/virtio-ccw-md-stubs.c
new file mode 100644
index 0000000000..e937865550
--- /dev/null
+++ b/hw/s390x/virtio-ccw-md-stubs.c
@@ -0,0 +1,24 @@
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "hw/s390x/virtio-ccw-md.h"
+
+void virtio_ccw_md_pre_plug(VirtIOMDCcw *vmd, MachineState *ms, Error **errp)
+{
+    error_setg(errp, "virtio based memory devices not supported");
+}
+
+void virtio_ccw_md_plug(VirtIOMDCcw *vmd, MachineState *ms, Error **errp)
+{
+    error_setg(errp, "virtio based memory devices not supported");
+}
+
+void virtio_ccw_md_unplug_request(VirtIOMDCcw *vmd, MachineState *ms,
+                                  Error **errp)
+{
+    error_setg(errp, "virtio based memory devices not supported");
+}
+
+void virtio_ccw_md_unplug(VirtIOMDCcw *vmd, MachineState *ms, Error **errp)
+{
+    error_setg(errp, "virtio based memory devices not supported");
+}
diff --git a/hw/s390x/virtio-ccw-md.c b/hw/s390x/virtio-ccw-md.c
new file mode 100644
index 0000000000..de333282df
--- /dev/null
+++ b/hw/s390x/virtio-ccw-md.c
@@ -0,0 +1,153 @@
+/*
+ * Virtio CCW support for abstract virtio based memory device
+ *
+ * Copyright (C) 2024 Red Hat, Inc.
+ *
+ * Authors:
+ *  David Hildenbrand <david@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "hw/s390x/virtio-ccw-md.h"
+#include "hw/mem/memory-device.h"
+#include "qapi/error.h"
+#include "qemu/error-report.h"
+
+void virtio_ccw_md_pre_plug(VirtIOMDCcw *vmd, MachineState *ms, Error **errp)
+{
+    DeviceState *dev = DEVICE(vmd);
+    HotplugHandler *bus_handler = qdev_get_bus_hotplug_handler(dev);
+    MemoryDeviceState *md = MEMORY_DEVICE(vmd);
+    Error *local_err = NULL;
+
+    if (!bus_handler && dev->hotplugged) {
+        /*
+         * Without a bus hotplug handler, we cannot control the plug/unplug
+         * order. We should never reach this point when hotplugging, but
+         * better add a safety net.
+         */
+        error_setg(errp, "hotplug of virtio based memory devices not supported"
+                   " on this bus.");
+        return;
+    }
+
+    /*
+     * First, see if we can plug this memory device at all. If that
+     * succeeds, branch of to the actual hotplug handler.
+     */
+    memory_device_pre_plug(md, ms, &local_err);
+    if (!local_err && bus_handler) {
+        hotplug_handler_pre_plug(bus_handler, dev, &local_err);
+    }
+    error_propagate(errp, local_err);
+}
+
+void virtio_ccw_md_plug(VirtIOMDCcw *vmd, MachineState *ms, Error **errp)
+{
+    DeviceState *dev = DEVICE(vmd);
+    HotplugHandler *bus_handler = qdev_get_bus_hotplug_handler(dev);
+    MemoryDeviceState *md = MEMORY_DEVICE(vmd);
+    Error *local_err = NULL;
+
+    /*
+     * Plug the memory device first and then branch off to the actual
+     * hotplug handler. If that one fails, we can easily undo the memory
+     * device bits.
+     */
+    memory_device_plug(md, ms);
+    if (bus_handler) {
+        hotplug_handler_plug(bus_handler, dev, &local_err);
+        if (local_err) {
+            memory_device_unplug(md, ms);
+        }
+    }
+    error_propagate(errp, local_err);
+}
+
+void virtio_ccw_md_unplug_request(VirtIOMDCcw *vmd, MachineState *ms,
+                                  Error **errp)
+{
+    VirtIOMDCcwClass *vmdc = VIRTIO_MD_CCW_GET_CLASS(vmd);
+    DeviceState *dev = DEVICE(vmd);
+    HotplugHandler *bus_handler = qdev_get_bus_hotplug_handler(dev);
+    HotplugHandlerClass *hdc;
+    Error *local_err = NULL;
+
+    if (!vmdc->unplug_request_check) {
+        error_setg(errp,
+                   "this virtio based memory devices cannot be unplugged");
+        return;
+    }
+
+    if (!bus_handler) {
+        error_setg(errp, "hotunplug of virtio based memory devices not"
+                   "supported on this bus");
+        return;
+    }
+
+    vmdc->unplug_request_check(vmd, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
+    /*
+     * Forward the async request or turn it into a sync request (handling it
+     * like qdev_unplug()).
+     */
+    hdc = HOTPLUG_HANDLER_GET_CLASS(bus_handler);
+    if (hdc->unplug_request) {
+        hotplug_handler_unplug_request(bus_handler, dev, &local_err);
+    } else {
+        virtio_ccw_md_unplug(vmd, ms, &local_err);
+        if (!local_err) {
+            object_unparent(OBJECT(dev));
+        }
+    }
+}
+
+void virtio_ccw_md_unplug(VirtIOMDCcw *vmd, MachineState *ms, Error **errp)
+{
+    DeviceState *dev = DEVICE(vmd);
+    HotplugHandler *bus_handler = qdev_get_bus_hotplug_handler(dev);
+    MemoryDeviceState *md = MEMORY_DEVICE(vmd);
+    Error *local_err = NULL;
+
+    /* Unplug the memory device while it is still realized. */
+    memory_device_unplug(md, ms);
+
+    if (bus_handler) {
+        hotplug_handler_unplug(bus_handler, dev, &local_err);
+        if (local_err) {
+            /* Not expected to fail ... but still try to recover. */
+            memory_device_plug(md, ms);
+            error_propagate(errp, local_err);
+            return;
+        }
+    } else {
+        /* Very unexpected, but let's just try to do the right thing. */
+        warn_report("Unexpected unplug of virtio based memory device");
+        qdev_unrealize(dev);
+    }
+}
+
+static const TypeInfo virtio_ccw_md_info = {
+    .name = TYPE_VIRTIO_MD_CCW,
+    .parent = TYPE_VIRTIO_CCW_DEVICE,
+    .instance_size = sizeof(VirtIOMDCcw),
+    .class_size = sizeof(VirtIOMDCcwClass),
+    .abstract = true,
+    .interfaces = (InterfaceInfo[]) {
+        { TYPE_MEMORY_DEVICE },
+        { }
+    },
+};
+
+static void virtio_ccw_md_register(void)
+{
+    type_register_static(&virtio_ccw_md_info);
+}
+type_init(virtio_ccw_md_register)
diff --git a/hw/s390x/virtio-ccw-md.h b/hw/s390x/virtio-ccw-md.h
new file mode 100644
index 0000000000..39ba864c92
--- /dev/null
+++ b/hw/s390x/virtio-ccw-md.h
@@ -0,0 +1,44 @@
+/*
+ * Virtio CCW support for abstract virtio based memory device
+ *
+ * Copyright (C) 2024 Red Hat, Inc.
+ *
+ * Authors:
+ *  David Hildenbrand <david@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef HW_S390X_VIRTIO_CCW_MD_H
+#define HW_S390X_VIRTIO_CCW_MD_H
+
+#include "virtio-ccw.h"
+#include "qom/object.h"
+
+/*
+ * virtio-md-ccw: This extends VirtioCcwDevice.
+ */
+#define TYPE_VIRTIO_MD_CCW "virtio-md-ccw"
+
+OBJECT_DECLARE_TYPE(VirtIOMDCcw, VirtIOMDCcwClass, VIRTIO_MD_CCW)
+
+struct VirtIOMDCcwClass {
+    /* private */
+    VirtIOCCWDeviceClass parent;
+
+    /* public */
+    void (*unplug_request_check)(VirtIOMDCcw *vmd, Error **errp);
+};
+
+struct VirtIOMDCcw {
+    VirtioCcwDevice parent_obj;
+};
+
+void virtio_ccw_md_pre_plug(VirtIOMDCcw *vmd, MachineState *ms, Error **errp);
+void virtio_ccw_md_plug(VirtIOMDCcw *vmd, MachineState *ms, Error **errp);
+void virtio_ccw_md_unplug_request(VirtIOMDCcw *vmd, MachineState *ms,
+                                  Error **errp);
+void virtio_ccw_md_unplug(VirtIOMDCcw *vmd, MachineState *ms, Error **errp);
+
+#endif /* HW_S390X_VIRTIO_CCW_MD_H */
diff --git a/hw/virtio/Kconfig b/hw/virtio/Kconfig
index 17595ff350..653ddfdfa8 100644
--- a/hw/virtio/Kconfig
+++ b/hw/virtio/Kconfig
@@ -25,6 +25,7 @@ config VIRTIO_MMIO
 config VIRTIO_CCW
     bool
     select VIRTIO
+    select VIRTIO_MD_SUPPORTED
 
 config VIRTIO_BALLOON
     bool
-- 
2.46.1


