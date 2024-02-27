Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C4D0C54798
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 17:45:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rf1Vh-0004nX-5p; Tue, 27 Feb 2024 12:44:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@linux.vnet.ibm.com>)
 id 1rf1Vf-0004fp-SD; Tue, 27 Feb 2024 12:44:55 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@linux.vnet.ibm.com>)
 id 1rf1Vd-0005X0-EU; Tue, 27 Feb 2024 12:44:55 -0500
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 41RGmaKU029806; Tue, 27 Feb 2024 17:44:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=GsiTSmHxSva/JpY+YXdU0a8q4ADVHBrCpAMFeva6+0M=;
 b=F55w6fymm+wkYfnOCufA6oW7vEv/WlXOSUj1qKJFNjQk79O5iCWMwOIpdBrlTK/XZMsz
 G0yHcf1TnOFbGNXvj0JYbRCwsvRleDU1i2r+3q/Vv5Pz9+51OYnQv21GKAiKllQagO1C
 89hdYMN+JnHZvbgS4NU4ww4/Y/aL0zTv9AyOCwaEqlRrQ7/8iQShwgHKji57hiKThNi0
 +Kz/eSsARL3NSJjN4IsGp8yuSxa/YVNCTPJNXSzFC0bokjkK70Y52Uz6/oaRrqr95Rli
 vFcQfOxDiaKRnPbI/+k9zLfuSNPGyS+kzYKXKa2S3xxy8jgDKtkpQorQmmTItc9a7ErO RA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3whkjysh6g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 Feb 2024 17:44:49 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41RHJBXP014023;
 Tue, 27 Feb 2024 17:44:49 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3whkjysh5v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 Feb 2024 17:44:49 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 41RHOppv024144; Tue, 27 Feb 2024 17:44:48 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wfw0k8w4q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 Feb 2024 17:44:48 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 41RHikoj28115626
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 27 Feb 2024 17:44:48 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1A0025805F;
 Tue, 27 Feb 2024 17:44:46 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A3C9058059;
 Tue, 27 Feb 2024 17:44:45 +0000 (GMT)
Received: from [9.10.254.104] (unknown [9.10.254.104])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 27 Feb 2024 17:44:45 +0000 (GMT)
Message-ID: <19e8d914-9ef9-4f5b-a105-78e88a432d27@linux.vnet.ibm.com>
Date: Tue, 27 Feb 2024 11:44:45 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] ppc/pnv: Fix pervasive topology calculation for P10
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, npiggin@gmail.com, fbarrat@linux.ibm.com
References: <20240227144844.23606-1-calebs@linux.vnet.ibm.com>
 <c084d751-fc21-4e9f-ab28-fc5889b8d9af@kaod.org>
Content-Language: en-US
From: Caleb Schlossin <calebs@linux.vnet.ibm.com>
In-Reply-To: <c084d751-fc21-4e9f-ab28-fc5889b8d9af@kaod.org>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: K0u-4N3QMC84efsRdNy-LIKiTO5gSWCh
X-Proofpoint-GUID: AySfgg42kTNykawvIo4PnS0p1uib0tcL
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-27_03,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 mlxlogscore=999 adultscore=0 mlxscore=0
 impostorscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402270136
Received-SPF: none client-ip=148.163.158.5;
 envelope-from=calebs@linux.vnet.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

Cedric,

I'll resend both patches, so this new patch shows up properly as [PATCH 2/2].

Thanks,
Caleb

On 2/27/24 10:15 AM, Cédric Le Goater wrote:
> Hello Caleb,
> 
> On 2/27/24 15:48, Caleb Schlossin wrote:
>> Pervasive topology(PIR) calculation for core, thread ID was
>> wrong for big cores (SMT8). Fixing for P10.
>>
>> Based on: <20240123195005.8965-1-calebs@linux.vnet.ibm.com>
>> Signed-off-by: Caleb Schlossin <calebs@linux.vnet.ibm.com>
> 
> Since the initial patch [1] is not merged yet, you can simply send a v2
> with the update. There is still some time before soft freeze [2].
> 
> The Subject of this patch [PATCH 2/2] seems to refer to a series. Is
> there a patch 1/2 ?
> 
> Thanks,
> 
> C.
> 
> 
> 
> [1] https://lore.kernel.org/all/20240123195005.8965-1-calebs@linux.vnet.ibm.com/
> [2] https://wiki.qemu.org/Planning/9.0
> 
>> ---
>>   hw/ppc/pnv.c | 15 +++++++++++++--
>>   1 file changed, 13 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
>> index 2f53883916..aa5aba60b4 100644
>> --- a/hw/ppc/pnv.c
>> +++ b/hw/ppc/pnv.c
>> @@ -1068,12 +1068,23 @@ static uint32_t pnv_chip_pir_p9(PnvChip *chip, uint32_t core_id,
>>       }
>>   }
>>   +/*
>> + *    0:48  Reserved - Read as zeroes
>> + *   49:52  Node ID
>> + *   53:55  Chip ID
>> + *   56     Reserved - Read as zero
>> + *   57:59  Quad ID
>> + *   60     Core Chiplet Pair ID
>> + *   61:63  Thread/Core Chiplet ID t0-t2
>> + *
>> + * We only care about the lower bits. uint32_t is fine for the moment.
>> + */
>>   static uint32_t pnv_chip_pir_p10(PnvChip *chip, uint32_t core_id,
>>                                    uint32_t thread_id)
>>   {
>>       if (chip->nr_threads == 8) {
>> -        return (chip->chip_id << 8) | ((thread_id & 1) << 2) | (core_id << 3) |
>> -               (thread_id >> 1);
>> +        return (chip->chip_id << 8) | ((core_id / 4) << 4) |
>> +               ((core_id % 2) << 3) | thread_id;
>>       } else {
>>           return (chip->chip_id << 8) | (core_id << 2) | thread_id;
>>       }
> 

