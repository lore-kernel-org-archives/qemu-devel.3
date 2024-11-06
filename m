Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BA12D3E783
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 02:50:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8W7L-0006vr-A3; Tue, 05 Nov 2024 21:49:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t8W7K-0006vX-5w
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 21:49:58 -0500
Received: from mgamail.intel.com ([198.175.65.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t8W7G-0003MT-HT
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 21:49:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730861395; x=1762397395;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=7mHTbnUklJ/WxI1mhOHUVBJLHOP4R6PTTfU5+MgjIaU=;
 b=jG98tZ3ZpDSgSOG/r2MJUe8GwC9sNn3ndyIw/WCayJhox+8/v6oQs1d4
 y02bxnYTrGIhUpT5hisH+6yi7iO0ZbT7wZtEJuOezVAciPW3Eq0AEK9lb
 J4AWA7MGf+sK1sLrEbIhrBUMRBsCU0jbkahVFsOVosUjCqLDmCr/TMUiT
 FfkyorJlCgIgCu0/odDCisxNKPz6csM92UxS/V10k/v1Ul1ISC4JwJshX
 nmDbKoh95mbRP2fL+wLGe31uY71QHZJM5sDidB6fZBaYf8eOBCqAKRL0n
 8tIDER3kLVe+AJ02v+ZqCPBEDNIunpELmEVB2pqGTYGOjco15pHz/CV3P w==;
X-CSE-ConnectionGUID: t56yfEKrQ8m42BBvp+ql9g==
X-CSE-MsgGUID: OpCKjGDvQA+GW1zeNmRqxg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30492194"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="30492194"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2024 18:49:50 -0800
X-CSE-ConnectionGUID: K2/Uw2lRQueNgRX4yeYC/g==
X-CSE-MsgGUID: 4P0vK2jrQ3Or/fH5RjinCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,261,1725346800"; d="scan'208";a="115077968"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa001.fm.intel.com with ESMTP; 05 Nov 2024 18:49:46 -0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Tao Su <tao1.su@linux.intel.com>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, Pankaj Gupta <pankaj.gupta@amd.com>,
 Zide Chen <zide.chen@intel.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v5 00/11] i386: miscellaneous cleanup
Date: Wed,  6 Nov 2024 11:07:17 +0800
Message-Id: <20241106030728.553238-1-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.19; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
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

Hi Paolo and all,

Is it necessary to include the first patch (AVX10 cleanup/fix) in v9.2?

Others are for v10.0.

Compared with v4 [1],
 * patch 1 (AVX10 fix) and patch 9 (RAPL cleanup) are newly added.
 * rebased on commit 9a7b0a8618b1 ("Merge tag 'pull-aspeed-20241104' of
   https://github.com/legoater/qemu into staging").


Background and Introduction
===========================

This series picks cleanup from my previous kvmclock [2] (as other
renaming attempts were temporarily put on hold).

In addition, this series also include the cleanup on a historically
workaround, recent comment of coco interface [3] and error handling
corner cases in kvm_arch_init().

Avoiding the fragmentation of these misc cleanups, I consolidated them
all in one series and was able to tackle them in one go!

[1]: https://lore.kernel.org/qemu-devel/20240716161015.263031-1-zhao1.liu@intel.com/
[2]: https://lore.kernel.org/qemu-devel/20240329101954.3954987-1-zhao1.liu@linux.intel.com/
[3]: https://lore.kernel.org/qemu-devel/2815f0f1-9e20-4985-849c-d74c6cdc94ae@intel.com/

Thanks and Best Regards,
Zhao
---
Zhao Liu (11):
  i386/cpu: Mark avx10_version filtered when prefix is NULL
  target/i386/kvm: Add feature bit definitions for KVM CPUID
  target/i386/kvm: Remove local MSR_KVM_WALL_CLOCK and
    MSR_KVM_SYSTEM_TIME definitions
  target/i386/kvm: Only save/load kvmclock MSRs when kvmclock enabled
  target/i386/kvm: Save/load MSRs of kvmclock2
    (KVM_FEATURE_CLOCKSOURCE2)
  target/i386/kvm: Drop workaround for KVM_X86_DISABLE_EXITS_HTL typo
  target/i386/confidential-guest: Fix comment of
    x86_confidential_guest_kvm_type()
  target/i386/kvm: Clean up return values of MSR filter related
    functions
  target/i386/kvm: Return -1 when kvm_msr_energy_thread_init() fails
  target/i386/kvm: Clean up error handling in kvm_arch_init()
  target/i386/kvm: Replace ARRAY_SIZE(msr_handlers) with
    KVM_MSR_FILTER_MAX_RANGES

 hw/i386/kvm/clock.c              |   5 +-
 target/i386/confidential-guest.h |   2 +-
 target/i386/cpu.c                |   6 +-
 target/i386/cpu.h                |  25 ++++
 target/i386/kvm/kvm.c            | 211 +++++++++++++++++--------------
 5 files changed, 145 insertions(+), 104 deletions(-)

-- 
2.34.1


