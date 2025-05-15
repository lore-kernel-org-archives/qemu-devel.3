Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC0F9C2D0CD
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 16:12:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFbBR-0001Sc-4n; Thu, 15 May 2025 12:11:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1uFbB5-0001NL-7u; Thu, 15 May 2025 12:11:24 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1uFbB2-0001DN-Qy; Thu, 15 May 2025 12:11:22 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54FCgBus004815;
 Thu, 15 May 2025 16:11:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=bP9JIBnj7JTj+hxaItA7LztE5MGQ0BQR87TbH+QPY5Y=; b=N5pBZilRhu6j
 qRJrfJUNl/WjsT4/YgaFX3JhxmpFCVVoPZ6TXLf62krHQ2j8SXQfuEWHnS++bA+n
 8dKQKWDoZeMv/wAHdqvWhkqmAWYssYxroi0yo1dxLCFINN1bXSgJDbh/ryPXVvTF
 dhv9oc/DyJ/disNgpLhUJ+bwkqN9c6y5iRaRFcF47CvtaDp7uEs0k8z2vPI4ylTz
 Z/uXTxQ3v2ng5+wuDyzhnM3soE7Hno9eG7j4FRdRCr+qnaI5PTeAVc1dG9oXJHRg
 9uDF/70w2IYGHtXkDsliLPo3WhgQIHgZ60WSF6yqRPk0sM+hwSvJQvXaiReAqU4B
 G4qQxYkzEA==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46ndfjt6qt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 16:11:18 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54FFtaO7014287;
 Thu, 15 May 2025 16:11:18 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46ndfjt6qp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 16:11:18 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54FEHn9N021424;
 Thu, 15 May 2025 16:11:17 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46mbfru4nj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 16:11:17 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 54FGBGFb2360004
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 15 May 2025 16:11:16 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8C27158061;
 Thu, 15 May 2025 16:11:16 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3117158057;
 Thu, 15 May 2025 16:11:16 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 15 May 2025 16:11:16 +0000 (GMT)
Message-ID: <0f76e538b69d0431234255897190e2ecc988bc60.camel@linux.ibm.com>
Subject: Re: [PATCH 42/50] ppc/xive: Redistribute phys after pulling of pool
 context
From: Miles Glenn <milesg@linux.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, =?ISO-8859-1?Q?Fr=E9d=E9ric?= Barrat
 <fbarrat@linux.ibm.com>, Michael Kowal <kowal@linux.ibm.com>, Caleb
 Schlossin <calebs@linux.vnet.ibm.com>
Date: Thu, 15 May 2025 11:11:15 -0500
In-Reply-To: <20250512031100.439842-43-npiggin@gmail.com>
References: <20250512031100.439842-1-npiggin@gmail.com>
 <20250512031100.439842-43-npiggin@gmail.com>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: enUO8843RHOw1zcSbdi4IhJz_F73NsJs
X-Authority-Analysis: v=2.4 cv=ecg9f6EH c=1 sm=1 tr=0 ts=68261226 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8
 a=yvUvzrinEMu33hxc1CYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: S9_ZBK_Mq6GLKLaLefp4uvNPZE4ay3l5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDE2MCBTYWx0ZWRfX1fKBxPG1DKSP
 icvo+tJJlzkysKGEwGK8W4UNAumXGtnReYCkzBuO+XRUClFaaaBcBba7BNwZEfQW5ifFWVHL1PC
 xOdMnaOD3PeM35x0vVWa8cpnJiREAmxDcWjtImmCgWelRY4h8+iTJaNU+pki66Bhji5ABQIC2nz
 bZ6X9xMG00sT1PlrLGcWwybT4FWnmpJnCIg/Y3uC5bVfgo7P3gPOUczLJqNakKCsxp7tJ5+ExO2
 f4z0u35/xqOdqCIen+ec7ydpX0qfk7jddRfWhlxy5KOk454CX02C7YjkhrImETjpy1hXNNi1nB4
 hcZ0h/y5SYkQu52koUxbKfuokvBBe4n4M5suFeY4jdmAyVEB6twtV3GIHwkFV6jvjkx95uKvKJV
 zPm2+ceArbBzaz93rZdREyGcxkENc8U2NhLdIdLpsMjtsomNsLgYG483H+kZgwK3kxXCbA+U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_07,2025-05-15_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999
 impostorscore=0 spamscore=0 clxscore=1015 malwarescore=0 mlxscore=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 suspectscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505150160
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
> After pulling the pool context, if a pool irq had been presented and
> was cleared in the process, there could be a pending irq in phys that
> should be presented. Process the phys irq ring after pulling pool ring
> to catch this case and avoid losing irqs.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  hw/intc/xive.c  |  3 +++
>  hw/intc/xive2.c | 16 ++++++++++++++--
>  2 files changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> index 81af59f0ec..aeca66e56e 100644
> --- a/hw/intc/xive.c
> +++ b/hw/intc/xive.c
> @@ -320,6 +320,9 @@ static uint64_t xive_tm_pull_pool_ctx(XivePresenter *xptr, XiveTCTX *tctx,
>  
>      xive_tctx_reset_signal(tctx, TM_QW1_OS);
>      xive_tctx_reset_signal(tctx, TM_QW2_HV_POOL);
> +    /* Re-check phys for interrupts if pool was disabled */
> +    xive_tctx_pipr_recompute_from_ipb(tctx, TM_QW3_HV_PHYS);
> +
>      return qw2w2;
>  }
>  
> diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
> index aeeb901b6a..917ecbaae4 100644
> --- a/hw/intc/xive2.c
> +++ b/hw/intc/xive2.c
> @@ -683,6 +683,8 @@ static void xive2_redistribute(Xive2Router *xrtr, XiveTCTX *tctx, uint8_t ring)
>      xive_tctx_reset_signal(tctx, ring);
>  }
>  
> +static void xive2_tctx_process_pending(XiveTCTX *tctx, uint8_t sig_ring);
> +
>  static uint64_t xive2_tm_pull_ctx(XivePresenter *xptr, XiveTCTX *tctx,
>                                    hwaddr offset, unsigned size, uint8_t ring)
>  {
> @@ -739,6 +741,18 @@ static uint64_t xive2_tm_pull_ctx(XivePresenter *xptr, XiveTCTX *tctx,
>          }
>      }
>  
> +    if (ring == TM_QW2_HV_POOL) {
> +        /* Re-check phys for interrupts if pool was disabled */
> +        nsr = tctx->regs[TM_QW3_HV_PHYS + TM_NSR];
> +        if (xive_nsr_indicates_exception(TM_QW3_HV_PHYS, nsr)) {
> +            /* Ring must be PHYS because POOL would have been redistributed */
> +            g_assert(xive_nsr_exception_ring(TM_QW3_HV_PHYS, nsr) ==
> +                                                           TM_QW3_HV_PHYS);
> +        } else {
> +            xive2_tctx_process_pending(tctx, TM_QW3_HV_PHYS);
> +        }
> +    }
> +
>      if (xive2_router_get_config(xrtr) & XIVE2_VP_SAVE_RESTORE && do_save) {
>          xive2_tctx_save_ctx(xrtr, tctx, ring, nvp_blk, nvp_idx);
>      }
> @@ -925,8 +939,6 @@ static uint8_t xive2_tctx_restore_ctx(Xive2Router *xrtr, XiveTCTX *tctx,
>      return cppr;
>  }
>  
> -static void xive2_tctx_process_pending(XiveTCTX *tctx, uint8_t sig_ring);
> -
>  static void xive2_tctx_need_resend(Xive2Router *xrtr, XiveTCTX *tctx,
>                                     uint8_t nvp_blk, uint32_t nvp_idx,
>                                     bool do_restore)


