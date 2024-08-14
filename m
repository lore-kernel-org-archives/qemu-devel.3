Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E26F3C52D7B
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2024 02:30:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1se3m0-0001lZ-PA; Tue, 13 Aug 2024 22:30:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1se3ly-0001js-Ja
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 22:30:02 -0400
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1se3lw-0001Io-TP
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 22:30:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1723602601; x=1755138601;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=CSjv0yN5RKXLY+T7hJ21POJicIU3yJ7BJl67jO6IcQA=;
 b=VKOvi7o5e1r5Hpc334wJ45eEjD4Opbua24GpNofcrNCR+P0lU53fkf7l
 xuqvdDcR/wcRYMdu9gTFg4keO5DdB0DE055222w+LDDAF/tkgz/ix+e3y
 ydYYTL7BGK7in4MnQPXwQhRtD2XSp5AJE2UVr90K96NWHcrVDHEUbPpeU
 PnrxGZvfbwcMVC4PMp+tSx5Ew9pPtPCnGRF67MGTDnIlS02EUgKFGui3X
 K+uZCbDxw/NCjMhxreOy4ZD7EsedbT7Qfww1EZeFUd7EQrYnJOcmvYpoi
 +EaIeOHbHeF+W2V2m43A+AO5uKisBaVJB3L8A2hxbBPq3qy+9uocL6pBT A==;
X-CSE-ConnectionGUID: JLCaJZhPQUW1bnzR/UzRvQ==
X-CSE-MsgGUID: GNz4PwvqQZu5BcBLcYKqFg==
X-IronPort-AV: E=McAfee;i="6700,10204,11163"; a="21940419"
X-IronPort-AV: E=Sophos;i="6.09,287,1716274800"; d="scan'208";a="21940419"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Aug 2024 19:29:55 -0700
X-CSE-ConnectionGUID: WUTPcn7gQoigxowPI6aFww==
X-CSE-MsgGUID: lxcVsDO2QG6xSLmmKQ8zQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,287,1716274800"; d="scan'208";a="58737173"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
 by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Aug 2024 19:29:54 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: chao.p.peng@intel.com,
	Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v3 0/2] intel_iommu minor fixes
Date: Wed, 14 Aug 2024 10:26:51 +0800
Message-Id: <20240814022654.2612780-1-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.16;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Hi

Fixes two minor issues in intel iommu.
See patch for details.

Tested scalable mode and legacy mode with vfio device passthrough: PASS
Tested intel-iommu.flat in kvm-unit-test: PASS

Thanks
Zhenzhong

v3:
- add fix tag (Liu Yi)
- collect R-B

Zhenzhong Duan (2):
  intel_iommu: Fix invalidation descriptor type field
  intel_iommu: Make PASID-cache and PIOTLB type invalid in legacy mode

 hw/i386/intel_iommu_internal.h | 11 ++++++-----
 hw/i386/intel_iommu.c          | 24 ++++++++++++------------
 2 files changed, 18 insertions(+), 17 deletions(-)

-- 
2.34.1


