Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32E48C0218D
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 06:14:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcerD-0001v4-Ef; Tue, 28 Jan 2025 01:13:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1tcerC-0001us-CW; Tue, 28 Jan 2025 01:13:54 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1tcerA-000378-Jh; Tue, 28 Jan 2025 01:13:54 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50S18BrI010125;
 Tue, 28 Jan 2025 06:13:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=TqHps1
 ErmAR/Mh2uCNOpi27t161oEHOTxj/nndRhwhQ=; b=Qa95JkntcyfOXzxN47LezA
 VewNTS3EecK4Xj+zp6QbH9W9EkObkQfeGg6dNDmIzwKZe3gfHH2Y9tmLfL00sIAI
 U3MH/6rqF0+xDhkRW0A08JSrssvo8BDSuRktYA+cD7BMz0ZC9+G1kkNamqm7hSuC
 ssGDbl7k8v0B/FiA830fIKR5/+LJb748vxDUoJh5938zuzF5Ok3lGMemyMC40mUM
 nXBX//6fRSt10mM4P84XY8Et9w0bhQk7uKHxX7xsZL0/Bj9BH4YUWI1hSbQ5Lsel
 VqpsR3YXGvO48bWs6ra1NrkADBjBnwXaALFavOiRLWlcqSirpox4ZufriXcJ6udg
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44ena9s1u7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 Jan 2025 06:13:49 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50S6DD7H028162;
 Tue, 28 Jan 2025 06:13:48 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44ena9s1u5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 Jan 2025 06:13:48 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50S5Uek2028045;
 Tue, 28 Jan 2025 06:13:47 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44dbsk9tbw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 Jan 2025 06:13:47 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 50S6DkfQ29557002
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 28 Jan 2025 06:13:47 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E6D3B5805E;
 Tue, 28 Jan 2025 06:13:46 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BF3C258062;
 Tue, 28 Jan 2025 06:13:44 +0000 (GMT)
Received: from [9.124.214.156] (unknown [9.124.214.156])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 28 Jan 2025 06:13:44 +0000 (GMT)
Message-ID: <34b75938-ce88-47d5-ab86-715e50de4cb8@linux.ibm.com>
Date: Tue, 28 Jan 2025 11:43:42 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/15] target/ppc: Move ppc_ldl_code() to
 tcg-excp_helper.c
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>
References: <20250127102620.39159-1-philmd@linaro.org>
 <20250127102620.39159-6-philmd@linaro.org>
Content-Language: en-US
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <20250127102620.39159-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: GsIP7zSJnh40D4LlCN4HPzJy36DXvRYL
X-Proofpoint-GUID: -ZtfjHv4cPYilPsstG-ZLd4yydBzmeej
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-28_01,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 mlxscore=0
 mlxlogscore=845 malwarescore=0 phishscore=0 priorityscore=1501
 clxscore=1015 spamscore=0 suspectscore=0 adultscore=0 impostorscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501280044
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/ppc/excp_helper.c     | 21 ---------------------
>   target/ppc/tcg-excp_helper.c | 18 ++++++++++++++++++
>   2 files changed, 18 insertions(+), 21 deletions(-)
> 

This patch also needs to remove the function declaration introduced in 
internal.h in patch 3.

Otherwise,
Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>

> diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
> index b05eb7f5aec..8956466db1d 100644
> --- a/target/ppc/excp_helper.c
> +++ b/target/ppc/excp_helper.c
> @@ -136,27 +136,6 @@ static void dump_hcall(CPUPPCState *env)
>                     env->nip);
>   }
>   
> -#ifdef CONFIG_TCG
> -/* Return true iff byteswap is needed to load instruction */
> -static inline bool insn_need_byteswap(CPUArchState *env)
> -{
> -    /* SYSTEM builds TARGET_BIG_ENDIAN. Need to swap when MSR[LE] is set */
> -    return !!(env->msr & ((target_ulong)1 << MSR_LE));
> -}
> -
> -uint32_t ppc_ldl_code(CPUArchState *env, target_ulong addr)
> -{
> -    uint32_t insn = cpu_ldl_code(env, addr);
> -
> -    if (insn_need_byteswap(env)) {
> -        insn = bswap32(insn);
> -    }
> -
> -    return insn;
> -}
> -
> -#endif
> -
>   static void ppc_excp_debug_sw_tlb(CPUPPCState *env, int excp)
>   {
>       const char *es;
> diff --git a/target/ppc/tcg-excp_helper.c b/target/ppc/tcg-excp_helper.c
> index 3402dbe05ee..6950b78774d 100644
> --- a/target/ppc/tcg-excp_helper.c
> +++ b/target/ppc/tcg-excp_helper.c
> @@ -199,4 +199,22 @@ bool ppc_cpu_debug_check_watchpoint(CPUState *cs, CPUWatchpoint *wp)
>       return false;
>   }
>   
> +/* Return true iff byteswap is needed to load instruction */
> +static inline bool insn_need_byteswap(CPUArchState *env)
> +{
> +    /* SYSTEM builds TARGET_BIG_ENDIAN. Need to swap when MSR[LE] is set */
> +    return !!(env->msr & ((target_ulong)1 << MSR_LE));
> +}
> +
> +uint32_t ppc_ldl_code(CPUArchState *env, target_ulong addr)
> +{
> +    uint32_t insn = cpu_ldl_code(env, addr);
> +
> +    if (insn_need_byteswap(env)) {
> +        insn = bswap32(insn);
> +    }
> +
> +    return insn;
> +}
> +
>   #endif /* !CONFIG_USER_ONLY */

