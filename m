Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 016C7C27C52
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 15:09:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEVmP-0001Gf-Fa; Tue, 04 Jun 2024 11:08:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1sEVmO-0001GO-1G; Tue, 04 Jun 2024 11:08:52 -0400
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1sEVmK-0000nH-NX; Tue, 04 Jun 2024 11:08:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1717513728; x=1749049728;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=JeOBBM0d4YIUT0J1py90ZZ7gnBnyJCwUqUhFwSbZ2ro=;
 b=eCb3gQCowAHqzewgvjAjX1AeZiqai5XMu2TODqMWA3lqQmE185qCP8Ub
 jIxQG7+CUWgJFMcC3hT63tALer0bwUOz7AdcTErh/W/27HtAwpx1BoKNV
 mklDQfvE84DAPVk+xeh1Ly6OKZWWuY5foeBY06SvzGh/SdYlxBPdCi2Pk
 dSOxD8QkpLmEAntEcLJ/8jL4FWOzS9zspQZDIaPe7+RUsOiNNf0X7DdZv
 vmQII4zDaq24pwmsSYIo45niZbG8+VTqLk9mH8Zc2G8ZjvbL96siL48qq
 CrLqV/Ab1u/GvZFWisfqx4fDqrGoR03yhIviQyMXQ17qhvYLG75gAz6wz g==;
X-CSE-ConnectionGUID: 6xzkaxZITCCvyQoKJRELpQ==
X-CSE-MsgGUID: TvlOuBhFRi6eJ/ZDhh6L6w==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="13816988"
X-IronPort-AV: E=Sophos;i="6.08,214,1712646000"; d="scan'208";a="13816988"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jun 2024 08:08:46 -0700
X-CSE-ConnectionGUID: BQ0DAi9IRmGuJtIiMP09Ow==
X-CSE-MsgGUID: hdJTlxOFSgeEDguQ97RsPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,214,1712646000"; d="scan'208";a="41708741"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.125.247.52])
 ([10.125.247.52])
 by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jun 2024 08:08:43 -0700
Message-ID: <d1756ef5-7eb9-419f-850f-2addaa6533e6@intel.com>
Date: Tue, 4 Jun 2024 23:08:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 2/2] target/i386: Advertise MWAIT iff host supports
To: Zide Chen <zide.chen@intel.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mst@redhat.com, thuth@redhat.com, cfontana@suse.de,
 qemu-trivial@nongnu.org, seanjc@google.com, zhao1.liu@intel.com
References: <20240604000222.75065-1-zide.chen@intel.com>
 <20240604000222.75065-3-zide.chen@intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20240604000222.75065-3-zide.chen@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.198.163.18; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.288, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 6/4/2024 8:02 AM, Zide Chen wrote:
> host_cpu_realizefn() sets CPUID_EXT_MONITOR without consulting host/KVM
> capabilities. This may cause problems:
> 
> - If MWAIT/MONITOR is not available on the host, advertising this
>    feature to the guest and executing MWAIT/MONITOR from the guest
>    triggers #UD and the guest doesn't boot.  This is because typically
>    #UD takes priority over VM-Exit interception checks and KVM doesn't
>    emulate MONITOR/MWAIT on #UD.
> 
> - If KVM doesn't support KVM_X86_DISABLE_EXITS_MWAIT, MWAIT/MONITOR
>    from the guest are intercepted by KVM, which is not what cpu-pm=on
>    intends to do.
> 
> In these cases, MWAIT/MONITOR should not be exposed to the guest.
> 
> The logic in kvm_arch_get_supported_cpuid() to handle CPUID_EXT_MONITOR
> is correct and sufficient, and we can't set CPUID_EXT_MONITOR after
> x86_cpu_filter_features().
> 
> This was not an issue before commit 662175b91ff ("i386: reorder call to
> cpu_exec_realizefn") because the feature added in the accel-specific
> realizefn could be checked against host availability and filtered out.
> 
> Additionally, it seems not a good idea to handle guest CPUID leaves in
> host_cpu_realizefn(), and this patch merges host_cpu_enable_cpu_pm()
> into kvm_cpu_realizefn().
> 
> Fixes: f5cc5a5c1686 ("i386: split cpu accelerators from cpu.c, using AccelCPUClass")
> Fixes: 662175b91ff2 ("i386: reorder call to cpu_exec_realizefn")
> Signed-off-by: Zide Chen <zide.chen@intel.com>

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

> ---
> 
> V3:
> - don't set CPUID_EXT_MONITOR in kvm_cpu_realizefn().
> - Change title to reflect the main purpose of this patch.
> 
>   target/i386/host-cpu.c    | 12 ------------
>   target/i386/kvm/kvm-cpu.c | 11 +++++++++--
>   2 files changed, 9 insertions(+), 14 deletions(-)
> 
> diff --git a/target/i386/host-cpu.c b/target/i386/host-cpu.c
> index 280e427c017c..8b8bf5afeccf 100644
> --- a/target/i386/host-cpu.c
> +++ b/target/i386/host-cpu.c
> @@ -42,15 +42,6 @@ static uint32_t host_cpu_phys_bits(void)
>       return host_phys_bits;
>   }
>   
> -static void host_cpu_enable_cpu_pm(X86CPU *cpu)
> -{
> -    CPUX86State *env = &cpu->env;
> -
> -    host_cpuid(5, 0, &cpu->mwait.eax, &cpu->mwait.ebx,
> -               &cpu->mwait.ecx, &cpu->mwait.edx);
> -    env->features[FEAT_1_ECX] |= CPUID_EXT_MONITOR;
> -}
> -
>   static uint32_t host_cpu_adjust_phys_bits(X86CPU *cpu)
>   {
>       uint32_t host_phys_bits = host_cpu_phys_bits();
> @@ -83,9 +74,6 @@ bool host_cpu_realizefn(CPUState *cs, Error **errp)
>       X86CPU *cpu = X86_CPU(cs);
>       CPUX86State *env = &cpu->env;
>   
> -    if (cpu->max_features && enable_cpu_pm) {
> -        host_cpu_enable_cpu_pm(cpu);
> -    }
>       if (env->features[FEAT_8000_0001_EDX] & CPUID_EXT2_LM) {
>           uint32_t phys_bits = host_cpu_adjust_phys_bits(cpu);
>   
> diff --git a/target/i386/kvm/kvm-cpu.c b/target/i386/kvm/kvm-cpu.c
> index f76972e47e61..148d10ce3711 100644
> --- a/target/i386/kvm/kvm-cpu.c
> +++ b/target/i386/kvm/kvm-cpu.c
> @@ -65,8 +65,15 @@ static bool kvm_cpu_realizefn(CPUState *cs, Error **errp)
>        *   cpu_common_realizefn() (via xcc->parent_realize)
>        */
>       if (cpu->max_features) {
> -        if (enable_cpu_pm && kvm_has_waitpkg()) {
> -            env->features[FEAT_7_0_ECX] |= CPUID_7_0_ECX_WAITPKG;
> +        if (enable_cpu_pm) {
> +            if (kvm_has_waitpkg()) {
> +                env->features[FEAT_7_0_ECX] |= CPUID_7_0_ECX_WAITPKG;
> +            }
> +
> +            if (env->features[FEAT_1_ECX] & CPUID_EXT_MONITOR) {
> +                host_cpuid(5, 0, &cpu->mwait.eax, &cpu->mwait.ebx,
> +                           &cpu->mwait.ecx, &cpu->mwait.edx);
> +	    }
>           }
>           if (cpu->ucode_rev == 0) {
>               cpu->ucode_rev =


