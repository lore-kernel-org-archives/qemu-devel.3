Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAB99CCF9E9
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 10:58:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE3rt-0004Gl-L7; Wed, 29 Oct 2025 06:57:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vE3rm-0003wJ-Ky; Wed, 29 Oct 2025 06:57:23 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vE3rb-0002g6-MS; Wed, 29 Oct 2025 06:57:21 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59SJm21A004466;
 Wed, 29 Oct 2025 10:57:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=MSuvFl
 mQNGgbBIIwXjkwWu8UaqBjWg6WhvDZGAATYD8=; b=sS5UgEBf57P6nEcc0mtZMo
 vIyc1GrMrFgOyR2GpvRPR9YV4xPJHq/v2R4Bg09+XnXr5PtijrRF17gtQkqo1S6V
 78TNjbWYo77tescghH+499I0Q3qoKJicgsRtpHcp2ip9//MwRZpLhjHRivGOf5YG
 JzLFj53u+ilxqua2u6+PnR6w2sBHxXMxYo9F5Nj3HW3Oi8I59GvKSFxZYWdxE7hV
 6oWk6I12Db+GQVBZqLGpsppx07QRt0WdOI6wXAfjd8kw0sqKDRA8ICUsfpauMoOo
 voQukkCeBkdoIPtEFReHA/WZqhG6zCcTDssUOh+oyioClBgE3A78GMTKdxyagr+w
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a34a8juv3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 29 Oct 2025 10:57:03 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59TAdEAN002247;
 Wed, 29 Oct 2025 10:57:03 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a34a8juuy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 29 Oct 2025 10:57:02 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59T9sptL030714;
 Wed, 29 Oct 2025 10:57:01 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4a33wwjxn4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 29 Oct 2025 10:57:01 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59TAv1Rm23069092
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 29 Oct 2025 10:57:01 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7679B58052;
 Wed, 29 Oct 2025 10:57:01 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9CC4558050;
 Wed, 29 Oct 2025 10:56:59 +0000 (GMT)
Received: from [9.39.28.229] (unknown [9.39.28.229])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 29 Oct 2025 10:56:59 +0000 (GMT)
Message-ID: <8ee23eb9-e7cd-42b9-ad43-a5a5370860db@linux.ibm.com>
Date: Wed, 29 Oct 2025 16:26:58 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/ppc/sam460ex: Update u-boot-sam460ex
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Thomas Huth <thuth@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org
References: <20251028151923.10DBB5972E5@zero.eik.bme.hu>
 <ee77b09f-7a12-4d52-b5f6-2d4b5b711448@linux.ibm.com>
 <f4c3bbb6-9a54-69ff-0d54-481ab4a55579@eik.bme.hu>
 <b131d419-15a8-4b4a-8dbd-c6f4988679fa@linux.ibm.com>
 <aedc6da1-605d-9c23-69b7-d93649fcd2cc@eik.bme.hu>
Content-Language: en-US
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <aedc6da1-605d-9c23-69b7-d93649fcd2cc@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=DYkaa/tW c=1 sm=1 tr=0 ts=6901f2ff cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=GaQpPoNlAAAA:8
 a=2bKAHB_-g_cVxtq2Nj4A:9 a=QEXdDO2ut3YA:10 a=xF5q_uoM5gZT5J3czcBi:22
 a=oH34dK2VZjykjzsv8OSz:22 a=pHzHmUro8NiASowvMSCR:22 a=n87TN5wuljxrRezIQYnT:22
X-Proofpoint-GUID: __7kLs349X578AZA3Wzdg-sV3x-nYiFR
X-Proofpoint-ORIG-GUID: al72_EWHlfKuRj1DLXHXxmbGPohivSTQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDE2NiBTYWx0ZWRfX0N27NUP9qDoU
 HbOZmOFe427YkZOWghu2f6UvnxYe9hP6LQf0abcuTENSQXfvtS53kRPjuzNuhm9DDxDjguXTCng
 DxxntT0OJ/Pnoer7gNvHtBVz11zOnyz9KsF+xVe/Ao7OQTXTWlGAXVq6LQi28axYEP8Eis0PZE2
 jX+s92HmqaTLfWTNzo99xg94+jWOSJHWeUY++cFcpQzCwOXYN7rrQsoiwy1Hd5rqvi33t1RnPM6
 B3E829D1BmkVKl6nGfz2N4lu0kwtCvAslMaA8R45gTflgHab/fA79Ld04g0T2uIoDTusv5Cf5Ko
 /VoRW4uROkAMa2/o2ZZLRb4lhm6chlw8ACaPI6H3KYzuWxQswISl4I9V5gFowJtEtsztaqHPh6f
 7GlERQKFWE27PXgSlG20OvF0K7i+nA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-29_04,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 malwarescore=0 bulkscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2510280166
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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



On 10/29/25 16:09, BALATON Zoltan wrote:
> On Wed, 29 Oct 2025, Harsh Prateek Bora wrote:
>> On 10/29/25 15:28, BALATON Zoltan wrote:
>>> On Wed, 29 Oct 2025, Harsh Prateek Bora wrote:
>>>> + Thomas
>>>>
>>>> Hi BALATON,
>>>>
>>>> I am unable to fetch it with b4 am, and I do not see it appear on 
>>>> lore also, not sure if its due to the binary size.
>>>>
>>>> harshpb:patches$ b4 am 20251028151923.10DBB5972E5@zero.eik.bme.hu
>>>> Looking up 
>>>> https://lore.kernel.org/r/20251028151923.10DBB5972E5%40zero.eik.bme.hu
>>>> Grabbing thread from 
>>>> lore.kernel.org/all/20251028151923.10DBB5972E5%40zero.eik.bme.hu/t.mbox.gz
>>>> Server returned an error: 404
>>>> harshpb:patches$
>>>>
>>>> I guess you may need to send a PULL SUBSYSTEM req like Thomas did 
>>>> for slof:
>>>> https://lore.kernel.org/qemu-devel/20251027074404.25758-1-thuth@redhat.com/
>>>
>>> Hi Harsh,
>>>
>>> You should be able to download mbox from
>>> https://patchew.org/QEMU/20251028151923.10DBB5972E5@zero.eik.bme.hu/
>>> and git am that. This was tested by somebody else and worked.
>>
>> Yes, git fetch from there seems to work, thanks.
>>
>> If needed
>>> I could try to split the binary into another patch or send you the 
>>> patch again. Maybe lore does not store large files?
>>
>> Having only binary file update into its own separate patch may be better
>> as a best practice, so other patch gets non-binary changes for easy 
>> review.
>> Also, maintaining the date stamp may also be helpful in some cases.
>> Let me know if you think otherwise.
> 
> Which date stamp maintaining are you referring to? I can split the patch 
> in two later today or tomorrow if you want and send a v2 but not right 
> now. For that to compile and work after each patch it would need to add 
> the new binary in one patch then remove the old one after changing its 
> usage. Or maybe even 3 patches: first updating submodule, then adding 
> binary rebuilt from that then changing usage and removing old one. I 
> think this would make the series larger as git now seems to contain 
> binary diff between old and new versions but if these are in different 
> patch it may still add the removed binary as a binary patch. So this 
> only works if the old and new binary is the same name or renamed in one 
> patch but then that would break if the usage is not updated in the same 
> patch. So maybe patch one to update submodule, patch 2 to add binary 
> with old name and patch 3 to rename the binary could work but does that 
> worth the hassle and any better than this single patch?


I was referring to the version number in binary name as date stamp which
is being removed, but that's fine. I think we can take this patch as-is
for now as split doesn't add much value and also we are close to freeze.

regards,
Harsh

> 
> Regards,
> BALATON Zoltan

