Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 807D61088E7E
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 05:24:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w35r0-0004p5-MA; Thu, 19 Mar 2026 01:23:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1w35qo-0004ng-Nf
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 01:23:19 -0400
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1w35ql-0007tU-H5
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 01:23:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773897796; x=1805433796;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=TgTxvHCWi3fXEA43aM8mwolMJTMmN/YWQczQ7WYTzBs=;
 b=IJ7iaP1xFSM3EY1ukVqetpGAsg2gY50Lx74NUbqnAj4q4ZYNFeRyGk6m
 tUoa90C3Di0ypJigPWO1owbA4s6FQWJ9PB2hIN3GGz6z/95oPtMXqKKGR
 N6LBeWvZOCQA6+qduPhApw0cCI9E3TxKTJsVDq58/reTPoNOE/X7KR54O
 VyDm6dYG8uCVnv/+fsP7c2zQ4wiu84JJlSTYC1KwkTW5W9D1rLS5794XH
 w87OtEPZUYvlK5XCGTFBfNAtZ8Ej6vzzk7/kaYvvQmM1QFcjtY2aTJP+9
 vg+5LQbf9930jGMWqohWxl3z7yTIR2my1fOzpfikXcjcVa1eDIORz9oZg A==;
X-CSE-ConnectionGUID: pdLCrS0DTdGejwfvBDWJPA==
X-CSE-MsgGUID: v6rZXbBBTPGDrWH4deB82Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11733"; a="74660395"
X-IronPort-AV: E=Sophos;i="6.23,128,1770624000"; d="scan'208";a="74660395"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2026 22:23:07 -0700
X-CSE-ConnectionGUID: QMV0mCFZQHOUbcmrwwRrVw==
X-CSE-MsgGUID: iAD9roUmQbqj9Denh15ktQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,128,1770624000"; d="scan'208";a="218355533"
Received: from vkasired-desk2.fm.intel.com ([10.105.128.132])
 by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2026 22:23:04 -0700
From: Vivek Kasireddy <vivek.kasireddy@intel.com>
To: qemu-devel@nongnu.org
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>,
 Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v12 08/10] vfio/device: Add a helper to mmap a dmabuf
Date: Wed, 18 Mar 2026 22:15:57 -0700
Message-ID: <20260319052023.2088685-9-vivek.kasireddy@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260319052023.2088685-1-vivek.kasireddy@intel.com>
References: <20260319052023.2088685-1-vivek.kasireddy@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.20;
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
 include/hw/vfio/vfio-device.h | 16 ++++++++++
 hw/vfio/device.c              | 59 +++++++++++++++++++++++++++++++++++
 hw/vfio/dmabuf-stubs.c        |  7 +++++
 3 files changed, 82 insertions(+)

diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
index d46640ff53..14909490ef 100644
--- a/include/hw/vfio/vfio-device.h
+++ b/include/hw/vfio/vfio-device.h
@@ -331,6 +331,22 @@ int vfio_device_get_irq_info(VFIODevice *vbasedev, int index,
  */
 int vfio_device_create_dmabuf_fd(struct iovec *iov, unsigned int iov_cnt,
                                  size_t total_size, Error **errp);
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
diff --git a/hw/vfio/device.c b/hw/vfio/device.c
index 542c378913..43223ceacd 100644
--- a/hw/vfio/device.c
+++ b/hw/vfio/device.c
@@ -758,3 +758,62 @@ int vfio_device_create_dmabuf_fd(struct iovec *iov, unsigned int iov_cnt,
     }
     return ret;
 }
+
+void *vfio_device_mmap_dmabuf(struct iovec *iov, unsigned int iov_cnt,
+                              size_t total_size, Error **errp)
+{
+    struct vfio_region_info *info = NULL;
+    ram_addr_t offset, len = 0;
+    VFIODevice *vbasedev;
+    VFIORegion *region;
+    RAMBlock *first_rb;
+    void *map, *submap;
+    int i;
+
+    if (iov_size(iov, iov_cnt) != total_size) {
+        error_setg(errp, "Total size of iov does not match dmabuf size\n");
+        return NULL;
+    }
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
index 374bd2a188..044d1ed058 100644
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
-- 
2.53.0


