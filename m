Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86269C3ABDA
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 18:53:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFHE7-0005bN-9Y; Wed, 14 May 2025 14:53:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1uFHE5-0005Yd-B1; Wed, 14 May 2025 14:53:09 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1uFHE3-0005n7-6O; Wed, 14 May 2025 14:53:08 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54EIoPUt031296;
 Wed, 14 May 2025 18:53:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=2MaJc5
 hSW9Z8ToJWE/mgoddTsJmNPPc66E0Rw8MFMo4=; b=X5DX91V/UBdZCn4Sg4753m
 fEaWUzqaLyP9SpRUW2T58zBlVeAnPiei7gqowAbJFbCcMxdO17c63jFCWJfhZzz1
 oyY3Josgdqspc9oTncbdga3cyp2kKQW0l/WVSUFeUHcRjoaUrzt2jDe+JN38Cv7b
 Vh2vtbsJP0vCzs3eQJIYJJ4m/Nkamd1dUSile6mwUju10sU8C1HFZZG8K5BAGFwh
 /RGjwCPSstXC4xs5PUeoa8ErS6scgChXhGOeZhKSNGi5bJytgdu/ae/6oTbx298b
 NxtNEWXAe+SHNQq/iN8bftjPUvjHVOkDd4VPiUsYhnOt/uQMnYVLFawPd99wYV3Q
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46n0t980td-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 May 2025 18:53:04 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54EIpt7M002372;
 Wed, 14 May 2025 18:53:03 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46n0t980ta-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 May 2025 18:53:03 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54EGV2E1024309;
 Wed, 14 May 2025 18:53:02 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46mbfs5wwb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 May 2025 18:53:02 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 54EIr07F24052442
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 14 May 2025 18:53:01 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B7F1458055;
 Wed, 14 May 2025 18:53:00 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 387A95803F;
 Wed, 14 May 2025 18:53:00 +0000 (GMT)
Received: from [9.10.80.143] (unknown [9.10.80.143])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 14 May 2025 18:53:00 +0000 (GMT)
Message-ID: <1a31a22d-183e-43e6-bea1-28a69b4eb6de@linux.ibm.com>
Date: Wed, 14 May 2025 13:52:59 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/50] ppc/xive2: Fix irq preempted by lower priority
 group irq
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?=
 <fbarrat@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Caleb Schlossin <calebs@linux.vnet.ibm.com>
References: <20250512031100.439842-1-npiggin@gmail.com>
 <20250512031100.439842-10-npiggin@gmail.com>
Content-Language: en-US
From: Mike Kowal <kowal@linux.ibm.com>
In-Reply-To: <20250512031100.439842-10-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=etzfzppX c=1 sm=1 tr=0 ts=6824e690 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=rvxr7Vxs7MPorNA6K-4A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE0MDE2OSBTYWx0ZWRfX2jcN07HWTD4W
 ZmteNogedqEA93f6NGRby6KHydI46uhilehAx5D1UVE4YEi25DcKRiQLy+tCnD0K+axfbugCqXr
 Vs+F6X9pCtybspesidSTPBnQipGBpIyC+N4pD4VrNSH6W+I0cSlsV6fQ4+JtkIU/tOY2xe8ocTL
 Y4rpNsf0iDS5z3/EhDJzh+I/KdlMHRCMpHzjsiNuqOmvQvuMvMY40gd8UbN0vqjLv3yFVEuDBAs
 r58+69yuyzppWW6KfRJdD0NGobDi2IgCU5+xvLZfh2K6JaLC2thdpvYWHPIY1ej0FeH6JNl/crN
 cRz5PHwLEB+xwVqNFnSYnbyavpYqxWUgd7iIyH311uvRfylHvTIMSOv9/fP/oEEyi0vXaMgIfVW
 97R8nHk3bGhd8RCJfNu/ZlvKKtCFjW6+5k/WVVxeGf2fvw5dTwGZFiiceDKNSuS5RMdAyrtE
X-Proofpoint-ORIG-GUID: jQHmFvsh3FwszvhIelru_RNlxJsapAEV
X-Proofpoint-GUID: l7n-Sy5BgjdLquWXKN4sFQegAtIMAjVZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-14_04,2025-05-14_03,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 lowpriorityscore=0 phishscore=0 mlxscore=0 mlxlogscore=950 bulkscore=0
 suspectscore=0 spamscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505140169
Received-SPF: pass client-ip=148.163.156.1; envelope-from=kowal@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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


On 5/11/2025 10:10 PM, Nicholas Piggin wrote:
> From: Glenn Miles <milesg@linux.ibm.com>
>
> A problem was seen where uart interrupts would be lost resulting in the
> console hanging. Traces showed that a lower priority interrupt was
> preempting a higher priority interrupt, which would result in the higher
> priority interrupt never being handled.
>
> The new interrupt's priority was being compared against the CPPR
> (Current Processor Priority Register) instead of the PIPR (Post
> Interrupt Priority Register), as was required by the XIVE spec.
> This allowed for a window between raising an interrupt and ACK'ing
> the interrupt where a lower priority interrupt could slip in.

Reviewed-by: Michael Kowal <kowal@linux.ibm.com>

Thanks MAK


>
> Fixes: 26c55b99418 ("ppc/xive2: Process group backlog when updating the CPPR")
> Signed-off-by: Glenn Miles <milesg@linux.ibm.com>
> ---
>   hw/intc/xive2.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
> index 453fe37f18..2b4d0f51be 100644
> --- a/hw/intc/xive2.c
> +++ b/hw/intc/xive2.c
> @@ -1283,7 +1283,7 @@ bool xive2_tm_irq_precluded(XiveTCTX *tctx, int ring, uint8_t priority)
>        * priority to know if the thread can take the interrupt now or if
>        * it is precluded.
>        */
> -    if (priority < alt_regs[TM_CPPR]) {
> +    if (priority < alt_regs[TM_PIPR]) {
>           return false;
>       }
>       return true;

