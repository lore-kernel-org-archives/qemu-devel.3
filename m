Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38332C3ABD8
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 19:49:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFI63-0002bl-9l; Wed, 14 May 2025 15:48:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1uFI5z-0002Ub-2A; Wed, 14 May 2025 15:48:51 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1uFI5w-0001Ai-Vb; Wed, 14 May 2025 15:48:50 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54EIsewi013318;
 Wed, 14 May 2025 19:48:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=rBEWxo
 7YHX4ptmzEoPut51X32rlenDSvLHz4MxN804U=; b=chD1LflY3gJnFPwM8fSvWV
 +J13SyMYZu9cXkGImwAGWniGee2eWjZIYI7JnJS53M7fuYEequ3iZ5qpXKHLOUnM
 3mc9IwozSoQHp+fMGJWHSpYZL8uepNc5Tte8XNU+A+Pza+z2iMriNGMUTSzzmGph
 eHz7bVD08kv0bP4xo24pfP3A3PF316EUTzIzn6aHcusxd7KeCwKtmeUtCJt7u6r4
 jLMXChntaxvgqVR9PSs1/dOpfEJr/ISuHrxLChi3tjjzoWGFriy6Od71hcfGR4Ld
 yIHqctv/2H8a64hvyLtvfuJfnPUqudKJLzd9A5Fau2yshDmFBNBAfyu0isQUuxxg
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46n0v6g9rf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 May 2025 19:48:47 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54EJmkj1007544;
 Wed, 14 May 2025 19:48:46 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46n0v6g9rc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 May 2025 19:48:46 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54EJeCB7024322;
 Wed, 14 May 2025 19:48:46 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46mbfs66g3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 May 2025 19:48:46 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 54EJmip921693084
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 14 May 2025 19:48:44 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D77635804E;
 Wed, 14 May 2025 19:48:44 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 505F35803F;
 Wed, 14 May 2025 19:48:44 +0000 (GMT)
Received: from [9.10.80.143] (unknown [9.10.80.143])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 14 May 2025 19:48:44 +0000 (GMT)
Message-ID: <c26a1461-7a63-4673-84bc-4387c327ac04@linux.ibm.com>
Date: Wed, 14 May 2025 14:48:43 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 26/50] ppc/xive2: Redistribute group interrupt precluded
 by CPPR update
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?=
 <fbarrat@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Caleb Schlossin <calebs@linux.vnet.ibm.com>
References: <20250512031100.439842-1-npiggin@gmail.com>
 <20250512031100.439842-27-npiggin@gmail.com>
Content-Language: en-US
From: Mike Kowal <kowal@linux.ibm.com>
In-Reply-To: <20250512031100.439842-27-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=IqAecK/g c=1 sm=1 tr=0 ts=6824f39f cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=AcSaozVda94OPL_zz7AA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: J7YfsFsrCVm1SsBzScC0l0roo5HZJoyP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE0MDE4MCBTYWx0ZWRfX1ozHjv8f11iV
 xwmzbq63IzlcaBTUOwjknWNKeokFHChY/e2ur0jeh+uRy7MdSN4KGT5E8rcidWgE+WysrYc58tH
 CkwFO/vyKhTIwVuo7fb+6F/S+AXUJPYOWghO78rqkSAeuIyy0ch1oPYy4DfolisfJtZD3n1Vtjd
 YfgDPhGjKTHJ8jK+8ybQZHpDn/4jWrSh9AU4MJt1LBsVAT7kvMJf496Axq2Loq6ikr2CctiKxFP
 bKXyZ/Ff60LvJSA5Ht8iy93J5mX6QVkXshKkKn8tyB3cR/QUCTWdeG3+TgDzQQc3ZDzynmZJUPk
 NBXbATrj5ekBWvHBy3A0zFgIdX7TfmHWg8kGaP56WyfpsbHQSG4nIWUTczFGk3zZ9dB8HsW4Wng
 i4oIC5RjJDfnKCSDEuiDShh6Wg9zuhqXuCt+RJziQkUah78lZNbGc7HtwzARsucX7eG+LLKk
X-Proofpoint-GUID: WUNqMwG3Qpjeoso5y-Lip0XB56AyN-An
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-14_04,2025-05-14_03,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 malwarescore=0
 adultscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0
 priorityscore=1501 clxscore=1015 spamscore=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505140180
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
> From: Glenn Miles <milesg@linux.ibm.com>
>
> Add support for redistributing a presented group interrupt if it
> is precluded as a result of changing the CPPR value. Without this,
> group interrupts can be lost.

Reviewed-by: Michael Kowal<kowal@linux.ibm.com>

Thanks,  MAK

>
> Signed-off-by: Glenn Miles <milesg@linux.ibm.com>
> ---
>   hw/intc/xive2.c | 82 ++++++++++++++++++++++++++++++++++++-------------
>   1 file changed, 60 insertions(+), 22 deletions(-)
>
> diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
> index 68be138335..92dbbad8d4 100644
> --- a/hw/intc/xive2.c
> +++ b/hw/intc/xive2.c
> @@ -601,20 +601,37 @@ static uint32_t xive2_tctx_hw_cam_line(XivePresenter *xptr, XiveTCTX *tctx)
>       return xive2_nvp_cam_line(blk, 1 << tid_shift | (pir & tid_mask));
>   }
>   
> -static void xive2_redistribute(Xive2Router *xrtr, XiveTCTX *tctx,
> -                               uint8_t nvp_blk, uint32_t nvp_idx, uint8_t ring)
> +static void xive2_redistribute(Xive2Router *xrtr, XiveTCTX *tctx, uint8_t ring)
>   {
> -    uint8_t nsr = tctx->regs[ring + TM_NSR];
> +    uint8_t *regs = &tctx->regs[ring];
> +    uint8_t nsr = regs[TM_NSR];
> +    uint8_t pipr = regs[TM_PIPR];
>       uint8_t crowd = NVx_CROWD_LVL(nsr);
>       uint8_t group = NVx_GROUP_LVL(nsr);
> -    uint8_t nvgc_blk;
> -    uint8_t nvgc_idx;
> -    uint8_t end_blk;
> -    uint32_t end_idx;
> -    uint8_t pipr = tctx->regs[ring + TM_PIPR];
> +    uint8_t nvgc_blk, end_blk, nvp_blk;
> +    uint32_t nvgc_idx, end_idx, nvp_idx;
>       Xive2Nvgc nvgc;
>       uint8_t prio_limit;
>       uint32_t cfg;
> +    uint8_t alt_ring;
> +    uint32_t target_ringw2;
> +    uint32_t cam;
> +    bool valid;
> +    bool hw;
> +
> +    /* redistribution is only for group/crowd interrupts */
> +    if (!xive_nsr_indicates_group_exception(ring, nsr)) {
> +        return;
> +    }
> +
> +    alt_ring = xive_nsr_exception_ring(ring, nsr);
> +    target_ringw2 = xive_tctx_word2(&tctx->regs[alt_ring]);
> +    cam = be32_to_cpu(target_ringw2);
> +
> +    /* extract nvp block and index from targeted ring's cam */
> +    xive2_cam_decode(cam, &nvp_blk, &nvp_idx, &valid, &hw);
> +
> +    trace_xive_redistribute(tctx->cs->cpu_index, alt_ring, nvp_blk, nvp_idx);
>   
>       trace_xive_redistribute(tctx->cs->cpu_index, ring, nvp_blk, nvp_idx);
>       /* convert crowd/group to blk/idx */
> @@ -659,8 +676,8 @@ static void xive2_redistribute(Xive2Router *xrtr, XiveTCTX *tctx,
>       xive2_router_end_notify(xrtr, end_blk, end_idx, 0, true);
>   
>       /* clear interrupt indication for the context */
> -    tctx->regs[ring + TM_NSR] = 0;
> -    tctx->regs[ring + TM_PIPR] = tctx->regs[ring + TM_CPPR];
> +    regs[TM_NSR] = 0;
> +    regs[TM_PIPR] = regs[TM_CPPR];
>       xive_tctx_reset_signal(tctx, ring);
>   }
>   
> @@ -695,7 +712,7 @@ static uint64_t xive2_tm_pull_ctx(XivePresenter *xptr, XiveTCTX *tctx,
>       /* Active group/crowd interrupts need to be redistributed */
>       nsr = tctx->regs[ring + TM_NSR];
>       if (xive_nsr_indicates_group_exception(ring, nsr)) {
> -        xive2_redistribute(xrtr, tctx, nvp_blk, nvp_idx, ring);
> +        xive2_redistribute(xrtr, tctx, ring);
>       }
>   
>       if (xive2_router_get_config(xrtr) & XIVE2_VP_SAVE_RESTORE && do_save) {
> @@ -1059,6 +1076,7 @@ void xive2_tm_ack_os_el(XivePresenter *xptr, XiveTCTX *tctx,
>       xive2_tctx_accept_el(xptr, tctx, TM_QW1_OS, TM_QW1_OS);
>   }
>   
> +/* NOTE: CPPR only exists for TM_QW1_OS and TM_QW3_HV_PHYS */
>   static void xive2_tctx_set_cppr(XiveTCTX *tctx, uint8_t ring, uint8_t cppr)
>   {
>       uint8_t *regs = &tctx->regs[ring];
> @@ -1069,10 +1087,11 @@ static void xive2_tctx_set_cppr(XiveTCTX *tctx, uint8_t ring, uint8_t cppr)
>       uint32_t nvp_blk, nvp_idx;
>       Xive2Nvp nvp;
>       int rc;
> +    uint8_t nsr = regs[TM_NSR];
>   
>       trace_xive_tctx_set_cppr(tctx->cs->cpu_index, ring,
>                                regs[TM_IPB], regs[TM_PIPR],
> -                             cppr, regs[TM_NSR]);
> +                             cppr, nsr);
>   
>       if (cppr > XIVE_PRIORITY_MAX) {
>           cppr = 0xff;
> @@ -1081,6 +1100,35 @@ static void xive2_tctx_set_cppr(XiveTCTX *tctx, uint8_t ring, uint8_t cppr)
>       old_cppr = regs[TM_CPPR];
>       regs[TM_CPPR] = cppr;
>   
> +    /* Handle increased CPPR priority (lower value) */
> +    if (cppr < old_cppr) {
> +        if (cppr <= regs[TM_PIPR]) {
> +            /* CPPR lowered below PIPR, must un-present interrupt */
> +            if (xive_nsr_indicates_exception(ring, nsr)) {
> +                if (xive_nsr_indicates_group_exception(ring, nsr)) {
> +                    /* redistribute precluded active grp interrupt */
> +                    xive2_redistribute(xrtr, tctx, ring);
> +                    return;
> +                }
> +            }
> +
> +            /* interrupt is VP directed, pending in IPB */
> +            regs[TM_PIPR] = cppr;
> +            xive_tctx_notify(tctx, ring, 0); /* Ensure interrupt is cleared */
> +            return;
> +        } else {
> +            /* CPPR was lowered, but still above PIPR. No action needed. */
> +            return;
> +        }
> +    }
> +
> +    /* CPPR didn't change, nothing needs to be done */
> +    if (cppr == old_cppr) {
> +        return;
> +    }
> +
> +    /* CPPR priority decreased (higher value) */
> +
>       /*
>        * Recompute the PIPR based on local pending interrupts. It will
>        * be adjusted below if needed in case of pending group interrupts.
> @@ -1129,16 +1177,6 @@ again:
>           return;
>       }
>   
> -    if (cppr < old_cppr) {
> -        /*
> -         * FIXME: check if there's a group interrupt being presented
> -         * and if the new cppr prevents it. If so, then the group
> -         * interrupt needs to be re-added to the backlog and
> -         * re-triggered (see re-trigger END info in the NVGC
> -         * structure)
> -         */
> -    }
> -
>       if (group_enabled &&
>           lsmfb_min < cppr &&
>           lsmfb_min < pipr_min) {

