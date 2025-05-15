Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5280C2D0CD
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 15:36:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFad8-00053Z-0M; Thu, 15 May 2025 11:36:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1uFad6-00052X-C0; Thu, 15 May 2025 11:36:16 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1uFad3-00055U-3E; Thu, 15 May 2025 11:36:16 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54FCg4Ti004723;
 Thu, 15 May 2025 15:36:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=6nlfhN
 2OMCuAmRqea8AVec9ZG4NcyiIQsyvbwp/KjUg=; b=sBhZMY/c137CgheSY8HyKA
 kmwJhkhZr0aUTIMJT0lrvpKU/SvmGMTDvnO/aRUoubknDTs3gEwzmAmV50hdzrYm
 qkacdexVX5XIcqerh9OUBZgEy7wX1umaRsVofR8h5rnvuZVlJV+cI2djnnH6FxFt
 dz86Mcn2fQwKHHxMkMQhMsn8Mc9gEK98mSXWJXCXVf2w4aG9iA6EPMu29BifF4BQ
 UNFvWTKfnEW7WnisOLAHf+sCmUmASDrOSCj7EkO933e2r54oL+8AebQZagAOEisa
 eccc4eMT+2GSMDzEDehTYNt54SanQ8D8SV8PYgvsbuzcuKo+Clh/72KcM+cijnIg
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46navu2uap-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 15:36:09 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54FFa8Xg002218;
 Thu, 15 May 2025 15:36:08 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46navu2ua9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 15:36:08 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54FE7amN026947;
 Thu, 15 May 2025 15:36:04 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 46mbfpjykt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 15:36:04 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 54FFa3GE29950572
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 15 May 2025 15:36:03 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C2E9458061;
 Thu, 15 May 2025 15:36:03 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 73ECA58059;
 Thu, 15 May 2025 15:36:03 +0000 (GMT)
Received: from [9.10.80.143] (unknown [9.10.80.143])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 15 May 2025 15:36:03 +0000 (GMT)
Message-ID: <87922ddb-3504-4b9b-bd6a-5b4e9744395b@linux.ibm.com>
Date: Thu, 15 May 2025 10:36:02 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 40/50] ppc/xive2: implement NVP context save restore for
 POOL ring
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?=
 <fbarrat@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Caleb Schlossin <calebs@linux.vnet.ibm.com>
References: <20250512031100.439842-1-npiggin@gmail.com>
 <20250512031100.439842-41-npiggin@gmail.com>
Content-Language: en-US
From: Mike Kowal <kowal@linux.ibm.com>
In-Reply-To: <20250512031100.439842-41-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: uvVGZQaFl7DKYvwYc-EiJk0A1AQ75owE
X-Authority-Analysis: v=2.4 cv=XK4wSRhE c=1 sm=1 tr=0 ts=682609e9 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8
 a=PQitADfLxHH4esMn5eYA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: phNXFkvlKx4sGO3tMqSbvEuRTMUfD9q3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDE1NSBTYWx0ZWRfX4pdQtgE7XX1A
 PBJqEjkMU4jqf1P43dckKzE3HCSrN4rowh/ULfC3GzGR7gEQRM5VN9vsKPRgGNxj/1XJ1CY2JlY
 CsYP/oDZll7XB85Feep4cQIyWhJKdieis0SZTu5hVu9cYuKKw+kqefm6Ag1fw7CLOcxx3DakYPp
 G3NxvahbkdARondC6CsRcABd8lcS1U9ttDWybLPGVoclpsVXzSEKiQu4lFdQ6y1OgdyPD+r9fDf
 lDDverrNUhDlp7vDRveQEAgqgdtcfHzbTs0k/4qX/7SuF6eKr9dX9rAhYhzenwYzn7CcTQoU6eq
 AQRn+oCqwUdZ25r7OK4ye0o0dOyBiazUhSViDS2mZIINhBR2rLlKR9xsGkSh4v4YYPvGVgoA01N
 HezeELEWIJRQ9eSueUmwmz8nKEkAj+Y/kBFKZhoERVUFz2Xed/3x9yxB53bbek85I8r+DLoW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_06,2025-05-15_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0
 mlxscore=0 bulkscore=0 mlxlogscore=999 clxscore=1015 lowpriorityscore=0
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
> In preparation to implement POOL context push, add support for POOL
> NVP context save/restore.
>
> The NVP p bit is defined in the spec as follows:
>
>      If TRUE, the CPPR of a Pool VP in the NVP is updated during store of
>      the context with the CPPR of the Hard context it was running under.
>
> It's not clear whether non-pool VPs always or never get CPPR updated.
> Before this patch, OS contexts always save CPPR, so we will assume that
> is the behaviour.

Reviewed-by: Michael Kowal<kowal@linux.ibm.com>

Thanks,  MAK
>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   hw/intc/xive2.c             | 51 +++++++++++++++++++++++++------------
>   include/hw/ppc/xive2_regs.h |  1 +
>   2 files changed, 36 insertions(+), 16 deletions(-)
>
> diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
> index e3060810d3..d899c1fb14 100644
> --- a/hw/intc/xive2.c
> +++ b/hw/intc/xive2.c
> @@ -512,12 +512,13 @@ static void xive2_presenter_backlog_decr(XivePresenter *xptr,
>    */
>   
>   static void xive2_tctx_save_ctx(Xive2Router *xrtr, XiveTCTX *tctx,
> -                                uint8_t nvp_blk, uint32_t nvp_idx,
> -                                uint8_t ring)
> +                                uint8_t ring,
> +                                uint8_t nvp_blk, uint32_t nvp_idx)
>   {
>       CPUPPCState *env = &POWERPC_CPU(tctx->cs)->env;
>       uint32_t pir = env->spr_cb[SPR_PIR].default_value;
>       Xive2Nvp nvp;
> +    uint8_t *sig_regs = xive_tctx_signal_regs(tctx, ring);
>       uint8_t *regs = &tctx->regs[ring];
>   
>       if (xive2_router_get_nvp(xrtr, nvp_blk, nvp_idx, &nvp)) {
> @@ -553,7 +554,14 @@ static void xive2_tctx_save_ctx(Xive2Router *xrtr, XiveTCTX *tctx,
>       }
>   
>       nvp.w2 = xive_set_field32(NVP2_W2_IPB, nvp.w2, regs[TM_IPB]);
> -    nvp.w2 = xive_set_field32(NVP2_W2_CPPR, nvp.w2, regs[TM_CPPR]);
> +
> +    if ((nvp.w0 & NVP2_W0_P) || ring != TM_QW2_HV_POOL) {
> +        /*
> +         * Non-pool contexts always save CPPR (ignore p bit). XXX: Clarify
> +         * whether that is the correct behaviour.
> +         */
> +        nvp.w2 = xive_set_field32(NVP2_W2_CPPR, nvp.w2, sig_regs[TM_CPPR]);
> +    }
>       if (nvp.w0 & NVP2_W0_L) {
>           /*
>            * Typically not used. If LSMFB is restored with 0, it will
> @@ -722,7 +730,7 @@ static uint64_t xive2_tm_pull_ctx(XivePresenter *xptr, XiveTCTX *tctx,
>       }
>   
>       if (xive2_router_get_config(xrtr) & XIVE2_VP_SAVE_RESTORE && do_save) {
> -        xive2_tctx_save_ctx(xrtr, tctx, nvp_blk, nvp_idx, ring);
> +        xive2_tctx_save_ctx(xrtr, tctx, ring, nvp_blk, nvp_idx);
>       }
>   
>       /*
> @@ -863,12 +871,15 @@ void xive2_tm_pull_phys_ctx_ol(XivePresenter *xptr, XiveTCTX *tctx,
>       xive2_tm_pull_ctx_ol(xptr, tctx, offset, value, size, TM_QW3_HV_PHYS);
>   }
>   
> -static uint8_t xive2_tctx_restore_os_ctx(Xive2Router *xrtr, XiveTCTX *tctx,
> -                                        uint8_t nvp_blk, uint32_t nvp_idx,
> -                                        Xive2Nvp *nvp)
> +static uint8_t xive2_tctx_restore_ctx(Xive2Router *xrtr, XiveTCTX *tctx,
> +                                      uint8_t ring,
> +                                      uint8_t nvp_blk, uint32_t nvp_idx,
> +                                      Xive2Nvp *nvp)
>   {
>       CPUPPCState *env = &POWERPC_CPU(tctx->cs)->env;
>       uint32_t pir = env->spr_cb[SPR_PIR].default_value;
> +    uint8_t *sig_regs = xive_tctx_signal_regs(tctx, ring);
> +    uint8_t *regs = &tctx->regs[ring];
>       uint8_t cppr;
>   
>       if (!xive2_nvp_is_hw(nvp)) {
> @@ -881,10 +892,10 @@ static uint8_t xive2_tctx_restore_os_ctx(Xive2Router *xrtr, XiveTCTX *tctx,
>       nvp->w2 = xive_set_field32(NVP2_W2_CPPR, nvp->w2, 0);
>       xive2_router_write_nvp(xrtr, nvp_blk, nvp_idx, nvp, 2);
>   
> -    tctx->regs[TM_QW1_OS + TM_CPPR] = cppr;
> -    tctx->regs[TM_QW1_OS + TM_LSMFB] = xive_get_field32(NVP2_W2_LSMFB, nvp->w2);
> -    tctx->regs[TM_QW1_OS + TM_LGS] = xive_get_field32(NVP2_W2_LGS, nvp->w2);
> -    tctx->regs[TM_QW1_OS + TM_T] = xive_get_field32(NVP2_W2_T, nvp->w2);
> +    sig_regs[TM_CPPR] = cppr;
> +    regs[TM_LSMFB] = xive_get_field32(NVP2_W2_LSMFB, nvp->w2);
> +    regs[TM_LGS] = xive_get_field32(NVP2_W2_LGS, nvp->w2);
> +    regs[TM_T] = xive_get_field32(NVP2_W2_T, nvp->w2);
>   
>       nvp->w1 = xive_set_field32(NVP2_W1_CO, nvp->w1, 1);
>       nvp->w1 = xive_set_field32(NVP2_W1_CO_THRID_VALID, nvp->w1, 1);
> @@ -893,9 +904,18 @@ static uint8_t xive2_tctx_restore_os_ctx(Xive2Router *xrtr, XiveTCTX *tctx,
>       /*
>        * Checkout privilege: 0:OS, 1:Pool, 2:Hard
>        *
> -     * TODO: we only support OS push/pull
> +     * TODO: we don't support hard push/pull
>        */
> -    nvp->w1 = xive_set_field32(NVP2_W1_CO_PRIV, nvp->w1, 0);
> +    switch (ring) {
> +    case TM_QW1_OS:
> +        nvp->w1 = xive_set_field32(NVP2_W1_CO_PRIV, nvp->w1, 0);
> +        break;
> +    case TM_QW2_HV_POOL:
> +        nvp->w1 = xive_set_field32(NVP2_W1_CO_PRIV, nvp->w1, 1);
> +        break;
> +    default:
> +        g_assert_not_reached();
> +    }
>   
>       xive2_router_write_nvp(xrtr, nvp_blk, nvp_idx, nvp, 1);
>   
> @@ -930,9 +950,8 @@ static void xive2_tctx_need_resend(Xive2Router *xrtr, XiveTCTX *tctx,
>       }
>   
>       /* Automatically restore thread context registers */
> -    if (xive2_router_get_config(xrtr) & XIVE2_VP_SAVE_RESTORE &&
> -        do_restore) {
> -        xive2_tctx_restore_os_ctx(xrtr, tctx, nvp_blk, nvp_idx, &nvp);
> +    if (xive2_router_get_config(xrtr) & XIVE2_VP_SAVE_RESTORE && do_restore) {
> +        xive2_tctx_restore_ctx(xrtr, tctx, TM_QW1_OS, nvp_blk, nvp_idx, &nvp);
>       }
>   
>       ipb = xive_get_field32(NVP2_W2_IPB, nvp.w2);
> diff --git a/include/hw/ppc/xive2_regs.h b/include/hw/ppc/xive2_regs.h
> index f82054661b..2a3e60abad 100644
> --- a/include/hw/ppc/xive2_regs.h
> +++ b/include/hw/ppc/xive2_regs.h
> @@ -158,6 +158,7 @@ typedef struct Xive2Nvp {
>   #define NVP2_W0_L                  PPC_BIT32(8)
>   #define NVP2_W0_G                  PPC_BIT32(9)
>   #define NVP2_W0_T                  PPC_BIT32(10)
> +#define NVP2_W0_P                  PPC_BIT32(11)
>   #define NVP2_W0_ESC_END            PPC_BIT32(25) /* 'N' bit 0:ESB  1:END */
>   #define NVP2_W0_PGOFIRST           PPC_BITMASK32(26, 31)
>           uint32_t       w1;

