Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D006FC54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 06:42:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkIK0-0001wO-PN; Wed, 13 Mar 2024 02:42:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tao1.su@linux.intel.com>)
 id 1rkIJs-0001uZ-SE
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 02:42:33 -0400
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tao1.su@linux.intel.com>)
 id 1rkIJq-0007Lz-89
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 02:42:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1710312150; x=1741848150;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=ZBE+YJupWeH0/Kewj5YOOn1eqy+YbjLU/TgIWDjKO4c=;
 b=I4uS+CTBxbPPTC+Y3w5i4Yh7XqyrPjZiGn2et4cJhbTPaywv9/EakbrW
 2DccdNh2l8pVqWuCj93AksLZQhGDzs9WKyckI2y+jUF/4jRNukckgeiau
 o3YQ0CQpJVCCDJNLq0mjlFBQGAbu6Cq/P0CPcYhVSAzAOp1CeX+kX4Pu0
 2vIe/Zybt1JbF3RxHir4TyJ6yP9r2tsBZLp4YkSizzbXt00tIsqw2fWZz
 9HxYhXNUQBQVqFBv7ogv4Zep/BcItZrB5YT6iNOfKtedO4xS9wn2ZWuyz
 N08EB0zWIhK3TTQkfQL7wQzicXlCRoBMbvESLJ2yrF2cGm0KtsRHbjF+v Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="8876152"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="8876152"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Mar 2024 23:42:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; d="scan'208";a="16461521"
Received: from linux.bj.intel.com ([10.238.157.71])
 by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Mar 2024 23:42:25 -0700
Date: Wed, 13 Mar 2024 14:39:32 +0800
From: Tao Su <tao1.su@linux.intel.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Tom Lendacky <thomas.lendacky@amd.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org
Subject: Re: [PATCH v2 2/2] kvm: add support for guest physical bits
Message-ID: <ZfFKJPYoE5bacb6+@linux.bj.intel.com>
References: <20240305105233.617131-1-kraxel@redhat.com>
 <20240305105233.617131-3-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240305105233.617131-3-kraxel@redhat.com>
Received-SPF: none client-ip=198.175.65.14;
 envelope-from=tao1.su@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

On Tue, Mar 05, 2024 at 11:52:33AM +0100, Gerd Hoffmann wrote:
> Query kvm for supported guest physical address bits, in cpuid
> function 80000008, eax[23:16].  Usually this is identical to host
> physical address bits.  With NPT or EPT being used this might be
> restricted to 48 (max 4-level paging address space size) even if
> the host cpu supports more physical address bits.
> 
> When set pass this to the guest, using cpuid too.  Guest firmware
> can use this to figure how big the usable guest physical address
> space is, so PCI bar mapping are actually reachable.

If this patch is applied, do you have plans to implement it in
OVMF/Seabios?

Thanks,
Tao

> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  target/i386/cpu.h     |  1 +
>  target/i386/cpu.c     |  1 +
>  target/i386/kvm/kvm.c | 17 +++++++++++++++++
>  3 files changed, 19 insertions(+)
> 
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index 952174bb6f52..d427218827f6 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -2026,6 +2026,7 @@ struct ArchCPU {
>  
>      /* Number of physical address bits supported */
>      uint32_t phys_bits;
> +    uint32_t guest_phys_bits;
>  
>      /* in order to simplify APIC support, we leave this pointer to the
>         user */
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 2666ef380891..1a6cfc75951e 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -6570,6 +6570,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>          if (env->features[FEAT_8000_0001_EDX] & CPUID_EXT2_LM) {
>              /* 64 bit processor */
>               *eax |= (cpu_x86_virtual_addr_width(env) << 8);
> +             *eax |= (cpu->guest_phys_bits << 16);
>          }
>          *ebx = env->features[FEAT_8000_0008_EBX];
>          if (cs->nr_cores * cs->nr_threads > 1) {
> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
> index 7298822cb511..ce22dfcaa661 100644
> --- a/target/i386/kvm/kvm.c
> +++ b/target/i386/kvm/kvm.c
> @@ -238,6 +238,15 @@ static int kvm_get_tsc(CPUState *cs)
>      return 0;
>  }
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
>  static inline void do_kvm_synchronize_tsc(CPUState *cpu, run_on_cpu_data arg)
>  {
>      kvm_get_tsc(cpu);
> @@ -1730,6 +1739,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
>      X86CPU *cpu = X86_CPU(cs);
>      CPUX86State *env = &cpu->env;
>      uint32_t limit, i, j, cpuid_i;
> +    uint32_t guest_phys_bits;
>      uint32_t unused;
>      struct kvm_cpuid_entry2 *c;
>      uint32_t signature[3];
> @@ -1765,6 +1775,13 @@ int kvm_arch_init_vcpu(CPUState *cs)
>  
>      env->apic_bus_freq = KVM_APIC_BUS_FREQUENCY;
>  
> +    guest_phys_bits = kvm_get_guest_phys_bits(cs->kvm_state);
> +    if (guest_phys_bits &&
> +        (cpu->guest_phys_bits == 0 ||
> +         cpu->guest_phys_bits > guest_phys_bits)) {
> +        cpu->guest_phys_bits = guest_phys_bits;
> +    }
> +
>      /*
>       * kvm_hyperv_expand_features() is called here for the second time in case
>       * KVM_CAP_SYS_HYPERV_CPUID is not supported. While we can't possibly handle
> -- 
> 2.44.0
> 
> 

