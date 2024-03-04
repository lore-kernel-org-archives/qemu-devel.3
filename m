Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01DAAC48BF6
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 04:09:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgzdG-0005Ts-SU; Sun, 03 Mar 2024 23:08:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tao1.su@linux.intel.com>)
 id 1rgzdE-0005Ti-UC
 for qemu-devel@nongnu.org; Sun, 03 Mar 2024 23:08:53 -0500
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tao1.su@linux.intel.com>)
 id 1rgzdD-0001xN-3D
 for qemu-devel@nongnu.org; Sun, 03 Mar 2024 23:08:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1709525331; x=1741061331;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=kPEzY1Q/YiJkCG9/zvlWooKynCaKb4rUYhJRl+dFyFs=;
 b=BnvR70REWY365WJqZLNjnJeSTRbkH/LUNHR/eH7oOKABsqntkQxyJKm4
 CnJWbuiIHyZrM/0SsZg4EQ9ojwWx/QIBd7i6YFrgOhLJth0IW6PHa9j6t
 bxePwhOdbJY0rK+0l1imoregSgL0iOOnONJ0Jxg2/tDVwxLLDiQq544cE
 lYy6zCht4GqgS1vfetRUY/1AUvhJSnWQwIJD6HQJXzmlzXvzccjfQ+9zs
 NMFIlNGvtFXQZ3qfto5VpxfbMOHQDGVqXX+5nSAK26RUzYAwiRBcyebG9
 e1ijO04DIlKMOCcFahPTpCuJTM6VTnwgchr3vQkQAxSmpd6irDjKwVL84 w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11002"; a="3858455"
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="3858455"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Mar 2024 20:08:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="9296666"
Received: from linux.bj.intel.com ([10.238.157.71])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Mar 2024 20:08:44 -0800
Date: Mon, 4 Mar 2024 12:05:50 +0800
From: Tao Su <tao1.su@linux.intel.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org,
 Marcelo Tosatti <mtosatti@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Subject: Re: [PATCH 1/1] kvm: add support for guest physical bits
Message-ID: <ZeVIniWQDtPufs7W@linux.bj.intel.com>
References: <20240301101713.356759-1-kraxel@redhat.com>
 <20240301101713.356759-2-kraxel@redhat.com>
 <3ab64c0f-7387-4738-b78c-cf798528d5f4@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ab64c0f-7387-4738-b78c-cf798528d5f4@intel.com>
Received-SPF: none client-ip=192.198.163.19;
 envelope-from=tao1.su@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.589,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Mon, Mar 04, 2024 at 09:54:40AM +0800, Xiaoyao Li wrote:
> On 3/1/2024 6:17 PM, Gerd Hoffmann wrote:
> > query kvm for supported guest physical address bits using
> > KVM_CAP_VM_GPA_BITS.  Expose the value to the guest via cpuid
> > (leaf 0x80000008, eax, bits 16-23).
> > 
> > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> > ---
> >   target/i386/cpu.h     | 1 +
> >   target/i386/cpu.c     | 1 +
> >   target/i386/kvm/kvm.c | 8 ++++++++
> >   3 files changed, 10 insertions(+)
> > 
> > diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> > index 952174bb6f52..d427218827f6 100644
> > --- a/target/i386/cpu.h
> > +++ b/target/i386/cpu.h
> > @@ -2026,6 +2026,7 @@ struct ArchCPU {
> >       /* Number of physical address bits supported */
> >       uint32_t phys_bits;
> > +    uint32_t guest_phys_bits;
> >       /* in order to simplify APIC support, we leave this pointer to the
> >          user */
> > diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> > index 2666ef380891..1a6cfc75951e 100644
> > --- a/target/i386/cpu.c
> > +++ b/target/i386/cpu.c
> > @@ -6570,6 +6570,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
> >           if (env->features[FEAT_8000_0001_EDX] & CPUID_EXT2_LM) {
> >               /* 64 bit processor */
> >                *eax |= (cpu_x86_virtual_addr_width(env) << 8);
> > +             *eax |= (cpu->guest_phys_bits << 16);
> 
> I think you misunderstand this field.
> 
> If you expose this field to guest, it's the information for nested guest.
> i.e., the guest itself runs as a hypervisor will know its nested guest can
> have guest_phys_bits for physical addr.

I'm also thinking about this issue...

Currently guest KVM doesn't use this field to advertise MAXPHYADDR because
nested guest hasn't tdp. And this patch only affects KVM hypervisor now.

Thanks,
Tao

> 
> >           }
> >           *ebx = env->features[FEAT_8000_0008_EBX];
> >           if (cs->nr_cores * cs->nr_threads > 1) {
> > diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
> > index 42970ab046fa..e06c9d66bb01 100644
> > --- a/target/i386/kvm/kvm.c
> > +++ b/target/i386/kvm/kvm.c
> > @@ -1716,6 +1716,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
> >       X86CPU *cpu = X86_CPU(cs);
> >       CPUX86State *env = &cpu->env;
> >       uint32_t limit, i, j, cpuid_i;
> > +    uint32_t guest_phys_bits;
> >       uint32_t unused;
> >       struct kvm_cpuid_entry2 *c;
> >       uint32_t signature[3];
> > @@ -1751,6 +1752,13 @@ int kvm_arch_init_vcpu(CPUState *cs)
> >       env->apic_bus_freq = KVM_APIC_BUS_FREQUENCY;
> > +    guest_phys_bits = kvm_check_extension(cs->kvm_state, KVM_CAP_VM_GPA_BITS);
> > +    if (guest_phys_bits &&
> > +        (cpu->guest_phys_bits == 0 ||
> > +         cpu->guest_phys_bits > guest_phys_bits)) {
> > +        cpu->guest_phys_bits = guest_phys_bits;
> > +    }
> > +
> >       /*
> >        * kvm_hyperv_expand_features() is called here for the second time in case
> >        * KVM_CAP_SYS_HYPERV_CPUID is not supported. While we can't possibly handle
> 
> 

