Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19A38C2BD09
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 03:19:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPD09-0007UK-GR; Wed, 03 Jul 2024 23:19:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1sPD07-0007Tp-IJ
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 23:19:15 -0400
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1sPD05-0000fo-OV
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 23:19:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1720063154; x=1751599154;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=W3bTFOLBuac1BrRBBLR71U03QeIrXChG8XHMyRtOPMI=;
 b=Yh85C+sqgexUxLYtfYLbCvyhLwn0EKrzbk9scUrp49AyaxWzrBVZDxy7
 580QZ+9DITF/1SatSC7jb+yZZqj5Ex5n4xlMX5minqlFHiwpWmzgE0MqV
 UffCOyOSbGqX1OzB4iYgRCD5z5P4iL0JaNon74q+nGnKoe20UzHSYJxqf
 C+sBUkLxfNGfd+hhlMiGOXalXkAkPhEFCnRhPWDPJWBMpscDjvQGu0FRA
 tZTzOzlw1DuWkcM0tUa4e7ajg9E+CKXUMvhAGLbsvBnEMZQ+KkM6Pu2hV
 hA9UcH92PEMonYiDrB5znyJCmMZh5k7eVKzIsEweaj+nsjd27GxaHPBt9 Q==;
X-CSE-ConnectionGUID: juz/FDUWRJK2cbrKURT+Yg==
X-CSE-MsgGUID: 6RHgkKdzTqSC7DWeB5D5WA==
X-IronPort-AV: E=McAfee;i="6700,10204,11122"; a="17460263"
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; d="scan'208";a="17460263"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jul 2024 20:19:12 -0700
X-CSE-ConnectionGUID: 1GUe2LA6TBKE4yNIKj+5Rg==
X-CSE-MsgGUID: UV4594Z8Q22iMh8sftHgYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; d="scan'208";a="46424241"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.240.26])
 ([10.124.240.26])
 by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jul 2024 20:19:08 -0700
Message-ID: <3f0c171e-b956-4b90-8a84-a0ce297053f3@intel.com>
Date: Thu, 4 Jul 2024 11:19:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] target/i386: Update CMPLegacy handling for Zhaoxin
 and VIA CPUs
To: Ewan Hai <ewanhai-oc@zhaoxin.com>, pbonzini@redhat.com
Cc: qemu-devel@nongnu.org, ewanhai@zhaoxin.com, cobechen@zhaoxin.com,
 rockcui@zhaoxin.com, louisqi@zhaoxin.com
References: <20240625091905.1325205-1-ewanhai-oc@zhaoxin.com>
 <20240625091905.1325205-5-ewanhai-oc@zhaoxin.com>
 <81ee1a67-e70f-4437-ab28-6c4d4f741d8b@intel.com>
 <7a988f9e-fc63-4a6d-b3b1-d416dfc7e982@zhaoxin.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <7a988f9e-fc63-4a6d-b3b1-d416dfc7e982@zhaoxin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.18; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001, RCVD_IN_DNSWL_MED=-2.3,
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

On 7/4/2024 11:14 AM, Ewan Hai wrote:
> On 7/3/24 10:49, Xiaoyao Li wrote:
>>
>> On 6/25/2024 5:19 PM, EwanHai wrote:
>>> Zhaoxin and VIA CPUs handle the CMPLegacy bit in the same way
>>> as Intel CPUs. This patch simplifies the existing logic by
>>> using the IS_XXX_CPU macro and includes checks for Zhaoxin
>>> and VIA vendors to align their behavior with Intel.
>>>
>>> Signed-off-by: EwanHai <ewanhai-oc@zhaoxin.com>
>>> ---
>>>   target/i386/cpu.c | 6 +++---
>>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
>>> index 50edff077e..0836416617 100644
>>> --- a/target/i386/cpu.c
>>> +++ b/target/i386/cpu.c
>>> @@ -6945,9 +6945,9 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t 
>>> index, uint32_t count,
>>>            * So don't set it here for Intel to make Linux guests happy.
>>>            */
>>>           if (threads_per_pkg > 1) {
>>> -            if (env->cpuid_vendor1 != CPUID_VENDOR_INTEL_1 ||
>>> -                env->cpuid_vendor2 != CPUID_VENDOR_INTEL_2 ||
>>> -                env->cpuid_vendor3 != CPUID_VENDOR_INTEL_3) {
>>> +            if (!IS_INTEL_CPU(env) &&
>>> +                !IS_ZHAOXIN_CPU(env) &&
>>> +                !IS_VIA_CPU(env)) {
>>
>> it seems you added ! by mistake.
>>
>>>                   *ecx |= 1 << 1; /* CmpLegacy bit */
>>>               }
>>>           }
>>
> For CPUID leaf 0x80000001 ECX bit 1, Intel defines it as "Bits 04-01: 
> Reserved,"
> whereas AMD defines it as "CmpLegacy, Core multi-processing legacy 
> mode." For Intel
> CPUs and those following Intel's behavior, this bit should not be set to 
> 1. Therefore,
> I believe the "!" here is correct.
> 

Sorry, I misread the original code.

I think maybe we can just use is_AMD_CPU(). But I'm not sure if any 
magic use case with customized VENDOR ID relies on it. So you code looks 
good to me.

