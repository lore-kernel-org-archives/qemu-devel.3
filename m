Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 334CACCF9EB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 10:25:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE3L3-0001Ki-18; Wed, 29 Oct 2025 06:23:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vE3L0-0001K3-I2; Wed, 29 Oct 2025 06:23:30 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vE3Kw-0006Cr-4E; Wed, 29 Oct 2025 06:23:29 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59SJm0TZ025843;
 Wed, 29 Oct 2025 10:23:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=eQAccm
 gB8kLxzoxrhtMr/ynHZBmyJCMlEk310c2w4Os=; b=F7PehTcuhz97XolFF+FYJ0
 RcMSnaplROZ7yPv8d+g2Mxk3WPuEQPpzLgizaKZPusd7yKbbtAcu0mzd473AyE5N
 NoLKuEwqSV6ZgwDeNyYLTMVvQ7OlXBd38iXh6MUS7Ur8pOEYB0bTRekEPikvYy3j
 0py8Yw/hDbMz3SFNVAgYSfBjQUCBKU7Q3neofL9ZKXna95ogWOcyeVDgt5AfMjly
 Buq6eh0cTh8Pim6qHNhIVkkN15cJcvwBBV06Q98QhtFMv2540Joj7JmbL2tDfT9y
 UlUOUTu27kx8/7ogshMoSNN5iZlAXN/yprSSMZbbRLhvHnPEVs01yvRjkpx9eRrg
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a34aajjfg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 29 Oct 2025 10:23:16 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59TAHcpT010387;
 Wed, 29 Oct 2025 10:23:16 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a34aajjfd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 29 Oct 2025 10:23:16 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59T9fA0h031689;
 Wed, 29 Oct 2025 10:23:15 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4a33w02rde-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 29 Oct 2025 10:23:15 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59TAN2Mi56492290
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 29 Oct 2025 10:23:02 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3597758052;
 Wed, 29 Oct 2025 10:23:15 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5015E58045;
 Wed, 29 Oct 2025 10:23:13 +0000 (GMT)
Received: from [9.39.28.229] (unknown [9.39.28.229])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 29 Oct 2025 10:23:12 +0000 (GMT)
Message-ID: <b131d419-15a8-4b4a-8dbd-c6f4988679fa@linux.ibm.com>
Date: Wed, 29 Oct 2025 15:53:11 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/ppc/sam460ex: Update u-boot-sam460ex
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Thomas Huth <thuth@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org
References: <20251028151923.10DBB5972E5@zero.eik.bme.hu>
 <ee77b09f-7a12-4d52-b5f6-2d4b5b711448@linux.ibm.com>
 <f4c3bbb6-9a54-69ff-0d54-481ab4a55579@eik.bme.hu>
Content-Language: en-US
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <f4c3bbb6-9a54-69ff-0d54-481ab4a55579@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=ALkgKXG8 c=1 sm=1 tr=0 ts=6901eb14 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=GaQpPoNlAAAA:8
 a=qB1JzS8udnwjJoHLBn0A:9 a=QEXdDO2ut3YA:10 a=xF5q_uoM5gZT5J3czcBi:22
 a=oH34dK2VZjykjzsv8OSz:22 a=pHzHmUro8NiASowvMSCR:22 a=n87TN5wuljxrRezIQYnT:22
X-Proofpoint-ORIG-GUID: 6XXwKObhYlIHRK8S7Np3HHZtL4N85PVb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDE2NiBTYWx0ZWRfX/3aU36bkRg2I
 rmviON5F4ZpzRzRWVzsfx0geJsOklHOeuqhIdPeBZRU4M/w+K5x9wB56zC/DOWvl1SxMNEQ0cea
 vtyOiAvEZEsbtt4RWF1Ssmk7dmjGSKffFCEwNsEhLxBMuQxSeOhWgd2rLv2TOga5vy1MCUy1gvP
 /66dbO2ZFVWivE0Fovly4qoCnhw8HQxfuJsB/B5bAYX9BS94YPm6Jw+y5OkvkGKQKGhpMrQeUjs
 Coj8CB2OHcDLYXvogWFqtfkXYUImRoa1StSHvWmq+0L4cmb+dvbZhLZXGAhQjRY6PLukn6gTCbX
 3HLMYe3UsIgyOXhtpS9SIQrKlp4+QrrzDQ0HjXfUjLLuYImRbCRDMuc2Kf4eV0Lrou/Xq33U0Rt
 xFAzJaQ9+yGHrg+Le73Z5IAIhULWjg==
X-Proofpoint-GUID: yEOJie-EMpHeCIxKVszgwtTnceIN7BoW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-29_04,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 impostorscore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2510280166
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



On 10/29/25 15:28, BALATON Zoltan wrote:
> On Wed, 29 Oct 2025, Harsh Prateek Bora wrote:
>> + Thomas
>>
>> Hi BALATON,
>>
>> I am unable to fetch it with b4 am, and I do not see it appear on lore 
>> also, not sure if its due to the binary size.
>>
>> harshpb:patches$ b4 am 20251028151923.10DBB5972E5@zero.eik.bme.hu
>> Looking up 
>> https://lore.kernel.org/r/20251028151923.10DBB5972E5%40zero.eik.bme.hu
>> Grabbing thread from 
>> lore.kernel.org/all/20251028151923.10DBB5972E5%40zero.eik.bme.hu/t.mbox.gz
>> Server returned an error: 404
>> harshpb:patches$
>>
>> I guess you may need to send a PULL SUBSYSTEM req like Thomas did for 
>> slof:
>> https://lore.kernel.org/qemu-devel/20251027074404.25758-1-thuth@redhat.com/
> 
> Hi Harsh,
> 
> You should be able to download mbox from
> https://patchew.org/QEMU/20251028151923.10DBB5972E5@zero.eik.bme.hu/
> and git am that. This was tested by somebody else and worked.

Yes, git fetch from there seems to work, thanks.

  If needed
> I could try to split the binary into another patch or send you the patch 
> again. Maybe lore does not store large files?

Having only binary file update into its own separate patch may be better
as a best practice, so other patch gets non-binary changes for easy review.
Also, maintaining the date stamp may also be helpful in some cases.
Let me know if you think otherwise.

regards,
Harsh

> 
> Regards,
> BALATON Zoltan
> 

