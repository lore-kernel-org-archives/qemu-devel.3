Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D9EEC3DA5D
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 09:23:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVpFx-0001QY-Bb; Mon, 22 Jul 2024 05:22:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1sVpFs-0001Fm-TT; Mon, 22 Jul 2024 05:22:53 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1sVpFm-0007dm-5w; Mon, 22 Jul 2024 05:22:48 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46M7ToCp014429;
 Mon, 22 Jul 2024 09:17:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=0
 RpKGXELt3c+sfZUJmA2NCxvEbtjbFY+kiPpqg7OBbI=; b=iV1YFWI0rSslI6Snt
 jY2JxAt2clriPzaEWJsp29zwIdCpnY8VXtzGKLSq7F8Jp9lFrygiTLQYJPzR97y0
 MVCh90WXE8eIOtN8zuwdTxpmVskka4KAo4H7bnmTzb1HOeL1bRIHfBxxplJUQ++O
 GgEBk9WDjNXo2XKoftS0xZhifqODgyIaAxDFrF5N3Se4EmPM69xTe+chNO5DkXUo
 xnAHCJmmdA9e6XdxyMjVB3SHkNPFurfcecvAeW2ZG9qjYvGJtPpr6LOZ843l+zKy
 QT8oeSKOPqTV/RFKN/Gn/k0LEvn1jKHmobi/hm9o1pu3T/i/my3lQBLMbM+KWPre
 ePiVA==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40hk2xg729-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 22 Jul 2024 09:17:27 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 46M9HQ61007391;
 Mon, 22 Jul 2024 09:17:27 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40hk2xg725-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 22 Jul 2024 09:17:26 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 46M8sd2e005890; Mon, 22 Jul 2024 09:17:26 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40gy2p4e76-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 22 Jul 2024 09:17:26 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 46M9HKHG48693734
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 22 Jul 2024 09:17:22 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6B14320043;
 Mon, 22 Jul 2024 09:17:20 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D4E392004F;
 Mon, 22 Jul 2024 09:17:17 +0000 (GMT)
Received: from [9.109.199.72] (unknown [9.109.199.72])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 22 Jul 2024 09:17:17 +0000 (GMT)
Message-ID: <00d202a7-03dd-4cb0-8e02-3c49a025e284@linux.ibm.com>
Date: Mon, 22 Jul 2024 14:47:16 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ppc/pnv: Update Power10's cfam id to use Power10 DD2
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>
References: <20240502062701.1379833-1-adityag@linux.ibm.com>
 <a1e529e9-32b2-438a-b50d-10117296d4e1@kaod.org>
Content-Language: en-US
From: Aditya Gupta <adityag@linux.ibm.com>
In-Reply-To: <a1e529e9-32b2-438a-b50d-10117296d4e1@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 8HOMncvn_sOp0bGhwK52wyX6U5iK7qO5
X-Proofpoint-GUID: -CTkVOfcrB_F5T5hACPjeI4PZLPstVNd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-22_05,2024-07-18_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015
 adultscore=0 spamscore=0 priorityscore=1501 mlxlogscore=999 mlxscore=0
 bulkscore=0 malwarescore=0 impostorscore=0 phishscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2407220068
Received-SPF: pass client-ip=148.163.158.5; envelope-from=adityag@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H3=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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

Hello,

Any comments on this change ?

Though this isn't urgent and won't change behaviour much, mainly other 
than skiboot recognising the chip as P10 DD2.


Thanks

- Aditya Gupta


On 02/05/24 13:51, Cédric Le Goater wrote:

> On 5/2/24 08:27, Aditya Gupta wrote:
>> Power10 DD1.0 was dropped in:
>>
>>      commit 8f054d9ee825 ("ppc: Drop support for POWER9 and POWER10 
>> DD1 chips")
>>
>> Use the newer Power10 DD2 chips cfam id.
>>
>> Cc: Cédric Le Goater <clg@kaod.org>
>> Cc: David Gibson <david@gibson.dropbear.id.au>
>> Cc: Frédéric Barrat <fbarrat@linux.ibm.com>
>> Cc: Laurent Vivier <lvivier@redhat.com>
>> Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>
>> Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
>> Cc: Nicholas Piggin <npiggin@gmail.com>
>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>> Cc: Thomas Huth <thuth@redhat.com>
>> Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
>
>
> Reviewed-by: Cédric Le Goater <clg@redhat.com>
>
> Thanks,
>
> C.
>
>
>> ---
>>   hw/ppc/pnv.c            | 2 +-
>>   tests/qtest/pnv-xscom.h | 2 +-
>>   2 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
>> index 6e3a5ccdec76..06a4e4d13948 100644
>> --- a/hw/ppc/pnv.c
>> +++ b/hw/ppc/pnv.c
>> @@ -2090,7 +2090,7 @@ static void 
>> pnv_chip_power10_class_init(ObjectClass *klass, void *data)
>>       PnvChipClass *k = PNV_CHIP_CLASS(klass);
>>       static const int i2c_ports_per_engine[PNV10_CHIP_MAX_I2C] = 
>> {14, 14, 2, 16};
>>   -    k->chip_cfam_id = 0x120da04900008000ull; /* P10 DD1.0 (with 
>> NX) */
>> +    k->chip_cfam_id = 0x220da04980000000ull; /* P10 DD2.0 (with NX) */
>>       k->cores_mask = POWER10_CORE_MASK;
>>       k->chip_pir = pnv_chip_pir_p10;
>>       k->intc_create = pnv_chip_power10_intc_create;
>> diff --git a/tests/qtest/pnv-xscom.h b/tests/qtest/pnv-xscom.h
>> index 6f62941744a6..5aa1701ea768 100644
>> --- a/tests/qtest/pnv-xscom.h
>> +++ b/tests/qtest/pnv-xscom.h
>> @@ -56,7 +56,7 @@ static const PnvChip pnv_chips[] = {
>>           .chip_type  = PNV_CHIP_POWER10,
>>           .cpu_model  = "POWER10",
>>           .xscom_base = 0x000603fc00000000ull,
>> -        .cfam_id    = 0x120da04900008000ull,
>> +        .cfam_id    = 0x220da04980000000ull,
>>           .first_core = 0x0,
>>           .num_i2c    = 4,
>>       },
>

