Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8028D3EE9A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 06:23:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjAYm-0003Bm-GI; Fri, 23 Jan 2026 01:22:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1vjAYk-0003A5-Dp
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 01:22:18 -0500
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1vjAYi-0000sJ-Ja
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 01:22:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1769149337; x=1800685337;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=yhdsCW0DFMHQGdzuiJxr5bsKYnwCstyI9SKEGqfdAQo=;
 b=RDnj4V86P6wTL6c9byp2xtN+jfP9jgJTcqieRjBMuh4t4uzbIdezHZgy
 bq2eQPQUel+649vUROJs/8Yhn9192VlNr/bxhTec2lcg3KaelR5FIQBi3
 lvDAVItVJ0bJSJUtiX1RZpJLF1zufIq6G1vbAl5GKxFFwF940SsYmLfaz
 uynXaQ73Wk8ALwCMh6PCPVOTyDdHat5JesQpB8zlf1FCHrplU5BwArB0c
 HI+yiYJrcIT1m2RLcE5kjiinGpcDwR7tFsX7NgtQHDwZAmecw+N8cG/mQ
 HNneFYZGkOeiYqmD2AeZ3uYqV4ZIJJ60Lmrfbywbtb74w7maP4+DhWZFv g==;
X-CSE-ConnectionGUID: RnH5IFwXTg+lAh4kyWjvFw==
X-CSE-MsgGUID: eQN8ZLR/Roe1bUIA8EWSjg==
X-IronPort-AV: E=McAfee;i="6800,10657,11679"; a="74254204"
X-IronPort-AV: E=Sophos;i="6.21,247,1763452800"; d="scan'208";a="74254204"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jan 2026 22:22:06 -0800
X-CSE-ConnectionGUID: 43EOBY/fSMqt8SqXZDRQ2w==
X-CSE-MsgGUID: +fE6sewrTKGxmZtjyIMePQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,247,1763452800"; d="scan'208";a="207287411"
Received: from unknown (HELO vkasired-desk2.fm.intel.com) ([10.105.128.132])
 by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jan 2026 22:22:05 -0800
From: Vivek Kasireddy <vivek.kasireddy@intel.com>
To: qemu-devel@nongnu.org
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>,
 Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v4 5/8] vfio/device: Add a helper to lookup VFIODevice from
 memory region
Date: Thu, 22 Jan 2026 22:17:44 -0800
Message-ID: <20260123062042.568703-6-vivek.kasireddy@intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260123062042.568703-1-vivek.kasireddy@intel.com>
References: <20260123062042.568703-1-vivek.kasireddy@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.14;
 envelope-from=vivek.kasireddy@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.07,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
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

Cc: Alex Williamson <alex@shazbot.org>
Cc: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
---
 hw/vfio/device.c              | 12 ++++++++++++
 include/hw/vfio/vfio-device.h |  9 +++++++++
 2 files changed, 21 insertions(+)

diff --git a/hw/vfio/device.c b/hw/vfio/device.c
index 973fc35b59..afeff0f034 100644
--- a/hw/vfio/device.c
+++ b/hw/vfio/device.c
@@ -644,3 +644,15 @@ static VFIODeviceIOOps vfio_device_io_ops_ioctl = {
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
index 596c7f5a10..ccf2fd887c 100644
--- a/include/hw/vfio/vfio-device.h
+++ b/include/hw/vfio/vfio-device.h
@@ -318,6 +318,15 @@ int vfio_device_get_irq_info(VFIODevice *vbasedev, int index,
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


