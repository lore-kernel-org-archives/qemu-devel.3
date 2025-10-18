Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55AA8CCD193
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Oct 2025 11:21:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vA4z8-0006R8-Au; Sat, 18 Oct 2025 07:20:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sourabhjain@linux.ibm.com>)
 id 1vA4z4-0006Qg-69; Sat, 18 Oct 2025 07:20:26 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sourabhjain@linux.ibm.com>)
 id 1vA4z2-0002lL-4y; Sat, 18 Oct 2025 07:20:25 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59I3S5cV001474;
 Sat, 18 Oct 2025 11:20:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=FQcbGZ
 pqUjATbcX0cBP4UcOhkIe7jgxHKVuObclZMBI=; b=VycLpaFB7c3x0IX6cLlr6J
 nzAIoriAHnGCWqh2fSWkYRKo8a7d9lZwPzsYkOY0qX0ZVrif0UvwvhoS5ENeI9xv
 7lbW+0vDujxOGs6hEkJ00kxPSLB+nLqHIzjMR8XQaSDoabbQvaBisLCrWEE0AQrO
 rA4VGdW7O2eGeTZD45aUWlkWGfdfevhkwHC965vi9OgoeweAPqP81pSXCulveREq
 4kCUXkOzrm/UhsxRm/nliaRoGek0bM1utD00xNHcSNk70iAuaU1kNT298oPuVYUM
 pp9lxNMi2fVA+4ZJzyB3a57UJJucm3kpGW5uKNA/M7caAN52HL19cABw73Sis9cg
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v30v952n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 18 Oct 2025 11:20:21 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59IBKLjb026050;
 Sat, 18 Oct 2025 11:20:21 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v30v952k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 18 Oct 2025 11:20:21 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59I7m7sO015259;
 Sat, 18 Oct 2025 11:20:20 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 49r1jst03k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 18 Oct 2025 11:20:20 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59IBKGF858196316
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 18 Oct 2025 11:20:16 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CC87D20043;
 Sat, 18 Oct 2025 11:20:16 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 819FB20040;
 Sat, 18 Oct 2025 11:20:14 +0000 (GMT)
Received: from [9.39.28.54] (unknown [9.39.28.54])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Sat, 18 Oct 2025 11:20:14 +0000 (GMT)
Message-ID: <65b70282-c6ca-4140-92f6-d266082b6d49@linux.ibm.com>
Date: Sat, 18 Oct 2025 16:50:12 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/8] hw/ppc: Pass dump-sizes property for fadump in
 device tree
To: Aditya Gupta <adityag@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Hari Bathini <hbathini@linux.ibm.com>
References: <20250323174007.221116-1-adityag@linux.ibm.com>
 <20250323174007.221116-7-adityag@linux.ibm.com>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <20250323174007.221116-7-adityag@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 7NNeu7VW4TNrJUSGF6OUjufKGUP8Nhqv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX7xvFBmervFR7
 YOI8QZmK3kOV8CdDGxUQ7vtlyask2droVB6msK7nfbzdlpyF/cfK6B25JlHdwEIN6QSObRw0+lN
 FP0ml1COH8NgDql23spW/HiOydX/WZFS4MQ1zobuy46EKKjim8sgcghELp2iAoaszKg7WK8bZy9
 44Hgiw3u6rtdu7Nz6BZr+559stqWKsGfGhSCY48SrCXRuM5JJeAX2lWav6+gYSF+YF7xTLktvfC
 qVJklJUCj4zql8+l/XCI6iTe0L3qg5YAvPG2nw1kkf89UMayHwJqklFDsrnMXdCTZGBLErxX63f
 RAjEcWn3IBvRWGw3z04Z7u0T09lBKgta2TWdRd+/JzMbq9qCcHMTbK8ljPuVhgEY8ZvBoqj8SHw
 E76uVtUW4CoKCdHDu+T8kv3Sca2Njg==
X-Authority-Analysis: v=2.4 cv=MIJtWcZl c=1 sm=1 tr=0 ts=68f377f5 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=f_s96IIItf4NiyCAkXYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: nmifO5uOhH0Lwxt7SaPlvP3-8bqKcb_G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-18_04,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 clxscore=1015 impostorscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=sourabhjain@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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




On 23/03/25 23:10, Aditya Gupta wrote:
> Platform (ie. QEMU) is expected to pass few device tree properties for
> details for fadump:
>
>    * "ibm,configure-kernel-dump-sizes": Space required to store dump data
>      for firmware provided dump sections (ie. CPU & HPTE regions)
>    * "ibm,configure-kernel-dump-version": Versions of fadump supported
>
> Pass the above device tree nodes so that kernel can reserve sufficient
> space for preserving the CPU state data
>
> Note: As of this patch, the "kernel-dump" device tree entry is still not
> added for the second boot, so after crash, the second kernel will boot
> assuming fadump dump is "NOT" active, and try to register for fadump,
> but since we already have fadump registered in QEMU internal state, the
> register rtas call will fail with: "DUMP ACTIVE"
>
> Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
> ---
>   hw/ppc/spapr.c | 57 ++++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 57 insertions(+)
>
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index a415e51d077a..3cbc6a7409b7 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -900,6 +900,61 @@ static int spapr_dt_rng(void *fdt)
>       return ret ? -1 : 0;
>   }
>   
> +static void spapr_dt_rtas_fadump(SpaprMachineState *spapr, void *fdt, int rtas)
> +{
> +    MachineState *ms = MACHINE(spapr);
> +    MachineClass *mc = MACHINE_GET_CLASS(ms);
> +
> +    uint32_t max_possible_cpus = mc->possible_cpu_arch_ids(ms)->len;
> +    uint64_t fadump_cpu_state_size = 0;
> +    uint16_t fadump_versions[2] = {
> +        FADUMP_VERSION /* min supported version */,
> +        FADUMP_VERSION /* max supported version */
> +    };
> +    uint32_t fadump_rgn_sizes[2][3] = {
> +        {
> +            cpu_to_be32(FADUMP_CPU_STATE_DATA),
> +            0, 0 /* Calculated later */
> +        },
> +        {
> +            cpu_to_be32(FADUMP_HPTE_REGION),
> +            0, 0 /* HPTE region not implemented */
> +        }

#nit-pick
Why to advertise if we don't support it? Kernel anyways ignores this for 
now.

> +    };
> +
> +    /*
> +     * CPU State Data contains multiple fields such as header, num_cpus and
> +     * register entries
> +     *
> +     * Calculate the maximum CPU State Data size, according to maximum
> +     * possible CPUs the QEMU VM can have
> +     *
> +     * This calculation must match the 'cpu_state_len' calculation done in
> +     * 'populate_cpu_state_data' in spapr_fadump.c
> +     */
> +    fadump_cpu_state_size += sizeof(struct FadumpRegSaveAreaHeader);
> +    fadump_cpu_state_size += 0xc;                      /* padding as in PAPR */
> +    fadump_cpu_state_size += sizeof(__be32);           /* num_cpus */
> +    fadump_cpu_state_size += max_possible_cpus   *     /* reg entries */
> +                             FADUMP_NUM_PER_CPU_REGS *
> +                             sizeof(struct FadumpRegEntry);
> +
> +    /* Set maximum size for CPU state data region */
> +    assert(fadump_rgn_sizes[0][0] == cpu_to_be32(FADUMP_CPU_STATE_DATA));
> +
> +    /* Upper 32 bits of size, usually 0 */
> +    fadump_rgn_sizes[0][1] = cpu_to_be32(fadump_cpu_state_size >> 32);
> +
> +    /* Lower 32 bits of size */
> +    fadump_rgn_sizes[0][2] = cpu_to_be32(fadump_cpu_state_size & 0xffffffff);
> +
> +    /* Add device tree properties required from platform for fadump */
> +    _FDT((fdt_setprop(fdt, rtas, "ibm,configure-kernel-dump-version",
> +                    fadump_versions, sizeof(fadump_versions))));
> +    _FDT((fdt_setprop(fdt, rtas, "ibm,configure-kernel-dump-sizes",
> +                    fadump_rgn_sizes, sizeof(fadump_rgn_sizes))));
> +}
> +
>   static void spapr_dt_rtas(SpaprMachineState *spapr, void *fdt)
>   {
>       MachineState *ms = MACHINE(spapr);
> @@ -1012,6 +1067,8 @@ static void spapr_dt_rtas(SpaprMachineState *spapr, void *fdt)
>       _FDT(fdt_setprop(fdt, rtas, "ibm,lrdr-capacity",
>                        lrdr_capacity, sizeof(lrdr_capacity)));
>   
> +    spapr_dt_rtas_fadump(spapr, fdt, rtas);
> +
>       spapr_dt_rtas_tokens(fdt, rtas);
>   }
>   


