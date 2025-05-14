Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B3C2C3ABD8
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 19:14:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFHXj-0002j3-Bl; Wed, 14 May 2025 15:13:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1uFHPL-0002W0-Sl; Wed, 14 May 2025 15:04:50 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1uFHPJ-0008AK-NA; Wed, 14 May 2025 15:04:47 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54EIoJww031046;
 Wed, 14 May 2025 19:04:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=BDYoUF
 m3roSbB0O80QvXEcZaV+5/rsBQYuGJPSrfPWE=; b=N8qDydcJ4Gunc5Bckvb6Il
 IDkrO5IeATY3+SKXxhVtPXTvZDvmhAflJo3TJ1iA36WP8XclbUVBgU2OrdHCpKIO
 THCzLwRS+5+XxVcpsa7FEgNEiKk7bPjhKw0Y5BB7X13lkYSco5vCdbF2uKdC4quq
 T4BtGRk62rPMRcvKaDCmUX+7844uNhuaasfB4oqnmQ3D0clXguo2y1g7liXn5ueR
 cn7YuuLAnLJGNzhG5m4qX+VKp24GWaEqvf9wug2eW21qG5U1issXS6crydTVkfu9
 +FRrgnYSkDYI5UOTv1slzE/kxiR9O4Zt5M/BShP/h06oZky7p93Vnc3DnR0membg
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46n0t982vp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 May 2025 19:04:39 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54EIwv4C019034;
 Wed, 14 May 2025 19:04:38 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46n0t982vh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 May 2025 19:04:38 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54EGQEpe021806;
 Wed, 14 May 2025 19:04:37 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46mbfpp033-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 May 2025 19:04:37 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 54EJ4asn28246682
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 14 May 2025 19:04:36 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6FD5E5804E;
 Wed, 14 May 2025 19:04:36 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E916D58055;
 Wed, 14 May 2025 19:04:35 +0000 (GMT)
Received: from [9.10.80.143] (unknown [9.10.80.143])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 14 May 2025 19:04:35 +0000 (GMT)
Message-ID: <c9c12164-99dc-46ad-8e7a-bd4a5626559c@linux.ibm.com>
Date: Wed, 14 May 2025 14:04:35 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/50] ppc/xive: Move NSR decoding into helper functions
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?=
 <fbarrat@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Caleb Schlossin <calebs@linux.vnet.ibm.com>
References: <20250512031100.439842-1-npiggin@gmail.com>
 <20250512031100.439842-16-npiggin@gmail.com>
Content-Language: en-US
From: Mike Kowal <kowal@linux.ibm.com>
In-Reply-To: <20250512031100.439842-16-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=etzfzppX c=1 sm=1 tr=0 ts=6824e947 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8
 a=4UZJbdheEuQRtzx_KTAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE0MDE2OSBTYWx0ZWRfX1rZuNkqmktw4
 10KOcQCRpD9DMu3ZD/kPBGKrHCE3H/k1MlnacDVDSNhZQeCGaBoPABvp50ZwpF35lTNuUqww6ln
 158vmRls3Ho/mhxVVkdvronAzAGDacOnp47tvwW45z0FAPQ86k345q9ddae/JbNBFCXvDoXNceK
 VQpVQSMAQymRZIO4j6iqMBk/Y5zkskq8KL83mFJa+tfcu2Nz2Ht+4Bm5oZwBEFZIuWIU5+bhV46
 DevweZ6VoeMYdGCwqNPJpT+ZKUjzW/mjDhCOkuKCnjT4MjbTJr2JY+Z3rdmEUBI+vlVEl6NpxzO
 ZoIEftbnGkwx9fU0dNoVBmWz8gHaAZO5qzxmEsXq3ut7u2eJOHUEcg3xHz+/ejs27NfuuAjddPR
 9WRBtEMoGMYgctcnb0DVoU64iDgO+EphjiGa8aGkUoO71o+Ti1Tb5qTHSQ1jfELjKtfJ+p4P
X-Proofpoint-ORIG-GUID: 3PtB91zg01iM6Le1YZrkQXABr0oCwin5
X-Proofpoint-GUID: EDY62ZBxRN9ZwfAa0sn0S87A7dYYG1kk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-14_04,2025-05-14_03,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 lowpriorityscore=0 phishscore=0 mlxscore=0 mlxlogscore=712 bulkscore=0
 suspectscore=0 spamscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505140169
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
> Rather than functions to return masks to test NSR bits, have functions
> to test those bits directly. This should be no functional change, it
> just makes the code more readable.

Reviewed-by: Michael Kowal <kowal@linux.ibm.com>

Thanks MAK


>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   hw/intc/xive.c        | 51 +++++++++++++++++++++++++++++++++++--------
>   include/hw/ppc/xive.h |  4 ++++
>   2 files changed, 46 insertions(+), 9 deletions(-)
>
> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> index bb40a69c5b..c2da23f9ea 100644
> --- a/hw/intc/xive.c
> +++ b/hw/intc/xive.c
> @@ -25,6 +25,45 @@
>   /*
>    * XIVE Thread Interrupt Management context
>    */
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
>   static qemu_irq xive_tctx_output(XiveTCTX *tctx, uint8_t ring)
>   {
> @@ -48,18 +87,12 @@ static uint64_t xive_tctx_accept(XiveTCTX *tctx, uint8_t ring)
>   
>       qemu_irq_lower(xive_tctx_output(tctx, ring));
>   
> -    if (regs[TM_NSR] != 0) {
> +    if (xive_nsr_indicates_exception(ring, nsr)) {
>           uint8_t cppr = regs[TM_PIPR];
>           uint8_t alt_ring;
>           uint8_t *alt_regs;
>   
> -        /* POOL interrupt uses IPB in QW2, POOL ring */
> -        if ((ring == TM_QW3_HV_PHYS) &&
> -            ((nsr & TM_QW3_NSR_HE) == (TM_QW3_NSR_HE_POOL << 6))) {
> -            alt_ring = TM_QW2_HV_POOL;
> -        } else {
> -            alt_ring = ring;
> -        }
> +        alt_ring = xive_nsr_exception_ring(ring, nsr);
>           alt_regs = &tctx->regs[alt_ring];
>   
>           regs[TM_CPPR] = cppr;
> @@ -68,7 +101,7 @@ static uint64_t xive_tctx_accept(XiveTCTX *tctx, uint8_t ring)
>            * If the interrupt was for a specific VP, reset the pending
>            * buffer bit, otherwise clear the logical server indicator
>            */
> -        if (!(regs[TM_NSR] & TM_NSR_GRP_LVL)) {
> +        if (!xive_nsr_indicates_group_exception(ring, nsr)) {
>               alt_regs[TM_IPB] &= ~xive_priority_to_ipb(cppr);
>           }
>   
> diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
> index 538f438681..28f0f1b79a 100644
> --- a/include/hw/ppc/xive.h
> +++ b/include/hw/ppc/xive.h
> @@ -365,6 +365,10 @@ static inline uint32_t xive_tctx_word2(uint8_t *ring)
>       return *((uint32_t *) &ring[TM_WORD2]);
>   }
>   
> +bool xive_nsr_indicates_exception(uint8_t ring, uint8_t nsr);
> +bool xive_nsr_indicates_group_exception(uint8_t ring, uint8_t nsr);
> +uint8_t xive_nsr_exception_ring(uint8_t ring, uint8_t nsr);
> +
>   /*
>    * XIVE Router
>    */

