Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0FCCCCD183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 09:47:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9KZN-0000vx-NR; Thu, 16 Oct 2025 05:46:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1v9KZL-0000vd-G2
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 05:46:47 -0400
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1v9KZF-0003im-SI
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 05:46:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760608002; x=1792144002;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=d4WbKXy5ahZh7Dp0uGXOHG3aAB9xz6hsI0Q0UIh25sY=;
 b=iAqRSD06OmhRGy/d1gJhzDRJDC7VXXGPMrFZQWIn7XxfKJHU/XpUb1Dp
 cvJlJuylvcL7EZSwAq6xHlAsIpY8/zikFkbK1uX8PVwTkGbgsd21obhz1
 v5mcQN+o/Amrf38TnQ1n+XLQiCqZi+peGm8XGs4N36O0KAMlDGnGwTDaX
 jl2nIMWy54Tfv9aNXrbxErJZP651IVYNU907vzCJmX7MI8tiIHYUILA1Q
 udUVE+3Hdp55ffE8z9a9whvGhy0mjT+osQ7r20gic3q1U+Jv7P5zM0Mw0
 PSrr07qkHKuMFh00ECngx3xPiJbOLbs84xbuRt9zCNdLcQeRVZDAyBW48 w==;
X-CSE-ConnectionGUID: E4bfqSc2T3aAZrcHzT/DHw==
X-CSE-MsgGUID: li8ROjlmT/Gq/+aRNNumQQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11583"; a="62836976"
X-IronPort-AV: E=Sophos;i="6.19,233,1754982000"; d="scan'208";a="62836976"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Oct 2025 02:46:37 -0700
X-CSE-ConnectionGUID: DuYoG6orQmOiDZSo2ckhIQ==
X-CSE-MsgGUID: ak7huOpiTlK8L+wTJo67Hg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,233,1754982000"; d="scan'208";a="186425914"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.238.14])
 ([10.124.238.14])
 by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Oct 2025 02:46:35 -0700
Message-ID: <d0494262-a805-4311-bcb1-c47bdf1f0eac@intel.com>
Date: Thu, 16 Oct 2025 17:46:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] target/i386: Use X86ASIdx_MEM in kvm_init()
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20251014094216.164306-1-xiaoyao.li@intel.com>
 <20251014094216.164306-3-xiaoyao.li@intel.com>
 <c82e0b7d-c22c-41b5-a9e8-757a590cf719@linaro.org>
 <af20ba0c-26ad-48d7-a135-918f14b8d63e@redhat.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <af20ba0c-26ad-48d7-a135-918f14b8d63e@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.14; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On 10/16/2025 5:23 PM, Paolo Bonzini wrote:
> On 10/16/25 10:43, Philippe Mathieu-Daudé wrote:
>> On 14/10/25 11:42, Xiaoyao Li wrote:
>>> When the patch introduces 'enum X86ADIdx'[0] got merged, it somehow
>>> missed the change to replace as id 0 with X86ASIdx_MEM in kvm_init().
> 
> It wasn't missed, it broke CI. ;)

I see.

I missed the fact that Philippe pointed out:

   this is a generic code use by multiple architectures.

Sorry for the wrong patch.

> Paolo
> 
>>> Change the leftover in kvm_init() to make the usage consistent.
>>>
>>> [0] https://lore.kernel.org/qemu-devel/20250730095253.1833411-3- 
>>> xiaoyao.li@intel.com/
>>>
>>> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
>>> ---
>>>   accel/kvm/kvm-all.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
>>> index 58802f7c3cc1..3030c47d55b1 100644
>>> --- a/accel/kvm/kvm-all.c
>>> +++ b/accel/kvm/kvm-all.c
>>> @@ -2800,7 +2800,7 @@ static int kvm_init(AccelState *as, 
>>> MachineState *ms)
>>>       s->memory_listener.listener.coalesced_io_del = 
>>> kvm_uncoalesce_mmio_region;
>>>       kvm_memory_listener_register(s, &s->memory_listener,
>>> -                                 &address_space_memory, 0, "kvm- 
>>> memory");
>>> +                                 &address_space_memory, 
>>> X86ASIdx_MEM, "kvm-memory");
>>
>> NAck: this is a generic code use by multiple architectures.
>>
>>
> 


