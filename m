Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BB4BC3ABDA
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 19:49:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFI5y-0002S9-GL; Wed, 14 May 2025 15:48:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1uFI5P-0001P5-AU; Wed, 14 May 2025 15:48:16 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1uFI5N-00016P-7Z; Wed, 14 May 2025 15:48:14 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54EItE1J014637;
 Wed, 14 May 2025 19:48:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=pBSulu
 kKZ4pcqYI8zOqM7bb8esmTiXH+Mlw3wlRdRCk=; b=HUfU+3/hv6YpWg/m0vOfYx
 F073ErisEcrdJM3pTgwbOucPuq1rXZ5OMppof7//1eErwMAuj9I/LeOTcE1MrPZi
 UIybiJRjMum5xcqunFZXWolk9Htzgkhenu3YG/X2hE37rQ6w1o4NWau6J6Goinp4
 /NTgJ5w3Vb4/tZNKwl75+dzFcDsb9RHxCgfji7qEqiW0T2XeR/8BHJBZp+hTVuP6
 szWbdaa9TM0wQd0u2BUUZZbf0KzLzqZnq/XF6JcyOnU6aKjapSB2QNcPgOKnsImi
 ZkyFtt7wDRwjl5DAUvSs3AtcqP/KsYQY6vRLRhTJpoKE4jvmHJFBXzBkFv9Y/1DA
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46n0v6g9mp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 May 2025 19:48:07 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54EJeM7i020966;
 Wed, 14 May 2025 19:48:07 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46n0v6g9mn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 May 2025 19:48:07 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54EGgcin026911;
 Wed, 14 May 2025 19:48:06 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 46mbfpe5y1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 May 2025 19:48:06 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 54EJm4Pd24183070
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 14 May 2025 19:48:04 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 93C3B5804E;
 Wed, 14 May 2025 19:48:04 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 154AA58055;
 Wed, 14 May 2025 19:48:04 +0000 (GMT)
Received: from [9.10.80.143] (unknown [9.10.80.143])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 14 May 2025 19:48:03 +0000 (GMT)
Message-ID: <216b782e-d90f-435e-8111-422288da6864@linux.ibm.com>
Date: Wed, 14 May 2025 14:48:03 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 25/50] ppc/xive2: Implement "Ack OS IRQ to even report
 line" TIMA op
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?=
 <fbarrat@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Caleb Schlossin <calebs@linux.vnet.ibm.com>
References: <20250512031100.439842-1-npiggin@gmail.com>
 <20250512031100.439842-26-npiggin@gmail.com>
Content-Language: en-US
From: Mike Kowal <kowal@linux.ibm.com>
In-Reply-To: <20250512031100.439842-26-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=IqAecK/g c=1 sm=1 tr=0 ts=6824f377 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=o8TdU-I3RdqAkSISKskA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: -q2RyWiOALCrmP8zfjJ5wPgQJ71NGQQD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE0MDE4MCBTYWx0ZWRfX6EALJtVvQVas
 uTUHkOW+I9uLlDk3in2XzllKlftpdJwFhqhNcE6LfG0jykH8Hc2Pqxeye/1OxGTTuJIe/XU08mG
 vgvQIgCP0Folce2qc8ao+T/tp6W1w3y/gyDiN+0xOlbK7Yin1Wz7DEu123pcb2Jj16efT5O76mu
 ag43CP4PrsdxBp/cHd7v+ML48foMSEjmLrRnPiWR1bUYB2eKgow+Y5/47phW+lhfEqSUgg+kQBu
 0aNpfwYpcj782l+VOLmg4k+Uzyw2OdRhxHbvvYmokq8g3aEeuJtCNmbcb6huoFc3cNYyC8Zrj8p
 OQTNmp+irb02sGc5hDRDkhMJ8TElSZRCaWeFCXP5utU4nG7drZLqV/JOJCfhNUgvD2uUlx2jUiz
 fhu1uj5PR2cEssoo9pYv6OOr7vLXT6vzdCSZFMNjGAuRI3eywuloKYqoDnNyl6vLHOvcRjIV
X-Proofpoint-GUID: InW5hARvU8w3t3Hw8gTvAAxcQjSouRdm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-14_04,2025-05-14_03,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 malwarescore=0
 adultscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0
 priorityscore=1501 clxscore=1015 spamscore=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505140180
Received-SPF: pass client-ip=148.163.158.5; envelope-from=kowal@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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
> From: Glenn Miles <milesg@linux.ibm.com>
>
> Booting AIX in a PowerVM partition requires the use of the "Acknowledge
> O/S Interrupt to even O/S reporting line" special operation provided by
> the IBM XIVE interrupt controller. This operation is invoked by writing
> a byte (data is irrelevant) to offset 0xC10 of the Thread Interrupt
> Management Area (TIMA). It can be used by software to notify the XIVE
> logic that the interrupt was received.

Reviewed-by: Michael Kowal<kowal@linux.ibm.com>

Thanks,  MAK

>
> Signed-off-by: Glenn Miles <milesg@linux.ibm.com>
> ---
>   hw/intc/xive.c         |  8 ++++---
>   hw/intc/xive2.c        | 50 ++++++++++++++++++++++++++++++++++++++++++
>   include/hw/ppc/xive.h  |  1 +
>   include/hw/ppc/xive2.h |  3 ++-
>   4 files changed, 58 insertions(+), 4 deletions(-)
>
> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> index 7461dbecb8..9ec1193dfc 100644
> --- a/hw/intc/xive.c
> +++ b/hw/intc/xive.c
> @@ -80,7 +80,7 @@ static qemu_irq xive_tctx_output(XiveTCTX *tctx, uint8_t ring)
>           }
>   }
>   
> -static uint64_t xive_tctx_accept(XiveTCTX *tctx, uint8_t ring)
> +uint64_t xive_tctx_accept(XiveTCTX *tctx, uint8_t ring)
>   {
>       uint8_t *regs = &tctx->regs[ring];
>       uint8_t nsr = regs[TM_NSR];
> @@ -340,14 +340,14 @@ static uint64_t xive_tm_vt_poll(XivePresenter *xptr, XiveTCTX *tctx,
>   
>   static const uint8_t xive_tm_hw_view[] = {
>       3, 0, 0, 0,   0, 0, 0, 0,   3, 3, 3, 3,   0, 0, 0, 0, /* QW-0 User */
> -    3, 3, 3, 3,   3, 3, 0, 2,   3, 3, 3, 3,   0, 0, 0, 0, /* QW-1 OS   */
> +    3, 3, 3, 3,   3, 3, 0, 2,   3, 3, 3, 3,   0, 0, 0, 3, /* QW-1 OS   */
>       0, 0, 3, 3,   0, 3, 3, 0,   3, 3, 3, 3,   0, 0, 0, 0, /* QW-2 POOL */
>       3, 3, 3, 3,   0, 3, 0, 2,   3, 0, 0, 3,   3, 3, 3, 0, /* QW-3 PHYS */
>   };
>   
>   static const uint8_t xive_tm_hv_view[] = {
>       3, 0, 0, 0,   0, 0, 0, 0,   3, 3, 3, 3,   0, 0, 0, 0, /* QW-0 User */
> -    3, 3, 3, 3,   3, 3, 0, 2,   3, 3, 3, 3,   0, 0, 0, 0, /* QW-1 OS   */
> +    3, 3, 3, 3,   3, 3, 0, 2,   3, 3, 3, 3,   0, 0, 0, 3, /* QW-1 OS   */
>       0, 0, 3, 3,   0, 3, 3, 0,   0, 3, 3, 3,   0, 0, 0, 0, /* QW-2 POOL */
>       3, 3, 3, 3,   0, 3, 0, 2,   3, 0, 0, 3,   0, 0, 0, 0, /* QW-3 PHYS */
>   };
> @@ -718,6 +718,8 @@ static const XiveTmOp xive2_tm_operations[] = {
>                                                        xive_tm_pull_phys_ctx },
>       { XIVE_TM_HV_PAGE, TM_SPC_PULL_PHYS_CTX_OL,   1, xive2_tm_pull_phys_ctx_ol,
>                                                        NULL },
> +    { XIVE_TM_OS_PAGE, TM_SPC_ACK_OS_EL,          1, xive2_tm_ack_os_el,
> +                                                     NULL },
>   };
>   
>   static const XiveTmOp *xive_tm_find_op(XivePresenter *xptr, hwaddr offset,
> diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
> index ec4b9320b4..68be138335 100644
> --- a/hw/intc/xive2.c
> +++ b/hw/intc/xive2.c
> @@ -1009,6 +1009,56 @@ static int xive2_tctx_get_nvp_indexes(XiveTCTX *tctx, uint8_t ring,
>       return 0;
>   }
>   
> +static void xive2_tctx_accept_el(XivePresenter *xptr, XiveTCTX *tctx,
> +                                 uint8_t ring, uint8_t cl_ring)
> +{
> +    uint64_t rd;
> +    Xive2Router *xrtr = XIVE2_ROUTER(xptr);
> +    uint32_t nvp_blk, nvp_idx, xive2_cfg;
> +    Xive2Nvp nvp;
> +    uint64_t phys_addr;
> +    uint8_t OGen = 0;
> +
> +    xive2_tctx_get_nvp_indexes(tctx, cl_ring, &nvp_blk, &nvp_idx);
> +
> +    if (xive2_router_get_nvp(xrtr, (uint8_t)nvp_blk, nvp_idx, &nvp)) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: No NVP %x/%x\n",
> +                      nvp_blk, nvp_idx);
> +        return;
> +    }
> +
> +    if (!xive2_nvp_is_valid(&nvp)) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: invalid NVP %x/%x\n",
> +                      nvp_blk, nvp_idx);
> +        return;
> +    }
> +
> +
> +    rd = xive_tctx_accept(tctx, ring);
> +
> +    if (ring == TM_QW1_OS) {
> +        OGen = tctx->regs[ring + TM_OGEN];
> +    }
> +    xive2_cfg = xive2_router_get_config(xrtr);
> +    phys_addr = xive2_nvp_reporting_addr(&nvp);
> +    uint8_t report_data[REPORT_LINE_GEN1_SIZE];
> +    memset(report_data, 0xff, sizeof(report_data));
> +    if ((OGen == 1) || (xive2_cfg & XIVE2_GEN1_TIMA_OS)) {
> +        report_data[8] = (rd >> 8) & 0xff;
> +        report_data[9] = rd & 0xff;
> +    } else {
> +        report_data[0] = (rd >> 8) & 0xff;
> +        report_data[1] = rd & 0xff;
> +    }
> +    cpu_physical_memory_write(phys_addr, report_data, REPORT_LINE_GEN1_SIZE);
> +}
> +
> +void xive2_tm_ack_os_el(XivePresenter *xptr, XiveTCTX *tctx,
> +                        hwaddr offset, uint64_t value, unsigned size)
> +{
> +    xive2_tctx_accept_el(xptr, tctx, TM_QW1_OS, TM_QW1_OS);
> +}
> +
>   static void xive2_tctx_set_cppr(XiveTCTX *tctx, uint8_t ring, uint8_t cppr)
>   {
>       uint8_t *regs = &tctx->regs[ring];
> diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
> index 28f0f1b79a..46d05d74fb 100644
> --- a/include/hw/ppc/xive.h
> +++ b/include/hw/ppc/xive.h
> @@ -561,6 +561,7 @@ void xive_tctx_pipr_update(XiveTCTX *tctx, uint8_t ring, uint8_t priority,
>                              uint8_t group_level);
>   void xive_tctx_reset_signal(XiveTCTX *tctx, uint8_t ring);
>   void xive_tctx_notify(XiveTCTX *tctx, uint8_t ring, uint8_t group_level);
> +uint64_t xive_tctx_accept(XiveTCTX *tctx, uint8_t ring);
>   
>   /*
>    * KVM XIVE device helpers
> diff --git a/include/hw/ppc/xive2.h b/include/hw/ppc/xive2.h
> index 760b94a962..ff02ce2549 100644
> --- a/include/hw/ppc/xive2.h
> +++ b/include/hw/ppc/xive2.h
> @@ -142,5 +142,6 @@ void xive2_tm_set_hv_target(XivePresenter *xptr, XiveTCTX *tctx,
>                               hwaddr offset, uint64_t value, unsigned size);
>   void xive2_tm_pull_phys_ctx_ol(XivePresenter *xptr, XiveTCTX *tctx,
>                                  hwaddr offset, uint64_t value, unsigned size);
> -
> +void xive2_tm_ack_os_el(XivePresenter *xptr, XiveTCTX *tctx,
> +                        hwaddr offset, uint64_t value, unsigned size);
>   #endif /* PPC_XIVE2_H */

