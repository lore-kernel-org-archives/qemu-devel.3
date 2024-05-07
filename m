Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79BFCC25B75
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 06:45:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4EZp-00038s-8A; Tue, 07 May 2024 02:45:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s4EZi-00036S-B4
 for qemu-devel@nongnu.org; Tue, 07 May 2024 02:45:20 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s4EZg-0005Ee-IH
 for qemu-devel@nongnu.org; Tue, 07 May 2024 02:45:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1715064316; x=1746600316;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=m/kP6uLbI6sW/eoQnViDBe/hAuFiVrL6IoViZA7EnZI=;
 b=OBU+3Up/li8POf+/SdpLwwFVTHLL2nqqvjVBlOSfp3DNSFmujekhNYyl
 JAub5zhY2SlSYzoUBuPN6cLGljlei0NeoU2XYxLc+HMIDK+kVe8FNu3Tv
 k46fhxueLqSA/HVDTZtFG7BpdzRY5rQSwrHHqQJ9VPjY9pEh7XJysF8hZ
 inB28GvWSZZgEn66PmUTC6XdHbwgWwUsNM8m68EVXvDNY9YTVMn/kERzg
 4dDcj8Jw7COirsM3CDMq0zCe6wwPs77CpE4QHaSQ8zdz8eAFVMAGSTQye
 c/3QS0+wcZrjGCklNFbdBJWWICHW52Gkqc58zFHgDsiCvVWt6Cm+p+ZX8 g==;
X-CSE-ConnectionGUID: YoRV2eHtSyC42T2BmjGHsQ==
X-CSE-MsgGUID: bQ7gJEKQQoCn53xk6xIbuw==
X-IronPort-AV: E=McAfee;i="6600,9927,11065"; a="22240225"
X-IronPort-AV: E=Sophos;i="6.07,260,1708416000"; d="scan'208";a="22240225"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 May 2024 23:45:15 -0700
X-CSE-ConnectionGUID: A85EBLSHSg2Augsdg1I/8A==
X-CSE-MsgGUID: mLwk8lxNSZiLWluvmTyuqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,260,1708416000"; d="scan'208";a="28407510"
Received: from unknown (HELO SPR-S2600BT.bj.intel.com) ([10.240.192.124])
 by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 May 2024 23:45:13 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v2 02/11] vfio/pci: Use g_autofree in
 iommufd_cdev_get_info_iova_range()
Date: Tue,  7 May 2024 14:42:43 +0800
Message-Id: <20240507064252.457884-3-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240507064252.457884-1-zhenzhong.duan@intel.com>
References: <20240507064252.457884-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.10;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

Local pointer info is freed before return from
iommufd_cdev_get_info_iova_range().

Use 'g_autofree' to avoid the g_free() calls.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/vfio/iommufd.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 8827ffe636..c644127972 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -258,7 +258,7 @@ static int iommufd_cdev_get_info_iova_range(VFIOIOMMUFDContainer *container,
                                             uint32_t ioas_id, Error **errp)
 {
     VFIOContainerBase *bcontainer = &container->bcontainer;
-    struct iommu_ioas_iova_ranges *info;
+    g_autofree struct iommu_ioas_iova_ranges *info = NULL;
     struct iommu_iova_range *iova_ranges;
     int ret, sz, fd = container->be->fd;
 
@@ -291,12 +291,10 @@ static int iommufd_cdev_get_info_iova_range(VFIOIOMMUFDContainer *container,
     }
     bcontainer->pgsizes = info->out_iova_alignment;
 
-    g_free(info);
     return 0;
 
 error:
     ret = -errno;
-    g_free(info);
     error_setg_errno(errp, errno, "Cannot get IOVA ranges");
     return ret;
 }
-- 
2.34.1


