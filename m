Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADBB9C3DA6D
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 16:07:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFb75-0003SX-3k; Thu, 15 May 2025 12:07:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1uFb6j-0002rL-IW; Thu, 15 May 2025 12:06:59 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1uFb6g-0000YG-1T; Thu, 15 May 2025 12:06:52 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54FDn3Z9032297;
 Thu, 15 May 2025 16:06:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=fawGPSErN21Yv7x+wKDzxKRp+dQQPdexiwI86i+hLng=; b=iAsi/TqojoFQ
 QsBLfgsmVlwR5iSA3hENu15UmYO6B0ZXHGybjKwGNyILkW5+yJL32o8PCJzzDPBX
 FPbjo0nZcwNWaCiQjt6KkRcr6sctGUX4tsXYjRoeZsJAMV2Of0X4x1nAUnCTxTGP
 G9VtdgT11p+W6hXDPCCZiWl8B3y2u96jLNdZlJQBg4+AQzy/+4N1KUgXvuC6/sBO
 5MUJFaIoWgx3c5QmkQuOxbaK21uX+grTT0nEX217NdzF1q4U0R/yCzJlGZvxkLtV
 tkk3RYqIc5vsmRh/OGJjuoXZJPHl007yenleXob0LMuqctLK/sXJg0u67Kb8EyDm
 z+aZNy5bBg==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46nhg30s4x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 16:06:42 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54FFeQ89003868;
 Thu, 15 May 2025 16:06:42 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46nhg30s2n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 16:06:42 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54FE58tx021459;
 Thu, 15 May 2025 16:06:12 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46mbfru3xp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 16:06:12 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 54FG6BFX24511088
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 15 May 2025 16:06:11 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 973065805D;
 Thu, 15 May 2025 16:06:11 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 42A7158057;
 Thu, 15 May 2025 16:06:11 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 15 May 2025 16:06:11 +0000 (GMT)
Message-ID: <dc8f9cce170492c32fe12a7f50f0fdfe9d79e02c.camel@linux.ibm.com>
Subject: Re: [PATCH 36/50] ppc/xive2: split tctx presentation processing
 from set CPPR
From: Miles Glenn <milesg@linux.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, =?ISO-8859-1?Q?Fr=E9d=E9ric?= Barrat
 <fbarrat@linux.ibm.com>, Michael Kowal <kowal@linux.ibm.com>, Caleb
 Schlossin <calebs@linux.vnet.ibm.com>
Date: Thu, 15 May 2025 11:06:10 -0500
In-Reply-To: <20250512031100.439842-37-npiggin@gmail.com>
References: <20250512031100.439842-1-npiggin@gmail.com>
 <20250512031100.439842-37-npiggin@gmail.com>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Cf0I5Krl c=1 sm=1 tr=0 ts=68261114 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8
 a=0-WaI2_ozc3jpBna6GUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDE2MCBTYWx0ZWRfX9//viQm8NecL
 XzX6EQjgDFDdOkX61oq/BtqcY/Nb5W2ikLjHnIwbx6uBquPxO5tJH5Gx1IUpoq2PueQt+S1lMrO
 GyvyxZGVA0eCXJi2QqQiIyDZGrxctmeMAUyFrAwfcij6wuFpurlRYqcrELQLR1+8IRqsVAIM4Eo
 15HyUI3HF5bPTvedKPcJA/jLCbOvlDucvfnaM2am9OhrsGGY1i81r771Td+VoSIq1GIj4K42WCD
 j8Fz8Mu12TCYERvj35E+c1+JsLy2+Bf4w949LmM9eeK2rAhmB3ESntNwm0E0FZfZMBDvyOuba3l
 xpe2IXgkxfqIbEUVygH4vwitvWPH+18eOK1MIfcln4SaTHEVEixC6YoROOjC5x8nDh2M2Kqf6Bm
 RYf/cuAmsVc9G9mDo//xSi2QwqSFcaoaCrgJgOcTaKCzHHo/WVdk44B9Wq4Qw4dlfaImGoWY
X-Proofpoint-GUID: H8aVPl9yaKFCP4fF6SRQP7F5HcY8AkX6
X-Proofpoint-ORIG-GUID: 15GJdba679pitMYDAztekH7L-E3K9SDW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_07,2025-05-15_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0
 spamscore=0 malwarescore=0 lowpriorityscore=0 mlxlogscore=999
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
> The second part of the set CPPR operation is to process (or re-present)
> any pending interrupts after CPPR is adjusted.
> 
> Split this presentation processing out into a standalone function that
> can be used in other places.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  hw/intc/xive2.c | 137 +++++++++++++++++++++++++++---------------------
>  1 file changed, 76 insertions(+), 61 deletions(-)
> 
> diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
> index 8c8dab3aa2..aa06bfda77 100644
> --- a/hw/intc/xive2.c
> +++ b/hw/intc/xive2.c
> @@ -1098,66 +1098,19 @@ void xive2_tm_ack_os_el(XivePresenter *xptr, XiveTCTX *tctx,
>      xive2_tctx_accept_el(xptr, tctx, TM_QW1_OS, TM_QW1_OS);
>  }
>  
> -/* NOTE: CPPR only exists for TM_QW1_OS and TM_QW3_HV_PHYS */
> -static void xive2_tctx_set_cppr(XiveTCTX *tctx, uint8_t ring, uint8_t cppr)
> +/* Re-calculate and present pending interrupts */
> +static void xive2_tctx_process_pending(XiveTCTX *tctx, uint8_t sig_ring)
>  {
> -    uint8_t *sig_regs = &tctx->regs[ring];
> +    uint8_t *sig_regs = &tctx->regs[sig_ring];
>      Xive2Router *xrtr = XIVE2_ROUTER(tctx->xptr);
> -    uint8_t old_cppr, backlog_prio, first_group, group_level;
> +    uint8_t backlog_prio, first_group, group_level;
>      uint8_t pipr_min, lsmfb_min, ring_min;
> +    uint8_t cppr = sig_regs[TM_CPPR];
>      bool group_enabled;
> -    uint8_t nvp_blk;
> -    uint32_t nvp_idx;
>      Xive2Nvp nvp;
>      int rc;
> -    uint8_t nsr = sig_regs[TM_NSR];
> -
> -    g_assert(ring == TM_QW1_OS || ring == TM_QW3_HV_PHYS);
> -
> -    g_assert(tctx->regs[TM_QW2_HV_POOL + TM_NSR] == 0);
> -    g_assert(tctx->regs[TM_QW2_HV_POOL + TM_PIPR] == 0);
> -    g_assert(tctx->regs[TM_QW2_HV_POOL + TM_CPPR] == 0);
> -
> -    /* XXX: should show pool IPB for PHYS ring */
> -    trace_xive_tctx_set_cppr(tctx->cs->cpu_index, ring,
> -                             sig_regs[TM_IPB], sig_regs[TM_PIPR],
> -                             cppr, nsr);
> -
> -    if (cppr > XIVE_PRIORITY_MAX) {
> -        cppr = 0xff;
> -    }
> -
> -    old_cppr = sig_regs[TM_CPPR];
> -    sig_regs[TM_CPPR] = cppr;
> -
> -    /* Handle increased CPPR priority (lower value) */
> -    if (cppr < old_cppr) {
> -        if (cppr <= sig_regs[TM_PIPR]) {
> -            /* CPPR lowered below PIPR, must un-present interrupt */
> -            if (xive_nsr_indicates_exception(ring, nsr)) {
> -                if (xive_nsr_indicates_group_exception(ring, nsr)) {
> -                    /* redistribute precluded active grp interrupt */
> -                    xive2_redistribute(xrtr, tctx,
> -                                       xive_nsr_exception_ring(ring, nsr));
> -                    return;
> -                }
> -            }
>  
> -            /* interrupt is VP directed, pending in IPB */
> -            xive_tctx_pipr_set(tctx, ring, cppr, 0);
> -            return;
> -        } else {
> -            /* CPPR was lowered, but still above PIPR. No action needed. */
> -            return;
> -        }
> -    }
> -
> -    /* CPPR didn't change, nothing needs to be done */
> -    if (cppr == old_cppr) {
> -        return;
> -    }
> -
> -    /* CPPR priority decreased (higher value) */
> +    g_assert(sig_ring == TM_QW3_HV_PHYS || sig_ring == TM_QW1_OS);
>  
>      /*
>       * Recompute the PIPR based on local pending interrupts. It will
> @@ -1167,11 +1120,11 @@ again:
>      pipr_min = xive_ipb_to_pipr(sig_regs[TM_IPB]);
>      group_enabled = !!sig_regs[TM_LGS];
>      lsmfb_min = group_enabled ? sig_regs[TM_LSMFB] : 0xff;
> -    ring_min = ring;
> +    ring_min = sig_ring;
>      group_level = 0;
>  
>      /* PHYS updates also depend on POOL values */
> -    if (ring == TM_QW3_HV_PHYS) {
> +    if (sig_ring == TM_QW3_HV_PHYS) {
>          uint8_t *pool_regs = &tctx->regs[TM_QW2_HV_POOL];
>  
>          /* POOL values only matter if POOL ctx is valid */
> @@ -1201,20 +1154,25 @@ again:
>          }
>      }
>  
> -    rc = xive2_tctx_get_nvp_indexes(tctx, ring_min, &nvp_blk, &nvp_idx);
> -    if (rc) {
> -        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: set CPPR on invalid context\n");
> -        return;
> -    }
> -
>      if (group_enabled &&
>          lsmfb_min < cppr &&
>          lsmfb_min < pipr_min) {
> +
> +        uint8_t nvp_blk;
> +        uint32_t nvp_idx;
> +
>          /*
>           * Thread has seen a group interrupt with a higher priority
>           * than the new cppr or pending local interrupt. Check the
>           * backlog
>           */
> +        rc = xive2_tctx_get_nvp_indexes(tctx, ring_min, &nvp_blk, &nvp_idx);
> +        if (rc) {
> +            qemu_log_mask(LOG_GUEST_ERROR, "XIVE: set CPPR on invalid "
> +                                           "context\n");
> +            return;
> +        }
> +
>          if (xive2_router_get_nvp(xrtr, nvp_blk, nvp_idx, &nvp)) {
>              qemu_log_mask(LOG_GUEST_ERROR, "XIVE: No NVP %x/%x\n",
>                            nvp_blk, nvp_idx);
> @@ -1260,6 +1218,63 @@ again:
>      xive_tctx_pipr_set(tctx, ring_min, pipr_min, group_level);
>  }
>  
> +/* NOTE: CPPR only exists for TM_QW1_OS and TM_QW3_HV_PHYS */
> +static void xive2_tctx_set_cppr(XiveTCTX *tctx, uint8_t sig_ring, uint8_t cppr)
> +{
> +    uint8_t *sig_regs = &tctx->regs[sig_ring];
> +    Xive2Router *xrtr = XIVE2_ROUTER(tctx->xptr);
> +    uint8_t old_cppr;
> +    uint8_t nsr = sig_regs[TM_NSR];
> +
> +    g_assert(sig_ring == TM_QW1_OS || sig_ring == TM_QW3_HV_PHYS);
> +
> +    g_assert(tctx->regs[TM_QW2_HV_POOL + TM_NSR] == 0);
> +    g_assert(tctx->regs[TM_QW2_HV_POOL + TM_PIPR] == 0);
> +    g_assert(tctx->regs[TM_QW2_HV_POOL + TM_CPPR] == 0);
> +
> +    /* XXX: should show pool IPB for PHYS ring */
> +    trace_xive_tctx_set_cppr(tctx->cs->cpu_index, sig_ring,
> +                             sig_regs[TM_IPB], sig_regs[TM_PIPR],
> +                             cppr, nsr);
> +
> +    if (cppr > XIVE_PRIORITY_MAX) {
> +        cppr = 0xff;
> +    }
> +
> +    old_cppr = sig_regs[TM_CPPR];
> +    sig_regs[TM_CPPR] = cppr;
> +
> +    /* Handle increased CPPR priority (lower value) */
> +    if (cppr < old_cppr) {
> +        if (cppr <= sig_regs[TM_PIPR]) {
> +            /* CPPR lowered below PIPR, must un-present interrupt */
> +            if (xive_nsr_indicates_exception(sig_ring, nsr)) {
> +                if (xive_nsr_indicates_group_exception(sig_ring, nsr)) {
> +                    /* redistribute precluded active grp interrupt */
> +                    xive2_redistribute(xrtr, tctx,
> +                                       xive_nsr_exception_ring(sig_ring, nsr));
> +                    return;
> +                }
> +            }
> +
> +            /* interrupt is VP directed, pending in IPB */
> +            xive_tctx_pipr_set(tctx, sig_ring, cppr, 0);
> +            return;
> +        } else {
> +            /* CPPR was lowered, but still above PIPR. No action needed. */
> +            return;
> +        }
> +    }
> +
> +    /* CPPR didn't change, nothing needs to be done */
> +    if (cppr == old_cppr) {
> +        return;
> +    }
> +
> +    /* CPPR priority decreased (higher value) */
> +    xive2_tctx_process_pending(tctx, sig_ring);
> +}
> +
>  void xive2_tm_set_hv_cppr(XivePresenter *xptr, XiveTCTX *tctx,
>                            hwaddr offset, uint64_t value, unsigned size)
>  {


