Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 549DCC9830C
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 02:02:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhebA-0004KL-13; Sun, 18 Jan 2026 21:02:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dapeng1.mi@linux.intel.com>)
 id 1vheb6-0004Gl-7G
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 21:02:29 -0500
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dapeng1.mi@linux.intel.com>)
 id 1vheb3-0001aV-9d
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 21:02:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1768788145; x=1800324145;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=3wDWTskNBuEFL+W/N1MD6bW9dCDN1qyL975rH+2XUZs=;
 b=g9KCWQaPjP2RBrZl603iEkRyvligeJnffexbV6bY0KIbZWbwc2rqPAmw
 PzuyRfhcdeLx+8Wt/Zaz8C7ZkcyaS/IiBN3QHpkpKFdcKuKj2qKuTRgmN
 XJT/SWJ0rtWxvFRdfqhfcj4ADADhQMzdxWpZ0eiGKXXW7tRWy7Mv6XahE
 khWI3lyxnLkhg5t8M6ZLD4DbMrH59MnZj6yMaACeMLmvEPtFad5Pzfgga
 fCu0bgJt3xuYFyKr1RX/+HX/sMzUC5Dsr9W0ewoSbbqFFnS8UxUV2yBl9
 6qCrxJOqNb3P0v/eQPGitR2eidNvjjxoe4MlK/Vjny79Sb6PSAxYv1/C/ A==;
X-CSE-ConnectionGUID: 1ZktQk4FTPSY3buhgARBqA==
X-CSE-MsgGUID: OH3TAq5PRRatG6Zh1eUNag==
X-IronPort-AV: E=McAfee;i="6800,10657,11675"; a="70165190"
X-IronPort-AV: E=Sophos;i="6.21,237,1763452800"; d="scan'208";a="70165190"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jan 2026 18:02:21 -0800
X-CSE-ConnectionGUID: 8nzoHSV8RbeIbug7x0bmRg==
X-CSE-MsgGUID: DCoGKgYZTRywTlZy0sNVFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,237,1763452800"; d="scan'208";a="210240722"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.240.14])
 ([10.124.240.14])
 by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jan 2026 18:02:19 -0800
Message-ID: <eb2c185b-9edc-4ef7-b71b-5cc3fed3827c@linux.intel.com>
Date: Mon, 19 Jan 2026 10:02:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] target/i386: Gate enable_pmu on kvm_enabled()
To: Zide Chen <zide.chen@intel.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Cc: xiaoyao.li@intel.com, Dongli Zhang <dongli.zhang@oracle.com>
References: <20260117011053.80723-1-zide.chen@intel.com>
 <20260117011053.80723-4-zide.chen@intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260117011053.80723-4-zide.chen@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=198.175.65.16;
 envelope-from=dapeng1.mi@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.077,
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


On 1/17/2026 9:10 AM, Zide Chen wrote:
> Guest PMU support requires KVM.  Clear cpu->enable_pmu when KVM is not
> enabled, so PMU-related code can rely solely on cpu->enable_pmu.
>
> This reduces duplication and avoids bugs where one of the checks is
> missed.  For example, cpu_x86_cpuid() enables CPUID.0AH when
> cpu->enable_pmu is set but does not check kvm_enabled(). This is
> implicitly fixed by this patch:
>
> if (cpu->enable_pmu) {
> 	x86_cpu_get_supported_cpuid(0xA, count, eax, ebx, ecx, edx);
> }
>
> Also fix two places that check kvm_enabled() but not cpu->enable_pmu.
>
> Signed-off-by: Zide Chen <zide.chen@intel.com>
> ---
>  target/i386/cpu.c     | 9 ++++++---
>  target/i386/kvm/kvm.c | 4 ++--
>  2 files changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 37803cd72490..f1ac98970d3e 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -8671,7 +8671,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>          *ecx = 0;
>          *edx = 0;
>          if (!(env->features[FEAT_7_0_EBX] & CPUID_7_0_EBX_INTEL_PT) ||
> -            !kvm_enabled()) {
> +            !cpu->enable_pmu) {
>              break;
>          }
>  
> @@ -9018,7 +9018,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>      case 0x80000022:
>          *eax = *ebx = *ecx = *edx = 0;
>          /* AMD Extended Performance Monitoring and Debug */
> -        if (kvm_enabled() && cpu->enable_pmu &&
> +        if (cpu->enable_pmu &&
>              (env->features[FEAT_8000_0022_EAX] & CPUID_8000_0022_EAX_PERFMON_V2)) {
>              *eax |= CPUID_8000_0022_EAX_PERFMON_V2;
>              *ebx |= kvm_arch_get_supported_cpuid(cs->kvm_state, index, count,
> @@ -9642,7 +9642,7 @@ static bool x86_cpu_filter_features(X86CPU *cpu, bool verbose)
>       * are advertised by cpu_x86_cpuid().  Keep these two in sync.
>       */
>      if ((env->features[FEAT_7_0_EBX] & CPUID_7_0_EBX_INTEL_PT) &&
> -        kvm_enabled()) {
> +        cpu->enable_pmu) {
>          x86_cpu_get_supported_cpuid(0x14, 0,
>                                      &eax_0, &ebx_0, &ecx_0, &edx_0);
>          x86_cpu_get_supported_cpuid(0x14, 1,
> @@ -9790,6 +9790,9 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
>      Error *local_err = NULL;
>      unsigned requested_lbr_fmt;
>  
> +    if (!kvm_enabled())
> +	    cpu->enable_pmu = false;
> +
>  #if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
>      /* Use pc-relative instructions in system-mode */
>      tcg_cflags_set(cs, CF_PCREL);
> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
> index cffbc90d1c50..e81fa46ed66c 100644
> --- a/target/i386/kvm/kvm.c
> +++ b/target/i386/kvm/kvm.c
> @@ -4222,7 +4222,7 @@ static int kvm_put_msrs(X86CPU *cpu, KvmPutState level)
>                                env->msr_xfd_err);
>          }
>  
> -        if (kvm_enabled() && cpu->enable_pmu &&
> +        if (cpu->enable_pmu &&
>              (env->features[FEAT_7_0_EDX] & CPUID_7_0_EDX_ARCH_LBR)) {
>              uint64_t depth;
>              int ret;
> @@ -4698,7 +4698,7 @@ static int kvm_get_msrs(X86CPU *cpu)
>          kvm_msr_entry_add(cpu, MSR_IA32_XFD_ERR, 0);
>      }
>  
> -    if (kvm_enabled() && cpu->enable_pmu &&
> +    if (cpu->enable_pmu &&
>          (env->features[FEAT_7_0_EDX] & CPUID_7_0_EDX_ARCH_LBR)) {
>          uint64_t depth;
>  

LGTM.

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>



