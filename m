Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9EE3C25B75
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 21:31:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEFFk-00089P-H8; Mon, 03 Jun 2024 17:30:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zide.chen@intel.com>)
 id 1sEFFh-00086c-GY; Mon, 03 Jun 2024 17:30:01 -0400
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zide.chen@intel.com>)
 id 1sEFFd-0003sA-6w; Mon, 03 Jun 2024 17:30:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1717450198; x=1748986198;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=gz2VB/z8nQbvqbqR+d1dnEMt2xQWkKx/LQ/TlrYty08=;
 b=XbYE2TTAznPqAHB8n0eRpB2rIar+UcS/5L7CNpJWNjjgv+fBAHHAwWdJ
 W7KnMCB/9IdXR5CCqZENjeoYeUrydSKHmFNFQUKqU/K92StQQfF/y1L3N
 tqIvI2szgUz9mdDnPByly6O2g78fdr6O5NzYQcpSUL7Jpaz3PnNdpI8gZ
 zpeGLq1ong+oRJg3MYMd6tKYUOA3uk9NOuUlZ07fByxjzhN6mCA0aigE6
 nhSVmX+hlDoIpVT8GraFX1ngFcE/I7sgvZyasL2j+p1Z6I7UTRmaWosdy
 k/uD3yc9iAGSy1vC4TAYLIkdliigJMwIV4muTI0ZrZAmbOPxwotL63Kke A==;
X-CSE-ConnectionGUID: 6uAuosR1TU+zT1zbgomuIg==
X-CSE-MsgGUID: Zszpf+vYQhK268SzNAtf/g==
X-IronPort-AV: E=McAfee;i="6600,9927,11092"; a="31468502"
X-IronPort-AV: E=Sophos;i="6.08,212,1712646000"; d="scan'208";a="31468502"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2024 14:29:56 -0700
X-CSE-ConnectionGUID: 8vY+LpolR46nvCpza61h8Q==
X-CSE-MsgGUID: jntpWwISRaS3+Vs1K1nI0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,212,1712646000"; d="scan'208";a="41433126"
Received: from soc-cp83kr3.jf.intel.com (HELO [10.24.10.62]) ([10.24.10.62])
 by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2024 14:29:55 -0700
Message-ID: <7c1336d2-f68d-45c0-a535-613f271a8535@intel.com>
Date: Mon, 3 Jun 2024 14:29:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 2/3] target/i386: call cpu_exec_realizefn before
 x86_cpu_filter_features
To: Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, mst@redhat.com,
 thuth@redhat.com, cfontana@suse.de, xiaoyao.li@intel.com,
 qemu-trivial@nongnu.org, Sean Christopherson <seanjc@google.com>
References: <20240524200017.150339-1-zide.chen@intel.com>
 <20240524200017.150339-3-zide.chen@intel.com> <ZlluoKXUF6ctecVt@intel.com>
 <04d3dfd8-93d2-493d-82d1-8fbcad6ecd22@intel.com> <Zls9v9mg17SXZhO7@intel.com>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <Zls9v9mg17SXZhO7@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=198.175.65.10; envelope-from=zide.chen@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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



On 6/1/2024 8:26 AM, Zhao Liu wrote:
> On Fri, May 31, 2024 at 10:13:47AM -0700, Chen, Zide wrote:
>> Date: Fri, 31 May 2024 10:13:47 -0700
>> From: "Chen, Zide" <zide.chen@intel.com>
>> Subject: Re: [PATCH V2 2/3] target/i386: call cpu_exec_realizefn before
>>  x86_cpu_filter_features
>>
>> On 5/30/2024 11:30 PM, Zhao Liu wrote:
>>> Hi Zide,
>>>
>>> On Fri, May 24, 2024 at 01:00:16PM -0700, Zide Chen wrote:
>>>> Date: Fri, 24 May 2024 13:00:16 -0700
>>>> From: Zide Chen <zide.chen@intel.com>
>>>> Subject: [PATCH V2 2/3] target/i386: call cpu_exec_realizefn before
>>>>  x86_cpu_filter_features
>>>> X-Mailer: git-send-email 2.34.1
>>>>
>>>> cpu_exec_realizefn which calls the accel-specific realizefn may expand
>>>> features.  e.g., some accel-specific options may require extra features
>>>> to be enabled, and it's appropriate to expand these features in accel-
>>>> specific realizefn.
>>>>
>>>> One such example is the cpu-pm option, which may add CPUID_EXT_MONITOR.
>>>>
>>>> Thus, call cpu_exec_realizefn before x86_cpu_filter_features to ensure
>>>> that it won't expose features not supported by the host.
>>>>
>>>> Fixes: 662175b91ff2 ("i386: reorder call to cpu_exec_realizefn")
>>>> Suggested-by: Xiaoyao Li <xiaoyao.li@intel.com>
>>>> Signed-off-by: Zide Chen <zide.chen@intel.com>
>>>> ---
>>>>  target/i386/cpu.c         | 24 ++++++++++++------------
>>>>  target/i386/kvm/kvm-cpu.c |  1 -
>>>>  2 files changed, 12 insertions(+), 13 deletions(-)
>>>>
>>>> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
>>>> index bc2dceb647fa..a1c1c785bd2f 100644
>>>> --- a/target/i386/cpu.c
>>>> +++ b/target/i386/cpu.c
>>>> @@ -7604,6 +7604,18 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
>>>>          }
>>>>      }
>>>>  
>>>> +    /*
>>>> +     * note: the call to the framework needs to happen after feature expansion,
>>>> +     * but before the checks/modifications to ucode_rev, mwait, phys_bits.
>>>> +     * These may be set by the accel-specific code,
>>>> +     * and the results are subsequently checked / assumed in this function.
>>>> +     */
>>>> +    cpu_exec_realizefn(cs, &local_err);
>>>> +    if (local_err != NULL) {
>>>> +        error_propagate(errp, local_err);
>>>> +        return;
>>>> +    }
>>>> +
>>>>      x86_cpu_filter_features(cpu, cpu->check_cpuid || cpu->enforce_cpuid);
>>>
>>> For your case, which sets cpu-pm=on via overcommit, then
>>> x86_cpu_filter_features() will complain that mwait is not supported.
>>>
>>> Such warning is not necessary, because the purpose of overcommit (from
>>> code) is only to support mwait when possible, not to commit to support
>>> mwait in Guest.
>>>
>>> Additionally, I understand x86_cpu_filter_features() is primarily
>>> intended to filter features configured by the user, 
>>
>> Yes, that's why this patches intends to let x86_cpu_filter_features()
>> filter out the MWAIT bit which is set from the overcommit option.
> 
> HMM, but in fact x86_cpu_filter_features() has already checked the MWAIT
> bit set by "-overcommit cpu-pm=on". ;-)
> 
> (Pls correct me if I'm wrong) Revisiting what cpu-pm did to MWAIT:
> * Firstly, it set MWAIT bit in x86_cpu_expand_features():
>   x86_cpu_expand_features()
>      -> x86_cpu_get_supported_feature_word()
>         -> kvm_arch_get_supported_cpuid()
>  This MWAIT is based on Host's MWAIT capability. This MWAIT enablement
>  is fine for next x86_cpu_filter_features() and x86_cpu_filter_features()
>  is working correctly here!
> 
> * Then, MWAIT was secondly set in host_cpu_enable_cpu_pm() regardless
>   neither Host's support or previous MWAIT enablement result. This is
>   the root cause of your issue.
> 
> Therefore, we should make cpu-pm honor his first MWAIT enablement result
> instead of repeatly and unconditionally setting the MWAIT bit again in
> host_cpu_enable_cpu_pm().

Yes, we don't need to set CPUID_EXT_MONITOR in host_cpu_enable_cpu_pm().

I'll drop this patch though I still think it makes sense to reorder
cpu_exec_realizefn () call.


> 
> Additionally, I think the code in x86_cpu_realizefn():
>   cpu->mwait.ecx |= CPUID_MWAIT_EMX | CPUID_MWAIT_IBE;
> has the similar issue because it also should check MWAIT feature bit.

As explained in another comment, I agree that these two bits need to be
checked against MWAIT availability, or even we don't need
cpu->mwait->ecx at all. But I don't understand why the code explicitly
states that "We always wake on interrupt even if host does not have the
capability", and don't know if it could cause problems if they are removed.

> 
> Further, it may be possible to remove cpu->mwait: just check the MWAIT
> bit in leaf 5 of cpu_x86_cpuid(), and if MWAIT is present, use host's
> mwait info plus CPUID_MWAIT_EMX | CPUID_MWAIT_IBE.
> 
>>> and the changes of
>>> CPUID after x86_cpu_filter_features() should by default be regarded like
>>> "QEMU knows what it is doing".
>>
>> Sure, we can add feature bits after x86_cpu_filter_features(), but I
>> think moving cpu_exec_realizefn() before x86_cpu_filter_features() is
>> more generic, and actually this is what QEMU did before commit 662175b91ff2.
>>
>> - Less redundant code. Specifically, no need to call
>> x86_cpu_get_supported_feature_word() again.
>> - Potentially there could be other features could be added from the
>> accel-specific realizefn, kvm_cpu_realizefn() for example.  And these
>> features need to be checked against the host availability.
> 
> Mainly I don't think this reorder is a direct fix for the problem (I
> just analyse it above), also in your case x86_cpu_filter_features() will
> print a WARNING when QEMU boots, which I don't think is cpu-pm's intention.
> 


