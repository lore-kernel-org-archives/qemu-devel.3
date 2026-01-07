Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F691CF6BF1
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 07:00:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdNWO-0003rP-TU; Wed, 07 Jan 2026 01:59:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vdNWN-0003qL-AD
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 01:59:55 -0500
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vdNWK-0006gG-LQ
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 01:59:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1767769193; x=1799305193;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=gMisxaofBYxdozgayUag/9U3gcvpdLXLk+lKQ42GR/Q=;
 b=cj0RaKK37d4Shwrwp/83qxxLWb4wGa4H2I2ukLapCZts5a/SXqZiYH2H
 zxv+kE3WediEPtWXu735vL704g3xistiXmtDu3GTajQaWxfMYSVOPKjxQ
 uIwDikYYvGRuYM3b0LMpYf1sILSRiHZMTwZm97KTexV7+fF/QIyxbrqB6
 IQrLaruGlJbVa4lwpiALYOxTbcn8TrHn8FvsquOJrySkX9yMRFjTb2TQ8
 RDRUeI9L+JjHgGRd5/M1xj2ipFMmQNPmuVqK+Ti90gS8AZufFDWnYmYU7
 g8VGRM2xlDBqEBThHsChBKNE4zvuuqUkSTc/WFjWWA4rwMP+8QX1qU//q g==;
X-CSE-ConnectionGUID: GbykIvaRQwOjsCxh9NR3Wg==
X-CSE-MsgGUID: FG8dmFpnTG27RlC8wwJCYA==
X-IronPort-AV: E=McAfee;i="6800,10657,11663"; a="69046134"
X-IronPort-AV: E=Sophos;i="6.21,207,1763452800"; d="scan'208";a="69046134"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jan 2026 22:59:49 -0800
X-CSE-ConnectionGUID: 0oNHSyUsR52hBjQBsJmbLg==
X-CSE-MsgGUID: EA1t0KhxQY+CouqlGdmSpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,207,1763452800"; d="scan'208";a="203301259"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa009.fm.intel.com with ESMTP; 06 Jan 2026 22:59:44 -0800
Date: Wed, 7 Jan 2026 15:25:10 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Shivansh Dhiman <shivansh.dhiman@amd.com>
Cc: pbonzini@redhat.com, mtosatti@redhat.com, kvm@vger.kernel.org,
 qemu-devel@nongnu.org, seanjc@google.com, santosh.shukla@amd.com,
 nikunj.dadhania@amd.com, ravi.bangoria@amd.com, babu.moger@amd.com
Subject: Re: [PATCH 1/5] i386: Implement CPUID 0x80000026
Message-ID: <aV4KVjjZXZSB5YGw@intel.com>
References: <20251121083452.429261-1-shivansh.dhiman@amd.com>
 <20251121083452.429261-2-shivansh.dhiman@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251121083452.429261-2-shivansh.dhiman@amd.com>
Received-SPF: pass client-ip=192.198.163.17; envelope-from=zhao1.liu@intel.com;
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

Hi Shivansh,

Sorry for late reply.

On Fri, Nov 21, 2025 at 08:34:48AM +0000, Shivansh Dhiman wrote:
> Date: Fri, 21 Nov 2025 08:34:48 +0000
> From: Shivansh Dhiman <shivansh.dhiman@amd.com>
> Subject: [PATCH 1/5] i386: Implement CPUID 0x80000026
> X-Mailer: git-send-email 2.43.0
> 
> Implement CPUID leaf 0x80000026 (AMD Extended CPU Topology). It presents the
> complete topology information to guests via a single CPUID with multiple
> subleafs, each describing a specific hierarchy level, viz. core, complex,
> die, socket.
> 
> Note that complex/CCX level relates to "die" in QEMU, and die/CCD level is
> not supported in QEMU yet. Hence, use CCX at CCD level until diegroups are
> implemented.

I'm trying to understand AMD's topology hierarchy by comparing it to the
kernel's arch/x86/kernel/cpu/topology_ext.c file:

static const unsigned int topo_domain_map_0b_1f[MAX_TYPE_1F] = {
	[SMT_TYPE]	= TOPO_SMT_DOMAIN,
	[CORE_TYPE]	= TOPO_CORE_DOMAIN,
	[MODULE_TYPE]	= TOPO_MODULE_DOMAIN,
	[TILE_TYPE]	= TOPO_TILE_DOMAIN,
	[DIE_TYPE]	= TOPO_DIE_DOMAIN,
	[DIEGRP_TYPE]	= TOPO_DIEGRP_DOMAIN,
};

static const unsigned int topo_domain_map_80000026[MAX_TYPE_80000026] = {
	[SMT_TYPE]		= TOPO_SMT_DOMAIN,
	[CORE_TYPE]		= TOPO_CORE_DOMAIN,
	[AMD_CCD_TYPE]		= TOPO_TILE_DOMAIN,
	[AMD_SOCKET_TYPE]	= TOPO_DIE_DOMAIN,
};

What particularly puzzles me is that "complex" isn't listed here, yet it
should be positioned between "core" and CCD. Does this mean complex
actually corresponds to kernel's module domain?

Back to QEMU, now CCX is mapped as QEMU's die level, and AMD socket is mapped
to socket level. Should we revisit QEMU's topology level mapping for AMD, to
align with the above topology domain mapping?

If we want to go further: supporting CCD configuration would be quite
tricky. I feel that adding another new parameter between the smp.dies
and smp.sockets would create significant confusion.

> Signed-off-by: Shivansh Dhiman <shivansh.dhiman@amd.com>
> ---
>  target/i386/cpu.c     | 76 +++++++++++++++++++++++++++++++++++++++++++
>  target/i386/kvm/kvm.c | 17 ++++++++++
>  2 files changed, 93 insertions(+)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 641777578637..b7827e448aa5 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -495,6 +495,78 @@ static void encode_topo_cpuid1f(CPUX86State *env, uint32_t count,
>      assert(!(*eax & ~0x1f));
>  }
>  
> +/*
> + * CPUID_Fn80000026: Extended CPU Topology
> + *
> + * EAX Bits Description
> + * 31:5 Reserved
> + *  4:0 Number of bits to shift Extended APIC ID right to get a unique
> + *      topology ID of the current hierarchy level.
> + *
> + * EBX Bits Description
> + * 31:16 Reserved
> + * 15:0  Number of logical processors at the current hierarchy level.
> + *
> + * ECX Bits Description
> + * 31:16 Reserved
> + * 15:8  Level Type. Values:
> + *       Value   Description
> + *       0h      Reserved
> + *       1h      Core
> + *       2h      Complex
> + *       3h      Die
> + *       4h      Socket
> + *       FFh-05h Reserved
> + * 7:0   Input ECX
> + *
> + * EDX Bits Description
> + * 31:0 Extended APIC ID of the logical processor
> + */

I feel this long comment is not necessary, since people could check APM for
details. Or this description could be included in commit message.

> +static void encode_topo_cpuid80000026(CPUX86State *env, uint32_t count,
> +                                X86CPUTopoInfo *topo_info,
> +                                uint32_t *eax, uint32_t *ebx,
> +                                uint32_t *ecx, uint32_t *edx)

Regards,
Zhao


