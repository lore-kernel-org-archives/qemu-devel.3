Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34608C282DE
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 10:30:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1traOV-0008Q9-2d; Mon, 10 Mar 2025 06:29:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1traOS-0008P0-Ly; Mon, 10 Mar 2025 06:29:56 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1traOQ-0001FJ-9U; Mon, 10 Mar 2025 06:29:56 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 529LKF0A020904;
 Mon, 10 Mar 2025 10:29:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=xO2Jph
 TxrcHeF+m27aeP6BLfqYm1hPGudtTn44rsEGI=; b=MppITT3ftGaNjANLC8zFhx
 4oO0FqbJWSTuNI1NkQM0LxlTCCEZVrBA6TI5WOTXwdFYpws0Ym+KTXMJGtDpxG/o
 kFL9OerF1SUbhZiDui1eO4mTuYOEJKhBit8PpyoUZPM5cSNoRsKDyaCB6UIICPxa
 TnGPwZdr4DtkTZR5w9L+abIZptPnLURTziS+rqND7eI6cANUvCus8WBsMFJ+laex
 Q+i9YdGYQsEVrv/tpims0QUaMofNJ7mskw8V9AMr5lMMaybvLLigojjkwy5hQw0+
 M2PDf0gRyItOOxKtHN0auKeeDz5E0iPBvgBF8PnN/7FDFcVfzOFQNKb9XJkPRegA
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 459b16m02t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 10 Mar 2025 10:29:41 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52AATfeM016316;
 Mon, 10 Mar 2025 10:29:41 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 459b16m02q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 10 Mar 2025 10:29:41 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52AA6CRs023841;
 Mon, 10 Mar 2025 10:29:40 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4590kyp8jm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 10 Mar 2025 10:29:40 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 52AATakV27787904
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 10 Mar 2025 10:29:36 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1F3BF20043;
 Mon, 10 Mar 2025 10:29:36 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 09A692004F;
 Mon, 10 Mar 2025 10:29:34 +0000 (GMT)
Received: from [9.109.199.160] (unknown [9.109.199.160])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 10 Mar 2025 10:29:33 +0000 (GMT)
Message-ID: <0efed892-f988-4865-b219-bdf750abeef6@linux.ibm.com>
Date: Mon, 10 Mar 2025 15:59:33 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 7/8] ppc/pnv: Add a Power11 Pnv11Chip, and a Power11
 Machine
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
References: <20250308205141.3219333-1-adityag@linux.ibm.com>
 <20250308205141.3219333-8-adityag@linux.ibm.com>
 <bce5dcfc-24d2-41e2-b11e-7cb5967f2132@kaod.org>
Content-Language: en-US
From: Aditya Gupta <adityag@linux.ibm.com>
In-Reply-To: <bce5dcfc-24d2-41e2-b11e-7cb5967f2132@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: MgSGmDMhHgqMKD2DdI9bmzZY-4EUdXzQ
X-Proofpoint-GUID: 14LDVWIyswfcX03ElY3kFcrLUwnfsyOl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-10_04,2025-03-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0
 priorityscore=1501 spamscore=0 phishscore=0 mlxscore=0 suspectscore=0
 lowpriorityscore=0 impostorscore=0 mlxlogscore=999 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503100083
Received-SPF: pass client-ip=148.163.156.1; envelope-from=adityag@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Hi Cédric,

Thanks for the reviews.


On 09/03/25 19:38, Cédric Le Goater wrote:
> On 3/8/25 21:51, Aditya Gupta wrote:
>>
>> <...snip...>
>>
>>   docs/system/ppc/powernv.rst |   9 +-
>>   hw/ppc/pnv.c                | 177 +++++++++++++++++++++++++++++++++++-
>>   hw/ppc/pnv_core.c           |  11 +++
>
> I would introduce the pnv_core changes in their own patch.
Sure, will do that in v6.
>
>>   include/hw/ppc/pnv.h        |   5 +
>>   include/hw/ppc/pnv_chip.h   |   7 ++
>>   include/hw/ppc/pnv_core.h   |   1 +
>>   6 files changed, 201 insertions(+), 9 deletions(-)
>>
>> diff --git a/docs/system/ppc/powernv.rst b/docs/system/ppc/powernv.rst
>> index de7a807ac762..366da9bc371c 100644
>>
>> <...snip...>
>>
>> +    /*
>> +     * Power11 declares Power10 as it's parent class, to be able to 
>> reuse
>> +     * most of the Power10 code.
>> +     * But this causes Power10 and Power11's both instance init to be
>> +     * called for PowerNV11 chip
>> +     *
>> +     * Skip initialising Power10 specific child objects, if the chip is
>> +     * Power11 chip, in which case power11's instance init will 
>> initialise
>> +     * the child objects
>> +     */
>> +    if (!strcmp(object_get_typename(obj), TYPE_PNV_CHIP_POWER11)) {
>> +        return;
>> +    }
>> +
>
> This is a hack !  Please duplicate the code like done for other chips.
>
Agreed it's hacky. Okay, I will duplicate the code.

>
>>       object_initialize_child(obj, "adu", &chip10->adu, TYPE_PNV_ADU);
>>       object_initialize_child(obj, "xive", &chip10->xive, 
>> TYPE_PNV_XIVE2);
>>       object_property_add_alias(obj, "xive-fabric", 
>> OBJECT(&chip10->xive),
>> @@ -1997,7 +2041,8 @@ static void 
>> pnv_chip_power10_instance_init(Object *obj)
>>       }
>>   }
>>   -static void pnv_chip_power10_quad_realize(Pnv10Chip *chip10, Error 
>> **errp)
>> +static void pnv_chip_power10_quad_realize(Pnv10Chip *chip10, Error 
>> **errp,
>> +        const char *cpu_model)
>
>
> this belongs to another patch modifying P10 first.
>
Okay, will put changes modifying p10 functions in diff patch.
>>   {
>>       PnvChip *chip = PNV_CHIP(chip10);
>>       int i;
>> @@ -2007,9 +2052,10 @@ static void 
>> pnv_chip_power10_quad_realize(Pnv10Chip *chip10, Error **errp)
>>         for (i = 0; i < chip10->nr_quads; i++) {
>>           PnvQuad *eq = &chip10->quads[i];
>> +        g_autofree char *type_name = PNV_QUAD_TYPE_NAME_DYN(cpu_model);
>>             pnv_chip_quad_realize_one(chip, eq, chip->cores[i * 4],
>> - PNV_QUAD_TYPE_NAME("power10"));
>> +                                  type_name);
>>             pnv_xscom_add_subregion(chip, 
>> PNV10_XSCOM_EQ_BASE(eq->quad_id),
>>                                   &eq->xscom_regs);
>> @@ -2047,7 +2093,8 @@ static void 
>> pnv_chip_power10_phb_realize(PnvChip *chip, Error **errp)
>>       }
>>   }
>>   -static void pnv_chip_power10_realize(DeviceState *dev, Error **errp)
>> +static void pnv_chip_power10_common_realize(DeviceState *dev, Error 
>> **errp,
>> +        const char *cpu_model)
>
> this belongs to another patch modifying P10 first.
Sure
>
>>   <...snip...>
>>
>> @@ -2757,7 +2880,6 @@ static void 
>> pnv_machine_p10_common_class_init(ObjectClass *oc, void *data)
>>           { TYPE_PNV_PHB_ROOT_PORT, "version", "5" },
>>       };
>>   -    mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("power10_v2.0");
>
> This belongs to another patch.
>
Sure, will move it another patch.
>> compat_props_add(mc->compat_props, phb_compat, 
>> G_N_ELEMENTS(phb_compat));
>>         mc->alias = "powernv";
>> @@ -2780,6 +2902,7 @@ static void 
>> pnv_machine_power10_class_init(ObjectClass *oc, void *data)
>>         pnv_machine_p10_common_class_init(oc, data);
>>       mc->desc = "IBM PowerNV (Non-Virtualized) POWER10";
>> +    mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("power10_v2.0");
>
> ditto
Sure
>>         /*
>>        * This is the parent of POWER10 Rainier class, so properies go 
>> here
>> @@ -2806,9 +2929,26 @@ static void 
>> pnv_machine_p10_rainier_class_init(ObjectClass *oc, void *data)
>>         pnv_machine_p10_common_class_init(oc, data);
>>       mc->desc = "IBM PowerNV (Non-Virtualized) POWER10 Rainier";
>> +    mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("power10_v2.0");
>
> ditto
Okay will move to different patch
>
>> <...snip...>
>>
>> @@ -2969,6 +3125,17 @@ static const TypeInfo types[] = {
>>           .abstract      = true,
>>       },
>> +    /*
>> +     * P11 chip and variants
>> +     */
>> +    {
>> +        .name          = TYPE_PNV11_CHIP,
>> +        .parent        = TYPE_PNV10_CHIP,
>
> why is the parent not TYPE_PNV_CHIP like the other chips ?
>
> This is a hack which can be easily avoided with more work :)

I kept it that way so that for most things p11 could simply fall back to 
p10 functions.

Many of these functions cast the chip object to PNV10_CHIP, and since 
QEMU allows casting to parent class, I made PNV10_CHIP the parent of 
PNV11_CHIP.

Duplicating the code, or something allowing this cast the ways I think. 
Will duplicate.

>
>> +        .instance_init = pnv_chip_power11_instance_init,
>> +        .instance_size = sizeof(Pnv11Chip),
>> +    },
>> +    DEFINE_PNV11_CHIP_TYPE(TYPE_PNV_CHIP_POWER11, 
>> pnv_chip_power11_class_init),
>> +
>>       /*
>>        * P10 chip and variants
>>        */
>> diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
>> index 99d9644ee38e..12916b15aa3b 100644
>> --- a/hw/ppc/pnv_core.c
>> +++ b/hw/ppc/pnv_core.c
>> @@ -469,6 +469,11 @@ static void 
>> pnv_core_power10_class_init(ObjectClass *oc, void *data)
>>       pcc->xscom_size = PNV10_XSCOM_EC_SIZE;
>>   }
>>   +static void pnv_core_power11_class_init(ObjectClass *oc, void *data)
>> +{
>> +    pnv_core_power10_class_init(oc, data);
>> +}
>> +
>>   static void pnv_core_class_init(ObjectClass *oc, void *data)
>>   {
>>       DeviceClass *dc = DEVICE_CLASS(oc);
>> @@ -500,6 +505,7 @@ static const TypeInfo pnv_core_infos[] = {
>>       DEFINE_PNV_CORE_TYPE(power8, "power8nvl_v1.0"),
>>       DEFINE_PNV_CORE_TYPE(power9, "power9_v2.2"),
>>       DEFINE_PNV_CORE_TYPE(power10, "power10_v2.0"),
>> +    DEFINE_PNV_CORE_TYPE(power11, "power11_v2.0"),
>>   };
>>     DEFINE_TYPES(pnv_core_infos)
>> @@ -748,6 +754,11 @@ static const TypeInfo pnv_quad_infos[] = {
>>           .name = PNV_QUAD_TYPE_NAME("power10"),
>>           .class_init = pnv_quad_power10_class_init,
>>       },
>> +    {
>> +        .parent = PNV_QUAD_TYPE_NAME("power10"),
>
> why not TYPE_PNV_QUAD ?
>
I wanted it to use Power10 quad's '_class_init' & '_realize'. Will make 
it's parent PNV_QUAD, and create separate class_init and realize for 
Power11 then.


Thanks,

- Aditya Gupta

>
> Thanks,
>
> C.
>

