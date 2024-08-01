Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A60ACC49EA1
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 08:52:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZRXE-0003cZ-G4; Thu, 01 Aug 2024 04:51:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1sZRX6-0003ak-VD; Thu, 01 Aug 2024 04:51:38 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1sZRX4-0002HU-Ru; Thu, 01 Aug 2024 04:51:36 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47125DZJ007742;
 Thu, 1 Aug 2024 08:51:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=w
 kxYim9tPssgr3piD6/mojVZMmBPSlN2nsNfTM5QP0o=; b=aKT4zByowb8ZJ3opg
 d4Fksy+V8uUE0eSq6SH1Jbn1ULp03AuYvVzIRJBs92VIQtzlCXkni3t3Tr8gKcBG
 Np32T5Uq+OFEYTS56tEjpNBBDB7qaqVKIEnuPXQfJyf4m+6voG+v6AY9uWhFY+2D
 Ql//lVFMP/cYQllC3Aq2546Kiwv2OXwAQuAv4FJq8S5Kj+JdoMakMeIbgfxUGP/G
 5LwWRG9Yc3b8KVhNMLXgE6jlovRUtK5JRDFNYWAqs2EmZ0yy9X4wNEec5+P/3RcN
 1OYr1+Gaj3B/Ca4jwytwoPtEmnTnMC85urj89j1UMDtcrTUpxHLleYvDwXLJHayg
 H23mw==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40qxygs48u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 01 Aug 2024 08:51:25 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4718pO0S016235;
 Thu, 1 Aug 2024 08:51:24 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40qxygs48t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 01 Aug 2024 08:51:24 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 47180Vfj007457; Thu, 1 Aug 2024 08:51:23 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 40nb7uh1nc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 01 Aug 2024 08:51:23 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4718pIcu51511680
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 1 Aug 2024 08:51:20 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0B5AE20043;
 Thu,  1 Aug 2024 08:51:18 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BFD7820040;
 Thu,  1 Aug 2024 08:51:15 +0000 (GMT)
Received: from [9.109.199.72] (unknown [9.109.199.72])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  1 Aug 2024 08:51:15 +0000 (GMT)
Message-ID: <ad48593a-ca93-494a-bbe6-da433b547cb9@linux.ibm.com>
Date: Thu, 1 Aug 2024 14:21:14 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/ppc: Implement -dtb support for PowerNV
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20240731201039.1011028-1-adityag@linux.ibm.com>
 <1cbec992-4eaa-4506-b6e4-1bd91e0c39ce@kaod.org>
Content-Language: en-US
From: Aditya Gupta <adityag@linux.ibm.com>
In-Reply-To: <1cbec992-4eaa-4506-b6e4-1bd91e0c39ce@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Bd3toYi9yk__-ZLC8l2feTP7YvqtJSDD
X-Proofpoint-GUID: Zsc2jGQ_KIQTBbIuCds7m-YWgKEs1i_A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-01_05,2024-07-31_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=791
 priorityscore=1501 adultscore=0 impostorscore=0 spamscore=0 malwarescore=0
 clxscore=1015 bulkscore=0 lowpriorityscore=0 mlxscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408010050
Received-SPF: pass client-ip=148.163.156.1; envelope-from=adityag@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

Hello Cedric,


>> <...snip...>
>>
>> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
>> index 3526852685b4..03600fa62cbd 100644
>> --- a/hw/ppc/pnv.c
>> +++ b/hw/ppc/pnv.c
>> @@ -736,10 +736,21 @@ static void pnv_reset(MachineState *machine, 
>> ShutdownCause reason)
>>           }
>>       }
>>   -    fdt = pnv_dt_create(machine);
>> +    if (machine->dtb) {
>> +        warn_report("with manually passed dtb, some options like 
>> '-append'"
>> +                " will get ignored and the dtb passed will be used 
>> as-is");
>
> This warning should come after all other checks. See below.
>
>
>> -    /* Pack resulting tree */
>> -    _FDT((fdt_pack(fdt)));
>> +        /* read the file 'machine->dtb', and load it into 'fdt' 
>> buffer */
>> +        if (!g_file_get_contents(machine->dtb, (gchar **)&fdt, NULL, 
>> NULL)) {
>> +            error_report("Could not load dtb '%s'", machine->dtb);
>> +            exit(1);
>> +        }
>
> We should try to report such errors earlier than in reset.
>
Thanks, I will remember this from next time.

> Can you please introduce a PnvMachineState::dtb attribute and 
> initialize it
> in pnv_init() after ->initrd_filename.
>
Sure, I will move it to pnv_init.


Thanks,

Aditya Gupta

>
>
> Thanks,
>
> C.
>
>
>
>> +    } else {
>> +        fdt = pnv_dt_create(machine);
>> +
>> +        /* Pack resulting tree */
>> +        _FDT((fdt_pack(fdt)));
>> +    }
>>         qemu_fdt_dumpdtb(fdt, fdt_totalsize(fdt));
>>       cpu_physical_memory_write(PNV_FDT_ADDR, fdt, fdt_totalsize(fdt));
>> @@ -952,6 +963,14 @@ static void pnv_init(MachineState *machine)
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
>> +    }
>> +
>>       memory_region_add_subregion(get_system_memory(), 0, machine->ram);
>>         /*
>

