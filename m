Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74C31C83013
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 05:12:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWpkD-0004aD-PN; Wed, 02 Jul 2025 01:10:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dapeng1.mi@linux.intel.com>)
 id 1uWpkC-0004Zv-Ho
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 01:10:52 -0400
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dapeng1.mi@linux.intel.com>)
 id 1uWpk8-0000oM-9i
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 01:10:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751433048; x=1782969048;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=vnDsnqkZVkFQ6WP3qoK7mtMNaceCb9TRU+GdjkvdOaQ=;
 b=Qzb1RQIQ1zqEwjE4Qeq5uidehBwGhXrRkq7BMpMsBlKmkR1T6nU+5/Cp
 A2/MI3jB25h4zCJBBKbnqdtgeMePfDCN0c2nB+gyMuaStlK+AUe+PI/E1
 MyzxiCq3RMrSN5E0JXaRaNbMeJkUugjuel/tHU9p1rRepaxz4NtoRRC1A
 pV+TJ3H/nxQlSPLlfrLyNg+GEn6XqejlKbcrZLaOKZG1cSaQbUsLrGKS+
 1rW5OlNv8558TdH8KYO5XCZ0hxAldpmUjWmOWE8FYOSoRvCemRuXwZKI8
 iX1TDcIrR3REs75s1ODDijWEJDf91SGGScMXy0yGjygXkokSC0dMn+STk A==;
X-CSE-ConnectionGUID: mv5qdwg5R7CCv5d9YpYSVg==
X-CSE-MsgGUID: WTrMp18lTc+EzDOvFOwlQA==
X-IronPort-AV: E=McAfee;i="6800,10657,11481"; a="52833059"
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; d="scan'208";a="52833059"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jul 2025 22:10:45 -0700
X-CSE-ConnectionGUID: yCyyxUsaTWi2NZOmBgoTAw==
X-CSE-MsgGUID: T9URMdmrTSCvmP35sRIXjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; d="scan'208";a="153432671"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.240.80])
 ([10.124.240.80])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jul 2025 22:10:40 -0700
Message-ID: <fb562fe3-285a-44a1-a323-d49b014eab0b@linux.intel.com>
Date: Wed, 2 Jul 2025 13:10:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 6/9] target/i386/kvm: query kvm.enable_pmu parameter
To: Dongli Zhang <dongli.zhang@oracle.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org
Cc: pbonzini@redhat.com, zhao1.liu@intel.com, mtosatti@redhat.com,
 sandipan.das@amd.com, babu.moger@amd.com, likexu@tencent.com,
 like.xu.linux@gmail.com, groug@kaod.org, khorenko@virtuozzo.com,
 alexander.ivanov@virtuozzo.com, den@virtuozzo.com,
 davydov-max@yandex-team.ru, xiaoyao.li@intel.com, joe.jin@oracle.com,
 ewanhai-oc@zhaoxin.com, ewanhai@zhaoxin.com
References: <20250624074421.40429-1-dongli.zhang@oracle.com>
 <20250624074421.40429-7-dongli.zhang@oracle.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20250624074421.40429-7-dongli.zhang@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=192.198.163.19;
 envelope-from=dapeng1.mi@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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


On 6/24/2025 3:43 PM, Dongli Zhang wrote:
> When PMU is enabled in QEMU, there is a chance that PMU virtualization is
> completely disabled by the KVM module parameter kvm.enable_pmu=N.
>
> The kvm.enable_pmu parameter is introduced since Linux v5.17.
> Its permission is 0444. It does not change until a reload of the KVM
> module.
>
> Read the kvm.enable_pmu value from the module sysfs to give a chance to
> provide more information about vPMU enablement.
>
> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
> ---
> Changed since v2:
>   - Rework the code flow following Zhao's suggestion.
>   - Return error when:
>     (*kvm_enable_pmu == 'N' && X86_CPU(cpu)->enable_pmu)
> Changed since v3:
>   - Re-split the cases into enable_pmu and !enable_pmu, following Zhao's
>     suggestion.
>   - Rework the commit messages.
>   - Bring back global static variable 'kvm_pmu_disabled' from v2.
> Changed since v4:
>   - Add Reviewed-by from Zhao.
> Changed since v5:
>   - Rebase on top of most recent QEMU.
>
>  target/i386/kvm/kvm.c | 61 +++++++++++++++++++++++++++++++------------
>  1 file changed, 44 insertions(+), 17 deletions(-)
>
> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
> index 824148688d..d191dd1da3 100644
> --- a/target/i386/kvm/kvm.c
> +++ b/target/i386/kvm/kvm.c
> @@ -186,6 +186,10 @@ static int has_triple_fault_event;
>  static bool has_msr_mcg_ext_ctl;
>  
>  static int pmu_cap;
> +/*
> + * Read from /sys/module/kvm/parameters/enable_pmu.
> + */
> +static bool kvm_pmu_disabled;
>  
>  static struct kvm_cpuid2 *cpuid_cache;
>  static struct kvm_cpuid2 *hv_cpuid_cache;
> @@ -2050,23 +2054,30 @@ int kvm_arch_pre_create_vcpu(CPUState *cpu, Error **errp)
>      if (first) {
>          first = false;
>  
> -        /*
> -         * Since Linux v5.18, KVM provides a VM-level capability to easily
> -         * disable PMUs; however, QEMU has been providing PMU property per
> -         * CPU since v1.6. In order to accommodate both, have to configure
> -         * the VM-level capability here.
> -         *
> -         * KVM_PMU_CAP_DISABLE doesn't change the PMU
> -         * behavior on Intel platform because current "pmu" property works
> -         * as expected.
> -         */
> -        if ((pmu_cap & KVM_PMU_CAP_DISABLE) && !X86_CPU(cpu)->enable_pmu) {
> -            ret = kvm_vm_enable_cap(kvm_state, KVM_CAP_PMU_CAPABILITY, 0,
> -                                    KVM_PMU_CAP_DISABLE);
> -            if (ret < 0) {
> -                error_setg_errno(errp, -ret,
> -                                 "Failed to set KVM_PMU_CAP_DISABLE");
> -                return ret;
> +        if (X86_CPU(cpu)->enable_pmu) {
> +            if (kvm_pmu_disabled) {
> +                warn_report("Failed to enable PMU since "
> +                            "KVM's enable_pmu parameter is disabled");
> +            }
> +        } else {
> +            /*
> +             * Since Linux v5.18, KVM provides a VM-level capability to easily
> +             * disable PMUs; however, QEMU has been providing PMU property per
> +             * CPU since v1.6. In order to accommodate both, have to configure
> +             * the VM-level capability here.
> +             *
> +             * KVM_PMU_CAP_DISABLE doesn't change the PMU
> +             * behavior on Intel platform because current "pmu" property works
> +             * as expected.
> +             */
> +            if (pmu_cap & KVM_PMU_CAP_DISABLE) {
> +                ret = kvm_vm_enable_cap(kvm_state, KVM_CAP_PMU_CAPABILITY, 0,
> +                                        KVM_PMU_CAP_DISABLE);
> +                if (ret < 0) {
> +                    error_setg_errno(errp, -ret,
> +                                     "Failed to set KVM_PMU_CAP_DISABLE");
> +                    return ret;
> +                }
>              }
>          }
>      }
> @@ -3273,6 +3284,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
>      int ret;
>      struct utsname utsname;
>      Error *local_err = NULL;
> +    g_autofree char *kvm_enable_pmu;
>  
>      /*
>       * Initialize confidential guest (SEV/TDX) context, if required
> @@ -3409,6 +3421,21 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
>  
>      pmu_cap = kvm_check_extension(s, KVM_CAP_PMU_CAPABILITY);
>  
> +    /*
> +     * The enable_pmu parameter is introduced since Linux v5.17,
> +     * give a chance to provide more information about vPMU
> +     * enablement.
> +     *
> +     * The kvm.enable_pmu's permission is 0444. It does not change
> +     * until a reload of the KVM module.
> +     */
> +    if (g_file_get_contents("/sys/module/kvm/parameters/enable_pmu",
> +                            &kvm_enable_pmu, NULL, NULL)) {
> +        if (*kvm_enable_pmu == 'N') {
> +            kvm_pmu_disabled = true;
> +        }
> +    }
> +
>      return 0;
>  }
>  
Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

