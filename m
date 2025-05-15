Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD3C5C54755
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 15:48:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFang-0002wz-AV; Thu, 15 May 2025 11:47:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1uFan8-0000qj-DY; Thu, 15 May 2025 11:46:38 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1uFan3-0006Zx-GX; Thu, 15 May 2025 11:46:38 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54FDn3Wx032297;
 Thu, 15 May 2025 15:46:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=vI54V2
 t83TgfT12cQR7DdhKSsckCynbZBiS4oMEbbhs=; b=glpgL3j4tYMGxK1WAED3FC
 MaHOal1MxURv387/xX8sZFSa1GVsEJw8Z5rhUgu1tbqgVvcEFTXlTxjffbnwDu5B
 aQ2T5fL1QwHU2HUyXXxPSDnAhl3lKDhQ6tmMo6UacaTReDmdF+nYvYIJAth5oPwv
 ITla1XRgWxrgprZTTWTJBfsZblBenx9ZODdWecsSM7xiXo9UdB1ajgA5/gKxodN2
 B61OKaMiUk0RtLZ3j4kMR2LheicqQkhgUJxQcrDqFSD7ovneoi1ISupRKf3SH9ZM
 sdyQMRQOmBNXpFEMl5TOTYcRUjxUctJ9JSdO/borsiSXfZKWcq0uF/Pb8pznUWAw
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46nhg30nr3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 15:46:29 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54FFIpEh015123;
 Thu, 15 May 2025 15:46:28 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46nhg30nr0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 15:46:28 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54FE89EQ021439;
 Thu, 15 May 2025 15:46:28 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46mbfru0sx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 15:46:28 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 54FFkRI628770896
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 15 May 2025 15:46:27 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 07C605805D;
 Thu, 15 May 2025 15:46:27 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AA69858058;
 Thu, 15 May 2025 15:46:26 +0000 (GMT)
Received: from [9.10.80.143] (unknown [9.10.80.143])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 15 May 2025 15:46:26 +0000 (GMT)
Message-ID: <dacf574a-9bf7-4b6e-81e1-abf0903b74b1@linux.ibm.com>
Date: Thu, 15 May 2025 10:46:25 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 42/50] ppc/xive: Redistribute phys after pulling of pool
 context
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?=
 <fbarrat@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Caleb Schlossin <calebs@linux.vnet.ibm.com>
References: <20250512031100.439842-1-npiggin@gmail.com>
 <20250512031100.439842-43-npiggin@gmail.com>
Content-Language: en-US
From: Mike Kowal <kowal@linux.ibm.com>
In-Reply-To: <20250512031100.439842-43-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Cf0I5Krl c=1 sm=1 tr=0 ts=68260c55 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8
 a=yvUvzrinEMu33hxc1CYA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDE1NSBTYWx0ZWRfX5n9kIdXCdP+t
 BETD9u1szxCXGrY9eoT3vt6yM6lhCj5qXPhzRohXZY1kBb+3QEo6K6I7dMkzb6wFkWbFbvKjSI/
 S3+Q/JpLPqG2QKc1rL+zir+p801a1lLy1S6qAWK1rytH/UIeTFulpJGihIH94555ZK/q9lel9Xj
 s+PdTh+yuGx3iDlpiFKU3OxyVwZEGqCsA6Fi+/zufZowac3Ur4LNKblqje2HNUskHvc1uoax3xB
 Jodxn8yWNQz/kJCNDzdVmyDc2Xu4q7qmgdayGg9jhhjX89OL/pWaIyVDWkV2JsWZAXydy8+Xaxh
 8TZ2kiaSTmI1vwJgZX3WQqe5i0TWakSDjPv/BNo8FPOt+3Iyh7eB5c1L/dCVs+P8kiRFHifu4rK
 VEnFFiPaMlrX92WHnFViR682Q3Y6MqNvalUcZIDXKPXU9EAAoqWzu9oPGZPou5S87HfY/BOF
X-Proofpoint-GUID: Nlb6bG1J2x6S0h07f6AF6K3f8dRvUWOQ
X-Proofpoint-ORIG-GUID: 9s_JPxnk38hcYFbVncm0H9XPLyNl2qxi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_06,2025-05-15_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0
 spamscore=0 malwarescore=0 lowpriorityscore=0 mlxlogscore=999
 impostorscore=0 phishscore=0 priorityscore=1501 mlxscore=0 bulkscore=0
 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505150155
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
> After pulling the pool context, if a pool irq had been presented and
> was cleared in the process, there could be a pending irq in phys that
> should be presented. Process the phys irq ring after pulling pool ring
> to catch this case and avoid losing irqs.

Reviewed-by: Michael Kowal<kowal@linux.ibm.com>

Thanks,  MAK
>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   hw/intc/xive.c  |  3 +++
>   hw/intc/xive2.c | 16 ++++++++++++++--
>   2 files changed, 17 insertions(+), 2 deletions(-)
>
> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> index 81af59f0ec..aeca66e56e 100644
> --- a/hw/intc/xive.c
> +++ b/hw/intc/xive.c
> @@ -320,6 +320,9 @@ static uint64_t xive_tm_pull_pool_ctx(XivePresenter *xptr, XiveTCTX *tctx,
>   
>       xive_tctx_reset_signal(tctx, TM_QW1_OS);
>       xive_tctx_reset_signal(tctx, TM_QW2_HV_POOL);
> +    /* Re-check phys for interrupts if pool was disabled */
> +    xive_tctx_pipr_recompute_from_ipb(tctx, TM_QW3_HV_PHYS);
> +
>       return qw2w2;
>   }
>   
> diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
> index aeeb901b6a..917ecbaae4 100644
> --- a/hw/intc/xive2.c
> +++ b/hw/intc/xive2.c
> @@ -683,6 +683,8 @@ static void xive2_redistribute(Xive2Router *xrtr, XiveTCTX *tctx, uint8_t ring)
>       xive_tctx_reset_signal(tctx, ring);
>   }
>   
> +static void xive2_tctx_process_pending(XiveTCTX *tctx, uint8_t sig_ring);
> +
>   static uint64_t xive2_tm_pull_ctx(XivePresenter *xptr, XiveTCTX *tctx,
>                                     hwaddr offset, unsigned size, uint8_t ring)
>   {
> @@ -739,6 +741,18 @@ static uint64_t xive2_tm_pull_ctx(XivePresenter *xptr, XiveTCTX *tctx,
>           }
>       }
>   
> +    if (ring == TM_QW2_HV_POOL) {
> +        /* Re-check phys for interrupts if pool was disabled */
> +        nsr = tctx->regs[TM_QW3_HV_PHYS + TM_NSR];
> +        if (xive_nsr_indicates_exception(TM_QW3_HV_PHYS, nsr)) {
> +            /* Ring must be PHYS because POOL would have been redistributed */
> +            g_assert(xive_nsr_exception_ring(TM_QW3_HV_PHYS, nsr) ==
> +                                                           TM_QW3_HV_PHYS);
> +        } else {
> +            xive2_tctx_process_pending(tctx, TM_QW3_HV_PHYS);
> +        }
> +    }
> +
>       if (xive2_router_get_config(xrtr) & XIVE2_VP_SAVE_RESTORE && do_save) {
>           xive2_tctx_save_ctx(xrtr, tctx, ring, nvp_blk, nvp_idx);
>       }
> @@ -925,8 +939,6 @@ static uint8_t xive2_tctx_restore_ctx(Xive2Router *xrtr, XiveTCTX *tctx,
>       return cppr;
>   }
>   
> -static void xive2_tctx_process_pending(XiveTCTX *tctx, uint8_t sig_ring);
> -
>   static void xive2_tctx_need_resend(Xive2Router *xrtr, XiveTCTX *tctx,
>                                      uint8_t nvp_blk, uint32_t nvp_idx,
>                                      bool do_restore)

