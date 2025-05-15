Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1919C2D0CD
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 15:37:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFadp-0005mL-0Z; Thu, 15 May 2025 11:37:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1uFadc-0005dm-Id; Thu, 15 May 2025 11:36:50 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1uFadW-00057k-Vx; Thu, 15 May 2025 11:36:47 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54FDnLPe000571;
 Thu, 15 May 2025 15:36:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=771dyR/1g4vzI4eJY/RT5s4sBtUKGB+h+C8k9DwgxtM=; b=NvsCbVEShIWg
 LmYKykwX1J+PEBy9rCxr1jYcFW/WR0+5ojFly6JQa1PWHbgXDAJWjFdW28VU46qZ
 4XSfOte5y5pKjXzb2p3chjvJVIuDwBQz2idJpBWb54911zPC6Aianl6yOVnVDjZE
 LzAT3dc+tJTTR0BBLHjJCSNH3QLcPFgkviv+4jcvpUdH8039jUwqerP5ubsKD5LP
 9yk8zMaaKWmVCbMT4Ts5CcvKS01pbVizo97zMZRfs0umV/5GYIc82ZeSeGKNo8WL
 EmluVTqeBXzXSsLab38po49TOB9uhfywL6McuwDP1lsNfBHOFjPxV8IfGBc78AMa
 Thw+59yNkQ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46nhg30m4w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 15:36:40 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54FF9CDA023119;
 Thu, 15 May 2025 15:36:40 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46nhg30m4t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 15:36:39 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54FDufKl015330;
 Thu, 15 May 2025 15:36:39 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 46mbfq2ybu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 15:36:39 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 54FFabv112255884
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 15 May 2025 15:36:37 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6D9DF58057;
 Thu, 15 May 2025 15:36:37 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 15C2458059;
 Thu, 15 May 2025 15:36:37 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 15 May 2025 15:36:36 +0000 (GMT)
Message-ID: <1bd9b416da0add987ba42f2392baa3cfcabab531.camel@linux.ibm.com>
Subject: Re: [PATCH 05/50] ppc/xive2: fix context push calculation of IPB
 priority
From: Miles Glenn <milesg@linux.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, =?ISO-8859-1?Q?Fr=E9d=E9ric?= Barrat
 <fbarrat@linux.ibm.com>, Michael Kowal <kowal@linux.ibm.com>, Caleb
 Schlossin <calebs@linux.vnet.ibm.com>
Date: Thu, 15 May 2025 10:36:36 -0500
In-Reply-To: <20250512031100.439842-6-npiggin@gmail.com>
References: <20250512031100.439842-1-npiggin@gmail.com>
 <20250512031100.439842-6-npiggin@gmail.com>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Cf0I5Krl c=1 sm=1 tr=0 ts=68260a08 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8
 a=yJ9lfIZagGyyCFpBJUMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDE1NSBTYWx0ZWRfX0/Mb2k7DuIB3
 ENr5ps59a/YzaobzZ6zr9e2SMfjK3wge+bWWWR2WwvmlRzViJ4vhjcbejCKA7D56k5ZOOMFfXbY
 d2Ucfti/r+qdg5H4kUabTxbP/eu3i5pSdgQa1OoNS0WZNwZ5OoFGRGgK52cc4w8//NP6Fm0sYex
 4zNkGR1gm3A+IcUXhE/yvl3bp3Tf1sEBKySb1r/Ekw4JEU1ktDAyJmtpUYbuglMtpgnihIUJOeh
 7fjdiRBQec9RqBBIDvorjZ3BFdGlA8tVz7pT8C9c01MuqbKRn+Y0K5pFFNMvPE5bTV6P4ElQk5Q
 FU4tTmhhCETgAt3mpncNRfJexmh02nzOJmihsiOrGMDujNH52K48wzEYHrO4I6JAmRi1wEY8EAm
 ICEYM30wDa9iRy62U9Ivy6PAdq0y+U83LYZd8EB56VgFqwIMPwWSfGBVHjdmCWM93rpTn6o7
X-Proofpoint-GUID: OcmW0olUy5ZAxl9yfNLFfMXCXu4AUMGl
X-Proofpoint-ORIG-GUID: vue8GoGUqWW72hamdtEve9agdHayHxNC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_06,2025-05-15_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0
 spamscore=0 malwarescore=0 lowpriorityscore=0 mlxlogscore=752
 impostorscore=0 phishscore=0 priorityscore=1501 mlxscore=0 bulkscore=0
 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
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
> Pushing a context and loading IPB from NVP is defined to merge ('or')
> that IPB into the TIMA IPB register. PIPR should therefore be calculated
> based on the final IPB value, not just the NVP value.
> 
> Fixes: 9d2b6058c5b ("ppc/xive2: Add grouping level to notification")
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  hw/intc/xive2.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
> index 790152a2a6..4dd04a0398 100644
> --- a/hw/intc/xive2.c
> +++ b/hw/intc/xive2.c
> @@ -835,8 +835,9 @@ static void xive2_tctx_need_resend(Xive2Router *xrtr, XiveTCTX *tctx,
>          nvp.w2 = xive_set_field32(NVP2_W2_IPB, nvp.w2, 0);
>          xive2_router_write_nvp(xrtr, nvp_blk, nvp_idx, &nvp, 2);
>      }
> +    /* IPB bits in the backlog are merged with the TIMA IPB bits */
>      regs[TM_IPB] |= ipb;
> -    backlog_prio = xive_ipb_to_pipr(ipb);
> +    backlog_prio = xive_ipb_to_pipr(regs[TM_IPB]);
>      backlog_level = 0;
>  
>      first_group = xive_get_field32(NVP2_W0_PGOFIRST, nvp.w0);


