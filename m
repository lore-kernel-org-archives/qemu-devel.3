Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25A57C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 07:36:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZmpH-0000RM-1M; Fri, 02 Aug 2024 03:35:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1sZmpE-0000I8-Sa
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 03:35:45 -0400
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1sZmpC-0006vW-Rk
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 03:35:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1722584143; x=1754120143;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=K7Le+SN/xC2gk5hunIyvYAHQePh0F2RhxsYuIxUG3ws=;
 b=krnGqc4hgc7cbZgjDILoVe3D2yz+ZavdZrjHc0sKTgrN4HgSxiP+u8YP
 H5pcDTdmNfQ9hQLrinFqJ6fplddvAEvLnhfjllt2lP+BWfnDzcNclxKS4
 0EN51wqYNtOHp4OAygwq5p+Ce90rBEjlPqF4vDlptdQqp839DeNHz9FL7
 tzoaj1BW2cJY+eMJrX9C9h/pK5VZPiuV1W2Q7ILCOS8Qhqf8UFXcT7zx7
 nv1vLh4kvthmNKw/7PA3hsEgvUXeD++R4/iejewhnL8mghLhvSfP0WKTI
 qBSajCK+JnLYoAAxmT0utlV1ssgQyQEEjTStgZPD9bik7d5vXSXkphkgp w==;
X-CSE-ConnectionGUID: fRFZjv4ATqWQ1rJtWE/7qA==
X-CSE-MsgGUID: KeACpK65T6mDKycM0AHYhw==
X-IronPort-AV: E=McAfee;i="6700,10204,11151"; a="43103849"
X-IronPort-AV: E=Sophos;i="6.09,257,1716274800"; d="scan'208";a="43103849"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Aug 2024 00:35:41 -0700
X-CSE-ConnectionGUID: kf1VhOQCS+O94Dh7Hv1Cfw==
X-CSE-MsgGUID: L9CYua6ZQra0uySHItN0yg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,257,1716274800"; d="scan'208";a="59426748"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.240.26])
 ([10.124.240.26])
 by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Aug 2024 00:35:38 -0700
Message-ID: <d987ea0e-da52-403f-b183-95f0ff453504@intel.com>
Date: Fri, 2 Aug 2024 15:35:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] target/i386: Always set leaf 0x1f
To: Manish <manish.mishra@nutanix.com>, Igor Mammedov <imammedo@redhat.com>
Cc: John Levon <john.levon@nutanix.com>, qemu-devel@nongnu.org,
 berrange@redhat.com, zhao1.liu@intel.com, pbonzini@redhat.com,
 bob.ball@nutanix.com, prerna.saxena@nutanix.com
References: <20240724075226.212882-1-manish.mishra@nutanix.com>
 <20240724110004.389c1a0c@imammedo.users.ipa.redhat.com>
 <21ca5c19-677b-4fac-84d4-72413577f260@nutanix.com>
 <6e65dbb2-461e-44f4-842c-249c7b333885@intel.com> <Zqn6mNuCH4/HJoO/@lent>
 <bda03736-ade0-46a9-977f-1ae368374555@intel.com>
 <d7de1729-e497-4913-be8e-8938e83b3a2a@nutanix.com>
 <20240801122537.4307ea77@imammedo.users.ipa.redhat.com>
 <e9f61d7d-2f72-4644-ba9f-241672d27cda@intel.com>
 <4bcae915-5812-4465-8ce0-dca787cc4860@nutanix.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <4bcae915-5812-4465-8ce0-dca787cc4860@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.9; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.131,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001, RCVD_IN_DNSWL_MED=-2.3,
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

On 8/2/2024 12:46 AM, Manish wrote:
> 
> On 01/08/24 8:41 pm, Xiaoyao Li wrote:
>> !-------------------------------------------------------------------|
>>  CAUTION: External Email
>>
>> |-------------------------------------------------------------------!
>>
>> On 8/1/2024 6:25 PM, Igor Mammedov wrote:
>>> On Thu, 1 Aug 2024 15:36:10 +0530
>>> Manish <manish.mishra@nutanix.com> wrote:
>>>
>>>> On 31/07/24 9:01 pm, Xiaoyao Li wrote:
>>>>> !-------------------------------------------------------------------|
>>>>>   CAUTION: External Email
>>>>>
>>>>> |-------------------------------------------------------------------!
>>>>>
>>>>> On 7/31/2024 4:49 PM, John Levon wrote:
>>>>>> On Wed, Jul 31, 2024 at 03:02:15PM +0800, Xiaoyao Li wrote:
>>>>>>>> Windows does not expect 0x1f to be present for any CPU model. But
>>>>>>>> if it
>>>>>>>> is exposed to the guest, it expects non-zero values.
>>>>>>>
>>>>>>> Please fix Windows!
>>>>>>
>>>>>> A ticket has been filed with MSFT, we are aware this is a guest bug.
>>>>>>
>>>>>> But that doesn't really help anybody trying to use Windows right now.
>>>>>
>>>>> For existing buggy Windows, we can still introduce
>>>>> "cpuid-0x1f-enforce" but not make it default on.
>>>>>
>>>>> People want to boot the buggy Windows needs to opt-in it themselves
>>>>> via "-cpu xxx,cpuid-0x1f-enforce=on". This way, we don't have live
>>>>> migration issue and it doesn't affect anything.
>>>>
>>>>
>>>> Yes, that makes sense, I will send a updated patch by tomorrow if no 
>>>> one
>>>> has any objection with this.
>>>
>>> I'd rename it to
>>>     x-have-cpuid-0x1f-leaf
>>> (x-) to reflect that it's not stable/maintained and subject
>>> to be dropped in future
>>>
>>> Also please clearly spell out that it's a temporary workaround for ...
>>> in commit message.
>>
>> I have a patch at hand, to introduce enable_cpuid_0x1f similar as 
>> enable_cpuid_0xb, for TDX:
>>
>> https://urldefense.proofpoint.com/v2/url?u=https-3A__github.com_intel-2Dstaging_qemu-2Dtdx_commit_de08fd30926bc9d7997af6bd12cfff1b998da8b7&d=DwIDaQ&c=s883GpUCOChKOHiocYtGcg&r=c4KON2DiMd-szjwjggQcuUvTsPWblztAL0gVzaHnNmc&m=CIrxjRd0KG4ww4BtSxZysWS0tFYfPGTRBG731EmlUcy7BFlAw3-5PLp2SlKPR83m&s=2gKDZXpqB7wE8v0vtN8l65WBqTtXOUJ-FkMblXcT_Ws&e=
>> It is not a temporary solution. So I would suggest to drop (x-).
>> If no objection, I think Manish can start from my patch and it only 
>> misses a property definition for windows case:
>>
>>   DEFINE_PROP_BOOL("cpuid-0x1f", X86CPU, enable_cpuid_0x1f, false);
>>
>>
> Thanks Xiaoyao, I see your patch does what we require but i am not able 
> to track these patches, are these in line to be merged soon? We need 
> this urgently. Also as it is just a single line change on top of your 
> changes, how i manage my change? Should i wait for you to merge and then 
> send patch or you will be fine to directly include it in your series?

Sent it:

https://lore.kernel.org/qemu-devel/20240802072426.4016194-1-xiaoyao.li@intel.com/

We can continue the discussion from there.

> 
>>
>>>
>>>>
>>>>>> regards
>>>>>> john
>>>>
>>>>
>>>> Thanks
>>>>
>>>> Manish Mishra
>>>>
>>>
>>
> 
> Thanks
> 
> Manish Mishra
> 


