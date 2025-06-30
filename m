Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CD70C83000
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Jun 2025 06:42:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uW8DU-0002te-FF; Mon, 30 Jun 2025 02:42:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1uW8DK-0002rx-Vl; Mon, 30 Jun 2025 02:42:03 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1uW8DH-0008Ub-FC; Mon, 30 Jun 2025 02:42:02 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55TKRunB019886;
 Mon, 30 Jun 2025 06:41:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=Qy4Vr6
 Zg55e6ME9BZ3QvOYoZ1r7Cib1yaF47TIkWZrU=; b=b+3uIGOcMNuDEFNJ8w/v6i
 GbppML/olows35WLgmP2a+DmSbmahFkPP1KCMA6tiJASQ9WDxqx8r8BFza5+xMMg
 gDdPNEVlp6Rb0bxQj1DPGPsu7MoZHVC7XjGlqPCTxyMACiXXo7ppLCxvpMI8yyZu
 ycj+X84Wxv+EMGdLdJfo/Ys07OToVx1qYziSTaGvy7vHjYdZ2skOE+Gj/QC1T8d8
 E2se/lpsuzO1m3ByouKbab3Ss6d7YuMbW3J/VZyrOgzW9ZjrA1FNanT8AATsMts3
 ru1+SdW4P0angAZIT0CYX3DWv5thEaims3mMcVHqOoujPQQSUab8YTKy8UO6I7Pg
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47j830fk9f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 30 Jun 2025 06:41:46 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 55U6eZac027900;
 Mon, 30 Jun 2025 06:41:46 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47j830fk9d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 30 Jun 2025 06:41:46 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55U5DTNi021939;
 Mon, 30 Jun 2025 06:41:44 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47juqpcnhp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 30 Jun 2025 06:41:44 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 55U6fiMS30868122
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 30 Jun 2025 06:41:44 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2256058065;
 Mon, 30 Jun 2025 06:41:44 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D769058056;
 Mon, 30 Jun 2025 06:41:41 +0000 (GMT)
Received: from [9.39.23.32] (unknown [9.39.23.32])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Mon, 30 Jun 2025 06:41:41 +0000 (GMT)
Message-ID: <81a8e7c0-2fe4-45e5-80d2-ecda3daeb353@linux.ibm.com>
Date: Mon, 30 Jun 2025 12:11:39 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] MAINTAINERS: Add myself as reviewer for PowerPC TCG
 CPUs
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, npiggin@gmail.com, danielhb413@gmail.com
Cc: richard.henderson@linaro.org, harshpb@linux.ibm.com
References: <20250619095840.369351-1-rathc@linux.ibm.com>
 <20250619095840.369351-6-rathc@linux.ibm.com>
 <6b336a63-464d-4b4d-89d2-370d19f97388@kaod.org>
Content-Language: en-US
From: Chinmay Rath <rathc@linux.ibm.com>
In-Reply-To: <6b336a63-464d-4b4d-89d2-370d19f97388@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: PX8G3QAxGTC83G1uuBmwB3KaByW3OfXk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjMwMDA1MSBTYWx0ZWRfX1Gvt+MkkoERY
 u7ImTidBasV8ZbUc2MAIC4sskaIY+2Tx1sd1AwzuWS4ZzeCVyGaSlQnj8qNoV9wxCkSUug3ODG/
 7t8j25BftP/GphkUpxdF18hikNCprrwfI0QDDUKuwm8NcZfAAwYuPnf0QUNlppsV0ScGPF9dl5E
 BEr+EzUuklwCsWM7q52WcPR20bIEPQIZg+RvgAb+Xw4of0Q3Kwpfsv8Ua3vNH2KVgiWECqvWW2/
 BAqNgVaKQamg2aVtrNvhKUsRp40CYd8Gn4H80uE3wbyeoWN+bLU/zF8vlX7yruXGx0wG18+vWzQ
 frUDX63yIenRtvJUJjUutMzeCkZ0wI0/6XbHS5FOPs83caCpXA93YeotErbmJ8N+nXJAlyUGlB7
 d7ocLXbcLwFlCOrZgrhUR/VHOXFKvm8XPqHvcPbyc06zKdQ4vBBgz7GVva/N8ZKc/RkADunr
X-Authority-Analysis: v=2.4 cv=MOlgmNZl c=1 sm=1 tr=0 ts=686231aa cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8
 a=69wJf7TsAAAA:8 a=20KFwNOVAAAA:8
 a=wcz21rLgfVc3ZAzCLjEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-GUID: PIfNlMHuKnI-YaHwxs0GQm1ln2SWITgw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-30_01,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 mlxscore=0
 adultscore=0 suspectscore=0 bulkscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 mlxlogscore=999 spamscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506300051
Received-SPF: pass client-ip=148.163.156.1; envelope-from=rathc@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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


On 6/19/25 17:27, Cédric Le Goater wrote:
> On 6/19/25 11:58, Chinmay Rath wrote:
>> I have been working on Power ISA for a long time now and have mostly
>> contributed in TCG instruction translation area (moved 300+ 
>> instructions to
>> decodetree as of yet) and would like to continue contributing to PPC 
>> TCG in
>> best possible ways I can. I think it's time to step up and assist in 
>> reviewing
>> related patches to enable myself contribute more effectively in this 
>> direction.
>>
>> Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
>> ---
>>   MAINTAINERS | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 16af37986a..a2db7d72aa 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -295,6 +295,7 @@ F: tests/tcg/openrisc/
>>   PowerPC TCG CPUs
>>   M: Nicholas Piggin <npiggin@gmail.com>
>>   M: Daniel Henrique Barboza <danielhb413@gmail.com>
>> +R: Chinmay Rath <rathc@linux.ibm.com>
>>   L: qemu-ppc@nongnu.org
>>   S: Odd Fixes
>>   F: target/ppc/
>
>
> Reviewed-by: Cédric Le Goater <clg@redhat.com>
>
> Thanks,
>
> C. 

Thanks Cedric !

Thanks,

Chinmay


