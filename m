Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6660ACCD195
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 09:37:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9gsu-0002T9-OV; Fri, 17 Oct 2025 05:36:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1v9gsq-0002SB-Os
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 05:36:24 -0400
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1v9gsk-0004xV-Lk
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 05:36:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760693778; x=1792229778;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=9O0xkH2h6BXqot+AuuIZ4FK/rZwOy3gk7OVLKGL0gXY=;
 b=fMUTthdVFcU9MF6fxekEGuRMI2E2A/sNKDo+7SEhhh+flbSRTNZ1ejtV
 RGvgitY+j2BlEScia4XGusa3ApOVTtsq0JiMymIXG6zkN2DqzKwcLQfRr
 31KwZak7lBfR6jH6VDVUZpc4J+UPRnGg5UPox16R9dHS+KWiHRPUoHcW+
 h/d3UwJZDIZ4nJH7HqAsjJh6JXzQ8KXrREOE/5rFnr3lxCBmXEa9fz/eo
 YJw+Acf9XWZHN9pYwwRPIGzz3qidmn7r875SdjQegWcnrwtUP/iVjjp/2
 MwXos1qlJFr4y8l3KPGgCvZRAirdKkZQfj1ilXtL0KMDNO1NDOhDdZIu5 w==;
X-CSE-ConnectionGUID: gRVsejkuSSihs7wPCo8lGA==
X-CSE-MsgGUID: W5/hnWB6SFCRFeDXYXbQGg==
X-IronPort-AV: E=McAfee;i="6800,10657,11584"; a="62805635"
X-IronPort-AV: E=Sophos;i="6.19,236,1754982000"; d="scan'208";a="62805635"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Oct 2025 02:36:11 -0700
X-CSE-ConnectionGUID: 3oTxQ8hEQ1qkkUJX6BQLeA==
X-CSE-MsgGUID: +TwTfL9DT/+dc+TDeq6TpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,236,1754982000"; d="scan'208";a="186720546"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Oct 2025 02:36:10 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, jasowang@redhat.com, peterx@redhat.com, yi.l.liu@intel.com,
 clement.mathieu--drif@eviden.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v3 0/3] Fix DMA failure when there is domain switch in guest
Date: Fri, 17 Oct 2025 05:35:59 -0400
Message-ID: <20251017093602.525338-1-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.17;
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

This fixes an DMA failure issue in guest when user switch domain
manually. E.g., echo [DMA|identity] > /sys/kernel/iommu_groups/6/type

First two patches come from [PATCH v6 00/22] intel_iommu: Enable first stage translation for passthrough device
which added basic support for pasid cache invalidation, the 3rd patch
add a fix.

Test:
both vhost network card and VFIO device,
guest config with and without iommu=pt,
switch domain with echo [DMA|identity] > /sys/kernel/iommu_groups/6/type,
ping test under different domain

Thanks
Zhenzhong

Changelog:
v3:
- compare pasid entry with pasid cache before as switch and sync (Liuyi)

v2:
- drop extract64 usage in patch1 (Liuyi)
- update DID check logic (Liuyi)
- refactor comments (Liuyi)
- rewrite patch2 with simpler code
- bypass vtd_address_space_sync() when pasid entry is invalid

Zhenzhong Duan (3):
  intel_iommu: Handle PASID cache invalidation
  intel_iommu: Reset pasid cache when system level reset
  intel_iommu: Fix DMA failure when guest switches IOMMU domain

 hw/i386/intel_iommu_internal.h |  17 +++
 include/hw/i386/intel_iommu.h  |   6 ++
 hw/i386/intel_iommu.c          | 182 +++++++++++++++++++++++++++++++--
 hw/i386/trace-events           |   4 +
 4 files changed, 199 insertions(+), 10 deletions(-)

-- 
2.47.1


