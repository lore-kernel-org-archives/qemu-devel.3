Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 553F2D132BE
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 13:00:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7wg2-0005uF-I9; Mon, 04 Nov 2024 07:59:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1t7wfo-0005oY-SU
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 07:59:15 -0500
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1t7wfk-0004hy-Vd
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 07:59:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730725149; x=1762261149;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=fcgmAOMXw6BRCR893q21KprbTvQ9G/wA28dUHeQ2vqY=;
 b=If+RDdYVdFbZeWxAEOOsM8KnXMBWCd5Y0+uh565L2lz5a91BM3X5flWP
 hUhU60juzouqijxxjsZgfzLckynd1pegPRf2AV11eo6OcrFCg3yz8BQ53
 dQ85kpF/xywvdktwHN53q8uBV/aSO5EmFBbJyceWW0A5I/a1Nkfj/Yav5
 X+A82gd62Ae8m4TiKyfy5swOoxWHqe/7wQLksCMeRhyyUvQoeMU06S3nc
 WKGR2nO9CHGNpvE+/JOl2xbsKn39Hm/tD7qup/avhClL+dpbAPmCAmiL+
 +fwE2uTcr+0ezcCICE+ygSWvs3dszVmpM5JCknGdCeTp3aUMkMoEkpc3v Q==;
X-CSE-ConnectionGUID: xH7Z7VEUQL+I+6jybo8ajQ==
X-CSE-MsgGUID: vw9lWQXoTTq76lY/H7tNgg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="41524637"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="41524637"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2024 04:59:04 -0800
X-CSE-ConnectionGUID: bV3b1gMDT6mBsTR2fRYaTg==
X-CSE-MsgGUID: dsiGkyoiTv6GWww2tWk7yA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,257,1725346800"; d="scan'208";a="84465172"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
 by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2024 04:59:02 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, jasowang@redhat.com, yi.l.liu@intel.com,
 clement.mathieu--drif@eviden.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH 0/3] intel_iommu: Add missed sanity check for invalidae
 descriptor
Date: Mon,  4 Nov 2024 20:55:33 +0800
Message-Id: <20241104125536.1236118-1-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.13;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
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

This adds missed sanity check when IQ size is 256-bit per Yi's suggestion,
see patch for details.

I don't add check for VTD_INV_DESC_PC and VTD_INV_DESC_PIOTLB, will do it
in "intel_iommu: Enable stage-1 translation for emulated device" series.

Thanks
Zhenzhong

Zhenzhong Duan (3):
  intel_iommu: Send IQE event when setting reserved bit in IQT_TAIL
  intel_iommu: Add missed sanity check for 256-bit invalidation queue
  intel_iommu: Add missed reserved bit check for IEC descriptor

 hw/i386/intel_iommu_internal.h |  4 ++
 hw/i386/intel_iommu.c          | 89 +++++++++++++++++++++++++---------
 2 files changed, 71 insertions(+), 22 deletions(-)

-- 
2.34.1


