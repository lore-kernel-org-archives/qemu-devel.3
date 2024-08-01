Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7264EC3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 09:52:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZSTw-0001mH-1Y; Thu, 01 Aug 2024 05:52:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=3ESM=PA=kaod.org=clg@ozlabs.org>)
 id 1sZSTu-0001ky-Ne; Thu, 01 Aug 2024 05:52:22 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=3ESM=PA=kaod.org=clg@ozlabs.org>)
 id 1sZSTs-0004NM-K6; Thu, 01 Aug 2024 05:52:22 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4WZPQ753dMz4wx5;
 Thu,  1 Aug 2024 19:52:15 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4WZPQ40y5Lz4w2R;
 Thu,  1 Aug 2024 19:52:11 +1000 (AEST)
Message-ID: <e376f6ce-4ade-455b-853b-270172317437@kaod.org>
Date: Thu, 1 Aug 2024 11:52:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hw/ppc: Implement -dtb support for PowerNV
To: Aditya Gupta <adityag@linux.ibm.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
References: <20240801085133.59781-1-adityag@linux.ibm.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240801085133.59781-1-adityag@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=3ESM=PA=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 8/1/24 10:51, Aditya Gupta wrote:
> Currently any device tree passed with -dtb option in QEMU, was ignored
> by the PowerNV code.
> 
> Read and pass the passed -dtb to the kernel, thus enabling easier
> debugging with custom DTBs.
> 
> The existing behaviour when -dtb is 'not' passed, is preserved as-is.
> 
> But when a '-dtb' is passed, it completely overrides any dtb nodes or
> changes QEMU might have done, such as '-append' arguments to the kernel
> (which are mentioned in /chosen/bootargs in the dtb), hence add warning
> when -dtb is being used
> 
> Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
> 
> ---
> Changelog
> ===========
> v2:
>   + move reading dtb and warning to pnv_init
> 
> v1:
>   + use 'g_file_get_contents' and add check for -append & -dtb as suggested by Daniel
> ---
> ---
>   hw/ppc/pnv.c         | 29 ++++++++++++++++++++++++++---
>   include/hw/ppc/pnv.h |  2 ++
>   2 files changed, 28 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index 3526852685b4..047725bd97fc 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -736,11 +736,14 @@ static void pnv_reset(MachineState *machine, ShutdownCause reason)
>           }
>       }
>   
> -    fdt = pnv_dt_create(machine);
> +    if (!pnv->fdt) {
> +        pnv->fdt = pnv_dt_create(machine);

At next reset, the dtb specified on the command line will be ignored.
Please reverse the logic :

     if (pnv->fdt) {
         fdt = pnv->fdt;
     } else {
         fdt = pnv_dt_create(machine);
         /* Pack resulting tree */
         _FDT((fdt_pack(fdt)));
     }

but, at the end of pnv_reset(), beware of :

     g_free(machine->fdt);
     machine->fdt = fdt;


> -    /* Pack resulting tree */
> -    _FDT((fdt_pack(fdt)));
> +        /* Pack resulting tree */
> +        _FDT((fdt_pack(pnv->fdt)));
> +    }
>   
> +    fdt = pnv->fdt;
>       qemu_fdt_dumpdtb(fdt, fdt_totalsize(fdt));
>       cpu_physical_memory_write(PNV_FDT_ADDR, fdt, fdt_totalsize(fdt));
>   
> @@ -952,6 +955,14 @@ static void pnv_init(MachineState *machine)
>           g_free(sz);
>           exit(EXIT_FAILURE);
>       }
> +
> +    /* checks for invalid option combinations */
> +    if (machine->dtb && (strlen(machine->kernel_cmdline) != 0)) {
> +        error_report("-append and -dtb cannot be used together, as passed"
> +                " command line is ignored in case of custom dtb");
> +        exit(EXIT_FAILURE);

I think this is redundant with the warn report below.

> +    }
> +
>       memory_region_add_subregion(get_system_memory(), 0, machine->ram);
>   
>       /*
> @@ -1003,6 +1014,18 @@ static void pnv_init(MachineState *machine)
>           }
>       }
>   
> +    /* load dtb if passed */
> +    if (machine->dtb) {
> +        warn_report("with manually passed dtb, some options like '-append'"
> +                " will get ignored and the dtb passed will be used as-is");
> +
> +        /* read the file 'machine->dtb', and load it into 'fdt' buffer */
> +        if (!g_file_get_contents(machine->dtb, (gchar **)&pnv->fdt, NULL, NULL)) {
> +            error_report("Could not load dtb '%s'", machine->dtb);
> +            exit(1);
> +        }

There is a load_device_tree() routine you could use. Please check how other
machines handle -dtb for examples.


Thanks,

C.



> +    }
> +
>       /* MSIs are supported on this platform */
>       msi_nonbroken = true;
>   
> diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
> index fcb6699150c8..20b68fd9264e 100644
> --- a/include/hw/ppc/pnv.h
> +++ b/include/hw/ppc/pnv.h
> @@ -91,6 +91,8 @@ struct PnvMachineState {
>       uint32_t     initrd_base;
>       long         initrd_size;
>   
> +    void         *fdt;
> +
>       uint32_t     num_chips;
>       PnvChip      **chips;
>   


