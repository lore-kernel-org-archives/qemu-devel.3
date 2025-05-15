Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 505DCC2D0CD
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 15:30:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFaVs-0005he-48; Thu, 15 May 2025 11:28:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1uFaVn-0005gC-Gy; Thu, 15 May 2025 11:28:43 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1uFaVh-0003sE-Nr; Thu, 15 May 2025 11:28:43 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54FCg4gG002206;
 Thu, 15 May 2025 15:28:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=/BY69o
 gv1bi2F2xg7qlBGicXZqaYq81IhJN6zuPbKIU=; b=JkarUpFFW3wP6jjZ30Avxz
 cwV77HS9HYwhvTEwB1KNwIELi/5DxZNErr3my9rKwB3iOM5Gk/V0TzgiC1pugy5Q
 hL218K6Wd1HMxLobfu6a3V8m0TchQraM9URkEtDbKsslhYNGXRD607B/VutOIEmf
 92kn3DM4+JqNWwiq1Gk+pyugz542cG8nzbf7y8v4asOAqlTZL+eC3z8ncNqRIags
 7wh7JycDB9tfwsqxdQjwD4nCHy7pZuItuRw1AJEwJXN5JNVNC0ZHf1enFTgwRD+R
 //f43YIxj1UPakGYu28DVs0jSVyUjC5j57Qa6X0/fDOhhgZY9Ik3YjUenswK5cyA
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46n0v6nakq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 15:28:34 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54FFMAHN025533;
 Thu, 15 May 2025 15:28:33 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46n0v6nakp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 15:28:33 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54FE0PFF024288;
 Thu, 15 May 2025 15:28:33 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46mbfsaxr4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 15:28:33 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 54FFSVnR22282884
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 15 May 2025 15:28:32 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AF20358057;
 Thu, 15 May 2025 15:28:31 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5BE3058063;
 Thu, 15 May 2025 15:28:31 +0000 (GMT)
Received: from [9.10.80.143] (unknown [9.10.80.143])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 15 May 2025 15:28:31 +0000 (GMT)
Message-ID: <f21b0331-be45-46bb-8f1d-797523175ba1@linux.ibm.com>
Date: Thu, 15 May 2025 10:28:30 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 39/50] ppc/xive: Assert group interrupts were redistributed
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?=
 <fbarrat@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Caleb Schlossin <calebs@linux.vnet.ibm.com>
References: <20250512031100.439842-1-npiggin@gmail.com>
 <20250512031100.439842-40-npiggin@gmail.com>
Content-Language: en-US
From: Mike Kowal <kowal@linux.ibm.com>
In-Reply-To: <20250512031100.439842-40-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=IqAecK/g c=1 sm=1 tr=0 ts=68260822 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8
 a=QkMIsaPlGapj7avH3-UA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: QdpGJAUNCYqmCzo5vEqHYaWCEOxbi6O-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDE1MCBTYWx0ZWRfX3Y4BSm+2vXuK
 3MzA4bxJUpQ4T/hc3qn5tvTAmleebLgnTcHm9WL2qyhR7g5gqjIhfRATBbINrAwb6kWerTysIhs
 k0wyIDVHPpN6wVqh3xxmCjheY/MCTAVriPab0UKY+nM2bvkP5d4KkwCrnkW7mY3O/sgOgBkIKCD
 dRMmFQ7xKFSsZEsW2VfWvCqRAQDr2eyv0vhpQy8MJ0/mMgrPHPeGOIECAmbE5ARrxgOGAyFGLgg
 gE1f/wCxE28QlS8BPW9G/4sgE6jaKIaQS0ZdRgj4EFJAblMxU/BE0Oan3q/tu0GSfqos3stcl01
 YR3pLHPFi/s/xnEPQkZiNRa9+4Kdovq2wtDujiEJ2TimDy5GZlQHc0D/lM9UAoJcjpmofYBMlGc
 u7HjIl6o4i9o6S+P5kPWILUqX7w/4afTx0sOyB5kKVKLxS6aZYTdT1iDhSpbDSAEpDz5cT5K
X-Proofpoint-GUID: qxb_YebHHvj0rYw3g-TuqCnjnqn9O5Xp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_06,2025-05-15_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 malwarescore=0
 adultscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0
 priorityscore=1501 clxscore=1015 spamscore=0 mlxlogscore=540 bulkscore=0
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505150150
Received-SPF: pass client-ip=148.163.158.5; envelope-from=kowal@linux.ibm.com;
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


On 5/11/2025 10:10 PM, Nicholas Piggin wrote:
> Add some assertions to try to ensure presented group interrupts do
> not get lost without being redistributed, if they become precluded
> by CPPR or preempted by a higher priority interrupt.

Reviewed-by: Michael Kowal<kowal@linux.ibm.com>

Thanks,  MAK
>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   hw/intc/xive.c  | 2 ++
>   hw/intc/xive2.c | 1 +
>   2 files changed, 3 insertions(+)
>
> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> index 4659821d4a..81af59f0ec 100644
> --- a/hw/intc/xive.c
> +++ b/hw/intc/xive.c
> @@ -132,6 +132,8 @@ void xive_tctx_pipr_set(XiveTCTX *tctx, uint8_t ring, uint8_t pipr,
>       uint8_t *sig_regs = xive_tctx_signal_regs(tctx, ring);
>       uint8_t *regs = &tctx->regs[ring];
>   
> +    g_assert(!xive_nsr_indicates_group_exception(ring, sig_regs[TM_NSR]));
> +
>       sig_regs[TM_PIPR] = pipr;
>   
>       if (pipr < sig_regs[TM_CPPR]) {
> diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
> index ace5871706..e3060810d3 100644
> --- a/hw/intc/xive2.c
> +++ b/hw/intc/xive2.c
> @@ -1089,6 +1089,7 @@ static void xive2_tctx_process_pending(XiveTCTX *tctx, uint8_t sig_ring)
>       int rc;
>   
>       g_assert(sig_ring == TM_QW3_HV_PHYS || sig_ring == TM_QW1_OS);
> +    g_assert(!xive_nsr_indicates_group_exception(sig_ring, sig_regs[TM_NSR]));
>   
>       /*
>        * Recompute the PIPR based on local pending interrupts. It will

