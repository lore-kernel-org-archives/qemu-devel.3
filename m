Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 852DCF36C2C
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2026 06:56:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wEiYH-0002Cd-IG; Mon, 20 Apr 2026 02:56:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wEiYC-0002CI-To; Mon, 20 Apr 2026 02:56:10 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wEiY9-0001Dq-QU; Mon, 20 Apr 2026 02:56:07 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63JNoiYZ3689187; Mon, 20 Apr 2026 06:56:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=CwL52M
 GJ8c1IpPyE+ys9kqBvjYaxLRDWBHsBo71u48A=; b=avkXEZXvqPSEonvNW5uTJ9
 2KNBa31ORBOtlHFcVTXheLoDQ3whUVOP6V3+d8wq6WPBCjyX9RmfvcGa5PMZ0PmQ
 14nfQxcwI7yoC64WQgk04FRe0OmizPVJGnuTjgi7KFx6wm/9nOzx8IBVcGbHtR3l
 mxzcLZuEPvzke35GwgUs4szLK9bx5S9YLtXCu5cTLS3RRjteYuBdwBfSBUMhcXdS
 eOOxmNG4sZlLPDpy/WVBNqcdwOPhEv4HfL1oleNpuKhispOmtRbuKpwTE+JR9PJu
 8ooTm9+3CXX1sUKOvblPRrbmEZPoWIZjLi5uTVqflVENUX2fLpRXu0XuuhXaJxug
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dm2nexkx0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 20 Apr 2026 06:56:00 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63K6oJxw002815;
 Mon, 20 Apr 2026 06:55:59 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dmn9juq7m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 20 Apr 2026 06:55:59 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63K6twHL24642074
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 20 Apr 2026 06:55:58 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E91AA58056;
 Mon, 20 Apr 2026 06:55:57 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2790858045;
 Mon, 20 Apr 2026 06:55:54 +0000 (GMT)
Received: from [9.123.0.169] (unknown [9.123.0.169])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 20 Apr 2026 06:55:53 +0000 (GMT)
Message-ID: <41f8091f-78a5-4034-a235-8e8f55f93c21@linux.ibm.com>
Date: Mon, 20 Apr 2026 12:25:52 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/8] target/ppc/mmu: Restrict hash32_load_hpte() helpers
 scope
Content-Language: en-GB
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>, Paolo Bonzini <pbonzini@redhat.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Nicholas Piggin <npiggin@gmail.com>,
 Glenn Miles <milesg@linux.ibm.com>, kvm@vger.kernel.org,
 qemu-ppc@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Chinmay Rath <rathc@linux.ibm.com>
References: <20260319111936.68041-1-philmd@linaro.org>
 <20260319111936.68041-5-philmd@linaro.org>
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <20260319111936.68041-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: 4HGd4fSzItL7vDOHwM2YIj7eaxXwJBLV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDA2NCBTYWx0ZWRfX8bV46rLsl4hX
 OLqbnDMjJ4Gi4yQng4HI3hyZP2Tz8B0lwgTD+eb8mcAznVqc+xpcsROM7TE8T82Ux1LpeuqtZhu
 zbdYSQQaUXVbuDftts6xbCZBwe6HJ3PKAOGFW1jArudZsjOv5PLcQLy3mBR7kXA/as80IEFDa9p
 UQpca/XVQLY7dBQtdsuNB8Ymv8f5h41fngvixZbojFK8WVa+4jXh9XuKQOmhhyXREZq2bgvQ92D
 pQKurNp+EUtOlwS76+oM8c7GRK+KOp74Ps9hMRd6PBeaXN7uP5Ngx+/q60oDYBGsLKHjlEr9a2/
 GoqPwDTg4ZN3SNeWTFcuz1wYIj0C/57NLanm37hocBkhBor+FwdZOUAXPo+eANYg/DusZExFTdd
 scEy2Kxnbow0NIk95PLCCfhJWOk1kj4wE2l62C71lyPPiAjuP+MpmwO3w1AXDqdiGdFdHDT0cuh
 iInOCXm43ZGobf23P+Q==
X-Proofpoint-GUID: Hwr7rD3K332NdYoR0_6StyByY8D9Vq0l
X-Authority-Analysis: v=2.4 cv=B7iJFutM c=1 sm=1 tr=0 ts=69e5ce01 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22
 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8 a=0I839AAy7vvk_TsqX-0A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_01,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 spamscore=0 impostorscore=0 adultscore=0
 bulkscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604200064
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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



On 19/03/26 4:49 pm, Philippe Mathieu-Daudé wrote:
> hash32_load_hpte() helpers are only used within mmu-hash32.c,
> no need to have each file including "mmu-hash32.h" to compile
> them. Move their definition to this source file.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>

> ---
>   target/ppc/mmu-hash32.h | 16 ----------------
>   target/ppc/mmu-hash32.c | 14 ++++++++++++++
>   2 files changed, 14 insertions(+), 16 deletions(-)
> 
> diff --git a/target/ppc/mmu-hash32.h b/target/ppc/mmu-hash32.h
> index 5705f57935b..bfea03ea872 100644
> --- a/target/ppc/mmu-hash32.h
> +++ b/target/ppc/mmu-hash32.h
> @@ -71,22 +71,6 @@ static inline hwaddr ppc_hash32_hpt_mask(PowerPCCPU *cpu)
>       return ((cpu->env.spr[SPR_SDR1] & SDR_32_HTABMASK) << 16) | 0xFFFF;
>   }
>   
> -static inline target_ulong ppc_hash32_load_hpte0(PowerPCCPU *cpu,
> -                                                 hwaddr pte_offset)
> -{
> -    target_ulong base = ppc_hash32_hpt_base(cpu);
> -
> -    return ldl_phys(CPU(cpu)->as, base + pte_offset);
> -}
> -
> -static inline target_ulong ppc_hash32_load_hpte1(PowerPCCPU *cpu,
> -                                                 hwaddr pte_offset)
> -{
> -    target_ulong base = ppc_hash32_hpt_base(cpu);
> -
> -    return ldl_phys(CPU(cpu)->as, base + pte_offset + HASH_PTE_SIZE_32 / 2);
> -}
> -
>   static inline hwaddr get_pteg_offset32(PowerPCCPU *cpu, hwaddr hash)
>   {
>       return (hash * HASH_PTEG_SIZE_32) & ppc_hash32_hpt_mask(cpu);
> diff --git a/target/ppc/mmu-hash32.c b/target/ppc/mmu-hash32.c
> index 8b980a5aa90..08c9f63a132 100644
> --- a/target/ppc/mmu-hash32.c
> +++ b/target/ppc/mmu-hash32.c
> @@ -201,6 +201,20 @@ static bool ppc_hash32_direct_store(PowerPCCPU *cpu, target_ulong sr,
>       return false;
>   }
>   
> +static target_ulong ppc_hash32_load_hpte0(PowerPCCPU *cpu, hwaddr pte_offset)
> +{
> +    target_ulong base = ppc_hash32_hpt_base(cpu);
> +
> +    return ldl_phys(CPU(cpu)->as, base + pte_offset);
> +}
> +
> +static target_ulong ppc_hash32_load_hpte1(PowerPCCPU *cpu, hwaddr pte_offset)
> +{
> +    target_ulong base = ppc_hash32_hpt_base(cpu);
> +
> +    return ldl_phys(CPU(cpu)->as, base + pte_offset + HASH_PTE_SIZE_32 / 2);
> +}
> +
>   static hwaddr ppc_hash32_pteg_search(PowerPCCPU *cpu, hwaddr pteg_off,
>                                        bool secondary, target_ulong ptem,
>                                        ppc_hash_pte32_t *pte)


