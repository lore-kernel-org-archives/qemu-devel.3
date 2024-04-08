Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71D2ACD1292
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 08:16:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtk9q-0002qD-9I; Mon, 08 Apr 2024 04:15:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rtk9o-0002mX-6b
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 04:15:12 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rtk9l-00088l-93
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 04:15:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1712564109; x=1744100109;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=wykm8CTdvs/a63yu30J9vOfyYa6zOvbij1LOSE5uNY0=;
 b=Frg0stdvjDGrSjSlNM/DjUiPTbe0+grjfNEdqUwfHFj+XDxlYWPLRkt9
 UhgWhuJnN4Lo9Ad8d2w0bE8uVg+kWEHx4qswROjG0tqInhRr8KJQz//4R
 BChNXaWEUxQVDwcPHpQp6qp9cgs6q19TRj/xArkzZsqPK5BMxaP+MFrFR
 bMJYUslih+3sldKcBevb2DXYRSV7otBDzRsx7p1q87OdddjewqR3suon/
 oWaF3DlWe+uXq7JrrbgakGFdh46rDs5qi4KBXxuV3u13mjvBbuOtW5LYT
 BBPBhN2h/0+s6tLoD+kIfidM4jno9xsD+MxoL+l0awqT9e3okjzbCu+CI w==;
X-CSE-ConnectionGUID: DEm5sQyBS/27OiXiUhI7Ug==
X-CSE-MsgGUID: wnNE+OFRQVq7Cnl3nXR2Eg==
X-IronPort-AV: E=McAfee;i="6600,9927,11037"; a="19199660"
X-IronPort-AV: E=Sophos;i="6.07,186,1708416000"; d="scan'208";a="19199660"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Apr 2024 01:15:07 -0700
X-CSE-ConnectionGUID: uA+19ALmRUi0BuSiAzEreQ==
X-CSE-MsgGUID: nyHeRnZ9QP+qXdTzXmjSJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,186,1708416000"; d="scan'208";a="19845170"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.124])
 by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Apr 2024 01:15:03 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, mst@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 01/10] backends: Introduce abstract HostIOMMUDevice
Date: Mon,  8 Apr 2024 16:12:21 +0800
Message-Id: <20240408081230.1030078-2-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240408081230.1030078-1-zhenzhong.duan@intel.com>
References: <20240408081230.1030078-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.10;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.355,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

get_host_iommu_info() is used to get host IOMMU info, different
backends can have different implementations and result format.

Introduce a macro CONFIG_HOST_IOMMU_DEVICE to define the usage
for VFIO, and VDPA in the future.

Suggested-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 MAINTAINERS                        |  2 ++
 include/sysemu/host_iommu_device.h | 19 +++++++++++++++++++
 backends/host_iommu_device.c       | 19 +++++++++++++++++++
 backends/Kconfig                   |  5 +++++
 backends/meson.build               |  1 +
 5 files changed, 46 insertions(+)
 create mode 100644 include/sysemu/host_iommu_device.h
 create mode 100644 backends/host_iommu_device.c

diff --git a/MAINTAINERS b/MAINTAINERS
index e71183eef9..22f71cbe02 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2202,6 +2202,8 @@ M: Zhenzhong Duan <zhenzhong.duan@intel.com>
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
index 0000000000..22ccbe3a5d
--- /dev/null
+++ b/include/sysemu/host_iommu_device.h
@@ -0,0 +1,19 @@
+#ifndef HOST_IOMMU_DEVICE_H
+#define HOST_IOMMU_DEVICE_H
+
+#include "qom/object.h"
+
+#define TYPE_HOST_IOMMU_DEVICE "host-iommu-device"
+OBJECT_DECLARE_TYPE(HostIOMMUDevice, HostIOMMUDeviceClass, HOST_IOMMU_DEVICE)
+
+struct HostIOMMUDevice {
+    Object parent;
+};
+
+struct HostIOMMUDeviceClass {
+    ObjectClass parent_class;
+
+    int (*get_host_iommu_info)(HostIOMMUDevice *hiod, void *data, uint32_t len,
+                               Error **errp);
+};
+#endif
diff --git a/backends/host_iommu_device.c b/backends/host_iommu_device.c
new file mode 100644
index 0000000000..6cb6007d8c
--- /dev/null
+++ b/backends/host_iommu_device.c
@@ -0,0 +1,19 @@
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


