Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F8C2C79F8C
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 07:29:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4Cjz-0004IY-7q; Wed, 09 Sep 2026 03:29:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1x4Cjx-0004ID-KD
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 03:29:05 -0400
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1x4Cjv-0003ls-TX
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 03:29:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788938944; x=1820474944;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=oXa9aU/pnOkKiAjG1eoG8cmrXg38L1xjPhqUAnvKK1M=;
 b=c2P0keulDT1qd69X7U3LvtpH1tVIoFmKDfiSIkbktjLR7gq9+cQQiI9C
 bJDK84Ri06mvQvHkAkZeDIqBfbAPVCrQnhl1R9A63ueUk01Y/8VwlV0M1
 7L3yOqIaCqfhMb6xY/RRT1dRVB74ztyBkXV8rTSgZocmT7fGtK9yFkRML
 4WB/DPZ2y7ocqmObQtpKPn0YFrCXRY5KYRaYTfXXv5dwmdlpszZztgrC1
 q2g6M1EhLxAQW/SxxgRaPCUjn4XWb3yFZni2cimqIKPF8+DwHfQpP2U1T
 Y/b9budTeo3u/lJuIujK/qgQi8vR0D/1JdWCeR4mvrwxJXJNwwNFAKHan A==;
X-CSE-ConnectionGUID: CN8Ur9KySNSxc7dSV4NKqg==
X-CSE-MsgGUID: C6C5AdcpTiSnOhjJlLC0yA==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="106723290"
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; d="scan'208";a="106723290"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Sep 2026 00:29:02 -0700
X-CSE-ConnectionGUID: QyRcQMxIQPeuwC8Idd06zw==
X-CSE-MsgGUID: kKC4Mr91SKqENgcbdjYm0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; d="scan'208";a="267982416"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.229.148])
 by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Sep 2026 00:28:58 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex@shazbot.org, clg@redhat.com, eric.auger@redhat.com, mst@redhat.com,
 jasowangio@gmail.com, jgg@nvidia.com, nicolinc@nvidia.com,
 skolothumtho@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@bull.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Xudong Hao <xudong.hao@intel.com>
Subject: [PATCH v6 2/6] backends/iommufd: Introduce
 iommufd_backend_alloc_faultq
Date: Wed,  9 Sep 2026 15:28:33 +0800
Message-ID: <20260909072837.3183154-3-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260909072837.3183154-1-zhenzhong.duan@intel.com>
References: <20260909072837.3183154-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.10;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Add a new helper for IOMMU_FAULT_QUEUE_ALLOC ioctl to allocate a fault
handling object which will be used in hwpt allocation.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Clement Mathieu--Drif <clement.mathieu--drif@bull.com>
Reviewed-by: Yi Liu <yi.l.liu@intel.com>
Tested-by: Xudong Hao <xudong.hao@intel.com>
---
 include/system/iommufd.h |  3 +++
 backends/iommufd.c       | 21 +++++++++++++++++++++
 backends/trace-events    |  1 +
 3 files changed, 25 insertions(+)

diff --git a/include/system/iommufd.h b/include/system/iommufd.h
index 17bf1a3727..36b34b4899 100644
--- a/include/system/iommufd.h
+++ b/include/system/iommufd.h
@@ -106,6 +106,9 @@ bool iommufd_backend_alloc_veventq(IOMMUFDBackend *be, uint32_t viommu_id,
                                    uint32_t *out_veventq_id,
                                    uint32_t *out_veventq_fd, Error **errp);
 
+bool iommufd_backend_alloc_faultq(IOMMUFDBackend *be, uint32_t *out_fault_id,
+                                  uint32_t *out_fault_fd, Error **errp);
+
 bool iommufd_backend_alloc_hw_queue(IOMMUFDBackend *be, uint32_t viommu_id,
                                     uint32_t queue_type, uint32_t index,
                                     uint64_t addr, uint64_t length,
diff --git a/backends/iommufd.c b/backends/iommufd.c
index 15f2a51350..2775eef741 100644
--- a/backends/iommufd.c
+++ b/backends/iommufd.c
@@ -554,6 +554,27 @@ bool iommufd_backend_alloc_veventq(IOMMUFDBackend *be, uint32_t viommu_id,
     return true;
 }
 
+bool iommufd_backend_alloc_faultq(IOMMUFDBackend *be, uint32_t *out_fault_id,
+                                  uint32_t *out_fault_fd, Error **errp)
+{
+    int ret, fd = be->fd;
+    struct iommu_fault_alloc cmd = {
+        .size = sizeof(cmd),
+    };
+
+    ret = ioctl(fd, IOMMU_FAULT_QUEUE_ALLOC, &cmd);
+    trace_iommufd_backend_alloc_faultq(fd, cmd.out_fault_id, cmd.out_fault_fd,
+                                       ret);
+    if (ret) {
+        error_setg_errno(errp, errno, "Failed to allocate fault queue");
+        return false;
+    }
+
+    *out_fault_id = cmd.out_fault_id;
+    *out_fault_fd = cmd.out_fault_fd;
+    return true;
+}
+
 bool iommufd_backend_alloc_hw_queue(IOMMUFDBackend *be, uint32_t viommu_id,
                                     uint32_t queue_type, uint32_t index,
                                     uint64_t addr, uint64_t length,
diff --git a/backends/trace-events b/backends/trace-events
index 9b7b9b7d68..b1c1d89dd8 100644
--- a/backends/trace-events
+++ b/backends/trace-events
@@ -17,6 +17,7 @@ iommufd_backend_unmap_dma_non_exist(int iommufd, uint32_t ioas, uint64_t iova, u
 iommufd_backend_unmap_dma(int iommufd, uint32_t ioas, uint64_t iova, uint64_t size, int ret) " iommufd=%d ioas=%d iova=0x%"PRIx64" size=0x%"PRIx64" (%d)"
 iommufd_backend_alloc_ioas(int iommufd, uint32_t ioas) " iommufd=%d ioas=%d"
 iommufd_backend_alloc_hwpt(int iommufd, uint32_t dev_id, uint32_t pt_id, uint32_t flags, uint32_t hwpt_type, uint32_t len, uint64_t data_ptr, uint32_t out_hwpt_id, int ret) " iommufd=%d dev_id=%u pt_id=%u flags=0x%x hwpt_type=%u len=%u data_ptr=0x%"PRIx64" out_hwpt=%u (%d)"
+iommufd_backend_alloc_faultq(int iommufd, uint32_t fault_id, uint32_t fault_fd, int ret) " iommufd=%d fault_id=%u fault_fd=%u (%d)"
 iommufd_backend_free_id(int iommufd, uint32_t id, int ret) " iommufd=%d id=%d (%d)"
 iommufd_backend_set_dirty(int iommufd, uint32_t hwpt_id, bool start, int ret) " iommufd=%d hwpt=%u enable=%d (%d)"
 iommufd_backend_get_dirty_bitmap(int iommufd, uint32_t hwpt_id, uint64_t iova, uint64_t size, uint64_t flags, uint64_t page_size, int ret) " iommufd=%d hwpt=%u iova=0x%"PRIx64" size=0x%"PRIx64" flags=0x%"PRIx64" page_size=0x%"PRIx64" (%d)"
-- 
2.52.0


