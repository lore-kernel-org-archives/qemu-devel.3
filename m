Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47F84C25B78
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 06:29:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBqJs-0003aH-SD; Tue, 28 May 2024 02:28:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1sBqJk-0003ZE-TI; Tue, 28 May 2024 02:28:18 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1sBqJg-0006Hn-0y; Tue, 28 May 2024 02:28:16 -0400
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 44S6B23e028000; Tue, 28 May 2024 06:28:09 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1; _a=3Drsa-sha256; _c=3Drelaxed/relaxed;
 _d=3Dibm.com; _h=3Dcc?=
 =?UTF-8?Q?:content-transfer-encoding:content-type:date:from:in-reply-to:m?=
 =?UTF-8?Q?essage-id:mime-version:references:subject:to;_s=3Dpp1;_bh=3DYAT?=
 =?UTF-8?Q?JobFGrHpiaPiUMCTfMXg4AMOe4hiLzIBQtEhanA4=3D;_b=3DiBoG3A7i3KJuKq?=
 =?UTF-8?Q?gxZKpMU0WmBBmz2km1qckcPvaxcW/vPTZYXtmmL1uYINAPgUghqIXN_1pE1fYO9?=
 =?UTF-8?Q?4iLXorwrxDwMIl7UmGqsZY5clUC51L71vAxLYGLkPMZ7kuRVwePN4wcdZWHq_tI?=
 =?UTF-8?Q?pFHWPCozmFsRKpA4XWZPEsqDzC103vy3Ad0mjIr27coK9Hl6Ypb+Pe+X7onzRF4?=
 =?UTF-8?Q?E7/_zqE0pko/SFyJY+B3JwD+9NomFggWNbkS75ywHTCKiT/UIBGVGb0xTGtabZu?=
 =?UTF-8?Q?zbS328Fgm_mkkjsWywbujzSfdOc+Lg982GrtmbkrE8JIAKbdpFOemmS1WzY8A9d?=
 =?UTF-8?Q?2pDytCHCM3WDhm7_5g=3D=3D_?=
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yd8wsr5mn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 May 2024 06:28:08 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44S6S8JC021792;
 Tue, 28 May 2024 06:28:08 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yd8wsr5mk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 May 2024 06:28:08 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 44S4OCCM006721; Tue, 28 May 2024 06:28:07 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ybtatdjhm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 May 2024 06:28:07 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 44S6S4DV36242034
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 28 May 2024 06:28:06 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5C78D5805D;
 Tue, 28 May 2024 06:28:04 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 00C4B58061;
 Tue, 28 May 2024 06:28:02 +0000 (GMT)
Received: from [9.109.242.165] (unknown [9.109.242.165])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 28 May 2024 06:28:01 +0000 (GMT)
Message-ID: <5876e49c-9912-4979-9613-c60d40eabd41@linux.ibm.com>
Date: Tue, 28 May 2024 11:58:00 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 02/10] ppc/pnv: Move timebase state into PnvCore
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: Caleb Schlossin <calebs@linux.vnet.ibm.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-devel@nongnu.org
References: <20240526122612.473476-1-npiggin@gmail.com>
 <20240526122612.473476-3-npiggin@gmail.com>
Content-Language: en-US
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <20240526122612.473476-3-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: v5gnNYOj2Qp57xntGjkGXceggWgg5VCV
X-Proofpoint-GUID: hJFDT5jhgQoCcF8GqNKTxL_eTvlejPhE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-28_03,2024-05-27_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 mlxlogscore=999
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 phishscore=0
 spamscore=0 adultscore=0 bulkscore=0 clxscore=1015 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405280046
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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



On 5/26/24 17:56, Nicholas Piggin wrote:
> The timebase state machine is per per-core state and can be driven
> by any thread in the core. It is currently implemented as a hack
> where the state is in a CPU structure and only thread 0's state is
> accessed by the chiptod, which limits programming the timebase
> side of the state machine to thread 0 of a core.
> 
> Move the state out into PnvCore and share it among all threads.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   include/hw/ppc/pnv_core.h    | 17 ++++++++++++
>   target/ppc/cpu.h             | 20 --------------
>   hw/ppc/pnv_chiptod.c         |  6 ++--
>   target/ppc/timebase_helper.c | 53 ++++++++++++++++++++----------------
>   4 files changed, 49 insertions(+), 47 deletions(-)
> 
> diff --git a/include/hw/ppc/pnv_core.h b/include/hw/ppc/pnv_core.h
> index 30c1e5b1a3..f434c71547 100644
> --- a/include/hw/ppc/pnv_core.h
> +++ b/include/hw/ppc/pnv_core.h
> @@ -25,6 +25,20 @@
>   #include "hw/ppc/pnv.h"
>   #include "qom/object.h"
>   
> +/* ChipTOD and TimeBase State Machine */
> +struct pnv_tod_tbst {
> +    int tb_ready_for_tod; /* core TB ready to receive TOD from chiptod */
> +    int tod_sent_to_tb;   /* chiptod sent TOD to the core TB */
> +
> +    /*
> +     * "Timers" for async TBST events are simulated by mfTFAC because TFAC
> +     * is polled for such events. These are just used to ensure firmware
> +     * performs the polling at least a few times.
> +     */
> +    int tb_state_timer;
> +    int tb_sync_pulse_timer;
> +};
> +
>   #define TYPE_PNV_CORE "powernv-cpu-core"
>   OBJECT_DECLARE_TYPE(PnvCore, PnvCoreClass,
>                       PNV_CORE)
> @@ -38,6 +52,9 @@ struct PnvCore {
>       uint32_t pir;
>       uint32_t hwid;
>       uint64_t hrmor;
> +
> +    struct pnv_tod_tbst pnv_tod_tbst;
> +

Now that it is part of struct PnvCore itself, we can drop pnv_ prefix
and just call the member variable as tod_tbst ?

>       PnvChip *chip;
>   
>       MemoryRegion xscom_regs;
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index 2015e603d4..1e86658da6 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -1196,21 +1196,6 @@ DEXCR_ASPECT(SRAPD, 4)
>   DEXCR_ASPECT(NPHIE, 5)
>   DEXCR_ASPECT(PHIE, 6)
>   
> -/*****************************************************************************/
> -/* PowerNV ChipTOD and TimeBase State Machine */
> -struct pnv_tod_tbst {
> -    int tb_ready_for_tod; /* core TB ready to receive TOD from chiptod */
> -    int tod_sent_to_tb;   /* chiptod sent TOD to the core TB */
> -
> -    /*
> -     * "Timers" for async TBST events are simulated by mfTFAC because TFAC
> -     * is polled for such events. These are just used to ensure firmware
> -     * performs the polling at least a few times.
> -     */
> -    int tb_state_timer;
> -    int tb_sync_pulse_timer;
> -};
> -
>   /*****************************************************************************/
>   /* The whole PowerPC CPU context */
>   
> @@ -1292,11 +1277,6 @@ struct CPUArchState {
>   #define TLB_NEED_LOCAL_FLUSH   0x1
>   #define TLB_NEED_GLOBAL_FLUSH  0x2
>   
> -#if defined(TARGET_PPC64)
> -    /* PowerNV chiptod / timebase facility state. */
> -    /* Would be nice to put these into PnvCore */
> -    struct pnv_tod_tbst pnv_tod_tbst;
> -#endif
>   #endif
>   
>       /* Other registers */
> diff --git a/hw/ppc/pnv_chiptod.c b/hw/ppc/pnv_chiptod.c
> index 3831a72101..3eaddd66f0 100644
> --- a/hw/ppc/pnv_chiptod.c
> +++ b/hw/ppc/pnv_chiptod.c
> @@ -365,7 +365,7 @@ static void pnv_chiptod_xscom_write(void *opaque, hwaddr addr,
>                             " TOD_MOVE_TOD_TO_TB_REG with no slave target\n");
>           } else {
>               PowerPCCPU *cpu = chiptod->slave_pc_target->threads[0];
> -            CPUPPCState *env = &cpu->env;
> +            PnvCore *pc = pnv_cpu_state(cpu)->core;
>   
>               /*
>                * Moving TOD to TB will set the TB of all threads in a
> @@ -377,8 +377,8 @@ static void pnv_chiptod_xscom_write(void *opaque, hwaddr addr,
>                * thread 0.
>                */
>   
> -            if (env->pnv_tod_tbst.tb_ready_for_tod) {
> -                env->pnv_tod_tbst.tod_sent_to_tb = 1;
> +            if (pc->pnv_tod_tbst.tb_ready_for_tod) {
> +                pc->pnv_tod_tbst.tod_sent_to_tb = 1;
>               } else {
>                   qemu_log_mask(LOG_GUEST_ERROR, "pnv_chiptod: xscom write reg"
>                                 " TOD_MOVE_TOD_TO_TB_REG with TB not ready to"
> diff --git a/target/ppc/timebase_helper.c b/target/ppc/timebase_helper.c
> index 39d397416e..788c498d63 100644
> --- a/target/ppc/timebase_helper.c
> +++ b/target/ppc/timebase_helper.c
> @@ -19,6 +19,7 @@
>   #include "qemu/osdep.h"
>   #include "cpu.h"
>   #include "hw/ppc/ppc.h"
> +#include "hw/ppc/pnv_core.h"
>   #include "exec/helper-proto.h"
>   #include "exec/exec-all.h"
>   #include "qemu/log.h"
> @@ -298,8 +299,17 @@ static void write_tfmr(CPUPPCState *env, target_ulong val)
>       }
>   }
>   
> +static struct pnv_tod_tbst *cpu_get_tbst(PowerPCCPU *cpu)
> +{
> +    PnvCore *pc = pnv_cpu_state(cpu)->core;
> +
> +    return &pc->pnv_tod_tbst;
> +}
> +
>   static void tb_state_machine_step(CPUPPCState *env)
>   {
> +    PowerPCCPU *cpu = env_archcpu(env);
> +    struct pnv_tod_tbst *pnv_tod_tbst = cpu_get_tbst(cpu);

Since cpu is not used anywhere later, we could just do 
cpu_get_tbst(env_archcpu(env)) ?

>       uint64_t tfmr = env->spr[SPR_TFMR];
>       unsigned int tbst = tfmr_get_tb_state(tfmr);
>   
> @@ -307,15 +317,15 @@ static void tb_state_machine_step(CPUPPCState *env)
>           return;
>       }
>   
> -    if (env->pnv_tod_tbst.tb_sync_pulse_timer) {
> -        env->pnv_tod_tbst.tb_sync_pulse_timer--;
> +    if (pnv_tod_tbst->tb_sync_pulse_timer) {
> +        pnv_tod_tbst->tb_sync_pulse_timer--;
>       } else {
>           tfmr |= TFMR_TB_SYNC_OCCURED;
>           write_tfmr(env, tfmr);
>       }
>   
> -    if (env->pnv_tod_tbst.tb_state_timer) {
> -        env->pnv_tod_tbst.tb_state_timer--;
> +    if (pnv_tod_tbst->tb_state_timer) {
> +        pnv_tod_tbst->tb_state_timer--;
>           return;
>       }
>   
> @@ -332,20 +342,20 @@ static void tb_state_machine_step(CPUPPCState *env)
>       } else if (tfmr & TFMR_MOVE_CHIP_TOD_TO_TB) {
>           if (tbst == TBST_SYNC_WAIT) {
>               tfmr = tfmr_new_tb_state(tfmr, TBST_GET_TOD);
> -            env->pnv_tod_tbst.tb_state_timer = 3;
> +            pnv_tod_tbst->tb_state_timer = 3;
>           } else if (tbst == TBST_GET_TOD) {
> -            if (env->pnv_tod_tbst.tod_sent_to_tb) {
> +            if (pnv_tod_tbst->tod_sent_to_tb) {
>                   tfmr = tfmr_new_tb_state(tfmr, TBST_TB_RUNNING);
>                   tfmr &= ~TFMR_MOVE_CHIP_TOD_TO_TB;
> -                env->pnv_tod_tbst.tb_ready_for_tod = 0;
> -                env->pnv_tod_tbst.tod_sent_to_tb = 0;
> +                pnv_tod_tbst->tb_ready_for_tod = 0;
> +                pnv_tod_tbst->tod_sent_to_tb = 0;
>               }
>           } else {
>               qemu_log_mask(LOG_GUEST_ERROR, "TFMR error: MOVE_CHIP_TOD_TO_TB "
>                             "state machine in invalid state 0x%x\n", tbst);
>               tfmr = tfmr_new_tb_state(tfmr, TBST_TB_ERROR);
>               tfmr |= TFMR_FIRMWARE_CONTROL_ERROR;
> -            env->pnv_tod_tbst.tb_ready_for_tod = 0;
> +            pnv_tod_tbst->tb_ready_for_tod = 0;
>           }
>       }
>   
> @@ -361,6 +371,8 @@ target_ulong helper_load_tfmr(CPUPPCState *env)
>   
>   void helper_store_tfmr(CPUPPCState *env, target_ulong val)
>   {
> +    PowerPCCPU *cpu = env_archcpu(env);
> +    struct pnv_tod_tbst *pnv_tod_tbst = cpu_get_tbst(cpu);

... similarly here as well.

With suggested minor improvements,
Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>

>       uint64_t tfmr = env->spr[SPR_TFMR];
>       uint64_t clear_on_write;
>       unsigned int tbst = tfmr_get_tb_state(tfmr);
> @@ -384,14 +396,7 @@ void helper_store_tfmr(CPUPPCState *env, target_ulong val)
>        * after the second mfspr.
>        */
>       tfmr &= ~TFMR_TB_SYNC_OCCURED;
> -    env->pnv_tod_tbst.tb_sync_pulse_timer = 1;
> -
> -    if (ppc_cpu_tir(env_archcpu(env)) != 0 &&
> -        (val & (TFMR_LOAD_TOD_MOD | TFMR_MOVE_CHIP_TOD_TO_TB))) {
> -        qemu_log_mask(LOG_UNIMP, "TFMR timebase state machine can only be "
> -                                 "driven by thread 0\n");
> -        goto out;
> -    }
> +    pnv_tod_tbst->tb_sync_pulse_timer = 1;
>   
>       if (((tfmr | val) & (TFMR_LOAD_TOD_MOD | TFMR_MOVE_CHIP_TOD_TO_TB)) ==
>                           (TFMR_LOAD_TOD_MOD | TFMR_MOVE_CHIP_TOD_TO_TB)) {
> @@ -399,7 +404,7 @@ void helper_store_tfmr(CPUPPCState *env, target_ulong val)
>                                          "MOVE_CHIP_TOD_TO_TB both set\n");
>           tfmr = tfmr_new_tb_state(tfmr, TBST_TB_ERROR);
>           tfmr |= TFMR_FIRMWARE_CONTROL_ERROR;
> -        env->pnv_tod_tbst.tb_ready_for_tod = 0;
> +        pnv_tod_tbst->tb_ready_for_tod = 0;
>           goto out;
>       }
>   
> @@ -413,8 +418,8 @@ void helper_store_tfmr(CPUPPCState *env, target_ulong val)
>           tfmr &= ~TFMR_LOAD_TOD_MOD;
>           tfmr &= ~TFMR_MOVE_CHIP_TOD_TO_TB;
>           tfmr &= ~TFMR_FIRMWARE_CONTROL_ERROR; /* XXX: should this be cleared? */
> -        env->pnv_tod_tbst.tb_ready_for_tod = 0;
> -        env->pnv_tod_tbst.tod_sent_to_tb = 0;
> +        pnv_tod_tbst->tb_ready_for_tod = 0;
> +        pnv_tod_tbst->tod_sent_to_tb = 0;
>           goto out;
>       }
>   
> @@ -427,19 +432,19 @@ void helper_store_tfmr(CPUPPCState *env, target_ulong val)
>   
>       if (tfmr & TFMR_LOAD_TOD_MOD) {
>           /* Wait for an arbitrary 3 mfspr until the next state transition. */
> -        env->pnv_tod_tbst.tb_state_timer = 3;
> +        pnv_tod_tbst->tb_state_timer = 3;
>       } else if (tfmr & TFMR_MOVE_CHIP_TOD_TO_TB) {
>           if (tbst == TBST_NOT_SET) {
>               tfmr = tfmr_new_tb_state(tfmr, TBST_SYNC_WAIT);
> -            env->pnv_tod_tbst.tb_ready_for_tod = 1;
> -            env->pnv_tod_tbst.tb_state_timer = 3; /* arbitrary */
> +            pnv_tod_tbst->tb_ready_for_tod = 1;
> +            pnv_tod_tbst->tb_state_timer = 3; /* arbitrary */
>           } else {
>               qemu_log_mask(LOG_GUEST_ERROR, "TFMR error: MOVE_CHIP_TOD_TO_TB "
>                                              "not in TB not set state 0x%x\n",
>                                              tbst);
>               tfmr = tfmr_new_tb_state(tfmr, TBST_TB_ERROR);
>               tfmr |= TFMR_FIRMWARE_CONTROL_ERROR;
> -            env->pnv_tod_tbst.tb_ready_for_tod = 0;
> +            pnv_tod_tbst->tb_ready_for_tod = 0;
>           }
>       }
>   

