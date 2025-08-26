Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4819CA0EFA
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Aug 2025 10:02:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqqUU-0005lY-KJ; Tue, 26 Aug 2025 06:01:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uqqUR-0005jF-FR
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 06:01:19 -0400
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uqqUO-0003xt-97
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 06:01:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756202476; x=1787738476;
 h=message-id:date:mime-version:subject:to:references:from:
 in-reply-to:content-transfer-encoding;
 bh=6dNg018JeVmQ9Jl7WyWvmqP6YPSMqRUhp1lDY78i5gQ=;
 b=ByRJuT7Q5aYLqK8LcJvevFVrgt+rkYqUW5IYSyB6RZR9B9F10oi/YZsp
 LWOhqcsjY7lzYLL6HADtW64UaNyS6ljgEWhIQyDmw4auYOVIQKX2c9Fzf
 2GzmqbNXRA1rjxTrM0tUbWXyfqhJxfEH/Fj6FZcEjMdGwQgysIrIVeg4C
 jJ2rs3pDkemW731qF694Y3jprkAbiVXfdqYS29uyTrumLs7CyO6WyhX5w
 KjYxR51us3fpOWSsiI5NKy3CteMAFGcsjSnq2x1As7AExXIvzWHZkZMPk
 vp2YYyQ3DBLZx1/mIYHicphNIUvH3UBAsYe9w1eEYrOFZ/7Z/6JyZkB7V Q==;
X-CSE-ConnectionGUID: cMVH00B2RlerF5yozfrtDw==
X-CSE-MsgGUID: hDRJLVszRseF5cEmKhE3gg==
X-IronPort-AV: E=McAfee;i="6800,10657,11533"; a="69530572"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; d="scan'208";a="69530572"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Aug 2025 03:01:12 -0700
X-CSE-ConnectionGUID: /jdEgfBoQV+k9dnHwvd17A==
X-CSE-MsgGUID: zf0IxCPmTA6bXTp4U6+ZJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; d="scan'208";a="193206363"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.238.14])
 ([10.124.238.14])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Aug 2025 03:01:09 -0700
Message-ID: <7fa8968e-c584-4441-8859-a40788067e95@intel.com>
Date: Tue, 26 Aug 2025 18:01:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 09/19] hw/i386/pc_piix.c: simplify RAM size logic in
 pc_init_isa()
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>, pbonzini@redhat.com,
 mst@redhat.com, marcel.apfelbaum@gmail.com, eduardo@habkost.net,
 imammedo@redhat.com, qemu-devel@nongnu.org
References: <20250822121342.894223-1-mark.caveayland@nutanix.com>
 <20250822121342.894223-10-mark.caveayland@nutanix.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20250822121342.894223-10-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=198.175.65.13; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.703, RCVD_IN_DNSWL_MED=-2.3,
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

On 8/22/2025 8:11 PM, Mark Cave-Ayland wrote:
> All isapc machines must have 32-bit CPUs and so the RAM split logic can be hardcoded
> accordingly.
> 
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> ---
>   hw/i386/pc_piix.c | 58 ++++-------------------------------------------
>   1 file changed, 4 insertions(+), 54 deletions(-)
> 
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index 816124c027..fc94937ad4 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -444,69 +444,19 @@ static void pc_init_isa(MachineState *machine)
>       GSIState *gsi_state;
>       MemoryRegion *ram_memory;
>       MemoryRegion *rom_memory = system_memory;
> -    ram_addr_t lowmem;
>       uint64_t hole64_size = 0;
>   
>       /*
> -     * Calculate ram split, for memory below and above 4G.  It's a bit
> -     * complicated for backward compatibility reasons ...
> -     *
> -     *  - Traditional split is 3.5G (lowmem = 0xe0000000).  This is the
> -     *    default value for max_ram_below_4g now.
> -     *
> -     *  - Then, to gigabyte align the memory, we move the split to 3G
> -     *    (lowmem = 0xc0000000).  But only in case we have to split in
> -     *    the first place, i.e. ram_size is larger than (traditional)
> -     *    lowmem.  And for new machine types (gigabyte_align = true)
> -     *    only, for live migration compatibility reasons.
> -     *
> -     *  - Next the max-ram-below-4g option was added, which allowed to
> -     *    reduce lowmem to a smaller value, to allow a larger PCI I/O
> -     *    window below 4G.  qemu doesn't enforce gigabyte alignment here,
> -     *    but prints a warning.
> -     *
> -     *  - Finally max-ram-below-4g got updated to also allow raising lowmem,
> -     *    so legacy non-PAE guests can get as much memory as possible in
> -     *    the 32bit address space below 4G.
> -     *
> -     *  - Note that Xen has its own ram setup code in xen_ram_init(),
> -     *    called via xen_hvm_init_pc().
> -     *
> -     * Examples:
> -     *    qemu -M pc-1.7 -m 4G    (old default)    -> 3584M low,  512M high
> -     *    qemu -M pc -m 4G        (new default)    -> 3072M low, 1024M high
> -     *    qemu -M pc,max-ram-below-4g=2G -m 4G     -> 2048M low, 2048M high
> -     *    qemu -M pc,max-ram-below-4g=4G -m 3968M  -> 3968M low (=4G-128M)
> +     * There is no RAM split for the isapc machine
>        */
>       if (xen_enabled()) {
>           xen_hvm_init_pc(pcms, &ram_memory);
>       } else {
>           ram_memory = machine->ram;
> -        if (!pcms->max_ram_below_4g) {
> -            pcms->max_ram_below_4g = 0xe0000000; /* default: 3.5G */
> -        }
> -        lowmem = pcms->max_ram_below_4g;
> -        if (machine->ram_size >= pcms->max_ram_below_4g) {
> -            if (pcmc->gigabyte_align) {
> -                if (lowmem > 0xc0000000) {
> -                    lowmem = 0xc0000000;
> -                }
> -                if (lowmem & (1 * GiB - 1)) {
> -                    warn_report("Large machine and max_ram_below_4g "
> -                                "(%" PRIu64 ") not a multiple of 1G; "
> -                                "possible bad performance.",
> -                                pcms->max_ram_below_4g);
> -                }
> -            }
> -        }
>   
> -        if (machine->ram_size >= lowmem) {
> -            x86ms->above_4g_mem_size = machine->ram_size - lowmem;
> -            x86ms->below_4g_mem_size = lowmem;
> -        } else {
> -            x86ms->above_4g_mem_size = 0;
> -            x86ms->below_4g_mem_size = machine->ram_size;
> -        }
> +        pcms->max_ram_below_4g = 4 * GiB;
> +        x86ms->above_4g_mem_size = 0;
> +        x86ms->below_4g_mem_size = machine->ram_size;

I think we need to sanity check the machine->ram_size is not bigger than 
4G, and error out if it exceeds.

>       }
>   
>       /*


