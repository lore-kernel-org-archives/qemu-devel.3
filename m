Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 970A8C3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2024 14:00:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sc3ft-0002JQ-Bw; Thu, 08 Aug 2024 09:59:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1sc3fl-0002HV-3h
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 09:59:22 -0400
Received: from mgamail.intel.com ([198.175.65.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1sc3fi-0001cS-NE
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 09:59:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1723125559; x=1754661559;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=uTncNvr+TetwbvaCUuoUwOSPkUp8fifs8Wqn7mSL614=;
 b=TvOz+wyao7YOBSIdXdS0FB3RO7E/D6ga1zn93S65nSL2ukVFPgN5gsKH
 3G7avnbekwwL/ajwBYXURXJhPaT5Y3V0870ZBw2PZD5QRQf6dDxf78aOm
 c6ZWRyjyXVK0mhb8pDSjSlMyV3bGx7M6pc1ggoA0fYdSOb+3KHJOEN5nH
 GCLaUqQ+3yepZYrjdpAXSZZQ1snjflr8fT6RefIFFlFIRgfkUhL2slAJk
 ndd2sYz4gqkB6k3huHQoaJQaXBF+me9iZPB7NO5UGz4t1aQwp2ENnWUP8
 I6Qm25Qv4Me+EQJMCZiuHzSbim0AnWl+tjEBuqKW0qssP1qzm4ZpNr4U7 g==;
X-CSE-ConnectionGUID: lqCQItbwRA2x/WAr4qqhJQ==
X-CSE-MsgGUID: JtLLEwN1SxidpQuFR4iClg==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="21109763"
X-IronPort-AV: E=Sophos;i="6.09,273,1716274800"; d="scan'208";a="21109763"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Aug 2024 06:59:14 -0700
X-CSE-ConnectionGUID: HqyDKyk+Sw2pZE7kpEMiUw==
X-CSE-MsgGUID: wfCrepEIRZOUzrERzQvEew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,273,1716274800"; d="scan'208";a="62073870"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.228.22])
 ([10.124.228.22])
 by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Aug 2024 06:59:11 -0700
Message-ID: <26064315-6730-48fa-9f04-cb86a2dcfdf0@intel.com>
Date: Thu, 8 Aug 2024 21:59:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] i386/cpu: Introduce enable_cpuid_0x1f to force exposing
 CPUID 0x1f
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, 
 Manish <manish.mishra@nutanix.com>, John Levon <john.levon@nutanix.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org
References: <20240802072426.4016194-1-xiaoyao.li@intel.com>
 <ZrSZQN/AQa6BiIUu@intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <ZrSZQN/AQa6BiIUu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=198.175.65.19; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001, RCVD_IN_DNSWL_MED=-2.3,
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

On 8/8/2024 6:09 PM, Zhao Liu wrote:
> Hi Xiaoyao,
> 
> Patch is generally fine for me. Just a few nits:
> 
> On Fri, Aug 02, 2024 at 03:24:26AM -0400, Xiaoyao Li wrote:
>> diff --git a/include/hw/i386/topology.h b/include/hw/i386/topology.h
>> index dff49fce1154..b63bce2f4c82 100644
>> --- a/include/hw/i386/topology.h
>> +++ b/include/hw/i386/topology.h
>> @@ -207,13 +207,4 @@ static inline apic_id_t x86_apicid_from_cpu_idx(X86CPUTopoInfo *topo_info,
>>       return x86_apicid_from_topo_ids(topo_info, &topo_ids);
>>   }
>>   
>> -/*
>> - * Check whether there's extended topology level (module or die)?
>> - */
>> -static inline bool x86_has_extended_topo(unsigned long *topo_bitmap)
>> -{
>> -    return test_bit(CPU_TOPO_LEVEL_MODULE, topo_bitmap) ||
>> -           test_bit(CPU_TOPO_LEVEL_DIE, topo_bitmap);
>> -}
>> -
> 
> [snip]
> 
>> +/*
>> + * Check whether there's v2 extended topology level (module or die)?
>> + */
>> +bool x86_has_v2_extended_topo(X86CPU *cpu)
>> +{
>> +    if (cpu->enable_cpuid_0x1f) {
>> +        return true;
>> +    }
>> +
>> +    return test_bit(CPU_TOPO_LEVEL_MODULE, cpu->env.avail_cpu_topo) ||
>> +           test_bit(CPU_TOPO_LEVEL_DIE, cpu->env.avail_cpu_topo);
>> +}
>> +
> 
> I suggest to decouple 0x1f enablement and extended topo check, since as
> the comment of CPUTopoLevel said:
> 
> /*
>   * CPUTopoLevel is the general i386 topology hierarchical representation,
>   * ordered by increasing hierarchical relationship.
>   * Its enumeration value is not bound to the type value of Intel (CPUID[0x1F])
>   * or AMD (CPUID[0x80000026]).
>   */
> 
> The topology enumeration is generic and is not bound to the vendor.

I don't quit get your point. All the current usages of 
x86_has_extended_topo() are for CPUID leaf 0x1f, which is an Intel 
specific leaf.

Are you saying x86_has_extended_topo() will be used for leaf 0x80000026 
for AMD as well?

or maybe I misunderstand the meaning "extend_topo". The extend_topo just 
means the topo level of module and die, and the topo level of smt and 
core are non-extended? If so, this is new to me, could I ask where the 
definitions come from? or just QEMU defines them itself?

> [snip]
> 
>> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
>> index c6cc035df3d8..211a42ffbfa6 100644
>> --- a/target/i386/cpu.h
>> +++ b/target/i386/cpu.h
>> @@ -2110,6 +2110,9 @@ struct ArchCPU {
>>       /* Compatibility bits for old machine types: */
>>       bool enable_cpuid_0xb;
>>   
>> +    /* Force to expose cpuid 0x1f */
> 
> Maybe "Force to enable cpuid 0x1f"?

I can change to it.

>> +    bool enable_cpuid_0x1f;
>> +
>>       /* Enable auto level-increase for all CPUID leaves */
>>       bool full_cpuid_auto_level;i
> 
> Regards,
> Zhao
> 


