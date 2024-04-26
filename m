Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1044AC4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2024 17:35:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0PSz-0006QF-V4; Fri, 26 Apr 2024 13:34:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1s0PSx-0006PG-OO; Fri, 26 Apr 2024 13:34:31 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1s0PSv-0005ks-Kv; Fri, 26 Apr 2024 13:34:31 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 43QH3Rr7021905; Fri, 26 Apr 2024 17:34:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=pp1;
 bh=Vi9S9klno6f31cN9uDsWsajnNRT8KfmAawJAuZSvv6s=;
 b=aJGHEkEa61929fyntA/WplpCyOV4dNgW9LC4vknSABwdCDhs3dHT/00LyPUM2t6bUUFh
 9St39WVRMg1RUtj/Q3LgHimK2oJJlLBgqLrQX3nL3M7tbz++zMvIx75R17nhMfw4QOSM
 kzUypM7FDoBWZGTSDbAfi7zqbUevaUBa2agafH/bQUJZUCvBmu1QYLyYTyPeiu1MD1FB
 5LHBT+Ar8HSzjlQIWFrApqz4DoEW5+rJxSyrqYLMPKQ8NN0NatYObPkA55aYdvk9mYRo
 ivcEtxS5Aoz3rN9aMIBW09qFznPx2oNHIpunq/6NU5ssQ3JiIBuKECJisG/GIoypAjo2 Uw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xrgb1r228-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 Apr 2024 17:34:19 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43QHYJ0B003035;
 Fri, 26 Apr 2024 17:34:19 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xrgb1r225-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 Apr 2024 17:34:19 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 43QF1dIN020915; Fri, 26 Apr 2024 17:34:18 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xmre0h4ax-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 Apr 2024 17:34:18 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 43QHYDhw30540412
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 26 Apr 2024 17:34:15 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1696F2004D;
 Fri, 26 Apr 2024 17:34:13 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E871E20040;
 Fri, 26 Apr 2024 17:34:10 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.171.36.162])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Fri, 26 Apr 2024 17:34:10 +0000 (GMT)
Date: Fri, 26 Apr 2024 23:04:08 +0530
From: Aditya Gupta <adityag@linux.ibm.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>
Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org,
 =?utf-8?B?RnLDqWTDqXJpYw==?= Barrat <fbarrat@linux.ibm.com>
Subject: Re: [PATCH v2 03/10] ppc/pnv: Add a Power11 Pnv11Chip, and a Power11
 Machine
Message-ID: <trxofbh7pgkmmfioku4kw7c7rl4bj3dawe4zakuqcx55tnhujo@fqxgd6s3odvr>
References: <20240426110023.733309-1-adityag@linux.ibm.com>
 <20240426110023.733309-4-adityag@linux.ibm.com>
 <7ac5fa18-70be-42d2-addb-b35c9355e984@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7ac5fa18-70be-42d2-addb-b35c9355e984@kaod.org>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: JmfVB39bqpmgp--zCll-PnTmcfJsyUhV
X-Proofpoint-ORIG-GUID: gLnpa4giT7b7gKnEUtsmli8mbO6O5lNk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-26_14,2024-04-26_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0
 mlxscore=0 mlxlogscore=999 adultscore=0 malwarescore=0 suspectscore=0
 clxscore=1015 phishscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404260119
Received-SPF: pass client-ip=148.163.158.5; envelope-from=adityag@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hello Cédric,

> >
> > <...snip...>
> >
> > - * Multi processor support for POWER8, POWER8NVL and POWER9.
> > + * Multi processor support for POWER8, POWER8NVL, POWER9, POWER10 and Power11.
> 
> POWER10 -> Power10. Don't ask me why.

Sure, got it !

> 
> >    * XSCOM, serial communication sideband bus to configure chiplets.
> >    * Simple LPC Controller.
> >    * Processor Service Interface (PSI) Controller.
> > - * Interrupt Controller, XICS (POWER8) and XIVE (POWER9) and XIVE2 (Power10).
> > + * Interrupt Controller, XICS (POWER8) and XIVE (POWER9) and XIVE2 (Power10 &
> > +   Power11).
> >    * POWER8 PHB3 PCIe Host bridge and POWER9 PHB4 PCIe Host bridge.
> >    * Simple OCC is an on-chip micro-controller used for power management tasks.
> >    * iBT device to handle BMC communication, with the internal BMC simulator
> > diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> > index 74e7908e5ffb..06e272f3bdd3 100644
> > --- a/hw/ppc/pnv.c
> > +++ b/hw/ppc/pnv.c
> > @@ -431,13 +431,27 @@ static const uint8_t pa_features_31[] = { 74, 0,
> >   static void pnv_chip_power10_dt_populate(PnvChip *chip, void *fdt)
> >   {
> > -    static const char compat[] = "ibm,power10-xscom\0ibm,xscom";
> > +    PnvChipClass *pcc = PNV_CHIP_GET_CLASS(chip);
> > +    static const char compat_p10[] = "ibm,power10-xscom\0ibm,xscom";
> > +    static const char compat_p11[] = "ibm,power11-xscom\0ibm,xscom";
> > +
> > +    PnvChipType chip_type = pcc->chip_type;
> > +    const char *compat;
> > +    int compat_len;
> >       int i;
> > +    if (chip_type == PNV_TYPE_POWER11) {
> > +        compat = compat_p11;
> > +        compat_len = sizeof(compat_p11);
> > +    } else {
> > +        compat = compat_p10;
> > +        compat_len = sizeof(compat_p10);
> > +    }
> 
> please introduce a pnv_chip_power11_dt_populate() routine instead.

Okay.

> 
> >       pnv_dt_xscom(chip, fdt, 0,
> >                    cpu_to_be64(PNV10_XSCOM_BASE(chip)),
> >                    cpu_to_be64(PNV10_XSCOM_SIZE),
> > -                 compat, sizeof(compat));
> > +                 compat, compat_len);
> >       for (i = 0; i < chip->nr_cores; i++) {
> >           PnvCore *pnv_core = chip->cores[i];
> > @@ -1288,6 +1302,8 @@ static void pnv_chip_power10_intc_print_info(PnvChip *chip, PowerPCCPU *cpu,
> >   #define POWER10_CORE_MASK  (0xffffffffffffffull)
> > +#define POWER11_CORE_MASK  (0xffffffffffffffull)
> > +
> >   static void pnv_chip_power8_instance_init(Object *obj)
> >   {
> >       Pnv8Chip *chip8 = PNV8_CHIP(obj);
> > @@ -1838,6 +1854,7 @@ static void pnv_chip_power10_instance_init(Object *obj)
> >   static void pnv_chip_power10_quad_realize(Pnv10Chip *chip10, Error **errp)
> >   {
> >       PnvChip *chip = PNV_CHIP(chip10);
> > +    PnvChipClass *chip_class = PNV_CHIP_GET_CLASS(chip);
> >       int i;
> >       chip10->nr_quads = DIV_ROUND_UP(chip->nr_cores, 4);
> > @@ -1846,7 +1863,11 @@ static void pnv_chip_power10_quad_realize(Pnv10Chip *chip10, Error **errp)
> >       for (i = 0; i < chip10->nr_quads; i++) {
> >           PnvQuad *eq = &chip10->quads[i];
> > -        pnv_chip_quad_realize_one(chip, eq, chip->cores[i * 4],
> > +        if (chip_class->chip_type == PNV_TYPE_POWER11)
> > +            pnv_chip_quad_realize_one(chip, eq, chip->cores[i * 4],
> > +                                  PNV_QUAD_TYPE_NAME("power11"));
> > +        else
> > +            pnv_chip_quad_realize_one(chip, eq, chip->cores[i * 4],
> >                                     PNV_QUAD_TYPE_NAME("power10"));
> 
> 
> Please change introduce a new pnv_chip_quad_realize() routine taking an
> extra type_name argument.

Sure, can do it. But as it's called from 'pnv_chip_power10_realize',
might require a 'pnv_chip_power11_realize' function also, so it can pass
type_name as "power11" vs "power10".
Will do it.

> 
> 
> >           pnv_xscom_add_subregion(chip, PNV10_XSCOM_EQ_BASE(eq->quad_id),
> > @@ -2116,6 +2137,35 @@ static void pnv_chip_power10_class_init(ObjectClass *klass, void *data)
> >                                       &k->parent_realize);
> >   }
> > +static void pnv_chip_power11_class_init(ObjectClass *klass, void *data)
> > +{
> > +    DeviceClass *dc = DEVICE_CLASS(klass);
> > +    PnvChipClass *k = PNV_CHIP_CLASS(klass);
> > +
> > +    static const int i2c_ports_per_engine[PNV10_CHIP_MAX_I2C] = {14, 14, 2, 16};
> > +
> > +    k->chip_cfam_id = 0x120da04900008000ull; /* P11 (with NX) */
> > +    k->chip_type = PNV_TYPE_POWER11;
> > +    k->cores_mask = POWER11_CORE_MASK;
> > +    k->chip_pir = pnv_chip_pir_p10;
> > +    k->intc_create = pnv_chip_power10_intc_create;
> > +    k->intc_reset = pnv_chip_power10_intc_reset;
> > +    k->intc_destroy = pnv_chip_power10_intc_destroy;
> > +    k->intc_print_info = pnv_chip_power10_intc_print_info;
> > +    k->isa_create = pnv_chip_power10_isa_create;
> > +    k->dt_populate = pnv_chip_power10_dt_populate;
> > +    k->pic_print_info = pnv_chip_power10_pic_print_info;
> > +    k->xscom_core_base = pnv_chip_power10_xscom_core_base;
> > +    k->xscom_pcba = pnv_chip_power10_xscom_pcba;
> > +    dc->desc = "PowerNV Chip POWER11";
> > +    k->num_pecs = PNV10_CHIP_MAX_PEC;
> > +    k->i2c_num_engines = PNV10_CHIP_MAX_I2C;
> > +    k->i2c_ports_per_engine = i2c_ports_per_engine;
> > +
> > +    device_class_set_parent_realize(dc, pnv_chip_power10_realize,
> > +                                    &k->parent_realize);
> > +}
> > +
> >   static void pnv_chip_core_sanitize(PnvChip *chip, Error **errp)
> >   {
> >       PnvChipClass *pcc = PNV_CHIP_GET_CLASS(chip);
> > @@ -2510,6 +2560,22 @@ static void pnv_machine_p10_rainier_class_init(ObjectClass *oc, void *data)
> >       pmc->i2c_init = pnv_rainier_i2c_init;
> >   }
> > +static void pnv_machine_power11_class_init(ObjectClass *oc, void *data)
> > +{
> > +    MachineClass *mc = MACHINE_CLASS(oc);
> > +    PnvMachineClass *pmc = PNV_MACHINE_CLASS(oc);
> > +    static const char compat[] = "qemu,powernv11\0ibm,powernv";
> > +
> > +    /* do power10_class_init as p11 core is same as p10 */
> > +    pnv_machine_p10_common_class_init(oc, data);
> > +
> > +    mc->desc = "IBM PowerNV (Non-Virtualized) POWER11";
> > +    mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("power11");
> 
> This should be using a versionned CPU "power11_vx.y".

Okay.

> 
> > +
> > +    pmc->compat = compat;
> > +    pmc->compat_size = sizeof(compat);
> > +}
> > +
> >   static bool pnv_machine_get_hb(Object *obj, Error **errp)
> >   {
> >       PnvMachineState *pnv = PNV_MACHINE(obj);
> > @@ -2613,7 +2679,23 @@ static void pnv_machine_class_init(ObjectClass *oc, void *data)
> >           .parent        = TYPE_PNV10_CHIP,          \
> >       }
> > +#define DEFINE_PNV11_CHIP_TYPE(type, class_initfn) \
> > +    {                                              \
> > +        .name          = type,                     \
> > +        .class_init    = class_initfn,             \
> > +        .parent        = TYPE_PNV11_CHIP,          \
> > +    }
> > +
> >   static const TypeInfo types[] = {
> > +    {
> > +        .name          = MACHINE_TYPE_NAME("powernv11"),
> > +        .parent        = TYPE_PNV_MACHINE,
> > +        .class_init    = pnv_machine_power11_class_init,
> > +        .interfaces = (InterfaceInfo[]) {
> > +            { TYPE_XIVE_FABRIC },
> > +            { },
> > +        },
> > +    },
> >       {
> >           .name          = MACHINE_TYPE_NAME("powernv10-rainier"),
> >           .parent        = MACHINE_TYPE_NAME("powernv10"),
> > @@ -2668,6 +2750,16 @@ static const TypeInfo types[] = {
> >           .abstract      = true,
> >       },
> > +    /*
> > +     * P11 chip and variants
> > +     */
> > +    {
> > +        .name          = TYPE_PNV11_CHIP,
> > +        .parent        = TYPE_PNV10_CHIP,
> > +        .instance_size = sizeof(Pnv11Chip),
> > +    },
> > +    DEFINE_PNV11_CHIP_TYPE(TYPE_PNV_CHIP_POWER11, pnv_chip_power11_class_init),
> > +
> >       /*
> >        * P10 chip and variants
> >        */
> > diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
> > index f40ab721d6fc..4522655793da 100644
> > --- a/hw/ppc/pnv_core.c
> > +++ b/hw/ppc/pnv_core.c
> > @@ -402,7 +402,16 @@ static const TypeInfo pnv_core_infos[] = {
> >       DEFINE_PNV_CORE_TYPE(power8, "power8_v2.0"),
> >       DEFINE_PNV_CORE_TYPE(power8, "power8nvl_v1.0"),
> >       DEFINE_PNV_CORE_TYPE(power9, "power9_v2.2"),
> > -    DEFINE_PNV_CORE_TYPE(power10, "power10_v2.0"),
> > +    {
> > +        .parent = TYPE_PNV_CORE,
> > +        .name = PNV_CORE_TYPE_NAME("power10_v2.0"),
> > +        .class_init = pnv_core_power10_class_init,
> > +        .class_base_init = pnv_core_power10_class_init,
> > +    },
> 
> hmm, what is this change ?

I expanded the macro, to add '.class_base_init', as .class_base_init
will be run by QEMU during initialisation of any child classes also. And
I wanted to let QEMU call 'pnv_core_power10_class_init' when it
initialises 'power11' type.

> 
> 
> > +    {
> > +        .parent = PNV_CORE_TYPE_NAME("power10_v2.0"),
> > +        .name = PNV_CORE_TYPE_NAME("power11"),
> > +    }
> 
> nope. please use DEFINE_PNV_CORE_TYPE()

Okay, then, should I have a 'pnv_core_power11_class_init' call
'pnv_core_power10_class_init' ?

> 
> >   };
> >   DEFINE_TYPES(pnv_core_infos)
> > @@ -633,6 +642,11 @@ static const TypeInfo pnv_quad_infos[] = {
> >           .parent = TYPE_PNV_QUAD,
> >           .name = PNV_QUAD_TYPE_NAME("power10"),
> >           .class_init = pnv_quad_power10_class_init,
> > +        .class_base_init = pnv_quad_power10_class_init,
> > +    },
> > +    {
> > +        .parent = PNV_QUAD_TYPE_NAME("power10"),
> > +        .name = PNV_QUAD_TYPE_NAME("power11"),
> 
> hmm, I'd rather introduce pnv_quad_power11_class_init.

Same, in that case, I can have a 'pnv_quad_power11_class_init' which
just calls 'pnv_quad_power10_class_init'.

Any comments ?

> > <...snip...>
> >
> > +struct Pnv11Chip {
> > +    /*< private >*/
> > +    Pnv10Chip      parent_obj;
> 
> Can't you use a typedef instead ?

Yes, makes sense. Thanks Cédric.

- Aditya Gupta

> 
> Thanks,
> 
> C.
> 
> 
> > +};
> > +
> >   struct PnvChipClass {
> >       /*< private >*/
> >       SysBusDeviceClass parent_class;
> 

