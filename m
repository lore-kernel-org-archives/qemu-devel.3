Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85987C021B8
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Mar 2025 08:00:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpNCL-0000Q4-NL; Tue, 04 Mar 2025 03:00:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tpNBm-0000Bn-G8
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 02:59:45 -0500
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tpNBh-0003IP-VU
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 02:59:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1741075178; x=1772611178;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=fStzAgDO0dDP/vwo04uzV8D13FdB8wbm/NHcgdjt3ZQ=;
 b=gNyaAOjnwcTK8QKpsS2ZkE2Eut2TRdHhJD4DK5joliiL2+oycDq192kx
 kMNB9/n8h7bkrsnXJEZY91eIdwQd72gE0lgCwdUWgPzpqiY1USaMH0iAW
 bJFErzijDpg2WEWGGP0JFkE51nlDvKmQLDEPRykl7OdNUAibTCFPYiJXl
 7CFG83cLnHvbf9xXn8zj2014JmRV0jzo+3V4d9gqp8hn9YcQ4gxKnQnty
 3DSFbH1KXUhDn280oUCoF74bmxepFr5z9EdLwNr2f8oMlTklGi9k2gcpo
 oHjmpqhwJxdti0b7Jt+REtQzmmBk4TKs2hxP1L7Bj0l6xf+beSFIQVHau w==;
X-CSE-ConnectionGUID: 4VApCfSxSDC5ARdRGs2g5g==
X-CSE-MsgGUID: rsPv72FHQ46Jes89MfHCBQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11362"; a="41888634"
X-IronPort-AV: E=Sophos;i="6.13,331,1732608000"; d="scan'208";a="41888634"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Mar 2025 23:59:34 -0800
X-CSE-ConnectionGUID: L6ZQuwHCQYydl+Zxmm56sA==
X-CSE-MsgGUID: kmL3LGcoQi+OvI0u7sXtwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,331,1732608000"; d="scan'208";a="118087272"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Mar 2025 23:59:29 -0800
Message-ID: <76da2b4a-2dc4-417c-91bc-ad29e08c8ba0@intel.com>
Date: Tue, 4 Mar 2025 15:59:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/10] target/i386/kvm: set KVM_PMU_CAP_DISABLE if
 "-pmu" is configured
To: Dongli Zhang <dongli.zhang@oracle.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org
Cc: pbonzini@redhat.com, zhao1.liu@intel.com, mtosatti@redhat.com,
 sandipan.das@amd.com, babu.moger@amd.com, likexu@tencent.com,
 like.xu.linux@gmail.com, zhenyuw@linux.intel.com, groug@kaod.org,
 khorenko@virtuozzo.com, alexander.ivanov@virtuozzo.com, den@virtuozzo.com,
 davydov-max@yandex-team.ru, dapeng1.mi@linux.intel.com, joe.jin@oracle.com
References: <20250302220112.17653-1-dongli.zhang@oracle.com>
 <20250302220112.17653-5-dongli.zhang@oracle.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20250302220112.17653-5-dongli.zhang@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=198.175.65.21; envelope-from=xiaoyao.li@intel.com;
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

On 3/3/2025 6:00 AM, Dongli Zhang wrote:
> Although AMD PERFCORE and PerfMonV2 are removed when "-pmu" is configured,
> there is no way to fully disable KVM AMD PMU virtualization. Neither
> "-cpu host,-pmu" nor "-cpu EPYC" achieves this.

This looks like a KVM bug.

Anyway, since QEMU can achieve its goal with KVM_PMU_CAP_DISABLE with 
current KVM, I'm fine with it.

I have one nit below, otherwise

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

> As a result, the following message still appears in the VM dmesg:
> 
> [    0.263615] Performance Events: AMD PMU driver.
> 
> However, the expected output should be:
> 
> [    0.596381] Performance Events: PMU not available due to virtualization, using software events only.
> [    0.600972] NMI watchdog: Perf NMI watchdog permanently disabled
> 
> This occurs because AMD does not use any CPUID bit to indicate PMU
> availability.
> 
> To address this, KVM_CAP_PMU_CAPABILITY is used to set KVM_PMU_CAP_DISABLE
> when "-pmu" is configured.
> 
> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
> ---
> Changed since v1:
>    - Switch back to the initial implementation with "-pmu".
> https://lore.kernel.org/all/20221119122901.2469-3-dongli.zhang@oracle.com
>    - Mention that "KVM_PMU_CAP_DISABLE doesn't change the PMU behavior on
>      Intel platform because current "pmu" property works as expected."
> 
>   target/i386/kvm/kvm.c | 31 +++++++++++++++++++++++++++++++
>   1 file changed, 31 insertions(+)
> 
> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
> index f41e190fb8..5c8a852dbd 100644
> --- a/target/i386/kvm/kvm.c
> +++ b/target/i386/kvm/kvm.c
> @@ -176,6 +176,8 @@ static int has_triple_fault_event;
>   
>   static bool has_msr_mcg_ext_ctl;
>   
> +static int has_pmu_cap;
> +
>   static struct kvm_cpuid2 *cpuid_cache;
>   static struct kvm_cpuid2 *hv_cpuid_cache;
>   static struct kvm_msr_list *kvm_feature_msrs;
> @@ -2053,6 +2055,33 @@ full:
>   
>   int kvm_arch_pre_create_vcpu(CPUState *cpu, Error **errp)
>   {
> +    static bool first = true;
> +    int ret;
> +
> +    if (first) {
> +        first = false;
> +
> +        /*
> +         * Since Linux v5.18, KVM provides a VM-level capability to easily
> +         * disable PMUs; however, QEMU has been providing PMU property per
> +         * CPU since v1.6. In order to accommodate both, have to configure
> +         * the VM-level capability here.
> +         *
> +         * KVM_PMU_CAP_DISABLE doesn't change the PMU
> +         * behavior on Intel platform because current "pmu" property works
> +         * as expected.
> +         */
> +        if (has_pmu_cap && !X86_CPU(cpu)->enable_pmu) {

One nit, it's safer to use

	(has_pmu_cap & KVM_PMU_CAP_DISABLE) && !X86_CPU(cpu)->enable_pmu

Maybe we can rename has_pmu_cap to pmu_cap as well.

> +            ret = kvm_vm_enable_cap(kvm_state, KVM_CAP_PMU_CAPABILITY, 0,
> +                                    KVM_PMU_CAP_DISABLE);
> +            if (ret < 0) {
> +                error_setg_errno(errp, -ret,
> +                                 "Failed to set KVM_PMU_CAP_DISABLE");
> +                return ret;
> +            }
> +        }
> +    }
> +
>       return 0;
>   }
>   
> @@ -3351,6 +3380,8 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
>           }
>       }
>   
> +    has_pmu_cap = kvm_check_extension(s, KVM_CAP_PMU_CAPABILITY);
> +
>       return 0;
>   }
>   


