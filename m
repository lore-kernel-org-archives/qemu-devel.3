Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73618C0218D
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 06:04:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1td1BJ-0000yW-Ru; Wed, 29 Jan 2025 01:04:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1td1BH-0000y9-L3; Wed, 29 Jan 2025 01:04:07 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1td1BF-00023e-Ef; Wed, 29 Jan 2025 01:04:07 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50T5OQ1i014627;
 Wed, 29 Jan 2025 06:03:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=Pb713I
 oNukJqI/CS9Y28f5DWJ0/xLwlsCcaBTBNxrVA=; b=TBMV2WCoqZExPnOL3wrNG4
 dqigwC88kdSetjkRKzEaY6nJ//1OFepnAs82pYg8809zsowzo+Loa6OXSkKM5BtA
 ijTcA2PUUpKYTm8lv2qZqF65AOmTzA1tZuQOvZtzdFRJrjACXY4BBpa11c2hou8Z
 x6jZwU2Af95jkt9xyK0h7eaRNz7rgHP4vbgv8YxPW4/FCJqqohOmwf7/Cy5H2REz
 6pVxSdDD2fLZGA3VK7evlSKJ/uLy4UwBgjlrX4YMYutRiDx36+B8ivVlHLcRPI0K
 k6AVrgcG9cfAJDTp5/BWOAT/nJXW29ca4GAARsmn+VmE1OXPnS2eGYHjxdKYPxhg
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44fe5883rp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 29 Jan 2025 06:03:48 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50T608h4022040;
 Wed, 29 Jan 2025 06:03:48 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44fe5883rm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 29 Jan 2025 06:03:48 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50T4tkWB019276;
 Wed, 29 Jan 2025 06:03:47 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44db9my6ar-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 29 Jan 2025 06:03:47 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 50T63k867406294
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 29 Jan 2025 06:03:46 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 949675805B;
 Wed, 29 Jan 2025 06:03:46 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C3F8D5804B;
 Wed, 29 Jan 2025 06:03:42 +0000 (GMT)
Received: from [9.109.242.165] (unknown [9.109.242.165])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 29 Jan 2025 06:03:42 +0000 (GMT)
Message-ID: <3bf9f4e7-c091-4dc3-99a5-cac148efbead@linux.ibm.com>
Date: Wed, 29 Jan 2025 11:33:40 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 14/15] target/ppc: Restrict ATTN / SCV / PMINSN helpers
 to TCG
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>
References: <20250127102620.39159-1-philmd@linaro.org>
 <20250127102620.39159-15-philmd@linaro.org>
Content-Language: en-US
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <20250127102620.39159-15-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: z1T0IuYWNAEycp1-Ky9vGo9N2jzX_jta
X-Proofpoint-ORIG-GUID: RZBx-_uuu-d8zBwNI0bOCxeK5piW2tui
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-28_04,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0
 lowpriorityscore=0 mlxlogscore=571 bulkscore=0 impostorscore=0
 priorityscore=1501 mlxscore=0 adultscore=0 malwarescore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501290048
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
> Move helper_attn(), helper_scv() and helper_pminsn() to
> tcg-excp_helper.c.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>

> ---
>   target/ppc/excp_helper.c     | 45 ------------------------------------
>   target/ppc/tcg-excp_helper.c | 39 +++++++++++++++++++++++++++++++
>   2 files changed, 39 insertions(+), 45 deletions(-)
> 
> diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
> index f0e734e1412..2deed155987 100644
> --- a/target/ppc/excp_helper.c
> +++ b/target/ppc/excp_helper.c
> @@ -400,21 +400,6 @@ static void powerpc_set_excp_state(PowerPCCPU *cpu, target_ulong vector,
>       env->reserve_addr = -1;
>   }
>   
> -#ifdef CONFIG_TCG
> -#if defined(TARGET_PPC64) && !defined(CONFIG_USER_ONLY)
> -void helper_attn(CPUPPCState *env)
> -{
> -    /* POWER attn is unprivileged when enabled by HID, otherwise illegal */
> -    if ((*env->check_attn)(env)) {
> -        powerpc_checkstop(env, "host executed attn");
> -    } else {
> -        raise_exception_err(env, POWERPC_EXCP_HV_EMU,
> -                            POWERPC_EXCP_INVAL | POWERPC_EXCP_INVAL_INVAL);
> -    }
> -}
> -#endif
> -#endif /* CONFIG_TCG */
> -
>   static void powerpc_mcheck_checkstop(CPUPPCState *env)
>   {
>       /* KVM guests always have MSR[ME] enabled */
> @@ -2445,36 +2430,6 @@ void helper_ppc_maybe_interrupt(CPUPPCState *env)
>       ppc_maybe_interrupt(env);
>   }
>   
> -#ifdef TARGET_PPC64
> -void helper_scv(CPUPPCState *env, uint32_t lev)
> -{
> -    if (env->spr[SPR_FSCR] & (1ull << FSCR_SCV)) {
> -        raise_exception_err(env, POWERPC_EXCP_SYSCALL_VECTORED, lev);
> -    } else {
> -        raise_exception_err(env, POWERPC_EXCP_FU, FSCR_IC_SCV);
> -    }
> -}
> -
> -void helper_pminsn(CPUPPCState *env, uint32_t insn)
> -{
> -    CPUState *cs = env_cpu(env);
> -
> -    cs->halted = 1;
> -
> -    /* Condition for waking up at 0x100 */
> -    env->resume_as_sreset = (insn != PPC_PM_STOP) ||
> -        (env->spr[SPR_PSSCR] & PSSCR_EC);
> -
> -    /* HDECR is not to wake from PM state, it may have already fired */
> -    if (env->resume_as_sreset) {
> -        PowerPCCPU *cpu = env_archcpu(env);
> -        ppc_set_irq(cpu, PPC_INTERRUPT_HDECR, 0);
> -    }
> -
> -    ppc_maybe_interrupt(env);
> -}
> -#endif /* TARGET_PPC64 */
> -
>   static void do_rfi(CPUPPCState *env, target_ulong nip, target_ulong msr)
>   {
>       /* MSR:POW cannot be set by any form of rfi */
> diff --git a/target/ppc/tcg-excp_helper.c b/target/ppc/tcg-excp_helper.c
> index 5ad39cacc92..4517b458b79 100644
> --- a/target/ppc/tcg-excp_helper.c
> +++ b/target/ppc/tcg-excp_helper.c
> @@ -499,6 +499,45 @@ void ppc_tcg_hv_emu(CPUPPCState *env, target_ulong *new_msr,
>       *new_msr |= env->msr & ((target_ulong)1 << MSR_RI);
>   }
>   
> +void helper_attn(CPUPPCState *env)
> +{
> +    /* POWER attn is unprivileged when enabled by HID, otherwise illegal */
> +    if ((*env->check_attn)(env)) {
> +        powerpc_checkstop(env, "host executed attn");
> +    } else {
> +        raise_exception_err(env, POWERPC_EXCP_HV_EMU,
> +                            POWERPC_EXCP_INVAL | POWERPC_EXCP_INVAL_INVAL);
> +    }
> +}
> +
> +void helper_scv(CPUPPCState *env, uint32_t lev)
> +{
> +    if (env->spr[SPR_FSCR] & (1ull << FSCR_SCV)) {
> +        raise_exception_err(env, POWERPC_EXCP_SYSCALL_VECTORED, lev);
> +    } else {
> +        raise_exception_err(env, POWERPC_EXCP_FU, FSCR_IC_SCV);
> +    }
> +}
> +
> +void helper_pminsn(CPUPPCState *env, uint32_t insn)
> +{
> +    CPUState *cs = env_cpu(env);
> +
> +    cs->halted = 1;
> +
> +    /* Condition for waking up at 0x100 */
> +    env->resume_as_sreset = (insn != PPC_PM_STOP) ||
> +        (env->spr[SPR_PSSCR] & PSSCR_EC);
> +
> +    /* HDECR is not to wake from PM state, it may have already fired */
> +    if (env->resume_as_sreset) {
> +        PowerPCCPU *cpu = env_archcpu(env);
> +        ppc_set_irq(cpu, PPC_INTERRUPT_HDECR, 0);
> +    }
> +
> +    ppc_maybe_interrupt(env);
> +}
> +
>   #endif /* TARGET_PPC64 */
>   
>   #endif /* !CONFIG_USER_ONLY */

