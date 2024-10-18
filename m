Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80C53D3C549
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2024 05:18:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1fMb-00054H-Ut; Fri, 18 Oct 2024 01:17:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1t1fMa-00053m-Ex; Fri, 18 Oct 2024 01:17:24 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1t1fMX-0006SP-U8; Fri, 18 Oct 2024 01:17:24 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49HJSAvV017516;
 Fri, 18 Oct 2024 05:17:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=0FHp8t
 tCFkdSoRM8M47qWWPn1nX8WXLKtCphrTErj4M=; b=B0EPTBZk4zKwg5LRVyZWd+
 MytDr6dBvBHhnGKuWffGg9a72BkB6+0LtUh4i6dxIAEhgB2JlzN5aBntTSTzanrL
 GcZU9xAB1Ub1w6UHCQI9hIu0bswrDOQCOlG2MLTx+qDzuCMlrBCRSWo0diuxdPwM
 Ns01LpqUqAuDQH1U7Nsx+ntrWaA1a67bYrD0al3+/rLOm+cLrDRFzun/Wdv/u6is
 /qY/igGt6kFTbbT2hiK93xgfECLVirceqF/3BBoxfDHvc3dQhhdh1/P9+XPADqFk
 Vx2gRoZb3KYH1k/vnSFkYqd/uP4PZFeotfOISLxLkTmDcz6J62Vpm7uI5rowWmKQ
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42ar0u6qsg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 18 Oct 2024 05:17:15 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49I5HESh029720;
 Fri, 18 Oct 2024 05:17:14 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42ar0u6qsc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 18 Oct 2024 05:17:14 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49I4YwSs006415;
 Fri, 18 Oct 2024 05:17:14 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4284xkjgdv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 18 Oct 2024 05:17:14 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 49I5HCi651183928
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 18 Oct 2024 05:17:13 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AF2E25804E;
 Fri, 18 Oct 2024 05:17:12 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DEF435803F;
 Fri, 18 Oct 2024 05:17:09 +0000 (GMT)
Received: from [9.124.220.95] (unknown [9.124.220.95])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 18 Oct 2024 05:17:09 +0000 (GMT)
Message-ID: <07af4e02-aa2a-494c-9279-cd70389fc97e@linux.ibm.com>
Date: Fri, 18 Oct 2024 10:47:08 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spapr: nested: Add support for DPDES SPR in GSB for TCG L0
To: Amit Machhiwal <amachhiw@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Vaibhav Jain <vaibhav@linux.ibm.com>
Cc: David Gibson <david@gibson.dropbear.id.au>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-devel@nongnu.org
References: <20241017110033.3929988-1-amachhiw@linux.ibm.com>
Content-Language: en-US
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <20241017110033.3929988-1-amachhiw@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 1mve9AEtLiHPf8mLzLVxm1yuWvvcyMsn
X-Proofpoint-ORIG-GUID: niZx0BWZKniiFyII0ubBw06uW-5GIU9W
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 mlxscore=0
 spamscore=0 bulkscore=0 adultscore=0 mlxlogscore=776 phishscore=0
 suspectscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410180029
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Hi Amit,

On 10/17/24 16:30, Amit Machhiwal wrote:
> The DPDES support for doorbell emulation and handling for KVM on PAPR
> guests was added in Linux via [1]. Subsequently, a new GSB element for
> DPDES was added in Linux; the same has been missing in QEMU L0. Add

s/QEMU L0/ TCG L0 implementation?

> support for DPDES register's APIv2 GSB element and required handling in
> `spapr_nested.c`.
> 
> Currently, booting a KVM guest inside a QEMU TCG guest fails with the
> below crash. The crash is encountered when GUEST_RUN_VCPU hcall made
> into QEMU TCG L0 fails because H_INVALID_ELEMENT_VALUE is returned as
> the mapping of the element ID corresponding to DPDES (unknown to QEMU
> TCG L0) in GSR (Guest State Request) of TCG guest's KVM to the GSB
> (Guest State Buffer) elements of QEMU TCG L0 fails.

GSB full form would be more appropriate along with first mention of GSB 
in above text.

With that:
Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>

> 
>   KVM: unknown exit, hardware reason ffffffffffffffea
>   NIP 0000000000000100   LR 0000000000000000 CTR 0000000000000000 XER 0000000000000000 CPU#0
>   MSR 0000000000003000 HID0 0000000000000000  HF 6c002000 iidx 3 didx 3
>   TB 00000000 00000000 DECR 0
>   GPR00 0000000000000000 0000000000000000 0000000000000000 000000007fe00000
>   GPR04 0000000000000000 0000000000000000 0000000000000000 0000000000000000
>   GPR08 0000000000000000 0000000000000000 0000000000000000 0000000000000000
>   GPR12 0000000000000000 0000000000000000 0000000000000000 0000000000000000
>   GPR16 0000000000000000 0000000000000000 0000000000000000 0000000000000000
>   GPR20 0000000000000000 0000000000000000 0000000000000000 0000000000000000
>   GPR24 0000000000000000 0000000000000000 0000000000000000 0000000000000000
>   GPR28 0000000000000000 0000000000000000 0000000000000000 0000000000000000
>   CR 00000000  [ -  -  -  -  -  -  -  -  ]     RES 000@ffffffffffffffff
>    SRR0 0000000000000000  SRR1 0000000000000000    PVR 0000000000801200 VRSAVE 0000000000000000
>   SPRG0 0000000000000000 SPRG1 0000000000000000  SPRG2 0000000000000000  SPRG3 0000000000000000
>   SPRG4 0000000000000000 SPRG5 0000000000000000  SPRG6 0000000000000000  SPRG7 0000000000000000
>   HSRR0 0000000000000000 HSRR1 0000000000000000
>    CFAR 0000000000000000
>    LPCR 0000000000560413
>    PTCR 0000000000000000   DAR 0000000000000000  DSISR 0000000000000000
> 
> Fix this by adding the required support and handling in QEMU TCG L0.
> 
> [1] https://lore.kernel.org/all/20240605113913.83715-1-gautam@linux.ibm.com/
> 
> Fixes: 4a575f9a0567 ("spapr: nested: Initialize the GSB elements lookup table.")
> Suggested-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
> Reviewed-by: Vaibhav Jain <vaibhav@linux.ibm.com>
> Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com > ---
>   hw/ppc/spapr_nested.c         | 3 +++
>   include/hw/ppc/spapr_nested.h | 3 ++-
>   2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/ppc/spapr_nested.c b/hw/ppc/spapr_nested.c
> index c02785756c1e..b696ad537a77 100644
> --- a/hw/ppc/spapr_nested.c
> +++ b/hw/ppc/spapr_nested.c
> @@ -194,6 +194,7 @@ static void nested_save_state(struct nested_ppc_state *save, PowerPCCPU *cpu)
>           save->fscr = env->spr[SPR_FSCR];
>           save->pspb = env->spr[SPR_PSPB];
>           save->ctrl = env->spr[SPR_CTRL];
> +        save->dpdes = env->spr[SPR_DPDES];
>           save->vrsave = env->spr[SPR_VRSAVE];
>           save->dar = env->spr[SPR_DAR];
>           save->dsisr = env->spr[SPR_DSISR];
> @@ -293,6 +294,7 @@ static void nested_load_state(PowerPCCPU *cpu, struct nested_ppc_state *load)
>           env->spr[SPR_FSCR] = load->fscr;
>           env->spr[SPR_PSPB] = load->pspb;
>           env->spr[SPR_CTRL] = load->ctrl;
> +        env->spr[SPR_DPDES] = load->dpdes;
>           env->spr[SPR_VRSAVE] = load->vrsave;
>           env->spr[SPR_DAR] = load->dar;
>           env->spr[SPR_DSISR] = load->dsisr;
> @@ -982,6 +984,7 @@ struct guest_state_element_type guest_state_element_types[] = {
>       GUEST_STATE_ELEMENT_ENV_DW(GSB_VCPU_SPR_FSCR,  fscr),
>       GUEST_STATE_ELEMENT_ENV_W(GSB_VCPU_SPR_PSPB,   pspb),
>       GUEST_STATE_ELEMENT_ENV_DW(GSB_VCPU_SPR_CTRL,  ctrl),
> +    GUEST_STATE_ELEMENT_ENV_DW(GSB_VCPU_SPR_DPDES, dpdes),
>       GUEST_STATE_ELEMENT_ENV_W(GSB_VCPU_SPR_VRSAVE, vrsave),
>       GUEST_STATE_ELEMENT_ENV_DW(GSB_VCPU_SPR_DAR,   dar),
>       GUEST_STATE_ELEMENT_ENV_W(GSB_VCPU_SPR_DSISR,  dsisr),
> diff --git a/include/hw/ppc/spapr_nested.h b/include/hw/ppc/spapr_nested.h
> index 93ef14adcc5e..3b5cd993c256 100644
> --- a/include/hw/ppc/spapr_nested.h
> +++ b/include/hw/ppc/spapr_nested.h
> @@ -99,7 +99,8 @@
>   #define GSB_VCPU_SPR_HASHKEYR   0x1050
>   #define GSB_VCPU_SPR_HASHPKEYR  0x1051
>   #define GSB_VCPU_SPR_CTRL       0x1052
> -                    /* RESERVED 0x1053 - 0x1FFF */
> +#define GSB_VCPU_SPR_DPDES      0x1053
> +                    /* RESERVED 0x1054 - 0x1FFF */
>   #define GSB_VCPU_SPR_CR         0x2000
>   #define GSB_VCPU_SPR_PIDR       0x2001
>   #define GSB_VCPU_SPR_DSISR      0x2002
> 
> base-commit: aa54f5be44be786636a5d51cc1612ad208a24849

