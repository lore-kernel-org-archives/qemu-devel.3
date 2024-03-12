Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD196C54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 08:42:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjxgv-0007NQ-1j; Tue, 12 Mar 2024 04:40:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1rjxgt-0007M5-UT; Tue, 12 Mar 2024 04:40:55 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1rjxgr-0004Ii-NB; Tue, 12 Mar 2024 04:40:55 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 42C8XC3N004052; Tue, 12 Mar 2024 08:40:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=cYN7bD7SjBgLDoeN94cAty9M2Fo57hUIvxL2KSueosQ=;
 b=SUW//rgbbQ8jTnbC0rsJ27H4UxH12OPvzWquiwGYUaCSsPAoNCgQ+kLU/BicHVjRohtX
 H+RdglOjhjX4vIhE0zCHKqnFq1rqnvhWiXq5wzPwg5+JdBfYXCexzh8pt95jvhiXXW3l
 pJZS1mu5doIKa3MQM9gNp/M1C6VHx9zeHcJ8PbMHnzgNyUmTgsGZrCOVqgFSOlMEHIMF
 UnD7b7+msBueGLzlCtKoZ+Ob5tM2RCzSy3PeYaof8KMdXBue0vXPZn/UNNgc0zNVOo5p
 wGeQq/GrY3xbF3RwXSLrOKYwaNYbNXSK1eb+H9xsaEHJXKV5mMToiCOPgmrY19HV0Nw+ vw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wtkmsg3bd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 Mar 2024 08:40:47 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42C8YeIK006880;
 Tue, 12 Mar 2024 08:40:46 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wtkmsg3b7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 Mar 2024 08:40:46 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 42C8KbiG018575; Tue, 12 Mar 2024 08:40:46 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ws4t1weat-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 Mar 2024 08:40:46 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 42C8ehHY42009020
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 12 Mar 2024 08:40:45 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 129F85805A;
 Tue, 12 Mar 2024 08:40:43 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3F94E58064;
 Tue, 12 Mar 2024 08:40:41 +0000 (GMT)
Received: from [9.109.243.35] (unknown [9.109.243.35])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 12 Mar 2024 08:40:40 +0000 (GMT)
Message-ID: <2a61bc32-9f6a-4b80-8b5c-d000e4743996@linux.ibm.com>
Date: Tue, 12 Mar 2024 14:10:39 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/13] ppc/spapr|pnv: Remove SAO from pa-features
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>
References: <20240311185200.2185753-1-npiggin@gmail.com>
 <20240311185200.2185753-4-npiggin@gmail.com>
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <20240311185200.2185753-4-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: tHhZ8Qf-www4turV64jl6EjYAoJ_1dSZ
X-Proofpoint-GUID: DGhgJ0VvcWFf0TRwtH2Ojdit3V9t66tt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-12_06,2024-03-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0
 spamscore=0 mlxscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2403120066
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

Hi Nick,

One cosmetic comment, in case you are doing a re-spin:

On 3/12/24 00:21, Nicholas Piggin wrote:
> SAO is a page table attribute that strengthens the memory ordering of
> accesses. QEMU with MTTCG does not implement this, so clear it in
> ibm,pa-features. This is an obscure feature that has been removed from
> POWER10 ISA v3.1, there isn't much concern with removing it.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   hw/ppc/pnv.c   |  2 +-
>   hw/ppc/spapr.c | 14 ++++++++++----
>   2 files changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index 0b47b92baa..aa9786e970 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -150,7 +150,7 @@ static void pnv_dt_core(PnvChip *chip, PnvCore *pc, void *fdt)
>       uint32_t page_sizes_prop[64];
>       size_t page_sizes_prop_size;
>       const uint8_t pa_features[] = { 24, 0,
> -                                    0xf6, 0x3f, 0xc7, 0xc0, 0x80, 0xf0,
> +                                    0xf6, 0x3f, 0xc7, 0xc0, 0x00, 0xf0,
>                                       0x80, 0x00, 0x00, 0x00, 0x00, 0x00,
>                                       0x00, 0x00, 0x00, 0x00, 0x80, 0x00,
>                                       0x80, 0x00, 0x80, 0x00, 0x80, 0x00 };
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 55263f0815..5099f12cc6 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -234,16 +234,16 @@ static void spapr_dt_pa_features(SpaprMachineState *spapr,
>                                    void *fdt, int offset)
>   {
>       uint8_t pa_features_206[] = { 6, 0,
> -        0xf6, 0x1f, 0xc7, 0x00, 0x80, 0xc0 };
> +        0xf6, 0x1f, 0xc7, 0x00, 0x00, 0xc0 };
>       uint8_t pa_features_207[] = { 24, 0,
> -        0xf6, 0x1f, 0xc7, 0xc0, 0x80, 0xf0,
> +        0xf6, 0x1f, 0xc7, 0xc0, 0x00, 0xf0,
>           0x80, 0x00, 0x00, 0x00, 0x00, 0x00,
>           0x00, 0x00, 0x00, 0x00, 0x80, 0x00,
>           0x80, 0x00, 0x80, 0x00, 0x00, 0x00 };
>       uint8_t pa_features_300[] = { 66, 0,
>           /* 0: MMU|FPU|SLB|RUN|DABR|NX, 1: fri[nzpm]|DABRX|SPRG3|SLB0|PP110 */
> -        /* 2: VPM|DS205|PPR|DS202|DS206, 3: LSD|URG, SSO, 5: LE|CFAR|EB|LSQ */
> -        0xf6, 0x1f, 0xc7, 0xc0, 0x80, 0xf0, /* 0 - 5 */
> +        /* 2: VPM|DS205|PPR|DS202|DS206, 3: LSD|URG, 5: LE|CFAR|EB|LSQ */

Do we want to mention in comments SSO (disabled), also ..

> +        0xf6, 0x1f, 0xc7, 0xc0, 0x00, 0xf0, /* 0 - 5 */
>           /* 6: DS207 */
>           0x80, 0x00, 0x00, 0x00, 0x00, 0x00, /* 6 - 11 */
>           /* 16: Vector */
> @@ -284,6 +284,12 @@ static void spapr_dt_pa_features(SpaprMachineState *spapr,
>           return;
>       }
>   
> +    /*
> +     * SSO (SAO) ordering is supported on KVM and thread=single hosts,
> +     * but not MTTCG, so disable it. To advertise it, a cap would have
> +     * to be added, or support implemented for MTTCG.
> +     */
> +

This comment could go in the beginning where we are actually disabling it.

Otherwise,

Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>


>       if (ppc_hash64_has(cpu, PPC_HASH64_CI_LARGEPAGE)) {
>           /*
>            * Note: we keep CI large pages off by default because a 64K capable

