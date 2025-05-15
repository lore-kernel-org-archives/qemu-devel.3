Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4EB2C2D0CD
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 16:13:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFbCP-00028L-Mo; Thu, 15 May 2025 12:12:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1uFbC9-0001y4-ER; Thu, 15 May 2025 12:12:31 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1uFbC6-0001Gc-98; Thu, 15 May 2025 12:12:28 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54FCgV55013313;
 Thu, 15 May 2025 16:12:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=gUXwlZ7Pd+haoMN/sT8MAgHSiaREWtawWiouT8lP3T4=; b=p1EiYEp3jE7s
 qf0d3XhbquVWKiLnEoCsidDIjolpCv0Zu/wsuUGiJiwlOMSovEa5swOsyHZc2JNW
 N3DtH3WyPda1yGcmU0RLH97ORsRh0uyVLxpfleSRSSrlNFfBOFyT4DpsQhuc66I5
 tLNQaEC4R6GaSB9d+vYts72UQm5c0AQ/q9RqT0XeubwvW5Q8GNRS2AzgYw+yO3DJ
 ViOqKLHclttyDJunq4XC12xm2FVQOazGM95089FRxt1mjEtmFkdBBHgicq0XLo7V
 tEE+zSgZ8DMmtNATZdIAmav28O2GqS7snrQKUY4leEg9BAOSVUvx8lIlaMUxx8T9
 1/6ocyBrCA==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46n0t9dpfc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 16:12:23 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54FFsdnv023029;
 Thu, 15 May 2025 16:12:23 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46n0t9dpf8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 16:12:23 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54FEIZuk024449;
 Thu, 15 May 2025 16:12:21 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46mbfsb5jw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 16:12:21 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 54FGCK5327067102
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 15 May 2025 16:12:20 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 606515805C;
 Thu, 15 May 2025 16:12:20 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F1B4658051;
 Thu, 15 May 2025 16:12:19 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 15 May 2025 16:12:19 +0000 (GMT)
Message-ID: <4cb445a7315af9070d5d9904287816a8a4be2517.camel@linux.ibm.com>
Subject: Re: [PATCH 43/50] ppc/xive: Check TIMA operations validity
From: Miles Glenn <milesg@linux.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, =?ISO-8859-1?Q?Fr=E9d=E9ric?= Barrat
 <fbarrat@linux.ibm.com>, Michael Kowal <kowal@linux.ibm.com>, Caleb
 Schlossin <calebs@linux.vnet.ibm.com>
Date: Thu, 15 May 2025 11:12:19 -0500
In-Reply-To: <20250512031100.439842-44-npiggin@gmail.com>
References: <20250512031100.439842-1-npiggin@gmail.com>
 <20250512031100.439842-44-npiggin@gmail.com>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=etzfzppX c=1 sm=1 tr=0 ts=68261267 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8
 a=D3cgVjojyP8M4rMLZNYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDE2MCBTYWx0ZWRfX+6nAjk4v4GkD
 X74HXsO9rUiNLOpV/jf2ZbyorSia4oH0oQvY7oUmfMRZy/ZDaxU1+NKYTqGYVBOEtUAPk/E2TJQ
 OhGuA61cKT5pMbo32dSoJos3eWpxt5Ct2+IVupOs+RdFTFsoV/L+7+34Al4T4EERzQ5281lRxGJ
 yIMkt+pfO4G/xHf7VBBiNdSzAzNEV7YNL6ilaoaMOukWugHIrt5MqZ9CNTJEF5275abDwgRA2se
 Wh7orT9lDO2pPd//wXelABOuqUQnpSGCEOqODkNK8phjprUyuqMbPbGsGnsiP8LCTFNyVeCV1fi
 Lzt5zqQfGTzqzpZHFaheiOQmAne3GZinEYdGrdDqBBXU/FJR6fx3YThsKhSavTAUZVpTyrfAdNh
 /tuvfHOv8rn0Kvxh6+qvIwIvycyYWXkBHb1KFbpFLWq7cknXK1ZlQ8lH2w63ghCOD/LMe3de
X-Proofpoint-ORIG-GUID: NiTtIKLiqp92TVjUVm82HqE-1ELBpN_L
X-Proofpoint-GUID: YhraolRXJz8nvwGLAgEXEIcs55dOUyA6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_07,2025-05-15_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 lowpriorityscore=0 phishscore=0 mlxscore=0 mlxlogscore=817 bulkscore=0
 suspectscore=0 spamscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505150160
Received-SPF: pass client-ip=148.163.156.1; envelope-from=milesg@linux.ibm.com;
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
Reply-To: milesg@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Reviewed-by: Glenn Miles <milesg@linux.ibm.com>

On Mon, 2025-05-12 at 13:10 +1000, Nicholas Piggin wrote:
> Certain TIMA operations should only be performed when a ring is valid,
> others when the ring is invalid, and they are considered undefined if
> used incorrectly. Add checks for this condition.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  hw/intc/xive.c        | 196 +++++++++++++++++++++++++-----------------
>  include/hw/ppc/xive.h |   1 +
>  2 files changed, 116 insertions(+), 81 deletions(-)
> 
> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> index aeca66e56e..d5bbd8f4c6 100644
> --- a/hw/intc/xive.c
> +++ b/hw/intc/xive.c
> @@ -25,6 +25,19 @@
>  /*
>   * XIVE Thread Interrupt Management context
>   */
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
>  bool xive_nsr_indicates_exception(uint8_t ring, uint8_t nsr)
>  {
>      switch (ring) {
> @@ -663,6 +676,8 @@ typedef struct XiveTmOp {
>      uint8_t  page_offset;
>      uint32_t op_offset;
>      unsigned size;
> +    bool     hw_ok;
> +    bool     sw_ok;
>      void     (*write_handler)(XivePresenter *xptr, XiveTCTX *tctx,
>                                hwaddr offset,
>                                uint64_t value, unsigned size);
> @@ -675,34 +690,34 @@ static const XiveTmOp xive_tm_operations[] = {
>       * MMIOs below 2K : raw values and special operations without side
>       * effects
>       */
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
>      /* MMIOs above 2K : special operations with side effects */
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
>  };
>  
>  static const XiveTmOp xive2_tm_operations[] = {
> @@ -710,52 +725,48 @@ static const XiveTmOp xive2_tm_operations[] = {
>       * MMIOs below 2K : raw values and special operations without side
>       * effects
>       */
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
>      /* MMIOs above 2K : special operations with side effects */
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
>  };
>  
>  static const XiveTmOp *xive_tm_find_op(XivePresenter *xptr, hwaddr offset,
> @@ -797,18 +808,28 @@ void xive_tctx_tm_write(XivePresenter *xptr, XiveTCTX *tctx, hwaddr offset,
>                          uint64_t value, unsigned size)
>  {
>      const XiveTmOp *xto;
> +    uint8_t ring = offset & TM_RING_OFFSET;
> +    bool is_valid = xive_ring_valid(tctx, ring);
> +    bool hw_owned = is_valid;
>  
>      trace_xive_tctx_tm_write(tctx->cs->cpu_index, offset, size, value);
>  
> -    /*
> -     * TODO: check V bit in Q[0-3]W2
> -     */
> -
>      /*
>       * First, check for special operations in the 2K region
>       */
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
>      if (offset & TM_SPECIAL_OP) {
> -        xto = xive_tm_find_op(tctx->xptr, offset, size, true);
>          if (!xto) {
>              qemu_log_mask(LOG_GUEST_ERROR, "XIVE: invalid write access at TIMA "
>                            "@%"HWADDR_PRIx" size %d\n", offset, size);
> @@ -821,7 +842,6 @@ void xive_tctx_tm_write(XivePresenter *xptr, XiveTCTX *tctx, hwaddr offset,
>      /*
>       * Then, for special operations in the region below 2K.
>       */
> -    xto = xive_tm_find_op(tctx->xptr, offset, size, true);
>      if (xto) {
>          xto->write_handler(xptr, tctx, offset, value, size);
>          return;
> @@ -830,6 +850,11 @@ void xive_tctx_tm_write(XivePresenter *xptr, XiveTCTX *tctx, hwaddr offset,
>      /*
>       * Finish with raw access to the register values
>       */
> +    if (hw_owned) {
> +        /* Store context operations are dangerous when context is valid */
> +        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: undefined write to HW TIMA "
> +                      "@%"HWADDR_PRIx" size %d\n", offset, size);
> +    }
>      xive_tm_raw_write(tctx, offset, value, size);
>  }
>  
> @@ -837,17 +862,27 @@ uint64_t xive_tctx_tm_read(XivePresenter *xptr, XiveTCTX *tctx, hwaddr offset,
>                             unsigned size)
>  {
>      const XiveTmOp *xto;
> +    uint8_t ring = offset & TM_RING_OFFSET;
> +    bool is_valid = xive_ring_valid(tctx, ring);
> +    bool hw_owned = is_valid;
>      uint64_t ret;
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
>      /*
>       * First, check for special operations in the 2K region
>       */
>      if (offset & TM_SPECIAL_OP) {
> -        xto = xive_tm_find_op(tctx->xptr, offset, size, false);
>          if (!xto) {
>              qemu_log_mask(LOG_GUEST_ERROR, "XIVE: invalid read access to TIMA"
>                            "@%"HWADDR_PRIx" size %d\n", offset, size);
> @@ -860,7 +895,6 @@ uint64_t xive_tctx_tm_read(XivePresenter *xptr, XiveTCTX *tctx, hwaddr offset,
>      /*
>       * Then, for special operations in the region below 2K.
>       */
> -    xto = xive_tm_find_op(tctx->xptr, offset, size, false);
>      if (xto) {
>          ret = xto->read_handler(xptr, tctx, offset, size);
>          goto out;
> diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
> index 2372d1014b..b7ca8544e4 100644
> --- a/include/hw/ppc/xive.h
> +++ b/include/hw/ppc/xive.h
> @@ -365,6 +365,7 @@ static inline uint32_t xive_tctx_word2(uint8_t *ring)
>      return *((uint32_t *) &ring[TM_WORD2]);
>  }
>  
> +bool xive_ring_valid(XiveTCTX *tctx, uint8_t ring);
>  bool xive_nsr_indicates_exception(uint8_t ring, uint8_t nsr);
>  bool xive_nsr_indicates_group_exception(uint8_t ring, uint8_t nsr);
>  uint8_t xive_nsr_exception_ring(uint8_t ring, uint8_t nsr);


