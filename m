Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DFABCCF9E0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 07:52:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDI1J-0006Jj-5c; Mon, 27 Oct 2025 03:52:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1vDI1G-0006JN-VG
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 03:51:59 -0400
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1vDI1E-0002fL-Uh
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 03:51:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761551517; x=1793087517;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=hUssZkK1Y/cmoggTCHRLo6w9ZYPSDnuXfS58DzvKqDY=;
 b=Di2Z3c4gUmTX9LQsuRQJyAfcTrKVvzI06yFcOgbuU67ow/P0Ar+Eo0dT
 MR6RYp7SuNiDXJo6LF76hcmogDSQwCjJZWkxi1uc/p0V1O7VAOf5+C4z/
 4/i0KwDN+vEU5btkVeAhPgjn9QgWjk/pQraZi54+HDcv7UQUN2bip7EnO
 NIV5spEzUWUPM3IxM1kxyJ3m22alzpE1qxC6+Ad0TWxAz6C9VaX5/SV1h
 kn7oK/9SO0llf9fe4pX4nmWk40HhkNexqA9NeA0Lr1PIPX/Fyl1WvfYXd
 89MnxklP8u8WNwAlIjkNm54L6Yy/hk/WaBJatlt/7reETJewpLALx1Ri0 Q==;
X-CSE-ConnectionGUID: p9bIT2ztQsulCYnx4TEyTg==
X-CSE-MsgGUID: XNheT0sYSSGfC1I/26EX5Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="63525424"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; d="scan'208";a="63525424"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2025 00:51:53 -0700
X-CSE-ConnectionGUID: 08A+90eYQHyYkn7tvbED7Q==
X-CSE-MsgGUID: 8q10nxgbRaePCOXum/LZyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,258,1754982000"; d="scan'208";a="184593865"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.238.14])
 ([10.124.238.14])
 by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2025 00:51:50 -0700
Message-ID: <ab59bf10-3d16-4c34-b87d-31002fe83142@intel.com>
Date: Mon, 27 Oct 2025 15:51:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/20] i386/cpu: Drop pmu check in CPUID 0x1C encoding
To: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, Chao Gao
 <chao.gao@intel.com>, John Allen <john.allen@amd.com>,
 Babu Moger <babu.moger@amd.com>, Mathias Krause <minipli@grsecurity.net>,
 Dapeng Mi <dapeng1.mi@intel.com>, Zide Chen <zide.chen@intel.com>,
 Chenyi Qiang <chenyi.qiang@intel.com>, Farrah Chen <farrah.chen@intel.com>
References: <20251024065632.1448606-1-zhao1.liu@intel.com>
 <20251024065632.1448606-9-zhao1.liu@intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20251024065632.1448606-9-zhao1.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=198.175.65.21; envelope-from=xiaoyao.li@intel.com;
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
> Since CPUID_7_0_EDX_ARCH_LBR will be masked off if pmu is disabled,
> there's no need to check CPUID_7_0_EDX_ARCH_LBR feature with pmu.
> 
> Tested-by: Farrah Chen <farrah.chen@intel.com>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

> ---
>   target/i386/cpu.c | 13 +++++++++----
>   1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 5b7a81fcdb1b..5cd335bb5574 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -8275,11 +8275,16 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>           }
>           break;
>       }
> -    case 0x1C:
> -        if (cpu->enable_pmu && (env->features[FEAT_7_0_EDX] & CPUID_7_0_EDX_ARCH_LBR)) {
> -            x86_cpu_get_supported_cpuid(0x1C, 0, eax, ebx, ecx, edx);
> -            *edx = 0;
> +    case 0x1C: /* Last Branch Records Information Leaf */
> +        *eax = 0;
> +        *ebx = 0;
> +        *ecx = 0;
> +        *edx = 0;

Could you help write a patch to move the initialization-to-0 operation 
out to the switch() handling as the common first handling. So that each 
case doesn't need to set them to 0 individually.

> +        if (!(env->features[FEAT_7_0_EDX] & CPUID_7_0_EDX_ARCH_LBR)) {
> +            break;
>           }
> +        x86_cpu_get_supported_cpuid(0x1C, 0, eax, ebx, ecx, edx);
> +        *edx = 0; /* EDX is reserved. */

Not the fault of this series. I think just presenting what KVM returns 
to guest (i.e., directly passthrough) isn't correct. Once leaf 0x1c gets 
more bits defined and KVM starts to support and report them, then the 
bits presented to guest get changed automatically between different KVM.

the leaf 0x1c needs to be configurable and QEMU needs to ensure the same 
configuration outputs the constant result of leaf 0x1c, to ensure safe 
migration.

It's not urgent though. KVM doesn't even support ArchLBR yet.

>           break;
>       case 0x1D: {
>           /* AMX TILE, for now hardcoded for Sapphire Rapids*/


