Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A39F1F513F8
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 05:37:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyNsD-0002VP-1v; Fri, 06 Mar 2026 00:37:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dapeng1.mi@linux.intel.com>)
 id 1vyNsA-0002V8-Lk
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 00:37:14 -0500
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dapeng1.mi@linux.intel.com>)
 id 1vyNs8-0003mI-SB
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 00:37:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772775433; x=1804311433;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=3j82WyUflnJOrnQUQDQg1X89lw9l2xXyQpwpjg187zw=;
 b=dzXa5lbsY+96O6cF4eeHjR/RJkOID4yE+JlcMRM9IBIZD5+3g7s9LXHo
 +5oZuu7W6D/qBNx0VqqbK/6Rr4egYHDO47WxkGx3E7gO8/Mbgc1K+EREH
 WUGsOx4Gu1/bEWcXsX5euH4QZAtzkcrn08m/of4I4Ik07/iKCevGubDvW
 j6lXq28Dojzydc7iPJ698dWEJ6AaF7j8ccpNjL8LMfhkBVQ0vCA3ASy27
 hd8jtrOCauuDOdpB/mEEjQhHqmlI2x3xQpytTULk11S0Zdc0frLUerNqf
 YGr/RQYWRAdFDH2jXoE6eE3jBI19lLRRMB1t6fk8wWyjJ95QqwkxD+5Oj A==;
X-CSE-ConnectionGUID: ElCc6PazR4+LaOB31/JdrQ==
X-CSE-MsgGUID: 0Xc5SPM+QjyvbxdV+6VOgA==
X-IronPort-AV: E=McAfee;i="6800,10657,11720"; a="85227888"
X-IronPort-AV: E=Sophos;i="6.23,104,1770624000"; d="scan'208";a="85227888"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Mar 2026 21:37:06 -0800
X-CSE-ConnectionGUID: KtR5zKE6SBKiVqe/2gBfSw==
X-CSE-MsgGUID: 535IJ0eVTqO6PIZxF55elA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,104,1770624000"; d="scan'208";a="216074971"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.147])
 ([10.124.241.147])
 by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Mar 2026 21:37:03 -0800
Message-ID: <7a09bdbc-750b-4248-80a5-a03341cf5fcc@linux.intel.com>
Date: Fri, 6 Mar 2026 13:37:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 13/13] target/i386: Add Topdown metrics feature support
To: Zide Chen <zide.chen@intel.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Sandipan Das <sandipan.das@amd.com>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, Dongli Zhang <dongli.zhang@oracle.com>
References: <20260304180713.360471-1-zide.chen@intel.com>
 <20260304180713.360471-14-zide.chen@intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260304180713.360471-14-zide.chen@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.198.163.10;
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
> IA32_PERF_CAPABILITIES.PERF_METRICS_AVAILABLE (bit 15) indicates that
> the CPU provides built-in support for TMA L1 metrics through
> the PERF_METRICS MSR.  Expose it as a user-visible CPU feature
> ("perf-metrics"), allowing it to be explicitly enabled or disabled and
> used with migratable guests.
>
> Plumb IA32_PERF_METRICS through the KVM MSR get/put paths to be able
> to save and restore this MSR.
>
> Migrate IA32_PERF_METRICS MSR using a new subsection of
> vmstate_msr_architectural_pmu.
>
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Co-developed-by: Zide Chen <zide.chen@intel.com>
> Signed-off-by: Zide Chen <zide.chen@intel.com>
> ---
> V3: New patch
> ---
>  target/i386/cpu.c     |  2 +-
>  target/i386/cpu.h     |  3 +++
>  target/i386/kvm/kvm.c | 10 ++++++++++
>  target/i386/machine.c | 19 +++++++++++++++++++
>  4 files changed, 33 insertions(+), 1 deletion(-)
>
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 3ff9f76cf7da..88cfd3529851 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -1620,7 +1620,7 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
>              NULL, NULL, NULL, NULL,
>              NULL, NULL, "pebs-trap", "pebs-arch-reg",
>              NULL, NULL, NULL, NULL,
> -            NULL, "full-width-write", "pebs-baseline", NULL,
> +            NULL, "full-width-write", "pebs-baseline", "perf-metrics",
>              NULL, "pebs-timing-info", NULL, NULL,
>              NULL, NULL, NULL, NULL,
>              NULL, NULL, NULL, NULL,
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index 6a9820c4041a..5d0ed692ae06 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -428,6 +428,7 @@ typedef enum X86Seg {
>                                           PERF_CAP_PEBS_FMT_SHIFT)
>  #define PERF_CAP_FULL_WRITE             (1U << 13)
>  #define PERF_CAP_PEBS_BASELINE          (1U << 14)
> +#define PERF_CAP_TOPDOWN                (1U << 15)
>  
>  #define MSR_IA32_TSX_CTRL		0x122
>  #define MSR_IA32_TSCDEADLINE            0x6e0
> @@ -514,6 +515,7 @@ typedef enum X86Seg {
>  #define MSR_CORE_PERF_FIXED_CTR0        0x309
>  #define MSR_CORE_PERF_FIXED_CTR1        0x30a
>  #define MSR_CORE_PERF_FIXED_CTR2        0x30b
> +#define MSR_PERF_METRICS                0x329
>  #define MSR_CORE_PERF_FIXED_CTR_CTRL    0x38d
>  #define MSR_CORE_PERF_GLOBAL_STATUS     0x38e
>  #define MSR_CORE_PERF_GLOBAL_CTRL       0x38f
> @@ -2111,6 +2113,7 @@ typedef struct CPUArchState {
>      uint64_t msr_fixed_ctr_ctrl;
>      uint64_t msr_global_ctrl;
>      uint64_t msr_global_status;
> +    uint64_t msr_perf_metrics;
>      uint64_t msr_ds_area;
>      uint64_t msr_pebs_data_cfg;
>      uint64_t msr_pebs_enable;
> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
> index 8c4564bcbb9e..3f533cd65708 100644
> --- a/target/i386/kvm/kvm.c
> +++ b/target/i386/kvm/kvm.c
> @@ -4295,6 +4295,10 @@ static int kvm_put_msrs(X86CPU *cpu, KvmPutState level)
>                  kvm_msr_entry_add(cpu, MSR_CORE_PERF_FIXED_CTR0 + i,
>                                    env->msr_fixed_counters[i]);
>              }
> +            /* SDM: Write IA32_PERF_METRICS after fixed counter 3. */
> +            if (env->features[FEAT_PERF_CAPABILITIES] & PERF_CAP_TOPDOWN) {
> +                    kvm_msr_entry_add(cpu, MSR_PERF_METRICS, env->msr_perf_metrics);
> +            }
>              for (i = 0; i < num_pmu_gp_counters; i++) {
>                  kvm_msr_entry_add(cpu, perf_cntr_base + i,
>                                    env->msr_gp_counters[i]);
> @@ -4868,6 +4872,9 @@ static int kvm_get_msrs(X86CPU *cpu)
>              kvm_msr_entry_add(cpu, MSR_CORE_PERF_GLOBAL_CTRL, 0);
>              kvm_msr_entry_add(cpu, MSR_CORE_PERF_GLOBAL_STATUS, 0);
>          }
> +        if (env->features[FEAT_PERF_CAPABILITIES] & PERF_CAP_TOPDOWN) {
> +            kvm_msr_entry_add(cpu, MSR_PERF_METRICS, 0);
> +        }
>          for (i = 0; i < num_pmu_fixed_counters; i++) {
>              kvm_msr_entry_add(cpu, MSR_CORE_PERF_FIXED_CTR0 + i, 0);
>          }
> @@ -5234,6 +5241,9 @@ static int kvm_get_msrs(X86CPU *cpu)
>          case MSR_AMD64_PERF_CNTR_GLOBAL_STATUS:
>              env->msr_global_status = msrs[i].data;
>              break;
> +        case MSR_PERF_METRICS:
> +            env->msr_perf_metrics = msrs[i].data;
> +            break;
>          case MSR_CORE_PERF_FIXED_CTR0 ... MSR_CORE_PERF_FIXED_CTR0 + MAX_FIXED_COUNTERS - 1:
>              env->msr_fixed_counters[index - MSR_CORE_PERF_FIXED_CTR0] = msrs[i].data;
>              break;
> diff --git a/target/i386/machine.c b/target/i386/machine.c
> index 5cff5d5a9db5..6b7141cfead7 100644
> --- a/target/i386/machine.c
> +++ b/target/i386/machine.c
> @@ -680,6 +680,24 @@ static const VMStateDescription vmstate_msr_ds_pebs = {
>          VMSTATE_END_OF_LIST()}
>  };
>  
> +static bool perf_metrics_enabled(void *opaque)
> +{
> +    X86CPU *cpu = opaque;
> +    CPUX86State *env = &cpu->env;
> +
> +    return !!env->msr_perf_metrics;
> +}
> +
> +static const VMStateDescription vmstate_msr_perf_metrics = {
> +    .name = "cpu/msr_architectural_pmu/msr_perf_metrics",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .needed = perf_metrics_enabled,
> +    .fields = (const VMStateField[]){
> +        VMSTATE_UINT64(env.msr_perf_metrics, X86CPU),
> +        VMSTATE_END_OF_LIST()}
> +};
> +
>  static bool pmu_enable_needed(void *opaque)
>  {
>      X86CPU *cpu = opaque;
> @@ -721,6 +739,7 @@ static const VMStateDescription vmstate_msr_architectural_pmu = {
>      },
>      .subsections = (const VMStateDescription * const []) {
>          &vmstate_msr_ds_pebs,
> +        &vmstate_msr_perf_metrics,
>          NULL,
>      },
>  };

