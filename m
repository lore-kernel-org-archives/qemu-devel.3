Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0C9FC5AD49
	for <qemu-devel@archiver.kernel.org>; Thu, 29 May 2025 07:26:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKXeJ-00058a-LS; Thu, 29 May 2025 03:25:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uKXeH-00058M-7F
 for qemu-devel@nongnu.org; Thu, 29 May 2025 03:25:57 -0400
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uKXe8-0005HQ-E3
 for qemu-devel@nongnu.org; Thu, 29 May 2025 03:25:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748503548; x=1780039548;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=jks/0wNU+eKVRliWSuFjRMXSj/aFk8yeov2WcLwYI4Q=;
 b=LjVZTDDvIuwWnTgYhUD2j5/9XDz8nwVBcXKVVXQMhlvowvDlnGn3tsgd
 R1a0aC3md6UwtV8oYq74HHDg3T3n794Vj8atQKSg3FVF4VUwXLy+PpDtr
 WCvS3a+S10jry6/e6E6ZElwgenf2hWpgSgARVq+lRMOtpB+rIJR5XYVa1
 wG0Qf1UMZO54Kv7MQ/171himu4nkJPLvehCU6/x1lam4Cqyi0ftzGZt/e
 /VQn0tcNTlUDiWvFbzIFF3wMqP5eVxvc+QPdQPAf70841IMlyIqWh1QQ7
 H04j6uTNCNu7rMytSMEOSnb0tzpaZr+fJhTT/IAtO6tn0JgZZ3um1V6WL A==;
X-CSE-ConnectionGUID: Nfl9fHTaRE+sMZnEwMOGPg==
X-CSE-MsgGUID: 3fxXlVBhTlmf0CoUTCoUrg==
X-IronPort-AV: E=McAfee;i="6700,10204,11447"; a="67971101"
X-IronPort-AV: E=Sophos;i="6.15,323,1739865600"; d="scan'208";a="67971101"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 May 2025 00:25:45 -0700
X-CSE-ConnectionGUID: BaF1pdlFQtKLYk6YNig+8A==
X-CSE-MsgGUID: CF29+2VhTeS8AJomEXp4Jg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,323,1739865600"; d="scan'208";a="147376310"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 May 2025 00:25:44 -0700
Message-ID: <11ac1863-ac8d-4c03-906e-05f96b33295a@intel.com>
Date: Thu, 29 May 2025 15:25:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/3] target/i386: Add a new CPU feature word for
 CPUID.7.1.ECX
To: Paolo Bonzini <pbonzini@redhat.com>, "Xin Li (Intel)" <xin@zytor.com>,
 qemu-devel@nongnu.org
Cc: mtosatti@redhat.com, xin3.li@intel.com
References: <20250103084827.1820007-1-xin@zytor.com>
 <20250103084827.1820007-3-xin@zytor.com>
 <859d17d7-2f5f-456c-887e-7a50134a205d@intel.com>
 <e63cbab9-3a9b-4556-aa44-3783573df32c@redhat.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <e63cbab9-3a9b-4556-aa44-3783573df32c@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.10; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -62
X-Spam_score: -6.3
X-Spam_bar: ------
X-Spam_report: (-6.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.904,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.998, RCVD_IN_DNSWL_MED=-2.3,
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

On 5/29/2025 3:13 PM, Paolo Bonzini wrote:
> On 5/26/25 05:47, Xiaoyao Li wrote:
>> On 1/3/2025 4:48 PM, Xin Li (Intel) wrote:
>>> The immediate form of MSR access instructions will use this new CPU
>>> feature word.
>>>
>>> Signed-off-by: Xin Li (Intel) <xin@zytor.com>
>>> ---
>>>   target/i386/cpu.c | 23 ++++++++++++++++++++++-
>>>   target/i386/cpu.h |  1 +
>>>   2 files changed, 23 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
>>> index 8a1223acb3..2fb05879c3 100644
>>> --- a/target/i386/cpu.c
>>> +++ b/target/i386/cpu.c
>>> @@ -894,6 +894,7 @@ void x86_cpu_vendor_words2str(char *dst, uint32_t 
>>> vendor1,
>>>   #define TCG_7_1_EAX_FEATURES (CPUID_7_1_EAX_FZRM | 
>>> CPUID_7_1_EAX_FSRS | \
>>>             CPUID_7_1_EAX_FSRC | CPUID_7_1_EAX_CMPCCXADD)
>>> +#define TCG_7_1_ECX_FEATURES 0
>>>   #define TCG_7_1_EDX_FEATURES 0
>>>   #define TCG_7_2_EDX_FEATURES 0
>>>   #define TCG_APM_FEATURES 0
>>> @@ -1133,6 +1134,25 @@ FeatureWordInfo 
>>> feature_word_info[FEATURE_WORDS] = {
>>>           },
>>>           .tcg_features = TCG_7_1_EAX_FEATURES,
>>>       },
>>> +    [FEAT_7_1_ECX] = {
>>> +        .type = CPUID_FEATURE_WORD,
>>> +        .feat_names = {
>>> +            NULL, NULL, NULL, NULL,
>>> +            NULL, NULL, NULL, NULL,
>>> +            NULL, NULL, NULL, NULL,
>>> +            NULL, NULL, NULL, NULL,
>>> +            NULL, NULL, NULL, NULL,
>>> +            NULL, NULL, NULL, NULL,
>>> +            NULL, NULL, NULL, NULL,
>>> +            NULL, NULL, NULL, NULL,
>>
>> This looks silly, and the size of feat_names[] was changed from 32 to 
>> 64. Just explicitly assign the first 32 entries with NULL doesn't make 
>> any sense after the size change.
> 
> 64 is just for MSR features.  This is a bit silly, I agree, but it is 
> consistent with existing feature words and ultimately it becomes more 
> compact after just 9 features.  So I'm queuing Xin's patches as they are.

Yes. It makes sense for this reason, especially that this leaf is 
general feature enumeration leaf and destined to be filled up in the future.

> Thanks for the review though!  It's always appreciated even if we disagree.

My pleasure.


