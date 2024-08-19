Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA304C3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2024 14:04:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sg2yp-0003JJ-TI; Mon, 19 Aug 2024 10:03:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1sg2yl-0003HT-0s; Mon, 19 Aug 2024 10:03:27 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1sg2yi-0006vm-R6; Mon, 19 Aug 2024 10:03:26 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47J5m2mO014050;
 Mon, 19 Aug 2024 14:03:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=V
 h8NrWKrEa9zOz2uYPqCc2z2LjnupXgkd7cHNXi5W0Y=; b=bW3Pta2dMJ7OpK/s3
 vSJmfDlPfAArA18gepT6+hidXs+/1G6tKUawj3De7eZjTPP4amyLd840Vttt65IX
 BnHLaYcD73rqHPEpmerBlmZZmGwBVAE1HPfscR6FaX4TOKA+oOq7HruEylr82aJn
 ewvmQw9ycb+g5bkeaF3tW+f7UXqnOiIOeO/Npo2qC0+FEZ52MNV1DKwfbkMtfCW4
 6W50tZh7CfZ3Rp8SycjlPOeBuuRA16cNsgSaD+sR5qNf3BVMws7Q5UycqclZcP+L
 RFkZSP6SeF7QdV7jo4wbxKu7hf2pjrHhe1qJ1DlszqjvepYgm2WR/22kGFXituqD
 h09Qw==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 412ma013rc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 19 Aug 2024 14:03:17 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 47JE0NBp018053;
 Mon, 19 Aug 2024 14:03:16 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 412ma013pp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 19 Aug 2024 14:03:16 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 47JD49uG019044;
 Mon, 19 Aug 2024 14:02:39 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41376ppd5d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 19 Aug 2024 14:02:39 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 47JE2XQt32375328
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 19 Aug 2024 14:02:35 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6A7C620043;
 Mon, 19 Aug 2024 14:02:33 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F40D820040;
 Mon, 19 Aug 2024 14:02:30 +0000 (GMT)
Received: from [9.195.36.7] (unknown [9.195.36.7])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 19 Aug 2024 14:02:30 +0000 (GMT)
Message-ID: <253d0911-a3e5-478c-8431-4944be83bdfb@linux.ibm.com>
Date: Mon, 19 Aug 2024 19:32:29 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] hw/ppc: Implement -dtb support for PowerNV
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20240813134536.1204513-1-adityag@linux.ibm.com>
 <D3GB5QVADVQ1.XZM3FFV52LIW@gmail.com>
 <6c0cdf26-9795-4998-9d80-1d0095700a59@kaod.org>
Content-Language: en-US
From: Aditya Gupta <adityag@linux.ibm.com>
In-Reply-To: <6c0cdf26-9795-4998-9d80-1d0095700a59@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: PGczQSZkKin10fGPssp3U3ED5n4-IpC-
X-Proofpoint-ORIG-GUID: CLYVOq-ZAL-lKx23p1X45gzSMrgg9I-6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-19_12,2024-08-19_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 priorityscore=1501
 mlxlogscore=999 lowpriorityscore=0 phishscore=0 spamscore=0 malwarescore=0
 bulkscore=0 adultscore=0 impostorscore=0 suspectscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408190094
Received-SPF: pass client-ip=148.163.156.1; envelope-from=adityag@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Hi Cedric,


On 15/08/24 23:22, Cédric Le Goater wrote:
>
> I don't think this is a bug fix. is it ? AFAIUI, it is a debug
> feature for skiboot. It's QEMU 9.2 material.
>
Thanks for answering Nick's question, I did not check my mails.

Yes, it can be considered a debug feature.

>> One little nit is MachineState.fdt vs PnvMachineState.fdt
>> which is now confusing. I would call the new PnvMachineState member
>> something like fdt_from_dtb, or fdt_override?
>
> I agree. this is confusing. machine->fdt could be used instead ?

Sure, will use it.


Thanks,

Aditya Gupta

>
>> The other question... Some machines rebuild fdt at init, others at
>> reset time. As far as I understood, spapr has to rebuild on reset
>> because C-A-S call can update the fdt so you have to undo that on
>> reset. 
>
> C-A-S is a guest OS hcall. reset is called before the guest OS
> is started.
>
>> Did powernv just copy that without really needing it, I wonder?
>> Maybe that rearranged to just do it at init time (e.g., see
>> hw/riscv/virt.c which is simpler).
>
> The machine is aware of user created devices (on the command line)
> only at reset time.
>
> Thanks,
>
> C.
>
>
>
>
>
>> Thanks,
>> Nick
>>
>>>
>>> ---
>>> Changelog
>>> ===========
>>> v3:
>>>   + use 'load_device_tree' to read the device tree, instead of 
>>> g_file_get_contents
>>>   + tested that passed dtb does NOT get ignored on system_reset
>>>
>>> v2:
>>>   + move reading dtb and warning to pnv_init
>>>
>>> v1:
>>>   + use 'g_file_get_contents' and add check for -append & -dtb as 
>>> suggested by Daniel
>>> ---
>>> ---
>>>   hw/ppc/pnv.c         | 34 ++++++++++++++++++++++++++++++----
>>>   include/hw/ppc/pnv.h |  2 ++
>>>   2 files changed, 32 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
>>> index 3526852685b4..14225f7e48af 100644
>>> --- a/hw/ppc/pnv.c
>>> +++ b/hw/ppc/pnv.c
>>> @@ -736,10 +736,13 @@ static void pnv_reset(MachineState *machine, 
>>> ShutdownCause reason)
>>>           }
>>>       }
>>>   -    fdt = pnv_dt_create(machine);
>>> -
>>> -    /* Pack resulting tree */
>>> -    _FDT((fdt_pack(fdt)));
>>> +    if (pnv->fdt) {
>>> +        fdt = pnv->fdt;
>>> +    } else {
>>> +        fdt = pnv_dt_create(machine);
>>> +        /* Pack resulting tree */
>>> +        _FDT((fdt_pack(fdt)));
>>> +    }
>>>         qemu_fdt_dumpdtb(fdt, fdt_totalsize(fdt));
>>>       cpu_physical_memory_write(PNV_FDT_ADDR, fdt, fdt_totalsize(fdt));
>>> @@ -952,6 +955,14 @@ static void pnv_init(MachineState *machine)
>>>           g_free(sz);
>>>           exit(EXIT_FAILURE);
>>>       }
>>> +
>>> +    /* checks for invalid option combinations */
>>> +    if (machine->dtb && (strlen(machine->kernel_cmdline) != 0)) {
>>> +        error_report("-append and -dtb cannot be used together, as 
>>> passed"
>>> +                " command line is ignored in case of custom dtb");
>>> +        exit(EXIT_FAILURE);
>>> +    }
>>> +
>>>       memory_region_add_subregion(get_system_memory(), 0, 
>>> machine->ram);
>>>         /*
>>> @@ -1003,6 +1014,21 @@ static void pnv_init(MachineState *machine)
>>>           }
>>>       }
>>>   +    /* load dtb if passed */
>>> +    if (machine->dtb) {
>>> +        int fdt_size;
>>> +
>>> +        warn_report("with manually passed dtb, some options like 
>>> '-append'"
>>> +                " will get ignored and the dtb passed will be used 
>>> as-is");
>>> +
>>> +        /* read the file 'machine->dtb', and load it into 'fdt' 
>>> buffer */
>>> +        pnv->fdt = load_device_tree(machine->dtb, &fdt_size);
>>> +        if (!pnv->fdt) {
>>> +            error_report("Could not load dtb '%s'", machine->dtb);
>>> +            exit(1);
>>> +        }
>>> +    }
>>> +
>>>       /* MSIs are supported on this platform */
>>>       msi_nonbroken = true;
>>>   diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
>>> index fcb6699150c8..20b68fd9264e 100644
>>> --- a/include/hw/ppc/pnv.h
>>> +++ b/include/hw/ppc/pnv.h
>>> @@ -91,6 +91,8 @@ struct PnvMachineState {
>>>       uint32_t     initrd_base;
>>>       long         initrd_size;
>>>   +    void         *fdt;
>>> +
>>>       uint32_t     num_chips;
>>>       PnvChip      **chips;
>>
>

