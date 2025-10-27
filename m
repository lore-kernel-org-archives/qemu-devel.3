Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D56ACCF9EB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 07:05:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDHIB-0006QJ-Ko; Mon, 27 Oct 2025 03:05:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1vDHI9-0006Pb-Vd
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 03:05:21 -0400
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1vDHI7-00051K-NU
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 03:05:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761548719; x=1793084719;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=92iIV6RDBJqkO12qftZuVJ7paoQuUYviIHpplpoCTWE=;
 b=egwhfqqtmmpkBx8w7yXkPdZv0EEbLAiY4CsD4HM8kM8i1VJj8gXetvjK
 MbGIrVa2I0BdPUvZHCJvNlGaWrp+pFxOOsfF5u+/s6bsUDWRgAlIMalEO
 qS9EG+BSUwcklcG8Cz/huz8YuegJW/6C3nUK3uNman/TLuHcyAwr7/56/
 qlS+gUmry0XiWf53BiYMW97qJpvSG/Tv5L8nUYo8nrPJlTGN17qGITD7y
 h+EzgW7zDPs+QRFOzqwnj2BlgoJRVkkvEIwtNf3uHbWCu51NkjtAAnwni
 EmW8OlqE01lb2EVviBVbqCyuPkkcDMDuGWB9WCjRLMvB6CWAznwesEWQg w==;
X-CSE-ConnectionGUID: Ku7JQ/fnQJWDqIPeFse38Q==
X-CSE-MsgGUID: UKhBTVlcQayGnxczZBipOQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="67266039"
X-IronPort-AV: E=Sophos;i="6.19,258,1754982000"; d="scan'208";a="67266039"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2025 00:05:17 -0700
X-CSE-ConnectionGUID: hAsd1gKVTF+3LEAswftFfg==
X-CSE-MsgGUID: TCS3iW28RdKATST0eLrExg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,258,1754982000"; d="scan'208";a="184583647"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.238.14])
 ([10.124.238.14])
 by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2025 00:05:14 -0700
Message-ID: <93f57118-99ea-4dc0-b2cb-a8f929f4cbfa@intel.com>
Date: Mon, 27 Oct 2025 15:05:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/20] i386/cpu: Add avx10 dependency for
 Opmask/ZMM_Hi256/Hi16_ZMM
To: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, Chao Gao
 <chao.gao@intel.com>, John Allen <john.allen@amd.com>,
 Babu Moger <babu.moger@amd.com>, Mathias Krause <minipli@grsecurity.net>,
 Dapeng Mi <dapeng1.mi@intel.com>, Zide Chen <zide.chen@intel.com>,
 Chenyi Qiang <chenyi.qiang@intel.com>, Farrah Chen <farrah.chen@intel.com>
References: <20251024065632.1448606-1-zhao1.liu@intel.com>
 <20251024065632.1448606-7-zhao1.liu@intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20251024065632.1448606-7-zhao1.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=198.175.65.15; envelope-from=xiaoyao.li@intel.com;
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
> With feature array in ExtSaveArea, add avx10 as the second dependency
> for Opmask/ZMM_Hi256/Hi16_ZMM xsave components, and drop the special
> check in cpuid_has_xsave_feature().
> 
> Tested-by: Farrah Chen <farrah.chen@intel.com>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

> ---
>   target/i386/cpu.c | 9 +++------
>   1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index cd269d15ce0b..236a2f3a9426 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -2054,18 +2054,21 @@ ExtSaveArea x86_ext_save_areas[XSAVE_STATE_AREA_COUNT] = {
>           .size = sizeof(XSaveOpmask),
>           .features = {
>               { FEAT_7_0_EBX,         CPUID_7_0_EBX_AVX512F },
> +            { FEAT_7_1_EDX,         CPUID_7_1_EDX_AVX10   },
>           },
>       },
>       [XSTATE_ZMM_Hi256_BIT] = {
>           .size = sizeof(XSaveZMM_Hi256),
>           .features = {
>               { FEAT_7_0_EBX,         CPUID_7_0_EBX_AVX512F },
> +            { FEAT_7_1_EDX,         CPUID_7_1_EDX_AVX10   },
>           },
>       },
>       [XSTATE_Hi16_ZMM_BIT] = {
>           .size = sizeof(XSaveHi16_ZMM),
>           .features = {
>               { FEAT_7_0_EBX,         CPUID_7_0_EBX_AVX512F },
> +            { FEAT_7_1_EDX,         CPUID_7_1_EDX_AVX10   },
>           },
>       },
>       [XSTATE_PKRU_BIT] = {
> @@ -8643,12 +8646,6 @@ static bool cpuid_has_xsave_feature(CPUX86State *env, const ExtSaveArea *esa)
>           }
>       }
>   
> -    if (esa->features[0].index == FEAT_7_0_EBX &&
> -        esa->features[0].mask == CPUID_7_0_EBX_AVX512F &&
> -        (env->features[FEAT_7_1_EDX] & CPUID_7_1_EDX_AVX10)) {
> -        return true;
> -    }
> -
>       return false;
>   }
>   


