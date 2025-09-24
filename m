Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22554CAC5A5
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 07:04:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1JXH-0005vA-4I; Wed, 24 Sep 2025 03:03:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1v1JXB-0005tQ-7h
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 03:03:25 -0400
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1v1JX3-0001S7-GE
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 03:03:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758697397; x=1790233397;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=QE+93H5zx2Cumt50cB45OVBESI7leJRch2TqNhvibqQ=;
 b=ks6vvrOx7G+9jYY3SmuighZUgurafP+oSwkffZkM4zaMAFE5CSNNjxhE
 3LEPaaCvo5lsTeLJbqXNzuodi2n/p2X9a+NW5Vzzcp/RyN6R7DU2uA+BP
 Jt9vg64mFizmyStmN+UkDjzHoqWUAqAGyszjM3byKh3VlIBgcSG1xdlbQ
 /Fpg5e7C52w8l/h9nm8nzpMPhR4cm+AbLVJOtFgHBH4/870XEq4h+z6oY
 EM7TA6mm+HfjRth8yEHLORkE+SB0l8qUIzhX4R0a4T0nKGLH3Pbmf5aY3
 cwG+1uqgQdmWNIB4yNmDO56lJfJ5fbMPfaP1Af/iw2CIQrzliY19v0gMA w==;
X-CSE-ConnectionGUID: TnHjmzH+Qj2dwkmEoAhPCQ==
X-CSE-MsgGUID: nGNH28tWSSOs+0yQnCHVXQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11561"; a="86429772"
X-IronPort-AV: E=Sophos;i="6.18,290,1751266800"; d="scan'208";a="86429772"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2025 00:03:07 -0700
X-CSE-ConnectionGUID: 8JDok/cmTnuRRQYi6skEnQ==
X-CSE-MsgGUID: D2myTBU5SDu0vIOTkcoX6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,290,1751266800"; d="scan'208";a="180975724"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2025 00:03:05 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 joao.m.martins@oracle.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH 2/2] vfio/iommufd: Support unmap all in one ioctl()
Date: Wed, 24 Sep 2025 03:02:54 -0400
Message-ID: <20250924070254.1550014-3-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250924070254.1550014-1-zhenzhong.duan@intel.com>
References: <20250924070254.1550014-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.7;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

IOMMUFD kernel uAPI supports unmapping whole address space in one call with
[iova, size] set to [0, UINT64_MAX], this can simplify iommufd_cdev_unmap()
a bit.  See iommufd_ioas_unmap() in kernel for details.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/vfio/iommufd.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 8c27222f75..02e4b8774a 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -65,21 +65,9 @@ static int iommufd_cdev_unmap(const VFIOContainerBase *bcontainer,
     const VFIOIOMMUFDContainer *container =
         container_of(bcontainer, VFIOIOMMUFDContainer, bcontainer);
 
-    /* unmap in halves */
     if (unmap_all) {
-        Int128 llsize = int128_rshift(int128_2_64(), 1);
-        int ret;
-
-        ret = iommufd_backend_unmap_dma(container->be, container->ioas_id,
-                                        0, int128_get64(llsize));
-
-        if (ret == 0) {
-            ret = iommufd_backend_unmap_dma(container->be, container->ioas_id,
-                                            int128_get64(llsize),
-                                            int128_get64(llsize));
-        }
-
-        return ret;
+        assert(!iova && !size);
+        size = UINT64_MAX;
     }
 
     /* TODO: Handle dma_unmap_bitmap with iotlb args (migration) */
-- 
2.47.1


