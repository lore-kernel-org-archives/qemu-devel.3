Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA3E1CCF9E3
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 15:43:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEUnO-0007Gr-6O; Thu, 30 Oct 2025 11:42:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vEUnH-0007GV-Sn
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 11:42:31 -0400
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vEUnC-0002d5-Vn
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 11:42:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761838947; x=1793374947;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=G82bnRITGyqKjw4vCwsGZ99kE0549Ia3SE8bIF8kwK0=;
 b=Jcd4JrNGwBpxBbCSr1bOCIzR1DsxeXcYkg/g4IBC2tO7+Fs6e0UTw9Sd
 UuM14Ld0OmRI/pb2Ghq2NHVPYDiMM/tkvHhuAKhx2EmuEKQc2/AlI4wTY
 e8COvIDbEW0PlWmH7D8UlFyjm48EmbfBAK8KSi+lgrzepdET7dGAxbC4a
 VmScxqcPjdhQk1jD5GssRV2TcaxHkBhTJsbIwTKVu66KZ9Rj9fUMSGEwi
 ua3ciqzaRWZ53xJbxY+F/dh1zwiLzSC0yzKTU2tFxrPrZ9Ex8UtM8SBdD
 WqH4R8Rdm//HVptWWRDYCjg1SMx7nxOeoGHrvPuExVmg0/TVqhu2NhAk0 Q==;
X-CSE-ConnectionGUID: VkxqVq58TbyZnoixSOEnkA==
X-CSE-MsgGUID: k4DwJLMmRnWZJIkxvWLtKg==
X-IronPort-AV: E=McAfee;i="6800,10657,11598"; a="75434848"
X-IronPort-AV: E=Sophos;i="6.19,267,1754982000"; d="scan'208";a="75434848"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Oct 2025 08:42:22 -0700
X-CSE-ConnectionGUID: LzuJ36b8QLq7/qznGsTrwA==
X-CSE-MsgGUID: G6SewhZcS8q1HQtR95fX1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,267,1754982000"; d="scan'208";a="185678709"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa007.fm.intel.com with ESMTP; 30 Oct 2025 08:42:18 -0700
Date: Fri, 31 Oct 2025 00:04:30 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Chao Gao <chao.gao@intel.com>,
 John Allen <john.allen@amd.com>, Babu Moger <babu.moger@amd.com>,
 Mathias Krause <minipli@grsecurity.net>,
 Dapeng Mi <dapeng1.mi@intel.com>, Zide Chen <zide.chen@intel.com>,
 Chenyi Qiang <chenyi.qiang@intel.com>, Farrah Chen <farrah.chen@intel.com>,
 Yang Weijiang <weijiang.yang@intel.com>
Subject: Re: [PATCH v3 15/20] i386/machine: Add vmstate for cet-ss and cet-ibt
Message-ID: <aQOMjlHnjgwdYfFX@intel.com>
References: <20251024065632.1448606-1-zhao1.liu@intel.com>
 <20251024065632.1448606-16-zhao1.liu@intel.com>
 <445462e9-22e5-4e8b-999e-7be468731752@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <445462e9-22e5-4e8b-999e-7be468731752@intel.com>
Received-SPF: pass client-ip=198.175.65.12; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Oct 28, 2025 at 04:29:58PM +0800, Xiaoyao Li wrote:
> Date: Tue, 28 Oct 2025 16:29:58 +0800
> From: Xiaoyao Li <xiaoyao.li@intel.com>
> Subject: Re: [PATCH v3 15/20] i386/machine: Add vmstate for cet-ss and
>  cet-ibt
> 
> On 10/24/2025 2:56 PM, Zhao Liu wrote:
> > From: Yang Weijiang <weijiang.yang@intel.com>
> > 
> > Add vmstates for cet-ss and cet-ibt
> > 
> > Tested-by: Farrah Chen <farrah.chen@intel.com>
> > Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
> > Co-developed-by: Chao Gao <chao.gao@intel.com>
> > Signed-off-by: Chao Gao <chao.gao@intel.com>
> > Co-developed-by: Zhao Liu <zhao1.liu@intel.com>
> > Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> > ---
> > Changes Since v2:
> >   - Split a subsection "vmstate_ss" since shstk is user-configurable.
> > ---
> >   target/i386/machine.c | 53 +++++++++++++++++++++++++++++++++++++++++++
> >   1 file changed, 53 insertions(+)
> > 
> > diff --git a/target/i386/machine.c b/target/i386/machine.c
> > index 45b7cea80aa7..3ad07ec82428 100644
> > --- a/target/i386/machine.c
> > +++ b/target/i386/machine.c
> > @@ -1668,6 +1668,58 @@ static const VMStateDescription vmstate_triple_fault = {
> >       }
> >   };
> > +static bool shstk_needed(void *opaque)
> > +{
> > +    X86CPU *cpu = opaque;
> > +    CPUX86State *env = &cpu->env;
> > +
> > +    return !!(env->features[FEAT_7_0_ECX] & CPUID_7_0_ECX_CET_SHSTK);
> > +}
> > +
> > +static const VMStateDescription vmstate_ss = {
> > +    .name = "cpu/cet_ss",
> > +    .version_id = 1,
> > +    .minimum_version_id = 1,
> > +    .needed = shstk_needed,
> > +    .fields = (VMStateField[]) {
> > +        VMSTATE_UINT64(env.pl0_ssp, X86CPU),
> > +        VMSTATE_UINT64(env.pl1_ssp, X86CPU),
> > +        VMSTATE_UINT64(env.pl2_ssp, X86CPU),
> > +        VMSTATE_UINT64(env.pl3_ssp, X86CPU),
> > +#ifdef TARGET_X86_64
> > +        /* This MSR is only present on Intel 64 architecture. */
> > +        VMSTATE_UINT64(env.int_ssp_table, X86CPU),
> > +#endif
> 
> It seems we need to split int_ssp_table into a separate vmstate_*
> 
> Its .needed function needs to check both  CPUID_7_0_ECX_CET_SHSTK &&
> CPUID_EXT2_LM.

Ok, will split this entry into a subsection. Thanks.

> > +        VMSTATE_UINT64(env.guest_ssp, X86CPU),
> > +        VMSTATE_END_OF_LIST()
> > +    }
> > +};
> > +
> > +static bool cet_needed(void *opaque)
> > +{
> > +    X86CPU *cpu = opaque;
> > +    CPUX86State *env = &cpu->env;
> > +
> > +    return !!((env->features[FEAT_7_0_ECX] & CPUID_7_0_ECX_CET_SHSTK) ||
> > +              (env->features[FEAT_7_0_EDX] & CPUID_7_0_EDX_CET_IBT));
> > +}
> > +
> > +static const VMStateDescription vmstate_cet = {
> > +    .name = "cpu/cet",
> > +    .version_id = 1,
> > +    .minimum_version_id = 1,
> > +    .needed = cet_needed,
> > +    .fields = (VMStateField[]) {
> > +        VMSTATE_UINT64(env.u_cet, X86CPU),
> > +        VMSTATE_UINT64(env.s_cet, X86CPU),
> > +        VMSTATE_END_OF_LIST()
> > +    },
> > +    .subsections = (const VMStateDescription * const []) {
> > +        &vmstate_ss,

here:       ^^^^^^^^^^^^^

> > +        NULL,
> > +    },
> > +};
> > +
> >   const VMStateDescription vmstate_x86_cpu = {
> >       .name = "cpu",
> >       .version_id = 12,
> > @@ -1817,6 +1869,7 @@ const VMStateDescription vmstate_x86_cpu = {
> >   #endif
> >           &vmstate_arch_lbr,
> >           &vmstate_triple_fault,
> > +        &vmstate_cet,
> 
> missing &vmstate_ss

I made vmstate_ss as a subsection in vmstate_cet

Regards,
Zhao


