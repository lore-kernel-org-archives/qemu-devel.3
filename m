Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4020F8925B
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 11:06:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wF8v6-00071K-57; Tue, 21 Apr 2026 07:05:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1wF8uu-000705-Hk; Tue, 21 Apr 2026 07:05:22 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1wF8uq-0001mo-RB; Tue, 21 Apr 2026 07:05:18 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63KJgiiX1650816; Tue, 21 Apr 2026 11:04:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=Z//SCb
 f0EW11516TBYtCR0JQqZMahcIKxTUe6u+z3b4=; b=d9luD71gwlGKbO/yXP+5qb
 j861EU4jpnn/wbUct4FPo3ixulxhAE8Sre2fVKY/InqvQnaLIenOeq2QwUOigzSI
 YZry5y3ZDLR+tJSmqrkHExQ1dkdAmIxBdg11k9vWO//QKgvQP0USooc/+Tp+eYqK
 1SL4Pxofp3UFKwQ5RwhOGxO6n7cozCcfnFDuoINvn/AEdJuVpSoeVZBHRL/+Cmjd
 ncbxY96OAtScwOJ/+M60guWCV/Gi6xMMCm5qI9bMVmOqHvacGM4h9GptzWxTfJA2
 XcblPmh26rnDn+rkxIw+v4UbwyvHOSRxfY/MIAOadJKxRgFCdguqsBKdlIXhk2DQ
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dm2k53wq7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 Apr 2026 11:04:46 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63LAoMCJ009455;
 Tue, 21 Apr 2026 11:04:45 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dmmnvrh8d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 Apr 2026 11:04:45 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63LB4fom54395158
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 21 Apr 2026 11:04:41 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 774DB20043;
 Tue, 21 Apr 2026 11:04:41 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0041D20040;
 Tue, 21 Apr 2026 11:04:39 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.111.64.206])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 21 Apr 2026 11:04:39 +0000 (GMT)
Message-ID: <26992841-42db-489e-90d4-d24615f222c3@linux.ibm.com>
Date: Tue, 21 Apr 2026 13:04:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/17] target/s390x: Make get_phys_page_debug handle
 non-page-aligned addrs
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-riscv@nongnu.org, qemu-s390x@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Mahmoud Mandour
 <ma.mandourr@gmail.com>, Peter Xu <peterx@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, David Hildenbrand <david@kernel.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
References: <20260417173105.1648172-1-peter.maydell@linaro.org>
 <20260417173105.1648172-7-peter.maydell@linaro.org>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20260417173105.1648172-7-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: qx0yJDngtlFCCt_Sn4-LUG4LTeJkPbwt
X-Proofpoint-ORIG-GUID: aRmAw6KNJryOEt3nRAcFv89zbn8Z-XdW
X-Authority-Analysis: v=2.4 cv=VP7tWdPX c=1 sm=1 tr=0 ts=69e759cf cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=KKAkSRfTAAAA:8
 a=VnNF1IyMAAAA:8 a=-46nHPmGWPDw9I8CGM8A:9 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIxMDEwNyBTYWx0ZWRfX+SRRZWz3kNyo
 Q3LxISjtkTjlhsmVYnXZ/9ijUTrqbux1JdyPH60Ej4mtbOByWATmjHJwWwJeb17Q7OWMt8oOG5q
 GsAMja/OYqBp3d4TKqPHXXQAK2abzHJjtegZ1VBGGo6sPNbOE10bFXm6o+8ThSbZjL7SdYf9siO
 YXotN+WhPdI2099t46BSChQl3/JK7Xf8VFogxqh60KdsRbX/JzfTPfvvyTpELFMJKcUhOx0lh4i
 bVZ88B5ZORXq60JAGMQzI+7svLrppvgPgVSU/AmUIikwevx1PncBIUHdVQXwONmSUtspBYotoOB
 UDnA7IYf1nJcXUhmSIzjGt/edSq0eYec7CGPZcneS2giWn0BfXCf/ivXVm5/3I89PdhitDhKfnX
 f5HuWy5csq+b3qAhlV9h1x9Geuk0TxuwbRKic36Kb/2sMXCpG+MmZcFI5poj3zYieCIPELrr2no
 556W8x+TTbj/69adb/w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_02,2026-04-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 impostorscore=0 suspectscore=0 priorityscore=1501 adultscore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604210107
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


On 4/17/26 18:30, Peter Maydell wrote:
> Currently our implementations of SysemuCPUOps::get_phys_page_debug
> and SysemuCPUOps::get_phys_page_attrs_debug are a mix of "accepts a
> non-page-aligned virtual address and returns the corresponding
> non-page-aligned physical address" and "only returns a page-aligned
> physical address".  This is awkward for callsites, which in practice
> all want the physical address for an arbitrary virtual address and
> have to work around the possibility of getting a page-aligned
> address, and it doesn't account for protection being possibly on a
> sub-page-sized granularity.  We want to standardize on the
> implementation having to handle non-page-aligned addresses.
>
> s390x already has an implementation of "give me the actual physical
> address, not rounded down", in s390_get_phys_addr_debug(), so we can
> use this for the SysemuCPUOps::get_phys_page_debug method, and merge
> the s390_cpu_get_phys_page_debug() function into
> s390_get_phys_addr_debug() which is now its only caller.
>
> This leaves the function implementing the method with a name
> that doesn't match the method name, but we will fix that shortly
> by renaming the method to *_addr_* for all targets.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/s390x/cpu-system.c     |  2 +-
>   target/s390x/helper.c         | 20 +++++---------------
>   target/s390x/s390x-internal.h |  1 -
>   3 files changed, 6 insertions(+), 17 deletions(-)

Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>


