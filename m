Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 320F8CCD1BF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 08:56:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDfUj-00007N-Lf; Tue, 28 Oct 2025 04:55:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1vDfUg-000065-4I
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 04:55:55 -0400
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1vDfUR-0007bC-BH
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 04:55:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761641739; x=1793177739;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=LDkly6JAWl+jNWu68ElLZLMn4bAcPr46JUM/YlHZDEM=;
 b=dEenYQUjBdqv305/3pgvDY9SXy9uVxtTxvi+eOspOalNYirppxmiuYZo
 9u5xWnJP3V1M4mVNBs/5tlFAyV12hTmRp3lNcjwfRa03i3QvmXX5ZyEai
 4rxYCDjuoMKfnLR/GrHI1gmqYsdQJkETD30Ifngt0BKAYti0OLfv2bDao
 BSKUBEm98ss+2c9Zd6+FVLPUHr/4pbS9VjHAkGavSVmTNH0ZgIEQga1Kc
 URwn7ftelVOJ3fZYdsgznXdhtEV/JV/nCI95hl8+Ev3M1Fh3PPG51/Id2
 VPXZxTuB0BakPlZ5yWlKtoST69oWidnuVgeqRvV1M2wWJRaWYE1Dh9dSF Q==;
X-CSE-ConnectionGUID: 5pF5CVQ5SyWg4cXP7eG0Qw==
X-CSE-MsgGUID: 0ToGk1qITyq27tccr9EhOg==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="51309699"
X-IronPort-AV: E=Sophos;i="6.19,261,1754982000"; d="scan'208";a="51309699"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Oct 2025 01:55:31 -0700
X-CSE-ConnectionGUID: Gooqyu1mSvqm+npkSCoOvA==
X-CSE-MsgGUID: 4/64+YRuQBqbi7MTw9YwmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,261,1754982000"; d="scan'208";a="189345914"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.238.14])
 ([10.124.238.14])
 by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Oct 2025 01:55:29 -0700
Message-ID: <ea4ff407-b5ee-4649-b5cd-82b626dca3ee@intel.com>
Date: Tue, 28 Oct 2025 16:55:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 20/20] i386/tdx: Add CET SHSTK/IBT into the supported
 CPUID by XFAM
To: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, Chao Gao
 <chao.gao@intel.com>, John Allen <john.allen@amd.com>,
 Babu Moger <babu.moger@amd.com>, Mathias Krause <minipli@grsecurity.net>,
 Dapeng Mi <dapeng1.mi@intel.com>, Zide Chen <zide.chen@intel.com>,
 Chenyi Qiang <chenyi.qiang@intel.com>, Farrah Chen <farrah.chen@intel.com>
References: <20251024065632.1448606-1-zhao1.liu@intel.com>
 <20251024065632.1448606-21-zhao1.liu@intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20251024065632.1448606-21-zhao1.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.198.163.16; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.574, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
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

On 10/24/2025 2:56 PM, Zhao Liu wrote:
> From: Chenyi Qiang <chenyi.qiang@intel.com>
> 
> So that it can be configured in TD guest.
> 
> And considerring cet-u and cet-s have the same dependencies, it's enough
> to only list cet-u in tdx_xfam_deps[].

In fact, this is not the reason.

The reason is that CET_U and CET_S bits are always same in supported 
XFAM reported by TDX module, i.e., either 00 or 11. So, we only need to 
choose one of them.

> Tested-by: Farrah Chen <farrah.chen@intel.com>
> Signed-off-by: Chenyi Qiang <chenyi.qiang@intel.com>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>

With commit message updated,

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

> ---
>   target/i386/kvm/tdx.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
> index a3444623657f..01619857685b 100644
> --- a/target/i386/kvm/tdx.c
> +++ b/target/i386/kvm/tdx.c
> @@ -526,6 +526,8 @@ TdxXFAMDep tdx_xfam_deps[] = {
>       { XSTATE_OPMASK_BIT,    { FEAT_7_0_EDX, CPUID_7_0_EDX_AVX512_FP16 } },
>       { XSTATE_PT_BIT,        { FEAT_7_0_EBX, CPUID_7_0_EBX_INTEL_PT } },
>       { XSTATE_PKRU_BIT,      { FEAT_7_0_ECX, CPUID_7_0_ECX_PKU } },
> +    { XSTATE_CET_U_BIT,     { FEAT_7_0_ECX, CPUID_7_0_ECX_CET_SHSTK } },
> +    { XSTATE_CET_U_BIT,     { FEAT_7_0_EDX, CPUID_7_0_EDX_CET_IBT } },
>       { XSTATE_XTILE_CFG_BIT, { FEAT_7_0_EDX, CPUID_7_0_EDX_AMX_BF16 } },
>       { XSTATE_XTILE_CFG_BIT, { FEAT_7_0_EDX, CPUID_7_0_EDX_AMX_TILE } },
>       { XSTATE_XTILE_CFG_BIT, { FEAT_7_0_EDX, CPUID_7_0_EDX_AMX_INT8 } },


