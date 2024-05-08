Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E84CC25B7A
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 09:08:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4dGZ-0008Ug-De; Wed, 08 May 2024 05:07:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s4dGW-0008UI-IS
 for qemu-devel@nongnu.org; Wed, 08 May 2024 05:07:08 -0400
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s4dGS-0005QH-TF
 for qemu-devel@nongnu.org; Wed, 08 May 2024 05:07:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1715159225; x=1746695225;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Jn1r/x0KrmfDsO1CfAxa4HhCkuJ3CaPD/BeliOP8JC0=;
 b=RMeel0Cjk9JzdrPqxjAfwYulHsd4CH3M+Q3CvpkyO68UPerI2x6RaXmG
 GGeQIlYzxSNGse8k+Thw61P3cO2gKPcfkgtnJVJvO/E8Ku87hOcfB4Bp6
 UD9nnb5p0BeToSD6rIbLtRFakvzPRKzA+T+a7TXdKIa57GEsbIIs1626U
 gzTcG1efDuXirLLjbtmQHONLhlaI0NkLpmJYc3DoB3yZpmfRKpXyWGeuH
 bMrI/oHkPq2M8GAUqzN3cs50m+CWebvyil1uf6MAqrKnZlG12BSJfBg+9
 0fUdcDWoIq/htSiBnKzBwZZ8d9c6qL8AiDR9C6VIWt20tpZhkwo1aqlmK w==;
X-CSE-ConnectionGUID: 4AprWPKvTMW0dv7KMTT85g==
X-CSE-MsgGUID: TGNElTWMQdibedLVlV41Vg==
X-IronPort-AV: E=McAfee;i="6600,9927,11066"; a="11160863"
X-IronPort-AV: E=Sophos;i="6.08,144,1712646000"; d="scan'208";a="11160863"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2024 02:07:04 -0700
X-CSE-ConnectionGUID: c1Gu0JvcT7u58z7ICP28iA==
X-CSE-MsgGUID: NyPxPZkHQ2ml94ohQQ+7ug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,144,1712646000"; d="scan'208";a="29226451"
Received: from unknown (HELO SPR-S2600BT.bj.intel.com) ([10.240.192.124])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2024 02:06:59 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, peterx@redhat.com, jasowang@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v5 01/19] backends: Introduce HostIOMMUDevice abstract
Date: Wed,  8 May 2024 17:03:36 +0800
Message-Id: <20240508090354.1815561-2-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240508090354.1815561-1-zhenzhong.duan@intel.com>
References: <20240508090354.1815561-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.18;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Introduce HostIOMMUDevice as an abstraction of host IOMMU device.

Introduce .realize() to initialize HostIOMMUDevice further after
instance init.

Introduce a macro CONFIG_HOST_IOMMU_DEVICE to define the usage
for VFIO, and VDPA in the future.

Suggested-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 MAINTAINERS                        |  2 ++
 include/sysemu/host_iommu_device.h | 51 ++++++++++++++++++++++++++++++
 backends/host_iommu_device.c       | 30 ++++++++++++++++++
 backends/Kconfig                   |  5 +++
 backends/meson.build               |  1 +
 5 files changed, 89 insertions(+)
 create mode 100644 include/sysemu/host_iommu_device.h
 create mode 100644 backends/host_iommu_device.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 84391777db..5dab60bd04 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2191,6 +2191,8 @@ M: Zhenzhong Duan <zhenzhong.duan@intel.com>
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
index 0000000000..2b58a94d62
--- /dev/null
+++ b/include/sysemu/host_iommu_device.h
@@ -0,0 +1,51 @@
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
+};
+
+/**
+ * struct HostIOMMUDeviceClass - The base class for all host IOMMU devices.
+ *
+ * Different type of host devices (e.g., VFIO or VDPA device) or devices
+ * with different backend (e.g., VFIO legacy container or IOMMUFD backend)
+ * can have different sub-classes.
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
+     *          i.e., for VFIO, pointer to VFIODevice
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
index 0000000000..41f2fdce20
--- /dev/null
+++ b/backends/host_iommu_device.c
@@ -0,0 +1,30 @@
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
+}
diff --git a/backends/Kconfig b/backends/Kconfig
index 2cb23f62fa..34ab29e994 100644
--- a/backends/Kconfig
+++ b/backends/Kconfig
@@ -3,3 +3,8 @@ source tpm/Kconfig
 config IOMMUFD
     bool
     depends on VFIO
+
+config HOST_IOMMU_DEVICE
+    bool
+    default y
+    depends on VFIO
diff --git a/backends/meson.build b/backends/meson.build
index 8b2b111497..2e975d641e 100644
--- a/backends/meson.build
+++ b/backends/meson.build
@@ -25,6 +25,7 @@ if have_vhost_user
 endif
 system_ss.add(when: 'CONFIG_VIRTIO_CRYPTO', if_true: files('cryptodev-vhost.c'))
 system_ss.add(when: 'CONFIG_IOMMUFD', if_true: files('iommufd.c'))
+system_ss.add(when: 'CONFIG_HOST_IOMMU_DEVICE', if_true: files('host_iommu_device.c'))
 if have_vhost_user_crypto
   system_ss.add(when: 'CONFIG_VIRTIO_CRYPTO', if_true: files('cryptodev-vhost-user.c'))
 endif
-- 
2.34.1


