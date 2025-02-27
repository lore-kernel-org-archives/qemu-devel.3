Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65916C19F2E
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 06:49:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnXiE-00047y-Hh; Thu, 27 Feb 2025 01:49:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1tnXi6-00042e-LP; Thu, 27 Feb 2025 01:49:32 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1tnXi4-0004CH-It; Thu, 27 Feb 2025 01:49:30 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51R189tL027830;
 Thu, 27 Feb 2025 06:49:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=87E1bU
 LPw24MdkwqdVPp7QIZFvKqt/T3i3Rf7Ah5nXo=; b=C/LDEZkfCGVId7uuCr75eR
 jYL6Z1daVvrDyPyZX71lJ/GM0aTxxKxsquQJfTcu3vGCSKcpl3Ts/ydXD9caHuQ8
 oCv0log3IlYwIrzF88NBHiHatYlufSdrATWFFalvUvQs7nWKiJczPbjriEecTP1b
 xWKI1PhdUZ416McSram83+AOinMVfqHbyXwHse6/8gHb3l/C5+TSJu1vfHszLuQ+
 cavoh0Ds35gg43Vj7XzfjyZbtI9ME+1Av9CtHFoVvKhohpp9/0IDnB6IUsVqDH0L
 WpFvrUA7myp+T49rA96oFHSR4g5SzgZZtoQiY/VK2JpBNUfUQiL2YHPtklFLwjYw
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 452e4a16bs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 27 Feb 2025 06:49:25 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 51R6nPl2010306;
 Thu, 27 Feb 2025 06:49:25 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 452e4a16bn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 27 Feb 2025 06:49:25 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51R5iBag027396;
 Thu, 27 Feb 2025 06:49:24 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44ytdkq2gt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 27 Feb 2025 06:49:24 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 51R6nKkI34210402
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 27 Feb 2025 06:49:20 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2C43D2004D;
 Thu, 27 Feb 2025 06:49:20 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 04E6320043;
 Thu, 27 Feb 2025 06:49:18 +0000 (GMT)
Received: from [9.124.211.149] (unknown [9.124.211.149])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 27 Feb 2025 06:49:17 +0000 (GMT)
Message-ID: <7ec1dc4f-e7b1-492a-8cf2-b971b11bc31b@linux.ibm.com>
Date: Thu, 27 Feb 2025 12:19:16 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] hw/ppc: Implement skeleton code for fadump in PSeries
To: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Sourabh Jain <sourabhjain@linux.ibm.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Hari Bathini <hbathini@linux.ibm.com>
References: <20250217071711.83735-1-adityag@linux.ibm.com>
 <20250217071711.83735-2-adityag@linux.ibm.com>
 <D82WB0T0PJ0H.3M2NGHZT4M9SW@gmail.com>
Content-Language: en-US
From: Aditya Gupta <adityag@linux.ibm.com>
In-Reply-To: <D82WB0T0PJ0H.3M2NGHZT4M9SW@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: IK0LWkiYJ0JPy2O4rTwVlhaaluVd6Fk8
X-Proofpoint-GUID: iMhX5heLSlYgQHVkjO4cCaD1_3lZ81fU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-27_03,2025-02-26_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 suspectscore=0 phishscore=0 mlxlogscore=999 spamscore=0 adultscore=0
 clxscore=1015 priorityscore=1501 bulkscore=0 impostorscore=0
 malwarescore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502270048
Received-SPF: pass client-ip=148.163.156.1; envelope-from=adityag@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
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

Hi Nick,

On 27/02/25 08:37, Nicholas Piggin wrote:
> On Mon Feb 17, 2025 at 5:17 PM AEST, Aditya Gupta wrote:
>> Implement the handler for "ibm,configure-kernel-dump" rtas call in QEMU.
>>
>> Currently the handler just does basic checks and handles
>> register/unregister/invalidate requests from kernel.
>>
>> Fadump will be enabled in a later patch.
>>
>> Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
>> ---
>>   hw/ppc/spapr_rtas.c    | 99 ++++++++++++++++++++++++++++++++++++++++++
>>   include/hw/ppc/spapr.h | 59 +++++++++++++++++++++++++
>>   2 files changed, 158 insertions(+)
>>
>> diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
>> index df2e837632aa..eebdf13b1552 100644
>> --- a/hw/ppc/spapr_rtas.c
>> +++ b/hw/ppc/spapr_rtas.c
>> @@ -341,6 +341,105 @@ static void rtas_ibm_set_system_parameter(PowerPCCPU *cpu,
>>       rtas_st(rets, 0, ret);
>>   }
>>   
>> +struct fadump_metadata fadump_metadata;
> Can this (and other globals added in other patches) come under
> SpaprMachineState?
>
> And could most of the fadump code and structures go under new
> spapr_fadump.[ch] files?
Yes, i can move it inside SpaprMachineState. Will put the code in new files.
>> +
>> +/* Papr Section 7.4.9 ibm,configure-kernel-dump RTAS call */
>> +static __attribute((unused)) void rtas_configure_kernel_dump(PowerPCCPU *cpu,
>> +                                   SpaprMachineState *spapr,
>> +                                   uint32_t token, uint32_t nargs,
>> +                                   target_ulong args,
>> +                                   uint32_t nret, target_ulong rets)
> I don't know about adding a new unused function like this, is there
> a way to juggle patches around to add it when it's wired up?

Ah, that is problematic agreed. I tried to move around things, but 
arrived at this.

I will spend some time thinking how to arrange this.

Will need some guidance. How should I approach arranging the code in 
such situations ?

My idea was to
* First one is the skeleton: mentions the steps, but doesn't implement 
the steps
* Middle patches implement the steps one by one
* Last patch enables it all. So in future if someone checks out the 
"Enable fadump" commit they would have all the support ready.

The major problem is "everything" remains unused till this last patch. 
But this 1st patch gave me the chance to logically build upon this, eg. 
first implement preserving memory regions, then add the fadump_trigger 
in os-term rtas call, etc.

Any advice to approach this ?

>> +{
>> +    struct rtas_fadump_section_header header;
>> +    target_ulong cmd = rtas_ld(args, 0);
>> +    target_ulong fdm_addr = rtas_ld(args, 1);
>> +    target_ulong fdm_size = rtas_ld(args, 2);
>> +
>> +    /* Number outputs has to be 1 */
>> +    if (nret != 1) {
>> +        qemu_log_mask(LOG_GUEST_ERROR,
>> +                "FADUMP: ibm,configure-kernel-dump RTAS called with nret != 1.\n");
>> +        return;
>> +    }
>> +
>> +    /* Number inputs has to be 3 */
>> +    if (nargs != 3) {
>> +        rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
>> +        return;
>> +    }
>> +
>> +    switch (cmd) {
>> +    case FADUMP_CMD_REGISTER:
>> +        if (fadump_metadata.fadump_registered) {
>> +            /* Fadump already registered */
>> +            rtas_st(rets, 0, RTAS_OUT_DUMP_ALREADY_REGISTERED);
>> +            return;
>> +        }
>> +
>> +        if (fadump_metadata.fadump_dump_active == 1) {
>> +            rtas_st(rets, 0, RTAS_OUT_DUMP_ACTIVE);
>> +            return;
>> +        }
>> +
>> +        if (fdm_size < sizeof(struct rtas_fadump_section_header)) {
>> +            qemu_log_mask(LOG_GUEST_ERROR,
>> +                "FADUMP: Header size is invalid: %lu\n", fdm_size);
>> +            rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
>> +            return;
>> +        }
>> +
>> +        /* XXX: Can we ensure fdm_addr points to a valid RMR-memory buffer ? */
> RMR memory? There is spapr_rma_size() if that's what you need?


Thanks, will use `spapr_rma_size`. The PAPR says fdm_addr should point 
to a valid RMR buffer, I guess that means it should be in the RMA, ie. 
`< spapr_rma_size()` ?


- Aditya G

>
> Thanks,
> Nick

