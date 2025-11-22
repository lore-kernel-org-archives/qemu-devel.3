Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EEE1CFC51E
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Nov 2025 07:48:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMiHu-0007Sy-Ms; Sat, 22 Nov 2025 02:44:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1vMhUI-0000kK-Jp
 for qemu-devel@nongnu.org; Sat, 22 Nov 2025 01:52:51 -0500
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1vMhTw-0000qe-HL
 for qemu-devel@nongnu.org; Sat, 22 Nov 2025 01:52:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763794348; x=1795330348;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=xcklOL67otmqpeg2fnsITiUmdKSHZVSNYVszE/Pxnvc=;
 b=HtlPFKlKV/HTkMsCUDQAfHLalMpzzMNwNp+2YLVBI7cR4oAIdPtlZkOM
 laaM7Bh4y1ijNPmXzd/ppZqqD7rHOEY4PDIY2nObYArTedcc7NGDv7Kds
 e3QNiMslhXtZuo2bnhoLTwDvYTwhS98aptOOO4goMJB8OeUOr5dbyotHS
 qHjwJx7yjzN8Qow5dNJL96NpoVJs+2rTSbjsjEF/ahu3SIRbRr89uA8dZ
 cHMsz/0w9E1T+7hwSOMcx4M/FILQ+cUz5Ha3tQ0W+AFI8kUIPVrLbHwR9
 cyv6501cO0hMxxPC0VLA04xGjqkXSuCSXiZAUY1o/IeWJtMvzEc8HKifM A==;
X-CSE-ConnectionGUID: Ur6U1mCmQXOpL4+Iqyp4mA==
X-CSE-MsgGUID: WAR+DQfdTgqX/HE6U9phxA==
X-IronPort-AV: E=McAfee;i="6800,10657,11620"; a="65924081"
X-IronPort-AV: E=Sophos;i="6.20,217,1758610800"; d="scan'208";a="65924081"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Nov 2025 22:50:22 -0800
X-CSE-ConnectionGUID: XMdUcYobS7yqqBHu5m1Yag==
X-CSE-MsgGUID: T83Tey3ZQlqTwgdTcFVCOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,217,1758610800"; d="scan'208";a="191064615"
Received: from vkasired-desk2.fm.intel.com ([10.105.128.132])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Nov 2025 22:50:22 -0800
From: Vivek Kasireddy <vivek.kasireddy@intel.com>
To: qemu-devel@nongnu.org
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>,
 Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v3 5/9] vfio/device: Add a helper to lookup VFIODevice from
 memory region
Date: Fri, 21 Nov 2025 22:46:26 -0800
Message-ID: <20251122064936.2948632-6-vivek.kasireddy@intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251122064936.2948632-1-vivek.kasireddy@intel.com>
References: <20251122064936.2948632-1-vivek.kasireddy@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.14;
 envelope-from=vivek.kasireddy@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

Cc: Alex Williamson <alex@shazbot.org>
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


