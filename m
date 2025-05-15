Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25C29C54754
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 15:51:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFaoy-0000XD-G8; Thu, 15 May 2025 11:48:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1uFaot-00005f-0j; Thu, 15 May 2025 11:48:27 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1uFaom-0006gR-3p; Thu, 15 May 2025 11:48:26 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54FCg44T004680;
 Thu, 15 May 2025 15:48:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=4yjmpH0400ZrmT9Y9Fdw7fqIGgJobuwOJdA8Lx3z29E=; b=iKXJqEBy/VT3
 V8bk5ZvfYKpx55Z/aP41FgF4ZAWLTF0l9FlC47a8NqTP93dvrM/7kYwx1RM2kywT
 p3MeGraIlvHTtfLhr6n5TtP3cYLGvvBXEplNlTSFzZ+r29mvBWn3roV7pDR7niQr
 Fln63OOI93+6eb4Uor9q7dpi9srCMfP1709rjKm1lld5DBs0aPUuolHp0pOcjmA0
 Cy6UIEfNVsvU2kyTD6g2Tv3VajuLnuOWiVEAwpslJPCbwI+XtiYJuijiOPS132Xk
 6LhQCwgkkdW/a1JcFZwNM5XblWM+spFYebqmLx4XLJWvLhLoxQkySJx8kdukd1Xu
 kslOSl8Syw==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46navu2wd0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 15:48:14 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54FFbOv3004980;
 Thu, 15 May 2025 15:48:14 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46navu2wcv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 15:48:14 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54FDqFL4026954;
 Thu, 15 May 2025 15:48:13 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 46mbfpk197-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 15:48:13 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 54FFmCkY21693122
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 15 May 2025 15:48:12 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F421958058;
 Thu, 15 May 2025 15:48:11 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5F41C5805B;
 Thu, 15 May 2025 15:48:11 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 15 May 2025 15:48:11 +0000 (GMT)
Message-ID: <27fe9973722d8fc025f22336c77a4a4e1a18b591.camel@linux.ibm.com>
Subject: Re: [PATCH 15/50] ppc/xive: Move NSR decoding into helper functions
From: Miles Glenn <milesg@linux.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, =?ISO-8859-1?Q?Fr=E9d=E9ric?= Barrat
 <fbarrat@linux.ibm.com>, Michael Kowal <kowal@linux.ibm.com>, Caleb
 Schlossin <calebs@linux.vnet.ibm.com>
Date: Thu, 15 May 2025 10:48:10 -0500
In-Reply-To: <20250512031100.439842-16-npiggin@gmail.com>
References: <20250512031100.439842-1-npiggin@gmail.com>
 <20250512031100.439842-16-npiggin@gmail.com>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: F6NGbNW3sRVsTmz0oydBNZCpES1PFGjQ
X-Authority-Analysis: v=2.4 cv=XK4wSRhE c=1 sm=1 tr=0 ts=68260cbf cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8
 a=4UZJbdheEuQRtzx_KTAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 4lRB4XiZeSmcUODOjGWb3ui-QHC78fHx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDE1NSBTYWx0ZWRfX7HtgRP0qBi2z
 DXsgCgiN0MGmE8ShHEts6eUPzpy1SmzJXYCY9VbhC++is2YNTJs4kok5n3PC8hQA2025SahuGvW
 Jhf8Jf06CtLN/NleXmH860DXPDzt1/cHLqAgxcP9jHr4wpPsd6Jwi5IVUvxX/9nGiHa4T1Z1hXs
 hiNOuAejHOqwbM2lovc0sxi93NjkEMyU6pczSNOh6HaljgySD7Qo4w6TzEgeABzReyYznoohgn2
 HN8oskRwPoeI1XBKHp4mcoIruAt+EfUQ0pi0/2nHF+XAA5w9z7Y+7tfopE3DGH/anld9FgfMDSB
 y0ZvvGDnn+j5wBnAS+25gzg9jczqfqIIOp6VqbMbJ3lEzUXnjd1X7oIGdE9UybPvrzB4TrkLeQw
 mZETdhPt3jnQh7lC9/bK5yM+5kH1Zg4R590dN2vY2o/Sbmc8GQJJWwsetnXwz30/o1UXqcu8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_06,2025-05-15_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0
 mlxscore=0 bulkscore=0 mlxlogscore=620 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 impostorscore=0 adultscore=0
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
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
> Rather than functions to return masks to test NSR bits, have functions
> to test those bits directly. This should be no functional change, it
> just makes the code more readable.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  hw/intc/xive.c        | 51 +++++++++++++++++++++++++++++++++++--------
>  include/hw/ppc/xive.h |  4 ++++
>  2 files changed, 46 insertions(+), 9 deletions(-)
> 
> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> index bb40a69c5b..c2da23f9ea 100644
> --- a/hw/intc/xive.c
> +++ b/hw/intc/xive.c
> @@ -25,6 +25,45 @@
>  /*
>   * XIVE Thread Interrupt Management context
>   */
> +bool xive_nsr_indicates_exception(uint8_t ring, uint8_t nsr)
> +{
> +    switch (ring) {
> +    case TM_QW1_OS:
> +        return !!(nsr & TM_QW1_NSR_EO);
> +    case TM_QW2_HV_POOL:
> +    case TM_QW3_HV_PHYS:
> +        return !!(nsr & TM_QW3_NSR_HE);
> +    default:
> +        g_assert_not_reached();
> +    }
> +}
> +
> +bool xive_nsr_indicates_group_exception(uint8_t ring, uint8_t nsr)
> +{
> +    if ((nsr & TM_NSR_GRP_LVL) > 0) {
> +        g_assert(xive_nsr_indicates_exception(ring, nsr));
> +        return true;
> +    }
> +    return false;
> +}
> +
> +uint8_t xive_nsr_exception_ring(uint8_t ring, uint8_t nsr)
> +{
> +    /* NSR determines if pool/phys ring is for phys or pool interrupt */
> +    if ((ring == TM_QW3_HV_PHYS) || (ring == TM_QW2_HV_POOL)) {
> +        uint8_t he = (nsr & TM_QW3_NSR_HE) >> 6;
> +
> +        if (he == TM_QW3_NSR_HE_PHYS) {
> +            return TM_QW3_HV_PHYS;
> +        } else if (he == TM_QW3_NSR_HE_POOL) {
> +            return TM_QW2_HV_POOL;
> +        } else {
> +            /* Don't support LSI mode */
> +            g_assert_not_reached();
> +        }
> +    }
> +    return ring;
> +}
>  
>  static qemu_irq xive_tctx_output(XiveTCTX *tctx, uint8_t ring)
>  {
> @@ -48,18 +87,12 @@ static uint64_t xive_tctx_accept(XiveTCTX *tctx, uint8_t ring)
>  
>      qemu_irq_lower(xive_tctx_output(tctx, ring));
>  
> -    if (regs[TM_NSR] != 0) {
> +    if (xive_nsr_indicates_exception(ring, nsr)) {
>          uint8_t cppr = regs[TM_PIPR];
>          uint8_t alt_ring;
>          uint8_t *alt_regs;
>  
> -        /* POOL interrupt uses IPB in QW2, POOL ring */
> -        if ((ring == TM_QW3_HV_PHYS) &&
> -            ((nsr & TM_QW3_NSR_HE) == (TM_QW3_NSR_HE_POOL << 6))) {
> -            alt_ring = TM_QW2_HV_POOL;
> -        } else {
> -            alt_ring = ring;
> -        }
> +        alt_ring = xive_nsr_exception_ring(ring, nsr);
>          alt_regs = &tctx->regs[alt_ring];
>  
>          regs[TM_CPPR] = cppr;
> @@ -68,7 +101,7 @@ static uint64_t xive_tctx_accept(XiveTCTX *tctx, uint8_t ring)
>           * If the interrupt was for a specific VP, reset the pending
>           * buffer bit, otherwise clear the logical server indicator
>           */
> -        if (!(regs[TM_NSR] & TM_NSR_GRP_LVL)) {
> +        if (!xive_nsr_indicates_group_exception(ring, nsr)) {
>              alt_regs[TM_IPB] &= ~xive_priority_to_ipb(cppr);
>          }
>  
> diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
> index 538f438681..28f0f1b79a 100644
> --- a/include/hw/ppc/xive.h
> +++ b/include/hw/ppc/xive.h
> @@ -365,6 +365,10 @@ static inline uint32_t xive_tctx_word2(uint8_t *ring)
>      return *((uint32_t *) &ring[TM_WORD2]);
>  }
>  
> +bool xive_nsr_indicates_exception(uint8_t ring, uint8_t nsr);
> +bool xive_nsr_indicates_group_exception(uint8_t ring, uint8_t nsr);
> +uint8_t xive_nsr_exception_ring(uint8_t ring, uint8_t nsr);
> +
>  /*
>   * XIVE Router
>   */


