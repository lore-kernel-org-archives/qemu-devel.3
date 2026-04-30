Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB020FF8875
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 15:04:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wISvj-0000Uu-Ss; Thu, 30 Apr 2026 11:03:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1wISv6-0000Qu-Rk; Thu, 30 Apr 2026 11:03:24 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1wISv0-0000jy-RZ; Thu, 30 Apr 2026 11:03:16 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63U9DJNN1914783; Thu, 30 Apr 2026 15:02:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=gQRtJ0L7c/5Z6Hz2FLTO4Te4twaV8I1/XGUl0GP7d/Y=; b=hzfUmX23IzcB
 uh06+/C8bI0Am9nnq8CVlLMISloxDIiVJa9q+VtHGG9NSEaq7mcWo9Ug5o1OHnvs
 X0en4rl2tjc3IAB10K609OdnPrVnXAyvfkfv84tfi06nfjP2PukqiWOlfXoFn8rg
 9uVWC5QZ0vEX9w61KuxWbJPnw24nK04fEXqqGqPC3HEErueC+rCCNo8H2g6h+lES
 dRfYZ31ARyL5cHeIH4vk0PRygay7v7K3OeTwl8ps5xL2vdrsi5BN942IodxvVYDb
 PjNJ8rJyk/CEqdunec0bA2R6y4t5tPjf58O8al09p81iiQJeKjWN/6HDWhm1NOat
 cXq/4z8P2w==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drnb5gcs7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 30 Apr 2026 15:02:35 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63UEs2xt031756;
 Thu, 30 Apr 2026 15:02:34 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ds8aw3jxx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 30 Apr 2026 15:02:34 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63UF2WKF3605448
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 30 Apr 2026 15:02:32 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C15C95805C;
 Thu, 30 Apr 2026 15:02:32 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 606CD5805D;
 Thu, 30 Apr 2026 15:02:30 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 30 Apr 2026 15:02:30 +0000 (GMT)
Message-ID: <8cb18c45e3a08fc64b854b945878d6edbee03416.camel@linux.ibm.com>
Subject: Re: [PATCH v2 08/25] target/ppc: Make get_phys_page_debug handle
 non-page-aligned addrs
From: Miles Glenn <milesg@linux.ibm.com>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org, Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?=
 <philmd@linaro.org>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Yanan
 Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>, Paolo
 Bonzini <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, "Dr. David Alan Gilbert"
 <dave@treblig.org>, Alex =?ISO-8859-1?Q?Benn=E9e?=
 <alex.bennee@linaro.org>, Alexandre Iooss <erdnaxe@crans.org>, Mahmoud
 Mandour <ma.mandourr@gmail.com>, Peter Xu <peterx@redhat.com>, "Edgar E.
 Iglesias" <edgar.iglesias@gmail.com>, Jiaxun Yang
 <jiaxun.yang@flygoat.com>, Nicholas Piggin <npiggin@gmail.com>, Chinmay
 Rath <rathc@linux.ibm.com>, Palmer Dabbelt <palmer@dabbelt.com>, Alistair
 Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, Daniel
 Henrique Barboza <daniel.barboza@oss.qualcomm.com>, Liu Zhiwei
 <zhiwei_liu@linux.alibaba.com>, Chao Liu <chao.liu.zevorn@gmail.com>, Ilya
 Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>, Mark
 Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko
 <atar4qemu@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>
Date: Thu, 30 Apr 2026 10:02:29 -0500
In-Reply-To: <20260430093810.2762539-9-peter.maydell@linaro.org>
References: <20260430093810.2762539-1-peter.maydell@linaro.org>
 <20260430093810.2762539-9-peter.maydell@linaro.org>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=AqDeGu9P c=1 sm=1 tr=0 ts=69f36f0c cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=KKAkSRfTAAAA:8 a=-46nHPmGWPDw9I8CGM8A:9 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDE1MiBTYWx0ZWRfX7mlSUiJH+efK
 9ilzbt2jdanVt2tXl7b4YMiryNy9CHE+Ea1dmrBMRekp8uThiZ/0ZOUqpe15oT6epGPVKPZvhKU
 Pjk2iKwarkTlcKpJ+8X7KDa5LKbRH0PLMwo2jAGoXfyw8RtlhZUVjhfRNhzkj7BD5Vz7L0KV/DB
 h08iL+vDSB91WhyRCYZ/JYejuu02DAYocxgNsOMYg3jXCuG8au5dAC+IZ/xWGG4BsynbD0u0FWd
 XGmmA/+Ij2yaY44/VMeUgJAYN8M6k7aSnFpYlYzq22gMJ4mNur2c7E28tjehw+bcAI77eqB1Ype
 fTgxVz1s10gwrILdnvHqXw8mpUporcb98/Tekr6T4ETVJaTKgmH6VWBrf7V2T66mV+9IYrxCEls
 HrpY8jcuhMUVqppVleE+QvW6uj07gTnjVIuKHTtHxdtUrPsFiesBSvkYv7V7gS7PBoaQ/QY/2x6
 fJxe3BPZbtGgMuU/g3g==
X-Proofpoint-GUID: GJ3vrb5pZ2K64prRGtpBc4kKAJXfD4z-
X-Proofpoint-ORIG-GUID: mLsDhH_fvqHm8TlodVz6-dSPFFqTTSCG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-30_04,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 phishscore=0 suspectscore=0 clxscore=1011
 lowpriorityscore=0 spamscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604300152
Received-SPF: pass client-ip=148.163.156.1; envelope-from=milesg@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Reply-To: milesg@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Reviewed-by: Glenn Miles <milesg@linux.ibm.com>

Thanks,

Glenn

On Thu, 2026-04-30 at 10:37 +0100, Peter Maydell wrote:
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
> The ppc_xlate() function can accept a non-page-aligned input but may
> return a page-aligned output; we take the simple approach of ORing
> the page offset back into the result address after calling it.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Message-id: 20260417173105.1648172-8-peter.maydell@linaro.org
> ---
>  target/ppc/mmu_common.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
> index 52d48615ac..a1345df716 100644
> --- a/target/ppc/mmu_common.c
> +++ b/target/ppc/mmu_common.c
> @@ -863,7 +863,7 @@ hwaddr ppc_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
>                    ppc_env_mmu_index(&cpu->env, false), false) ||
>          ppc_xlate(cpu, addr, MMU_INST_FETCH, &raddr, &s, &p,
>                    ppc_env_mmu_index(&cpu->env, true), false)) {
> -        return raddr & TARGET_PAGE_MASK;
> +        return raddr | (addr & ~TARGET_PAGE_MASK);
>      }
>      return -1;
>  }


