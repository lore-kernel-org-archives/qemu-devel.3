Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2043BCAC5B0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 23:45:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4pRg-0005DQ-JX; Fri, 03 Oct 2025 19:44:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1v4pRV-0005C2-K1
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 19:44:05 -0400
Received: from mgamail.intel.com ([198.175.65.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1v4pRO-0001Sg-2J
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 19:44:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1759535038; x=1791071038;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=gzul51cGI+N3oHYT9aFRo2LZYIYxvdReF+axntN4T2U=;
 b=Y0aDowa+nofmNlmkGZ9gPwqcNpxvTuL9cMl9ik9uiWwQg7v1zXm6ah/d
 9gM5BbtiaL6A0v03U0cUyoHE70BLRRf6T1G1C8F4rEP8pr/OHbAjDRPTW
 1ubN79m4zscrlDZ+YbMBBGdCkcuROGv31Cs6UDXJKtiMDyRQQg+Yrd7ji
 vcS42QBgE4je0NRWC9Ojr6ZU2JEmza+NAAP2GZeoVtWr9I1BnDoZSmk0/
 VCZObaAFuHfP/lZmuoysaURWexfLtZHzNkhkYauD50Ozf2lE7hQhCKzEt
 cyFlQLirMLcqIAKAfQWd4vshVv8IYxt0CudeRmmSpa/2JqPJ6clU9eUTp Q==;
X-CSE-ConnectionGUID: u7QJSb3PQR2z2yI/Jv0qxA==
X-CSE-MsgGUID: uL1D3ujSTGSstQy/N5E8Dg==
X-IronPort-AV: E=McAfee;i="6800,10657,11571"; a="61705040"
X-IronPort-AV: E=Sophos;i="6.18,314,1751266800"; d="scan'208";a="61705040"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Oct 2025 16:43:39 -0700
X-CSE-ConnectionGUID: AJMjB2sGTfG8yv0ILvgxzw==
X-CSE-MsgGUID: 6FnRAmDsQbuDqFy5u1WGRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,314,1751266800"; d="scan'208";a="179428152"
Received: from vkasired-desk2.fm.intel.com ([10.105.128.132])
 by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Oct 2025 16:43:38 -0700
From: Vivek Kasireddy <vivek.kasireddy@intel.com>
To: qemu-devel@nongnu.org
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v1 4/7] vfio/region: Add a helper to get region index from
 memory region
Date: Fri,  3 Oct 2025 16:35:57 -0700
Message-ID: <20251003234138.85820-5-vivek.kasireddy@intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251003234138.85820-1-vivek.kasireddy@intel.com>
References: <20251003234138.85820-1-vivek.kasireddy@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.19;
 envelope-from=vivek.kasireddy@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.467,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Having a way to figure out the region index (or bar) associated
with a memory region is helpful in various scenarios. For example,
this capability can be useful in retrieving the region info needed
for mapping a part of a VFIO region or creating a dmabuf.

Cc: Alex Williamson <alex.williamson@redhat.com>
Cc: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
---
 hw/vfio/region.c              | 14 ++++++++++++++
 include/hw/vfio/vfio-device.h |  2 ++
 2 files changed, 16 insertions(+)

diff --git a/hw/vfio/region.c b/hw/vfio/region.c
index b165ab0b93..8837afc97f 100644
--- a/hw/vfio/region.c
+++ b/hw/vfio/region.c
@@ -398,3 +398,17 @@ void vfio_region_mmaps_set_enabled(VFIORegion *region, bool enabled)
     trace_vfio_region_mmaps_set_enabled(memory_region_name(region->mem),
                                         enabled);
 }
+
+int vfio_get_region_index_from_mr(MemoryRegion *mr)
+{
+    VFIORegion *region = mr->opaque;
+
+    if (mr->ops != &vfio_region_ops) {
+        mr = mr->container;
+        if (mr->ops != &vfio_region_ops) {
+            return -1;
+        }
+	region = mr->opaque;
+    }
+    return region->nr;
+}
diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
index 7e9aed6d3c..bdb106c937 100644
--- a/include/hw/vfio/vfio-device.h
+++ b/include/hw/vfio/vfio-device.h
@@ -277,6 +277,8 @@ bool vfio_device_has_region_cap(VFIODevice *vbasedev, int region, uint16_t cap_t
 
 int vfio_device_get_irq_info(VFIODevice *vbasedev, int index,
                                 struct vfio_irq_info *info);
+
+int vfio_get_region_index_from_mr(MemoryRegion *mr);
 #endif
 
 /* Returns 0 on success, or a negative errno. */
-- 
2.50.1


