Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BEEBC3ABD8
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 18:52:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFHCk-0003pE-AY; Wed, 14 May 2025 14:51:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1uFHBy-0003BU-BT; Wed, 14 May 2025 14:50:58 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1uFHBw-0005R8-9Z; Wed, 14 May 2025 14:50:57 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54EGnIpf012692;
 Wed, 14 May 2025 18:50:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=dJVFRQ
 XSjR8eEtEhjYpf7r/gaQu+JLlpC+k6TKynSZA=; b=O4+GH6TrCR9vD5w9e3r3ze
 OT+hALHILoa7Y4oa5qFFmk+iiRjoQCsVvxspR3Rpr4mzHrPWIauMEe5JTYlU9H+t
 wy2eLjWsHoz83fExoypL+C/jALW4Lv1s6dBuy70hD97E5sRGIEcf255+U8aCSHCh
 078WQnAKMEnL0X31Pu/1t6dxXjsp1HY7cBor7b1v+EIm82QcEIVSDFFLaTEejCoj
 k8fACJ0aOhqU98VUhYsBbQonvLhlFSly2CMbWcUncEzgKUYFUHVUkzHwOwIknjB6
 0pxepaXcDhLkKed9Bwo56/hto2GmI8mVsVF+Y+qa3Z4teMSKw1ZQI3dsn1yqWKag
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46mrcjaxru-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 May 2025 18:50:55 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54EIk6rK008788;
 Wed, 14 May 2025 18:50:54 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46mrcjaxrb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 May 2025 18:50:54 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54EGZb1G021459;
 Wed, 14 May 2025 18:50:54 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46mbfrnw3w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 May 2025 18:50:54 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 54EIoqCZ30474938
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 14 May 2025 18:50:52 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A00EF58055;
 Wed, 14 May 2025 18:50:52 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2163B5804E;
 Wed, 14 May 2025 18:50:52 +0000 (GMT)
Received: from [9.10.80.143] (unknown [9.10.80.143])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 14 May 2025 18:50:52 +0000 (GMT)
Message-ID: <9b1537e1-9c40-47c1-ab92-8adda3d0b554@linux.ibm.com>
Date: Wed, 14 May 2025 13:50:51 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/50] ppc/xive2: Reset Generation Flipped bit on END
 Cache Watch
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?=
 <fbarrat@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Caleb Schlossin <calebs@linux.vnet.ibm.com>
References: <20250512031100.439842-1-npiggin@gmail.com>
 <20250512031100.439842-8-npiggin@gmail.com>
Content-Language: en-US
From: Mike Kowal <kowal@linux.ibm.com>
In-Reply-To: <20250512031100.439842-8-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=ZYgdNtVA c=1 sm=1 tr=0 ts=6824e60f cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=u5XRYQ9GfIdERzJa8uoA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: S4hSHrqmBY_vzIcdAkiKK-0jFjvCuEnh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE0MDE2OSBTYWx0ZWRfX8DBXd2FDq4+4
 uOwVYdXyktTR0CZSRwe4SeKO8oWHIArB2JxtKu6la0Mqcnh/OHWSZ/M194yJJ+Oy4+T98U64FzZ
 r8d4DRrUgSKh+mymfV//1ghJXEGZTosaGiMJfH+FMhYsHA+GqVxi/ujtb1Yz/hwgdV6C9i1UxXN
 Uz+Z2UgmHeVOClzIcP7X4uPRTSed+Rp8IOwuXmkfzBJMJghgZIz1p21HsZabhOvKXGMt7+37EES
 cwB9aHoQcnMr9DsBN8UVn6O8lvmEHCXd6qeuopkSmncX/GVQn7cbfKTxs96bi2UYmWWwpo4uFhL
 0Z4N7Xt1+QekS09sRJVjFUmvJ4TRinJG7ERMkuU7nigPbV6E2VB8xb6lwP6a/8B42KeLCrO3fS5
 YLHe/oyuvHm3THr8/vyiHHGNIIZl6ndN2JiktvSlmArNfSMZmhv+rG/BIE6KV2FfZZ77VPXP
X-Proofpoint-GUID: lYjjQVEOdLL5MqHyY5urrbyIwjkuSsGy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-14_04,2025-05-14_03,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 mlxscore=0 spamscore=0
 suspectscore=0 bulkscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505070000
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
> From: Michael Kowal <kowal@linux.ibm.com>
>
> When the END Event Queue wraps the END EQ Generation bit is flipped and the
> Generation Flipped bit is set to one.  On a END cache Watch read operation,
> the Generation Flipped bit needs to be reset.
>
> While debugging an error modified END not valid error messages to include
> the method since all were the same.

Reviewed-by: Michael Kowal <kowal@linux.ibm.com>

Thanks MAK


>
> Signed-off-by: Michael Kowal <kowal@linux.ibm.com>
> ---
>   hw/intc/pnv_xive2.c | 3 ++-
>   hw/intc/xive2.c     | 4 ++--
>   2 files changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/hw/intc/pnv_xive2.c b/hw/intc/pnv_xive2.c
> index 30b4ab2efe..72cdf0f20c 100644
> --- a/hw/intc/pnv_xive2.c
> +++ b/hw/intc/pnv_xive2.c
> @@ -1325,10 +1325,11 @@ static uint64_t pnv_xive2_ic_vc_read(void *opaque, hwaddr offset,
>       case VC_ENDC_WATCH3_DATA0:
>           /*
>            * Load DATA registers from cache with data requested by the
> -         * SPEC register
> +         * SPEC register.  Clear gen_flipped bit in word 1.
>            */
>           watch_engine = (offset - VC_ENDC_WATCH0_DATA0) >> 6;
>           pnv_xive2_end_cache_load(xive, watch_engine);
> +        xive->vc_regs[reg] &= ~(uint64_t)END2_W1_GEN_FLIPPED;
>           val = xive->vc_regs[reg];
>           break;
>   
> diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
> index 4dd04a0398..453fe37f18 100644
> --- a/hw/intc/xive2.c
> +++ b/hw/intc/xive2.c
> @@ -374,8 +374,8 @@ static void xive2_end_enqueue(Xive2End *end, uint32_t data)
>           qgen ^= 1;
>           end->w1 = xive_set_field32(END2_W1_GENERATION, end->w1, qgen);
>   
> -        /* TODO(PowerNV): reset GF bit on a cache watch operation */
> -        end->w1 = xive_set_field32(END2_W1_GEN_FLIPPED, end->w1, qgen);
> +        /* Set gen flipped to 1, it gets reset on a cache watch operation */
> +        end->w1 = xive_set_field32(END2_W1_GEN_FLIPPED, end->w1, 1);
>       }
>       end->w1 = xive_set_field32(END2_W1_PAGE_OFF, end->w1, qindex);
>   }

