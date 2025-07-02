Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D70FC83038
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 03:49:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWoSL-0004ej-V6; Tue, 01 Jul 2025 23:48:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dapeng1.mi@linux.intel.com>)
 id 1uWoSI-0004eE-EA
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 23:48:19 -0400
Received: from mgamail.intel.com ([192.198.163.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dapeng1.mi@linux.intel.com>)
 id 1uWoSB-0005Ue-3u
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 23:48:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751428091; x=1782964091;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=dUJSWas4bJCDz+3vCVgh4blko/WfxGUXU9eqB5oU+gI=;
 b=lRDlYBWhWPbYqjAYQ66wS3rZbhvvUesrnozXD9zZhLImcOhOZXUy6s1p
 1zQdETsQreRJ8Xa9R9FzRBXwzO+s5elbYCg9GuNawg9Jt+XmX/Q7H22+S
 RcTODuN/vmshUXDe7TRA1WsY5kWuwqJmC4M1AImCdyrwxlKwml21Ez7Rk
 K4lM59ka4x6PavqeV/VgnAOyJl70QJuR+AHhrqHkdNf0ewyn2znZF+Wr9
 P33+hoaS8aGLbsImwNHWMbnGIpQrXXGjghEqTe9wfZuiHNNcLU/3w7FWd
 Y80LhOIwJp9Zi4lgNk3OZx3hj22XsfGzayekOt1isBdoL4o3wM5iczlmT w==;
X-CSE-ConnectionGUID: knIZCn7yQjiTDRRRdNIeaw==
X-CSE-MsgGUID: pqBvgYaATcq3S5qHgVAqdA==
X-IronPort-AV: E=McAfee;i="6800,10657,11481"; a="57518073"
X-IronPort-AV: E=Sophos;i="6.16,280,1744095600"; d="scan'208";a="57518073"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jul 2025 20:48:03 -0700
X-CSE-ConnectionGUID: ypFfP/t6Q6ywZOmI6/widQ==
X-CSE-MsgGUID: Ragv6DtvRdGCKD68XPdxuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,280,1744095600"; d="scan'208";a="153578290"
Received: from jiatingt-mobl.ccr.corp.intel.com (HELO [10.124.240.80])
 ([10.124.240.80])
 by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jul 2025 20:47:58 -0700
Message-ID: <9f75dc33-303a-4b04-a30d-cd530676108d@linux.intel.com>
Date: Wed, 2 Jul 2025 11:47:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/9] target/i386/kvm: set KVM_PMU_CAP_DISABLE if "-pmu"
 is configured
To: Dongli Zhang <dongli.zhang@oracle.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org
Cc: pbonzini@redhat.com, zhao1.liu@intel.com, mtosatti@redhat.com,
 sandipan.das@amd.com, babu.moger@amd.com, likexu@tencent.com,
 like.xu.linux@gmail.com, groug@kaod.org, khorenko@virtuozzo.com,
 alexander.ivanov@virtuozzo.com, den@virtuozzo.com,
 davydov-max@yandex-team.ru, xiaoyao.li@intel.com, joe.jin@oracle.com,
 ewanhai-oc@zhaoxin.com, ewanhai@zhaoxin.com
References: <20250624074421.40429-1-dongli.zhang@oracle.com>
 <20250624074421.40429-4-dongli.zhang@oracle.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20250624074421.40429-4-dongli.zhang@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=192.198.163.12;
 envelope-from=dapeng1.mi@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
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
> Although AMD PERFCORE and PerfMonV2 are removed when "-pmu" is configured,
> there is no way to fully disable KVM AMD PMU virtualization. Neither
> "-cpu host,-pmu" nor "-cpu EPYC" achieves this.
>
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
> Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
> ---
> Changed since v1:
>   - Switch back to the initial implementation with "-pmu".
> https://lore.kernel.org/all/20221119122901.2469-3-dongli.zhang@oracle.com
>   - Mention that "KVM_PMU_CAP_DISABLE doesn't change the PMU behavior on
>     Intel platform because current "pmu" property works as expected."
> Changed since v2:
>   - Change has_pmu_cap to pmu_cap.
>   - Use (pmu_cap & KVM_PMU_CAP_DISABLE) instead of only pmu_cap in if
>     statement.
>   - Add Reviewed-by from Xiaoyao and Zhao as the change is minor.
> Changed since v5:
>   - Re-base on top of most recent mainline QEMU.
>   - To resolve conflicts, move the PMU related code before the
>     call site of is_tdx_vm().
>
>  target/i386/kvm/kvm.c | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
>
> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
> index 234878c613..15155b79b5 100644
> --- a/target/i386/kvm/kvm.c
> +++ b/target/i386/kvm/kvm.c
> @@ -178,6 +178,8 @@ static int has_triple_fault_event;
>  
>  static bool has_msr_mcg_ext_ctl;
>  
> +static int pmu_cap;
> +
>  static struct kvm_cpuid2 *cpuid_cache;
>  static struct kvm_cpuid2 *hv_cpuid_cache;
>  static struct kvm_msr_list *kvm_feature_msrs;
> @@ -2062,6 +2064,33 @@ full:
>  
>  int kvm_arch_pre_create_vcpu(CPUState *cpu, Error **errp)
>  {
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
> +        if ((pmu_cap & KVM_PMU_CAP_DISABLE) && !X86_CPU(cpu)->enable_pmu) {
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
>      if (is_tdx_vm()) {
>          return tdx_pre_create_vcpu(cpu, errp);
>      }
> @@ -3363,6 +3392,8 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
>          }
>      }
>  
> +    pmu_cap = kvm_check_extension(s, KVM_CAP_PMU_CAPABILITY);
> +
>      return 0;
>  }
>  

LGTM.

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>


