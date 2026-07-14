Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CB9DC44508
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 12:29:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjcFW-0003Ia-Ft; Tue, 14 Jul 2026 08:28:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1wjcFU-0003Hs-IS; Tue, 14 Jul 2026 08:28:32 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1wjcFT-0004vS-4g; Tue, 14 Jul 2026 08:28:32 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66EBgE1Y1195386; Tue, 14 Jul 2026 12:28:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=mpa7L6
 GpXZe/xgjQRF5U/+NbZJaVtJrK4g2sYpzfE1w=; b=WYqxYUbqJVGInCyRJ6cuaO
 fcrGwRAMpmq6zoK8/LGIeyLfGmcKFqPbpZEC85xf7xg2wVfqSPDmQqivW5D7GkQp
 xB41CgycEUx2MFfgUgncgDK66F1gGHcGfTMI8sji7y+Zb27StZsVCSJC1LolLQZy
 xeeqeYf0OxMyzfXO/PMMMYnFmEwGbo+gYrfdlZ6a8g0ChMBok5MvmPb2RR+VJgc6
 tOaqT2rsjZuAfW/Atg13rgLs9tPaqiiz9ShlfTyiILuXP5yhvHHjO9dCa1zp4yLh
 6qSn0f4NmoWWwVK302ikrOCVLyhQjmvcby1kK5TieWnVdLO/Vwn4yTZsj19tV+sg
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbegbnmms-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 14 Jul 2026 12:28:27 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66ECJesX019358;
 Tue, 14 Jul 2026 12:28:27 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fc05q2wx6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 14 Jul 2026 12:28:27 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66ECSP4Z25100782
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 14 Jul 2026 12:28:25 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 488CA20043;
 Tue, 14 Jul 2026 12:28:25 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0FE3520040;
 Tue, 14 Jul 2026 12:28:25 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.111.75.242])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 14 Jul 2026 12:28:24 +0000 (GMT)
Message-ID: <4842810e-21e8-452f-8b49-2a0c4dbb8e68@linux.ibm.com>
Date: Tue, 14 Jul 2026 14:28:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/51] exec/watchpoint: Add CPUWatchpoint.id
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org, jcmvbkbc@gmail.com
References: <20260710205401.836304-1-richard.henderson@linaro.org>
 <20260710205401.836304-8-richard.henderson@linaro.org>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20260710205401.836304-8-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=fOcJG5ae c=1 sm=1 tr=0 ts=6a562b6c cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=KKAkSRfTAAAA:8
 a=VnNF1IyMAAAA:8 a=Bs_vCHwtGeDls6627E8A:9 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDEyNyBTYWx0ZWRfXx1Fm/fA762xU
 KCah4Ty42PVYArTA0qgpPfgZUpV/pa2QwJtiz2ow3rmA1/XeaKwY2T2cXLVwOOOV5u1DTjSA3B/
 O6CinyAtUA2o3e837emp9TE0PX8H/ayUmVK9dcD7CWOi/R16wcCtFfgRAhHJn+872XivzrDmcLV
 pUeRS2nQAMqe3wX/FazO/LT+L0Yp9Vm6MNO5hsFnsN/bR7toDRgNrKHVfBq8GbK7HlApGYIrdJO
 czXG/92utDnBUCK0v5yE64CSz//cXxu1W1Z8syG4GoaE2HAw2f8c8ItNE/sldL2yJRwHgntF8Yv
 DXESmSeodfHWNsEiJF4P3JB1033ukOMlBxj6V9IbHgK14InugRqw5X9XHMrCr8bvMZKSj4WnPGS
 OgWRndqEKXh2PBeoIfQfmBKb15E1OZICIUPpx7msMPKfCkSyutiyP6QdAOpK6EP3ZHbSkvYmLi6
 ed8A4cC+m39KS2am9Xw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDEyNyBTYWx0ZWRfX7ZMAn29o+xda
 tSD37yRKXLPo/IDBt32lYqvvwPJ4sUnJaNIFIKiC25eDrpacyzdirz5NHt+/SvmUBS2fvVVpbr7
 C+U3ufbgxjd4aUPZFA7eWiTqAyeu6PU=
X-Proofpoint-GUID: av0yhXGf3gPjn5rFcm2RHJsVDJV11Nmd
X-Proofpoint-ORIG-GUID: aUs36QupULD5kwa0cAaHFxZ0WB6-b1gL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_03,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607140127
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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



On 7/10/26 22:53, Richard Henderson wrote:
> Add an identifier for use by targets with BP_CPU.  For most targets
> the index of the hardware breakpoint resource is to hand.  For s390x,
> there is only one resource so use id 0.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/exec/breakpoint.h           |  4 +++-
>   accel/tcg/tcg-accel-ops.c           |  2 +-
>   accel/tcg/user-exec-stub.c          |  3 ++-
>   system/watchpoint.c                 |  3 ++-
>   target/arm/tcg/debug.c              |  2 +-
>   target/i386/tcg/system/bpt_helper.c |  4 ++--
>   target/ppc/cpu.c                    |  3 ++-
>   target/riscv/debug.c                |  8 ++++----
>   target/s390x/tcg/debug.c            | 11 +++++------
>   target/xtensa/dbg_helper.c          |  2 +-
>   10 files changed, 23 insertions(+), 19 deletions(-)
s390x does have only one resource, but it can cover any range :-)


Reviewed-by: Ilya Leoskevich <iii@linux.ibm.com>

