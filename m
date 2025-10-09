Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4EF9CCA471
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 04:04:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6hrR-0005oL-CN; Thu, 09 Oct 2025 00:02:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1v6hrN-0005nY-O9
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 00:02:34 -0400
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1v6hrD-0002b2-7c
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 00:02:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1759982543; x=1791518543;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=bCM8JqnsTf0uHErOG5tcVjKaa7+Cl/EZ1hBjD9sT9ks=;
 b=ccqYM7+AoInKZIxebHgkRPb5/i4TbLCElxTUkvJF2LbmlAIn0yMbfIVZ
 oY2sM3v4/cuxQ2zKSHVPNy0T2G1N44Pw9mT3amEuqf134BAnG5OIvRqtx
 kHnjolhBYj3R8NN5iBE7gQTw1C0B/TS+b+LgY11XnIZTqBjmWUC7Rs50X
 wvVcITdzUZlCGVfHyh3SEcSaDT3hTd7aWlxB/vc3muUhfCo1WGDwPwHjv
 F8w6tSYL3lyzqtf+FihTGH7Ti1P1mitwSzwEKvIb/f3SxNk2N92RrxmYP
 i+XQ/yw57s0LjA0N6TmWZQ/T0ElkYknLdMgzPXVu+F+d5298NMfCM4IoH Q==;
X-CSE-ConnectionGUID: WabdLdWvQnWiiRDEcbXVRw==
X-CSE-MsgGUID: POaZ8RMrR/+U5mwTRFNlUg==
X-IronPort-AV: E=McAfee;i="6800,10657,11576"; a="84804135"
X-IronPort-AV: E=Sophos;i="6.19,215,1754982000"; d="scan'208";a="84804135"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Oct 2025 21:02:16 -0700
X-CSE-ConnectionGUID: NTDe3AgXTLy1/i4THWbCyQ==
X-CSE-MsgGUID: /nXASSMWSNqLMlCvYYJGcw==
X-ExtLoop1: 1
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Oct 2025 21:02:15 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 levon@movementarian.org, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v2 2/3] vfio/iommufd: Support unmap all in one ioctl()
Date: Thu,  9 Oct 2025 00:01:33 -0400
Message-ID: <20251009040134.334251-3-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20251009040134.334251-1-zhenzhong.duan@intel.com>
References: <20251009040134.334251-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.9;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

IOMMUFD kernel uAPI supports unmapping whole address space in one call with
[iova, size] set to [0, UINT64_MAX], this can simplify iommufd_cdev_unmap()
a bit. See iommufd_ioas_unmap() in kernel for details.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/vfio/iommufd.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 68470d552e..336f8fdb04 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -62,21 +62,8 @@ static int iommufd_cdev_unmap(const VFIOContainer *bcontainer,
 {
     const VFIOIOMMUFDContainer *container = VFIO_IOMMU_IOMMUFD(bcontainer);
 
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
+        size = UINT64_MAX;
     }
 
     /* TODO: Handle dma_unmap_bitmap with iotlb args (migration) */
-- 
2.47.1


