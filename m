Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAD26C369A2
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Apr 2025 02:58:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2LdQ-0005Ma-4K; Tue, 08 Apr 2025 22:57:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1u2LdP-0005MR-3p
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 22:57:51 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1u2LdM-0001kO-VS
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 22:57:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1744167469; x=1775703469;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=a5YJGvLAvptuhNOJ4X+MsFhU4v0EsHX81xULja4ARzI=;
 b=ZvEeQadyNJmu+PpQBHzXItTP9pGop1bmo52JC29DtLv/+BoSHVWp9E+x
 aFt1g58ZdjHwonTKebOJa017Kh0zBPjghAuikZS9hPf1ZXrGoflMgavJQ
 nN98/NvTfB6+OpQwInczH9BKzmTD+6TCmgZlFv8Rz8dQDNM+KJeJvcQp1
 2EwAxqW8FbGNVNjW8udTSP0DatIttNuFhAyEcDrTd/hBnGeNBosDHkDAu
 Lucq30eyTY+xDqZ2nxpY+MqIHITobK1fJgtQuht+ZfpVLr6Uwlt6rEEH8
 O6cp/vf9bmBGkEgGeCh53Bn8e6133++xwXPz7wNmFlpZg3Qh2+BZMGhLZ Q==;
X-CSE-ConnectionGUID: v/yhh4HuSiuw0mYYk0cf1w==
X-CSE-MsgGUID: a0ucBs91QfOwsXZDtVDFMg==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="56996014"
X-IronPort-AV: E=Sophos;i="6.15,199,1739865600"; d="scan'208";a="56996014"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Apr 2025 19:57:45 -0700
X-CSE-ConnectionGUID: EIyMrmVkSMWGNUhMq1CLNQ==
X-CSE-MsgGUID: C+VF7Z3wSLC9R2+UKI4C7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,199,1739865600"; d="scan'208";a="132575603"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Apr 2025 19:57:42 -0700
Message-ID: <88fac92a-c646-4cbe-9409-60b6e3393dc8@intel.com>
Date: Wed, 9 Apr 2025 10:57:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 12/55] i386/tdx: Validate TD attributes
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Francesco Lavra <francescolavra.fl@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>
References: <20250401130205.2198253-1-xiaoyao.li@intel.com>
 <20250401130205.2198253-13-xiaoyao.li@intel.com>
 <Z-0j6nfevxiCJ_ud@redhat.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <Z-0j6nfevxiCJ_ud@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.10; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.845,
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

On 4/2/2025 7:47 PM, Daniel P. Berrangé wrote:
> On Tue, Apr 01, 2025 at 09:01:22AM -0400, Xiaoyao Li wrote:
>> Validate TD attributes with tdx_caps that only supported bits are
>> allowed by KVM.
>>
>> Besides, sanity check the attribute bits that have not been supported by
>> QEMU yet. e.g., debug bit, it will be allowed in the future when debug
>> TD support lands in QEMU.
>>
>> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
>> Acked-by: Gerd Hoffmann <kraxel@redhat.com>
>> ---
>> Changes in v8:
>> - Split the mrconfigid/mrowner/mrownerconfig part into a seperate next
>>    patch;
>>
>> Changes in v7:
>> - Define TDX_SUPPORTED_TD_ATTRS as QEMU supported mask, to validates
>>    user's request. (Rick)
>>
>> Changes in v3:
>> - using error_setg() for error report; (Daniel)
>> ---
>>   target/i386/kvm/tdx.c | 32 ++++++++++++++++++++++++++++++--
>>   1 file changed, 30 insertions(+), 2 deletions(-)
>>
>> diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
>> index 1202b2111ba8..aa043acb1a88 100644
>> --- a/target/i386/kvm/tdx.c
>> +++ b/target/i386/kvm/tdx.c
>> @@ -18,10 +18,15 @@
>>   #include "kvm_i386.h"
>>   #include "tdx.h"
>>   
>> +#define TDX_TD_ATTRIBUTES_DEBUG             BIT_ULL(0)
>>   #define TDX_TD_ATTRIBUTES_SEPT_VE_DISABLE   BIT_ULL(28)
>>   #define TDX_TD_ATTRIBUTES_PKS               BIT_ULL(30)
>>   #define TDX_TD_ATTRIBUTES_PERFMON           BIT_ULL(63)
>>   
>> +#define TDX_SUPPORTED_TD_ATTRS  (TDX_TD_ATTRIBUTES_SEPT_VE_DISABLE |\
>> +                                 TDX_TD_ATTRIBUTES_PKS | \
>> +                                 TDX_TD_ATTRIBUTES_PERFMON)
>> +
>>   static TdxGuest *tdx_guest;
>>   
>>   static struct kvm_tdx_capabilities *tdx_caps;
>> @@ -153,13 +158,33 @@ static int tdx_kvm_type(X86ConfidentialGuest *cg)
>>       return KVM_X86_TDX_VM;
>>   }
>>   
>> -static void setup_td_guest_attributes(X86CPU *x86cpu)
>> +static int tdx_validate_attributes(TdxGuest *tdx, Error **errp)
>> +{
>> +    if ((tdx->attributes & ~tdx_caps->supported_attrs)) {
>> +        error_setg(errp, "Invalid attributes 0x%lx for TDX VM "
>> +                   "(KVM supported: 0x%llx)", tdx->attributes,
>> +                   tdx_caps->supported_attrs);
>> +        return -1;
>> +    }
>> +
>> +    if (tdx->attributes & ~TDX_SUPPORTED_TD_ATTRS) {
>> +        warn_report("Some QEMU unsupported TD attribute bits being requested:"
>> +                    "requested: 0x%lx QEMU supported: 0x%llx",
>> +                    tdx->attributes, TDX_SUPPORTED_TD_ATTRS);
> 
> IIUC, this is an explicit user mis-configuration, and so we
> ought to use  error_setg & return -1, not merely a warning.

My thought was to allow user to enable some QEMU unsupported but KVM 
supported attribute bits, for testing purpose.

But now I agree with you. It's not good for production QEMU.

>> +    }
>> +
>> +    return 0;
>> +}
>> +
>> +static int setup_td_guest_attributes(X86CPU *x86cpu, Error **errp)
>>   {
>>       CPUX86State *env = &x86cpu->env;
>>   
>>       tdx_guest->attributes |= (env->features[FEAT_7_0_ECX] & CPUID_7_0_ECX_PKS) ?
>>                                TDX_TD_ATTRIBUTES_PKS : 0;
>>       tdx_guest->attributes |= x86cpu->enable_pmu ? TDX_TD_ATTRIBUTES_PERFMON : 0;
>> +
>> +    return tdx_validate_attributes(tdx_guest, errp);
>>   }
>>   
>>   static int setup_td_xfam(X86CPU *x86cpu, Error **errp)
>> @@ -225,7 +250,10 @@ int tdx_pre_create_vcpu(CPUState *cpu, Error **errp)
>>       init_vm = g_malloc0(sizeof(struct kvm_tdx_init_vm) +
>>                           sizeof(struct kvm_cpuid_entry2) * KVM_MAX_CPUID_ENTRIES);
>>   
>> -    setup_td_guest_attributes(x86cpu);
>> +    r = setup_td_guest_attributes(x86cpu, errp);
>> +    if (r) {
>> +        return r;
>> +    }
>>   
>>       r = setup_td_xfam(x86cpu, errp);
>>       if (r) {
>> -- 
>> 2.34.1
>>
> 
> With regards,
> Daniel


