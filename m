Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67831C531DC
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2024 08:04:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1se8xx-0002KA-MM; Wed, 14 Aug 2024 04:02:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1se8xv-0002I3-GW
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 04:02:43 -0400
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1se8xp-0007rt-9p
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 04:02:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1723622558; x=1755158558;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=Pc6v8vQDyhFUnCnaUpnKF0TGvteOoZKGCnvSfBFYwhY=;
 b=gfje2xDSK2r2w4SMfqwkoOVpk8+W/YNRVMIlOzTOOyPhNMstzfOrEULN
 nH+2a2wGd0PNFoy27Ybfm2k0R2d1QJXWhgWE1bsT9mLUHfYjNbW0nhx3P
 HV6PXMMIqu1tekUhTIGeg7vSbOx7ahjHo8Cb7KWLdJIrc6nv3vo+UFiDf
 XfovumuahV2bwfTKeQtZ26wDJwv4tANX93DNe9frVbIrtVd7FLdc4b9V/
 Qj3qXG6i1UKcq7kUZ3q7doEQfGAA8ZC1TqleCQecfQzNP91mhrowtnTuF
 sasE7getyxsm8XMMSEQrnUOYz9+gVZyBPRtFifjtZyM3TQjEN+/z3rzHZ A==;
X-CSE-ConnectionGUID: EIXD9JUBTZmZm+6zrnC+aA==
X-CSE-MsgGUID: s7pPiFE2Tu+ctaCvLCdaTQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11163"; a="25584449"
X-IronPort-AV: E=Sophos;i="6.09,288,1716274800"; d="scan'208";a="25584449"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Aug 2024 01:02:33 -0700
X-CSE-ConnectionGUID: v9MCkPMnRlyoOxRBYN7Qxw==
X-CSE-MsgGUID: S4LG+NLlRsGaUmQVXgYh/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,288,1716274800"; d="scan'208";a="59048939"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by fmviesa010.fm.intel.com with ESMTP; 14 Aug 2024 01:02:31 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: qemu-devel@nongnu.org,
	kvm@vger.kernel.org,
	xiaoyao.li@intel.com
Subject: [PATCH 0/9] Misc patches for x86 CPUID
Date: Wed, 14 Aug 2024 03:54:22 -0400
Message-Id: <20240814075431.339209-1-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.15; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001, RCVD_IN_DNSWL_MED=-2.3,
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

This series is a misc collection of patches for x86 CPUID. It contains
patches to add support for new CPUID bit, to fix the construction of
some CPUID leaves, to not expose AMD defined bits on Intel guest, and to
make invtsc migratable contioned on user_tsc_khz.

All of them are found during TDX development and testing. However, they
issues they aim to address are not TDX specific and the patches are not
TDX specific.

Xiaoyao Li (9):
  i386/cpu: Don't construct a all-zero entry for CPUID[0xD 0x3f]
  i386/cpu: Enable fdp-excptn-only and zero-fcs-fds
  i386/cpu: Add support for bits in CPUID.7_2.EDX
  i386/cpu: Construct valid CPUID leaf 5 iff CPUID_EXT_MONITOR
  i386/cpu: Construct CPUID 2 as stateful iff times > 1
  i386/cpu: Set topology info in 0x80000008.ECX only for AMD CPUs
  i386/cpu: Suppress CPUID values not defined by Intel
  i386/cpu: Drop AMD alias bits in FEAT_8000_0001_EDX for non-AMD guests
  i386/cpu: Make invtsc migratable when user sets tsc-khz explicitly

 target/i386/cpu.c     | 50 ++++++++++++++++++++++++++++++-------------
 target/i386/cpu.h     |  4 ++++
 target/i386/kvm/kvm.c | 17 +++++++++------
 3 files changed, 49 insertions(+), 22 deletions(-)

-- 
2.34.1


