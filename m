Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 957FDEEF310
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 07:01:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vy2gO-0003Sj-IZ; Thu, 05 Mar 2026 01:59:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1vy2gN-0003Rs-Be
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 01:59:39 -0500
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1vy2gL-0007qG-Lm
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 01:59:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772693977; x=1804229977;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=1TEvr2QnTOUFzPzfTMXk5IYYw/2XkOgNrkkXD+yNNs8=;
 b=jM5fP7dyhdmV8Ney7zyDBcWh7yBgDgwnmtUx/7bXSL9gUjhwWrdAC7V5
 AyU00muidV5wOhzw8LOaxFYrQQctz0QKohl9Iz9ASmBTfEWLU+3LwtuGg
 CE9OmDt5tA5G4JgnTIvfhDXw/XDeMj1Dy6rlJ2xY9pA6ClIGooyz4F/ax
 RZN4zmeFXis69IPdt+rdwt0fIcnlzebSibcrZ4UIvBobZqDxaOv8vwWTl
 1hdU7WJJ2yIeLwxiKoee2HZZA0VsazwUl0DC46WtGNdYEvbK8cIMa1TSH
 OU8cfIvcH/yEK0vKO/OgTgFNCXdMYr9ZXOVwI5GzxwG2miUVcjNA0qhPe Q==;
X-CSE-ConnectionGUID: IqooO0CQS5qmAOmiYnR/vQ==
X-CSE-MsgGUID: UBFtRHwlTT6ibj3aEiI2Lw==
X-IronPort-AV: E=McAfee;i="6800,10657,11719"; a="91343514"
X-IronPort-AV: E=Sophos;i="6.21,325,1763452800"; d="scan'208";a="91343514"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Mar 2026 22:59:30 -0800
X-CSE-ConnectionGUID: ouwFp2yRTeaagSB8ZILr7A==
X-CSE-MsgGUID: AHN7/fogSs6mSHnKJUqsBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,325,1763452800"; d="scan'208";a="218725672"
Received: from vkasired-desk2.fm.intel.com ([10.105.128.132])
 by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Mar 2026 22:59:30 -0800
From: Vivek Kasireddy <vivek.kasireddy@intel.com>
To: qemu-devel@nongnu.org
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>,
 Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v9 06/10] vfio/region: Add a helper to get region index from
 memory region
Date: Wed,  4 Mar 2026 22:54:37 -0800
Message-ID: <20260305065700.1155146-7-vivek.kasireddy@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260305065700.1155146-1-vivek.kasireddy@intel.com>
References: <20260305065700.1155146-1-vivek.kasireddy@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.8;
 envelope-from=vivek.kasireddy@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.703,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=1.386, SPF_HELO_NONE=0.001,
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
index 47fdc2df34..4cb92216ef 100644
--- a/hw/vfio/region.c
+++ b/hw/vfio/region.c
@@ -539,3 +539,17 @@ void vfio_region_mmaps_set_enabled(VFIORegion *region, bool enabled)
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
+            return region->nr;
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
2.53.0


