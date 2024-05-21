Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 106CCC25B74
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2024 17:08:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9SxZ-00059j-AF; Tue, 21 May 2024 13:07:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1s9SxR-00055E-1k; Tue, 21 May 2024 13:07:26 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1s9SxN-0005Y9-DQ; Tue, 21 May 2024 13:07:23 -0400
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 44LGf15o006124; Tue, 21 May 2024 17:07:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : reply-to : to : cc : date : in-reply-to : references : content-type
 : mime-version : content-transfer-encoding; s=pp1;
 bh=FjgWeyJoe86pKzX3GwzL3eHkQVW30qhEBHjKCKGkq50=;
 b=JQSFKw4wxuXVb0+5G9GX8C4egq3g6qH9pdi8Za10CjlolDMTMRzLJkLZU5plh6ksZXBI
 VEFsC61RgWIgCZb29oRXeAE2nl0FRTHC4RiJD86GaCm07zeDWZ3LOVKrRFlEF3Pwj0J1
 JYbaqL+r0UagVC5DhmxSOjL+ADc1TNUioGZ3Aq+PwsoBjvbNtya/LeLY4PUDMNhxZ05x
 aVYaJcJGXWU0JkRpw0l1cQWOZgQ584Ai2l5tG80uQaErDpv+LgOu3icdfCUdfuz6jxs9
 p7auZaf1nt2THiAm3Ev8aj9nzIy3uhN7ZY6MdDnyELdTXmc8p2mzlWZVUHcTL4/LTsak kQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y8y53r3rg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 May 2024 17:07:17 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44LH7GBg021522;
 Tue, 21 May 2024 17:07:16 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y8y53r3re-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 May 2024 17:07:16 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 44LE7VhA023498; Tue, 21 May 2024 17:07:15 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3y77np6xfd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 May 2024 17:07:15 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 44LH7Ca917760864
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 21 May 2024 17:07:14 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B58FB58067;
 Tue, 21 May 2024 17:07:12 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 83A6D58062;
 Tue, 21 May 2024 17:07:12 +0000 (GMT)
Received: from mamboa4.aus.stglabs.ibm.com (unknown [9.3.84.87])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 21 May 2024 17:07:12 +0000 (GMT)
Message-ID: <d390aed7e8e07120d187493fc6314afdca4aefcd.camel@linux.ibm.com>
Subject: Re: [PATCH v2 12/12] target/ppc: add SMT support to msgsnd broadcast
From: Miles Glenn <milesg@linux.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>, Chinmay Rath
 <rathc@linux.ibm.com>
Date: Tue, 21 May 2024 12:07:12 -0500
In-Reply-To: <20240521013029.30082-13-npiggin@gmail.com>
References: <20240521013029.30082-1-npiggin@gmail.com>
 <20240521013029.30082-13-npiggin@gmail.com>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: IDnwMGTiC_gcQHJCM-z002kV09xrKcY1
X-Proofpoint-GUID: DyA8mDJuP112Nm70rWXcpJ7EVDMdtWI6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-21_10,2024-05-21_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0
 mlxscore=0 clxscore=1015 malwarescore=0 mlxlogscore=999 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 spamscore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405210130
Received-SPF: pass client-ip=148.163.156.1; envelope-from=milesg@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
> msgsnd has a broadcast mode that sends hypervisor doorbells to all
> threads belonging to the same core as the target. A "subcore" mode
> sends to all or one thread depending on 1LPAR mode.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  target/ppc/cpu.h                              |  6 +-
>  target/ppc/helper.h                           |  2 +-
>  target/ppc/excp_helper.c                      | 57 +++++++++++++--
> ----
>  .../ppc/translate/processor-ctrl-impl.c.inc   |  2 +-
>  4 files changed, 46 insertions(+), 21 deletions(-)
> 
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index e4c342b17d..e201b7f6c2 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -1163,7 +1163,11 @@ FIELD(FPSCR, FI, FPSCR_FI, 1)
>  
>  #define DBELL_TYPE_DBELL_SERVER        (0x05 << DBELL_TYPE_SHIFT)
>  
> -#define DBELL_BRDCAST                  PPC_BIT(37)
> +#define DBELL_BRDCAST_MASK             PPC_BITMASK(37, 38)
> +#define DBELL_BRDCAST_SHIFT            25
> +#define DBELL_BRDCAST_SUBPROC          (0x1 << DBELL_BRDCAST_SHIFT)
> +#define DBELL_BRDCAST_CORE             (0x2 << DBELL_BRDCAST_SHIFT)
> +
>  #define DBELL_LPIDTAG_SHIFT            14
>  #define DBELL_LPIDTAG_MASK             (0xfff <<
> DBELL_LPIDTAG_SHIFT)
>  #define DBELL_PIRTAG_MASK              0x3fff
> diff --git a/target/ppc/helper.h b/target/ppc/helper.h
> index 57bf8354e7..dd92c6a937 100644
> --- a/target/ppc/helper.h
> +++ b/target/ppc/helper.h
> @@ -695,7 +695,7 @@ DEF_HELPER_FLAGS_3(store_sr, TCG_CALL_NO_RWG,
> void, env, tl, tl)
>  
>  DEF_HELPER_1(msgsnd, void, tl)
>  DEF_HELPER_2(msgclr, void, env, tl)
> -DEF_HELPER_1(book3s_msgsnd, void, tl)
> +DEF_HELPER_2(book3s_msgsnd, void, env, tl)
>  DEF_HELPER_2(book3s_msgclr, void, env, tl)
>  #endif
>  
> diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
> index e786a9044b..0a9e8539a4 100644
> --- a/target/ppc/excp_helper.c
> +++ b/target/ppc/excp_helper.c
> @@ -2978,7 +2978,7 @@ void helper_msgsnd(target_ulong rb)
>          PowerPCCPU *cpu = POWERPC_CPU(cs);
>          CPUPPCState *cenv = &cpu->env;
>  
> -        if ((rb & DBELL_BRDCAST) || (cenv->spr[SPR_BOOKE_PIR] ==
> pir)) {
> +        if ((rb & DBELL_BRDCAST_MASK) || (cenv->spr[SPR_BOOKE_PIR]
> == pir)) {
>              ppc_set_irq(cpu, irq, 1);
>          }
>      }
> @@ -2997,6 +2997,16 @@ static bool dbell_type_server(target_ulong rb)
>      return (rb & DBELL_TYPE_MASK) == DBELL_TYPE_DBELL_SERVER;
>  }
>  
> +static inline bool dbell_bcast_core(target_ulong rb)
> +{
> +    return (rb & DBELL_BRDCAST_MASK) == DBELL_BRDCAST_CORE;
> +}
> +
> +static inline bool dbell_bcast_subproc(target_ulong rb)
> +{
> +    return (rb & DBELL_BRDCAST_MASK) == DBELL_BRDCAST_SUBPROC;
> +}
> +
>  void helper_book3s_msgclr(CPUPPCState *env, target_ulong rb)
>  {
>      if (!dbell_type_server(rb)) {
> @@ -3006,32 +3016,43 @@ void helper_book3s_msgclr(CPUPPCState *env,
> target_ulong rb)
>      ppc_set_irq(env_archcpu(env), PPC_INTERRUPT_HDOORBELL, 0);
>  }
>  
> -static void book3s_msgsnd_common(int pir, int irq)
> +void helper_book3s_msgsnd(CPUPPCState *env, target_ulong rb)
>  {
> -    CPUState *cs;
> +    int pir = rb & DBELL_PROCIDTAG_MASK;
> +    bool brdcast = false;
> +    CPUState *cs, *ccs;
> +    PowerPCCPU *cpu;
>  
> -    bql_lock();
> -    CPU_FOREACH(cs) {
> -        PowerPCCPU *cpu = POWERPC_CPU(cs);
> -        CPUPPCState *cenv = &cpu->env;
> +    if (!dbell_type_server(rb)) {
> +        return;
> +    }
>  
> -        /* TODO: broadcast message to all threads of the
> same  processor */
> -        if (cenv->spr_cb[SPR_PIR].default_value == pir) {
> -            ppc_set_irq(cpu, irq, 1);
> -        }
> +    cpu = ppc_get_vcpu_by_pir(pir);
> +    if (!cpu) {
> +        return;
>      }
> -    bql_unlock();
> -}
> +    cs = CPU(cpu);
>  
> -void helper_book3s_msgsnd(target_ulong rb)
> -{
> -    int pir = rb & DBELL_PROCIDTAG_MASK;
> +    if (dbell_bcast_core(rb) || (dbell_bcast_subproc(rb) &&
> +                                 (env->flags &
> POWERPC_FLAG_SMT_1LPAR))) {
> +        brdcast = true;
> +    }
>  
> -    if (!dbell_type_server(rb)) {
> +    if (cs->nr_threads == 1 || !brdcast) {
> +        ppc_set_irq(cpu, PPC_INTERRUPT_HDOORBELL, 1);
>          return;
>      }
>  
> -    book3s_msgsnd_common(pir, PPC_INTERRUPT_HDOORBELL);
> +    /*
> +     * Why is bql needed for walking CPU list? Answer seems to be
> because ppc
> +     * irq handling needs it, but ppc_set_irq takes the lock itself
> if needed,
> +     * so could this be removed?
> +     */
> +    bql_lock();
> +    THREAD_SIBLING_FOREACH(cs, ccs) {
> +        ppc_set_irq(POWERPC_CPU(ccs), PPC_INTERRUPT_HDOORBELL, 1);
> +    }
> +    bql_unlock();
>  }
>  
>  #ifdef TARGET_PPC64
> diff --git a/target/ppc/translate/processor-ctrl-impl.c.inc
> b/target/ppc/translate/processor-ctrl-impl.c.inc
> index 0142801985..8abbb89630 100644
> --- a/target/ppc/translate/processor-ctrl-impl.c.inc
> +++ b/target/ppc/translate/processor-ctrl-impl.c.inc
> @@ -59,7 +59,7 @@ static bool trans_MSGSND(DisasContext *ctx,
> arg_X_rb *a)
>  
>  #if !defined(CONFIG_USER_ONLY)
>      if (is_book3s_arch2x(ctx)) {
> -        gen_helper_book3s_msgsnd(cpu_gpr[a->rb]);
> +        gen_helper_book3s_msgsnd(tcg_env, cpu_gpr[a->rb]);
>      } else {
>          gen_helper_msgsnd(cpu_gpr[a->rb]);
>      }


