Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5A44CED240
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 03:21:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLCGZ-0001I6-Qt; Mon, 17 Nov 2025 22:20:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vLCGX-0001HZ-Fp
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 22:20:25 -0500
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vLCGU-0004CU-6a
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 22:20:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763436022; x=1794972022;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=e7ZuP6IJXLFF9a7BOtF/YskQsXWAUPGXOl3UUkfR6iA=;
 b=J7QkjgQhbJsltidT1fZUhkalPH55WX2yiYzf/xpVMJw1YX9e2yuiwNj4
 WiW2y6Q8fIl3oHbcPdc36SlQ1pZdXGWzza9kIlIQAL9TslnKRrgTaskr/
 CjqJ2ievE7Hkeq9K1ZGAQS8+8KsUsulYdIzF9tQHyHFHZaZtB0+kg5gkK
 v4Ma+ESUYZnwcF8/6riPa2en1tIeoCY0a+8WEcHu/ScRHS9w7SmjmOCCN
 a1dRTXY9Jw6RZkHI+6yYdUPcQ7xyYL6ieXnKH3LWP1OuAkPaBjflmTsNG
 eiPb59cPgJkXB+dgqmHKNXwRKryogg2kD6lUXwWjRTtDeUUWZZsdJknhX A==;
X-CSE-ConnectionGUID: UDAFqWFjQ/WtHQM6tHhxXQ==
X-CSE-MsgGUID: FYgNHYOUR1O1R5Q7Zh2mYQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11616"; a="68053717"
X-IronPort-AV: E=Sophos;i="6.19,313,1754982000"; d="scan'208";a="68053717"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Nov 2025 19:20:17 -0800
X-CSE-ConnectionGUID: EV1Ij9I/T+OobmynnrHDpQ==
X-CSE-MsgGUID: ymzuKz1cSNW2o8WJr2gSKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,313,1754982000"; d="scan'208";a="221537123"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by fmviesa001.fm.intel.com with ESMTP; 17 Nov 2025 19:20:13 -0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, Chao Gao <chao.gao@intel.com>,
 Xin Li <xin@zytor.com>, John Allen <john.allen@amd.com>,
 Babu Moger <babu.moger@amd.com>, Mathias Krause <minipli@grsecurity.net>,
 Dapeng Mi <dapeng1.mi@intel.com>, Zide Chen <zide.chen@intel.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, Chenyi Qiang <chenyi.qiang@intel.com>,
 Farrah Chen <farrah.chen@intel.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v4 00/23] i386: Support CET for KVM
Date: Tue, 18 Nov 2025 11:42:08 +0800
Message-Id: <20251118034231.704240-1-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.13; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
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

This the v4 series to support CET (CET-SHSTK & CET-IBT) in QEMU, which
is based on the master branch at the commit 9febfa94b69b ("Merge tag
'for-upstream' of https://repo.or.cz/qemu/kevin into staging"). And you
can also find the code here:

https://gitlab.com/zhao.liu/qemu/-/tree/i386-all-for-dmr-v1.1-11-17-2025

Compared to v3 [1], v4 mainly considers pl0 SSP MSR for FRED, and fixes
migratable_flags for FEAT_XSAVE_XSS_LO. More details, pls refer Change
Log in the following.

Thanks for your review!

Overview
========

Control-flow enforcement technology includes 2 x86-architectural
features:
 - CET shadow stack (CET-SHSTK or CET-SS).
 - CET indirect branch tracking (CET-IBT).

Intel has implemented both 2 features since Sapphire Rapids (P-core) &
Sierra Forest (E-core).

AMD also implemented shadow stack since Zen3 [2] - this series has
considerred only-shstk case and is supposed to work on AMD platform, but
I hasn't tested this on AMD.

The basic CET support (patch 12-20) includes:
 * CET-S & CET-U supervisor xstates support.
 * CET CPUIDs enumeration.
 * CET MSRs save & load.
 * CET guest SSP register (KVM treats this as a special internal
   register - KVM_REG_GUEST_SSP) save & load.
 * Vmstates for MSRs & guest SSP.

But before CET support, there's a lot of cleanup work needed for
supervisor xstate.

Before CET-S/CET-U, QEMU has already supports arch lbr as the 1st
supervisor xstate. Although arch LBR has not yet been merged into KVM
(still planned), this series cleans up supervisor state-related support
and avoids breaking the current arch LBR in QEMU - that's what patch
2-11 are doing.

Additionally, besides KVM, this series also supports CET for TDX.

Change Log
==========

Changes Since v3:
 - Fill CPUID 0xD subleaves from KVM CPUID instead of host CPUID for
   non-dynamic xstates (i.e., except AMX xstates for now).
 - Save/restore/migrate MSR_IA32_PL0_SSP for FRED.
 - Fix migratable_flags for FEAT_XSAVE_XSS_LO.
 - Refine commit message for CET TDX support.

[1]: https://lore.kernel.org/qemu-devel/20251024065632.1448606-1-zhao1.liu@intel.com/
[2]: https://lore.kernel.org/all/20250908201750.98824-1-john.allen@amd.com/

Thanks and Best Regards,
Zhao
---
Chao Gao (1):
  i386/cpu: Fix supervisor xstate initialization

Chenyi Qiang (1):
  i386/tdx: Add CET SHSTK/IBT into the supported CPUID by XFAM

Xin Li (Intel) (2):
  i386/cpu: Save/restore SSP0 MSR for FRED
  i386/cpu: Migrate MSR_IA32_PL0_SSP for FRED and CET-SHSTK

Yang Weijiang (5):
  i386/cpu: Enable xsave support for CET states
  i386/kvm: Add save/restore support for CET MSRs
  i386/kvm: Add save/restore support for KVM_REG_GUEST_SSP
  i386/machine: Add vmstate for cet-shstk and cet-ibt
  i386/cpu: Advertise CET related flags in feature words

Zhao Liu (14):
  i386/cpu: Clean up indent style of x86_ext_save_areas[]
  i386/cpu: Clean up arch lbr xsave struct and comment
  i386/cpu: Reorganize arch lbr structure definitions
  i386/cpu: Make ExtSaveArea store an array of dependencies
  i386/cpu: Add avx10 dependency for Opmask/ZMM_Hi256/Hi16_ZMM
  i386/kvm: Initialize x86_ext_save_areas[] based on KVM support
  i386/cpu: Use x86_ext_save_areas[] for CPUID.0XD subleaves
  i386/cpu: Reorganize dependency check for arch lbr state
  i386/cpu: Drop pmu check in CPUID 0x1C encoding
  i386/cpu: Add missing migratable xsave features
  i386/cpu: Add CET support in CR4
  i386/cpu: Mark cet-u & cet-s xstates as migratable
  i386/cpu: Enable cet-ss & cet-ibt for supported CPU models
  i386/tdx: Fix missing spaces in tdx_xfam_deps[]

 target/i386/cpu.c         | 256 +++++++++++++++++++++++++++-----------
 target/i386/cpu.h         | 110 ++++++++++++----
 target/i386/helper.c      |  12 ++
 target/i386/kvm/kvm-cpu.c |  23 +++-
 target/i386/kvm/kvm.c     | 117 +++++++++++++++++
 target/i386/kvm/tdx.c     |  20 +--
 target/i386/machine.c     |  78 ++++++++++++
 7 files changed, 501 insertions(+), 115 deletions(-)

-- 
2.34.1


