Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBA95C3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 08:21:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUMMM-0006I8-Sc; Thu, 18 Jul 2024 04:19:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sUMMK-0006HZ-KG
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 04:19:28 -0400
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sUMMG-0008A9-Ji
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 04:19:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1721290765; x=1752826765;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=XI7GRNFDIFpt10S6pE0W79/hV9U0lqLchs2RSULRrG0=;
 b=HbPTxtiI274ebJYcZmtSqiRfChfkSFy+88IcLxsgJIhIE3yEEvX48CC5
 cuoEobzUnXSnyS2Xf4pHm3qsm6zYpB+/rjQdLs69RqDCDwiK1un6JkK8C
 N/7hx8AZoRRbWMMsI/OjKvZcoDhFXBe94NaYXSd5JOvNZSKcfJVJ5i8Wb
 ITinv/RJkU81cea9P1KTFIT1A1XfaW7cIQCmVrrGiUikhLW8KU16FzGJl
 Z9ump0TY+MFm2qtGD3sb4KhBVWqZne1M5YWJupIrDPnxuKzGNgov4SlS9
 uIPVAhkvEtgSiCbRgxA4fbpVVar2HqJ9iOqC3UTwnE+9OM+WnVs++Kb0B A==;
X-CSE-ConnectionGUID: 9ge6GFAaT6SSQN3wsFrhuQ==
X-CSE-MsgGUID: mszPbl5LQmWwQlaGKMPgXg==
X-IronPort-AV: E=McAfee;i="6700,10204,11136"; a="29996104"
X-IronPort-AV: E=Sophos;i="6.09,217,1716274800"; d="scan'208";a="29996104"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jul 2024 01:19:20 -0700
X-CSE-ConnectionGUID: YqYLY0q/TtSMlEBzhJwjOw==
X-CSE-MsgGUID: +zlsn3bYQpGrjFCqyNqrhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,217,1716274800"; d="scan'208";a="81717038"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jul 2024 01:19:17 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, peterx@redhat.com, jasowang@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v1 00/17] intel_iommu: Enable stage-1 translation for emulated
 device
Date: Thu, 18 Jul 2024 16:16:19 +0800
Message-Id: <20240718081636.879544-1-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.13;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Hi,

Per Jason Wang's suggestion, iommufd nesting series[1] is split into
"Enable stage-1 translation for emulated device" series and
"Enable stage-1 translation for passthrough device" series.

This series enables stage-1 translation support for emulated device
in intel iommu which we called "modern" mode.

PATCH1-5:  Some preparing work before support stage-1 translation
PATCH6-8:  Implement stage-1 translation for emulated device
PATCH9-14: Emulate iotlb invalidation of stage-1 mapping
PATCH15:   Set default aw_bits to 48 in scalable modern mode
PATCH16:   Introduce "modern" mode to distinguish with legacy mode
PATCH17:   Add qtest

Note in spec revision 3.4, it renames "First-level" to "First-stage",
"Second-level" to "Second-stage". But the scalable mode was added
before that change. So we keep old favor using First-level/fl/Second-level/sl
in code but change to use stage-1/stage-2 in commit log.
But keep in mind First-level/fl/stage-1 all have same meaning,
same for Second-level/sl/stage-2.

Qemu code can be found at [2]

[1] https://lists.gnu.org/archive/html/qemu-devel/2024-01/msg02740.html
[2] https://github.com/yiliu1765/qemu/tree/zhenzhong/iommufd_stage1_emu_v1

Thanks
Zhenzhong

Changelog:
v1:
- define VTD_HOST_AW_AUTO (Clement)
- passing pgtt as a parameter to vtd_update_iotlb (Clement)
- prefix sl_/fl_ to second/first level specific functions (Clement)
- pick reserved bit check from Clement, add his Co-developed-by
- Update test without using libqtest-single.h (Thomas)

rfcv2:
- split from nesting series (Jason)
- merged some commits from Clement
- add qtest (jason)

Clément Mathieu--Drif (5):
  intel_iommu: Check if the input address is canonical
  intel_iommu: Set accessed and dirty bits during first stage
    translation
  intel_iommu: Extract device IOTLB invalidation logic
  intel_iommu: Add an internal API to find an address space with PASID
  intel_iommu: Add support for PASID-based device IOTLB invalidation

Yi Liu (3):
  intel_iommu: Rename slpte to pte
  intel_iommu: Implement stage-1 translation
  intel_iommu: Modify x-scalable-mode to be string option

Yu Zhang (1):
  intel_iommu: Use the latest fault reasons defined by spec

Zhenzhong Duan (8):
  intel_iommu: Make pasid entry type check accurate
  intel_iommu: Add a placeholder variable for scalable modern mode
  intel_iommu: Flush stage-2 cache in PADID-selective PASID-based iotlb
    invalidation
  intel_iommu: Flush stage-1 cache in iotlb invalidation
  intel_iommu: Process PASID-based iotlb invalidation
  intel_iommu: piotlb invalidation should notify unmap
  intel_iommu: Set default aw_bits to 48 in scalable modren mode
  tests/qtest: Add intel-iommu test

 MAINTAINERS                    |   1 +
 hw/i386/intel_iommu_internal.h |  90 +++-
 include/hw/i386/intel_iommu.h  |   8 +-
 hw/i386/intel_iommu.c          | 742 +++++++++++++++++++++++++++------
 tests/qtest/intel-iommu-test.c |  71 ++++
 tests/qtest/meson.build        |   1 +
 6 files changed, 764 insertions(+), 149 deletions(-)
 create mode 100644 tests/qtest/intel-iommu-test.c

-- 
2.34.1


