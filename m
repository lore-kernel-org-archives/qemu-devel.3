Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1AB2C54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 18:13:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rn0Qr-00053C-Rh; Wed, 20 Mar 2024 14:12:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <isaku.yamahata@intel.com>)
 id 1rn0Qn-00052F-Ge
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 14:12:54 -0400
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <isaku.yamahata@intel.com>)
 id 1rn0QQ-0000ac-F1
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 14:12:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1710958351; x=1742494351;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=Vnbag9q3xQRvF0qzbjgLy7tYXm8Ph98PFJ3DvYqpeYA=;
 b=PhnYYZ/fd7zBS6E2wL44Ufz0sqC3+7PoOI9Ifut0zE8OweCVZ+PiVppl
 dS4bdBsEvoNrE3diYJ3kl/pnaJqOYiPKH5pOrda8mh6oRavl2bT1lxKsP
 NQNN3HKx+chjjG6tsb+X4KurJd+lwwXEC3TzAPP+71S1rhhnCo+t1TS+A
 Cp9TJBg/rbjgfFjCUAzTSFE7cXLXOddk7fsvTiIRArvXB2Ha0uUiRw8Uz
 XLQ1tP2u+YTHElprM4zas30QXslIKpVihvJptFJpT0k5TplMyIJBvj9Mf
 +tV9iwcb7LDyiAY6tkQOIlgddm1FHiT9W2j1JZMkTDlJuHT1QhHsKnimh w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11019"; a="9697215"
X-IronPort-AV: E=Sophos;i="6.07,140,1708416000"; 
   d="scan'208";a="9697215"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Mar 2024 11:12:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,140,1708416000"; d="scan'208";a="14142999"
Received: from ls.sc.intel.com (HELO localhost) ([172.25.112.31])
 by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Mar 2024 11:12:24 -0700
Date: Wed, 20 Mar 2024 11:12:23 -0700
From: Isaku Yamahata <isaku.yamahata@intel.com>
To: Michael Roth <michael.roth@amd.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Tom Lendacky <thomas.lendacky@amd.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Pankaj Gupta <pankaj.gupta@amd.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>,
 Isaku Yamahata <isaku.yamahata@linux.intel.com>, isaku.yamahata@intel.com
Subject: Re: [PATCH v3 48/49] hw/i386/sev: Use guest_memfd for legacy ROMs
Message-ID: <20240320181223.GG1994522@ls.amr.corp.intel.com>
References: <20240320083945.991426-1-michael.roth@amd.com>
 <20240320083945.991426-49-michael.roth@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240320083945.991426-49-michael.roth@amd.com>
Received-SPF: pass client-ip=198.175.65.15;
 envelope-from=isaku.yamahata@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.417,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Wed, Mar 20, 2024 at 03:39:44AM -0500,
Michael Roth <michael.roth@amd.com> wrote:

> TODO: make this SNP-specific if TDX disables legacy ROMs in general

TDX disables pc.rom, not disable isa-bios. IIRC, TDX doesn't need pc pflash.
Xiaoyao can chime in.

Thanks,

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
> ---
>  hw/i386/pc.c       | 13 +++++++++----
>  hw/i386/pc_sysfw.c | 13 ++++++++++---
>  2 files changed, 19 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index feb7a93083..5feaeb43ee 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -1011,10 +1011,15 @@ void pc_memory_init(PCMachineState *pcms,
>      pc_system_firmware_init(pcms, rom_memory);
>  
>      option_rom_mr = g_malloc(sizeof(*option_rom_mr));
> -    memory_region_init_ram(option_rom_mr, NULL, "pc.rom", PC_ROM_SIZE,
> -                           &error_fatal);
> -    if (pcmc->pci_enabled) {
> -        memory_region_set_readonly(option_rom_mr, true);
> +    if (machine_require_guest_memfd(machine)) {
> +        memory_region_init_ram_guest_memfd(option_rom_mr, NULL, "pc.rom",
> +                                           PC_ROM_SIZE, &error_fatal);
> +    } else {
> +        memory_region_init_ram(option_rom_mr, NULL, "pc.rom", PC_ROM_SIZE,
> +                               &error_fatal);
> +        if (pcmc->pci_enabled) {
> +            memory_region_set_readonly(option_rom_mr, true);
> +        }
>      }
>      memory_region_add_subregion_overlap(rom_memory,
>                                          PC_ROM_MIN_VGA,
> diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
> index 9dbb3f7337..850f86edd4 100644
> --- a/hw/i386/pc_sysfw.c
> +++ b/hw/i386/pc_sysfw.c
> @@ -54,8 +54,13 @@ static void pc_isa_bios_init(MemoryRegion *rom_memory,
>      /* map the last 128KB of the BIOS in ISA space */
>      isa_bios_size = MIN(flash_size, 128 * KiB);
>      isa_bios = g_malloc(sizeof(*isa_bios));
> -    memory_region_init_ram(isa_bios, NULL, "isa-bios", isa_bios_size,
> -                           &error_fatal);
> +    if (machine_require_guest_memfd(current_machine)) {
> +        memory_region_init_ram_guest_memfd(isa_bios, NULL, "isa-bios",
> +                                           isa_bios_size, &error_fatal);
> +    } else {
> +        memory_region_init_ram(isa_bios, NULL, "isa-bios", isa_bios_size,
> +                               &error_fatal);
> +    }
>      memory_region_add_subregion_overlap(rom_memory,
>                                          0x100000 - isa_bios_size,
>                                          isa_bios,
> @@ -68,7 +73,9 @@ static void pc_isa_bios_init(MemoryRegion *rom_memory,
>             ((uint8_t*)flash_ptr) + (flash_size - isa_bios_size),
>             isa_bios_size);
>  
> -    memory_region_set_readonly(isa_bios, true);
> +    if (!machine_require_guest_memfd(current_machine)) {
> +        memory_region_set_readonly(isa_bios, true);
> +    }
>  }
>  
>  static PFlashCFI01 *pc_pflash_create(PCMachineState *pcms,
> -- 
> 2.25.1
> 
> 

-- 
Isaku Yamahata <isaku.yamahata@intel.com>

