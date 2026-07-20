Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79220C44515
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 13:06:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlngT-0002Ws-J9; Mon, 20 Jul 2026 09:05:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wlngP-0002Oy-TE; Mon, 20 Jul 2026 09:05:22 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wlngO-0007bW-9H; Mon, 20 Jul 2026 09:05:21 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66KBCTgr1952023; Mon, 20 Jul 2026 13:05:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=OHDyI8
 u9W2gS1Ika/yvlOv1PJ89DL89mzYquztn8Xs0=; b=dIhLJbX56WpmGju2DwI2A5
 FOCTiFZ8TvjnWyEy/u8aWWAk36jSV9+PoCDI9au4gLS3zyuI1a5ps6Wpn6SKS2pa
 YzLWryHzMy65v0kiUflrk7+BFVU+d9E6qBMh2P8e1TTVRBX7aYIrw5vpAwaxq8aR
 +JjRCIEaY5FGGDWQfCYRdrYrw5ytUesMNzQtjzDxPfXm5T86wpxm8LBfsFDklzQR
 tQP3pt/kZ4w+4Cz4WG+4NFVsd6GQ33UanXpFw5boH8AvRAzgKS+bV7MupJBcUYTF
 mdlDn1swS4wjve2+cuYjLPq6Qz5YrCb6hmSC8DXzsg+QRwHfS18CrAd3rxJjRFrA
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg77jyara-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 20 Jul 2026 13:05:15 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66KD4exT021942;
 Mon, 20 Jul 2026 13:05:15 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgmtjnpqr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 20 Jul 2026 13:05:14 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66KD5DgN25952784
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 20 Jul 2026 13:05:13 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B00D658051;
 Mon, 20 Jul 2026 13:05:13 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1894F5805E;
 Mon, 20 Jul 2026 13:05:10 +0000 (GMT)
Received: from [9.39.17.136] (unknown [9.39.17.136])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 20 Jul 2026 13:05:09 +0000 (GMT)
Message-ID: <728087c8-b350-4993-a64a-45aba38a616f@linux.ibm.com>
Date: Mon, 20 Jul 2026 18:35:06 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] target/ppc: Reorder PPC2 flags
To: Shivang Upadhyay <shivangu@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, npiggin@gmail.com, harshpb@linux.ibm.com,
 tommusta@gmail.com
Cc: richard.henderson@linaro.org, milesg@linux.ibm.com
References: <20260715125634.2107320-1-rathc@linux.ibm.com>
 <20260715125634.2107320-7-rathc@linux.ibm.com>
 <a2fde2b73930cfe5e555da8660598dc464c72127.camel@linux.ibm.com>
Content-Language: en-US
From: Chinmay Rath <rathc@linux.ibm.com>
In-Reply-To: <a2fde2b73930cfe5e555da8660598dc464c72127.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=HJXz0Itv c=1 sm=1 tr=0 ts=6a5e1d0b cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=Yqvyljzr7-0roLXx2qwA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDE0MSBTYWx0ZWRfXxE9q75pqFaoD
 JFJlwy5oYX+I+OdJiO4xDQfwQJpnPFrnPlz2FTJsXAqJnYewhTJlKWzGHX5zAW7ISapAihnuUjz
 B+crsLRqs3HgkXfqtIZ7vxQHYwj048b59suVBjmb6bOB8kccatStbK4ey17/1RI0xY1HJsGaGW3
 z9mEz7SQgrRsxqFcqolUX3sDIsobt/NMdrw/l6OBcZdHOQZhIKMbsRmg+J66x7cTdL7hEw5v8qF
 IljJeKFNwxrOxVlyFqW+4dL4nDawXugO3zYSoVeRM+K8+fiV1izL7waZXkChNXvBs/ylvvxjQqu
 ZYOk3kd7Bh3hNkt0TLRKOZBccBgzkyx7+et6mzMXQ7top0j/yqw40jgQ6DG1kt16ALEJiiBKfsT
 tpZuU9l2uYW0rsWZEpbw7m8oM9dxFYLHeMhr+WRFOvQ5dz1FWpyXlhw+yVTv7oBxjp+98Kephrp
 KfvF8J8tOaYWyEXG1Jg==
X-Proofpoint-ORIG-GUID: pTZ9LdLNQfNyN326Qz-_Sj0HMRPRidi6
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDE0MSBTYWx0ZWRfXyoG5AAKSaSvT
 EwkblHu7EuRSq/UY3llI7cM0dZsWSZO/Flx7ar1pfSSbZ3qy4iHfKeRLxFcJ2e+nldySfP8TH8A
 kHPT3pd5ijDDq5pD5hFcJ3vSuYQ23XM=
X-Proofpoint-GUID: jkhytKHqyD0ZCDkpnC0wRX85oFpXs8Hr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_02,2026-07-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 malwarescore=0 impostorscore=0 clxscore=1015 phishscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607200141
Received-SPF: pass client-ip=148.163.158.5; envelope-from=rathc@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


On 7/15/26 20:11, Shivang Upadhyay wrote:
> On Wed, 2026-07-15 at 18:26 +0530, Chinmay Rath wrote:
>> +    PPC2_BCDA_ISA206   = 0x0000000000040000ULL,
>>       /* PPE42
>> instructions                                                    */
>> -    PPC2_PPE42         = 0x0000000000800000ULL,
>> +    PPC2_PPE42         = 0x0000000000080000ULL,
>>       /* PPE42X
>> instructions                                                   */
>> -    PPC2_PPE42X        = 0x0000000001000000ULL,
>> +    PPC2_PPE42X        = 0x0000000000100000ULL,
>>       /* PPE42XM
>> instructions                                                  */
>> -    PPC2_PPE42XM       = 0x0000000002000000ULL,
>> +    PPC2_PPE42XM       = 0x0000000000200000ULL,
>>   
> Hi Chinmay,
>
>   Would it be fine if we can do something like this instead?
>
> PPC2_PPE42XM  = (1ull << 21);
>
> It would be easy to see where the gaps are from next time.
Hi Shivang,
Thanks for the suggestion. I agree with you. Looking at the shift 
numbers and making sure they are in consecutive incremental order would 
make gaps less likely. However if we are to switch to this way, there 
are about 40 such flags in cpu.h which will have to be reset in this 
fashion. Hence should be a different patch in itself as the objective of 
this series is different. Plus it would also bring in the risk of 
someone shifting a bit by a value that might cause an overflow. So one 
would have to take care of that while adding a new flag. So this way or 
the original way, one does need to take care of couple things while 
adding future flags.

Regards,
Chinmay

>
> ~Shivang.
>

