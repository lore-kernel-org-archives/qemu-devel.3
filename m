Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76548C3ABC9
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 15:56:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFawN-0004zf-1G; Thu, 15 May 2025 11:56:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1uFawJ-0004jj-1R; Thu, 15 May 2025 11:56:07 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1uFawA-0007Ze-PU; Thu, 15 May 2025 11:56:01 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54FCg7mP016713;
 Thu, 15 May 2025 15:55:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=hcTrz+olk6JIcU24JtE2PXOMExy/beyGrQJl68A2jK8=; b=OZ+aMyIzbkoC
 Mfr7QG/ANsk1Arb/3wzI130ZaxHesSAvWYROUydvZ24/BPRIUxCT7ZFkexA9Ipxl
 yUpXUAbvN5/2/iuwPhtaumGkzjCqGibwu9mCPI6t0yIKpbto3h134/c33beegNrk
 Avinw1W/iATczDNzzI/7XxYCAeEQ10co5kRw1hds7hbVy7SQWJ+4GYlFyImCWoHk
 q3HdWHKuOZZfDwvA1E42+W839TXzj9J/brQYRCu8gbnobpz59kCv6CPv63JgsDnN
 Pz/7k4OIpDQstl3evllS4QiVQcyUR7oleRkTAgd4n/LpC/gYfQmSLAemiNY9TvWC
 SE+m4t4X+w==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46nd4gt8e1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 15:55:55 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54FFttJ3028209;
 Thu, 15 May 2025 15:55:55 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46nd4gt8dw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 15:55:55 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54FEDUUw015353;
 Thu, 15 May 2025 15:55:54 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 46mbfq31up-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 15:55:54 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 54FFtqEn27460274
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 15 May 2025 15:55:52 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 59EAA58056;
 Thu, 15 May 2025 15:55:52 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0BA395803F;
 Thu, 15 May 2025 15:55:52 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 15 May 2025 15:55:51 +0000 (GMT)
Message-ID: <9c7a76a72952ce19f326077c54c865e72e0bbe06.camel@linux.ibm.com>
Subject: Re: [PATCH 31/50] ppc/xive: Fix high prio group interrupt being
 preempted by low prio VP
From: Miles Glenn <milesg@linux.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, =?ISO-8859-1?Q?Fr=E9d=E9ric?= Barrat
 <fbarrat@linux.ibm.com>, Michael Kowal <kowal@linux.ibm.com>, Caleb
 Schlossin <calebs@linux.vnet.ibm.com>
Date: Thu, 15 May 2025 10:55:51 -0500
In-Reply-To: <20250512031100.439842-32-npiggin@gmail.com>
References: <20250512031100.439842-1-npiggin@gmail.com>
 <20250512031100.439842-32-npiggin@gmail.com>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: clCdyxuT007p0MHkOwbeULlMpbcZFpev
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDE1NSBTYWx0ZWRfXxT1qV0wSOurA
 syMRpVXamfDH6UtL7gNJxBAXh0Ab7tjfjt/6f+6DHdg918ho4IxxZUIJp3xMqWvuICUGTaa05MC
 FEpwDIM7iM4m5B4HKjMrIFH4HA95n5zvfbBgZp8UZXrMwxiuxr8SdTgArlBGzmubniCCndDzbi3
 m8hLNDUJq5lj2LEZ4cpqxIn0b/yB2KWdrMmmgmafZ+M6FYpZBd3ZRjwnqGjtMhS3fXcQNrbfKLl
 3a4ycXbMHMc2VW42/hIP7pdjqQJCTopZ4T3vmMKcfjEhT+fX9KlPP5KIJ67NqYFncmd7+2qeThs
 EhL0QsKY3O1/KFTBAyXNN5tSwKMYMDLxyNyDb7NmC0hbu89wbrGc7v7LKtzv7BkpZ1Fb4wLq8zU
 qPx51QkdbHDtkPpe5XbMC7y+athRUPNUhy3OsANzwlvuDuFPSVGl/6P2XaXEaHs8MBIZVHsP
X-Proofpoint-ORIG-GUID: h02dHfwycbpZEk-a2O04KUS7R4Kfv1Wl
X-Authority-Analysis: v=2.4 cv=OsNPyz/t c=1 sm=1 tr=0 ts=68260e8b cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8
 a=jbdF2D7wSZ7cY4eH8r0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_06,2025-05-15_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 suspectscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0 clxscore=1015
 impostorscore=0 mlxlogscore=546 mlxscore=0 adultscore=0 bulkscore=0
 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
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
> xive_tctx_pipr_present() as implemented with xive_tctx_pipr_update()
> causes VP-directed (group==0) interrupt to be presented in PIPR and NSR
> despite being a lower priority than the currently presented group
> interrupt.
> 
> This must not happen. The IPB bit should record the low priority VP
> interrupt, but PIPR and NSR must not present the lower priority
> interrupt.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  hw/intc/xive.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> index bf4c0634ca..25f6c69c44 100644
> --- a/hw/intc/xive.c
> +++ b/hw/intc/xive.c
> @@ -228,7 +228,23 @@ void xive_tctx_pipr_update(XiveTCTX *tctx, uint8_t ring, uint8_t priority,
>  void xive_tctx_pipr_present(XiveTCTX *tctx, uint8_t ring, uint8_t priority,
>                              uint8_t group_level)
>  {
> -    xive_tctx_pipr_update(tctx, ring, priority, group_level);
> +    /* HV_POOL ring uses HV_PHYS NSR, CPPR and PIPR registers */
> +    uint8_t alt_ring = (ring == TM_QW2_HV_POOL) ? TM_QW3_HV_PHYS : ring;
> +    uint8_t *aregs = &tctx->regs[alt_ring];
> +    uint8_t *regs = &tctx->regs[ring];
> +    uint8_t pipr = xive_priority_to_pipr(priority);
> +
> +    if (group_level == 0) {
> +        regs[TM_IPB] |= xive_priority_to_ipb(priority);
> +        if (pipr >= aregs[TM_PIPR]) {
> +            /* VP interrupts can come here with lower priority than PIPR */
> +            return;
> +        }
> +    }
> +    g_assert(pipr <= xive_ipb_to_pipr(regs[TM_IPB]));
> +    g_assert(pipr < aregs[TM_PIPR]);
> +    aregs[TM_PIPR] = pipr;
> +    xive_tctx_notify(tctx, ring, group_level);
>  }
>  
>  /*


