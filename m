Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CDFDF513EE
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 03:17:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyLgl-0007Wt-Dw; Thu, 05 Mar 2026 22:17:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dapeng1.mi@linux.intel.com>)
 id 1vyLgi-0007WC-SE
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 22:17:17 -0500
Received: from mgamail.intel.com ([192.198.163.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dapeng1.mi@linux.intel.com>)
 id 1vyLgg-0002I1-Bj
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 22:17:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772767034; x=1804303034;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=PtFCYUhxjLP3lWKnlSJfivIA+ShJwsAIokwzmLGIR/E=;
 b=VE8Dhlxu0uu5Nujb175yfviTuSos9IzU6nm6Bls45icdRWlT1OQR1lbY
 Yft88JgvF/+H8m8GI7OpYLKUe2P/lcce/+pm992shkELIW1hDY0gVe6jD
 awFiy/3EN2jTYuzNsbL3vJAI+JaigzEXV57OC5XcCDCftSkZET2S3o/Pa
 AIIfok4vw4UfH6VUG5ENo4zNU+069OEz6gQbqgZ2p4Od+JwtiXcuOkVR1
 wWJlX4vr/Ntlpvuih8U6kTFAfPKwzmrbIyxM5vCyqZLF47eCv0r86/2jR
 uhCyWEXJOSev6pKIiTqW+Pmfx9W05RBBtN4wRyA3D9fK2eGGiYFBeHrxT g==;
X-CSE-ConnectionGUID: DncU3Kv7T86A7gsixDAimQ==
X-CSE-MsgGUID: A+bkfUTrTTabr5LlWBXSJA==
X-IronPort-AV: E=McAfee;i="6800,10657,11720"; a="77741901"
X-IronPort-AV: E=Sophos;i="6.23,104,1770624000"; d="scan'208";a="77741901"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Mar 2026 19:17:10 -0800
X-CSE-ConnectionGUID: D/nNeNVWT3iKaYkAgKizwA==
X-CSE-MsgGUID: Nh57sl0TSoCm3v9lHDzL4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,104,1770624000"; d="scan'208";a="214835091"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.147])
 ([10.124.241.147])
 by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Mar 2026 19:17:07 -0800
Message-ID: <b6fce45c-0c81-4ac5-b469-f7b8ca50d7ff@linux.intel.com>
Date: Fri, 6 Mar 2026 11:17:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 07/13] target/i386: Add get/set/migrate support for
 legacy PEBS MSRs
To: Zide Chen <zide.chen@intel.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Sandipan Das <sandipan.das@amd.com>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, Dongli Zhang <dongli.zhang@oracle.com>
References: <20260304180713.360471-1-zide.chen@intel.com>
 <20260304180713.360471-8-zide.chen@intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260304180713.360471-8-zide.chen@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.198.163.12;
 envelope-from=dapeng1.mi@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.892, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.622,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

On 3/5/2026 2:07 AM, Zide Chen wrote:
> From: Dapeng Mi <dapeng1.mi@linux.intel.com>
>
> The legacy DS-based PEBS relies on IA32_DS_AREA and IA32_PEBS_ENABLE
> to take snapshots of a subset of the machine registers into the Intel
> Debug-Store.
>
> Adaptive PEBS introduces MSR_PEBS_DATA_CFG to be able to capture only
> the data of interest, which is enumerated via bit 14 (PEBS_BASELINE)
> of IA32_PERF_CAPABILITIES.
>
> QEMU must save, restore and migrate these MSRs when legacy PEBS is
> enabled.  Though the availability of these MSRs may not be the same,
> it's still valid to put them in the same vmstate subsection for
> implementation simplicity.
>
> Originally-by: Luwei Kang <luwei.kang@intel.com>
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Co-developed-by: Zide Chen <zide.chen@intel.com>
> Signed-off-by: Zide Chen <zide.chen@intel.com>
> ---
> V3:
> - Add the missing Originally-by tag to credit Luwei.
> - Fix the vmstate name of msr_ds_pebs.
> - Fix the criteria for determining availability of IA32_PEBS_ENABLE
>   and MSR_PEBS_DATA_CFG.
> - Change title to cover all aspects of what this patch does.
> - Re-work the commit messages.
> ---
>  target/i386/cpu.h     | 10 ++++++++++
>  target/i386/kvm/kvm.c | 29 +++++++++++++++++++++++++++++
>  target/i386/machine.c | 27 ++++++++++++++++++++++++++-
>  3 files changed, 65 insertions(+), 1 deletion(-)
>
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index 7c241a20420c..3a10f3242329 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -422,6 +422,7 @@ typedef enum X86Seg {
>  #define MSR_IA32_PERF_CAPABILITIES      0x345
>  #define PERF_CAP_LBR_FMT                0x3f
>  #define PERF_CAP_FULL_WRITE             (1U << 13)
> +#define PERF_CAP_PEBS_BASELINE          (1U << 14)
>  
>  #define MSR_IA32_TSX_CTRL		0x122
>  #define MSR_IA32_TSCDEADLINE            0x6e0
> @@ -479,6 +480,7 @@ typedef enum X86Seg {
>  /* Indicates good rep/movs microcode on some processors: */
>  #define MSR_IA32_MISC_ENABLE_FASTSTRING    (1ULL << 0)
>  #define MSR_IA32_MISC_ENABLE_BTS_UNAVAIL   (1ULL << 11)
> +#define MSR_IA32_MISC_ENABLE_PEBS_UNAVAIL  (1ULL << 12)
>  #define MSR_IA32_MISC_ENABLE_MWAIT      (1ULL << 18)
>  #define MSR_IA32_MISC_ENABLE_DEFAULT    (MSR_IA32_MISC_ENABLE_FASTSTRING     | \
>                                           MSR_IA32_MISC_ENABLE_BTS_UNAVAIL)
> @@ -514,6 +516,11 @@ typedef enum X86Seg {
>  #define MSR_AMD64_PERF_CNTR_GLOBAL_STATUS       0xc0000300
>  #define MSR_AMD64_PERF_CNTR_GLOBAL_CTL          0xc0000301
>  
> +/* Legacy DS based PEBS MSRs */
> +#define MSR_IA32_PEBS_ENABLE            0x3f1
> +#define MSR_PEBS_DATA_CFG               0x3f2
> +#define MSR_IA32_DS_AREA                0x600
> +
>  #define MSR_K7_EVNTSEL0                 0xc0010000
>  #define MSR_K7_PERFCTR0                 0xc0010004
>  #define MSR_F15H_PERF_CTL0              0xc0010200
> @@ -2099,6 +2106,9 @@ typedef struct CPUArchState {
>      uint64_t msr_fixed_ctr_ctrl;
>      uint64_t msr_global_ctrl;
>      uint64_t msr_global_status;
> +    uint64_t msr_ds_area;
> +    uint64_t msr_pebs_data_cfg;
> +    uint64_t msr_pebs_enable;
>      uint64_t msr_fixed_counters[MAX_FIXED_COUNTERS];
>      uint64_t msr_gp_counters[MAX_GP_COUNTERS];
>      uint64_t msr_gp_evtsel[MAX_GP_COUNTERS];
> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
> index 4ba54151320f..8c4564bcbb9e 100644
> --- a/target/i386/kvm/kvm.c
> +++ b/target/i386/kvm/kvm.c
> @@ -4280,6 +4280,16 @@ static int kvm_put_msrs(X86CPU *cpu, KvmPutState level)
>                  kvm_msr_entry_add(cpu, MSR_CORE_PERF_GLOBAL_CTRL, 0);
>              }
>  
> +            if (env->features[FEAT_1_EDX] & CPUID_DTS) {
> +                kvm_msr_entry_add(cpu, MSR_IA32_DS_AREA, env->msr_ds_area);
> +            }
> +            if (!(env->msr_ia32_misc_enable & MSR_IA32_MISC_ENABLE_PEBS_UNAVAIL)) {
> +                kvm_msr_entry_add(cpu, MSR_IA32_PEBS_ENABLE, env->msr_pebs_enable);
> +            }
> +            if (env->features[FEAT_PERF_CAPABILITIES] & PERF_CAP_PEBS_BASELINE) {
> +                kvm_msr_entry_add(cpu, MSR_PEBS_DATA_CFG, env->msr_pebs_data_cfg);
> +            }
> +
>              /* Set the counter values.  */
>              for (i = 0; i < num_pmu_fixed_counters; i++) {
>                  kvm_msr_entry_add(cpu, MSR_CORE_PERF_FIXED_CTR0 + i,
> @@ -4900,6 +4910,16 @@ static int kvm_get_msrs(X86CPU *cpu)
>              kvm_msr_entry_add(cpu, MSR_AMD64_PERF_CNTR_GLOBAL_CTL, 0);
>              kvm_msr_entry_add(cpu, MSR_AMD64_PERF_CNTR_GLOBAL_STATUS, 0);
>          }
> +
> +        if (env->features[FEAT_1_EDX] & CPUID_DTS) {
> +            kvm_msr_entry_add(cpu, MSR_IA32_DS_AREA, 0);
> +        }
> +        if (!(env->msr_ia32_misc_enable & MSR_IA32_MISC_ENABLE_PEBS_UNAVAIL)) {
> +            kvm_msr_entry_add(cpu, MSR_IA32_PEBS_ENABLE, 0);
> +        }
> +        if (env->features[FEAT_PERF_CAPABILITIES] & PERF_CAP_PEBS_BASELINE) {
> +            kvm_msr_entry_add(cpu, MSR_PEBS_DATA_CFG, 0);
> +        }
>      }
>  
>      if (env->mcg_cap) {
> @@ -5241,6 +5261,15 @@ static int kvm_get_msrs(X86CPU *cpu)
>                  env->msr_gp_evtsel[index] = msrs[i].data;
>              }
>              break;
> +        case MSR_IA32_DS_AREA:
> +            env->msr_ds_area = msrs[i].data;
> +            break;
> +        case MSR_PEBS_DATA_CFG:
> +            env->msr_pebs_data_cfg = msrs[i].data;
> +            break;
> +        case MSR_IA32_PEBS_ENABLE:
> +            env->msr_pebs_enable = msrs[i].data;
> +            break;
>          case HV_X64_MSR_HYPERCALL:
>              env->msr_hv_hypercall = msrs[i].data;
>              break;
> diff --git a/target/i386/machine.c b/target/i386/machine.c
> index 7d08a05835fc..5cff5d5a9db5 100644
> --- a/target/i386/machine.c
> +++ b/target/i386/machine.c
> @@ -659,6 +659,27 @@ static const VMStateDescription vmstate_msr_ia32_feature_control = {
>      }
>  };
>  
> +static bool ds_pebs_enabled(void *opaque)
> +{
> +    X86CPU *cpu = opaque;
> +    CPUX86State *env = &cpu->env;
> +
> +    return (env->msr_ds_area || env->msr_pebs_enable ||
> +            env->msr_pebs_data_cfg);
> +}
> +
> +static const VMStateDescription vmstate_msr_ds_pebs = {
> +    .name = "cpu/msr_architectural_pmu/msr_ds_pebs",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .needed = ds_pebs_enabled,
> +    .fields = (const VMStateField[]){
> +        VMSTATE_UINT64(env.msr_ds_area, X86CPU),
> +        VMSTATE_UINT64(env.msr_pebs_data_cfg, X86CPU),
> +        VMSTATE_UINT64(env.msr_pebs_enable, X86CPU),
> +        VMSTATE_END_OF_LIST()}
> +};
> +
>  static bool pmu_enable_needed(void *opaque)
>  {
>      X86CPU *cpu = opaque;
> @@ -697,7 +718,11 @@ static const VMStateDescription vmstate_msr_architectural_pmu = {
>          VMSTATE_UINT64_ARRAY(env.msr_gp_counters, X86CPU, MAX_GP_COUNTERS),
>          VMSTATE_UINT64_ARRAY(env.msr_gp_evtsel, X86CPU, MAX_GP_COUNTERS),
>          VMSTATE_END_OF_LIST()
> -    }
> +    },
> +    .subsections = (const VMStateDescription * const []) {
> +        &vmstate_msr_ds_pebs,
> +        NULL,
> +    },
>  };
>  
>  static bool mpx_needed(void *opaque)

