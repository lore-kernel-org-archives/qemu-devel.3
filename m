Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B729CA0EFA
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Aug 2025 12:12:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqsX8-0000tr-UZ; Tue, 26 Aug 2025 08:12:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uqsWy-0000nN-Bi
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 08:12:05 -0400
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uqsWr-0006ep-6R
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 08:12:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756210318; x=1787746318;
 h=message-id:date:mime-version:subject:to:references:from:
 in-reply-to:content-transfer-encoding;
 bh=G+pLKu8WV8bcqwAgccfWml6Upyx38cO1+9hKJJzif3g=;
 b=Gi7HNw0tIi7WTbuwrst7bFQeVytBFWGMosX3EIVBQ+m6wieiXpKEbHvr
 45H1gMl6CMvYUYgVFLanppEUt/FatsTRonBEYe2imOIMgC8MrEOdZayzR
 N0xD4SS/K7d2gvMv1GUUF+4RziWrIzmrZtcyWVX1GEZ6uW3aerZwJhn5J
 eIdGpPhBPIi0r6RBlAIy+ajnC9HjnGjBGQ+AmN0IQvvGbI4lVopbZFYsN
 eUeLY4XQnHdo4MCed2wdRW0OJKIWgH2dhLOqQhGql4y+cfFb7/wkvN1qC
 Mr2OXbD+mSCN2qtSRHBJAYWRT854QH/xJlGfk/NAkueCdE/WI//MeYx9D g==;
X-CSE-ConnectionGUID: 4W28W4nXRESg8/b/+FSUUA==
X-CSE-MsgGUID: T3vKgeolSk+9qaom+h4xZA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="62274802"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; d="scan'208";a="62274802"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Aug 2025 05:11:54 -0700
X-CSE-ConnectionGUID: npwiF/UbSMKK1LBR/xBptg==
X-CSE-MsgGUID: 7YdWjn1/RkqtTOYdWLh7ig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; d="scan'208";a="206723683"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.238.14])
 ([10.124.238.14])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Aug 2025 05:11:52 -0700
Message-ID: <990a1867-1bee-4835-b6a3-9e177c0ee98f@intel.com>
Date: Tue, 26 Aug 2025 20:11:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 18/19] hw/i386/pc_piix.c: replace rom_memory with
 pci_memory
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>, pbonzini@redhat.com,
 mst@redhat.com, marcel.apfelbaum@gmail.com, eduardo@habkost.net,
 imammedo@redhat.com, qemu-devel@nongnu.org
References: <20250822121342.894223-1-mark.caveayland@nutanix.com>
 <20250822121342.894223-19-mark.caveayland@nutanix.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20250822121342.894223-19-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.14; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.751, RCVD_IN_DNSWL_MED=-2.3,
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

On 8/22/2025 8:12 PM, Mark Cave-Ayland wrote:
> Now that we can guarantee the i440fx-pc machine will always have a PCI bus, any
> instances of rom_memory can be replaced by pci_memory and rom_memory removed
> completely.
> 
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

> ---
>   hw/i386/pc_piix.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index 5babdc3e4c..b736f0f236 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -113,7 +113,6 @@ static void pc_init1(MachineState *machine, const char *pci_type)
>       GSIState *gsi_state;
>       MemoryRegion *ram_memory;
>       MemoryRegion *pci_memory = NULL;
> -    MemoryRegion *rom_memory = system_memory;
>       ram_addr_t lowmem;
>       uint64_t hole64_size = 0;
>       PCIDevice *pci_dev;
> @@ -191,7 +190,6 @@ static void pc_init1(MachineState *machine, const char *pci_type)
>   
>       pci_memory = g_new(MemoryRegion, 1);
>       memory_region_init(pci_memory, NULL, "pci", UINT64_MAX);
> -    rom_memory = pci_memory;
>   
>       phb = OBJECT(qdev_new(TYPE_I440FX_PCI_HOST_BRIDGE));
>       object_property_add_child(OBJECT(machine), "i440fx", phb);
> @@ -222,7 +220,7 @@ static void pc_init1(MachineState *machine, const char *pci_type)
>   
>       /* allocate ram and load rom/bios */
>       if (!xen_enabled()) {
> -        pc_memory_init(pcms, system_memory, rom_memory, hole64_size);
> +        pc_memory_init(pcms, system_memory, pci_memory, hole64_size);
>       } else {
>           assert(machine->ram_size == x86ms->below_4g_mem_size +
>                                       x86ms->above_4g_mem_size);


