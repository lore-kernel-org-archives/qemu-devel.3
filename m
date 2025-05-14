Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38C41C3ABD8
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 20:49:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFJ2a-0007Wk-38; Wed, 14 May 2025 16:49:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1uFJ2Y-0007VZ-1J; Wed, 14 May 2025 16:49:22 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1uFJ2U-0001Cl-7O; Wed, 14 May 2025 16:49:21 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54EGECJq012993;
 Wed, 14 May 2025 20:49:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=x05+Po
 d0L5PnNSXKdlX+gXyDtd8N5bveEZ9ZUsT6IQ4=; b=m/E+21mnOMxC3op4pZ2lWn
 7LfJPFU73PRgyJmKLAqrBGIwkkUxsFTIhLtMAU6TTDiBukLkVARHn3AJuLaaAT33
 XmSBtUKBv9gnTr7QGp3GTPEEuSdbx5iObuZxdY2yQ0AD8UjgUHMLwjQwmz6AWp+4
 6+4ZC+YVilstxmcqED/lUmNukhZCsu2ARUAAVdnu3qH0w9RVLRcpQyMp018vXa/b
 b1OYdU/O8QOX91BaujbSMmfSw6Y8o3fnGHxXV8uHtPxplFchLfh1wQ5IItfIFDPd
 MOR2i3qkNXLmlSY+5XxszxKGVggwRphZ0+fzcB4D0jRrtGITAbXbx/RIXgxy/q4g
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46mrcjbj19-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 May 2025 20:49:15 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54EKkQj4016285;
 Wed, 14 May 2025 20:49:15 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46mrcjbj16-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 May 2025 20:49:15 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54EJcCMW015353;
 Wed, 14 May 2025 20:49:14 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 46mbfpxfw5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 May 2025 20:49:14 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 54EKnD3562390562
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 14 May 2025 20:49:13 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E0E785804E;
 Wed, 14 May 2025 20:49:12 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4743A5803F;
 Wed, 14 May 2025 20:49:12 +0000 (GMT)
Received: from [9.10.80.143] (unknown [9.10.80.143])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 14 May 2025 20:49:12 +0000 (GMT)
Message-ID: <594a0900-f056-4c26-9adc-ddec6f3e2620@linux.ibm.com>
Date: Wed, 14 May 2025 15:49:11 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 33/50] ppc/xive: tctx signaling registers rework
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?=
 <fbarrat@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Caleb Schlossin <calebs@linux.vnet.ibm.com>
References: <20250512031100.439842-1-npiggin@gmail.com>
 <20250512031100.439842-34-npiggin@gmail.com>
Content-Language: en-US
From: Mike Kowal <kowal@linux.ibm.com>
In-Reply-To: <20250512031100.439842-34-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=ZYgdNtVA c=1 sm=1 tr=0 ts=682501cb cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8
 a=WWzrH3oCMrBdhLkH65UA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: s2dxi_bBphIlfDoN2p24A7GEGZyrgAmc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE0MDE4NSBTYWx0ZWRfX4ZXpGbi12+ub
 8mS/nNzs4IqfcMk4QvYL5si5SBcUYpC9MpMs+UqEwX8vN0IGX4CI4wcvi7gz+kn0X0FPA8h1gzD
 uly4DGP/mlliAaqQoLjr/XTLzLPrWeEFU73KZI7ZcpKAmLicXtQVwKDDjEzVcNmFOJeOnapk/2S
 qzmYdqtRfVlPXPeQ1nmQy8pAJUjYa0e4UWav+4jmDokF96OK7HPOQrLvufurE6+DjhTM7qIVNFl
 YzAtDGPfNJD+TnAvgf1RDmP+RhgyM8NT6S+1iZ5VongrzFsAJuwDQKwSCaiJZ4fkGA001VuP6FU
 Rk5/3rFPPqeBt1zKMRfOcFGyQlHbpKfHbCLxx/zY3Sg8geOXU6cdaxgKZJncbf7zuEvZbh8z9/R
 bINOvui2lz1WJrJsQVoUidcowE8k+FsoHUnkKVzB7rxMGaYEWYhfHQYcYMnTFzI7/LY/A/BM
X-Proofpoint-GUID: cbb4kp1Ezx7D7A7XWc3hjCaGF6xrng_1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-14_04,2025-05-14_03,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 mlxscore=0 spamscore=0
 suspectscore=0 bulkscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505140185
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
> The tctx "signaling" registers (PIPR, CPPR, NSR) raise an interrupt on
> the target CPU thread. The POOL and PHYS rings both raise hypervisor
> interrupts, so they both share one set of signaling registers in the
> PHYS ring. The PHYS NSR register contains a field that indicates which
> ring has presented the interrupt being signaled to the CPU.
>
> This sharing results in all the "alt_regs" throughout the code. alt_regs
> is not very descriptive, and worse is that the name is used for
> conversions in both directions, i.e., to find the presenting ring from
> the signaling ring, and the signaling ring from the presenting ring.
>
> Instead of alt_regs, use the names sig_regs and sig_ring, and regs and
> ring for the presenting ring being worked on. Add a helper function to
> get the sign_regs, and add some asserts to ensure the POOL regs are
> never used to signal interrupts.


Reviewed-by: Michael Kowal<kowal@linux.ibm.com>

Thanks,  MAK


>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   hw/intc/xive.c        | 112 ++++++++++++++++++++++--------------------
>   hw/intc/xive2.c       |  94 ++++++++++++++++-------------------
>   include/hw/ppc/xive.h |  26 +++++++++-
>   3 files changed, 126 insertions(+), 106 deletions(-)
>
> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> index 5ff1b8f024..4e0c71d684 100644
> --- a/hw/intc/xive.c
> +++ b/hw/intc/xive.c
> @@ -80,69 +80,77 @@ static qemu_irq xive_tctx_output(XiveTCTX *tctx, uint8_t ring)
>           }
>   }
>   
> -uint64_t xive_tctx_accept(XiveTCTX *tctx, uint8_t ring)
> +/*
> + * interrupt is accepted on the presentation ring, for PHYS ring the NSR
> + * directs it to the PHYS or POOL rings.
> + */
> +uint64_t xive_tctx_accept(XiveTCTX *tctx, uint8_t sig_ring)
>   {
> -    uint8_t *regs = &tctx->regs[ring];
> -    uint8_t nsr = regs[TM_NSR];
> +    uint8_t *sig_regs = &tctx->regs[sig_ring];
> +    uint8_t nsr = sig_regs[TM_NSR];
>   
> -    qemu_irq_lower(xive_tctx_output(tctx, ring));
> +    g_assert(sig_ring == TM_QW1_OS || sig_ring == TM_QW3_HV_PHYS);
> +
> +    g_assert(tctx->regs[TM_QW2_HV_POOL + TM_NSR] == 0);
> +    g_assert(tctx->regs[TM_QW2_HV_POOL + TM_PIPR] == 0);
> +    g_assert(tctx->regs[TM_QW2_HV_POOL + TM_CPPR] == 0);
> +
> +    qemu_irq_lower(xive_tctx_output(tctx, sig_ring));
>   
> -    if (xive_nsr_indicates_exception(ring, nsr)) {
> -        uint8_t cppr = regs[TM_PIPR];
> -        uint8_t alt_ring;
> -        uint8_t *alt_regs;
> +    if (xive_nsr_indicates_exception(sig_ring, nsr)) {
> +        uint8_t cppr = sig_regs[TM_PIPR];
> +        uint8_t ring;
> +        uint8_t *regs;
>   
> -        alt_ring = xive_nsr_exception_ring(ring, nsr);
> -        alt_regs = &tctx->regs[alt_ring];
> +        ring = xive_nsr_exception_ring(sig_ring, nsr);
> +        regs = &tctx->regs[ring];
>   
> -        regs[TM_CPPR] = cppr;
> +        sig_regs[TM_CPPR] = cppr;
>   
>           /*
>            * If the interrupt was for a specific VP, reset the pending
>            * buffer bit, otherwise clear the logical server indicator
>            */
> -        if (!xive_nsr_indicates_group_exception(ring, nsr)) {
> -            alt_regs[TM_IPB] &= ~xive_priority_to_ipb(cppr);
> +        if (!xive_nsr_indicates_group_exception(sig_ring, nsr)) {
> +            regs[TM_IPB] &= ~xive_priority_to_ipb(cppr);
>           }
>   
>           /* Clear the exception from NSR */
> -        regs[TM_NSR] = 0;
> +        sig_regs[TM_NSR] = 0;
>   
> -        trace_xive_tctx_accept(tctx->cs->cpu_index, alt_ring,
> -                               alt_regs[TM_IPB], regs[TM_PIPR],
> -                               regs[TM_CPPR], regs[TM_NSR]);
> +        trace_xive_tctx_accept(tctx->cs->cpu_index, ring,
> +                               regs[TM_IPB], sig_regs[TM_PIPR],
> +                               sig_regs[TM_CPPR], sig_regs[TM_NSR]);
>       }
>   
> -    return ((uint64_t)nsr << 8) | regs[TM_CPPR];
> +    return ((uint64_t)nsr << 8) | sig_regs[TM_CPPR];
>   }
>   
>   void xive_tctx_notify(XiveTCTX *tctx, uint8_t ring, uint8_t group_level)
>   {
> -    /* HV_POOL ring uses HV_PHYS NSR, CPPR and PIPR registers */
> -    uint8_t alt_ring = (ring == TM_QW2_HV_POOL) ? TM_QW3_HV_PHYS : ring;
> -    uint8_t *alt_regs = &tctx->regs[alt_ring];
> +    uint8_t *sig_regs = xive_tctx_signal_regs(tctx, ring);
>       uint8_t *regs = &tctx->regs[ring];
>   
> -    if (alt_regs[TM_PIPR] < alt_regs[TM_CPPR]) {
> +    if (sig_regs[TM_PIPR] < sig_regs[TM_CPPR]) {
>           switch (ring) {
>           case TM_QW1_OS:
> -            regs[TM_NSR] = TM_QW1_NSR_EO | (group_level & 0x3F);
> +            sig_regs[TM_NSR] = TM_QW1_NSR_EO | (group_level & 0x3F);
>               break;
>           case TM_QW2_HV_POOL:
> -            alt_regs[TM_NSR] = (TM_QW3_NSR_HE_POOL << 6) | (group_level & 0x3F);
> +            sig_regs[TM_NSR] = (TM_QW3_NSR_HE_POOL << 6) | (group_level & 0x3F);
>               break;
>           case TM_QW3_HV_PHYS:
> -            regs[TM_NSR] = (TM_QW3_NSR_HE_PHYS << 6) | (group_level & 0x3F);
> +            sig_regs[TM_NSR] = (TM_QW3_NSR_HE_PHYS << 6) | (group_level & 0x3F);
>               break;
>           default:
>               g_assert_not_reached();
>           }
>           trace_xive_tctx_notify(tctx->cs->cpu_index, ring,
> -                               regs[TM_IPB], alt_regs[TM_PIPR],
> -                               alt_regs[TM_CPPR], alt_regs[TM_NSR]);
> +                               regs[TM_IPB], sig_regs[TM_PIPR],
> +                               sig_regs[TM_CPPR], sig_regs[TM_NSR]);
>           qemu_irq_raise(xive_tctx_output(tctx, ring));
>       } else {
> -        alt_regs[TM_NSR] = 0;
> +        sig_regs[TM_NSR] = 0;
>           qemu_irq_lower(xive_tctx_output(tctx, ring));
>       }
>   }
> @@ -159,25 +167,32 @@ void xive_tctx_reset_signal(XiveTCTX *tctx, uint8_t ring)
>   
>   static void xive_tctx_set_cppr(XiveTCTX *tctx, uint8_t ring, uint8_t cppr)
>   {
> -    uint8_t *regs = &tctx->regs[ring];
> +    uint8_t *sig_regs = &tctx->regs[ring];
>       uint8_t pipr_min;
>       uint8_t ring_min;
>   
> +    g_assert(ring == TM_QW1_OS || ring == TM_QW3_HV_PHYS);
> +
> +    g_assert(tctx->regs[TM_QW2_HV_POOL + TM_NSR] == 0);
> +    g_assert(tctx->regs[TM_QW2_HV_POOL + TM_PIPR] == 0);
> +    g_assert(tctx->regs[TM_QW2_HV_POOL + TM_CPPR] == 0);
> +
> +    /* XXX: should show pool IPB for PHYS ring */
>       trace_xive_tctx_set_cppr(tctx->cs->cpu_index, ring,
> -                             regs[TM_IPB], regs[TM_PIPR],
> -                             cppr, regs[TM_NSR]);
> +                             sig_regs[TM_IPB], sig_regs[TM_PIPR],
> +                             cppr, sig_regs[TM_NSR]);
>   
>       if (cppr > XIVE_PRIORITY_MAX) {
>           cppr = 0xff;
>       }
>   
> -    tctx->regs[ring + TM_CPPR] = cppr;
> +    sig_regs[TM_CPPR] = cppr;
>   
>       /*
>        * Recompute the PIPR based on local pending interrupts.  The PHYS
>        * ring must take the minimum of both the PHYS and POOL PIPR values.
>        */
> -    pipr_min = xive_ipb_to_pipr(regs[TM_IPB]);
> +    pipr_min = xive_ipb_to_pipr(sig_regs[TM_IPB]);
>       ring_min = ring;
>   
>       /* PHYS updates also depend on POOL values */
> @@ -186,7 +201,6 @@ static void xive_tctx_set_cppr(XiveTCTX *tctx, uint8_t ring, uint8_t cppr)
>   
>           /* POOL values only matter if POOL ctx is valid */
>           if (pool_regs[TM_WORD2] & 0x80) {
> -
>               uint8_t pool_pipr = xive_ipb_to_pipr(pool_regs[TM_IPB]);
>   
>               /*
> @@ -200,7 +214,7 @@ static void xive_tctx_set_cppr(XiveTCTX *tctx, uint8_t ring, uint8_t cppr)
>           }
>       }
>   
> -    regs[TM_PIPR] = pipr_min;
> +    sig_regs[TM_PIPR] = pipr_min;
>   
>       /* CPPR has changed, check if we need to raise a pending exception */
>       xive_tctx_notify(tctx, ring_min, 0);
> @@ -208,56 +222,50 @@ static void xive_tctx_set_cppr(XiveTCTX *tctx, uint8_t ring, uint8_t cppr)
>   
>   void xive_tctx_pipr_update(XiveTCTX *tctx, uint8_t ring, uint8_t priority,
>                              uint8_t group_level)
> - {
> -    /* HV_POOL ring uses HV_PHYS NSR, CPPR and PIPR registers */
> -    uint8_t alt_ring = (ring == TM_QW2_HV_POOL) ? TM_QW3_HV_PHYS : ring;
> -    uint8_t *alt_regs = &tctx->regs[alt_ring];
> +{
> +    uint8_t *sig_regs = xive_tctx_signal_regs(tctx, ring);
>       uint8_t *regs = &tctx->regs[ring];
>   
>       if (group_level == 0) {
>           /* VP-specific */
>           regs[TM_IPB] |= xive_priority_to_ipb(priority);
> -        alt_regs[TM_PIPR] = xive_ipb_to_pipr(regs[TM_IPB]);
> +        sig_regs[TM_PIPR] = xive_ipb_to_pipr(regs[TM_IPB]);
>       } else {
>           /* VP-group */
> -        alt_regs[TM_PIPR] = xive_priority_to_pipr(priority);
> +        sig_regs[TM_PIPR] = xive_priority_to_pipr(priority);
>       }
>       xive_tctx_notify(tctx, ring, group_level);
>    }
>   
>   static void xive_tctx_pipr_recompute_from_ipb(XiveTCTX *tctx, uint8_t ring)
>   {
> -    /* HV_POOL ring uses HV_PHYS NSR, CPPR and PIPR registers */
> -    uint8_t alt_ring = (ring == TM_QW2_HV_POOL) ? TM_QW3_HV_PHYS : ring;
> -    uint8_t *aregs = &tctx->regs[alt_ring];
> +    uint8_t *sig_regs = xive_tctx_signal_regs(tctx, ring);
>       uint8_t *regs = &tctx->regs[ring];
>   
>       /* Does not support a presented group interrupt */
> -    g_assert(!xive_nsr_indicates_group_exception(alt_ring, aregs[TM_NSR]));
> +    g_assert(!xive_nsr_indicates_group_exception(ring, sig_regs[TM_NSR]));
>   
> -    aregs[TM_PIPR] = xive_ipb_to_pipr(regs[TM_IPB]);
> +    sig_regs[TM_PIPR] = xive_ipb_to_pipr(regs[TM_IPB]);
>       xive_tctx_notify(tctx, ring, 0);
>   }
>   
>   void xive_tctx_pipr_present(XiveTCTX *tctx, uint8_t ring, uint8_t priority,
>                               uint8_t group_level)
>   {
> -    /* HV_POOL ring uses HV_PHYS NSR, CPPR and PIPR registers */
> -    uint8_t alt_ring = (ring == TM_QW2_HV_POOL) ? TM_QW3_HV_PHYS : ring;
> -    uint8_t *aregs = &tctx->regs[alt_ring];
> +    uint8_t *sig_regs = xive_tctx_signal_regs(tctx, ring);
>       uint8_t *regs = &tctx->regs[ring];
>       uint8_t pipr = xive_priority_to_pipr(priority);
>   
>       if (group_level == 0) {
>           regs[TM_IPB] |= xive_priority_to_ipb(priority);
> -        if (pipr >= aregs[TM_PIPR]) {
> +        if (pipr >= sig_regs[TM_PIPR]) {
>               /* VP interrupts can come here with lower priority than PIPR */
>               return;
>           }
>       }
>       g_assert(pipr <= xive_ipb_to_pipr(regs[TM_IPB]));
> -    g_assert(pipr < aregs[TM_PIPR]);
> -    aregs[TM_PIPR] = pipr;
> +    g_assert(pipr < sig_regs[TM_PIPR]);
> +    sig_regs[TM_PIPR] = pipr;
>       xive_tctx_notify(tctx, ring, group_level);
>   }
>   
> diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
> index f91109b84a..b9ee8c9e9f 100644
> --- a/hw/intc/xive2.c
> +++ b/hw/intc/xive2.c
> @@ -606,11 +606,9 @@ static uint32_t xive2_tctx_hw_cam_line(XivePresenter *xptr, XiveTCTX *tctx)
>   
>   static void xive2_redistribute(Xive2Router *xrtr, XiveTCTX *tctx, uint8_t ring)
>   {
> -    uint8_t *regs = &tctx->regs[ring];
> -    uint8_t *alt_regs = (ring == TM_QW2_HV_POOL) ? &tctx->regs[TM_QW3_HV_PHYS] :
> -                                                   regs;
> -    uint8_t nsr = alt_regs[TM_NSR];
> -    uint8_t pipr = alt_regs[TM_PIPR];
> +    uint8_t *sig_regs = xive_tctx_signal_regs(tctx, ring);
> +    uint8_t nsr = sig_regs[TM_NSR];
> +    uint8_t pipr = sig_regs[TM_PIPR];
>       uint8_t crowd = NVx_CROWD_LVL(nsr);
>       uint8_t group = NVx_GROUP_LVL(nsr);
>       uint8_t nvgc_blk, end_blk, nvp_blk;
> @@ -618,19 +616,16 @@ static void xive2_redistribute(Xive2Router *xrtr, XiveTCTX *tctx, uint8_t ring)
>       Xive2Nvgc nvgc;
>       uint8_t prio_limit;
>       uint32_t cfg;
> -    uint8_t alt_ring;
>   
>       /* redistribution is only for group/crowd interrupts */
>       if (!xive_nsr_indicates_group_exception(ring, nsr)) {
>           return;
>       }
>   
> -    alt_ring = xive_nsr_exception_ring(ring, nsr);
> -
>       /* Don't check return code since ring is expected to be invalidated */
> -    xive2_tctx_get_nvp_indexes(tctx, alt_ring, &nvp_blk, &nvp_idx);
> +    xive2_tctx_get_nvp_indexes(tctx, ring, &nvp_blk, &nvp_idx);
>   
> -    trace_xive_redistribute(tctx->cs->cpu_index, alt_ring, nvp_blk, nvp_idx);
> +    trace_xive_redistribute(tctx->cs->cpu_index, ring, nvp_blk, nvp_idx);
>   
>       trace_xive_redistribute(tctx->cs->cpu_index, ring, nvp_blk, nvp_idx);
>       /* convert crowd/group to blk/idx */
> @@ -675,23 +670,11 @@ static void xive2_redistribute(Xive2Router *xrtr, XiveTCTX *tctx, uint8_t ring)
>       xive2_router_end_notify(xrtr, end_blk, end_idx, 0, true);
>   
>       /* clear interrupt indication for the context */
> -    alt_regs[TM_NSR] = 0;
> -    alt_regs[TM_PIPR] = alt_regs[TM_CPPR];
> +    sig_regs[TM_NSR] = 0;
> +    sig_regs[TM_PIPR] = sig_regs[TM_CPPR];
>       xive_tctx_reset_signal(tctx, ring);
>   }
>   
> -static uint8_t xive2_hv_irq_ring(uint8_t nsr)
> -{
> -    switch (nsr >> 6) {
> -    case TM_QW3_NSR_HE_POOL:
> -        return TM_QW2_HV_POOL;
> -    case TM_QW3_NSR_HE_PHYS:
> -        return TM_QW3_HV_PHYS;
> -    default:
> -        return -1;
> -    }
> -}
> -
>   static uint64_t xive2_tm_pull_ctx(XivePresenter *xptr, XiveTCTX *tctx,
>                                     hwaddr offset, unsigned size, uint8_t ring)
>   {
> @@ -718,7 +701,8 @@ static uint64_t xive2_tm_pull_ctx(XivePresenter *xptr, XiveTCTX *tctx,
>           uint32_t ringw2 = xive_tctx_word2(&tctx->regs[cur_ring]);
>           uint32_t ringw2_new = xive_set_field32(TM2_QW1W2_VO, ringw2, 0);
>           bool is_valid = !!(xive_get_field32(TM2_QW1W2_VO, ringw2));
> -        uint8_t alt_ring;
> +        uint8_t *sig_regs;
> +
>           memcpy(&tctx->regs[cur_ring + TM_WORD2], &ringw2_new, 4);
>   
>           /* Skip the rest for USER or invalid contexts */
> @@ -727,12 +711,11 @@ static uint64_t xive2_tm_pull_ctx(XivePresenter *xptr, XiveTCTX *tctx,
>           }
>   
>           /* Active group/crowd interrupts need to be redistributed */
> -        alt_ring = (cur_ring == TM_QW2_HV_POOL) ? TM_QW3_HV_PHYS : cur_ring;
> -        nsr = tctx->regs[alt_ring + TM_NSR];
> -        if (xive_nsr_indicates_group_exception(alt_ring, nsr)) {
> -            /* For HV rings, only redistribute if cur_ring matches NSR */
> -            if ((cur_ring == TM_QW1_OS) ||
> -                (cur_ring == xive2_hv_irq_ring(nsr))) {
> +        sig_regs = xive_tctx_signal_regs(tctx, ring);
> +        nsr = sig_regs[TM_NSR];
> +        if (xive_nsr_indicates_group_exception(cur_ring, nsr)) {
> +            /* Ensure ring matches NSR (for HV NSR POOL vs PHYS rings) */
> +            if (cur_ring == xive_nsr_exception_ring(cur_ring, nsr)) {
>                   xive2_redistribute(xrtr, tctx, cur_ring);
>               }
>           }
> @@ -1118,7 +1101,7 @@ void xive2_tm_ack_os_el(XivePresenter *xptr, XiveTCTX *tctx,
>   /* NOTE: CPPR only exists for TM_QW1_OS and TM_QW3_HV_PHYS */
>   static void xive2_tctx_set_cppr(XiveTCTX *tctx, uint8_t ring, uint8_t cppr)
>   {
> -    uint8_t *regs = &tctx->regs[ring];
> +    uint8_t *sig_regs = &tctx->regs[ring];
>       Xive2Router *xrtr = XIVE2_ROUTER(tctx->xptr);
>       uint8_t old_cppr, backlog_prio, first_group, group_level;
>       uint8_t pipr_min, lsmfb_min, ring_min;
> @@ -1127,33 +1110,41 @@ static void xive2_tctx_set_cppr(XiveTCTX *tctx, uint8_t ring, uint8_t cppr)
>       uint32_t nvp_idx;
>       Xive2Nvp nvp;
>       int rc;
> -    uint8_t nsr = regs[TM_NSR];
> +    uint8_t nsr = sig_regs[TM_NSR];
> +
> +    g_assert(ring == TM_QW1_OS || ring == TM_QW3_HV_PHYS);
> +
> +    g_assert(tctx->regs[TM_QW2_HV_POOL + TM_NSR] == 0);
> +    g_assert(tctx->regs[TM_QW2_HV_POOL + TM_PIPR] == 0);
> +    g_assert(tctx->regs[TM_QW2_HV_POOL + TM_CPPR] == 0);
>   
> +    /* XXX: should show pool IPB for PHYS ring */
>       trace_xive_tctx_set_cppr(tctx->cs->cpu_index, ring,
> -                             regs[TM_IPB], regs[TM_PIPR],
> +                             sig_regs[TM_IPB], sig_regs[TM_PIPR],
>                                cppr, nsr);
>   
>       if (cppr > XIVE_PRIORITY_MAX) {
>           cppr = 0xff;
>       }
>   
> -    old_cppr = regs[TM_CPPR];
> -    regs[TM_CPPR] = cppr;
> +    old_cppr = sig_regs[TM_CPPR];
> +    sig_regs[TM_CPPR] = cppr;
>   
>       /* Handle increased CPPR priority (lower value) */
>       if (cppr < old_cppr) {
> -        if (cppr <= regs[TM_PIPR]) {
> +        if (cppr <= sig_regs[TM_PIPR]) {
>               /* CPPR lowered below PIPR, must un-present interrupt */
>               if (xive_nsr_indicates_exception(ring, nsr)) {
>                   if (xive_nsr_indicates_group_exception(ring, nsr)) {
>                       /* redistribute precluded active grp interrupt */
> -                    xive2_redistribute(xrtr, tctx, ring);
> +                    xive2_redistribute(xrtr, tctx,
> +                                       xive_nsr_exception_ring(ring, nsr));
>                       return;
>                   }
>               }
>   
>               /* interrupt is VP directed, pending in IPB */
> -            regs[TM_PIPR] = cppr;
> +            sig_regs[TM_PIPR] = cppr;
>               xive_tctx_notify(tctx, ring, 0); /* Ensure interrupt is cleared */
>               return;
>           } else {
> @@ -1174,9 +1165,9 @@ static void xive2_tctx_set_cppr(XiveTCTX *tctx, uint8_t ring, uint8_t cppr)
>        * be adjusted below if needed in case of pending group interrupts.
>        */
>   again:
> -    pipr_min = xive_ipb_to_pipr(regs[TM_IPB]);
> -    group_enabled = !!regs[TM_LGS];
> -    lsmfb_min = group_enabled ? regs[TM_LSMFB] : 0xff;
> +    pipr_min = xive_ipb_to_pipr(sig_regs[TM_IPB]);
> +    group_enabled = !!sig_regs[TM_LGS];
> +    lsmfb_min = group_enabled ? sig_regs[TM_LSMFB] : 0xff;
>       ring_min = ring;
>       group_level = 0;
>   
> @@ -1265,7 +1256,7 @@ again:
>       }
>   
>       /* PIPR should not be set to a value greater than CPPR */
> -    regs[TM_PIPR] = (pipr_min > cppr) ? cppr : pipr_min;
> +    sig_regs[TM_PIPR] = (pipr_min > cppr) ? cppr : pipr_min;
>   
>       /* CPPR has changed, check if we need to raise a pending exception */
>       xive_tctx_notify(tctx, ring_min, group_level);
> @@ -1490,9 +1481,7 @@ int xive2_presenter_tctx_match(XivePresenter *xptr, XiveTCTX *tctx,
>   
>   bool xive2_tm_irq_precluded(XiveTCTX *tctx, int ring, uint8_t priority)
>   {
> -    /* HV_POOL ring uses HV_PHYS NSR, CPPR and PIPR registers */
> -    uint8_t alt_ring = (ring == TM_QW2_HV_POOL) ? TM_QW3_HV_PHYS : ring;
> -    uint8_t *alt_regs = &tctx->regs[alt_ring];
> +    uint8_t *sig_regs = xive_tctx_signal_regs(tctx, ring);
>   
>       /*
>        * The xive2_presenter_tctx_match() above tells if there's a match
> @@ -1500,7 +1489,7 @@ bool xive2_tm_irq_precluded(XiveTCTX *tctx, int ring, uint8_t priority)
>        * priority to know if the thread can take the interrupt now or if
>        * it is precluded.
>        */
> -    if (priority < alt_regs[TM_PIPR]) {
> +    if (priority < sig_regs[TM_PIPR]) {
>           return false;
>       }
>       return true;
> @@ -1640,14 +1629,13 @@ static void xive2_router_end_notify(Xive2Router *xrtr, uint8_t end_blk,
>                                &match)) {
>           XiveTCTX *tctx = match.tctx;
>           uint8_t ring = match.ring;
> -        uint8_t alt_ring = (ring == TM_QW2_HV_POOL) ? TM_QW3_HV_PHYS : ring;
> -        uint8_t *aregs = &tctx->regs[alt_ring];
> -        uint8_t nsr = aregs[TM_NSR];
> +        uint8_t *sig_regs = xive_tctx_signal_regs(tctx, ring);
> +        uint8_t nsr = sig_regs[TM_NSR];
>           uint8_t group_level;
>   
> -        if (priority < aregs[TM_PIPR] &&
> -            xive_nsr_indicates_group_exception(alt_ring, nsr)) {
> -            xive2_redistribute(xrtr, tctx, alt_ring);
> +        if (priority < sig_regs[TM_PIPR] &&
> +            xive_nsr_indicates_group_exception(ring, nsr)) {
> +            xive2_redistribute(xrtr, tctx, xive_nsr_exception_ring(ring, nsr));
>           }
>   
>           group_level = xive_get_group_level(crowd, cam_ignore, nvx_blk, nvx_idx);
> diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
> index 0d6b11e818..a3c2f50ece 100644
> --- a/include/hw/ppc/xive.h
> +++ b/include/hw/ppc/xive.h
> @@ -539,7 +539,7 @@ static inline uint8_t xive_ipb_to_pipr(uint8_t ibp)
>   }
>   
>   /*
> - * XIVE Thread Interrupt Management Aera (TIMA)
> + * XIVE Thread Interrupt Management Area (TIMA)
>    *
>    * This region gives access to the registers of the thread interrupt
>    * management context. It is four page wide, each page providing a
> @@ -551,6 +551,30 @@ static inline uint8_t xive_ipb_to_pipr(uint8_t ibp)
>   #define XIVE_TM_OS_PAGE         0x2
>   #define XIVE_TM_USER_PAGE       0x3
>   
> +/*
> + * The TCTX (TIMA) has 4 rings (phys, pool, os, user), but only signals
> + * (raises an interrupt on) the CPU from 3 of them. Phys and pool both
> + * cause a hypervisor privileged interrupt so interrupts presented on
> + * those rings signal using the phys ring. This helper returns the signal
> + * regs from the given ring.
> + */
> +static inline uint8_t *xive_tctx_signal_regs(XiveTCTX *tctx, uint8_t ring)
> +{
> +    /*
> +     * This is a good point to add invariants to ensure nothing has tried to
> +     * signal using the POOL ring.
> +     */
> +    g_assert(tctx->regs[TM_QW2_HV_POOL + TM_NSR] == 0);
> +    g_assert(tctx->regs[TM_QW2_HV_POOL + TM_PIPR] == 0);
> +    g_assert(tctx->regs[TM_QW2_HV_POOL + TM_CPPR] == 0);
> +
> +    if (ring == TM_QW2_HV_POOL) {
> +        /* POOL and PHYS rings share the signal regs (PIPR, NSR, CPPR) */
> +        ring = TM_QW3_HV_PHYS;
> +    }
> +    return &tctx->regs[ring];
> +}
> +
>   void xive_tctx_tm_write(XivePresenter *xptr, XiveTCTX *tctx, hwaddr offset,
>                           uint64_t value, unsigned size);
>   uint64_t xive_tctx_tm_read(XivePresenter *xptr, XiveTCTX *tctx, hwaddr offset,

