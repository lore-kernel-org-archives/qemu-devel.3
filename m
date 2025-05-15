Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83C33C2D0CD
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 15:44:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFakC-0001Gs-Og; Thu, 15 May 2025 11:43:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1uFakB-0001CK-BE; Thu, 15 May 2025 11:43:35 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1uFak9-00067u-5E; Thu, 15 May 2025 11:43:34 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54FCg561002277;
 Thu, 15 May 2025 15:43:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=wNLaAT
 ms/IfH4TryaYduKLF3sLhTtn659EMkwMekuvU=; b=X2WFi9YSBcsRbSUI2WuPOJ
 Ax9S2JbCVGcve2WPGm4X6/YOl4q8wUuLvFfuRLdcWfeUZyZaWlz/cAtALvb+hGzw
 RMCuX7Bz4+04fbS6cdHp1rEU2vr14XhBGxl0/RHHlZO5sz5DMpNQdBMw0Rpq5mtv
 OIqBRyN3TQoqFyaXhvV18/1b2DTskZS8RhCg2I5Rm3VS6wmCM6ifTltQkZAz6Yun
 Are6lci1s3wgDFMW194TXxmCuWnmrPSuR+Zx2pE+so5ORaWeQG8T4UDzuM4tXC5I
 /6eUXRae0kp3aZ7ijAub4UcNjVT4T0RsbgZuGhRsGazOx6ApuHq0FWLsdHv0c/2w
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46n0v6ndjm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 15:43:28 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54FFTPpE011769;
 Thu, 15 May 2025 15:43:28 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46n0v6ndjk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 15:43:28 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54FE3Xot021793;
 Thu, 15 May 2025 15:43:27 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46mbfpu16h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 15:43:27 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 54FFhQ4K30147178
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 15 May 2025 15:43:26 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 76B7D58058;
 Thu, 15 May 2025 15:43:26 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 245BC5805D;
 Thu, 15 May 2025 15:43:26 +0000 (GMT)
Received: from [9.10.80.143] (unknown [9.10.80.143])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 15 May 2025 15:43:26 +0000 (GMT)
Message-ID: <01a04608-18ba-4a83-9627-34a596e6a11d@linux.ibm.com>
Date: Thu, 15 May 2025 10:43:25 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 41/50] ppc/xive2: Prevent pulling of pool context losing
 phys interrupt
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?=
 <fbarrat@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Caleb Schlossin <calebs@linux.vnet.ibm.com>
References: <20250512031100.439842-1-npiggin@gmail.com>
 <20250512031100.439842-42-npiggin@gmail.com>
Content-Language: en-US
From: Mike Kowal <kowal@linux.ibm.com>
In-Reply-To: <20250512031100.439842-42-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=IqAecK/g c=1 sm=1 tr=0 ts=68260ba0 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8
 a=N5jOW-pyvUPM4XXbhVEA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: Fb0Vg-_sJBIT5HBmh4n-G6c_PRTm_gJd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDE1NSBTYWx0ZWRfX2EEE9M0/ddkB
 Bh1iQQwcCS+093UtigWU9ELza6zvdZ5e5VSizrBcZ5MnN413vQZ6Yk4552WO1K7iFXDfsdkGAkN
 bwXOCkK9haySsABP2woixPm654p7MmaUi1gx7oxUZNGuAIz+a++4+DzqVm5jb9Bv4X0+h/eiE7v
 1JJIm9HufKfeBg5clpdSQvxhlOQilIp/TAx8Z4nTrymVNvAsb6puQdA1XrOxDgHhv7i3OXEFk+g
 y6Bb7awnoDZKYyh7t44/jYghM0IsKGnmJfycxh9s837ThysR4xH+LXhT1iHDUs6q+sSctyoNGkN
 woMPle48KJWl6f2s1S7BfwqlVW5coUCQDrxc/Ql4bMpZ89ahm8HF03yRpfuajjJZRGfB3lZiZaP
 g/bDbFt82k2riY/wSPC1dGpczm/4pVEAqDuDheGi+lXxumXXxJVsqXLjeEHzXn+a+osqgu7N
X-Proofpoint-GUID: -Rn6wBYcbe0IZTuxF8B3F67H_2UfigY4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_06,2025-05-15_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 malwarescore=0
 adultscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0
 priorityscore=1501 clxscore=1015 spamscore=0 mlxlogscore=904 bulkscore=0
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
> When the pool context is pulled, the shared pool/phys signal is
> reset, which loses the qemu irq if a phys interrupt was presented.
>
> Only reset the signal if a poll irq was presented.

Reviewed-by: Michael Kowal<kowal@linux.ibm.com>

Thanks,  MAK
>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   hw/intc/xive2.c | 18 ++++++++++--------
>   1 file changed, 10 insertions(+), 8 deletions(-)
>
> diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
> index d899c1fb14..aeeb901b6a 100644
> --- a/hw/intc/xive2.c
> +++ b/hw/intc/xive2.c
> @@ -727,20 +727,22 @@ static uint64_t xive2_tm_pull_ctx(XivePresenter *xptr, XiveTCTX *tctx,
>                   xive2_redistribute(xrtr, tctx, cur_ring);
>               }
>           }
> +
> +        /*
> +         * Lower external interrupt line of requested ring and below except for
> +         * USER, which doesn't exist.
> +         */
> +        if (xive_nsr_indicates_exception(cur_ring, nsr)) {
> +            if (cur_ring == xive_nsr_exception_ring(cur_ring, nsr)) {
> +                xive_tctx_reset_signal(tctx, cur_ring);
> +            }
> +        }
>       }
>   
>       if (xive2_router_get_config(xrtr) & XIVE2_VP_SAVE_RESTORE && do_save) {
>           xive2_tctx_save_ctx(xrtr, tctx, ring, nvp_blk, nvp_idx);
>       }
>   
> -    /*
> -     * Lower external interrupt line of requested ring and below except for
> -     * USER, which doesn't exist.
> -     */
> -    for (cur_ring = TM_QW1_OS; cur_ring <= ring;
> -         cur_ring += XIVE_TM_RING_SIZE) {
> -        xive_tctx_reset_signal(tctx, cur_ring);
> -    }
>       return target_ringw2;
>   }
>   

