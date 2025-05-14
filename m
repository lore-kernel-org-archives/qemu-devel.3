Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7433EC3ABD8
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 20:44:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFIwT-0006AY-1J; Wed, 14 May 2025 16:43:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1uFIwP-000624-7I; Wed, 14 May 2025 16:43:01 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1uFIwN-0000a4-5a; Wed, 14 May 2025 16:43:00 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54EHq0mJ029642;
 Wed, 14 May 2025 20:42:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=ZP1cbl
 RNA8Ns8RY+/V095utz4eYpDIbTWWOXEsdvRi0=; b=Ohum+pU9ZvUmvXBCllB3tO
 20N6ISPpOfRqX7/kMUwIVt0KKpujIB4qfBA/qOF0etujD30t6PK3tLd20kGZePh1
 BcByLKL+B+FhZWuCcWMU7rq8M5LNZA8XFW6fc66EBLyhaS7e1LJSqwhasbc2sl63
 fKVKkwjF30KLgwo2M+UXrrh42i97ypJHbNwYDO+qO1GF5CDvMAlYzx6domEoOece
 q+FJgFZON43TGKRtM9rgzLDT53C9JsTr8C9fmRQYg+2OeKhr+DFFPTSMFwnR5QY8
 Mn916wKdQ/+RDJ67FuYXOkWlnxQxrcpk9LQyv+MDhiTcKQdFGzhyJvyqyDhp6b4g
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46mr1gkpx7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 May 2025 20:42:56 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54EKdLJ9013042;
 Wed, 14 May 2025 20:42:55 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46mr1gkpx6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 May 2025 20:42:55 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54EJjYxX021797;
 Wed, 14 May 2025 20:42:54 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46mbfppfbv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 May 2025 20:42:54 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 54EKgr3P30278288
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 14 May 2025 20:42:53 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6EAA65804E;
 Wed, 14 May 2025 20:42:53 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DC3715803F;
 Wed, 14 May 2025 20:42:52 +0000 (GMT)
Received: from [9.10.80.143] (unknown [9.10.80.143])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 14 May 2025 20:42:52 +0000 (GMT)
Message-ID: <015a40ec-5685-4572-a981-29fc40fefcda@linux.ibm.com>
Date: Wed, 14 May 2025 15:42:52 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 32/50] ppc/xive: Split xive recompute from IPB function
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?=
 <fbarrat@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Caleb Schlossin <calebs@linux.vnet.ibm.com>
References: <20250512031100.439842-1-npiggin@gmail.com>
 <20250512031100.439842-33-npiggin@gmail.com>
Content-Language: en-US
From: Mike Kowal <kowal@linux.ibm.com>
In-Reply-To: <20250512031100.439842-33-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: j2y_i3P4Ed15hzBuBxPTgXM--2X_pm3B
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE0MDE5MCBTYWx0ZWRfXxSvua5KlQSCY
 jjE0Iqe4aieHmN88tl+EQYcWJCeRWoTXI+/J/FQZrZJhrpnnkFj+yo/+aJO5cgOe92fdAogjdGf
 AH8eFo+MSYrPndGf6jTCHam0sNdu01X7x8Rn/7bKeOndmuexLgmX0Aa2u6sloGwSvApfskIlELm
 /NBnGrBuxkkvSpzvNm00QzON+6BkdXjyRjAQDj3ojjTRCXiqoDKmMs8wU6NQzz3Y+rrSyDJkDhK
 lBb7RdwXzBNI0YN+BIK10z4wYHf8dsXcA8yyQo4G/+WMtVmLtL/9VT1UO2uvgHmgmm318pQc7y9
 jPKUu3rcvIN4pvEwhQB6bcWgi2UryqB6+dU6mOzLNB53eV+/P7/mT8TXaYS/34EaC7OSLYlPBNw
 boFZ3eIboWr2azdj34VKnZDN7y+yrjES5FHVxMmMW8+oe3XoLE0LksELM1IDGnyMdhxR9WnP
X-Proofpoint-GUID: 7xnvuGL1MZj-5mn4Z3JbIsgHnRqqF2OL
X-Authority-Analysis: v=2.4 cv=QOxoRhLL c=1 sm=1 tr=0 ts=68250050 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8
 a=fYsK3lllQ_V0z_g72gUA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-14_04,2025-05-14_03,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0
 phishscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0
 clxscore=1015 mlxscore=0 bulkscore=0 priorityscore=1501 mlxlogscore=999
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505140190
Received-SPF: pass client-ip=148.163.156.1; envelope-from=kowal@linux.ibm.com;
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


On 5/11/2025 10:10 PM, Nicholas Piggin wrote:
> Further split xive_tctx_pipr_update() by splitting out a new function
> that is used to re-compute the PIPR from IPB. This is generally only
> used with XIVE1, because group interrputs require more logic.


Previous upstreaming was focused only on XIVE2 as not to impact users of 
XIVE1.

But I assume this does not hurt anything.

Reviewed-by: Michael Kowal<kowal@linux.ibm.com>

Thanks,  MAK


>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   hw/intc/xive.c | 25 ++++++++++++++++++++++---
>   1 file changed, 22 insertions(+), 3 deletions(-)
>
> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> index 25f6c69c44..5ff1b8f024 100644
> --- a/hw/intc/xive.c
> +++ b/hw/intc/xive.c
> @@ -225,6 +225,20 @@ void xive_tctx_pipr_update(XiveTCTX *tctx, uint8_t ring, uint8_t priority,
>       xive_tctx_notify(tctx, ring, group_level);
>    }
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
>   void xive_tctx_pipr_present(XiveTCTX *tctx, uint8_t ring, uint8_t priority,
>                               uint8_t group_level)
>   {
> @@ -517,7 +531,12 @@ static void xive_tm_set_os_lgs(XivePresenter *xptr, XiveTCTX *tctx,
>   static void xive_tm_set_os_pending(XivePresenter *xptr, XiveTCTX *tctx,
>                                      hwaddr offset, uint64_t value, unsigned size)
>   {
> -    xive_tctx_pipr_update(tctx, TM_QW1_OS, value & 0xff, 0);
> +    uint8_t ring = TM_QW1_OS;
> +    uint8_t *regs = &tctx->regs[ring];
> +
> +    /* XXX: how should this work exactly? */
> +    regs[TM_IPB] |= xive_priority_to_ipb(value & 0xff);
> +    xive_tctx_pipr_recompute_from_ipb(tctx, ring);
>   }
>   
>   static void xive_os_cam_decode(uint32_t cam, uint8_t *nvt_blk,
> @@ -601,14 +620,14 @@ static void xive_tctx_need_resend(XiveRouter *xrtr, XiveTCTX *tctx,
>       }
>   
>       /*
> -     * Always call xive_tctx_pipr_update(). Even if there were no
> +     * Always call xive_tctx_recompute_from_ipb(). Even if there were no
>        * escalation triggered, there could be a pending interrupt which
>        * was saved when the context was pulled and that we need to take
>        * into account by recalculating the PIPR (which is not
>        * saved/restored).
>        * It will also raise the External interrupt signal if needed.
>        */
> -    xive_tctx_pipr_update(tctx, TM_QW1_OS, 0xFF, 0); /* fxb */
> +    xive_tctx_pipr_recompute_from_ipb(tctx, TM_QW1_OS); /* fxb */
>   }
>   
>   /*

