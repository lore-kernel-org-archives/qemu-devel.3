Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75206C54754
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 15:48:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFan8-0000my-MA; Thu, 15 May 2025 11:46:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1uFamF-00082Q-KW; Thu, 15 May 2025 11:45:44 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1uFam4-0006U5-Or; Thu, 15 May 2025 11:45:43 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54FCg6LI002316;
 Thu, 15 May 2025 15:45:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=oSt+N1lu/Ph9YEJoXpM25zKAE7994l+m0uALbFqfXHI=; b=WdtecRkLMw8P
 Z8y2bRyOrNKLN17lnJWZvU+ZG++0O4ryVd7f2PWMJxgrVD/jC+WZRPGkrJSqP7wY
 42OxGg2S1BeQIIqEd6B8p/KYjkDVPnxhwbAiZgYeiGh8ZlPxvMtDOWDfiQjsstjq
 cNpSuj9aWwLMb7cOYEskgTAuEIj4z5ZQw7AF6Ukkkn5GwGKspze6sKHiLZV+oy+8
 0tJRpZwoat6J1Vdiw2mBy4gwyjVQ/x1XKkaly7g9lCfj5KV3fjCEzneYptA2YCK8
 CUAE5HsyXtyGu7EdvbCNB6jN9/UKrKA+ytG/c7+bpia6bUQ7qX88Q6XJi61jtmEs
 Z+LI/pfKwQ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46n0v6ndx9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 15:45:30 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54FFjTwe019016;
 Thu, 15 May 2025 15:45:29 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46n0v6ndx6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 15:45:29 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54FEOTig015329;
 Thu, 15 May 2025 15:45:29 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 46mbfq30ep-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 15:45:29 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 54FFjR9o25756306
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 15 May 2025 15:45:27 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3AEF858059;
 Thu, 15 May 2025 15:45:27 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A8EA258058;
 Thu, 15 May 2025 15:45:26 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 15 May 2025 15:45:26 +0000 (GMT)
Message-ID: <12549968b1d9a0a89b32900b3fc8c4a574a28906.camel@linux.ibm.com>
Subject: Re: [PATCH 12/50] ppc/xive2: Set CPPR delivery should account for
 group priority
From: Miles Glenn <milesg@linux.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, =?ISO-8859-1?Q?Fr=E9d=E9ric?= Barrat
 <fbarrat@linux.ibm.com>, Michael Kowal <kowal@linux.ibm.com>, Caleb
 Schlossin <calebs@linux.vnet.ibm.com>
Date: Thu, 15 May 2025 10:45:26 -0500
In-Reply-To: <20250512031100.439842-13-npiggin@gmail.com>
References: <20250512031100.439842-1-npiggin@gmail.com>
 <20250512031100.439842-13-npiggin@gmail.com>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=IqAecK/g c=1 sm=1 tr=0 ts=68260c1a cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=pGLkceISAAAA:8 a=zSV6phptauE46_GIRisA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: j93Hfu676Q3HpO1RJPJYyrKOxQedT-KB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDE1NSBTYWx0ZWRfXzB7WH5U8VGUP
 WdKSdzRdh/QuRrx1G0z6Gq08kOg4TyQ7el1mf5BlVTsKyy7trcDSFeSca32qN9T6AUl90nvYRPp
 nwfsQTaaGglDInbB77bIqH3283JkfypLpv0dvY4pPxmSb7bTpg5zizmHoGaaoWME2ZT6pcWAO3P
 cC3WtdDgx5J9Th90dJ1oUhwLY1TWGksiasV5WymwnMTJlk4yNNTWRITHVwWPQgPdZ7LSyA3q+iI
 7ND5rGdev2vLsTAOHwCAEP17kZfdfB00s/E+ofNikc6TgFp1OWXoJM8havlCkxYKo4qkl1rruYw
 FfkQHEioBxyiE1WYQEX8EvCuCnHulDU46Fe3ONHMXZmueQapi8Wt3VJAkJ52aZbfG8+zWGoPBXn
 XsRttxSp0BL6pm7liw1dbmzO+qYIQUPmKKRgOlE0u/ZpjJopZyOHx3tLD1fjs1sfTVqpIhPC
X-Proofpoint-GUID: yvXyE6cKdRwapzRaeOAP_fJZVL-PHSSZ
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
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Mon, 2025-05-12 at 13:10 +1000, Nicholas Piggin wrote:
> The group interrupt delivery flow selects the group backlog scan if
> LSMFB < IPB, but that scan may find an interrupt with a priority >=
> IPB. In that case, the VP-direct interrupt should be chosen. This
> extends to selecting the lowest prio between POOL and PHYS rings.
> 
> Implement this just by re-starting the selection logic if the
> backlog irq was not found or priority did not match LSMFB (LSMFB
> is updated so next time around it would see the right value and
> not loop infinitely).
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  hw/intc/xive2.c | 32 ++++++++++++++++++++++----------
>  1 file changed, 22 insertions(+), 10 deletions(-)
> 
> diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
> index 8ede95b671..de139dcfbf 100644
> --- a/hw/intc/xive2.c
> +++ b/hw/intc/xive2.c
> @@ -939,7 +939,7 @@ static void xive2_tctx_set_cppr(XiveTCTX *tctx, uint8_t ring, uint8_t cppr)
>  {
>      uint8_t *regs = &tctx->regs[ring];
>      Xive2Router *xrtr = XIVE2_ROUTER(tctx->xptr);
> -    uint8_t old_cppr, backlog_prio, first_group, group_level = 0;
> +    uint8_t old_cppr, backlog_prio, first_group, group_level;
>      uint8_t pipr_min, lsmfb_min, ring_min;
>      bool group_enabled;
>      uint32_t nvp_blk, nvp_idx;
> @@ -961,10 +961,12 @@ static void xive2_tctx_set_cppr(XiveTCTX *tctx, uint8_t ring, uint8_t cppr)
>       * Recompute the PIPR based on local pending interrupts. It will
>       * be adjusted below if needed in case of pending group interrupts.
>       */
> +again:
>      pipr_min = xive_ipb_to_pipr(regs[TM_IPB]);
>      group_enabled = !!regs[TM_LGS];
> -    lsmfb_min = (group_enabled) ? regs[TM_LSMFB] : 0xff;
> +    lsmfb_min = group_enabled ? regs[TM_LSMFB] : 0xff;
>      ring_min = ring;
> +    group_level = 0;
>  
>      /* PHYS updates also depend on POOL values */
>      if (ring == TM_QW3_HV_PHYS) {
> @@ -998,9 +1000,6 @@ static void xive2_tctx_set_cppr(XiveTCTX *tctx, uint8_t ring, uint8_t cppr)
>          }
>      }
>  
> -    /* PIPR should not be set to a value greater than CPPR */
> -    regs[TM_PIPR] = (pipr_min > cppr) ? cppr : pipr_min;
> -
>      rc = xive2_tctx_get_nvp_indexes(tctx, ring_min, &nvp_blk, &nvp_idx);
>      if (rc) {
>          qemu_log_mask(LOG_GUEST_ERROR, "XIVE: set CPPR on invalid context\n");
> @@ -1019,7 +1018,7 @@ static void xive2_tctx_set_cppr(XiveTCTX *tctx, uint8_t ring, uint8_t cppr)
>  
>      if (group_enabled &&
>          lsmfb_min < cppr &&
> -        lsmfb_min < regs[TM_PIPR]) {
> +        lsmfb_min < pipr_min) {
>          /*
>           * Thread has seen a group interrupt with a higher priority
>           * than the new cppr or pending local interrupt. Check the
> @@ -1048,12 +1047,25 @@ static void xive2_tctx_set_cppr(XiveTCTX *tctx, uint8_t ring, uint8_t cppr)
>                                                      nvp_blk, nvp_idx,
>                                                      first_group, &group_level);
>          tctx->regs[ring_min + TM_LSMFB] = backlog_prio;
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
>          }
> +
> +        xive2_presenter_backlog_decr(tctx->xptr, nvp_blk, nvp_idx,
> +                                     backlog_prio, group_level);
> +        pipr_min = backlog_prio;
>      }
> +
> +    /* PIPR should not be set to a value greater than CPPR */
> +    regs[TM_PIPR] = (pipr_min > cppr) ? cppr : pipr_min;
> +
>      /* CPPR has changed, check if we need to raise a pending exception */
>      xive_tctx_notify(tctx, ring_min, group_level);
>  }


