Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EC97D26D97
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 09:45:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfETi-0000Qq-MO; Mon, 12 Jan 2026 04:44:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1vfETK-0000Fm-Af
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 04:44:28 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1vfET4-00023Q-LA
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 04:44:12 -0500
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60BLROTG027978;
 Mon, 12 Jan 2026 09:44:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=lo74E7
 +MyyFy8eb/8t+gLb+mLrbut3hJ5kSBuxY4dhI=; b=LRrlDHsEeBL14YetggrMLP
 uDYvPbmhKLB5Jhkt15Lq5NxIv4+fqCkeTJ19/VQ7YR04zzrlqS083KNmGxdibt5t
 onAWiY1F8q+3D9Xj9DeyunIoX2tGrZekRo4OCT0iyz0ExY91N6/m3jilb60o+j25
 HHCLgj3dX96laEcwHNvu10REiBrPFlMws5BbttaoW9d0fnL/LKCTe93drzAfKTGV
 C0r4liC+aZJL6r+ffRTSpSoWfR6Oy6cZeIBzG2GV6uOeYp0XhgAbSJ6aetnlOJDi
 uqF/1wqXqSfGrjax2vewuaK1um9ubK/MA+TalYYlPDnn0zxxGawJD4FPGPIihbNg
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bkc6gxcmc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 12 Jan 2026 09:44:07 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60C9JeDW011478;
 Mon, 12 Jan 2026 09:44:07 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bkc6gxcma-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 12 Jan 2026 09:44:07 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60C9M9ic002505;
 Mon, 12 Jan 2026 09:44:06 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4bm13sdc75-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 12 Jan 2026 09:44:06 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 60C9i5XW30868040
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 Jan 2026 09:44:06 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AB0485805F;
 Mon, 12 Jan 2026 09:44:05 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 17F5258059;
 Mon, 12 Jan 2026 09:44:03 +0000 (GMT)
Received: from [9.124.220.243] (unknown [9.124.220.243])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
 Mon, 12 Jan 2026 09:44:02 +0000 (GMT)
Message-ID: <24ba9d4e-f91f-4353-b00d-1198d0be559d@linux.ibm.com>
Date: Mon, 12 Jan 2026 15:13:59 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] target/ppc: Fix env->quiesced migration
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: thuth@redhat.com, peterx@redhat.com, Fabian Vogt <fvogt@suse.de>,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
References: <20260109123519.28703-1-farosas@suse.de>
 <20260109123519.28703-2-farosas@suse.de>
Content-Language: en-US
From: Chinmay Rath <rathc@linux.ibm.com>
In-Reply-To: <20260109123519.28703-2-farosas@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 1RtiUzEQh_1kmrf8GewSb0t8pdFDPI4a
X-Proofpoint-ORIG-GUID: xmbVws3260XE9s3AYk4kKJ0nTuJ6lRxq
X-Authority-Analysis: v=2.4 cv=TaibdBQh c=1 sm=1 tr=0 ts=6964c267 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=p0WdMEafAAAA:8 a=VnNF1IyMAAAA:8 a=23kfawwW_HBnvp2I3_8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEyMDA3MiBTYWx0ZWRfX34kr88uLo6bh
 H3HLerp3dq1svyylKvkIO6C0enIiT7Ivu+PR0Ce/OItL0r6/8bLNPJ/9AuYgULMYaUxQF+GFh8l
 qwROOeLbFHc9KYNOkej4du7b+zYKTc9ac38kcAmE9v0Z2nP6Vr7fzFv1Zm8eEKBVxMUjYUjt1EY
 6v1N+/HdUiDuTapEgsu0zXWDU4GHKlGvcNCMCPz65AOltVfUqGD9VIy47AVSiBPqXOvdfzE5Yz9
 SfepI+ZQHfeeiUHwLknJRFuovDOg57Z/K+R7+PwSaXnZRCG/okdQ0A9xIuILdOOK2x3NEDFiLKR
 Hgo3W2CCvCCY6XsvTEeEpwspu7YtJ2wsOAvIddXUyhoBkieNiba1CWkQWrXBYqdzQSNQEnsyc5p
 eM4gDU8b2l0BsnLPEhYDxvoZ65IAco1Qkt7IbChf1puCcvLyd5VGS/RVpjMmWZd3YAE7Cif+VDC
 qVqUo6Zt5FeTe2Q/IAA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-12_02,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 impostorscore=0 bulkscore=0 clxscore=1011
 suspectscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2512120000
 definitions=main-2601120072
Received-SPF: pass client-ip=148.163.158.5; envelope-from=rathc@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


On 1/9/26 18:05, Fabiano Rosas wrote:
> The commit referenced (from QEMU 10.0) has changed the way the pseries
> machine marks a cpu as quiesced. Previously, the cpu->halted value
> from QEMU common cpu code was (incorrectly) used. With the fix, the
> env->quiesced variable starts being used, which improves on the
> original situation, but also causes a side effect after migration:
>
> The env->quiesced is set at reset and never migrated, which causes the
> destination QEMU to stop delivering interrupts and hang the machine.
>
> To fix the issue from this point on, start migrating the env->quiesced
> value.
>
> For QEMU versions < 10.0, sending the new element on the stream would
> cause migration to be aborted, so add the appropriate compatibility
> property to omit the new subsection.
>
> Independently of this patch, all migrations from QEMU versions < 10.0
> would result in a hang since the older QEMU never migrates
> env->quiesced. This is bad because it leaves machines already running
> on the old QEMU without a migration path into newer versions.
>
> As a workaround, use a few heuristics to infer the new value of
> env->quiesced based on cpu->halted, LPCR and PSSCR bits that are
> usually set/cleared along with quiesced.
>
> Note that this was tested with -cpu power9 and -machine ic-mode=xive
> due to another bug affecting migration of XICS guests. Tested both
> forward and backward migration and savevm/loadvm from 9.2 and 10.0.
>
> Also tested loadvm of a savevm image that contains a mix of cpus both
> halted and not halted.
>
> Reported-by: Fabian Vogt <fvogt@suse.de>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3079
> Fixes: fb802acdc8b ("ppc/spapr: Fix RTAS stopped state")
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
Acked-by: Chinmay Rath <rathc@linux.ibm.com>
> ---
>   hw/ppc/spapr.c        |  6 +++++
>   target/ppc/cpu.h      |  1 +
>   target/ppc/cpu_init.c |  7 +++++
>   target/ppc/machine.c  | 62 +++++++++++++++++++++++++++++++++++++++++++
>   4 files changed, 76 insertions(+)
>
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 3d87450be5..5e8b7ab1aa 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -4788,8 +4788,14 @@ DEFINE_SPAPR_MACHINE(10, 1);
>    */
>   static void spapr_machine_10_0_class_options(MachineClass *mc)
>   {
> +    static GlobalProperty spapr_compat_10_0[] = {
> +        { TYPE_POWERPC_CPU, "rtas-stopped-state", "false" },
> +    };
> +
>       spapr_machine_10_1_class_options(mc);
>       compat_props_add(mc->compat_props, hw_compat_10_0, hw_compat_10_0_len);
> +    compat_props_add(mc->compat_props, spapr_compat_10_0,
> +                     G_N_ELEMENTS(spapr_compat_10_0));
>   }
>   
>   DEFINE_SPAPR_MACHINE(10, 0);
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index dbebae89dc..49445eb4ca 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -1529,6 +1529,7 @@ struct ArchCPU {
>       void *machine_data;
>       int32_t node_id; /* NUMA node this CPU belongs to */
>       PPCHash64Options *hash64_opts;
> +    bool rtas_stopped_state;
>   
>       /* Those resources are used only during code translation */
>       /* opcode handlers */
> diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
> index 929254827d..58816c51a7 100644
> --- a/target/ppc/cpu_init.c
> +++ b/target/ppc/cpu_init.c
> @@ -55,6 +55,11 @@
>   /* #define PPC_DEBUG_SPR */
>   /* #define USE_APPLE_GDB */
>   
> +static const Property powerpc_cpu_properties[] = {
> +    DEFINE_PROP_BOOL("rtas-stopped-state", PowerPCCPU,
> +                      rtas_stopped_state, true),
> +};
> +
>   static inline void vscr_init(CPUPPCState *env, uint32_t val)
>   {
>       /* Altivec always uses round-to-nearest */
> @@ -7529,6 +7534,8 @@ static void ppc_cpu_class_init(ObjectClass *oc, const void *data)
>                                         &pcc->parent_unrealize);
>       pcc->pvr_match = ppc_pvr_match_default;
>   
> +    device_class_set_props(dc, powerpc_cpu_properties);
> +
>       resettable_class_set_parent_phases(rc, NULL, ppc_cpu_reset_hold, NULL,
>                                          &pcc->parent_phases);
>   
> diff --git a/target/ppc/machine.c b/target/ppc/machine.c
> index d72e5ecb94..49cfdc6d67 100644
> --- a/target/ppc/machine.c
> +++ b/target/ppc/machine.c
> @@ -257,6 +257,45 @@ static int cpu_post_load(void *opaque, int version_id)
>           ppc_store_sdr1(env, env->spr[SPR_SDR1]);
>       }
>   
> +    if (!cpu->rtas_stopped_state) {
> +        /*
> +         * The source QEMU doesn't have fb802acdc8 and still uses halt +
> +         * PM bits in LPCR to implement RTAS stopped state. The new (this)
> +         * QEMU will have put the secondary vcpus in stopped state,
> +         * waiting for the start-cpu RTAS call. That call will never come
> +         * if the source cpus were already running. Try to infer the cpus
> +         * state and set env->quiesced accordingly.
> +         *
> +         * env->quiesced = true  ==> the cpu is waiting to start
> +         * env->quiesced = false ==> the cpu is running (unless halted)
> +         */
> +
> +        /*
> +         * Halted _could_ mean quiesced, but it could also be cede,
> +         * confer_self, power management, etc.
> +         */
> +        if (CPU(cpu)->halted) {
> +            PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
> +            /*
> +             * Both the PSSCR_EC bit and LPCR PM bits set at cpu reset
> +             * and rtas_stop and cleared at rtas_start, it's a good
> +             * heuristic.
> +             */
> +            if ((env->spr[SPR_PSSCR] & PSSCR_EC) &&
> +                (env->spr[SPR_LPCR] & pcc->lpcr_pm)) {
> +                env->quiesced = true;
> +            } else {
> +                env->quiesced = false;
> +            }
> +        } else {
> +            /*
> +             * Old QEMU sets halted during rtas_stop_self. Not halted,
> +             * therefore definitely not quiesced.
> +             */
> +            env->quiesced = false;
> +        }
> +    }
> +
>       post_load_update_msr(env);
>   
>       if (tcg_enabled()) {
> @@ -649,6 +688,28 @@ static const VMStateDescription vmstate_reservation = {
>       }
>   };
>   
> +static bool rtas_stopped_needed(void *opaque)
> +{
> +    PowerPCCPU *cpu = opaque;
> +
> +    return cpu->rtas_stopped_state;
> +}
> +
> +static const VMStateDescription vmstate_rtas_stopped = {
> +    .name = "cpu/rtas_stopped",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .needed = rtas_stopped_needed,
> +    .fields = (const VMStateField[]) {
> +        /*
> +         * "RTAS stopped" state, independent of halted state. For QEMU
> +         * < 10.0, this is taken from cpu->halted at cpu_post_load()
> +         */
> +        VMSTATE_BOOL(env.quiesced, PowerPCCPU),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
>   #ifdef TARGET_PPC64
>   static bool bhrb_needed(void *opaque)
>   {
> @@ -715,6 +776,7 @@ const VMStateDescription vmstate_ppc_cpu = {
>           &vmstate_tlbmas,
>           &vmstate_compat,
>           &vmstate_reservation,
> +        &vmstate_rtas_stopped,
>           NULL
>       }
>   };

