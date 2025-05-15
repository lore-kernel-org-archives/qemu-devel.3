Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED80FC3ABC9
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 15:53:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFarg-000807-Ny; Thu, 15 May 2025 11:51:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1uFarR-0007HW-TK; Thu, 15 May 2025 11:51:08 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1uFarP-000743-DZ; Thu, 15 May 2025 11:51:05 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54FCg420002200;
 Thu, 15 May 2025 15:51:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=5wyfZD
 ZsgDB6STLQosr0IYPuC8KTlipICrlksLyb+94=; b=GprSRgSSTd6M8h11t4YsLO
 Ar3V0kJbML2Elnsfszg1U6z/tr9AOXELVVF7QSlXRQkbeQNCuhbd2yXEtfntFPDN
 ggxmiA5MX1STfg1EwGTLOtcx42zPnfFgeamPoyHbqW06yDatcf0QeiuFIdVYTPMk
 Wi8PgMPSJhBk+86ksW3sSFAnuXERCzYSnWkaW5b729r2AC0dPQlNvVIU8aWEtnet
 E9UbWbgigt47Il9AVu6VxdIfbp1nSk389dMLFtXfvzBRHtfNXdz048J+cY6mQKg5
 1qN8ZbOMqy5BqmyZcdrqAFIaVI0aLPI5JhP8kRmJ4EvLv1InChF9dEmPQuGCYqdQ
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46n0v6nent-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 15:51:01 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54FFaFRi028631;
 Thu, 15 May 2025 15:51:01 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46n0v6nenp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 15:51:01 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54FE40nW024279;
 Thu, 15 May 2025 15:51:00 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46mbfsb24h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 15:51:00 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 54FFowi521365286
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 15 May 2025 15:50:59 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D6CFD58061;
 Thu, 15 May 2025 15:50:58 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 864B55805D;
 Thu, 15 May 2025 15:50:58 +0000 (GMT)
Received: from [9.10.80.143] (unknown [9.10.80.143])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 15 May 2025 15:50:58 +0000 (GMT)
Message-ID: <9a479b81-ec35-4256-8092-52357f4eebea@linux.ibm.com>
Date: Thu, 15 May 2025 10:50:57 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 48/50] ppc/xive2: Implement PHYS ring VP push TIMA op
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?=
 <fbarrat@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Caleb Schlossin <calebs@linux.vnet.ibm.com>
References: <20250512031100.439842-1-npiggin@gmail.com>
 <20250512031100.439842-49-npiggin@gmail.com>
Content-Language: en-US
From: Mike Kowal <kowal@linux.ibm.com>
In-Reply-To: <20250512031100.439842-49-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=IqAecK/g c=1 sm=1 tr=0 ts=68260d65 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8
 a=5GyUnxkyDHgghPbyitQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: yYpB7kexrzJmzNucRky1FkvTgh6aorMV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDE1NSBTYWx0ZWRfX1Rud2G/jPVNj
 WmFUH8lLF2pKDqTGpf7QDhUjLQIKI0yokmEI7BSULYoZKPR1jAKe3fcqJl08/PqdDxekKi9Y190
 avnA3NSrtsEzF7OHYl7Dx2lhVmJirpacPKflVGV0eeMjBhnDaHT8zN5HlWTY8HSjltoQB3cGmvr
 M+/SkLGDW10shCL9S6BOvkWYorvKIBz3BVloJIcy+o5ivK4v+wZ+snDuqQ7jT+mapoZWjEgENOz
 vyvPZ8IEjnRJZ7bB9gX58o//Qh4GTEWKQtvZimEcFxBre7Ot+AfniThL6/emkfZviVfny+KdTzR
 GUz9+knNRnn4OmmP2ZbGf5djovm1Lis91l5YY5n/Fby6AZrjTJkO1R3/piVisIiEirC4tWfpnb8
 me3FIlCp0oKgTYc/gbkWTn3Yy/YQ6juU7pHJZo96VmnsTOOzJOeB4Zr+lOYHr9Z+crZBz7Yq
X-Proofpoint-GUID: OaGeuXZ8xq3nF69G-RnmvWS_iiCoynqO
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
> Implement the phys (aka hard) VP push. PowerVM uses this operation.

Reviewed-by: Michael Kowal<kowal@linux.ibm.com>

Thanks,  MAK
>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   hw/intc/xive.c         |  2 ++
>   hw/intc/xive2.c        | 11 +++++++++++
>   include/hw/ppc/xive2.h |  2 ++
>   3 files changed, 15 insertions(+)
>
> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> index 807a1c1c34..69118999e6 100644
> --- a/hw/intc/xive.c
> +++ b/hw/intc/xive.c
> @@ -747,6 +747,8 @@ static const XiveTmOp xive2_tm_operations[] = {
>         xive_tm_set_pool_lgs, NULL },
>       { XIVE_TM_HV_PAGE, TM_QW3_HV_PHYS + TM_CPPR,  1, true, true,
>         xive2_tm_set_hv_cppr, NULL },
> +    { XIVE_TM_HV_PAGE, TM_QW3_HV_PHYS + TM_WORD2, 1, false, true,
> +      xive2_tm_push_phys_ctx, NULL },
>       { XIVE_TM_HV_PAGE, TM_QW3_HV_PHYS + TM_WORD2, 1, true, true,
>         NULL, xive_tm_vt_poll },
>       { XIVE_TM_HV_PAGE, TM_QW3_HV_PHYS + TM_T,     1, true, true,
> diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
> index de1ccad685..a9b188b909 100644
> --- a/hw/intc/xive2.c
> +++ b/hw/intc/xive2.c
> @@ -1005,6 +1005,11 @@ static void xive2_tm_push_ctx(XivePresenter *xptr, XiveTCTX *tctx,
>   
>       /* First update the thead context */
>       switch (size) {
> +    case 1:
> +        tctx->regs[ring + TM_WORD2] = value & 0xff;
> +        cam = xive2_tctx_hw_cam_line(xptr, tctx);
> +        cam |= ((value & 0xc0) << 24); /* V and H bits */
> +        break;
>       case 4:
>           cam = value;
>           w2 = cpu_to_be32(cam);
> @@ -1040,6 +1045,12 @@ void xive2_tm_push_pool_ctx(XivePresenter *xptr, XiveTCTX *tctx,
>       xive2_tm_push_ctx(xptr, tctx, offset, value, size, TM_QW2_HV_POOL);
>   }
>   
> +void xive2_tm_push_phys_ctx(XivePresenter *xptr, XiveTCTX *tctx,
> +                            hwaddr offset, uint64_t value, unsigned size)
> +{
> +    xive2_tm_push_ctx(xptr, tctx, offset, value, size, TM_QW3_HV_PHYS);
> +}
> +
>   /* returns -1 if ring is invalid, but still populates block and index */
>   static int xive2_tctx_get_nvp_indexes(XiveTCTX *tctx, uint8_t ring,
>                                         uint8_t *nvp_blk, uint32_t *nvp_idx)
> diff --git a/include/hw/ppc/xive2.h b/include/hw/ppc/xive2.h
> index 45266c2a8b..f4437e2c79 100644
> --- a/include/hw/ppc/xive2.h
> +++ b/include/hw/ppc/xive2.h
> @@ -146,6 +146,8 @@ void xive2_tm_push_pool_ctx(XivePresenter *xptr, XiveTCTX *tctx,
>                               hwaddr offset, uint64_t value, unsigned size);
>   uint64_t xive2_tm_pull_pool_ctx(XivePresenter *xptr, XiveTCTX *tctx,
>                                   hwaddr offset, unsigned size);
> +void xive2_tm_push_phys_ctx(XivePresenter *xptr, XiveTCTX *tctx,
> +                            hwaddr offset, uint64_t value, unsigned size);
>   uint64_t xive2_tm_pull_phys_ctx(XivePresenter *xptr, XiveTCTX *tctx,
>                                   hwaddr offset, unsigned size);
>   void xive2_tm_pull_phys_ctx_ol(XivePresenter *xptr, XiveTCTX *tctx,

