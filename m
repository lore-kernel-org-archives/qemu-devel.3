Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6989EE644D
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 06:28:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sodJB-00058i-Qh; Thu, 12 Sep 2024 02:28:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=071a=QK=kaod.org=clg@ozlabs.org>)
 id 1sodJA-00053L-CW; Thu, 12 Sep 2024 02:28:00 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=071a=QK=kaod.org=clg@ozlabs.org>)
 id 1sodJ8-0000Gg-1N; Thu, 12 Sep 2024 02:28:00 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4X46tx1QP9z4x0K;
 Thu, 12 Sep 2024 16:27:53 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4X46tt5xtHz4wx5;
 Thu, 12 Sep 2024 16:27:50 +1000 (AEST)
Message-ID: <97ef9605-0acf-4296-aa7e-0d83a054e738@kaod.org>
Date: Thu, 12 Sep 2024 08:27:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/14] ppc/xive2: Change context/ring specific
 functions to be generic
To: Michael Kowal <kowal@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, fbarrat@linux.ibm.com, npiggin@gmail.com,
 milesg@linux.ibm.com
References: <20240909211038.27440-1-kowal@linux.ibm.com>
 <20240909211038.27440-10-kowal@linux.ibm.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240909211038.27440-10-kowal@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=071a=QK=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
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

On 9/9/24 23:10, Michael Kowal wrote:
> Some the functions that have been created are specific to a ring or context. Some
> of these same functions are being changed to operate on any ring/context. This  will
> simplify the next patch sets that are adding additional ring/context operations.
>
> Signed-off-by: Michael Kowal <kowal@linux.ibm.com>
> ---
>   include/hw/ppc/xive.h |  2 +-
>   hw/intc/xive.c        |  6 ++--
>   hw/intc/xive2.c       | 77 ++++++++++++++++++++++++++++---------------
>   3 files changed, 55 insertions(+), 30 deletions(-)
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
> index 8d3d69a0db..38a4b0ff68 100644
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
>   }
>   
>   
> @@ -351,37 +352,54 @@ static uint32_t xive2_tctx_hw_cam_line(XivePresenter *xptr, XiveTCTX *tctx)
>       return xive2_nvp_cam_line(blk, 1 << tid_shift | (pir & tid_mask));
>   }
>   
> -uint64_t xive2_tm_pull_os_ctx(XivePresenter *xptr, XiveTCTX *tctx,
> -                              hwaddr offset, unsigned size)
> +static uint64_t xive2_tm_pull_ctx(XivePresenter *xptr, XiveTCTX *tctx,
> +                                  hwaddr offset, unsigned size, uint8_t ring)

The changes below are not strictly adding a ring parameter. Some belong
to another patch.


Thanks,

C.



>   {
>       Xive2Router *xrtr = XIVE2_ROUTER(xptr);
> -    uint32_t qw1w2 = xive_tctx_word2(&tctx->regs[TM_QW1_OS]);
> -    uint32_t qw1w2_new;
> -    uint32_t cam = be32_to_cpu(qw1w2);
> +    uint32_t target_ringw2 = xive_tctx_word2(&tctx->regs[ring]);
> +    uint32_t cam = be32_to_cpu(target_ringw2);
>       uint8_t nvp_blk;
>       uint32_t nvp_idx;
> -    bool vo;
> +    uint8_t cur_ring;
> +    bool valid;
>       bool do_save;
>   
> -    xive2_os_cam_decode(cam, &nvp_blk, &nvp_idx, &vo, &do_save);
> +    xive2_cam_decode(cam, &nvp_blk, &nvp_idx, &valid, &do_save);
>   
> -    if (!vo) {
> +    if (!valid) {
>           qemu_log_mask(LOG_GUEST_ERROR, "XIVE: pulling invalid NVP %x/%x !?\n",
>                         nvp_blk, nvp_idx);
>       }
>   
> -    /* Invalidate CAM line */
> -    qw1w2_new = xive_set_field32(TM2_QW1W2_VO, qw1w2, 0);
> -    memcpy(&tctx->regs[TM_QW1_OS + TM_WORD2], &qw1w2_new, 4);
> +    /* Invalidate CAM line of requested ring and all lower rings */
> +    for (cur_ring = TM_QW0_USER; cur_ring <= ring;
> +         cur_ring += XIVE_TM_RING_SIZE) {
> +        uint32_t ringw2 = xive_tctx_word2(&tctx->regs[cur_ring]);
> +        uint32_t ringw2_new = xive_set_field32(TM2_QW1W2_VO, ringw2, 0);
> +        memcpy(&tctx->regs[cur_ring + TM_WORD2], &ringw2_new, 4);
> +    }
>   
>       if (xive2_router_get_config(xrtr) & XIVE2_VP_SAVE_RESTORE && do_save) {
> -        xive2_tctx_save_os_ctx(xrtr, tctx, nvp_blk, nvp_idx);
> +        xive2_tctx_save_ctx(xrtr, tctx, nvp_blk, nvp_idx, ring);
>       }
>   
> -    xive_tctx_reset_os_signal(tctx);
> -    return qw1w2;
> +    /*
> +     * Lower external interrupt line of requested ring and below except for
> +     * USER, which doesn't exist.
> +     */
> +    for (cur_ring = TM_QW1_OS; cur_ring <= ring;
> +         cur_ring += XIVE_TM_RING_SIZE) {
> +        xive_tctx_reset_signal(tctx, cur_ring);
> +    }
> +    return target_ringw2;
>   }
>   
> +uint64_t xive2_tm_pull_os_ctx(XivePresenter *xptr, XiveTCTX *tctx,
> +                              hwaddr offset, unsigned size)
> +{
> +    return xive2_tm_pull_ctx(xptr, tctx, offset, size, TM_QW1_OS);
> + }
> +
>   #define REPORT_LINE_GEN1_SIZE       16
>   
>   static void xive2_tm_report_line_gen1(XiveTCTX *tctx, uint8_t *data,
> @@ -424,8 +442,9 @@ static void xive2_tm_report_line_gen1(XiveTCTX *tctx, uint8_t *data,
>       }
>   }
>   
> -void xive2_tm_pull_os_ctx_ol(XivePresenter *xptr, XiveTCTX *tctx,
> -                             hwaddr offset, uint64_t value, unsigned size)
> +static void xive2_tm_pull_ctx_ol(XivePresenter *xptr, XiveTCTX *tctx,
> +                                 hwaddr offset, uint64_t value,
> +                                 unsigned size, uint8_t ring)
>   {
>       Xive2Router *xrtr = XIVE2_ROUTER(xptr);
>       uint32_t hw_cam, nvp_idx, xive2_cfg, reserved;
> @@ -473,8 +492,14 @@ void xive2_tm_pull_os_ctx_ol(XivePresenter *xptr, XiveTCTX *tctx,
>           assert(result == MEMTX_OK);
>       }
>   
> -    /* the rest is similar to pull OS context to registers */
> -    xive2_tm_pull_os_ctx(xptr, tctx, offset, size);
> +    /* the rest is similar to pull context to registers */
> +    xive2_tm_pull_ctx(xptr, tctx, offset, size, ring);
> +}
> +
> +void xive2_tm_pull_os_ctx_ol(XivePresenter *xptr, XiveTCTX *tctx,
> +                             hwaddr offset, uint64_t value, unsigned size)
> +{
> +    xive2_tm_pull_ctx_ol(xptr, tctx, offset, value, size, TM_QW1_OS);
>   }
>   
>   static uint8_t xive2_tctx_restore_os_ctx(Xive2Router *xrtr, XiveTCTX *tctx,
> @@ -573,7 +598,7 @@ void xive2_tm_push_os_ctx(XivePresenter *xptr, XiveTCTX *tctx,
>       bool vo;
>       bool do_restore;
>   
> -    xive2_os_cam_decode(cam, &nvp_blk, &nvp_idx, &vo, &do_restore);
> +    xive2_cam_decode(cam, &nvp_blk, &nvp_idx, &vo, &do_restore);
>   
>       /* First update the thead context */
>       memcpy(&tctx->regs[TM_QW1_OS + TM_WORD2], &qw1w2, 4);


