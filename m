Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88632D1266D
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 07:37:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQhPW-0004hl-8u; Wed, 03 Dec 2025 02:36:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vQhOz-0004aI-Na
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 02:35:57 -0500
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vQhOw-0002EW-2n
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 02:35:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1764747350; x=1796283350;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=uPkdQERsIUHqaNGhdud8roMEQ1jbCQGL7Ej6X/cSmgs=;
 b=VbrBr6iIf2EMPAXLtb5gbnUZz9FlTTpzQaZ9y4foNBGaVqjneCxwEBi9
 1FxXWoj/++WE33OT6RLL5pwDK4/9r9hJMIR2V9VALRmnq96SBEtV6uQqI
 +mCq+tcVLfbNAlqjHUrVBS6Y9DME2yMmsXYt2QUi/q2GeF7GNJ8bsMRqt
 w4J6wxECXuCuKLTr3WjWmt04vL8rsxuOWzo7We9D9Squ4scg3q7oV2GaV
 xtQvFZWHNcocQZVzMi5UovQ7PrTuZZ0J/Ey1tkiJ1ZOGX+WvP3D9Ax1Om
 HNVMzbsYJMF7RqG0LttHZa/fs+NjFbTWqtib4A8PqTvUrSB2g2kSTRY0y w==;
X-CSE-ConnectionGUID: JUot9bFDSMyNhum9alhR/Q==
X-CSE-MsgGUID: aZ2X3gSuQpaMlOXF9Ovedg==
X-IronPort-AV: E=McAfee;i="6800,10657,11631"; a="65734509"
X-IronPort-AV: E=Sophos;i="6.20,245,1758610800"; d="scan'208";a="65734509"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Dec 2025 23:35:46 -0800
X-CSE-ConnectionGUID: 6mrCZqXsSJq1NlqrqoQD7A==
X-CSE-MsgGUID: JaWz9ufsR5qI4BE4ureL1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,245,1758610800"; d="scan'208";a="194280649"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa007.fm.intel.com with ESMTP; 02 Dec 2025 23:35:43 -0800
Date: Wed, 3 Dec 2025 16:00:26 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Chao Gao <chao.gao@intel.com>,
 Xin Li <xin@zytor.com>, John Allen <john.allen@amd.com>,
 Babu Moger <babu.moger@amd.com>, Mathias Krause <minipli@grsecurity.net>,
 Dapeng Mi <dapeng1.mi@intel.com>, Zide Chen <zide.chen@intel.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, Chenyi Qiang <chenyi.qiang@intel.com>,
 Farrah Chen <farrah.chen@intel.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH v4 06/23] i386/kvm: Initialize x86_ext_save_areas[] based
 on KVM support
Message-ID: <aS/uGsU39/ZbXDij@intel.com>
References: <20251118034231.704240-1-zhao1.liu@intel.com>
 <20251118034231.704240-7-zhao1.liu@intel.com>
 <5675fe47-f8ca-468a-abb6-449c88030a5f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5675fe47-f8ca-468a-abb6-449c88030a5f@redhat.com>
Received-SPF: pass client-ip=192.198.163.19; envelope-from=zhao1.liu@intel.com;
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

Hi Paolo,

> > +        /*
> > +         * AMX xstates are supported in KVM_GET_SUPPORTED_CPUID only when
> > +         * XSTATE_XTILE_DATA_MASK gets guest permission in
> > +         * kvm_request_xsave_components().
> > +         */
> > +        if (!((1 << i) & XSTATE_XTILE_MASK)) {
> 
> This should be XSTATE_DYNAMIC_MASK, 

XSTATE_DYNAMIC_MASK covers both XSTATE_XTILE_DATA_MASK and
XSTATE_XTILE_CFG_MASK, and XSTATE_DYNAMIC_MASK only has
XSTATE_XTILE_DATA_MASK.

On KVM side, kvm_get_filtered_xcr0() will mask off XTILE_CFG if
XTILE_DATA is filtered out.

So from this KVM logic, at current point, getting XTILE_CFG information
seems meaningless. Therefore I skip both XTILE_DATA and XTILE_CFG.

> but I don't like getting the information differently.  My understanding is
> that this is useful for the next patch, but I don't understand well why
> the next patch is needed. The commit message doesn't help.

My bad, my commit messages are not orginized well. Both patch 6 & 7 are
serving patch 8. Please let me explain in detail:

* In 0xD encoding, Arch LBR is checked specially, that's not needed.
  Before 0xD encoding, any dependencies check should be done. So there's
  patch 8 to drop such special check for Arch LBR.

  But there're 2 differences should be clarified before patch 8.

  - Arch LBR xstate CPUID is filled by x86_cpu_get_supported_cpuid(),
    and other xstates in 0xD is filled based on x86_ext_save_areas[].

    Ideally, all xstates CPUIDs should be from x86_ext_save_areas[] and
    x86_ext_save_areas[] is initialized by accelerators.

    So there's patch 7 to make ARCH LBR also use x86_ext_save_areas[] to
    encode its CPUID.

  - Arch LBR gets its xstate information by
    x86_cpu_get_supported_cpuid(), and other xstates (for KVM) in the
    x86_ext_save_areas[] are initialized by host_cpuid().

    I think this is a confusion. QEMU KVM doesn't need to use
    host_cpuid() to get xstates information. In fact, it should get this
    from KVM's get_cpuid ioctl (although KVM also use host info directly),
    just like HVF does.

    So this is what patch 6 does - avoid using host_cpuid as much as
    possible. For AMX states that require dynamic permission acquisition,
    since memory allocation is involved, I think it also makes sense to
    continue using host_cpuid().

The changes in patches 6~8 are rather trivial, mainly to address the
comments from the previous version... such as whether such replacements
(in patch 8) would change functionality, etc. So, in this version I'm
doing it step by step.

> Can you move the call to kvm_cpu_xsave_init() after
> x86_cpu_enable_xsave_components()?  Is it used anywhere before the CPU is
> running?

Yes, this is an "ugly" palce. I did not fully defer the initialization
of the xstate array earlier also because I observed that both HVF and
TCG have similar xsave initialization interfaces within their accelerator's
cpu_instance_init() function.

I think it might be better to do the same thing for HVF & TCG as well
(i.e., defer xstate initialization). Otherwise, if we only modify QEMU
KVM logic, it looks a bit fragmented... What do you think?

Thanks for your patience,
Zhao


