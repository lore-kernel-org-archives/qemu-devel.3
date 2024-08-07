Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00C32C3DA7F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 08:45:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbcHb-0005JP-9Z; Wed, 07 Aug 2024 04:44:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1sbcHZ-0005IW-HI; Wed, 07 Aug 2024 04:44:33 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1sbcHX-0001q5-BG; Wed, 07 Aug 2024 04:44:33 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4772Mg58010160;
 Wed, 7 Aug 2024 08:44:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=2
 2lwVAZS8slt9VT/IR3++IM2iwGk4kpfto1vMOGP97Q=; b=o8/cVuxmH2ruqtX+e
 PdVUOMPvB7v3/jPQtoAddLe8yjHXgPr7tQ7/IFXFpBiYkVAk9EzI5HvpPFDSZ4oF
 clGiM10Dd9kipFRX8S/0v7AI3XBCf2xtOm3iuASTji5/JXtEyCe/RjdoKlYwJZdl
 ye+sV9mg5VW8r0Lcl+eR90QlNpdvvkMBFipkCkr8RW2xLUfsOOyjAAZPS7m/kzpA
 1FXufOFqVA9O1uwTKQMfnrVGp9FcXS31G0ZIXTMFiNbkhgV0Cd9mt4S/QPYYmCyr
 H5GFjPOs0TuOOHngUyJXknCXyGLvf9zUh4nn4KD+W5mEJ7zHqinMjIRyO/3OD61M
 lJw/A==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40uk02abv1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 07 Aug 2024 08:44:27 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4778iQ1g031964;
 Wed, 7 Aug 2024 08:44:26 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40uk02abv0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 07 Aug 2024 08:44:26 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 4777JlrD024211; Wed, 7 Aug 2024 08:44:25 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40syvpg69f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 07 Aug 2024 08:44:25 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4778iKlu44237298
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 7 Aug 2024 08:44:22 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EBB2620043;
 Wed,  7 Aug 2024 08:44:19 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B2C7E2004D;
 Wed,  7 Aug 2024 08:44:17 +0000 (GMT)
Received: from [9.195.32.224] (unknown [9.195.32.224])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  7 Aug 2024 08:44:17 +0000 (GMT)
Message-ID: <043b00cd-1358-44cd-8feb-f79a58ed2d88@linux.ibm.com>
Date: Wed, 7 Aug 2024 14:14:16 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hw/ppc: Implement -dtb support for PowerNV
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20240801085133.59781-1-adityag@linux.ibm.com>
 <e376f6ce-4ade-455b-853b-270172317437@kaod.org>
Content-Language: en-US
From: Aditya Gupta <adityag@linux.ibm.com>
In-Reply-To: <e376f6ce-4ade-455b-853b-270172317437@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ZHvEjeBJd6Q7RRKAgzlC2u9FmMJj-Qze
X-Proofpoint-GUID: r1NAQbYv04Aj_gaaj_-swh_T2Ib3Q7U3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-07_05,2024-08-06_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 mlxlogscore=999
 priorityscore=1501 mlxscore=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 bulkscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408070057
Received-SPF: pass client-ip=148.163.158.5; envelope-from=adityag@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Hi Cedric,

Sorry for the late reply.


On 01/08/24 15:22, Cédric Le Goater wrote:
> On 8/1/24 10:51, Aditya Gupta wrote:
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
>>
>> ---
>> Changelog
>> ===========
>> v2:
>>   + move reading dtb and warning to pnv_init
>>
>> v1:
>>   + use 'g_file_get_contents' and add check for -append & -dtb as 
>> suggested by Daniel
>> ---
>> ---
>>   hw/ppc/pnv.c         | 29 ++++++++++++++++++++++++++---
>>   include/hw/ppc/pnv.h |  2 ++
>>   2 files changed, 28 insertions(+), 3 deletions(-)
>>
>> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
>> index 3526852685b4..047725bd97fc 100644
>> --- a/hw/ppc/pnv.c
>> +++ b/hw/ppc/pnv.c
>> @@ -736,11 +736,14 @@ static void pnv_reset(MachineState *machine, 
>> ShutdownCause reason)
>>           }
>>       }
>>   -    fdt = pnv_dt_create(machine);
>> +    if (!pnv->fdt) {
>> +        pnv->fdt = pnv_dt_create(machine);
>
> At next reset, the dtb specified on the command line will be ignored.
> Please reverse the logic :
>
>     if (pnv->fdt) {
>         fdt = pnv->fdt;
>     } else {
>         fdt = pnv_dt_create(machine);
>         /* Pack resulting tree */
>         _FDT((fdt_pack(fdt)));
>     }


Understood, thanks for pointing it out.

>
> but, at the end of pnv_reset(), beware of :
>
>     g_free(machine->fdt);
>     machine->fdt = fdt;
>
That should be okay right ? Even if machine->fdt is NULL, that's okay, 
and we assign the latest fdt to machine->fdt
>
>> -    /* Pack resulting tree */
>> -    _FDT((fdt_pack(fdt)));
>> +        /* Pack resulting tree */
>> +        _FDT((fdt_pack(pnv->fdt)));
>> +    }
>>   +    fdt = pnv->fdt;
>>       qemu_fdt_dumpdtb(fdt, fdt_totalsize(fdt));
>>       cpu_physical_memory_write(PNV_FDT_ADDR, fdt, fdt_totalsize(fdt));
>>   @@ -952,6 +955,14 @@ static void pnv_init(MachineState *machine)
>>           g_free(sz);
>>           exit(EXIT_FAILURE);
>>       }
>> +
>> +    /* checks for invalid option combinations */
>> +    if (machine->dtb && (strlen(machine->kernel_cmdline) != 0)) {
>> +        error_report("-append and -dtb cannot be used together, as 
>> passed"
>> +                " command line is ignored in case of custom dtb");
>> +        exit(EXIT_FAILURE);
>
> I think this is redundant with the warn report below.

Can we keep it ?

The warning is meant to be generic, as other options, maybe even -smp 
might get ignored. There might be lot of such combinations.

While, the error above just covers one of the combinations, give an 
error if -append & -dtb are used together.

The error and warning seem repetitive, maybe I will add some more flags 
to the warning ?


Thanks,

Aditya Gupta

>
>> +    }
>> +
>>       memory_region_add_subregion(get_system_memory(), 0, machine->ram);
>>         /*
>> @@ -1003,6 +1014,18 @@ static void pnv_init(MachineState *machine)
>>           }
>>       }
>>   +    /* load dtb if passed */
>> +    if (machine->dtb) {
>> +        warn_report("with manually passed dtb, some options like 
>> '-append'"
>> +                " will get ignored and the dtb passed will be used 
>> as-is");
>> +
>> +        /* read the file 'machine->dtb', and load it into 'fdt' 
>> buffer */
>> +        if (!g_file_get_contents(machine->dtb, (gchar **)&pnv->fdt, 
>> NULL, NULL)) {
>> +            error_report("Could not load dtb '%s'", machine->dtb);
>> +            exit(1);
>> +        }
>
> There is a load_device_tree() routine you could use. Please check how 
> other
> machines handle -dtb for examples.
>
>
> Thanks,
>
> C.
>
>
>
>> +    }
>> +
>>       /* MSIs are supported on this platform */
>>       msi_nonbroken = true;
>>   diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
>> index fcb6699150c8..20b68fd9264e 100644
>> --- a/include/hw/ppc/pnv.h
>> +++ b/include/hw/ppc/pnv.h
>> @@ -91,6 +91,8 @@ struct PnvMachineState {
>>       uint32_t     initrd_base;
>>       long         initrd_size;
>>   +    void         *fdt;
>> +
>>       uint32_t     num_chips;
>>       PnvChip      **chips;
>

