Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB3FFEE644D
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 06:25:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sodGb-00037H-PH; Thu, 12 Sep 2024 02:25:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=071a=QK=kaod.org=clg@ozlabs.org>)
 id 1sodGZ-0002yp-9k; Thu, 12 Sep 2024 02:25:19 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=071a=QK=kaod.org=clg@ozlabs.org>)
 id 1sodGW-0008R6-Sx; Thu, 12 Sep 2024 02:25:19 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4X46ql4rhsz4x4c;
 Thu, 12 Sep 2024 16:25:07 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4X46qj2pmrz4wx5;
 Thu, 12 Sep 2024 16:25:04 +1000 (AEST)
Message-ID: <025f3970-646c-40dc-9b93-918fff7521d9@kaod.org>
Date: Thu, 12 Sep 2024 08:24:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/14] ppc/xive2: Support "Pull Thread Context to Odd
 Thread Reporting Line"
To: Michael Kowal <kowal@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, fbarrat@linux.ibm.com, npiggin@gmail.com,
 milesg@linux.ibm.com
References: <20240909211038.27440-1-kowal@linux.ibm.com>
 <20240909211038.27440-11-kowal@linux.ibm.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240909211038.27440-11-kowal@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=071a=QK=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
> From: Glenn Miles <milesg@linux.vnet.ibm.com>
> 
> Adds support for single byte writes to offset 0xC38 of the TIMA address
> space.  When this offset is written to, the hardware disables the thread
> context and copies the current state information to the odd cache line of
> the pair specified by the NVT structure indexed by the THREAD CAM entry.
> 
> Note that this operation is almost identical to what we are already doing
> for the "Pull OS Context to Odd Thread Reporting Line" operation except
> that it also invalidates the Pool and Thread Contexts.
> 
> Signed-off-by: Glenn Miles <milesg@linux.vnet.ibm.com>
> Signed-off-by: Michael Kowal <kowal@linux.ibm.com>
> ---
>   include/hw/ppc/xive2.h      |  2 ++
>   include/hw/ppc/xive2_regs.h | 16 +++++++++-------
>   include/hw/ppc/xive_regs.h  |  1 +
>   hw/intc/xive.c              |  9 +++++----
>   hw/intc/xive2.c             | 12 +++++++++---
>   5 files changed, 26 insertions(+), 14 deletions(-)
> 
> diff --git a/include/hw/ppc/xive2.h b/include/hw/ppc/xive2.h
> index 36bd0e747f..5bccf41159 100644
> --- a/include/hw/ppc/xive2.h
> +++ b/include/hw/ppc/xive2.h
> @@ -123,5 +123,7 @@ void xive2_tm_pull_os_ctx_ol(XivePresenter *xptr, XiveTCTX *tctx,
>                                hwaddr offset, uint64_t value, unsigned size);
>   void xive2_tm_set_hv_target(XivePresenter *xptr, XiveTCTX *tctx,
>                               hwaddr offset, uint64_t value, unsigned size);
> +void xive2_tm_pull_phys_ctx_ol(XivePresenter *xptr, XiveTCTX *tctx,
> +                               hwaddr offset, uint64_t value, unsigned size);
>   
>   #endif /* PPC_XIVE2_H */
> diff --git a/include/hw/ppc/xive2_regs.h b/include/hw/ppc/xive2_regs.h
> index 99840e88a8..1d00c8df64 100644
> --- a/include/hw/ppc/xive2_regs.h
> +++ b/include/hw/ppc/xive2_regs.h
> @@ -19,16 +19,18 @@
>    * mode (P10), the CAM line is slightly different as the VP space was
>    * increased.
>    */
> -#define   TM2_QW0W2_VU           PPC_BIT32(0)
> +#define   TM2_W2_VALID           PPC_BIT32(0)
> +#define   TM2_W2_HW              PPC_BIT32(1)
> +#define   TM2_QW0W2_VU           TM2_W2_VALID
>   #define   TM2_QW0W2_LOGIC_SERV   PPC_BITMASK32(4, 31)
> -#define   TM2_QW1W2_VO           PPC_BIT32(0)
> -#define   TM2_QW1W2_HO           PPC_BIT32(1)
> +#define   TM2_QW1W2_VO           TM2_W2_VALID
> +#define   TM2_QW1W2_HO           TM2_W2_HW
>   #define   TM2_QW1W2_OS_CAM       PPC_BITMASK32(4, 31)
> -#define   TM2_QW2W2_VP           PPC_BIT32(0)
> -#define   TM2_QW2W2_HP           PPC_BIT32(1)
> +#define   TM2_QW2W2_VP           TM2_W2_VALID
> +#define   TM2_QW2W2_HP           TM2_W2_HW
>   #define   TM2_QW2W2_POOL_CAM     PPC_BITMASK32(4, 31)
> -#define   TM2_QW3W2_VT           PPC_BIT32(0)
> -#define   TM2_QW3W2_HT           PPC_BIT32(1)
> +#define   TM2_QW3W2_VT           TM2_W2_VALID
> +#define   TM2_QW3W2_HT           TM2_W2_HW
>   #define   TM2_QW3W2_LP           PPC_BIT32(6)
>   #define   TM2_QW3W2_LE           PPC_BIT32(7)
>   
> diff --git a/include/hw/ppc/xive_regs.h b/include/hw/ppc/xive_regs.h
> index 558a5ae742..5b11463777 100644
> --- a/include/hw/ppc/xive_regs.h
> +++ b/include/hw/ppc/xive_regs.h
> @@ -138,6 +138,7 @@
>   #define TM_SPC_ACK_HV_POOL_EL   0xc20   /* Store8 ack HV evt pool to even     */
>                                           /* line                               */
>   #define TM_SPC_ACK_HV_EL        0xc30   /* Store8 ack HV irq to even line     */
> +#define TM_SPC_PULL_PHYS_CTX_OL 0xc38   /* Pull phys ctx to odd cache line    */
>   /* XXX more... */
>   
>   /* NSR fields for the various QW ack types */
> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> index f1d007d9a6..9d85da0999 100644
> --- a/hw/intc/xive.c
> +++ b/hw/intc/xive.c
> @@ -117,10 +117,9 @@ static void xive_tctx_notify(XiveTCTX *tctx, uint8_t ring)
>   void xive_tctx_reset_signal(XiveTCTX *tctx, uint8_t ring)
>   {
>       /*
> -     * Lower the External interrupt. Used when pulling an OS
> -     * context. It is necessary to avoid catching it in the hypervisor
> -     * context. It should be raised again when re-pushing the OS
> -     * context.
> +     * Lower the External interrupt. Used when pulling a context. It is
> +     * necessary to avoid catching it in the higher privilege context. It
> +     * should be raised again when re-pushing the lower privilege context.
>        */
>       qemu_irq_lower(xive_tctx_output(tctx, ring));
>   }
> @@ -581,6 +580,8 @@ static const XiveTmOp xive2_tm_operations[] = {
>                                                        NULL },
>       { XIVE_TM_HV_PAGE, TM_SPC_PULL_PHYS_CTX,      1, NULL,
>                                                        xive_tm_pull_phys_ctx },
> +    { XIVE_TM_HV_PAGE, TM_SPC_PULL_PHYS_CTX_OL,   1, xive2_tm_pull_phys_ctx_ol,
> +                                                     NULL },
>   };
>   
>   static const XiveTmOp *xive_tm_find_op(XivePresenter *xptr, hwaddr offset,
> diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
> index 38a4b0ff68..10fcbd04f1 100644
> --- a/hw/intc/xive2.c
> +++ b/hw/intc/xive2.c
> @@ -327,8 +327,8 @@ static void xive2_cam_decode(uint32_t cam, uint8_t *nvp_blk,
>   {
>       *nvp_blk = xive2_nvp_blk(cam);
>       *nvp_idx = xive2_nvp_idx(cam);
> -    *valid = !!(cam & TM2_QW1W2_VO);
> -    *hw = !!(cam & TM2_QW1W2_HO);
> +    *valid = !!(cam & TM2_W2_VALID);
> +    *hw = !!(cam & TM2_W2_HW);
>   }
>   
>   
> @@ -398,7 +398,7 @@ uint64_t xive2_tm_pull_os_ctx(XivePresenter *xptr, XiveTCTX *tctx,
>                                 hwaddr offset, unsigned size)
>   {
>       return xive2_tm_pull_ctx(xptr, tctx, offset, size, TM_QW1_OS);
> - }
> +}

This should be avoided in patch 9.


>   #define REPORT_LINE_GEN1_SIZE       16
>   
> @@ -502,6 +502,12 @@ void xive2_tm_pull_os_ctx_ol(XivePresenter *xptr, XiveTCTX *tctx,
>       xive2_tm_pull_ctx_ol(xptr, tctx, offset, value, size, TM_QW1_OS);
>   }
>   
> +void xive2_tm_pull_phys_ctx_ol(XivePresenter *xptr, XiveTCTX *tctx,
> +                               hwaddr offset, uint64_t value, unsigned size)
> +{
> +    xive2_tm_pull_ctx_ol(xptr, tctx, offset, value, size, TM_QW3_HV_PHYS);
> +}
> +
>   static uint8_t xive2_tctx_restore_os_ctx(Xive2Router *xrtr, XiveTCTX *tctx,
>                                           uint8_t nvp_blk, uint32_t nvp_idx,
>                                           Xive2Nvp *nvp)


