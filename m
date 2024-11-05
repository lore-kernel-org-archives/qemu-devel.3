Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25D42D12693
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 11:54:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8I8S-0004ns-Md; Tue, 05 Nov 2024 06:54:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1t8I8P-0004nE-T8
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 06:54:09 -0500
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1t8I8O-00020l-1D
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 06:54:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730807648; x=1762343648;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=MU3Vwso6KH01jEsxvdnAJcmSqvWyHee3ON+2Ro2iZ6o=;
 b=bHitxa9imMieRdmATbnVMouaAa0n+ABoq7S54TVlZULvlU9mbmVmjCx6
 ZYY6tstjXx4wGv3Ou3cqTsUeyGgFOYHowzKOPO5AvsOGl8dPsZx4Spfp1
 Z7Zn6PR5+9olB6ln+XiPc+P4AtJBt4HAK4ael7KV9NMgK4F/9sx3oRrBN
 YLE2QjxVIcBypusVF6mbqao33vDf1zYfrfNqU7z34KWMleWVEH4UaAtfB
 ImVOvWm/QqMJOr16/EbZOeUJG8qwlmN0L2x1cJe/wycKBx8QhXToy7ACn
 sAfpokWC4j9qnEShjAHFuXG8pEGOGI1WUuyM67c4B0+0NsvWMP4ijJz65 g==;
X-CSE-ConnectionGUID: rk1zAG1kQmq3mc52FG2AfA==
X-CSE-MsgGUID: GxvfiwBvR0WAHReUh564BQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11246"; a="41180102"
X-IronPort-AV: E=Sophos;i="6.11,260,1725346800"; d="scan'208";a="41180102"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2024 03:54:05 -0800
X-CSE-ConnectionGUID: y9/TKhocS/aOJ8358YkO7g==
X-CSE-MsgGUID: hQkuky62TOeYbX1TYZTmBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,260,1725346800"; d="scan'208";a="84382331"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2024 03:54:01 -0800
Message-ID: <7fbf9071-493a-4929-afaa-d0a669346f17@intel.com>
Date: Tue, 5 Nov 2024 19:53:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 13/60] i386/tdx: Validate TD attributes
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Cornelia Huck <cohuck@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, rick.p.edgecombe@intel.com,
 kvm@vger.kernel.org, qemu-devel@nongnu.org
References: <20241105062408.3533704-1-xiaoyao.li@intel.com>
 <20241105062408.3533704-14-xiaoyao.li@intel.com>
 <Zyn1Jhxr8ip0lIcs@redhat.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <Zyn1Jhxr8ip0lIcs@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.9; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.781, RCVD_IN_DNSWL_MED=-2.3,
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

On 11/5/2024 6:36 PM, Daniel P. Berrangé wrote:
> On Tue, Nov 05, 2024 at 01:23:21AM -0500, Xiaoyao Li wrote:
>> Validate TD attributes with tdx_caps that fixed-0 bits must be zero and
>> fixed-1 bits must be set.
>>
>> Besides, sanity check the attribute bits that have not been supported by
>> QEMU yet. e.g., debug bit, it will be allowed in the future when debug
>> TD support lands in QEMU.
>>
>> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
>> Acked-by: Gerd Hoffmann <kraxel@redhat.com>
>>
>> ---
>> Changes in v3:
>> - using error_setg() for error report; (Daniel)
>> ---
>>   target/i386/kvm/tdx.c | 28 ++++++++++++++++++++++++++--
>>   1 file changed, 26 insertions(+), 2 deletions(-)
>>
>> diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
>> index 6cf81f788fe0..5a9ce2ada89d 100644
>> --- a/target/i386/kvm/tdx.c
>> +++ b/target/i386/kvm/tdx.c
>> @@ -20,6 +20,7 @@
>>   #include "kvm_i386.h"
>>   #include "tdx.h"
>>   
>> +#define TDX_TD_ATTRIBUTES_DEBUG             BIT_ULL(0)
>>   #define TDX_TD_ATTRIBUTES_SEPT_VE_DISABLE   BIT_ULL(28)
>>   #define TDX_TD_ATTRIBUTES_PKS               BIT_ULL(30)
>>   #define TDX_TD_ATTRIBUTES_PERFMON           BIT_ULL(63)
>> @@ -141,13 +142,33 @@ static int tdx_kvm_type(X86ConfidentialGuest *cg)
>>       return KVM_X86_TDX_VM;
>>   }
>>   
>> -static void setup_td_guest_attributes(X86CPU *x86cpu)
>> +static int tdx_validate_attributes(TdxGuest *tdx, Error **errp)
>> +{
>> +    if ((tdx->attributes & ~tdx_caps->supported_attrs)) {
>> +            error_setg(errp, "Invalid attributes 0x%lx for TDX VM "
>> +                       "(supported: 0x%llx)",
>> +                       tdx->attributes, tdx_caps->supported_attrs);
>> +            return -1;
> 
> Minor whitespace accident, with indentation too deep.

Good catch!

btw, how did you catch it? any tool like checkpatch.pl or just by your eyes?

>> +    }
>> +
>> +    if (tdx->attributes & TDX_TD_ATTRIBUTES_DEBUG) {
>> +        error_setg(errp, "Current QEMU doesn't support attributes.debug[bit 0] "
>> +                         "for TDX VM");
>> +        return -1;
>> +    }
>> +
>> +    return 0;
>> +}
> 
> With regards,
> Daniel


