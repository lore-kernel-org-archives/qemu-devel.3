Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACA0DC4345F
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2024 13:23:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s29vN-0002jr-TC; Wed, 01 May 2024 09:23:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1s29vM-0002i5-5r; Wed, 01 May 2024 09:23:04 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1s29vK-0002Cl-07; Wed, 01 May 2024 09:23:03 -0400
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 441DLTr8003190; Wed, 1 May 2024 13:22:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=wnJpLET2NCd+tIVa4lgTVXo3kQkDLNPr7ct0EFpxOTI=;
 b=bVXAdsUPjG+Of7OXzMKHDjhVNdfxo6wkZ+QJdLRDdJM5/rhtvYPKAuYCdTIRsB2atdTg
 qUAQq4GaAI7KBrs2iIzbCdWB6I14D/qSdg/ENevE/gFxF2Ox79ap9OrRigCAzwPagzY2
 giiBYDdDU4iOAAxUdW3Xhji6RUn1hL96rqFRIjPD2ev9vCEPJpgA8QlcbCPJ21BgKzBF
 Z3C1u2bZKg+A+LhkapMFhu5uNC7XWyTwht8FtI3D41015si8Rh50vWw54P2nAbANMRkJ
 XaZzkKTE2LwVQIulZQCwScV5EZ/pApI45mG5PnZp/QKXSoc/Tid6nM9o2E9MqlqSTGWi 2w== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xunwqg3fp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 01 May 2024 13:22:46 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 441DMkQF004993;
 Wed, 1 May 2024 13:22:46 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xunwqg3fm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 01 May 2024 13:22:46 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 441D3JNG003184; Wed, 1 May 2024 13:22:45 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xscppjmer-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 01 May 2024 13:22:45 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 441DMdcB50856284
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 1 May 2024 13:22:42 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E26B220065;
 Wed,  1 May 2024 13:22:39 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8A4992006E;
 Wed,  1 May 2024 13:22:37 +0000 (GMT)
Received: from [9.171.6.168] (unknown [9.171.6.168])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  1 May 2024 13:22:37 +0000 (GMT)
Message-ID: <358a26db-d447-453d-8313-376f00e8c902@linux.ibm.com>
Date: Wed, 1 May 2024 18:52:36 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/10] ppc/pseries: Add Power11 cpu type
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
References: <20240426110023.733309-1-adityag@linux.ibm.com>
 <20240426110023.733309-2-adityag@linux.ibm.com>
 <d35b2a2d-1307-46bf-81ae-747a0e62d6be@kaod.org>
 <p57z4il36laqlccge3llmbzveepyzad7dokxpoipxh22t2y2s3@tsiegjpijeas>
 <f39f0e4a-6f9f-45f7-9f84-1663f20cd755@kaod.org>
Content-Language: en-US
From: Aditya Gupta <adityag@linux.ibm.com>
In-Reply-To: <f39f0e4a-6f9f-45f7-9f84-1663f20cd755@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: YtluhwjSHHADdq0GwplDg7gXsLNJh4Cz
X-Proofpoint-GUID: Iy31RIidlhCwewsopqMpFPVHOvg292mv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-01_12,2024-04-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 impostorscore=0 spamscore=0 phishscore=0
 clxscore=1015 bulkscore=0 adultscore=0 malwarescore=0 mlxlogscore=714
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2405010092
Received-SPF: pass client-ip=148.163.158.5; envelope-from=adityag@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
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

Hi Cédric,

 > diff --git a/target/ppc/cpu-models.h b/target/ppc/cpu-models.h
>>>> index 0229ef3a9a5c..a1b540c3aa9e 100644
>>>> --- a/target/ppc/cpu-models.h
>>>> +++ b/target/ppc/cpu-models.h
>>>> @@ -354,6 +354,7 @@ enum {
>>>>        CPU_POWERPC_POWER10_BASE       = 0x00800000,
>>>>        CPU_POWERPC_POWER10_DD1        = 0x00801100,
>>>>        CPU_POWERPC_POWER10_DD20       = 0x00801200,
>>>> +    CPU_POWERPC_POWER11            = 0x00821200,
>>>
>>> is that a DD2.2 PVR ? If so, It should be mentionned in the definition.
>>>
>>
>> Yes, I have kept the last 2 bytes same as P10 DD2. I will mention it
>> above the line I have added it, in v3.
>
> Skiboot reports :
>
> [    0.121234172,6] P11 DD1.00 detected
>
It is a DD2.0, with major revision = 0x2, and minor revision = 0. Might 
need some change in skiboot. Will post a v3 series with changes.


Thanks,

- Aditya Gupta

>
> C.

