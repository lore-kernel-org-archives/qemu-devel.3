Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94683C3ABAA
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 20:56:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAETZ-0004t6-Ld; Wed, 30 Apr 2025 16:56:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rreyes@linux.ibm.com>)
 id 1uAETW-0004sK-Vb; Wed, 30 Apr 2025 16:56:15 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rreyes@linux.ibm.com>)
 id 1uAETT-0008An-08; Wed, 30 Apr 2025 16:56:12 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53UKXe1H027563;
 Wed, 30 Apr 2025 20:55:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=OOUEzT
 hgW2Yl6bhLhIqiyUSOUw1uYcFmu+wJeq6XK0w=; b=Iz9lBy2by7+suu8yRmzK8m
 2MFi4bPfCtFuToeRHbUPWYt0BqZmQUzsO206bvD40B7EOJbCTiyiphcbxwvdfK7q
 aifdMKqh6b2wRA4cN2RldlzklQ4NxyVxDnYktCSQnAa6adX1bw7vYdAShDgjdkQ1
 EU7/7WFrau6TN5M/B5hzvXgdGwdoyBEYePTPa7FImsXuBAjUc3f8KyWNDzDqshtX
 2nL0PT4NTMEA02o3AcD9DEKwzQZdm3YfbY6HDZrWHVRAUYi1GuoerI8tZnnZFLpr
 8u9VoVPzop2es5XLgkoJT+u/IQym+anADanAtkmHUrnv7UCcCnIfkX+T4qecqdxA
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46b8r0w3gy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 30 Apr 2025 20:55:34 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53UI45UD008501;
 Wed, 30 Apr 2025 20:55:33 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 469ch39fgk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 30 Apr 2025 20:55:33 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 53UKtWEI40960604
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 30 Apr 2025 20:55:32 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EDCCA58054;
 Wed, 30 Apr 2025 20:55:31 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DF18458052;
 Wed, 30 Apr 2025 20:55:30 +0000 (GMT)
Received: from [9.61.251.53] (unknown [9.61.251.53])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 30 Apr 2025 20:55:30 +0000 (GMT)
Message-ID: <8c8463d3-a1a2-476d-b9a0-fbbc0cb58c22@linux.ibm.com>
Date: Wed, 30 Apr 2025 16:55:30 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/6] Report vfio-ap configuration changes
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org, 
 qemu-s390x@nongnu.org
Cc: pbonzini@redhat.com, cohuck@redhat.com, pasic@linux.ibm.com,
 jjherne@linux.ibm.com, borntraeger@linux.ibm.com,
 alex.williamson@redhat.com, thuth@redhat.com, akrowiak@linux.ibm.com
References: <20250425052401.8287-1-rreyes@linux.ibm.com>
 <e35561c9-f104-4be0-8bf4-cae726118028@redhat.com>
Content-Language: en-US
From: Rorie Reyes <rreyes@linux.ibm.com>
In-Reply-To: <e35561c9-f104-4be0-8bf4-cae726118028@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDMwMDE0NyBTYWx0ZWRfX9JLe5xql3rxw
 XiekHyX5JYDvcN7OZnBwArzb+VJkpB7MIT6GywvlbD762W+a3OlDQLyfRcKYuHgslXkw4EfqXD9
 vuc13avU9wWbDzsEFYSu7XeodpFJjtTS9RKwKXSUAAbzNYJTRPPmjiCy7FuSjEAQHTLUyYtFmAH
 wsi5EgujmJOYI7Qa3tTm67zFcWqh7EVN001+ptkhWaWLVD7VxbOzAViasZPVyxcVFzYTGkm/IfV
 vu1gE80leIBtSSTPG9Gyko7+Y5+YDFj1rAli24c4/aKF+HWp+c7JP9C8JYs3kY904cx9to6HOqF
 fH2y359MXly8iqUJKktxeS7oaU/rueVEwKK2+aBC1M8pOfXX/ySfMgrLh7vpapu6f+1GP+xvJFD
 /QPWu5jEoRQ/ekEezVCm8V1ooNAZqyFVMnrxMmfKfZmt1j0VJ9i/WOBHgt8wpE8G9cjh5vMZ
X-Authority-Analysis: v=2.4 cv=OqdPyz/t c=1 sm=1 tr=0 ts=68128e46 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=td8I4cNIj0D-FrJ7sd8A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: qqaofTno4bjBRJF8DSOQupRig4quag1y
X-Proofpoint-ORIG-GUID: qqaofTno4bjBRJF8DSOQupRig4quag1y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-30_06,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 suspectscore=0 malwarescore=0 priorityscore=1501 bulkscore=0 mlxscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 spamscore=0 mlxlogscore=951
 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504300147
Received-SPF: pass client-ip=148.163.158.5; envelope-from=rreyes@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


On 4/28/25 5:29 PM, Cédric Le Goater wrote:
> On 4/25/25 07:23, Rorie Reyes wrote:
>> Changelog:
>> v7:
>> - Dropped initial commit for linux-header file vfio.h since I created 
>> two new commits
>> to address the changes made in v6
>> - Moved patches 6 and 7 to the beginning of the series after dropping 
>> the first patch
>>     - Because I dropped the initial commit for linux-header file 
>> vfio.h, I had to add
>> VFIO_AP_CFG_CHG_IRQ_INDEX
>> - Resyncing latest to v6.15-rc3
>> - Still need Thomas Huth's review of v5 changes for patch 6/6
>
> I checked the build without default devices.
>
> Applied to vfio-next.
>
> Thanks,
>
> C.
>
>
Hey Cedric, are my QEMU patches considered good for this series?

