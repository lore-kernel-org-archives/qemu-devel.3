Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4855BC54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 13:40:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk2MP-0005pG-C8; Tue, 12 Mar 2024 09:40:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1rk2MG-0005n3-7A; Tue, 12 Mar 2024 09:39:57 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1rk2MD-0003GS-7k; Tue, 12 Mar 2024 09:39:55 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 42CDLRI6000530; Tue, 12 Mar 2024 13:39:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=YDXeLkwTC3uR8ZL5Vcol+th6X8cjGFur7oqJFpWmk9A=;
 b=RDOqeWG/8A1quczphonkDgPGJ99DrhiwfnuVdgLjcsJmeFxTWok9tf+wxgtCbiSGpJQu
 xnkj+f+iKCmUWQZ86mYU0xmHFXtcq/vaXic4mu6EiyGvhzTHJSpaVtvAhK9dy3QniMtw
 b9QOThpp/Ao9ToYOtO6WmPO5Ywifshb70LsMIC8TzK2bIBxz3kiV3Haps05im1UxUCja
 kHccFJMzElL5ahl4H7rlbzR0Ibdv61H6YsIN0OcFh3ngXUS35qQeD1NHiqn5CslRRj1H
 yvJZBUjkMnzHJV/HNT9U+v2ag/wSa5ff7Td+TQNjF/CwGoxsQtDudhVzgYQzfsoEn2Eh Yw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wtmbubme9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 Mar 2024 13:39:47 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42CDaObk005243;
 Tue, 12 Mar 2024 13:39:47 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wtmbubmdy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 Mar 2024 13:39:46 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 42CBIO4s018189; Tue, 12 Mar 2024 13:39:46 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ws23t7j0b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 Mar 2024 13:39:46 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 42CDdh6q34013650
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 12 Mar 2024 13:39:45 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5B28D58068;
 Tue, 12 Mar 2024 13:39:43 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 982F45804B;
 Tue, 12 Mar 2024 13:39:39 +0000 (GMT)
Received: from [9.171.52.145] (unknown [9.171.52.145])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 12 Mar 2024 13:39:39 +0000 (GMT)
Message-ID: <6ab6a17b-dc2a-4d98-81f0-0e45b412516d@linux.ibm.com>
Date: Tue, 12 Mar 2024 19:09:32 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/10] ppc/pnv: Permit ibm, pa-features set per machine
 variant
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>
References: <20240312131419.2196845-1-npiggin@gmail.com>
 <20240312131419.2196845-8-npiggin@gmail.com>
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <20240312131419.2196845-8-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: i0cDuYAltb-1cmjSG5o0iocK4TcQw1yq
X-Proofpoint-GUID: 0YONbxTSIecfq1pfPLeSMdPh74kX4v57
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-12_08,2024-03-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 impostorscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999 spamscore=0
 suspectscore=0 clxscore=1015 phishscore=0 adultscore=0 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403120105
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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



On 3/12/24 18:44, Nicholas Piggin wrote:
> This allows different pa-features for powernv8/9/10.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>

> ---
>   hw/ppc/pnv.c | 41 +++++++++++++++++++++++++++++------------
>   1 file changed, 29 insertions(+), 12 deletions(-)
> 
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index aa9786e970..52d964f77a 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -133,7 +133,7 @@ static int get_cpus_node(void *fdt)
>    * device tree, used in XSCOM to address cores and in interrupt
>    * servers.
>    */
> -static void pnv_dt_core(PnvChip *chip, PnvCore *pc, void *fdt)
> +static int pnv_dt_core(PnvChip *chip, PnvCore *pc, void *fdt)
>   {
>       PowerPCCPU *cpu = pc->threads[0];
>       CPUState *cs = CPU(cpu);
> @@ -149,11 +149,6 @@ static void pnv_dt_core(PnvChip *chip, PnvCore *pc, void *fdt)
>       uint32_t cpufreq = 1000000000;
>       uint32_t page_sizes_prop[64];
>       size_t page_sizes_prop_size;
> -    const uint8_t pa_features[] = { 24, 0,
> -                                    0xf6, 0x3f, 0xc7, 0xc0, 0x00, 0xf0,
> -                                    0x80, 0x00, 0x00, 0x00, 0x00, 0x00,
> -                                    0x00, 0x00, 0x00, 0x00, 0x80, 0x00,
> -                                    0x80, 0x00, 0x80, 0x00, 0x80, 0x00 };
>       int offset;
>       char *nodename;
>       int cpus_offset = get_cpus_node(fdt);
> @@ -236,15 +231,14 @@ static void pnv_dt_core(PnvChip *chip, PnvCore *pc, void *fdt)
>                              page_sizes_prop, page_sizes_prop_size)));
>       }
>   
> -    _FDT((fdt_setprop(fdt, offset, "ibm,pa-features",
> -                       pa_features, sizeof(pa_features))));
> -
>       /* Build interrupt servers properties */
>       for (i = 0; i < smt_threads; i++) {
>           servers_prop[i] = cpu_to_be32(pc->pir + i);
>       }
>       _FDT((fdt_setprop(fdt, offset, "ibm,ppc-interrupt-server#s",
>                          servers_prop, sizeof(*servers_prop) * smt_threads)));
> +
> +    return offset;
>   }
>   
>   static void pnv_dt_icp(PnvChip *chip, void *fdt, uint32_t pir,
> @@ -299,6 +293,17 @@ PnvChip *pnv_chip_add_phb(PnvChip *chip, PnvPHB *phb)
>       return chip;
>   }
>   
> +/*
> + * Same as spapr pa_features_207 except pnv always enables CI largepages bit.
> + * HTM is always enabled because TCG does implement HTM, it's just a
> + * degenerate implementation.
> + */
> +static const uint8_t pa_features_207[] = { 24, 0,
> +                 0xf6, 0x3f, 0xc7, 0xc0, 0x00, 0xf0,
> +                 0x80, 0x00, 0x00, 0x00, 0x00, 0x00,
> +                 0x00, 0x00, 0x00, 0x00, 0x80, 0x00,
> +                 0x80, 0x00, 0x80, 0x00, 0x80, 0x00 };
> +
>   static void pnv_chip_power8_dt_populate(PnvChip *chip, void *fdt)
>   {
>       static const char compat[] = "ibm,power8-xscom\0ibm,xscom";
> @@ -311,8 +316,12 @@ static void pnv_chip_power8_dt_populate(PnvChip *chip, void *fdt)
>   
>       for (i = 0; i < chip->nr_cores; i++) {
>           PnvCore *pnv_core = chip->cores[i];
> +        int offset;
> +
> +        offset = pnv_dt_core(chip, pnv_core, fdt);
>   
> -        pnv_dt_core(chip, pnv_core, fdt);
> +        _FDT((fdt_setprop(fdt, offset, "ibm,pa-features",
> +                           pa_features_207, sizeof(pa_features_207))));
>   
>           /* Interrupt Control Presenters (ICP). One per core. */
>           pnv_dt_icp(chip, fdt, pnv_core->pir, CPU_CORE(pnv_core)->nr_threads);
> @@ -335,8 +344,12 @@ static void pnv_chip_power9_dt_populate(PnvChip *chip, void *fdt)
>   
>       for (i = 0; i < chip->nr_cores; i++) {
>           PnvCore *pnv_core = chip->cores[i];
> +        int offset;
>   
> -        pnv_dt_core(chip, pnv_core, fdt);
> +        offset = pnv_dt_core(chip, pnv_core, fdt);
> +
> +        _FDT((fdt_setprop(fdt, offset, "ibm,pa-features",
> +                           pa_features_207, sizeof(pa_features_207))));
>       }
>   
>       if (chip->ram_size) {
> @@ -358,8 +371,12 @@ static void pnv_chip_power10_dt_populate(PnvChip *chip, void *fdt)
>   
>       for (i = 0; i < chip->nr_cores; i++) {
>           PnvCore *pnv_core = chip->cores[i];
> +        int offset;
> +
> +        offset = pnv_dt_core(chip, pnv_core, fdt);
>   
> -        pnv_dt_core(chip, pnv_core, fdt);
> +        _FDT((fdt_setprop(fdt, offset, "ibm,pa-features",
> +                           pa_features_207, sizeof(pa_features_207))));
>       }
>   
>       if (chip->ram_size) {

