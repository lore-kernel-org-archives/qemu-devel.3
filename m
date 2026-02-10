Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9501FEA3F0F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 07:15:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vphxe-0004eF-5k; Tue, 10 Feb 2026 02:15:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dapeng1.mi@linux.intel.com>)
 id 1vphxc-0004d8-Ie
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 02:15:00 -0500
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dapeng1.mi@linux.intel.com>)
 id 1vphxZ-0006Jl-MY
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 02:15:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770707698; x=1802243698;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=skPpdXck19RJFs/p+cWcI0O12SRZOQZ8nvGFWWjcjpY=;
 b=bbsWoETfJXBN/GWeJh0etn/bdebNt0cCIbc1H5Ta4wyB/Y7AtC8naCKY
 +TVjHZkJQDnN69eVSyOYzFsT1JWHxOBZzViz+Ay67i9vb5sM2neUnn7qC
 m5BxnG62y26dgjyt2IDAC+cwRudO3KyxUIvLTmYjOjNcaxGnw/c6rCVSQ
 laFznXwtbWhdDs9YzTFAd00DKRU7TNc4sgg9fOuqAoO6DjQwmPnHPrH34
 cdTCJ3r9HyQh8hQWQAMhONaqoFkfrZSaxW9P8iVt7yXxz13XgpgguA49B
 LziQ1r3pGAim6F92yLmqoKTd/ILakbLl7rK9dTtd9T0+NrUbbRaWPRyM/ A==;
X-CSE-ConnectionGUID: Am2lmvDbSbqexCFHgUYowQ==
X-CSE-MsgGUID: 9wn6/xFIQt+VejL4e28trg==
X-IronPort-AV: E=McAfee;i="6800,10657,11696"; a="75454272"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="75454272"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Feb 2026 23:14:54 -0800
X-CSE-ConnectionGUID: o6f/FJTATqGCLj0+sVZ/VQ==
X-CSE-MsgGUID: l6hIKXY0QM+gnm62VSkaHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="216361627"
Received: from qianm-mobl2.ccr.corp.intel.com (HELO [10.238.1.184])
 ([10.238.1.184])
 by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Feb 2026 23:14:53 -0800
Message-ID: <4b0ca0ab-bf5c-427d-bfe9-18aee47572ff@linux.intel.com>
Date: Tue, 10 Feb 2026 15:14:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 09/11] target/i386: Refactor LBR format handling
To: Zide Chen <zide.chen@intel.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, Dongli Zhang <dongli.zhang@oracle.com>
References: <20260128231003.268981-1-zide.chen@intel.com>
 <20260128231003.268981-10-zide.chen@intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260128231003.268981-10-zide.chen@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=198.175.65.15;
 envelope-from=dapeng1.mi@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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


On 1/29/2026 7:09 AM, Zide Chen wrote:
> Detach x86_cpu_pmu_realize() from x86_cpu_realizefn() to keep the latter
> focused and easier to follow.  Introduce a dedicated helper,
> x86_cpu_apply_lbr_pebs_fmt(), in preparation for adding PEBS format
> support without duplicating code.
>
> Convert PERF_CAP_LBR_FMT into separate mask and shift macros to allow
> x86_cpu_apply_lbr_pebs_fmt() to be shared with PEBS format handling.
>
> No functional change intended

Seems a period is missed for above line.

Others look good to me.

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>


>
> Signed-off-by: Zide Chen <zide.chen@intel.com>
> ---
> V2:
> - New patch.
>
>  target/i386/cpu.c | 94 +++++++++++++++++++++++++++++++----------------
>  target/i386/cpu.h |  3 +-
>  2 files changed, 65 insertions(+), 32 deletions(-)
>
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 09180c718d58..54f04adb0b48 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -9781,6 +9781,66 @@ static bool x86_cpu_update_smp_cache_topo(MachineState *ms, X86CPU *cpu,
>  }
>  #endif
>  
> +static bool x86_cpu_apply_lbr_pebs_fmt(X86CPU *cpu, uint64_t host_perf_cap,
> +                                  uint64_t user_req, bool is_lbr_fmt,
> +                                  Error **errp)
> +{
> +    CPUX86State *env = &cpu->env;
> +    uint64_t mask;
> +    unsigned shift;
> +    unsigned user_fmt;
> +    const char *name;
> +
> +    if (is_lbr_fmt) {
> +        mask = PERF_CAP_LBR_FMT_MASK;
> +        shift = PERF_CAP_LBR_FMT_SHIFT;
> +        name = "lbr";
> +    } else {
> +        return false;
> +    }
> +
> +    if (user_req != -1) {
> +        env->features[FEAT_PERF_CAPABILITIES] &= ~(mask << shift);
> +        env->features[FEAT_PERF_CAPABILITIES] |= (user_req << shift);
> +    }
> +
> +    user_fmt = (env->features[FEAT_PERF_CAPABILITIES] >> shift) & mask;
> +
> +    if (user_fmt) {
> +        unsigned host_fmt = (host_perf_cap >> shift) & mask;
> +
> +        if (!cpu->enable_pmu) {
> +            error_setg(errp, "vPMU: %s is unsupported without pmu=on", name);
> +            return false;
> +        }
> +        if (user_fmt != host_fmt) {
> +            error_setg(errp, "vPMU: the %s-fmt value (0x%x) does not match "
> +                        "the host value (0x%x).",
> +                        name, user_fmt, host_fmt);
> +            return false;
> +        }
> +    }
> +
> +    return true;
> +}
> +
> +static int x86_cpu_pmu_realize(X86CPU *cpu, Error **errp)
> +{
> +    uint64_t host_perf_cap =
> +        x86_cpu_get_supported_feature_word(NULL, FEAT_PERF_CAPABILITIES);
> +
> +    /*
> +     * Override env->features[FEAT_PERF_CAPABILITIES].LBR_FMT
> +     * with user-provided setting.
> +     */
> +    if (!x86_cpu_apply_lbr_pebs_fmt(cpu, host_perf_cap,
> +                                    cpu->lbr_fmt, true, errp)) {
> +        return -EINVAL;
> +    }
> +
> +    return 0;
> +}
> +
>  static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
>  {
>      CPUState *cs = CPU(dev);
> @@ -9788,7 +9848,6 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
>      X86CPUClass *xcc = X86_CPU_GET_CLASS(dev);
>      CPUX86State *env = &cpu->env;
>      Error *local_err = NULL;
> -    unsigned guest_fmt;
>  
>      if (!kvm_enabled())
>          cpu->enable_pmu = false;
> @@ -9824,35 +9883,8 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
>          goto out;
>      }
>  
> -    /*
> -     * Override env->features[FEAT_PERF_CAPABILITIES].LBR_FMT
> -     * with user-provided setting.
> -     */
> -    if (cpu->lbr_fmt != -1) {
> -        env->features[FEAT_PERF_CAPABILITIES] &= ~PERF_CAP_LBR_FMT;
> -        env->features[FEAT_PERF_CAPABILITIES] |= cpu->lbr_fmt;
> -    }
> -
> -    /*
> -     * vPMU LBR is supported when 1) KVM is enabled 2) Option pmu=on and
> -     * 3)vPMU LBR format matches that of host setting.
> -     */
> -    guest_fmt = env->features[FEAT_PERF_CAPABILITIES] & PERF_CAP_LBR_FMT;
> -    if (guest_fmt) {
> -        uint64_t host_perf_cap =
> -            x86_cpu_get_supported_feature_word(NULL, FEAT_PERF_CAPABILITIES);
> -        unsigned host_lbr_fmt = host_perf_cap & PERF_CAP_LBR_FMT;
> -
> -        if (!cpu->enable_pmu) {
> -            error_setg(errp, "vPMU: LBR is unsupported without pmu=on");
> -            return;
> -        }
> -        if (guest_fmt != host_lbr_fmt) {
> -            error_setg(errp, "vPMU: the lbr-fmt value (0x%x) does not match "
> -                        "the host value (0x%x).",
> -                        guest_fmt, host_lbr_fmt);
> -            return;
> -        }
> +    if (x86_cpu_pmu_realize(cpu, errp)) {
> +        return;
>      }
>  
>      if (x86_cpu_filter_features(cpu, cpu->check_cpuid || cpu->enforce_cpuid)) {
> @@ -10445,7 +10477,7 @@ static const Property x86_cpu_properties[] = {
>  #endif
>      DEFINE_PROP_INT32("node-id", X86CPU, node_id, CPU_UNSET_NUMA_NODE_ID),
>      DEFINE_PROP_BOOL("pmu", X86CPU, enable_pmu, false),
> -    DEFINE_PROP_UINT64_CHECKMASK("lbr-fmt", X86CPU, lbr_fmt, PERF_CAP_LBR_FMT),
> +    DEFINE_PROP_UINT64_CHECKMASK("lbr-fmt", X86CPU, lbr_fmt, PERF_CAP_LBR_FMT_MASK),
>  
>      DEFINE_PROP_UINT32("hv-spinlocks", X86CPU, hyperv_spinlock_attempts,
>                         HYPERV_SPINLOCK_NEVER_NOTIFY),
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index 3e2222e105bc..aa3c24e0ba13 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -420,7 +420,8 @@ typedef enum X86Seg {
>  #define ARCH_CAP_TSX_CTRL_MSR		(1<<7)
>  
>  #define MSR_IA32_PERF_CAPABILITIES      0x345
> -#define PERF_CAP_LBR_FMT                0x3f
> +#define PERF_CAP_LBR_FMT_MASK           0x3f
> +#define PERF_CAP_LBR_FMT_SHIFT          0x0
>  #define PERF_CAP_FULL_WRITE             (1U << 13)
>  #define PERF_CAP_PEBS_BASELINE          (1U << 14)
>  

