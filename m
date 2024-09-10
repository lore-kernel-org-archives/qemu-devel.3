Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6148EDE9AB
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 18:02:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so59H-0000nQ-G3; Tue, 10 Sep 2024 13:59:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1so59G-0000dY-1S
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 13:59:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1so59D-0006U8-KG
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 13:59:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725991167;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=75nB3XlxHtyFpg5pWr/5/YeyWJyE2v0N5lLtydj1lT8=;
 b=UdMRGcQqoShmU6EhcYZ7KMQAgKTiNFfdhL+aiPY634HGxDUNAotBKFRfRGTaXykGozf7sv
 C4Paa5syt1QG7/D7MMCP5nFIAvq0xsdRhiDoFz4EzoATUOxvzlsHqkZfXJl0/brRoq1n5a
 +YOLyY8SQUfwm2EYq8HmyBm8Lsz9WTk=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-568-dBmsZHunPGScXd29v6yp3g-1; Tue,
 10 Sep 2024 13:59:23 -0400
X-MC-Unique: dBmsZHunPGScXd29v6yp3g-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BFFE0195394A; Tue, 10 Sep 2024 17:59:21 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.22.32.182])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 800C019560AD; Tue, 10 Sep 2024 17:59:17 +0000 (UTC)
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
Subject: [PATCH v1 13/14] s390x/virtio-ccw: add support for virtio based
 memory devices
Date: Tue, 10 Sep 2024 19:58:08 +0200
Message-ID: <20240910175809.2135596-14-david@redhat.com>
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
the virtio-pci implementation as an orientation.

As we neither support virtio-mem or virtio-pmem yet, the code is
effectively unused and not wired up. We'll implement support for
virtio-mem based on this next.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 MAINTAINERS              |   2 +
 hw/s390x/meson.build     |   1 +
 hw/s390x/virtio-ccw-md.c | 153 +++++++++++++++++++++++++++++++++++++++
 hw/s390x/virtio-ccw-md.h |  44 +++++++++++
 hw/virtio/Kconfig        |   1 +
 5 files changed, 201 insertions(+)
 create mode 100644 hw/s390x/virtio-ccw-md.c
 create mode 100644 hw/s390x/virtio-ccw-md.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 0c1bc69828..53ed2c5f0f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2400,6 +2400,8 @@ F: include/hw/virtio/virtio-crypto.h
 virtio based memory device
 M: David Hildenbrand <david@redhat.com>
 S: Supported
+F: hw/s390x/virtio-ccw-md.c
+F: hw/s390x/virtio-ccw-md.h
 F: hw/virtio/virtio-md-pci.c
 F: include/hw/virtio/virtio-md-pci.h
 F: stubs/virtio-md-pci.c
diff --git a/hw/s390x/meson.build b/hw/s390x/meson.build
index 71ec747f4c..4df40da855 100644
--- a/hw/s390x/meson.build
+++ b/hw/s390x/meson.build
@@ -48,6 +48,7 @@ endif
 virtio_ss.add(when: 'CONFIG_VHOST_SCSI', if_true: files('vhost-scsi-ccw.c'))
 virtio_ss.add(when: 'CONFIG_VHOST_VSOCK', if_true: files('vhost-vsock-ccw.c'))
 virtio_ss.add(when: 'CONFIG_VHOST_USER_FS', if_true: files('vhost-user-fs-ccw.c'))
+virtio_ss.add(when: 'CONFIG_VIRTIO_MD', if_true: files('virtio-ccw-md.c'))
 s390x_ss.add_all(when: 'CONFIG_VIRTIO_CCW', if_true: virtio_ss)
 
 hw_arch += {'s390x': s390x_ss}
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
index 0000000000..e83d40f6c4
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
+#endif
diff --git a/hw/virtio/Kconfig b/hw/virtio/Kconfig
index 0afec2ae92..f4b14e1a44 100644
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
2.46.0


