Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0692C25B74
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2024 16:39:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9SVA-0001Sy-6E; Tue, 21 May 2024 12:38:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1s9SV4-0001Se-2U; Tue, 21 May 2024 12:38:06 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1s9SUx-0000AF-PN; Tue, 21 May 2024 12:38:05 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 44LGZceY007302; Tue, 21 May 2024 16:37:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : reply-to : to : cc : date : in-reply-to : references : content-type
 : mime-version : content-transfer-encoding; s=pp1;
 bh=tEiqjZdKlDZzbu3gerLcY0UPMx/iUnMBmLiyL70vVvQ=;
 b=CcjG/zS+SWOZEOees4hjmTmINnXLXoRXzm9tQBieDSuuTvyIpjI9jyiEnDg+CnlfEExB
 qQ+xUNMmvrhlVsWyw18Mu1r8UtYYlYTDwcfFnRScDCDBYTrGmAN+Lxv8Sgy0YAC00NYn
 rQFXDYUwC6DN8DkLWFZdf2MteG2EfCJZVD3idSAbJ1ewqqCrlREV6txopKm9lkN3XnFC
 wzU3fhvyoUHujyxctV2f5Te+Ev/ZfWCcLLN5edMyCt6Zb/CeWN/HigK+lzPeXwuER7fj
 YVnKxdXtXgNiTz47vlvdOnovna2KKjJgLrfsYCHJLc0nOAUol8MixQKJFw8gxsyyi5mT FA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y8vxv0dgv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 May 2024 16:37:55 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44LGbtna010393;
 Tue, 21 May 2024 16:37:55 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y8vxv0dgu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 May 2024 16:37:55 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 44LEkGBf026474; Tue, 21 May 2024 16:37:54 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3y785men3r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 May 2024 16:37:54 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 44LGbpGf27132436
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 21 May 2024 16:37:53 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id ACF1758063;
 Tue, 21 May 2024 16:37:51 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5BF9358043;
 Tue, 21 May 2024 16:37:51 +0000 (GMT)
Received: from mamboa4.aus.stglabs.ibm.com (unknown [9.3.84.87])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 21 May 2024 16:37:51 +0000 (GMT)
Message-ID: <3794936cf8166557df9fd9f6fd440e77aaf9514d.camel@linux.ibm.com>
Subject: Re: [PATCH v2 11/12] target/ppc: Implement SPRC/SPRD SPRs
From: Miles Glenn <milesg@linux.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>, Chinmay Rath
 <rathc@linux.ibm.com>
Date: Tue, 21 May 2024 11:37:51 -0500
In-Reply-To: <20240521013029.30082-12-npiggin@gmail.com>
References: <20240521013029.30082-1-npiggin@gmail.com>
 <20240521013029.30082-12-npiggin@gmail.com>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: tWaQlbRcGMKEh0on7B8wZJBNr_H2fzHC
X-Proofpoint-ORIG-GUID: ioiR9I_Wjike7oXIuyzxBOVH8h7JTS4D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-21_10,2024-05-21_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0
 mlxscore=0 priorityscore=1501 bulkscore=0 phishscore=0 lowpriorityscore=0
 suspectscore=0 clxscore=1015 spamscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405210126
Received-SPF: pass client-ip=148.163.156.1; envelope-from=milesg@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-To: milesg@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Reviewed-by: Glenn Miles <milesg@linux.ibm.com>

Thanks,

Glenn

On Tue, 2024-05-21 at 11:30 +1000, Nicholas Piggin wrote:
> This implements the POWER SPRC/SPRD SPRs, and SCRATCH0-7 registers
> that
> can be accessed via these indirect SPRs.
> 
> SCRATCH registers only provide storage, but they are used by firmware
> for low level crash and progress data, so this implementation logs
> writes to the registers to help with analysis.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  target/ppc/cpu.h         |  7 +++--
>  target/ppc/helper.h      |  3 ++
>  target/ppc/spr_common.h  |  3 ++
>  target/ppc/cpu_init.c    | 10 ++++++
>  target/ppc/misc_helper.c | 66
> ++++++++++++++++++++++++++++++++++++++++
>  target/ppc/translate.c   | 18 +++++++++++
>  6 files changed, 105 insertions(+), 2 deletions(-)
> 
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index 823be85d03..e4c342b17d 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -1264,6 +1264,9 @@ struct CPUArchState {
>      ppc_slb_t slb[MAX_SLB_ENTRIES]; /* PowerPC 64 SLB area */
>      struct CPUBreakpoint *ciabr_breakpoint;
>      struct CPUWatchpoint *dawr0_watchpoint;
> +
> +    /* POWER CPU regs/state */
> +    target_ulong scratch[8]; /* SCRATCH registers (shared across
> core) */
>  #endif
>      target_ulong sr[32];   /* segment registers */
>      uint32_t nb_BATs;      /* number of BATs */
> @@ -1806,9 +1809,9 @@ void ppc_compat_add_property(Object *obj, const
> char *name,
>  #define SPR_SPRG2             (0x112)
>  #define SPR_SPRG3             (0x113)
>  #define SPR_SPRG4             (0x114)
> -#define SPR_SCOMC             (0x114)
> +#define SPR_POWER_SPRC        (0x114)
>  #define SPR_SPRG5             (0x115)
> -#define SPR_SCOMD             (0x115)
> +#define SPR_POWER_SPRD        (0x115)
>  #define SPR_SPRG6             (0x116)
>  #define SPR_SPRG7             (0x117)
>  #define SPR_ASR               (0x118)
> diff --git a/target/ppc/helper.h b/target/ppc/helper.h
> index 09d50f9b76..57bf8354e7 100644
> --- a/target/ppc/helper.h
> +++ b/target/ppc/helper.h
> @@ -730,6 +730,9 @@ DEF_HELPER_2(book3s_msgsndp, void, env, tl)
>  DEF_HELPER_2(book3s_msgclrp, void, env, tl)
>  DEF_HELPER_1(load_tfmr, tl, env)
>  DEF_HELPER_2(store_tfmr, void, env, tl)
> +DEF_HELPER_FLAGS_2(store_sprc, TCG_CALL_NO_RWG, void, env, tl)
> +DEF_HELPER_FLAGS_1(load_sprd, TCG_CALL_NO_RWG_SE, tl, env)
> +DEF_HELPER_FLAGS_2(store_sprd, TCG_CALL_NO_RWG, void, env, tl)
>  #endif
>  DEF_HELPER_2(store_sdr1, void, env, tl)
>  DEF_HELPER_2(store_pidr, void, env, tl)
> diff --git a/target/ppc/spr_common.h b/target/ppc/spr_common.h
> index 85f73b860b..01aff449bc 100644
> --- a/target/ppc/spr_common.h
> +++ b/target/ppc/spr_common.h
> @@ -207,6 +207,9 @@ void spr_write_lpcr(DisasContext *ctx, int sprn,
> int gprn);
>  void spr_read_dexcr_ureg(DisasContext *ctx, int gprn, int sprn);
>  void spr_read_ppr32(DisasContext *ctx, int sprn, int gprn);
>  void spr_write_ppr32(DisasContext *ctx, int sprn, int gprn);
> +void spr_write_sprc(DisasContext *ctx, int sprn, int gprn);
> +void spr_read_sprd(DisasContext *ctx, int sprn, int gprn);
> +void spr_write_sprd(DisasContext *ctx, int sprn, int gprn);
>  #endif
>  
>  void register_low_BATs(CPUPPCState *env);
> diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
> index 7f2f8e5a4a..f21dbcfefb 100644
> --- a/target/ppc/cpu_init.c
> +++ b/target/ppc/cpu_init.c
> @@ -5794,6 +5794,16 @@ static void
> register_power_common_book4_sprs(CPUPPCState *env)
>                   SPR_NOACCESS, SPR_NOACCESS,
>                   &spr_read_generic, &spr_core_write_generic,
>                   0x00000000);
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
>  #endif
>  }
>  
> diff --git a/target/ppc/misc_helper.c b/target/ppc/misc_helper.c
> index a67930d031..fa47be2298 100644
> --- a/target/ppc/misc_helper.c
> +++ b/target/ppc/misc_helper.c
> @@ -307,6 +307,72 @@ void helper_store_dpdes(CPUPPCState *env,
> target_ulong val)
>      }
>      bql_unlock();
>  }
> +
> +/* Indirect SCOM (SPRC/SPRD) access to SCRATCH0-7 are implemented.
> */
> +void helper_store_sprc(CPUPPCState *env, target_ulong val)
> +{
> +    if (val & ~0x3f8ULL) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "Invalid SPRC register value
> "
> +                      TARGET_FMT_lx"\n", val);
> +        return;
> +    }
> +    env->spr[SPR_POWER_SPRC] = val;
> +}
> +
> +target_ulong helper_load_sprd(CPUPPCState *env)
> +{
> +    target_ulong sprc = env->spr[SPR_POWER_SPRC];
> +
> +    switch (sprc & 0x3c0) {
> +    case 0: /* SCRATCH0-7 */
> +        return env->scratch[(sprc >> 3) & 0x7];
> +    default:
> +        qemu_log_mask(LOG_UNIMP, "mfSPRD: Unimplemented SPRC:0x"
> +                                  TARGET_FMT_lx"\n", sprc);
> +        break;
> +    }
> +    return 0;
> +}
> +
> +static void do_store_scratch(CPUPPCState *env, int nr, target_ulong
> val)
> +{
> +    CPUState *cs = env_cpu(env);
> +    CPUState *ccs;
> +    uint32_t nr_threads = cs->nr_threads;
> +
> +    /*
> +     * Log stores to SCRATCH, because some firmware uses these for
> debugging
> +     * and logging, but they would normally be read by the BMC,
> which is
> +     * not implemented in QEMU yet. This gives a way to get at the
> information.
> +     * Could also dump these upon checkstop.
> +     */
> +    qemu_log("SPRD write 0x" TARGET_FMT_lx " to SCRATCH%d\n", val,
> nr);
> +
> +    if (nr_threads == 1) {
> +        env->scratch[nr] = val;
> +        return;
> +    }
> +
> +    THREAD_SIBLING_FOREACH(cs, ccs) {
> +        CPUPPCState *cenv = &POWERPC_CPU(ccs)->env;
> +        cenv->scratch[nr] = val;
> +    }
> +}
> +
> +void helper_store_sprd(CPUPPCState *env, target_ulong val)
> +{
> +    target_ulong sprc = env->spr[SPR_POWER_SPRC];
> +
> +    switch (sprc & 0x3c0) {
> +    case 0: /* SCRATCH0-7 */
> +        do_store_scratch(env, (sprc >> 3) & 0x7, val);
> +        break;
> +    default:
> +        qemu_log_mask(LOG_UNIMP, "mfSPRD: Unimplemented SPRC:0x"
> +                                  TARGET_FMT_lx"\n", sprc);
> +        break;
> +    }
> +}
>  #endif /* defined(TARGET_PPC64) */
>  
>  void helper_store_pidr(CPUPPCState *env, target_ulong val)
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index 76f829ad12..ab11e48e3f 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -1363,6 +1363,24 @@ void spr_write_tfmr(DisasContext *ctx, int
> sprn, int gprn)
>      gen_helper_store_tfmr(tcg_env, cpu_gpr[gprn]);
>  }
>  
> +void spr_write_sprc(DisasContext *ctx, int sprn, int gprn)
> +{
> +    gen_helper_store_sprc(tcg_env, cpu_gpr[gprn]);
> +}
> +
> +void spr_read_sprd(DisasContext *ctx, int gprn, int sprn)
> +{
> +    gen_helper_load_sprd(cpu_gpr[gprn], tcg_env);
> +}
> +
> +void spr_write_sprd(DisasContext *ctx, int sprn, int gprn)
> +{
> +    if (!gen_serialize_core(ctx)) {
> +        return;
> +    }
> +    gen_helper_store_sprd(tcg_env, cpu_gpr[gprn]);
> +}
> +
>  void spr_write_lpcr(DisasContext *ctx, int sprn, int gprn)
>  {
>      translator_io_start(&ctx->base);


