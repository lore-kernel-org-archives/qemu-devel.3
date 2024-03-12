Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AC94C54E66
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 09:35:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjyXK-0007YV-Ar; Tue, 12 Mar 2024 05:35:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1rjyXI-0007YJ-Rv; Tue, 12 Mar 2024 05:35:04 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1rjyXG-0004Qc-CP; Tue, 12 Mar 2024 05:35:04 -0400
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 42C7b4W1005208; Tue, 12 Mar 2024 09:34:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=FcaXYb3NgVwAPGYAqsZH+9/nCRjxqwQ0L8nu7rIboow=;
 b=copHY474Ba7KdfPagBWTyByIevtU8AJmRvNaYE4bf3DGb5kMbUtYJu2Kkos8JZ9FdV2E
 mICpgiBCGowu5cURNi8HwvUdtW9hj1d2Nl3Uy6Bavq311jMdT5vLTm/mWClM1kX8ChK1
 zunLmXYQ60hegd5r9SxdgIsrbsaqLACQhDFfS0V8wHWTIgDRcTopx3QVbZ8Wbc/VAcBT
 OrD3jsb7iiL3C0mx8+Qj3YLledBrH8nW+kJEduurkhtgjpgWH1uG6y7Fv9MFZivnZM1k
 KOQOrh6qrNCBZIP8McYsJ+3mVWbT3QT5PXwGavHuCrXG7XH6Ij9agubHI0+weHkZe1uC VQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wtjtmsj0a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 Mar 2024 09:34:55 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42C9FJ2e007421;
 Tue, 12 Mar 2024 09:34:54 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wtjtmsj02-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 Mar 2024 09:34:54 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 42C9JAse020496; Tue, 12 Mar 2024 09:34:53 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ws3kkx1q0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 Mar 2024 09:34:53 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 42C9YoPP29229466
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 12 Mar 2024 09:34:52 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8A2F958065;
 Tue, 12 Mar 2024 09:34:50 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6525D58056;
 Tue, 12 Mar 2024 09:34:48 +0000 (GMT)
Received: from [9.109.243.35] (unknown [9.109.243.35])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 12 Mar 2024 09:34:48 +0000 (GMT)
Message-ID: <297e96cb-568f-4811-b563-e999ee079b5f@linux.ibm.com>
Date: Tue, 12 Mar 2024 15:04:46 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/13] ppc/spapr: Add pa-features for POWER10 machines
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Benjamin Gray <bgray@linux.ibm.com>
References: <20240311185200.2185753-1-npiggin@gmail.com>
 <20240311185200.2185753-7-npiggin@gmail.com>
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <20240311185200.2185753-7-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 0UGd0aVg2KDfimBjm20xxQVqqP34Sn65
X-Proofpoint-GUID: X7AAnlJnLK5IYWibRPBMnVxRraPt7Zw3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-12_08,2024-03-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 spamscore=0 mlxscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0
 phishscore=0 impostorscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403120073
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



On 3/12/24 00:21, Nicholas Piggin wrote:
> From: Benjamin Gray <bgray@linux.ibm.com>
> 
> Add POWER10 pa-features entry.
> 
> Notably DEXCR and and [P]HASHST/[P]HASHCHK instruction support is

s/and and/and

> advertised. Each DEXCR aspect is allocated a bit in the device tree,
> using the 68--71 byte range (inclusive). The functionality of the
> [P]HASHST/[P]HASHCHK instructions is separately declared in byte 72,
> bit 0 (BE).
> 
> Signed-off-by: Benjamin Gray <bgray@linux.ibm.com>
> [npiggin: reword title and changelog, adjust a few bits]
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   hw/ppc/spapr.c | 34 ++++++++++++++++++++++++++++++++++
>   1 file changed, 34 insertions(+)
> 
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 247f920f07..128bfe11a8 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -265,6 +265,36 @@ static void spapr_dt_pa_features(SpaprMachineState *spapr,
>           /* 60: NM atomic, 62: RNG */
>           0x80, 0x00, 0x80, 0x00, 0x00, 0x00, /* 60 - 65 */
>       };
> +    /* 3.1 removes SAO, HTM support */
> +    uint8_t pa_features_31[] = { 74, 0,
> +        /* 0: MMU|FPU|SLB|RUN|DABR|NX, 1: fri[nzpm]|DABRX|SPRG3|SLB0|PP110 */
> +        /* 2: VPM|DS205|PPR|DS202|DS206, 3: LSD|URG, 5: LE|CFAR|EB|LSQ */
> +        0xf6, 0x1f, 0xc7, 0xc0, 0x00, 0xf0, /* 0 - 5 */
> +        /* 6: DS207 */
> +        0x80, 0x00, 0x00, 0x00, 0x00, 0x00, /* 6 - 11 */
> +        /* 16: Vector */
> +        0x00, 0x00, 0x00, 0x00, 0x80, 0x00, /* 12 - 17 */
> +        /* 18: Vec. Scalar, 20: Vec. XOR */
> +        0x80, 0x00, 0x80, 0x00, 0x00, 0x00, /* 18 - 23 */
> +        /* 24: Ext. Dec, 26: 64 bit ftrs, 28: PM ftrs */
> +        0x80, 0x00, 0x80, 0x00, 0x80, 0x00, /* 24 - 29 */
> +        /* 32: LE atomic, 34: EBB + ext EBB */
> +        0x00, 0x00, 0x80, 0x00, 0xC0, 0x00, /* 30 - 35 */
> +        /* 40: Radix MMU */
> +        0x00, 0x00, 0x00, 0x00, 0x80, 0x00, /* 36 - 41 */
> +        /* 42: PM, 44: PC RA, 46: SC vec'd */
> +        0x80, 0x00, 0x80, 0x00, 0x80, 0x00, /* 42 - 47 */
> +        /* 48: SIMD, 50: QP BFP, 52: String */
> +        0x80, 0x00, 0x80, 0x00, 0x80, 0x00, /* 48 - 53 */
> +        /* 54: DecFP, 56: DecI, 58: SHA */
> +        0x80, 0x00, 0x80, 0x00, 0x80, 0x00, /* 54 - 59 */
> +        /* 60: NM atomic, 62: RNG */
> +        0x80, 0x00, 0x80, 0x00, 0x00, 0x00, /* 60 - 65 */
> +        /* 68: DEXCR[SBHE|IBRTPDUS|SRAPD|NPHIE|PHIE] */
> +        0x00, 0x00, 0xce, 0x00, 0x00, 0x00, /* 66 - 71 */
> +        /* 72: [P]HASHCHK */

Do we want to mention [P]HASHST as well in comment above ?

> +        0x80, 0x00,                         /* 72 - 73 */
> +    };
>       uint8_t *pa_features = NULL;
>       size_t pa_size;
>   

In future, we may want to have helpers returning pointer to the
pa_features array and corresponding size conditionally based on the
required ISA support needed, instead of having local arrays bloat this
routine.

For now, with cosmetic fixes,

Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>

> @@ -280,6 +310,10 @@ static void spapr_dt_pa_features(SpaprMachineState *spapr,
>           pa_features = pa_features_300;
>           pa_size = sizeof(pa_features_300);
>       }
> +    if (ppc_check_compat(cpu, CPU_POWERPC_LOGICAL_3_10, 0, cpu->compat_pvr)) {
> +        pa_features = pa_features_31;
> +        pa_size = sizeof(pa_features_31);
> +    }
>       if (!pa_features) {
>           return;
>       }

