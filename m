Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDAE0C28B2E
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 05:42:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trsNY-0002Y8-Gj; Tue, 11 Mar 2025 01:42:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1trsNW-0002XP-6s; Tue, 11 Mar 2025 01:42:10 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1trsNT-0006TV-OR; Tue, 11 Mar 2025 01:42:09 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52AKFaWX028835;
 Tue, 11 Mar 2025 05:42:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=4zwo7F
 SEtTF0tdYgyaOZ3f8HexKNaXpybO9Pt//cX40=; b=Mi+tCIT6/4rUUV5VVpVv80
 +10s1mrU3xecdDIip5Gn5vEkQUWCN2nBXYWBVdW4GqEHD3x/UTFLThn2RZweCfD/
 JLRtRkJLZ0IWIMixtr35lC7RhRO7h51hI5vkOcMh7n7QgOdiJxDDeQ6hvgYHq6HS
 nX1lz5SUW1G0b9YeO2yvOkmn1+yt1LriMUPUNnvpNHyCOIF/vhuBYulfH9CHAHG0
 Y0daZpw1OJGnw06xKnbwn3hpXITD63A0J6f3RobGNZQ0pXh7Zo1Fx/3TsLywaD/C
 URJQtxOH1r6tRMSGGd0SATRuCnPaGBGkiIh9U5hKi4yYnO6wLpUkYwxdSWktxL7g
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45a042vcdr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 11 Mar 2025 05:42:05 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52B5er5v014630;
 Tue, 11 Mar 2025 05:42:04 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45a042vcdn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 11 Mar 2025 05:42:04 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52B30QGr014487;
 Tue, 11 Mar 2025 05:42:03 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4592eka5jp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 11 Mar 2025 05:42:03 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 52B5g24j61800718
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 11 Mar 2025 05:42:02 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 716FE58065;
 Tue, 11 Mar 2025 05:42:02 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BBD1158055;
 Tue, 11 Mar 2025 05:41:59 +0000 (GMT)
Received: from [9.109.242.165] (unknown [9.109.242.165])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 11 Mar 2025 05:41:59 +0000 (GMT)
Message-ID: <4d90572e-5485-42ae-a55e-4eb08dc1ac93@linux.ibm.com>
Date: Tue, 11 Mar 2025 11:11:57 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] hw/ppc: Implement MPIPL in PowerNV
To: Aditya Gupta <adityag@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>,
 Sourabh Jain <sourabhjain@linux.ibm.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Hari Bathini <hbathini@linux.ibm.com>
References: <20250217071934.86131-1-adityag@linux.ibm.com>
 <20250217071934.86131-8-adityag@linux.ibm.com>
Content-Language: en-US
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <20250217071934.86131-8-adityag@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: v1dKLqSvRyNiez5XRUzsI-vbhj2VuRo0
X-Proofpoint-ORIG-GUID: hC2YlLC5_LYedUResqLJ5fYJlyCAW08D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-11_01,2025-03-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxlogscore=999
 impostorscore=0 clxscore=1015 mlxscore=0 priorityscore=1501 spamscore=0
 adultscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503110035
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 2/17/25 12:49, Aditya Gupta wrote:
> Linux expect a "ibm,opal/dump" node to know whether MPIPL (aka fadump)
> is supported on the hardware.
> 
> Export the "ibm,opal/dump" node in QEMU's device tree for Linux to know
> that PowerNV supports MPIPL.
> 
> With the commit, kernel boots thinking fadump is supported, and reserves
> memory regions for fadump if "fadump=on" is passed in kernel cmdline:
> 
>      Linux/PowerPC load: init=/bin/sh debug fadump=on
>      Finalizing device tree... flat tree at 0x20ebaca0
>      [    1.005765851,5] DUMP: Payload sent metadata tag : 0x800002a8
>      [    1.005980914,5] DUMP: Boot mem size : 0x40000000
>      [    0.000000] opal fadump: Kernel metadata addr: 800002a8
>      [    0.000000] fadump: Reserved 1024MB of memory at 0x00000040000000 (System RAM: 20480MB)
>      [    0.000000] fadump: Initialized 0x40000000 bytes cma area at 1024MB from 0x400102a8 bytes of memory reserved for firmware-assisted dump
> 
> Also, OPAL and Linux expect the "mpipl-boot" device tree node on a MPIPL
> boot. Hence add "mpipl-boot" property in device tree on an MPIPL boot.
> 
> Hence after crash, Linux knows when it's a MPIPL/fadump boot:
> 
>      [    0.000000] opal fadump: Firmware-assisted dump is active.
>      [    0.000000] fadump: Firmware-assisted dump is active.
>      [    0.000000] fadump: Reserving 23552MB of memory at 0x00000040000000 for preserving crash data
> 
> Do note that fadump boot in PowerNV seems to require more memory,
> trying with 1GB causes this error by kernel:
> 
>      [    0.000000] fadump: Failed to find memory chunk for reservation!
> 
> And even with anything from 2GB - 19GB, the kernel fails to boot due to
> some memory issues.
> 
> Trying with >20GB memory is recommended for now
> 
> Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
> ---
>   hw/ppc/pnv.c             | 49 ++++++++++++++++++++++++++++++++++++++++
>   hw/ppc/pnv_sbe.c         | 18 +++++++++++----
>   include/hw/ppc/pnv_sbe.h |  4 ++++
>   3 files changed, 67 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index 11fd477b71be..39ed3f873e9a 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -51,6 +51,7 @@
>   #include "hw/ppc/pnv_chip.h"
>   #include "hw/ppc/pnv_xscom.h"
>   #include "hw/ppc/pnv_pnor.h"
> +#include "hw/ppc/pnv_sbe.h"
>   
>   #include "hw/isa/isa.h"
>   #include "hw/char/serial-isa.h"
> @@ -697,6 +698,26 @@ static void *pnv_dt_create(MachineState *machine)
>           pmc->dt_power_mgt(pnv, fdt);
>       }
>   
> +    /* Add "dump" node so kernel knows MPIPL (aka fadump) is supported */
> +    off = fdt_add_subnode(fdt, 0, "ibm,opal");
> +    if (off == -FDT_ERR_EXISTS) {
> +        off = fdt_path_offset(fdt, "/ibm,opal");
> +    }
> +
> +    _FDT(off);
> +    off = fdt_add_subnode(fdt, off, "dump");
> +    _FDT(off);
> +    _FDT((fdt_setprop_string(fdt, off, "compatible", "ibm,opal-dump")));
> +
> +    /* Add kernel and initrd as fw-load-area */
> +    uint64_t fw_load_area[4] = {
> +        cpu_to_be64(KERNEL_LOAD_ADDR), cpu_to_be64(KERNEL_MAX_SIZE),
> +        cpu_to_be64(INITRD_LOAD_ADDR), cpu_to_be64(INITRD_MAX_SIZE)
> +    };
> +
> +    _FDT((fdt_setprop(fdt, off, "fw-load-area",
> +                    fw_load_area, sizeof(fw_load_area))));
> +

Above could be wrapped in pnv_dt_mpipl(fdt) and called here?

>       return fdt;
>   }
>   
> @@ -714,6 +735,7 @@ static void pnv_reset(MachineState *machine, ResetType type)
>       PnvMachineState *pnv = PNV_MACHINE(machine);
>       IPMIBmc *bmc;
>       void *fdt;
> +    int node_offset;
>   
>       qemu_devices_reset(type);
>   
> @@ -744,6 +766,33 @@ static void pnv_reset(MachineState *machine, ResetType type)
>           _FDT((fdt_pack(fdt)));
>       }
>   
> +    /*
> +     * If it's a MPIPL boot, add the "mpipl-boot" property, and reset the
> +     * boolean for MPIPL boot for next boot
> +     */
> +    if (pnv_sbe_is_mpipl_boot()) {
> +        void *fdt_copy = g_malloc0(FDT_MAX_SIZE);

Where is this getting free'ed ?

> +
> +        /* Create a writable copy of the fdt */
> +        _FDT((fdt_open_into(fdt, fdt_copy, FDT_MAX_SIZE)));
> +
> +        node_offset = fdt_path_offset(fdt_copy, "/ibm,opal/dump");
> +        _FDT((fdt_appendprop_u64(fdt_copy, node_offset, "mpipl-boot", 1)));
> +
> +        /* Update the fdt, and free the original fdt */
> +        if (fdt != machine->fdt) {
> +            /*
> +             * Only free the fdt if it's not machine->fdt, to prevent
> +             * double free, since we already free machine->fdt later
> +             */
> +            g_free(fdt);
> +        }
> +        fdt = fdt_copy;
> +
> +        /* This boot is an MPIPL, reset the boolean for next boot */
> +        pnv_sbe_reset_is_next_boot_mpipl();
> +    }
> +

Could above be wrapped in pnv_reset_mpipl(fdt) and called if
pnv_sbe_is_mpipl_boot is true?

>       qemu_fdt_dumpdtb(fdt, fdt_totalsize(fdt));
>       cpu_physical_memory_write(PNV_FDT_ADDR, fdt, fdt_totalsize(fdt));
>   
> diff --git a/hw/ppc/pnv_sbe.c b/hw/ppc/pnv_sbe.c
> index 3b50667226b5..671dc81c9501 100644
> --- a/hw/ppc/pnv_sbe.c
> +++ b/hw/ppc/pnv_sbe.c
> @@ -216,6 +216,18 @@ struct proc_dump_area {
>       __be32  act_size;      /* Actual data size */
>   } __packed;
>   
> +static bool is_next_boot_mpipl;
> +
> +bool pnv_sbe_is_mpipl_boot(void)
> +{
> +    return is_next_boot_mpipl;
> +}
> +
> +void pnv_sbe_reset_is_next_boot_mpipl(void)
> +{
> +    is_next_boot_mpipl = false;
> +}
> +
>   static void pnv_sbe_set_host_doorbell(PnvSBE *sbe, uint64_t val)
>   {
>       val &= SBE_HOST_RESPONSE_MASK; /* Is this right? What does HW do? */
> @@ -334,10 +346,8 @@ static void pnv_sbe_power9_xscom_ctrl_write(void *opaque, hwaddr addr,
>               /* Save processor state */
>               pnv_mpipl_save_proc_regs();
>   
> -            /*
> -             * TODO: Pass `mpipl` node in device tree to signify next
> -             * boot is an MPIPL boot
> -             */
> +            /* Mark next boot as Memory-preserving boot */
> +            is_next_boot_mpipl = true;
>   
>               /* Then do a guest reset */
>               /*
> diff --git a/include/hw/ppc/pnv_sbe.h b/include/hw/ppc/pnv_sbe.h
> index f6cbcf990ed9..94bbdc7b6414 100644
> --- a/include/hw/ppc/pnv_sbe.h
> +++ b/include/hw/ppc/pnv_sbe.h
> @@ -56,4 +56,8 @@ struct PnvSBEClass {
>   /* Helper to access stashed SKIBOOT_BASE */
>   bool pnv_sbe_mpipl_skiboot_base(void);
>   
> +/* Helpers to know if next boot is MPIPL boot */
> +bool pnv_sbe_is_mpipl_boot(void);
> +void pnv_sbe_reset_is_next_boot_mpipl(void);

Usually we have a set along with reset and helpers for modifying struct 
members. Above helpers for a gloabl var seems a bit un-necessary. I 
guess we want to keep such global vars inside relevant struct.

Thanks
Harsh
> +
>   #endif /* PPC_PNV_SBE_H */

