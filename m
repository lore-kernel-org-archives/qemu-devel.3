Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7E62C19F4E
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 08:41:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzuef-0005Kt-9Z; Thu, 25 Apr 2024 04:40:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rzueb-0005KS-SD
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 04:40:29 -0400
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rzueR-00012H-3z
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 04:40:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1714034419; x=1745570419;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=K/Cg5XtNto2C/13YZaMoG170H77iS2HAQOjxL3QuFD8=;
 b=khzFD1IJ3JmMPtmIM83+RsI9piLo2zmThhpL6/T8oIQOYUGo6l1QQEac
 bkbsAG0jjIT8XPFcUeWSqnUmdHhGWkJpoP8+Bd04tGk04u+Dgg4RG77Lr
 KOOFosuEy4sXRli4jwoxn9mOwoaNpeTm8JYkzfBFynJ9yQQ5U2YOngz8e
 4+pk8tz/0YbPGDQDu2bHUlG/wNcruqdzeiPiuICLIvEO3GxT2L6va6ylM
 +qM/yI/P3iFnPyXDX+qXpwctdNe1Y2VLGyn1EVpN4gklqM/BBJxwI5pJ+
 jrfppVNV+s0Z0+Dtg6mu95Y9UsD+ssfRzSrfvHHNkxJwyipi4ewczoFKh Q==;
X-CSE-ConnectionGUID: csjTzihoSPC/t1lY7rLZWw==
X-CSE-MsgGUID: FTGmstGwQr2T7FxFIi4nSg==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="9570768"
X-IronPort-AV: E=Sophos;i="6.07,228,1708416000"; 
   d="scan'208";a="9570768"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Apr 2024 01:40:16 -0700
X-CSE-ConnectionGUID: BY6rdOebSoCkhZNBuGSy/g==
X-CSE-MsgGUID: BavTUoOpSpK1M8a6krZjOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,228,1708416000"; d="scan'208";a="29630606"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.242.48])
 ([10.124.242.48])
 by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Apr 2024 01:40:12 -0700
Message-ID: <eb5cfa25-6490-4b8d-8552-4be2662d15d2@intel.com>
Date: Thu, 25 Apr 2024 16:40:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.1 0/7] target/i386/kvm: Cleanup the kvmclock feature
 name
To: Zhao Liu <zhao1.liu@linux.intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, "Michael S . Tsirkin"
 <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Tim Wiederhake <twiederh@redhat.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Zhao Liu <zhao1.liu@intel.com>
References: <20240329101954.3954987-1-zhao1.liu@linux.intel.com>
 <fb252e78-2e71-4422-9499-9eac69102eec@intel.com> <ZioDhpYUOEdGbWgE@intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <ZioDhpYUOEdGbWgE@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.198.163.17; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.668,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
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

On 4/25/2024 3:17 PM, Zhao Liu wrote:
> Hi Xiaoyao,
> 
> On Wed, Apr 24, 2024 at 11:57:11PM +0800, Xiaoyao Li wrote:
>> Date: Wed, 24 Apr 2024 23:57:11 +0800
>> From: Xiaoyao Li <xiaoyao.li@intel.com>
>> Subject: Re: [PATCH for-9.1 0/7] target/i386/kvm: Cleanup the kvmclock
>>   feature name
>>
>> On 3/29/2024 6:19 PM, Zhao Liu wrote:
>>> From: Zhao Liu <zhao1.liu@intel.com>
>>>
>>> Hi list,
>>>
>>> This series is based on Paolo's guest_phys_bits patchset [1].
>>>
>>> Currently, the old and new kvmclocks have the same feature name
>>> "kvmclock" in FeatureWordInfo[FEAT_KVM].
>>>
>>> When I tried to dig into the history of this unusual naming and fix it,
>>> I realized that Tim was already trying to rename it, so I picked up his
>>> renaming patch [2] (with a new commit message and other minor changes).
>>>
>>> 13 years age, the same name was introduced in [3], and its main purpose
>>> is to make it easy for users to enable/disable 2 kvmclocks. Then, in
>>> 2012, Don tried to rename the new kvmclock, but the follow-up did not
>>> address Igor and Eduardo's comments about compatibility.
>>>
>>> Tim [2], not long ago, and I just now, were both puzzled by the naming
>>> one after the other.
>>
>> The commit message of [3] said the reason clearly:
>>
>>    When we tweak flags involving this value - specially when we use "-",
>>    we have to act on both.
>>
>> So you are trying to change it to "when people want to disable kvmclock,
>> they need to use '-kvmclock,-kvmclock2' instead of '-kvmclock'"
>>
>> IMHO, I prefer existing code and I don't see much value of differentiating
>> them. If the current code puzzles you, then we can add comment to explain.
> 
> It's enough to just enable kvmclock2 for Guest; kvmclock (old) is
> redundant in the presence of kvmclock2.
> 
> So operating both feature bits at the same time is not a reasonable
> choice, we should only keep kvmclock2 for Guest. It's possible because
> the oldest linux (v4.5) which QEMU i386 supports has kvmclock2.

who said the oldest Linux QEMU supports is from 4.5? what about 2.x kernel?

Besides, not only the Linux guest, whatever guest OS is, it will be 
broken if the guest is using kvmclock and QEMU starts to drop support of 
kvmclock.

So, again, hard NAK to drop the support of kvmclock. It breaks existing 
guests that use kvmclock. You cannot force people to upgrade their 
existing VMs to use kvmclock2 instead of kvmclock.

> Pls see:
> https://elixir.bootlin.com/linux/v4.5/source/arch/x86/include/uapi/asm/kvm_para.h#L22
> 
> With this in mind, I'm trying to implement a silky smooth transition to
> "only kcmclock2 support".
> 
> This series is now separating kvmclock and kvmclock2, and then I plan to
> go to the KVM side and deprecate kvmclock2, and then finally remove
> kvmclock (old) in QEMU. Separating the two features makes the process
> clearer.
> 
> Continuing to use the same name equally would have silently caused the
> CPUID to change on the Guest side, which would have hurt compatibility
> as well.
> 
>>> So, this series is to push for renaming the new kvmclock feature to
>>> "kvmclock2" and adding compatibility support for older machines (PC 9.0
>>> and older).
>>>
>>> Finally, let's put an end to decades of doubt about this name.
>>>
>>>
>>> Next Step
>>> =========
>>>
>>> This series just separates the two kvmclocks from the naming, and in
>>> subsequent patches I plan to stop setting kvmclock(old kcmclock) by
>>> default as long as KVM supports kvmclock2 (new kvmclock).
>>
>> No. It will break existing guests that use KVM_FEATURE_CLOCKSOURCE.
> 
> Please refer to my elaboration on v4.5 above, where kvmclock2 is
> available, it should be used in priority.
> 
>>> Also, try to deprecate the old kvmclock in KVM side.
>>>
>>> [1]: https://lore.kernel.org/qemu-devel/20240325141422.1380087-1-pbonzini@redhat.com/
>>> [2]: https://lore.kernel.org/qemu-devel/20230908124534.25027-4-twiederh@redhat.com/
>>> [3]: https://lore.kernel.org/qemu-devel/1300401727-5235-3-git-send-email-glommer@redhat.com/
>>> [4]: https://lore.kernel.org/qemu-devel/1348171412-23669-3-git-send-email-Don@CloudSwitch.com/
> 
> Thanks,
> Zhao
> 
> 


