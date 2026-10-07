Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 876B0CA6002
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 20:15:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEY1n-0004cK-FG; Wed, 07 Oct 2026 16:14:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1xEY1a-0004Zt-NC
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 16:14:02 -0400
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1xEY1Y-0002BI-Pi
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 16:14:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791404041; x=1822940041;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=eewvSv5A7/D5spMXJzGxhfFCFSwhWuB7A5JmKaq8VG4=;
 b=MEexrU7lydf6LCUKb82ekuQ0hsP1RIbtdmKusQwcGRDlGj39Y23kaRFo
 EolT6HGT1K6UWhz3ick/T7MDFNydHppymztvodLO56iJKLuGVRTVL4VFw
 Cy/4NDu1db22nY0heAYTfGYAHpVFJUWNGnS4ZgqaS6mLCxoGtoI6r2LOb
 8kReitefTHMNoZK+X7CZlyjnIFrefok6U4T0zpDpjXsbXHuB/kLnRNL0T
 l64qumxgoSEaL3eoB0Vt/ikJVIilZvkQiRSHthbHJqfNZWNN6IV0U4FFc
 1Dw9OcpDwBLu8gnrUhVoOVDYAM0JkLdJqpubAJ7bzvxFvRqDuBPPsHjjx g==;
X-CSE-ConnectionGUID: rRc7hSIWSD2r9JJvrpAXDg==
X-CSE-MsgGUID: MeoxBeV+SYuBIC2BE2F+rw==
X-IronPort-AV: E=McAfee;i="6800,10657,11928"; a="178486"
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; 
   d="scan'208";a="178486"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Oct 2026 13:13:49 -0700
X-CSE-ConnectionGUID: i3tHxe2jSr2sy4nLIC9/XA==
X-CSE-MsgGUID: PRWoqnA5Txe1IemkAeqapQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; 
   d="scan'208";a="1564970"
Received: from vkasired-desk1.fm.intel.com ([10.121.64.242])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Oct 2026 13:13:47 -0700
From: Vivek Kasireddy <vivek.kasireddy@intel.com>
To: qemu-devel@nongnu.org
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>,
 Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v13 7/9] vfio/device: Add a helper to mmap a dmabuf
Date: Wed,  7 Oct 2026 13:09:26 -0700
Message-ID: <20261007201222.648687-8-vivek.kasireddy@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261007201222.648687-1-vivek.kasireddy@intel.com>
References: <20261007201222.648687-1-vivek.kasireddy@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.18;
 envelope-from=vivek.kasireddy@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

In order to mmap a dmabuf, we first need to create a placeholder
mapping that would fit the entire size of the dmabuf. This mapping
would then be replaced with smaller mappings of individual dmabuf
segments.

Cc: Alex Williamson <alex@shazbot.org>
Cc: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
---
 include/hw/vfio/vfio-device.h | 15 ++++++++++
 hw/vfio/device.c              | 55 +++++++++++++++++++++++++++++++++++
 hw/vfio/dmabuf-stubs.c        |  7 +++++
 3 files changed, 77 insertions(+)

diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
index c05430be8a..4b8fb62056 100644
--- a/include/hw/vfio/vfio-device.h
+++ b/include/hw/vfio/vfio-device.h
@@ -345,6 +345,21 @@ int vfio_device_get_irq_info(VFIODevice *vbasedev, int index,
  */
 int vfio_device_create_dmabuf_fd(struct iovec *iov, unsigned int iov_cnt,
                                  Error **errp);
+
+/**
+ * Mmap a dmabuf by first translating the addresses in the iovec
+ * array into VFIO region offsets and then creating a placeholder
+ * mapping that would be replaced later with mappings that
+ * correspond to the dmabuf segments.
+ *
+ * @iov: array of iovec entries associated with the dmabuf
+ * @iov_cnt: number of entries in the iovec array
+ * @errp: pointer to Error*, to store an error if it happens.
+ *
+ * Returns the mapped pointer on success and NULL on error.
+ */
+void *vfio_device_mmap_dmabuf(struct iovec *iov, unsigned int iov_cnt,
+                              Error **errp);
 #endif
 
 /* Returns 0 on success, or a negative errno. */
diff --git a/hw/vfio/device.c b/hw/vfio/device.c
index d95503a5f1..5bc0443764 100644
--- a/hw/vfio/device.c
+++ b/hw/vfio/device.c
@@ -776,3 +776,58 @@ int vfio_device_create_dmabuf_fd(struct iovec *iov, unsigned int iov_cnt,
     }
     return ret;
 }
+
+void *vfio_device_mmap_dmabuf(struct iovec *iov, unsigned int iov_cnt,
+                              Error **errp)
+{
+    size_t total_size = iov_size(iov, iov_cnt);
+    struct vfio_region_info *info = NULL;
+    ram_addr_t offset, len = 0;
+    VFIODevice *vbasedev;
+    VFIORegion *region;
+    RAMBlock *first_rb;
+    void *map, *submap;
+    int i;
+
+    if (!vfio_device_lookup(iov, &vbasedev, &first_rb, errp)) {
+        return NULL;
+    }
+
+    /*
+     * We first reserve a contiguous chunk of address space for the entire
+     * dmabuf, then replace it with smaller mappings that correspond to the
+     * individual segments of the dmabuf.
+     */
+    map = mmap(NULL, total_size, PROT_NONE, MAP_SHARED | MAP_ANONYMOUS, -1, 0);
+    if (map == MAP_FAILED) {
+        error_setg_errno(errp, errno, "Could not reserve placeholder mapping");
+        return NULL;
+    }
+
+    for (i = 0; i < iov_cnt; i++) {
+        if (!vfio_region_lookup(iov[i].iov_base, &region,
+                                first_rb, &offset, errp)) {
+            goto err;
+        }
+
+        if (vfio_device_get_region_info(vbasedev, region->nr, &info)) {
+            error_setg(errp, "Cannot find region info for dmabuf segment\n");
+            goto err;
+        }
+
+        submap = mmap(map + len, iov[i].iov_len, PROT_READ,
+                      MAP_SHARED | MAP_FIXED, vbasedev->fd,
+                      info->offset + offset);
+        if (submap == MAP_FAILED) {
+            error_setg_errno(errp, errno, "Could not mmap dmabuf segment\n");
+            goto err;
+        }
+        len += iov[i].iov_len;
+    }
+    return map;
+err:
+    munmap(map, total_size);
+    error_prepend(errp, "VFIO dmabuf mmap failed: ");
+    return NULL;
+}
+
diff --git a/hw/vfio/dmabuf-stubs.c b/hw/vfio/dmabuf-stubs.c
index fb5318e929..b9e03a162a 100644
--- a/hw/vfio/dmabuf-stubs.c
+++ b/hw/vfio/dmabuf-stubs.c
@@ -15,3 +15,10 @@ int vfio_device_create_dmabuf_fd(struct iovec *iov, unsigned int iov_cnt,
     error_setg(errp, "VFIO dmabuf support is not enabled");
     return VFIO_DMABUF_CREATE_ERR_UNSPEC;
 }
+
+void *vfio_device_mmap_dmabuf(struct iovec *iov, unsigned int iov_cnt,
+                              Error **errp)
+{
+    error_setg(errp, "VFIO mmap dmabuf support is not enabled");
+    return NULL;
+}
-- 
2.53.0


