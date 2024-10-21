Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F2B3D3C937
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 07:04:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2mSa-0006h7-MS; Mon, 21 Oct 2024 03:04:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1t2mSY-0006gu-LB; Mon, 21 Oct 2024 03:04:11 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1t2mSV-0003ZY-Us; Mon, 21 Oct 2024 03:04:10 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49L2KXfH016404;
 Mon, 21 Oct 2024 07:04:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=Yim5LG
 aBih/yGxAOn/nIEA5Tlh29C8BbJS33thSqQNY=; b=CgSDJcWirdS1tvAOlwevaS
 atOqFgvjqixtjwnyP3E2fOQzKV91EDis1qAEXB8p+GjfOlaVf54qdE4q5kNV7ZWl
 esVaLY3A64oEhdIPtt3tj36WxvX50shGM9FSh2hjfPeh3/7AoIZu3WDKM3A9VFP8
 htENsuWrzwMzFwnZI7f1+7A6x42aBRVeO7UZB9Sq+Xu3s+xtk6jA9CYRQJYDBzOu
 ngwBHG5mBNUpTfXs1SOC5Gkx1jVCEzKENZJiHU/a1snntF3r5SqxQgxXWiJLhrRM
 w5ZpXx46G3833xwhvzROcloPqgOQKK1P90vtPO0+9NeLgHNE6KAkM5Zq0B1iTf3g
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42c5h2yj6v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 21 Oct 2024 07:03:59 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49L73xgT010082;
 Mon, 21 Oct 2024 07:03:59 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42c5h2yj6t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 21 Oct 2024 07:03:59 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49L5iuBH018659;
 Mon, 21 Oct 2024 07:03:58 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 42csaj4nmg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 21 Oct 2024 07:03:58 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 49L73vgR27787806
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 21 Oct 2024 07:03:57 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DFBEB5805C;
 Mon, 21 Oct 2024 07:03:56 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 285C658051;
 Mon, 21 Oct 2024 07:03:54 +0000 (GMT)
Received: from [9.39.24.155] (unknown [9.39.24.155])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 21 Oct 2024 07:03:53 +0000 (GMT)
Message-ID: <f3f7087a-652c-44b9-9f4c-ccfb76f4f2b7@linux.ibm.com>
Date: Mon, 21 Oct 2024 12:33:52 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] spapr: nested: Add support for DPDES SPR in GSB for
 TCG L0
To: Amit Machhiwal <amachhiw@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Vaibhav Jain <vaibhav@linux.ibm.com>
Cc: David Gibson <david@gibson.dropbear.id.au>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-devel@nongnu.org
References: <20241018163849.2080847-1-amachhiw@linux.ibm.com>
Content-Language: en-US
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <20241018163849.2080847-1-amachhiw@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: hF2DrUMnHdLJ5CyncRZblzCqPgynCBBK
X-Proofpoint-ORIG-GUID: 9HhZo8GBD0uct9px7oZgAppF0jZK50wX
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 mlxlogscore=997
 adultscore=0 clxscore=1015 phishscore=0 spamscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410210047
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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



On 10/18/24 22:08, Amit Machhiwal wrote:
> The DPDES support for doorbell emulation and handling for KVM on PAPR
> guests was added in Linux via [1]. Subsequently, a new GSB (Guest State
> Buffer) element for DPDES was added in Linux; the same has been missing
> in TCG L0 implementation. Add support for DPDES register's APIv2 GSB
> element and required handling in `spapr_nested.c`.
> 
> Currently, booting a KVM guest inside a QEMU TCG guest fails with the
> following crash. The crash occurs while handling the GUEST_RUN_VCPU
> hcall made in TCG L0. In the hcall handling path, map_and_getset_state()
> calls getset_state(), which, in turn, calls guest_state_request_check()
> to validate the GSR (Guest State Request) elements. During this process,
> guest_state_request_check() iterates over the GSR elements and receives
> a NULL return code from guest_state_element_type_find() for the type
> variable corresponding to the DPDES register's elemetn ID (which was
> unknown to TCG L0). Subsequently, getset_state() returns H_P3,
> ultimately leading to the hcall failure and causing the KVM guest to
> crash.
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
> Fix this by adding the required support in TCG L0 implementation of
> APIv2.
> 
> [1] https://lore.kernel.org/all/20240605113913.83715-1-gautam@linux.ibm.com/
> 
> Fixes: 4a575f9a0567 ("spapr: nested: Initialize the GSB elements lookup table.")
> Suggested-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
> Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>

Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>

> ---
> Changes since v1:
>      - Addressed Harsh's comments on v1
>      - Updated the patch description to more precise details of the issue
>      - v1: https://lore.kernel.org/all/20241017110033.3929988-1-amachhiw@linux.ibm.com/
> 
>   hw/ppc/spapr_nested.c         | 1 +
>   include/hw/ppc/spapr_nested.h | 3 ++-
>   2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/ppc/spapr_nested.c b/hw/ppc/spapr_nested.c
> index c02785756c1e..1b41c8fb8b67 100644
> --- a/hw/ppc/spapr_nested.c
> +++ b/hw/ppc/spapr_nested.c
> @@ -982,6 +982,7 @@ struct guest_state_element_type guest_state_element_types[] = {
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

