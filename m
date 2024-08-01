Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F54FC3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 15:12:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZXTM-0007Hs-0o; Thu, 01 Aug 2024 11:12:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1sZXTL-0007F1-3q
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 11:12:07 -0400
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1sZXTH-0002Ij-S6
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 11:12:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1722525124; x=1754061124;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=jms0HdxrV1igDnOvzVyDB2B7twRaKKIogkK1DcUxunI=;
 b=AZRecB0Hk23GCBRRlWGcR4fJNmnVHFcgtWDDre8MpqjfUjF51VLliTuO
 sZSvmPCW5f9bJs1ardCVU+kTdBejt+dKfZt8VmKZiGNUNz5gNxe57YQ06
 Z9qBAuQYjVCUqF9N284FQzpfvKTNqpvbyNB/EX0N67rrcHvtLVEEs6i/O
 mYo6vSMrmmZCiBTo0k0JHAoipdmiyNx/ZMvAMvr6bT+9XFqFxoFHozW0u
 kl6AATXOupqg55l1yA1VVwsOfKVxWjsrrlpqWWNNmwx6jZIDCAbDf/tvU
 /+/t5pdzQ7h2HlTsD6P7K0OLJHDCwzToLSBSmoj5QpImRCOwzHiUC6hqv w==;
X-CSE-ConnectionGUID: jIZ7MFYmTli3BZrzaF11Iw==
X-CSE-MsgGUID: ZuS6C615R4iVN7z37KhfTA==
X-IronPort-AV: E=McAfee;i="6700,10204,11151"; a="20304572"
X-IronPort-AV: E=Sophos;i="6.09,254,1716274800"; d="scan'208";a="20304572"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Aug 2024 08:12:00 -0700
X-CSE-ConnectionGUID: 5C0CCv3NTpe8k19GRnSdCg==
X-CSE-MsgGUID: dJ9BWU3BT86WznnO2sNymQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,254,1716274800"; d="scan'208";a="55147617"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.240.26])
 ([10.124.240.26])
 by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Aug 2024 08:11:56 -0700
Message-ID: <e9f61d7d-2f72-4644-ba9f-241672d27cda@intel.com>
Date: Thu, 1 Aug 2024 23:11:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] target/i386: Always set leaf 0x1f
To: Igor Mammedov <imammedo@redhat.com>, Manish <manish.mishra@nutanix.com>
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
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20240801122537.4307ea77@imammedo.users.ipa.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.20; envelope-from=xiaoyao.li@intel.com;
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

On 8/1/2024 6:25 PM, Igor Mammedov wrote:
> On Thu, 1 Aug 2024 15:36:10 +0530
> Manish <manish.mishra@nutanix.com> wrote:
> 
>> On 31/07/24 9:01 pm, Xiaoyao Li wrote:
>>> !-------------------------------------------------------------------|
>>>   CAUTION: External Email
>>>
>>> |-------------------------------------------------------------------!
>>>
>>> On 7/31/2024 4:49 PM, John Levon wrote:
>>>> On Wed, Jul 31, 2024 at 03:02:15PM +0800, Xiaoyao Li wrote:
>>>>   
>>>>>> Windows does not expect 0x1f to be present for any CPU model. But
>>>>>> if it
>>>>>> is exposed to the guest, it expects non-zero values.
>>>>>
>>>>> Please fix Windows!
>>>>
>>>> A ticket has been filed with MSFT, we are aware this is a guest bug.
>>>>
>>>> But that doesn't really help anybody trying to use Windows right now.
>>>
>>> For existing buggy Windows, we can still introduce
>>> "cpuid-0x1f-enforce" but not make it default on.
>>>
>>> People want to boot the buggy Windows needs to opt-in it themselves
>>> via "-cpu xxx,cpuid-0x1f-enforce=on". This way, we don't have live
>>> migration issue and it doesn't affect anything.
>>
>>
>> Yes, that makes sense, I will send a updated patch by tomorrow if no one
>> has any objection with this.
> 
> I'd rename it to
>     x-have-cpuid-0x1f-leaf
> (x-) to reflect that it's not stable/maintained and subject
> to be dropped in future
> 
> Also please clearly spell out that it's a temporary workaround for ...
> in commit message.

I have a patch at hand, to introduce enable_cpuid_0x1f similar as 
enable_cpuid_0xb, for TDX:

https://github.com/intel-staging/qemu-tdx/commit/de08fd30926bc9d7997af6bd12cfff1b998da8b7

It is not a temporary solution. So I would suggest to drop (x-).
If no objection, I think Manish can start from my patch and it only 
misses a property definition for windows case:

   DEFINE_PROP_BOOL("cpuid-0x1f", X86CPU, enable_cpuid_0x1f, false);



> 
>>
>>>   
>>>> regards
>>>> john
>>
>>
>> Thanks
>>
>> Manish Mishra
>>
> 


