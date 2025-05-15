Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AE6CC3ABC9
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 15:53:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFarI-0006yv-5K; Thu, 15 May 2025 11:50:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1uFaqa-0006XK-HY; Thu, 15 May 2025 11:50:17 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1uFaqT-0006nN-A5; Thu, 15 May 2025 11:50:12 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54FCgOwn013030;
 Thu, 15 May 2025 15:50:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=aN1Fn+
 2EfkR3fghPlp516O5wn0aD5pXnja7rdPfiTBM=; b=riFugZ6MtAilUPVx5yIFJ3
 CzaoHS+h4+MvXLOLVkykNIlh5u0vVRBZ2uJ2vvt+yW2XAZo7+VH/OtGyMdiKcuoy
 hCXmAqa2UymAJEzsW5N7sda1iQRLOblWlL/LXDH+ldz7mu28bN4lcXUTolBY+/Kb
 G73qvZPMyykn0SPlnqSpW8qVI1jaQbTmcaAp4YOBKUUw41u2Tm3UIQ//Ia9sfr4j
 3upGa7Et8wSoZNAbwemJmZgFK2SOp77ZpXrSla1vfvxUOBuqo5G+BUvLOWBT+gec
 jX6bee3B6oABnrwjD5llF85mE96iBaHdGKAt3E+f/TYVB865uDWd9CksFi2Cu5Ww
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46n0t9djk3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 15:50:02 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54FFcEGI016084;
 Thu, 15 May 2025 15:50:02 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46n0t9djju-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 15:50:01 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54FDl6cl021806;
 Thu, 15 May 2025 15:50:00 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46mbfpu259-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 15:50:00 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 54FFnufB30409318
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 15 May 2025 15:49:56 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 42D3A58063;
 Thu, 15 May 2025 15:49:59 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E750658061;
 Thu, 15 May 2025 15:49:58 +0000 (GMT)
Received: from [9.10.80.143] (unknown [9.10.80.143])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 15 May 2025 15:49:58 +0000 (GMT)
Message-ID: <c30e3716-135b-4e90-be1f-28f286bc51ae@linux.ibm.com>
Date: Thu, 15 May 2025 10:49:58 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 46/50] ppc/xive2: Implement set_os_pending TIMA op
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?=
 <fbarrat@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Caleb Schlossin <calebs@linux.vnet.ibm.com>
References: <20250512031100.439842-1-npiggin@gmail.com>
 <20250512031100.439842-47-npiggin@gmail.com>
Content-Language: en-US
From: Mike Kowal <kowal@linux.ibm.com>
In-Reply-To: <20250512031100.439842-47-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=etzfzppX c=1 sm=1 tr=0 ts=68260d2a cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8
 a=jaoGCA84DIYCLCjvDVkA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDE1NSBTYWx0ZWRfX+oZRioa5wpQ6
 1VcpMRqQr3wGuNjzNHt87CzQSjmhrv783n81/e8RdmIVyfkJ0qrKI39bA6nQbIbNc9k88vFPD9z
 RzhXAinMHNeYzK4RS2XK68DJKayOZ2HEPF0xtwZ+l+posqY02+d1BAKbi1Daq8IM8kUi6sPYIxs
 jn2dWF6rnERKZvOUDFZTJQ285qWVECMLF2NeDjnf111O1QUzJrRdZL16JP0kVPvmQCOQ+nZ36d4
 82QkpTuT45tiyNl/raweDE6o1mMEXCqPnpmwHjV/iIpjyCvt5erOnqK4HMqmk5BfnT1w+6B1wgl
 W1fUWMc4cP3DxWfC1XCvH5AXxvK/9dAAQWpeuej0H9bUFfBN15D5dcyVYkg1ZrUxsg5nlwN9hZ3
 k+auur1p2Dh1QmSIwWPSfnLs83OT998w4aFP76x1VW78ereJTFaiMMswArffe4v91V8CpDh0
X-Proofpoint-ORIG-GUID: NCF4VzEltiSze7j56_K2LL1RGDwjME1L
X-Proofpoint-GUID: Xp9RuHO0LazSfAd8QlT3BZn6d12_i8WS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_06,2025-05-15_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 lowpriorityscore=0 phishscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
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
> xive2 must take into account redistribution of group interrupts if
> the VP directed priority exceeds the group interrupt priority after
> this operation. The xive1 code is not group aware so implement this
> for xive2.


Reviewed-by: Michael Kowal<kowal@linux.ibm.com>

Thanks,  MAK

>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   hw/intc/xive.c         |  2 ++
>   hw/intc/xive2.c        | 28 ++++++++++++++++++++++++++++
>   include/hw/ppc/xive2.h |  2 ++
>   3 files changed, 32 insertions(+)
>
> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> index 979031a587..dc64edf13d 100644
> --- a/hw/intc/xive.c
> +++ b/hw/intc/xive.c
> @@ -747,6 +747,8 @@ static const XiveTmOp xive2_tm_operations[] = {
>       /* MMIOs above 2K : special operations with side effects */
>       { XIVE_TM_OS_PAGE, TM_SPC_ACK_OS_REG,         2, true, false,
>         NULL, xive_tm_ack_os_reg },
> +    { XIVE_TM_OS_PAGE, TM_SPC_SET_OS_PENDING,     1, true, false,
> +      xive2_tm_set_os_pending, NULL },
>       { XIVE_TM_HV_PAGE, TM_SPC_PULL_OS_CTX_G2,     4, true, false,
>         NULL, xive2_tm_pull_os_ctx },
>       { XIVE_TM_HV_PAGE, TM_SPC_PULL_OS_CTX,        4, true, false,
> diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
> index 392ac6077e..de1ccad685 100644
> --- a/hw/intc/xive2.c
> +++ b/hw/intc/xive2.c
> @@ -1323,6 +1323,34 @@ void xive2_tm_set_os_cppr(XivePresenter *xptr, XiveTCTX *tctx,
>       xive2_tctx_set_cppr(tctx, TM_QW1_OS, value & 0xff);
>   }
>   
> +/*
> + * Adjust the IPB to allow a CPU to process event queues of other
> + * priorities during one physical interrupt cycle.
> + */
> +void xive2_tm_set_os_pending(XivePresenter *xptr, XiveTCTX *tctx,
> +                             hwaddr offset, uint64_t value, unsigned size)
> +{
> +    Xive2Router *xrtr = XIVE2_ROUTER(xptr);
> +    uint8_t ring = TM_QW1_OS;
> +    uint8_t *regs = &tctx->regs[ring];
> +    uint8_t priority = value & 0xff;
> +
> +    /*
> +     * XXX: should this simply set a bit in IPB and wait for it to be picked
> +     * up next cycle, or is it supposed to present it now? We implement the
> +     * latter here.
> +     */
> +    regs[TM_IPB] |= xive_priority_to_ipb(priority);
> +    if (xive_ipb_to_pipr(regs[TM_IPB]) >= regs[TM_PIPR]) {
> +        return;
> +    }
> +    if (xive_nsr_indicates_group_exception(ring, regs[TM_NSR])) {
> +        xive2_redistribute(xrtr, tctx, ring);
> +    }
> +
> +    xive_tctx_pipr_present(tctx, ring, priority, 0);
> +}
> +
>   static void xive2_tctx_set_target(XiveTCTX *tctx, uint8_t ring, uint8_t target)
>   {
>       uint8_t *regs = &tctx->regs[ring];
> diff --git a/include/hw/ppc/xive2.h b/include/hw/ppc/xive2.h
> index c1ab06a55a..45266c2a8b 100644
> --- a/include/hw/ppc/xive2.h
> +++ b/include/hw/ppc/xive2.h
> @@ -130,6 +130,8 @@ void xive2_tm_set_hv_cppr(XivePresenter *xptr, XiveTCTX *tctx,
>                             hwaddr offset, uint64_t value, unsigned size);
>   void xive2_tm_set_os_cppr(XivePresenter *xptr, XiveTCTX *tctx,
>                             hwaddr offset, uint64_t value, unsigned size);
> +void xive2_tm_set_os_pending(XivePresenter *xptr, XiveTCTX *tctx,
> +                             hwaddr offset, uint64_t value, unsigned size);
>   void xive2_tm_push_os_ctx(XivePresenter *xptr, XiveTCTX *tctx, hwaddr offset,
>                              uint64_t value, unsigned size);
>   uint64_t xive2_tm_pull_os_ctx(XivePresenter *xptr, XiveTCTX *tctx,

