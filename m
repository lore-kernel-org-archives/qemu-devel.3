Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18708C3DA6D
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 15:49:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFaoP-0005qF-Q3; Thu, 15 May 2025 11:47:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1uFaoK-0005Y4-3M; Thu, 15 May 2025 11:47:52 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1uFaoG-0006f6-Cc; Thu, 15 May 2025 11:47:51 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54FCg4V5004723;
 Thu, 15 May 2025 15:47:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=2nM27F
 EKKgxpmM4GaubF6IgMnV5kayVizlm851yuw5I=; b=bjfhnXj0fhexKKCZnEhSME
 BDztrfaph+1bVDWRaeZHOjxDyWEBofeQ2AS1A3fmc5PPKw+QhuVMVEPoAN7LkITg
 yTqLiP+yWHs3DAqG54yqAehRFCBSLwrgNpNouGBKEWaHF1Zx3y2nVHoKcFlLDOQO
 pAPdRA6SFSfPcTLWpUZkwtEDyecBNGADMM5R0LkCnSbnou8tSvidy8echwrCr5Zq
 M6L/k/Hoc0tpZIlUHw1po0T+SDK3wH+RU4mDE0tPPpAQsAe0Twr8MKxFmMK1GZt8
 vIw6obBavA8OXK4aDoZyZNMJy6qtdaF4NFF+/GVnhXRR/p+8x6RtelEvshgd1ufQ
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46navu2wad-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 15:47:44 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54FFiJf0023883;
 Thu, 15 May 2025 15:47:44 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46navu2wac-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 15:47:44 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54FE7apn026947;
 Thu, 15 May 2025 15:47:43 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 46mbfpk17c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 15:47:43 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 54FFlf6l18678470
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 15 May 2025 15:47:41 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 313E858061;
 Thu, 15 May 2025 15:47:41 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C174758059;
 Thu, 15 May 2025 15:47:40 +0000 (GMT)
Received: from [9.10.80.143] (unknown [9.10.80.143])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 15 May 2025 15:47:40 +0000 (GMT)
Message-ID: <958306ea-aef6-4115-a539-4cea9ec3578e@linux.ibm.com>
Date: Thu, 15 May 2025 10:47:39 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 43/50] ppc/xive: Check TIMA operations validity
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?=
 <fbarrat@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Caleb Schlossin <calebs@linux.vnet.ibm.com>
References: <20250512031100.439842-1-npiggin@gmail.com>
 <20250512031100.439842-44-npiggin@gmail.com>
Content-Language: en-US
From: Mike Kowal <kowal@linux.ibm.com>
In-Reply-To: <20250512031100.439842-44-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: q_Yd1d1jehAD7F2vvrZjA5ALP7Y5SIhx
X-Authority-Analysis: v=2.4 cv=XK4wSRhE c=1 sm=1 tr=0 ts=68260ca0 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8
 a=D3cgVjojyP8M4rMLZNYA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 6onxY_hMEOPR7RPy3noh3zy5BQetDR5v
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDE1NSBTYWx0ZWRfX+0Y09Dj3UG5j
 5GTtcyeTOuVRzJUbZTjwKCuFEgLaJsaH3+yb/e36fxzQs+pjyWxjHBScHcH7G1/yHwR0HxQIovL
 IdoNpEhceC3UQ/QPqO4WpvvvmZTnqUIkmz/LzUQ83ILzq8ckpvv6v9T6m9FMkTbkcG5onEKcWVI
 mLHtjs6vm4AbvzYbJjgmCAhdFqz+7tWvc/GmJZk8el5RPYw0o5gte1vsogWvM6Cj45gJeg6fcHZ
 XP6JalpRdXfweFeol83E2VxTGWQjXSdpjok8kET16izkZF93pi11JVwrMbimT30FRMh+ekA6YpA
 mn8dEXP1WKSjGsdXZloFtl0KCl7iCzcmeFug/fqLkN0PfZqqZLkB3/qbhGRiR8kAkesIwC4nrz6
 KblIrLO4ep/7DJb1gq0zq6s9nRHK8gMlfJx+q+iVQK4iCs4LParcBeeee3BJ6TBeyoujiNmP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_06,2025-05-15_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0
 mlxscore=0 bulkscore=0 mlxlogscore=909 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 impostorscore=0 adultscore=0
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505150155
Received-SPF: pass client-ip=148.163.156.1; envelope-from=kowal@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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


On 5/11/2025 10:10 PM, Nicholas Piggin wrote:
> Certain TIMA operations should only be performed when a ring is valid,
> others when the ring is invalid, and they are considered undefined if
> used incorrectly. Add checks for this condition.

Reviewed-by: Michael Kowal<kowal@linux.ibm.com>

Thanks,  MAK
>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   hw/intc/xive.c        | 196 +++++++++++++++++++++++++-----------------
>   include/hw/ppc/xive.h |   1 +
>   2 files changed, 116 insertions(+), 81 deletions(-)
>
> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> index aeca66e56e..d5bbd8f4c6 100644
> --- a/hw/intc/xive.c
> +++ b/hw/intc/xive.c
> @@ -25,6 +25,19 @@
>   /*
>    * XIVE Thread Interrupt Management context
>    */
> +bool xive_ring_valid(XiveTCTX *tctx, uint8_t ring)
> +{
> +    uint8_t cur_ring;
> +
> +    for (cur_ring = ring; cur_ring <= TM_QW3_HV_PHYS;
> +         cur_ring += XIVE_TM_RING_SIZE) {
> +        if (!(tctx->regs[cur_ring + TM_WORD2] & 0x80)) {
> +            return false;
> +        }
> +    }
> +    return true;
> +}
> +
>   bool xive_nsr_indicates_exception(uint8_t ring, uint8_t nsr)
>   {
>       switch (ring) {
> @@ -663,6 +676,8 @@ typedef struct XiveTmOp {
>       uint8_t  page_offset;
>       uint32_t op_offset;
>       unsigned size;
> +    bool     hw_ok;
> +    bool     sw_ok;
>       void     (*write_handler)(XivePresenter *xptr, XiveTCTX *tctx,
>                                 hwaddr offset,
>                                 uint64_t value, unsigned size);
> @@ -675,34 +690,34 @@ static const XiveTmOp xive_tm_operations[] = {
>        * MMIOs below 2K : raw values and special operations without side
>        * effects
>        */
> -    { XIVE_TM_OS_PAGE, TM_QW1_OS + TM_CPPR,       1, xive_tm_set_os_cppr,
> -                                                     NULL },
> -    { XIVE_TM_HV_PAGE, TM_QW1_OS + TM_WORD2,      4, xive_tm_push_os_ctx,
> -                                                     NULL },
> -    { XIVE_TM_HV_PAGE, TM_QW3_HV_PHYS + TM_CPPR,  1, xive_tm_set_hv_cppr,
> -                                                     NULL },
> -    { XIVE_TM_HV_PAGE, TM_QW3_HV_PHYS + TM_WORD2, 1, xive_tm_vt_push,
> -                                                     NULL },
> -    { XIVE_TM_HV_PAGE, TM_QW3_HV_PHYS + TM_WORD2, 1, NULL,
> -                                                     xive_tm_vt_poll },
> +    { XIVE_TM_OS_PAGE, TM_QW1_OS + TM_CPPR,       1, true, true,
> +      xive_tm_set_os_cppr, NULL },
> +    { XIVE_TM_HV_PAGE, TM_QW1_OS + TM_WORD2,      4, true, true,
> +      xive_tm_push_os_ctx, NULL },
> +    { XIVE_TM_HV_PAGE, TM_QW3_HV_PHYS + TM_CPPR,  1, true, true,
> +      xive_tm_set_hv_cppr, NULL },
> +    { XIVE_TM_HV_PAGE, TM_QW3_HV_PHYS + TM_WORD2, 1, false, true,
> +      xive_tm_vt_push, NULL },
> +    { XIVE_TM_HV_PAGE, TM_QW3_HV_PHYS + TM_WORD2, 1, true, true,
> +      NULL, xive_tm_vt_poll },
>   
>       /* MMIOs above 2K : special operations with side effects */
> -    { XIVE_TM_OS_PAGE, TM_SPC_ACK_OS_REG,         2, NULL,
> -                                                     xive_tm_ack_os_reg },
> -    { XIVE_TM_OS_PAGE, TM_SPC_SET_OS_PENDING,     1, xive_tm_set_os_pending,
> -                                                     NULL },
> -    { XIVE_TM_HV_PAGE, TM_SPC_PULL_OS_CTX,        4, NULL,
> -                                                     xive_tm_pull_os_ctx },
> -    { XIVE_TM_HV_PAGE, TM_SPC_PULL_OS_CTX,        8, NULL,
> -                                                     xive_tm_pull_os_ctx },
> -    { XIVE_TM_HV_PAGE, TM_SPC_ACK_HV_REG,         2, NULL,
> -                                                     xive_tm_ack_hv_reg },
> -    { XIVE_TM_HV_PAGE, TM_SPC_PULL_POOL_CTX,      4, NULL,
> -                                                     xive_tm_pull_pool_ctx },
> -    { XIVE_TM_HV_PAGE, TM_SPC_PULL_POOL_CTX,      8, NULL,
> -                                                     xive_tm_pull_pool_ctx },
> -    { XIVE_TM_HV_PAGE, TM_SPC_PULL_PHYS_CTX,      1, NULL,
> -                                                     xive_tm_pull_phys_ctx },
> +    { XIVE_TM_OS_PAGE, TM_SPC_ACK_OS_REG,         2, true, false,
> +      NULL, xive_tm_ack_os_reg },
> +    { XIVE_TM_OS_PAGE, TM_SPC_SET_OS_PENDING,     1, true, false,
> +      xive_tm_set_os_pending, NULL },
> +    { XIVE_TM_HV_PAGE, TM_SPC_PULL_OS_CTX,        4, true, false,
> +      NULL, xive_tm_pull_os_ctx },
> +    { XIVE_TM_HV_PAGE, TM_SPC_PULL_OS_CTX,        8, true, false,
> +      NULL, xive_tm_pull_os_ctx },
> +    { XIVE_TM_HV_PAGE, TM_SPC_ACK_HV_REG,         2, true, false,
> +      NULL, xive_tm_ack_hv_reg },
> +    { XIVE_TM_HV_PAGE, TM_SPC_PULL_POOL_CTX,      4, true, false,
> +      NULL, xive_tm_pull_pool_ctx },
> +    { XIVE_TM_HV_PAGE, TM_SPC_PULL_POOL_CTX,      8, true, false,
> +      NULL, xive_tm_pull_pool_ctx },
> +    { XIVE_TM_HV_PAGE, TM_SPC_PULL_PHYS_CTX,      1, true, false,
> +      NULL, xive_tm_pull_phys_ctx },
>   };
>   
>   static const XiveTmOp xive2_tm_operations[] = {
> @@ -710,52 +725,48 @@ static const XiveTmOp xive2_tm_operations[] = {
>        * MMIOs below 2K : raw values and special operations without side
>        * effects
>        */
> -    { XIVE_TM_OS_PAGE, TM_QW1_OS + TM_CPPR,       1, xive2_tm_set_os_cppr,
> -                                                     NULL },
> -    { XIVE_TM_HV_PAGE, TM_QW1_OS + TM_WORD2,      4, xive2_tm_push_os_ctx,
> -                                                     NULL },
> -    { XIVE_TM_HV_PAGE, TM_QW1_OS + TM_WORD2,      8, xive2_tm_push_os_ctx,
> -                                                     NULL },
> -    { XIVE_TM_OS_PAGE, TM_QW1_OS + TM_LGS,        1, xive_tm_set_os_lgs,
> -                                                     NULL },
> -    { XIVE_TM_HV_PAGE, TM_QW3_HV_PHYS + TM_CPPR,  1, xive2_tm_set_hv_cppr,
> -                                                     NULL },
> -    { XIVE_TM_HV_PAGE, TM_QW3_HV_PHYS + TM_WORD2, 1, xive_tm_vt_push,
> -                                                     NULL },
> -    { XIVE_TM_HV_PAGE, TM_QW3_HV_PHYS + TM_WORD2, 1, NULL,
> -                                                     xive_tm_vt_poll },
> -    { XIVE_TM_HV_PAGE, TM_QW3_HV_PHYS + TM_T,     1, xive2_tm_set_hv_target,
> -                                                     NULL },
> +    { XIVE_TM_OS_PAGE, TM_QW1_OS + TM_CPPR,       1, true, true,
> +      xive2_tm_set_os_cppr, NULL },
> +    { XIVE_TM_HV_PAGE, TM_QW1_OS + TM_WORD2,      4, true, true,
> +      xive2_tm_push_os_ctx, NULL },
> +    { XIVE_TM_HV_PAGE, TM_QW1_OS + TM_WORD2,      8, true, true,
> +      xive2_tm_push_os_ctx, NULL },
> +    { XIVE_TM_OS_PAGE, TM_QW1_OS + TM_LGS,        1, true, true,
> +      xive_tm_set_os_lgs, NULL },
> +    { XIVE_TM_HV_PAGE, TM_QW3_HV_PHYS + TM_CPPR,  1, true, true,
> +      xive2_tm_set_hv_cppr, NULL },
> +    { XIVE_TM_HV_PAGE, TM_QW3_HV_PHYS + TM_WORD2, 1, true, true,
> +      NULL, xive_tm_vt_poll },
> +    { XIVE_TM_HV_PAGE, TM_QW3_HV_PHYS + TM_T,     1, true, true,
> +      xive2_tm_set_hv_target, NULL },
>   
>       /* MMIOs above 2K : special operations with side effects */
> -    { XIVE_TM_OS_PAGE, TM_SPC_ACK_OS_REG,         2, NULL,
> -                                                   xive_tm_ack_os_reg },
> -    { XIVE_TM_OS_PAGE, TM_SPC_SET_OS_PENDING,     1, xive_tm_set_os_pending,
> -                                                     NULL },
> -    { XIVE_TM_HV_PAGE, TM_SPC_PULL_OS_CTX_G2,     4, NULL,
> -                                                     xive2_tm_pull_os_ctx },
> -    { XIVE_TM_HV_PAGE, TM_SPC_PULL_OS_CTX,        4, NULL,
> -                                                     xive2_tm_pull_os_ctx },
> -    { XIVE_TM_HV_PAGE, TM_SPC_PULL_OS_CTX,        8, NULL,
> -                                                     xive2_tm_pull_os_ctx },
> -    { XIVE_TM_HV_PAGE, TM_SPC_ACK_HV_REG,         2, NULL,
> -                                                     xive_tm_ack_hv_reg },
> -    { XIVE_TM_HV_PAGE, TM_SPC_PULL_POOL_CTX_G2,   4, NULL,
> -                                                     xive2_tm_pull_pool_ctx },
> -    { XIVE_TM_HV_PAGE, TM_SPC_PULL_POOL_CTX,      4, NULL,
> -                                                     xive2_tm_pull_pool_ctx },
> -    { XIVE_TM_HV_PAGE, TM_SPC_PULL_POOL_CTX,      8, NULL,
> -                                                     xive2_tm_pull_pool_ctx },
> -    { XIVE_TM_HV_PAGE, TM_SPC_PULL_OS_CTX_OL,     1, xive2_tm_pull_os_ctx_ol,
> -                                                     NULL },
> -    { XIVE_TM_HV_PAGE, TM_SPC_PULL_PHYS_CTX_G2,   4, NULL,
> -                                                     xive2_tm_pull_phys_ctx },
> -    { XIVE_TM_HV_PAGE, TM_SPC_PULL_PHYS_CTX,      1, NULL,
> -                                                     xive2_tm_pull_phys_ctx },
> -    { XIVE_TM_HV_PAGE, TM_SPC_PULL_PHYS_CTX_OL,   1, xive2_tm_pull_phys_ctx_ol,
> -                                                     NULL },
> -    { XIVE_TM_OS_PAGE, TM_SPC_ACK_OS_EL,          1, xive2_tm_ack_os_el,
> -                                                     NULL },
> +    { XIVE_TM_OS_PAGE, TM_SPC_ACK_OS_REG,         2, true, false,
> +      NULL, xive_tm_ack_os_reg },
> +    { XIVE_TM_HV_PAGE, TM_SPC_PULL_OS_CTX_G2,     4, true, false,
> +      NULL, xive2_tm_pull_os_ctx },
> +    { XIVE_TM_HV_PAGE, TM_SPC_PULL_OS_CTX,        4, true, false,
> +      NULL, xive2_tm_pull_os_ctx },
> +    { XIVE_TM_HV_PAGE, TM_SPC_PULL_OS_CTX,        8, true, false,
> +      NULL, xive2_tm_pull_os_ctx },
> +    { XIVE_TM_HV_PAGE, TM_SPC_ACK_HV_REG,         2, true, false,
> +      NULL, xive_tm_ack_hv_reg },
> +    { XIVE_TM_HV_PAGE, TM_SPC_PULL_POOL_CTX_G2,   4, true, false,
> +      NULL, xive2_tm_pull_pool_ctx },
> +    { XIVE_TM_HV_PAGE, TM_SPC_PULL_POOL_CTX,      4, true, false,
> +      NULL, xive2_tm_pull_pool_ctx },
> +    { XIVE_TM_HV_PAGE, TM_SPC_PULL_POOL_CTX,      8, true, false,
> +      NULL, xive2_tm_pull_pool_ctx },
> +    { XIVE_TM_HV_PAGE, TM_SPC_PULL_OS_CTX_OL,     1, true, false,
> +      xive2_tm_pull_os_ctx_ol, NULL },
> +    { XIVE_TM_HV_PAGE, TM_SPC_PULL_PHYS_CTX_G2,   4, true, false,
> +      NULL, xive2_tm_pull_phys_ctx },
> +    { XIVE_TM_HV_PAGE, TM_SPC_PULL_PHYS_CTX,      1, true, false,
> +      NULL, xive2_tm_pull_phys_ctx },
> +    { XIVE_TM_HV_PAGE, TM_SPC_PULL_PHYS_CTX_OL,   1, true, false,
> +      xive2_tm_pull_phys_ctx_ol, NULL },
> +    { XIVE_TM_OS_PAGE, TM_SPC_ACK_OS_EL,          1, true, false,
> +      xive2_tm_ack_os_el, NULL },
>   };
>   
>   static const XiveTmOp *xive_tm_find_op(XivePresenter *xptr, hwaddr offset,
> @@ -797,18 +808,28 @@ void xive_tctx_tm_write(XivePresenter *xptr, XiveTCTX *tctx, hwaddr offset,
>                           uint64_t value, unsigned size)
>   {
>       const XiveTmOp *xto;
> +    uint8_t ring = offset & TM_RING_OFFSET;
> +    bool is_valid = xive_ring_valid(tctx, ring);
> +    bool hw_owned = is_valid;
>   
>       trace_xive_tctx_tm_write(tctx->cs->cpu_index, offset, size, value);
>   
> -    /*
> -     * TODO: check V bit in Q[0-3]W2
> -     */
> -
>       /*
>        * First, check for special operations in the 2K region
>        */
> +    xto = xive_tm_find_op(tctx->xptr, offset, size, true);
> +    if (xto) {
> +        if (hw_owned && !xto->hw_ok) {
> +            qemu_log_mask(LOG_GUEST_ERROR, "XIVE: undefined write to HW TIMA "
> +                          "@%"HWADDR_PRIx" size %d\n", offset, size);
> +        }
> +        if (!hw_owned && !xto->sw_ok) {
> +            qemu_log_mask(LOG_GUEST_ERROR, "XIVE: undefined write to SW TIMA "
> +                          "@%"HWADDR_PRIx" size %d\n", offset, size);
> +        }
> +    }
> +
>       if (offset & TM_SPECIAL_OP) {
> -        xto = xive_tm_find_op(tctx->xptr, offset, size, true);
>           if (!xto) {
>               qemu_log_mask(LOG_GUEST_ERROR, "XIVE: invalid write access at TIMA "
>                             "@%"HWADDR_PRIx" size %d\n", offset, size);
> @@ -821,7 +842,6 @@ void xive_tctx_tm_write(XivePresenter *xptr, XiveTCTX *tctx, hwaddr offset,
>       /*
>        * Then, for special operations in the region below 2K.
>        */
> -    xto = xive_tm_find_op(tctx->xptr, offset, size, true);
>       if (xto) {
>           xto->write_handler(xptr, tctx, offset, value, size);
>           return;
> @@ -830,6 +850,11 @@ void xive_tctx_tm_write(XivePresenter *xptr, XiveTCTX *tctx, hwaddr offset,
>       /*
>        * Finish with raw access to the register values
>        */
> +    if (hw_owned) {
> +        /* Store context operations are dangerous when context is valid */
> +        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: undefined write to HW TIMA "
> +                      "@%"HWADDR_PRIx" size %d\n", offset, size);
> +    }
>       xive_tm_raw_write(tctx, offset, value, size);
>   }
>   
> @@ -837,17 +862,27 @@ uint64_t xive_tctx_tm_read(XivePresenter *xptr, XiveTCTX *tctx, hwaddr offset,
>                              unsigned size)
>   {
>       const XiveTmOp *xto;
> +    uint8_t ring = offset & TM_RING_OFFSET;
> +    bool is_valid = xive_ring_valid(tctx, ring);
> +    bool hw_owned = is_valid;
>       uint64_t ret;
>   
> -    /*
> -     * TODO: check V bit in Q[0-3]W2
> -     */
> +    xto = xive_tm_find_op(tctx->xptr, offset, size, false);
> +    if (xto) {
> +        if (hw_owned && !xto->hw_ok) {
> +            qemu_log_mask(LOG_GUEST_ERROR, "XIVE: undefined read to HW TIMA "
> +                          "@%"HWADDR_PRIx" size %d\n", offset, size);
> +        }
> +        if (!hw_owned && !xto->sw_ok) {
> +            qemu_log_mask(LOG_GUEST_ERROR, "XIVE: undefined read to SW TIMA "
> +                          "@%"HWADDR_PRIx" size %d\n", offset, size);
> +        }
> +    }
>   
>       /*
>        * First, check for special operations in the 2K region
>        */
>       if (offset & TM_SPECIAL_OP) {
> -        xto = xive_tm_find_op(tctx->xptr, offset, size, false);
>           if (!xto) {
>               qemu_log_mask(LOG_GUEST_ERROR, "XIVE: invalid read access to TIMA"
>                             "@%"HWADDR_PRIx" size %d\n", offset, size);
> @@ -860,7 +895,6 @@ uint64_t xive_tctx_tm_read(XivePresenter *xptr, XiveTCTX *tctx, hwaddr offset,
>       /*
>        * Then, for special operations in the region below 2K.
>        */
> -    xto = xive_tm_find_op(tctx->xptr, offset, size, false);
>       if (xto) {
>           ret = xto->read_handler(xptr, tctx, offset, size);
>           goto out;
> diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
> index 2372d1014b..b7ca8544e4 100644
> --- a/include/hw/ppc/xive.h
> +++ b/include/hw/ppc/xive.h
> @@ -365,6 +365,7 @@ static inline uint32_t xive_tctx_word2(uint8_t *ring)
>       return *((uint32_t *) &ring[TM_WORD2]);
>   }
>   
> +bool xive_ring_valid(XiveTCTX *tctx, uint8_t ring);
>   bool xive_nsr_indicates_exception(uint8_t ring, uint8_t nsr);
>   bool xive_nsr_indicates_group_exception(uint8_t ring, uint8_t nsr);
>   uint8_t xive_nsr_exception_ring(uint8_t ring, uint8_t nsr);

