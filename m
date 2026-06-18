Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32094CD98ED
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 03:49:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wa3kk-0004v6-AA; Wed, 17 Jun 2026 23:49:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1wa3ki-0004uK-Bd
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 23:49:16 -0400
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1wa3kg-0008Ok-Nj
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 23:49:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781754555; x=1813290555;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=TMSLeJtOy+jPr3vQZCHYiOP6JY5Ioq6Z33pxMq++iN4=;
 b=crd9ClLFki7zRm4Eux9E7AuLzNOwIqJOyIA06rEbZC3IK2FJ33MMt3KE
 4ZCuRP+wrU3UJeM007Fn1wqZiZUnpc5mkatvUS3KagrwlQpsSCV8v3ttp
 9Fx+XqZszYqL+pu7m9jSQ9yXnL2y76MRdXXiT0epJrDWz48Wo9OMEuxI+
 PMHo5yXuDB+gXf2W1ABAZ0ULXoUAa4ComKcu1A29sp1geMjsRoRKiN7US
 iiOdPRYDrY4GHnmvIbztpFfqJu+SW8KMapuJEPoPmWjREvxwV3orQsaXr
 IvXu4C/5SZu6z5sQWCs20EVyOWytRDw8W/sn0jEU4XCsqUjShlBUudcol g==;
X-CSE-ConnectionGUID: 1u4WJv2sRXCsnXuARC8jPg==
X-CSE-MsgGUID: uuNqA+/wR3CQ6/OJgmrmWA==
X-IronPort-AV: E=McAfee;i="6800,10657,11820"; a="82776859"
X-IronPort-AV: E=Sophos;i="6.24,210,1774335600"; d="scan'208";a="82776859"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jun 2026 20:49:14 -0700
X-CSE-ConnectionGUID: MkK1UpkbT0CfiztApv6ORA==
X-CSE-MsgGUID: cfzU51jeTLCyVwNEipWiFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,210,1774335600"; d="scan'208";a="253352777"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jun 2026 20:49:10 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex@shazbot.org, clg@redhat.com, eric.auger@redhat.com, mst@redhat.com,
 jasowang@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 skolothumtho@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@bull.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 xudong.hao@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v2 5/5] intel_iommu_accel: teardown FAULTQ resources in bottom
 half
Date: Wed, 17 Jun 2026 23:48:43 -0400
Message-ID: <20260618034844.618011-6-zhenzhong.duan@intel.com>
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

When a pasid entry becomes invalid, we need to release all resources
allocated for that entry including FAULTQ object and fault_fd.

We call qemu_set_fd_handler() to detach fault_fd's io_read handler and
wakes up main thread from poll(), but there could still be a small
window we call iommufd_backend_free_id(fault_id) before poll() exit
and release fault_id file reference. In this rare case, FAULTQ object
free return -EBUSY because opened fault_id file keeps reference of
FAULTQ object.

Teardown FAULTQ resources in bottom half to ensure poll() has released
fault_id file reference.

Suggested-by: Shameer Kolothum <skolothumtho@nvidia.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Tested-by: Xudong Hao <xudong.hao@intel.com>
---
 hw/i386/intel_iommu_accel.c | 31 ++++++++++++++++++++++++++++---
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/hw/i386/intel_iommu_accel.c b/hw/i386/intel_iommu_accel.c
index 9746355cd6..4857edbcce 100644
--- a/hw/i386/intel_iommu_accel.c
+++ b/hw/i386/intel_iommu_accel.c
@@ -245,15 +245,40 @@ free_faultq:
     return false;
 }
 
+typedef struct IOMMUFaultQueue {
+    IOMMUFDBackend *iommufd;
+    uint32_t id;
+    int fd;
+} IOMMUFaultQueue;
+
+static void faultq_teardown_bh(void *opaque)
+{
+    IOMMUFaultQueue *fq = opaque;
+
+    qemu_set_fd_handler(fq->fd, NULL, NULL, NULL);
+    close(fq->fd);
+    iommufd_backend_free_id(fq->iommufd, fq->id);
+
+    g_free(fq);
+}
+
 static void vtd_destroy_old_fs_faultq(VTDAccelPASIDCacheEntry *vtd_pce)
 {
+    HostIOMMUDeviceIOMMUFD *idev =
+        HOST_IOMMU_DEVICE_IOMMUFD(vtd_pce->vtd_hiod->hiod);
+
     if (vtd_pce->fault_fd < 0) {
         return;
     }
 
-    qemu_set_fd_handler(vtd_pce->fault_fd, NULL, NULL, NULL);
-    vtd_destroy_fs_faultq(vtd_pce->vtd_hiod, vtd_pce->fault_id,
-                          vtd_pce->fault_fd);
+    IOMMUFaultQueue *fq = g_malloc(sizeof(IOMMUFaultQueue));
+    fq->iommufd = idev->iommufd;
+    fq->fd = vtd_pce->fault_fd;
+    fq->id = vtd_pce->fault_id;
+
+    aio_bh_schedule_oneshot(iohandler_get_aio_context(),
+                            faultq_teardown_bh, fq);
+
     vtd_pce->fault_id = 0;
     vtd_pce->fault_fd = -1;
 }
-- 
2.52.0


