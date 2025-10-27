Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E07DFCCF9EC
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 11:17:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDLD7-0003ui-PH; Mon, 27 Oct 2025 07:16:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1vDLCv-0003Wx-DE
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 07:16:13 -0400
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1vDLCr-0000Eq-Oo
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 07:16:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761563771; x=1793099771;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=RSOrVX31vGcWfeQGlrfg+xZrYHFOOXx25gDBBxP1nsw=;
 b=DuBbk+Hi/x1aaxbLPIswrXqQfqoxNmy3FTvdW9VIQPbFbsci1CLil/Le
 oREybkbkqwnuN8118sAzhi3PXgbk5oEh2J5y81MKG3ml0ZXLUk5S7Rl17
 vTrGDyRDLx1QakbZId0HsPxHQxEKHIKi1Qo9S7z1djjPC3mVwaae9bb+Z
 U/63w+FeVztCXye/pH166/gyKck7ONUSNbzRglpXkYnJ7dqDLwDGJj6tr
 aBNt8B9VhGt9kLOlZOF3DqWaNsqEf7hD6+IrjDIELpRovziBYz2N/gWbQ
 Cs7UMRfGEElwmZNsY0F6R7cltw8N5H5jKka5hGmq/COp1Z/e/7MU6Q8Er Q==;
X-CSE-ConnectionGUID: bIRhVIdmSECwogiB/OuN3Q==
X-CSE-MsgGUID: EuTmhNc5ThOLxc8VxpvujA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="63539709"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; d="scan'208";a="63539709"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2025 04:16:06 -0700
X-CSE-ConnectionGUID: AWHDKMlCTMayMuuVaaROYA==
X-CSE-MsgGUID: TmDYxUY7SRau8PqAYyj0LA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,258,1754982000"; d="scan'208";a="184636872"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.238.14])
 ([10.124.238.14])
 by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2025 04:16:02 -0700
Message-ID: <b70c5b82-815b-4c4d-a1c6-f3f011d951f9@intel.com>
Date: Mon, 27 Oct 2025 19:15:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/20] i386/cpu: Reorganize dependency check for arch
 lbr state
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti
 <mtosatti@redhat.com>, qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Chao Gao <chao.gao@intel.com>, John Allen <john.allen@amd.com>,
 Babu Moger <babu.moger@amd.com>, Mathias Krause <minipli@grsecurity.net>,
 Dapeng Mi <dapeng1.mi@intel.com>, Zide Chen <zide.chen@intel.com>,
 Chenyi Qiang <chenyi.qiang@intel.com>, Farrah Chen <farrah.chen@intel.com>
References: <20251024065632.1448606-1-zhao1.liu@intel.com>
 <20251024065632.1448606-8-zhao1.liu@intel.com>
 <d34f682a-c6c0-4609-96e8-2a0b76585c7d@intel.com> <aP9FfUKoP2azthS8@intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <aP9FfUKoP2azthS8@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=198.175.65.21; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.574, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 10/27/2025 6:12 PM, Zhao Liu wrote:
>>>    * XSAVES feature bit (CPUID 0xD.0x1.EAX[bit 3]):
>>>
>>>      Arch lbr state is a supervisor state, which requires the XSAVES
>>>      feature support. Enumerate supported supervisor state based on XSAVES
>>>      feature bit in x86_cpu_enable_xsave_components().
>>>
>>>      Then it's safe to drop the check on XSAVES feature support during
>>>      CPUID 0XD encoding.
> 
> ...
> 
>>> +++ b/target/i386/cpu.c
>>> @@ -8174,16 +8174,6 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>>>                *ebx = xsave_area_size(xstate, true);
>>>                *ecx = env->features[FEAT_XSAVE_XSS_LO];
>>>                *edx = env->features[FEAT_XSAVE_XSS_HI];
>>> -            if (kvm_enabled() && cpu->enable_pmu &&
>>> -                (env->features[FEAT_7_0_EDX] & CPUID_7_0_EDX_ARCH_LBR) &&
>>> -                (*eax & CPUID_XSAVE_XSAVES)) {
>>> -                *ecx |= XSTATE_ARCH_LBR_MASK;
>>> -            } else {
>>> -                *ecx &= ~XSTATE_ARCH_LBR_MASK;
>>> -            }
>>
>>> -        } else if (count == 0xf && cpu->enable_pmu
>>> -                   && (env->features[FEAT_7_0_EDX] & CPUID_7_0_EDX_ARCH_LBR)) {
>>> -            x86_cpu_get_supported_cpuid(0xD, count, eax, ebx, ecx, edx);
>>
>> This chunk needs to be a separate patch. It's a functional change.
> 
> Already mentioned this in commit message.

Before this patch, if pmu is enabled and ARCH_LBR is configured, the 
leaf (0xd, 0xf) is constructed by

	x86_cpu_get_supported_cpuid()

after this patch, it's constructed to

	*eax = esa->size;
	*ebx = 0;
         *ecx = 1;

I'm not sure which part of the commit message mention it and clarify it.


