Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B9E2FD88DF
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 02:57:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w09ke-0000Ty-6v; Tue, 10 Mar 2026 22:56:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1w09kc-0000SW-Kz
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 22:56:46 -0400
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1w09kb-000630-1w
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 22:56:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773197805; x=1804733805;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=1TEvr2QnTOUFzPzfTMXk5IYYw/2XkOgNrkkXD+yNNs8=;
 b=ZYd3uKMfu4fZVQNy/hozXlXMk3CSzGGZhXWEhBFF66sxE5ojmajWdn2U
 JNzD6DUqmIU7hc/aqdXp/kiSmjCfL6CtioV1HNsNrVTXu9g8iLiNE87AH
 VQP+1TcuCP7Htm2bJmEhpYBKU8WF1yaLZEDLF2NfbQu5Yx5epYgliSCRS
 GNvKSSfyWo7doAhSUiVs5HmHtTQ+TDZxodxBlI/3xARyemHVRhnVrwkOz
 iZNpEAx9WS0rUIXk1W5nBHNGiti9ARwl+V095JW6s5WSx3VVN2Ysfs+r+
 jC7KUPiMmBhTCl7BVqIEjzAGsYMuzvoLi1B9AABvFyWW7SGWjD2kUxwOh w==;
X-CSE-ConnectionGUID: IinLgPMZQZqOzrTFSWCEnA==
X-CSE-MsgGUID: jZzuZlbdRCSaHqsfFEpK3Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11725"; a="76867915"
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; d="scan'208";a="76867915"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Mar 2026 19:56:29 -0700
X-CSE-ConnectionGUID: EjmBG8tDRwS5lUZd0TUqCg==
X-CSE-MsgGUID: wo/pc/cHSbaWeaOx3nlgYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; d="scan'208";a="215611447"
Received: from vkasired-desk2.fm.intel.com ([10.105.128.132])
 by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Mar 2026 19:56:29 -0700
From: Vivek Kasireddy <vivek.kasireddy@intel.com>
To: qemu-devel@nongnu.org
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>,
 Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v11 06/10] vfio/region: Add a helper to get region index from
 memory region
Date: Tue, 10 Mar 2026 19:50:48 -0700
Message-ID: <20260311025340.1335673-7-vivek.kasireddy@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260311025340.1335673-1-vivek.kasireddy@intel.com>
References: <20260311025340.1335673-1-vivek.kasireddy@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.13;
 envelope-from=vivek.kasireddy@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
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


