Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AFBBC25B79
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 08:33:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBsFx-0001Zo-Qx; Tue, 28 May 2024 04:32:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1sBsFu-0001Yb-Jt; Tue, 28 May 2024 04:32:26 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1sBsFs-0003zS-1U; Tue, 28 May 2024 04:32:25 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 44S7fEhN011279; Tue, 28 May 2024 08:32:14 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1; _a=3Drsa-sha256; _c=3Drelaxed/relaxed;
 _d=3Dibm.com; _h=3Dcc?=
 =?UTF-8?Q?:content-transfer-encoding:content-type:date:from:in-reply-to:m?=
 =?UTF-8?Q?essage-id:mime-version:references:subject:to;_s=3Dpp1;_bh=3Dnrc?=
 =?UTF-8?Q?9ZqCIFLu5/f3df0y30KNyr9EHTArTxt0QLBVXEK8=3D;_b=3DSXqSEx5Uoj/L5L?=
 =?UTF-8?Q?r7oVuO/VT0iYEmGIh0ShI2RN01XInf9DK1tSPQVgyAGf9uyp/QLBZb_oDdr4It9?=
 =?UTF-8?Q?3L4xmEDnN67HMycef0nQ/cQbWs4lKlevlz++6LUvbf6EPhcZ7I6gAYUtoN8x_ia?=
 =?UTF-8?Q?EHnLtA2FE3mP7h0ZMoMhbFyD45HatJISv9RIVWYCkNCiwW59hszl8+UeznSaneH?=
 =?UTF-8?Q?nL5_kneu3ZRphF1pX/2ekJ+Hz3HA31kfZbxevuiTQBwcgd8RiiV7JN4DTYPdNLC?=
 =?UTF-8?Q?W9niCrSPq_8IGUpToT3At5vqN7EY8grPLZ/8twa5J8qgshID77aQ+fVgIbRMatU?=
 =?UTF-8?Q?bu/86Xf53siOVHv_XQ=3D=3D_?=
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yd9048fkp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 May 2024 08:32:14 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44S8WEw1023262;
 Tue, 28 May 2024 08:32:14 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yd9048fkm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 May 2024 08:32:13 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 44S7EqVZ027089; Tue, 28 May 2024 08:32:13 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ybvhknevh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 May 2024 08:32:13 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 44S8WAdM50528920
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 28 May 2024 08:32:12 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7E1AD5805D;
 Tue, 28 May 2024 08:32:10 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B647358043;
 Tue, 28 May 2024 08:32:07 +0000 (GMT)
Received: from [9.109.242.165] (unknown [9.109.242.165])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 28 May 2024 08:32:07 +0000 (GMT)
Message-ID: <39e4ac93-256b-424b-8ecb-7ed87afeb048@linux.ibm.com>
Date: Tue, 28 May 2024 14:02:06 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 05/10] ppc/pnv: Extend chip_pir class method to TIR as
 well
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: Caleb Schlossin <calebs@linux.vnet.ibm.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-devel@nongnu.org
References: <20240526122612.473476-1-npiggin@gmail.com>
 <20240526122612.473476-6-npiggin@gmail.com>
Content-Language: en-US
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <20240526122612.473476-6-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: vXaUD9J4OsmMETf3sMJTZmEPpWGD3I_l
X-Proofpoint-ORIG-GUID: cAjgtRZ81cmp0gBAjjo8W1BG7JQJSzZ9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-28_05,2024-05-27_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 mlxlogscore=833 impostorscore=0 phishscore=0 spamscore=0 clxscore=1015
 bulkscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405280062
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
> The chip_pir chip class method allows the platform to set the PIR
> processor identification register. Extend this to a more general
> ID function which also allows the TIR to be set. This is in
> preparation for "big core", which is a more complicated topology
> of cores and threads.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   include/hw/ppc/pnv_chip.h |  3 +-
>   hw/ppc/pnv.c              | 61 ++++++++++++++++++++++++---------------
>   hw/ppc/pnv_core.c         | 10 ++++---
>   3 files changed, 45 insertions(+), 29 deletions(-)
> 
> diff --git a/include/hw/ppc/pnv_chip.h b/include/hw/ppc/pnv_chip.h
> index 8589f3291e..679723926a 100644
> --- a/include/hw/ppc/pnv_chip.h
> +++ b/include/hw/ppc/pnv_chip.h
> @@ -147,7 +147,8 @@ struct PnvChipClass {
>   
>       DeviceRealize parent_realize;
>   
> -    uint32_t (*chip_pir)(PnvChip *chip, uint32_t core_id, uint32_t thread_id);
> +    void (*processor_id)(PnvChip *chip, uint32_t core_id, uint32_t thread_id,
> +                         uint32_t *pir, uint32_t *tir);

Should it be named get_chip_core_thread_regs() ?

>       void (*intc_create)(PnvChip *chip, PowerPCCPU *cpu, Error **errp);
>       void (*intc_reset)(PnvChip *chip, PowerPCCPU *cpu);
>       void (*intc_destroy)(PnvChip *chip, PowerPCCPU *cpu);
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index a706de2e36..7d062ec16c 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -144,7 +144,7 @@ static int pnv_dt_core(PnvChip *chip, PnvCore *pc, void *fdt)
>       PnvChipClass *pnv_cc = PNV_CHIP_GET_CLASS(chip);
>       g_autofree uint32_t *servers_prop = g_new(uint32_t, smt_threads);
>       int i;
> -    uint32_t pir;
> +    uint32_t pir, tir;
>       uint32_t segs[] = {cpu_to_be32(28), cpu_to_be32(40),
>                          0xffffffff, 0xffffffff};
>       uint32_t tbfreq = PNV_TIMEBASE_FREQ;
> @@ -155,7 +155,7 @@ static int pnv_dt_core(PnvChip *chip, PnvCore *pc, void *fdt)
>       char *nodename;
>       int cpus_offset = get_cpus_node(fdt);
>   
> -    pir = pnv_cc->chip_pir(chip, pc->hwid, 0);
> +    pnv_cc->processor_id(chip, pc->hwid, 0, &pir, &tir);

As a generic helper API and potentially expandable, it should allow 
passing NULL for registers whose values are not really sought to avoid 
having to create un-necessary local variables by the caller.

regards,
Harsh
>   
>       nodename = g_strdup_printf("%s@%x", dc->fw_name, pir);
>       offset = fdt_add_subnode(fdt, cpus_offset, nodename);
> @@ -237,7 +237,8 @@ static int pnv_dt_core(PnvChip *chip, PnvCore *pc, void *fdt)
>   
>       /* Build interrupt servers properties */
>       for (i = 0; i < smt_threads; i++) {
> -        servers_prop[i] = cpu_to_be32(pnv_cc->chip_pir(chip, pc->hwid, i));
> +        pnv_cc->processor_id(chip, pc->hwid, i, &pir, &tir);
> +        servers_prop[i] = cpu_to_be32(pir);
>       }
>       _FDT((fdt_setprop(fdt, offset, "ibm,ppc-interrupt-server#s",
>                          servers_prop, sizeof(*servers_prop) * smt_threads)));
> @@ -249,14 +250,17 @@ static void pnv_dt_icp(PnvChip *chip, void *fdt, uint32_t hwid,
>                          uint32_t nr_threads)
>   {
>       PnvChipClass *pcc = PNV_CHIP_GET_CLASS(chip);
> -    uint32_t pir = pcc->chip_pir(chip, hwid, 0);
> -    uint64_t addr = PNV_ICP_BASE(chip) | (pir << 12);
> +    uint32_t pir, tir;
> +    uint64_t addr;
>       char *name;
>       const char compat[] = "IBM,power8-icp\0IBM,ppc-xicp";
>       uint32_t irange[2], i, rsize;
>       uint64_t *reg;
>       int offset;
>   
> +    pcc->processor_id(chip, hwid, 0, &pir, &tir);
> +    addr = PNV_ICP_BASE(chip) | (pir << 12);
> +
>       irange[0] = cpu_to_be32(pir);
>       irange[1] = cpu_to_be32(nr_threads);
>   
> @@ -1104,10 +1108,12 @@ static void pnv_power10_init(MachineState *machine)
>    *   25:28  Core number
>    *   29:31  Thread ID
>    */
> -static uint32_t pnv_chip_pir_p8(PnvChip *chip, uint32_t core_id,
> -                                uint32_t thread_id)
> +static void pnv_processor_id_p8(PnvChip *chip,
> +                                uint32_t core_id, uint32_t thread_id,
> +                                uint32_t *pir, uint32_t *tir)
>   {
> -    return (chip->chip_id << 7) | (core_id << 3) | thread_id;
> +    *pir = (chip->chip_id << 7) | (core_id << 3) | thread_id;
> +    *tir = thread_id;
>   }
>   
>   static void pnv_chip_power8_intc_create(PnvChip *chip, PowerPCCPU *cpu,
> @@ -1159,15 +1165,17 @@ static void pnv_chip_power8_intc_print_info(PnvChip *chip, PowerPCCPU *cpu,
>    *
>    * We only care about the lower bits. uint32_t is fine for the moment.
>    */
> -static uint32_t pnv_chip_pir_p9(PnvChip *chip, uint32_t core_id,
> -                                uint32_t thread_id)
> +static void pnv_processor_id_p9(PnvChip *chip,
> +                                uint32_t core_id, uint32_t thread_id,
> +                                uint32_t *pir, uint32_t *tir)
>   {
>       if (chip->nr_threads == 8) {
> -        return (chip->chip_id << 8) | ((thread_id & 1) << 2) | (core_id << 3) |
> +        *pir = (chip->chip_id << 8) | ((thread_id & 1) << 2) | (core_id << 3) |
>                  (thread_id >> 1);
>       } else {
> -        return (chip->chip_id << 8) | (core_id << 2) | thread_id;
> +        *pir = (chip->chip_id << 8) | (core_id << 2) | thread_id;
>       }
> +    *tir = thread_id;
>   }
>   
>   /*
> @@ -1181,15 +1189,17 @@ static uint32_t pnv_chip_pir_p9(PnvChip *chip, uint32_t core_id,
>    *
>    * We only care about the lower bits. uint32_t is fine for the moment.
>    */
> -static uint32_t pnv_chip_pir_p10(PnvChip *chip, uint32_t core_id,
> -                                 uint32_t thread_id)
> +static void pnv_processor_id_p10(PnvChip *chip,
> +                                uint32_t core_id, uint32_t thread_id,
> +                                uint32_t *pir, uint32_t *tir)
>   {
>       if (chip->nr_threads == 8) {
> -        return (chip->chip_id << 8) | ((core_id / 4) << 4) |
> -               ((core_id % 2) << 3) | thread_id;
> +        *pir = (chip->chip_id << 8) | ((core_id / 4) << 4) |
> +                ((core_id % 2) << 3) | thread_id;
>       } else {
> -        return (chip->chip_id << 8) | (core_id << 2) | thread_id;
> +        *pir = (chip->chip_id << 8) | (core_id << 2) | thread_id;
>       }
> +    *tir = thread_id;
>   }
>   
>   static void pnv_chip_power9_intc_create(PnvChip *chip, PowerPCCPU *cpu,
> @@ -1368,8 +1378,11 @@ static void pnv_chip_icp_realize(Pnv8Chip *chip8, Error **errp)
>           int core_hwid = CPU_CORE(pnv_core)->core_id;
>   
>           for (j = 0; j < CPU_CORE(pnv_core)->nr_threads; j++) {
> -            uint32_t pir = pcc->chip_pir(chip, core_hwid, j);
> -            PnvICPState *icp = PNV_ICP(xics_icp_get(chip8->xics, pir));
> +            uint32_t pir, tir;
> +            PnvICPState *icp;
> +
> +            pcc->processor_id(chip, core_hwid, j, &pir, &tir);
> +            icp = PNV_ICP(xics_icp_get(chip8->xics, pir));
>   
>               memory_region_add_subregion(&chip8->icp_mmio, pir << 12,
>                                           &icp->mmio);
> @@ -1481,7 +1494,7 @@ static void pnv_chip_power8e_class_init(ObjectClass *klass, void *data)
>       k->chip_cfam_id = 0x221ef04980000000ull;  /* P8 Murano DD2.1 */
>       k->cores_mask = POWER8E_CORE_MASK;
>       k->num_phbs = 3;
> -    k->chip_pir = pnv_chip_pir_p8;
> +    k->processor_id = pnv_processor_id_p8;
>       k->intc_create = pnv_chip_power8_intc_create;
>       k->intc_reset = pnv_chip_power8_intc_reset;
>       k->intc_destroy = pnv_chip_power8_intc_destroy;
> @@ -1505,7 +1518,7 @@ static void pnv_chip_power8_class_init(ObjectClass *klass, void *data)
>       k->chip_cfam_id = 0x220ea04980000000ull; /* P8 Venice DD2.0 */
>       k->cores_mask = POWER8_CORE_MASK;
>       k->num_phbs = 3;
> -    k->chip_pir = pnv_chip_pir_p8;
> +    k->processor_id = pnv_processor_id_p8;
>       k->intc_create = pnv_chip_power8_intc_create;
>       k->intc_reset = pnv_chip_power8_intc_reset;
>       k->intc_destroy = pnv_chip_power8_intc_destroy;
> @@ -1529,7 +1542,7 @@ static void pnv_chip_power8nvl_class_init(ObjectClass *klass, void *data)
>       k->chip_cfam_id = 0x120d304980000000ull;  /* P8 Naples DD1.0 */
>       k->cores_mask = POWER8_CORE_MASK;
>       k->num_phbs = 4;
> -    k->chip_pir = pnv_chip_pir_p8;
> +    k->processor_id = pnv_processor_id_p8;
>       k->intc_create = pnv_chip_power8_intc_create;
>       k->intc_reset = pnv_chip_power8_intc_reset;
>       k->intc_destroy = pnv_chip_power8_intc_destroy;
> @@ -1802,7 +1815,7 @@ static void pnv_chip_power9_class_init(ObjectClass *klass, void *data)
>   
>       k->chip_cfam_id = 0x220d104900008000ull; /* P9 Nimbus DD2.0 */
>       k->cores_mask = POWER9_CORE_MASK;
> -    k->chip_pir = pnv_chip_pir_p9;
> +    k->processor_id = pnv_processor_id_p9;
>       k->intc_create = pnv_chip_power9_intc_create;
>       k->intc_reset = pnv_chip_power9_intc_reset;
>       k->intc_destroy = pnv_chip_power9_intc_destroy;
> @@ -2114,7 +2127,7 @@ static void pnv_chip_power10_class_init(ObjectClass *klass, void *data)
>   
>       k->chip_cfam_id = 0x120da04900008000ull; /* P10 DD1.0 (with NX) */
>       k->cores_mask = POWER10_CORE_MASK;
> -    k->chip_pir = pnv_chip_pir_p10;
> +    k->processor_id = pnv_processor_id_p10;
>       k->intc_create = pnv_chip_power10_intc_create;
>       k->intc_reset = pnv_chip_power10_intc_reset;
>       k->intc_destroy = pnv_chip_power10_intc_destroy;
> diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
> index 7b0ea7812b..9b5edd9e48 100644
> --- a/hw/ppc/pnv_core.c
> +++ b/hw/ppc/pnv_core.c
> @@ -228,8 +228,9 @@ static void pnv_core_cpu_realize(PnvCore *pc, PowerPCCPU *cpu, Error **errp,
>       PnvCPUState *pnv_cpu = pnv_cpu_state(cpu);
>       CPUPPCState *env = &cpu->env;
>       int core_hwid;
> -    ppc_spr_t *pir = &env->spr_cb[SPR_PIR];
> -    ppc_spr_t *tir = &env->spr_cb[SPR_TIR];
> +    ppc_spr_t *pir_spr = &env->spr_cb[SPR_PIR];
> +    ppc_spr_t *tir_spr = &env->spr_cb[SPR_TIR];
> +    uint32_t pir, tir;
>       Error *local_err = NULL;
>       PnvChipClass *pcc = PNV_CHIP_GET_CLASS(pc->chip);
>   
> @@ -247,8 +248,9 @@ static void pnv_core_cpu_realize(PnvCore *pc, PowerPCCPU *cpu, Error **errp,
>   
>       core_hwid = object_property_get_uint(OBJECT(pc), "hwid", &error_abort);
>   
> -    tir->default_value = thread_index;
> -    pir->default_value = pcc->chip_pir(pc->chip, core_hwid, thread_index);
> +    pcc->processor_id(pc->chip, core_hwid, thread_index, &pir, &tir);
> +    pir_spr->default_value = pir;
> +    tir_spr->default_value = tir;
>   
>       /* Set time-base frequency to 512 MHz */
>       cpu_ppc_tb_init(env, PNV_TIMEBASE_FREQ);

