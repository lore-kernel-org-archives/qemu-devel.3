Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE5DAC54E41
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 09:47:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfGWc-0005Aq-Q4; Wed, 28 Feb 2024 04:46:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rfGWW-00056t-T4
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 04:46:49 -0500
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rfGWT-00029T-Bd
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 04:46:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1709113605; x=1740649605;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=Sz9m7Bft6jTYzp3wkTyr6eMhrYRoxqCKul3DslJXftc=;
 b=EtMULPRn5rQKX5uuj+IhG3gChx+VCejwfEdkyuh7TE1nRDprAZbUBEmD
 jaWDZe53BLvRMcUZdpbvAF3RfW3M/cPxkQvXzJARSTzrGu/8UzmtXuc9q
 AEQA1BCmSxfnV0j+lUcs78mWPypGX6LukYVGy4TEDJbVImumCTExbSgZJ
 Cxpa/3Qf42PLL57b0QyPyytZpibW+gOeUVK5JNt+XOXLngsVTSg8NAwtq
 YX0PvoXqv4xBxcUzeYFLTAfctdJvoZ/c5sebgxEPmMu5mVO6EWAXzGQvU
 0Rk/bJh3W04eJ4jyrFc2L3OJ+xVOQWmbjiDc18YJ35VfFzLrQxVKBDuEZ w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="25969956"
X-IronPort-AV: E=Sophos;i="6.06,190,1705392000"; d="scan'208";a="25969956"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Feb 2024 01:46:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,190,1705392000"; 
   d="scan'208";a="7809907"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.124])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Feb 2024 01:46:38 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, mst@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, yi.y.sun@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v1 0/6] Check and sync host IOMMU cap/ecap with vIOMMU
Date: Wed, 28 Feb 2024 17:44:26 +0800
Message-Id: <20240228094432.1092748-1-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.9;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Based on Joao's suggestion, the iommufd nesting prerequisite series [1]
is further splitted to host IOMMU device abstract part [2] and vIOMMU
check/sync part. This series implements the 2nd part.

This enables vIOMMU to get host IOMMU cap/ecap information by implementing
a new set/unset_iommu_device interface, then vIOMMU could check or sync
with vIOMMU's own cap/ecap config.

It works by having device side, i.e. VFIO, register either an IOMMULegacyDevice
or IOMMUFDDevice to vIOMMU, which includes necessary data to archive that.
Currently only VFIO device is supported, but it could also be used for other
devices, i.e., VDPA.

For coldplugged device, we can get its host IOMMU cap/ecap during qemu init,
then check and sync into vIOMMU cap/ecap.
For hotplugged device, vIOMMU cap/ecap is frozen, we could only check with
vIOMMU cap/ecap, not allowed to update. If check fails, hotplugged will fail.

This is also a prerequisite for incoming iommufd nesting series:
'intel_iommu: Enable stage-1 translation'.

I didn't implement cap/ecap sync for legacy VFIO backend, would like to see
what Eric want to put in IOMMULegacyDevice for virtio-iommu and if I can
utilize some of them.

Because it's becoming clear on community's suggestion, I'd like to remove
rfc tag from this version.

Qemu code can be found at:
https://github.com/yiliu1765/qemu/tree/zhenzhong/iommufd_nesting_preq_part2_v1

[1] https://lore.kernel.org/qemu-devel/20240201072818.327930-1-zhenzhong.duan@intel.com
[2] https://lists.gnu.org/archive/html/qemu-devel/2024-02/msg06314.html

Thanks
Zhenzhong

Changelog:
v1:
- convert HostIOMMUDevice to sub object pointer in vtd_check_hdev

rfcv2:
- introduce common abstract HostIOMMUDevice and sub struct for different BEs (Eric, Cédric)
- remove iommufd_device.[ch] (Cédric)
- remove duplicate iommufd/devid define from VFIODevice (Eric)
- drop the p in aliased_pbus and aliased_pdevfn (Eric)
- assert devfn and iommu_bus in pci_device_get_iommu_bus_devfn (Cédric, Eric)
- use errp in iommufd_device_get_info (Eric)
- split and simplify cap/ecap check/sync code in intel_iommu.c (Cédric)
- move VTDHostIOMMUDevice declaration to intel_iommu_internal.h (Cédric)
- make '(vtd->cap_reg >> 16) & 0x3fULL' a MACRO and add missed '+1' (Cédric)
- block migration if vIOMMU cap/ecap updated based on host IOMMU cap/ecap
- add R-B


Yi Liu (2):
  intel_iommu: Add set/unset_iommu_device callback
  intel_iommu: Add a framework to check and sync host IOMMU cap/ecap

Zhenzhong Duan (4):
  intel_iommu: Extract out vtd_cap_init to initialize cap/ecap
  intel_iommu: Implement check and sync mechanism in iommufd mode
  intel_iommu: Use mgaw instead of s->aw_bits
  intel_iommu: Block migration if cap is updated

 hw/i386/intel_iommu_internal.h |   9 ++
 include/hw/i386/intel_iommu.h  |   4 +
 hw/i386/acpi-build.c           |   3 +-
 hw/i386/intel_iommu.c          | 287 ++++++++++++++++++++++++++-------
 4 files changed, 245 insertions(+), 58 deletions(-)

-- 
2.34.1


