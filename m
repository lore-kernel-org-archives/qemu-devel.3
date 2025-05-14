Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E62BEC3ABD8
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 19:48:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFI5d-0001eY-S2; Wed, 14 May 2025 15:48:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1uFI4N-0008Sa-9W; Wed, 14 May 2025 15:47:11 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1uFI4L-00010D-IE; Wed, 14 May 2025 15:47:11 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54EIoMA3031095;
 Wed, 14 May 2025 19:47:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=kVNLkD
 CbbKdbDxO3S+UlVaL72iTo4v9ZQxP7hgYHPEA=; b=SRoZEw42g0dOlWu7PRSgXC
 Zk7YSD+nETK2UeeWhb558/xGcwfzCkLmdVFpfsXP0IeEDSAvj+bCDBaExh6NJ2dZ
 TrqVIHdtYFfx3fnpR8HRO2ykyN8IMRdRkUkXjHT8+MddCcUkeUzGDiCiVkh3cREZ
 C6JGMQ/pPRwIQpl3iSY8REzRx2z5fmQxg9tllR3ruyGWz3mFMH3awEGR4rBDF04y
 3tWplKcVqm2TA72bjQVm4tkmOTAWrWgl4OW1CA6rOtkoQY4oAw0FndddtwboveRZ
 nWI55i60VPRNr+/Kjod296QBV+vfDJ28df/x9khPV0zFmFy64eeETe/ZEbyEHXxg
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46n0t98a1b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 May 2025 19:47:07 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54EJl67M025304;
 Wed, 14 May 2025 19:47:06 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46n0t98a19-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 May 2025 19:47:06 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54EJQwGi021455;
 Wed, 14 May 2025 19:47:05 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46mbfrp5y9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 May 2025 19:47:05 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 54EJl4d523724566
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 14 May 2025 19:47:04 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3D10858054;
 Wed, 14 May 2025 19:47:04 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id ACA715804E;
 Wed, 14 May 2025 19:47:03 +0000 (GMT)
Received: from [9.10.80.143] (unknown [9.10.80.143])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 14 May 2025 19:47:03 +0000 (GMT)
Message-ID: <71381de3-796a-4707-840d-48ada1ab7059@linux.ibm.com>
Date: Wed, 14 May 2025 14:47:03 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 24/50] ppc/xive2: Improve pool regs variable name
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?=
 <fbarrat@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Caleb Schlossin <calebs@linux.vnet.ibm.com>
References: <20250512031100.439842-1-npiggin@gmail.com>
 <20250512031100.439842-25-npiggin@gmail.com>
Content-Language: en-US
From: Mike Kowal <kowal@linux.ibm.com>
In-Reply-To: <20250512031100.439842-25-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=etzfzppX c=1 sm=1 tr=0 ts=6824f33b cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=zwZabxx_P4Ew84Oz15sA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE0MDE4MCBTYWx0ZWRfX5jsOJkoTtQrd
 0oVGitO4oCdkwvxswod2OrUUBvFynKX2Y3eCXRMZRNiJ6AbmzUR3PKwvG4i6Pl9XEZUul4kbFjB
 jtF9OZ8fAWR4Rx7Kbd2g8+VNlk4yNdMpzdFAyXQlyhLcAe/3mplx0HMwsTLQ8AHdWZjxRbDXuvv
 mZiLcxWG4m9GKR4T4SnHyHwY9aAOzLkfQlxAYW0x+nwApznIo7rZSpk9kecg21GTPRvJikJGhVW
 ueMsVTg6I7w0C6YqfolQXAHjyvUXfxlfqK6iX/YNFMtQucxGrBKur1Z+gN8Kd334ZEBhoO2jvjB
 Z3Sdz90ah2gZJfbTjkKIX1oC+wA2gK6+KCeS07jaRDIg5gEZxOALasZyF/nfaIEfINn0eQS7Cgq
 /Kx/XhTA5CzADQPl5PadL/1naDysPVWnXArwibPaB8Ca7aFbApmXuHf2LlUyK24dYykr0252
X-Proofpoint-ORIG-GUID: _qHLdI9YIbmzI4u2OLTHpGb_7_gnyY8F
X-Proofpoint-GUID: 7TyviRGtIBOYOWmKmE7gVKGE6XNZTbzt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-14_04,2025-05-14_03,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 lowpriorityscore=0 phishscore=0 mlxscore=0 mlxlogscore=944 bulkscore=0
 suspectscore=0 spamscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505140180
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
> From: Glenn Miles <milesg@linux.ibm.com>
>
> Change pregs to pool_regs, for clarity.

Reviewed-by: Michael Kowal<kowal@linux.ibm.com>

Thanks,  MAK

>
> [npiggin: split from larger patch]
> Signed-off-by: Glenn Miles <milesg@linux.ibm.com>
> ---
>   hw/intc/xive2.c | 11 +++++------
>   1 file changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
> index 968b698677..ec4b9320b4 100644
> --- a/hw/intc/xive2.c
> +++ b/hw/intc/xive2.c
> @@ -1044,13 +1044,12 @@ again:
>   
>       /* PHYS updates also depend on POOL values */
>       if (ring == TM_QW3_HV_PHYS) {
> -        uint8_t *pregs = &tctx->regs[TM_QW2_HV_POOL];
> +        uint8_t *pool_regs = &tctx->regs[TM_QW2_HV_POOL];
>   
>           /* POOL values only matter if POOL ctx is valid */
> -        if (pregs[TM_WORD2] & 0x80) {
> -
> -            uint8_t pool_pipr = xive_ipb_to_pipr(pregs[TM_IPB]);
> -            uint8_t pool_lsmfb = pregs[TM_LSMFB];
> +        if (pool_regs[TM_WORD2] & 0x80) {
> +            uint8_t pool_pipr = xive_ipb_to_pipr(pool_regs[TM_IPB]);
> +            uint8_t pool_lsmfb = pool_regs[TM_LSMFB];
>   
>               /*
>                * Determine highest priority interrupt and
> @@ -1064,7 +1063,7 @@ again:
>               }
>   
>               /* Values needed for group priority calculation */
> -            if (pregs[TM_LGS] && (pool_lsmfb < lsmfb_min)) {
> +            if (pool_regs[TM_LGS] && (pool_lsmfb < lsmfb_min)) {
>                   group_enabled = true;
>                   lsmfb_min = pool_lsmfb;
>                   if (lsmfb_min < pipr_min) {

