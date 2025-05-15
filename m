Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADC2FC2D0CD
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 16:13:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFbDV-0004Dx-Vb; Thu, 15 May 2025 12:13:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1uFbDU-0004BN-0Q; Thu, 15 May 2025 12:13:52 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1uFbDS-0001OJ-0p; Thu, 15 May 2025 12:13:51 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54FCg6Bc002325;
 Thu, 15 May 2025 16:13:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=48IZRqXt3bqQuJqi3/uAjqWWPR7TLzxrYdNa+6sFJdc=; b=ap2tI1bJXUjT
 HmpvDT1mnRCWYtGCIhQS7ahLLfp000hWLqc34Z5RIB7XWAckUJf8he9bJ5B8xr58
 ThIvmegBys7TCswqVe6aDrlAJDCbNBko9sKy6Q4xmDR2cNXWRrRAgCfXTbR6MAxz
 D6rsijdWZL8LzX3YhYHSEa0sDvhnN86LhoyLdnIHPaD+WTz9uar+7P5FLdCNC3vI
 sUwLDUsKI+fy3ulSqDt4MISfFYJRbXr11KfBcEWxMA3Pz0Dge5RG55ahqnXrlJzz
 egMBdvmUt0M3ygMt7m69Nznoz2m8Df7Iz4xfHwfpTbfgA/OO1L2RFy+cxfkW79p1
 xD1xKW80jQ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46n0v6njny-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 16:13:48 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54FG2aVT024166;
 Thu, 15 May 2025 16:13:47 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46n0v6njnw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 16:13:47 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54FDr54C024273;
 Thu, 15 May 2025 16:13:47 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46mbfsb5pp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 16:13:47 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 54FGDjTG33161894
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 15 May 2025 16:13:45 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 85C2D5805C;
 Thu, 15 May 2025 16:13:45 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EC59E58054;
 Thu, 15 May 2025 16:13:44 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 15 May 2025 16:13:44 +0000 (GMT)
Message-ID: <d7e83888600c849a94be7324927df0af80d9cb5b.camel@linux.ibm.com>
Subject: Re: [PATCH 45/50] ppc/xive2: redistribute group interrupts on
 context push
From: Miles Glenn <milesg@linux.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, =?ISO-8859-1?Q?Fr=E9d=E9ric?= Barrat
 <fbarrat@linux.ibm.com>, Michael Kowal <kowal@linux.ibm.com>, Caleb
 Schlossin <calebs@linux.vnet.ibm.com>
Date: Thu, 15 May 2025 11:13:44 -0500
In-Reply-To: <20250512031100.439842-46-npiggin@gmail.com>
References: <20250512031100.439842-1-npiggin@gmail.com>
 <20250512031100.439842-46-npiggin@gmail.com>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=IqAecK/g c=1 sm=1 tr=0 ts=682612bc cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8
 a=89eXdJJYgY74zT-coKsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: AjzxKgv_CI1r-Ijp345BTmy5vUUUxczc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDE2MCBTYWx0ZWRfX4rNoceoNTFHg
 L48VQuILL/V6x9jwF9Cf+tfE7dYRHVFybH4d+GEDYM8Xjs/ElvN4tCWkjrBVILya2I005znBiK+
 BZOfOXoAQqAXDFNuHxAFCL1Q4LZ+48FY4mvCiWtCItW7XVGfDew9+DJkX32SgdP5+bfsJg4uK6/
 7i2gWS8P2b2aF2qsfhnmOU1m0CMtY1TCOWooCbbeDJAM0mqkXSbYQohHAWAoHO5ADty0xgepO0q
 7j9l5LeQmzz+YEWWgVxB8aGBGr0cti1jC5QxrQuoRGO/yZlt8jGsEXHoB89qdL5RuXGc6jwBDNx
 JW3UA07Tpgg+sLpWCsNuCnNGaX/7hQu0CK40mq/79A4nWj/H34Zh+5Cb6/uOjZzV5SqO6kMg9VX
 OQfT3JiRgLT4q+A3AAhdYVL8WppPlG2Qe02zNmLj/kiPmtQOegf6pq7J6kWqvD7+ehL0v6xl
X-Proofpoint-GUID: MW-ty07WXAqx31obhs-_ir-HVhcGwrSY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_07,2025-05-15_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 malwarescore=0
 adultscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0
 priorityscore=1501 clxscore=1015 spamscore=0 mlxlogscore=818 bulkscore=0
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
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
> When pushing a context, any presented group interrupt should be
> redistributed before processing pending interrupts to present
> highest priority.
> 
> This can occur when pushing the POOL ring when the valid PHYS
> ring has a group interrupt presented, because they share signal
> registers.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  hw/intc/xive2.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
> index 21cd07df68..392ac6077e 100644
> --- a/hw/intc/xive2.c
> +++ b/hw/intc/xive2.c
> @@ -945,8 +945,9 @@ static void xive2_tctx_need_resend(Xive2Router *xrtr, XiveTCTX *tctx,
>                                     uint8_t nvp_blk, uint32_t nvp_idx,
>                                     bool do_restore)
>  {
> +    uint8_t *sig_regs = xive_tctx_signal_regs(tctx, ring);
>      uint8_t *regs = &tctx->regs[ring];
> -    uint8_t ipb;
> +    uint8_t ipb, nsr = sig_regs[TM_NSR];
>      Xive2Nvp nvp;
>  
>      /*
> @@ -978,6 +979,11 @@ static void xive2_tctx_need_resend(Xive2Router *xrtr, XiveTCTX *tctx,
>      /* IPB bits in the backlog are merged with the TIMA IPB bits */
>      regs[TM_IPB] |= ipb;
>  
> +    if (xive_nsr_indicates_group_exception(ring, nsr)) {
> +        /* redistribute precluded active grp interrupt */
> +        g_assert(ring == TM_QW2_HV_POOL); /* PHYS ring has the grp interrupt */
> +        xive2_redistribute(xrtr, tctx, xive_nsr_exception_ring(ring, nsr));
> +    }
>      xive2_tctx_process_pending(tctx, ring == TM_QW2_HV_POOL ?
>                                           TM_QW3_HV_PHYS : ring);
>  }


