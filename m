Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 012B8C5321E
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2024 11:47:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1siYB8-0000Py-5o; Mon, 26 Aug 2024 07:46:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=7wMH=PZ=kaod.org=clg@ozlabs.org>)
 id 1siYB2-0000Oi-Pv; Mon, 26 Aug 2024 07:46:28 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=7wMH=PZ=kaod.org=clg@ozlabs.org>)
 id 1siYB0-00073o-L2; Mon, 26 Aug 2024 07:46:28 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4WspmG10Nlz4x11;
 Mon, 26 Aug 2024 21:46:22 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4WspmC5qt7z4wc3;
 Mon, 26 Aug 2024 21:46:19 +1000 (AEST)
Message-ID: <496cadfe-f9dd-4ec3-8ff7-0aee2edea10f@kaod.org>
Date: Mon, 26 Aug 2024 13:46:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/13] ppc/xive2: Support "Pull Thread Context to
 Register" operation
To: Michael Kowal <kowal@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, fbarrat@linux.ibm.com, npiggin@gmail.com,
 milesg@linux.ibm.com
References: <20240801203008.11224-1-kowal@linux.ibm.com>
 <20240801203008.11224-9-kowal@linux.ibm.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240801203008.11224-9-kowal@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=7wMH=PZ=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 8/1/24 22:30, Michael Kowal wrote:
> From: Glenn Miles <milesg@linux.vnet.ibm.com>
> 
> Adds support for single byte read of offset 0x838 of the TIMA address
> space.  According to the XIVE2 Specification, this causes the hardware
> to atomically:
>    1. Read the number of bytes requested (lbz or lhz are supported).
>    2. Reset the valid bit of the thread context.
>    3. Return the number of bytes requested in step 1 to a register.
> 
> Signed-off-by: Glenn Miles <milesg@linux.vnet.ibm.com>
> Signed-off-by: Michael Kowal <kowal@linux.ibm.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   include/hw/ppc/xive_regs.h |  2 ++
>   hw/intc/xive.c             | 15 +++++++++++++++
>   2 files changed, 17 insertions(+)
> 
> diff --git a/include/hw/ppc/xive_regs.h b/include/hw/ppc/xive_regs.h
> index f8f05deafd..558a5ae742 100644
> --- a/include/hw/ppc/xive_regs.h
> +++ b/include/hw/ppc/xive_regs.h
> @@ -101,6 +101,7 @@
>   #define   TM_QW3W2_LP           PPC_BIT32(6)
>   #define   TM_QW3W2_LE           PPC_BIT32(7)
>   #define   TM_QW3W2_T            PPC_BIT32(31)
> +#define   TM_QW3B8_VT           PPC_BIT8(0)
>   
>   /*
>    * In addition to normal loads to "peek" and writes (only when invalid)
> @@ -128,6 +129,7 @@
>   #define TM_SPC_PULL_POOL_CTX    0x828   /* Load32/Load64 Pull/Invalidate Pool */
>                                           /* context to reg                     */
>   #define TM_SPC_ACK_HV_REG       0x830   /* Load16 ack HV irq to reg           */
> +#define TM_SPC_PULL_PHYS_CTX    0x838   /* Pull phys ctx to reg               */
>   #define TM_SPC_PULL_USR_CTX_OL  0xc08   /* Store8 Pull/Inval usr ctx to odd   */
>                                           /* line                               */
>   #define TM_SPC_ACK_OS_EL        0xc10   /* Store8 ack OS irq to even line     */
> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> index 6229a6f870..5b66a3aec5 100644
> --- a/hw/intc/xive.c
> +++ b/hw/intc/xive.c
> @@ -179,6 +179,17 @@ static uint64_t xive_tm_pull_pool_ctx(XivePresenter *xptr, XiveTCTX *tctx,
>       return qw2w2;
>   }
>   
> +static uint64_t xive_tm_pull_phys_ctx(XivePresenter *xptr, XiveTCTX *tctx,
> +                                      hwaddr offset, unsigned size)
> +{
> +    uint8_t qw3b8_prev = tctx->regs[TM_QW3_HV_PHYS + TM_WORD2];
> +    uint8_t qw3b8;
> +
> +    qw3b8 = qw3b8_prev & ~TM_QW3B8_VT;
> +    tctx->regs[TM_QW3_HV_PHYS + TM_WORD2] = qw3b8;
> +    return qw3b8;
> +}
> +
>   static void xive_tm_vt_push(XivePresenter *xptr, XiveTCTX *tctx, hwaddr offset,
>                               uint64_t value, unsigned size)
>   {
> @@ -527,6 +538,8 @@ static const XiveTmOp xive_tm_operations[] = {
>                                                        xive_tm_pull_pool_ctx },
>       { XIVE_TM_HV_PAGE, TM_SPC_PULL_POOL_CTX,      8, NULL,
>                                                        xive_tm_pull_pool_ctx },
> +    { XIVE_TM_HV_PAGE, TM_SPC_PULL_PHYS_CTX,      1, NULL,
> +                                                     xive_tm_pull_phys_ctx },
>   };
>   
>   static const XiveTmOp xive2_tm_operations[] = {
> @@ -566,6 +579,8 @@ static const XiveTmOp xive2_tm_operations[] = {
>                                                        xive_tm_pull_pool_ctx },
>       { XIVE_TM_HV_PAGE, TM_SPC_PULL_OS_CTX_OL,     1, xive2_tm_pull_os_ctx_ol,
>                                                        NULL },
> +    { XIVE_TM_HV_PAGE, TM_SPC_PULL_PHYS_CTX,      1, NULL,
> +                                                     xive_tm_pull_phys_ctx },
>   };
>   
>   static const XiveTmOp *xive_tm_find_op(XivePresenter *xptr, hwaddr offset,


