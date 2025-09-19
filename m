Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19748CAC5A5
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 07:08:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzVD1-0000Ju-ST; Fri, 19 Sep 2025 03:07:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uzVCz-0000Ji-FU
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 03:07:05 -0400
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uzVCx-0004Ny-7c
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 03:07:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758265623; x=1789801623;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=xtiUjVEaStWtrN2H3xtifqwcVUXGa2m0sLWRLbFg1/c=;
 b=lfzVhtYn73hxUNxwaYhP70zWUSnigBZwuaz+anZjukyrA5ptVHeVOBhZ
 KurGNgeR1EK8udzyuUvW8gdFVzdUahdjT8GYaa2TdzD4IdHQmdmF6hAIL
 YwU76JG1wqs73mYJiCLuCMFQ5BNmYiVhI26yQqy4oxqlBuDgUGDqlJd6W
 GQYbuUVTy9041mKMQ0iAO2pUhatiyhvPvo7uJ3So1mLvTRJbqmUMFTub7
 PaxOtF99Ugj1TKy3PUaxf89ayIU7D5ptuptrgUiwRvyYdSDTrd+1+qYHK
 kwm35xO1a+9IwGQ3DnAB1CR7VEFcjn7iexHDKZBaUHLz7aGVTGHz4hOIg w==;
X-CSE-ConnectionGUID: xfAkkroySxOdy6HhZRKN9Q==
X-CSE-MsgGUID: trvBNiY7RBSM5nh+KKMUxg==
X-IronPort-AV: E=McAfee;i="6800,10657,11557"; a="60304401"
X-IronPort-AV: E=Sophos;i="6.18,277,1751266800"; d="scan'208";a="60304401"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Sep 2025 00:06:57 -0700
X-CSE-ConnectionGUID: cKKFsbV7ROqRZOQeABWF6g==
X-CSE-MsgGUID: tN0hkEwVSkmmg1eFuV/cjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,277,1751266800"; d="scan'208";a="175584352"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Sep 2025 00:06:55 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, jasowang@redhat.com, peterx@redhat.com, yi.l.liu@intel.com,
 clement.mathieu--drif@eviden.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH 0/2] Enable ESRTPS and simplify caching-mode=on check
Date: Fri, 19 Sep 2025 03:06:36 -0400
Message-ID: <20250919070638.983549-1-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.20;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.005,
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

Hi

Patch1 enable ESRTPS to avoid three global invalidation request in guest
kernel.
Patch2 rework caching mode check with simpler code.

Thanks
Zhenzhong

Zhenzhong Duan (2):
  intel_iommu: Enable Enhanced Set Root Table Pointer Support (ESRTPS)
  intel_iommu: Simplify caching mode check with VFIO device

 hw/i386/intel_iommu_internal.h |  1 +
 hw/i386/intel_iommu.c          | 49 +++++-----------------------------
 hw/i386/pc.c                   | 20 --------------
 3 files changed, 8 insertions(+), 62 deletions(-)

-- 
2.47.1


