Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36C64C3DA63
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 04:37:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sW7Gr-0001F6-6k; Tue, 23 Jul 2024 00:37:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1sW7Gk-0000zC-G4; Tue, 23 Jul 2024 00:36:58 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1sW7Gh-0004BY-W3; Tue, 23 Jul 2024 00:36:58 -0400
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46N4RorD016067;
 Tue, 23 Jul 2024 04:36:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=C
 jChgPvhiEbL8tGTCQ7xphX7txq4oBjGyQzcVIC00Zw=; b=HVX1elTLdPzs87gWA
 9Qo+XvcSNbqcahxVisSm0c1xV/tih97vOA4ukk6fc8eyN5lLcwSM0CrEM3pN56pD
 h2DjvIEeqvECb9sSRcHf4aaNK2apjhr8a9aAlIyw8xbXhCdKe1lSrxF+I+Vfe2CV
 VrcyMqS42JUJTJ+VIUnhqLBsWEbE7rdJabt/gG2VlB83M4p0trRuBaZMWV5KwLNM
 g1ip+wIPALr7lwo1Jmmt2SSqF/4ApNOogDAUIlM4jTn6nkrbQvyWXZHXEj/qn50i
 YC8q7qmpSO/Jsx85PzS/upTu+LOskeJ7jeDrQ9S0adnvYab7NDCiIHtYvr3GqxeN
 FvRPA==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40hva3gyjx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Jul 2024 04:36:42 +0000 (GMT)
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 46N4agjQ028623;
 Tue, 23 Jul 2024 04:36:42 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40hva3gyju-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Jul 2024 04:36:42 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 46N11P3i005870; Tue, 23 Jul 2024 04:36:41 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40gy2p8krj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Jul 2024 04:36:41 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 46N4aZHt13173052
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 23 Jul 2024 04:36:37 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 70F4320043;
 Tue, 23 Jul 2024 04:36:35 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3F46E20040;
 Tue, 23 Jul 2024 04:36:33 +0000 (GMT)
Received: from [9.109.199.72] (unknown [9.109.199.72])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 23 Jul 2024 04:36:33 +0000 (GMT)
Message-ID: <1b1dabb8-ce2d-4914-bd23-a174e1a3fc08@linux.ibm.com>
Date: Tue, 23 Jul 2024 10:06:32 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ppc/pnv: Update Power10's cfam id to use Power10 DD2
To: Nicholas Piggin <npiggin@gmail.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>
References: <20240502062701.1379833-1-adityag@linux.ibm.com>
 <a1e529e9-32b2-438a-b50d-10117296d4e1@kaod.org>
 <00d202a7-03dd-4cb0-8e02-3c49a025e284@linux.ibm.com>
 <D2WMNDZEGNYY.2OPUMBFIEPTLI@gmail.com>
Content-Language: en-US
From: Aditya Gupta <adityag@linux.ibm.com>
In-Reply-To: <D2WMNDZEGNYY.2OPUMBFIEPTLI@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: dfLPke-PLVxyj8EvPsnHx8mN2UnDtUAe
X-Proofpoint-ORIG-GUID: l-tOySByyTZquKI8V8ICOFst2WDkl7BA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-22_18,2024-07-23_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 mlxscore=0 spamscore=0
 phishscore=0 mlxlogscore=999 impostorscore=0 lowpriorityscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407230030
Received-SPF: pass client-ip=148.163.158.5; envelope-from=adityag@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

Hi Nick,

On 23/07/24 09:48, Nicholas Piggin wrote:

> On Mon Jul 22, 2024 at 7:17 PM AEST, Aditya Gupta wrote:
>> Hello,
>>
>> Any comments on this change ?
>>
>> Though this isn't urgent and won't change behaviour much, mainly other
>> than skiboot recognising the chip as P10 DD2.
> Hey Aditya,
>
> Yeah I missed this in my last PR but I have it in my tree.

Got it, thank you !


- Aditya Gupta

> Thanks,
> Nick
>
>>
>> Thanks
>>
>> - Aditya Gupta
>>
>>
>> On 02/05/24 13:51, Cédric Le Goater wrote:
>>
>>> On 5/2/24 08:27, Aditya Gupta wrote:
>>>> Power10 DD1.0 was dropped in:
>>>>
>>>>       commit 8f054d9ee825 ("ppc: Drop support for POWER9 and POWER10
>>>> DD1 chips")
>>>>
>>>> Use the newer Power10 DD2 chips cfam id.
>>>>
>>>> Cc: Cédric Le Goater <clg@kaod.org>
>>>> Cc: David Gibson <david@gibson.dropbear.id.au>
>>>> Cc: Frédéric Barrat <fbarrat@linux.ibm.com>
>>>> Cc: Laurent Vivier <lvivier@redhat.com>
>>>> Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>
>>>> Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
>>>> Cc: Nicholas Piggin <npiggin@gmail.com>
>>>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>>>> Cc: Thomas Huth <thuth@redhat.com>
>>>> Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
>>>
>>> Reviewed-by: Cédric Le Goater <clg@redhat.com>
>>>
>>> Thanks,
>>>
>>> C.
>>>
>>>
>>>> ---
>>>>    hw/ppc/pnv.c            | 2 +-
>>>>    tests/qtest/pnv-xscom.h | 2 +-
>>>>    2 files changed, 2 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
>>>> index 6e3a5ccdec76..06a4e4d13948 100644
>>>> --- a/hw/ppc/pnv.c
>>>> +++ b/hw/ppc/pnv.c
>>>> @@ -2090,7 +2090,7 @@ static void
>>>> pnv_chip_power10_class_init(ObjectClass *klass, void *data)
>>>>        PnvChipClass *k = PNV_CHIP_CLASS(klass);
>>>>        static const int i2c_ports_per_engine[PNV10_CHIP_MAX_I2C] =
>>>> {14, 14, 2, 16};
>>>>    -    k->chip_cfam_id = 0x120da04900008000ull; /* P10 DD1.0 (with
>>>> NX) */
>>>> +    k->chip_cfam_id = 0x220da04980000000ull; /* P10 DD2.0 (with NX) */
>>>>        k->cores_mask = POWER10_CORE_MASK;
>>>>        k->chip_pir = pnv_chip_pir_p10;
>>>>        k->intc_create = pnv_chip_power10_intc_create;
>>>> diff --git a/tests/qtest/pnv-xscom.h b/tests/qtest/pnv-xscom.h
>>>> index 6f62941744a6..5aa1701ea768 100644
>>>> --- a/tests/qtest/pnv-xscom.h
>>>> +++ b/tests/qtest/pnv-xscom.h
>>>> @@ -56,7 +56,7 @@ static const PnvChip pnv_chips[] = {
>>>>            .chip_type  = PNV_CHIP_POWER10,
>>>>            .cpu_model  = "POWER10",
>>>>            .xscom_base = 0x000603fc00000000ull,
>>>> -        .cfam_id    = 0x120da04900008000ull,
>>>> +        .cfam_id    = 0x220da04980000000ull,
>>>>            .first_core = 0x0,
>>>>            .num_i2c    = 4,
>>>>        },

