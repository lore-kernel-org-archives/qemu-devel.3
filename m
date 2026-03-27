Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4A1D10BA420
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 02:53:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5xJY-0005Xc-Ir; Thu, 26 Mar 2026 22:52:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1w5xJU-0005Wa-Nq
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 22:52:45 -0400
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1w5xJT-00083T-1k
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 22:52:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774579963; x=1806115963;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=w5vSF8KYox0CHnA35X/HlNBRury1CbOEj6ktSvWYxDg=;
 b=M1paV1vQkF+G/CDgyTbT1vn/NSBmRnQc8lAnTnYaqQLXEyHsFByWo0UH
 2oDGqIb+PuOoGEt7BPibqb/WIUpKxK4NvJFnGjIrSiDfmReVF4qgZSMlF
 k0KhR0ct1/4s0YISoXaIhmcXpKFN0DBnsNcbQqnj8sqw41EzPX5nsD07z
 udJQSeZbr6iQoQ7NM5yziGWSQItXnF/RkNNZDyZdZvwFxxp+ccNgEHV7W
 22SoxOVzzlUn+9Re0aL8ko3SJwKnsOvbidoUWp3RYsrZ/PxxLVMEyg8Mn
 vvAF3WTOMl13mOCW1We2jZkldAWhWpVJWFnqZ3NqOcKcOP0M1KxK9gfMF Q==;
X-CSE-ConnectionGUID: FZ0KGynHSdmlRgIdzW0NbA==
X-CSE-MsgGUID: /jCtXBf2SfCaTvyZi6X92g==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="75719878"
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; d="scan'208";a="75719878"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Mar 2026 19:52:42 -0700
X-CSE-ConnectionGUID: KyFET4/UQgmFgo1t+CeniA==
X-CSE-MsgGUID: hJ5UlfSaQ/Kwxe02QtYgjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; d="scan'208";a="221874380"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Mar 2026 19:52:38 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex@shazbot.org, clg@redhat.com, eric.auger@redhat.com, mst@redhat.com,
 jasowang@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 skolothumtho@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@bull.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 xudong.hao@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH 1/5] backends/iommufd: Introduce iommufd_backend_alloc_faultq
Date: Thu, 26 Mar 2026 22:52:23 -0400
Message-ID: <20260327025228.474257-2-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260327025228.474257-1-zhenzhong.duan@intel.com>
References: <20260327025228.474257-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.14;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
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

Add a new helper for IOMMU_FAULT_QUEUE_ALLOC ioctl to allocate a fault
handling object which will be used in hwpt allocation.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 include/system/iommufd.h |  3 +++
 backends/iommufd.c       | 21 +++++++++++++++++++++
 backends/trace-events    |  1 +
 3 files changed, 25 insertions(+)

diff --git a/include/system/iommufd.h b/include/system/iommufd.h
index 45a9e87cb0..d4ba8434a5 100644
--- a/include/system/iommufd.h
+++ b/include/system/iommufd.h
@@ -100,6 +100,9 @@ bool iommufd_backend_alloc_veventq(IOMMUFDBackend *be, uint32_t viommu_id,
                                    uint32_t *out_veventq_id,
                                    uint32_t *out_veventq_fd, Error **errp);
 
+bool iommufd_backend_alloc_faultq(IOMMUFDBackend *be, uint32_t *fault_id,
+                                  uint32_t *fault_fd, Error **errp);
+
 bool iommufd_backend_set_dirty_tracking(IOMMUFDBackend *be, uint32_t hwpt_id,
                                         bool start, Error **errp);
 bool iommufd_backend_get_dirty_bitmap(IOMMUFDBackend *be, uint32_t hwpt_id,
diff --git a/backends/iommufd.c b/backends/iommufd.c
index ab612e4874..9496377a25 100644
--- a/backends/iommufd.c
+++ b/backends/iommufd.c
@@ -337,6 +337,27 @@ bool iommufd_backend_alloc_hwpt(IOMMUFDBackend *be, uint32_t dev_id,
     return true;
 }
 
+bool iommufd_backend_alloc_faultq(IOMMUFDBackend *be, uint32_t *fault_id,
+                                  uint32_t *fault_fd, Error **errp)
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
+    *fault_id = cmd.out_fault_id;
+    *fault_fd = cmd.out_fault_fd;
+    return true;
+}
+
 bool iommufd_backend_set_dirty_tracking(IOMMUFDBackend *be,
                                         uint32_t hwpt_id, bool start,
                                         Error **errp)
diff --git a/backends/trace-events b/backends/trace-events
index b9365113e7..6820a9939e 100644
--- a/backends/trace-events
+++ b/backends/trace-events
@@ -17,6 +17,7 @@ iommufd_backend_unmap_dma_non_exist(int iommufd, uint32_t ioas, uint64_t iova, u
 iommufd_backend_unmap_dma(int iommufd, uint32_t ioas, uint64_t iova, uint64_t size, int ret) " iommufd=%d ioas=%d iova=0x%"PRIx64" size=0x%"PRIx64" (%d)"
 iommufd_backend_alloc_ioas(int iommufd, uint32_t ioas) " iommufd=%d ioas=%d"
 iommufd_backend_alloc_hwpt(int iommufd, uint32_t dev_id, uint32_t pt_id, uint32_t flags, uint32_t hwpt_type, uint32_t len, uint64_t data_ptr, uint32_t out_hwpt_id, int ret) " iommufd=%d dev_id=%u pt_id=%u flags=0x%x hwpt_type=%u len=%u data_ptr=0x%"PRIx64" out_hwpt=%u (%d)"
+iommufd_backend_alloc_faultq(int iommufd, uint32_t fault_id, uint32_t fault_fd, int ret) " iommufd=%d fault_id=%d fault_fd=%d (%d)"
 iommufd_backend_free_id(int iommufd, uint32_t id, int ret) " iommufd=%d id=%d (%d)"
 iommufd_backend_set_dirty(int iommufd, uint32_t hwpt_id, bool start, int ret) " iommufd=%d hwpt=%u enable=%d (%d)"
 iommufd_backend_get_dirty_bitmap(int iommufd, uint32_t hwpt_id, uint64_t iova, uint64_t size, uint64_t flags, uint64_t page_size, int ret) " iommufd=%d hwpt=%u iova=0x%"PRIx64" size=0x%"PRIx64" flags=0x%"PRIx64" page_size=0x%"PRIx64" (%d)"
-- 
2.47.3


