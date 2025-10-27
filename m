Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5B52CCF9EA
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 09:50:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDJro-0006Ul-I4; Mon, 27 Oct 2025 05:50:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vDJrm-0006UZ-IG
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 05:50:18 -0400
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vDJrg-0001BC-0x
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 05:50:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761558612; x=1793094612;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=EPREoMUXRyDfBk/mK+9pxDtEalQDV12FTD9qW61Ut7E=;
 b=bzHZHJdoPfSM53hKtc8ABChwnCTuPwtoggdExkvHyA91ip56pIHWWqxJ
 3MVBkfo+iDoRdRLJKJbi+NkprVruDTl2YjdwOsoo8AFZwsCsz7kLeMGlw
 I7Pz6AYqVxvQmPYa+YcIRhjVKn+ssrYXMpWflWStSDVdatC0TM9THs67q
 XLetowJD4xFGhKHOE/NBPf6/hiEFArXg1A5feo/0hrH3dRlhpPCf0wFfh
 UP/4/AMi+ETnQvnztbWMi9kS8kFaQ3L6yo2gIX0weaafQRt8lfK3AH95i
 2vo3YzdiK9TDkuUvtMF+W9MAKk+FyvmhqMZ1pHuZBRbVr/en0JUt5bo5k g==;
X-CSE-ConnectionGUID: ovKl2CyRQAqK63hhkYnt4g==
X-CSE-MsgGUID: JJBnvRrYRruoAm7SPCLd1w==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="86263350"
X-IronPort-AV: E=Sophos;i="6.19,258,1754982000"; d="scan'208";a="86263350"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2025 02:50:06 -0700
X-CSE-ConnectionGUID: BHXATqk5RQmsIvipYv+t5Q==
X-CSE-MsgGUID: v4fAVbsXSPKNKCNSurB9EQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,258,1754982000"; d="scan'208";a="185759421"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa010.fm.intel.com with ESMTP; 27 Oct 2025 02:50:03 -0700
Date: Mon, 27 Oct 2025 18:12:13 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Chao Gao <chao.gao@intel.com>,
 John Allen <john.allen@amd.com>, Babu Moger <babu.moger@amd.com>,
 Mathias Krause <minipli@grsecurity.net>,
 Dapeng Mi <dapeng1.mi@intel.com>, Zide Chen <zide.chen@intel.com>,
 Chenyi Qiang <chenyi.qiang@intel.com>, Farrah Chen <farrah.chen@intel.com>
Subject: Re: [PATCH v3 07/20] i386/cpu: Reorganize dependency check for arch
 lbr state
Message-ID: <aP9FfUKoP2azthS8@intel.com>
References: <20251024065632.1448606-1-zhao1.liu@intel.com>
 <20251024065632.1448606-8-zhao1.liu@intel.com>
 <d34f682a-c6c0-4609-96e8-2a0b76585c7d@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d34f682a-c6c0-4609-96e8-2a0b76585c7d@intel.com>
Received-SPF: pass client-ip=198.175.65.9; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

> >   * XSAVES feature bit (CPUID 0xD.0x1.EAX[bit 3]):
> > 
> >     Arch lbr state is a supervisor state, which requires the XSAVES
> >     feature support. Enumerate supported supervisor state based on XSAVES
> >     feature bit in x86_cpu_enable_xsave_components().
> > 
> >     Then it's safe to drop the check on XSAVES feature support during
> >     CPUID 0XD encoding.

...

> > +++ b/target/i386/cpu.c
> > @@ -8174,16 +8174,6 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
> >               *ebx = xsave_area_size(xstate, true);
> >               *ecx = env->features[FEAT_XSAVE_XSS_LO];
> >               *edx = env->features[FEAT_XSAVE_XSS_HI];
> > -            if (kvm_enabled() && cpu->enable_pmu &&
> > -                (env->features[FEAT_7_0_EDX] & CPUID_7_0_EDX_ARCH_LBR) &&
> > -                (*eax & CPUID_XSAVE_XSAVES)) {
> > -                *ecx |= XSTATE_ARCH_LBR_MASK;
> > -            } else {
> > -                *ecx &= ~XSTATE_ARCH_LBR_MASK;
> > -            }
> 
> > -        } else if (count == 0xf && cpu->enable_pmu
> > -                   && (env->features[FEAT_7_0_EDX] & CPUID_7_0_EDX_ARCH_LBR)) {
> > -            x86_cpu_get_supported_cpuid(0xD, count, eax, ebx, ecx, edx);
> 
> This chunk needs to be a separate patch. It's a functional change.

Already mentioned this in commit message.


