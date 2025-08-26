Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94E76CA0EFA
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Aug 2025 12:03:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqsO1-0004yP-3Z; Tue, 26 Aug 2025 08:02:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uqsNU-0004h9-08
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 08:02:17 -0400
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uqsNG-0004yg-Kg
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 08:02:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756209723; x=1787745723;
 h=message-id:date:mime-version:subject:to:references:from:
 in-reply-to:content-transfer-encoding;
 bh=Xyqvcx+jTtR+9ArkL5X/t4vwFMaPEwI+C4KL/CX8rzc=;
 b=GvpfKAWMNDSfSkjDSypU+dMy74F0t1XSOEcICoHafIXi2eR7M5tyILz2
 2kidh+yyoijo0zkQF6nObxIFz1ojXWpE6fB0VI37estMRGo5vogVY4fl3
 +Ph9Ttt0zR1ATTkB7PV1ud3Zi80YXM00sxR+u89LGbweLE+5dlQpibJao
 FsqxR/ljI5IZDsGqoAhvvGvA3oIViju7GWsM5ImmsPZicjs1ka0cVmpeg
 aXMzXun0S1KgVv4vqxQrASino4cZWEHdDEkfy+ftAia76wOFpsPosZtli
 /EHYF4JJ3OX7mSs8nEol08Ey5XrKxMMrefJA6KIRc6DSZ6rdRAtIFFJup g==;
X-CSE-ConnectionGUID: bMICxHwCS1asvm5R64uB6A==
X-CSE-MsgGUID: n0+S4DuQRICIyJB8GnY24g==
X-IronPort-AV: E=McAfee;i="6800,10657,11533"; a="62086273"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; d="scan'208";a="62086273"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Aug 2025 05:01:52 -0700
X-CSE-ConnectionGUID: 0dNb/YMcQg+W/OmBpWnSVQ==
X-CSE-MsgGUID: tTB2Qj5hQ8W/fD7Gd+0VTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; d="scan'208";a="174863469"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.238.14])
 ([10.124.238.14])
 by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Aug 2025 05:01:51 -0700
Message-ID: <a3ce7fb5-8cce-4e87-a9db-8eb047ee79a1@intel.com>
Date: Tue, 26 Aug 2025 20:01:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 12/19] hw/i386/pc_piix.c: always initialise ISA IDE
 drives in pc_init_isa()
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>, pbonzini@redhat.com,
 mst@redhat.com, marcel.apfelbaum@gmail.com, eduardo@habkost.net,
 imammedo@redhat.com, qemu-devel@nongnu.org
References: <20250822121342.894223-1-mark.caveayland@nutanix.com>
 <20250822121342.894223-13-mark.caveayland@nutanix.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20250822121342.894223-13-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.15; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.751, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
> By definition an isapc machine must always use ISA IDE drives so ensure that they
> are always enabled. At the same time also remove the surrounding CONFIG_IDE_ISA
> define since it will be enabled via the ISAPC Kconfig.
> 
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

> ---
>   hw/i386/pc_piix.c | 35 +++++++++++++++--------------------
>   1 file changed, 15 insertions(+), 20 deletions(-)
> 
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index bbd5f9d17f..924888b59d 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -444,6 +444,8 @@ static void pc_init_isa(MachineState *machine)
>       GSIState *gsi_state;
>       MemoryRegion *ram_memory;
>       MemoryRegion *rom_memory = system_memory;
> +    DriveInfo *hd[MAX_IDE_BUS * MAX_IDE_DEVS];
> +    int i;
>   
>       /*
>        * There is no RAM split for the isapc machine
> @@ -519,27 +521,20 @@ static void pc_init_isa(MachineState *machine)
>   
>       pc_nic_init(pcmc, isa_bus, pcms->pcibus);
>   
> -#ifdef CONFIG_IDE_ISA
> -    if (!pcmc->pci_enabled) {
> -        DriveInfo *hd[MAX_IDE_BUS * MAX_IDE_DEVS];
> -        int i;
> -
> -        ide_drive_get(hd, ARRAY_SIZE(hd));
> -        for (i = 0; i < MAX_IDE_BUS; i++) {
> -            ISADevice *dev;
> -            char busname[] = "ide.0";
> -            dev = isa_ide_init(isa_bus, ide_iobase[i], ide_iobase2[i],
> -                               ide_irq[i],
> -                               hd[MAX_IDE_DEVS * i], hd[MAX_IDE_DEVS * i + 1]);
> -            /*
> -             * The ide bus name is ide.0 for the first bus and ide.1 for the
> -             * second one.
> -             */
> -            busname[4] = '0' + i;
> -            pcms->idebus[i] = qdev_get_child_bus(DEVICE(dev), busname);
> -        }
> +    ide_drive_get(hd, ARRAY_SIZE(hd));
> +    for (i = 0; i < MAX_IDE_BUS; i++) {
> +        ISADevice *dev;
> +        char busname[] = "ide.0";
> +        dev = isa_ide_init(isa_bus, ide_iobase[i], ide_iobase2[i],
> +                            ide_irq[i],
> +                            hd[MAX_IDE_DEVS * i], hd[MAX_IDE_DEVS * i + 1]);
> +        /*
> +         * The ide bus name is ide.0 for the first bus and ide.1 for the
> +         * second one.
> +         */
> +        busname[4] = '0' + i;
> +        pcms->idebus[i] = qdev_get_child_bus(DEVICE(dev), busname);
>       }
> -#endif
>   }
>   #endif
>   


