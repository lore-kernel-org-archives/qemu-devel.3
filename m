Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 064DAC27C53
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 08:34:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEm5E-0001DV-Pc; Wed, 05 Jun 2024 04:33:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sEm5C-0001Cb-NU
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 04:33:22 -0400
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sEm59-0005yn-FP
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 04:33:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1717576401; x=1749112401;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=CmeYlZ61sNZ2CHJbaVxqP4OOUTD2lRKC2HheUI1jI48=;
 b=Kj1RUy4ecYBNMCKjYFeHnJF6Ps2clj2jjigQRT2M9m7UthyaovsCRI5Y
 XWCBUYHHFadtktJ5M4P18WKELdrj5lpGKW0yWXuz0KRICo13X9jjlvS2u
 WUCQyPf1amp69OPdgZWnmrPOhF+VKJkTtCFuzzNTyRMNm3Vw74X92jNyL
 mQRgIhSV4yM1oqS9sXy5vxdA98vWYFsoCSDygpk3MsCyO131xpyCLals2
 /lPZlnRi3CHyMCiOidxGOyfKeoXobO3ky7uwyw8lRIkYhpNctHY9ZQwMk
 X5152IPQ7Bjr1Q0fWxRUaIhsX63XMK4p/rYN0r9aMsgMPFd8TskNAnutf A==;
X-CSE-ConnectionGUID: b70bPJ0RTI2z32HyRHB4MQ==
X-CSE-MsgGUID: YP8bPuxlR/Gr8tMxYRIjrg==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="25575291"
X-IronPort-AV: E=Sophos;i="6.08,216,1712646000"; d="scan'208";a="25575291"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jun 2024 01:33:18 -0700
X-CSE-ConnectionGUID: kON+uY/qQCuQfKxeJAS4qg==
X-CSE-MsgGUID: EG/2/ecXSouislCBZtnZQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,216,1712646000"; d="scan'208";a="37954746"
Received: from unknown (HELO SPR-S2600BT.bj.intel.com) ([10.240.192.127])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jun 2024 01:33:14 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, peterx@redhat.com, jasowang@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v7 01/17] backends: Introduce HostIOMMUDevice abstract
Date: Wed,  5 Jun 2024 16:30:27 +0800
Message-Id: <20240605083043.317831-2-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240605083043.317831-1-zhenzhong.duan@intel.com>
References: <20240605083043.317831-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.12;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
---
 MAINTAINERS                        |  2 ++
 include/sysemu/host_iommu_device.h | 53 ++++++++++++++++++++++++++++++
 backends/host_iommu_device.c       | 33 +++++++++++++++++++
 backends/meson.build               |  1 +
 4 files changed, 89 insertions(+)
 create mode 100644 include/sysemu/host_iommu_device.h
 create mode 100644 backends/host_iommu_device.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 448dc951c5..1cf2b25beb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2196,6 +2196,8 @@ M: Zhenzhong Duan <zhenzhong.duan@intel.com>
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
index 0000000000..db47a16189
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
index 0000000000..8f2dda1beb
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
index 8b2b111497..106312f0c8 100644
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
2.34.1


