Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B458ECCD1BF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 08:32:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDf6C-0005hG-QV; Tue, 28 Oct 2025 04:30:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1vDf63-0005gp-OZ
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 04:30:33 -0400
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1vDf5o-0004Hn-Mx
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 04:30:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761640212; x=1793176212;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=NwoPJ+QPtaDuf+sBJLBVlCChGUU0Iuj/ciX76s/tQK8=;
 b=ZMXQFLqpcbttCx/5ZZUwxjUWsoxns7ZhUPfD8d/KcyrQRGVK2Hl80YyJ
 rKXZfC9T/KGevSIGu62A2gtx2XbO/f14tdldAhkn2wAPxyeSRnTl4A2rI
 vcuIa+h+Kv6pXBy4XDn+mpM58fjK/8cU4HZZOd9RBt/Fcn8QB5WN+9bez
 H2SO1CDQRztUhphn3oFA7curjamqKytlReAqC9mhBbYYZoBMwigiGFp37
 EsU3t6TAQJSJLxbrN+w43nRDwW6Md+Or5BfdcYR/WGCwjQ1fSQqjMGK53
 t94Bacf/nsJdFDh+YFKeJ3Vx62Mp2iOOMgnvk4+2ooHfqyH31fxUjZ/os A==;
X-CSE-ConnectionGUID: El8I9RWmTdu7uRxZGmPp2w==
X-CSE-MsgGUID: Y1EZc4QcTkCH/QMBIZvFBw==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="74020340"
X-IronPort-AV: E=Sophos;i="6.19,261,1754982000"; d="scan'208";a="74020340"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Oct 2025 01:30:06 -0700
X-CSE-ConnectionGUID: JYg7o9JqRVGXyvow0m2/tw==
X-CSE-MsgGUID: 1ZxJMpwlSru4aHM5d8YP1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,261,1754982000"; d="scan'208";a="189340578"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.238.14])
 ([10.124.238.14])
 by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Oct 2025 01:30:03 -0700
Message-ID: <445462e9-22e5-4e8b-999e-7be468731752@intel.com>
Date: Tue, 28 Oct 2025 16:29:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 15/20] i386/machine: Add vmstate for cet-ss and cet-ibt
To: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, Chao Gao
 <chao.gao@intel.com>, John Allen <john.allen@amd.com>,
 Babu Moger <babu.moger@amd.com>, Mathias Krause <minipli@grsecurity.net>,
 Dapeng Mi <dapeng1.mi@intel.com>, Zide Chen <zide.chen@intel.com>,
 Chenyi Qiang <chenyi.qiang@intel.com>, Farrah Chen <farrah.chen@intel.com>,
 Yang Weijiang <weijiang.yang@intel.com>
References: <20251024065632.1448606-1-zhao1.liu@intel.com>
 <20251024065632.1448606-16-zhao1.liu@intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20251024065632.1448606-16-zhao1.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=198.175.65.11; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.574, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
> From: Yang Weijiang <weijiang.yang@intel.com>
> 
> Add vmstates for cet-ss and cet-ibt
> 
> Tested-by: Farrah Chen <farrah.chen@intel.com>
> Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
> Co-developed-by: Chao Gao <chao.gao@intel.com>
> Signed-off-by: Chao Gao <chao.gao@intel.com>
> Co-developed-by: Zhao Liu <zhao1.liu@intel.com>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---
> Changes Since v2:
>   - Split a subsection "vmstate_ss" since shstk is user-configurable.
> ---
>   target/i386/machine.c | 53 +++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 53 insertions(+)
> 
> diff --git a/target/i386/machine.c b/target/i386/machine.c
> index 45b7cea80aa7..3ad07ec82428 100644
> --- a/target/i386/machine.c
> +++ b/target/i386/machine.c
> @@ -1668,6 +1668,58 @@ static const VMStateDescription vmstate_triple_fault = {
>       }
>   };
>   
> +static bool shstk_needed(void *opaque)
> +{
> +    X86CPU *cpu = opaque;
> +    CPUX86State *env = &cpu->env;
> +
> +    return !!(env->features[FEAT_7_0_ECX] & CPUID_7_0_ECX_CET_SHSTK);
> +}
> +
> +static const VMStateDescription vmstate_ss = {
> +    .name = "cpu/cet_ss",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .needed = shstk_needed,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_UINT64(env.pl0_ssp, X86CPU),
> +        VMSTATE_UINT64(env.pl1_ssp, X86CPU),
> +        VMSTATE_UINT64(env.pl2_ssp, X86CPU),
> +        VMSTATE_UINT64(env.pl3_ssp, X86CPU),
> +#ifdef TARGET_X86_64
> +        /* This MSR is only present on Intel 64 architecture. */
> +        VMSTATE_UINT64(env.int_ssp_table, X86CPU),
> +#endif

It seems we need to split int_ssp_table into a separate vmstate_*

Its .needed function needs to check both  CPUID_7_0_ECX_CET_SHSTK && 
CPUID_EXT2_LM.

> +        VMSTATE_UINT64(env.guest_ssp, X86CPU),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +static bool cet_needed(void *opaque)
> +{
> +    X86CPU *cpu = opaque;
> +    CPUX86State *env = &cpu->env;
> +
> +    return !!((env->features[FEAT_7_0_ECX] & CPUID_7_0_ECX_CET_SHSTK) ||
> +              (env->features[FEAT_7_0_EDX] & CPUID_7_0_EDX_CET_IBT));
> +}
> +
> +static const VMStateDescription vmstate_cet = {
> +    .name = "cpu/cet",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .needed = cet_needed,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_UINT64(env.u_cet, X86CPU),
> +        VMSTATE_UINT64(env.s_cet, X86CPU),
> +        VMSTATE_END_OF_LIST()
> +    },
> +    .subsections = (const VMStateDescription * const []) {
> +        &vmstate_ss,
> +        NULL,
> +    },
> +};
> +
>   const VMStateDescription vmstate_x86_cpu = {
>       .name = "cpu",
>       .version_id = 12,
> @@ -1817,6 +1869,7 @@ const VMStateDescription vmstate_x86_cpu = {
>   #endif
>           &vmstate_arch_lbr,
>           &vmstate_triple_fault,
> +        &vmstate_cet,

missing &vmstate_ss

>           NULL
>       }
>   };


