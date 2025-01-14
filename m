Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D037C02183
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2025 12:40:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXgD7-0004z6-50; Tue, 14 Jan 2025 07:39:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tXgD2-0004pc-Do
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 07:39:52 -0500
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tXgCz-0005qV-4I
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 07:39:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1736858390; x=1768394390;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=Ymy6fi60DeIIv6w0XhdotWZiGY1VFM3N3b5/Gxgr4ts=;
 b=boz9uSdugCGaiKT5eppgE+AXn1VIZBpAzCLbJTabkpfGZj9ySiYYEaks
 3JZM1s1KmK279nS9Zal4d0s4rRdKX3xMyyLDzscf1EyIzkBvYxow/1yY7
 6z08I0nkFE6C7yD8zJ2t1I3y+U7lm5YAv2HQ9o5trjRclw0m0M1DOYlSM
 tBgIOpGkgEOEm42MPhhqWWE1oR/uEmkkIh5gnbpu7sfOap6cP9m6JVIx6
 +BYEM7SupsRW4y4ypp3QV9BpvmG6nWl/OvwIgZuAJHPcOWPiAQQTntN7T
 JQP2jANIa3aGQlDNyHTn8aaV6mCTA0Nvo5Z8pxdx+RAxV27mWHoWIwI2V A==;
X-CSE-ConnectionGUID: Wh5788j/RJyHutlwajjTWA==
X-CSE-MsgGUID: Dm8FLeH1QsOKZCLNS+NmzQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="47640487"
X-IronPort-AV: E=Sophos;i="6.12,314,1728975600"; d="scan'208";a="47640487"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jan 2025 04:39:46 -0800
X-CSE-ConnectionGUID: 8RJqrxEAS0ClqBKgQtivpA==
X-CSE-MsgGUID: HVskA2wXR2WOzdEVmKNImg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,314,1728975600"; d="scan'208";a="104876000"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jan 2025 04:39:40 -0800
Message-ID: <1b03e7a4-c398-4646-9182-e3757f65980e@intel.com>
Date: Tue, 14 Jan 2025 20:39:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 09/60] i386/tdx: Initialize TDX before creating TD vcpus
To: Tony Lindgren <tony.lindgren@linux.intel.com>,
 Ira Weiny <ira.weiny@intel.com>
Cc: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
 "riku.voipio@iki.fi" <riku.voipio@iki.fi>,
 "imammedo@redhat.com" <imammedo@redhat.com>, "Liu, Zhao1"
 <zhao1.liu@intel.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "anisinha@redhat.com" <anisinha@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "philmd@linaro.org" <philmd@linaro.org>,
 "cohuck@redhat.com" <cohuck@redhat.com>,
 "mtosatti@redhat.com" <mtosatti@redhat.com>,
 "eblake@redhat.com" <eblake@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "wangyanan55@huawei.com" <wangyanan55@huawei.com>,
 "berrange@redhat.com" <berrange@redhat.com>
References: <20241105062408.3533704-1-xiaoyao.li@intel.com>
 <20241105062408.3533704-10-xiaoyao.li@intel.com>
 <1235bac6ffe7be6662839adb2630c1a97d1cc4c5.camel@intel.com>
 <c0ef6c19-756e-43f3-8342-66b032238265@intel.com>
 <Zyr7FA10pmLhZBxL@tlindgre-MOBL1> <Z1scMzIdT2cI4F5T@iweiny-mobl>
 <Z2F3mBlIqbf9h4QM@tlindgre-MOBL1>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <Z2F3mBlIqbf9h4QM@tlindgre-MOBL1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.11; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -52
X-Spam_score: -5.3
X-Spam_bar: -----
X-Spam_report: (-5.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.063,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.998, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=-1.794, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 12/17/2024 9:10 PM, Tony Lindgren wrote:
> On Thu, Dec 12, 2024 at 11:24:03AM -0600, Ira Weiny wrote:
>> On Wed, Nov 06, 2024 at 07:13:56AM +0200, Tony Lindgren wrote:
>>> On Wed, Nov 06, 2024 at 10:01:04AM +0800, Xiaoyao Li wrote:
>>>> On 11/6/2024 4:51 AM, Edgecombe, Rick P wrote:
>>>>> +Tony
>>>>>
>>>>> On Tue, 2024-11-05 at 01:23 -0500, Xiaoyao Li wrote:
>>>>>> +int tdx_pre_create_vcpu(CPUState *cpu, Error **errp)
>>>>>> +{
>>>>>> +    X86CPU *x86cpu = X86_CPU(cpu);
>>>>>> +    CPUX86State *env = &x86cpu->env;
>>>>>> +    g_autofree struct kvm_tdx_init_vm *init_vm = NULL;
>>>>>> +    int r = 0;
>>>>>> +
>>>>>> +    QEMU_LOCK_GUARD(&tdx_guest->lock);
>>>>>> +    if (tdx_guest->initialized) {
>>>>>> +        return r;
>>>>>> +    }
>>>>>> +
>>>>>> +    init_vm = g_malloc0(sizeof(struct kvm_tdx_init_vm) +
>>>>>> +                        sizeof(struct kvm_cpuid_entry2) * KVM_MAX_CPUID_ENTRIES);
>>>>>> +
>>>>>> +    r = setup_td_xfam(x86cpu, errp);
>>>>>> +    if (r) {
>>>>>> +        return r;
>>>>>> +    }
>>>>>> +
>>>>>> +    init_vm->cpuid.nent = kvm_x86_build_cpuid(env, init_vm->cpuid.entries, 0);
>>>>>> +    tdx_filter_cpuid(&init_vm->cpuid);
>>>>>> +
>>>>>> +    init_vm->attributes = tdx_guest->attributes;
>>>>>> +    init_vm->xfam = tdx_guest->xfam;
>>>>>> +
>>>>>> +    do {
>>>>>> +        r = tdx_vm_ioctl(KVM_TDX_INIT_VM, 0, init_vm);
>>>>>> +    } while (r == -EAGAIN);
>>>>>
>>>>> KVM_TDX_INIT_VM can also return EBUSY. This should check for it, or KVM should
>>>>> standardize on one for both conditions. In KVM, both cases handle
>>>>> TDX_RND_NO_ENTROPY, but one tries to save some of the initialization for the
>>>>> next attempt. I don't know why userspace would need to differentiate between the
>>>>> two cases though, which makes me think we should just change the KVM side.
>>>>
>>>> I remember I tested retrying on the two cases and no surprise showed.
>>>>
>>>> I agree to change KVM side to return -EAGAIN for the two cases.
>>>
>>> OK yeah let's patch KVM for it.
>>
>> Will the patch to KVM converge such that it is ok for qemu to loop forever?
> 
> Hmm I don't think we should loop forever anywhere, the retries needed should
> be only a few. Or what do you have in mind?

"A few" seems not accurate. It depends on how heavy the RDRAND/RDSEED 
traffic from others are. IIRC, it gets > 10 0000 -EAGAIN before success 
when all the LPs in the system are doing RDRAND/RDSEED.

Maybe a timeout? E.g., QEMU exits when it cannot move forward for a 
certain period.

However, I'm not sure what value is reasonable for the timeout.


> Regards,
> 
> Tony


