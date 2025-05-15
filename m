Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5873C2D0CD
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 15:55:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFavB-0002z2-5L; Thu, 15 May 2025 11:54:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1uFaub-0002Oi-4X; Thu, 15 May 2025 11:54:22 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1uFauY-0007Gb-Pt; Thu, 15 May 2025 11:54:20 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54FCgOPW013083;
 Thu, 15 May 2025 15:54:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=SVsiSR
 dhAHqb97D9e5FkwgjTia6SPZtBOuu+XdOnSKw=; b=T27y9m9vlyjVWKytfJVS/J
 pvMAhR470iGYfjymyYbRnLtuEeIC4hghrl+6PURKb3GP3bRxawhDf0gMbUpN0s4h
 wawLmoRKIl1B/DyjOB/PpbwnEJ7hMzsc84Ouz4Y9uLI83yu9+jjzy9c+1dpjnl9p
 JYMsSrc8cZkXWlM32bd5BSGpnbic4amoV5y4TfOkrmLizon5UekreJKW5txzw9Ep
 lpwkEHL7OFSwVSrhu0rfGruk28JDNHOeQyF5yhy4P3yXZdL/yOllr5tjHrCENPp1
 L7DFnq+h3u1rbQnJTaKNe4dYk7BItoQsnablM4XSBGME0wJ7+GxKf+x2Gq6xpZEQ
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46n0t9dk8a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 15:54:14 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54FFsDSM022692;
 Thu, 15 May 2025 15:54:13 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46n0t9dk87-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 15:54:13 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54FEJwea015315;
 Thu, 15 May 2025 15:54:12 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 46mbfq31mu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 15:54:12 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 54FFsAe124773160
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 15 May 2025 15:54:11 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A6EA05805D;
 Thu, 15 May 2025 15:54:10 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5596158057;
 Thu, 15 May 2025 15:54:10 +0000 (GMT)
Received: from [9.10.80.143] (unknown [9.10.80.143])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 15 May 2025 15:54:10 +0000 (GMT)
Message-ID: <7604bcc7-7f64-42d3-a165-73feb378509b@linux.ibm.com>
Date: Thu, 15 May 2025 10:54:09 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 50/50] ppc/xive2: Enable lower level contexts on VP push
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?=
 <fbarrat@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Caleb Schlossin <calebs@linux.vnet.ibm.com>
References: <20250512031100.439842-1-npiggin@gmail.com>
 <20250512031100.439842-51-npiggin@gmail.com>
Content-Language: en-US
From: Mike Kowal <kowal@linux.ibm.com>
In-Reply-To: <20250512031100.439842-51-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=etzfzppX c=1 sm=1 tr=0 ts=68260e26 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8
 a=z2KaQxLorgeo9JcVKagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDE1NSBTYWx0ZWRfXywvJURBAGvyu
 KpArJLMJ2HX2mdLLSm2tgg+cQu07EWYUOr70mLkqGv3pVTNWSBwMdtuGpwX9JFzgvMBMPernll0
 tpM7ZtuL6hK007WAqPluHsNLvkO4ttH+JpII13ujymsPGGMxT2Hp25O7DzPEKvsuzPx9SOnR5n+
 zFL9CkTyNtqt2AcdX5KZoYmu2ehCHO1Ee8nweSazcQrL/VuVpbuhjrGf8nF6f4QVk0lTMtXQWBe
 V+byH/lUA+M+q4GKXx3HHYejMurh1nP6VLl/7hYYpfcF2VCw/7mACJFaXP/6t0ro4MSNcr7NIH2
 U96b/UtPI4178sMiHj3qZ+orx/TNl9PSKSlI/6mG2URagfB4maiItxdW/ILtcPgxlntIEn5UfVB
 2WNC77lM2mxC9+ejZkvfOXVmeoQO1mp87VgSXCbmZN30sZQcHU02C3OKj4hafXwFA+eQ9+fj
X-Proofpoint-ORIG-GUID: RTtfnko0XN5HEjkzkz5ruMUV0NJZHava
X-Proofpoint-GUID: Wa_yXvdQzKNfOohcp9ouF-L5h2dZOKqM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_06,2025-05-15_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 lowpriorityscore=0 phishscore=0 mlxscore=0 mlxlogscore=885 bulkscore=0
 suspectscore=0 spamscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505150155
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
> When pushing a context, the lower-level context becomes valid if it
> had V=1, and so on. Iterate lower level contexts and send them
> pending interrupts if they become enabled.

Reviewed-by: Michael Kowal<kowal@linux.ibm.com>

Thanks,  MAK
>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   hw/intc/xive2.c | 36 ++++++++++++++++++++++++++++--------
>   1 file changed, 28 insertions(+), 8 deletions(-)
>
> diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
> index 53e90b8178..ded003fa87 100644
> --- a/hw/intc/xive2.c
> +++ b/hw/intc/xive2.c
> @@ -995,6 +995,12 @@ static void xive2_tm_push_ctx(XivePresenter *xptr, XiveTCTX *tctx,
>       bool v;
>       bool do_restore;
>   
> +    if (xive_ring_valid(tctx, ring)) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: Attempt to push VP to enabled"
> +                                       " ring 0x%02x\n", ring);
> +        return;
> +    }
> +
>       /* First update the thead context */
>       switch (size) {
>       case 1:
> @@ -1021,19 +1027,32 @@ static void xive2_tm_push_ctx(XivePresenter *xptr, XiveTCTX *tctx,
>       /* Check the interrupt pending bits */
>       if (v) {
>           Xive2Router *xrtr = XIVE2_ROUTER(xptr);
> -        uint8_t *sig_regs = xive_tctx_signal_regs(tctx, ring);
> -        uint8_t nsr = sig_regs[TM_NSR];
> +        uint8_t cur_ring;
>   
>           xive2_tctx_restore_nvp(xrtr, tctx, ring,
>                                  nvp_blk, nvp_idx, do_restore);
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
>           }
> -        xive2_tctx_process_pending(tctx, ring == TM_QW2_HV_POOL ?
> -                                                 TM_QW3_HV_PHYS : ring);
>       }
>   }
>   
> @@ -1159,6 +1178,7 @@ static void xive2_tctx_process_pending(XiveTCTX *tctx, uint8_t sig_ring)
>       int rc;
>   
>       g_assert(sig_ring == TM_QW3_HV_PHYS || sig_ring == TM_QW1_OS);
> +    g_assert(sig_regs[TM_WORD2] & 0x80);
>       g_assert(!xive_nsr_indicates_group_exception(sig_ring, sig_regs[TM_NSR]));
>   
>       /*

