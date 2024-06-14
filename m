Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F7C4C27C75
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2024 08:58:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sI2lE-00082e-9v; Fri, 14 Jun 2024 04:58:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1sI2lA-00081x-NT
 for qemu-devel@nongnu.org; Fri, 14 Jun 2024 04:58:12 -0400
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1sI2l7-0000I3-Md
 for qemu-devel@nongnu.org; Fri, 14 Jun 2024 04:58:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1718355489; x=1749891489;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=ZkPLu1HSLwVqyFvZ09LNN8JNPb4JfA5nMv9opMuXQrc=;
 b=lMAekFkMuYGTRt+rR76Gw42u5GyfDhzGu+MTS74F87Enx45lJCbRdckq
 nfohQ49NLBW8y8O600PtjP3m6qbAy7btKguHjWic7KUAA9eJdQWRA3/Lt
 bKgHYmKMOL7SkxctV8FZcfzMHsULYOjRkniq+TGgFsFiiDHepUhTgMhKx
 1A2UepNe34i9NR4Wb77z9cYGIhlkVEG091ezGxgLu1LSUsUhEqijwGo5c
 iv+mzHkjUEyc0KhROf4p2/LumHYsc3fn13Rwi141SAc70bnS5f9POPGu8
 K7aLb693ir64wDTbLyjL3CELg6cWtMlS7bAnue+lFVfedcL1tRNRuhqP9 w==;
X-CSE-ConnectionGUID: zZL1AJXiRT2xCJazhR5Enw==
X-CSE-MsgGUID: YzPcVGWtSr6lLkIwMGLTUQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11102"; a="25906235"
X-IronPort-AV: E=Sophos;i="6.08,237,1712646000"; d="scan'208";a="25906235"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jun 2024 01:58:07 -0700
X-CSE-ConnectionGUID: Lu9ghrZNTEmZlzKrkO63zA==
X-CSE-MsgGUID: xiAXtWP7SMm0AuzF9KsU+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,237,1712646000"; d="scan'208";a="40539531"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.238.14])
 ([10.124.238.14])
 by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jun 2024 01:58:04 -0700
Message-ID: <ce895ad3-7a84-4af1-8927-6e85f60ef4f6@intel.com>
Date: Fri, 14 Jun 2024 16:58:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 27/31] hw/i386/sev: Use guest_memfd for legacy ROMs
To: Pankaj Gupta <pankaj.gupta@amd.com>, qemu-devel@nongnu.org
Cc: brijesh.singh@amd.com, dovmurik@linux.ibm.com, armbru@redhat.com,
 michael.roth@amd.com, pbonzini@redhat.com, thomas.lendacky@amd.com,
 isaku.yamahata@intel.com, berrange@redhat.com, kvm@vger.kernel.org,
 anisinha@redhat.com
References: <20240530111643.1091816-1-pankaj.gupta@amd.com>
 <20240530111643.1091816-28-pankaj.gupta@amd.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20240530111643.1091816-28-pankaj.gupta@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.198.163.9; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 5/30/2024 7:16 PM, Pankaj Gupta wrote:
> From: Michael Roth <michael.roth@amd.com>
> 
> Current SNP guest kernels will attempt to access these regions with
> with C-bit set, so guest_memfd is needed to handle that. Otherwise,
> kvm_convert_memory() will fail when the guest kernel tries to access it
> and QEMU attempts to call KVM_SET_MEMORY_ATTRIBUTES to set these ranges
> to private.
> 
> Whether guests should actually try to access ROM regions in this way (or
> need to deal with legacy ROM regions at all), is a separate issue to be
> addressed on kernel side, but current SNP guest kernels will exhibit
> this behavior and so this handling is needed to allow QEMU to continue
> running existing SNP guest kernels.
> 
> Signed-off-by: Michael Roth <michael.roth@amd.com>
> [pankaj: Added sev_snp_enabled() check]
> Signed-off-by: Pankaj Gupta <pankaj.gupta@amd.com>
> ---
>   hw/i386/pc.c       | 14 ++++++++++----
>   hw/i386/pc_sysfw.c | 13 ++++++++++---
>   2 files changed, 20 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 7b638da7aa..62c25ea1e9 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -62,6 +62,7 @@
>   #include "hw/mem/memory-device.h"
>   #include "e820_memory_layout.h"
>   #include "trace.h"
> +#include "sev.h"
>   #include CONFIG_DEVICES
>   
>   #ifdef CONFIG_XEN_EMU
> @@ -1022,10 +1023,15 @@ void pc_memory_init(PCMachineState *pcms,
>       pc_system_firmware_init(pcms, rom_memory);
>   
>       option_rom_mr = g_malloc(sizeof(*option_rom_mr));
> -    memory_region_init_ram(option_rom_mr, NULL, "pc.rom", PC_ROM_SIZE,
> -                           &error_fatal);
> -    if (pcmc->pci_enabled) {
> -        memory_region_set_readonly(option_rom_mr, true);
> +    if (sev_snp_enabled()) {
> +        memory_region_init_ram_guest_memfd(option_rom_mr, NULL, "pc.rom",
> +                                           PC_ROM_SIZE, &error_fatal);
> +    } else {
> +        memory_region_init_ram(option_rom_mr, NULL, "pc.rom", PC_ROM_SIZE,
> +                               &error_fatal);
> +        if (pcmc->pci_enabled) {
> +            memory_region_set_readonly(option_rom_mr, true);
> +        }
>       }
>       memory_region_add_subregion_overlap(rom_memory,
>                                           PC_ROM_MIN_VGA,
> diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
> index 00464afcb4..def77a442d 100644
> --- a/hw/i386/pc_sysfw.c
> +++ b/hw/i386/pc_sysfw.c
> @@ -51,8 +51,13 @@ static void pc_isa_bios_init(MemoryRegion *isa_bios, MemoryRegion *rom_memory,
>   
>       /* map the last 128KB of the BIOS in ISA space */
>       isa_bios_size = MIN(flash_size, 128 * KiB);
> -    memory_region_init_ram(isa_bios, NULL, "isa-bios", isa_bios_size,
> -                           &error_fatal);
> +    if (sev_snp_enabled()) {
> +        memory_region_init_ram_guest_memfd(isa_bios, NULL, "isa-bios",
> +                                           isa_bios_size, &error_fatal);
> +    } else {
> +        memory_region_init_ram(isa_bios, NULL, "isa-bios", isa_bios_size,
> +                               &error_fatal);
> +    }
>       memory_region_add_subregion_overlap(rom_memory,
>                                           0x100000 - isa_bios_size,
>                                           isa_bios,
> @@ -65,7 +70,9 @@ static void pc_isa_bios_init(MemoryRegion *isa_bios, MemoryRegion *rom_memory,
>              ((uint8_t*)flash_ptr) + (flash_size - isa_bios_size),
>              isa_bios_size);
>   
> -    memory_region_set_readonly(isa_bios, true);
> +    if (!machine_require_guest_memfd(current_machine)) {
> +        memory_region_set_readonly(isa_bios, true);
> +    }

This patch takes different approach than next patch that this patch 
chooses to not set readonly when require guest memfd while next patch 
skips the whole isa_bios setup for -bios case. Why make different 
handling for the two cases?

More importantly, with commit a44ea3fa7f2a,
pcmc->isa_bios_alias is default true for all new machine after 9.0, then 
pc_isa_bios_init() would be hit even on plash case. It will call 
x86_isa_bios_init() in pc_system_flash_map().

So with -bios case, the call site is

   pc_system_firmware_init()
      -> x86_bios_rom_init()
	-> x86_isa_bios_init()

   because require_guest_memfd is true for snp, x86_isa_bios_init() is 
not called.

However, with pflash case, the call site is

   pc_system_firmware_init()
      -> pc_system_flash_map()
	 -> if (pcmc->isa_bios_alias) {
                 x86_isa_bios_init();
             } else {
                 pc_isa_bios_init();
             }

As I said above, pcmc->isa_bios_alias is true for machine after 9.0, so 
it will goes x86_isa_bios_init().

So please anyone explain to me why x86_isa_bios_init() is ok for pflash 
case but not for -bios case?

>   }
>   
>   static PFlashCFI01 *pc_pflash_create(PCMachineState *pcms,


