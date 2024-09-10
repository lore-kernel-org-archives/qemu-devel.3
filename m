Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54F6FEDE9AC
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 18:01:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so59M-0001Pn-99; Tue, 10 Sep 2024 13:59:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1so59K-00016t-5J
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 13:59:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1so59H-0006Ue-AJ
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 13:59:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725991170;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u5wUDX+2kP7cRta/0FxqSgypC6a+G2b35c5TzUUtlvc=;
 b=GTfkcyHthNOIDxiI7XWwOe8R3LpceXJqE2DNuOs7/Q90sm3X9F96jq0p4mdYC1NonML2b0
 kCFJecFKv8ikViH5GX0IYbTRNNP5kbsUyqqJFtdWOYV0EU167HIcKXXH7qkQVU/kGJmYRt
 WOJh2OLxqgixmnS2Ob5kQdyVpImdkS0=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-620-7EE3IRy5NR--18eB3nvmHg-1; Tue,
 10 Sep 2024 13:59:28 -0400
X-MC-Unique: 7EE3IRy5NR--18eB3nvmHg-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9101C195394C; Tue, 10 Sep 2024 17:59:26 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.22.32.182])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 47F27195605A; Tue, 10 Sep 2024 17:59:22 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, David Hildenbrand <david@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>
Subject: [PATCH v1 14/14] s390x: virtio-mem support
Date: Tue, 10 Sep 2024 19:58:09 +0200
Message-ID: <20240910175809.2135596-15-david@redhat.com>
In-Reply-To: <20240910175809.2135596-1-david@redhat.com>
References: <20240910175809.2135596-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Let's add our virtio-mem-ccw proxy device and wire it up. We should
be supporting everything (e.g., device unplug, "dynamic-memslots") that
we already support for the virtio-pci variant.

With a Linux guest that supports virtio-mem (and has automatic memory
onlining properly configured, the following example will work:

1. Start a VM with 4G initial memory and a virtio-mem device with a maximum
   capacity of 16GB:

   qemu/build/qemu-system-s390x \
    --enable-kvm \
    -m 4G,maxmem=20G \
    -nographic \
    -smp 8 \
    -hda Fedora-Server-KVM-40-1.14.s390x.qcow2 \
    -chardev socket,id=monitor,path=/var/tmp/monitor,server,nowait \
    -mon chardev=monitor,mode=readline \
    -object memory-backend-ram,id=mem0,size=16G,reserve=off \
    -device virtio-mem-ccw,id=vmem0,memdev=mem0,dynamic-memslots=on

2. Query the current size of virtio-mem device:

    (qemu) info memory-devices
    Memory device [virtio-mem]: "vmem0"
      memaddr: 0x100000000
      node: 0
      requested-size: 0
      size: 0
      max-size: 17179869184
      block-size: 1048576
      memdev: /objects/mem0

3. Request to grow it to 8GB (hotplug 8GB):

    (qemu) qom-set vmem0 requested-size 8G
    (qemu) info memory-devices
    Memory device [virtio-mem]: "vmem0"
      memaddr: 0x100000000
      node: 0
      requested-size: 8589934592
      size: 8589934592
      max-size: 17179869184
      block-size: 1048576
      memdev: /objects/mem0

4. Request to grow to 16GB (hotplug another 8GB):

    (qemu) qom-set vmem0 requested-size 16G
    (qemu) info memory-devices
    Memory device [virtio-mem]: "vmem0"
      memaddr: 0x100000000
      node: 0
      requested-size: 17179869184
      size: 17179869184
      max-size: 17179869184
      block-size: 1048576
      memdev: /objects/mem0

5. Try to hotunplug all memory again, shrinking to 0GB:

    (qemu) qom-set vmem0 requested-size 0G
    (qemu) info memory-devices
    Memory device [virtio-mem]: "vmem0"
      memaddr: 0x100000000
      node: 0
      requested-size: 0
      size: 0
      max-size: 17179869184
      block-size: 1048576
      memdev: /objects/mem0

6. If it worked, unplug the device

    (qemu) device_del vmem0
    (qemu) info memory-devices
    (qemu) object_del mem0

7. Hotplug a new device with a smaller capacity and directly size it to 1GB

    (qemu) object_add memory-backend-ram,id=mem0,size=8G,reserve=off
    (qemu) device_add virtio-mem-ccw,id=vmem0,memdev=mem0,\
                      dynamic-memslots=on,requested-size=1G
    (qemu) info memory-devices
    Memory device [virtio-mem]: "vmem0"
      memaddr: 0x100000000
      node: 0
      requested-size: 1073741824
      size: 1073741824
      max-size: 8589934592
      block-size: 1048576
      memdev: /objects/mem0

Trying to use a virtio-mem device backed by hugetlb into a !hugetlb VM
correctly results in the error:
   ... Memory device uses a bigger page size than initial memory

Note that the virtio-mem driver in Linux will supports 1 MiB (pageblock)
granularity.

Note that we won't wire up virtio-mem-pci (should currently be
impossible due to lack of support for MSI-X), but we'll add a safety net
to reject plugging them.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 MAINTAINERS                |   2 +
 hw/s390x/Kconfig           |   1 +
 hw/s390x/meson.build       |   1 +
 hw/s390x/s390-virtio-ccw.c |  45 +++++++-
 hw/s390x/virtio-ccw-mem.c  | 226 +++++++++++++++++++++++++++++++++++++
 hw/s390x/virtio-ccw-mem.h  |  34 ++++++
 hw/virtio/virtio-mem.c     |   4 +-
 7 files changed, 311 insertions(+), 2 deletions(-)
 create mode 100644 hw/s390x/virtio-ccw-mem.c
 create mode 100644 hw/s390x/virtio-ccw-mem.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 53ed2c5f0f..f8e0b6c8e3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2413,6 +2413,8 @@ W: https://virtio-mem.gitlab.io/
 F: hw/virtio/virtio-mem.c
 F: hw/virtio/virtio-mem-pci.h
 F: hw/virtio/virtio-mem-pci.c
+F: hw/s390x/virtio-ccw-mem.c
+F: hw/s390x/virtio-ccw-mem.h
 F: include/hw/virtio/virtio-mem.h
 
 virtio-snd
diff --git a/hw/s390x/Kconfig b/hw/s390x/Kconfig
index 3bbf4ae56e..5d57daff77 100644
--- a/hw/s390x/Kconfig
+++ b/hw/s390x/Kconfig
@@ -15,3 +15,4 @@ config S390_CCW_VIRTIO
     select SCLPCONSOLE
     select VIRTIO_CCW
     select MSI_NONBROKEN
+    select VIRTIO_MEM_SUPPORTED
diff --git a/hw/s390x/meson.build b/hw/s390x/meson.build
index 4df40da855..a8434e7918 100644
--- a/hw/s390x/meson.build
+++ b/hw/s390x/meson.build
@@ -49,6 +49,7 @@ virtio_ss.add(when: 'CONFIG_VHOST_SCSI', if_true: files('vhost-scsi-ccw.c'))
 virtio_ss.add(when: 'CONFIG_VHOST_VSOCK', if_true: files('vhost-vsock-ccw.c'))
 virtio_ss.add(when: 'CONFIG_VHOST_USER_FS', if_true: files('vhost-user-fs-ccw.c'))
 virtio_ss.add(when: 'CONFIG_VIRTIO_MD', if_true: files('virtio-ccw-md.c'))
+virtio_ss.add(when: 'CONFIG_VIRTIO_MEM', if_true: files('virtio-ccw-mem.c'))
 s390x_ss.add_all(when: 'CONFIG_VIRTIO_CCW', if_true: virtio_ss)
 
 hw_arch += {'s390x': s390x_ss}
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 0a9d25620d..8d4a23db7d 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -45,6 +45,8 @@
 #include "migration/blocker.h"
 #include "qapi/visitor.h"
 #include "hw/s390x/cpu-topology.h"
+#include "hw/virtio/virtio-md-pci.h"
+#include "hw/s390x/virtio-ccw-md.h"
 #include CONFIG_DEVICES
 
 static Error *pv_mig_blocker;
@@ -529,11 +531,37 @@ static void s390_machine_reset(MachineState *machine, ShutdownCause reason)
     s390_ipl_clear_reset_request();
 }
 
+static void s390_machine_device_pre_plug(HotplugHandler *hotplug_dev,
+                                         DeviceState *dev, Error **errp)
+{
+    if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MD_CCW)) {
+        virtio_ccw_md_pre_plug(VIRTIO_MD_CCW(dev), MACHINE(hotplug_dev), errp);
+    } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MD_PCI)) {
+        error_setg(errp,
+                   "PCI-attached virtio based memory device is not supported");
+    }
+}
+
 static void s390_machine_device_plug(HotplugHandler *hotplug_dev,
                                      DeviceState *dev, Error **errp)
 {
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
+        if (qemu_maxrampagesize() != s390_get_max_pagesize()) {
+            error_setg(errp, "Memory device uses a bigger page size than"
+                       " initial memory");
+            return;
+        }
+        virtio_ccw_md_plug(VIRTIO_MD_CCW(dev), MACHINE(hotplug_dev), errp);
     }
 }
 
@@ -543,6 +571,17 @@ static void s390_machine_device_unplug_request(HotplugHandler *hotplug_dev,
     if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
         error_setg(errp, "CPU hot unplug not supported on this machine");
         return;
+    } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MD_CCW)) {
+        virtio_ccw_md_unplug_request(VIRTIO_MD_CCW(dev), MACHINE(hotplug_dev),
+                                     errp);
+    }
+}
+
+static void s390_machine_device_unplug(HotplugHandler *hotplug_dev,
+                                       DeviceState *dev, Error **errp)
+{
+    if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MD_CCW)) {
+        virtio_ccw_md_unplug(VIRTIO_MD_CCW(dev), MACHINE(hotplug_dev), errp);
     }
 }
 
@@ -592,7 +631,9 @@ static const CPUArchIdList *s390_possible_cpu_arch_ids(MachineState *ms)
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
@@ -768,8 +809,10 @@ static void ccw_machine_class_init(ObjectClass *oc, void *data)
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
diff --git a/hw/s390x/virtio-ccw-mem.c b/hw/s390x/virtio-ccw-mem.c
new file mode 100644
index 0000000000..bee0d560cb
--- /dev/null
+++ b/hw/s390x/virtio-ccw-mem.c
@@ -0,0 +1,226 @@
+/*
+ * virtio-mem CCW implementation
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
+#include "hw/qdev-properties.h"
+#include "qapi/error.h"
+#include "qemu/module.h"
+#include "virtio-ccw-mem.h"
+#include "hw/mem/memory-device.h"
+#include "qapi/qapi-events-machine.h"
+#include "qapi/qapi-events-misc.h"
+
+static void virtio_ccw_mem_realize(VirtioCcwDevice *ccw_dev, Error **errp)
+{
+    VirtIOMEMCcw *dev = VIRTIO_MEM_CCW(ccw_dev);
+    DeviceState *vdev = DEVICE(&dev->vdev);
+
+    qdev_realize(vdev, BUS(&ccw_dev->bus), errp);
+}
+
+static void virtio_ccw_mem_set_addr(MemoryDeviceState *md, uint64_t addr,
+                                    Error **errp)
+{
+    object_property_set_uint(OBJECT(md), VIRTIO_MEM_ADDR_PROP, addr, errp);
+}
+
+static uint64_t virtio_ccw_mem_get_addr(const MemoryDeviceState *md)
+{
+    return object_property_get_uint(OBJECT(md), VIRTIO_MEM_ADDR_PROP,
+                                    &error_abort);
+}
+
+static MemoryRegion *virtio_ccw_mem_get_memory_region(MemoryDeviceState *md,
+                                                      Error **errp)
+{
+    VirtIOMEMCcw *dev = VIRTIO_MEM_CCW(md);
+    VirtIOMEM *vmem = &dev->vdev;
+    VirtIOMEMClass *vmc = VIRTIO_MEM_GET_CLASS(vmem);
+
+    return vmc->get_memory_region(vmem, errp);
+}
+
+static void virtio_ccw_mem_decide_memslots(MemoryDeviceState *md,
+                                           unsigned int limit)
+{
+    VirtIOMEMCcw *dev = VIRTIO_MEM_CCW(md);
+    VirtIOMEM *vmem = VIRTIO_MEM(&dev->vdev);
+    VirtIOMEMClass *vmc = VIRTIO_MEM_GET_CLASS(vmem);
+
+    vmc->decide_memslots(vmem, limit);
+}
+
+static unsigned int virtio_ccw_mem_get_memslots(MemoryDeviceState *md)
+{
+    VirtIOMEMCcw *dev = VIRTIO_MEM_CCW(md);
+    VirtIOMEM *vmem = VIRTIO_MEM(&dev->vdev);
+    VirtIOMEMClass *vmc = VIRTIO_MEM_GET_CLASS(vmem);
+
+    return vmc->get_memslots(vmem);
+}
+
+static uint64_t virtio_ccw_mem_get_plugged_size(const MemoryDeviceState *md,
+                                                Error **errp)
+{
+    return object_property_get_uint(OBJECT(md), VIRTIO_MEM_SIZE_PROP,
+                                    errp);
+}
+
+static void virtio_ccw_mem_fill_device_info(const MemoryDeviceState *md,
+                                            MemoryDeviceInfo *info)
+{
+    VirtioMEMDeviceInfo *vi = g_new0(VirtioMEMDeviceInfo, 1);
+    VirtIOMEMCcw *dev = VIRTIO_MEM_CCW(md);
+    VirtIOMEM *vmem = &dev->vdev;
+    VirtIOMEMClass *vpc = VIRTIO_MEM_GET_CLASS(vmem);
+    DeviceState *vdev = DEVICE(md);
+
+    if (vdev->id) {
+        vi->id = g_strdup(vdev->id);
+    }
+
+    /* let the real device handle everything else */
+    vpc->fill_device_info(vmem, vi);
+
+    info->u.virtio_mem.data = vi;
+    info->type = MEMORY_DEVICE_INFO_KIND_VIRTIO_MEM;
+}
+
+static uint64_t virtio_ccw_mem_get_min_alignment(const MemoryDeviceState *md)
+{
+    return object_property_get_uint(OBJECT(md), VIRTIO_MEM_BLOCK_SIZE_PROP,
+                                    &error_abort);
+}
+
+static void virtio_ccw_mem_size_change_notify(Notifier *notifier, void *data)
+{
+    VirtIOMEMCcw *dev = container_of(notifier, VirtIOMEMCcw,
+                                         size_change_notifier);
+    DeviceState *vdev = DEVICE(dev);
+    char *qom_path = object_get_canonical_path(OBJECT(dev));
+    const uint64_t * const size_p = data;
+
+    qapi_event_send_memory_device_size_change(vdev->id, *size_p, qom_path);
+    g_free(qom_path);
+}
+
+static void virtio_ccw_mem_unplug_request_check(VirtIOMDCcw *vmd, Error **errp)
+{
+    VirtIOMEMCcw *dev = VIRTIO_MEM_CCW(vmd);
+    VirtIOMEM *vmem = &dev->vdev;
+    VirtIOMEMClass *vpc = VIRTIO_MEM_GET_CLASS(vmem);
+
+    vpc->unplug_request_check(vmem, errp);
+}
+
+static void virtio_ccw_mem_get_requested_size(Object *obj, Visitor *v,
+                                              const char *name, void *opaque,
+                                              Error **errp)
+{
+    VirtIOMEMCcw *dev = VIRTIO_MEM_CCW(obj);
+
+    object_property_get(OBJECT(&dev->vdev), name, v, errp);
+}
+
+static void virtio_ccw_mem_set_requested_size(Object *obj, Visitor *v,
+                                              const char *name, void *opaque,
+                                              Error **errp)
+{
+    VirtIOMEMCcw *dev = VIRTIO_MEM_CCW(obj);
+    DeviceState *vdev = DEVICE(obj);
+
+    /*
+     * If we passed virtio_ccw_mem_unplug_request_check(), making sure that
+     * the requested size is 0, don't allow modifying the requested size
+     * anymore, otherwise the VM might end up hotplugging memory before
+     * handling the unplug request.
+     */
+    if (vdev->pending_deleted_event) {
+        error_setg(errp, "'%s' cannot be changed if the device is in the"
+                   " process of unplug", name);
+        return;
+    }
+
+    object_property_set(OBJECT(&dev->vdev), name, v, errp);
+}
+
+static Property virtio_ccw_mem_properties[] = {
+    DEFINE_PROP_BIT("ioeventfd", VirtioCcwDevice, flags,
+                    VIRTIO_CCW_FLAG_USE_IOEVENTFD_BIT, true),
+    DEFINE_PROP_UINT32("max_revision", VirtioCcwDevice, max_rev,
+                       VIRTIO_CCW_MAX_REV),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void virtio_ccw_mem_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    VirtIOCCWDeviceClass *k = VIRTIO_CCW_DEVICE_CLASS(klass);
+    MemoryDeviceClass *mdc = MEMORY_DEVICE_CLASS(klass);
+    VirtIOMDCcwClass *vmdc = VIRTIO_MD_CCW_CLASS(klass);
+
+    k->realize = virtio_ccw_mem_realize;
+    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
+    device_class_set_props(dc, virtio_ccw_mem_properties);
+
+    mdc->get_addr = virtio_ccw_mem_get_addr;
+    mdc->set_addr = virtio_ccw_mem_set_addr;
+    mdc->get_plugged_size = virtio_ccw_mem_get_plugged_size;
+    mdc->get_memory_region = virtio_ccw_mem_get_memory_region;
+    mdc->decide_memslots = virtio_ccw_mem_decide_memslots;
+    mdc->get_memslots = virtio_ccw_mem_get_memslots;
+    mdc->fill_device_info = virtio_ccw_mem_fill_device_info;
+    mdc->get_min_alignment = virtio_ccw_mem_get_min_alignment;
+
+    vmdc->unplug_request_check = virtio_ccw_mem_unplug_request_check;
+}
+
+static void virtio_ccw_mem_instance_init(Object *obj)
+{
+    VirtIOMEMCcw *dev = VIRTIO_MEM_CCW(obj);
+    VirtIOMEMClass *vmc;
+    VirtIOMEM *vmem;
+
+    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
+                                TYPE_VIRTIO_MEM);
+
+    dev->size_change_notifier.notify = virtio_ccw_mem_size_change_notify;
+    vmem = &dev->vdev;
+    vmc = VIRTIO_MEM_GET_CLASS(vmem);
+    /*
+     * We never remove the notifier again, as we expect both devices to
+     * disappear at the same time.
+     */
+    vmc->add_size_change_notifier(vmem, &dev->size_change_notifier);
+
+    object_property_add_alias(obj, VIRTIO_MEM_BLOCK_SIZE_PROP,
+                              OBJECT(&dev->vdev), VIRTIO_MEM_BLOCK_SIZE_PROP);
+    object_property_add_alias(obj, VIRTIO_MEM_SIZE_PROP, OBJECT(&dev->vdev),
+                              VIRTIO_MEM_SIZE_PROP);
+    object_property_add(obj, VIRTIO_MEM_REQUESTED_SIZE_PROP, "size",
+                        virtio_ccw_mem_get_requested_size,
+                        virtio_ccw_mem_set_requested_size, NULL, NULL);
+}
+
+static const TypeInfo virtio_ccw_mem = {
+    .name = TYPE_VIRTIO_MEM_CCW,
+    .parent = TYPE_VIRTIO_MD_CCW,
+    .instance_size = sizeof(VirtIOMEMCcw),
+    .instance_init = virtio_ccw_mem_instance_init,
+    .class_init = virtio_ccw_mem_class_init,
+};
+
+static void virtio_ccw_mem_register_types(void)
+{
+    type_register_static(&virtio_ccw_mem);
+}
+type_init(virtio_ccw_mem_register_types)
diff --git a/hw/s390x/virtio-ccw-mem.h b/hw/s390x/virtio-ccw-mem.h
new file mode 100644
index 0000000000..730cd9fcd7
--- /dev/null
+++ b/hw/s390x/virtio-ccw-mem.h
@@ -0,0 +1,34 @@
+/*
+ * Virtio MEM CCW device
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
+#ifndef HW_S390X_VIRTIO_CCW_MEM_H
+#define HW_S390X_VIRTIO_CCW_MEM_H
+
+#include "virtio-ccw-md.h"
+#include "hw/virtio/virtio-mem.h"
+#include "qom/object.h"
+
+typedef struct VirtIOMEMCcw VirtIOMEMCcw;
+
+/*
+ * virtio-mem-ccw: This extends VirtIOMDCcw
+ */
+#define TYPE_VIRTIO_MEM_CCW "virtio-mem-ccw"
+DECLARE_INSTANCE_CHECKER(VirtIOMEMCcw, VIRTIO_MEM_CCW, TYPE_VIRTIO_MEM_CCW)
+
+struct VirtIOMEMCcw {
+    VirtIOMDCcw parent_obj;
+    VirtIOMEM vdev;
+    Notifier size_change_notifier;
+};
+
+#endif /* QEMU_VIRTIO_MEM_PCI_H */
diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
index ef64bf1b4a..988101783f 100644
--- a/hw/virtio/virtio-mem.c
+++ b/hw/virtio/virtio-mem.c
@@ -61,6 +61,8 @@ static uint32_t virtio_mem_default_thp_size(void)
     } else if (qemu_real_host_page_size() == 64 * KiB) {
         default_thp_size = 512 * MiB;
     }
+#elif defined(__s390x__)
+    default_thp_size = 1 * MiB;
 #endif
 
     return default_thp_size;
@@ -161,7 +163,7 @@ static bool virtio_mem_has_shared_zeropage(RAMBlock *rb)
  * necessary (as the section size can change). But it's more likely that the
  * section size will rather get smaller and not bigger over time.
  */
-#if defined(TARGET_X86_64) || defined(TARGET_I386)
+#if defined(TARGET_X86_64) || defined(TARGET_I386) || defined(TARGET_S390X)
 #define VIRTIO_MEM_USABLE_EXTENT (2 * (128 * MiB))
 #elif defined(TARGET_ARM)
 #define VIRTIO_MEM_USABLE_EXTENT (2 * (512 * MiB))
-- 
2.46.0


