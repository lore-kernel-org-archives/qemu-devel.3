Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F00F6D0E6D1
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 08:49:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2o5a-0003tw-6e; Mon, 21 Oct 2024 04:48:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1t2o5H-0003qX-44; Mon, 21 Oct 2024 04:48:18 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1t2o5E-0006Vh-GL; Mon, 21 Oct 2024 04:48:14 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49L2KJKr030410;
 Mon, 21 Oct 2024 08:47:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=LGzbzf
 aAXDlpwxsnhHIC8O8kL+V4oU7X+qJxKvZcAak=; b=NjAgd+SWRUNAEci0XPgzKs
 gLFuG3ih1qOrEliVIwNMOYJXTpumH+QJojqQbt5WeT3gfBGFKTQoa+ynbEDYv05p
 0aDYJb5GRyWRgakzBYU09ReEPjZrQhx3LkQxLEMK0Z/Tf4bBDwwt61ebjh9coCM7
 pDFfJRlJJNK+ff80asHBLv2R3Kl5EcF9ztoB4YLv/mgVuzZ9wu8aQ6M4/r22hKx3
 G/A7BUanLSmc2sGVjaRnqRUkdrkgMOYtx8qJsh2udhf5rSnNFGVM5pPGxU2X86VR
 Q+g/Uxx5pmMjEfoXhe4Cu7/WL5Qo6TRpj0S4/xXnTaw7Qr14ZL2TsQjpF1jTqYww
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42c5fsqp09-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 21 Oct 2024 08:47:59 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49L8lxF0001856;
 Mon, 21 Oct 2024 08:47:59 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42c5fsqp06-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 21 Oct 2024 08:47:59 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49L68i24023864;
 Mon, 21 Oct 2024 08:47:58 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 42cst0w18a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 21 Oct 2024 08:47:58 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 49L8lt0n49873234
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 21 Oct 2024 08:47:55 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 12A6120043;
 Mon, 21 Oct 2024 08:47:55 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 429B520040;
 Mon, 21 Oct 2024 08:47:51 +0000 (GMT)
Received: from [9.39.24.12] (unknown [9.39.24.12])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 21 Oct 2024 08:47:50 +0000 (GMT)
Message-ID: <9b7a4321-86a7-4c5f-8aad-3fa6190c00c9@linux.ibm.com>
Date: Mon, 21 Oct 2024 14:17:49 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] hw/ppc: Implement -dtb support for PowerNV
From: Aditya Gupta <adityag@linux.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>
Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org
References: <20240820103003.550735-1-adityag@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20240820103003.550735-1-adityag@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: DOEFrB6on7HL9ZL4_yOdcZbcFglw1B7J
X-Proofpoint-ORIG-GUID: ELdNtn7RAj13v616Q3QvpX8hCBAzxZLO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0
 impostorscore=0 clxscore=1011 mlxscore=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 adultscore=0 phishscore=0 priorityscore=1501
 spamscore=0 mlxlogscore=947 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2409260000 definitions=main-2410210060
Received-SPF: pass client-ip=148.163.158.5; envelope-from=adityag@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

Hi all,

Just a ping for this. Any comments ?


Thanks,

Aditya Gupta

On 20/08/24 16:00, Aditya Gupta wrote:
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
> v4:
>   + use 'MachineState::fdt' instead of 'PnvMachineState::fdt'
>   + added an 'if' check at end of pnv_reset, so we don't free the fdt we
>     are using
> v3:
>   + use 'load_device_tree' to read the device tree, instead of g_file_get_contents
>   + tested that passed dtb does NOT get ignored on system_reset
>
> v2:
>   + move reading dtb and warning to pnv_init
>
> v1:
>   + use 'g_file_get_contents' and add check for -append & -dtb as suggested by Daniel
> ---
> ---
>   hw/ppc/pnv.c | 51 ++++++++++++++++++++++++++++++++++++++++-----------
>   1 file changed, 40 insertions(+), 11 deletions(-)
>
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index 3526852685b4..5be15f748e45 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -736,21 +736,27 @@ static void pnv_reset(MachineState *machine, ShutdownCause reason)
>           }
>       }
>   
> -    fdt = pnv_dt_create(machine);
> -
> -    /* Pack resulting tree */
> -    _FDT((fdt_pack(fdt)));
> +    if (machine->fdt) {
> +        fdt = machine->fdt;
> +    } else {
> +        fdt = pnv_dt_create(machine);
> +        /* Pack resulting tree */
> +        _FDT((fdt_pack(fdt)));
> +    }
>   
>       qemu_fdt_dumpdtb(fdt, fdt_totalsize(fdt));
>       cpu_physical_memory_write(PNV_FDT_ADDR, fdt, fdt_totalsize(fdt));
>   
> -    /*
> -     * Set machine->fdt for 'dumpdtb' QMP/HMP command. Free
> -     * the existing machine->fdt to avoid leaking it during
> -     * a reset.
> -     */
> -    g_free(machine->fdt);
> -    machine->fdt = fdt;
> +    /* Update machine->fdt with latest fdt */
> +    if (machine->fdt != fdt) {
> +        /*
> +         * Set machine->fdt for 'dumpdtb' QMP/HMP command. Free
> +         * the existing machine->fdt to avoid leaking it during
> +         * a reset.
> +         */
> +        g_free(machine->fdt);
> +        machine->fdt = fdt;
> +    }
>   }
>   
>   static ISABus *pnv_chip_power8_isa_create(PnvChip *chip, Error **errp)
> @@ -952,6 +958,14 @@ static void pnv_init(MachineState *machine)
>           g_free(sz);
>           exit(EXIT_FAILURE);
>       }
> +
> +    /* checks for invalid option combinations */
> +    if (machine->dtb && (strlen(machine->kernel_cmdline) != 0)) {
> +        error_report("-append and -dtb cannot be used together, as passed"
> +                " command line is ignored in case of custom dtb");
> +        exit(EXIT_FAILURE);
> +    }
> +
>       memory_region_add_subregion(get_system_memory(), 0, machine->ram);
>   
>       /*
> @@ -1003,6 +1017,21 @@ static void pnv_init(MachineState *machine)
>           }
>       }
>   
> +    /* load dtb if passed */
> +    if (machine->dtb) {
> +        int fdt_size;
> +
> +        warn_report("with manually passed dtb, some options like '-append'"
> +                " will get ignored and the dtb passed will be used as-is");
> +
> +        /* read the file 'machine->dtb', and load it into 'fdt' buffer */
> +        machine->fdt = load_device_tree(machine->dtb, &fdt_size);
> +        if (!machine->fdt) {
> +            error_report("Could not load dtb '%s'", machine->dtb);
> +            exit(1);
> +        }
> +    }
> +
>       /* MSIs are supported on this platform */
>       msi_nonbroken = true;
>   

