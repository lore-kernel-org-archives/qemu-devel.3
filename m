Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B3E8EB7ED8
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 11:57:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxkqu-0000rc-RB; Wed, 04 Mar 2026 06:57:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1vxkqt-0000rC-6N
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 06:57:19 -0500
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1vxkqr-0003K0-0v
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 06:57:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject
 :Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=kC+Bf/tQCnfzq30cKLXWdYhTJ3FvtVBu4UHl0eauY50=; b=au9uyM+gPdk9xWt
 n19wPhMNPmgZz5M31M5m5SG6y7xqGW0Q3XnNANLFAPwzx5V9QNVEYWzIC0PGeXwKlyzpcPBRVcKEg
 1sdFY121xZITDKyR/KX7jgyD7zoEqYLouqXqF1+PHDskLFAserCCSR02OR15Ky1Qm/A9XKkoHX2WG
 jQ=;
Date: Wed, 4 Mar 2026 13:00:55 +0100
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Helge Deller <deller@gmx.de>
Subject: Re: [PATCH v5 3/4] hppa: Get physical address space bits from
 HPPACPUDef
Message-ID: <aagbf6ItBgLAUtDa@hive.localdomain>
References: <20260303-hppa-c3600-v5-0-277bfe6b40b8@rev.ng>
 <20260303-hppa-c3600-v5-3-277bfe6b40b8@rev.ng>
 <988762d7-6cbc-4ef7-889c-0482502ae248@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <988762d7-6cbc-4ef7-889c-0482502ae248@linaro.org>
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: 0
X-Spam_score: -0.0
X-Spam_bar: /
X-Spam_report: (-0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.703, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.386,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 03/03/26, Richard Henderson wrote:
> On 3/4/26 03:11, Anton Johansson wrote:
> > Reviewed-by: Helge Deller <deller@gmx.de>
> > Signed-off-by: Anton Johansson <anjo@rev.ng>
> > ---
> >   target/hppa/cpu.h        | 11 ++++++++---
> >   hw/hppa/machine.c        |  4 ++--
> >   hw/pci-host/astro.c      |  2 +-
> >   target/hppa/cpu.c        |  9 ++++++++-
> >   target/hppa/mem_helper.c | 39 +++++++++++----------------------------
> >   5 files changed, 30 insertions(+), 35 deletions(-)
> > 
> > diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
> > index 43b4882fb4..487f0f5e9e 100644
> > --- a/target/hppa/cpu.h
> > +++ b/target/hppa/cpu.h
> > @@ -320,6 +320,11 @@ static inline const HPPACPUDef *hppa_def(CPUHPPAState *env)
> >       return HPPA_CPU_GET_CLASS(env_cpu(env))->def;
> >   }
> > +static inline uint8_t hppa_phys_addr_bits(CPUHPPAState *env)
> > +{
> > +    return hppa_def(env)->phys_addr_bits;
> > +}
> > +
> >   static inline bool hppa_is_pa20(CPUHPPAState *env)
> >   {
> >       return hppa_def(env)->is_pa20;
> > @@ -352,9 +357,9 @@ static inline vaddr hppa_form_gva(CPUHPPAState *env, uint64_t spc,
> >       return hppa_form_gva_mask(env->gva_offset_mask, spc, off);
> >   }
> > -hwaddr hppa_abs_to_phys_pa1x(vaddr addr);
> > -hwaddr hppa_abs_to_phys_pa2_w0(vaddr addr);
> > -hwaddr hppa_abs_to_phys_pa2_w1(vaddr addr);
> > +hwaddr hppa_abs_to_phys_pa1x(CPUHPPAState *env, vaddr addr);
> > +hwaddr hppa_abs_to_phys_pa2_w0(CPUHPPAState *env, vaddr addr);
> > +hwaddr hppa_abs_to_phys_pa2_w1(CPUHPPAState *env, vaddr addr);
> >   /*
> >    * Since PSW_{I,CB} will never need to be in tb->flags, reuse them.
> > diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
> > index 5d0d4de09e..bb6b7dc76c 100644
> > --- a/hw/hppa/machine.c
> > +++ b/hw/hppa/machine.c
> > @@ -181,12 +181,12 @@ static uint64_t linux_kernel_virt_to_phys(void *opaque, uint64_t addr)
> >   static uint64_t translate_pa10(void *dummy, uint64_t addr)
> >   {
> > -    return hppa_abs_to_phys_pa1x(addr);
> > +    return hppa_abs_to_phys_pa1x(cpu_env(first_cpu), addr);
> >   }
> >   static uint64_t translate_pa20(void *dummy, uint64_t addr)
> >   {
> > -    return hppa_abs_to_phys_pa2_w0(addr);
> > +    return hppa_abs_to_phys_pa2_w0(cpu_env(first_cpu), addr);
> >   }
> >   static HPPACPU *cpu[HPPA_MAX_CPUS];
> > diff --git a/hw/pci-host/astro.c b/hw/pci-host/astro.c
> > index 00a904277c..d38f81e553 100644
> > --- a/hw/pci-host/astro.c
> > +++ b/hw/pci-host/astro.c
> > @@ -303,7 +303,7 @@ static IOMMUTLBEntry astro_translate_iommu(IOMMUMemoryRegion *iommu,
> >        * language which not-coincidentally matches the PSW.W=0 mapping.
> >        */
> >       if (addr <= UINT32_MAX) {
> > -        entry = hppa_abs_to_phys_pa2_w0(addr);
> > +        entry = hppa_abs_to_phys_pa2_w0(cpu_env(first_cpu), addr);
> >       } else {
> >           entry = addr;
> >       }
> > diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
> > index cc755da8be..b04bcfa6a0 100644
> > --- a/target/hppa/cpu.c
> > +++ b/target/hppa/cpu.c
> > @@ -282,7 +282,14 @@ static void hppa_cpu_class_base_init(ObjectClass *oc, const void *data)
> >       HPPACPUClass *acc = HPPA_CPU_CLASS(oc);
> >       /* Make sure all CPU models define a HPPACPUDef */
> >       g_assert(!object_class_is_abstract(oc) && data != NULL);
> > -    acc->def = data;
> > +    if (data) {
> 
> You just asserted data != NULL.

Agh I see I misunderstood class_base_init().. I thought it,
counterintuitively, would also be called for the parent class.

I'll remove this.

Thanks!

//Anton

