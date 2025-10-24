Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43D93CCD1AB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 06:38:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCBNu-0003L4-LS; Fri, 24 Oct 2025 02:34:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vCBNs-0003Kp-4T
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 02:34:44 -0400
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vCBNo-0003jZ-Uw
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 02:34:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761287681; x=1792823681;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=0vwFoNdFcHLi/HQ/rXcTxHECC2JAXDzG6T5GA7aPM9k=;
 b=UUU1H7diQAQTGSNo0YJKEulaPZRS/9S6c2v5skpcYr3yduR58oNI0d/D
 aDyRXfQ+MDDRBQyWln1rgGwOQYkgs1ZnpFcx810/KbSh6aUI0GwXNM5sD
 qGX+VC4Qa22B+2BmDSxXoUfKvtFxLHoCvxMt6wUmxmbUB2kKtcdd2ZiQs
 cN9NZkiWpLxH+NEJNeupU835Y/wVOzapvIFZgws5La3kHtyPXeTGyiJpA
 W93CPNeVfwoXg3Tj3J+FnRbObtY7H5nyt7yTt72RglcA9AjZ6AoAXx1Kr
 mdPKrvWI5HxYSXAPPUuUqg16BBd3xcKmLx5GQXHmKpCleTrBQs2B/dCdy w==;
X-CSE-ConnectionGUID: 3OSohRPaS662LFAdfcp/bg==
X-CSE-MsgGUID: Ppd1Snd3Q/+A963nkVJ8QQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="74137849"
X-IronPort-AV: E=Sophos;i="6.19,251,1754982000"; d="scan'208";a="74137849"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2025 23:34:37 -0700
X-CSE-ConnectionGUID: flYQLtPjRgi3m8pUAfNovA==
X-CSE-MsgGUID: sWKOiGYiRn6N2DE67vWT1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,251,1754982000"; d="scan'208";a="184275849"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by fmviesa006.fm.intel.com with ESMTP; 23 Oct 2025 23:34:34 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, Chao Gao <chao.gao@intel.com>,
 John Allen <john.allen@amd.com>, Babu Moger <babu.moger@amd.com>,
 Mathias Krause <minipli@grsecurity.net>, Dapeng Mi <dapeng1.mi@intel.com>,
 Zide Chen <zide.chen@intel.com>, Chenyi Qiang <chenyi.qiang@intel.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, Farrah Chen <farrah.chen@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v3 00/20] i386: Support CET for KVM
Date: Fri, 24 Oct 2025 14:56:12 +0800
Message-Id: <20251024065632.1448606-1-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.9; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

This the v3 series to support CET (CET-SHSTK & CET-IBT) in QEMU, which
is based on the commit c0e80879c876 ("Merge tag 'pull-vfio-20251022' of
https://github.com/legoater/qemu into staging"). And you can also find
the code here:

https://gitlab.com/zhao.liu/qemu/-/commits/i386-cet-v1-10-22-2025

Compared to v2 [1] (posted two years ago), the basic CET support (
xstate/MSR/vmstate/CPUID) remains roughly unchanged. And I also noted
the change logs in the patches inherited from v2.

Thanks for your feedback!

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

The basic CET support (patch 11-17) includes:
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

[1]: https://lore.kernel.org/qemu-devel/20230720111445.99509-1-weijiang.yang@intel.com/
[2]: https://lore.kernel.org/all/20250908201750.98824-1-john.allen@amd.com/

Thanks and Best Regards,
Zhao
---
Chao Gao (1):
  i386/cpu: Fix supervisor xstate initialization

Chenyi Qiang (1):
  i386/tdx: Add CET SHSTK/IBT into the supported CPUID by XFAM

Yang Weijiang (5):
  i386/cpu: Enable xsave support for CET states
  i386/kvm: Add save/load support for CET MSRs
  i386/kvm: Add save/load support for KVM_REG_GUEST_SSP
  i386/machine: Add vmstate for cet-ss and cet-ibt
  i386/cpu: Advertise CET related flags in feature words

Zhao Liu (13):
  linux-headers: Update to v6.18-rc2
  i386/cpu: Clean up indent style of x86_ext_save_areas[]
  i386/cpu: Clean up arch lbr xsave struct and comment
  i386/cpu: Reorganize arch lbr structure definitions
  i386/cpu: Make ExtSaveArea store an array of dependencies
  i386/cpu: Add avx10 dependency for Opmask/ZMM_Hi256/Hi16_ZMM
  i386/cpu: Reorganize dependency check for arch lbr state
  i386/cpu: Drop pmu check in CPUID 0x1C encoding
  i386/cpu: Add missing migratable xsave features
  i386/cpu: Add CET support in CR4
  i386/cpu: Mark cet-u & cet-s xstates as migratable
  i386/cpu: Enable cet-ss & cet-ibt for supported CPU models
  i386/tdx: Fix missing spaces in tdx_xfam_deps[]

 include/standard-headers/linux/ethtool.h      |   1 +
 include/standard-headers/linux/fuse.h         |  22 +-
 .../linux/input-event-codes.h                 |   1 +
 include/standard-headers/linux/input.h        |  22 +-
 include/standard-headers/linux/pci_regs.h     |  10 +
 include/standard-headers/linux/virtio_ids.h   |   1 +
 include/standard-headers/linux/virtio_rtc.h   | 237 ++++++++++++++++++
 include/standard-headers/linux/virtio_spi.h   | 181 +++++++++++++
 linux-headers/asm-loongarch/kvm.h             |   1 +
 linux-headers/asm-riscv/kvm.h                 |  23 +-
 linux-headers/asm-riscv/ptrace.h              |   4 +-
 linux-headers/asm-x86/kvm.h                   |  34 +++
 linux-headers/asm-x86/unistd_64.h             |   1 +
 linux-headers/asm-x86/unistd_x32.h            |   1 +
 linux-headers/linux/kvm.h                     |   3 +
 linux-headers/linux/psp-sev.h                 |  10 +-
 linux-headers/linux/stddef.h                  |   1 -
 linux-headers/linux/vduse.h                   |   2 +-
 linux-headers/linux/vhost.h                   |   4 +-
 target/i386/cpu.c                             | 227 ++++++++++++-----
 target/i386/cpu.h                             |  99 ++++++--
 target/i386/helper.c                          |  12 +
 target/i386/kvm/kvm.c                         | 103 ++++++++
 target/i386/kvm/tdx.c                         |  20 +-
 target/i386/machine.c                         |  53 ++++
 25 files changed, 968 insertions(+), 105 deletions(-)
 create mode 100644 include/standard-headers/linux/virtio_rtc.h
 create mode 100644 include/standard-headers/linux/virtio_spi.h

-- 
2.34.1


