Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C353C282DE
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 18:57:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsnk5-0002Ky-DT; Thu, 13 Mar 2025 14:57:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1tsnjt-0002Kg-MH; Thu, 13 Mar 2025 14:57:05 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1tsnjr-0005kp-UN; Thu, 13 Mar 2025 14:57:05 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52DGo4MU003374;
 Thu, 13 Mar 2025 18:56:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=VJXdrd
 +1eaYMSNBLo//WDFb4Rchi205CRWFA8thjB4w=; b=pEKGXCzp/Wp4wSaTR5DHlF
 IF6oDFooPvXNLpvHjUwbGDDs6r+VsQk4lII0J6xo/HzYUhF1MFdcWXZPqCm4H3zV
 fsrAvj65/HGoS5w2iTOcoyKIef1PEOVUrBymmXGWYGiARHOQ9AFC0MM4LmRtYa4C
 t8Ve47QxbvLkYUlgAe3fPDJ2lClf4BjbYyVrMlNAR+48RPqDEk5kK5C+dRRJGXzH
 BhqKVH6zbv+aYNjRWV/5P+dDOfPqqihLw2SQVMKbx0HduO8zwIYXn4WtMpRZ9eyl
 1s3QSvsVhxcAyA5nUk7bIxUf7LCWsQF9cxDyF1IchhO0Kt5krAMAWdscOYCoRvQw
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45bhepnsg9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 13 Mar 2025 18:56:57 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52DIuvp2007283;
 Thu, 13 Mar 2025 18:56:57 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45bhepnsfu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 13 Mar 2025 18:56:57 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52DFdlkL007428;
 Thu, 13 Mar 2025 18:56:51 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45atsrbbe8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 13 Mar 2025 18:56:51 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 52DIulUb60096938
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 13 Mar 2025 18:56:48 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E365920043;
 Thu, 13 Mar 2025 18:56:47 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B715E20040;
 Thu, 13 Mar 2025 18:56:45 +0000 (GMT)
Received: from [9.124.223.53] (unknown [9.124.223.53])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 13 Mar 2025 18:56:45 +0000 (GMT)
Message-ID: <32011f77-ed4d-4c26-92d0-5ec139f1daa0@linux.ibm.com>
Date: Fri, 14 Mar 2025 00:26:44 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] hw/ppc: [WIP] Add Processor Dump Area offsets in Pnv
 SBE
To: Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>,
 Sourabh Jain <sourabhjain@linux.ibm.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Hari Bathini <hbathini@linux.ibm.com>
References: <20250217071934.86131-1-adityag@linux.ibm.com>
 <20250217071934.86131-7-adityag@linux.ibm.com>
 <72b6c824-7767-4dce-901f-806d291e1d98@linux.ibm.com>
Content-Language: en-US
From: Aditya Gupta <adityag@linux.ibm.com>
In-Reply-To: <72b6c824-7767-4dce-901f-806d291e1d98@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: zoP4HuJM7eUrbPzDBJ0PPHfXH9mIbmrZ
X-Proofpoint-ORIG-GUID: MIZEls27gDHG1XJv7S1mJJGOulGzOoEG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-13_08,2025-03-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 phishscore=0 spamscore=0
 suspectscore=0 mlxscore=0 malwarescore=0 clxscore=1015 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503130145
Received-SPF: pass client-ip=148.163.158.5; envelope-from=adityag@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

On 11/03/25 10:53, Harsh Prateek Bora wrote:

>
>
> On 2/17/25 12:49, Aditya Gupta wrote:
>> Add offsets for the processor state captured during MPIPL dump.
>>
>> This is incomplete. And might be implemented in future if the effort to
>> implement MPIPL is resumed again.
>
> Please use RFC prefix in next iteration of patch series until the 
> patches are requested to be merged.

Sorry I missed it, and just sent it as a normal patch series.

Will take care from next time.


>
>>
>> Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
>> ---
>>   hw/ppc/pnv_sbe.c | 27 +++++++++++++++++++++++++++
>>   1 file changed, 27 insertions(+)
>>
>> diff --git a/hw/ppc/pnv_sbe.c b/hw/ppc/pnv_sbe.c
>> index ee905df4e0a6..3b50667226b5 100644
>> --- a/hw/ppc/pnv_sbe.c
>> +++ b/hw/ppc/pnv_sbe.c
>> @@ -197,6 +197,25 @@ struct mdrt_table {
>>       __be64  padding;    /* unused */
>>   } __packed;
>>   +/*
>> + * Processor Dump Area
>> + *
>> + * This contains the information needed for having processor
>> + * state captured during a platform dump.
>> + */
>> +struct proc_dump_area {
>> +    __be32  thread_size;    /* Size of each thread register entry */
>> +#define PROC_DUMP_AREA_FORMAT_P9    0x1    /* P9 format */
>> +    uint8_t version;
>> +    uint8_t reserved[11];
>> +    __be64  alloc_addr;    /* Destination memory to place register 
>> data */
>> +    __be32  reserved2;
>> +    __be32  alloc_size;    /* Allocated size */
>> +    __be64  dest_addr;     /* Destination address */
>> +    __be32  reserved3;
>> +    __be32  act_size;      /* Actual data size */
>> +} __packed;
>> +
>
> Above should go into pnv_sbe.h and introduce when actually get used.

Sure, will take care of introducing only when used.


>
>>   static void pnv_sbe_set_host_doorbell(PnvSBE *sbe, uint64_t val)
>>   {
>>       val &= SBE_HOST_RESPONSE_MASK; /* Is this right? What does HW 
>> do? */
>> @@ -281,6 +300,11 @@ static void pnv_mpipl_preserve_mem(void)
>>       cpu_physical_memory_write(MDRT_TABLE_BASE, mdrt, MDRT_TABLE_SIZE);
>>   }
>>   +static void pnv_mpipl_save_proc_regs(void)
>> +{
>> +    /* TODO: modify PROC_DUMP_AREA_BASE */
>> +}
>> +
>>   static void pnv_sbe_power9_xscom_ctrl_write(void *opaque, hwaddr addr,
>>                                          uint64_t val, unsigned size)
>>   {
>> @@ -307,6 +331,9 @@ static void pnv_sbe_power9_xscom_ctrl_write(void 
>> *opaque, hwaddr addr,
>>               /* Preserve the memory locations registered for MPIPL */
>>               pnv_mpipl_preserve_mem();
>>   +            /* Save processor state */
>> +            pnv_mpipl_save_proc_regs();
>
> Introduce when actually get implemented, otherwise doesnt need a 
> separate patch for this stub.

Okay, I planned to implement it in this patch itself. Will implement in v2.


Thanks,

- Aditya G


>
>> +
>>               /*
>>                * TODO: Pass `mpipl` node in device tree to signify next
>>                * boot is an MPIPL boot

