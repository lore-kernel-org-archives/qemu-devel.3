Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF65AC2D0CD
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 15:57:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFaxY-0007xn-SZ; Thu, 15 May 2025 11:57:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1uFaxW-0007pd-TI; Thu, 15 May 2025 11:57:23 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1uFaxU-0007gj-Dj; Thu, 15 May 2025 11:57:22 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54FDn3ih032307;
 Thu, 15 May 2025 15:57:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=z1qCdX
 cCdQwxBZt3EbQIWR8QCKOiNraHuxCrcjBMXUQ=; b=kSlOuQDKeETW3Jal9n4hce
 XfaKAHNCRHNqMNpy8+vQBhUvjKERPTzHSumljoVA7JPP5SrZXT2NfiwCBNe22VJG
 s19sh2+j4Z6l5t5xRev4DzxKrlQ8mWfvpMnhIpg8wMLJAjvMH4CxDdpaASJcH4mH
 +Ig9yh1v1YhJuujtC8x7EJWYZHMWAMi2CLfO4BEU/+N4XvJAz9yZFxpaAN57ALBE
 lbVre1oAopA2/tLL5LMm6SnDbR4W8rbhZncPMHAWAR3vJ1+R6YzNjZ9QWBwGSUs8
 Nc5K/fyeYyYLM9USTNbV1tiauWiTydQaRyxwtlkJDscSFW2MLTFM0p/jBArEWP2w
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46nhg30q8m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 15:57:18 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54FFvI3L008500;
 Thu, 15 May 2025 15:57:18 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46nhg30q8h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 15:57:18 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54FEG7jg021828;
 Thu, 15 May 2025 15:57:17 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46mbfpu34b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 15:57:17 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 54FFvF1W29491858
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 15 May 2025 15:57:16 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CA1C958057;
 Thu, 15 May 2025 15:57:15 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7D23D5805D;
 Thu, 15 May 2025 15:57:15 +0000 (GMT)
Received: from [9.10.80.143] (unknown [9.10.80.143])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 15 May 2025 15:57:15 +0000 (GMT)
Message-ID: <861877f8-c9aa-4f45-ba0b-60fdbfe9f5fe@linux.ibm.com>
Date: Thu, 15 May 2025 10:57:14 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 49/50] ppc/xive: Split need_resend into restore_nvp
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?=
 <fbarrat@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Caleb Schlossin <calebs@linux.vnet.ibm.com>
References: <20250512031100.439842-1-npiggin@gmail.com>
 <20250512031100.439842-50-npiggin@gmail.com>
Content-Language: en-US
From: Mike Kowal <kowal@linux.ibm.com>
In-Reply-To: <20250512031100.439842-50-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Cf0I5Krl c=1 sm=1 tr=0 ts=68260ede cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8
 a=PPXmNmk22UTcdFbNa5sA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDE1NSBTYWx0ZWRfX5lm67/Hxe5Lf
 msNBX6VMLIHiy/Vd44vSJrYj6B7YfKX4smbMeDKV4UL5Lo9tsJke3ucizyjSYDR7Zg9bSSaCBAR
 facUZ8aNedt9xvJZWhdzOo4hvViuRp0XAzr/dYByEe2RkKhzAM+sbG8HFoe3oqcnzz8g0XlrwvO
 gemM4s+gUITK0eBIGUAgxzCMFJqg850kAqxBw7Nvd6/YdFHnwHvhCxMd6K/9plk6mPExufncC/2
 buyB105SDRAKNRZkPtftedhKcWKzhO+rwHq1iRdoerd0hgKyZ3eACn0mtqdDd36z+kojx5xcqQo
 TBSmKbTnJKQbB25dyuH+RAbCbo12geIB9f2n2WDPdUGzpUlEytmX2YI0Bmb66gMoRd0nViuu4of
 PE0srrGdLKg5ZIfaIn61H94rSyqU8mpoSAI8KDceosJKqZiCSCTkfvt3HdEB4Qx8b2zHbqq6
X-Proofpoint-GUID: KFN5dgXpclWHD8ITlvUmienUPysRiwjR
X-Proofpoint-ORIG-GUID: 7JT-jO1Cm7URy-HqCqAOSq97Vz9psGrD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_06,2025-05-15_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0
 spamscore=0 malwarescore=0 lowpriorityscore=0 mlxlogscore=999
 impostorscore=0 phishscore=0 priorityscore=1501 mlxscore=0 bulkscore=0
 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505150155
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
> This is needed by the next patch which will re-send on all lower
> rings when pushing a context.

Reviewed-by: Michael Kowal<kowal@linux.ibm.com>

Thanks,  MAK
>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   hw/intc/xive.c  | 24 ++++++++++++------------
>   hw/intc/xive2.c | 28 ++++++++++++++++------------
>   2 files changed, 28 insertions(+), 24 deletions(-)
>
> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> index 69118999e6..9ade9ec6c1 100644
> --- a/hw/intc/xive.c
> +++ b/hw/intc/xive.c
> @@ -606,7 +606,7 @@ static uint64_t xive_tm_pull_os_ctx(XivePresenter *xptr, XiveTCTX *tctx,
>       return qw1w2;
>   }
>   
> -static void xive_tctx_need_resend(XiveRouter *xrtr, XiveTCTX *tctx,
> +static void xive_tctx_restore_nvp(XiveRouter *xrtr, XiveTCTX *tctx,
>                                     uint8_t nvt_blk, uint32_t nvt_idx)
>   {
>       XiveNVT nvt;
> @@ -632,16 +632,6 @@ static void xive_tctx_need_resend(XiveRouter *xrtr, XiveTCTX *tctx,
>           uint8_t *regs = &tctx->regs[TM_QW1_OS];
>           regs[TM_IPB] |= ipb;
>       }
> -
> -    /*
> -     * Always call xive_tctx_recompute_from_ipb(). Even if there were no
> -     * escalation triggered, there could be a pending interrupt which
> -     * was saved when the context was pulled and that we need to take
> -     * into account by recalculating the PIPR (which is not
> -     * saved/restored).
> -     * It will also raise the External interrupt signal if needed.
> -     */
> -    xive_tctx_pipr_recompute_from_ipb(tctx, TM_QW1_OS); /* fxb */
>   }
>   
>   /*
> @@ -663,7 +653,17 @@ static void xive_tm_push_os_ctx(XivePresenter *xptr, XiveTCTX *tctx,
>   
>       /* Check the interrupt pending bits */
>       if (vo) {
> -        xive_tctx_need_resend(XIVE_ROUTER(xptr), tctx, nvt_blk, nvt_idx);
> +        xive_tctx_restore_nvp(XIVE_ROUTER(xptr), tctx, nvt_blk, nvt_idx);
> +
> +        /*
> +         * Always call xive_tctx_recompute_from_ipb(). Even if there were no
> +         * escalation triggered, there could be a pending interrupt which
> +         * was saved when the context was pulled and that we need to take
> +         * into account by recalculating the PIPR (which is not
> +         * saved/restored).
> +         * It will also raise the External interrupt signal if needed.
> +         */
> +        xive_tctx_pipr_recompute_from_ipb(tctx, TM_QW1_OS); /* fxb */
>       }
>   }
>   
> diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
> index a9b188b909..53e90b8178 100644
> --- a/hw/intc/xive2.c
> +++ b/hw/intc/xive2.c
> @@ -940,14 +940,14 @@ static uint8_t xive2_tctx_restore_ctx(Xive2Router *xrtr, XiveTCTX *tctx,
>       return cppr;
>   }
>   
> -static void xive2_tctx_need_resend(Xive2Router *xrtr, XiveTCTX *tctx,
> +/* Restore TIMA VP context from NVP backlog */
> +static void xive2_tctx_restore_nvp(Xive2Router *xrtr, XiveTCTX *tctx,
>                                      uint8_t ring,
>                                      uint8_t nvp_blk, uint32_t nvp_idx,
>                                      bool do_restore)
>   {
> -    uint8_t *sig_regs = xive_tctx_signal_regs(tctx, ring);
>       uint8_t *regs = &tctx->regs[ring];
> -    uint8_t ipb, nsr = sig_regs[TM_NSR];
> +    uint8_t ipb;
>       Xive2Nvp nvp;
>   
>       /*
> @@ -978,14 +978,6 @@ static void xive2_tctx_need_resend(Xive2Router *xrtr, XiveTCTX *tctx,
>       }
>       /* IPB bits in the backlog are merged with the TIMA IPB bits */
>       regs[TM_IPB] |= ipb;
> -
> -    if (xive_nsr_indicates_group_exception(ring, nsr)) {
> -        /* redistribute precluded active grp interrupt */
> -        g_assert(ring == TM_QW2_HV_POOL); /* PHYS ring has the grp interrupt */
> -        xive2_redistribute(xrtr, tctx, xive_nsr_exception_ring(ring, nsr));
> -    }
> -    xive2_tctx_process_pending(tctx, ring == TM_QW2_HV_POOL ?
> -                                         TM_QW3_HV_PHYS : ring);
>   }
>   
>   /*
> @@ -1028,8 +1020,20 @@ static void xive2_tm_push_ctx(XivePresenter *xptr, XiveTCTX *tctx,
>   
>       /* Check the interrupt pending bits */
>       if (v) {
> -        xive2_tctx_need_resend(XIVE2_ROUTER(xptr), tctx, ring,
> +        Xive2Router *xrtr = XIVE2_ROUTER(xptr);
> +        uint8_t *sig_regs = xive_tctx_signal_regs(tctx, ring);
> +        uint8_t nsr = sig_regs[TM_NSR];
> +
> +        xive2_tctx_restore_nvp(xrtr, tctx, ring,
>                                  nvp_blk, nvp_idx, do_restore);
> +
> +        if (xive_nsr_indicates_group_exception(ring, nsr)) {
> +            /* redistribute precluded active grp interrupt */
> +            g_assert(ring == TM_QW2_HV_POOL); /* PHYS ring has the interrupt */
> +            xive2_redistribute(xrtr, tctx, xive_nsr_exception_ring(ring, nsr));
> +        }
> +        xive2_tctx_process_pending(tctx, ring == TM_QW2_HV_POOL ?
> +                                                 TM_QW3_HV_PHYS : ring);
>       }
>   }
>   

