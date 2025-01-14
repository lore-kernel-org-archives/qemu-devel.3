Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B830EE77188
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2025 12:57:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXgSm-0008M4-Q0; Tue, 14 Jan 2025 07:56:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tXgSk-0008Lt-Lo
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 07:56:06 -0500
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tXgSi-0007fk-LW
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 07:56:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1736859364; x=1768395364;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=qJC8d9uqmeCHYmIZX8ZDBCvOsr4anJF7pnDu7IUs47Q=;
 b=hhsY3c99YNUCgMUruDWyqYCrMqexuQg0qpj1cDsKzSG1v/vCpmtRzFES
 elYYoIO/IhB2O2xLT/LSPEZcNkBLwoQPfLTm+gzAxOo+4ROyji5RpZIRp
 xzBffBMc3Q9sheJGgNUmwUhR0BeXkWvZNJMqIfPmCuqNf2B3VyX0AKDQx
 gACkDGF2xQhVNdmtUzCMXCFrtzBTz54ahDM5g7/Pb5n2b+p6aYRXBpTb8
 3wQU4oHHAOpplf219L0yDHcYYCDU90AuxUlDCy4v9SGvPKKgQaNKMpuQn
 3rb3AQr9HlqlEsDJZDEcjjTjpp1+s7kDu0D/iaGtfoM4u5J+kx+DnNYk0 g==;
X-CSE-ConnectionGUID: Sjk8EL+nREmQGo0++ljPcA==
X-CSE-MsgGUID: CpC4wuSzSpGc33yS8ptruQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11315"; a="37314568"
X-IronPort-AV: E=Sophos;i="6.12,314,1728975600"; d="scan'208";a="37314568"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jan 2025 04:56:02 -0800
X-CSE-ConnectionGUID: 2OBKfawTTOa2A5hnk/mwfQ==
X-CSE-MsgGUID: hARCAZLvRZKc8lIYka8fig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,314,1728975600"; d="scan'208";a="105313915"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jan 2025 04:55:56 -0800
Message-ID: <1cbe556d-ac8a-4a95-bf1c-8f87a4bd04ca@intel.com>
Date: Tue, 14 Jan 2025 20:55:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 36/60] i386/tdx: Force exposing CPUID 0x1f
To: Ira Weiny <ira.weiny@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, rick.p.edgecombe@intel.com,
 kvm@vger.kernel.org, qemu-devel@nongnu.org
References: <20241105062408.3533704-1-xiaoyao.li@intel.com>
 <20241105062408.3533704-37-xiaoyao.li@intel.com>
 <Z1thEdonGTThi7MX@iweiny-mobl>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <Z1thEdonGTThi7MX@iweiny-mobl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=198.175.65.16; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.063,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.998, RCVD_IN_DNSWL_MED=-2.3,
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

On 12/13/2024 6:17 AM, Ira Weiny wrote:
> On Tue, Nov 05, 2024 at 01:23:44AM -0500, Xiaoyao Li wrote:
>> TDX uses CPUID 0x1f to configure TD guest's CPU topology. So set
>> enable_cpuid_0x1f for TDs.
> 
> If you squashed this into patch 35 I think it might make more sense overall
> after some commit message clean ups.

I see it as patch 35 introduces the interface, and this patch uses it. 
I'm neutral. Squash is simple, I would leave it to Paolo to make the 
final decision.

> Ira
> 
>>
>> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
>> ---
>>   target/i386/kvm/tdx.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
>> index 289722a129ce..19ce90df4143 100644
>> --- a/target/i386/kvm/tdx.c
>> +++ b/target/i386/kvm/tdx.c
>> @@ -388,7 +388,11 @@ static int tdx_kvm_type(X86ConfidentialGuest *cg)
>>   
>>   static void tdx_cpu_instance_init(X86ConfidentialGuest *cg, CPUState *cpu)
>>   {
>> +    X86CPU *x86cpu = X86_CPU(cpu);
>> +
>>       object_property_set_bool(OBJECT(cpu), "pmu", false, &error_abort);
>> +
>> +    x86cpu->enable_cpuid_0x1f = true;
>>   }
>>   
>>   static void tdx_cpu_realizefn(X86ConfidentialGuest *cg, CPUState *cs,
>> -- 
>> 2.34.1
>>


