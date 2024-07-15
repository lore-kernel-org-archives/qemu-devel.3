Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC814C2BD09
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2024 04:35:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTDPw-0008Cz-EZ; Mon, 15 Jul 2024 00:34:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sTDPu-0008Bz-M5
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 00:34:26 -0400
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sTDPs-0004Ev-R7
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 00:34:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1721018065; x=1752554065;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=+kWBSksCjwdQpHlmtbr87XOClMos7SBe4fOvnuHZMAU=;
 b=EF1idCBXlxOcoNI0M6C5LfnJuTAEc5LDZNG5JyebTGxOXoAztgrkHK8C
 jkTWvQQ71kSQvVnD4emtD6B6fvyqqADSP8445UQel6X0zBAuHzvmU+EML
 8U/jzM3WZt+H9eNUBcq5Pmx6TR64OWAeX7mQzPD8lDepZeQ76RznC3+sY
 g0q4C7GNW2uScN1yml+sAUXG60ZsR+XQK+dtfpx8lCFYsL6Dp7rvDMXWZ
 2dzzXX36kXLsHyC6PFc7aXiHYgXo/I/2eWUKe9nDOnaskGPK5PWKNf4g3
 lpiEBOWAyiwz9jWlojhhdOdQ4S+MGnME1ze1fKt3kMDupmxdd1ldC5bF4 A==;
X-CSE-ConnectionGUID: FE8vuKVlRGG+Xw+10kFNGQ==
X-CSE-MsgGUID: JMzuTY57RIilVTa5EBYrvw==
X-IronPort-AV: E=McAfee;i="6700,10204,11133"; a="35809797"
X-IronPort-AV: E=Sophos;i="6.09,209,1716274800"; d="scan'208";a="35809797"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jul 2024 21:34:20 -0700
X-CSE-ConnectionGUID: bC8wDrE7S1Onq3QSDONJhA==
X-CSE-MsgGUID: XKOiyfdTRqCpV/EAIU1onA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,209,1716274800"; d="scan'208";a="54043024"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa004.fm.intel.com with ESMTP; 14 Jul 2024 21:34:16 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, Pankaj Gupta <pankaj.gupta@amd.com>,
 Zide Chen <zide.chen@intel.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v3 0/8] [PATCH v3 0/8] target/i386: Misc cleanup on KVM PV
 defs, outdated comments and error handling
Date: Mon, 15 Jul 2024 12:49:47 +0800
Message-Id: <20240715044955.3954304-1-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.10; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

This is my v3 cleanup series. Compared with v2 [1],
 * v3 resolved the rebasing conflict (now based on 37fbfda8f414).
 * Added 2 more patches (patch 7&8) to clean up error handling in
   kvm_arch_init().


Background and Introduction
===========================

This series picks cleanup from my previous kvmclock [2] (as other
renaming attempts were temporarily put on hold).

In addition, this series also include the cleanup on a historically
workaround, recent comment of coco interface [3] and error handling
corner cases in kvm_arch_init().

Avoiding the fragmentation of these misc cleanups, I consolidated them
all in one series and was able to tackle them in one go!

[1]: https://lore.kernel.org/qemu-devel/20240506085153.2834841-1-zhao1.liu@intel.com/
[2]: https://lore.kernel.org/qemu-devel/20240329101954.3954987-1-zhao1.liu@linux.intel.com/
[3]: https://lore.kernel.org/qemu-devel/2815f0f1-9e20-4985-849c-d74c6cdc94ae@intel.com/

Thanks and Best Regards,
Zhao
---
Zhao Liu (8):
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
  target/i386/kvm: Clean up error handling in kvm_arch_init()

 hw/i386/kvm/clock.c              |   5 +-
 target/i386/confidential-guest.h |   2 +-
 target/i386/cpu.h                |  25 +++++++
 target/i386/kvm/kvm.c            | 108 ++++++++++++++++++-------------
 target/i386/kvm/kvm_i386.h       |   4 +-
 5 files changed, 92 insertions(+), 52 deletions(-)

-- 
2.34.1


