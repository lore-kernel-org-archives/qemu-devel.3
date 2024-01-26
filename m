Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5A00C47422
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 08:17:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTHOi-0004yW-41; Fri, 26 Jan 2024 03:17:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rTHOf-0004rs-NX
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 03:17:10 -0500
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rTHOd-0002Ig-0D
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 03:17:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1706257027; x=1737793027;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=8V3NMygngn2hS6xZCvOV5AkRiszSP+ebpxnEuRx4sK8=;
 b=Brktsd4U7WS4UjwS7YyyBZ2xbRUT4SsdjzqD3quBT9tLO0vEUDlDBT7c
 5gGEd706aOEpKOG2q5A+jrx7MkXHQnhTwkcO+3Jr5Pd4Kzz8WWrTTZyLX
 7+htpIvbmxEY89dHkplmHv1/KHAFcv2Kkmq9/+iH8l4t39LyD2HpZ+ii3
 d6YiE91cjd3ZV9l7cYdJ5Gm+UQeQcT7VPNC3YK9J+qV7rJ0XyIMIE2SBm
 WrIS3WyGeeMNzHEgmQZJsTuDQt6oXCcJUpNRktE51OTwRRgC1e/armzNq
 Rbam0VU/F7rFc50JgcbBxjga4lYWJlopHBepiy7RYgJrNnV66BHmIg9FZ Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="9098190"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="9098190"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jan 2024 00:17:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="960143920"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; d="scan'208";a="960143920"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.93.33.17])
 ([10.93.33.17])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jan 2024 00:17:01 -0800
Message-ID: <846644e9-27c5-4d7a-b2ec-7d94ba2dcc19@intel.com>
Date: Fri, 26 Jan 2024 16:16:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Why invtsc (CPUID_APM_INVTSC) is unmigratable?
Content-Language: en-US
To: Marcelo Tosatti <mtosatti@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Lei Wang <lei4.wang@intel.com>
References: <825f29d7-9112-45a2-b4a3-7d3b54c3c0a2@intel.com>
 <Zaqf839r8TXvkIAf@tpad> <b6950a34-0ef6-4945-9e50-5a47e86490e1@intel.com>
 <Za/doRj6sEibC64y@tpad> <e34d49cc-b743-4df1-9a31-96c987dc2ad3@intel.com>
 <ZbGJnbo1CJyAk61y@tpad>
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <ZbGJnbo1CJyAk61y@tpad>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.198.163.11; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.5,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.999, HK_RANDOM_FROM=1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 1/25/2024 6:05 AM, Marcelo Tosatti wrote:
> On Wed, Jan 24, 2024 at 10:52:46PM +0800, Xiaoyao Li wrote:
>> On 1/23/2024 11:39 PM, Marcelo Tosatti wrote:
>>> On Sat, Jan 20, 2024 at 05:44:07PM +0800, Xiaoyao Li wrote:
>>>> On 1/20/2024 12:14 AM, Marcelo Tosatti wrote:
>>>>> On Fri, Jan 19, 2024 at 02:46:22PM +0800, Xiaoyao Li wrote:
>>>>>> I'm wondering why CPUID_APM_INVTSC is set as unmigratable_flags. Could
>>>>>> anyone explain it?
>>>>>
>>>>>
>>>>> commit 68bfd0ad4a1dcc4c328d5db85dc746b49c1ec07e
>>>>> Author: Marcelo Tosatti <mtosatti@redhat.com>
>>>>> Date:   Wed May 14 16:30:09 2014 -0300
>>>>>
>>>>>        target-i386: block migration and savevm if invariant tsc is exposed
>>>>>        Invariant TSC documentation mentions that "invariant TSC will run at a
>>>>>        constant rate in all ACPI P-, C-. and T-states".
>>>>>        This is not the case if migration to a host with different TSC frequency
>>>>>        is allowed, or if savevm is performed. So block migration/savevm.
>>>>>
>>>>> So the rationale here was that without ensuring the destination host
>>>>> has the same TSC clock frequency, we can't migrate.
>>>>
>>>> It seems to me the concept of invtsc was extended to "tsc freq will not
>>>> change even after the machine is live migrated". I'm not sure it is correct
>>>> to extend the concept of invtsc.
>>>>
>>>> The main reason of introducing invtsc is to tell the tsc hardware keeps
>>>> counting (at the same rate) even at deep C state, so long as other states.
>>>>
>>>> For example, a guest is created on machine A with X GHz tsc, and invtsc
>>>> exposed (machine A can ensure the guest's tsc counts at X GHz at any state).
>>>> If the guest is migrated to machine B with Y GHz tsc, and machine B can also
>>>> ensure the invtsc of its guest, i.e., the guest's tsc counts at Y GHz at any
>>>> state. IMHO, in this case, the invtsc is supported at both src and dest,
>>>> which means it is a migratable feature. However, the migration itself fails,
>>>> due to mismatched/different configuration of tsc freq, not due to invtsc.
>>>>
>>>>> However, this was later extended to allow invtsc migratioon when setting
>>>>> tsc-khz explicitly:
>>>>>
>>>>> commit d99569d9d8562c480e0befab601756b0b7b5d0e0
>>>>> Author: Eduardo Habkost <ehabkost@redhat.com>
>>>>> Date:   Sun Jan 8 15:32:34 2017 -0200
>>>>>
>>>>>        kvm: Allow invtsc migration if tsc-khz is set explicitly
>>>>>        We can safely allow a VM to be migrated with invtsc enabled if
>>>>>        tsc-khz is set explicitly, because:
>>>>>        * QEMU already refuses to start if it can't set the TSC frequency
>>>>>          to the configured value.
>>>>>        * Management software is already required to keep device
>>>>>          configuration (including CPU configuration) the same on
>>>>>          migration source and destination.
>>>>>        Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
>>>>>        Message-Id: <20170108173234.25721-3-ehabkost@redhat.com>
>>>>>        Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
>>>>
>>>> But in the case that user doesn't set tsc freq explicitly, the live
>>>> migration is likely to fail or have issues even without invtsc exposed to
>>>> guest,
>>>
>>> Depends on how the guest is using the TSC, but yes.
>>>
>>>> if the destination host has a different tsc frequency than src host.
>>>>
>>>> So why bother checking invtsc only?
>>>
>>> Well, if invtsc is exposed to the guest, then it might use the TSC for
>>> timekeeping purposes.
>>>
>>> Therefore you don't want to fail (on the invtsc clock characteristics)
>>> otherwise timekeeping in the guest might be problematic.
>>>
>>> But this are all just heuristics.
>>>
>>> Do you have a suggestion for different behaviour?
>>
>> I think we need to block live migration when user doesn't specify a certain
>> tsc frequency explicitly, regardless of invtsc.
> 
> Problem is if that guest is using kvmclock for timekeeping, then live migration
> is safe (kvmclock logic will update the tsc frequency of the destination
> host upon migration).
> 

It surprises me kvmclock can do it. Cloud you please elaborate it a bit 
how kvmclock achieve it during migration or point me to some codes in 
Linux?

