Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9239C19F32
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 02:42:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tovl9-0005cG-IT; Sun, 02 Mar 2025 21:42:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tovl6-0005bq-Uh
 for qemu-devel@nongnu.org; Sun, 02 Mar 2025 21:42:20 -0500
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tovl4-0007EZ-Q2
 for qemu-devel@nongnu.org; Sun, 02 Mar 2025 21:42:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1740969739; x=1772505739;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=UTJE0AWcwtm1kfCtTh7Pdyk6SzSTbYJlwG8ImNoDFkg=;
 b=JUsx82dmMuC6yhovbBqiMEF59QUkHX6pHk0k+nBHcJi7fv4j1c1VPb2k
 06PtYqvxlJAjVZHcUoDtx5lvbyRUVkEHXxuerbegKlOJwVEXde0hJ3vo+
 SHqp1DLcquP91hO7aBRoaqmURquzh4mf1tXKt8nChmtyvMeRQVuh3sd/1
 2m+pgybiUBQnxjnCbkSAwzQkjtv53mDlVLKG59Y+7Pz7xnBva+w6rgPQv
 /JpY1yZrTiDjto6W77Rt/VJ57m2Yvb4OmYtEVehFytQY0FgkVH6X5/YmI
 YmMM7Av0PjYDSR58P8iQ63wAJvLafenD/giDNoCp3lglVN07FTp6VD1OU w==;
X-CSE-ConnectionGUID: 0y2LbC9ITayiMK8KAeiWBw==
X-CSE-MsgGUID: WVLSfHI9SVeIAEr6fgMBng==
X-IronPort-AV: E=McAfee;i="6700,10204,11361"; a="41533052"
X-IronPort-AV: E=Sophos;i="6.13,328,1732608000"; d="scan'208";a="41533052"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Mar 2025 18:42:16 -0800
X-CSE-ConnectionGUID: uvej7JceQYS6RgznScZbuA==
X-CSE-MsgGUID: WluVq+NDQ0qfbVt13pid6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,328,1732608000"; d="scan'208";a="117896335"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Mar 2025 18:42:12 -0800
Message-ID: <85c7d37d-1e8f-49f6-8c96-36ff316a6615@intel.com>
Date: Mon, 3 Mar 2025 10:42:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 38/52] i386/apic: Skip kvm_apic_put() for TDX
To: Francesco Lavra <francescolavra.fl@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Igor Mammedov <imammedo@redhat.com>
Cc: Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcelo Tosatti <mtosatti@redhat.com>, Huacai Chen <chenhuacai@kernel.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org
References: <20250124132048.3229049-1-xiaoyao.li@intel.com>
 <20250124132048.3229049-39-xiaoyao.li@intel.com>
 <40b8bf9854d4a83b55ae8e83f093462b5852a35f.camel@gmail.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <40b8bf9854d4a83b55ae8e83f093462b5852a35f.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.20; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On 2/28/2025 12:57 AM, Francesco Lavra wrote:
> On Fri, 2025-01-24 at 08:20 -0500, Xiaoyao Li wrote:
>> KVM neithers allow writing to MSR_IA32_APICBASE for TDs, nor allow
>> for
>> KVM_SET_LAPIC[*].
>>
>> Note, KVM_GET_LAPIC is also disallowed for TDX. It is called in the
>> path
>>
>>    do_kvm_cpu_synchronize_state()
>>    -> kvm_arch_get_registers()
>>       -> kvm_get_apic()
>>
>> and it's already disllowed for confidential guest through
>> guest_state_protected.
>>
>> [*] https://lore.kernel.org/all/Z3w4Ku4Jq0CrtXne@google.com/
>>
>> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
>> ---
>>   hw/i386/kvm/apic.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/hw/i386/kvm/apic.c b/hw/i386/kvm/apic.c
>> index 757510600098..a1850524a67f 100644
>> --- a/hw/i386/kvm/apic.c
>> +++ b/hw/i386/kvm/apic.c
>> @@ -17,6 +17,7 @@
>>   #include "system/hw_accel.h"
>>   #include "system/kvm.h"
>>   #include "kvm/kvm_i386.h"
>> +#include "kvm/tdx.h"
>>   
>>   static inline void kvm_apic_set_reg(struct kvm_lapic_state *kapic,
>>                                       int reg_id, uint32_t val)
>> @@ -141,6 +142,10 @@ static void kvm_apic_put(CPUState *cs,
>> run_on_cpu_data data)
>>       struct kvm_lapic_state kapic;
>>       int ret;
>>   
>> +    if(is_tdx_vm()) {
> 
> Missing space between if and (.
> scripts/checkpatch.pl would have caught this.

Me to be blamed that don't use checkpatch.pl everytime before post.

