Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BF2FC2D0CD
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 15:26:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFaTF-0003k3-Qc; Thu, 15 May 2025 11:26:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1uFaTD-0003jK-EV; Thu, 15 May 2025 11:26:03 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1uFaT7-0003O8-ED; Thu, 15 May 2025 11:26:02 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54FCfu3V016145;
 Thu, 15 May 2025 15:25:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=r08tq1
 ePNEnlcgTFy2c6Vdj8pBzWmb7Eq1jm4PuF8Us=; b=qgdAjiCYbxMNhR2IQ5jY/I
 jRRH7Bt5RXbCZ1uBGVIeiPzEc4EMqglv8jBG/nCXynuOEcKZWafbdbbrvmq6JY3i
 5jycc5S4ViyeySDnma4/+aYhPjtoy+kT/LpSZuitsy+9cNDB2ZPncYcSeAhctr5t
 sK4IwlGexf0Nyrjk0JaZuLFnvBC2T8bpHMQc3YeOOMbfCio6WhaBbyP6+y7/Qz6s
 inawwjavVpUoBmZH9M+osXixJWCEdmD+c+ZpXZ1BxU1IBJyAHm2pKR10BWntvMY0
 cOamRflMJkrf7UstOg1uA9l9DXSjL2vNvi5WaiNzzd1I8aynLKYvJo8u2ystlJ3w
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46nd4gt2w7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 15:25:53 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54FFPg4x020099;
 Thu, 15 May 2025 15:25:53 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46nd4gt2vy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 15:25:53 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54FE3XiC021793;
 Thu, 15 May 2025 15:25:52 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46mbfptx1x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 15:25:52 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 54FFPoim20775618
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 15 May 2025 15:25:51 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id ACC055805D;
 Thu, 15 May 2025 15:25:50 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 60D5E58057;
 Thu, 15 May 2025 15:25:50 +0000 (GMT)
Received: from [9.10.80.143] (unknown [9.10.80.143])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 15 May 2025 15:25:50 +0000 (GMT)
Message-ID: <186406e4-5e8c-4972-a0ab-c05e21879719@linux.ibm.com>
Date: Thu, 15 May 2025 10:25:49 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 37/50] ppc/xive2: Consolidate presentation processing in
 context push
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?=
 <fbarrat@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Caleb Schlossin <calebs@linux.vnet.ibm.com>
References: <20250512031100.439842-1-npiggin@gmail.com>
 <20250512031100.439842-38-npiggin@gmail.com>
Content-Language: en-US
From: Mike Kowal <kowal@linux.ibm.com>
In-Reply-To: <20250512031100.439842-38-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 2X0dICpG9AbrPRPjA9L6lw4ylEjKoPP3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDE1MCBTYWx0ZWRfXwNPA2lHtoiu1
 +Gs0MTfIhGuXHwRUTeL79BO/cn/FEqEvhYS2eYct6pVkOI5WeijVCKceUmuzbXyOwPV7suDo0gN
 YfxVf3gWtIMV9tDc2/+5Mc44u+kWLUO5lUHxuXqEY4307K7BViI00LSPetW14NdD8li5O15NmhF
 FJZssc/9jGjvZCgRL+tndXrTcrc24nCONKPHIrLgR1i0aiMgwqG2H3276XNE1WBy9JX/jbx+Aor
 0FFpl94cBAVFNqdES+gm+q0/SqB3fio7PxopYlSgTHNFMXvC2YFD9/YCmdBpNUuvPZLf7UTCkJX
 4x3JsutFzMfKo7lkua7H7EbXqqhQDmhtF+8cGc95H76Eb/BJ/q3HmrEFGrfx91XybdA7hqh4ftr
 qsPudytYWpLMy1yuWyLXDyaNLA5NV01IlC0SHpnY7cdcdY7VYFodZhuj2QM/C53RvxeCh0MP
X-Proofpoint-ORIG-GUID: fPMbUo6kqFlmvLyFl4olkVxyFzsIt2LN
X-Authority-Analysis: v=2.4 cv=OsNPyz/t c=1 sm=1 tr=0 ts=68260781 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8
 a=d2C1B0Mhuc3K8UHgKYMA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_06,2025-05-15_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 suspectscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0 clxscore=1015
 impostorscore=0 mlxlogscore=999 mlxscore=0 adultscore=0 bulkscore=0
 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505150150
Received-SPF: pass client-ip=148.163.156.1; envelope-from=kowal@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


On 5/11/2025 10:10 PM, Nicholas Piggin wrote:
> OS-push operation must re-present pending interrupts. Use the
> newly created xive2_tctx_process_pending() function instead of
> duplicating the logic.

Reviewed-by: Michael Kowal<kowal@linux.ibm.com>

Thanks,  MAK
>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   hw/intc/xive2.c | 42 ++++++++++--------------------------------
>   1 file changed, 10 insertions(+), 32 deletions(-)
>
> diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
> index aa06bfda77..0fdf6a4f20 100644
> --- a/hw/intc/xive2.c
> +++ b/hw/intc/xive2.c
> @@ -903,18 +903,14 @@ static uint8_t xive2_tctx_restore_os_ctx(Xive2Router *xrtr, XiveTCTX *tctx,
>       return cppr;
>   }
>   
> +static void xive2_tctx_process_pending(XiveTCTX *tctx, uint8_t sig_ring);
> +
>   static void xive2_tctx_need_resend(Xive2Router *xrtr, XiveTCTX *tctx,
>                                      uint8_t nvp_blk, uint32_t nvp_idx,
>                                      bool do_restore)
>   {
> -    XivePresenter *xptr = XIVE_PRESENTER(xrtr);
> -    uint8_t ipb;
> -    uint8_t backlog_level;
> -    uint8_t group_level;
> -    uint8_t first_group;
> -    uint8_t backlog_prio;
> -    uint8_t group_prio;
>       uint8_t *regs = &tctx->regs[TM_QW1_OS];
> +    uint8_t ipb;
>       Xive2Nvp nvp;
>   
>       /*
> @@ -946,30 +942,8 @@ static void xive2_tctx_need_resend(Xive2Router *xrtr, XiveTCTX *tctx,
>       }
>       /* IPB bits in the backlog are merged with the TIMA IPB bits */
>       regs[TM_IPB] |= ipb;
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
>   }
>   
>   /*
> @@ -1103,8 +1077,12 @@ static void xive2_tctx_process_pending(XiveTCTX *tctx, uint8_t sig_ring)
>   {
>       uint8_t *sig_regs = &tctx->regs[sig_ring];
>       Xive2Router *xrtr = XIVE2_ROUTER(tctx->xptr);
> -    uint8_t backlog_prio, first_group, group_level;
> -    uint8_t pipr_min, lsmfb_min, ring_min;
> +    uint8_t backlog_prio;
> +    uint8_t first_group;
> +    uint8_t group_level;
> +    uint8_t pipr_min;
> +    uint8_t lsmfb_min;
> +    uint8_t ring_min;
>       uint8_t cppr = sig_regs[TM_CPPR];
>       bool group_enabled;
>       Xive2Nvp nvp;

