Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7A25C3ABC9
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 16:13:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFbD3-0002fU-LV; Thu, 15 May 2025 12:13:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1uFbCs-0002Z4-6U; Thu, 15 May 2025 12:13:15 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1uFbCp-0001Kf-Td; Thu, 15 May 2025 12:13:13 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54FDnCHX032369;
 Thu, 15 May 2025 16:13:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=drWrgSPg72f+oNkA6rNzgwa24XKXLJGFNPjZXXpz6Og=; b=dm+3OEpL9JtC
 tO1oU1NL1/5QSNt6CD1e3NdkiGvrliK3WuT1tkcRXwaWZkxdAE9sA7SR2OxBbi/S
 0rlIT/2b6peWee0GymVQfJK9D2ytRZqt2R0klX13oUaV1LpFtQ7SPb19pZSOhWWZ
 kTtLuGWm7Sv2wUXgPxfyqhdxXtfFp8mwxrVOztlOfcBqfghSsFsRWvYFgY+TOByf
 wHFrwizrMqVo3bVH90GR+2rugWkbCeK3UmO+UCz5g1nErVTZ6v5/1QgNhyvHlWvI
 tj+Y1cqevGBMcgTWtXkNUXtr6M0iTCvpv2YBiqqPtRYce+my/KoE5pov3D0ky5EL
 RJOsrBd1Sw==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46nhg30t58-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 16:13:10 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54FG8oAq004872;
 Thu, 15 May 2025 16:13:10 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46nhg30t54-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 16:13:09 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54FDmiws015484;
 Thu, 15 May 2025 16:13:09 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 46mbfq34pr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 16:13:09 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 54FGD7E727984420
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 15 May 2025 16:13:07 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A4CE258050;
 Thu, 15 May 2025 16:13:07 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1A79158045;
 Thu, 15 May 2025 16:13:07 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 15 May 2025 16:13:07 +0000 (GMT)
Message-ID: <68cbd55e1b029418d490713b8eaad804b59d0c12.camel@linux.ibm.com>
Subject: Re: [PATCH 44/50] ppc/xive2: Implement pool context push TIMA op
From: Miles Glenn <milesg@linux.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, =?ISO-8859-1?Q?Fr=E9d=E9ric?= Barrat
 <fbarrat@linux.ibm.com>, Michael Kowal <kowal@linux.ibm.com>, Caleb
 Schlossin <calebs@linux.vnet.ibm.com>
Date: Thu, 15 May 2025 11:13:06 -0500
In-Reply-To: <20250512031100.439842-45-npiggin@gmail.com>
References: <20250512031100.439842-1-npiggin@gmail.com>
 <20250512031100.439842-45-npiggin@gmail.com>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Cf0I5Krl c=1 sm=1 tr=0 ts=68261296 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8
 a=-_8YoPsHaeqYWmk9H9cA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDE2MCBTYWx0ZWRfXx5sOoM74F5sV
 EynnIgTcJDWTJX7u81ySyMAaPG/swwUN2lmSL5kpCc4C9HbdBGDRIqtyD4+u4fPld6Rhgm82QZa
 Fxlw4zisjtgMCAi5qNJP9oXpodds8mfEz61yv12tjZe2Z8skqli1HpwEz7Htjecv2+IV6lvN4kh
 Ztn4X1grTWhDGvAEMztrSp4le0tdMn6TEgh2Qqd1v9Eub3sX/PMsVcav4h7yXNUa9eihUoLHhl9
 ReaeuM/pY3dlqV+gUA4S1Wt9Nx2mrPqwXknorcsFwkCrnD+jdg30u79hRqLYxnI8wFL/lHbbpaR
 b5gsscmecw2/ctjm6hn+QL0vXS7a3kEugLajz0fzv8WNFeteVaBBFglfBelYMohvtvp488b4ctA
 rfr3rWBPjlekqeC1rHcITZysfXbumnQEp2PTrd7vLxkStSL2RH0ayvsP7DqWOZLIX78rM6Wz
X-Proofpoint-GUID: dGOPkxc4y6Dhyzsny9at42OnvQZmrYf8
X-Proofpoint-ORIG-GUID: vMXsnH0F5xrr1F81L5cp0ZJsz0qxWQEX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_07,2025-05-15_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0
 spamscore=0 malwarescore=0 lowpriorityscore=0 mlxlogscore=794
 impostorscore=0 phishscore=0 priorityscore=1501 mlxscore=0 bulkscore=0
 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505150160
Received-SPF: pass client-ip=148.163.158.5; envelope-from=milesg@linux.ibm.com;
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
Reply-To: milesg@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Reviewed-by: Glenn Miles <milesg@linux.ibm.com>

On Mon, 2025-05-12 at 13:10 +1000, Nicholas Piggin wrote:
> Implement pool context push TIMA op.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  hw/intc/xive.c         |  4 ++++
>  hw/intc/xive2.c        | 50 ++++++++++++++++++++++++++++--------------
>  include/hw/ppc/xive2.h |  2 ++
>  3 files changed, 39 insertions(+), 17 deletions(-)
> 
> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> index d5bbd8f4c6..979031a587 100644
> --- a/hw/intc/xive.c
> +++ b/hw/intc/xive.c
> @@ -733,6 +733,10 @@ static const XiveTmOp xive2_tm_operations[] = {
>        xive2_tm_push_os_ctx, NULL },
>      { XIVE_TM_OS_PAGE, TM_QW1_OS + TM_LGS,        1, true, true,
>        xive_tm_set_os_lgs, NULL },
> +    { XIVE_TM_HV_PAGE, TM_QW2_HV_POOL + TM_WORD2, 4, true, true,
> +      xive2_tm_push_pool_ctx, NULL },
> +    { XIVE_TM_HV_PAGE, TM_QW2_HV_POOL + TM_WORD2, 8, true, true,
> +      xive2_tm_push_pool_ctx, NULL },
>      { XIVE_TM_HV_PAGE, TM_QW3_HV_PHYS + TM_CPPR,  1, true, true,
>        xive2_tm_set_hv_cppr, NULL },
>      { XIVE_TM_HV_PAGE, TM_QW3_HV_PHYS + TM_WORD2, 1, true, true,
> diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
> index 917ecbaae4..21cd07df68 100644
> --- a/hw/intc/xive2.c
> +++ b/hw/intc/xive2.c
> @@ -583,6 +583,7 @@ static void xive2_tctx_save_ctx(Xive2Router *xrtr, XiveTCTX *tctx,
>      xive2_router_write_nvp(xrtr, nvp_blk, nvp_idx, &nvp, 1);
>  }
>  
> +/* POOL cam is the same as OS cam encoding */
>  static void xive2_cam_decode(uint32_t cam, uint8_t *nvp_blk,
>                               uint32_t *nvp_idx, bool *valid, bool *hw)
>  {
> @@ -940,10 +941,11 @@ static uint8_t xive2_tctx_restore_ctx(Xive2Router *xrtr, XiveTCTX *tctx,
>  }
>  
>  static void xive2_tctx_need_resend(Xive2Router *xrtr, XiveTCTX *tctx,
> +                                   uint8_t ring,
>                                     uint8_t nvp_blk, uint32_t nvp_idx,
>                                     bool do_restore)
>  {
> -    uint8_t *regs = &tctx->regs[TM_QW1_OS];
> +    uint8_t *regs = &tctx->regs[ring];
>      uint8_t ipb;
>      Xive2Nvp nvp;
>  
> @@ -965,7 +967,7 @@ static void xive2_tctx_need_resend(Xive2Router *xrtr, XiveTCTX *tctx,
>  
>      /* Automatically restore thread context registers */
>      if (xive2_router_get_config(xrtr) & XIVE2_VP_SAVE_RESTORE && do_restore) {
> -        xive2_tctx_restore_ctx(xrtr, tctx, TM_QW1_OS, nvp_blk, nvp_idx, &nvp);
> +        xive2_tctx_restore_ctx(xrtr, tctx, ring, nvp_blk, nvp_idx, &nvp);
>      }
>  
>      ipb = xive_get_field32(NVP2_W2_IPB, nvp.w2);
> @@ -976,48 +978,62 @@ static void xive2_tctx_need_resend(Xive2Router *xrtr, XiveTCTX *tctx,
>      /* IPB bits in the backlog are merged with the TIMA IPB bits */
>      regs[TM_IPB] |= ipb;
>  
> -    xive2_tctx_process_pending(tctx, TM_QW1_OS);
> +    xive2_tctx_process_pending(tctx, ring == TM_QW2_HV_POOL ?
> +                                         TM_QW3_HV_PHYS : ring);
>  }
>  
>  /*
> - * Updating the OS CAM line can trigger a resend of interrupt
> + * Updating the ring CAM line can trigger a resend of interrupt
>   */
> -void xive2_tm_push_os_ctx(XivePresenter *xptr, XiveTCTX *tctx,
> -                          hwaddr offset, uint64_t value, unsigned size)
> +static void xive2_tm_push_ctx(XivePresenter *xptr, XiveTCTX *tctx,
> +                              hwaddr offset, uint64_t value, unsigned size,
> +                              uint8_t ring)
>  {
>      uint32_t cam;
> -    uint32_t qw1w2;
> -    uint64_t qw1dw1;
> +    uint32_t w2;
> +    uint64_t dw1;
>      uint8_t nvp_blk;
>      uint32_t nvp_idx;
> -    bool vo;
> +    bool v;
>      bool do_restore;
>  
>      /* First update the thead context */
>      switch (size) {
>      case 4:
>          cam = value;
> -        qw1w2 = cpu_to_be32(cam);
> -        memcpy(&tctx->regs[TM_QW1_OS + TM_WORD2], &qw1w2, 4);
> +        w2 = cpu_to_be32(cam);
> +        memcpy(&tctx->regs[ring + TM_WORD2], &w2, 4);
>          break;
>      case 8:
>          cam = value >> 32;
> -        qw1dw1 = cpu_to_be64(value);
> -        memcpy(&tctx->regs[TM_QW1_OS + TM_WORD2], &qw1dw1, 8);
> +        dw1 = cpu_to_be64(value);
> +        memcpy(&tctx->regs[ring + TM_WORD2], &dw1, 8);
>          break;
>      default:
>          g_assert_not_reached();
>      }
>  
> -    xive2_cam_decode(cam, &nvp_blk, &nvp_idx, &vo, &do_restore);
> +    xive2_cam_decode(cam, &nvp_blk, &nvp_idx, &v, &do_restore);
>  
>      /* Check the interrupt pending bits */
> -    if (vo) {
> -        xive2_tctx_need_resend(XIVE2_ROUTER(xptr), tctx, nvp_blk, nvp_idx,
> -                               do_restore);
> +    if (v) {
> +        xive2_tctx_need_resend(XIVE2_ROUTER(xptr), tctx, ring,
> +                               nvp_blk, nvp_idx, do_restore);
>      }
>  }
>  
> +void xive2_tm_push_os_ctx(XivePresenter *xptr, XiveTCTX *tctx,
> +                          hwaddr offset, uint64_t value, unsigned size)
> +{
> +    xive2_tm_push_ctx(xptr, tctx, offset, value, size, TM_QW1_OS);
> +}
> +
> +void xive2_tm_push_pool_ctx(XivePresenter *xptr, XiveTCTX *tctx,
> +                            hwaddr offset, uint64_t value, unsigned size)
> +{
> +    xive2_tm_push_ctx(xptr, tctx, offset, value, size, TM_QW2_HV_POOL);
> +}
> +
>  /* returns -1 if ring is invalid, but still populates block and index */
>  static int xive2_tctx_get_nvp_indexes(XiveTCTX *tctx, uint8_t ring,
>                                        uint8_t *nvp_blk, uint32_t *nvp_idx)
> diff --git a/include/hw/ppc/xive2.h b/include/hw/ppc/xive2.h
> index a91b99057c..c1ab06a55a 100644
> --- a/include/hw/ppc/xive2.h
> +++ b/include/hw/ppc/xive2.h
> @@ -140,6 +140,8 @@ bool xive2_tm_irq_precluded(XiveTCTX *tctx, int ring, uint8_t priority);
>  void xive2_tm_set_lsmfb(XiveTCTX *tctx, int ring, uint8_t priority);
>  void xive2_tm_set_hv_target(XivePresenter *xptr, XiveTCTX *tctx,
>                              hwaddr offset, uint64_t value, unsigned size);
> +void xive2_tm_push_pool_ctx(XivePresenter *xptr, XiveTCTX *tctx,
> +                            hwaddr offset, uint64_t value, unsigned size);
>  uint64_t xive2_tm_pull_pool_ctx(XivePresenter *xptr, XiveTCTX *tctx,
>                                  hwaddr offset, unsigned size);
>  uint64_t xive2_tm_pull_phys_ctx(XivePresenter *xptr, XiveTCTX *tctx,


