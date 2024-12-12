Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49C98E7717D
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 03:23:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLZmq-0005Il-0P; Wed, 11 Dec 2024 22:22:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tLZmm-0005IY-UN
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 22:22:44 -0500
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tLZmk-0001k0-Nn
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 22:22:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1733973763; x=1765509763;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=TLc20mLzHfeeGrYmmia2bm0rHI5V4UBcIouvk7viHHg=;
 b=ECALrVMbD5yIxNvTyr3NNICy4BTa8F2d3i37O4B3yWuAApXaFTlR48ge
 EcCrnDcpS3KOQiabGnO2zGXJ9RGmpuhh7B9ervIz2CvR0W9WpTm/06n2D
 dzz5sd5Nfsbpwx26pAp2nkb1+DZUjd2WAfHMUN4QiZlPIYyuav7ujoSTx
 tiUb+UTTijO8q3rfG9XAP1jN4qkWGzLd8VR8akB65kHOKwn26N/4/nQDk
 t26NxRQOScTYvclDZ0jrYHIkOR6aSlofQSoUWCeSLjD+dx0a9knHIueek
 jxj+QDG5x7xTuPDuaVFELsUXout7jnNAEkVTCwev3OsGqOCIV8zvIma0/ Q==;
X-CSE-ConnectionGUID: Lbw+JovkRf6hDQTLKac1Mw==
X-CSE-MsgGUID: PnND6X6fSPS9KBEbOXqUPg==
X-IronPort-AV: E=McAfee;i="6700,10204,11283"; a="34281517"
X-IronPort-AV: E=Sophos;i="6.12,227,1728975600"; d="scan'208";a="34281517"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Dec 2024 19:22:36 -0800
X-CSE-ConnectionGUID: n7SnEHGYTYiM+/WlFgKSNg==
X-CSE-MsgGUID: IgSKQBh3QAyqxrxsFyjKjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="127046600"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Dec 2024 19:22:31 -0800
Message-ID: <709634f3-226e-44c8-be7c-60d3f8f53f43@intel.com>
Date: Thu, 12 Dec 2024 11:22:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/4] i386: Extract a common fucntion to setup value of
 MSR_CORE_THREAD_COUNT
To: Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org
References: <20241205145716.472456-1-xiaoyao.li@intel.com>
 <20241205145716.472456-3-xiaoyao.li@intel.com>
 <f9793791-2aaa-42b8-9830-86401a020205@linaro.org>
 <20241210173524.48e203a3@imammedo.users.ipa.redhat.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20241210173524.48e203a3@imammedo.users.ipa.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.17; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.472,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=1, RCVD_IN_DNSWL_MED=-2.3,
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

On 12/11/2024 12:35 AM, Igor Mammedov wrote:
> On Thu, 5 Dec 2024 22:38:41 +0100
> Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
> 
>> Hi Xiaoyao,
>>
>> On 5/12/24 15:57, Xiaoyao Li wrote:
>>> There are duplicated code to setup the value of MSR_CORE_THREAD_COUNT.
>>> Extract a common function for it.
>>>
>>> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
>>> ---
>>>    target/i386/cpu.h                    | 11 +++++++++++
>>>    target/i386/hvf/x86_emu.c            |  3 +--
>>>    target/i386/kvm/kvm.c                |  5 +----
>>>    target/i386/tcg/sysemu/misc_helper.c |  3 +--
>>>    4 files changed, 14 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
>>> index 4c239a6970fd..5795a497e567 100644
>>> --- a/target/i386/cpu.h
>>> +++ b/target/i386/cpu.h
>>> @@ -2390,6 +2390,17 @@ static inline void cpu_x86_load_seg_cache_sipi(X86CPU *cpu,
>>>        cs->halted = 0;
>>>    }
>>>    
>>> +static inline uint64_t cpu_x86_get_msr_core_thread_count(X86CPU *cpu)
>>
>> Please do not add more inlined functions in this huge file, the
>> inlining performance isn't justified at all.
>>
>> target/i386/cpu-sysemu.c looks the correct place for this helper.
> 
> ack

Will move it to target/i386/cpu-sysemu.c in next version.

>>
>>> +{
>>> +    CPUState *cs = CPU(cpu);
>>> +    uint64_t val;
>>> +
>>> +    val = cs->nr_threads * cs->nr_cores;  /* thread count, bits 15..0 */
>>> +    val |= ((uint32_t)cs->nr_cores << 16); /* core count, bits 31..16 */
>>
>> Personally I'd change to:
>>
>>          return deposit64(cs->nr_threads * cs->nr_cores, 16, 16,
>>                           cs->nr_cores);
> that I wouldn't do in this patch to make it easier to compare apples to apples
> That however could be a separate patch on top

OK. I will keep it as-is in this patch.

>>> +
>>> +    return val;
>>> +}
>>
> 


