Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FA3AC2D0CD
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 16:09:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFb8X-0005x3-7N; Thu, 15 May 2025 12:08:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1uFb8F-0005qq-UI; Thu, 15 May 2025 12:08:29 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1uFb8E-0000gy-3y; Thu, 15 May 2025 12:08:27 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54FCgB9e004840;
 Thu, 15 May 2025 16:08:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=ezdn3EAa7Vfpw/WuA5ViZBwVIpdUUqvE9kYSQoj+fCI=; b=ZxM+Addn/gMa
 2z8X13wOuYCn2zXEv4WJG00FPqXmsUnMywGTgHTjFZ4xCVLiai2AHSrgELgUVHsO
 ppyo1d87XuNK795LYDk5TC1MAK3Raja/wAMPCCPvc+AdrkU6xOcLHJZNy2eWevf6
 J4AGvH9WjrwANeQqCDtXzzJaQBx7vFM3tJLHGhsGYXbkn5SBCFqFkj6xurL/+MmE
 W1T3yVAalcGC8EeDCf28eBTRf1jdiprxnpnJMdio8PTxJL+I/05EV1+m5HnCOKdz
 BXVs48ynGiWKxIxcb2g5nPDVwTuK7Y7jBcBh5czBGuvUv7VSVbEeBOumErJW6TX5
 NCl3CLmWrg==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46ndfjt6ap-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 16:08:23 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54FG4hxf004352;
 Thu, 15 May 2025 16:08:23 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46ndfjt6am-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 16:08:22 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54FE0HZv019386;
 Thu, 15 May 2025 16:08:22 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 46mbfru57b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 16:08:22 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 54FG8KBx35062366
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 15 May 2025 16:08:20 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4905A58052;
 Thu, 15 May 2025 16:08:20 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EA3935805A;
 Thu, 15 May 2025 16:08:19 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 15 May 2025 16:08:19 +0000 (GMT)
Message-ID: <a89cb820a8a7b180e10d081fddf1c5b424adb34e.camel@linux.ibm.com>
Subject: Re: [PATCH 39/50] ppc/xive: Assert group interrupts were redistributed
From: Miles Glenn <milesg@linux.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, =?ISO-8859-1?Q?Fr=E9d=E9ric?= Barrat
 <fbarrat@linux.ibm.com>, Michael Kowal <kowal@linux.ibm.com>, Caleb
 Schlossin <calebs@linux.vnet.ibm.com>
Date: Thu, 15 May 2025 11:08:19 -0500
In-Reply-To: <20250512031100.439842-40-npiggin@gmail.com>
References: <20250512031100.439842-1-npiggin@gmail.com>
 <20250512031100.439842-40-npiggin@gmail.com>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: fBzynl2I99LbkK4CnQVooFbYQpKgxRKE
X-Authority-Analysis: v=2.4 cv=ecg9f6EH c=1 sm=1 tr=0 ts=68261177 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8
 a=x6Irf60CIn5f3FMP8mkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: WOo1s_y-suvNkwbzfbGRR4fj5Tkyvo9b
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDE2MCBTYWx0ZWRfX0ybQ2tOz4Yz7
 bw6Lk8oZwtYojvtzDSamnu1IXaBpaWByASBe4JfWQrrUsIfpOHDkAOThVxmjB4ww+F98SGUJR1U
 7SFTbfxdI8NHt3fRH1EzCYWCrqgDqF+Rzdj2HMyDHKo2LBSa8U8oSloQMVs01iI8zHe4O78VQPr
 o1EJUvh5Gqi5aWPi6ZiDWXtvHSXzUzMxfRAWA5WdG+TkvmPQjl4vRcHTVV61ubMxA3r/sLyupEk
 kvwhinHjpnd1xh3bP4/tRC1YpMGf+LsrUwjA6kgCIcjvZmlMZg3d+6BixKAERiEPmP2LZ30VjW+
 WB9zcKcLLp2AwDL0/6LkwudkE1EalmFq0GbX6eivY30BJYfhuXo95tgBNiI9tNrDA3bydfnIryv
 OCo0qexETEWjduGCAEzophfmYVjQR+A31BBLxes6QedmmIuAWay3lhUJNUx4Y1ySvRAKrWDv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_07,2025-05-15_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=442
 impostorscore=0 spamscore=0 clxscore=1015 malwarescore=0 mlxscore=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 suspectscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
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
> Add some assertions to try to ensure presented group interrupts do
> not get lost without being redistributed, if they become precluded
> by CPPR or preempted by a higher priority interrupt.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  hw/intc/xive.c  | 2 ++
>  hw/intc/xive2.c | 1 +
>  2 files changed, 3 insertions(+)
> 
> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> index 4659821d4a..81af59f0ec 100644
> --- a/hw/intc/xive.c
> +++ b/hw/intc/xive.c
> @@ -132,6 +132,8 @@ void xive_tctx_pipr_set(XiveTCTX *tctx, uint8_t ring, uint8_t pipr,
>      uint8_t *sig_regs = xive_tctx_signal_regs(tctx, ring);
>      uint8_t *regs = &tctx->regs[ring];
>  
> +    g_assert(!xive_nsr_indicates_group_exception(ring, sig_regs[TM_NSR]));
> +
>      sig_regs[TM_PIPR] = pipr;
>  
>      if (pipr < sig_regs[TM_CPPR]) {
> diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
> index ace5871706..e3060810d3 100644
> --- a/hw/intc/xive2.c
> +++ b/hw/intc/xive2.c
> @@ -1089,6 +1089,7 @@ static void xive2_tctx_process_pending(XiveTCTX *tctx, uint8_t sig_ring)
>      int rc;
>  
>      g_assert(sig_ring == TM_QW3_HV_PHYS || sig_ring == TM_QW1_OS);
> +    g_assert(!xive_nsr_indicates_group_exception(sig_ring, sig_regs[TM_NSR]));
>  
>      /*
>       * Recompute the PIPR based on local pending interrupts. It will


