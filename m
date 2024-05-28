Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00B0FC25B78
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 06:21:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBqCR-0007ri-Ay; Tue, 28 May 2024 02:20:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1sBqCN-0007qY-2t; Tue, 28 May 2024 02:20:39 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1sBqC0-00059o-Ri; Tue, 28 May 2024 02:20:38 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 44S6Aogu000546; Tue, 28 May 2024 06:20:04 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1; _a=3Drsa-sha256; _c=3Drelaxed/relaxed;
 _d=3Dibm.com; _h=3Dcc?=
 =?UTF-8?Q?:content-transfer-encoding:content-type:date:from:in-reply-to:m?=
 =?UTF-8?Q?essage-id:mime-version:references:subject:to;_s=3Dpp1;_bh=3DKlj?=
 =?UTF-8?Q?R2xTA1CwiauWebXNAMO60kQuiaj/KBTDeQ4QIkvI=3D;_b=3DWi9NbiFDZeKj+x?=
 =?UTF-8?Q?QWwh3ImwwBl67F7ZOoUiJCmeBIV1joSRFyymzByJBhoiaWoLmkRNBv_IMeVwxZI?=
 =?UTF-8?Q?M2LYgtKgQ1oQPOVs53ie9462UyxteX1P1lmFFv6IL82MFR1yqV35nvWYALYo_8J?=
 =?UTF-8?Q?TyqFD74ERuhzX2rbX95vrzfMz2BDuLhlTCqRn4pcvKLVGPXFEbOsQt4eYXui2Uy?=
 =?UTF-8?Q?Kw7_MPugNQqtCsuUm5HMRQVzRpvB/y4frqzXn6HBx3pie2Piec7BHqJZCGgw+gv?=
 =?UTF-8?Q?6WGl/piYv_97X9HeCoU1kNFiH5TzM9MkoBM+md8sdZNrlV+qDEoJpBxo30eQxac?=
 =?UTF-8?Q?aIog7FZByoQt9aC_dA=3D=3D_?=
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yd904849d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 May 2024 06:20:04 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44S6K318015299;
 Tue, 28 May 2024 06:20:03 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yd904849c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 May 2024 06:20:03 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 44S50C3g011087; Tue, 28 May 2024 06:20:03 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ybtq05ep7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 May 2024 06:20:03 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 44S6K0rI48235100
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 28 May 2024 06:20:02 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CC78058053;
 Tue, 28 May 2024 06:20:00 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6ABB45805F;
 Tue, 28 May 2024 06:19:58 +0000 (GMT)
Received: from [9.109.242.165] (unknown [9.109.242.165])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 28 May 2024 06:19:58 +0000 (GMT)
Message-ID: <b59c7ab1-7671-4c84-9a16-ce571138f4c1@linux.ibm.com>
Date: Tue, 28 May 2024 11:49:56 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 01/10] ppc/pnv: Add pointer from PnvCPUState to PnvCore
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: Caleb Schlossin <calebs@linux.vnet.ibm.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-devel@nongnu.org
References: <20240526122612.473476-1-npiggin@gmail.com>
 <20240526122612.473476-2-npiggin@gmail.com>
Content-Language: en-US
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <20240526122612.473476-2-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: YqUiZRPP_GJ6N5dA95Ski4UTkZNFUNOr
X-Proofpoint-ORIG-GUID: dGKrUWCMHefMe8KPWxblhmwJV8YH4YhQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-28_03,2024-05-27_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 mlxlogscore=999 impostorscore=0 phishscore=0 spamscore=0 clxscore=1015
 bulkscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405280045
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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
> This helps move core state from CPU to core structures.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   include/hw/ppc/pnv_core.h | 1 +
>   hw/ppc/pnv_core.c         | 3 +++
>   2 files changed, 4 insertions(+)
> 
> diff --git a/include/hw/ppc/pnv_core.h b/include/hw/ppc/pnv_core.h
> index c6d62fd145..30c1e5b1a3 100644
> --- a/include/hw/ppc/pnv_core.h
> +++ b/include/hw/ppc/pnv_core.h
> @@ -54,6 +54,7 @@ struct PnvCoreClass {
>   #define PNV_CORE_TYPE_NAME(cpu_model) cpu_model PNV_CORE_TYPE_SUFFIX
>   
>   typedef struct PnvCPUState {
> +    PnvCore *core;

Naming it *pc might be more intuitive with the most of its usage, 
although I see few usage as "pnv_core" as well.

Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>

>       Object *intc;
>   } PnvCPUState;
>   
> diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
> index f40ab721d6..7b0ea7812b 100644
> --- a/hw/ppc/pnv_core.c
> +++ b/hw/ppc/pnv_core.c
> @@ -225,6 +225,7 @@ static const MemoryRegionOps pnv_core_power10_xscom_ops = {
>   static void pnv_core_cpu_realize(PnvCore *pc, PowerPCCPU *cpu, Error **errp,
>                                    int thread_index)
>   {
> +    PnvCPUState *pnv_cpu = pnv_cpu_state(cpu);
>       CPUPPCState *env = &cpu->env;
>       int core_hwid;
>       ppc_spr_t *pir = &env->spr_cb[SPR_PIR];
> @@ -232,6 +233,8 @@ static void pnv_core_cpu_realize(PnvCore *pc, PowerPCCPU *cpu, Error **errp,
>       Error *local_err = NULL;
>       PnvChipClass *pcc = PNV_CHIP_GET_CLASS(pc->chip);
>   
> +    pnv_cpu->core = pc;
> +
>       if (!qdev_realize(DEVICE(cpu), NULL, errp)) {
>           return;
>       }

