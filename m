Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB4FBCD98F3
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 12:51:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waCA8-0001ji-JN; Thu, 18 Jun 2026 08:48:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fcallies@linux.ibm.com>)
 id 1wa596-0000jN-IX; Thu, 18 Jun 2026 01:18:32 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fcallies@linux.ibm.com>)
 id 1wa594-0004kI-B6; Thu, 18 Jun 2026 01:18:32 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65HHmNg91250962; Thu, 18 Jun 2026 05:18:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=Ul2lpy
 gMmk5Bgkmm0OVzYMry2gJVaQXV30FxWdOLe6E=; b=CfsX2t6UhnpmaxocSTW7dN
 kWP6MPcLv81Pu1MWPjan5aipK6Eimf67cHvXnXLLFBIPMSqymzwF+E4PDgTPUMLc
 XXV3T8BBO1EKzZyJN2HR+1fQXi/Nn2OTgC5s6i0yFkNPvQoVVzN7fELCaIl8fH6y
 wUcO3U+u95sxBHRZYpvQ8Di/v4oaYug0r3Ict9DUzUl3yF4bx0jMRk4VlAw+2oFu
 fu0Iv33jbqim19z5b3347O9Fn/0F7al2M3c79uiF8rKoS+JVnWTk7NBovKSpYMkp
 NAMN0nIuPLQkM2nP08jHKRCl4KQST/RV7mGQDYNFDTZ5CUUarKZJ3xjjod5YtZPQ
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4euequ6em3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 Jun 2026 05:18:25 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65I54l8P031755;
 Thu, 18 Jun 2026 05:18:24 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ev172a4bw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 Jun 2026 05:18:24 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65I5IKOr57934252
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 18 Jun 2026 05:18:20 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6551820043;
 Thu, 18 Jun 2026 05:18:20 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 32A4520040;
 Thu, 18 Jun 2026 05:18:20 +0000 (GMT)
Received: from [9.224.89.241] (unknown [9.224.89.241])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 18 Jun 2026 05:18:20 +0000 (GMT)
Message-ID: <1c0b83e3-a9f6-423f-8330-d51ca26a196c@linux.ibm.com>
Date: Thu, 18 Jun 2026 07:18:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 03/17] target/s390x: Support cpacf sha256
Content-Language: en-GB
To: Harald Freudenberger <freude@linux.ibm.com>, richard.henderson@linaro.org, 
 iii@linux.ibm.com, david@kernel.org, thuth@redhat.com, berrange@redhat.com
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 linux390-list@tuxmaker.boeblingen.de.ibm.com,
 linux-s390@vger.kernel.org, dengler@linux.ibm.com,
 borntraeger@linux.ibm.com, cohuck@redhat.com
References: <20260617094820.34402-1-freude@linux.ibm.com>
 <20260617094820.34402-4-freude@linux.ibm.com>
From: Finn Callies <fcallies@linux.ibm.com>
In-Reply-To: <20260617094820.34402-4-freude@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDA0NSBTYWx0ZWRfX5ZqwN2hqz3Dp
 DzxJ7Kv6geYmQvwKbfFD/NfVLmfrC1DIdoVczu0DsSLhiRm7t3D5o2AsJJ6dcAImxyZoPPaEEFU
 WL+qkaZScbbdlxQA3G1TtleGm2nfhOQ=
X-Proofpoint-ORIG-GUID: N0naJPEtG_uxkuj4O3k2dsAxlPh-fHRe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDA0NSBTYWx0ZWRfX9MtN6hgUF6G4
 GeIRpR5NK1zXRoJO1/LeQpjM/m99VmpGy3TsAL3AlHtBKK0cbFWD+C0xZOF4eleKcljzpWRy/Si
 ZJXOOjg09J8yUaDAWonC+fr7Xkz23N74CFl3wWxMk771b0fP42/h62p06AJ8a9kfvue4mlme5X+
 U6X2bbXqJdRRrawHodkFnvsMrBQvhlAYbdYknLU5akRGfYtvTMwwyYt/INgysjllungOoz6rwxP
 y+px2g6xIWt9txh8NIIBHrnuI4CRWB3OZz35+YVFZh7Vn9KHxPX9M0cSsoVWImPWqLwBY/1toL9
 cuClDKSR3niAjgyOr4smVJ+ehcJBYUceCRNBJowEBBASEb8WhxoYqXEZCJzw9zCryfe5b/S3XZY
 QOdcr4PBzlWEQnWJGWcuhd+OGzH3hviypJR6J7yQLaD35F9ELatWHbXqyI/CgWjvUh+MHFI1Kry
 42mgzptfIDE1LivaWoA==
X-Proofpoint-GUID: N0naJPEtG_uxkuj4O3k2dsAxlPh-fHRe
X-Authority-Analysis: v=2.4 cv=L9gtheT8 c=1 sm=1 tr=0 ts=6a337fa1 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=CEokcfMmFq3Gd3i0g-0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_02,2026-06-17_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 malwarescore=0 clxscore=1015 adultscore=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606180045
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=fcallies@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 18 Jun 2026 08:48:01 -0400
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



On 17.06.26 11:48, Harald Freudenberger wrote:
> Add a new file cpacf_sha256.c which implements sha256.
> Add support for the sha256 subfuction for CPACF kimd and klmd.
> 
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
> Tested-by: Holger Dengler <dengler@linux.ibm.com>

With the one typo (see below) fixed:

Reviewed-by: Finn Callies <fcallies@linux.ibm.com>

> ---
>   target/s390x/gen-features.c      |   2 +
>   target/s390x/tcg/cpacf.h         |   5 +
>   target/s390x/tcg/cpacf_sha256.c  | 232 +++++++++++++++++++++++++++++++
>   target/s390x/tcg/crypto_helper.c |   8 ++
>   target/s390x/tcg/meson.build     |   1 +
>   5 files changed, 248 insertions(+)
>   create mode 100644 target/s390x/tcg/cpacf_sha256.c
> 
> diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
> index 8218e6470e..5cf5b92c37 100644
> --- a/target/s390x/gen-features.c
> +++ b/target/s390x/gen-features.c
> @@ -916,7 +916,9 @@ static uint16_t qemu_V7_1[] = {
>    */
>   static uint16_t qemu_MAX[] = {
>       S390_FEAT_MSA_EXT_5,
> +    S390_FEAT_KIMD_SHA_256,
>       S390_FEAT_KIMD_SHA_512,
> +    S390_FEAT_KLMD_SHA_256,
>       S390_FEAT_KLMD_SHA_512,
>       S390_FEAT_PRNO_TRNG,
>   };
> diff --git a/target/s390x/tcg/cpacf.h b/target/s390x/tcg/cpacf.h
> index d27839ddd9..e2c36306b2 100644
> --- a/target/s390x/tcg/cpacf.h
> +++ b/target/s390x/tcg/cpacf.h
> @@ -8,6 +8,11 @@
>   #ifndef S390X_CPACF_H
>   #define S390X_CPACF_H
>   
> +/* from crypto_sha256.c */

The comment should be cpacf_sha256.c instead of crypto_sha256.c

> +int cpacf_sha256(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
> +                 uint64_t param_addr, uint64_t *message_reg, uint64_t *len_reg,
> +                 uint32_t type);
> +
[ snip ]

