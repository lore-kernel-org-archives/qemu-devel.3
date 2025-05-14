Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE076C3ABDA
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 18:48:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFH8d-00080F-0R; Wed, 14 May 2025 14:47:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1uFH7k-0007Zq-FU; Wed, 14 May 2025 14:46:58 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1uFH7e-0004WL-Md; Wed, 14 May 2025 14:46:36 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54EGTiW9029370;
 Wed, 14 May 2025 18:46:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=HHTJhu
 g0TgYFXwupMNdjbMCS1Ktfnwi98LEXWwdf/a0=; b=sBhYUs8DUUXlu3auqxW+jT
 VjpTYO8fvmHdxQr+qsZu8P8eonYSvnC7cuEJ9yD1R2kuVDlnYItN/8EOfU57/ank
 63tWLnYt1Ysw9zo83794TlqNsRN5cfIP7fxgLgeKJp059o8Q5WfJ5bDb4DBHYRfU
 3pZQRHruPpWYP9bS9/eT0YWL2claX9BoVq0uGeuggMsRYLgOLmoC4Sv+g3XLExFY
 JepKHrjHSW8lC/kzCPz7E0gAjAaD+HCJk6BPns+QYScr9U25UaVrpuSXR8rMP5wd
 a5dG4MCUouYeMwskP/oidMVy/CRr5F7hC7q6N4Lp1ei/ZjvY1bOqoiiq6hctTC8A
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46mr1gk3gu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 May 2025 18:46:28 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54EIjMIb019316;
 Wed, 14 May 2025 18:46:27 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46mr1gk3gr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 May 2025 18:46:27 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54EGG3uw021455;
 Wed, 14 May 2025 18:46:26 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46mbfrnv7a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 May 2025 18:46:26 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 54EIkPNd29491920
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 14 May 2025 18:46:25 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3BF385804E;
 Wed, 14 May 2025 18:46:25 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B5BE05803F;
 Wed, 14 May 2025 18:46:24 +0000 (GMT)
Received: from [9.10.80.143] (unknown [9.10.80.143])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 14 May 2025 18:46:24 +0000 (GMT)
Message-ID: <10995b6a-bdb9-45c7-83a7-770b090e65fc@linux.ibm.com>
Date: Wed, 14 May 2025 13:46:24 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/50] ppc/xive2: Remote VSDs need to match on forwarding
 address
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?=
 <fbarrat@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Caleb Schlossin <calebs@linux.vnet.ibm.com>
References: <20250512031100.439842-1-npiggin@gmail.com>
 <20250512031100.439842-5-npiggin@gmail.com>
Content-Language: en-US
From: Mike Kowal <kowal@linux.ibm.com>
In-Reply-To: <20250512031100.439842-5-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: zUvgbKkgvNX8gL8za3XZeSDRCBxRwl0v
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE0MDE2OSBTYWx0ZWRfX2LrLu7dttknq
 ump9Se6i8Qxu8ukLseSJBrdxoruVIbg/Gi1vJM23Y6uX74CAydyFo0yU/LIauy+zkbD7ObjDb9Q
 YXdGcVCP2EYPghKpJwJosBnW+ci7ZcGAfmSO2n2L2QFKu+CE9ASkNnGkur9FVoFIW9X6iltOAJ1
 4vafgxNvUyQ+QzCt2bUZrgns2y1mY+KrQALgvJg2hN8l4feygjbsnQ1LFZ1Gmq5Ys4qGHo6tzu7
 1iAjUDh/Kc75N6ACOb6MdCY9m4Nfef0z+gLWywsP1Rc4WX9YajPTU2lSWR+diLSWQ/eI33r+zA1
 jWe7edE1ahnj4uPLALijVtu9GP7Y8IUptbZWg+VVJn5ONhSGV5C5WFkux/dTieg5qZQAsSBQeIq
 GlyTGu5QcWCeTcRwfAGgZpettrKZwW1SvbKnHO09mMKi1cKcVNKpFKP4JtfJu1JRAaKMgrWu
X-Proofpoint-GUID: DZe3zD3gB0vE-Nty_sqSLSdQR6XQIZRT
X-Authority-Analysis: v=2.4 cv=QOxoRhLL c=1 sm=1 tr=0 ts=6824e504 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=BZqlLmCw9VANlYX6ozUA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-14_04,2025-05-14_03,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0
 phishscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0
 clxscore=1015 mlxscore=0 bulkscore=0 priorityscore=1501 mlxlogscore=999
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505140169
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
> From: Michael Kowal <kowal@linux.ibm.com>
>
> In a multi chip environment there will be remote/forwarded VSDs.  The check
> to find a matching INT controller (XIVE) of the remote block number was
> checking the INTs chip number.  Block numbers are not tied to a chip number.
> The matching remote INT is the one that matches the forwarded VSD address
> with VSD types associated MMIO BAR.

Reviewed-by: Michael Kowal <kowal@linux.ibm.com>

Thanks MAK


>
> Signed-off-by: Michael Kowal <kowal@linux.ibm.com>
> ---
>   hw/intc/pnv_xive2.c | 25 +++++++++++++++++--------
>   1 file changed, 17 insertions(+), 8 deletions(-)
>
> diff --git a/hw/intc/pnv_xive2.c b/hw/intc/pnv_xive2.c
> index d1713b406c..30b4ab2efe 100644
> --- a/hw/intc/pnv_xive2.c
> +++ b/hw/intc/pnv_xive2.c
> @@ -102,12 +102,10 @@ static uint32_t pnv_xive2_block_id(PnvXive2 *xive)
>   }
>   
>   /*
> - * Remote access to controllers. HW uses MMIOs. For now, a simple scan
> - * of the chips is good enough.
> - *
> - * TODO: Block scope support
> + * Remote access to INT controllers. HW uses MMIOs(?). For now, a simple
> + * scan of all the chips INT controller is good enough.
>    */
> -static PnvXive2 *pnv_xive2_get_remote(uint8_t blk)
> +static PnvXive2 *pnv_xive2_get_remote(uint32_t vsd_type, hwaddr fwd_addr)
>   {
>       PnvMachineState *pnv = PNV_MACHINE(qdev_get_machine());
>       int i;
> @@ -116,10 +114,22 @@ static PnvXive2 *pnv_xive2_get_remote(uint8_t blk)
>           Pnv10Chip *chip10 = PNV10_CHIP(pnv->chips[i]);
>           PnvXive2 *xive = &chip10->xive;
>   
> -        if (pnv_xive2_block_id(xive) == blk) {
> +        /*
> +         * Is this the XIVE matching the forwarded VSD address is for this
> +         * VSD type
> +         */
> +        if ((vsd_type == VST_ESB   && fwd_addr == xive->esb_base) ||
> +            (vsd_type == VST_END   && fwd_addr == xive->end_base)  ||
> +            ((vsd_type == VST_NVP ||
> +              vsd_type == VST_NVG) && fwd_addr == xive->nvpg_base) ||
> +            (vsd_type == VST_NVC   && fwd_addr == xive->nvc_base)) {
>               return xive;
>           }
>       }
> +
> +    qemu_log_mask(LOG_GUEST_ERROR,
> +                 "XIVE: >>>>> pnv_xive2_get_remote() vsd_type %u  fwd_addr 0x%lX NOT FOUND\n",
> +                 vsd_type, fwd_addr);
>       return NULL;
>   }
>   
> @@ -252,8 +262,7 @@ static uint64_t pnv_xive2_vst_addr(PnvXive2 *xive, uint32_t type, uint8_t blk,
>   
>       /* Remote VST access */
>       if (GETFIELD(VSD_MODE, vsd) == VSD_MODE_FORWARD) {
> -        xive = pnv_xive2_get_remote(blk);
> -
> +        xive = pnv_xive2_get_remote(type, (vsd & VSD_ADDRESS_MASK));
>           return xive ? pnv_xive2_vst_addr(xive, type, blk, idx) : 0;
>       }
>   

