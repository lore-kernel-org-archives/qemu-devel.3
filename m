Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E25BCDD55C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2024 20:51:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sr1d7-00046I-80; Wed, 18 Sep 2024 16:50:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_bcain@quicinc.com>)
 id 1sr1d1-00043w-Cc; Wed, 18 Sep 2024 16:50:23 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_bcain@quicinc.com>)
 id 1sr1cz-0008Az-8v; Wed, 18 Sep 2024 16:50:22 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48I9HEdU030698;
 Wed, 18 Sep 2024 20:50:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 LokDSERNP19gHVnEW4ynfMz1bXd8Vos4AgRAg7HxKE4=; b=kKlCgMAGVra0Z8y9
 uZ9oQ/yVnY1BR04N8hKKc8iMAscWTSARG5iNuSpw5hlXecw7gPN5iRoD1VbZ0vOq
 5T4EwEMFMYPBE7nxut3OpQBJDmaxzuNhWsizEgnL+Ge3FG3hwCkYIU2cWzwuZb92
 vsgMiCS3J1B7+ZGPoEP/lyj3R7ERFrHe1U/jzF4ez9CpKItlfoygH0/S40iQ8wpw
 2xKbkTqL43OeDe8L9NyNuT3+a1LN98lrSVcDmLJjxtTLzNZVV9rHGLNZkikPexY/
 6uJttJWZ6yzxxOqsGvUBiY3+yQm5/4J2Kd9O07ResYfUTHNS7DJUmPtwWT9/aPWZ
 XcJ1oA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41n4j6u8vh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 18 Sep 2024 20:50:10 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com
 [10.47.97.35])
 by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48IKo93h031554
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 18 Sep 2024 20:50:09 GMT
Received: from [10.110.61.117] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 18 Sep
 2024 13:50:09 -0700
Message-ID: <de414c13-d321-403c-93d6-df1bd3b783b8@quicinc.com>
Date: Wed, 18 Sep 2024 15:50:07 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hw: fix memory leak in IRQState allocation
To: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>,
 <qemu-devel@nongnu.org>
CC: <balaton@eik.bme.hu>, <mst@redhat.com>, <bcain@quicinc.com>,
 <qemu-trivial@nongnu.org>
References: <1723deb603afec3fa69a75970cef9aac62d57d62.1726674185.git.quic_mathbern@quicinc.com>
Content-Language: en-US
From: Brian Cain <quic_bcain@quicinc.com>
In-Reply-To: <1723deb603afec3fa69a75970cef9aac62d57d62.1726674185.git.quic_mathbern@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-ORIG-GUID: xThrzHBS2VYvvD_D7o7ocSLn-YczWjo2
X-Proofpoint-GUID: xThrzHBS2VYvvD_D7o7ocSLn-YczWjo2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 mlxlogscore=932
 mlxscore=0 malwarescore=0 bulkscore=0 priorityscore=1501 clxscore=1015
 adultscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2409180136
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=quic_bcain@quicinc.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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


On 9/18/2024 10:43 AM, Matheus Tavares Bernardino wrote:
> At e72a7f65c1 (hw: Move declaration of IRQState to header and add init
> function, 2024-06-29), we've changed qemu_allocate_irq() to use a
> combination of g_new() + object_initialize() instead of
> IRQ(object_new()). The latter sets obj->free, so that that the memory is
> properly cleaned when the object is finalized, but the former doesn't.
>
> Fixes: e72a7f65c1 (hw: Move declaration of IRQState to header and add init function)
> Signed-off-by: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
> Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
Reviewed-by: Brian Cain <bcain@quicinc.com>
> In v2: adjusted function init_irq_fields name to reflect it is not
> public and added BALATON's Reviewed-by
>
>   hw/core/irq.c | 19 +++++++++++--------
>   1 file changed, 11 insertions(+), 8 deletions(-)
>
> diff --git a/hw/core/irq.c b/hw/core/irq.c
> index db95ffc18f..7d5b0038c1 100644
> --- a/hw/core/irq.c
> +++ b/hw/core/irq.c
> @@ -34,13 +34,19 @@ void qemu_set_irq(qemu_irq irq, int level)
>       irq->handler(irq->opaque, irq->n, level);
>   }
>   
> +static void init_irq_fields(IRQState *irq, qemu_irq_handler handler,
> +                            void *opaque, int n)
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
> +    init_irq_fields(irq, handler, opaque, n);
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
> +    init_irq_fields(irq, handler, opaque, n);
>       return irq;
>   }
>   

