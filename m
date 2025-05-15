Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 268F0C54755
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 15:52:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFapw-0004W6-0X; Thu, 15 May 2025 11:49:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1uFapt-0004Bq-CF; Thu, 15 May 2025 11:49:29 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1uFapk-0006kE-C0; Thu, 15 May 2025 11:49:29 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54FCgAFs004769;
 Thu, 15 May 2025 15:49:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=d9hIti7ftVCs19pCWU6Ho24lLc1XQVOfwlG+W/SzdjI=; b=cUB4Bh1mutRy
 w3WSgAdmzz3cn39Z7nFfkerhbQhzckjaymUQzmtK3uj5qxwVjRc5FqCwCTJuO+aw
 c/RR/6i4VgPLUMViECHosJceJdOw7doXkZQ2XBRg2eBpUur7lL/9IKda0EEOF7RS
 7oA6pQtb98gOugaDIdmswRuSRrOK0NjQc3zjjFKW6bM3yYcw6q3qwznjUfNwswTn
 uzediWgJSHFPu9ZkoX7FN1AwECUVpDsA8kzndU1CV2FCg6YNWVb1zIoPWwz+bdHb
 yr5rXrXYACGysQB+qNvlKaA5LDA/jd6W/T5E34KjLKJLCh9+L+nNWl+ggiu9IN5q
 I8CnYT29/w==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46ndfjt31x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 15:49:17 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54FFigYe024463;
 Thu, 15 May 2025 15:49:16 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46ndfjt31w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 15:49:16 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54FE89FC021439;
 Thu, 15 May 2025 15:49:16 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46mbfru16e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 15:49:16 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 54FFnEQo27394658
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 15 May 2025 15:49:14 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6860158053;
 Thu, 15 May 2025 15:49:14 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C776C58043;
 Thu, 15 May 2025 15:49:13 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 15 May 2025 15:49:13 +0000 (GMT)
Message-ID: <4260e56a877e459cc9c3a2d4a8912c5622b46675.camel@linux.ibm.com>
Subject: Re: [PATCH 16/50] ppc/xive: Fix pulling pool and phys contexts
From: Miles Glenn <milesg@linux.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, =?ISO-8859-1?Q?Fr=E9d=E9ric?= Barrat
 <fbarrat@linux.ibm.com>, Michael Kowal <kowal@linux.ibm.com>, Caleb
 Schlossin <calebs@linux.vnet.ibm.com>
Date: Thu, 15 May 2025 10:49:13 -0500
In-Reply-To: <20250512031100.439842-17-npiggin@gmail.com>
References: <20250512031100.439842-1-npiggin@gmail.com>
 <20250512031100.439842-17-npiggin@gmail.com>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: pomMtLsNleiqCzvQwYX_btm77NvFYoVX
X-Authority-Analysis: v=2.4 cv=ecg9f6EH c=1 sm=1 tr=0 ts=68260cfd cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8
 a=Z2M4xorl1dFmOFgaFRYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: hlZRdlRP4p1hh4oPLdudyW2ThGV1bXKU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDE1NSBTYWx0ZWRfX1pROPESydOBK
 BnCl5mZ9EYfJhnKbZWolTUBfAnqikDJsP5KWHC0jUgaoMJK8MI5Dre1dVPb8pDMLkG+JPrl+cpw
 Q/MZjVqNbDK0ycwyUB6r4ebMSVVDbXGlZqCb9aLCKBcdG3KObzInIemHmerwc24EbmO0GuPDIJB
 PXPkoD3YbKO2Lm2okLK3ZXA/guyYWsT0t/RP+BRvLboK7x/L2I3vpRab763sVL3EaFJnz0g87PF
 NXTqrqqeDERtxS6gf3I+vvv1I/fluTeyE/+61JeLzOp5bfo85YP3dzX3mIEIMrNeotScBiwmrq6
 ZvH/DA9Hpq0nWUBfGuRrC+WXYshnUpzhrrBoARDMxv95IBBLb8VItL61TtwR6NnnlzP3z2QQPqv
 /WgOhfPY2zrEhhyP4ORAP9UjIoTPsGCeIhviB1Iu5OCIlPOeCSmT187txJgsApOn8DqNqg0Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_06,2025-05-15_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=950
 impostorscore=0 spamscore=0 clxscore=1015 malwarescore=0 mlxscore=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 suspectscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505150155
Received-SPF: pass client-ip=148.163.158.5; envelope-from=milesg@linux.ibm.com;
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
Reply-To: milesg@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Reviewed-by: Glenn Miles <milesg@linux.ibm.com>

On Mon, 2025-05-12 at 13:10 +1000, Nicholas Piggin wrote:
> This improves the implementation of pulling pool and phys contexts in
> XIVE1, by following closer the OS pulling code.
> 
> In particular, the old ring data is returned rather than the modified,
> and irq signals are reset on pull.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  hw/intc/xive.c | 66 ++++++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 58 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> index c2da23f9ea..1a94642c62 100644
> --- a/hw/intc/xive.c
> +++ b/hw/intc/xive.c
> @@ -241,25 +241,75 @@ static uint64_t xive_tm_ack_hv_reg(XivePresenter *xptr, XiveTCTX *tctx,
>      return xive_tctx_accept(tctx, TM_QW3_HV_PHYS);
>  }
>  
> +static void xive_pool_cam_decode(uint32_t cam, uint8_t *nvt_blk,
> +                                 uint32_t *nvt_idx, bool *vp)
> +{
> +    if (nvt_blk) {
> +        *nvt_blk = xive_nvt_blk(cam);
> +    }
> +    if (nvt_idx) {
> +        *nvt_idx = xive_nvt_idx(cam);
> +    }
> +    if (vp) {
> +        *vp = !!(cam & TM_QW2W2_VP);
> +    }
> +}
> +
> +static uint32_t xive_tctx_get_pool_cam(XiveTCTX *tctx, uint8_t *nvt_blk,
> +                                       uint32_t *nvt_idx, bool *vp)
> +{
> +    uint32_t qw2w2 = xive_tctx_word2(&tctx->regs[TM_QW2_HV_POOL]);
> +    uint32_t cam = be32_to_cpu(qw2w2);
> +
> +    xive_pool_cam_decode(cam, nvt_blk, nvt_idx, vp);
> +    return qw2w2;
> +}
> +
> +static void xive_tctx_set_pool_cam(XiveTCTX *tctx, uint32_t qw2w2)
> +{
> +    memcpy(&tctx->regs[TM_QW2_HV_POOL + TM_WORD2], &qw2w2, 4);
> +}
> +
>  static uint64_t xive_tm_pull_pool_ctx(XivePresenter *xptr, XiveTCTX *tctx,
>                                        hwaddr offset, unsigned size)
>  {
> -    uint32_t qw2w2_prev = xive_tctx_word2(&tctx->regs[TM_QW2_HV_POOL]);
>      uint32_t qw2w2;
> +    uint32_t qw2w2_new;
> +    uint8_t nvt_blk;
> +    uint32_t nvt_idx;
> +    bool vp;
>  
> -    qw2w2 = xive_set_field32(TM_QW2W2_VP, qw2w2_prev, 0);
> -    memcpy(&tctx->regs[TM_QW2_HV_POOL + TM_WORD2], &qw2w2, 4);
> +    qw2w2 = xive_tctx_get_pool_cam(tctx, &nvt_blk, &nvt_idx, &vp);
> +
> +    if (!vp) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: pull invalid POOL NVT %x/%x !?\n",
> +                      nvt_blk, nvt_idx);
> +    }
> +
> +    /* Invalidate CAM line */
> +    qw2w2_new = xive_set_field32(TM_QW2W2_VP, qw2w2, 0);
> +    xive_tctx_set_pool_cam(tctx, qw2w2_new);
> +
> +    xive_tctx_reset_signal(tctx, TM_QW1_OS);
> +    xive_tctx_reset_signal(tctx, TM_QW2_HV_POOL);
>      return qw2w2;
>  }
>  
>  static uint64_t xive_tm_pull_phys_ctx(XivePresenter *xptr, XiveTCTX *tctx,
>                                        hwaddr offset, unsigned size)
>  {
> -    uint8_t qw3b8_prev = tctx->regs[TM_QW3_HV_PHYS + TM_WORD2];
> -    uint8_t qw3b8;
> +    uint8_t qw3b8 = tctx->regs[TM_QW3_HV_PHYS + TM_WORD2];
> +    uint8_t qw3b8_new;
> +
> +    qw3b8 = tctx->regs[TM_QW3_HV_PHYS + TM_WORD2];
> +    if (!(qw3b8 & TM_QW3B8_VT)) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: pulling invalid PHYS thread!?\n");
> +    }
> +    qw3b8_new = qw3b8 & ~TM_QW3B8_VT;
> +    tctx->regs[TM_QW3_HV_PHYS + TM_WORD2] = qw3b8_new;
>  
> -    qw3b8 = qw3b8_prev & ~TM_QW3B8_VT;
> -    tctx->regs[TM_QW3_HV_PHYS + TM_WORD2] = qw3b8;
> +    xive_tctx_reset_signal(tctx, TM_QW1_OS);
> +    xive_tctx_reset_signal(tctx, TM_QW3_HV_PHYS);
>      return qw3b8;
>  }
>  
> @@ -489,7 +539,7 @@ static uint64_t xive_tm_pull_os_ctx(XivePresenter *xptr, XiveTCTX *tctx,
>      qw1w2 = xive_tctx_get_os_cam(tctx, &nvt_blk, &nvt_idx, &vo);
>  
>      if (!vo) {
> -        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: pulling invalid NVT %x/%x !?\n",
> +        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: pull invalid OS NVT %x/%x !?\n",
>                        nvt_blk, nvt_idx);
>      }
>  


