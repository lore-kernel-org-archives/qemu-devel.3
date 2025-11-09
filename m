Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE223CCFA13
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Nov 2025 05:40:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vHy8p-0005ad-6Q; Sun, 09 Nov 2025 00:39:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1vHy8c-0005XI-Pa
 for qemu-devel@nongnu.org; Sun, 09 Nov 2025 00:38:58 -0500
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1vHy8b-0007aH-7r
 for qemu-devel@nongnu.org; Sun, 09 Nov 2025 00:38:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1762666733; x=1794202733;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=r9X27iFF9jmuT4eMQvcKCO4gQXvlIancgXdQF7u7ogs=;
 b=hdGqxaBHhhKg+eUWRcaHweeJI96SgHGeJ4Rb0NIR+jzzaepuvb4xZfv1
 WTB8FgyzpfNpRMzmJhYU6mIaCgpqbuWY8bgQPfnMVOKS/P3mdwafmGjZE
 pJzbV404IzIKC5RKew6sevPb1LgOhAAEucmqU+MGiB/Jpa3nEASSvttML
 PSmDOqviKaPhzsTfgg0ESgxUj68eMgluGoHTZZ2veVInUorKmN14igg6K
 uV1yWMhTeHHy2tIIvxSVeXr7Qt9UKEc6D6SnuWJdED/w2kVSW5O2SSyuD
 FcP/VUi0Oa5M+LYwRaJo9wlhRifPUEieGoTzakWxWmMUNtpRxpRT4i1cd A==;
X-CSE-ConnectionGUID: 5HGUlT1XREe549G+xEXuVw==
X-CSE-MsgGUID: 5+w/aUSORX2md9689W5B/A==
X-IronPort-AV: E=McAfee;i="6800,10657,11607"; a="63965789"
X-IronPort-AV: E=Sophos;i="6.19,291,1754982000"; d="scan'208";a="63965789"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Nov 2025 21:38:41 -0800
X-CSE-ConnectionGUID: Nfy3obEOS9WGqjFA0jfUlg==
X-CSE-MsgGUID: mEb3d7JRSii1ihhAYJDJcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,291,1754982000"; d="scan'208";a="188129057"
Received: from vkasired-desk2.fm.intel.com ([10.105.128.132])
 by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Nov 2025 21:38:40 -0800
From: Vivek Kasireddy <vivek.kasireddy@intel.com>
To: qemu-devel@nongnu.org
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v2 05/10] vfio/device: Add a helper to lookup VFIODevice from
 memory region
Date: Sat,  8 Nov 2025 21:33:48 -0800
Message-ID: <20251109053801.2267149-6-vivek.kasireddy@intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251109053801.2267149-1-vivek.kasireddy@intel.com>
References: <20251109053801.2267149-1-vivek.kasireddy@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.18;
 envelope-from=vivek.kasireddy@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Instead of iterating over all QOM devices to find the VFIODevice
associated with a memory region, it is faster to just use the
vfio_device_list to lookup the VFIODevice.

Cc: Alex Williamson <alex.williamson@redhat.com>
Cc: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
---
 hw/vfio/device.c              | 12 ++++++++++++
 include/hw/vfio/vfio-device.h |  9 +++++++++
 2 files changed, 21 insertions(+)

diff --git a/hw/vfio/device.c b/hw/vfio/device.c
index 76869828fc..9ff73f9941 100644
--- a/hw/vfio/device.c
+++ b/hw/vfio/device.c
@@ -603,3 +603,15 @@ static VFIODeviceIOOps vfio_device_io_ops_ioctl = {
     .region_read = vfio_device_io_region_read,
     .region_write = vfio_device_io_region_write,
 };
+
+VFIODevice *vfio_device_lookup(MemoryRegion *mr)
+{
+    VFIODevice *vbasedev;
+
+    QLIST_FOREACH(vbasedev, &vfio_device_list, next) {
+        if (vbasedev->dev == mr->dev) {
+            return vbasedev;
+        }
+    }
+    return NULL;
+}
diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
index 44cacd3728..2f8087f133 100644
--- a/include/hw/vfio/vfio-device.h
+++ b/include/hw/vfio/vfio-device.h
@@ -300,6 +300,15 @@ int vfio_device_get_irq_info(VFIODevice *vbasedev, int index,
  * Returns the region index or -1 on error.
  */
 int vfio_get_region_index_from_mr(MemoryRegion *mr);
+
+/**
+ * Return the VFIO device associated with a given MemoryRegion.
+ *
+ * @mr: MemoryRegion to use
+ *
+ * Returns the VFIO device if found or NULL.
+ */
+VFIODevice *vfio_device_lookup(MemoryRegion *mr);
 #endif
 
 /* Returns 0 on success, or a negative errno. */
-- 
2.50.1


