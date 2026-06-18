Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CAD8CD98ED
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 03:50:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wa3kW-0004rl-1I; Wed, 17 Jun 2026 23:49:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1wa3kV-0004rW-28
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 23:49:03 -0400
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1wa3kT-0008OK-54
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 23:49:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781754541; x=1813290541;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=dBgCqtONCptyZXJ2k+3tDlSp+lfxKq17l6cUqH3J2Q0=;
 b=g+n2OppFN/aNDEVnbzN/Ma6Co1mVvx9SIdR/8BfRmVvxy/29KDjKS7Gs
 G/D3xKXua7p4BvBS8ehPJy+agYd74zmyUM7nybUcZYwPy7iHwb2FEXKDk
 EjqgpEgov91us0BzTMomvVApfCBjJEaYcmme5mopNbVDzhAgPuz+65pvJ
 CYNFngmW5g8FxvpvES3Y/9SKcIKiEhQtXqbQWsKWmRJK3LPAw+QbVNhl9
 MNXrlT1q4ukSbuTjLE/m/lF3tVYHHz/JoIW/ZgAvxIdSws2GRytCDbKu9
 cM6A5fy5RtRUkaDXjsB1rx3Dy4C3U6M+OB3iWyRA4+sZfmyOoWO/rbmEq A==;
X-CSE-ConnectionGUID: DlYOoQuvQk6/w6W3M7qFdQ==
X-CSE-MsgGUID: kE1I7UoDT46Q96sQa7Wi5A==
X-IronPort-AV: E=McAfee;i="6800,10657,11820"; a="82776826"
X-IronPort-AV: E=Sophos;i="6.24,210,1774335600"; d="scan'208";a="82776826"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jun 2026 20:48:59 -0700
X-CSE-ConnectionGUID: CTngwMwpT4CPQfG9BWq6rg==
X-CSE-MsgGUID: A37hcDYiTm6l1KqQ8uc6lg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,210,1774335600"; d="scan'208";a="253352574"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jun 2026 20:48:55 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex@shazbot.org, clg@redhat.com, eric.auger@redhat.com, mst@redhat.com,
 jasowang@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 skolothumtho@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@bull.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 xudong.hao@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v2 1/5] backends/iommufd: Introduce
 iommufd_backend_alloc_faultq
Date: Wed, 17 Jun 2026 23:48:39 -0400
Message-ID: <20260618034844.618011-2-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260618034844.618011-1-zhenzhong.duan@intel.com>
References: <20260618034844.618011-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.16;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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
Tested-by: Xudong Hao <xudong.hao@intel.com>
---
 include/system/iommufd.h |  3 +++
 backends/iommufd.c       | 21 +++++++++++++++++++++
 backends/trace-events    |  1 +
 3 files changed, 25 insertions(+)

diff --git a/include/system/iommufd.h b/include/system/iommufd.h
index 17bf1a3727..c287767b11 100644
--- a/include/system/iommufd.h
+++ b/include/system/iommufd.h
@@ -106,6 +106,9 @@ bool iommufd_backend_alloc_veventq(IOMMUFDBackend *be, uint32_t viommu_id,
                                    uint32_t *out_veventq_id,
                                    uint32_t *out_veventq_fd, Error **errp);
 
+bool iommufd_backend_alloc_faultq(IOMMUFDBackend *be, uint32_t *fault_id,
+                                  int *fault_fd, Error **errp);
+
 bool iommufd_backend_alloc_hw_queue(IOMMUFDBackend *be, uint32_t viommu_id,
                                     uint32_t queue_type, uint32_t index,
                                     uint64_t addr, uint64_t length,
diff --git a/backends/iommufd.c b/backends/iommufd.c
index 09624cd652..9c56a7bcd6 100644
--- a/backends/iommufd.c
+++ b/backends/iommufd.c
@@ -549,6 +549,27 @@ bool iommufd_backend_alloc_veventq(IOMMUFDBackend *be, uint32_t viommu_id,
     return true;
 }
 
+bool iommufd_backend_alloc_faultq(IOMMUFDBackend *be, uint32_t *fault_id,
+                                  int *fault_fd, Error **errp)
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
 bool iommufd_backend_alloc_hw_queue(IOMMUFDBackend *be, uint32_t viommu_id,
                                     uint32_t queue_type, uint32_t index,
                                     uint64_t addr, uint64_t length,
diff --git a/backends/trace-events b/backends/trace-events
index b63420b73e..1df3efb353 100644
--- a/backends/trace-events
+++ b/backends/trace-events
@@ -17,6 +17,7 @@ iommufd_backend_unmap_dma_non_exist(int iommufd, uint32_t ioas, uint64_t iova, u
 iommufd_backend_unmap_dma(int iommufd, uint32_t ioas, uint64_t iova, uint64_t size, int ret) " iommufd=%d ioas=%d iova=0x%"PRIx64" size=0x%"PRIx64" (%d)"
 iommufd_backend_alloc_ioas(int iommufd, uint32_t ioas) " iommufd=%d ioas=%d"
 iommufd_backend_alloc_hwpt(int iommufd, uint32_t dev_id, uint32_t pt_id, uint32_t flags, uint32_t hwpt_type, uint32_t len, uint64_t data_ptr, uint32_t out_hwpt_id, int ret) " iommufd=%d dev_id=%u pt_id=%u flags=0x%x hwpt_type=%u len=%u data_ptr=0x%"PRIx64" out_hwpt=%u (%d)"
+iommufd_backend_alloc_faultq(int iommufd, uint32_t fault_id, int fault_fd, int ret) " iommufd=%d fault_id=%u fault_fd=%d (%d)"
 iommufd_backend_free_id(int iommufd, uint32_t id, int ret) " iommufd=%d id=%d (%d)"
 iommufd_backend_set_dirty(int iommufd, uint32_t hwpt_id, bool start, int ret) " iommufd=%d hwpt=%u enable=%d (%d)"
 iommufd_backend_get_dirty_bitmap(int iommufd, uint32_t hwpt_id, uint64_t iova, uint64_t size, uint64_t flags, uint64_t page_size, int ret) " iommufd=%d hwpt=%u iova=0x%"PRIx64" size=0x%"PRIx64" flags=0x%"PRIx64" page_size=0x%"PRIx64" (%d)"
-- 
2.52.0


