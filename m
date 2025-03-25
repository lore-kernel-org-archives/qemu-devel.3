Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23726C36008
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 17:40:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tx8Fe-0001eV-6Z; Tue, 25 Mar 2025 13:39:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1tx8Fc-0001da-9m; Tue, 25 Mar 2025 13:39:44 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1tx8Fa-0002CD-De; Tue, 25 Mar 2025 13:39:44 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52PGvlEq023763;
 Tue, 25 Mar 2025 17:39:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=oV17Qf
 hId4Nkk1DSlmVGSy/a1QiAbLzFlHPWbBVvGHo=; b=mqRdvJmd+vD9jrXjeCujYW
 fntaApCTZWme8/ToaNamwOkIdAwckzrH38QgMqSJmceZCKym3fKXOh7MIHVyOLBD
 iUsedBv7MCGkaYbPV8PMRE37a4c/i67BjFLEbEyiti4S3s2HKLtyBeA922hpDSBv
 gkiamrt0tM4FgcUuMvkfHzloEdF5Vy7nd165myLSfmqxZvAfqjbT5VtmuHvfkhkb
 rSv6buwnksOnHSJJeWxqIcjTz4Jhz9vXr6sEL2v74NmsGLGJM0q+7lARaLqwa4K1
 jzoL2o6AqVDoG6UeIcxFuAHEC3+PrEvLGtNVP/kOJ+2B7iP5PmzLjNWO04u11QtA
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45kekyw6n3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 25 Mar 2025 17:39:39 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52PHF4bc026878;
 Tue, 25 Mar 2025 17:39:38 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45kekyw6n2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 25 Mar 2025 17:39:38 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52PE7BuC009585;
 Tue, 25 Mar 2025 17:39:37 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 45j9rkmamw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 25 Mar 2025 17:39:37 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 52PHdYlV35783206
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 25 Mar 2025 17:39:34 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 45AD320043;
 Tue, 25 Mar 2025 17:39:34 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 52FA920040;
 Tue, 25 Mar 2025 17:39:32 +0000 (GMT)
Received: from [9.39.16.55] (unknown [9.39.16.55])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 25 Mar 2025 17:39:32 +0000 (GMT)
Message-ID: <e72ff61d-6194-4993-9672-1be0fb6f0c00@linux.ibm.com>
Date: Tue, 25 Mar 2025 23:09:31 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 06/10] ppc/pnv: Introduce Pnv11Chip
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?=
 <fbarrat@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
References: <20250325112319.927190-1-adityag@linux.ibm.com>
 <20250325112319.927190-7-adityag@linux.ibm.com>
 <e81f326c-23ea-4608-aa7b-7d49d5362ddb@kaod.org>
Content-Language: en-US
From: Aditya Gupta <adityag@linux.ibm.com>
In-Reply-To: <e81f326c-23ea-4608-aa7b-7d49d5362ddb@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: CudDjpwU6aj-g6PjGnTh-npk2s80xBpl
X-Proofpoint-GUID: CoaESqpClpOYRoTPWq4jW8aXyRzEj2Y0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-25_07,2025-03-25_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0
 adultscore=0 impostorscore=0 malwarescore=0 spamscore=0 bulkscore=0
 mlxlogscore=744 mlxscore=0 lowpriorityscore=0 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503250119
Received-SPF: pass client-ip=148.163.158.5; envelope-from=adityag@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 25/03/25 22:50, Cédric Le Goater wrote:

> On 3/25/25 12:23, Aditya Gupta wrote:
>> Implement Pnv11Chip, currently without chiptod, xive and phb.
>>
>> Chiptod, XIVE, PHB are implemented in later patches.
>>
>> Since Power11 core is same as Power10, the implementation of Pnv11Chip
>> is a duplicate of corresponding Pnv10Chip.
>>
>> Cc: Cédric Le Goater <clg@kaod.org>
>> Cc: Frédéric Barrat <fbarrat@linux.ibm.com>
>> Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>
>> Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
>> Cc: Nicholas Piggin <npiggin@gmail.com>
>> Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
>
>
> Looks correct, one comment below.
>
> Anyhow,
>
> Reviewed-by: Cédric Le Goater <clg@redhat.com>
>
>
>> <...snip...>
>>
>> +    object_initialize_child(obj, "adu",  &chip11->adu, TYPE_PNV_ADU);
>> +    object_initialize_child(obj, "psi", &chip11->psi, TYPE_PNV11_PSI);
>> +    object_initialize_child(obj, "lpc", &chip11->lpc, TYPE_PNV11_LPC);
>> +    object_initialize_child(obj, "occ",  &chip11->occ, TYPE_PNV11_OCC);
>> +    object_initialize_child(obj, "sbe",  &chip11->sbe, TYPE_PNV11_SBE);
>> +    object_initialize_child(obj, "homer", &chip11->homer, 
>> TYPE_PNV11_HOMER);
>
>
> As said earlier, if the models of the HW units above are the same
> on P10 an P11, you could simply use the P10 types. That's fine.
> Just add a little comment.
>
Sure, made that change in my tree. And thanks for the tag Cédric !


- Aditya Gupta

>
> Thanks,
>
> C.
>
>

