Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0FC1C3ABD8
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 19:52:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFI8Y-0005oa-MV; Wed, 14 May 2025 15:51:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1uFI8W-0005mC-0u; Wed, 14 May 2025 15:51:28 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1uFI8T-0001hI-DF; Wed, 14 May 2025 15:51:27 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54EDn6mC003586;
 Wed, 14 May 2025 19:51:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=TexI9L
 uO/o+ubnA4Nm9X+aHDAcUI1L0s4VmMviRcFOI=; b=E9e0Pbp0lQhe8Yspib75yz
 WqgGEmDhHbEbcZ1Omp4+PMu0ggNIB/swQVBhRGDYNPKExX7BgYHCA/TWfIxvIxJB
 65dGF4ECgQaS5gkSqh3E2os3b1bkTikbvw0IpTa28Cdibin1X8gbv98LSoGC+E3M
 sgUzDmBlm44ecDiFotjhXNM94fvwWj6rdHU9eJrWC67CTNh9zgGqkd9+I7Udd1hA
 DzpEeESqD232BvZnlzf2TTmpSyFToPehH9QGoOSsD56I+irqthuI7OedyNaNnxlR
 i/hh8U91e49q5evMfkAOmcshXJWNvweZDeC59LSGyknrOVOjMKxyEPI94lHSalZA
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46mvd3a0b6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 May 2025 19:51:23 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54EJpN3B028559;
 Wed, 14 May 2025 19:51:23 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46mvd3a0b5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 May 2025 19:51:23 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54EJcJTc015300;
 Wed, 14 May 2025 19:51:22 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 46mbfpx6vs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 May 2025 19:51:22 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 54EJpKEt30868068
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 14 May 2025 19:51:20 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B8BE258054;
 Wed, 14 May 2025 19:51:20 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 306CD5804E;
 Wed, 14 May 2025 19:51:20 +0000 (GMT)
Received: from [9.10.80.143] (unknown [9.10.80.143])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 14 May 2025 19:51:20 +0000 (GMT)
Message-ID: <0b40801d-ac99-4b27-8f85-243c7089fd7f@linux.ibm.com>
Date: Wed, 14 May 2025 14:51:19 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 27/50] ppc/xive2: redistribute irqs for pool and phys ctx
 pull
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?=
 <fbarrat@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Caleb Schlossin <calebs@linux.vnet.ibm.com>
References: <20250512031100.439842-1-npiggin@gmail.com>
 <20250512031100.439842-28-npiggin@gmail.com>
Content-Language: en-US
From: Mike Kowal <kowal@linux.ibm.com>
In-Reply-To: <20250512031100.439842-28-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 5F1WDP8LRBKk9o4fhrIahTQj1oLztudY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE0MDE4MCBTYWx0ZWRfXxAMmsJJ5VdvH
 wPOesvdZ+6AEljLtaWQkbEIdZojZsHEiqq7PiHday0VYDpo97nV/Ql7XKc0/h90y4DNWUrbz50S
 MtC+S7n+iD+8gDZbVc+JKqr+uPYno1Eyz82jcfg/Xbo6b78fq8aecZtYpIyVLZzQxjc6w5Gve1p
 M/YoCCfI6fKHiXfhsR2Ky19sfmEviaNN+nR5W502goANbzdANCg1IRpGpBrR2DVvM9uqt6F5+IC
 cEqtCPDlXTE3zxZnupJA7gZvRnV2nUrejX1v2kVnzeax0w1L7nsrBvMSsnt81t6nlmB9BSm3gj/
 tkewckx3yh3v5UGSA/B8hjYd3psvu+rr8Tm1cHsmXoeRNXOTPdrbePf8CmefNDFPs1JyIBMKuxV
 5TCnro/9tPsrCcadYsyp0a5khsP7M20jyi3KVllQNVHY3A4fh/F0bhEmy+NTmWQ94yArWOJv
X-Proofpoint-ORIG-GUID: 6XL54zHUmvT3QiYNY3Qmu-ZUzi0LbKFh
X-Authority-Analysis: v=2.4 cv=GbEXnRXL c=1 sm=1 tr=0 ts=6824f43b cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=XDSjNo-0thwMDuTFyp4A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-14_04,2025-05-14_03,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
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
> When disabling (pulling) an xive interrupt context, we need
> to redistribute any active group interrupts to other threads
> that can handle the interrupt if possible.  This support had
> already been added for the OS context but had not yet been
> added to the pool or physical context.

Reviewed-by: Michael Kowal<kowal@linux.ibm.com>

Thanks,  MAK

>
> Signed-off-by: Glenn Miles <milesg@linux.ibm.com>
> ---
>   hw/intc/xive.c              | 12 ++---
>   hw/intc/xive2.c             | 94 ++++++++++++++++++++++++++-----------
>   include/hw/ppc/xive2.h      |  4 ++
>   include/hw/ppc/xive2_regs.h |  4 +-
>   4 files changed, 79 insertions(+), 35 deletions(-)
>
> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> index 9ec1193dfc..ad30476c17 100644
> --- a/hw/intc/xive.c
> +++ b/hw/intc/xive.c
> @@ -693,7 +693,7 @@ static const XiveTmOp xive2_tm_operations[] = {
>   
>       /* MMIOs above 2K : special operations with side effects */
>       { XIVE_TM_OS_PAGE, TM_SPC_ACK_OS_REG,         2, NULL,
> -                                                     xive_tm_ack_os_reg },
> +                                                   xive_tm_ack_os_reg },
>       { XIVE_TM_OS_PAGE, TM_SPC_SET_OS_PENDING,     1, xive_tm_set_os_pending,
>                                                        NULL },
>       { XIVE_TM_HV_PAGE, TM_SPC_PULL_OS_CTX_G2,     4, NULL,
> @@ -705,17 +705,17 @@ static const XiveTmOp xive2_tm_operations[] = {
>       { XIVE_TM_HV_PAGE, TM_SPC_ACK_HV_REG,         2, NULL,
>                                                        xive_tm_ack_hv_reg },
>       { XIVE_TM_HV_PAGE, TM_SPC_PULL_POOL_CTX_G2,   4, NULL,
> -                                                     xive_tm_pull_pool_ctx },
> +                                                     xive2_tm_pull_pool_ctx },
>       { XIVE_TM_HV_PAGE, TM_SPC_PULL_POOL_CTX,      4, NULL,
> -                                                     xive_tm_pull_pool_ctx },
> +                                                     xive2_tm_pull_pool_ctx },
>       { XIVE_TM_HV_PAGE, TM_SPC_PULL_POOL_CTX,      8, NULL,
> -                                                     xive_tm_pull_pool_ctx },
> +                                                     xive2_tm_pull_pool_ctx },
>       { XIVE_TM_HV_PAGE, TM_SPC_PULL_OS_CTX_OL,     1, xive2_tm_pull_os_ctx_ol,
>                                                        NULL },
>       { XIVE_TM_HV_PAGE, TM_SPC_PULL_PHYS_CTX_G2,   4, NULL,
> -                                                     xive_tm_pull_phys_ctx },
> +                                                     xive2_tm_pull_phys_ctx },
>       { XIVE_TM_HV_PAGE, TM_SPC_PULL_PHYS_CTX,      1, NULL,
> -                                                     xive_tm_pull_phys_ctx },
> +                                                     xive2_tm_pull_phys_ctx },
>       { XIVE_TM_HV_PAGE, TM_SPC_PULL_PHYS_CTX_OL,   1, xive2_tm_pull_phys_ctx_ol,
>                                                        NULL },
>       { XIVE_TM_OS_PAGE, TM_SPC_ACK_OS_EL,          1, xive2_tm_ack_os_el,
> diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
> index 92dbbad8d4..ac94193464 100644
> --- a/hw/intc/xive2.c
> +++ b/hw/intc/xive2.c
> @@ -23,6 +23,9 @@ static void xive2_router_end_notify(Xive2Router *xrtr, uint8_t end_blk,
>                                       uint32_t end_idx, uint32_t end_data,
>                                       bool redistribute);
>   
> +static int xive2_tctx_get_nvp_indexes(XiveTCTX *tctx, uint8_t ring,
> +                                      uint8_t *nvp_blk, uint32_t *nvp_idx);
> +
>   uint32_t xive2_router_get_config(Xive2Router *xrtr)
>   {
>       Xive2RouterClass *xrc = XIVE2_ROUTER_GET_CLASS(xrtr);
> @@ -604,8 +607,10 @@ static uint32_t xive2_tctx_hw_cam_line(XivePresenter *xptr, XiveTCTX *tctx)
>   static void xive2_redistribute(Xive2Router *xrtr, XiveTCTX *tctx, uint8_t ring)
>   {
>       uint8_t *regs = &tctx->regs[ring];
> -    uint8_t nsr = regs[TM_NSR];
> -    uint8_t pipr = regs[TM_PIPR];
> +    uint8_t *alt_regs = (ring == TM_QW2_HV_POOL) ? &tctx->regs[TM_QW3_HV_PHYS] :
> +                                                   regs;
> +    uint8_t nsr = alt_regs[TM_NSR];
> +    uint8_t pipr = alt_regs[TM_PIPR];
>       uint8_t crowd = NVx_CROWD_LVL(nsr);
>       uint8_t group = NVx_GROUP_LVL(nsr);
>       uint8_t nvgc_blk, end_blk, nvp_blk;
> @@ -614,10 +619,6 @@ static void xive2_redistribute(Xive2Router *xrtr, XiveTCTX *tctx, uint8_t ring)
>       uint8_t prio_limit;
>       uint32_t cfg;
>       uint8_t alt_ring;
> -    uint32_t target_ringw2;
> -    uint32_t cam;
> -    bool valid;
> -    bool hw;
>   
>       /* redistribution is only for group/crowd interrupts */
>       if (!xive_nsr_indicates_group_exception(ring, nsr)) {
> @@ -625,11 +626,9 @@ static void xive2_redistribute(Xive2Router *xrtr, XiveTCTX *tctx, uint8_t ring)
>       }
>   
>       alt_ring = xive_nsr_exception_ring(ring, nsr);
> -    target_ringw2 = xive_tctx_word2(&tctx->regs[alt_ring]);
> -    cam = be32_to_cpu(target_ringw2);
>   
> -    /* extract nvp block and index from targeted ring's cam */
> -    xive2_cam_decode(cam, &nvp_blk, &nvp_idx, &valid, &hw);
> +    /* Don't check return code since ring is expected to be invalidated */
> +    xive2_tctx_get_nvp_indexes(tctx, alt_ring, &nvp_blk, &nvp_idx);
>   
>       trace_xive_redistribute(tctx->cs->cpu_index, alt_ring, nvp_blk, nvp_idx);
>   
> @@ -676,11 +675,23 @@ static void xive2_redistribute(Xive2Router *xrtr, XiveTCTX *tctx, uint8_t ring)
>       xive2_router_end_notify(xrtr, end_blk, end_idx, 0, true);
>   
>       /* clear interrupt indication for the context */
> -    regs[TM_NSR] = 0;
> -    regs[TM_PIPR] = regs[TM_CPPR];
> +    alt_regs[TM_NSR] = 0;
> +    alt_regs[TM_PIPR] = alt_regs[TM_CPPR];
>       xive_tctx_reset_signal(tctx, ring);
>   }
>   
> +static uint8_t xive2_hv_irq_ring(uint8_t nsr)
> +{
> +    switch (nsr >> 6) {
> +    case TM_QW3_NSR_HE_POOL:
> +        return TM_QW2_HV_POOL;
> +    case TM_QW3_NSR_HE_PHYS:
> +        return TM_QW3_HV_PHYS;
> +    default:
> +        return -1;
> +    }
> +}
> +
>   static uint64_t xive2_tm_pull_ctx(XivePresenter *xptr, XiveTCTX *tctx,
>                                     hwaddr offset, unsigned size, uint8_t ring)
>   {
> @@ -696,7 +707,7 @@ static uint64_t xive2_tm_pull_ctx(XivePresenter *xptr, XiveTCTX *tctx,
>   
>       xive2_cam_decode(cam, &nvp_blk, &nvp_idx, &valid, &do_save);
>   
> -    if (!valid) {
> +    if (xive2_tctx_get_nvp_indexes(tctx, ring, &nvp_blk, &nvp_idx)) {
>           qemu_log_mask(LOG_GUEST_ERROR, "XIVE: pulling invalid NVP %x/%x !?\n",
>                         nvp_blk, nvp_idx);
>       }
> @@ -706,13 +717,25 @@ static uint64_t xive2_tm_pull_ctx(XivePresenter *xptr, XiveTCTX *tctx,
>            cur_ring += XIVE_TM_RING_SIZE) {
>           uint32_t ringw2 = xive_tctx_word2(&tctx->regs[cur_ring]);
>           uint32_t ringw2_new = xive_set_field32(TM2_QW1W2_VO, ringw2, 0);
> +        bool is_valid = !!(xive_get_field32(TM2_QW1W2_VO, ringw2));
> +        uint8_t alt_ring;
>           memcpy(&tctx->regs[cur_ring + TM_WORD2], &ringw2_new, 4);
> -    }
>   
> -    /* Active group/crowd interrupts need to be redistributed */
> -    nsr = tctx->regs[ring + TM_NSR];
> -    if (xive_nsr_indicates_group_exception(ring, nsr)) {
> -        xive2_redistribute(xrtr, tctx, ring);
> +        /* Skip the rest for USER or invalid contexts */
> +        if ((cur_ring == TM_QW0_USER) || !is_valid) {
> +            continue;
> +        }
> +
> +        /* Active group/crowd interrupts need to be redistributed */
> +        alt_ring = (cur_ring == TM_QW2_HV_POOL) ? TM_QW3_HV_PHYS : cur_ring;
> +        nsr = tctx->regs[alt_ring + TM_NSR];
> +        if (xive_nsr_indicates_group_exception(alt_ring, nsr)) {
> +            /* For HV rings, only redistribute if cur_ring matches NSR */
> +            if ((cur_ring == TM_QW1_OS) ||
> +                (cur_ring == xive2_hv_irq_ring(nsr))) {
> +                xive2_redistribute(xrtr, tctx, cur_ring);
> +            }
> +        }
>       }
>   
>       if (xive2_router_get_config(xrtr) & XIVE2_VP_SAVE_RESTORE && do_save) {
> @@ -736,6 +759,18 @@ uint64_t xive2_tm_pull_os_ctx(XivePresenter *xptr, XiveTCTX *tctx,
>       return xive2_tm_pull_ctx(xptr, tctx, offset, size, TM_QW1_OS);
>   }
>   
> +uint64_t xive2_tm_pull_pool_ctx(XivePresenter *xptr, XiveTCTX *tctx,
> +                                hwaddr offset, unsigned size)
> +{
> +    return xive2_tm_pull_ctx(xptr, tctx, offset, size, TM_QW2_HV_POOL);
> +}
> +
> +uint64_t xive2_tm_pull_phys_ctx(XivePresenter *xptr, XiveTCTX *tctx,
> +                                hwaddr offset, unsigned size)
> +{
> +    return xive2_tm_pull_ctx(xptr, tctx, offset, size, TM_QW3_HV_PHYS);
> +}
> +
>   #define REPORT_LINE_GEN1_SIZE       16
>   
>   static void xive2_tm_report_line_gen1(XiveTCTX *tctx, uint8_t *data,
> @@ -993,37 +1028,40 @@ void xive2_tm_push_os_ctx(XivePresenter *xptr, XiveTCTX *tctx,
>       }
>   }
>   
> +/* returns -1 if ring is invalid, but still populates block and index */
>   static int xive2_tctx_get_nvp_indexes(XiveTCTX *tctx, uint8_t ring,
> -                                      uint32_t *nvp_blk, uint32_t *nvp_idx)
> +                                      uint8_t *nvp_blk, uint32_t *nvp_idx)
>   {
> -    uint32_t w2, cam;
> +    uint32_t w2;
> +    uint32_t cam = 0;
> +    int rc = 0;
>   
>       w2 = xive_tctx_word2(&tctx->regs[ring]);
>       switch (ring) {
>       case TM_QW1_OS:
>           if (!(be32_to_cpu(w2) & TM2_QW1W2_VO)) {
> -            return -1;
> +            rc = -1;
>           }
>           cam = xive_get_field32(TM2_QW1W2_OS_CAM, w2);
>           break;
>       case TM_QW2_HV_POOL:
>           if (!(be32_to_cpu(w2) & TM2_QW2W2_VP)) {
> -            return -1;
> +            rc = -1;
>           }
>           cam = xive_get_field32(TM2_QW2W2_POOL_CAM, w2);
>           break;
>       case TM_QW3_HV_PHYS:
>           if (!(be32_to_cpu(w2) & TM2_QW3W2_VT)) {
> -            return -1;
> +            rc = -1;
>           }
>           cam = xive2_tctx_hw_cam_line(tctx->xptr, tctx);
>           break;
>       default:
> -        return -1;
> +        rc = -1;
>       }
>       *nvp_blk = xive2_nvp_blk(cam);
>       *nvp_idx = xive2_nvp_idx(cam);
> -    return 0;
> +    return rc;
>   }
>   
>   static void xive2_tctx_accept_el(XivePresenter *xptr, XiveTCTX *tctx,
> @@ -1031,7 +1069,8 @@ static void xive2_tctx_accept_el(XivePresenter *xptr, XiveTCTX *tctx,
>   {
>       uint64_t rd;
>       Xive2Router *xrtr = XIVE2_ROUTER(xptr);
> -    uint32_t nvp_blk, nvp_idx, xive2_cfg;
> +    uint32_t nvp_idx, xive2_cfg;
> +    uint8_t nvp_blk;
>       Xive2Nvp nvp;
>       uint64_t phys_addr;
>       uint8_t OGen = 0;
> @@ -1084,7 +1123,8 @@ static void xive2_tctx_set_cppr(XiveTCTX *tctx, uint8_t ring, uint8_t cppr)
>       uint8_t old_cppr, backlog_prio, first_group, group_level;
>       uint8_t pipr_min, lsmfb_min, ring_min;
>       bool group_enabled;
> -    uint32_t nvp_blk, nvp_idx;
> +    uint8_t nvp_blk;
> +    uint32_t nvp_idx;
>       Xive2Nvp nvp;
>       int rc;
>       uint8_t nsr = regs[TM_NSR];
> diff --git a/include/hw/ppc/xive2.h b/include/hw/ppc/xive2.h
> index ff02ce2549..a91b99057c 100644
> --- a/include/hw/ppc/xive2.h
> +++ b/include/hw/ppc/xive2.h
> @@ -140,6 +140,10 @@ bool xive2_tm_irq_precluded(XiveTCTX *tctx, int ring, uint8_t priority);
>   void xive2_tm_set_lsmfb(XiveTCTX *tctx, int ring, uint8_t priority);
>   void xive2_tm_set_hv_target(XivePresenter *xptr, XiveTCTX *tctx,
>                               hwaddr offset, uint64_t value, unsigned size);
> +uint64_t xive2_tm_pull_pool_ctx(XivePresenter *xptr, XiveTCTX *tctx,
> +                                hwaddr offset, unsigned size);
> +uint64_t xive2_tm_pull_phys_ctx(XivePresenter *xptr, XiveTCTX *tctx,
> +                                hwaddr offset, unsigned size);
>   void xive2_tm_pull_phys_ctx_ol(XivePresenter *xptr, XiveTCTX *tctx,
>                                  hwaddr offset, uint64_t value, unsigned size);
>   void xive2_tm_ack_os_el(XivePresenter *xptr, XiveTCTX *tctx,
> diff --git a/include/hw/ppc/xive2_regs.h b/include/hw/ppc/xive2_regs.h
> index e222038143..f82054661b 100644
> --- a/include/hw/ppc/xive2_regs.h
> +++ b/include/hw/ppc/xive2_regs.h
> @@ -209,9 +209,9 @@ static inline uint32_t xive2_nvp_idx(uint32_t cam_line)
>       return cam_line & ((1 << XIVE2_NVP_SHIFT) - 1);
>   }
>   
> -static inline uint32_t xive2_nvp_blk(uint32_t cam_line)
> +static inline uint8_t xive2_nvp_blk(uint32_t cam_line)
>   {
> -    return (cam_line >> XIVE2_NVP_SHIFT) & 0xf;
> +    return (uint8_t)((cam_line >> XIVE2_NVP_SHIFT) & 0xf);
>   }
>   
>   void xive2_nvp_pic_print_info(Xive2Nvp *nvp, uint32_t nvp_idx, GString *buf);

