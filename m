Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4536C3ABB2
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 06:09:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uK9xO-0007Uk-OY; Wed, 28 May 2025 02:08:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uK9xN-0007UF-6K
 for qemu-devel@nongnu.org; Wed, 28 May 2025 02:08:05 -0400
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uK9xK-0000lT-8T
 for qemu-devel@nongnu.org; Wed, 28 May 2025 02:08:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748412483; x=1779948483;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=QQNY7Zmj/hAgVuMHUbKHogpM6GBKiUiPk4IwJ5nZIRs=;
 b=fpwTcMx8jLPKrQAabRPpahcQSn+0I2BRcn/ncbM4b2l4/iNzxZz9e3Ia
 tkCQlJv2z6BRDtsiSi8VPkmdK5d10halNQ2JIRGLGV8duFCuiFP6u/Y0l
 e4DEAo5Ygb3wOx2PEnbtcociT0opHVGZTfJfihDuAPKefhfN/dCQXor31
 DqmQkZeYtDmLqu5asUWb4XxMs2tVSXuwTDZt4vSxnH1slU/xDTsmvmGCL
 qoDCx5/gwhMaF5mk4vh9ez3FwRR/cXiwdtYROa6vem3xuHcFrkoImptDC
 lkoIcLspzE7nTXkQWPIFpimNRYv4sYqK5qgQfp9hBP4BzfgsAW+sNMBes w==;
X-CSE-ConnectionGUID: i4ZZDBj9QSq/5gkS0NRICA==
X-CSE-MsgGUID: VmITQ5JGQL+Pp1bFydmciQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11446"; a="60678950"
X-IronPort-AV: E=Sophos;i="6.15,320,1739865600"; d="scan'208";a="60678950"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 May 2025 23:07:59 -0700
X-CSE-ConnectionGUID: euYsKqzOStGCYQw2SckKzg==
X-CSE-MsgGUID: 7dzYej+XTtGkxjkZkJsZSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,320,1739865600"; d="scan'208";a="143164889"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
 by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 May 2025 23:07:54 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com,
 jgg@nvidia.com, nicolinc@nvidia.com, shameerali.kolothum.thodi@huawei.com,
 joao.m.martins@oracle.com, clement.mathieu--drif@eviden.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v1 0/6] VFIO and IOMMU prerequisite stuff for IOMMU nesting
 support
Date: Wed, 28 May 2025 14:04:03 +0800
Message-Id: <20250528060409.3710008-1-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.11;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -72
X-Spam_score: -7.3
X-Spam_bar: -------
X-Spam_report: (-7.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.907,
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

Hi,

The first 6 patches of [1] are all VFIO or IOMMUFD related additions.
Split them out per Cédric and seek for quick acceptance.

I didn't copy changelog from [1] as it's a mix of the whole nesting series.
Compared to rfcv3 in [1], changed to save raw data in VendorCaps, so we can
keep all vendor structure decoding inside the backend and VFIO wouldn't need
to care about types nor what's inside the data.


Test done:
- VFIO devices hotplug/unplug
- build test on Windows

[1] https://lists.gnu.org/archive/html/qemu-devel/2025-05/msg05002.html

Thanks
Zhenzhong

Zhenzhong Duan (6):
  backends/iommufd: Add a helper to invalidate user-managed HWPT
  vfio/iommufd: Add properties and handlers to
    TYPE_HOST_IOMMU_DEVICE_IOMMUFD
  vfio/iommufd: Initialize iommufd specific members in
    HostIOMMUDeviceIOMMUFD
  vfio/iommufd: Implement [at|de]tach_hwpt handlers
  vfio/iommufd: Save vendor specific device info
  iommufd: Implement query of host VTD IOMMU's capability

 hw/i386/intel_iommu_internal.h     |  1 +
 include/system/host_iommu_device.h | 18 ++++++
 include/system/iommufd.h           | 54 +++++++++++++++++
 backends/iommufd.c                 | 94 +++++++++++++++++++++++++++++-
 hw/vfio/iommufd.c                  | 36 ++++++++++--
 backends/trace-events              |  1 +
 6 files changed, 197 insertions(+), 7 deletions(-)

-- 
2.34.1


