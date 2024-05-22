Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13983C25B77
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 04:43:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9doT-0001OL-Nu; Wed, 22 May 2024 00:42:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s9doS-0001Nw-40; Wed, 22 May 2024 00:42:52 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s9doQ-0005sV-AE; Wed, 22 May 2024 00:42:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1716352971; x=1747888971;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=JCXGA2f5VRq8cLR58D7Xt/OW8TEieNqwtU9mvtZZxD4=;
 b=VSFGTwDE2TAb28OCFXXYVGesQf89I6/IQ3bocfIdR5DtzsbRa2vF7ovd
 JpiKAr4czolmEOFJZNTV0hxs8iYhnVR//gIYxaRNjnWxJhwZ07gckhFLi
 U6dqVJYKK3wnEWsp0Ih7b6QUUVu1m7HS1qENMCyt4RAtIkh0O2yH52gRW
 CPoQaDyejyqogKhyk5qjjGRpXi3aYaAGPriTUOXCutHqad4sDc9dH/Pb9
 EZQOxQhmRzL5fS9deX5uBdpVtSXlF90DbnLD8oS/0OXf4P7/BMPRB467Z
 cKD6ZBcna8tENrLV2kR8vCp8iVTpneNkFrrS3qFmeFA1TSADCf/HJi0er Q==;
X-CSE-ConnectionGUID: RpJvu+GbR+q0kx6aJam6AQ==
X-CSE-MsgGUID: btlSvdDrT62tEOJsf1nIpg==
X-IronPort-AV: E=McAfee;i="6600,9927,11079"; a="23994135"
X-IronPort-AV: E=Sophos;i="6.08,179,1712646000"; d="scan'208";a="23994135"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2024 21:42:49 -0700
X-CSE-ConnectionGUID: RbCUlBoZQcuF2tGZHj6EQg==
X-CSE-MsgGUID: C57Vs8dkTZ+iGJ51Qofy1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,179,1712646000"; d="scan'208";a="33683683"
Received: from unknown (HELO SPR-S2600BT.bj.intel.com) ([10.240.192.124])
 by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2024 21:42:46 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Thomas Huth <thuth@redhat.com>, Tony Krowiak <akrowiak@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 qemu-s390x@nongnu.org (open list:S390 general arch...)
Subject: [PATCH v2 05/20] vfio/helpers: Make vfio_device_get_name() return bool
Date: Wed, 22 May 2024 12:40:00 +0800
Message-Id: <20240522044015.412951-6-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240522044015.412951-1-zhenzhong.duan@intel.com>
References: <20240522044015.412951-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.10;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

This is to follow the coding standand in qapi/error.h to return bool
for bool-valued functions.

Suggested-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/vfio/vfio-common.h | 2 +-
 hw/vfio/ap.c                  | 2 +-
 hw/vfio/ccw.c                 | 2 +-
 hw/vfio/helpers.c             | 8 ++++----
 hw/vfio/pci.c                 | 2 +-
 hw/vfio/platform.c            | 5 ++---
 6 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index b712799caf..4cb1ab8645 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -279,7 +279,7 @@ int vfio_get_dirty_bitmap(const VFIOContainerBase *bcontainer, uint64_t iova,
                           uint64_t size, ram_addr_t ram_addr, Error **errp);
 
 /* Returns 0 on success, or a negative errno. */
-int vfio_device_get_name(VFIODevice *vbasedev, Error **errp);
+bool vfio_device_get_name(VFIODevice *vbasedev, Error **errp);
 void vfio_device_set_fd(VFIODevice *vbasedev, const char *str, Error **errp);
 void vfio_device_init(VFIODevice *vbasedev, int type, VFIODeviceOps *ops,
                       DeviceState *dev, bool ram_discard);
diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
index d8a9615fee..c12531a788 100644
--- a/hw/vfio/ap.c
+++ b/hw/vfio/ap.c
@@ -158,7 +158,7 @@ static void vfio_ap_realize(DeviceState *dev, Error **errp)
     VFIOAPDevice *vapdev = VFIO_AP_DEVICE(dev);
     VFIODevice *vbasedev = &vapdev->vdev;
 
-    if (vfio_device_get_name(vbasedev, errp) < 0) {
+    if (!vfio_device_get_name(vbasedev, errp)) {
         return;
     }
 
diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
index 1f578a3c75..8850ca17c8 100644
--- a/hw/vfio/ccw.c
+++ b/hw/vfio/ccw.c
@@ -588,7 +588,7 @@ static void vfio_ccw_realize(DeviceState *dev, Error **errp)
         }
     }
 
-    if (vfio_device_get_name(vbasedev, errp) < 0) {
+    if (!vfio_device_get_name(vbasedev, errp)) {
         return;
     }
 
diff --git a/hw/vfio/helpers.c b/hw/vfio/helpers.c
index 9edbc96688..4b079dc383 100644
--- a/hw/vfio/helpers.c
+++ b/hw/vfio/helpers.c
@@ -607,7 +607,7 @@ bool vfio_has_region_cap(VFIODevice *vbasedev, int region, uint16_t cap_type)
     return ret;
 }
 
-int vfio_device_get_name(VFIODevice *vbasedev, Error **errp)
+bool vfio_device_get_name(VFIODevice *vbasedev, Error **errp)
 {
     ERRP_GUARD();
     struct stat st;
@@ -616,7 +616,7 @@ int vfio_device_get_name(VFIODevice *vbasedev, Error **errp)
         if (stat(vbasedev->sysfsdev, &st) < 0) {
             error_setg_errno(errp, errno, "no such host device");
             error_prepend(errp, VFIO_MSG_PREFIX, vbasedev->sysfsdev);
-            return -errno;
+            return false;
         }
         /* User may specify a name, e.g: VFIO platform device */
         if (!vbasedev->name) {
@@ -625,7 +625,7 @@ int vfio_device_get_name(VFIODevice *vbasedev, Error **errp)
     } else {
         if (!vbasedev->iommufd) {
             error_setg(errp, "Use FD passing only with iommufd backend");
-            return -EINVAL;
+            return false;
         }
         /*
          * Give a name with fd so any function printing out vbasedev->name
@@ -636,7 +636,7 @@ int vfio_device_get_name(VFIODevice *vbasedev, Error **errp)
         }
     }
 
-    return 0;
+    return true;
 }
 
 void vfio_device_set_fd(VFIODevice *vbasedev, const char *str, Error **errp)
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 358da4497b..aad012c348 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -2999,7 +2999,7 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
                             vdev->host.slot, vdev->host.function);
     }
 
-    if (vfio_device_get_name(vbasedev, errp) < 0) {
+    if (!vfio_device_get_name(vbasedev, errp)) {
         return;
     }
 
diff --git a/hw/vfio/platform.c b/hw/vfio/platform.c
index 3233ca8691..e1a32863d9 100644
--- a/hw/vfio/platform.c
+++ b/hw/vfio/platform.c
@@ -545,9 +545,8 @@ static int vfio_base_device_init(VFIODevice *vbasedev, Error **errp)
                                              vbasedev->name);
     }
 
-    ret = vfio_device_get_name(vbasedev, errp);
-    if (ret) {
-        return ret;
+    if (!vfio_device_get_name(vbasedev, errp)) {
+        return -EINVAL;
     }
 
     if (!vfio_attach_device(vbasedev->name, vbasedev,
-- 
2.34.1


