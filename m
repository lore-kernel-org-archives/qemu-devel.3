Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DA3FFA374F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2024 13:11:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sp64H-0003Dn-7J; Fri, 13 Sep 2024 09:10:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=56UY=QL=kaod.org=clg@ozlabs.org>)
 id 1sp64F-0003C3-Cx; Fri, 13 Sep 2024 09:10:31 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=56UY=QL=kaod.org=clg@ozlabs.org>)
 id 1sp64C-00019x-4r; Fri, 13 Sep 2024 09:10:31 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4X4vmn6sqYz4xQW;
 Fri, 13 Sep 2024 23:10:17 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4X4vml4mr1z4wb0;
 Fri, 13 Sep 2024 23:10:15 +1000 (AEST)
Message-ID: <121cb7c6-bd37-44fe-8d69-d33d1efa1643@kaod.org>
Date: Fri, 13 Sep 2024 15:10:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/14] ppc/xive2: Change context/ring specific
 functions to be generic
To: Michael Kowal <kowal@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, fbarrat@linux.ibm.com, npiggin@gmail.com,
 milesg@linux.ibm.com
References: <20240912205028.15854-1-kowal@linux.ibm.com>
 <20240912205028.15854-10-kowal@linux.ibm.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240912205028.15854-10-kowal@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=56UY=QL=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 9/12/24 22:50, Michael Kowal wrote:
> Some the functions that have been created are specific to a ring or context. Some
> of these same functions are being changed to operate on any ring/context. This  will
> simplify the next patch sets that are adding additional ring/context operations.
> 
> Signed-off-by: Michael Kowal <kowal@linux.ibm.com>
> ---
>   include/hw/ppc/xive.h |  2 +-
>   hw/intc/xive.c        |  6 +++---
>   hw/intc/xive2.c       | 23 ++++++++++++-----------
>   3 files changed, 16 insertions(+), 15 deletions(-)
> 
> diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
> index 28c181faa2..31242f0406 100644
> --- a/include/hw/ppc/xive.h
> +++ b/include/hw/ppc/xive.h
> @@ -533,7 +533,7 @@ Object *xive_tctx_create(Object *cpu, XivePresenter *xptr, Error **errp);
>   void xive_tctx_reset(XiveTCTX *tctx);
>   void xive_tctx_destroy(XiveTCTX *tctx);
>   void xive_tctx_ipb_update(XiveTCTX *tctx, uint8_t ring, uint8_t ipb);
> -void xive_tctx_reset_os_signal(XiveTCTX *tctx);
> +void xive_tctx_reset_signal(XiveTCTX *tctx, uint8_t ring);
>   
>   /*
>    * KVM XIVE device helpers
> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> index 5b66a3aec5..f1d007d9a6 100644
> --- a/hw/intc/xive.c
> +++ b/hw/intc/xive.c
> @@ -114,7 +114,7 @@ static void xive_tctx_notify(XiveTCTX *tctx, uint8_t ring)
>       }
>   }
>   
> -void xive_tctx_reset_os_signal(XiveTCTX *tctx)
> +void xive_tctx_reset_signal(XiveTCTX *tctx, uint8_t ring)
>   {
>       /*
>        * Lower the External interrupt. Used when pulling an OS
> @@ -122,7 +122,7 @@ void xive_tctx_reset_os_signal(XiveTCTX *tctx)
>        * context. It should be raised again when re-pushing the OS
>        * context.
>        */
> -    qemu_irq_lower(xive_tctx_output(tctx, TM_QW1_OS));
> +    qemu_irq_lower(xive_tctx_output(tctx, ring));
>   }
>   
>   static void xive_tctx_set_cppr(XiveTCTX *tctx, uint8_t ring, uint8_t cppr)
> @@ -424,7 +424,7 @@ static uint64_t xive_tm_pull_os_ctx(XivePresenter *xptr, XiveTCTX *tctx,
>       qw1w2_new = xive_set_field32(TM_QW1W2_VO, qw1w2, 0);
>       xive_tctx_set_os_cam(tctx, qw1w2_new);
>   
> -    xive_tctx_reset_os_signal(tctx);
> +    xive_tctx_reset_signal(tctx, TM_QW1_OS);
>       return qw1w2;
>   }
>   
> diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
> index 8d3d69a0db..ad8b8729ed 100644
> --- a/hw/intc/xive2.c
> +++ b/hw/intc/xive2.c
> @@ -270,13 +270,14 @@ static void xive2_end_enqueue(Xive2End *end, uint32_t data)
>    *     the NVP by changing the H bit while the context is enabled
>    */
>   
> -static void xive2_tctx_save_os_ctx(Xive2Router *xrtr, XiveTCTX *tctx,
> -                                   uint8_t nvp_blk, uint32_t nvp_idx)
> +static void xive2_tctx_save_ctx(Xive2Router *xrtr, XiveTCTX *tctx,
> +                                uint8_t nvp_blk, uint32_t nvp_idx,
> +                                uint8_t ring)
>   {
>       CPUPPCState *env = &POWERPC_CPU(tctx->cs)->env;
>       uint32_t pir = env->spr_cb[SPR_PIR].default_value;
>       Xive2Nvp nvp;
> -    uint8_t *regs = &tctx->regs[TM_QW1_OS];
> +    uint8_t *regs = &tctx->regs[ring];
>   
>       if (xive2_router_get_nvp(xrtr, nvp_blk, nvp_idx, &nvp)) {
>           qemu_log_mask(LOG_GUEST_ERROR, "XIVE: No NVP %x/%x\n",
> @@ -321,13 +322,13 @@ static void xive2_tctx_save_os_ctx(Xive2Router *xrtr, XiveTCTX *tctx,
>       xive2_router_write_nvp(xrtr, nvp_blk, nvp_idx, &nvp, 1);
>   }
>   
> -static void xive2_os_cam_decode(uint32_t cam, uint8_t *nvp_blk,
> -                                uint32_t *nvp_idx, bool *vo, bool *ho)
> +static void xive2_cam_decode(uint32_t cam, uint8_t *nvp_blk,
> +                             uint32_t *nvp_idx, bool *valid, bool *hw)
>   {
>       *nvp_blk = xive2_nvp_blk(cam);
>       *nvp_idx = xive2_nvp_idx(cam);
> -    *vo = !!(cam & TM2_QW1W2_VO);
> -    *ho = !!(cam & TM2_QW1W2_HO);
> +    *valid = !!(cam & TM2_QW1W2_VO);
> +    *hw = !!(cam & TM2_QW1W2_HO);

This change belongs to another patch. Anyhow,


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.



>   }
>   
>   
> @@ -363,7 +364,7 @@ uint64_t xive2_tm_pull_os_ctx(XivePresenter *xptr, XiveTCTX *tctx,
>       bool vo;
>       bool do_save;
>   
> -    xive2_os_cam_decode(cam, &nvp_blk, &nvp_idx, &vo, &do_save);
> +    xive2_cam_decode(cam, &nvp_blk, &nvp_idx, &vo, &do_save);
>   
>       if (!vo) {
>           qemu_log_mask(LOG_GUEST_ERROR, "XIVE: pulling invalid NVP %x/%x !?\n",
> @@ -375,10 +376,10 @@ uint64_t xive2_tm_pull_os_ctx(XivePresenter *xptr, XiveTCTX *tctx,
>       memcpy(&tctx->regs[TM_QW1_OS + TM_WORD2], &qw1w2_new, 4);
>   
>       if (xive2_router_get_config(xrtr) & XIVE2_VP_SAVE_RESTORE && do_save) {
> -        xive2_tctx_save_os_ctx(xrtr, tctx, nvp_blk, nvp_idx);
> +        xive2_tctx_save_ctx(xrtr, tctx, nvp_blk, nvp_idx, TM_QW1_OS);
>       }
>   
> -    xive_tctx_reset_os_signal(tctx);
> +    xive_tctx_reset_signal(tctx, TM_QW1_OS);
>       return qw1w2;
>   }
>   
> @@ -573,7 +574,7 @@ void xive2_tm_push_os_ctx(XivePresenter *xptr, XiveTCTX *tctx,
>       bool vo;
>       bool do_restore;
>   
> -    xive2_os_cam_decode(cam, &nvp_blk, &nvp_idx, &vo, &do_restore);
> +    xive2_cam_decode(cam, &nvp_blk, &nvp_idx, &vo, &do_restore);
>   
>       /* First update the thead context */
>       memcpy(&tctx->regs[TM_QW1_OS + TM_WORD2], &qw1w2, 4);


