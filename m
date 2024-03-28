Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C109C54E67
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 00:46:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpdtN-0008Df-AM; Wed, 27 Mar 2024 20:45:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rpdtL-0008DQ-KI
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 20:45:15 -0400
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rpdtI-00086P-CY
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 20:45:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1711586712; x=1743122712;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=qMr1lni1QD7AcsTQhnj6Msn8Z5FbVcK5sLp+/58NNJ0=;
 b=iw0PORWHdWmigdPioQyk0rA/5R2iUH17LzGMHxcl0930l/5zXcaDEPXY
 CERE7elGO+sNfphQTx+Eg97OcMNMtFHHg04S1amlytDL0xAXq36L4tIJs
 7mvOHg2oz6iEFTUkOIk4nYLzfPN6X3bMSYtIkqP3HZdNgcccDCsfQQ/ly
 mp/vBoProNRyde4nY+xgowIPETFrfaAgcFSzoSba6x2kHbCA+PrQRPC+v
 833PWHpuW/Q5lZIAUEnBlb1ZmqS/TdU74GJnsgjgFVZUVQTqkg5nfRDRB
 +DWuh5DcyC/JLgIR1ViK7OEJANYb18EWtmS8XXZwRyljqzjktxpywxhZZ Q==;
X-CSE-ConnectionGUID: nwjZwjXkR5OeKtmmjGe51w==
X-CSE-MsgGUID: HSn6YppoTKKDEYz6+9+OwQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="29200854"
X-IronPort-AV: E=Sophos;i="6.07,160,1708416000"; d="scan'208";a="29200854"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2024 17:45:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,160,1708416000"; d="scan'208";a="47683047"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.224.7])
 ([10.124.224.7])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2024 17:45:06 -0700
Message-ID: <61462f83-1406-48ea-8f1a-fae848ff1443@intel.com>
Date: Thu, 28 Mar 2024 08:45:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 48/49] hw/i386/sev: Use guest_memfd for legacy ROMs
To: Isaku Yamahata <isaku.yamahata@intel.com>,
 Michael Roth <michael.roth@amd.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Tom Lendacky <thomas.lendacky@amd.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Pankaj Gupta <pankaj.gupta@amd.com>,
 Isaku Yamahata <isaku.yamahata@linux.intel.com>
References: <20240320083945.991426-1-michael.roth@amd.com>
 <20240320083945.991426-49-michael.roth@amd.com>
 <20240320181223.GG1994522@ls.amr.corp.intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20240320181223.GG1994522@ls.amr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=198.175.65.9; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_NONE=-0.0001,
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

On 3/21/2024 2:12 AM, Isaku Yamahata wrote:
> On Wed, Mar 20, 2024 at 03:39:44AM -0500,
> Michael Roth <michael.roth@amd.com> wrote:
> 
>> TODO: make this SNP-specific if TDX disables legacy ROMs in general
> 
> TDX disables pc.rom, not disable isa-bios. IIRC, TDX doesn't need pc pflash.

Not TDX doesn't need pc pflash, but TDX cannot support pflash.

Can SNP support the behavior of pflash? That what's got changed will be 
synced back to OVMF file?

> Xiaoyao can chime in.
> 
> Thanks,
> 
>>
>> Current SNP guest kernels will attempt to access these regions with
>> with C-bit set, so guest_memfd is needed to handle that. Otherwise,
>> kvm_convert_memory() will fail when the guest kernel tries to access it
>> and QEMU attempts to call KVM_SET_MEMORY_ATTRIBUTES to set these ranges
>> to private.
>>
>> Whether guests should actually try to access ROM regions in this way (or
>> need to deal with legacy ROM regions at all), is a separate issue to be
>> addressed on kernel side, but current SNP guest kernels will exhibit
>> this behavior and so this handling is needed to allow QEMU to continue
>> running existing SNP guest kernels.
>>
>> Signed-off-by: Michael Roth <michael.roth@amd.com>
>> ---
>>   hw/i386/pc.c       | 13 +++++++++----
>>   hw/i386/pc_sysfw.c | 13 ++++++++++---
>>   2 files changed, 19 insertions(+), 7 deletions(-)
>>
>> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
>> index feb7a93083..5feaeb43ee 100644
>> --- a/hw/i386/pc.c
>> +++ b/hw/i386/pc.c
>> @@ -1011,10 +1011,15 @@ void pc_memory_init(PCMachineState *pcms,
>>       pc_system_firmware_init(pcms, rom_memory);
>>   
>>       option_rom_mr = g_malloc(sizeof(*option_rom_mr));
>> -    memory_region_init_ram(option_rom_mr, NULL, "pc.rom", PC_ROM_SIZE,
>> -                           &error_fatal);
>> -    if (pcmc->pci_enabled) {
>> -        memory_region_set_readonly(option_rom_mr, true);
>> +    if (machine_require_guest_memfd(machine)) {
>> +        memory_region_init_ram_guest_memfd(option_rom_mr, NULL, "pc.rom",
>> +                                           PC_ROM_SIZE, &error_fatal);
>> +    } else {
>> +        memory_region_init_ram(option_rom_mr, NULL, "pc.rom", PC_ROM_SIZE,
>> +                               &error_fatal);
>> +        if (pcmc->pci_enabled) {
>> +            memory_region_set_readonly(option_rom_mr, true);
>> +        }
>>       }
>>       memory_region_add_subregion_overlap(rom_memory,
>>                                           PC_ROM_MIN_VGA,
>> diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
>> index 9dbb3f7337..850f86edd4 100644
>> --- a/hw/i386/pc_sysfw.c
>> +++ b/hw/i386/pc_sysfw.c
>> @@ -54,8 +54,13 @@ static void pc_isa_bios_init(MemoryRegion *rom_memory,
>>       /* map the last 128KB of the BIOS in ISA space */
>>       isa_bios_size = MIN(flash_size, 128 * KiB);
>>       isa_bios = g_malloc(sizeof(*isa_bios));
>> -    memory_region_init_ram(isa_bios, NULL, "isa-bios", isa_bios_size,
>> -                           &error_fatal);
>> +    if (machine_require_guest_memfd(current_machine)) {
>> +        memory_region_init_ram_guest_memfd(isa_bios, NULL, "isa-bios",
>> +                                           isa_bios_size, &error_fatal);
>> +    } else {
>> +        memory_region_init_ram(isa_bios, NULL, "isa-bios", isa_bios_size,
>> +                               &error_fatal);
>> +    }
>>       memory_region_add_subregion_overlap(rom_memory,
>>                                           0x100000 - isa_bios_size,
>>                                           isa_bios,
>> @@ -68,7 +73,9 @@ static void pc_isa_bios_init(MemoryRegion *rom_memory,
>>              ((uint8_t*)flash_ptr) + (flash_size - isa_bios_size),
>>              isa_bios_size);
>>   
>> -    memory_region_set_readonly(isa_bios, true);
>> +    if (!machine_require_guest_memfd(current_machine)) {
>> +        memory_region_set_readonly(isa_bios, true);
>> +    }
>>   }
>>   
>>   static PFlashCFI01 *pc_pflash_create(PCMachineState *pcms,
>> -- 
>> 2.25.1
>>
>>
> 


