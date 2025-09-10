Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 941BFCAC582
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Sep 2025 02:39:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwAih-00072D-MU; Tue, 09 Sep 2025 22:38:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uwAif-00071G-Ca
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 22:38:01 -0400
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uwAiO-0005ey-GM
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 22:38:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1757471864; x=1789007864;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=OTgM5lLfLfET1p0LPSvqPExJgsnE2V1snvbGRXSSmsc=;
 b=UpQgwNJsjA3PUPGUatTahMxJibMGCDZGkQv5MxYTsa/6x1pMfO5U8GME
 8MsZnGtfH1eA/NtQhad8ksisaD10nPemhkDRYn/MESKM5nPzQTyH2fUpC
 r9Djnb0CaPgVJ6ksWvP71RiaTof8CGlz+d9/COyvh4nRcYQspU+unFzN9
 gQcC90SFBH0Uf2S3/JKu32KODMU0Uz7figAS3vT+u0O128M4AC/l4antG
 dGq6HungKSitCRE5UjtSzcS6lqGcAWT1+CAlLpk4Duemy+SRimgT9ly0v
 VCigFQzgwfpmY0FOf+gye59QY8pEQqNL+Gcs7/MdQJ2ZwfXKK9+pV3csW g==;
X-CSE-ConnectionGUID: lpPVf0YbQFq92C1WjuBIhw==
X-CSE-MsgGUID: 3t8pMvSCTOyiM6DYGSiMtw==
X-IronPort-AV: E=McAfee;i="6800,10657,11548"; a="62402781"
X-IronPort-AV: E=Sophos;i="6.18,253,1751266800"; d="scan'208";a="62402781"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Sep 2025 19:37:30 -0700
X-CSE-ConnectionGUID: seu6+7NXTUm29xulb4kA+g==
X-CSE-MsgGUID: 5HvNehR+QYS+ZjInKWfWUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,253,1751266800"; d="scan'208";a="196930547"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Sep 2025 19:37:27 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, mst@redhat.com,
 jasowang@redhat.com, yi.l.liu@intel.com, clement.mathieu--drif@eviden.com,
 eric.auger@redhat.com, joao.m.martins@oracle.com, avihaih@nvidia.com,
 xudong.hao@intel.com, giovanni.cabiddu@intel.com, mark.gross@intel.com,
 arjan.van.de.ven@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH 0/5] vfio: relax the vIOMMU check
Date: Tue,  9 Sep 2025 22:36:56 -0400
Message-ID: <20250910023701.244356-1-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.13;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Hi,

This series relax the vIOMMU check and allows live migration with vIOMMU
without VFs using device dirty tracking. It's rewritten based on first 4
patches of [1] from Joao.

Currently what block us is the lack of dirty bitmap query with iommufd
before unmap. By adding that query in patch2 plus an extra optimization
in patch3 that let us simply read the dirty bit (without clearing it),
then an optimization in patch4 to handle a corner case of domain switch
in guest, finally we relax the check in patch5.

We tested VM live migration (running QAT workload in VM) with QAT
device passthrough, below matrix configs:
1.Scalable mode vIOMMU + IOMMUFD cdev mode
2.Scalable mode vIOMMU + legacy VFIO mode
3.legacy mode vIOMMU + IOMMUFD cdev mode
4.legacy mode vIOMMU + legacy VFIO mode

[1] https://github.com/jpemartins/qemu/commits/vfio-migration-viommu/

Thanks
Zhenzhong

Zhenzhong Duan (5):
  vfio/iommufd: Add framework code to support getting dirty bitmap
    before unmap
  vfio/iommufd: Query dirty bitmap before DMA unmap
  vfio/iommufd: Add IOMMU_HWPT_GET_DIRTY_BITMAP_NO_CLEAR flag support
  intel_iommu: Optimize unmap_bitmap during migration
  vfio/migration: Allow live migration with vIOMMU without VFs using
    device dirty tracking

 hw/vfio/vfio-iommufd.h        |  1 +
 include/hw/vfio/vfio-device.h | 10 ++++++
 include/system/iommufd.h      |  2 +-
 backends/iommufd.c            |  5 +--
 hw/i386/intel_iommu.c         | 42 ++++++++++++++++++++++
 hw/vfio/container-base.c      |  5 +--
 hw/vfio/device.c              |  6 ++++
 hw/vfio/iommufd.c             | 66 +++++++++++++++++++++++++++++------
 hw/vfio/migration.c           |  6 ++--
 backends/trace-events         |  2 +-
 10 files changed, 123 insertions(+), 22 deletions(-)

-- 
2.47.1


