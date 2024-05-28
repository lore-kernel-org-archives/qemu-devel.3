Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BCA7C25B78
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 06:51:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBqfT-0007t0-6s; Tue, 28 May 2024 02:50:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1sBqfR-0007sj-Px; Tue, 28 May 2024 02:50:41 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1sBqfP-00021T-D8; Tue, 28 May 2024 02:50:41 -0400
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 44S64Voo003891; Tue, 28 May 2024 06:50:29 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1; _a=3Drsa-sha256; _c=3Drelaxed/relaxed;
 _d=3Dibm.com; _h=3Dcc?=
 =?UTF-8?Q?:content-transfer-encoding:content-type:date:from:in-reply-to:m?=
 =?UTF-8?Q?essage-id:mime-version:references:subject:to;_s=3Dpp1;_bh=3D5M5?=
 =?UTF-8?Q?JwSZb94a2QU8jxyu6Pzmkc89+pad4WPpVjzww1iI=3D;_b=3DFxHDq8u9f52wKF?=
 =?UTF-8?Q?PfecUEWyWwpWkb+2V/5cfpBHqCplilkYgfRkcM/6nx5RKAUK6ClD5u_5V9vEJar?=
 =?UTF-8?Q?LJOH8NlM6XEKsP355B489Jpbfq5h1R33Y26QTzOSWWjyoPtBAtPwjG5o++V4_to?=
 =?UTF-8?Q?34VkRcCjbL2oIw47jeSZGCLsb0gbBF7OmVbF1HLVtyT4P76/l+3iGS7Tt3Ccwm1?=
 =?UTF-8?Q?Oys_GeSV3S+VqRrk7njUo3LvPvut0iunwNFjCE9Cz/uYoFyPuDvUJHiqM8VvYyG?=
 =?UTF-8?Q?2JaJbecxM_Dysck068xOCOtixbZDPXfPBbJtehHIWRkNCOIrR+ta7bp5YBzj6QG?=
 =?UTF-8?Q?ZXLrKtrss+xt2zY_FA=3D=3D_?=
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yd9e204yb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 May 2024 06:50:28 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44S6oSZH018282;
 Tue, 28 May 2024 06:50:28 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yd9e204ya-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 May 2024 06:50:28 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 44S6h8o2032160; Tue, 28 May 2024 06:50:27 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ybutm5758-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 May 2024 06:50:27 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 44S6oOkl22741708
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 28 May 2024 06:50:26 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A97A958061;
 Tue, 28 May 2024 06:50:24 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5304858059;
 Tue, 28 May 2024 06:50:22 +0000 (GMT)
Received: from [9.109.242.165] (unknown [9.109.242.165])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 28 May 2024 06:50:22 +0000 (GMT)
Message-ID: <eed27a5e-6b32-45e0-8d76-51371fadc976@linux.ibm.com>
Date: Tue, 28 May 2024 12:20:20 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 03/10] target/ppc: Improve SPR indirect registers
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: Caleb Schlossin <calebs@linux.vnet.ibm.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-devel@nongnu.org
References: <20240526122612.473476-1-npiggin@gmail.com>
 <20240526122612.473476-4-npiggin@gmail.com>
Content-Language: en-US
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <20240526122612.473476-4-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: pagRG43Mo5vGRBOrnS2rJNLbgCvaSW64
X-Proofpoint-GUID: A9i4ZHlpECjQbMhFIWFPvvcu--7rUajs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-28_04,2024-05-27_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0
 lowpriorityscore=0 adultscore=0 bulkscore=0 mlxscore=0 phishscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 spamscore=0
 mlxlogscore=879 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2405010000 definitions=main-2405280048
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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


Hi Nick,

On 5/26/24 17:56, Nicholas Piggin wrote:
> SPRC/SPRD were recently added to all BookS CPUs supported, but
> they are only tested on POWER9 and POWER10, so restrict them to
> those CPUs.
> 

Hope you mean to restrict to P9/10 for both spapr and pnv or just pnv ?

> SPR indirect scratch registers presently replicated per-CPU like
> SMT SPRs, but the PnvCore is a better place for them since they
> are restricted to P9/P10.
> 
> Also add SPR indirect read access to core thread state for POWER9
> since skiboot accesses that when booting to check for big-core
> mode.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   include/hw/ppc/pnv_core.h |  1 +
>   target/ppc/cpu.h          |  3 --
>   target/ppc/cpu_init.c     | 21 ++++++------
>   target/ppc/misc_helper.c  | 67 ++++++++++++++++++++-------------------
>   4 files changed, 46 insertions(+), 46 deletions(-)
> 
> diff --git a/include/hw/ppc/pnv_core.h b/include/hw/ppc/pnv_core.h
> index f434c71547..21297262c1 100644
> --- a/include/hw/ppc/pnv_core.h
> +++ b/include/hw/ppc/pnv_core.h
> @@ -53,6 +53,7 @@ struct PnvCore {
>       uint32_t hwid;
>       uint64_t hrmor;
>   
> +    target_ulong scratch[8]; /* SCRATCH registers */
>       struct pnv_tod_tbst pnv_tod_tbst;
>   
>       PnvChip *chip;
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index 1e86658da6..dac13d4dac 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -1253,9 +1253,6 @@ struct CPUArchState {
>       ppc_slb_t slb[MAX_SLB_ENTRIES]; /* PowerPC 64 SLB area */
>       struct CPUBreakpoint *ciabr_breakpoint;
>       struct CPUWatchpoint *dawr0_watchpoint;
> -
> -    /* POWER CPU regs/state */
> -    target_ulong scratch[8]; /* SCRATCH registers (shared across core) */
>   #endif
>       target_ulong sr[32];   /* segment registers */
>       uint32_t nb_BATs;      /* number of BATs */
> diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
> index 01e358a4a5..ae483e20c4 100644
> --- a/target/ppc/cpu_init.c
> +++ b/target/ppc/cpu_init.c
> @@ -5759,16 +5759,6 @@ static void register_power_common_book4_sprs(CPUPPCState *env)
>                    SPR_NOACCESS, SPR_NOACCESS,
>                    &spr_read_generic, &spr_core_write_generic,
>                    0x00000000);
> -    spr_register_hv(env, SPR_POWER_SPRC, "SPRC",
> -                 SPR_NOACCESS, SPR_NOACCESS,
> -                 SPR_NOACCESS, SPR_NOACCESS,
> -                 &spr_read_generic, &spr_write_sprc,
> -                 0x00000000);
> -    spr_register_hv(env, SPR_POWER_SPRD, "SPRD",
> -                 SPR_NOACCESS, SPR_NOACCESS,
> -                 SPR_NOACCESS, SPR_NOACCESS,
> -                 &spr_read_sprd, &spr_write_sprd,
> -                 0x00000000);
>   #endif
>   }
>   
> @@ -5781,6 +5771,17 @@ static void register_power9_book4_sprs(CPUPPCState *env)
>                        SPR_NOACCESS, SPR_NOACCESS,
>                        &spr_read_generic, &spr_write_generic,
>                        KVM_REG_PPC_WORT, 0);
> +    /* SPRC/SPRD exist in earlier CPUs but only tested on POWER9/10 */
> +    spr_register_hv(env, SPR_POWER_SPRC, "SPRC",
> +                 SPR_NOACCESS, SPR_NOACCESS,
> +                 SPR_NOACCESS, SPR_NOACCESS,
> +                 &spr_read_generic, &spr_write_sprc,
> +                 0x00000000);
> +    spr_register_hv(env, SPR_POWER_SPRD, "SPRD",
> +                 SPR_NOACCESS, SPR_NOACCESS,
> +                 SPR_NOACCESS, SPR_NOACCESS,
> +                 &spr_read_sprd, &spr_write_sprd,
> +                 0x00000000);
>   #endif
>   }
>   
> diff --git a/target/ppc/misc_helper.c b/target/ppc/misc_helper.c
> index fa47be2298..46ba3a5584 100644
> --- a/target/ppc/misc_helper.c
> +++ b/target/ppc/misc_helper.c
> @@ -26,6 +26,7 @@
>   #include "qemu/main-loop.h"
>   #include "mmu-book3s-v3.h"
>   #include "hw/ppc/ppc.h"
> +#include "hw/ppc/pnv_core.h"
>   
>   #include "helper_regs.h"
>   
> @@ -321,11 +322,25 @@ void helper_store_sprc(CPUPPCState *env, target_ulong val)
>   
>   target_ulong helper_load_sprd(CPUPPCState *env)
>   {
> +    PowerPCCPU *cpu = env_archcpu(env);
> +    PnvCore *pc = pnv_cpu_state(cpu)->core;

We may want to avoid creating local variable cpu here also like previous 
patches.

However, is this helper meant to be accessible for spapr as well ?

>       target_ulong sprc = env->spr[SPR_POWER_SPRC];
>   
> -    switch (sprc & 0x3c0) {
> -    case 0: /* SCRATCH0-7 */
> -        return env->scratch[(sprc >> 3) & 0x7];
> +    switch (sprc & 0x3e0) {
> +    case 0: /* SCRATCH0-3 */
> +    case 1: /* SCRATCH4-7 */
> +        return pc->scratch[(sprc >> 3) & 0x7];

If so, will pc be uninitialized in case of spapr ?

> +    case 0x1e0: /* core thread state */
> +        if (env->excp_model == POWERPC_EXCP_POWER9) {
> +            /*
> +             * Only implement for POWER9 because skiboot uses it to check
> +             * big-core mode. Other bits are unimplemented so we would
> +             * prefer to get unimplemented message on POWER10 if it were
> +             * used.
> +             */
> +            return 0;
> +        }
> +        /* fallthru */
>       default:
>           qemu_log_mask(LOG_UNIMP, "mfSPRD: Unimplemented SPRC:0x"
>                                     TARGET_FMT_lx"\n", sprc);
> @@ -334,41 +349,27 @@ target_ulong helper_load_sprd(CPUPPCState *env)
>       return 0;
>   }
>   
> -static void do_store_scratch(CPUPPCState *env, int nr, target_ulong val)
> -{
> -    CPUState *cs = env_cpu(env);
> -    CPUState *ccs;
> -    uint32_t nr_threads = cs->nr_threads;
> -
> -    /*
> -     * Log stores to SCRATCH, because some firmware uses these for debugging
> -     * and logging, but they would normally be read by the BMC, which is
> -     * not implemented in QEMU yet. This gives a way to get at the information.
> -     * Could also dump these upon checkstop.
> -     */
> -    qemu_log("SPRD write 0x" TARGET_FMT_lx " to SCRATCH%d\n", val, nr);
> -
> -    if (nr_threads == 1) {
> -        env->scratch[nr] = val;
> -        return;
> -    }
> -
> -    THREAD_SIBLING_FOREACH(cs, ccs) {
> -        CPUPPCState *cenv = &POWERPC_CPU(ccs)->env;
> -        cenv->scratch[nr] = val;
> -    }
> -}
> -
>   void helper_store_sprd(CPUPPCState *env, target_ulong val)
>   {
>       target_ulong sprc = env->spr[SPR_POWER_SPRC];
> -
> -    switch (sprc & 0x3c0) {
> -    case 0: /* SCRATCH0-7 */
> -        do_store_scratch(env, (sprc >> 3) & 0x7, val);
> +    PowerPCCPU *cpu = env_archcpu(env);
> +    PnvCore *pc = pnv_cpu_state(cpu)->core;

Ditto?

> +
> +    switch (sprc & 0x3e0) {
> +    case 0: /* SCRATCH0-3 */
> +    case 1: /* SCRATCH4-7 */
> +        /*
> +         * Log stores to SCRATCH, because some firmware uses these for
> +         * debugging and logging, but they would normally be read by the BMC,
> +	 * which is not implemented in QEMU yet. This gives a way to get at the
> +	 * information. Could also dump these upon checkstop.
> +         */
> +        int nr = (sprc >> 3) & 0x7;
> +        qemu_log("SPRD write 0x" TARGET_FMT_lx " to SCRATCH%d\n", val, nr);
> +        pc->scratch[nr] = val;

regards,
Harsh
>           break;
>       default:
> -        qemu_log_mask(LOG_UNIMP, "mfSPRD: Unimplemented SPRC:0x"
> +        qemu_log_mask(LOG_UNIMP, "mtSPRD: Unimplemented SPRC:0x"
>                                     TARGET_FMT_lx"\n", sprc);
>           break;
>       }

