Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28993C36008
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 07:14:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twc0Q-0002Z4-JT; Mon, 24 Mar 2025 03:13:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1twc0O-0002Xg-Gh; Mon, 24 Mar 2025 03:13:52 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1twc0M-0000Wr-Pz; Mon, 24 Mar 2025 03:13:52 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52NKeB2B027468;
 Mon, 24 Mar 2025 07:13:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=Bj/ph5
 rohYlJAZkx9Jm0X6zH5p2DC6OecRuf09JtLFs=; b=sMsdR9Org/1QdIE38fDAKq
 HIyhMIPHfnaZlkh5J3LZjyMmNHnd9OIcYG45NSNPBh8BRqVX2nJfwNig5xXvpURD
 0VazHA6CrGHZgmplJhIjv4+GbnVc3RTLHulNsDesjTJzav2NGpRNh5KBokWCZ7/2
 cbX6KlBxDOPTPwvxHndgTiwlk4nuMYkfDNpQTJ/bk6JAomJuIJYUBHUQEUL1YfAP
 cyDYzOZdJUk5PqHpF1pDcbjaP+HrYbcZtWL/0WaCJad9IhUPj4LEsEqU58ZWPcPL
 vKw5O/N19U3GzkBZAyJmqSgyFdsOxIJDb/mFEHQ/RaQqkCJGmaje79xMNd7gX4tA
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45jjb4ubat-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 24 Mar 2025 07:13:40 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52O7Brlf000756;
 Mon, 24 Mar 2025 07:13:40 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45jjb4ubap-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 24 Mar 2025 07:13:39 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52O4mCBD009709;
 Mon, 24 Mar 2025 07:13:39 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 45j9rkcuwq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 24 Mar 2025 07:13:38 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 52O7DZ9s54264108
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Mar 2025 07:13:35 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 290D12004B;
 Mon, 24 Mar 2025 07:13:35 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4CADF20040;
 Mon, 24 Mar 2025 07:13:33 +0000 (GMT)
Received: from [9.109.199.160] (unknown [9.109.199.160])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 24 Mar 2025 07:13:33 +0000 (GMT)
Message-ID: <337b1a39-ed5f-4737-a98a-1ed2784aef7b@linux.ibm.com>
Date: Mon, 24 Mar 2025 12:43:32 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 7/8] ppc/pnv: Add a Power11 Pnv11Chip, and a Power11
 Machine
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
References: <20250308205141.3219333-1-adityag@linux.ibm.com>
 <20250308205141.3219333-8-adityag@linux.ibm.com>
 <bce5dcfc-24d2-41e2-b11e-7cb5967f2132@kaod.org>
Content-Language: en-US
From: Aditya Gupta <adityag@linux.ibm.com>
In-Reply-To: <bce5dcfc-24d2-41e2-b11e-7cb5967f2132@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: I0HNRdAOnMxe5KNyiGEhi-GCdHnLpexY
X-Proofpoint-ORIG-GUID: PKb0eHPVTWWJcgxXeZjUrZUe-eKr5lme
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-24_03,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 malwarescore=0 phishscore=0 clxscore=1015 priorityscore=1501
 mlxlogscore=999 suspectscore=0 bulkscore=0 adultscore=0 spamscore=0
 mlxscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503240049
Received-SPF: pass client-ip=148.163.156.1; envelope-from=adityag@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.01, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 09/03/25 19:38, Cédric Le Goater wrote:
> On 3/8/25 21:51, Aditya Gupta wrote:
>> <...snip...>
>>
>>   static void pnv_chip_power8_instance_init(Object *obj)
>>   {
>>       Pnv8Chip *chip8 = PNV8_CHIP(obj);
>> @@ -1966,6 +1996,20 @@ static void 
>> pnv_chip_power10_instance_init(Object *obj)
>>       PnvChipClass *pcc = PNV_CHIP_GET_CLASS(obj);
>>       int i;
>>   +    /*
>> +     * Power11 declares Power10 as it's parent class, to be able to 
>> reuse
>> +     * most of the Power10 code.
>> +     * But this causes Power10 and Power11's both instance init to be
>> +     * called for PowerNV11 chip
>> +     *
>> +     * Skip initialising Power10 specific child objects, if the chip is
>> +     * Power11 chip, in which case power11's instance init will 
>> initialise
>> +     * the child objects
>> +     */
>> +    if (!strcmp(object_get_typename(obj), TYPE_PNV_CHIP_POWER11)) {
>> +        return;
>> +    }
>> +
>
> This is a hack !  Please duplicate the code like done for other chips.
>
>
>> <...snip...>
>>
>>   +    /*
>> +     * P11 chip and variants
>> +     */
>> +    {
>> +        .name          = TYPE_PNV11_CHIP,
>> +        .parent        = TYPE_PNV10_CHIP,
>
> why is the parent not TYPE_PNV_CHIP like the other chips ?
>
> This is a hack which can be easily avoided with more work :)


When I do this, every function using Pnv10Chip* will need to be 
duplicated to use Pnv11Chip*.

I will do that.

But what do you say about changing Pnv10 chip to Pnv1x chip ? It may 
only be used by Pnv10 and Pnv11, not future chips. But is that 
unnecessary for just two versions of the chip ?

Just tried to think of some ways to reduce duplication, or having 
different files such as pnv10.c, pnv11.c ? I am not sure because these 
might be unnecessary things too.


Thanks,

- Aditya G


