Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B901AC369AB
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 02:33:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u73R7-0005WG-6p; Mon, 21 Apr 2025 22:32:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1u73R2-0005Vx-UR
 for qemu-devel@nongnu.org; Mon, 21 Apr 2025 22:32:33 -0400
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1u73Qz-0007SQ-Sh
 for qemu-devel@nongnu.org; Mon, 21 Apr 2025 22:32:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1745289149; x=1776825149;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=O+7AtRZm2AYrjDF8UIydm9UblikX9BSHcOdQe11cpkc=;
 b=UrQn7cONu04eXtWuK8Zgvz8CC8H8qGaSka+i69BkJPjvmoV3qseW9Ypb
 VZfcMUnHKtviP1ds0zf/QAJnlSlJUg5VPN3avfLkL9m9I30Ay0fm67d3t
 RgbK5Za+MBjVYpxUxPr1vdtk3Awjk8Dw1D1Bgztvw6AcCEwrt2FHiHR8H
 cKWiVzRHO/piJ3OoA7LTbsln4seuZJ4T4RpD6p+s+URwWhcA69vSqFZwr
 CJ7hQAsMobHSxvG+iWgSXCLyD5GuBhWoeHNs/CHIVWHeulDN9sQQiC7s6
 lU/XgGHxUgOFN228vUibnDMzoUz43SWMLjmN7YaHyuqLS8AWor/iOVGab A==;
X-CSE-ConnectionGUID: 27I3LreIQ8+sHelWbKb0HQ==
X-CSE-MsgGUID: aJoihfBrQgusDUbousEEtQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11410"; a="46954160"
X-IronPort-AV: E=Sophos;i="6.15,229,1739865600"; d="scan'208";a="46954160"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Apr 2025 19:32:26 -0700
X-CSE-ConnectionGUID: DXNFuP0fT7awzMk8hHET0w==
X-CSE-MsgGUID: GOjJq5NsSuKRcVYuVxGFGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,229,1739865600"; d="scan'208";a="136854006"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Apr 2025 19:32:24 -0700
Message-ID: <12ec4e5c-33af-47a0-817f-b1fd0420f8f5@intel.com>
Date: Tue, 22 Apr 2025 10:32:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 06/55] i386/tdx: Introduce is_tdx_vm() helper and cache
 tdx_guest object
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, Francesco Lavra <francescolavra.fl@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>
References: <20250401130205.2198253-1-xiaoyao.li@intel.com>
 <20250401130205.2198253-7-xiaoyao.li@intel.com> <aAIfL0jS0lWSpvZE@intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <aAIfL0jS0lWSpvZE@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.198.163.15; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.692,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
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

On 4/18/2025 5:45 PM, Zhao Liu wrote:
> On Tue, Apr 01, 2025 at 09:01:16AM -0400, Xiaoyao Li wrote:
>> Date: Tue,  1 Apr 2025 09:01:16 -0400
>> From: Xiaoyao Li <xiaoyao.li@intel.com>
>> Subject: [PATCH v8 06/55] i386/tdx: Introduce is_tdx_vm() helper and cache
>>   tdx_guest object
>> X-Mailer: git-send-email 2.34.1
>>
>> It will need special handling for TDX VMs all around the QEMU.
>> Introduce is_tdx_vm() helper to query if it's a TDX VM.
>>
>> Cache tdx_guest object thus no need to cast from ms->cgs every time.
>>
>> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
>> Acked-by: Gerd Hoffmann <kraxel@redhat.com>
>> Reviewed-by: Isaku Yamahata <isaku.yamahata@intel.com>
>> ---
>> changes in v3:
>> - replace object_dynamic_cast with TDX_GUEST();
>> ---
>>   target/i386/kvm/tdx.c | 15 ++++++++++++++-
>>   target/i386/kvm/tdx.h | 10 ++++++++++
>>   2 files changed, 24 insertions(+), 1 deletion(-)
>>
>> diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
>> index c67be5e618e2..16f67e18ae78 100644
>> --- a/target/i386/kvm/tdx.c
>> +++ b/target/i386/kvm/tdx.c
>> @@ -18,8 +18,16 @@
>>   #include "kvm_i386.h"
>>   #include "tdx.h"
>>   
>> +static TdxGuest *tdx_guest;
>> +
>>   static struct kvm_tdx_capabilities *tdx_caps;
>>   
>> +/* Valid after kvm_arch_init()->confidential_guest_kvm_init()->tdx_kvm_init() */
>> +bool is_tdx_vm(void)
>> +{
>> +    return !!tdx_guest;
>> +}
>> +
>>   enum tdx_ioctl_level {
>>       TDX_VM_IOCTL,
>>       TDX_VCPU_IOCTL,
>> @@ -117,15 +125,20 @@ static int get_tdx_capabilities(Error **errp)
>>   
>>   static int tdx_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
>>   {
>> +    TdxGuest *tdx = TDX_GUEST(cgs);
>>       int r = 0;
>>   
>>       kvm_mark_guest_state_protected();
>>   
>>       if (!tdx_caps) {
>>           r = get_tdx_capabilities(errp);
>> +        if (r) {
>> +            return r;
>> +        }
>>       }
>>   
>> -    return r;
>> +    tdx_guest = tdx;
>> +    return 0;
>>   }
>>   
>>   static int tdx_kvm_type(X86ConfidentialGuest *cg)
>> diff --git a/target/i386/kvm/tdx.h b/target/i386/kvm/tdx.h
>> index f3b725336161..de8ae9196163 100644
>> --- a/target/i386/kvm/tdx.h
>> +++ b/target/i386/kvm/tdx.h
>> @@ -3,6 +3,10 @@
>>   #ifndef QEMU_I386_TDX_H
>>   #define QEMU_I386_TDX_H
>>   
>> +#ifndef CONFIG_USER_ONLY
>> +#include CONFIG_DEVICES /* CONFIG_TDX */
>> +#endif
>> +
>>   #include "confidential-guest.h"
>>   
>>   #define TYPE_TDX_GUEST "tdx-guest"
>> @@ -18,4 +22,10 @@ typedef struct TdxGuest {
>>       uint64_t attributes;    /* TD attributes */
>>   } TdxGuest;
>>   
>> +#ifdef CONFIG_TDX
>> +bool is_tdx_vm(void);
>> +#else
>> +#define is_tdx_vm() 0
>> +#endif /* CONFIG_TDX */
>> +
>   
> a little nit: could we rename it as "tdx_enabled"?
> 
> Then the cases like these would be neater?

When sev support was added, it was seen as a feature for the VMs that 
are created on AMD platform. I think that's why it got called sev_enabled().

But for TDX, it is introduced as a different type of VM in contrast to 
the legacy/normal VMX VMs. We need to pass specific TDX vm type to 
KVM_CREATE_VM. Based on this, is_tdx_vm() was chosen.

I don't think the different name is a big issue, as nobody mentions it 
from the initial RFC to current v8 until you. So again, I will just keep 
it unchanged unless someone objects it strongly.

> if (sev_enabled() || is_tdx_vm()) {
>      ...
> }
> 
> 
> if (sev_enabled()) {
>      ...
> } else if (is_tdx_vm()) {
>      ...
> }
> 
> Otherwise,
> 
> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>

Thanks!

> Thanks,
> Zhao
> 
> 


