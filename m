Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91EFAC5478C
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 09:39:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rd5XW-0000px-GR; Thu, 22 Feb 2024 04:38:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1rd5XP-0000pM-7S; Thu, 22 Feb 2024 04:38:44 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1rd5X8-0004Zg-17; Thu, 22 Feb 2024 04:38:42 -0500
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 41M9VhZg024472; Thu, 22 Feb 2024 09:38:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=AFtrwon6wIkU90363ORHZqwzy1nGeCuoTr+nv0aJ0Lk=;
 b=ci9eGn3kigT5g3jAbH9k5m2cJ/JBHG5ufPgrcMjlgPFGsfRgjNI4opCh2AZfy1mzGF9F
 s8o7LaC++/jftGGNzSSGMBtHXry4tMXef67eBrdYkHU4wFUzf/OTd1BKFFpmlHAGPMDa
 r2ncTT04SFJA3GYxjuqcquPt5cDVTd2uSn4b0Awm1cf8AePjN+sHPm1ksRELBub/eoTg
 50OHxFStgAGgnFnXXc6MBsE2ocj4jMNi/JvWWFaqw2boF/7OG6CYyXJBe96eSsu2CIrJ
 PUId3Y7RlxCQdsoFGXIt7Pw1HG8F0eJzqM5nnrbUqdMwlwobZ9GAT6HSoBlSsKuUfPHU Bw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3we3c8gptj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 22 Feb 2024 09:38:15 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41M9Vn3s025652;
 Thu, 22 Feb 2024 09:38:15 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3we3c8gpt4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 22 Feb 2024 09:38:15 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 41M8470g013532; Thu, 22 Feb 2024 09:38:14 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wb7h0nfct-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 22 Feb 2024 09:38:14 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 41M9cCuG17039942
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 22 Feb 2024 09:38:14 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 332CA58056;
 Thu, 22 Feb 2024 09:38:12 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 176DB5806B;
 Thu, 22 Feb 2024 09:38:10 +0000 (GMT)
Received: from [9.179.15.237] (unknown [9.179.15.237])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 22 Feb 2024 09:38:09 +0000 (GMT)
Message-ID: <70a58dda-5fd3-415a-9a15-5b5ecfafb756@linux.ibm.com>
Date: Thu, 22 Feb 2024 15:08:05 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 8/9] target/ppc: Clean up ifdefs in excp_helper.c, part
 3
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, clg@kaod.org
References: <cover.1705614747.git.balaton@eik.bme.hu>
 <2ae612eeb7f7712a4a3d1d13e08d218fb0a04e0b.1705614747.git.balaton@eik.bme.hu>
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <2ae612eeb7f7712a4a3d1d13e08d218fb0a04e0b.1705614747.git.balaton@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: RrI90uD8jIbcnsGRqlwceqAZzhq_9qnv
X-Proofpoint-ORIG-GUID: kkf6ekheencTG2KhHDZhKCmSeFnJS2hf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_06,2024-02-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0
 impostorscore=0 adultscore=0 clxscore=1015 priorityscore=1501 mlxscore=0
 spamscore=0 malwarescore=0 lowpriorityscore=0 mlxlogscore=870 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402220076
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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



On 1/19/24 03:31, BALATON Zoltan wrote:
> Concatenate #if blocks that are ending then beginning on the next line
> again.
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>

Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>

> ---
>   target/ppc/excp_helper.c | 15 ++-------------
>   1 file changed, 2 insertions(+), 13 deletions(-)
> 
> diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
> index 2d4a72883f..5124c3e6b5 100644
> --- a/target/ppc/excp_helper.c
> +++ b/target/ppc/excp_helper.c
> @@ -2496,10 +2496,8 @@ void helper_raise_exception(CPUPPCState *env, uint32_t exception)
>   {
>       raise_exception_err_ra(env, exception, 0, 0);
>   }
> -#endif /* CONFIG_TCG */
>   
>   #ifndef CONFIG_USER_ONLY
> -#ifdef CONFIG_TCG
>   void helper_store_msr(CPUPPCState *env, target_ulong val)
>   {
>       uint32_t excp = hreg_store_msr(env, val, 0);
> @@ -2605,9 +2603,7 @@ void helper_hrfid(CPUPPCState *env)
>   {
>       do_rfi(env, env->spr[SPR_HSRR0], env->spr[SPR_HSRR1]);
>   }
> -#endif /* TARGET_PPC64 */
>   
> -#ifdef TARGET_PPC64
>   void helper_rfebb(CPUPPCState *env, target_ulong s)
>   {
>       target_ulong msr = env->msr;
> @@ -2707,10 +2703,8 @@ void helper_rfmci(CPUPPCState *env)
>       /* FIXME: choose CSRR1 or MCSRR1 based on cpu type */
>       do_rfi(env, env->spr[SPR_BOOKE_MCSRR0], env->spr[SPR_BOOKE_MCSRR1]);
>   }
> -#endif /* CONFIG_TCG */
> -#endif /* !defined(CONFIG_USER_ONLY) */
> +#endif /* !CONFIG_USER_ONLY */
>   
> -#ifdef CONFIG_TCG
>   void helper_tw(CPUPPCState *env, target_ulong arg1, target_ulong arg2,
>                  uint32_t flags)
>   {
> @@ -2738,9 +2732,7 @@ void helper_td(CPUPPCState *env, target_ulong arg1, target_ulong arg2,
>       }
>   }
>   #endif /* TARGET_PPC64 */
> -#endif /* CONFIG_TCG */
>   
> -#ifdef CONFIG_TCG
>   static uint32_t helper_SIMON_LIKE_32_64(uint32_t x, uint64_t key, uint32_t lane)
>   {
>       const uint16_t c = 0xfffc;
> @@ -2851,11 +2843,8 @@ HELPER_HASH(HASHST, env->spr[SPR_HASHKEYR], true, NPHIE)
>   HELPER_HASH(HASHCHK, env->spr[SPR_HASHKEYR], false, NPHIE)
>   HELPER_HASH(HASHSTP, env->spr[SPR_HASHPKEYR], true, PHIE)
>   HELPER_HASH(HASHCHKP, env->spr[SPR_HASHPKEYR], false, PHIE)
> -#endif /* CONFIG_TCG */
>   
>   #ifndef CONFIG_USER_ONLY
> -#ifdef CONFIG_TCG
> -
>   /* Embedded.Processor Control */
>   static int dbell2irq(target_ulong rb)
>   {
> @@ -3197,5 +3186,5 @@ bool ppc_cpu_debug_check_watchpoint(CPUState *cs, CPUWatchpoint *wp)
>       return false;
>   }
>   
> -#endif /* CONFIG_TCG */
>   #endif /* !CONFIG_USER_ONLY */
> +#endif /* CONFIG_TCG */

