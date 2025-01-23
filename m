Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C9F3C02182
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2025 16:46:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tb0LP-0008Jv-DT; Thu, 23 Jan 2025 11:46:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tb0LN-0008JV-Jf
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 11:46:14 -0500
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tb0LK-0007FK-TA
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 11:46:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1737650771; x=1769186771;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=vVySh/TZLF+wwReAUP5Aq1bccSywQEunCA8CYjonaeM=;
 b=gd9GOGihVXICa/Ys1tZFk73AL/QY8pQ24GIlGXiCozAPRal7fAjJ6JUk
 ZJJVP3KZRn+hZpzfgK/90ZKZoSiG+V/g7s6WU93cR8XV9odJDCJ5+SuF+
 I/ssSz77AlV1d8SwelF7AVwrpsZ23eoyf4WFsV2aJa6tpSGhhyKV9RRF8
 dfGbTpvcQxBOZbJ8/8NvpL6d3szYnCKiUsdrie891aV/rBqsIcc+A82xs
 0fn/BFB6R28OzC8cpeNAi3qL8soAgJZi6SUe5Fqfw29nYqIBGoMl2dCKY
 ARfytRmYPe0jmodD2+70PDRCkUkCcgJWtLRXN9qiK1WxH7xfokdv2gBrZ Q==;
X-CSE-ConnectionGUID: vqMwEqdXRgiSOG+Dh+GBXQ==
X-CSE-MsgGUID: h7mqfw0tTNy6aszCk4JXNA==
X-IronPort-AV: E=McAfee;i="6700,10204,11324"; a="37858842"
X-IronPort-AV: E=Sophos;i="6.13,228,1732608000"; d="scan'208";a="37858842"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jan 2025 08:46:00 -0800
X-CSE-ConnectionGUID: nBRhB7V2SR2ZKsPwWWRXIw==
X-CSE-MsgGUID: /WGZTQrXTXOSzzv+4SXBTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="107350612"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jan 2025 08:45:54 -0800
Message-ID: <00ecb103-2f0b-479d-bae8-cb3f7bace3be@intel.com>
Date: Fri, 24 Jan 2025 00:45:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 40/60] hw/i386: add eoi_intercept_unsupported member to
 X86MachineState
To: Igor Mammedov <imammedo@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Ani Sinha <anisinha@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Yanan Wang <wangyanan55@huawei.com>,
 Cornelia Huck <cohuck@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Marcelo Tosatti
 <mtosatti@redhat.com>, rick.p.edgecombe@intel.com, kvm@vger.kernel.org,
 qemu-devel@nongnu.org
References: <20241105062408.3533704-1-xiaoyao.li@intel.com>
 <20241105062408.3533704-41-xiaoyao.li@intel.com>
 <20250123134148.036d52b0@imammedo.users.ipa.redhat.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20250123134148.036d52b0@imammedo.users.ipa.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=198.175.65.20; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -63
X-Spam_score: -6.4
X-Spam_bar: ------
X-Spam_report: (-6.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
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

On 1/23/2025 8:41 PM, Igor Mammedov wrote:
> On Tue,  5 Nov 2024 01:23:48 -0500
> Xiaoyao Li <xiaoyao.li@intel.com> wrote:
> 
>> Add a new bool member, eoi_intercept_unsupported, to X86MachineState
>> with default value false. Set true for TDX VM.
> 
> I'd rename it to enable_eoi_intercept, by default set to true for evrything
> and make TDX override this to false.
>>
>> Inability to intercept eoi causes impossibility to emulate level
>> triggered interrupt to be re-injected when level is still kept active.
>> which affects interrupt controller emulation.
>>
>> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
>> Acked-by: Gerd Hoffmann <kraxel@redhat.com>
>> ---
>>   hw/i386/x86.c         | 1 +
>>   include/hw/i386/x86.h | 1 +
>>   target/i386/kvm/tdx.c | 2 ++
>>   3 files changed, 4 insertions(+)
>>
>> diff --git a/hw/i386/x86.c b/hw/i386/x86.c
>> index 01fc5e656272..82faeed24ff9 100644
>> --- a/hw/i386/x86.c
>> +++ b/hw/i386/x86.c
>> @@ -370,6 +370,7 @@ static void x86_machine_initfn(Object *obj)
>>       x86ms->oem_table_id = g_strndup(ACPI_BUILD_APPNAME8, 8);
>>       x86ms->bus_lock_ratelimit = 0;
>>       x86ms->above_4g_mem_start = 4 * GiB;
>> +    x86ms->eoi_intercept_unsupported = false;
>>   }
>>   
>>   static void x86_machine_class_init(ObjectClass *oc, void *data)
>> diff --git a/include/hw/i386/x86.h b/include/hw/i386/x86.h
>> index d43cb3908e65..fd9a30391755 100644
>> --- a/include/hw/i386/x86.h
>> +++ b/include/hw/i386/x86.h
>> @@ -73,6 +73,7 @@ struct X86MachineState {
>>       uint64_t above_4g_mem_start;
>>   
>>       /* CPU and apic information: */
>> +    bool eoi_intercept_unsupported;
>>       unsigned pci_irq_mask;
>>       unsigned apic_id_limit;
>>       uint16_t boot_cpus;
>> diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
>> index 9ab4e911f78a..9dcb77e011bd 100644
>> --- a/target/i386/kvm/tdx.c
>> +++ b/target/i386/kvm/tdx.c
>> @@ -388,6 +388,8 @@ static int tdx_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
>>           return -EOPNOTSUPP;
>>       }
>>   
>> +    x86ms->eoi_intercept_unsupported = true;
> 
> I don't particulary like accel go to its parent (machine) object and override things there
> and that being buried deep inside.

I would suggest don't see TDX as accel but see it as a special type of 
x86 machine.

> How do you start TDX guest?
> Is there a machine property or something like it to enable TDX?

via the "confidential-guest-support" property.
This series introduces tdx-guest object and we start a TDX guest by:

$qemu-system-x86_64 -object tdx-guest,id=tdx0 \
     -machine ...,confidential-guest-support=tdx0

>> +
>>       /*
>>        * Set kvm_readonly_mem_allowed to false, because TDX only supports readonly
>>        * memory for shared memory but not for private memory. Besides, whether a
> 


