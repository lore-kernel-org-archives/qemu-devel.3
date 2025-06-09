Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3AC0C5B552
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Jun 2025 12:06:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uObGO-0000k7-9B; Mon, 09 Jun 2025 08:06:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uObG4-0000hA-Ji; Mon, 09 Jun 2025 08:05:44 -0400
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uObFz-00060z-AP; Mon, 09 Jun 2025 08:05:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749470739; x=1781006739;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=Ot80FdygVaU40feRZ301n0PWrVBN6sbOj4IHwArYDLM=;
 b=J/7uIh+Bmk05b/R7NuFYsfSMKHILOY5iUJDsC4J/7hM2GJgAHi95hpdK
 dyNQCxUJpiDXG2MRKa7JMBJXzx0RFPm7zzxebVtKa3XQA1Y/E9s4jlkaS
 JBM5RHn+5Rq8OGjfJHV1Bk5nN7UvDfvP1XS83PIvEH03OHkWZeTCB5wmE
 syCC5Ma/14cnmkPH9lrHNHENOOE11bRb0/4CquXL9j968AcdavmzZBztc
 bJp6ktDL2haxppJB/8KbqbF98GrKB5TgqnwMyswdZoK2vPY5QBzaLr8BI
 Tclt6IOgmMwInVI1upaXU36fL2xvnJOZcv9Rx2NnPefBWwJDmT8C0x+g0 A==;
X-CSE-ConnectionGUID: 3c8+2N3SSKuY1bpLA1kgnQ==
X-CSE-MsgGUID: 86xmJm9wSi6dChPJqiJ4Zg==
X-IronPort-AV: E=McAfee;i="6800,10657,11459"; a="55207656"
X-IronPort-AV: E=Sophos;i="6.16,222,1744095600"; d="scan'208";a="55207656"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2025 05:05:27 -0700
X-CSE-ConnectionGUID: neqNMhuqTByEfy8638EDwQ==
X-CSE-MsgGUID: Gb/B1zMdQ6GGp9Vb048ccQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,222,1744095600"; d="scan'208";a="169667573"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa002.fm.intel.com with ESMTP; 09 Jun 2025 05:05:16 -0700
Date: Mon, 9 Jun 2025 20:26:31 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Dongli Zhang <dongli.zhang@oracle.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, qemu-riscv@nongnu.org, qemu-s390x@nongnu.org,
 pbonzini@redhat.com, mtosatti@redhat.com, sandipan.das@amd.com,
 babu.moger@amd.com, likexu@tencent.com, like.xu.linux@gmail.com,
 groug@kaod.org, khorenko@virtuozzo.com,
 alexander.ivanov@virtuozzo.com, den@virtuozzo.com,
 davydov-max@yandex-team.ru, xiaoyao.li@intel.com,
 dapeng1.mi@linux.intel.com, joe.jin@oracle.com,
 peter.maydell@linaro.org, gaosong@loongson.cn,
 chenhuacai@kernel.org, philmd@linaro.org, aurelien@aurel32.net,
 jiaxun.yang@flygoat.com, arikalo@gmail.com, npiggin@gmail.com,
 danielhb413@gmail.com, palmer@dabbelt.com, alistair.francis@wdc.com,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 richard.henderson@linaro.org, david@redhat.com, iii@linux.ibm.com,
 thuth@redhat.com, flavra@baylibre.com, ewanhai-oc@zhaoxin.com,
 ewanhai@zhaoxin.com, cobechen@zhaoxin.com, louisqi@zhaoxin.com,
 liamni@zhaoxin.com, frankzhu@zhaoxin.com, silviazhao@zhaoxin.com,
 kraxel@redhat.com, berrange@redhat.com
Subject: Re: [PATCH v5 00/10] target/i386/kvm/pmu: PMU Enhancement, Bugfix
 and Cleanup
Message-ID: <aEbS93r7YRcIadj0@intel.com>
References: <20250425213037.8137-1-dongli.zhang@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250425213037.8137-1-dongli.zhang@oracle.com>
Received-SPF: pass client-ip=198.175.65.15; envelope-from=zhao1.liu@intel.com;
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

Hi Dongli,

Since the patch 3 was merged. I think you can rebase this series.

Thanks,
Zhao

On Fri, Apr 25, 2025 at 02:29:57PM -0700, Dongli Zhang wrote:
> Date: Fri, 25 Apr 2025 14:29:57 -0700
> From: Dongli Zhang <dongli.zhang@oracle.com>
> Subject: [PATCH v5 00/10] target/i386/kvm/pmu: PMU Enhancement, Bugfix and
>  Cleanup
> X-Mailer: git-send-email 2.43.5
> 
> This patchset addresses four bugs related to AMD PMU virtualization.
> 
> 1. The PerfMonV2 is still available if PERCORE if disabled via
> "-cpu host,-perfctr-core".
> 
> 2. The VM 'cpuid' command still returns PERFCORE although "-pmu" is
> configured.
> 
> 3. The third issue is that using "-cpu host,-pmu" does not disable AMD PMU
> virtualization. When using "-cpu EPYC" or "-cpu host,-pmu", AMD PMU
> virtualization remains enabled. On the VM's Linux side, you might still
> see:
> 
> [    0.510611] Performance Events: Fam17h+ core perfctr, AMD PMU driver.
> 
> instead of:
> 
> [    0.596381] Performance Events: PMU not available due to virtualization, using software events only.
> [    0.600972] NMI watchdog: Perf NMI watchdog permanently disabled
> 
> To address this, KVM_CAP_PMU_CAPABILITY is used to set KVM_PMU_CAP_DISABLE
> when "-pmu" is configured.
> 
> 4. The fourth issue is that unreclaimed performance events (after a QEMU
> system_reset) in KVM may cause random, unwanted, or unknown NMIs to be
> injected into the VM.
> 
> The AMD PMU registers are not reset during QEMU system_reset.
> 
> (1) If the VM is reset (e.g., via QEMU system_reset or VM kdump/kexec) while
> running "perf top", the PMU registers are not disabled properly.
> 
> (2) Despite x86_cpu_reset() resetting many registers to zero, kvm_put_msrs()
> does not handle AMD PMU registers, causing some PMU events to remain
> enabled in KVM.
> 
> (3) The KVM kvm_pmc_speculative_in_use() function consistently returns true,
> preventing the reclamation of these events. Consequently, the
> kvm_pmc->perf_event remains active.
> 
> (4) After a reboot, the VM kernel may report the following error:
> 
> [    0.092011] Performance Events: Fam17h+ core perfctr, Broken BIOS detected, complain to your hardware vendor.
> [    0.092023] [Firmware Bug]: the BIOS has corrupted hw-PMU resources (MSR c0010200 is 530076)
> 
> (5) In the worst case, the active kvm_pmc->perf_event may inject unknown
> NMIs randomly into the VM kernel:
> 
> [...] Uhhuh. NMI received for unknown reason 30 on CPU 0.
> 
> To resolve these issues, we propose resetting AMD PMU registers during the
> VM reset process
> 
> 
> Changed since v1:
>   - Use feature_dependencies for CPUID_EXT3_PERFCORE and
>     CPUID_8000_0022_EAX_PERFMON_V2.
>   - Remove CPUID_EXT3_PERFCORE when !cpu->enable_pmu.
>   - Pick kvm_arch_pre_create_vcpu() patch from Xiaoyao Li.
>   - Use "-pmu" but not a global "pmu-cap-disabled" for KVM_PMU_CAP_DISABLE.
>   - Also use sysfs kvm.enable_pmu=N to determine if PMU is supported.
>   - Some changes to PMU register limit calculation.
> Changed since v2:
>   - Change has_pmu_cap to pmu_cap.
>   - Use cpuid_find_entry() instead of cpu_x86_cpuid().
>   - Rework the code flow of PATCH 07 related to kvm.enable_pmu=N following
>     Zhao's suggestion.
>   - Use object_property_get_int() to get CPU family.
>   - Add support to Zhaoxin.
> Changed since v3:
>   - Re-base on top of Zhao's queued patch.
>   - Use host_cpu_vendor_fms() from Zhao's patch.
>   - Pick new version of kvm_arch_pre_create_vcpu() patch from Xiaoyao.
>   - Re-split the cases into enable_pmu and !enable_pmu, following Zhao's
>     suggestion.
>   - Check AMD directly makes the "compat" rule clear.
>   - Some changes on commit message and comment.
>   - Bring back global static variable 'kvm_pmu_disabled' read from
>     /sys/module/kvm/parameters/enable_pmu.
> Changed since v4:
>   - Re-base on top of most recent mainline QEMU.
>   - Add more Reviewed-by.
>   - All patches are reviewed.
> 
> 
> Xiaoyao Li (1):
>   kvm: Introduce kvm_arch_pre_create_vcpu()
> 
> Dongli Zhang (9):
>   target/i386: disable PerfMonV2 when PERFCORE unavailable
>   target/i386: disable PERFCORE when "-pmu" is configured
>   target/i386/kvm: set KVM_PMU_CAP_DISABLE if "-pmu" is configured
>   target/i386/kvm: extract unrelated code out of kvm_x86_build_cpuid()
>   target/i386/kvm: rename architectural PMU variables
>   target/i386/kvm: query kvm.enable_pmu parameter
>   target/i386/kvm: reset AMD PMU registers during VM reset
>   target/i386/kvm: support perfmon-v2 for reset
>   target/i386/kvm: don't stop Intel PMU counters
> 
>  accel/kvm/kvm-all.c        |   5 +
>  include/system/kvm.h       |   1 +
>  target/arm/kvm.c           |   5 +
>  target/i386/cpu.c          |   8 +
>  target/i386/cpu.h          |  16 ++
>  target/i386/kvm/kvm.c      | 360 ++++++++++++++++++++++++++++++++++------
>  target/loongarch/kvm/kvm.c |   4 +
>  target/mips/kvm.c          |   5 +
>  target/ppc/kvm.c           |   5 +
>  target/riscv/kvm/kvm-cpu.c |   5 +
>  target/s390x/kvm/kvm.c     |   5 +
>  11 files changed, 372 insertions(+), 47 deletions(-)
> 
> base-commit: 019fbfa4bcd2d3a835c241295e22ab2b5b56129b
> 
> Thank you very much!
> 
> Dongli Zhang
> 

