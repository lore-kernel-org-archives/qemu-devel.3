Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF0F1C3ABC9
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 15:19:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFaMN-0003my-AA; Thu, 15 May 2025 11:18:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1uFaMG-0003jB-Rd; Thu, 15 May 2025 11:18:52 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1uFaM9-00025M-Vq; Thu, 15 May 2025 11:18:52 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54FCg5u0002225;
 Thu, 15 May 2025 15:18:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=qYvesg
 uMG7+kWm4IQafvR/h0vqx+MIA2Wsyobc2BzGE=; b=PGWkpli9CxbBiWdUiCUzIF
 Qj6S1J+kTN+p49rQkpKN6gdMzeBJiaYuog2+kIWN8YaLv+vZipQL9NIozkXrm6TS
 ADGblZcccNH4LsU/ZMQF8dSPjdQriPvG1KTvY0wL2sqD0ywecWgAb6OoWKpryKkZ
 YKbConrkb2XpkOSEKefcisbpFThuUHl4jdvErClhsU2tXQorFvQeVNVogC74hMAa
 s+LJ6wqJO7c2HDpa4iwT5GLK20cUmsdXKtBSS9k2nSMdCyCp6f3k96oCDBk7dmEQ
 Ia/G6p9JqzxD61XwOIn5M/1ZHzo3PJthdeE5GDhUzLKlJ//6GOV565idWuQLAhUQ
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46n0v6n86t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 15:18:43 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54FFIhc6017323;
 Thu, 15 May 2025 15:18:43 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46n0v6n86p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 15:18:43 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54FE894V021439;
 Thu, 15 May 2025 15:18:42 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46mbfrtv7t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 15:18:42 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 54FFIfgH32703172
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 15 May 2025 15:18:41 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4A06D58064;
 Thu, 15 May 2025 15:18:41 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E6CB05805D;
 Thu, 15 May 2025 15:18:40 +0000 (GMT)
Received: from [9.10.80.143] (unknown [9.10.80.143])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 15 May 2025 15:18:40 +0000 (GMT)
Message-ID: <f49eb177-a9cb-4692-80ce-1946e640531f@linux.ibm.com>
Date: Thu, 15 May 2025 10:18:39 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 35/50] ppc/xive: Add xive_tctx_pipr_set() helper function
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?=
 <fbarrat@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Caleb Schlossin <calebs@linux.vnet.ibm.com>
References: <20250512031100.439842-1-npiggin@gmail.com>
 <20250512031100.439842-36-npiggin@gmail.com>
Content-Language: en-US
From: Mike Kowal <kowal@linux.ibm.com>
In-Reply-To: <20250512031100.439842-36-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=IqAecK/g c=1 sm=1 tr=0 ts=682605d3 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8
 a=vk7rrif49dpEDathr6wA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: nzJXeygLUQNGG-8g1-1cauSTdFraJzl_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDE1MCBTYWx0ZWRfX6X1A1oQugtx8
 /XxjbM0BgLEmIxl0kfsGthjiDM9kA8SnpwudA/dOpqYLIxtjpvzwfi9d5vuZuhoJlp3Zmu2wR8W
 WozXGLsr64DCDH+UxesuRe4oyJZIv7LEQrrZR2qjPQP3ry4YCsAZ+JQ04/LdYki5Er1dE3taG+R
 BVp+EwGz7a0AGAfdllsouDgAuQNcy0GzwUqWHDJFBNSBc0ZIWBBDWZETmWvonKJtbSvtFREpS94
 B57tvzSN4zh/XQgy+hwrLcnBmH+T/iO818QxY2vb4FAeP3J1aH/Ghqs/B8K3mVyHRzhfNkMmNA+
 BSQ17hMUF/6dbNGyuipYBYCQOs3QSHnvRPK4SeNlDcACCmQydvEeQsRK4BkqhoCiPzUKWH9FGDM
 wSUHYSOLxTep58fKqQtOLUZHfaOMgDN1jHCGwR/+cMXI8o1zfssm96SAfSgqTZwLAH0DZN9v
X-Proofpoint-GUID: cwkM9Q4DBgaTgkVXbBtwYh2LZOXAOG9w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_06,2025-05-15_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 malwarescore=0
 adultscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0
 priorityscore=1501 clxscore=1015 spamscore=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505150150
Received-SPF: pass client-ip=148.163.158.5; envelope-from=kowal@linux.ibm.com;
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


On 5/11/2025 10:10 PM, Nicholas Piggin wrote:
> Have xive_tctx_notify() also set the new PIPR value and rename it to
> xive_tctx_pipr_set(). This can replace the last xive_tctx_pipr_update()
> caller because it does not need to update IPB (it already sets it).

Reviewed-by: Michael Kowal<kowal@linux.ibm.com>

Thanks,  MAK


>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   hw/intc/xive.c        | 39 +++++++++++----------------------------
>   hw/intc/xive2.c       | 16 +++++++---------
>   include/hw/ppc/xive.h |  5 ++---
>   3 files changed, 20 insertions(+), 40 deletions(-)
>
> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> index d5dbeab6bd..4659821d4a 100644
> --- a/hw/intc/xive.c
> +++ b/hw/intc/xive.c
> @@ -125,12 +125,16 @@ uint64_t xive_tctx_accept(XiveTCTX *tctx, uint8_t sig_ring)
>       return ((uint64_t)nsr << 8) | sig_regs[TM_CPPR];
>   }
>   
> -void xive_tctx_notify(XiveTCTX *tctx, uint8_t ring, uint8_t group_level)
> +/* Change PIPR and calculate NSR and irq based on PIPR, CPPR, group */
> +void xive_tctx_pipr_set(XiveTCTX *tctx, uint8_t ring, uint8_t pipr,
> +                        uint8_t group_level)
>   {
>       uint8_t *sig_regs = xive_tctx_signal_regs(tctx, ring);
>       uint8_t *regs = &tctx->regs[ring];
>   
> -    if (sig_regs[TM_PIPR] < sig_regs[TM_CPPR]) {
> +    sig_regs[TM_PIPR] = pipr;
> +
> +    if (pipr < sig_regs[TM_CPPR]) {
>           switch (ring) {
>           case TM_QW1_OS:
>               sig_regs[TM_NSR] = TM_QW1_NSR_EO | (group_level & 0x3F);
> @@ -145,7 +149,7 @@ void xive_tctx_notify(XiveTCTX *tctx, uint8_t ring, uint8_t group_level)
>               g_assert_not_reached();
>           }
>           trace_xive_tctx_notify(tctx->cs->cpu_index, ring,
> -                               regs[TM_IPB], sig_regs[TM_PIPR],
> +                               regs[TM_IPB], pipr,
>                                  sig_regs[TM_CPPR], sig_regs[TM_NSR]);
>           qemu_irq_raise(xive_tctx_output(tctx, ring));
>       } else {
> @@ -213,29 +217,10 @@ static void xive_tctx_set_cppr(XiveTCTX *tctx, uint8_t ring, uint8_t cppr)
>           }
>       }
>   
> -    sig_regs[TM_PIPR] = pipr_min;
> -
> -    /* CPPR has changed, check if we need to raise a pending exception */
> -    xive_tctx_notify(tctx, ring_min, 0);
> +    /* CPPR has changed, this may present or preclude a pending exception */
> +    xive_tctx_pipr_set(tctx, ring_min, pipr_min, 0);
>   }
>   
> -void xive_tctx_pipr_update(XiveTCTX *tctx, uint8_t ring, uint8_t priority,
> -                           uint8_t group_level)
> -{
> -    uint8_t *sig_regs = xive_tctx_signal_regs(tctx, ring);
> -    uint8_t *regs = &tctx->regs[ring];
> -
> -    if (group_level == 0) {
> -        /* VP-specific */
> -        regs[TM_IPB] |= xive_priority_to_ipb(priority);
> -        sig_regs[TM_PIPR] = xive_ipb_to_pipr(regs[TM_IPB]);
> -    } else {
> -        /* VP-group */
> -        sig_regs[TM_PIPR] = xive_priority_to_pipr(priority);
> -    }
> -    xive_tctx_notify(tctx, ring, group_level);
> - }
> -
>   static void xive_tctx_pipr_recompute_from_ipb(XiveTCTX *tctx, uint8_t ring)
>   {
>       uint8_t *sig_regs = xive_tctx_signal_regs(tctx, ring);
> @@ -244,8 +229,7 @@ static void xive_tctx_pipr_recompute_from_ipb(XiveTCTX *tctx, uint8_t ring)
>       /* Does not support a presented group interrupt */
>       g_assert(!xive_nsr_indicates_group_exception(ring, sig_regs[TM_NSR]));
>   
> -    sig_regs[TM_PIPR] = xive_ipb_to_pipr(regs[TM_IPB]);
> -    xive_tctx_notify(tctx, ring, 0);
> +    xive_tctx_pipr_set(tctx, ring, xive_ipb_to_pipr(regs[TM_IPB]), 0);
>   }
>   
>   void xive_tctx_pipr_present(XiveTCTX *tctx, uint8_t ring, uint8_t priority,
> @@ -264,8 +248,7 @@ void xive_tctx_pipr_present(XiveTCTX *tctx, uint8_t ring, uint8_t priority,
>       }
>       g_assert(pipr <= xive_ipb_to_pipr(regs[TM_IPB]));
>       g_assert(pipr < sig_regs[TM_PIPR]);
> -    sig_regs[TM_PIPR] = pipr;
> -    xive_tctx_notify(tctx, ring, group_level);
> +    xive_tctx_pipr_set(tctx, ring, pipr, group_level);
>   }
>   
>   /*
> diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
> index b9ee8c9e9f..8c8dab3aa2 100644
> --- a/hw/intc/xive2.c
> +++ b/hw/intc/xive2.c
> @@ -966,10 +966,10 @@ static void xive2_tctx_need_resend(Xive2Router *xrtr, XiveTCTX *tctx,
>       }
>   
>       /*
> -     * Compute the PIPR based on the restored state.
> +     * Set the PIPR/NSR based on the restored state.
>        * It will raise the External interrupt signal if needed.
>        */
> -    xive_tctx_pipr_update(tctx, TM_QW1_OS, backlog_prio, backlog_level);
> +    xive_tctx_pipr_set(tctx, TM_QW1_OS, backlog_prio, backlog_level);
>   }
>   
>   /*
> @@ -1144,8 +1144,7 @@ static void xive2_tctx_set_cppr(XiveTCTX *tctx, uint8_t ring, uint8_t cppr)
>               }
>   
>               /* interrupt is VP directed, pending in IPB */
> -            sig_regs[TM_PIPR] = cppr;
> -            xive_tctx_notify(tctx, ring, 0); /* Ensure interrupt is cleared */
> +            xive_tctx_pipr_set(tctx, ring, cppr, 0);
>               return;
>           } else {
>               /* CPPR was lowered, but still above PIPR. No action needed. */
> @@ -1255,11 +1254,10 @@ again:
>           pipr_min = backlog_prio;
>       }
>   
> -    /* PIPR should not be set to a value greater than CPPR */
> -    sig_regs[TM_PIPR] = (pipr_min > cppr) ? cppr : pipr_min;
> -
> -    /* CPPR has changed, check if we need to raise a pending exception */
> -    xive_tctx_notify(tctx, ring_min, group_level);
> +    if (pipr_min > cppr) {
> +        pipr_min = cppr;
> +    }
> +    xive_tctx_pipr_set(tctx, ring_min, pipr_min, group_level);
>   }
>   
>   void xive2_tm_set_hv_cppr(XivePresenter *xptr, XiveTCTX *tctx,
> diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
> index a3c2f50ece..2372d1014b 100644
> --- a/include/hw/ppc/xive.h
> +++ b/include/hw/ppc/xive.h
> @@ -584,12 +584,11 @@ void xive_tctx_pic_print_info(XiveTCTX *tctx, GString *buf);
>   Object *xive_tctx_create(Object *cpu, XivePresenter *xptr, Error **errp);
>   void xive_tctx_reset(XiveTCTX *tctx);
>   void xive_tctx_destroy(XiveTCTX *tctx);
> -void xive_tctx_pipr_update(XiveTCTX *tctx, uint8_t ring, uint8_t priority,
> -                           uint8_t group_level);
> +void xive_tctx_pipr_set(XiveTCTX *tctx, uint8_t ring, uint8_t priority,
> +                        uint8_t group_level);
>   void xive_tctx_pipr_present(XiveTCTX *tctx, uint8_t ring, uint8_t priority,
>                               uint8_t group_level);
>   void xive_tctx_reset_signal(XiveTCTX *tctx, uint8_t ring);
> -void xive_tctx_notify(XiveTCTX *tctx, uint8_t ring, uint8_t group_level);
>   uint64_t xive_tctx_accept(XiveTCTX *tctx, uint8_t ring);
>   
>   /*

