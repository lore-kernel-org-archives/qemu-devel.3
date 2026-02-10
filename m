Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85304EA3F0F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 07:03:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vphlf-00057Z-4z; Tue, 10 Feb 2026 02:02:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1vphld-000550-TX
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 02:02:37 -0500
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1vphlc-0004p7-4d
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 02:02:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770706956; x=1802242956;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=HkTr/zWEef0bVYlJ9JiAZY/xqp73/s2wMhr4ci6XAjI=;
 b=Qo0RuurCaM7jv8uaTfci1OUMtkn4cqXXrZ2LmFlDDvIzGnG/uDQsXvwU
 7o0QNmVgh9rlybwc0Wm0XpKX9If6HJvNR1G9YcKpM8M6frqshl6h4O1mI
 I77Ro3dCMMLIRsnFk3mRGmv9NfVIkq5DdcGk2V5A+mhHq4VSUeVCac2Fp
 zO/GDIuJI2nj/M19KyKdzcKanU8r4rkKA8XbuSva8sTHu4GEiMo4aV98M
 WE3LhRiO5EFUpcl4hdiI/T+BYiTf6mNGyWvx1PFMAyxp+6Zxe0mEfDIG5
 6tiFN3SdLNf19PTnARxR2j7h4Avk+gohljILW98MGp6dKaN0B6vK3tzLx w==;
X-CSE-ConnectionGUID: MPqFtYT7SYK4Y8uZTHr2Yw==
X-CSE-MsgGUID: CcuDzGGHQqKqEcrY0FZf5w==
X-IronPort-AV: E=McAfee;i="6800,10657,11696"; a="72012185"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="72012185"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Feb 2026 23:02:15 -0800
X-CSE-ConnectionGUID: 9+7/NpY2TvOLGd4r5vlgyA==
X-CSE-MsgGUID: VcrRWGSGTQi3WjnIBaj6dA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="210920559"
Received: from vkasired-desk2.fm.intel.com ([10.105.128.132])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Feb 2026 23:02:14 -0800
From: Vivek Kasireddy <vivek.kasireddy@intel.com>
To: qemu-devel@nongnu.org
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>,
 Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v6 10/11] vfio/device: Add a helper to mmap a dmabuf
Date: Mon,  9 Feb 2026 22:59:50 -0800
Message-ID: <20260210070155.1176081-11-vivek.kasireddy@intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260210070155.1176081-1-vivek.kasireddy@intel.com>
References: <20260210070155.1176081-1-vivek.kasireddy@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.16;
 envelope-from=vivek.kasireddy@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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
 include/hw/vfio/vfio-device.h | 16 +++++++++
 2 files changed, 81 insertions(+)

diff --git a/hw/vfio/device.c b/hw/vfio/device.c
index a7603600f3..ef05ec8ade 100644
--- a/hw/vfio/device.c
+++ b/hw/vfio/device.c
@@ -725,3 +725,68 @@ bool vfio_device_create_dmabuf(struct iovec *iov, unsigned int iov_cnt,
     }
     return true;
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
+        if (!vfio_device_get_region_info(vbasedev, index, &info)) {
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
diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
index 003bac10b5..b8e0801b94 100644
--- a/include/hw/vfio/vfio-device.h
+++ b/include/hw/vfio/vfio-device.h
@@ -332,6 +332,22 @@ int vfio_get_region_index_from_mr(MemoryRegion *mr);
  */
 bool vfio_device_create_dmabuf(struct iovec *iov, unsigned int iov_cnt,
                                int *fd, Error **errp);
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
+ *
+ * Returns true on success and false in case of an error.
+ */
+bool vfio_device_mmap_dmabuf(struct iovec *iov, unsigned int iov_cnt,
+                             void **addr, size_t total_size, Error **errp);
 #endif
 
 /* Returns 0 on success, or a negative errno. */
-- 
2.50.1


