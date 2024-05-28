Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2B32C25B7E
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 07:11:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBqzR-0007fe-0T; Tue, 28 May 2024 03:11:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1sBqzP-0007dx-57; Tue, 28 May 2024 03:11:19 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1sBqys-00068N-2n; Tue, 28 May 2024 03:11:18 -0400
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 44S6B25f028000; Tue, 28 May 2024 07:10:41 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1; _a=3Drsa-sha256; _c=3Drelaxed/relaxed;
 _d=3Dibm.com; _h=3Dcc?=
 =?UTF-8?Q?:content-transfer-encoding:content-type:date:from:in-reply-to:m?=
 =?UTF-8?Q?essage-id:mime-version:references:subject:to;_s=3Dpp1;_bh=3DR+o?=
 =?UTF-8?Q?+EhoV+QNJPB1uilihNH6qMUUh8Nj+M68ydAyzdb8=3D;_b=3DEm2f1COEaiFAuZ?=
 =?UTF-8?Q?nirYrEIRXDsut2QeprGn7+apQo8VoESPAAy9YWn1xIekN9ATgmMUvt_Z5SyTcoF?=
 =?UTF-8?Q?RVr45/No+9fGhYDDoIt2G5DKW1KdCb92jy7qISNlvv2oJrLhY6aAPect+pDH_c5?=
 =?UTF-8?Q?bRbkscj8JXzDGmdy8avuMs77W9jTcvPJ+QJkJxF6rriblor3DCPmRRNxOgtnRNa?=
 =?UTF-8?Q?bSc_pfbqrz6BY+o6K1ll/pDiR9UxHMQcbQuZREQiqcNWUG7EcBPhDDwsYuXMMA0?=
 =?UTF-8?Q?AX+gFrKFe_z92ZtdQNEgkjLJfI1z3io4JPf8Hf05RhLdA+7yfBUmD59YUPaRp7P?=
 =?UTF-8?Q?b/qH6fb9heP5UBb_BA=3D=3D_?=
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yd8wsr94m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 May 2024 07:10:40 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44S7AeZa022898;
 Tue, 28 May 2024 07:10:40 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yd8wsr94k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 May 2024 07:10:40 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 44S4tNpE006696; Tue, 28 May 2024 07:10:39 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ybtatdrcy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 May 2024 07:10:39 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 44S7AbXe25952834
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 28 May 2024 07:10:39 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1072F58065;
 Tue, 28 May 2024 07:10:37 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B5C4258043;
 Tue, 28 May 2024 07:10:34 +0000 (GMT)
Received: from [9.109.242.165] (unknown [9.109.242.165])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 28 May 2024 07:10:34 +0000 (GMT)
Message-ID: <721d6b4b-0026-44c9-a97b-a007cc1ff5eb@linux.ibm.com>
Date: Tue, 28 May 2024 12:40:33 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 04/10] ppc/pnv: specialise init for powernv8/9/10
 machines
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: Caleb Schlossin <calebs@linux.vnet.ibm.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-devel@nongnu.org
References: <20240526122612.473476-1-npiggin@gmail.com>
 <20240526122612.473476-5-npiggin@gmail.com>
Content-Language: en-US
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <20240526122612.473476-5-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: glsrTNuJaAgwWD33QqTNnv2BEMur73ew
X-Proofpoint-GUID: a_P1HbLNczXsZDI1K7coJETmyAU-6C8M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-28_04,2024-05-27_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 mlxlogscore=999
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 phishscore=0
 spamscore=0 adultscore=0 bulkscore=0 clxscore=1015 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405280051
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

Hi Nick,

On 5/26/24 17:56, Nicholas Piggin wrote:
> This will allow different settings and checks for different
> machine types with later changes.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   hw/ppc/pnv.c | 35 ++++++++++++++++++++++++++++++-----
>   1 file changed, 30 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index 6e3a5ccdec..a706de2e36 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -976,11 +976,6 @@ static void pnv_init(MachineState *machine)
>       pnv->num_chips =
>           machine->smp.max_cpus / (machine->smp.cores * machine->smp.threads);
>   
> -    if (machine->smp.threads > 8) {
> -        error_report("Cannot support more than 8 threads/core "
> -                     "on a powernv machine");
> -        exit(1);
> -    }
>       if (!is_power_of_2(machine->smp.threads)) {
>           error_report("Cannot support %d threads/core on a powernv"
>                        "machine because it must be a power of 2",
> @@ -1076,6 +1071,33 @@ static void pnv_init(MachineState *machine)
>       }
>   }
>   
> +static void pnv_power8_init(MachineState *machine)
> +{
> +    if (machine->smp.threads > 8) {
> +        error_report("Cannot support more than 8 threads/core "
> +                     "on a powernv POWER8 machine");

We could use mc->desc for machine name above, so that ..

> +        exit(1);
> +    }

with this patch, we can reuse p8 init for both p9 and p10 (and not just 
reuse p9 for p10 with hard coded string?).

With that,
Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>

> +
> +    pnv_init(machine);
> +}
> +
> +static void pnv_power9_init(MachineState *machine)
> +{
> +    if (machine->smp.threads > 8) {
> +        error_report("Cannot support more than 8 threads/core "
> +                     "on a powernv9/10 machine");
> +        exit(1);
> +    }
> +
> +    pnv_init(machine);
> +}
> +
> +static void pnv_power10_init(MachineState *machine)
> +{
> +    pnv_power9_init(machine);
> +}
> +
>   /*
>    *    0:21  Reserved - Read as zeros
>    *   22:24  Chip ID
> @@ -2423,6 +2445,7 @@ static void pnv_machine_power8_class_init(ObjectClass *oc, void *data)
>       };
>   
>       mc->desc = "IBM PowerNV (Non-Virtualized) POWER8";
> +    mc->init = pnv_power8_init;
>       mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("power8_v2.0");
>       compat_props_add(mc->compat_props, phb_compat, G_N_ELEMENTS(phb_compat));
>   
> @@ -2449,6 +2472,7 @@ static void pnv_machine_power9_class_init(ObjectClass *oc, void *data)
>       };
>   
>       mc->desc = "IBM PowerNV (Non-Virtualized) POWER9";
> +    mc->init = pnv_power9_init;
>       mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("power9_v2.2");
>       compat_props_add(mc->compat_props, phb_compat, G_N_ELEMENTS(phb_compat));
>   
> @@ -2473,6 +2497,7 @@ static void pnv_machine_p10_common_class_init(ObjectClass *oc, void *data)
>           { TYPE_PNV_PHB_ROOT_PORT, "version", "5" },
>       };
>   
> +    mc->init = pnv_power10_init;
>       mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("power10_v2.0");
>       compat_props_add(mc->compat_props, phb_compat, G_N_ELEMENTS(phb_compat));
>   

