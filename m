Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A1DECAC590
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2024 23:48:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqhvH-0002NX-T1; Tue, 17 Sep 2024 19:47:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_bcain@quicinc.com>)
 id 1sqhvG-0002Li-9I; Tue, 17 Sep 2024 19:47:54 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_bcain@quicinc.com>)
 id 1sqhvE-0004o8-KY; Tue, 17 Sep 2024 19:47:54 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48HJf8Nt013720;
 Tue, 17 Sep 2024 23:47:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 tYIkwJVfXpqI65SfnzFs5E7FrJYH30koZ1vBszVWxog=; b=LyMMeFWg5Ud7rtuk
 5lJDWZhgKx+n1mZY5Tqvl+gCh6XtrBNT+kNsqfqhR4xiY7ieuCJkVoKF8YWYk77A
 MHdEYUPdsnp3ORqCUqdF05GOFGk0FzbAsRO3ZSKBlOE87eqa0RsGyRZq0dV0MuB1
 CBe1Zx6+LkMvm+sNOJxMy7Yxey3ggOurFkY1YvhdesB9qh8nf/BXDpdCoAbJ6Ba7
 baW2dNlAWwmIqMxmZsdB3f/labyjHN/I5yjv89KXHZLb2dvYWWFlW0sHwjbBYwaL
 NLbCKC1Dso6EOa6seh2PImok7Q9xbusL44OXaFDA3ErPCLtodVUT6+JXRQIqbUXJ
 +sVnng==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41n4j6rayp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 17 Sep 2024 23:47:47 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com
 [10.47.97.35])
 by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48HNlkZK001146
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 17 Sep 2024 23:47:46 GMT
Received: from [10.110.61.117] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 17 Sep
 2024 16:47:45 -0700
Message-ID: <3f2be160-c411-4c75-b08b-0977bff0b710@quicinc.com>
Date: Tue, 17 Sep 2024 18:47:36 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw: fix memory leak in IRQState allocation
To: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>,
 <qemu-devel@nongnu.org>
CC: <balaton@eik.bme.hu>, <mst@redhat.com>, <bcain@quicinc.com>,
 <qemu-trivial@nongnu.org>
References: <6f0b480e1f0fbeb9550d447dcbeda920f1869d2d.1726598846.git.quic_mathbern@quicinc.com>
Content-Language: en-US
From: Brian Cain <quic_bcain@quicinc.com>
In-Reply-To: <6f0b480e1f0fbeb9550d447dcbeda920f1869d2d.1726598846.git.quic_mathbern@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-ORIG-GUID: 9Ey6PAUWVpUCh4sTZKgPHqK5Ef_5uwzN
X-Proofpoint-GUID: 9Ey6PAUWVpUCh4sTZKgPHqK5Ef_5uwzN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 mlxlogscore=999
 mlxscore=0 malwarescore=0 bulkscore=0 priorityscore=1501 clxscore=1011
 adultscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2409170169
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=quic_bcain@quicinc.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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


On 9/17/2024 1:47 PM, Matheus Tavares Bernardino wrote:
> At e72a7f65c1 (hw: Move declaration of IRQState to header and add init
> function, 2024-06-29), we've changed qemu_allocate_irq() to use a
> combination of g_new() + object_initialize() instead of
> IRQ(object_new()). The latter sets obj->free, so that that the memory is
> properly cleaned when the object is finalized, but the former doesn't.
>
> Signed-off-by: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
> ---
>   hw/core/irq.c | 19 +++++++++++--------
>   1 file changed, 11 insertions(+), 8 deletions(-)
>
> diff --git a/hw/core/irq.c b/hw/core/irq.c
> index db95ffc18f..7d80de1ca6 100644
> --- a/hw/core/irq.c
> +++ b/hw/core/irq.c
> @@ -34,13 +34,19 @@ void qemu_set_irq(qemu_irq irq, int level)
>       irq->handler(irq->opaque, irq->n, level);
>   }
>   
> +static void qemu_init_irq_fields(IRQState *irq, qemu_irq_handler handler,
> +                                 void *opaque, int n)


This function was named as if it should be public, but declared 
`static`.  I think it might make more sense to call this function 
"init_irq_fields" instead.


> +{
> +    irq->handler = handler;
> +    irq->opaque = opaque;
> +    irq->n = n;
> +}
> +
>   void qemu_init_irq(IRQState *irq, qemu_irq_handler handler, void *opaque,
>                      int n)
>   {
>       object_initialize(irq, sizeof(*irq), TYPE_IRQ);
> -    irq->handler = handler;
> -    irq->opaque = opaque;
> -    irq->n = n;
> +    qemu_init_irq_fields(irq, handler, opaque, n);
>   }
>   
>   qemu_irq *qemu_extend_irqs(qemu_irq *old, int n_old, qemu_irq_handler handler,
> @@ -66,11 +72,8 @@ qemu_irq *qemu_allocate_irqs(qemu_irq_handler handler, void *opaque, int n)
>   
>   qemu_irq qemu_allocate_irq(qemu_irq_handler handler, void *opaque, int n)
>   {
> -    IRQState *irq;
> -
> -    irq = g_new(IRQState, 1);
> -    qemu_init_irq(irq, handler, opaque, n);
> -
> +    IRQState *irq = IRQ(object_new(TYPE_IRQ));
> +    qemu_init_irq_fields(irq, handler, opaque, n);
>       return irq;
>   }
>   

