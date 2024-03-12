Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CC13C54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 13:45:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk2Qn-0005Lz-Ve; Tue, 12 Mar 2024 09:44:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1rk2Qm-0005LP-7d; Tue, 12 Mar 2024 09:44:36 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1rk2Qk-00043K-2n; Tue, 12 Mar 2024 09:44:35 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 42CCrd7s027685; Tue, 12 Mar 2024 13:44:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=m8SETuk1g63VUQthJSO2KGz++TU9Zxekdx4+pmFqemA=;
 b=CEe+vJjLF1Hs0ebUGWZSmoSOEulH++XSn2vT/YTWG0pLbqrPGhm3FAljiZuv/1Ytx80K
 mdDbyqaug783WjqfsGObOmYkph6Twb9knlKhGAy3/6Go4B2YEJK6WTQfq0vUnrX8OYIL
 hmYvP2mqxxXSNS0xBjGZg792qgd52svUvJfzyCT94ePNp/Lu8azJolgZ8sNlJ5KVyrKF
 /eCfHCBNdirbqp1119hFLTAd7U0CKjxspv6tei3KhUGjnVjMbMwiuz+vaiE2LZG6q5S/
 WAmljHCouet/q/ux12ceJ2UX+b/1o2WVBR3ncoV4JQcG++9Yp14SzpZiH+oLseb2jgJb QA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wtqesryyq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 Mar 2024 13:44:29 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42CDI0Hd029686;
 Tue, 12 Mar 2024 13:44:28 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wtqesryyf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 Mar 2024 13:44:28 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 42CBGZPv018143; Tue, 12 Mar 2024 13:44:27 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ws23t7jmw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 Mar 2024 13:44:27 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 42CDiP9v48365958
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 12 Mar 2024 13:44:27 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C64945806D;
 Tue, 12 Mar 2024 13:44:23 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B077258055;
 Tue, 12 Mar 2024 13:44:19 +0000 (GMT)
Received: from [9.171.52.145] (unknown [9.171.52.145])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 12 Mar 2024 13:44:19 +0000 (GMT)
Message-ID: <b6d04ed3-efc7-4882-8bf7-e0829a07b3ce@linux.ibm.com>
Date: Tue, 12 Mar 2024 19:14:17 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/10] ppc/pnv: Set POWER9, POWER10 ibm,pa-features bits
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>
References: <20240312131419.2196845-1-npiggin@gmail.com>
 <20240312131419.2196845-9-npiggin@gmail.com>
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <20240312131419.2196845-9-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: nX-hbUb7S1X7d32q65L4KCrTcojDOvCY
X-Proofpoint-GUID: oGqrPkuE8EAPESAP9laQB-M0y652xxj9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-12_08,2024-03-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 bulkscore=0 spamscore=0 phishscore=0 adultscore=0 mlxlogscore=999
 priorityscore=1501 malwarescore=0 impostorscore=0 clxscore=1015 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403120105
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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
> Copy the pa-features arrays from spapr, adjusting slightly as
> described in comments.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Although future re-org is expected per discussion on v1, but for now:

Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>

> ---
>   hw/ppc/pnv.c   | 67 ++++++++++++++++++++++++++++++++++++++++++++++++--
>   hw/ppc/spapr.c |  1 +
>   2 files changed, 66 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index 52d964f77a..8a502dea90 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -332,6 +332,35 @@ static void pnv_chip_power8_dt_populate(PnvChip *chip, void *fdt)
>       }
>   }
>   
> +/*
> + * Same as spapr pa_features_300 except pnv always enables CI largepages bit.
> + */
> +static const uint8_t pa_features_300[] = { 66, 0,
> +    /* 0: MMU|FPU|SLB|RUN|DABR|NX, 1: CILRG|fri[nzpm]|DABRX|SPRG3|SLB0|PP110 */
> +    /* 2: VPM|DS205|PPR|DS202|DS206, 3: LSD|URG, 5: LE|CFAR|EB|LSQ */
> +    0xf6, 0x3f, 0xc7, 0xc0, 0x00, 0xf0, /* 0 - 5 */
> +    /* 6: DS207 */
> +    0x80, 0x00, 0x00, 0x00, 0x00, 0x00, /* 6 - 11 */
> +    /* 16: Vector */
> +    0x00, 0x00, 0x00, 0x00, 0x80, 0x00, /* 12 - 17 */
> +    /* 18: Vec. Scalar, 20: Vec. XOR, 22: HTM */
> +    0x80, 0x00, 0x80, 0x00, 0x80, 0x00, /* 18 - 23 */
> +    /* 24: Ext. Dec, 26: 64 bit ftrs, 28: PM ftrs */
> +    0x80, 0x00, 0x80, 0x00, 0x80, 0x00, /* 24 - 29 */
> +    /* 32: LE atomic, 34: EBB + ext EBB */
> +    0x00, 0x00, 0x80, 0x00, 0xC0, 0x00, /* 30 - 35 */
> +    /* 40: Radix MMU */
> +    0x00, 0x00, 0x00, 0x00, 0x80, 0x00, /* 36 - 41 */
> +    /* 42: PM, 44: PC RA, 46: SC vec'd */
> +    0x80, 0x00, 0x80, 0x00, 0x80, 0x00, /* 42 - 47 */
> +    /* 48: SIMD, 50: QP BFP, 52: String */
> +    0x80, 0x00, 0x80, 0x00, 0x80, 0x00, /* 48 - 53 */
> +    /* 54: DecFP, 56: DecI, 58: SHA */
> +    0x80, 0x00, 0x80, 0x00, 0x80, 0x00, /* 54 - 59 */
> +    /* 60: NM atomic, 62: RNG */
> +    0x80, 0x00, 0x80, 0x00, 0x00, 0x00, /* 60 - 65 */
> +};
> +
>   static void pnv_chip_power9_dt_populate(PnvChip *chip, void *fdt)
>   {
>       static const char compat[] = "ibm,power9-xscom\0ibm,xscom";
> @@ -349,7 +378,7 @@ static void pnv_chip_power9_dt_populate(PnvChip *chip, void *fdt)
>           offset = pnv_dt_core(chip, pnv_core, fdt);
>   
>           _FDT((fdt_setprop(fdt, offset, "ibm,pa-features",
> -                           pa_features_207, sizeof(pa_features_207))));
> +                           pa_features_300, sizeof(pa_features_300))));
>       }
>   
>       if (chip->ram_size) {
> @@ -359,6 +388,40 @@ static void pnv_chip_power9_dt_populate(PnvChip *chip, void *fdt)
>       pnv_dt_lpc(chip, fdt, 0, PNV9_LPCM_BASE(chip), PNV9_LPCM_SIZE);
>   }
>   
> +/*
> + * Same as spapr pa_features_31 except pnv always enables CI largepages bit,
> + * always disables copy/paste.
> + */
> +static const uint8_t pa_features_31[] = { 74, 0,
> +    /* 0: MMU|FPU|SLB|RUN|DABR|NX, 1: CILRG|fri[nzpm]|DABRX|SPRG3|SLB0|PP110 */
> +    /* 2: VPM|DS205|PPR|DS202|DS206, 3: LSD|URG, 5: LE|CFAR|EB|LSQ */
> +    0xf6, 0x3f, 0xc7, 0xc0, 0x00, 0xf0, /* 0 - 5 */
> +    /* 6: DS207 */
> +    0x80, 0x00, 0x00, 0x00, 0x00, 0x00, /* 6 - 11 */
> +    /* 16: Vector */
> +    0x00, 0x00, 0x00, 0x00, 0x80, 0x00, /* 12 - 17 */
> +    /* 18: Vec. Scalar, 20: Vec. XOR */
> +    0x80, 0x00, 0x80, 0x00, 0x00, 0x00, /* 18 - 23 */
> +    /* 24: Ext. Dec, 26: 64 bit ftrs, 28: PM ftrs */
> +    0x80, 0x00, 0x80, 0x00, 0x80, 0x00, /* 24 - 29 */
> +    /* 32: LE atomic, 34: EBB + ext EBB */
> +    0x00, 0x00, 0x80, 0x00, 0xC0, 0x00, /* 30 - 35 */
> +    /* 40: Radix MMU */
> +    0x00, 0x00, 0x00, 0x00, 0x80, 0x00, /* 36 - 41 */
> +    /* 42: PM, 44: PC RA, 46: SC vec'd */
> +    0x80, 0x00, 0x80, 0x00, 0x80, 0x00, /* 42 - 47 */
> +    /* 48: SIMD, 50: QP BFP, 52: String */
> +    0x80, 0x00, 0x80, 0x00, 0x80, 0x00, /* 48 - 53 */
> +    /* 54: DecFP, 56: DecI, 58: SHA */
> +    0x80, 0x00, 0x80, 0x00, 0x80, 0x00, /* 54 - 59 */
> +    /* 60: NM atomic, 62: RNG */
> +    0x80, 0x00, 0x80, 0x00, 0x00, 0x00, /* 60 - 65 */
> +    /* 68: DEXCR[SBHE|IBRTPDUS|SRAPD|NPHIE|PHIE] */
> +    0x00, 0x00, 0xce, 0x00, 0x00, 0x00, /* 66 - 71 */
> +    /* 72: [P]HASHST/[P]HASHCHK */
> +    0x80, 0x00,                         /* 72 - 73 */
> +};
> +
>   static void pnv_chip_power10_dt_populate(PnvChip *chip, void *fdt)
>   {
>       static const char compat[] = "ibm,power10-xscom\0ibm,xscom";
> @@ -376,7 +439,7 @@ static void pnv_chip_power10_dt_populate(PnvChip *chip, void *fdt)
>           offset = pnv_dt_core(chip, pnv_core, fdt);
>   
>           _FDT((fdt_setprop(fdt, offset, "ibm,pa-features",
> -                           pa_features_207, sizeof(pa_features_207))));
> +                           pa_features_31, sizeof(pa_features_31))));
>       }
>   
>       if (chip->ram_size) {
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index a684e0d9dc..abd484023a 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -243,6 +243,7 @@ static void spapr_dt_pa_features(SpaprMachineState *spapr,
>        * so there isn't much need for it anyway.
>        */
>   
> +    /* These should be kept in sync with pnv */
>       uint8_t pa_features_206[] = { 6, 0,
>           0xf6, 0x1f, 0xc7, 0x00, 0x00, 0xc0 };
>       uint8_t pa_features_207[] = { 24, 0,

