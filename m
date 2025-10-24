Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8924ACCF9E3
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 18:21:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCMPY-0008Go-F0; Fri, 24 Oct 2025 14:21:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zide.chen@intel.com>)
 id 1vCMPW-0008Ga-BK
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 14:21:10 -0400
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zide.chen@intel.com>)
 id 1vCMPU-0008FU-La
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 14:21:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761330069; x=1792866069;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=len0glU2yj1H+jJxLFoYUNqMIXEmHQqgK+yIOKm5WK4=;
 b=QZiwuToAPXhlZ+rJr9JsDsuSgiDIwtcvsDR6bQehJiNFxvmeFyKZ4FUy
 AgmEGVuFIONUfrJD5oPR9Kdn1kvkbBG83bHrpS8cPVzuPaNY9d3p7ygv2
 MSZ24Wz+Jjf+VrwrSE88E9YS/RVCtd46J7BRHBzI964rJwRTKdO99GdOM
 N7x4ym9PGKRLdM8ii5o170y5UxZl4Ihjvhi2RnIFYk7RKyvPaV914vz6k
 qqAxD3pzGFi6L23voHlz8kYz4LscyEctEZEkvK7nzSwH7bLgXThOOwRzW
 rfMbC6VMb4wnXE88/EhVsVkywI3MUBI1qH0HdYcY5DERXeE2Xt97XD9rT Q==;
X-CSE-ConnectionGUID: gGaKdqOvSJ+x9VlqHj6LAQ==
X-CSE-MsgGUID: ylCje5b2RxGCeVEiAb9zCg==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="74119595"
X-IronPort-AV: E=Sophos;i="6.19,253,1754982000"; d="scan'208";a="74119595"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Oct 2025 11:21:07 -0700
X-CSE-ConnectionGUID: 2WCoOoWFRcy/c3j3blz6VQ==
X-CSE-MsgGUID: fk28vnV3Q3yKX/jhnR3r/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,253,1754982000"; d="scan'208";a="188882533"
Received: from soc-cp83kr3.clients.intel.com (HELO [10.241.241.181])
 ([10.241.241.181])
 by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Oct 2025 11:21:07 -0700
Message-ID: <03763c00-3f14-4cab-9a75-78771cbbb79a@intel.com>
Date: Fri, 24 Oct 2025 11:21:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/20] i386/cpu: Drop pmu check in CPUID 0x1C encoding
To: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, Chao Gao
 <chao.gao@intel.com>, John Allen <john.allen@amd.com>,
 Babu Moger <babu.moger@amd.com>, Mathias Krause <minipli@grsecurity.net>,
 Dapeng Mi <dapeng1.mi@intel.com>, Chenyi Qiang <chenyi.qiang@intel.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, Farrah Chen <farrah.chen@intel.com>
References: <20251024065632.1448606-1-zhao1.liu@intel.com>
 <20251024065632.1448606-9-zhao1.liu@intel.com>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <20251024065632.1448606-9-zhao1.liu@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.198.163.11; envelope-from=zide.chen@intel.com;
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



On 10/23/2025 11:56 PM, Zhao Liu wrote:
> Since CPUID_7_0_EDX_ARCH_LBR will be masked off if pmu is disabled,
> there's no need to check CPUID_7_0_EDX_ARCH_LBR feature with pmu.
> 
> Tested-by: Farrah Chen <farrah.chen@intel.com>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>

Reviewed-by: Zide Chen <zide.chen@intel.com>

> ---
>  target/i386/cpu.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 5b7a81fcdb1b..5cd335bb5574 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -8275,11 +8275,16 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>          }
>          break;
>      }
> -    case 0x1C:
> -        if (cpu->enable_pmu && (env->features[FEAT_7_0_EDX] & CPUID_7_0_EDX_ARCH_LBR)) {
> -            x86_cpu_get_supported_cpuid(0x1C, 0, eax, ebx, ecx, edx);
> -            *edx = 0;
> +    case 0x1C: /* Last Branch Records Information Leaf */
> +        *eax = 0;
> +        *ebx = 0;
> +        *ecx = 0;
> +        *edx = 0;
> +        if (!(env->features[FEAT_7_0_EDX] & CPUID_7_0_EDX_ARCH_LBR)) {
> +            break;
>          }
> +        x86_cpu_get_supported_cpuid(0x1C, 0, eax, ebx, ecx, edx);
> +        *edx = 0; /* EDX is reserved. */
>          break;
>      case 0x1D: {
>          /* AMX TILE, for now hardcoded for Sapphire Rapids*/


