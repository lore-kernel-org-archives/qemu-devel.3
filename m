Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D72F7C54E67
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 03:10:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rm3Nh-0006UP-7X; Sun, 17 Mar 2024 23:09:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rm3Ne-0006U3-Ee
 for qemu-devel@nongnu.org; Sun, 17 Mar 2024 23:09:42 -0400
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rm3Nb-00086k-NI
 for qemu-devel@nongnu.org; Sun, 17 Mar 2024 23:09:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1710731380; x=1742267380;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=0SIo5nnH8rXWWo/PKZWu5xaHib3sujSo/4+YK3yVEhE=;
 b=j7K+jS2sSMnHVJxSIBqLDE2iPLaunYUtHKZgqI8VBWY/+wp6nVj62Vf9
 /ex9sveDYaK5HJ45XzWpwUThG4Um0P1J4APbX52sVLeTCBQja4Cgq0sBX
 hfcdULKdKaP5pwiRrLNfVA/BbHn31uS+bsbnd8XEqrnr99RuVhmbdq5QA
 Y02rZdDEM0HlLB8k6YT/F1PpiOtsTwZc6s4EB97ahBYVK14pCBYMWqRDH
 eOj119CJYrYSkmYTS6lbYmsb5POXY4IiF5kM9PigU9DUw71m+89z69JRy
 3FBw6pDJ2AEMOhOcQJtG/ue82voztr+hMo6hgDtdkauUr4qQY0W7JvBCm Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11016"; a="5660371"
X-IronPort-AV: E=Sophos;i="6.07,134,1708416000"; 
   d="scan'208";a="5660371"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Mar 2024 20:09:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,134,1708416000"; d="scan'208";a="44264959"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.238.14])
 ([10.124.238.14])
 by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Mar 2024 20:09:33 -0700
Message-ID: <4cbf6d9c-3916-4436-abfe-10b35734b67a@intel.com>
Date: Mon, 18 Mar 2024 11:09:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] kvm: add support for guest physical bits
Content-Language: en-US
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: Tom Lendacky <thomas.lendacky@amd.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 kvm@vger.kernel.org
References: <20240313132719.939417-1-kraxel@redhat.com>
 <20240313132719.939417-3-kraxel@redhat.com>
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20240313132719.939417-3-kraxel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=198.175.65.16; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.316,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 3/13/2024 9:27 PM, Gerd Hoffmann wrote:
> Query kvm for supported guest physical address bits, in cpuid
> function 80000008, eax[23:16].  Usually this is identical to host
> physical address bits.  With NPT or EPT being used this might be
> restricted to 48 (max 4-level paging address space size) even if
> the host cpu supports more physical address bits.
> 
> When set pass this to the guest, using cpuid too.  Guest firmware
> can use this to figure how big the usable guest physical address
> space is, so PCI bar mapping are actually reachable.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>   target/i386/cpu.h         |  1 +
>   target/i386/cpu.c         |  1 +
>   target/i386/kvm/kvm-cpu.c | 32 +++++++++++++++++++++++++++++++-
>   3 files changed, 33 insertions(+), 1 deletion(-)
> 
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index 952174bb6f52..d427218827f6 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -2026,6 +2026,7 @@ struct ArchCPU {
>   
>       /* Number of physical address bits supported */
>       uint32_t phys_bits;
> +    uint32_t guest_phys_bits;
>   
>       /* in order to simplify APIC support, we leave this pointer to the
>          user */
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 9a210d8d9290..c88c895a5b3e 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -6570,6 +6570,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>           if (env->features[FEAT_8000_0001_EDX] & CPUID_EXT2_LM) {
>               /* 64 bit processor */
>                *eax |= (cpu_x86_virtual_addr_width(env) << 8);
> +             *eax |= (cpu->guest_phys_bits << 16);
>           }
>           *ebx = env->features[FEAT_8000_0008_EBX];
>           if (cs->nr_cores * cs->nr_threads > 1) {
> diff --git a/target/i386/kvm/kvm-cpu.c b/target/i386/kvm/kvm-cpu.c
> index 9c791b7b0520..a2b7bfaeadf8 100644
> --- a/target/i386/kvm/kvm-cpu.c
> +++ b/target/i386/kvm/kvm-cpu.c
> @@ -18,10 +18,36 @@
>   #include "kvm_i386.h"
>   #include "hw/core/accel-cpu.h"
>   
> +static void kvm_set_guest_phys_bits(CPUState *cs)
> +{
> +    X86CPU *cpu = X86_CPU(cs);
> +    uint32_t eax, guest_phys_bits;
> +
> +    if (!cpu->host_phys_bits) {
> +        return;
> +    }

This needs explanation of why. What if users set the phys-bits to 
exactly host's value, via "-cpu xxx,phys-bits=host's value"?


> +    eax = kvm_arch_get_supported_cpuid(cs->kvm_state, 0x80000008, 0, R_EAX);
> +    guest_phys_bits = (eax >> 16) & 0xff;
> +    if (!guest_phys_bits) {
> +        return;
> +    }
> +
> +    if (cpu->guest_phys_bits == 0 ||
> +        cpu->guest_phys_bits > guest_phys_bits) {
> +        cpu->guest_phys_bits = guest_phys_bits;
> +    }
> +
> +    if (cpu->guest_phys_bits > cpu->host_phys_bits_limit) {
> +        cpu->guest_phys_bits = cpu->host_phys_bits_limit;
> +    }
> +}
> +
>   static bool kvm_cpu_realizefn(CPUState *cs, Error **errp)
>   {
>       X86CPU *cpu = X86_CPU(cs);
>       CPUX86State *env = &cpu->env;
> +    bool ret;
>   
>       /*
>        * The realize order is important, since x86_cpu_realize() checks if
> @@ -50,7 +76,11 @@ static bool kvm_cpu_realizefn(CPUState *cs, Error **errp)
>                                                      MSR_IA32_UCODE_REV);
>           }
>       }
> -    return host_cpu_realizefn(cs, errp);
> +    ret = host_cpu_realizefn(cs, errp);

We need to check ret and return if !ret;

> +    kvm_set_guest_phys_bits(cs);
> +
> +    return ret;
>   }
>   
>   static bool lmce_supported(void)


