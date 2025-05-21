Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2967DC54E65
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 11:20:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHhTH-0005RG-Vl; Wed, 21 May 2025 07:18:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uHhTF-0005QS-PZ
 for qemu-devel@nongnu.org; Wed, 21 May 2025 07:18:49 -0400
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uHhTC-0006NN-Oy
 for qemu-devel@nongnu.org; Wed, 21 May 2025 07:18:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747826327; x=1779362327;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=YZB35DqJoOlf0GURKOFT9vGqd0Aim1q03SvKO/Negkk=;
 b=iZQOtZvHRipgJFAv3cPQCHhkiwlN+/wwycwfx5o8OESLW+hOQNW+UZHO
 KdDv1x7f6KnA6VPdPHnP9KjA+3jC5h7Uh7qNeJg3LZV1RAiKoMil3fCQ5
 3ebSMa4a4Vy+w6YXHMPiE/MdTAZXfTf3IFbO3MmB5ttPappiicDNCP188
 hP/awM/kPVaIxt/c96nhQ4xxXc4nW5M6uFdYSOgl69PMJAJ1WzFd08grP
 IHMUV8uuCRYxepdLRGF7PdKOj6ngdXsws78P+9e1mYqP5KcdVlTxdEL4p
 postZkwRJJwoneVg9hp4i7kCXR1Wy0erPR3D7y40yWaOGO2eFyYPT53TC w==;
X-CSE-ConnectionGUID: s8k9xk7lS7OA9MXcGteGmw==
X-CSE-MsgGUID: KhQiyyGMSSOhZp6uC0aYKQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11439"; a="49894860"
X-IronPort-AV: E=Sophos;i="6.15,303,1739865600"; d="scan'208";a="49894860"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2025 04:18:43 -0700
X-CSE-ConnectionGUID: aUSk5PxhSyGrEEThOjTjfg==
X-CSE-MsgGUID: q9iaI9KSRP+o9t5zc8VA+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,303,1739865600"; d="scan'208";a="145158304"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
 by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2025 04:18:38 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com,
 jgg@nvidia.com, nicolinc@nvidia.com, shameerali.kolothum.thodi@huawei.com,
 joao.m.martins@oracle.com, clement.mathieu--drif@eviden.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH rfcv3 01/21] backends/iommufd: Add a helper to invalidate
 user-managed HWPT
Date: Wed, 21 May 2025 19:14:31 +0800
Message-Id: <20250521111452.3316354-2-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250521111452.3316354-1-zhenzhong.duan@intel.com>
References: <20250521111452.3316354-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.14;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.184,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This helper passes cache invalidation request from guest to invalidate
stage-1 page table cache in host hardware.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 include/system/iommufd.h |  4 ++++
 backends/iommufd.c       | 33 +++++++++++++++++++++++++++++++++
 backends/trace-events    |  1 +
 3 files changed, 38 insertions(+)

diff --git a/include/system/iommufd.h b/include/system/iommufd.h
index cbab75bfbf..5399519626 100644
--- a/include/system/iommufd.h
+++ b/include/system/iommufd.h
@@ -61,6 +61,10 @@ bool iommufd_backend_get_dirty_bitmap(IOMMUFDBackend *be, uint32_t hwpt_id,
                                       uint64_t iova, ram_addr_t size,
                                       uint64_t page_size, uint64_t *data,
                                       Error **errp);
+bool iommufd_backend_invalidate_cache(IOMMUFDBackend *be, uint32_t id,
+                                      uint32_t data_type, uint32_t entry_len,
+                                      uint32_t *entry_num, void *data_ptr,
+                                      Error **errp);
 
 #define TYPE_HOST_IOMMU_DEVICE_IOMMUFD TYPE_HOST_IOMMU_DEVICE "-iommufd"
 #endif
diff --git a/backends/iommufd.c b/backends/iommufd.c
index b73f75cd0b..c8788a6438 100644
--- a/backends/iommufd.c
+++ b/backends/iommufd.c
@@ -311,6 +311,39 @@ bool iommufd_backend_get_device_info(IOMMUFDBackend *be, uint32_t devid,
     return true;
 }
 
+bool iommufd_backend_invalidate_cache(IOMMUFDBackend *be, uint32_t id,
+                                      uint32_t data_type, uint32_t entry_len,
+                                      uint32_t *entry_num, void *data_ptr,
+                                      Error **errp)
+{
+    int ret, fd = be->fd;
+    uint32_t total_entries = *entry_num;
+    struct iommu_hwpt_invalidate cache = {
+        .size = sizeof(cache),
+        .hwpt_id = id,
+        .data_type = data_type,
+        .entry_len = entry_len,
+        .entry_num = total_entries,
+        .data_uptr = (uintptr_t)data_ptr,
+    };
+
+    ret = ioctl(fd, IOMMU_HWPT_INVALIDATE, &cache);
+    trace_iommufd_backend_invalidate_cache(fd, id, data_type, entry_len,
+                                           total_entries, cache.entry_num,
+                                           (uintptr_t)data_ptr,
+                                           ret ? errno : 0);
+    if (ret) {
+        *entry_num = cache.entry_num;
+        error_setg_errno(errp, errno, "IOMMU_HWPT_INVALIDATE failed:"
+                         " totally %d entries, processed %d entries",
+                         total_entries, cache.entry_num);
+    } else {
+        g_assert(total_entries == cache.entry_num);
+    }
+
+    return !ret;
+}
+
 static int hiod_iommufd_get_cap(HostIOMMUDevice *hiod, int cap, Error **errp)
 {
     HostIOMMUDeviceCaps *caps = &hiod->caps;
diff --git a/backends/trace-events b/backends/trace-events
index 40811a3162..7278214ea5 100644
--- a/backends/trace-events
+++ b/backends/trace-events
@@ -18,3 +18,4 @@ iommufd_backend_alloc_hwpt(int iommufd, uint32_t dev_id, uint32_t pt_id, uint32_
 iommufd_backend_free_id(int iommufd, uint32_t id, int ret) " iommufd=%d id=%d (%d)"
 iommufd_backend_set_dirty(int iommufd, uint32_t hwpt_id, bool start, int ret) " iommufd=%d hwpt=%u enable=%d (%d)"
 iommufd_backend_get_dirty_bitmap(int iommufd, uint32_t hwpt_id, uint64_t iova, uint64_t size, uint64_t page_size, int ret) " iommufd=%d hwpt=%u iova=0x%"PRIx64" size=0x%"PRIx64" page_size=0x%"PRIx64" (%d)"
+iommufd_backend_invalidate_cache(int iommufd, uint32_t id, uint32_t data_type, uint32_t entry_len, uint32_t entry_num, uint32_t done_num, uint64_t data_ptr, int ret) " iommufd=%d id=%u data_type=%u entry_len=%u entry_num=%u done_num=%u data_ptr=0x%"PRIx64" (%d)"
-- 
2.34.1


