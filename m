Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0375AC52D7F
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2024 07:16:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1se8Ew-00061N-Bg; Wed, 14 Aug 2024 03:16:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1se8Eu-0005u2-GF
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 03:16:12 -0400
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1se8Eo-0001C4-Fs
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 03:16:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1723619766; x=1755155766;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=G7xk2tIGXUAjilQDG21M0cUROKnjbVgy+pc1+6MJN58=;
 b=chK4lx4fa3DiSgymSnnsIbbGDC9hm51LCbBZqd9k8C1IbYVJPFdlY/pW
 MTkiwR7kSlNdJutB0UFN4Y7zDmXOEUCx3WbyS9W7Ihn4Q+wqANhj10zW3
 uoFeOtnNP2SvGnLsFkbprcyRhQWDi5UEshw/uihtHTKUQDN1D+1G+cO3t
 49t+golMOlvxdhKAznwCTjv702dYmEnk3dfNVY3yuzW+zvbpn2N/7YI3/
 6U7FPDEqOmX/gHOGlzsJ2jofZzS2noR3kgmJBNw5rpyNWCGUacBY3Pm5Z
 ZHmfknbCPm5D3kxYQruN5mVwru21jqX/vaxTyzWRkhrDJeDDpcazN747O Q==;
X-CSE-ConnectionGUID: fgF8MKjXTKWetArzPr5eow==
X-CSE-MsgGUID: VkEZOHFHTHykpfJwFSeKMw==
X-IronPort-AV: E=McAfee;i="6700,10204,11163"; a="32443616"
X-IronPort-AV: E=Sophos;i="6.09,288,1716274800"; d="scan'208";a="32443616"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Aug 2024 00:16:02 -0700
X-CSE-ConnectionGUID: MlBbCOy7TMmW80miirW95w==
X-CSE-MsgGUID: H9WoNAUWREGsHTjyGIW6FA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,288,1716274800"; d="scan'208";a="63326628"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
 by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Aug 2024 00:16:00 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, jasowang@redhat.com, yi.l.liu@intel.com,
 clement.mathieu--drif@eviden.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v4 0/2] intel_iommu minor fixes
Date: Wed, 14 Aug 2024 15:13:18 +0800
Message-Id: <20240814071321.2621384-1-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.11;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Hi

Fixes two minor issues in intel iommu.
See patch for details.

Tested scalable mode and legacy mode with vfio device passthrough: PASS
Tested intel-iommu.flat in kvm-unit-test: PASS

Thanks
Zhenzhong

Changelog:
v4:
- Use 12 bytes commit id in fix tag (Liu Yi)

v3:
- add fix tag (Liu Yi)
- collect R-B

v2:
- s/take/taking/ (Liu Yi)
- add patch2 (Liu Yi)

Zhenzhong Duan (2):
  intel_iommu: Fix invalidation descriptor type field
  intel_iommu: Make PASID-cache and PIOTLB type invalid in legacy mode

 hw/i386/intel_iommu_internal.h | 11 ++++++-----
 hw/i386/intel_iommu.c          | 24 ++++++++++++------------
 2 files changed, 18 insertions(+), 17 deletions(-)

-- 
2.34.1


