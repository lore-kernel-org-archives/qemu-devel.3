Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 712CAC3ABDA
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 19:08:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFHSX-00018R-E1; Wed, 14 May 2025 15:08:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1uFHMu-0005V3-OA; Wed, 14 May 2025 15:02:24 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1uFHMi-0007hB-Rz; Wed, 14 May 2025 15:02:09 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54EDnPJ2004373;
 Wed, 14 May 2025 19:01:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=XhX9gG
 2mecUE5SSUcGCKkc1pHNBvJakHy4LjG7+83hM=; b=PPkE/0eDPGFgYWSY4nddxj
 azd6fbvKmY3WlVs1GZrOapKOc4qdkEFN8zC9dwreR9ZfSZYz/bIpdtAjLRdqirxi
 nmEChB27N58WHuiS7hkQoL65yfW49TtouS+AAxyecy4gQfchV10WHl9Lm2q3V3Rd
 20NVa6FsQSX2brp9St13QHkSysusfZdu9Lt4gVm0WlIDv/huokJSfazPyoyDzV6i
 2DJixgu2sKKwWHwEsqimHTdozSdYK/hZfcBdqEhG4wybogZzIeSiGvbn87scRcHC
 VpWeOVucVQT+Cd0N//sY0V57eHV+CNwX8QdPD1oH64NMa0E1oEjOjqADyTJNk3zw
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46mvd39r7d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 May 2025 19:01:59 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54EIri2T027301;
 Wed, 14 May 2025 19:01:58 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46mvd39r7a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 May 2025 19:01:58 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54EGG32k021455;
 Wed, 14 May 2025 19:01:58 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46mbfrny1m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 May 2025 19:01:58 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 54EJ1r8H25428668
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 14 May 2025 19:01:53 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 075C75804E;
 Wed, 14 May 2025 19:01:57 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 85EED5803F;
 Wed, 14 May 2025 19:01:56 +0000 (GMT)
Received: from [9.10.80.143] (unknown [9.10.80.143])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 14 May 2025 19:01:56 +0000 (GMT)
Message-ID: <2c83321e-182b-4b98-89df-3d5fc4231747@linux.ibm.com>
Date: Wed, 14 May 2025 14:01:56 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/50] ppc/xive: Fix pulling pool and phys contexts
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?=
 <fbarrat@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Caleb Schlossin <calebs@linux.vnet.ibm.com>
References: <20250512031100.439842-1-npiggin@gmail.com>
 <20250512031100.439842-17-npiggin@gmail.com>
Content-Language: en-US
From: Mike Kowal <kowal@linux.ibm.com>
In-Reply-To: <20250512031100.439842-17-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 2IBeQfT5enuz8KMix9yyGVmuGmpPkkqV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE0MDE2OSBTYWx0ZWRfX64NxxsXLImEB
 yThaHurXtTIgkpVtIGragX4I9EHg0VyYLB7zF1jzmT5d5sC42NV1fso1icaOdrR9Nwqppd9Qu4E
 PvDC+xboiw0vxGbbC5DaQe3StKFe3lbhxcPZCdrJO+L4ZpbNJtSpp/AQUx7uwattczYX9QOpyAq
 dp7Ifjh1pqRSdfQoNakg8CiQKefSmLj4SJikkaw+aaEqPpiqOUb05ETYnE13JciQSL3PCwFEojT
 fQZvbtSRjFFXgRqpYuR5JYjbwN5vBtIpwdxUJ3IIVdHo+FJOt5KLqE+e9keqNq3Hiu1j6045/4T
 DVl/b6JgfBMwhy2xw+0K5pzeMKBQ9lhK9oXzqd1jf0rY5EYmSo3EJ0cCOel4S2lxV1vlIv78cDy
 Kuz92VREYa44hmUMKjka/YCpl0H8rPzD7zZYOIAO+cvcxtfBlhRbV0XxcaVpk7NruJxV28N7
X-Proofpoint-ORIG-GUID: Nch6JDrVPJpoD34RBY8v_qXjhzKIiccI
X-Authority-Analysis: v=2.4 cv=GbEXnRXL c=1 sm=1 tr=0 ts=6824e8a7 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8
 a=fmczn3qS4knw4DMiZZIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-14_04,2025-05-14_03,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505140169
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
> This improves the implementation of pulling pool and phys contexts in
> XIVE1, by following closer the OS pulling code.
>
> In particular, the old ring data is returned rather than the modified,
> and irq signals are reset on pull.

Reviewed-by: Michael Kowal <kowal@linux.ibm.com>

Thanks MAK


>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   hw/intc/xive.c | 66 ++++++++++++++++++++++++++++++++++++++++++++------
>   1 file changed, 58 insertions(+), 8 deletions(-)
>
> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> index c2da23f9ea..1a94642c62 100644
> --- a/hw/intc/xive.c
> +++ b/hw/intc/xive.c
> @@ -241,25 +241,75 @@ static uint64_t xive_tm_ack_hv_reg(XivePresenter *xptr, XiveTCTX *tctx,
>       return xive_tctx_accept(tctx, TM_QW3_HV_PHYS);
>   }
>   
> +static void xive_pool_cam_decode(uint32_t cam, uint8_t *nvt_blk,
> +                                 uint32_t *nvt_idx, bool *vp)
> +{
> +    if (nvt_blk) {
> +        *nvt_blk = xive_nvt_blk(cam);
> +    }
> +    if (nvt_idx) {
> +        *nvt_idx = xive_nvt_idx(cam);
> +    }
> +    if (vp) {
> +        *vp = !!(cam & TM_QW2W2_VP);
> +    }
> +}
> +
> +static uint32_t xive_tctx_get_pool_cam(XiveTCTX *tctx, uint8_t *nvt_blk,
> +                                       uint32_t *nvt_idx, bool *vp)
> +{
> +    uint32_t qw2w2 = xive_tctx_word2(&tctx->regs[TM_QW2_HV_POOL]);
> +    uint32_t cam = be32_to_cpu(qw2w2);
> +
> +    xive_pool_cam_decode(cam, nvt_blk, nvt_idx, vp);
> +    return qw2w2;
> +}
> +
> +static void xive_tctx_set_pool_cam(XiveTCTX *tctx, uint32_t qw2w2)
> +{
> +    memcpy(&tctx->regs[TM_QW2_HV_POOL + TM_WORD2], &qw2w2, 4);
> +}
> +
>   static uint64_t xive_tm_pull_pool_ctx(XivePresenter *xptr, XiveTCTX *tctx,
>                                         hwaddr offset, unsigned size)
>   {
> -    uint32_t qw2w2_prev = xive_tctx_word2(&tctx->regs[TM_QW2_HV_POOL]);
>       uint32_t qw2w2;
> +    uint32_t qw2w2_new;
> +    uint8_t nvt_blk;
> +    uint32_t nvt_idx;
> +    bool vp;
>   
> -    qw2w2 = xive_set_field32(TM_QW2W2_VP, qw2w2_prev, 0);
> -    memcpy(&tctx->regs[TM_QW2_HV_POOL + TM_WORD2], &qw2w2, 4);
> +    qw2w2 = xive_tctx_get_pool_cam(tctx, &nvt_blk, &nvt_idx, &vp);
> +
> +    if (!vp) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: pull invalid POOL NVT %x/%x !?\n",
> +                      nvt_blk, nvt_idx);
> +    }
> +
> +    /* Invalidate CAM line */
> +    qw2w2_new = xive_set_field32(TM_QW2W2_VP, qw2w2, 0);
> +    xive_tctx_set_pool_cam(tctx, qw2w2_new);
> +
> +    xive_tctx_reset_signal(tctx, TM_QW1_OS);
> +    xive_tctx_reset_signal(tctx, TM_QW2_HV_POOL);
>       return qw2w2;
>   }
>   
>   static uint64_t xive_tm_pull_phys_ctx(XivePresenter *xptr, XiveTCTX *tctx,
>                                         hwaddr offset, unsigned size)
>   {
> -    uint8_t qw3b8_prev = tctx->regs[TM_QW3_HV_PHYS + TM_WORD2];
> -    uint8_t qw3b8;
> +    uint8_t qw3b8 = tctx->regs[TM_QW3_HV_PHYS + TM_WORD2];
> +    uint8_t qw3b8_new;
> +
> +    qw3b8 = tctx->regs[TM_QW3_HV_PHYS + TM_WORD2];
> +    if (!(qw3b8 & TM_QW3B8_VT)) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: pulling invalid PHYS thread!?\n");
> +    }
> +    qw3b8_new = qw3b8 & ~TM_QW3B8_VT;
> +    tctx->regs[TM_QW3_HV_PHYS + TM_WORD2] = qw3b8_new;
>   
> -    qw3b8 = qw3b8_prev & ~TM_QW3B8_VT;
> -    tctx->regs[TM_QW3_HV_PHYS + TM_WORD2] = qw3b8;
> +    xive_tctx_reset_signal(tctx, TM_QW1_OS);
> +    xive_tctx_reset_signal(tctx, TM_QW3_HV_PHYS);
>       return qw3b8;
>   }
>   
> @@ -489,7 +539,7 @@ static uint64_t xive_tm_pull_os_ctx(XivePresenter *xptr, XiveTCTX *tctx,
>       qw1w2 = xive_tctx_get_os_cam(tctx, &nvt_blk, &nvt_idx, &vo);
>   
>       if (!vo) {
> -        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: pulling invalid NVT %x/%x !?\n",
> +        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: pull invalid OS NVT %x/%x !?\n",
>                         nvt_blk, nvt_idx);
>       }
>   

