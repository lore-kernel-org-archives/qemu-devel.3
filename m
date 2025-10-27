Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85FC9CCF9EB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 08:44:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDIov-0001TX-LZ; Mon, 27 Oct 2025 04:43:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1vDIos-0001T6-Hb
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 04:43:16 -0400
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1vDIoo-0000tB-RC
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 04:43:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761554591; x=1793090591;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=EMbzEKeXsUzP0lsfCgvG+XKe9Fk6bXujPvl2lOBxAAQ=;
 b=Qd/zqtFL+DEGwkCEJ3RN+T/YNvVkDzYovPM8/LKx5J3GjgQx6Llm3TYu
 zUbtOvR27WVFMROUdw5SZzo3YZN8mhCELvHo4/050ftqOQQbycLBm4n7E
 HUlJLzqeGj/VhDZ8/ZEWje9wvOP6aMFwCrdscGcya8uFEUcGdWVVrIXp8
 8ivg99jtAggN/lDbhFh1NJk+W8o07BAqQ1B+W9Bs5yJCGbaL60sUcjvWJ
 eYqBK3SivW3dVOgwQSWYVNbLjEMZguVcfGO5zgySCCx08DzNk1J9L6PvA
 ylroUWx1rE7Aczy5S5NTISJ/Ji20J0lehmMtGmFl2AYH5rHHyORg5FqZM w==;
X-CSE-ConnectionGUID: wgZXzYXOTGGDqD5ojZoYyQ==
X-CSE-MsgGUID: lDNOuZxKQGiidqOk/HkBWw==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63780191"
X-IronPort-AV: E=Sophos;i="6.19,258,1754982000"; d="scan'208";a="63780191"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2025 01:43:05 -0700
X-CSE-ConnectionGUID: vfbcSDChQSmufMSf7Uh7yw==
X-CSE-MsgGUID: S7QixNJtSYCAjBQIFFYspg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,258,1754982000"; d="scan'208";a="184604403"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.238.14])
 ([10.124.238.14])
 by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2025 01:43:00 -0700
Message-ID: <0dc79cc8-f932-4025-aff3-b1d5b56cb654@intel.com>
Date: Mon, 27 Oct 2025 16:42:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/20] i386/cpu: Add missing migratable xsave features
To: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, Chao Gao
 <chao.gao@intel.com>, John Allen <john.allen@amd.com>,
 Babu Moger <babu.moger@amd.com>, Mathias Krause <minipli@grsecurity.net>,
 Dapeng Mi <dapeng1.mi@intel.com>, Zide Chen <zide.chen@intel.com>,
 Chenyi Qiang <chenyi.qiang@intel.com>, Farrah Chen <farrah.chen@intel.com>
References: <20251024065632.1448606-1-zhao1.liu@intel.com>
 <20251024065632.1448606-11-zhao1.liu@intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20251024065632.1448606-11-zhao1.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=198.175.65.16; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.57, HK_RANDOM_FROM=0.998, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
> Xtile-cfg & xtile-data are both user xstates. Their xstates are cached
> in X86CPUState, and there's a related vmsd "vmstate_amx_xtile", so that
> it's safe to mark them as migratable.
> 
> Arch lbr xstate is a supervisor xstate, and it is save & load by saving
> & loading related arch lbr MSRs, which are cached in X86CPUState, and
> there's a related vmsd "vmstate_arch_lbr". So it's also safe to mark it
> as migratable (even though KVM hasn't supported it - its migration
> support is completed in QEMU).
> 
> PT is still unmigratable since KVM disabled it and there's no vmsd and
> no other emulation/simulation support.

The patch itself looks reasonable.

I'm wondering why there is no issue reported since I believe folks 
tested the functionality of AMX live migration when AMX support was 
upstreamed. So I explore a bit and find that the 
migrable_flags/ungratable_flags in XCR0/XSS leaf don't take any effect 
because of the
x86_cpu_enable_xsave_components()

Though the feature expansion in x86_cpu_expand_features() under

	if (xcc->max_features) {
		...
	}

only enables migratable features when cpu->migratable is true, 
x86_cpu_enable_xsave_components() overwrite the value later.

> Tested-by: Farrah Chen <farrah.chen@intel.com>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---
>   target/i386/cpu.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 1917376dbea9..b01729ad36d2 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -1522,7 +1522,8 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
>           .migratable_flags = XSTATE_FP_MASK | XSTATE_SSE_MASK |
>               XSTATE_YMM_MASK | XSTATE_BNDREGS_MASK | XSTATE_BNDCSR_MASK |
>               XSTATE_OPMASK_MASK | XSTATE_ZMM_Hi256_MASK | XSTATE_Hi16_ZMM_MASK |
> -            XSTATE_PKRU_MASK,
> +            XSTATE_PKRU_MASK | XSTATE_ARCH_LBR_MASK | XSTATE_XTILE_CFG_MASK |
> +            XSTATE_XTILE_DATA_MASK,
>       },
>       [FEAT_XSAVE_XCR0_HI] = {
>           .type = CPUID_FEATURE_WORD,


