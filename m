Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56ABAD6CFDC
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 06:23:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjAYl-0003Ab-2a; Fri, 23 Jan 2026 01:22:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1vjAYj-00039O-JM
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 01:22:17 -0500
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1vjAYh-0000sW-QD
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 01:22:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1769149336; x=1800685336;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=3nm9C0FRlKNZfgdC1Q1cu9wRjqB68evlSDNuAHUY+D8=;
 b=irqHz6iggB8n8dsx3ZyLkk3R1lCMehx23Dbi3/FRiExe+dRWd1+4wRJA
 25ho+0VBAk5A9j7pwlMWi2yxsllkD+aWoBF6n8SNRIKUmdLc458z+Moxx
 Nr1oTnqb1cOw0JOBdOBt8waT7QMavpQxO/IewiNl9SHpZkB70ckWnr/Cl
 ycBVBrHwM0LSQFhPV1ebVeRjaJCVg79OzM6MyT4e1J+4fbbwyyTw60OCR
 iQ1+pJxcNtEfZX51BbCDbR+uy5vh/lSNsgJ9RraDVC/BMA2Lko5zglbWf
 GrlDmIbCXaJNCj10szRIGduEtrs6IjuLshh5kvO3Cj9npHuGttNVVmoAE Q==;
X-CSE-ConnectionGUID: oU9w7rOoRtGDS7/cmxwuMg==
X-CSE-MsgGUID: bUfqidd/TVa0o4CdpJroqg==
X-IronPort-AV: E=McAfee;i="6800,10657,11679"; a="74254198"
X-IronPort-AV: E=Sophos;i="6.21,247,1763452800"; d="scan'208";a="74254198"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jan 2026 22:22:06 -0800
X-CSE-ConnectionGUID: 3UHgZYxVTdCeZUvTB8GK2w==
X-CSE-MsgGUID: jDxXwqEaSOWnAOPyIuMeOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,247,1763452800"; d="scan'208";a="207287408"
Received: from unknown (HELO vkasired-desk2.fm.intel.com) ([10.105.128.132])
 by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jan 2026 22:22:04 -0800
From: Vivek Kasireddy <vivek.kasireddy@intel.com>
To: qemu-devel@nongnu.org
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>,
 Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v4 4/8] vfio/region: Add a helper to get region index from
 memory region
Date: Thu, 22 Jan 2026 22:17:43 -0800
Message-ID: <20260123062042.568703-5-vivek.kasireddy@intel.com>
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

Having a way to figure out the region index (or bar) associated
with a memory region is helpful in various scenarios. For example,
this capability can be useful in retrieving the region info needed
for mapping a part of a VFIO region or creating a dmabuf.

Cc: Alex Williamson <alex@shazbot.org>
Cc: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
---
 hw/vfio/region.c              | 14 ++++++++++++++
 include/hw/vfio/vfio-device.h | 10 ++++++++++
 2 files changed, 24 insertions(+)

diff --git a/hw/vfio/region.c b/hw/vfio/region.c
index ab39d77574..8943128dd2 100644
--- a/hw/vfio/region.c
+++ b/hw/vfio/region.c
@@ -461,3 +461,17 @@ void vfio_region_mmaps_set_enabled(VFIORegion *region, bool enabled)
     trace_vfio_region_mmaps_set_enabled(memory_region_name(region->mem),
                                         enabled);
 }
+
+int vfio_get_region_index_from_mr(MemoryRegion *mr)
+{
+    VFIORegion *region;
+
+    while (mr->container) {
+        if (mr->ops == &vfio_region_ops) {
+            region = mr->opaque;
+	    return region->nr;
+        }
+        mr = mr->container;
+    }
+    return -1;
+}
diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
index 828a31c006..596c7f5a10 100644
--- a/include/hw/vfio/vfio-device.h
+++ b/include/hw/vfio/vfio-device.h
@@ -308,6 +308,16 @@ bool vfio_device_has_region_cap(VFIODevice *vbasedev, int region, uint16_t cap_t
 
 int vfio_device_get_irq_info(VFIODevice *vbasedev, int index,
                                 struct vfio_irq_info *info);
+
+/**
+ * Return the region index associated with a given MemoryRegion. The index
+ * can be useful in retrieving region info.
+ *
+ * @mr: MemoryRegion to use
+ *
+ * Returns the region index or -1 on error.
+ */
+int vfio_get_region_index_from_mr(MemoryRegion *mr);
 #endif
 
 /* Returns 0 on success, or a negative errno. */
-- 
2.50.1


