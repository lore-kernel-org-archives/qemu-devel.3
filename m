Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11EA4C3ABC9
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 15:23:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFaPs-0008C3-6e; Thu, 15 May 2025 11:22:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1uFaPe-0007zQ-SG; Thu, 15 May 2025 11:22:24 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1uFaPQ-0002mn-3y; Thu, 15 May 2025 11:22:14 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54FCg442004731;
 Thu, 15 May 2025 15:22:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=UXL3bY
 23UQ8+2bTnEyF/O88S+7a0qBsAMhO5YmlLEtI=; b=WOopNyNaisx4rrlTnIhtDw
 /JehQSQbrWrfHmPOmfS0jUvcCw5rqqrrnjNsXgFNwOOpAxDzsWa8x7LZkIz6IbzY
 uoDN7fP49AOFa12LOr4ZYaF5bWVb/kws4JgjZpD9wD9YiiA3T3789v+ywGdNMiWj
 PGUXlelugJsZrM/hyEdZCsphTXFIMZj4QHN838RyYQtWmrHBiW5GmAp7kMjUseoC
 fc89+wqyu+eqOApaE7PbRPWnIMcfITDmDG+PmQaIs4ZQtdVwfHw2emtQFDqdmItz
 bGexh7FijielVDY8DHRZWlNY8f6pkMZDgKw0rUNXdpYawbjLyFrgF4Adrc2NzC5A
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46navu2qt9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 15:21:59 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54FFLxRa029768;
 Thu, 15 May 2025 15:21:59 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46navu2qt5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 15:21:59 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54FEGgQj019443;
 Thu, 15 May 2025 15:21:58 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 46mbfrtwqw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 15:21:58 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 54FFLuq415270408
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 15 May 2025 15:21:56 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 85AAA58059;
 Thu, 15 May 2025 15:21:56 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2FD2658057;
 Thu, 15 May 2025 15:21:56 +0000 (GMT)
Received: from [9.10.80.143] (unknown [9.10.80.143])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 15 May 2025 15:21:56 +0000 (GMT)
Message-ID: <2b0df92c-6f5b-4dcb-a1ef-bc9c169fa0d0@linux.ibm.com>
Date: Thu, 15 May 2025 10:21:55 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 31/50] ppc/xive: Fix high prio group interrupt being
 preempted by low prio VP
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?=
 <fbarrat@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Caleb Schlossin <calebs@linux.vnet.ibm.com>
References: <20250512031100.439842-1-npiggin@gmail.com>
 <20250512031100.439842-32-npiggin@gmail.com>
Content-Language: en-US
From: Mike Kowal <kowal@linux.ibm.com>
In-Reply-To: <20250512031100.439842-32-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: owtLgYWb4y_JCBvXXLj5NbDVryaDycND
X-Authority-Analysis: v=2.4 cv=XK4wSRhE c=1 sm=1 tr=0 ts=68260697 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8
 a=k6hdcXhxsaq_Xb-7T0YA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 5M-Ee_X9Wb0CHg_4kQCAeM6AyFoLMuUS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDE1MCBTYWx0ZWRfX+Jty97Ln0mQj
 YRUDAg9k5Mmo3hvoy9ETOoam8FYIXuLo1azwSM3wFlQkjL33xa7TdXZYF2f6UP6Mgzfr8HKE9Rp
 IVPTIppzOQn3Iee5cWJewoCmc3KgXEhV2FeH0+Rn4Cq0Yj/URr9V0HvJ6qGj7QOqhewTKoeXi6q
 v9NuEk0/RitjfLwxQY0i5njLQlA8Bxj9lXYrlrfR8/iOO8fypJlt0NzN0NHeqteSsy55+WOzXGP
 gAYqxnVBcw8tPMLPvCLRtJgGm29a6JbySPKEU6iauowsm1R0z7ugGXsSxlTIDooIksOzTvQ8/Wg
 IrQ2S+JlAGJ3srTnYWMQaIQU+4cb9vrq6YoDsgDGKIOkOIsdhDbeeUbPkYlJ3uYrGRhS3qmTCuj
 e5Hc6yQGBrzHYmfy5okzqch7sCCTsuutJGQ/vUNM6eFKboU0u0WIGFtYHBs1Ak+Okn28Vn+J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_06,2025-05-15_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0
 mlxscore=0 bulkscore=0 mlxlogscore=634 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 impostorscore=0 adultscore=0
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505150150
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
> xive_tctx_pipr_present() as implemented with xive_tctx_pipr_update()
> causes VP-directed (group==0) interrupt to be presented in PIPR and NSR
> despite being a lower priority than the currently presented group
> interrupt.
>
> This must not happen. The IPB bit should record the low priority VP
> interrupt, but PIPR and NSR must not present the lower priority
> interrupt.


Reviewed-by: Michael Kowal<kowal@linux.ibm.com>

Thanks,  MAK

>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   hw/intc/xive.c | 18 +++++++++++++++++-
>   1 file changed, 17 insertions(+), 1 deletion(-)
>
> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> index bf4c0634ca..25f6c69c44 100644
> --- a/hw/intc/xive.c
> +++ b/hw/intc/xive.c
> @@ -228,7 +228,23 @@ void xive_tctx_pipr_update(XiveTCTX *tctx, uint8_t ring, uint8_t priority,
>   void xive_tctx_pipr_present(XiveTCTX *tctx, uint8_t ring, uint8_t priority,
>                               uint8_t group_level)
>   {
> -    xive_tctx_pipr_update(tctx, ring, priority, group_level);
> +    /* HV_POOL ring uses HV_PHYS NSR, CPPR and PIPR registers */
> +    uint8_t alt_ring = (ring == TM_QW2_HV_POOL) ? TM_QW3_HV_PHYS : ring;
> +    uint8_t *aregs = &tctx->regs[alt_ring];
> +    uint8_t *regs = &tctx->regs[ring];
> +    uint8_t pipr = xive_priority_to_pipr(priority);
> +
> +    if (group_level == 0) {
> +        regs[TM_IPB] |= xive_priority_to_ipb(priority);
> +        if (pipr >= aregs[TM_PIPR]) {
> +            /* VP interrupts can come here with lower priority than PIPR */
> +            return;
> +        }
> +    }
> +    g_assert(pipr <= xive_ipb_to_pipr(regs[TM_IPB]));
> +    g_assert(pipr < aregs[TM_PIPR]);
> +    aregs[TM_PIPR] = pipr;
> +    xive_tctx_notify(tctx, ring, group_level);
>   }
>   
>   /*

