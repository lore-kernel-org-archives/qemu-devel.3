Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8184CC6B03
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 09:22:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGYhc-0001wi-1B; Tue, 13 Oct 2026 05:21:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1xGYhZ-0001wB-HD; Tue, 13 Oct 2026 05:21:41 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1xGYhX-00044l-LB; Tue, 13 Oct 2026 05:21:41 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69D2EL0a1931562; Tue, 13 Oct 2026 09:21:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=bUz23b
 DEd43sdAIYYcoSsK00XgCqVCjVfCTcdNn5I+A=; b=LQMhQQ3P88xyL8ydt+itve
 4MUryRM4lJAXR2KNMI6xsDb7RiBQfJWu6JcTBg379vCC7E+Tf5FnrrFDae62fujT
 Hwu8z3WzLDftG65SZFaohc+g1XbCBf5WlRPQFCMYRqDbsUE54AInF2Oy5N2uQkCm
 l4GxzwAEnvNuDtUHoEBUV9n8Rnm6yBFRziynsWY1C/JEW1uJtvwt3AM7W9ORaA4Q
 ieDwopkhQ/PtOUDIHV54eorj0FryN+2gzJpeYocUL7rZ80IsTf9rfNMJoTf9dUku
 pLxtmCvhWaKAEYcvkDN9YE4DDZNsIN2XYwhl/DKATS2kkdMZzMIWzRK2Sq/SdI9w
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7e1w4qh4-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 13 Oct 2026 09:21:37 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 69D8UQNs1440163; Tue, 13 Oct 2026 09:21:36 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h81wg0ujn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 13 Oct 2026 09:21:36 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 69D9LZPb7013060
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 13 Oct 2026 09:21:35 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5970858061;
 Tue, 13 Oct 2026 09:21:35 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8F55C58043;
 Tue, 13 Oct 2026 09:21:32 +0000 (GMT)
Received: from [9.123.8.229] (unknown [9.123.8.229])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 13 Oct 2026 09:21:32 +0000 (GMT)
Message-ID: <390d3f37-30f4-4bbf-98d7-7535c088bf25@linux.ibm.com>
Date: Tue, 13 Oct 2026 14:51:31 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/17] target/ppc: Enable byte comparison and parity on
 e5500 and e6500
To: Bin Meng <bin.meng@processmission.com>, QEMU <qemu-devel@nongnu.org>
Cc: Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Glenn Miles <milesg@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
References: <20261006094921.110871-1-bin.meng@processmission.com>
 <20261006094921.110871-14-bin.meng@processmission.com>
Content-Language: en-US
From: Chinmay Rath <rathc@linux.ibm.com>
In-Reply-To: <20261006094921.110871-14-bin.meng@processmission.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDAzNiBTYWx0ZWRfX3LJkLpP0lR1H
 bhX7nWZ4tzy1Ni5uybctUj58kjgV/R4a64ZPQ85NLm6rRjhxG8zmPOI6P/Eu8M/PhG1OPf3COKO
 Zl9e52ENArTDzCykmOp0UUIthASbJEg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDAzNiBTYWx0ZWRfX+WfgXslOng7m
 AQ3ZAjrOQlByFgietlCjTFEafqBd/APV32oOZ6D0AUF157OVqBpfyGR/D3SVkJmwhTelmGEiWJq
 vHHfAJpmT3jZTA/5Lwb198Zsh+xMV34cLfRmcEtaX2QfnbIJyvXh+xDvsc5sI8/pZ79qnDd6i++
 9I6mdkB7viFiteHHmzC31os2MT9QGBZLgS9LmmGHr0InKShdIDsWGK0uHR1w4zTwGqAYVoqvQhE
 DVIHH51NWBsoCk/bMKGvLLyQbvEQpQBnAhTVHd7haHm3gh0+rg0PQi21IoUI2H2/X5snOvvhwvQ
 vlryhwZVyOtD/PpFB9i+pW7siqq8wTSLGbvbh0orQUIUeWcweXqQgHju+cic1LbUzSaxUn50Jba
 heehHrByPr5MIiru7HVR4PXU0H7GyHe5h+CBhQt/uEt2FWSmend0bgHR1kcZPzYzMTQ41pBJcke
 dtLedPDiq63VfMYXCkA==
X-Authority-Analysis: v=2.4 cv=E6pYNqdl c=1 sm=1 tr=0 ts=6acdf821 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=8AirrxEcAAAA:8
 a=FRSEYCzRAAAA:8 a=sD9Bos6riIcO1BNLf-MA:9 a=QEXdDO2ut3YA:10
 a=ST-jHhOKWsTCqRlWije3:22 a=H4N_Y-AU75W7NKDNhZlT:22
X-Proofpoint-ORIG-GUID: kMoo6Ofl_wWWgYy4uLfCMjH2FnC9jxuV
X-Proofpoint-GUID: 4iNd6-sscg3NA0g3Img1465GZ2KQmwpy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 spamscore=0 adultscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610130036
Received-SPF: pass client-ip=148.163.158.5; envelope-from=rathc@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


On 10/6/26 15:19, Bin Meng wrote:
> The e5500 and e6500 implement cmpb, prtyw and prtyd, as listed in
> table 3-7 of their reference manuals.
>
> Enable only the byte comparison and parity feature flags on these
> cores. The e500mc explicitly excludes cmpb and prtyw in table 3-1,
> so keep these features disabled there. Unsupported floating-point
> instructions and extended FPSCR access remain disabled.
Hey,
With this change, I observe 2 distinct sets of the new ISA205 flags 
introduced in this series :
1. PPC2_CMPB_ISA205 and PPC2_PRTY_ISA205, used always together with each 
other in cpu initialization, for e5500 and e6500.
and
2. The other 4 PPC2_xxx_ISA205 flags, which are always used together in 
cpu initialization of various CPUs.

This makes me wonder, why not just have 2 PPC2_xxx_ISA205 flags, one for 
each of these sets instead of 6 ? The said proposed 2 flags will 
accurately capture the behavior needed by the series since no machine 
during its initialization uses a subset of the above mentioned 2 sets. 
This leaves room for future flag bits.

Thoughts ?

Thanks,
Chinmay
>
> Reference:
> - E500MCRM (Rev.3), section 3.1.1
>    https://www.nxp.com/docs/en/reference-manual/E500MCRM.pdf
> - E5500RM (Rev.4), section 3.1.1 and 3.4.3.1.3
>    https://www.nxp.com/webapp/Download?colCode=E5500RM
> - E6500RM (Rev.0), section 3.1.1 and 3.4.3.1.3
>    https://www.nxp.com/docs/en/reference-manual/E6500RM.pdf
>
> Signed-off-by: Bin Meng <bin.meng@processmission.com>
> ---
>
>   target/ppc/cpu_init.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
> index f2a342b076..1c02354e11 100644
> --- a/target/ppc/cpu_init.c
> +++ b/target/ppc/cpu_init.c
> @@ -3216,7 +3216,7 @@ POWERPC_FAMILY(e5500)(ObjectClass *oc, const void *data)
>                          PPC_MEM_TLBSYNC | PPC_TLBIVAX | PPC_MEM_SYNC |
>                          PPC_64B | PPC_POPCNTB | PPC_POPCNTWD;
>       pcc->insns_flags2 = PPC2_BOOKE206 | PPC2_PRCNTL | PPC2_PERM_ISA206 |
> -                        PPC2_FP_CVT_S64;
> +                        PPC2_FP_CVT_S64 | PPC2_CMPB_ISA205 | PPC2_PRTY_ISA205;
>       pcc->msr_mask = (1ull << MSR_CM) |
>                       (1ull << MSR_GS) |
>                       (1ull << MSR_UCLE) |
> @@ -3265,7 +3265,8 @@ POWERPC_FAMILY(e6500)(ObjectClass *oc, const void *data)
>                          PPC_MEM_TLBSYNC | PPC_TLBIVAX | PPC_MEM_SYNC |
>                          PPC_64B | PPC_POPCNTB | PPC_POPCNTWD | PPC_ALTIVEC;
>       pcc->insns_flags2 = PPC2_BOOKE206 | PPC2_PRCNTL | PPC2_PERM_ISA206 |
> -                        PPC2_FP_CVT_S64 | PPC2_ATOMIC_ISA206;
> +                        PPC2_FP_CVT_S64 | PPC2_ATOMIC_ISA206 |
> +                        PPC2_CMPB_ISA205 | PPC2_PRTY_ISA205;
>       pcc->msr_mask = (1ull << MSR_CM) |
>                       (1ull << MSR_GS) |
>                       (1ull << MSR_UCLE) |

