Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2275CA0EFA
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Aug 2025 07:36:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqoCz-0003l4-OO; Tue, 26 Aug 2025 03:35:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uqoCx-0003jy-B2
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 03:35:07 -0400
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uqoCr-0005pn-U4
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 03:35:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756193703; x=1787729703;
 h=message-id:date:mime-version:subject:to:references:from:
 in-reply-to:content-transfer-encoding;
 bh=3NptOdMiIKrbC7blk59uavM4sJ8ZqjB9x54KtTymCOA=;
 b=RCetJhqiBnot4yrPUMcJF1cmvx0aaU7iRhIPO7E5Jl2we3Wxzlpu+Mqy
 T7/6bL2dMoadf1vdFGQ54CdIYLEDxLwWrZODVmERjhm8eAoLD/gf8o+1v
 E2BUjKEKCIzOWKmOLNgi9uFTXwhd6M/Cbz6+UfF/LQKg1mKHvz3Uf6roE
 O4iS25IcOTKs3Yx+YSLAnLvDCIBdsrg1aFONUo5utu5XFCA/8O6zflIwO
 KTxw+TowJXXu7F5GMr3xPdRFzRTLeRlKEp44o0lc2kF8ny/7Ika2OiuEF
 6x85L+1xeucu0mNgk3ZDBNC7aDoZ1I/lpKr2TdlSZazDSZ7XQMnXTs3ub A==;
X-CSE-ConnectionGUID: tt4rYKQCRWWKifLTafI+Xg==
X-CSE-MsgGUID: PCZfO9/9SFWSoR9eKy9b1g==
X-IronPort-AV: E=McAfee;i="6800,10657,11533"; a="69520028"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; d="scan'208";a="69520028"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Aug 2025 00:34:53 -0700
X-CSE-ConnectionGUID: RHCbwVUNSw6Y7/WAIAdmew==
X-CSE-MsgGUID: B/qvpcO+S8+2OTGvGaQ9QA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; d="scan'208";a="173904256"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.238.14])
 ([10.124.238.14])
 by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Aug 2025 00:34:49 -0700
Message-ID: <eb34b160-4638-487e-bb7b-d0cbeabe4faa@intel.com>
Date: Tue, 26 Aug 2025 15:34:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 03/19] hw/i386/pc_piix.c: inline pc_xen_hvm_init_pci()
 into pc_xen_hvm_init()
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>, pbonzini@redhat.com,
 mst@redhat.com, marcel.apfelbaum@gmail.com, eduardo@habkost.net,
 imammedo@redhat.com, qemu-devel@nongnu.org
References: <20250822121342.894223-1-mark.caveayland@nutanix.com>
 <20250822121342.894223-4-mark.caveayland@nutanix.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20250822121342.894223-4-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
> This helps to simplify the initialisation of the Xen hvm machine.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

> ---
>   hw/i386/pc_piix.c | 13 ++++---------
>   1 file changed, 4 insertions(+), 9 deletions(-)
> 
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index bc8fbe46a1..071bf7412e 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -453,14 +453,6 @@ static void pc_init_isa(MachineState *machine)
>   #endif
>   
>   #ifdef CONFIG_XEN
> -static void pc_xen_hvm_init_pci(MachineState *machine)
> -{
> -    const char *pci_type = xen_igd_gfx_pt_enabled() ?
> -                TYPE_IGD_PASSTHROUGH_I440FX_PCI_DEVICE : TYPE_I440FX_PCI_DEVICE;
> -
> -    pc_init1(machine, pci_type);
> -}
> -
>   static void pc_xen_hvm_init(MachineState *machine)
>   {
>       PCMachineState *pcms = PC_MACHINE(machine);
> @@ -470,7 +462,10 @@ static void pc_xen_hvm_init(MachineState *machine)
>           exit(1);
>       }
>   
> -    pc_xen_hvm_init_pci(machine);
> +    pc_init1(machine, xen_igd_gfx_pt_enabled()
> +                      ? TYPE_IGD_PASSTHROUGH_I440FX_PCI_DEVICE
> +                      : TYPE_I440FX_PCI_DEVICE);
> +
>       xen_igd_reserve_slot(pcms->pcibus);
>       pci_create_simple(pcms->pcibus, -1, "xen-platform");
>   }


