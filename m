Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3DAEC0218D
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 05:44:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1td0rI-0003li-Qs; Wed, 29 Jan 2025 00:43:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1td0rH-0003lO-8j; Wed, 29 Jan 2025 00:43:27 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1td0rC-0008D9-Pl; Wed, 29 Jan 2025 00:43:26 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50SHDbok023487;
 Wed, 29 Jan 2025 05:43:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=hWyGHO
 MLcX0iq3lUQhib17FXCVahnnZNdrtffP88Z1Q=; b=TWWoCt4h3BAlxuqGskhV82
 CEsIJh1mv+Qw3JmBkV8z0bw1rcPXXMkHYI1rQUPgeJXrFd1Yltsb/cD2NZCWOqd8
 mRTLhFkhT2ry83h6/4ZE+x8wzZDd618nWhsmLkRh4G79cgxHUlW5mdj9SmjwO1Jp
 m2oKUj3n2LRZVrcJnQQ+esEZHeydED6w37HBHq4mICyjdM6HtF2dVsJRlxUo8qhI
 hsx4VDMHU+HZkkoNnb88oXLwGwnkFcKnCAV4291FAqNP09smzPSI++GMZMQlRDGf
 aZkQGAyiNcaKpCzS+KmYYYw4uKEidb748lQ8lkJbIhdu1eq8Zu0vs9JXgJK4ImsA
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44etxrw1xm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 29 Jan 2025 05:43:19 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50T5hJcx032090;
 Wed, 29 Jan 2025 05:43:19 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44etxrw1xj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 29 Jan 2025 05:43:19 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50T5AR8i019265;
 Wed, 29 Jan 2025 05:43:18 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44db9my47f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 29 Jan 2025 05:43:18 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 50T5hHGH27525722
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 29 Jan 2025 05:43:18 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A4E8758059;
 Wed, 29 Jan 2025 05:43:17 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EC0B958058;
 Wed, 29 Jan 2025 05:43:12 +0000 (GMT)
Received: from [9.109.242.165] (unknown [9.109.242.165])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 29 Jan 2025 05:43:12 +0000 (GMT)
Message-ID: <994d3baf-7b49-442b-a7f6-8dab275a8458@linux.ibm.com>
Date: Wed, 29 Jan 2025 11:13:10 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/15] target/ppc: Restrict various common helpers to
 TCG
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>
References: <20250127102620.39159-1-philmd@linaro.org>
 <20250127102620.39159-12-philmd@linaro.org>
Content-Language: en-US
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <20250127102620.39159-12-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Qvvu91fYBgp5Va7gpRcx98IyvN6YhlXc
X-Proofpoint-GUID: yPF71GuPJCicmRigg70LuF889EfLF84Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-28_04,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 mlxscore=0
 impostorscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999
 priorityscore=1501 phishscore=0 adultscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2501290043
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
> Move helpers common to system/user emulation to tcg-excp_helper.c.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/ppc/excp_helper.c     | 141 ----------------------------------
>   target/ppc/tcg-excp_helper.c | 143 +++++++++++++++++++++++++++++++++++
>   2 files changed, 143 insertions(+), 141 deletions(-)
> 
> diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
> index 56a56148a40..48e08d65bd7 100644
> --- a/target/ppc/excp_helper.c
> +++ b/target/ppc/excp_helper.c
> @@ -2634,148 +2634,7 @@ void helper_rfmci(CPUPPCState *env)
>       /* FIXME: choose CSRR1 or MCSRR1 based on cpu type */
>       do_rfi(env, env->spr[SPR_BOOKE_MCSRR0], env->spr[SPR_BOOKE_MCSRR1]);
>   }
> -#endif /* !CONFIG_USER_ONLY */
>   
> -void helper_TW(CPUPPCState *env, target_ulong arg1, target_ulong arg2,
> -               uint32_t flags)
> -{
> -    if (!likely(!(((int32_t)arg1 < (int32_t)arg2 && (flags & 0x10)) ||
> -                  ((int32_t)arg1 > (int32_t)arg2 && (flags & 0x08)) ||
> -                  ((int32_t)arg1 == (int32_t)arg2 && (flags & 0x04)) ||
> -                  ((uint32_t)arg1 < (uint32_t)arg2 && (flags & 0x02)) ||
> -                  ((uint32_t)arg1 > (uint32_t)arg2 && (flags & 0x01))))) {
> -        raise_exception_err_ra(env, POWERPC_EXCP_PROGRAM,
> -                               POWERPC_EXCP_TRAP, GETPC());
> -    }
> -}
> -
> -#ifdef TARGET_PPC64
> -void helper_TD(CPUPPCState *env, target_ulong arg1, target_ulong arg2,
> -               uint32_t flags)
> -{
> -    if (!likely(!(((int64_t)arg1 < (int64_t)arg2 && (flags & 0x10)) ||
> -                  ((int64_t)arg1 > (int64_t)arg2 && (flags & 0x08)) ||
> -                  ((int64_t)arg1 == (int64_t)arg2 && (flags & 0x04)) ||
> -                  ((uint64_t)arg1 < (uint64_t)arg2 && (flags & 0x02)) ||
> -                  ((uint64_t)arg1 > (uint64_t)arg2 && (flags & 0x01))))) {
> -        raise_exception_err_ra(env, POWERPC_EXCP_PROGRAM,
> -                               POWERPC_EXCP_TRAP, GETPC());
> -    }
> -}
> -#endif /* TARGET_PPC64 */
> -
> -static uint32_t helper_SIMON_LIKE_32_64(uint32_t x, uint64_t key, uint32_t lane)
> -{
> -    const uint16_t c = 0xfffc;
> -    const uint64_t z0 = 0xfa2561cdf44ac398ULL;
> -    uint16_t z = 0, temp;
> -    uint16_t k[32], eff_k[32], xleft[33], xright[33], fxleft[32];
> -
> -    for (int i = 3; i >= 0; i--) {
> -        k[i] = key & 0xffff;
> -        key >>= 16;
> -    }
> -    xleft[0] = x & 0xffff;
> -    xright[0] = (x >> 16) & 0xffff;
> -
> -    for (int i = 0; i < 28; i++) {
> -        z = (z0 >> (63 - i)) & 1;
> -        temp = ror16(k[i + 3], 3) ^ k[i + 1];
> -        k[i + 4] = c ^ z ^ k[i] ^ temp ^ ror16(temp, 1);
> -    }
> -
> -    for (int i = 0; i < 8; i++) {
> -        eff_k[4 * i + 0] = k[4 * i + ((0 + lane) % 4)];
> -        eff_k[4 * i + 1] = k[4 * i + ((1 + lane) % 4)];
> -        eff_k[4 * i + 2] = k[4 * i + ((2 + lane) % 4)];
> -        eff_k[4 * i + 3] = k[4 * i + ((3 + lane) % 4)];
> -    }
> -
> -    for (int i = 0; i < 32; i++) {
> -        fxleft[i] = (rol16(xleft[i], 1) &
> -            rol16(xleft[i], 8)) ^ rol16(xleft[i], 2);
> -        xleft[i + 1] = xright[i] ^ fxleft[i] ^ eff_k[i];
> -        xright[i + 1] = xleft[i];
> -    }
> -
> -    return (((uint32_t)xright[32]) << 16) | xleft[32];
> -}
> -
> -static uint64_t hash_digest(uint64_t ra, uint64_t rb, uint64_t key)
> -{
> -    uint64_t stage0_h = 0ULL, stage0_l = 0ULL;
> -    uint64_t stage1_h, stage1_l;
> -
> -    for (int i = 0; i < 4; i++) {
> -        stage0_h |= ror64(rb & 0xff, 8 * (2 * i + 1));
> -        stage0_h |= ((ra >> 32) & 0xff) << (8 * 2 * i);
> -        stage0_l |= ror64((rb >> 32) & 0xff, 8 * (2 * i + 1));
> -        stage0_l |= (ra & 0xff) << (8 * 2 * i);
> -        rb >>= 8;
> -        ra >>= 8;
> -    }
> -
> -    stage1_h = (uint64_t)helper_SIMON_LIKE_32_64(stage0_h >> 32, key, 0) << 32;
> -    stage1_h |= helper_SIMON_LIKE_32_64(stage0_h, key, 1);
> -    stage1_l = (uint64_t)helper_SIMON_LIKE_32_64(stage0_l >> 32, key, 2) << 32;
> -    stage1_l |= helper_SIMON_LIKE_32_64(stage0_l, key, 3);
> -
> -    return stage1_h ^ stage1_l;
> -}
> -
> -static void do_hash(CPUPPCState *env, target_ulong ea, target_ulong ra,
> -                    target_ulong rb, uint64_t key, bool store)
> -{
> -    uint64_t calculated_hash = hash_digest(ra, rb, key), loaded_hash;
> -
> -    if (store) {
> -        cpu_stq_data_ra(env, ea, calculated_hash, GETPC());
> -    } else {
> -        loaded_hash = cpu_ldq_data_ra(env, ea, GETPC());
> -        if (loaded_hash != calculated_hash) {
> -            raise_exception_err_ra(env, POWERPC_EXCP_PROGRAM,
> -                POWERPC_EXCP_TRAP, GETPC());
> -        }
> -    }
> -}
> -
> -#include "qemu/guest-random.h"
> -
> -#ifdef TARGET_PPC64
> -#define HELPER_HASH(op, key, store, dexcr_aspect)                             \
> -void helper_##op(CPUPPCState *env, target_ulong ea, target_ulong ra,          \
> -                 target_ulong rb)                                             \
> -{                                                                             \
> -    if (env->msr & R_MSR_PR_MASK) {                                           \
> -        if (!(env->spr[SPR_DEXCR] & R_DEXCR_PRO_##dexcr_aspect##_MASK ||      \
> -            env->spr[SPR_HDEXCR] & R_HDEXCR_ENF_##dexcr_aspect##_MASK))       \
> -            return;                                                           \
> -    } else if (!(env->msr & R_MSR_HV_MASK)) {                                 \
> -        if (!(env->spr[SPR_DEXCR] & R_DEXCR_PNH_##dexcr_aspect##_MASK ||      \
> -            env->spr[SPR_HDEXCR] & R_HDEXCR_ENF_##dexcr_aspect##_MASK))       \
> -            return;                                                           \
> -    } else if (!(env->msr & R_MSR_S_MASK)) {                                  \
> -        if (!(env->spr[SPR_HDEXCR] & R_HDEXCR_HNU_##dexcr_aspect##_MASK))     \
> -            return;                                                           \
> -    }                                                                         \
> -                                                                              \
> -    do_hash(env, ea, ra, rb, key, store);                                     \
> -}
> -#else
> -#define HELPER_HASH(op, key, store, dexcr_aspect)                             \
> -void helper_##op(CPUPPCState *env, target_ulong ea, target_ulong ra,          \
> -                 target_ulong rb)                                             \
> -{                                                                             \
> -    do_hash(env, ea, ra, rb, key, store);                                     \
> -}
> -#endif /* TARGET_PPC64 */
> -
> -HELPER_HASH(HASHST, env->spr[SPR_HASHKEYR], true, NPHIE)
> -HELPER_HASH(HASHCHK, env->spr[SPR_HASHKEYR], false, NPHIE)
> -HELPER_HASH(HASHSTP, env->spr[SPR_HASHPKEYR], true, PHIE)
> -HELPER_HASH(HASHCHKP, env->spr[SPR_HASHPKEYR], false, PHIE)
> -
> -#ifndef CONFIG_USER_ONLY
>   /* Embedded.Processor Control */
>   static int dbell2irq(target_ulong rb)
>   {
> diff --git a/target/ppc/tcg-excp_helper.c b/target/ppc/tcg-excp_helper.c
> index dc5601a4577..5ad39cacc92 100644
> --- a/target/ppc/tcg-excp_helper.c
> +++ b/target/ppc/tcg-excp_helper.c
> @@ -66,6 +66,149 @@ void raise_exception(CPUPPCState *env, uint32_t exception)
>       raise_exception_err_ra(env, exception, 0, 0);
>   }
>   
> +#endif /* CONFIG_USER_ONLY */

Comment update needed: /* !CONFIG_USER_ONLY */

Otherwise,
Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>

> +
> +void helper_TW(CPUPPCState *env, target_ulong arg1, target_ulong arg2,
> +               uint32_t flags)
> +{
> +    if (!likely(!(((int32_t)arg1 < (int32_t)arg2 && (flags & 0x10)) ||
> +                  ((int32_t)arg1 > (int32_t)arg2 && (flags & 0x08)) ||
> +                  ((int32_t)arg1 == (int32_t)arg2 && (flags & 0x04)) ||
> +                  ((uint32_t)arg1 < (uint32_t)arg2 && (flags & 0x02)) ||
> +                  ((uint32_t)arg1 > (uint32_t)arg2 && (flags & 0x01))))) {
> +        raise_exception_err_ra(env, POWERPC_EXCP_PROGRAM,
> +                               POWERPC_EXCP_TRAP, GETPC());
> +    }
> +}
> +
> +#ifdef TARGET_PPC64
> +void helper_TD(CPUPPCState *env, target_ulong arg1, target_ulong arg2,
> +               uint32_t flags)
> +{
> +    if (!likely(!(((int64_t)arg1 < (int64_t)arg2 && (flags & 0x10)) ||
> +                  ((int64_t)arg1 > (int64_t)arg2 && (flags & 0x08)) ||
> +                  ((int64_t)arg1 == (int64_t)arg2 && (flags & 0x04)) ||
> +                  ((uint64_t)arg1 < (uint64_t)arg2 && (flags & 0x02)) ||
> +                  ((uint64_t)arg1 > (uint64_t)arg2 && (flags & 0x01))))) {
> +        raise_exception_err_ra(env, POWERPC_EXCP_PROGRAM,
> +                               POWERPC_EXCP_TRAP, GETPC());
> +    }
> +}
> +#endif /* TARGET_PPC64 */
> +
> +static uint32_t helper_SIMON_LIKE_32_64(uint32_t x, uint64_t key, uint32_t lane)
> +{
> +    const uint16_t c = 0xfffc;
> +    const uint64_t z0 = 0xfa2561cdf44ac398ULL;
> +    uint16_t z = 0, temp;
> +    uint16_t k[32], eff_k[32], xleft[33], xright[33], fxleft[32];
> +
> +    for (int i = 3; i >= 0; i--) {
> +        k[i] = key & 0xffff;
> +        key >>= 16;
> +    }
> +    xleft[0] = x & 0xffff;
> +    xright[0] = (x >> 16) & 0xffff;
> +
> +    for (int i = 0; i < 28; i++) {
> +        z = (z0 >> (63 - i)) & 1;
> +        temp = ror16(k[i + 3], 3) ^ k[i + 1];
> +        k[i + 4] = c ^ z ^ k[i] ^ temp ^ ror16(temp, 1);
> +    }
> +
> +    for (int i = 0; i < 8; i++) {
> +        eff_k[4 * i + 0] = k[4 * i + ((0 + lane) % 4)];
> +        eff_k[4 * i + 1] = k[4 * i + ((1 + lane) % 4)];
> +        eff_k[4 * i + 2] = k[4 * i + ((2 + lane) % 4)];
> +        eff_k[4 * i + 3] = k[4 * i + ((3 + lane) % 4)];
> +    }
> +
> +    for (int i = 0; i < 32; i++) {
> +        fxleft[i] = (rol16(xleft[i], 1) &
> +            rol16(xleft[i], 8)) ^ rol16(xleft[i], 2);
> +        xleft[i + 1] = xright[i] ^ fxleft[i] ^ eff_k[i];
> +        xright[i + 1] = xleft[i];
> +    }
> +
> +    return (((uint32_t)xright[32]) << 16) | xleft[32];
> +}
> +
> +static uint64_t hash_digest(uint64_t ra, uint64_t rb, uint64_t key)
> +{
> +    uint64_t stage0_h = 0ULL, stage0_l = 0ULL;
> +    uint64_t stage1_h, stage1_l;
> +
> +    for (int i = 0; i < 4; i++) {
> +        stage0_h |= ror64(rb & 0xff, 8 * (2 * i + 1));
> +        stage0_h |= ((ra >> 32) & 0xff) << (8 * 2 * i);
> +        stage0_l |= ror64((rb >> 32) & 0xff, 8 * (2 * i + 1));
> +        stage0_l |= (ra & 0xff) << (8 * 2 * i);
> +        rb >>= 8;
> +        ra >>= 8;
> +    }
> +
> +    stage1_h = (uint64_t)helper_SIMON_LIKE_32_64(stage0_h >> 32, key, 0) << 32;
> +    stage1_h |= helper_SIMON_LIKE_32_64(stage0_h, key, 1);
> +    stage1_l = (uint64_t)helper_SIMON_LIKE_32_64(stage0_l >> 32, key, 2) << 32;
> +    stage1_l |= helper_SIMON_LIKE_32_64(stage0_l, key, 3);
> +
> +    return stage1_h ^ stage1_l;
> +}
> +
> +static void do_hash(CPUPPCState *env, target_ulong ea, target_ulong ra,
> +                    target_ulong rb, uint64_t key, bool store)
> +{
> +    uint64_t calculated_hash = hash_digest(ra, rb, key), loaded_hash;
> +
> +    if (store) {
> +        cpu_stq_data_ra(env, ea, calculated_hash, GETPC());
> +    } else {
> +        loaded_hash = cpu_ldq_data_ra(env, ea, GETPC());
> +        if (loaded_hash != calculated_hash) {
> +            raise_exception_err_ra(env, POWERPC_EXCP_PROGRAM,
> +                POWERPC_EXCP_TRAP, GETPC());
> +        }
> +    }
> +}
> +
> +#include "qemu/guest-random.h"
> +
> +#ifdef TARGET_PPC64
> +#define HELPER_HASH(op, key, store, dexcr_aspect)                             \
> +void helper_##op(CPUPPCState *env, target_ulong ea, target_ulong ra,          \
> +                 target_ulong rb)                                             \
> +{                                                                             \
> +    if (env->msr & R_MSR_PR_MASK) {                                           \
> +        if (!(env->spr[SPR_DEXCR] & R_DEXCR_PRO_##dexcr_aspect##_MASK ||      \
> +            env->spr[SPR_HDEXCR] & R_HDEXCR_ENF_##dexcr_aspect##_MASK))       \
> +            return;                                                           \
> +    } else if (!(env->msr & R_MSR_HV_MASK)) {                                 \
> +        if (!(env->spr[SPR_DEXCR] & R_DEXCR_PNH_##dexcr_aspect##_MASK ||      \
> +            env->spr[SPR_HDEXCR] & R_HDEXCR_ENF_##dexcr_aspect##_MASK))       \
> +            return;                                                           \
> +    } else if (!(env->msr & R_MSR_S_MASK)) {                                  \
> +        if (!(env->spr[SPR_HDEXCR] & R_HDEXCR_HNU_##dexcr_aspect##_MASK))     \
> +            return;                                                           \
> +    }                                                                         \
> +                                                                              \
> +    do_hash(env, ea, ra, rb, key, store);                                     \
> +}
> +#else
> +#define HELPER_HASH(op, key, store, dexcr_aspect)                             \
> +void helper_##op(CPUPPCState *env, target_ulong ea, target_ulong ra,          \
> +                 target_ulong rb)                                             \
> +{                                                                             \
> +    do_hash(env, ea, ra, rb, key, store);                                     \
> +}
> +#endif /* TARGET_PPC64 */
> +
> +HELPER_HASH(HASHST, env->spr[SPR_HASHKEYR], true, NPHIE)
> +HELPER_HASH(HASHCHK, env->spr[SPR_HASHKEYR], false, NPHIE)
> +HELPER_HASH(HASHSTP, env->spr[SPR_HASHPKEYR], true, PHIE)
> +HELPER_HASH(HASHCHKP, env->spr[SPR_HASHPKEYR], false, PHIE)
> +
> +#ifndef CONFIG_USER_ONLY
> +
>   void ppc_cpu_do_unaligned_access(CPUState *cs, vaddr vaddr,
>                                    MMUAccessType access_type,
>                                    int mmu_idx, uintptr_t retaddr)

