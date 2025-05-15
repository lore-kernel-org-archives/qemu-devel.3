Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2B5CC2D0CD
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 16:14:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFbEO-0005FF-TU; Thu, 15 May 2025 12:14:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1uFbEL-0005Bb-Ew; Thu, 15 May 2025 12:14:45 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1uFbEJ-0001S0-1W; Thu, 15 May 2025 12:14:44 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54FDnJeJ000483;
 Thu, 15 May 2025 16:14:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=FGGgxnUv7EjXg7Ajw/kmQ0Tkx2GoiuxYqy7cjPDV1OI=; b=AzVQaNaFR77c
 sVu/vJv949+0C8MQ7t3rsv0syFDNGqr3U5jVqSW/YMAJpHdRAClP8cd77JoE0iuC
 sG8QJ6tTR3OctqGdJXA/RbmkPfQRDTuigmoTg8rB+GVF+Yqjzq3nqnNkkHk66g4Q
 kd1vc9S3Jmvc5+6EtANgmt4P+R/wArpZv1wIR7HEYyOil9eZ+M9j7lgZtjWSLCaq
 EacvikwRt5jMfa+QfK6jrYY6UEOLADl0O04eqXJg6QUpIMxL7bA1Zu/Trb2Wbjg2
 yuIpaBAl6NDanpLMupxcRnKP+zucMp/7+MEHzY/SEX8GMy2MgY93n5gejHysUsMK
 IlDk1yB4Dw==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46nhg30tf1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 16:14:40 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54FGEe0s019329;
 Thu, 15 May 2025 16:14:40 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46nhg30tf0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 16:14:40 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54FE7mBD021414;
 Thu, 15 May 2025 16:14:40 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46mbfru50w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 16:14:39 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 54FGEcXv27525818
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 15 May 2025 16:14:38 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 936355805D;
 Thu, 15 May 2025 16:14:38 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3F15258058;
 Thu, 15 May 2025 16:14:38 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 15 May 2025 16:14:38 +0000 (GMT)
Message-ID: <c31203ac989907c4e5bcefc80a0e0883c1ec1b89.camel@linux.ibm.com>
Subject: Re: [PATCH 46/50] ppc/xive2: Implement set_os_pending TIMA op
From: Miles Glenn <milesg@linux.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, =?ISO-8859-1?Q?Fr=E9d=E9ric?= Barrat
 <fbarrat@linux.ibm.com>, Michael Kowal <kowal@linux.ibm.com>, Caleb
 Schlossin <calebs@linux.vnet.ibm.com>
Date: Thu, 15 May 2025 11:14:37 -0500
In-Reply-To: <20250512031100.439842-47-npiggin@gmail.com>
References: <20250512031100.439842-1-npiggin@gmail.com>
 <20250512031100.439842-47-npiggin@gmail.com>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Cf0I5Krl c=1 sm=1 tr=0 ts=682612f1 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8
 a=jaoGCA84DIYCLCjvDVkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDE2MCBTYWx0ZWRfX2hhDb9fS+C9Y
 Ux9/8BhfNdTd+R5gOUCZUzhAUGEszVlcLegltQQK9+6Ik7ApX7ObRKorAjycAR/zHP9F7iiDg0V
 Q3TqIhjef4BlA8IAyddiApxE5FrvyD+k1JECyxklqfli80/KdyO6pcJMBiMv6m0scMJrSk/KVTc
 esYteqrPf0bb69uDPdFs0vlJhLR/QLFmsOfsmoLa599OpalbgB6sn9HV57Ps7uWWpGokzLWYaSs
 Op24LOJMS4HqsYW80f5KhGkdvT1C0h3Rt52srsG15FwPSifbRJ+JzwiXdAknGNiCG8yFMUzLFvl
 BYhJbLwQ6lqCFN6yK/EiFfHvKsdkDiDmw6jnprxwLcYf22ElLbgcxGd02824q98+7OGSVuQmQji
 DRg3sq2vdoaPPgVHgn7iQzFqGAORq8aJsNRX+Hrfbk2+X8G2pfY+XibChwHPtVCj4weP1KoZ
X-Proofpoint-GUID: -KrR0aRKpntWkHyb3wtJe4M01_uKqIGE
X-Proofpoint-ORIG-GUID: RabP1kF53eFWQef_xvAnbDsGMhrP4ovQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_07,2025-05-15_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0
 spamscore=0 malwarescore=0 lowpriorityscore=0 mlxlogscore=907
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
> xive2 must take into account redistribution of group interrupts if
> the VP directed priority exceeds the group interrupt priority after
> this operation. The xive1 code is not group aware so implement this
> for xive2.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  hw/intc/xive.c         |  2 ++
>  hw/intc/xive2.c        | 28 ++++++++++++++++++++++++++++
>  include/hw/ppc/xive2.h |  2 ++
>  3 files changed, 32 insertions(+)
> 
> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> index 979031a587..dc64edf13d 100644
> --- a/hw/intc/xive.c
> +++ b/hw/intc/xive.c
> @@ -747,6 +747,8 @@ static const XiveTmOp xive2_tm_operations[] = {
>      /* MMIOs above 2K : special operations with side effects */
>      { XIVE_TM_OS_PAGE, TM_SPC_ACK_OS_REG,         2, true, false,
>        NULL, xive_tm_ack_os_reg },
> +    { XIVE_TM_OS_PAGE, TM_SPC_SET_OS_PENDING,     1, true, false,
> +      xive2_tm_set_os_pending, NULL },
>      { XIVE_TM_HV_PAGE, TM_SPC_PULL_OS_CTX_G2,     4, true, false,
>        NULL, xive2_tm_pull_os_ctx },
>      { XIVE_TM_HV_PAGE, TM_SPC_PULL_OS_CTX,        4, true, false,
> diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
> index 392ac6077e..de1ccad685 100644
> --- a/hw/intc/xive2.c
> +++ b/hw/intc/xive2.c
> @@ -1323,6 +1323,34 @@ void xive2_tm_set_os_cppr(XivePresenter *xptr, XiveTCTX *tctx,
>      xive2_tctx_set_cppr(tctx, TM_QW1_OS, value & 0xff);
>  }
>  
> +/*
> + * Adjust the IPB to allow a CPU to process event queues of other
> + * priorities during one physical interrupt cycle.
> + */
> +void xive2_tm_set_os_pending(XivePresenter *xptr, XiveTCTX *tctx,
> +                             hwaddr offset, uint64_t value, unsigned size)
> +{
> +    Xive2Router *xrtr = XIVE2_ROUTER(xptr);
> +    uint8_t ring = TM_QW1_OS;
> +    uint8_t *regs = &tctx->regs[ring];
> +    uint8_t priority = value & 0xff;
> +
> +    /*
> +     * XXX: should this simply set a bit in IPB and wait for it to be picked
> +     * up next cycle, or is it supposed to present it now? We implement the
> +     * latter here.
> +     */
> +    regs[TM_IPB] |= xive_priority_to_ipb(priority);
> +    if (xive_ipb_to_pipr(regs[TM_IPB]) >= regs[TM_PIPR]) {
> +        return;
> +    }
> +    if (xive_nsr_indicates_group_exception(ring, regs[TM_NSR])) {
> +        xive2_redistribute(xrtr, tctx, ring);
> +    }
> +
> +    xive_tctx_pipr_present(tctx, ring, priority, 0);
> +}
> +
>  static void xive2_tctx_set_target(XiveTCTX *tctx, uint8_t ring, uint8_t target)
>  {
>      uint8_t *regs = &tctx->regs[ring];
> diff --git a/include/hw/ppc/xive2.h b/include/hw/ppc/xive2.h
> index c1ab06a55a..45266c2a8b 100644
> --- a/include/hw/ppc/xive2.h
> +++ b/include/hw/ppc/xive2.h
> @@ -130,6 +130,8 @@ void xive2_tm_set_hv_cppr(XivePresenter *xptr, XiveTCTX *tctx,
>                            hwaddr offset, uint64_t value, unsigned size);
>  void xive2_tm_set_os_cppr(XivePresenter *xptr, XiveTCTX *tctx,
>                            hwaddr offset, uint64_t value, unsigned size);
> +void xive2_tm_set_os_pending(XivePresenter *xptr, XiveTCTX *tctx,
> +                             hwaddr offset, uint64_t value, unsigned size);
>  void xive2_tm_push_os_ctx(XivePresenter *xptr, XiveTCTX *tctx, hwaddr offset,
>                             uint64_t value, unsigned size);
>  uint64_t xive2_tm_pull_os_ctx(XivePresenter *xptr, XiveTCTX *tctx,


