Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E86B7C0218D
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 05:48:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tceRr-0003pe-Cv; Tue, 28 Jan 2025 00:47:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1tceRq-0003pP-Cc; Tue, 28 Jan 2025 00:47:42 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1tceRo-0000FP-Kr; Tue, 28 Jan 2025 00:47:42 -0500
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50RLIt4A019848;
 Tue, 28 Jan 2025 05:47:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=u0F+sl
 cpt4yS3/V11+BFCRXzwY1vvVnQBr//RjBmkGA=; b=SA06mDLWMR5Zs6noSVEWsq
 +u/cvSPLMGyII3hSbB5IPiegxS6HEe+4UgZ//2TiqtnBwCR6P02m6MpclGPrIBRu
 tLSPtTeb5HKx/wp8ehtlDDtz3QNPdx7gPB4zV1Oy7r+d1GG8dAWxLpCmpBGg9LAx
 4ufppdzE+6TxzYXXB/zEUqULgcAiv9olj+TeAlKYfH2tQI/HLxNv/+4UgXEzJ25d
 9zjsrTNkHyKKUoRAf7/2SBKRgiCTyHH7F21sY/7gtcR3oXR5Mbi02FjJji/3Po1+
 FBQk0p3+oQ04d70XVCbn0aV4d5gwgIpaOfTF8Lhd3YLiwrEHqsfR/owFDKM8joUw
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44ecytb2d9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 Jan 2025 05:47:37 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50S5isFl019995;
 Tue, 28 Jan 2025 05:47:37 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44ecytb2d0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 Jan 2025 05:47:37 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50S1qlRu022193;
 Tue, 28 Jan 2025 05:47:36 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 44dcgjhgn6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 Jan 2025 05:47:36 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 50S5lZ1F30409254
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 28 Jan 2025 05:47:35 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BF4AD58052;
 Tue, 28 Jan 2025 05:47:35 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6701758056;
 Tue, 28 Jan 2025 05:47:33 +0000 (GMT)
Received: from [9.124.214.156] (unknown [9.124.214.156])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 28 Jan 2025 05:47:33 +0000 (GMT)
Message-ID: <890abad7-8da3-4f6e-b671-44904d2f646b@linux.ibm.com>
Date: Tue, 28 Jan 2025 11:17:31 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/15] target/ppc: Make ppc_ldl_code() declaration
 public
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>
References: <20250127102620.39159-1-philmd@linaro.org>
 <20250127102620.39159-4-philmd@linaro.org>
Content-Language: en-US
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <20250127102620.39159-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 3Ms-39ai0gxos7ute5weFj-tOWakDKXp
X-Proofpoint-ORIG-GUID: C_XsNDrm_ucZG4QlTR-QNeo8vRgorQ2e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-28_01,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 adultscore=0 spamscore=0
 impostorscore=0 mlxscore=0 phishscore=0 mlxlogscore=687 suspectscore=0
 bulkscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501280039
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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



On 1/27/25 15:56, Philippe Mathieu-Daudé wrote:
> We are going to move code calling ppc_ldl_code() out of
> excp_helper.c where it is defined. Expose its declaration
> for few commits, until eventually making it static again
> once everything is moved.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>

> ---
>   target/ppc/internal.h    | 2 ++
>   target/ppc/excp_helper.c | 2 +-
>   2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/target/ppc/internal.h b/target/ppc/internal.h
> index 20fb2ec593c..46db6adfcf6 100644
> --- a/target/ppc/internal.h
> +++ b/target/ppc/internal.h
> @@ -268,6 +268,8 @@ static inline void pte_invalidate(target_ulong *pte0)
>   #define PTE_PTEM_MASK 0x7FFFFFBF
>   #define PTE_CHECK_MASK (TARGET_PAGE_MASK | 0x7B)
>   
> +uint32_t ppc_ldl_code(CPUArchState *env, target_ulong addr);
> +
>   #ifdef CONFIG_USER_ONLY
>   void ppc_cpu_record_sigsegv(CPUState *cs, vaddr addr,
>                               MMUAccessType access_type,
> diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
> index fde9912230e..7ed4bbec035 100644
> --- a/target/ppc/excp_helper.c
> +++ b/target/ppc/excp_helper.c
> @@ -144,7 +144,7 @@ static inline bool insn_need_byteswap(CPUArchState *env)
>       return !!(env->msr & ((target_ulong)1 << MSR_LE));
>   }
>   
> -static uint32_t ppc_ldl_code(CPUArchState *env, target_ulong addr)
> +uint32_t ppc_ldl_code(CPUArchState *env, target_ulong addr)
>   {
>       uint32_t insn = cpu_ldl_code(env, addr);
>   

