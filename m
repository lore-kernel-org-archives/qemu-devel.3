Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A850C3ABC9
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 16:16:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFbFk-0006zw-GO; Thu, 15 May 2025 12:16:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1uFbFi-0006ys-H2; Thu, 15 May 2025 12:16:10 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1uFbFg-0001lX-4g; Thu, 15 May 2025 12:16:10 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54FCg4OK004757;
 Thu, 15 May 2025 16:16:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=c3gwoWzHF/I7I1h8UdXosNMr4t8T3f5oT+nEQoJhwfc=; b=FZtidoWMExOU
 F9/qCSZvlpiU/qpzXrzFDte1RGCVcWFyGHBbLUaBxdiNCmJbnwUpl3naimDrtIaz
 nYFI1RDo8WENVdl/zZK4uvv+jvuC7SeCvj5xVmU8ji0fCiaf2ee00SsQBAWewc+p
 Zcn3tNCRu6wo4uBYCnQlkGtQ9/LHduYva+bk3nlBn/6+GBfQJp3+0MUdyeK3eRQj
 4QbdPEZ0R/VcXV5bbWu3N0ZGNdUxRZiSpegCZbJtKF+T5gk327KKa4E89fdQglTK
 aCQtvKi3E+vdFv/cvj7VTHv+1R7pc0MZ0zU5bVcxONkGQ7QSONwch7hTk0dVlCgh
 LDUaTcm7PA==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46navu327t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 16:16:04 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54FFxb6e026198;
 Thu, 15 May 2025 16:16:04 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46navu327s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 16:16:04 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54FEAT5Q026939;
 Thu, 15 May 2025 16:16:03 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 46mbfpk5j1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 16:16:03 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 54FGG17e32702980
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 15 May 2025 16:16:02 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E11F458058;
 Thu, 15 May 2025 16:16:01 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 51AA85805C;
 Thu, 15 May 2025 16:16:01 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 15 May 2025 16:16:01 +0000 (GMT)
Message-ID: <1bba86aa5bc209a5fefd5429f5ebf3b37b36975a.camel@linux.ibm.com>
Subject: Re: [PATCH 48/50] ppc/xive2: Implement PHYS ring VP push TIMA op
From: Miles Glenn <milesg@linux.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, =?ISO-8859-1?Q?Fr=E9d=E9ric?= Barrat
 <fbarrat@linux.ibm.com>, Michael Kowal <kowal@linux.ibm.com>, Caleb
 Schlossin <calebs@linux.vnet.ibm.com>
Date: Thu, 15 May 2025 11:16:00 -0500
In-Reply-To: <20250512031100.439842-49-npiggin@gmail.com>
References: <20250512031100.439842-1-npiggin@gmail.com>
 <20250512031100.439842-49-npiggin@gmail.com>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: rep62-z1qhBMZb_1araOXCVVhmNLlIoJ
X-Authority-Analysis: v=2.4 cv=XK4wSRhE c=1 sm=1 tr=0 ts=68261345 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8
 a=0snGxUKV56Hvqz7yRSUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: w3tgG4t2WnXzEvVA5mdTsUI2DqlvxdP6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDE2MCBTYWx0ZWRfXzCalC7qdRYzf
 LzIJ51yRl81Bg9tBxicBEyuMcNOd8r7aTuXQKHqWEh6shtkP7nK11V7LcqScgiPdJbixmUZwWxA
 +mjvByK7/WhwGIHf3ekQM/dqdsHr5vtLY2253qgnq8VbL25/C0W47UuwCCZi95PGw6BDrsGqg+h
 qazpHddIGT6AQfe9UHNA45D61gRyABaBEYOMhZ0+Q4Hd5oilwObz3Lp6Zcv+4m8qkWeec5Szp4s
 e7A7/6FF4FH8VvKNrzcqF/MJll/Me9K6Kv5KamfnEJyD5qOMjutuNf35HiPH5+KwMkfG+cPEclG
 GQ6Ix6xe7cXccAIUBZ29drNrVo259Y5xqlkfu7QaQrUyEBWbNMYAhhkyioweTNAiqEDEbYP9vvV
 bN4LiNVh/6ssUjZXQBKOzmhOae55t1R55o6w7Npk/kLp57Q7o++PLP5Xb4UmxZZXbRgi6JO5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_07,2025-05-15_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0
 mlxscore=0 bulkscore=0 mlxlogscore=970 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 impostorscore=0 adultscore=0
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
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
> Implement the phys (aka hard) VP push. PowerVM uses this operation.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  hw/intc/xive.c         |  2 ++
>  hw/intc/xive2.c        | 11 +++++++++++
>  include/hw/ppc/xive2.h |  2 ++
>  3 files changed, 15 insertions(+)
> 
> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> index 807a1c1c34..69118999e6 100644
> --- a/hw/intc/xive.c
> +++ b/hw/intc/xive.c
> @@ -747,6 +747,8 @@ static const XiveTmOp xive2_tm_operations[] = {
>        xive_tm_set_pool_lgs, NULL },
>      { XIVE_TM_HV_PAGE, TM_QW3_HV_PHYS + TM_CPPR,  1, true, true,
>        xive2_tm_set_hv_cppr, NULL },
> +    { XIVE_TM_HV_PAGE, TM_QW3_HV_PHYS + TM_WORD2, 1, false, true,
> +      xive2_tm_push_phys_ctx, NULL },
>      { XIVE_TM_HV_PAGE, TM_QW3_HV_PHYS + TM_WORD2, 1, true, true,
>        NULL, xive_tm_vt_poll },
>      { XIVE_TM_HV_PAGE, TM_QW3_HV_PHYS + TM_T,     1, true, true,
> diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
> index de1ccad685..a9b188b909 100644
> --- a/hw/intc/xive2.c
> +++ b/hw/intc/xive2.c
> @@ -1005,6 +1005,11 @@ static void xive2_tm_push_ctx(XivePresenter *xptr, XiveTCTX *tctx,
>  
>      /* First update the thead context */
>      switch (size) {
> +    case 1:
> +        tctx->regs[ring + TM_WORD2] = value & 0xff;
> +        cam = xive2_tctx_hw_cam_line(xptr, tctx);
> +        cam |= ((value & 0xc0) << 24); /* V and H bits */
> +        break;
>      case 4:
>          cam = value;
>          w2 = cpu_to_be32(cam);
> @@ -1040,6 +1045,12 @@ void xive2_tm_push_pool_ctx(XivePresenter *xptr, XiveTCTX *tctx,
>      xive2_tm_push_ctx(xptr, tctx, offset, value, size, TM_QW2_HV_POOL);
>  }
>  
> +void xive2_tm_push_phys_ctx(XivePresenter *xptr, XiveTCTX *tctx,
> +                            hwaddr offset, uint64_t value, unsigned size)
> +{
> +    xive2_tm_push_ctx(xptr, tctx, offset, value, size, TM_QW3_HV_PHYS);
> +}
> +
>  /* returns -1 if ring is invalid, but still populates block and index */
>  static int xive2_tctx_get_nvp_indexes(XiveTCTX *tctx, uint8_t ring,
>                                        uint8_t *nvp_blk, uint32_t *nvp_idx)
> diff --git a/include/hw/ppc/xive2.h b/include/hw/ppc/xive2.h
> index 45266c2a8b..f4437e2c79 100644
> --- a/include/hw/ppc/xive2.h
> +++ b/include/hw/ppc/xive2.h
> @@ -146,6 +146,8 @@ void xive2_tm_push_pool_ctx(XivePresenter *xptr, XiveTCTX *tctx,
>                              hwaddr offset, uint64_t value, unsigned size);
>  uint64_t xive2_tm_pull_pool_ctx(XivePresenter *xptr, XiveTCTX *tctx,
>                                  hwaddr offset, unsigned size);
> +void xive2_tm_push_phys_ctx(XivePresenter *xptr, XiveTCTX *tctx,
> +                            hwaddr offset, uint64_t value, unsigned size);
>  uint64_t xive2_tm_pull_phys_ctx(XivePresenter *xptr, XiveTCTX *tctx,
>                                  hwaddr offset, unsigned size);
>  void xive2_tm_pull_phys_ctx_ol(XivePresenter *xptr, XiveTCTX *tctx,


