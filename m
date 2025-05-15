Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29238C3ABC9
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 16:07:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFb74-0003QO-OC; Thu, 15 May 2025 12:07:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1uFb6o-0002sC-OZ; Thu, 15 May 2025 12:07:03 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1uFb6k-0000Yl-Cy; Thu, 15 May 2025 12:06:57 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54FCgNgg012987;
 Thu, 15 May 2025 16:06:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=qMY4IakpUaMfP4qPUSGy8rO7m7aCIc5rEZk+diZuDNI=; b=NrUdxqbuhqOn
 QdrpWHlE5C37J45ONVQTq2xIDGiAVXX30ZmA38EFy2AteK830R/QBMsjv7C4giNH
 y/7sVu0vKgJGHaT24AuKtk8K0yxfZWDLQVqU3epG+L/L367jwobvUy1rTx9MT/vp
 gpKaC+uQSQUPzYxFcrIyiDlPNaLciLvw4bGKnelqqgiSAbZ/+njAQlND81hEAzUG
 S88wVQwpnPBjGfzxWxM3rHywfDdFlsW/CrxezWSXvY2C9KDpEXt+vrr+DZo+Rhfu
 lLheLuMwt5oR8NhzPHaQ1CxjyzrHS3pYsrzMpD9WHMMp1qPi+MNOqpHSn3+DxTC2
 zZYAZ+DbJw==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46n0t9dnm3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 16:06:51 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54FG56kV016316;
 Thu, 15 May 2025 16:06:51 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46n0t9dnku-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 16:06:51 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54FE58uJ021459;
 Thu, 15 May 2025 16:06:50 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46mbfru43w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 16:06:49 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 54FG6mml27853408
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 15 May 2025 16:06:48 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 438F258059;
 Thu, 15 May 2025 16:06:48 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A63D95805B;
 Thu, 15 May 2025 16:06:47 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 15 May 2025 16:06:47 +0000 (GMT)
Message-ID: <0c1a42c2ca977503d609bd37370ed8f9e7a681c6.camel@linux.ibm.com>
Subject: Re: [PATCH 37/50] ppc/xive2: Consolidate presentation processing in
 context push
From: Miles Glenn <milesg@linux.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, =?ISO-8859-1?Q?Fr=E9d=E9ric?= Barrat
 <fbarrat@linux.ibm.com>, Michael Kowal <kowal@linux.ibm.com>, Caleb
 Schlossin <calebs@linux.vnet.ibm.com>
Date: Thu, 15 May 2025 11:06:47 -0500
In-Reply-To: <20250512031100.439842-38-npiggin@gmail.com>
References: <20250512031100.439842-1-npiggin@gmail.com>
 <20250512031100.439842-38-npiggin@gmail.com>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=etzfzppX c=1 sm=1 tr=0 ts=6826111b cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8
 a=EdTen3BgkxFFPdHXyDcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDE2MCBTYWx0ZWRfXxfYwgR4fhzSV
 1EMy7L2633i3jY9ni3XcNM5socVMQl18ghQ/iwjV8afEdizXRnMvCGljPsrl2GzmsG/44+a+0GT
 MGCI6WqZimghIAtVCDkdH4BusoT8kBDpOLPz6NfI/DwkCDn7bw6bz6h3eYSvA5RoEvDdCVyfKst
 TLdYKJ48sLxazN++YDVzoMKw3F7zYRAQR8cT+FTXgxFUjNUN0EQmiZo6V5yNOjF5RYs7MehRcVU
 ZXM8C476xZ2IbpvPPOzENYwWVAYG/hvmXCpS1uvKdQfwn65yOBa2DUFCIsvgKUfVy7mCvMeemqW
 7WtUXs5hZL224GGOim+BaG9RL461Mq7OL0UFBtf1EyYyQrrPbN+9lMa++ecYQivEBZB7HCbtW0F
 iIW3MD3g+fczDCqSkdXoUbrtrXK6PH/Gy7KM2bgZ5xnOvrIEdCFL/SZK3QetakH3jVvD9AD/
X-Proofpoint-ORIG-GUID: Nvmq66bFCWDJKzzGcjqSUhsrV2xLo9Qh
X-Proofpoint-GUID: 1PSeSxq6oHurf8xi4ZsB29Xb6OkEjPte
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_07,2025-05-15_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 lowpriorityscore=0 phishscore=0 mlxscore=0 mlxlogscore=956 bulkscore=0
 suspectscore=0 spamscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
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
> OS-push operation must re-present pending interrupts. Use the
> newly created xive2_tctx_process_pending() function instead of
> duplicating the logic.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  hw/intc/xive2.c | 42 ++++++++++--------------------------------
>  1 file changed, 10 insertions(+), 32 deletions(-)
> 
> diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
> index aa06bfda77..0fdf6a4f20 100644
> --- a/hw/intc/xive2.c
> +++ b/hw/intc/xive2.c
> @@ -903,18 +903,14 @@ static uint8_t xive2_tctx_restore_os_ctx(Xive2Router *xrtr, XiveTCTX *tctx,
>      return cppr;
>  }
>  
> +static void xive2_tctx_process_pending(XiveTCTX *tctx, uint8_t sig_ring);
> +
>  static void xive2_tctx_need_resend(Xive2Router *xrtr, XiveTCTX *tctx,
>                                     uint8_t nvp_blk, uint32_t nvp_idx,
>                                     bool do_restore)
>  {
> -    XivePresenter *xptr = XIVE_PRESENTER(xrtr);
> -    uint8_t ipb;
> -    uint8_t backlog_level;
> -    uint8_t group_level;
> -    uint8_t first_group;
> -    uint8_t backlog_prio;
> -    uint8_t group_prio;
>      uint8_t *regs = &tctx->regs[TM_QW1_OS];
> +    uint8_t ipb;
>      Xive2Nvp nvp;
>  
>      /*
> @@ -946,30 +942,8 @@ static void xive2_tctx_need_resend(Xive2Router *xrtr, XiveTCTX *tctx,
>      }
>      /* IPB bits in the backlog are merged with the TIMA IPB bits */
>      regs[TM_IPB] |= ipb;
> -    backlog_prio = xive_ipb_to_pipr(regs[TM_IPB]);
> -    backlog_level = 0;
> -
> -    first_group = xive_get_field32(NVP2_W0_PGOFIRST, nvp.w0);
> -    if (first_group && regs[TM_LSMFB] < backlog_prio) {
> -        group_prio = xive2_presenter_backlog_scan(xptr, nvp_blk, nvp_idx,
> -                                                  first_group, &group_level);
> -        regs[TM_LSMFB] = group_prio;
> -        if (regs[TM_LGS] && group_prio < backlog_prio &&
> -            group_prio < regs[TM_CPPR]) {
> -
> -            /* VP can take a group interrupt */
> -            xive2_presenter_backlog_decr(xptr, nvp_blk, nvp_idx,
> -                                         group_prio, group_level);
> -            backlog_prio = group_prio;
> -            backlog_level = group_level;
> -        }
> -    }
>  
> -    /*
> -     * Set the PIPR/NSR based on the restored state.
> -     * It will raise the External interrupt signal if needed.
> -     */
> -    xive_tctx_pipr_set(tctx, TM_QW1_OS, backlog_prio, backlog_level);
> +    xive2_tctx_process_pending(tctx, TM_QW1_OS);
>  }
>  
>  /*
> @@ -1103,8 +1077,12 @@ static void xive2_tctx_process_pending(XiveTCTX *tctx, uint8_t sig_ring)
>  {
>      uint8_t *sig_regs = &tctx->regs[sig_ring];
>      Xive2Router *xrtr = XIVE2_ROUTER(tctx->xptr);
> -    uint8_t backlog_prio, first_group, group_level;
> -    uint8_t pipr_min, lsmfb_min, ring_min;
> +    uint8_t backlog_prio;
> +    uint8_t first_group;
> +    uint8_t group_level;
> +    uint8_t pipr_min;
> +    uint8_t lsmfb_min;
> +    uint8_t ring_min;
>      uint8_t cppr = sig_regs[TM_CPPR];
>      bool group_enabled;
>      Xive2Nvp nvp;


