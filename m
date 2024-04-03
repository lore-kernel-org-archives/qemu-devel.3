Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 538B9CD1288
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Apr 2024 15:35:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rs2dI-0006jl-Op; Wed, 03 Apr 2024 11:34:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rs2dG-0006jF-14
 for qemu-devel@nongnu.org; Wed, 03 Apr 2024 11:34:34 -0400
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rs2dD-00052A-Pw
 for qemu-devel@nongnu.org; Wed, 03 Apr 2024 11:34:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1712158471; x=1743694471;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=Wx7aZYKfQHN8dkuxOXCzB08HSgk6Fx2Jo5W5xBjAq6k=;
 b=FTJ4BAUs5OGbTtT/QM02DWWiHPscztquVbYlxiW2N1sTeb+HGpPnSsAt
 Y2XEMo6ysjxGELJ9IP/kQsU8FP9IxYORJG331sFcFo+i5GH+3o/m9gFB6
 ZI+tQjScVZ7Gwe7U+vRupFSKit5AUY7WQCUjfIPE0NvyYXQumBHJ6vRYU
 mek/qnJecdH0UABjYQKZJLLYi0cSAt6EAkteQehPJqJZhY6Bqi15qVngT
 vLrmAGRR0LuwozJJmXh3ULAFt9HJPO2z1h0fiODCqV3IIfRMwfi8tHng+
 mR/GnjRR4/tgN5BX1rTphx5fsa6/thuM/niIIuipjHqWdrkPf3EJUWgrw g==;
X-CSE-ConnectionGUID: 3e69Q7XJQ5GiMwDmaWLJ0g==
X-CSE-MsgGUID: +9YV9cenRA+DaeKrI2yXmA==
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="24852193"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; d="scan'208";a="24852193"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Apr 2024 08:34:27 -0700
X-CSE-ConnectionGUID: kXnljg0MT6GHILeV6yiJuw==
X-CSE-MsgGUID: SrAVkTI7SdGblFkp9Z7k6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; d="scan'208";a="18511928"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.224.7])
 ([10.124.224.7])
 by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Apr 2024 08:34:23 -0700
Message-ID: <d15fa876-5e9e-48c8-8b71-d1aecf5b25af@intel.com>
Date: Wed, 3 Apr 2024 23:34:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hw/i386/acpi: Set PCAT_COMPAT bit only when pic is not
 disabled
To: Igor Mammedov <imammedo@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-devel@nongnu.org,
 isaku.yamahata@intel.com,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
References: <20240403145953.3082491-1-xiaoyao.li@intel.com>
 <20240403171245.22a857af@imammedo.users.ipa.redhat.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20240403171245.22a857af@imammedo.users.ipa.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=198.175.65.10; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_LOW=-0.7,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 4/3/2024 11:12 PM, Igor Mammedov wrote:
> On Wed,  3 Apr 2024 10:59:53 -0400
> Xiaoyao Li <xiaoyao.li@intel.com> wrote:
> 
>> A value 1 of PCAT_COMPAT (bit 0) of MADT.Flags indicates that the system
>> also has a PC-AT-compatible dual-8259 setup, i.e., the PIC.
>>
>> When PIC is not enabled (pic=off) for x86 machine, the PCAT_COMPAT bit
>> needs to be cleared. Otherwise, the guest thinks there is a present PIC.
> 
> Can you add to commit message reproducer (aka qemu CLI and relevant
> logs/symptoms observed on guest side)?

When booting a VM with "-machine xx,pic=off", there is supposed to be no 
PIC for the guest. When guest probes PIC, it should find nothing and log 
of below should be printed:

   [    0.155970] Using NULL legacy PIC

However, the fact is that no such log printed in guest kernel, with the 
VM created with "pic=off". This is because guest think there is a 
present due to pcat_compat is reporte as 1 in MADT. See Linux code of 
probe_8259A() in arch/x86/kernel/i8259.c 


> 
>>    
>> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>                                  
>> ---
>> changes in v2:
>> - Clarify more in commit message;
>> ---
>>   hw/i386/acpi-common.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/i386/acpi-common.c b/hw/i386/acpi-common.c
>> index 20f19269da40..0cc2919bb851 100644
>> --- a/hw/i386/acpi-common.c
>> +++ b/hw/i386/acpi-common.c
>> @@ -107,7 +107,9 @@ void acpi_build_madt(GArray *table_data, BIOSLinker *linker,
>>       acpi_table_begin(&table, table_data);
>>       /* Local APIC Address */
>>       build_append_int_noprefix(table_data, APIC_DEFAULT_ADDRESS, 4);
>> -    build_append_int_noprefix(table_data, 1 /* PCAT_COMPAT */, 4); /* Flags */
>> +    /* Flags. bit 0: PCAT_COMPAT */
>> +    build_append_int_noprefix(table_data,
>> +                              x86ms->pic != ON_OFF_AUTO_OFF ? 1 : 0 , 4);
>>   
>>       for (i = 0; i < apic_ids->len; i++) {
>>           pc_madt_cpu_entry(i, apic_ids, table_data, false);
> 


