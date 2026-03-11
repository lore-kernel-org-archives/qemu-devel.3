Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D70AEFD88DF
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 02:57:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w09ke-0000UE-Sw; Tue, 10 Mar 2026 22:56:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1w09kd-0000Ss-7q
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 22:56:47 -0400
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1w09kb-00063p-EU
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 22:56:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773197805; x=1804733805;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=08119oWNX6HNfHpJjN7BnHeokG/3MBZuZM69MALLN+s=;
 b=GJqta/8T+/cb7hZgOQ5x7jdfdrRQZsPTLPNWWxCXKEx3V4qmYWPdF8ET
 6haqFAfc+NMc3L40EI4y9+UFAs8QrZ4qYyDHNkOzd1zNawcb7iMF9hC1/
 exb6kO30UvLrqU5tFiTsxDizH+PyBj1lIdr0VD0dN0F0cII0X+KhZ2Oag
 qhA4DIEh91jwrClmagvQirpd7iHjuZ6eALduL5NAAjOVZJYr19NXe1hlF
 xWLDj24wsBO1GrxNPuhmf89Mf/WIOEdnDLmGlq1IQgWRW0N4E0l+2RbEy
 xpdmy7iIdDVM3F/LLR3TqNVP6LYKGz8oMJCVZxKC9TxtaK2XgOBZjDwIS g==;
X-CSE-ConnectionGUID: IRzMAHRqQMqRtPX0qNiz7w==
X-CSE-MsgGUID: 7yZk6gaTSvOR53JvgfJJgA==
X-IronPort-AV: E=McAfee;i="6800,10657,11725"; a="76867927"
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; d="scan'208";a="76867927"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Mar 2026 19:56:29 -0700
X-CSE-ConnectionGUID: ytok5TbrRUmGmDlnGMP1cw==
X-CSE-MsgGUID: 1OMY7PnMTTOYKimVFTanLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; d="scan'208";a="215611453"
Received: from vkasired-desk2.fm.intel.com ([10.105.128.132])
 by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Mar 2026 19:56:29 -0700
From: Vivek Kasireddy <vivek.kasireddy@intel.com>
To: qemu-devel@nongnu.org
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>,
 Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v11 08/10] vfio/device: Add a helper to mmap a dmabuf
Date: Tue, 10 Mar 2026 19:50:50 -0700
Message-ID: <20260311025340.1335673-9-vivek.kasireddy@intel.com>
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

In order to mmap a dmabuf, we first need to create a placeholder
mapping that would fit the entire size of the dmabuf. This mapping
would then be replaced with smaller mappings of individual dmabuf
segments.

Cc: Alex Williamson <alex@shazbot.org>
Cc: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
---
 hw/vfio/device.c              | 64 +++++++++++++++++++++++++++++++++++
 hw/vfio/dmabuf-stubs.c        |  7 ++++
 include/hw/vfio/vfio-device.h | 16 +++++++++
 3 files changed, 87 insertions(+)

diff --git a/hw/vfio/device.c b/hw/vfio/device.c
index 2d01059be0..fdb94f1457 100644
--- a/hw/vfio/device.c
+++ b/hw/vfio/device.c
@@ -725,3 +725,67 @@ int vfio_device_create_dmabuf_fd(struct iovec *iov, unsigned int iov_cnt,
     }
     return ret;
 }
+
+void *vfio_device_mmap_dmabuf(struct iovec *iov, unsigned int iov_cnt,
+                              size_t total_size, Error **errp)
+{
+    struct vfio_region_info *info = NULL;
+    VFIODevice *vbasedev = NULL;
+    ram_addr_t offset, len = 0;
+    RAMBlock *first_rb, *rb;
+    void *map, *submap;
+    int i, index;
+
+    if (!vfio_device_lookup(iov, &vbasedev, errp)) {
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
+            error_setg_errno(errp, errno, "Could not mmap dmabuf segment\n");
+            goto err;
+        }
+
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
index e71e2b68dd..92b52bc60d 100644
--- a/hw/vfio/dmabuf-stubs.c
+++ b/hw/vfio/dmabuf-stubs.c
@@ -15,3 +15,10 @@ int vfio_device_create_dmabuf_fd(struct iovec *iov, unsigned int iov_cnt,
     error_setg(errp, "VFIO dmabuf support is not enabled");
     return VFIO_DMABUF_CREATE_HOST_ERROR;
 }
+
+void *vfio_device_mmap_dmabuf(struct iovec *iov, unsigned int iov_cnt,
+                              size_t total_size, Error **errp)
+{
+    error_setg(errp, "VFIO mmap dmabuf support is not enabled");
+    return NULL;
+}
diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
index 566e5d8bc0..60783d6fd5 100644
--- a/include/hw/vfio/vfio-device.h
+++ b/include/hw/vfio/vfio-device.h
@@ -340,6 +340,22 @@ int vfio_get_region_index_from_mr(MemoryRegion *mr);
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
+ * @total_size: total size of the dmabuf
+ * @errp: pointer to Error*, to store an error if it happens.
+ *
+ * Returns the mapped pointer on success and NULL on error.
+ */
+void *vfio_device_mmap_dmabuf(struct iovec *iov, unsigned int iov_cnt,
+                              size_t total_size, Error **errp);
 #endif
 
 /* Returns 0 on success, or a negative errno. */
-- 
2.53.0


