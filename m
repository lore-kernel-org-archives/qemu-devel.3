Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71D52C2D0CD
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 15:55:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFavB-00030H-5w; Thu, 15 May 2025 11:54:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1uFauw-0002nY-F4; Thu, 15 May 2025 11:54:49 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1uFaup-0007HN-FN; Thu, 15 May 2025 11:54:42 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54FCgNtG002849;
 Thu, 15 May 2025 15:54:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=k/VClevrbm+/QPF16ft1sLo7x4DLK9WnwsG/dJDyAfY=; b=CtPr71zZJQIn
 Un1kfStntmxYmOo2olHpIttwoFdhr+5Xupu8lovVPk+i+0JiTxz59KTLQiSS7Fww
 wLyr46tMtllITWz5ZCtVcj9HouVOXuvZkDKSscWDc6vKXYXezPiM516aKFbIi40N
 rSkaNRwi9i2vhHrOrPfs+i7l4qSnnrbHQLpnb/wwQk/Ont72Dmkuw/LWPxBEatyy
 PbXAWpcZqpuNcWBAxoOr7T4Es3pCj/Ky1SABNkBqkPmvt+VfdJUlWpViFQyuoxKI
 p/hiBv+7M9PIMIsBCYFZ9Yl3CeGDE+e3kFu0I4YChW+xSxyXANJqcvTE85P7CVey
 chNTrSsHBw==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46n0v6nf7p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 15:54:32 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54FFkI2W020784;
 Thu, 15 May 2025 15:54:31 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46n0v6nf7m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 15:54:31 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54FDtFLt021786;
 Thu, 15 May 2025 15:54:31 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46mbfpu2sr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 15:54:31 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 54FFsTAl23855422
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 15 May 2025 15:54:30 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A46285805D;
 Thu, 15 May 2025 15:54:29 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4CF9A58056;
 Thu, 15 May 2025 15:54:29 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 15 May 2025 15:54:29 +0000 (GMT)
Message-ID: <69beab9afd943d91b602c758a1bd24ec4e728e8e.camel@linux.ibm.com>
Subject: Re: [PATCH 29/50] ppc/xive2: Redistribute group interrupt preempted
 by higher priority interrupt
From: Miles Glenn <milesg@linux.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, =?ISO-8859-1?Q?Fr=E9d=E9ric?= Barrat
 <fbarrat@linux.ibm.com>, Michael Kowal <kowal@linux.ibm.com>, Caleb
 Schlossin <calebs@linux.vnet.ibm.com>
Date: Thu, 15 May 2025 10:54:28 -0500
In-Reply-To: <20250512031100.439842-30-npiggin@gmail.com>
References: <20250512031100.439842-1-npiggin@gmail.com>
 <20250512031100.439842-30-npiggin@gmail.com>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=IqAecK/g c=1 sm=1 tr=0 ts=68260e38 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8
 a=h6Ax321QG256VOZq6v8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: AUTC5O_6TFJYy2Oeb_0HuM_MUH_Z_sMD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDE1NSBTYWx0ZWRfX5PGM1/Q9iR8z
 KyyiUYEXFvwlPOkAqphfjSQ8ykz6yyUva33PukmaCJzyFbsxRhIt61OnAMTrH1RcAHxCYCMSDPQ
 oypXQRIdg0nLfU0PDjmEC+d4of9aHlNGhtEvbaCw6EQepGVc+zJcO6Pci4TO9zM+yKgbTuooF15
 5PACuXtTAa8B5+DKxdBsoSC/QOAgSPKtX4JTnscC8zqjzPdY8pESMWjdWYwEJbqMoMGz2e34iSA
 6mwZWE62fjRXFvTx9++DIKbikHYaZsx0UDHg1FUn0wmumBbpqhEqaYfw5YzrDnI0EPNBTPd1Zyt
 4BhGwDK0cbEK1oWRYtGxClbH2jqP/Y9yE7MU9X6bj/Y0f1PfCHPvIzb0ln7O7wgN5+d0/UlP2OZ
 tLo3tq15xrCnMsNR6XSr4UJS6+vbb89VcAmuIbhzQsdoxDyPzZSGDWlNeACw3kUxgljxltaf
X-Proofpoint-GUID: XC_88A09velTmSOLqzUPLGYwqBwaLvYo
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
> A group interrupt that gets preempted by a higher priority interrupt
> delivery must be redistributed otherwise it would get lost.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  hw/intc/xive2.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
> index 6e136ad2e2..cae4092198 100644
> --- a/hw/intc/xive2.c
> +++ b/hw/intc/xive2.c
> @@ -1638,11 +1638,21 @@ static void xive2_router_end_notify(Xive2Router *xrtr, uint8_t end_blk,
>                               crowd, cam_ignore, priority,
>                               xive_get_field32(END2_W7_F1_LOG_SERVER_ID, end.w7),
>                               &match)) {
> +        XiveTCTX *tctx = match.tctx;
> +        uint8_t ring = match.ring;
> +        uint8_t alt_ring = (ring == TM_QW2_HV_POOL) ? TM_QW3_HV_PHYS : ring;
> +        uint8_t *aregs = &tctx->regs[alt_ring];
> +        uint8_t nsr = aregs[TM_NSR];
>          uint8_t group_level;
>  
> +        if (priority < aregs[TM_PIPR] &&
> +            xive_nsr_indicates_group_exception(alt_ring, nsr)) {
> +            xive2_redistribute(xrtr, tctx, alt_ring);
> +        }
> +
>          group_level = xive_get_group_level(crowd, cam_ignore, nvx_blk, nvx_idx);
> -        trace_xive_presenter_notify(nvx_blk, nvx_idx, match.ring, group_level);
> -        xive_tctx_pipr_update(match.tctx, match.ring, priority, group_level);
> +        trace_xive_presenter_notify(nvx_blk, nvx_idx, ring, group_level);
> +        xive_tctx_pipr_update(tctx, ring, priority, group_level);
>          return;
>      }
>  


