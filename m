Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A82DE77184
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 11:16:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOEVi-0004Wy-Sd; Thu, 19 Dec 2024 06:16:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tOEVa-0004Vq-T6
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 06:16:00 -0500
Received: from mgamail.intel.com ([198.175.65.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tOEVY-0005H9-4C
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 06:15:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1734606957; x=1766142957;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=Wja/fOyeN1Jl/2G1ruWIeL2uxsW3z22In7tdFGqm7XU=;
 b=ZXW9Oiuf8xUjVlQ5ZRGzQfeBh3KMzHNoJwwEOZapPr4amR6Rh8ca7PrY
 Ebxx4gXSvUFx2A4dJKgCyMqm9dUucROIIMhnvWayw+B8dVRhxIG/RsnTK
 Qi9dAjejgGRQBMB0OcacTYOX4XzwNEoCtiXWnJYu0bjfDqOJTypuAXFiT
 VRnsfDa4pO2rcVbGNbDzXICaK6EML9jKWC45gcNxN7Yc4+8a3qpGSWGpo
 MFlA1nm1UBUVSCYnT2umfc7hlhsnffh6h0MIsmsBK1SrdwVsGQSKcH8xC
 DRfGZfFc/BMbwgc6kZ+L3m+RJJBZNNZ+XqTh+qZRsR9+GZdCz0tgT9Ypj Q==;
X-CSE-ConnectionGUID: dbSKtojaRd+/jlDC8mZUKA==
X-CSE-MsgGUID: pZn4TQW/Q+W2sbo+apgaDw==
X-IronPort-AV: E=McAfee;i="6700,10204,11290"; a="34994918"
X-IronPort-AV: E=Sophos;i="6.12,247,1728975600"; d="scan'208";a="34994918"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Dec 2024 03:15:51 -0800
X-CSE-ConnectionGUID: Gp7lEYM1RjiaC6+ndTc/+g==
X-CSE-MsgGUID: 1M2PfIeLQr6FU8pw8jThWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,247,1728975600"; d="scan'208";a="97956083"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by fmviesa006.fm.intel.com with ESMTP; 19 Dec 2024 03:15:47 -0800
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Yanan Wang <wangyanan55@huawei.com>,
 Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, xiaoyao.li@intel.com
Subject: [PATCH v2 00/10] i386: Track X86CPUTopoInfo in CPUX86State and track
 features in env->features[]
Date: Thu, 19 Dec 2024 06:01:15 -0500
Message-Id: <20241219110125.1266461-1-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.19; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.998, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This v2 series is follow up work of [1],[2].

The initial purpose is to track CPUID_HT in env->features[] for x86.
It's supposed to be implemented in x86_cpu_realizefn() and before
qemu_init_vcpu(). However, CPUID_HT bit needs to be evaluated based on
topology information, either 1) nr_cores and nr_threads of CPUState or
2) MachineState::smp.

1) are initialized in qemu_init_vcpu() which is too late. So [1] was
sent to initialize nr_threads and nr_cores of CPUState earlier. It
touches all the ARCHes and people disliked it. Followup attempt to
initialize them in cpu_common_initfn() was also rejected. [3]

2) needs to grab MachineState in cpu context and was disagreed[3]

As suggested by Igor[3], aduit nr_threads and nr_cores and initialize
them in pre_plug() callback for the ARCHes where they are actually needed.
I found nr_cores is only used by x86 and nr_threads is used by
X86/MIPS/PPC[4]. I didn't play with MIPS and PPC before and I'm
incapable to write patch for them. So I send an RFC work [2], which
drops nr_cores from CPUState and it instead maintains a substitute for
x86 only. The RFC work left how to handle nr_threads as open however I
didn't get any feedback yet.

Eventually, I decided to fix x86 only. The sulution is to maintain a
X86CPUTopoInfo in CPUX86State, so that x86 doesn't need to use
nr_threads and nr_cores anymore and the dependency on qemu_init_vcpu()
goes away.

x86 is the only user of CPUState::nr_core currently. When it switches to
use CPUX86state::X86CPUTopoInfo, CPUState::nr_core loses its only user
and can be dropped in patch 8.

In the future, if MIPS and PPC starts to maintain nr_threads in its own
CPU state, common CPUState::nr_threads can be dropped as well.

Besides the patches to fulfill the main goal to track CPUID_HT in
env->features[] for x86. This series also contains the cleanup patches
during the work.


[1] https://lore.kernel.org/qemu-devel/20241108070609.3653085-1-xiaoyao.li@intel.com/
[2] https://lore.kernel.org/qemu-devel/20241205145716.472456-1-xiaoyao.li@intel.com/
[3] https://lore.kernel.org/qemu-devel/20241125103857.78a23715@imammedo.users.ipa.redhat.com/
[4] https://lore.kernel.org/qemu-devel/045f9cb1-2b17-4b2c-985f-3c34e3626b36@intel.com/

Xiaoyao Li (10):
  i386/cpu: Extract a common fucntion to setup value of
    MSR_CORE_THREAD_COUNT
  i386/cpu: Drop the variable smp_cores and smp_threads in
    x86_cpu_pre_plug()
  i386/cpu: Drop cores_per_pkg in cpu_x86_cpuid()
  i386/topology: Update the comment of x86_apicid_from_topo_ids()
  i386/topology: Introduce helpers for various topology info of
    different level
  i386/cpu: Track a X86CPUTopoInfo directly in CPUX86State
  i386/cpu: Hoist check of CPUID_EXT3_TOPOEXT against threads_per_core
  cpu: Remove nr_cores from struct CPUState
  i386/cpu: Set up CPUID_HT in x86_cpu_expand_features() instead of
    cpu_x86_cpuid()
  i386/cpu: Set and track CPUID_EXT3_CMP_LEG in
    env->features[FEAT_8000_0001_ECX]

 hw/core/cpu-common.c                 |   1 -
 hw/i386/x86-common.c                 |  22 +++---
 include/hw/core/cpu.h                |   2 -
 include/hw/i386/topology.h           |  30 ++++++-
 system/cpus.c                        |   1 -
 target/i386/cpu-sysemu.c             |  11 +++
 target/i386/cpu.c                    | 113 ++++++++++++---------------
 target/i386/cpu.h                    |   8 +-
 target/i386/hvf/x86_emu.c            |   3 +-
 target/i386/kvm/kvm.c                |   5 +-
 target/i386/tcg/sysemu/misc_helper.c |   3 +-
 11 files changed, 103 insertions(+), 96 deletions(-)

-- 
2.34.1


