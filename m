Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 869D4C83013
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 11:43:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWvrP-0006vQ-3b; Wed, 02 Jul 2025 07:42:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uWvrL-0006uu-AY
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 07:42:39 -0400
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uWvrF-00072V-FZ
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 07:42:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751456553; x=1782992553;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=7WZYL9aCI7VaPVI7mqL5K3TFIKP0u5ajxiUVXGevXGI=;
 b=cyAMAtRuFDe76zSY2OT3tLMwo0vStcV+cEXU3jyJkiBYHOk37UKb05Vn
 N/849gAq6z9gTrSrKlotx8nsChL8sgVS08QEIijsP4cQYmPyCFDn+iZs0
 rTVsdiYvdEZGo9rAi1kcBTMZXnxamegZ3f4bFR28bcBdTYw7I6nhmUlS4
 veML9kyYW0FRD6IIMXDruV9qfxDGWoq/CPUAxMjcZ9J13k5FeHhyEBaP4
 DS76qHGjKozPzIJVNoyjuR4BBejj9sBNJrjZgMQTySkEZPET+ONFD5oou
 9QdgKyW2r2bZCvl1PHfZVVHx9BGTVAN/66LNYssrWQl1njrePGyPd8/V0 Q==;
X-CSE-ConnectionGUID: wXfa3MyHT0q3cPNp46BWmQ==
X-CSE-MsgGUID: GAPbCCO4RIyxr3HoVFIYEw==
X-IronPort-AV: E=McAfee;i="6800,10657,11481"; a="41374460"
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; d="scan'208";a="41374460"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2025 04:42:24 -0700
X-CSE-ConnectionGUID: qCpJRh6XSrO8ie8LWsQ7lw==
X-CSE-MsgGUID: NNBucaS9SUm+mbfeRqdxoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; d="scan'208";a="154785643"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2025 04:42:22 -0700
Message-ID: <76f8e877-e203-421f-b301-4b321534bd8b@intel.com>
Date: Wed, 2 Jul 2025 19:42:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Regression] Re: [PULL 35/35] qom: reverse order of
 instance_post_init calls
To: Zhao Liu <zhao1.liu@intel.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Dongli Zhang <dongli.zhang@oracle.com>, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org, Alistair Francis <alistair.francis@wdc.com>,
 Like Xu <like.xu.linux@gmail.com>, Igor Mammedov <imammedo@redhat.com>
References: <20250520110530.366202-1-pbonzini@redhat.com>
 <20250520110530.366202-36-pbonzini@redhat.com>
 <d429b6f5-b59c-4884-b18f-8db71cb8dc7b@oracle.com>
 <aFpocfTpBLB34N3l@intel.com> <aGKryLSGlFTMSKHv@intel.com>
 <690b5bca-4345-4ee9-a332-4c2e38532309@intel.com>
 <31387ca1-4fa0-482e-8e11-e8857c10cb6c@linaro.org>
 <aGTmFGC9vZB2yEwv@intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <aGTmFGC9vZB2yEwv@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.16; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 7/2/2025 3:56 PM, Zhao Liu wrote:
>>> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
>>> index 0d35e95430fe..bf290262cbfe 100644
>>> --- a/target/i386/cpu.c
>>> +++ b/target/i386/cpu.c
>>> @@ -9044,6 +9044,12 @@ static void x86_cpu_post_initfn(Object *obj)
>>>                X86_CONFIDENTIAL_GUEST(current_machine->cgs), (CPU(obj)));
>>>        }
>>>    #endif
>>> +
>>> +    /*
>>> +     * Re-apply the "feature[=foo]" from '-cpu' option since they might
>>> +     * be overwritten by above
>>> +     */
>>> +    qdev_prop_set_globals(DEVICE(obj));
>>>    }
>>
>> This patch LGTM.
> 
> This solution will call qdev_prop_set_globals() twice. My concern is
> that this masks the problem: previous x86 CPU assumptions about the
> order of global property initialization break down...
> 
> Per the commit message of Paolo's commit:
> 
> "This is incorrect because the leaf class cannot observe property
> values applied by the superclasses; for example, a compat property
> will be set on a device *after* the class's post_init callback has
> run."

After checking the history of why .post_instance_init() was introduced 
in the first place: 8231c2dd2203 ("qom: Introduce instance_post_init 
hook"). It turns out to be used for qdev_prop_set_globals(), to ensure 
global properties being applied after all sub-device specific 
instance_init() were called. And I think the order from child to parent 
was defined purposely.

And the reverse of Paolo's patch breaks the usage of "-global" than it 
won't take effect if the sub-device changes the property in its 
post_instance_init() callback.

Back to Paolo's example of "a compat property will be set on a device 
*after* the class's post_init callback has run". I think the behavior of 
compat property is applied after the class's post_init callback is also 
what we want. If reversing the order, then compat prop can be 
overwritten by subclass's post_init callback, and doesn't it fail the 
purpose of compat prop?

So I think we might revert this patch, and document clearly the reverse 
order of .post_instance_init() callback.

> X86 CPUs have the issue (e.g., "vendor" doesn't work) now because
> they - as leaf class, don't care about the property values of
> superclass - the DeviceState. If a property is just for initialization,
> like "vendor", it should be placed in the instance_init() instead of
> instance_post_init().
> 
> In addition, if other places handle it similarly, the device's
> post_init seems pointless. :-(
> 
> Thanks,
> Zhao
> 


