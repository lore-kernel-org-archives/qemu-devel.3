Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B885EE77171
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 08:13:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJ6z7-0006w8-0F; Thu, 05 Dec 2024 03:13:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tJ6z4-0006vw-QI
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 03:13:14 -0500
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tJ6z2-0000SX-Fh
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 03:13:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1733386392; x=1764922392;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=2RBIRHxMUSZorI6SOdXGd4m14Ag30L2Q/nI2ylnvw/0=;
 b=kVc6g5GeyoHpxMWFwn8/OzN3vXCKTwnFCgQIt94MYBDbe2Ask+rhWtn5
 8EKKuNkUCcgxmPYzsBsXAs40dS4tF/+BrpLimnYQDmv7q1OUa6hHhPckZ
 iojIJgDNXFifeWeEdGWT60ilYsUh8wIR1ObrCiH8musIHhHyUabJEqFEM
 Lf4wKWFuQw+U5XZmwg3gyYBJq3J+zYSn7ed6ukoQMI69NiTR3i50ns7eh
 kVEWG2W/p7liiorqKr2AU4uPmLiTFyhOs0pRiExFWneU66Y8yUC+Ybuh8
 Mp1z8m/KjMeTTahVVmGj/mxx+oUwt4CIsHl+ZxdULgYGx3ABWcP45/6k9 g==;
X-CSE-ConnectionGUID: AHF20h0qRQ6pWsX9XQ3WTw==
X-CSE-MsgGUID: qvTL6rOCQ9KIl9eojGnkRA==
X-IronPort-AV: E=McAfee;i="6700,10204,11276"; a="51218198"
X-IronPort-AV: E=Sophos;i="6.12,209,1728975600"; d="scan'208";a="51218198"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Dec 2024 00:13:10 -0800
X-CSE-ConnectionGUID: PXfPdTyfQlGzVUXd0QosMw==
X-CSE-MsgGUID: 0/X72TUEQOmnIMLfETNvUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,209,1728975600"; d="scan'208";a="94456843"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa007.jf.intel.com with ESMTP; 05 Dec 2024 00:13:05 -0800
Date: Thu, 5 Dec 2024 16:31:16 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Michael Rolnik <mrolnik@gmail.com>, Brian Cain <bcain@quicinc.com>,
 Song Gao <gaosong@loongson.cn>, Laurent Vivier <laurent@vivier.eu>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bmeng.cn@gmail.com>, Thomas Huth <thuth@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Max Filippov <jcmvbkbc@gmail.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v1 2/4] i386/cpu: Set up CPUID_HT in
 x86_cpu_expand_features() instead of cpu_x86_cpuid()
Message-ID: <Z1Fk1MW7274L/AV5@intel.com>
References: <20241108070609.3653085-1-xiaoyao.li@intel.com>
 <20241108070609.3653085-3-xiaoyao.li@intel.com>
 <Z1FUDGnenETEFV6Z@intel.com>
 <e634dbf0-267a-48de-9419-7d978e25c969@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e634dbf0-267a-48de-9419-7d978e25c969@intel.com>
Received-SPF: pass client-ip=192.198.163.8; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -73
X-Spam_score: -7.4
X-Spam_bar: -------
X-Spam_report: (-7.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
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

Hi Xiaoyao,

Thanks for your reply!

On Thu, Dec 05, 2024 at 03:54:36PM +0800, Xiaoyao Li wrote:
> Date: Thu, 5 Dec 2024 15:54:36 +0800
> From: Xiaoyao Li <xiaoyao.li@intel.com>
> Subject: Re: [PATCH v1 2/4] i386/cpu: Set up CPUID_HT in
>  x86_cpu_expand_features() instead of cpu_x86_cpuid()
> 
> On 12/5/2024 3:19 PM, Zhao Liu wrote:
> > Hi Xiaoyao,
> > 
> > Sorry for late reply.
> > 
> > > @@ -7490,6 +7489,7 @@ static void x86_cpu_enable_xsave_components(X86CPU *cpu)
> > >   void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
> > >   {
> > >       CPUX86State *env = &cpu->env;
> > > +    CPUState *cs = CPU(cpu);
> > >       FeatureWord w;
> > >       int i;
> > >       GList *l;
> > > @@ -7531,6 +7531,10 @@ void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
> > >           }
> > >       }
> > > +    if (cs->nr_cores * cs->nr_threads > 1) {
> > > +        env->features[FEAT_1_EDX] |= CPUID_HT;
> > > +    }
> > > +
> > 
> > We shouldn't place any CLI-configurable features here,
> > especially after expanding plus_features and minus_features.
> 
> yah, it needs to be placed before manipulation of plus_features and
> minus_features.

Please refer my comment at cover letter, you should do such thing in TDX
context.

> > HT has been made configurable since the commit 83629b1 ("target/i386/
> > cpu: Fix CPUID_HT exposure"), so if you want palce HT here, you
> > should make it un-configurable first.
> 
> No, commit 83629b1 doesn't make HT configurable but fix the warning of
> 
>    warning: host doesn't support requested feature: CPUID.01H:EDX.ht [bit
> 28]
> 
> when "-cpu *,+ht"
>
> > Regarding commit 83629b1, in what cases do we need to actively set HT?
> 
> when users want to do so. QEMU allows users to so do.

You haven't told the exact case you are fixing with HT.

HT is inherently tied to the topology, and custom modifications to HT
has already broken this. And I think we shouldn't go any further.

> > That commit even introduces more issues. Ideally, the hardware being
> > emulated by setting or masking feature bits should be feature-consistent.
> > 
> > However, "-cpu *,-ht -smp 2" does not remove the HT flag (which is
> > unexpected), and "-cpu *,+ht -smp 1" forcibly sets HT (which results in
> > buggy emulation). :(
> 
> For the case "-cpu *,-ht -smp 2" we can add some warn like what for AMD:
> 
>     if (IS_AMD_CPU(env) &&
>         !(env->features[FEAT_8000_0001_ECX] & CPUID_EXT3_TOPOEXT) &&
>         cs->nr_threads > 1) {
>             warn_report_once("This family of AMD CPU doesn't support "
>                              "hyperthreading(%d). Please configure -smp "
>                              "options properly or try enabling topoext "
>                              "feature.", cs->nr_threads);
>     }
> 
> for the case of "-cpu *,+ht, -smp 1", we can add a dependency between "HT"
> and "smp > 1", similar as feature_dependencies[]

So I think the 83629b1 just masked the issue, a thorough fix should be
to avoid CLI configuration.

> > In fact, HT should not be freely configurable in hardware emulation;
> > users should configure it in the BIOS.
> 
> How users configure it in the BIOS? Or do you mean the BIOS will set/clear
> it based on the actual (v)cpus get activated? Any reference to teh BIOS
> spec?

Sorry, I think we should focus more on this issue. Such rhetorical
questions are not very helpful...

Thanks,
Zhao


