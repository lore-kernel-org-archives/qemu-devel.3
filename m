Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBB77C2D0CD
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 16:17:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFbH6-0007dt-JH; Thu, 15 May 2025 12:17:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1uFbGp-0007a2-BP; Thu, 15 May 2025 12:17:25 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1uFbGm-0001q6-6I; Thu, 15 May 2025 12:17:19 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54FCg3Zx002075;
 Thu, 15 May 2025 16:17:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=13bxzULcAcKfB9LFx0HDpCT8S4BPCUAygbyjrvraHOY=; b=gh8XvT5buSC8
 /rJEdpEdcsp5AbuFHDol5Gve0bWRv2OPSibH3xbOSOA+xOk9tqFowH3h3SSWkM+2
 3QMcQszw8RSCZiQ/B24e8ZRlaphZ60RTX1dBqg0ypE7M8+j+vztzpthjXcWsGgkP
 KX6rJi/QdqTBjtKsdk9Qi9Gg8e+ixhTOgFJVUg/wfPpqZ5durRJpxJvYoQQOVvv3
 281hbSU7avviy78FmLwrGnXvsOSGoPAEl50dQJoeg2ILTG/TvKrV/WaNXex5Pfqu
 2hrAo01ZBUPG3FbyvJzmSe+o2i4gPia0Jijw5R17S04/iGilN6X73y3qCL4XVxek
 fTCd1f+8FA==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46n0v6nk63-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 16:17:12 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54FGEhfr020505;
 Thu, 15 May 2025 16:17:12 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46n0v6nk62-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 16:17:12 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54FDufWU015330;
 Thu, 15 May 2025 16:17:11 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 46mbfq354y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 16:17:11 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 54FGHARG31523344
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 15 May 2025 16:17:10 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 784EF58053;
 Thu, 15 May 2025 16:17:10 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DA51D58043;
 Thu, 15 May 2025 16:17:09 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 15 May 2025 16:17:09 +0000 (GMT)
Message-ID: <caea1fe979ec5925883fc4fdb505367835590c82.camel@linux.ibm.com>
Subject: Re: [PATCH 50/50] ppc/xive2: Enable lower level contexts on VP push
From: Miles Glenn <milesg@linux.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, =?ISO-8859-1?Q?Fr=E9d=E9ric?= Barrat
 <fbarrat@linux.ibm.com>, Michael Kowal <kowal@linux.ibm.com>, Caleb
 Schlossin <calebs@linux.vnet.ibm.com>
Date: Thu, 15 May 2025 11:17:09 -0500
In-Reply-To: <20250512031100.439842-51-npiggin@gmail.com>
References: <20250512031100.439842-1-npiggin@gmail.com>
 <20250512031100.439842-51-npiggin@gmail.com>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=IqAecK/g c=1 sm=1 tr=0 ts=68261388 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8
 a=z2KaQxLorgeo9JcVKagA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: ZMBZDkl-ehPzHFjpnsvTBVsXWipZvnNF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDE2MCBTYWx0ZWRfX973ewl4M2u1y
 Q5JsXtAcKE/njqIyicPS3zGBS+lTpaMnNE/K+3V0169Oc+x7R1KXRT4JVIhq306Li9cMvArC2EY
 vGMaEXNwLKCqVZFBJQEQYBlj4odb+EWYfKO2Z7gvJ1Y40K/5UAvNUPRyAHnOHKMyQls1TWshWFN
 3+Ivh32Z05dAykd9WuV9zEdELdg+Syk/xciUkIiR0vIflKB4s6R+b3uJIq9bwDX4DcXdJAzhiyN
 RMhRsBPmp7T2aE/tRre3Cs3JGOhU6iPfIQhiXZryv1dyqeNWrZei8CreC7oR5cuHyVoFt5w3cHP
 LDZQBCdlm85l7D0Ilr+uzOdqSRHzamOhjA3E8tJd3444e0eaI2rDqu3de19S2CrXnCs/tcljgFB
 fsG3rCBm7NyXa5esEsCNuIZhMxpnuiztFQr2/V6KSwvSteTFwfhWEXEd/m/z9oamfDSF9KnH
X-Proofpoint-GUID: E83uob2WaNsjur1HLduXn81prnZly2i6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_07,2025-05-15_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 malwarescore=0
 adultscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0
 priorityscore=1501 clxscore=1015 spamscore=0 mlxlogscore=793 bulkscore=0
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
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
> When pushing a context, the lower-level context becomes valid if it
> had V=1, and so on. Iterate lower level contexts and send them
> pending interrupts if they become enabled.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  hw/intc/xive2.c | 36 ++++++++++++++++++++++++++++--------
>  1 file changed, 28 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
> index 53e90b8178..ded003fa87 100644
> --- a/hw/intc/xive2.c
> +++ b/hw/intc/xive2.c
> @@ -995,6 +995,12 @@ static void xive2_tm_push_ctx(XivePresenter *xptr, XiveTCTX *tctx,
>      bool v;
>      bool do_restore;
>  
> +    if (xive_ring_valid(tctx, ring)) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: Attempt to push VP to enabled"
> +                                       " ring 0x%02x\n", ring);
> +        return;
> +    }
> +
>      /* First update the thead context */
>      switch (size) {
>      case 1:
> @@ -1021,19 +1027,32 @@ static void xive2_tm_push_ctx(XivePresenter *xptr, XiveTCTX *tctx,
>      /* Check the interrupt pending bits */
>      if (v) {
>          Xive2Router *xrtr = XIVE2_ROUTER(xptr);
> -        uint8_t *sig_regs = xive_tctx_signal_regs(tctx, ring);
> -        uint8_t nsr = sig_regs[TM_NSR];
> +        uint8_t cur_ring;
>  
>          xive2_tctx_restore_nvp(xrtr, tctx, ring,
>                                 nvp_blk, nvp_idx, do_restore);
>  
> -        if (xive_nsr_indicates_group_exception(ring, nsr)) {
> -            /* redistribute precluded active grp interrupt */
> -            g_assert(ring == TM_QW2_HV_POOL); /* PHYS ring has the interrupt */
> -            xive2_redistribute(xrtr, tctx, xive_nsr_exception_ring(ring, nsr));
> +        for (cur_ring = TM_QW1_OS; cur_ring <= ring;
> +             cur_ring += XIVE_TM_RING_SIZE) {
> +            uint8_t *sig_regs = xive_tctx_signal_regs(tctx, cur_ring);
> +            uint8_t nsr = sig_regs[TM_NSR];
> +
> +            if (!xive_ring_valid(tctx, cur_ring)) {
> +                continue;
> +            }
> +
> +            if (cur_ring == TM_QW2_HV_POOL) {
> +                if (xive_nsr_indicates_exception(cur_ring, nsr)) {
> +                    g_assert(xive_nsr_exception_ring(cur_ring, nsr) ==
> +                                                               TM_QW3_HV_PHYS);
> +                    xive2_redistribute(xrtr, tctx,
> +                                       xive_nsr_exception_ring(ring, nsr));
> +                }
> +                xive2_tctx_process_pending(tctx, TM_QW3_HV_PHYS);
> +                break;
> +            }
> +            xive2_tctx_process_pending(tctx, cur_ring);
>          }
> -        xive2_tctx_process_pending(tctx, ring == TM_QW2_HV_POOL ?
> -                                                 TM_QW3_HV_PHYS : ring);
>      }
>  }
>  
> @@ -1159,6 +1178,7 @@ static void xive2_tctx_process_pending(XiveTCTX *tctx, uint8_t sig_ring)
>      int rc;
>  
>      g_assert(sig_ring == TM_QW3_HV_PHYS || sig_ring == TM_QW1_OS);
> +    g_assert(sig_regs[TM_WORD2] & 0x80);
>      g_assert(!xive_nsr_indicates_group_exception(sig_ring, sig_regs[TM_NSR]));
>  
>      /*


