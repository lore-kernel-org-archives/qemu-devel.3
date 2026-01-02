Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 732C7FA3727
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Jan 2026 23:00:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vbo7C-0007MI-DE; Fri, 02 Jan 2026 17:59:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zide.chen@intel.com>)
 id 1vbo77-0007Kk-Sa
 for qemu-devel@nongnu.org; Fri, 02 Jan 2026 17:59:22 -0500
Received: from mgamail.intel.com ([198.175.65.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zide.chen@intel.com>)
 id 1vbo75-0002xb-8J
 for qemu-devel@nongnu.org; Fri, 02 Jan 2026 17:59:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1767394759; x=1798930759;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=D20EtKNYAY+TWKUOPiodzmWKx69NyYfF3aLv9FA9bKk=;
 b=F0dTlJlMfEo+BRlq5N/g4vASU+H58wtKa/UZ/pSEWcri+Vf0Xeh2won5
 mN2YObTbvp37yU/6Y9gkeFBKhd/UPner5tEHTdcBx8Wm+zAizn37+2RDf
 Ezqcr4SXazGO1/huYHxCApzRBK6UCg4ORlusxI0iLyds8kxHWjFYRUmNF
 Ga83dKqlJapmPn/tfKAOq9zn8pXDgHiw3qII5bx5sysqpbZRZ39vbKE+S
 RdtcU7FT7CqXE3lY2XlXmHgNgy+f0NNfJMdfitknT8zhbpTpbFIF7DR6g
 ZXgWYVOgLMWzaWDEc5Mibj0bfSOd9fO2jdCm10kMvhoiwS9AL0GT+wQab A==;
X-CSE-ConnectionGUID: 0AFE3iCPSBWJrXE4peq7WQ==
X-CSE-MsgGUID: 9cLqxJa8S4upQoCR6l6Cqw==
X-IronPort-AV: E=McAfee;i="6800,10657,11659"; a="68862164"
X-IronPort-AV: E=Sophos;i="6.21,198,1763452800"; d="scan'208";a="68862164"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jan 2026 14:59:15 -0800
X-CSE-ConnectionGUID: vRiXAqa6SEOb//OBkJgM0g==
X-CSE-MsgGUID: bicxgchGTNWycW3NUEgpSA==
X-ExtLoop1: 1
Received: from soc-cp83kr3.clients.intel.com (HELO [10.241.240.111])
 ([10.241.240.111])
 by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jan 2026 14:59:14 -0800
Message-ID: <b6c531d4-328d-48a7-856b-051c918c24ae@intel.com>
Date: Fri, 2 Jan 2026 14:59:13 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 4/7] target/i386/kvm: query kvm.enable_pmu parameter
To: Dongli Zhang <dongli.zhang@oracle.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org
Cc: pbonzini@redhat.com, zhao1.liu@intel.com, mtosatti@redhat.com,
 sandipan.das@amd.com, babu.moger@amd.com, likexu@tencent.com,
 like.xu.linux@gmail.com, groug@kaod.org, khorenko@virtuozzo.com,
 alexander.ivanov@virtuozzo.com, den@virtuozzo.com,
 davydov-max@yandex-team.ru, xiaoyao.li@intel.com,
 dapeng1.mi@linux.intel.com, joe.jin@oracle.com, ewanhai-oc@zhaoxin.com,
 ewanhai@zhaoxin.com
References: <20251230074354.88958-1-dongli.zhang@oracle.com>
 <20251230074354.88958-5-dongli.zhang@oracle.com>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <20251230074354.88958-5-dongli.zhang@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.17; envelope-from=zide.chen@intel.com;
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



On 12/29/2025 11:42 PM, Dongli Zhang wrote:
> When PMU is enabled in QEMU, there is a chance that PMU virtualization is
> completely disabled by the KVM module parameter kvm.enable_pmu=N.
> 
> The kvm.enable_pmu parameter is introduced since Linux v5.17.
> Its permission is 0444. It does not change until a reload of the KVM
> module.
> 
> Read the kvm.enable_pmu value from the module sysfs to give a chance to
> provide more information about vPMU enablement.> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
> Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
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
> Changed since v6:
>   - Add Reviewed-by from Dapeng Mi.
> 
>  target/i386/kvm/kvm.c | 61 +++++++++++++++++++++++++++++++------------
>  1 file changed, 44 insertions(+), 17 deletions(-)
> 
> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
> index 3b803c662d..338b9558e4 100644
> --- a/target/i386/kvm/kvm.c
> +++ b/target/i386/kvm/kvm.c
> @@ -187,6 +187,10 @@ static int has_triple_fault_event;
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
> @@ -2068,23 +2072,30 @@ int kvm_arch_pre_create_vcpu(CPUState *cpu, Error **errp)
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

I'm wondering about the intended value of this patch?

If enable_pmu is true in QEMU but the corresponding KVM parameter is
false, then KVM_GET_SUPPORTED_CPUID or KVM_GET_MSRS should be able to
tell that the PMU feature is not supported by host.

The logic implemented in this patch seems somewhat redundant.

Additionally, in this scenario — where the user intends to enable a
feature but the host cannot support it — normally no warning is emitted
by QEMU.

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
> @@ -3302,6 +3313,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
>      int ret;
>      struct utsname utsname;
>      Error *local_err = NULL;
> +    g_autofree char *kvm_enable_pmu;
>  
>      /*
>       * Initialize confidential guest (SEV/TDX) context, if required
> @@ -3437,6 +3449,21 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
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

It’s generally better not to rely on KVM’s internal implementation
unless really necessary.

For example, in the new mediated vPMU framework, even if the KVM module
parameter enable_pmu is set, the per-guest kvm->arch.enable_pmu could
still be cleared.

In such a case, the logic here might not be correct.

> +        }
> +    }
> +
>      return 0;
>  }
>  


