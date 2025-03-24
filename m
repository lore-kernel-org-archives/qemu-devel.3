Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AB2AC36002
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 07:10:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twbvd-0008HB-J4; Mon, 24 Mar 2025 03:08:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dapeng1.mi@linux.intel.com>)
 id 1twbvT-0008Fl-8C
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 03:08:47 -0400
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dapeng1.mi@linux.intel.com>)
 id 1twbvQ-0008IV-TK
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 03:08:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1742800125; x=1774336125;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=ANkPs0h4mhk6jy/bkiJEEPbEptITE5hW4KH1EhFBtXk=;
 b=CR3FeUI+4FFye4IuxfA5KK9hDngOWnZaQff6Nu7f/4u6oJTez1fkv7bK
 ZoI1gZkbbaXKMG8ns0OVz/OoTjF7/ZKe2ztQNx44GhVtCnZ7xQX0qczo7
 4+cMIjgmfRjlKvz/zQh/0Qh64wDGAV+yC4N0a9BZPan0x1Ez1qG4p4wpm
 xwl1aBzGjfZrXsmkCHkPBi/n6iQBnpULYgm6N3ixiPXAXBtFsQTQLxBeW
 L0t8X/bPi4oTm63To5tshTFZ0LAuQxyLAQ0ddqYYBHh2MSvKsiw4K24io
 /vQ+tN1ELax4gE6c5sGqL5CHB3MLkMtL9QzYtGt+yLavoqxKYFDNQlkAS w==;
X-CSE-ConnectionGUID: jDs2amaXTbmSZ6K5v3+e1g==
X-CSE-MsgGUID: l6WLLp4nSsKamn4Ua2RiLw==
X-IronPort-AV: E=McAfee;i="6700,10204,11382"; a="31588448"
X-IronPort-AV: E=Sophos;i="6.14,271,1736841600"; d="scan'208";a="31588448"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Mar 2025 00:08:40 -0700
X-CSE-ConnectionGUID: cBOFxVkVTkytqH8YnZ3tnA==
X-CSE-MsgGUID: //Xcw+dXToqFsjpHLZzwQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,271,1736841600"; d="scan'208";a="123944311"
Received: from emr.sh.intel.com ([10.112.229.56])
 by fmviesa007.fm.intel.com with ESMTP; 24 Mar 2025 00:08:37 -0700
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Sean Christopherson <seanjc@google.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, Zhao Liu <zhao1.liu@intel.com>,
 Zide Chen <zide.chen@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Dongli Zhang <dongli.zhang@oracle.com>, Mingwei Zhang <mizhang@google.com>,
 Das Sandipan <Sandipan.Das@amd.com>, Shukla Manali <Manali.Shukla@amd.com>,
 Dapeng Mi <dapeng1.mi@intel.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [PATCH 0/3] Enable x86 mediated vPMU
Date: Mon, 24 Mar 2025 12:37:09 +0000
Message-Id: <20250324123712.34096-1-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=192.198.163.16;
 envelope-from=dapeng1.mi@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DATE_IN_FUTURE_03_06=3.027,
 DKIMWL_WL_HIGH=-0.001, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

This small patch series enables the newly introduced KVM x86 mediated
vPMU solution. As KVM maintainer's suggestion, KVM mediated vPMU is
disabled by default unless user explicitly calls KVM_CAP_PMU_CAPABILITY
ioctl to enable it.

As for mediated vPMU, it's a new pass-through vPMU solution which is
designed to replace the legacy perf-based vPMU which has several
drawbacks, such as high performance overhead, hard to support new PMU
features, etc. Most of PMU MSRs except EVENTSELx are passed through to
guest in mediated vPMU. Currently the latest mediated vPMU patch series
is v3[1], the v4 patchset would be sent soon.

In this series, patch 1/3 introduces a helper
kvm_arch_pre_create_vcpu() which would be called before creating vCPU.
This patch comes from Xiaoyao's "QEMU TDX support" patchset[2]. Patch
2/3 leverages the patch 1/3 introduced helper to call
KVM_CAP_PMU_CAPABILITY ioctl to enable/disable KVM vPMU (mediated vPMU).
This patch is similar with patch 4/10 of Dongli's
"target/i386/kvm/pmu: PMU Enhancement, Bugfix and Cleanup" patchset[3],
but can be considered as an enhanced version. Patch 3/3 provides support
for newly introduced VMCS bit SAVE_IA32_PERF_GLOBAL_CTRL.

Tests:
  * Tests on Sapphire Rapids platform, both mediated vPMU and legacy
    perf-based vPMU can be enabled/disabled with "+/-pmu" option.

Ref:
[1] https://lore.kernel.org/all/20240801045907.4010984-1-mizhang@google.com/
[2] https://lore.kernel.org/all/20250124132048.3229049-8-xiaoyao.li@intel.com/
[3] https://lore.kernel.org/all/20250302220112.17653-5-dongli.zhang@oracle.com/  

Dapeng Mi (2):
  target/i386: Call KVM_CAP_PMU_CAPABILITY iotcl to enable/disable PMU
  target/i386: Support VMX_VM_EXIT_SAVE_IA32_PERF_GLOBAL_CTRL

Xiaoyao Li (1):
  kvm: Introduce kvm_arch_pre_create_vcpu()

 accel/kvm/kvm-all.c        |  5 +++++
 include/system/kvm.h       |  1 +
 target/arm/kvm.c           |  5 +++++
 target/i386/cpu.c          | 12 ++++++++----
 target/i386/cpu.h          |  1 +
 target/i386/kvm/kvm.c      | 22 ++++++++++++++++++++++
 target/loongarch/kvm/kvm.c |  5 +++++
 target/mips/kvm.c          |  5 +++++
 target/ppc/kvm.c           |  5 +++++
 target/riscv/kvm/kvm-cpu.c |  5 +++++
 target/s390x/kvm/kvm.c     |  5 +++++
 11 files changed, 67 insertions(+), 4 deletions(-)


base-commit: 71119ed3651622e1c531d1294839e9f3341adaf5
-- 
2.40.1


