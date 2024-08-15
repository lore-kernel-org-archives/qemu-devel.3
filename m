Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF2FEC52D7C
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2024 17:53:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seeeK-0007LA-UN; Thu, 15 Aug 2024 13:52:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=dF58=PO=kaod.org=clg@ozlabs.org>)
 id 1seeeI-0007Cw-Vq; Thu, 15 Aug 2024 13:52:34 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=dF58=PO=kaod.org=clg@ozlabs.org>)
 id 1seeeF-0004AH-L2; Thu, 15 Aug 2024 13:52:33 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4WlCPg1T5qz4x1V;
 Fri, 16 Aug 2024 03:52:23 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4WlCPb4Y1Mz4x1H;
 Fri, 16 Aug 2024 03:52:19 +1000 (AEST)
Message-ID: <6c0cdf26-9795-4998-9d80-1d0095700a59@kaod.org>
Date: Thu, 15 Aug 2024 19:52:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] hw/ppc: Implement -dtb support for PowerNV
To: Nicholas Piggin <npiggin@gmail.com>, Aditya Gupta
 <adityag@linux.ibm.com>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
References: <20240813134536.1204513-1-adityag@linux.ibm.com>
 <D3GB5QVADVQ1.XZM3FFV52LIW@gmail.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <D3GB5QVADVQ1.XZM3FFV52LIW@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=dF58=PO=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

On 8/15/24 09:31, Nicholas Piggin wrote:
> On Tue Aug 13, 2024 at 11:45 PM AEST, Aditya Gupta wrote:
>> Currently any device tree passed with -dtb option in QEMU, was ignored
>> by the PowerNV code.
>>
>> Read and pass the passed -dtb to the kernel, thus enabling easier
>> debugging with custom DTBs.
>>
>> The existing behaviour when -dtb is 'not' passed, is preserved as-is.
>>
>> But when a '-dtb' is passed, it completely overrides any dtb nodes or
>> changes QEMU might have done, such as '-append' arguments to the kernel
>> (which are mentioned in /chosen/bootargs in the dtb), hence add warning
>> when -dtb is being used
>>
>> Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
> 
> This looks pretty good, I'm inclined to take it as a bug fix fo this
> release.  

I don't think this is a bug fix. is it ? AFAIUI, it is a debug
feature for skiboot. It's QEMU 9.2 material.

> One little nit is MachineState.fdt vs PnvMachineState.fdt
> which is now confusing. I would call the new PnvMachineState member
> something like fdt_from_dtb, or fdt_override?

I agree. this is confusing. machine->fdt could be used instead ?
  
> The other question... Some machines rebuild fdt at init, others at
> reset time. As far as I understood, spapr has to rebuild on reset
> because C-A-S call can update the fdt so you have to undo that on
> reset. 

C-A-S is a guest OS hcall. reset is called before the guest OS
is started.

> Did powernv just copy that without really needing it, I wonder?
> Maybe that rearranged to just do it at init time (e.g., see
> hw/riscv/virt.c which is simpler).

The machine is aware of user created devices (on the command line)
only at reset time.

Thanks,

C.



  

> Thanks,
> Nick
> 
>>
>> ---
>> Changelog
>> ===========
>> v3:
>>   + use 'load_device_tree' to read the device tree, instead of g_file_get_contents
>>   + tested that passed dtb does NOT get ignored on system_reset
>>
>> v2:
>>   + move reading dtb and warning to pnv_init
>>
>> v1:
>>   + use 'g_file_get_contents' and add check for -append & -dtb as suggested by Daniel
>> ---
>> ---
>>   hw/ppc/pnv.c         | 34 ++++++++++++++++++++++++++++++----
>>   include/hw/ppc/pnv.h |  2 ++
>>   2 files changed, 32 insertions(+), 4 deletions(-)
>>
>> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
>> index 3526852685b4..14225f7e48af 100644
>> --- a/hw/ppc/pnv.c
>> +++ b/hw/ppc/pnv.c
>> @@ -736,10 +736,13 @@ static void pnv_reset(MachineState *machine, ShutdownCause reason)
>>           }
>>       }
>>   
>> -    fdt = pnv_dt_create(machine);
>> -
>> -    /* Pack resulting tree */
>> -    _FDT((fdt_pack(fdt)));
>> +    if (pnv->fdt) {
>> +        fdt = pnv->fdt;
>> +    } else {
>> +        fdt = pnv_dt_create(machine);
>> +        /* Pack resulting tree */
>> +        _FDT((fdt_pack(fdt)));
>> +    }
>>   
>>       qemu_fdt_dumpdtb(fdt, fdt_totalsize(fdt));
>>       cpu_physical_memory_write(PNV_FDT_ADDR, fdt, fdt_totalsize(fdt));
>> @@ -952,6 +955,14 @@ static void pnv_init(MachineState *machine)
>>           g_free(sz);
>>           exit(EXIT_FAILURE);
>>       }
>> +
>> +    /* checks for invalid option combinations */
>> +    if (machine->dtb && (strlen(machine->kernel_cmdline) != 0)) {
>> +        error_report("-append and -dtb cannot be used together, as passed"
>> +                " command line is ignored in case of custom dtb");
>> +        exit(EXIT_FAILURE);
>> +    }
>> +
>>       memory_region_add_subregion(get_system_memory(), 0, machine->ram);
>>   
>>       /*
>> @@ -1003,6 +1014,21 @@ static void pnv_init(MachineState *machine)
>>           }
>>       }
>>   
>> +    /* load dtb if passed */
>> +    if (machine->dtb) {
>> +        int fdt_size;
>> +
>> +        warn_report("with manually passed dtb, some options like '-append'"
>> +                " will get ignored and the dtb passed will be used as-is");
>> +
>> +        /* read the file 'machine->dtb', and load it into 'fdt' buffer */
>> +        pnv->fdt = load_device_tree(machine->dtb, &fdt_size);
>> +        if (!pnv->fdt) {
>> +            error_report("Could not load dtb '%s'", machine->dtb);
>> +            exit(1);
>> +        }
>> +    }
>> +
>>       /* MSIs are supported on this platform */
>>       msi_nonbroken = true;
>>   
>> diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
>> index fcb6699150c8..20b68fd9264e 100644
>> --- a/include/hw/ppc/pnv.h
>> +++ b/include/hw/ppc/pnv.h
>> @@ -91,6 +91,8 @@ struct PnvMachineState {
>>       uint32_t     initrd_base;
>>       long         initrd_size;
>>   
>> +    void         *fdt;
>> +
>>       uint32_t     num_chips;
>>       PnvChip      **chips;
>>   
> 


