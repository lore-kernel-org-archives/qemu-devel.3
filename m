Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ADEDC3601E
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Apr 2025 08:02:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2mqT-0005zv-19; Thu, 10 Apr 2025 04:01:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u2mqG-0005yO-U1; Thu, 10 Apr 2025 04:01:02 -0400
Received: from mgamail.intel.com ([198.175.65.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u2mqC-00073D-R2; Thu, 10 Apr 2025 04:00:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1744272053; x=1775808053;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=Fog4B6Qbd8u1Pqc/gI0bDG41NJadwivsKQhqgMevtPQ=;
 b=mzPuRRw891rlTsFM9OO202Ka3ZXrlJ91N6PXOSuruai/PJEW/HcKFgZU
 RmY8E3264DeRs8AUGl4vFnliNvRNt/kHVXfsMfOSY1PJpKRxyOdTEMR8D
 mWhfjd+NFEpNc53E2atNS+l+/juigl2GUBgOI4X5TSz8ZKRXsNJGdBoma
 fGfgQqQWz+sP8Q68pWNPFTQ9p2yhn89GFbtEPEYNxeoPUx1/r04Xh9EsP
 EUpLXUn2dORtSx2QiZyU3eZcF9SxYQvWO29JBSI27kg43vuCCUwQTDL9j
 uh2ZybZVUJhT0eVTad5YAPjn4E7QzRWZ1P4w2Qotv48tErYJQNizk/qEa g==;
X-CSE-ConnectionGUID: rOTq+PxKToCFEqu+7R8Pgg==
X-CSE-MsgGUID: 5nbWWZGTTr2nptxVLb7TFg==
X-IronPort-AV: E=McAfee;i="6700,10204,11399"; a="45668210"
X-IronPort-AV: E=Sophos;i="6.15,202,1739865600"; d="scan'208";a="45668210"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Apr 2025 01:00:39 -0700
X-CSE-ConnectionGUID: GCO21CPgQjmbraiccL1yeA==
X-CSE-MsgGUID: CwIZbOfJSLOTUfZSSHQyug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,202,1739865600"; d="scan'208";a="134019949"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa005.jf.intel.com with ESMTP; 10 Apr 2025 01:00:28 -0700
Date: Thu, 10 Apr 2025 16:21:18 +0800
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
 liamni@zhaoxin.com, frankzhu@zhaoxin.com, silviazhao@zhaoxin.com
Subject: Re: [PATCH v3 09/10] target/i386/kvm: support perfmon-v2 for reset
Message-ID: <Z/d/ft0CufA8prwl@intel.com>
References: <20250331013307.11937-1-dongli.zhang@oracle.com>
 <20250331013307.11937-10-dongli.zhang@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250331013307.11937-10-dongli.zhang@oracle.com>
Received-SPF: pass client-ip=198.175.65.19; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.505,
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

On Sun, Mar 30, 2025 at 06:32:28PM -0700, Dongli Zhang wrote:
> Date: Sun, 30 Mar 2025 18:32:28 -0700
> From: Dongli Zhang <dongli.zhang@oracle.com>
> Subject: [PATCH v3 09/10] target/i386/kvm: support perfmon-v2 for reset
> X-Mailer: git-send-email 2.43.5
> 
> Since perfmon-v2, the AMD PMU supports additional registers. This update
> includes get/put functionality for these extra registers.
> 
> Similar to the implementation in KVM:
> 
> - MSR_CORE_PERF_GLOBAL_STATUS and MSR_AMD64_PERF_CNTR_GLOBAL_STATUS both
> use env->msr_global_status.
> - MSR_CORE_PERF_GLOBAL_CTRL and MSR_AMD64_PERF_CNTR_GLOBAL_CTL both use
> env->msr_global_ctrl.
> - MSR_CORE_PERF_GLOBAL_OVF_CTRL and MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR
> both use env->msr_global_ovf_ctrl.
> 
> No changes are needed for vmstate_msr_architectural_pmu or
> pmu_enable_needed().
> 
> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
> ---

...

> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
> index 3a35fd741d..f4532e6f2a 100644
> --- a/target/i386/kvm/kvm.c
> +++ b/target/i386/kvm/kvm.c
> @@ -2149,6 +2149,16 @@ static void kvm_init_pmu_info_amd(struct kvm_cpuid2 *cpuid, X86CPU *cpu)
>      }
>  
>      num_pmu_gp_counters = AMD64_NUM_COUNTERS_CORE;
> +
> +    c = cpuid_find_entry(cpuid, 0x80000022, 0);
> +    if (c && (c->eax & CPUID_8000_0022_EAX_PERFMON_V2)) {
> +        pmu_version = 2;
> +        num_pmu_gp_counters = c->ebx & 0xf;
> +
> +        if (num_pmu_gp_counters > MAX_GP_COUNTERS) {
> +            num_pmu_gp_counters = MAX_GP_COUNTERS;

OK! KVM now supports 6 GP counters (KVM_MAX_NR_AMD_GP_COUNTERS).

> +        }
> +    }
>  }

Fine for me,

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


