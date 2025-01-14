Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9D03E77188
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2025 08:53:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXcfI-0004dd-8R; Tue, 14 Jan 2025 03:52:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tXcfF-0004ca-P3
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 03:52:46 -0500
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tXcfD-00062W-Cl
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 03:52:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1736844763; x=1768380763;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=f6usZVOc0+lmEHr0DktfiQxYv7Ud7H5qiOl4Zp/jjIM=;
 b=X9K+ICFvPtfgJGgtEzFtX7VIW+8EYbhddm8LJJCZRgZY+zA1UIDlRFjW
 IDcoA0/mFaqL+ZbW3FrsyTRf3kbGI3SnAUmxF8O15R4ICNBt0tUoUzevh
 L3emf2WeehbfF1PoTTqE4HkBBZxsb8L+MZTUB2Y/pvMTCSALeqqFB9vKR
 19BjlEx6xuxlbXtfe6iHuVyccfZ7FT4u371A/ltak8FnhPvzg8jUDH7IO
 gYigESaQBvdpPkY+YB+OccmziZASCrLuAyhX6nULUHjlAVqXYsH6FXpVu
 Ud4veFOKXKAr6Glabxr6rziERHeA0eKZSQUXNCrG+uzGU3cbbhL/iFsYs Q==;
X-CSE-ConnectionGUID: TZIoBba6SDOZSduEjEWDAQ==
X-CSE-MsgGUID: KXKEwfAeTayaIgHNw3KKvw==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="37046167"
X-IronPort-AV: E=Sophos;i="6.12,313,1728975600"; d="scan'208";a="37046167"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jan 2025 00:52:15 -0800
X-CSE-ConnectionGUID: eYxL9b7MTreBT5+XO3zGYg==
X-CSE-MsgGUID: nPLuQrqZR0aYhssEHp7RQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,313,1728975600"; d="scan'208";a="104687300"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jan 2025 00:52:09 -0800
Message-ID: <8d56ba39-ce9e-4afb-abd1-25cb393214a5@intel.com>
Date: Tue, 14 Jan 2025 16:52:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 34/60] i386/tdx: implement tdx_cpu_realizefn()
To: Ira Weiny <ira.weiny@intel.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Riku Voipio <riku.voipio@iki.fi>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, rick.p.edgecombe@intel.com,
 kvm@vger.kernel.org, qemu-devel@nongnu.org
References: <20241105062408.3533704-1-xiaoyao.li@intel.com>
 <20241105062408.3533704-35-xiaoyao.li@intel.com>
 <82b74218-f790-4300-ab3b-9c41de1f96b8@redhat.com>
 <2bedfcda-c2e7-4e5b-87a7-9352dfe28286@intel.com>
 <44627917-a848-4a86-bddb-20151ecfd39a@redhat.com>
 <Z1td_BZPlZ5G9Zaq@iweiny-mobl>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <Z1td_BZPlZ5G9Zaq@iweiny-mobl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.17; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.019,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.998, RCVD_IN_DNSWL_MED=-2.3,
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

On 12/13/2024 6:04 AM, Ira Weiny wrote:
> On Tue, Nov 05, 2024 at 12:53:25PM +0100, Paolo Bonzini wrote:
>> On 11/5/24 12:38, Xiaoyao Li wrote:
>>> On 11/5/2024 6:06 PM, Paolo Bonzini wrote:
>>>> On 11/5/24 07:23, Xiaoyao Li wrote:
>>>>> +static void tdx_cpu_realizefn(X86ConfidentialGuest *cg, CPUState *cs,
>>>>> +                              Error **errp)
>>>>> +{
>>>>> +    X86CPU *cpu = X86_CPU(cs);
>>>>> +    uint32_t host_phys_bits = host_cpu_phys_bits();
>>>>> +
>>>>> +    if (!cpu->phys_bits) {
>>>>> +        cpu->phys_bits = host_phys_bits;
>>>>> +    } else if (cpu->phys_bits != host_phys_bits) {
>>>>> +        error_setg(errp, "TDX only supports host physical bits (%u)",
>>>>> +                   host_phys_bits);
>>>>> +    }
>>>>> +}
>>>>
>>>> This should be already handled by host_cpu_realizefn(), which is
>>>> reached via cpu_exec_realizefn().
>>>>
>>>> Why is it needed earlier, but not as early as instance_init?  If
>>>> absolutely needed I would do the assignment in patch 33, but I don't
>>>> understand why it's necessary.
>>>
>>> It's not called earlier but right after cpu_exec_realizefn().
>>>
>>> Patch 33 adds x86_confidenetial_guest_cpu_realizefn() right after
>>> ecpu_exec_realizefn(). This patch implements the callback and gets
>>> called in x86_confidenetial_guest_cpu_realizefn() so it's called after
>>> cpu_exec_realizefn().
>>>
>>> The reason why host_cpu_realizefn() cannot satisfy is that for normal
>>> VMs, the check in cpu_exec_realizefn() is just a warning and QEMU does
>>> allow the user to configure the physical address bit other than host's
>>> value, and the configured value will be seen inside guest. i.e., "-cpu
>>> phys-bits=xx" where xx != host_value works for normal VMs.
>>>
>>> But for TDX, KVM doesn't allow it and the value seen in TD guest is
>>> always the host value.  i.e., "-cpu phys-bits=xx" where xx != host_value
>>> doesn't work for TDX.
>>>
>>>> Either way, the check should be in tdx_check_features.
>>>
>>> Good idea. I will try to implement it in tdx_check_features()
> 
> Is there any reason the TDX code can't just force cpu->host_phys_bits to true?

That doesn't work for all the cases. e.g., when user set 
"host-phys-bits-limit" to a smaller value. For this case, QEMU still 
needs to validate the final cpu->phys_bits.

Of course, we can force host_phys_bits to true for TDX, and warn and 
exit when user set "host-phys-bits-limit" to a smaller value than host 
value.

But I prefer the current direction to check cpu->phys_bits directly, 
which is straightforward.

>>
>> Thanks, and I think there's no need to change cpu->phys_bits, either. So
>> x86_confidenetial_guest_cpu_realizefn() should not be necessary.
> 
> I was going to comment that patch 33 should be squashed here but better to just
> drop it.
> 
> Ira
> 
>>
>> Paolo
>>


