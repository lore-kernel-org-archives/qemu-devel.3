Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECC58C3ABD8
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 18:58:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFHIR-0001Fm-9l; Wed, 14 May 2025 14:57:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1uFHIP-0001Cz-3J; Wed, 14 May 2025 14:57:37 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1uFHIN-0006d9-1B; Wed, 14 May 2025 14:57:36 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54EGVAoh029463;
 Wed, 14 May 2025 18:57:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=cOp+P6
 7UZLUQfCeVN72EctqgLS68yoiVHuvPSoalQC0=; b=M1Jm6LpfuUi3qpRbPTNaTn
 1gjdwGN0xGVDvWDEvg0IAQg1BUjlG+fi6egPSYud9WiqTzi00II+uXyh4oWCW1WR
 OkSNpQOcXClO+N9QoxgOo3VRqsksr8RnL0jGrGssMdquGRgosH8V4IJZZCPV5kT9
 b1DZK+ogOgB8bPzsPaZTpM9rtXRgRmB/CjQc9aL6IC/uF+1z/XwMVXDOVXPGe2kN
 AyoUxckitd7ZegILaMjsSzEsW8/C1VAn0NxPDCjz1Fn6NakZ5N5yYxWW1EXqKb0q
 QNH/4252/mGvudL+1VAxKYDxwGRXgV4RZmzXHrTlkwR3YaYIyN9Epe946kA3yPOg
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46mr1gk5qj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 May 2025 18:57:32 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54EIjMIj019316;
 Wed, 14 May 2025 18:57:32 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46mr1gk5qg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 May 2025 18:57:32 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54EGes5c026947;
 Wed, 14 May 2025 18:57:31 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 46mbfpdx3m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 May 2025 18:57:31 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 54EIvTwS19989146
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 14 May 2025 18:57:30 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D4A2458055;
 Wed, 14 May 2025 18:57:29 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5252F5804E;
 Wed, 14 May 2025 18:57:29 +0000 (GMT)
Received: from [9.10.80.143] (unknown [9.10.80.143])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 14 May 2025 18:57:29 +0000 (GMT)
Message-ID: <3e1eeae3-5090-46e4-98d1-473d269891b5@linux.ibm.com>
Date: Wed, 14 May 2025 13:57:28 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/50] ppc/xive2: Set CPPR delivery should account for
 group priority
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?=
 <fbarrat@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Caleb Schlossin <calebs@linux.vnet.ibm.com>
References: <20250512031100.439842-1-npiggin@gmail.com>
 <20250512031100.439842-13-npiggin@gmail.com>
Content-Language: en-US
From: Mike Kowal <kowal@linux.ibm.com>
In-Reply-To: <20250512031100.439842-13-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: alLcKTQSN0yPXBev0Put54A54T5Qp71i
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE0MDE2OSBTYWx0ZWRfX58XAh5tasYcY
 YbPWf4mbcXyalz0Oa4NipyInqvUIoWLNe0sBVueXaye+LIoKovwRZLjp5UyxF/FX8OXW3TWLNkN
 pYqK3G5necZsftPwz80gAfg4/Jim6QCviZzmg0ym9jWflwYxM/hFa2ruJuUoZBOunDGWLeCRyor
 9tLvRCnNp8c48mVj53+cpDenYezZCeRZ4ayaX4IrwW2sC7HJL2IwFJEAERyPOk5eCOVH9D0XRjI
 ReSN6ig10BcDYbgyBpTxodfAiUIEa0XYOGffx2drNLpNbXwT6IyTyeogmdGkmZT9WvuoAdJ9heG
 nQrSHioVnL0ijfusygx2Ekd8mGaLVFOGFa25P/b8xpqBp/e8OykILpNvwdU/Cm21Yov++437Fjy
 YqHCGJj84L4ij54N14tBrWKm3bk6EzVojjYOmiaDDodnOsjk/xdqHbnvGCleF4vezt+R5/qJ
X-Proofpoint-GUID: 1xPSw8FOM-jKASgVBv-FYQII5-dKBpfh
X-Authority-Analysis: v=2.4 cv=QOxoRhLL c=1 sm=1 tr=0 ts=6824e79c cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8
 a=zSV6phptauE46_GIRisA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-14_04,2025-05-14_03,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0
 phishscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0
 clxscore=1015 mlxscore=0 bulkscore=0 priorityscore=1501 mlxlogscore=999
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505070000
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
> The group interrupt delivery flow selects the group backlog scan if
> LSMFB < IPB, but that scan may find an interrupt with a priority >=
> IPB. In that case, the VP-direct interrupt should be chosen. This
> extends to selecting the lowest prio between POOL and PHYS rings.
>
> Implement this just by re-starting the selection logic if the
> backlog irq was not found or priority did not match LSMFB (LSMFB
> is updated so next time around it would see the right value and
> not loop infinitely).

Reviewed-by: Michael Kowal <kowal@linux.ibm.com>

Thanks MAK


>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   hw/intc/xive2.c | 32 ++++++++++++++++++++++----------
>   1 file changed, 22 insertions(+), 10 deletions(-)
>
> diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
> index 8ede95b671..de139dcfbf 100644
> --- a/hw/intc/xive2.c
> +++ b/hw/intc/xive2.c
> @@ -939,7 +939,7 @@ static void xive2_tctx_set_cppr(XiveTCTX *tctx, uint8_t ring, uint8_t cppr)
>   {
>       uint8_t *regs = &tctx->regs[ring];
>       Xive2Router *xrtr = XIVE2_ROUTER(tctx->xptr);
> -    uint8_t old_cppr, backlog_prio, first_group, group_level = 0;
> +    uint8_t old_cppr, backlog_prio, first_group, group_level;
>       uint8_t pipr_min, lsmfb_min, ring_min;
>       bool group_enabled;
>       uint32_t nvp_blk, nvp_idx;
> @@ -961,10 +961,12 @@ static void xive2_tctx_set_cppr(XiveTCTX *tctx, uint8_t ring, uint8_t cppr)
>        * Recompute the PIPR based on local pending interrupts. It will
>        * be adjusted below if needed in case of pending group interrupts.
>        */
> +again:
>       pipr_min = xive_ipb_to_pipr(regs[TM_IPB]);
>       group_enabled = !!regs[TM_LGS];
> -    lsmfb_min = (group_enabled) ? regs[TM_LSMFB] : 0xff;
> +    lsmfb_min = group_enabled ? regs[TM_LSMFB] : 0xff;
>       ring_min = ring;
> +    group_level = 0;
>   
>       /* PHYS updates also depend on POOL values */
>       if (ring == TM_QW3_HV_PHYS) {
> @@ -998,9 +1000,6 @@ static void xive2_tctx_set_cppr(XiveTCTX *tctx, uint8_t ring, uint8_t cppr)
>           }
>       }
>   
> -    /* PIPR should not be set to a value greater than CPPR */
> -    regs[TM_PIPR] = (pipr_min > cppr) ? cppr : pipr_min;
> -
>       rc = xive2_tctx_get_nvp_indexes(tctx, ring_min, &nvp_blk, &nvp_idx);
>       if (rc) {
>           qemu_log_mask(LOG_GUEST_ERROR, "XIVE: set CPPR on invalid context\n");
> @@ -1019,7 +1018,7 @@ static void xive2_tctx_set_cppr(XiveTCTX *tctx, uint8_t ring, uint8_t cppr)
>   
>       if (group_enabled &&
>           lsmfb_min < cppr &&
> -        lsmfb_min < regs[TM_PIPR]) {
> +        lsmfb_min < pipr_min) {
>           /*
>            * Thread has seen a group interrupt with a higher priority
>            * than the new cppr or pending local interrupt. Check the
> @@ -1048,12 +1047,25 @@ static void xive2_tctx_set_cppr(XiveTCTX *tctx, uint8_t ring, uint8_t cppr)
>                                                       nvp_blk, nvp_idx,
>                                                       first_group, &group_level);
>           tctx->regs[ring_min + TM_LSMFB] = backlog_prio;
> -        if (backlog_prio != 0xFF) {
> -            xive2_presenter_backlog_decr(tctx->xptr, nvp_blk, nvp_idx,
> -                                         backlog_prio, group_level);
> -            regs[TM_PIPR] = backlog_prio;
> +        if (backlog_prio != lsmfb_min) {
> +            /*
> +             * If the group backlog scan finds a less favored or no interrupt,
> +             * then re-do the processing which may turn up a more favored
> +             * interrupt from IPB or the other pool. Backlog should not
> +             * find a priority < LSMFB.
> +             */
> +            g_assert(backlog_prio >= lsmfb_min);
> +            goto again;
>           }
> +
> +        xive2_presenter_backlog_decr(tctx->xptr, nvp_blk, nvp_idx,
> +                                     backlog_prio, group_level);
> +        pipr_min = backlog_prio;
>       }
> +
> +    /* PIPR should not be set to a value greater than CPPR */
> +    regs[TM_PIPR] = (pipr_min > cppr) ? cppr : pipr_min;
> +
>       /* CPPR has changed, check if we need to raise a pending exception */
>       xive_tctx_notify(tctx, ring_min, group_level);
>   }

