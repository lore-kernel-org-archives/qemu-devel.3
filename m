Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02793FC9ECB
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2026 03:12:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyi4W-0004ni-3z; Fri, 06 Mar 2026 22:11:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1vyi4T-0004mD-BV
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 22:11:18 -0500
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1vyi4R-0000oK-Cs
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 22:11:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772853075; x=1804389075;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Hhz5My/Nci4MkLLcv1gOxQ5MgaITXA44LkA+ZiKWCXU=;
 b=Fo+JwFxi/52HJx57F1SeAJ5dmlYrMjZ/ohY5L+d6UXMTVGvXVDx9DefC
 iBxsR80Z/dWGa+tCrA6bZJMw6GaiemLCDpR4zy8Ih7vfMgcN9KCjgoZkx
 uRjSAA7piRHVrIc5OXh0IVnXO4rnAzIBVuJAuAJU7G7Z7WojFo/3SWc18
 4C0hYEhJ6WFg3Rj9aH+QNAOxvWsu8AkLDBknTF+u9R1x+Qb299oZcavu1
 e1yrOvbryn3okGSJUw7IlgrrRZmA4+dpFfXVS/q2OpI+iuLEb/TkPd/W/
 WkfpSdOhKKGqL2pvZnPfAs5KW/8Vw76L8InDURwzNmNtVucfjXQAFyRCa g==;
X-CSE-ConnectionGUID: B+ec/WoqQuGXiaO0Nrw28w==
X-CSE-MsgGUID: UMi8XxiLT+mb/Oi2i0FRNA==
X-IronPort-AV: E=McAfee;i="6800,10657,11721"; a="99434040"
X-IronPort-AV: E=Sophos;i="6.23,106,1770624000"; d="scan'208";a="99434040"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Mar 2026 19:11:01 -0800
X-CSE-ConnectionGUID: q9DVSK8HTMSy63lX1FYqsA==
X-CSE-MsgGUID: xJUNaIDtR4ObOPmwmjHykA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,106,1770624000"; d="scan'208";a="215813780"
Received: from vkasired-desk2.fm.intel.com ([10.105.128.132])
 by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Mar 2026 19:11:01 -0800
From: Vivek Kasireddy <vivek.kasireddy@intel.com>
To: qemu-devel@nongnu.org
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>,
 Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v10 08/10] vfio/device: Add a helper to mmap a dmabuf
Date: Fri,  6 Mar 2026 19:05:57 -0800
Message-ID: <20260307030812.1224392-9-vivek.kasireddy@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260307030812.1224392-1-vivek.kasireddy@intel.com>
References: <20260307030812.1224392-1-vivek.kasireddy@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.7;
 envelope-from=vivek.kasireddy@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.411,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.679, SPF_HELO_NONE=0.001,
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

In order to mmap a dmabuf, we first need to create a placeholder
mapping that would fit the entire size of the dmabuf. This mapping
would then be replaced with smaller mappings of individual dmabuf
segments.

Cc: Alex Williamson <alex@shazbot.org>
Cc: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
---
 hw/vfio/device.c              | 65 +++++++++++++++++++++++++++++++++++
 hw/vfio/dmabuf-stubs.c        |  7 ++++
 include/hw/vfio/vfio-device.h | 17 +++++++++
 3 files changed, 89 insertions(+)

diff --git a/hw/vfio/device.c b/hw/vfio/device.c
index 2d01059be0..592d901c77 100644
--- a/hw/vfio/device.c
+++ b/hw/vfio/device.c
@@ -725,3 +725,68 @@ int vfio_device_create_dmabuf_fd(struct iovec *iov, unsigned int iov_cnt,
     }
     return ret;
 }
+
+bool vfio_device_mmap_dmabuf(struct iovec *iov, unsigned int iov_cnt,
+                             void **addr, size_t total_size, Error **errp)
+{
+    struct vfio_region_info *info = NULL;
+    VFIODevice *vbasedev = NULL;
+    ram_addr_t offset, len = 0;
+    RAMBlock *first_rb, *rb;
+    void *map, *submap;
+    int i, index;
+
+    if (!vfio_device_lookup(iov, &vbasedev, errp)) {
+        return false;
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
+        return false;
+    }
+
+    for (i = 0; i < iov_cnt; i++) {
+        rb = qemu_ram_block_from_host(iov[i].iov_base, false, &offset);
+        if (i == 0) {
+            first_rb = rb;
+        }
+        if (!rb || rb != first_rb) {
+            error_setg(errp, "Cannot mmap dmabuf with different regions\n");
+            goto err;
+        }
+
+        index = vfio_get_region_index_from_mr(rb->mr);
+        if (index < 0) {
+            error_setg(errp, "Cannot find region index for dmabuf segment\n");
+            goto err;
+        }
+
+        if (vfio_device_get_region_info(vbasedev, index, &info)) {
+            error_setg(errp, "Cannot find region info for dmabuf segment\n");
+            goto err;
+        }
+
+        submap = mmap(map + len, iov[i].iov_len, PROT_READ,
+                      MAP_SHARED | MAP_FIXED, vbasedev->fd,
+                      info->offset + offset);
+        if (submap == MAP_FAILED) {
+            error_setg(errp, "Could not mmap dmabuf segment\n");
+            goto err;
+        }
+
+        len += iov[i].iov_len;
+    }
+    *addr = map;
+    return true;
+err:
+    munmap(map, total_size);
+    error_prepend(errp, "VFIO dmabuf mmap failed: ");
+    return false;
+}
+
diff --git a/hw/vfio/dmabuf-stubs.c b/hw/vfio/dmabuf-stubs.c
index e71e2b68dd..c3aa37233d 100644
--- a/hw/vfio/dmabuf-stubs.c
+++ b/hw/vfio/dmabuf-stubs.c
@@ -15,3 +15,10 @@ int vfio_device_create_dmabuf_fd(struct iovec *iov, unsigned int iov_cnt,
     error_setg(errp, "VFIO dmabuf support is not enabled");
     return VFIO_DMABUF_CREATE_HOST_ERROR;
 }
+
+bool vfio_device_mmap_dmabuf(struct iovec *iov, unsigned int iov_cnt,
+                             void **addr, size_t total_size, Error **errp)
+{
+    error_setg(errp, "VFIO mmap dmabuf support is not enabled");
+    return false;
+}
diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
index 566e5d8bc0..2de21a3047 100644
--- a/include/hw/vfio/vfio-device.h
+++ b/include/hw/vfio/vfio-device.h
@@ -340,6 +340,23 @@ int vfio_get_region_index_from_mr(MemoryRegion *mr);
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
+ * @addr: pointer to store the resulting mmap address
+ * @total_size: total size of the dmabuf
+ * @errp: pointer to Error*, to store an error if it happens.
+ *
+ * Returns true on success and false in case of an error.
+ */
+bool vfio_device_mmap_dmabuf(struct iovec *iov, unsigned int iov_cnt,
+                             void **addr, size_t total_size, Error **errp);
 #endif
 
 /* Returns 0 on success, or a negative errno. */
-- 
2.53.0


