Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 659A5C2D0CD
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 16:09:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFb9K-0007iO-3W; Thu, 15 May 2025 12:09:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1uFb9H-0007a3-Ry; Thu, 15 May 2025 12:09:31 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1uFb9F-0000pc-HQ; Thu, 15 May 2025 12:09:31 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54FCgOnt013039;
 Thu, 15 May 2025 16:09:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=wwbHsWwqJluA/95gGrzB9W5uuYhKotd3fj1omK4UkIY=; b=IQfsEc4ZiYk2
 17BA8UsH4s+xe82Zxf9A019jXw5Yqe2UMyfwOLG/PTkzDCIWSE7t9vUEYmjk2LOT
 DASqkHaV9HukR2o2zb0RFEQwVYldZhuZ3evt4L6q0l5pC9b+5omdFe88TWPSCal/
 skRWEN86qSobRrmqIYRwzeU47H5wOqcWFRleU9MzTZpJyFqo6vDo8Pk6EMHJGmd1
 8iNGO/6jdoYuS2TjbzlUiexUEUe8gSpYTeuiSEEQXV1zgim1j70XeUEdqVeJpyDK
 QpLfBDhpFyIB5Df3LGbUDtyimLQj423clqmi4DBjyaaZm+wKGCzJNnx0e6p/V0Jo
 Xuvf5qESlA==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46n0t9dnyw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 16:09:27 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54FG3d4l011758;
 Thu, 15 May 2025 16:09:26 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46n0t9dnyu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 16:09:26 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54FEHtuK021396;
 Thu, 15 May 2025 16:09:25 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46mbfru4fc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 16:09:25 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 54FG9N1632244466
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 15 May 2025 16:09:24 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C127A58056;
 Thu, 15 May 2025 16:09:23 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6BDA558052;
 Thu, 15 May 2025 16:09:23 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 15 May 2025 16:09:23 +0000 (GMT)
Message-ID: <c533dd6780b2d1be8b4983935c9b1ecd34704c5a.camel@linux.ibm.com>
Subject: Re: [PATCH 40/50] ppc/xive2: implement NVP context save restore for
 POOL ring
From: Miles Glenn <milesg@linux.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, =?ISO-8859-1?Q?Fr=E9d=E9ric?= Barrat
 <fbarrat@linux.ibm.com>, Michael Kowal <kowal@linux.ibm.com>, Caleb
 Schlossin <calebs@linux.vnet.ibm.com>
Date: Thu, 15 May 2025 11:09:23 -0500
In-Reply-To: <20250512031100.439842-41-npiggin@gmail.com>
References: <20250512031100.439842-1-npiggin@gmail.com>
 <20250512031100.439842-41-npiggin@gmail.com>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=etzfzppX c=1 sm=1 tr=0 ts=682611b7 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8
 a=PQitADfLxHH4esMn5eYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDE2MCBTYWx0ZWRfX2MCYt9AtNQbF
 Cc8SCbziPxNPwHDKmEQrhyaUOfNMvIbvU8aQNleCU8eZ6S9PQ8bfVPox+H/UB7z7Oybdc4TzKA8
 KDJwoWS6IjaaSsfW/1zbGaLQdy4Vm6iqiGcSL6SM/bJGdwc6xOStSEgtyMTSEIMdZrA20Ng8k6i
 6PNR9JgpKfyRA2Wc7Ts2m/88vxboTj8kbG5uFyYrEPjQV/RQysP+J5UdUpH0++oLX3ILAfl1cjx
 S6ccZtl+p9YoM+/Pn7WkjFLvwInxrIwUdc6+/FU1qK25ujwMf34vVg8m7RZ7mPAtt85p4GQRT/J
 pn59XNfznvt5aQ0xLn3oXZnFpnROcajzqdaIzdIefJmnaabpq1hR/LHqG9utmsydWJILF6Wy1CS
 ZXTmL31ex7jHrikkEW4HU8rYhM4TLWH1jHNhkkbrdkpPszk3HJyYAYXSj1IrsrJWUuglKO02
X-Proofpoint-ORIG-GUID: jD1oY3ZsWiiCQtDwwqcZE008kspmZ_tz
X-Proofpoint-GUID: pLQVuOqe4iN_5EOgKv-ZSYVyou1bSNQN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_07,2025-05-15_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 lowpriorityscore=0 phishscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 spamscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505150160
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
> In preparation to implement POOL context push, add support for POOL
> NVP context save/restore.
> 
> The NVP p bit is defined in the spec as follows:
> 
>     If TRUE, the CPPR of a Pool VP in the NVP is updated during store of
>     the context with the CPPR of the Hard context it was running under.
> 
> It's not clear whether non-pool VPs always or never get CPPR updated.
> Before this patch, OS contexts always save CPPR, so we will assume that
> is the behaviour.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  hw/intc/xive2.c             | 51 +++++++++++++++++++++++++------------
>  include/hw/ppc/xive2_regs.h |  1 +
>  2 files changed, 36 insertions(+), 16 deletions(-)
> 
> diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
> index e3060810d3..d899c1fb14 100644
> --- a/hw/intc/xive2.c
> +++ b/hw/intc/xive2.c
> @@ -512,12 +512,13 @@ static void xive2_presenter_backlog_decr(XivePresenter *xptr,
>   */
>  
>  static void xive2_tctx_save_ctx(Xive2Router *xrtr, XiveTCTX *tctx,
> -                                uint8_t nvp_blk, uint32_t nvp_idx,
> -                                uint8_t ring)
> +                                uint8_t ring,
> +                                uint8_t nvp_blk, uint32_t nvp_idx)
>  {
>      CPUPPCState *env = &POWERPC_CPU(tctx->cs)->env;
>      uint32_t pir = env->spr_cb[SPR_PIR].default_value;
>      Xive2Nvp nvp;
> +    uint8_t *sig_regs = xive_tctx_signal_regs(tctx, ring);
>      uint8_t *regs = &tctx->regs[ring];
>  
>      if (xive2_router_get_nvp(xrtr, nvp_blk, nvp_idx, &nvp)) {
> @@ -553,7 +554,14 @@ static void xive2_tctx_save_ctx(Xive2Router *xrtr, XiveTCTX *tctx,
>      }
>  
>      nvp.w2 = xive_set_field32(NVP2_W2_IPB, nvp.w2, regs[TM_IPB]);
> -    nvp.w2 = xive_set_field32(NVP2_W2_CPPR, nvp.w2, regs[TM_CPPR]);
> +
> +    if ((nvp.w0 & NVP2_W0_P) || ring != TM_QW2_HV_POOL) {
> +        /*
> +         * Non-pool contexts always save CPPR (ignore p bit). XXX: Clarify
> +         * whether that is the correct behaviour.
> +         */
> +        nvp.w2 = xive_set_field32(NVP2_W2_CPPR, nvp.w2, sig_regs[TM_CPPR]);
> +    }
>      if (nvp.w0 & NVP2_W0_L) {
>          /*
>           * Typically not used. If LSMFB is restored with 0, it will
> @@ -722,7 +730,7 @@ static uint64_t xive2_tm_pull_ctx(XivePresenter *xptr, XiveTCTX *tctx,
>      }
>  
>      if (xive2_router_get_config(xrtr) & XIVE2_VP_SAVE_RESTORE && do_save) {
> -        xive2_tctx_save_ctx(xrtr, tctx, nvp_blk, nvp_idx, ring);
> +        xive2_tctx_save_ctx(xrtr, tctx, ring, nvp_blk, nvp_idx);
>      }
>  
>      /*
> @@ -863,12 +871,15 @@ void xive2_tm_pull_phys_ctx_ol(XivePresenter *xptr, XiveTCTX *tctx,
>      xive2_tm_pull_ctx_ol(xptr, tctx, offset, value, size, TM_QW3_HV_PHYS);
>  }
>  
> -static uint8_t xive2_tctx_restore_os_ctx(Xive2Router *xrtr, XiveTCTX *tctx,
> -                                        uint8_t nvp_blk, uint32_t nvp_idx,
> -                                        Xive2Nvp *nvp)
> +static uint8_t xive2_tctx_restore_ctx(Xive2Router *xrtr, XiveTCTX *tctx,
> +                                      uint8_t ring,
> +                                      uint8_t nvp_blk, uint32_t nvp_idx,
> +                                      Xive2Nvp *nvp)
>  {
>      CPUPPCState *env = &POWERPC_CPU(tctx->cs)->env;
>      uint32_t pir = env->spr_cb[SPR_PIR].default_value;
> +    uint8_t *sig_regs = xive_tctx_signal_regs(tctx, ring);
> +    uint8_t *regs = &tctx->regs[ring];
>      uint8_t cppr;
>  
>      if (!xive2_nvp_is_hw(nvp)) {
> @@ -881,10 +892,10 @@ static uint8_t xive2_tctx_restore_os_ctx(Xive2Router *xrtr, XiveTCTX *tctx,
>      nvp->w2 = xive_set_field32(NVP2_W2_CPPR, nvp->w2, 0);
>      xive2_router_write_nvp(xrtr, nvp_blk, nvp_idx, nvp, 2);
>  
> -    tctx->regs[TM_QW1_OS + TM_CPPR] = cppr;
> -    tctx->regs[TM_QW1_OS + TM_LSMFB] = xive_get_field32(NVP2_W2_LSMFB, nvp->w2);
> -    tctx->regs[TM_QW1_OS + TM_LGS] = xive_get_field32(NVP2_W2_LGS, nvp->w2);
> -    tctx->regs[TM_QW1_OS + TM_T] = xive_get_field32(NVP2_W2_T, nvp->w2);
> +    sig_regs[TM_CPPR] = cppr;
> +    regs[TM_LSMFB] = xive_get_field32(NVP2_W2_LSMFB, nvp->w2);
> +    regs[TM_LGS] = xive_get_field32(NVP2_W2_LGS, nvp->w2);
> +    regs[TM_T] = xive_get_field32(NVP2_W2_T, nvp->w2);
>  
>      nvp->w1 = xive_set_field32(NVP2_W1_CO, nvp->w1, 1);
>      nvp->w1 = xive_set_field32(NVP2_W1_CO_THRID_VALID, nvp->w1, 1);
> @@ -893,9 +904,18 @@ static uint8_t xive2_tctx_restore_os_ctx(Xive2Router *xrtr, XiveTCTX *tctx,
>      /*
>       * Checkout privilege: 0:OS, 1:Pool, 2:Hard
>       *
> -     * TODO: we only support OS push/pull
> +     * TODO: we don't support hard push/pull
>       */
> -    nvp->w1 = xive_set_field32(NVP2_W1_CO_PRIV, nvp->w1, 0);
> +    switch (ring) {
> +    case TM_QW1_OS:
> +        nvp->w1 = xive_set_field32(NVP2_W1_CO_PRIV, nvp->w1, 0);
> +        break;
> +    case TM_QW2_HV_POOL:
> +        nvp->w1 = xive_set_field32(NVP2_W1_CO_PRIV, nvp->w1, 1);
> +        break;
> +    default:
> +        g_assert_not_reached();
> +    }
>  
>      xive2_router_write_nvp(xrtr, nvp_blk, nvp_idx, nvp, 1);
>  
> @@ -930,9 +950,8 @@ static void xive2_tctx_need_resend(Xive2Router *xrtr, XiveTCTX *tctx,
>      }
>  
>      /* Automatically restore thread context registers */
> -    if (xive2_router_get_config(xrtr) & XIVE2_VP_SAVE_RESTORE &&
> -        do_restore) {
> -        xive2_tctx_restore_os_ctx(xrtr, tctx, nvp_blk, nvp_idx, &nvp);
> +    if (xive2_router_get_config(xrtr) & XIVE2_VP_SAVE_RESTORE && do_restore) {
> +        xive2_tctx_restore_ctx(xrtr, tctx, TM_QW1_OS, nvp_blk, nvp_idx, &nvp);
>      }
>  
>      ipb = xive_get_field32(NVP2_W2_IPB, nvp.w2);
> diff --git a/include/hw/ppc/xive2_regs.h b/include/hw/ppc/xive2_regs.h
> index f82054661b..2a3e60abad 100644
> --- a/include/hw/ppc/xive2_regs.h
> +++ b/include/hw/ppc/xive2_regs.h
> @@ -158,6 +158,7 @@ typedef struct Xive2Nvp {
>  #define NVP2_W0_L                  PPC_BIT32(8)
>  #define NVP2_W0_G                  PPC_BIT32(9)
>  #define NVP2_W0_T                  PPC_BIT32(10)
> +#define NVP2_W0_P                  PPC_BIT32(11)
>  #define NVP2_W0_ESC_END            PPC_BIT32(25) /* 'N' bit 0:ESB  1:END */
>  #define NVP2_W0_PGOFIRST           PPC_BITMASK32(26, 31)
>          uint32_t       w1;


