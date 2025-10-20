Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2004ECCD1A5
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 18:58:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAv4w-0005yp-7c; Mon, 20 Oct 2025 14:57:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1vAv4p-0005yN-M5; Mon, 20 Oct 2025 14:57:51 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1vAv4l-00028I-HB; Mon, 20 Oct 2025 14:57:50 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59KCpjm1008364;
 Mon, 20 Oct 2025 18:57:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=5IDgqL
 tvEAKknlMu8EdmmvYJ42e0e/gHvwB/ShQFQNA=; b=f5cGzQui5UUCnHHIY8kc2E
 A5qmcGWOGq1NeUbD/4KELmwnImw35kgsZMqHmOKQHsDc1aGwmK19pKCLnr8ncpsO
 nF+gucNlXibCBIdSbS79B30jHLuFDZWQwRx1u1ieq7vQupJHMICiay+fpvXV6IQJ
 /TGUfLPYQldkfb6QBObLOy8nI6gG+7fGyWh364nq4PngHaF5dRActG2jcXtpjkrV
 DbC+t6Uze7n0a4rHpxG568Jv+0EsQ1mXD9vrKN2FU4OD4LX9Syi4w3jdZnebf6I1
 NN3YQZ1vy+j5ajfmhoKfNwnQkg+xhQYE6QCQktq3mnmkxZKUsHIOzq3Is8K+G6AA
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v32ha0a9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 20 Oct 2025 18:57:43 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59KIbslu024677;
 Mon, 20 Oct 2025 18:57:42 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49vpqjq3w3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 20 Oct 2025 18:57:42 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59KIvfS951315084
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 20 Oct 2025 18:57:41 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3856A58057;
 Mon, 20 Oct 2025 18:57:41 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AB55458066;
 Mon, 20 Oct 2025 18:57:40 +0000 (GMT)
Received: from [9.61.78.141] (unknown [9.61.78.141])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Mon, 20 Oct 2025 18:57:40 +0000 (GMT)
Message-ID: <1f4cd71a-e373-4b79-b070-8567b8bf9d3a@linux.ibm.com>
Date: Mon, 20 Oct 2025 14:57:40 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] pc-bios/s390-ccw: Fix Misattributed Function
 Prototypes
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: jjherne@linux.ibm.com, alifm@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, zycai@linux.ibm.com
References: <20251020162023.3649165-1-jrossi@linux.ibm.com>
 <20251020162023.3649165-2-jrossi@linux.ibm.com>
 <f1fa94aa-d0b3-4855-ba83-30b8239297ef@redhat.com>
Content-Language: en-US
From: Jared Rossi <jrossi@linux.ibm.com>
In-Reply-To: <f1fa94aa-d0b3-4855-ba83-30b8239297ef@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfXwpvH/ff4lMnF
 KKbWZ2rfgQJKfMuwGx5+isG0CAK+77Zj0gE30ouQNiQ5Ggbba+6xeI1iOZBtRtuqId5wMzPn45h
 NY1hiIraDkXJsQAyizVp3cC74KujMGylS8iwx05zLL9NEEvvyc8OJoBIgqT77CtUItnrNeN8WO5
 Nh7ivcLfPogaE8ESs/vnT2iCErnCI3m+f79PQ3O3V3uiPyVo84lnre3oEVAtjeiZ7ys3JylgljL
 /PTy6R4AelceAKIz9dfc9+7nRvGEv6DBzCDTmd22dJqQZWWIUsFZtx8QFqjgYy/OoCqK81h/NI7
 frv70itsyx94apNah+BE0YMnj+pRlBvvtbM9iDP501mD7OGiUyVXPSNY93rm0ZWH0BgvIz7pOFP
 xmRbTT0c2VJtVzqmZeE3xxjggID4rA==
X-Authority-Analysis: v=2.4 cv=OrVCCi/t c=1 sm=1 tr=0 ts=68f68627 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8 a=Cq4k7Z7riBiSKpyquisA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: ymbIfb78_cmrHAM_Fkwadl9xDmU89zL3
X-Proofpoint-ORIG-GUID: ymbIfb78_cmrHAM_Fkwadl9xDmU89zL3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_05,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0
 clxscore=1015 bulkscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022
Received-SPF: pass client-ip=148.163.158.5; envelope-from=jrossi@linux.ibm.com;
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



On 10/20/25 12:50 PM, Thomas Huth wrote:
> On 20/10/2025 18.20, jrossi@linux.ibm.com wrote:
>> From: Jared Rossi <jrossi@linux.ibm.com>
>>
>> The virtio-blkdev functions are incorrectly listed in s390-ccw.h as 
>> belonging to
>> virtio.c.  Additionally, virtio_load_direct() has an unused 
>> subchan_id argument.
>>
>> Remove the unused argument and move the prototypes to virtio.h so 
>> that they are
>> independent from the CCW bus.
>>
>> Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
>> ---
>
> I'd maybe spell "Misattributed Function Prototypes" with small letters 
> in the title, but apart from that, patch looks good to me:
>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
>
Thanks Thomas,

I'm not sure why I wrote it like that.  I notice now I did the same 
thing with "Architecture" in patch 3.  I'll fix the capitalization in 
both patches for the next version.

Regards,
Jared Rossi

