Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1140DCF6A84
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 08:33:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdlSS-0004l9-Pi; Thu, 08 Jan 2026 03:33:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1vdlSQ-0004aO-MQ; Thu, 08 Jan 2026 03:33:26 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1vdlSO-0005X5-FQ; Thu, 08 Jan 2026 03:33:26 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 607JFIkU005461;
 Thu, 8 Jan 2026 08:33:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=Iifplq
 LL/liimhfbUr0E+m1Ka5GskMN2fY+uyjRaXMs=; b=prsKiq5y521vtrpkH74WxW
 8Pb5KXZlmP53eiNMp8UY0xkdRFwphejZ+zqP5OgaeieV9zfUURFT+tomYnzr427+
 gxgO/aABJ1gZ/4KMSNnKWpZK0GRiv2cqdtRmpGi2ASr7gSJhgpAZKjxYFiNfEvKj
 m87jZksip68t4SOAf3AG1B0xqhxM/3Qmzh9g9sVfutPcdONDO5vuTL6zjseuBq78
 4k6RjETQe6/b2jxTXwfdbZGoAtMTESGuizY09Le7/+2YmdLSJNOXgjQi4E7WHlGi
 8TpBbGMY9MjbZ+605fH2MyVlHGm5GVfYcq5/pwvn8gU6lf6tZyLht3kFZPJiizPA
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4betu6d6us-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 08 Jan 2026 08:33:19 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 6088XJdx019689;
 Thu, 8 Jan 2026 08:33:19 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4betu6d6up-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 08 Jan 2026 08:33:19 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6086tiDp019337;
 Thu, 8 Jan 2026 08:33:18 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4bfg51dhcd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 08 Jan 2026 08:33:18 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6088XHvE14025350
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 8 Jan 2026 08:33:17 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5969B5805D;
 Thu,  8 Jan 2026 08:33:17 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BEC4058058;
 Thu,  8 Jan 2026 08:33:13 +0000 (GMT)
Received: from [9.124.217.83] (unknown [9.124.217.83])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
 Thu,  8 Jan 2026 08:33:13 +0000 (GMT)
Message-ID: <16a38211-b837-40b7-9460-2b896fbab3c9@linux.ibm.com>
Date: Thu, 8 Jan 2026 14:03:10 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] target/ppc: Restrict WatchPoint API to TCG
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>
References: <20260106231908.16756-1-philmd@linaro.org>
 <20260106231908.16756-3-philmd@linaro.org>
Content-Language: en-US
From: Chinmay Rath <rathc@linux.ibm.com>
In-Reply-To: <20260106231908.16756-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=QbNrf8bv c=1 sm=1 tr=0 ts=695f6bcf cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8 a=GnNG9Bo9lznobqhWuPoA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: AVDnsqlujqzTFP71Mobdm2SqnUNM7IpR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA4MDA1NiBTYWx0ZWRfX4BCzbhtV9C0v
 lE0ICP5getu5+zZNiHKb87wA9aHvMhyhVHGpuutvtaxExemYg6FUEbsVxd/PbOuiDd7/k6kiLoA
 UGnb65dC4oo+uh4usi2y3qL0ebmQPuIzkixcD5sTSGH0X9MudzLAUXzOveYocHilUId3HhKv9RE
 cX4lbDGO6GZBnSQZEJ5vdgyQuf9Tv0isCdNyxADe9Nk/lYjWqn+310TsluTjRHCo9vclPh2BQrt
 W4lm+3qAwIJfyR5UsEd8CnU0e4G8AmbQlMkxI5+/6t8GXNlw0ZeCIt04Ig9omYundKjVWJagnn+
 TJbL1NvvoWoivfMiwy45nDDdLPN2G20an3mg0RT1pgGtt/VbMBHGU41MBTAiraCAZnR5nCAc2bT
 9xobhgPVr1H5PaAYpJ7wm0hbYryejXpZDIC80sbqEs8edE5xX9tALlIh/eeVvgGAnVfG9DuE4Ye
 eWVLEMhM47fJCvNQZlA==
X-Proofpoint-GUID: OGf4zbrBiP5fozsHYsYo_LUuInOA_1jB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-08_01,2026-01-07_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1011 bulkscore=0 suspectscore=0 priorityscore=1501
 adultscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2512120000 definitions=main-2601080056
Received-SPF: pass client-ip=148.163.156.1; envelope-from=rathc@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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


On 1/7/26 04:49, Philippe Mathieu-Daudé wrote:
> Watchpoints are specific to the TCG accelerator. Since the
> Data Address Watchpoint helpers are only called from
> translated code, move them to a new 'watchpoint.c' file,
> specific to TCG. Thus restricting the WatchPoint API to TCG.
>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Chinmay Rath <rathc@linux.ibm.com>
> ---
>   target/ppc/cpu.c        | 81 +----------------------------------
>   target/ppc/watchpoint.c | 93 +++++++++++++++++++++++++++++++++++++++++
>   target/ppc/meson.build  |  1 +
>   3 files changed, 96 insertions(+), 79 deletions(-)
>   create mode 100644 target/ppc/watchpoint.c
>
> diff --git a/target/ppc/cpu.c b/target/ppc/cpu.c
> index 4d8faaddee2..9cb3f00aa88 100644
> --- a/target/ppc/cpu.c
> +++ b/target/ppc/cpu.c
> @@ -131,85 +131,8 @@ void ppc_store_ciabr(CPUPPCState *env, target_ulong val)
>       ppc_update_ciabr(env);
>   }
>   
> -void ppc_update_daw(CPUPPCState *env, int rid)
> -{
> -    CPUState *cs = env_cpu(env);
> -    int spr_dawr = rid ? SPR_DAWR1 : SPR_DAWR0;
> -    int spr_dawrx = rid ? SPR_DAWRX1 : SPR_DAWRX0;
> -    target_ulong deaw = env->spr[spr_dawr] & PPC_BITMASK(0, 60);
> -    uint32_t dawrx = env->spr[spr_dawrx];
> -    int mrd = extract32(dawrx, PPC_BIT_NR(48), 54 - 48);
> -    bool dw = extract32(dawrx, PPC_BIT_NR(57), 1);
> -    bool dr = extract32(dawrx, PPC_BIT_NR(58), 1);
> -    bool hv = extract32(dawrx, PPC_BIT_NR(61), 1);
> -    bool sv = extract32(dawrx, PPC_BIT_NR(62), 1);
> -    bool pr = extract32(dawrx, PPC_BIT_NR(62), 1);
> -    vaddr len;
> -    int flags;
> -
> -    if (env->dawr_watchpoint[rid]) {
> -        cpu_watchpoint_remove_by_ref(cs, env->dawr_watchpoint[rid]);
> -        env->dawr_watchpoint[rid] = NULL;
> -    }
> -
> -    if (!dr && !dw) {
> -        return;
> -    }
> -
> -    if (!hv && !sv && !pr) {
> -        return;
> -    }
> -
> -    len = (mrd + 1) * 8;
> -    flags = BP_CPU | BP_STOP_BEFORE_ACCESS;
> -    if (dr) {
> -        flags |= BP_MEM_READ;
> -    }
> -    if (dw) {
> -        flags |= BP_MEM_WRITE;
> -    }
> -
> -    cpu_watchpoint_insert(cs, deaw, len, flags, &env->dawr_watchpoint[rid]);
> -}
> -
> -void ppc_store_dawr0(CPUPPCState *env, target_ulong val)
> -{
> -    env->spr[SPR_DAWR0] = val;
> -    ppc_update_daw(env, 0);
> -}
> -
> -static void ppc_store_dawrx(CPUPPCState *env, uint32_t val, int rid)
> -{
> -    int hrammc = extract32(val, PPC_BIT_NR(56), 1);
> -
> -    if (hrammc) {
> -        /* This might be done with a second watchpoint at the xor of DEAW[0] */
> -        qemu_log_mask(LOG_UNIMP, "%s: DAWRX%d[HRAMMC] is unimplemented\n",
> -                      __func__, rid);
> -    }
> -
> -    env->spr[rid ? SPR_DAWRX1 : SPR_DAWRX0] = val;
> -    ppc_update_daw(env, rid);
> -}
> -
> -void ppc_store_dawrx0(CPUPPCState *env, uint32_t val)
> -{
> -    ppc_store_dawrx(env, val, 0);
> -}
> -
> -void ppc_store_dawr1(CPUPPCState *env, target_ulong val)
> -{
> -    env->spr[SPR_DAWR1] = val;
> -    ppc_update_daw(env, 1);
> -}
> -
> -void ppc_store_dawrx1(CPUPPCState *env, uint32_t val)
> -{
> -    ppc_store_dawrx(env, val, 1);
> -}
> -
> -#endif
> -#endif
> +#endif /* TARGET_PPC64 */
> +#endif /* !CONFIG_USER_ONLY */
>   
>   static inline void fpscr_set_rounding_mode(CPUPPCState *env)
>   {
> diff --git a/target/ppc/watchpoint.c b/target/ppc/watchpoint.c
> new file mode 100644
> index 00000000000..c71dd4550b7
> --- /dev/null
> +++ b/target/ppc/watchpoint.c
> @@ -0,0 +1,93 @@
> +/*
> + * PowerPC watchpoint routines for QEMU
> + *
> + * Copyright (c) 2017 Nikunj A Dadhania, IBM Corporation.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "exec/log.h"
> +#include "accel/tcg/watchpoint.h"
> +#include "target/ppc/cpu.h"
> +
> +#if defined(TARGET_PPC64)
> +
> +void ppc_update_daw(CPUPPCState *env, int rid)
> +{
> +    CPUState *cs = env_cpu(env);
> +    int spr_dawr = rid ? SPR_DAWR1 : SPR_DAWR0;
> +    int spr_dawrx = rid ? SPR_DAWRX1 : SPR_DAWRX0;
> +    target_ulong deaw = env->spr[spr_dawr] & PPC_BITMASK(0, 60);
> +    uint32_t dawrx = env->spr[spr_dawrx];
> +    int mrd = extract32(dawrx, PPC_BIT_NR(48), 54 - 48);
> +    bool dw = extract32(dawrx, PPC_BIT_NR(57), 1);
> +    bool dr = extract32(dawrx, PPC_BIT_NR(58), 1);
> +    bool hv = extract32(dawrx, PPC_BIT_NR(61), 1);
> +    bool sv = extract32(dawrx, PPC_BIT_NR(62), 1);
> +    bool pr = extract32(dawrx, PPC_BIT_NR(62), 1);
> +    vaddr len;
> +    int flags;
> +
> +    if (env->dawr_watchpoint[rid]) {
> +        cpu_watchpoint_remove_by_ref(cs, env->dawr_watchpoint[rid]);
> +        env->dawr_watchpoint[rid] = NULL;
> +    }
> +
> +    if (!dr && !dw) {
> +        return;
> +    }
> +
> +    if (!hv && !sv && !pr) {
> +        return;
> +    }
> +
> +    len = (mrd + 1) * 8;
> +    flags = BP_CPU | BP_STOP_BEFORE_ACCESS;
> +    if (dr) {
> +        flags |= BP_MEM_READ;
> +    }
> +    if (dw) {
> +        flags |= BP_MEM_WRITE;
> +    }
> +
> +    cpu_watchpoint_insert(cs, deaw, len, flags, &env->dawr_watchpoint[rid]);
> +}
> +
> +void ppc_store_dawr0(CPUPPCState *env, target_ulong val)
> +{
> +    env->spr[SPR_DAWR0] = val;
> +    ppc_update_daw(env, 0);
> +}
> +
> +static void ppc_store_dawrx(CPUPPCState *env, uint32_t val, int rid)
> +{
> +    int hrammc = extract32(val, PPC_BIT_NR(56), 1);
> +
> +    if (hrammc) {
> +        /* This might be done with a second watchpoint at the xor of DEAW[0] */
> +        qemu_log_mask(LOG_UNIMP, "%s: DAWRX%d[HRAMMC] is unimplemented\n",
> +                      __func__, rid);
> +    }
> +
> +    env->spr[rid ? SPR_DAWRX1 : SPR_DAWRX0] = val;
> +    ppc_update_daw(env, rid);
> +}
> +
> +void ppc_store_dawrx0(CPUPPCState *env, uint32_t val)
> +{
> +    ppc_store_dawrx(env, val, 0);
> +}
> +
> +void ppc_store_dawr1(CPUPPCState *env, target_ulong val)
> +{
> +    env->spr[SPR_DAWR1] = val;
> +    ppc_update_daw(env, 1);
> +}
> +
> +void ppc_store_dawrx1(CPUPPCState *env, uint32_t val)
> +{
> +    ppc_store_dawrx(env, val, 1);
> +}
> +
> +#endif
> diff --git a/target/ppc/meson.build b/target/ppc/meson.build
> index 8eed1fa40ca..d354c3240a2 100644
> --- a/target/ppc/meson.build
> +++ b/target/ppc/meson.build
> @@ -43,6 +43,7 @@ ppc_system_ss.add(files(
>     'ppc-qmp-cmds.c',
>   ))
>   ppc_system_ss.add(when: 'CONFIG_TCG', if_true: files(
> +  'watchpoint.c',
>     'mmu_helper.c',
>   ), if_false: files(
>     'tcg-stub.c',

