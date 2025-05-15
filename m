Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B45EC2D0CD
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 16:17:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFbGh-0007XC-3p; Thu, 15 May 2025 12:17:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1uFbGJ-0007Jp-8w; Thu, 15 May 2025 12:16:55 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1uFbGF-0001nW-JA; Thu, 15 May 2025 12:16:46 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54FCfwgj016290;
 Thu, 15 May 2025 16:16:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=aUER1ljf/J0lRmWlBfLi0Lriv0tGRx1FejPGkRlN2q8=; b=j+nIwcMsXoWv
 lhT/6qKD+e7pCA1afnYehp/4tO1/ehjFBCv8fHhXwR+dhEzsV/s3pXr3HQYWbXwQ
 3BgQv5tGdXUmM7wI7kbk2B6kaMxya8/swb2cj6jph7ROJybK2t714rhf5OEh5z7G
 b3FpWmRlJ/E5aS8WEcoTtNzAmL9RVLhXFH8VYjzRQzT41aqMSIatBszdxJtc7PNT
 HmbJ4BgwVmsHOTjR19QdadS5Rmd68RlLA69UuJVHNKnC1fmrnwhc+EI0/zQoQOkR
 CMeCRKL69Iygem7NNlbpyb7P9I5WVQXbWyQKZRg4pYa0RafV/KFI32yXN5hS5Gq+
 P/LJ4fwahg==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46nd4gtc5n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 16:16:39 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54FFsNrM026171;
 Thu, 15 May 2025 16:16:39 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46nd4gtc5j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 16:16:39 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54FEGgix019443;
 Thu, 15 May 2025 16:16:38 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 46mbfru66f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 16:16:38 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 54FGGXc630999174
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 15 May 2025 16:16:33 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 99E6158043;
 Thu, 15 May 2025 16:16:36 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0C2CA5805D;
 Thu, 15 May 2025 16:16:36 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 15 May 2025 16:16:35 +0000 (GMT)
Message-ID: <30b6be8161801519bfff2e9bdf9958a06a10a8e6.camel@linux.ibm.com>
Subject: Re: [PATCH 49/50] ppc/xive: Split need_resend into restore_nvp
From: Miles Glenn <milesg@linux.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, =?ISO-8859-1?Q?Fr=E9d=E9ric?= Barrat
 <fbarrat@linux.ibm.com>, Michael Kowal <kowal@linux.ibm.com>, Caleb
 Schlossin <calebs@linux.vnet.ibm.com>
Date: Thu, 15 May 2025 11:16:35 -0500
In-Reply-To: <20250512031100.439842-50-npiggin@gmail.com>
References: <20250512031100.439842-1-npiggin@gmail.com>
 <20250512031100.439842-50-npiggin@gmail.com>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: LHnw6I8vZM36w6nTMEljHAE8cFkFRING
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDE1NSBTYWx0ZWRfXy2Iv+EmMRzU0
 uNt7Th7Hjff1dClUNQFasfRTz3Yp9ne4Qj4kHbQJdFbXMx/ysb/eNkeQyqxkXDn2B8sJr6QY4Za
 brR0c4LqxbfGW3iA6Gp1Xjn2H7b7oh5aO0UfmzkrMGOneq6/V0Ws8pZFmBhYlppmWFlaGmzRCt8
 pfBwK1+TrmdfKX0n2cRUD9r+Isrk3LtbwXrZ9i3L4XYxNkIxAiEy0lK1tPAg3ddCRgHptB8Sxmt
 fgMt7fuMeS9KjG+1BcwiCG1J6llmRy9naQsmmwms17lkI3K3E9qFq9p0qUKdfK7BYzxwlZjBtRP
 zSNOVd+dXjwjCqGcNvYHzJ3CW3Drw2ifakqFgii0BAzLKlfWeYWDJ+/NfHtALo91HfU+Ug9qwVU
 npGAQh0DKspOaKSeei5BJhY3MBBmmfhj8CfPqduY2G8pHwnqen8GpvkPRpodiyS8aFuXXhrn
X-Proofpoint-ORIG-GUID: KtugQv3EsurxoTo_437iNuiUp4gfAitZ
X-Authority-Analysis: v=2.4 cv=OsNPyz/t c=1 sm=1 tr=0 ts=68261367 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8
 a=PPXmNmk22UTcdFbNa5sA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_06,2025-05-15_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 suspectscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0 clxscore=1015
 impostorscore=0 mlxlogscore=904 mlxscore=0 adultscore=0 bulkscore=0
 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505150155
Received-SPF: pass client-ip=148.163.156.1; envelope-from=milesg@linux.ibm.com;
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
Reply-To: milesg@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Reviewed-by: Glenn Miles <milesg@linux.ibm.com>

On Mon, 2025-05-12 at 13:10 +1000, Nicholas Piggin wrote:
> This is needed by the next patch which will re-send on all lower
> rings when pushing a context.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  hw/intc/xive.c  | 24 ++++++++++++------------
>  hw/intc/xive2.c | 28 ++++++++++++++++------------
>  2 files changed, 28 insertions(+), 24 deletions(-)
> 
> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> index 69118999e6..9ade9ec6c1 100644
> --- a/hw/intc/xive.c
> +++ b/hw/intc/xive.c
> @@ -606,7 +606,7 @@ static uint64_t xive_tm_pull_os_ctx(XivePresenter *xptr, XiveTCTX *tctx,
>      return qw1w2;
>  }
>  
> -static void xive_tctx_need_resend(XiveRouter *xrtr, XiveTCTX *tctx,
> +static void xive_tctx_restore_nvp(XiveRouter *xrtr, XiveTCTX *tctx,
>                                    uint8_t nvt_blk, uint32_t nvt_idx)
>  {
>      XiveNVT nvt;
> @@ -632,16 +632,6 @@ static void xive_tctx_need_resend(XiveRouter *xrtr, XiveTCTX *tctx,
>          uint8_t *regs = &tctx->regs[TM_QW1_OS];
>          regs[TM_IPB] |= ipb;
>      }
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
>  }
>  
>  /*
> @@ -663,7 +653,17 @@ static void xive_tm_push_os_ctx(XivePresenter *xptr, XiveTCTX *tctx,
>  
>      /* Check the interrupt pending bits */
>      if (vo) {
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
>      }
>  }
>  
> diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
> index a9b188b909..53e90b8178 100644
> --- a/hw/intc/xive2.c
> +++ b/hw/intc/xive2.c
> @@ -940,14 +940,14 @@ static uint8_t xive2_tctx_restore_ctx(Xive2Router *xrtr, XiveTCTX *tctx,
>      return cppr;
>  }
>  
> -static void xive2_tctx_need_resend(Xive2Router *xrtr, XiveTCTX *tctx,
> +/* Restore TIMA VP context from NVP backlog */
> +static void xive2_tctx_restore_nvp(Xive2Router *xrtr, XiveTCTX *tctx,
>                                     uint8_t ring,
>                                     uint8_t nvp_blk, uint32_t nvp_idx,
>                                     bool do_restore)
>  {
> -    uint8_t *sig_regs = xive_tctx_signal_regs(tctx, ring);
>      uint8_t *regs = &tctx->regs[ring];
> -    uint8_t ipb, nsr = sig_regs[TM_NSR];
> +    uint8_t ipb;
>      Xive2Nvp nvp;
>  
>      /*
> @@ -978,14 +978,6 @@ static void xive2_tctx_need_resend(Xive2Router *xrtr, XiveTCTX *tctx,
>      }
>      /* IPB bits in the backlog are merged with the TIMA IPB bits */
>      regs[TM_IPB] |= ipb;
> -
> -    if (xive_nsr_indicates_group_exception(ring, nsr)) {
> -        /* redistribute precluded active grp interrupt */
> -        g_assert(ring == TM_QW2_HV_POOL); /* PHYS ring has the grp interrupt */
> -        xive2_redistribute(xrtr, tctx, xive_nsr_exception_ring(ring, nsr));
> -    }
> -    xive2_tctx_process_pending(tctx, ring == TM_QW2_HV_POOL ?
> -                                         TM_QW3_HV_PHYS : ring);
>  }
>  
>  /*
> @@ -1028,8 +1020,20 @@ static void xive2_tm_push_ctx(XivePresenter *xptr, XiveTCTX *tctx,
>  
>      /* Check the interrupt pending bits */
>      if (v) {
> -        xive2_tctx_need_resend(XIVE2_ROUTER(xptr), tctx, ring,
> +        Xive2Router *xrtr = XIVE2_ROUTER(xptr);
> +        uint8_t *sig_regs = xive_tctx_signal_regs(tctx, ring);
> +        uint8_t nsr = sig_regs[TM_NSR];
> +
> +        xive2_tctx_restore_nvp(xrtr, tctx, ring,
>                                 nvp_blk, nvp_idx, do_restore);
> +
> +        if (xive_nsr_indicates_group_exception(ring, nsr)) {
> +            /* redistribute precluded active grp interrupt */
> +            g_assert(ring == TM_QW2_HV_POOL); /* PHYS ring has the interrupt */
> +            xive2_redistribute(xrtr, tctx, xive_nsr_exception_ring(ring, nsr));
> +        }
> +        xive2_tctx_process_pending(tctx, ring == TM_QW2_HV_POOL ?
> +                                                 TM_QW3_HV_PHYS : ring);
>      }
>  }
>  


