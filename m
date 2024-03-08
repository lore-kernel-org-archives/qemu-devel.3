Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64E45C5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 05:48:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riT59-0004CI-B5; Fri, 08 Mar 2024 00:47:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1riT54-0004Bt-HO
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 00:47:43 -0500
Received: from mgamail.intel.com ([198.175.65.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1riT51-0007on-Fh
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 00:47:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1709876860; x=1741412860;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=+QdToqycjCmAwHEr8FWm+TPwEiTZ7Ic9KnKQHw4IXYM=;
 b=fzApr8zYVLUbwSSWTVNQzohA4n8IvAl3EBFxBVyalTYDy3+UD+/AzyHa
 G9IowK/9Ytizen2IaBQ48hepEZcIlMHpCVAkzWzLOuItn9dksHkO8C3+x
 pMaI/v+wF55o+uus79aMsNCB6oaYMk5UNbd+BiAOAL3i2B3hg57EE4bsy
 z9Q89XCjr/uRkqLO3u+dsE7kKkdUDxor7IyTDrSI2rXBe1efTjA/PdZ44
 yoqLEEGi2SEXYZcN3o8UoMBN67ZzLQ6WB/qFSEglGbUgJcElFntJyFvNW
 2Q2gCFV42biw7vSJCJ6/C5We3DE4LpCssamQgYuqJs8+Uu3noX2ingIZb A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="4443034"
X-IronPort-AV: E=Sophos;i="6.07,108,1708416000"; 
   d="scan'208";a="4443034"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Mar 2024 21:47:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,108,1708416000"; d="scan'208";a="14856056"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.125.243.127])
 ([10.125.243.127])
 by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Mar 2024 21:47:34 -0800
Message-ID: <7b179554-c002-40da-943d-8dd98cf10bde@intel.com>
Date: Fri, 8 Mar 2024 13:47:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] kvm: add support for guest physical bits
Content-Language: en-US
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, Marcelo Tosatti
 <mtosatti@redhat.com>, kvm@vger.kernel.org
References: <20240305105233.617131-1-kraxel@redhat.com>
 <20240305105233.617131-3-kraxel@redhat.com>
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20240305105233.617131-3-kraxel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=198.175.65.19; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.583,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.273, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_NONE=-0.0001,
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

On 3/5/2024 6:52 PM, Gerd Hoffmann wrote:
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
>   target/i386/cpu.h     |  1 +
>   target/i386/cpu.c     |  1 +
>   target/i386/kvm/kvm.c | 17 +++++++++++++++++
>   3 files changed, 19 insertions(+)
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
> index 2666ef380891..1a6cfc75951e 100644
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
> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
> index 7298822cb511..ce22dfcaa661 100644
> --- a/target/i386/kvm/kvm.c
> +++ b/target/i386/kvm/kvm.c
> @@ -238,6 +238,15 @@ static int kvm_get_tsc(CPUState *cs)
>       return 0;
>   }
>   
> +/* return cpuid fn 8000_0008 eax[23:16] aka GuestPhysBits */
> +static int kvm_get_guest_phys_bits(KVMState *s)
> +{
> +    uint32_t eax;
> +
> +    eax = kvm_arch_get_supported_cpuid(s, 0x80000008, 0, R_EAX);
> +    return (eax >> 16) & 0xff;
> +}
> +
>   static inline void do_kvm_synchronize_tsc(CPUState *cpu, run_on_cpu_data arg)
>   {
>       kvm_get_tsc(cpu);
> @@ -1730,6 +1739,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
>       X86CPU *cpu = X86_CPU(cs);
>       CPUX86State *env = &cpu->env;
>       uint32_t limit, i, j, cpuid_i;
> +    uint32_t guest_phys_bits;
>       uint32_t unused;
>       struct kvm_cpuid_entry2 *c;
>       uint32_t signature[3];
> @@ -1765,6 +1775,13 @@ int kvm_arch_init_vcpu(CPUState *cs)
>   
>       env->apic_bus_freq = KVM_APIC_BUS_FREQUENCY;
>   
> +    guest_phys_bits = kvm_get_guest_phys_bits(cs->kvm_state);
> +    if (guest_phys_bits &&
> +        (cpu->guest_phys_bits == 0 ||
> +         cpu->guest_phys_bits > guest_phys_bits)) {
> +        cpu->guest_phys_bits = guest_phys_bits;
> +    }

suggest to move this added code block to kvm_cpu_realizefn().

Main code in kvm_arch_init_vcpu() is to consume the data in cpu or 
env->features to configure KVM specific configuration via KVM ioctls.

The preparation work of initializing the required data usually not 
happen in kvm_arch_init_vcpu();

>       /*
>        * kvm_hyperv_expand_features() is called here for the second time in case
>        * KVM_CAP_SYS_HYPERV_CPUID is not supported. While we can't possibly handle


