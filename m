Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75718CCA471
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Oct 2025 15:47:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5nR0-0003SI-6v; Mon, 06 Oct 2025 11:47:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1v5nQc-0003DG-Fj; Mon, 06 Oct 2025 11:47:11 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1v5nQS-00005O-EC; Mon, 06 Oct 2025 11:47:08 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 596Fa49m018649;
 Mon, 6 Oct 2025 15:46:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=dTcH2Ijo7iVWDDc/QpDBD8b5gbOP9B
 wGznszLI7LiKE=; b=sNLLjdPc+C5IktXZSvk3f0+ddZtiPufxBNVyHFAVBvSesN
 jkbv6roZGNUega3gXwS8Nc55Yt6zrYoYK/HoEafsUCbuLb2Nty/zg4osMxe17d4F
 NT2Gr/6dzKBCqexRUiX0OXaW0J3QjfoWcfCwigePwnTBxFsMANu6XwXjwUmsRAre
 vLVOqxuCyvSiH18KyvuDG4CLem4OsAWeGhkhZ/cW2LJ9bGZt9+aJTEzu71iCDM8u
 knBMrb2fvq8BCLOW22tVHUezI8VO+5g2odNthXfj62ZzHGfr9Yhes77KlYaH16RH
 NrZfD6U81wcC/4DpyY4dQWMSOo2EyltePEkA/yYA==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49ju8ahsa9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 06 Oct 2025 15:46:55 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 596FhE7t009926;
 Mon, 6 Oct 2025 15:46:55 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49ju8ahsa3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 06 Oct 2025 15:46:55 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 596CK2HX019689;
 Mon, 6 Oct 2025 15:46:54 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 49kdws6yws-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 06 Oct 2025 15:46:54 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 596FkqaY26346038
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 6 Oct 2025 15:46:52 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 815B158043;
 Mon,  6 Oct 2025 15:46:52 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E82C658059;
 Mon,  6 Oct 2025 15:46:51 +0000 (GMT)
Received: from [9.10.80.187] (unknown [9.10.80.187])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  6 Oct 2025 15:46:51 +0000 (GMT)
Content-Type: multipart/alternative;
 boundary="------------H52FfIKnaaqLxZoR2GANZQOE"
Message-ID: <95b3bfd6-e1a4-4b19-a86b-cc666da6eb30@linux.ibm.com>
Date: Mon, 6 Oct 2025 10:46:51 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 4/8] ppc/pnv: Add XIVE2 controller to Power11
To: Aditya Gupta <adityag@linux.ibm.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Gautam Menghani <gautam@linux.ibm.com>, Miles Glenn <milesg@linux.ibm.com>,
 Ganesh Goudar <ganeshgr@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
References: <20250925173049.891406-1-adityag@linux.ibm.com>
 <20250925173049.891406-5-adityag@linux.ibm.com>
Content-Language: en-US
From: Mike Kowal <kowal@linux.ibm.com>
In-Reply-To: <20250925173049.891406-5-adityag@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: L625E1ngWhXgx0kW744MkE1LkZ_ePXfZ
X-Authority-Analysis: v=2.4 cv=BpiQAIX5 c=1 sm=1 tr=0 ts=68e3e470 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=x6icFKpwvdMA:10 a=r77TgQKjGQsHNAKrUKIA:9 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8
 a=p8j9cQVM6DJJbO-JqHcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=H1shgiIZPKTCiYXe3LcA:9 a=OdyiT02D3D_q1XT8:21 a=_W_S_7VecoQA:10
 a=lqcHg5cX4UMA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAyMiBTYWx0ZWRfXzCWNhnFnaRz4
 97MLFo7FZZb9uIW3cgRxtv1+ZshbUY76qMtSH/yGfoouP2ovLcowsijRmrD1Hor6knCzhS3K6os
 8U1BsH5dfKsYtJWYVyIixg62vnIUIep4ND4ouZ2y1coFKuYDpihOPHkqf0AjJQa/xXo5lctu4oM
 nZA4KQsBPFPmWrD0dCme4Y66WjMXLVXcs/NOy1cgxj5dgtxaq6pHYrOoHa16kNlRdU3qrptmxYi
 sBEVPVC46lpahtBhcwrKeKsAmhyG2Q+okHL9my/bqOYkLcU+yUZTUVNZo9GEAIn63r73gMAmr2r
 x7B+ApkmFKC+hXNCZbt6bi2/23LJ+ckUPfSApcVkF4AibX+VWHmCA9r+z3aoUAPvPFD2wkZj3+O
 YOqmIp9Xt92hgf6dRmfTAJ+8QWFwoQ==
X-Proofpoint-ORIG-GUID: w5ISR7_We3EnKMmZi-M7Vh6ZEniu8-Gm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-06_05,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 suspectscore=0 bulkscore=0 impostorscore=0 adultscore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2510040022
Received-SPF: pass client-ip=148.163.158.5; envelope-from=kowal@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

This is a multi-part message in MIME format.
--------------H52FfIKnaaqLxZoR2GANZQOE
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 9/25/2025 12:30 PM, Aditya Gupta wrote:
> Add a XIVE2 controller to Power11 chip and machine.
> The controller has the same logic as Power10.

Reviewed-by: Michael Kowal<kowal@linux.ibm.com>

>
> Reviewed-by: Cédric Le Goater<clg@redhat.com>
> Signed-off-by: Aditya Gupta<adityag@linux.ibm.com>
> ---
>   hw/ppc/pnv.c         | 121 ++++++++++++++++++++++++++++++++++++++++++-
>   include/hw/ppc/pnv.h |  18 +++++++
>   2 files changed, 138 insertions(+), 1 deletion(-)
>
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index a4fdf59207fa..8097d3c09a2f 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -976,6 +976,7 @@ static void pnv_chip_power11_pic_print_info(PnvChip *chip, GString *buf)
>   {
>       Pnv11Chip *chip11 = PNV11_CHIP(chip);
>   
> +    pnv_xive2_pic_print_info(&chip11->xive, buf);
>       pnv_psi_pic_print_info(&chip11->psi, buf);
>   }
>   
> @@ -1491,6 +1492,50 @@ static void *pnv_chip_power10_intc_get(PnvChip *chip)
>       return &PNV10_CHIP(chip)->xive;
>   }
>   
> +static void pnv_chip_power11_intc_create(PnvChip *chip, PowerPCCPU *cpu,
> +                                        Error **errp)
> +{
> +    Pnv11Chip *chip11 = PNV11_CHIP(chip);
> +    Error *local_err = NULL;
> +    Object *obj;
> +    PnvCPUState *pnv_cpu = pnv_cpu_state(cpu);
> +
> +    /*
> +     * The core creates its interrupt presenter but the XIVE2 interrupt
> +     * controller object is initialized afterwards. Hopefully, it's
> +     * only used at runtime.
> +     */
> +    obj = xive_tctx_create(OBJECT(cpu), XIVE_PRESENTER(&chip11->xive),
> +                           &local_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        return;
> +    }
> +
> +    pnv_cpu->intc = obj;
> +}
> +
> +static void pnv_chip_power11_intc_reset(PnvChip *chip, PowerPCCPU *cpu)
> +{
> +    PnvCPUState *pnv_cpu = pnv_cpu_state(cpu);
> +
> +    xive_tctx_reset(XIVE_TCTX(pnv_cpu->intc));
> +}
> +
> +static void pnv_chip_power11_intc_destroy(PnvChip *chip, PowerPCCPU *cpu)
> +{
> +    PnvCPUState *pnv_cpu = pnv_cpu_state(cpu);
> +
> +    xive_tctx_destroy(XIVE_TCTX(pnv_cpu->intc));
> +    pnv_cpu->intc = NULL;
> +}
> +
> +static void pnv_chip_power11_intc_print_info(PnvChip *chip, PowerPCCPU *cpu,
> +                                             GString *buf)
> +{
> +    xive_tctx_pic_print_info(XIVE_TCTX(pnv_cpu_state(cpu)->intc), buf);
> +}
> +
>   static void *pnv_chip_power11_intc_get(PnvChip *chip)
>   {
>       return &PNV11_CHIP(chip)->xive;
> @@ -2443,6 +2488,10 @@ static void pnv_chip_power11_instance_init(Object *obj)
>       object_initialize_child(obj, "occ",  &chip11->occ, TYPE_PNV10_OCC);
>       object_initialize_child(obj, "sbe",  &chip11->sbe, TYPE_PNV10_SBE);
>       object_initialize_child(obj, "homer", &chip11->homer, TYPE_PNV10_HOMER);
> +
> +    object_initialize_child(obj, "xive", &chip11->xive, TYPE_PNV_XIVE2);
> +    object_property_add_alias(obj, "xive-fabric", OBJECT(&chip11->xive),
> +                              "xive-fabric");
>       object_initialize_child(obj, "n1-chiplet", &chip11->n1_chiplet,
>                               TYPE_PNV_N1_CHIPLET);
>   
> @@ -2518,7 +2567,26 @@ static void pnv_chip_power11_realize(DeviceState *dev, Error **errp)
>           return;
>       }
>   
> -    /* WIP: XIVE added in future patch */
> +    /* XIVE2 interrupt controller */
> +    object_property_set_int(OBJECT(&chip11->xive), "ic-bar",
> +                            PNV11_XIVE2_IC_BASE(chip), &error_fatal);
> +    object_property_set_int(OBJECT(&chip11->xive), "esb-bar",
> +                            PNV11_XIVE2_ESB_BASE(chip), &error_fatal);
> +    object_property_set_int(OBJECT(&chip11->xive), "end-bar",
> +                            PNV11_XIVE2_END_BASE(chip), &error_fatal);
> +    object_property_set_int(OBJECT(&chip11->xive), "nvpg-bar",
> +                            PNV11_XIVE2_NVPG_BASE(chip), &error_fatal);
> +    object_property_set_int(OBJECT(&chip11->xive), "nvc-bar",
> +                            PNV11_XIVE2_NVC_BASE(chip), &error_fatal);
> +    object_property_set_int(OBJECT(&chip11->xive), "tm-bar",
> +                            PNV11_XIVE2_TM_BASE(chip), &error_fatal);
> +    object_property_set_link(OBJECT(&chip11->xive), "chip", OBJECT(chip),
> +                             &error_abort);
> +    if (!sysbus_realize(SYS_BUS_DEVICE(&chip11->xive), errp)) {
> +        return;
> +    }
> +    pnv_xscom_add_subregion(chip, PNV11_XSCOM_XIVE2_BASE,
> +                            &chip11->xive.xscom_regs);
>   
>       /* Processor Service Interface (PSI) Host Bridge */
>       object_property_set_int(OBJECT(&chip11->psi), "bar",
> @@ -2720,6 +2788,10 @@ static void pnv_chip_power11_class_init(ObjectClass *klass, const void *data)
>       k->chip_cfam_id = 0x220da04980000000ull; /* P11 DD2.0 (with NX) */
>       k->cores_mask = POWER11_CORE_MASK;
>       k->get_pir_tir = pnv_get_pir_tir_p10;
> +    k->intc_create = pnv_chip_power11_intc_create;
> +    k->intc_reset = pnv_chip_power11_intc_reset;
> +    k->intc_destroy = pnv_chip_power11_intc_destroy;
> +    k->intc_print_info = pnv_chip_power11_intc_print_info;
>       k->intc_get = pnv_chip_power11_intc_get;
>       k->isa_create = pnv_chip_power11_isa_create;
>       k->dt_populate = pnv_chip_power11_dt_populate;
> @@ -3073,6 +3145,45 @@ static int pnv10_xive_broadcast(XiveFabric *xfb,
>       return 0;
>   }
>   
> +static bool pnv11_xive_match_nvt(XiveFabric *xfb, uint8_t format,
> +                                 uint8_t nvt_blk, uint32_t nvt_idx,
> +                                 bool crowd, bool cam_ignore, uint8_t priority,
> +                                 uint32_t logic_serv,
> +                                 XiveTCTXMatch *match)
> +{
> +    PnvMachineState *pnv = PNV_MACHINE(xfb);
> +    int i;
> +
> +    for (i = 0; i < pnv->num_chips; i++) {
> +        Pnv11Chip *chip11 = PNV11_CHIP(pnv->chips[i]);
> +        XivePresenter *xptr = XIVE_PRESENTER(&chip11->xive);
> +        XivePresenterClass *xpc = XIVE_PRESENTER_GET_CLASS(xptr);
> +
> +        xpc->match_nvt(xptr, format, nvt_blk, nvt_idx, crowd,
> +                       cam_ignore, priority, logic_serv, match);
> +    }
> +
> +    return !!match->count;
> +}
> +
> +static int pnv11_xive_broadcast(XiveFabric *xfb,
> +                                uint8_t nvt_blk, uint32_t nvt_idx,
> +                                bool crowd, bool cam_ignore,
> +                                uint8_t priority)
> +{
> +    PnvMachineState *pnv = PNV_MACHINE(xfb);
> +    int i;
> +
> +    for (i = 0; i < pnv->num_chips; i++) {
> +        Pnv11Chip *chip11 = PNV11_CHIP(pnv->chips[i]);
> +        XivePresenter *xptr = XIVE_PRESENTER(&chip11->xive);
> +        XivePresenterClass *xpc = XIVE_PRESENTER_GET_CLASS(xptr);
> +
> +        xpc->broadcast(xptr, nvt_blk, nvt_idx, crowd, cam_ignore, priority);
> +    }
> +    return 0;
> +}
> +
>   static bool pnv_machine_get_big_core(Object *obj, Error **errp)
>   {
>       PnvMachineState *pnv = PNV_MACHINE(obj);
> @@ -3251,6 +3362,7 @@ static void pnv_machine_power11_class_init(ObjectClass *oc, const void *data)
>   {
>       MachineClass *mc = MACHINE_CLASS(oc);
>       PnvMachineClass *pmc = PNV_MACHINE_CLASS(oc);
> +    XiveFabricClass *xfc = XIVE_FABRIC_CLASS(oc);
>       static const char compat[] = "qemu,powernv11\0ibm,powernv";
>   
>       pmc->compat = compat;
> @@ -3260,6 +3372,9 @@ static void pnv_machine_power11_class_init(ObjectClass *oc, const void *data)
>       pmc->quirk_tb_big_core = true;
>       pmc->dt_power_mgt = pnv_dt_power_mgt;
>   
> +    xfc->match_nvt = pnv11_xive_match_nvt;
> +    xfc->broadcast = pnv11_xive_broadcast;
> +
>       mc->desc = "IBM PowerNV (Non-Virtualized) Power11";
>       mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("power11_v2.0");
>   
> @@ -3393,6 +3508,10 @@ static const TypeInfo types[] = {
>           .name          = MACHINE_TYPE_NAME("powernv11"),
>           .parent        = TYPE_PNV_MACHINE,
>           .class_init    = pnv_machine_power11_class_init,
> +        .interfaces = (InterfaceInfo[]) {
> +            { TYPE_XIVE_FABRIC },
> +            { },
> +        },
>       },
>       {
>           .name          = MACHINE_TYPE_NAME("powernv10-rainier"),
> diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
> index f0002627bcab..cbdddfc73cd4 100644
> --- a/include/hw/ppc/pnv.h
> +++ b/include/hw/ppc/pnv.h
> @@ -270,6 +270,24 @@ void pnv_bmc_set_pnor(IPMIBmc *bmc, PnvPnor *pnor);
>   #define PNV11_PSIHB_SIZE            PNV10_PSIHB_SIZE
>   #define PNV11_PSIHB_BASE(chip)      PNV10_PSIHB_BASE(chip)
>   
> +#define PNV11_XIVE2_IC_SIZE         PNV10_XIVE2_IC_SIZE
> +#define PNV11_XIVE2_IC_BASE(chip)   PNV10_XIVE2_IC_BASE(chip)
> +
> +#define PNV11_XIVE2_TM_SIZE         PNV10_XIVE2_TM_SIZE
> +#define PNV11_XIVE2_TM_BASE(chip)   PNV10_XIVE2_TM_BASE(chip)
> +
> +#define PNV11_XIVE2_NVC_SIZE        PNV10_XIVE2_NVC_SIZE
> +#define PNV11_XIVE2_NVC_BASE(chip)  PNV10_XIVE2_NVC_BASE(chip)
> +
> +#define PNV11_XIVE2_NVPG_SIZE       PNV10_XIVE2_NVPG_SIZE
> +#define PNV11_XIVE2_NVPG_BASE(chip) PNV10_XIVE2_NVPG_BASE(chip)
> +
> +#define PNV11_XIVE2_ESB_SIZE        PNV10_XIVE2_ESB_SIZE
> +#define PNV11_XIVE2_ESB_BASE(chip)  PNV10_XIVE2_ESB_BASE(chip)
> +
> +#define PNV11_XIVE2_END_SIZE        PNV10_XIVE2_END_SIZE
> +#define PNV11_XIVE2_END_BASE(chip)  PNV10_XIVE2_END_BASE(chip)
> +
>   #define PNV11_OCC_SENSOR_BASE(chip) PNV10_OCC_SENSOR_BASE(chip)
>   
>   #endif /* PPC_PNV_H */
--------------H52FfIKnaaqLxZoR2GANZQOE
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 9/25/2025 12:30 PM, Aditya Gupta
      wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:20250925173049.891406-5-adityag@linux.ibm.com">
      <pre wrap="" class="moz-quote-pre">Add a XIVE2 controller to Power11 chip and machine.
The controller has the same logic as Power10.</pre>
    </blockquote>
    <br>
    <pre>Reviewed-by: Michael Kowal <a class="moz-txt-link-rfc2396E" href="mailto:kowal@linux.ibm.com">&lt;kowal@linux.ibm.com&gt;</a></pre>
    <blockquote type="cite"
      cite="mid:20250925173049.891406-5-adityag@linux.ibm.com">
      <pre wrap="" class="moz-quote-pre">

Reviewed-by: Cédric Le Goater <a class="moz-txt-link-rfc2396E" href="mailto:clg@redhat.com">&lt;clg@redhat.com&gt;</a>
Signed-off-by: Aditya Gupta <a class="moz-txt-link-rfc2396E" href="mailto:adityag@linux.ibm.com">&lt;adityag@linux.ibm.com&gt;</a>
---
 hw/ppc/pnv.c         | 121 ++++++++++++++++++++++++++++++++++++++++++-
 include/hw/ppc/pnv.h |  18 +++++++
 2 files changed, 138 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index a4fdf59207fa..8097d3c09a2f 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -976,6 +976,7 @@ static void pnv_chip_power11_pic_print_info(PnvChip *chip, GString *buf)
 {
     Pnv11Chip *chip11 = PNV11_CHIP(chip);
 
+    pnv_xive2_pic_print_info(&amp;chip11-&gt;xive, buf);
     pnv_psi_pic_print_info(&amp;chip11-&gt;psi, buf);
 }
 
@@ -1491,6 +1492,50 @@ static void *pnv_chip_power10_intc_get(PnvChip *chip)
     return &amp;PNV10_CHIP(chip)-&gt;xive;
 }
 
+static void pnv_chip_power11_intc_create(PnvChip *chip, PowerPCCPU *cpu,
+                                        Error **errp)
+{
+    Pnv11Chip *chip11 = PNV11_CHIP(chip);
+    Error *local_err = NULL;
+    Object *obj;
+    PnvCPUState *pnv_cpu = pnv_cpu_state(cpu);
+
+    /*
+     * The core creates its interrupt presenter but the XIVE2 interrupt
+     * controller object is initialized afterwards. Hopefully, it's
+     * only used at runtime.
+     */
+    obj = xive_tctx_create(OBJECT(cpu), XIVE_PRESENTER(&amp;chip11-&gt;xive),
+                           &amp;local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
+    pnv_cpu-&gt;intc = obj;
+}
+
+static void pnv_chip_power11_intc_reset(PnvChip *chip, PowerPCCPU *cpu)
+{
+    PnvCPUState *pnv_cpu = pnv_cpu_state(cpu);
+
+    xive_tctx_reset(XIVE_TCTX(pnv_cpu-&gt;intc));
+}
+
+static void pnv_chip_power11_intc_destroy(PnvChip *chip, PowerPCCPU *cpu)
+{
+    PnvCPUState *pnv_cpu = pnv_cpu_state(cpu);
+
+    xive_tctx_destroy(XIVE_TCTX(pnv_cpu-&gt;intc));
+    pnv_cpu-&gt;intc = NULL;
+}
+
+static void pnv_chip_power11_intc_print_info(PnvChip *chip, PowerPCCPU *cpu,
+                                             GString *buf)
+{
+    xive_tctx_pic_print_info(XIVE_TCTX(pnv_cpu_state(cpu)-&gt;intc), buf);
+}
+
 static void *pnv_chip_power11_intc_get(PnvChip *chip)
 {
     return &amp;PNV11_CHIP(chip)-&gt;xive;
@@ -2443,6 +2488,10 @@ static void pnv_chip_power11_instance_init(Object *obj)
     object_initialize_child(obj, "occ",  &amp;chip11-&gt;occ, TYPE_PNV10_OCC);
     object_initialize_child(obj, "sbe",  &amp;chip11-&gt;sbe, TYPE_PNV10_SBE);
     object_initialize_child(obj, "homer", &amp;chip11-&gt;homer, TYPE_PNV10_HOMER);
+
+    object_initialize_child(obj, "xive", &amp;chip11-&gt;xive, TYPE_PNV_XIVE2);
+    object_property_add_alias(obj, "xive-fabric", OBJECT(&amp;chip11-&gt;xive),
+                              "xive-fabric");
     object_initialize_child(obj, "n1-chiplet", &amp;chip11-&gt;n1_chiplet,
                             TYPE_PNV_N1_CHIPLET);
 
@@ -2518,7 +2567,26 @@ static void pnv_chip_power11_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    /* WIP: XIVE added in future patch */
+    /* XIVE2 interrupt controller */
+    object_property_set_int(OBJECT(&amp;chip11-&gt;xive), "ic-bar",
+                            PNV11_XIVE2_IC_BASE(chip), &amp;error_fatal);
+    object_property_set_int(OBJECT(&amp;chip11-&gt;xive), "esb-bar",
+                            PNV11_XIVE2_ESB_BASE(chip), &amp;error_fatal);
+    object_property_set_int(OBJECT(&amp;chip11-&gt;xive), "end-bar",
+                            PNV11_XIVE2_END_BASE(chip), &amp;error_fatal);
+    object_property_set_int(OBJECT(&amp;chip11-&gt;xive), "nvpg-bar",
+                            PNV11_XIVE2_NVPG_BASE(chip), &amp;error_fatal);
+    object_property_set_int(OBJECT(&amp;chip11-&gt;xive), "nvc-bar",
+                            PNV11_XIVE2_NVC_BASE(chip), &amp;error_fatal);
+    object_property_set_int(OBJECT(&amp;chip11-&gt;xive), "tm-bar",
+                            PNV11_XIVE2_TM_BASE(chip), &amp;error_fatal);
+    object_property_set_link(OBJECT(&amp;chip11-&gt;xive), "chip", OBJECT(chip),
+                             &amp;error_abort);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&amp;chip11-&gt;xive), errp)) {
+        return;
+    }
+    pnv_xscom_add_subregion(chip, PNV11_XSCOM_XIVE2_BASE,
+                            &amp;chip11-&gt;xive.xscom_regs);
 
     /* Processor Service Interface (PSI) Host Bridge */
     object_property_set_int(OBJECT(&amp;chip11-&gt;psi), "bar",
@@ -2720,6 +2788,10 @@ static void pnv_chip_power11_class_init(ObjectClass *klass, const void *data)
     k-&gt;chip_cfam_id = 0x220da04980000000ull; /* P11 DD2.0 (with NX) */
     k-&gt;cores_mask = POWER11_CORE_MASK;
     k-&gt;get_pir_tir = pnv_get_pir_tir_p10;
+    k-&gt;intc_create = pnv_chip_power11_intc_create;
+    k-&gt;intc_reset = pnv_chip_power11_intc_reset;
+    k-&gt;intc_destroy = pnv_chip_power11_intc_destroy;
+    k-&gt;intc_print_info = pnv_chip_power11_intc_print_info;
     k-&gt;intc_get = pnv_chip_power11_intc_get;
     k-&gt;isa_create = pnv_chip_power11_isa_create;
     k-&gt;dt_populate = pnv_chip_power11_dt_populate;
@@ -3073,6 +3145,45 @@ static int pnv10_xive_broadcast(XiveFabric *xfb,
     return 0;
 }
 
+static bool pnv11_xive_match_nvt(XiveFabric *xfb, uint8_t format,
+                                 uint8_t nvt_blk, uint32_t nvt_idx,
+                                 bool crowd, bool cam_ignore, uint8_t priority,
+                                 uint32_t logic_serv,
+                                 XiveTCTXMatch *match)
+{
+    PnvMachineState *pnv = PNV_MACHINE(xfb);
+    int i;
+
+    for (i = 0; i &lt; pnv-&gt;num_chips; i++) {
+        Pnv11Chip *chip11 = PNV11_CHIP(pnv-&gt;chips[i]);
+        XivePresenter *xptr = XIVE_PRESENTER(&amp;chip11-&gt;xive);
+        XivePresenterClass *xpc = XIVE_PRESENTER_GET_CLASS(xptr);
+
+        xpc-&gt;match_nvt(xptr, format, nvt_blk, nvt_idx, crowd,
+                       cam_ignore, priority, logic_serv, match);
+    }
+
+    return !!match-&gt;count;
+}
+
+static int pnv11_xive_broadcast(XiveFabric *xfb,
+                                uint8_t nvt_blk, uint32_t nvt_idx,
+                                bool crowd, bool cam_ignore,
+                                uint8_t priority)
+{
+    PnvMachineState *pnv = PNV_MACHINE(xfb);
+    int i;
+
+    for (i = 0; i &lt; pnv-&gt;num_chips; i++) {
+        Pnv11Chip *chip11 = PNV11_CHIP(pnv-&gt;chips[i]);
+        XivePresenter *xptr = XIVE_PRESENTER(&amp;chip11-&gt;xive);
+        XivePresenterClass *xpc = XIVE_PRESENTER_GET_CLASS(xptr);
+
+        xpc-&gt;broadcast(xptr, nvt_blk, nvt_idx, crowd, cam_ignore, priority);
+    }
+    return 0;
+}
+
 static bool pnv_machine_get_big_core(Object *obj, Error **errp)
 {
     PnvMachineState *pnv = PNV_MACHINE(obj);
@@ -3251,6 +3362,7 @@ static void pnv_machine_power11_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
     PnvMachineClass *pmc = PNV_MACHINE_CLASS(oc);
+    XiveFabricClass *xfc = XIVE_FABRIC_CLASS(oc);
     static const char compat[] = "qemu,powernv11\0ibm,powernv";
 
     pmc-&gt;compat = compat;
@@ -3260,6 +3372,9 @@ static void pnv_machine_power11_class_init(ObjectClass *oc, const void *data)
     pmc-&gt;quirk_tb_big_core = true;
     pmc-&gt;dt_power_mgt = pnv_dt_power_mgt;
 
+    xfc-&gt;match_nvt = pnv11_xive_match_nvt;
+    xfc-&gt;broadcast = pnv11_xive_broadcast;
+
     mc-&gt;desc = "IBM PowerNV (Non-Virtualized) Power11";
     mc-&gt;default_cpu_type = POWERPC_CPU_TYPE_NAME("power11_v2.0");
 
@@ -3393,6 +3508,10 @@ static const TypeInfo types[] = {
         .name          = MACHINE_TYPE_NAME("powernv11"),
         .parent        = TYPE_PNV_MACHINE,
         .class_init    = pnv_machine_power11_class_init,
+        .interfaces = (InterfaceInfo[]) {
+            { TYPE_XIVE_FABRIC },
+            { },
+        },
     },
     {
         .name          = MACHINE_TYPE_NAME("powernv10-rainier"),
diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
index f0002627bcab..cbdddfc73cd4 100644
--- a/include/hw/ppc/pnv.h
+++ b/include/hw/ppc/pnv.h
@@ -270,6 +270,24 @@ void pnv_bmc_set_pnor(IPMIBmc *bmc, PnvPnor *pnor);
 #define PNV11_PSIHB_SIZE            PNV10_PSIHB_SIZE
 #define PNV11_PSIHB_BASE(chip)      PNV10_PSIHB_BASE(chip)
 
+#define PNV11_XIVE2_IC_SIZE         PNV10_XIVE2_IC_SIZE
+#define PNV11_XIVE2_IC_BASE(chip)   PNV10_XIVE2_IC_BASE(chip)
+
+#define PNV11_XIVE2_TM_SIZE         PNV10_XIVE2_TM_SIZE
+#define PNV11_XIVE2_TM_BASE(chip)   PNV10_XIVE2_TM_BASE(chip)
+
+#define PNV11_XIVE2_NVC_SIZE        PNV10_XIVE2_NVC_SIZE
+#define PNV11_XIVE2_NVC_BASE(chip)  PNV10_XIVE2_NVC_BASE(chip)
+
+#define PNV11_XIVE2_NVPG_SIZE       PNV10_XIVE2_NVPG_SIZE
+#define PNV11_XIVE2_NVPG_BASE(chip) PNV10_XIVE2_NVPG_BASE(chip)
+
+#define PNV11_XIVE2_ESB_SIZE        PNV10_XIVE2_ESB_SIZE
+#define PNV11_XIVE2_ESB_BASE(chip)  PNV10_XIVE2_ESB_BASE(chip)
+
+#define PNV11_XIVE2_END_SIZE        PNV10_XIVE2_END_SIZE
+#define PNV11_XIVE2_END_BASE(chip)  PNV10_XIVE2_END_BASE(chip)
+
 #define PNV11_OCC_SENSOR_BASE(chip) PNV10_OCC_SENSOR_BASE(chip)
 
 #endif /* PPC_PNV_H */
</pre>
    </blockquote>
  </body>
</html>

--------------H52FfIKnaaqLxZoR2GANZQOE--


