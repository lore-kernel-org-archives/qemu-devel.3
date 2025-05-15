Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73C43C3ABC9
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 15:57:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFaxG-000709-8N; Thu, 15 May 2025 11:57:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1uFax0-0006sz-7H; Thu, 15 May 2025 11:56:53 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1uFawq-0007dm-Bx; Thu, 15 May 2025 11:56:47 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54FCg4nS002178;
 Thu, 15 May 2025 15:56:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=HuRdb4bRdIg25NxX1x/DBbl3gqjGuCXTa3B/yZ3m5Ew=; b=m1by4MP/i9h/
 2CTrjetiyayNu0bW1T62Irn9Obyk3apcVFkppmCUHv6RtZIGhP6eqMEBR5YvSEcO
 q7IPK7sSOpU8Zv23F98Xij2HMauPWGmfcph6ZuwP7lxAYMO+asBKKr6t6YJqm29a
 Nr2TiXeXKOo1Ki4YNGoQ39GicY7gzVuqHamY1aZENrWqav7SQq6udrqzPkC/mWdO
 fuzJY9prn/jPBXIYlBKMDSwcr+FwLaef1Kf6VMqydaBEWiWHQa/d8ZYOzovdJ335
 xlXwptaq2NmPA7g3D8XKmiB57VoFgaIHoHX8MzBdKJxs/vtQF1MtfsrYnsC+NJ7t
 lNjZunTnRQ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46n0v6nfjn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 15:56:34 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54FFYkgF025090;
 Thu, 15 May 2025 15:56:34 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46n0v6nfjk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 15:56:34 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54FDuWc5019466;
 Thu, 15 May 2025 15:56:33 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 46mbfru30c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 15:56:33 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 54FFuWpH26935902
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 15 May 2025 15:56:32 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 59D815803F;
 Thu, 15 May 2025 15:56:32 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F16F458056;
 Thu, 15 May 2025 15:56:31 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 15 May 2025 15:56:31 +0000 (GMT)
Message-ID: <198cfe6f7e78a357b0c3fd47b5765ea3838c8788.camel@linux.ibm.com>
Subject: Re: [PATCH 32/50] ppc/xive: Split xive recompute from IPB function
From: Miles Glenn <milesg@linux.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, =?ISO-8859-1?Q?Fr=E9d=E9ric?= Barrat
 <fbarrat@linux.ibm.com>, Michael Kowal <kowal@linux.ibm.com>, Caleb
 Schlossin <calebs@linux.vnet.ibm.com>
Date: Thu, 15 May 2025 10:56:31 -0500
In-Reply-To: <20250512031100.439842-33-npiggin@gmail.com>
References: <20250512031100.439842-1-npiggin@gmail.com>
 <20250512031100.439842-33-npiggin@gmail.com>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=IqAecK/g c=1 sm=1 tr=0 ts=68260eb2 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8
 a=fYsK3lllQ_V0z_g72gUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: kpty0TucV8ZZBd6A5MGya8hnQnHI4bpu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDE1NSBTYWx0ZWRfX+P8Z0lpWsx9b
 VsJ9B7xa5vVi09bcy4nd6gJYmnbKhMJ0PKYDDwP+LnZ5VTEwU7qqLd7Owv8gbZxmaxxUNlV76bw
 Trbb9bOKi9X08GT+i+oOlssK7+hQA2+N/Ekgt90ED4aqhy3IgGdZY0BJDc7VBCiX+1dap93C8WK
 Lgf4n9KaOyMrO+wlvwwEAxdcuHCD0P3VjwhRg1GRo2Bpp/Bd1qMslt60vaz12TcngnRJwIzRhei
 HZUKkAxW78WPQ3qnwr86OAQR+5BY7XRxn+pqJCbuxq4aKyQaQxjE5kCVz6O3a2ynowkJX66lzfN
 KGZwgh+d8OvxyEjAxtCrVxNhvCUSZ+ViYJKJmDkbZ+dA+sYVRvjmyVEX3pWSCCc3eVJo44y8bPv
 5TpaHJ6NSjW/QPB+7DY1J1SuNefjX3KNnwNQLcssH3LqsMf2Ho/uewCv/EcFB6cXJMXlVTkx
X-Proofpoint-GUID: bsjv77mkbevVogMh2_Vgm0ZWOVStlYSA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_06,2025-05-15_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 malwarescore=0
 adultscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0
 priorityscore=1501 clxscore=1015 spamscore=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505150155
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
> Further split xive_tctx_pipr_update() by splitting out a new function
> that is used to re-compute the PIPR from IPB. This is generally only
> used with XIVE1, because group interrputs require more logic.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  hw/intc/xive.c | 25 ++++++++++++++++++++++---
>  1 file changed, 22 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> index 25f6c69c44..5ff1b8f024 100644
> --- a/hw/intc/xive.c
> +++ b/hw/intc/xive.c
> @@ -225,6 +225,20 @@ void xive_tctx_pipr_update(XiveTCTX *tctx, uint8_t ring, uint8_t priority,
>      xive_tctx_notify(tctx, ring, group_level);
>   }
>  
> +static void xive_tctx_pipr_recompute_from_ipb(XiveTCTX *tctx, uint8_t ring)
> +{
> +    /* HV_POOL ring uses HV_PHYS NSR, CPPR and PIPR registers */
> +    uint8_t alt_ring = (ring == TM_QW2_HV_POOL) ? TM_QW3_HV_PHYS : ring;
> +    uint8_t *aregs = &tctx->regs[alt_ring];
> +    uint8_t *regs = &tctx->regs[ring];
> +
> +    /* Does not support a presented group interrupt */
> +    g_assert(!xive_nsr_indicates_group_exception(alt_ring, aregs[TM_NSR]));
> +
> +    aregs[TM_PIPR] = xive_ipb_to_pipr(regs[TM_IPB]);
> +    xive_tctx_notify(tctx, ring, 0);
> +}
> +
>  void xive_tctx_pipr_present(XiveTCTX *tctx, uint8_t ring, uint8_t priority,
>                              uint8_t group_level)
>  {
> @@ -517,7 +531,12 @@ static void xive_tm_set_os_lgs(XivePresenter *xptr, XiveTCTX *tctx,
>  static void xive_tm_set_os_pending(XivePresenter *xptr, XiveTCTX *tctx,
>                                     hwaddr offset, uint64_t value, unsigned size)
>  {
> -    xive_tctx_pipr_update(tctx, TM_QW1_OS, value & 0xff, 0);
> +    uint8_t ring = TM_QW1_OS;
> +    uint8_t *regs = &tctx->regs[ring];
> +
> +    /* XXX: how should this work exactly? */
> +    regs[TM_IPB] |= xive_priority_to_ipb(value & 0xff);
> +    xive_tctx_pipr_recompute_from_ipb(tctx, ring);
>  }
>  
>  static void xive_os_cam_decode(uint32_t cam, uint8_t *nvt_blk,
> @@ -601,14 +620,14 @@ static void xive_tctx_need_resend(XiveRouter *xrtr, XiveTCTX *tctx,
>      }
>  
>      /*
> -     * Always call xive_tctx_pipr_update(). Even if there were no
> +     * Always call xive_tctx_recompute_from_ipb(). Even if there were no
>       * escalation triggered, there could be a pending interrupt which
>       * was saved when the context was pulled and that we need to take
>       * into account by recalculating the PIPR (which is not
>       * saved/restored).
>       * It will also raise the External interrupt signal if needed.
>       */
> -    xive_tctx_pipr_update(tctx, TM_QW1_OS, 0xFF, 0); /* fxb */
> +    xive_tctx_pipr_recompute_from_ipb(tctx, TM_QW1_OS); /* fxb */
>  }
>  
>  /*


