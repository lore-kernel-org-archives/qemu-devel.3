Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D35AD3E782
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Dec 2025 05:44:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTZSj-0000aY-SC; Thu, 11 Dec 2025 00:43:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vTZSd-0000Yx-4W
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 00:43:32 -0500
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vTZSa-00017Z-9c
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 00:43:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765431808; x=1796967808;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=pXFlcf+ppR4o/U0dw6I5BODUXd5sp7/Yj1QR7z9CnuQ=;
 b=UXGkgCb2xq6uf9aFmZG2n0BXggzQSS5tT0YM6YfuLfOOStH6kdUO5Kii
 TkBU+50YYaopJF8SThAEZPmjA0KBkehsc/MKWofdmY2/E/9aI3bIAhPOn
 cVHUV5Hwb4x892pQ/7iZrhF7EeKSff+/fXrwrnb8Y8ImXg5+z98EX9tD8
 DcvQChZrFwndbkC8QgFw16XWT1Sr1X3O/nFthCEaLlN6pWO6JAbWw2p2K
 UA1JoIjKF/vtBPiDa91rhxMZ9048+3LVm+4GJaw9Q3W+hBFkLoZ8IchSE
 wvvD9AD0fF3EdY/LvflA6nr9cuQVc5cSDLljRBIsbxdwMkiUGafUgtbl1 g==;
X-CSE-ConnectionGUID: EQcFQmTcRAWdujAWbEKc0A==
X-CSE-MsgGUID: LUApFbCySo6b3e41u+coRg==
X-IronPort-AV: E=McAfee;i="6800,10657,11638"; a="66409798"
X-IronPort-AV: E=Sophos;i="6.20,265,1758610800"; d="scan'208";a="66409798"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Dec 2025 21:43:22 -0800
X-CSE-ConnectionGUID: yxu5aCrBSQekia2n3OGaDQ==
X-CSE-MsgGUID: nrYeIYWSTzSpC0BafUwIEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,265,1758610800"; d="scan'208";a="227365980"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa002.jf.intel.com with ESMTP; 10 Dec 2025 21:43:18 -0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, Chao Gao <chao.gao@intel.com>,
 Xin Li <xin@zytor.com>, John Allen <john.allen@amd.com>,
 Babu Moger <babu.moger@amd.com>, Mathias Krause <minipli@grsecurity.net>,
 Dapeng Mi <dapeng1.mi@intel.com>, Zide Chen <zide.chen@intel.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, Chenyi Qiang <chenyi.qiang@intel.com>,
 Farrah Chen <farrah.chen@intel.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v5 00/22] i386: Support CET for KVM
Date: Thu, 11 Dec 2025 14:07:39 +0800
Message-Id: <20251211060801.3600039-1-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.19; envelope-from=zhao1.liu@intel.com;
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
is based on the master branch at the commit 05f36f7c0512c ("Update
version for v10.2.0-rc2 release"). And you can also find the code here:

https://gitlab.com/zhao.liu/qemu/-/tree/i386-all-for-dmr-v2.1-12-10-2025

Compared to v4 [1], v5 continues to use host_cpuid for KVM's xstate
initialization and simplify the migration check for PL0_SSP MSR.

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

The basic CET support (patch 11-19) includes:
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
2-10 are doing.

Additionally, besides KVM, this series also supports CET for TDX.

Change Log
==========

Changes Since v4:
 - Drop previous patch "i386/kvm: Initialize x86_ext_save_areas[] based
   on KVM support", and continue to use host_cpuid to initialize
   x86_ext_save_areas[].
 - For migration, check whether pl0_ssp is in-use instead of checking
   FRED & CET-SHSTK CPUIDs.
 - Polish commit message of patch 6 "i386/cpu: Use x86_ext_save_areas[]
   for CPUID.0XD subleaves".

Changes Since v3:
 - Fill CPUID 0xD subleaves from KVM CPUID instead of host CPUID for
   non-dynamic xstates (i.e., except AMX xstates for now).
 - Save/restore/migrate MSR_IA32_PL0_SSP for FRED.
 - Fix migratable_flags for FEAT_XSAVE_XSS_LO.
 - Refine commit message for CET TDX support.

[1]: https://lore.kernel.org/qemu-devel/20251118034231.704240-1-zhao1.liu@intel.com/
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

Zhao Liu (13):
  i386/cpu: Clean up indent style of x86_ext_save_areas[]
  i386/cpu: Clean up arch lbr xsave struct and comment
  i386/cpu: Reorganize arch lbr structure definitions
  i386/cpu: Make ExtSaveArea store an array of dependencies
  i386/cpu: Add avx10 dependency for Opmask/ZMM_Hi256/Hi16_ZMM
  i386/cpu: Use x86_ext_save_areas[] for CPUID.0XD subleaves
  i386/cpu: Reorganize dependency check for arch lbr state
  i386/cpu: Drop pmu check in CPUID 0x1C encoding
  i386/cpu: Add missing migratable xsave features
  i386/cpu: Add CET support in CR4
  i386/cpu: Mark cet-u & cet-s xstates as migratable
  i386/cpu: Enable cet-ss & cet-ibt for supported CPU models
  i386/tdx: Fix missing spaces in tdx_xfam_deps[]

 target/i386/cpu.c     | 256 +++++++++++++++++++++++++++++-------------
 target/i386/cpu.h     | 107 ++++++++++++++----
 target/i386/helper.c  |  12 ++
 target/i386/kvm/kvm.c | 117 +++++++++++++++++++
 target/i386/kvm/tdx.c |  20 ++--
 target/i386/machine.c |  75 +++++++++++++
 6 files changed, 478 insertions(+), 109 deletions(-)

-- 
2.34.1


