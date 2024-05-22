Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7AEAC25B77
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 06:26:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9fQJ-0004Ws-OB; Wed, 22 May 2024 02:26:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s9fQ9-0004Ow-NT
 for qemu-devel@nongnu.org; Wed, 22 May 2024 02:25:57 -0400
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s9fQ7-0006eK-Ab
 for qemu-devel@nongnu.org; Wed, 22 May 2024 02:25:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1716359151; x=1747895151;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=VSJuw36TvKq0rhL9Q+gF2BhCS2uvG1kGl6zZF9znwlc=;
 b=dGn2sJv5guF1nuZ9RclmcTK2CqotZ+AncD4cMoMQ3g6uCVf9NQhsczz3
 bPaQWo3sB23mz2CIVNrSYc9fg6maY1nKVCE8+ZFqHDLuiXWw9yysuWK0t
 wy36vleXDRQ+TBgC1UJj1446hiJkye49enh5jziuu5MSNnO9VEnxbQAE1
 U2r9SaR8b8qy6C3bSH44AeWkzNoJfTJJKL0FdZG3+A/XsCVYybSdCxnHq
 q74MmwIbBa5BNZyb7ml2GUmlHHVleg9nT2b7JjpKtzyja751e/rnv9uri
 Nqt+eshNOtNGIZhSZyiFmMusKQKn+rPyq4G1pUErL3UWhnXY3nT6Z3UU8 A==;
X-CSE-ConnectionGUID: 5GEhC8DBTx65s6lyxpBgRg==
X-CSE-MsgGUID: sQfAJ3F+QiGG6zC5S9VftA==
X-IronPort-AV: E=McAfee;i="6600,9927,11079"; a="37972429"
X-IronPort-AV: E=Sophos;i="6.08,179,1712646000"; d="scan'208";a="37972429"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2024 23:25:49 -0700
X-CSE-ConnectionGUID: c2PghwpKQX66aGtd4n0ieg==
X-CSE-MsgGUID: OBccolLpSeGoIBBWq+EFEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,179,1712646000"; d="scan'208";a="33597541"
Received: from unknown (HELO SPR-S2600BT.bj.intel.com) ([10.240.192.124])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2024 23:25:45 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, peterx@redhat.com, jasowang@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH rfcv2 00/17] intel_iommu: Enable stage-1 translation for
 emulated device
Date: Wed, 22 May 2024 14:22:56 +0800
Message-Id: <20240522062313.453317-1-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.7;
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
PATCH15:   Set default aw_bits to 48 in scalable modren mode
PATCH16:   Introduce "modern" mode to distinguish with legacy mode
PATCH17:   Add qtest

Qemu code can be found at [2]

[1] https://lists.gnu.org/archive/html/qemu-devel/2024-01/msg02740.html
[2] https://github.com/yiliu1765/qemu/tree/zhenzhong/iommufd_stage1_emu_rfcv2

Thanks
Zhenzhong

Changelog:
v2:
- split from nesting series (Jason)
- merged some commits from Clement
- add qtest (jason)

Clément Mathieu--Drif (5):
  intel_iommu: check if the input address is canonical
  intel_iommu: set accessed and dirty bits during first stage
    translation
  intel_iommu: Extract device IOTLB invalidation logic
  intel_iommu: add an internal API to find an address space with PASID
  intel_iommu: add support for PASID-based device IOTLB invalidation

Yi Liu (3):
  intel_iommu: Rename slpte to pte
  intel_iommu: Implement stage-1 translation
  intel_iommu: Modify x-scalable-mode to be string option

Yu Zhang (1):
  intel_iommu: Update version to 3.0 and add the latest fault reasons

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
 hw/i386/intel_iommu_internal.h |  60 +++-
 include/hw/i386/intel_iommu.h  |   5 +-
 hw/i386/intel_iommu.c          | 639 ++++++++++++++++++++++++++++-----
 tests/qtest/intel-iommu-test.c |  63 ++++
 tests/qtest/meson.build        |   1 +
 6 files changed, 676 insertions(+), 93 deletions(-)
 create mode 100644 tests/qtest/intel-iommu-test.c

-- 
2.34.1


