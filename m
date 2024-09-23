Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72BA2CF9C5B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2024 07:00:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ssd3U-0001gV-1S; Mon, 23 Sep 2024 03:00:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1ssd3E-0001a3-AH; Mon, 23 Sep 2024 03:00:06 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1ssd3C-0000Qk-6M; Mon, 23 Sep 2024 03:00:03 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48MHdHpg020479;
 Mon, 23 Sep 2024 07:00:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=E
 iAEJGlYchNwpsFiO40VodyAAeOaIK8U8DUZYNPUyko=; b=J+YIXN0k1vc58ytOB
 dAfqBp6m9ej+l/p5moHJ3x3FtnxKGRG5ljghWjJJPotwqSNSxF/ycPpPC4KURUq2
 Q5ICnf9jT5CZOgEY/2ODNU3/sV1a2ckm1Bym8gBvgGFKVkluWChSf/zMvXMXYXZc
 ahSnh6mawOhTNwL5wfBFncZRAUGmIUHgEMU9UtijxzR0gEhzUPU/G4UXVzbl/8i1
 EMbSlzixx9CLzPp9xfw812Q8lL8eiQ5zdn29ElS3k6m8GMebEEcsN2escmsRqmDl
 7F2aUTjMaH4gDH4l3CUX0ufFzXprd7d3hTGGfb0JhKITy95FNKTNmY9r39k25XLP
 Y4rUw==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41skjra1dd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 23 Sep 2024 06:59:59 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 48N6xxkg021786;
 Mon, 23 Sep 2024 06:59:59 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41skjra1d8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 23 Sep 2024 06:59:59 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48N3sDEw012530;
 Mon, 23 Sep 2024 06:59:58 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41t9fpn1a0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 23 Sep 2024 06:59:58 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 48N6xtcZ44761464
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 23 Sep 2024 06:59:55 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0009E2004D;
 Mon, 23 Sep 2024 06:59:54 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 967EA20040;
 Mon, 23 Sep 2024 06:59:53 +0000 (GMT)
Received: from [9.109.199.38] (unknown [9.109.199.38])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 23 Sep 2024 06:59:53 +0000 (GMT)
Message-ID: <28ccb5c2-dca5-4475-a9c4-bb199fef8578@linux.ibm.com>
Date: Mon, 23 Sep 2024 12:29:52 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] ppc/spapr: Change printf format to %HWADDR_PRId for
 MIN_RMA_SLOF
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>
References: <20240912065207.508808-1-adityag@linux.ibm.com>
 <c960cbd9-dc19-4f96-b5f4-cbd3c5c9bcf2@linaro.org>
Content-Language: en-US
From: Aditya Gupta <adityag@linux.ibm.com>
In-Reply-To: <c960cbd9-dc19-4f96-b5f4-cbd3c5c9bcf2@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Y6nfKaMSFuJ1T4BNrUh5n-LZU8nyvi58
X-Proofpoint-ORIG-GUID: 7IfnW9XIACO2ZM7t1qIS6jj6lyWPqY_X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-23_03,2024-09-19_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 priorityscore=1501
 spamscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0
 clxscore=1011 malwarescore=0 mlxlogscore=999 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2409230047
Received-SPF: pass client-ip=148.163.158.5; envelope-from=adityag@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Hi Philippe,


Sorry for the late reply.


On 12/09/24 12:34, Philippe Mathieu-Daudé wrote:
> Hi Aditya,
>
> On 12/9/24 08:52, Aditya Gupta wrote:
>> Currently starting a pSeries machine, with lesser than 128MiB shows
>> below error:
>>
>>      qemu-system-ppc64: pSeries SLOF firmware requires >= 80ldMiB 
>> guest RMA (Real Mode Area memory)
>>
>> Above '80ldMib' is in hex, and it means 0x80 MiB = 128 MiB.
>>
>> Change format specifier for this value to use 'HWADDR_PRId', instead of
>> 'HWADDR_PRIx' thus showing decimal value instead of hex.
>>
>> Thus, change the message to below error:
>>
>>      qemu-system-ppc64: pSeries SLOF firmware requires >= 128MiB 
>> guest RMA (Real Mode Area memory)
>>
>> Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
>>
>> ---
>> This is an RFC, as it confused me why does QEMU print that error even 
>> with '-m' >80 MB.
>>
>> This patch can also be considered a personal preference to see it as 
>> a decimal value instead of hex.
>>
>> Or maybe we can have '0x80 MiB' instead ?
>
> Simply use size_to_str(), see hw/ppc/pnv.c:
>
>     /* allocate RAM */
>     if (machine->ram_size < mc->default_ram_size) {
>         char *sz = size_to_str(mc->default_ram_size);
>         error_report("Invalid RAM size, should be bigger than %s", sz);
>         g_free(sz);
>         exit(EXIT_FAILURE);
>     }
>
I would prefer the existing printf approach, as it seems simple to me, 
but can change to use 'size_to_str' if that's the generally accepted 
approach. What do you say ?


Thanks,

Aditya Gupta

>> Does the 'ldMiB' actually mean that the value is in hexadecimal ? I 
>> did not find a reason in git history.
>> ---
>> ---
>>   hw/ppc/spapr.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>> index 8aa3ce7449be..b2ddacc6dd01 100644
>> --- a/hw/ppc/spapr.c
>> +++ b/hw/ppc/spapr.c
>> @@ -2819,8 +2819,8 @@ static hwaddr spapr_rma_size(SpaprMachineState 
>> *spapr, Error **errp)
>>         if (rma_size < MIN_RMA_SLOF) {
>>           error_setg(errp,
>> -                   "pSeries SLOF firmware requires >= %" HWADDR_PRIx
>> -                   "ldMiB guest RMA (Real Mode Area memory)",
>> +                   "pSeries SLOF firmware requires >= %" HWADDR_PRId
>> +                   "MiB guest RMA (Real Mode Area memory)",
>>                      MIN_RMA_SLOF / MiB);
>>           return 0;
>>       }
>
> Amusingly MIN_RMA_SLOF is a constant:
>
> #define MIN_RMA_SLOF            (128 * MiB)
>
> Anyhow it could be changed, so better not hard-code the value in the
> error message. Your patch becomes:
>
>      if (rma_size < MIN_RMA_SLOF) {
> -        error_setg(errp,
> -                   "pSeries SLOF firmware requires >= %" HWADDR_PRIx
> -                   "ldMiB guest RMA (Real Mode Area memory)",
> -                   MIN_RMA_SLOF / MiB);
> +        g_autofree char *min_rma_size_str = size_to_str(MIN_RMA_SLOF);
> +
> +        error_setg(errp, "pSeries SLOF firmware requires >= %s guest"
> +                         "RMA (Real Mode Area memory)", 
> min_rma_size_str);
>          return 0;
>      }
>
> Regards,
>
> Phil.

