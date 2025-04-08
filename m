Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60961C3600C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Apr 2025 05:04:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u217k-0005bG-9Z; Tue, 08 Apr 2025 01:03:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1u217h-0005ar-6X
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 01:03:45 -0400
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1u217e-0001Ek-UH
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 01:03:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1744088623; x=1775624623;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=Zqy5B5Wj05+4KXOwALLqyvPLpQ1tbQVXH1C+Hwhhm6g=;
 b=G3peDysOQZvZTqKlgTMuZ1ScopfzVU/MS8prW5slWKxIUh+bYNLoYg5l
 O8z+gWeMl6Gr5BcQYrxz8TJBIS1CZQaiIQyUdpb36lyPWqcTAKgK4I09w
 4vhPY5GsDvWgPG/O+ZY7R60W4PzhszIi1nIdD9S2fNnca/gMIFaWIff1X
 bmngzWzk082F0czfXK7piYcn9fGb/Kcb6JBa/AGY8xFJLw7xhOfPiLuYX
 WwRJrtNY2La274FRBX//b5qcAILnI4l4F5/ZufnqCTolVV2l6kzhVorY7
 oh5NRsRaThxPuYSUbM0JN0aL1fzFBQ5uvEilkIAzp/nBDZ/zeg8GBFn4u w==;
X-CSE-ConnectionGUID: eTq8QG3hSfS0cDxKIjCdHQ==
X-CSE-MsgGUID: +nrN2TAjTIeJ60IxCeVtHQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="44751830"
X-IronPort-AV: E=Sophos;i="6.15,197,1739865600"; d="scan'208";a="44751830"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Apr 2025 22:03:38 -0700
X-CSE-ConnectionGUID: LOKAB7mDRc2NENlHtFc6vw==
X-CSE-MsgGUID: 85m6SchSQN2BmCRkQJ8c/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,197,1739865600"; d="scan'208";a="132874497"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Apr 2025 22:03:30 -0700
Message-ID: <1279f93c-3677-4097-968d-a8530a69678f@intel.com>
Date: Tue, 8 Apr 2025 13:03:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 38/55] i386/tdx: Set and check kernel_irqchip mode for
 TDX
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Francesco Lavra <francescolavra.fl@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>
References: <20250401130205.2198253-1-xiaoyao.li@intel.com>
 <20250401130205.2198253-39-xiaoyao.li@intel.com>
 <Z-0UdHfoXN-wIEnV@redhat.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <Z-0UdHfoXN-wIEnV@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.18; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.32,
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

On 4/2/2025 6:41 PM, Daniel P. Berrangé wrote:
> On Tue, Apr 01, 2025 at 09:01:48AM -0400, Xiaoyao Li wrote:
>> KVM mandates kernel_irqchip to be split mode.
>>
>> Set it to split mode automatically when users don't provide an explicit
>> value, otherwise check it to be the split mode.
>>
>> Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
>> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
>> ---
>>   target/i386/kvm/tdx.c | 8 ++++++++
>>   1 file changed, 8 insertions(+)
> 
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> 
> 
>> diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
>> index 0d30506c2021..4128f27d6b64 100644
>> --- a/target/i386/kvm/tdx.c
>> +++ b/target/i386/kvm/tdx.c
>> @@ -16,6 +16,7 @@
>>   #include "qapi/error.h"
>>   #include "qom/object_interfaces.h"
>>   #include "crypto/hash.h"
>> +#include "system/kvm_int.h"
>>   #include "system/runstate.h"
>>   #include "system/system.h"
>>   #include "exec/ramblock.h"
>> @@ -390,6 +391,13 @@ static int tdx_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
>>           return -EINVAL;
>>       }
>>   
>> +    if (kvm_state->kernel_irqchip_split == ON_OFF_AUTO_AUTO ) {
> 
> Nitpick, no need for a space before the ')' ...
> 
>> +        kvm_state->kernel_irqchip_split = ON_OFF_AUTO_ON;
>> +    } else if(kvm_state->kernel_irqchip_split != ON_OFF_AUTO_ON) {
> 
> ..and need a space between 'if' and '('

Thanks for catching these coding style issue. Will fix them in the next 
version.

>> +        error_setg(errp, "TDX VM requires kernel_irqchip to be split");
>> +        return -EINVAL;
>> +    }
>> +
> 
> Note for self - 'tdx_kvm_init' is called by 'confidential_guest_kvm_init',
> which is called by 'kvm_arch_init', which is called by 'kvm_init' *before*
> it processes "kvm_state->kernel_irqchip_split == ON_OFF_AUTO_AUTO" to set
> the default. So this change is correctly taking priority over the default
> behaviour.
> 
>>       if (!tdx_caps) {
>>           r = get_tdx_capabilities(errp);
>>           if (r) {
>> -- 
>> 2.34.1
>>
> 
> With regards,
> Daniel


