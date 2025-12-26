Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81417E8FDA1
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Dec 2025 08:03:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZ2mk-0008TE-DQ; Fri, 26 Dec 2025 03:02:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vZ2ma-0008Qs-Nw
 for qemu-devel@nongnu.org; Fri, 26 Dec 2025 03:02:46 -0500
Received: from mgamail.intel.com ([198.175.65.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vZ2mY-0005D0-Af
 for qemu-devel@nongnu.org; Fri, 26 Dec 2025 03:02:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1766736163; x=1798272163;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=H7ot/hRp81HthlDYk6TwFqV3Z6FYhPOKwVbR85Mr8Gk=;
 b=Da/XwrlmMyk6F+CA1mL+GUyburajFHGb5670GLUbFUfL+jjSJ30vPdd7
 G070Ac7o0H6Qc/DHjlcpFgdC4rpEPvSTAT4sv+/nhUEoFXyl8jApbhFQg
 YE9w2uPhJiuAGhe9UO42T1Ng7RlJnDQGky3Wsc5JY6Un1Wxe1UEQkpv6W
 da5jlff0Vl8uzdaU3XPgFdCo5JqU/KNdPL3oScqNye5MIOhWLPSTTLYHa
 ehrhcGPc5zLCQOZHJoG516mR7mOAYYnICFaFAk43JWvRAcbZPOxrmHvyJ
 OaC6ozdLu2B626M/EjomXZbUbNZDJ1/AOO2LvIJqhrP7TpprLClUP6PVP A==;
X-CSE-ConnectionGUID: NKASdE7YQ72uV8MXSnAVag==
X-CSE-MsgGUID: kwB/Dpk/QfyldGp9D7RiQg==
X-IronPort-AV: E=McAfee;i="6800,10657,11652"; a="68392814"
X-IronPort-AV: E=Sophos;i="6.21,177,1763452800"; d="scan'208";a="68392814"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Dec 2025 00:02:39 -0800
X-CSE-ConnectionGUID: /8As4clwTrqCVnrBiyl/dg==
X-CSE-MsgGUID: 1XbQAyDwS2+4a6RXAf1t+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,177,1763452800"; d="scan'208";a="204846799"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Dec 2025 00:02:34 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex@shazbot.org, clg@redhat.com, eric.auger@redhat.com, mst@redhat.com,
 jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, skolothumtho@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v9 0/4] Implement ERRATA_772415 quirk for VTD
Date: Fri, 26 Dec 2025 03:02:22 -0500
Message-ID: <20251226080227.1167993-1-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.19;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Based on Cédric's suggestions[1], The nesting series v8 is split to
"base nesting series" + "ERRATA_772415_SPR17 quirk series", this is the
ERRATA_772415_SPR17 quirk series.

On a system influenced by ERRATA_772415, IOMMU_HW_INFO_VTD_ERRATA_772415_SPR17
is repored by IOMMU_DEVICE_GET_HW_INFO. Due to this errata, even the readonly
range mapped on second stage page table could still be written.

Reference from 4th Gen Intel Xeon Processor Scalable Family Specification
Update, Errata Details, SPR17.
Link https://edc.intel.com/content/www/us/en/design/products-and-solutions/processors-and-chipsets/eagle-stream/sapphire-rapids-specification-update/
Backup link https://cdrdv2.intel.com/v1/dl/getContent/772415

Also copied the SPR17 details from above link:
"Problem: When remapping hardware is configured by system software in
scalable mode as Nested (PGTT=011b) and with PWSNP field Set in the
PASID-table-entry, it may Set Accessed bit and Dirty bit (and Extended
Access bit if enabled) in first-stage page-table entries even when
second-stage mappings indicate that corresponding first-stage page-table
is Read-Only.

Implication: Due to this erratum, pages mapped as Read-only in second-stage
page-tables may be modified by remapping hardware Access/Dirty bit updates.

Workaround: None identified. System software enabling nested translations
for a VM should ensure that there are no read-only pages in the
corresponding second-stage mappings."

QEMU code can be found at [2], it's based after below two series:

[PATCH v9 00/19] intel_iommu: Enable first stage translation for passthrough device
[PATCH v6 0/9] vfio: relax the vIOMMU check

Thanks
Zhenzhong

Changelog:
This is a new split from nesting series, see the link[2] for history changelog.

[1] https://lore.kernel.org/qemu-devel/bbc8412b-25c3-4c95-9fde-a1c9c29b54ce@redhat.com/
[2] https://github.com/yiliu1765/qemu/tree/zhenzhong/iommufd_nesting_ERRATA_772415.v9


Zhenzhong Duan (4):
  hw/pci: Introduce pci_device_get_host_iommu_quirks()
  intel_iommu_accel: Implement get_host_iommu_quirks() callback
  vfio/listener: Bypass readonly region for dirty tracking
  Workaround for ERRATA_772415_SPR17

 docs/devel/vfio-iommufd.rst      |  9 ++++++
 hw/i386/intel_iommu_accel.h      |  5 ++++
 include/hw/iommu.h               |  5 ++++
 include/hw/pci/pci.h             | 31 ++++++++++++++++++++
 include/hw/vfio/vfio-container.h |  1 +
 include/hw/vfio/vfio-device.h    |  3 ++
 hw/i386/intel_iommu.c            |  2 ++
 hw/i386/intel_iommu_accel.c      | 21 ++++++++++++++
 hw/pci/pci.c                     | 12 ++++++++
 hw/vfio/device.c                 | 14 +++++++++
 hw/vfio/iommufd.c                |  9 +++++-
 hw/vfio/listener.c               | 50 +++++++++++++++++++++++++-------
 hw/vfio/trace-events             |  1 +
 13 files changed, 151 insertions(+), 12 deletions(-)

-- 
2.47.1


