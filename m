Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F274C0218F
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Feb 2025 14:40:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1teb87-0007s8-9G; Sun, 02 Feb 2025 09:39:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1teb86-0007s0-Ek
 for qemu-devel@nongnu.org; Sun, 02 Feb 2025 09:39:22 -0500
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1teb83-00010l-8S
 for qemu-devel@nongnu.org; Sun, 02 Feb 2025 09:39:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738507159; x=1770043159;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=iPIUexgfl/nH+sknvP912xNQqEwXm19jPq4R/uL8ufs=;
 b=axvXmhtpun3C8MNb/yg0zoqsts0SPdNptO3ylmvjW/nWoneNuxG3owf5
 y29wnL/fLMtD+kByO+MXlLwdAevp+mJk/9Db2Xd18uCO5o5ouh0SzFxGU
 RndIgH4+5+8iK/5j1/cChdu7kTqCCBBxhWsMwXqDXLV6/uyvRswVpE0gZ
 77RMZE5SLae3JWyT+Fs8I1wImofe4mMVIcUq23RlFjrXfbKXOYa2jh2jV
 zanMnHHv58WOCQEsOOyHCkdbT18/cnmur3na8C1ukEG68/9FEws977vNj
 vYabdBw9JS5AOOWQ37ofldXhRQz97RSr0cYjI52mIHyQ+KNChMevZq0E2 A==;
X-CSE-ConnectionGUID: V9TdbEb0R3+W5Cvz2oy2kQ==
X-CSE-MsgGUID: VN6EjJfFTOyTl9yOgBvsOA==
X-IronPort-AV: E=McAfee;i="6700,10204,11334"; a="39167030"
X-IronPort-AV: E=Sophos;i="6.13,254,1732608000"; d="scan'208";a="39167030"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Feb 2025 06:39:14 -0800
X-CSE-ConnectionGUID: B+mnSoiAQZ28uG1kztDMSQ==
X-CSE-MsgGUID: CMjMRBjdRye/bMKwn2Av7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,254,1732608000"; d="scan'208";a="115066821"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Feb 2025 06:39:10 -0800
Message-ID: <774945ce-04e2-42d5-83fc-97ad08647101@intel.com>
Date: Sun, 2 Feb 2025 22:39:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 51/52] i386/tdx: Validate phys_bits against host value
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcelo Tosatti <mtosatti@redhat.com>, Huacai Chen <chenhuacai@kernel.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Francesco Lavra <francescolavra.fl@gmail.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org
References: <20250124132048.3229049-1-xiaoyao.li@intel.com>
 <20250124132048.3229049-52-xiaoyao.li@intel.com>
 <CABgObfb5ruVO2sxLCbZobiaqX-3h9Q+UKOZnp_hhxfJA=T-OJA@mail.gmail.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <CABgObfb5ruVO2sxLCbZobiaqX-3h9Q+UKOZnp_hhxfJA=T-OJA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.15; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=1, RCVD_IN_DNSWL_MED=-2.3,
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

On 2/1/2025 2:27 AM, Paolo Bonzini wrote:
> On Fri, Jan 24, 2025 at 2:40 PM Xiaoyao Li <xiaoyao.li@intel.com> wrote:
>>
>> For TDX guest, the phys_bits is not configurable and can only be
>> host/native value.
>>
>> Validate phys_bits inside tdx_check_features().
> 
> Hi Xiaoyao,
> 
> to avoid
> 
> qemu-kvm: TDX requires guest CPU physical bits (48) to match host CPU
> physical bits (52)
> 
> I need options like
> 
> -cpu host,phys-bits=52,guest-phys-bits=52,host-phys-bits-limit=52,-kvm-asyncpf-int
> 
> to start a TDX guest, is that intentional?

"-cpu host" should be sufficient and should not hit the error.

why did you get "guest CPU physical bits (48)"?

> Thanks,
> 
> Paolo
> 
>> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
>> ---
>>   target/i386/host-cpu.c | 2 +-
>>   target/i386/host-cpu.h | 1 +
>>   target/i386/kvm/tdx.c  | 8 ++++++++
>>   3 files changed, 10 insertions(+), 1 deletion(-)
>>
>> diff --git a/target/i386/host-cpu.c b/target/i386/host-cpu.c
>> index 3e4e85e729c8..8a15af458b05 100644
>> --- a/target/i386/host-cpu.c
>> +++ b/target/i386/host-cpu.c
>> @@ -15,7 +15,7 @@
>>   #include "system/system.h"
>>
>>   /* Note: Only safe for use on x86(-64) hosts */
>> -static uint32_t host_cpu_phys_bits(void)
>> +uint32_t host_cpu_phys_bits(void)
>>   {
>>       uint32_t eax;
>>       uint32_t host_phys_bits;
>> diff --git a/target/i386/host-cpu.h b/target/i386/host-cpu.h
>> index 6a9bc918baa4..b97ec01c9bec 100644
>> --- a/target/i386/host-cpu.h
>> +++ b/target/i386/host-cpu.h
>> @@ -10,6 +10,7 @@
>>   #ifndef HOST_CPU_H
>>   #define HOST_CPU_H
>>
>> +uint32_t host_cpu_phys_bits(void);
>>   void host_cpu_instance_init(X86CPU *cpu);
>>   void host_cpu_max_instance_init(X86CPU *cpu);
>>   bool host_cpu_realizefn(CPUState *cs, Error **errp);
>> diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
>> index bb75eb06dad9..c906a76c4c0e 100644
>> --- a/target/i386/kvm/tdx.c
>> +++ b/target/i386/kvm/tdx.c
>> @@ -24,6 +24,7 @@
>>
>>   #include "cpu.h"
>>   #include "cpu-internal.h"
>> +#include "host-cpu.h"
>>   #include "hw/i386/e820_memory_layout.h"
>>   #include "hw/i386/x86.h"
>>   #include "hw/i386/tdvf.h"
>> @@ -838,6 +839,13 @@ static int tdx_check_features(X86ConfidentialGuest *cg, CPUState *cs)
>>           return -1;
>>       }
>>
>> +    if (cpu->phys_bits != host_cpu_phys_bits()) {
>> +        error_report("TDX requires guest CPU physical bits (%u) "
>> +                     "to match host CPU physical bits (%u)",
>> +                     cpu->phys_bits, host_cpu_phys_bits());
>> +        exit(1);
>> +    }
>> +
>>       return 0;
>>   }
>>
>> --
>> 2.34.1
>>
> 
> 


