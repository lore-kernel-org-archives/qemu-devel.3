Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A34DC30653
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 21:29:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLrBa-0002hB-64; Mon, 24 Jun 2024 17:25:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sLrBY-0002f9-C2
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 17:25:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sLrBW-0006Vg-HU
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 17:25:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719264309;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IaNnVR99BQzWWbJnN4JIPoW2wYW+07pQUUxKvDwUtfU=;
 b=ImFi5oAnMeUgY+GzFEQ5aYcPUw8AP2vUhX1E2kotg1B1fUCznziXZYLsAeH9rVIkCUufyT
 0sCM3AsvOoyRJsaPAd+Uf+PDK+25fWZnmfgZUpBCSJFBBTB5Qyl9tfjDt5JExNrKaQsSY+
 9jANOVrfZvA+2PFEDGDqYsQ5c+Pak+U=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-335-T3Uhwin3NB2pk3dPdtOufw-1; Mon,
 24 Jun 2024 17:25:05 -0400
X-MC-Unique: T3Uhwin3NB2pk3dPdtOufw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9E17C195608C; Mon, 24 Jun 2024 21:25:04 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.49])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 561B21956057; Mon, 24 Jun 2024 21:25:01 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Eric Auger <eric.auger@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>
Subject: [PULL 01/42] backends: Introduce HostIOMMUDevice abstract
Date: Mon, 24 Jun 2024 23:24:15 +0200
Message-ID: <20240624212456.350919-2-clg@redhat.com>
In-Reply-To: <20240624212456.350919-1-clg@redhat.com>
References: <20240624212456.350919-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.207,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Zhenzhong Duan <zhenzhong.duan@intel.com>

A HostIOMMUDevice is an abstraction for an assigned device that is protected
by a physical IOMMU (aka host IOMMU). The userspace interaction with this
physical IOMMU can be done either through the VFIO IOMMU type 1 legacy
backend or the new iommufd backend. The assigned device can be a VFIO device
or a VDPA device. The HostIOMMUDevice is needed to interact with the host
IOMMU that protects the assigned device. It is especially useful when the
device is also protected by a virtual IOMMU as this latter use the translation
services of the physical IOMMU and is constrained by it. In that context the
HostIOMMUDevice can be passed to the virtual IOMMU to collect physical IOMMU
capabilities such as the supported address width. In the future, the virtual
IOMMU will use the HostIOMMUDevice to program the guest page tables in the
first translation stage of the physical IOMMU.

Introduce .realize() to initialize HostIOMMUDevice further after instance init.

Suggested-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
---
 MAINTAINERS                        |  2 ++
 include/sysemu/host_iommu_device.h | 53 ++++++++++++++++++++++++++++++
 backends/host_iommu_device.c       | 33 +++++++++++++++++++
 backends/meson.build               |  1 +
 4 files changed, 89 insertions(+)
 create mode 100644 include/sysemu/host_iommu_device.h
 create mode 100644 backends/host_iommu_device.c

diff --git a/MAINTAINERS b/MAINTAINERS
index f144b5af449e786ce0d132bb4dc509b46da2e82b..19f67dc5d2153bbf994821ad49cc3a4d662192ef 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2198,6 +2198,8 @@ M: Zhenzhong Duan <zhenzhong.duan@intel.com>
 S: Supported
 F: backends/iommufd.c
 F: include/sysemu/iommufd.h
+F: backends/host_iommu_device.c
+F: include/sysemu/host_iommu_device.h
 F: include/qemu/chardev_open.h
 F: util/chardev_open.c
 F: docs/devel/vfio-iommufd.rst
diff --git a/include/sysemu/host_iommu_device.h b/include/sysemu/host_iommu_device.h
new file mode 100644
index 0000000000000000000000000000000000000000..db47a16189a142a25887a835be9f8a8137fe00ee
--- /dev/null
+++ b/include/sysemu/host_iommu_device.h
@@ -0,0 +1,53 @@
+/*
+ * Host IOMMU device abstract declaration
+ *
+ * Copyright (C) 2024 Intel Corporation.
+ *
+ * Authors: Zhenzhong Duan <zhenzhong.duan@intel.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.  See
+ * the COPYING file in the top-level directory.
+ */
+
+#ifndef HOST_IOMMU_DEVICE_H
+#define HOST_IOMMU_DEVICE_H
+
+#include "qom/object.h"
+#include "qapi/error.h"
+
+#define TYPE_HOST_IOMMU_DEVICE "host-iommu-device"
+OBJECT_DECLARE_TYPE(HostIOMMUDevice, HostIOMMUDeviceClass, HOST_IOMMU_DEVICE)
+
+struct HostIOMMUDevice {
+    Object parent_obj;
+
+    char *name;
+};
+
+/**
+ * struct HostIOMMUDeviceClass - The base class for all host IOMMU devices.
+ *
+ * Different types of host devices (e.g., VFIO or VDPA device) or devices
+ * with different backend (e.g., VFIO legacy container or IOMMUFD backend)
+ * will have different implementations of the HostIOMMUDeviceClass.
+ */
+struct HostIOMMUDeviceClass {
+    ObjectClass parent_class;
+
+    /**
+     * @realize: initialize host IOMMU device instance further.
+     *
+     * Mandatory callback.
+     *
+     * @hiod: pointer to a host IOMMU device instance.
+     *
+     * @opaque: pointer to agent device of this host IOMMU device,
+     *          e.g., VFIO base device or VDPA device.
+     *
+     * @errp: pass an Error out when realize fails.
+     *
+     * Returns: true on success, false on failure.
+     */
+    bool (*realize)(HostIOMMUDevice *hiod, void *opaque, Error **errp);
+};
+#endif
diff --git a/backends/host_iommu_device.c b/backends/host_iommu_device.c
new file mode 100644
index 0000000000000000000000000000000000000000..8f2dda1beb9bbea27a61c17d439aeb19ec26cc90
--- /dev/null
+++ b/backends/host_iommu_device.c
@@ -0,0 +1,33 @@
+/*
+ * Host IOMMU device abstract
+ *
+ * Copyright (C) 2024 Intel Corporation.
+ *
+ * Authors: Zhenzhong Duan <zhenzhong.duan@intel.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.  See
+ * the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "sysemu/host_iommu_device.h"
+
+OBJECT_DEFINE_ABSTRACT_TYPE(HostIOMMUDevice,
+                            host_iommu_device,
+                            HOST_IOMMU_DEVICE,
+                            OBJECT)
+
+static void host_iommu_device_class_init(ObjectClass *oc, void *data)
+{
+}
+
+static void host_iommu_device_init(Object *obj)
+{
+}
+
+static void host_iommu_device_finalize(Object *obj)
+{
+    HostIOMMUDevice *hiod = HOST_IOMMU_DEVICE(obj);
+
+    g_free(hiod->name);
+}
diff --git a/backends/meson.build b/backends/meson.build
index 8b2b111497f7c6cd5cb6ca50ec6d1474a543fc9f..106312f0c8b6d76f6aa6b9cc046b85e540c10f35 100644
--- a/backends/meson.build
+++ b/backends/meson.build
@@ -16,6 +16,7 @@ if host_os != 'windows'
 endif
 if host_os == 'linux'
   system_ss.add(files('hostmem-memfd.c'))
+  system_ss.add(files('host_iommu_device.c'))
 endif
 if keyutils.found()
     system_ss.add(keyutils, files('cryptodev-lkcf.c'))
-- 
2.45.2


