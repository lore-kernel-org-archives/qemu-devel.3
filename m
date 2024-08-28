Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F8C1C54ED1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2024 11:50:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjHBp-0001pB-7S; Wed, 28 Aug 2024 07:50:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=2BaY=P3=kaod.org=clg@ozlabs.org>)
 id 1sjHBn-0001o5-0j; Wed, 28 Aug 2024 07:50:15 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=2BaY=P3=kaod.org=clg@ozlabs.org>)
 id 1sjHBk-0005Jz-60; Wed, 28 Aug 2024 07:50:14 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4Wv2lW6MGZz4wxx;
 Wed, 28 Aug 2024 21:49:59 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Wv2lT3lbdz4wxJ;
 Wed, 28 Aug 2024 21:49:57 +1000 (AEST)
Message-ID: <461d5091-e1f0-4ad3-a809-b46383ba1e26@kaod.org>
Date: Wed, 28 Aug 2024 13:49:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/13] pnv/xive2: TIMA CI ops using alternative offsets or
 byte lengths
To: Michael Kowal <kowal@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, fbarrat@linux.ibm.com, npiggin@gmail.com,
 milesg@linux.ibm.com
References: <20240801203008.11224-1-kowal@linux.ibm.com>
 <20240801203008.11224-14-kowal@linux.ibm.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240801203008.11224-14-kowal@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=2BaY=P3=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
> Some of the TIMA Special CI operations perform the same operation at
> alternative byte offsets and lengths.  The following
> xive2_tm_opertions[] table entries are missing when they exist for
> other offsets/sizes and have been added:
> - lwz@0x810 Pull/Invalidate O/S Context to register    added
>    lwz@0x818                                            exists
>    ld @0x818                                            exists
> - lwz@0x820 Pull Pool Context to register              added
>    lwz@0x828                                            exists
>    ld @0x828                                            exists
> - lwz@0x830 Pull Thread Context to register            added
>    lbz@0x838                                            exists
> 
> Signed-off-by: Michael Kowal <kowal@linux.ibm.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   include/hw/ppc/xive_regs.h | 7 ++++++-
>   hw/intc/xive.c             | 6 ++++++
>   2 files changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/include/hw/ppc/xive_regs.h b/include/hw/ppc/xive_regs.h
> index 5b11463777..326327fc79 100644
> --- a/include/hw/ppc/xive_regs.h
> +++ b/include/hw/ppc/xive_regs.h
> @@ -124,12 +124,17 @@
>   #define TM_SPC_PULL_USR_CTX     0x808   /* Load32 Pull/Invalidate user        */
>                                           /* context                            */
>   #define TM_SPC_SET_OS_PENDING   0x812   /* Store8 Set OS irq pending bit      */
> +#define TM_SPC_PULL_OS_CTX_G2   0x810   /* Load32/Load64 Pull/Invalidate OS   */
> +                                        /* context to reg                     */
>   #define TM_SPC_PULL_OS_CTX      0x818   /* Load32/Load64 Pull/Invalidate OS   */
>                                           /* context to reg                     */
> +#define TM_SPC_PULL_POOL_CTX_G2 0x820   /* Load32/Load64 Pull/Invalidate Pool */
> +                                        /* context to reg                     */
>   #define TM_SPC_PULL_POOL_CTX    0x828   /* Load32/Load64 Pull/Invalidate Pool */
>                                           /* context to reg                     */
>   #define TM_SPC_ACK_HV_REG       0x830   /* Load16 ack HV irq to reg           */
> -#define TM_SPC_PULL_PHYS_CTX    0x838   /* Pull phys ctx to reg               */
> +#define TM_SPC_PULL_PHYS_CTX_G2 0x830   /* Load32 Pull phys ctx to reg        */
> +#define TM_SPC_PULL_PHYS_CTX    0x838   /* Load8  Pull phys ctx to reg        */
>   #define TM_SPC_PULL_USR_CTX_OL  0xc08   /* Store8 Pull/Inval usr ctx to odd   */
>                                           /* line                               */
>   #define TM_SPC_ACK_OS_EL        0xc10   /* Store8 ack OS irq to even line     */
> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> index 99c8bea598..ce1504fbed 100644
> --- a/hw/intc/xive.c
> +++ b/hw/intc/xive.c
> @@ -614,18 +614,24 @@ static const XiveTmOp xive2_tm_operations[] = {
>                                                        xive_tm_ack_os_reg },
>       { XIVE_TM_OS_PAGE, TM_SPC_SET_OS_PENDING,     1, xive_tm_set_os_pending,
>                                                        NULL },
> +    { XIVE_TM_HV_PAGE, TM_SPC_PULL_OS_CTX_G2,     4, NULL,
> +                                                     xive2_tm_pull_os_ctx },
>       { XIVE_TM_HV_PAGE, TM_SPC_PULL_OS_CTX,        4, NULL,
>                                                        xive2_tm_pull_os_ctx },
>       { XIVE_TM_HV_PAGE, TM_SPC_PULL_OS_CTX,        8, NULL,
>                                                        xive2_tm_pull_os_ctx },
>       { XIVE_TM_HV_PAGE, TM_SPC_ACK_HV_REG,         2, NULL,
>                                                        xive_tm_ack_hv_reg },
> +    { XIVE_TM_HV_PAGE, TM_SPC_PULL_POOL_CTX_G2,   4, NULL,
> +                                                     xive_tm_pull_pool_ctx },
>       { XIVE_TM_HV_PAGE, TM_SPC_PULL_POOL_CTX,      4, NULL,
>                                                        xive_tm_pull_pool_ctx },
>       { XIVE_TM_HV_PAGE, TM_SPC_PULL_POOL_CTX,      8, NULL,
>                                                        xive_tm_pull_pool_ctx },
>       { XIVE_TM_HV_PAGE, TM_SPC_PULL_OS_CTX_OL,     1, xive2_tm_pull_os_ctx_ol,
>                                                        NULL },
> +    { XIVE_TM_HV_PAGE, TM_SPC_PULL_PHYS_CTX_G2,   4, NULL,
> +                                                     xive_tm_pull_phys_ctx },
>       { XIVE_TM_HV_PAGE, TM_SPC_PULL_PHYS_CTX,      1, NULL,
>                                                        xive_tm_pull_phys_ctx },
>       { XIVE_TM_HV_PAGE, TM_SPC_PULL_PHYS_CTX_OL,   1, xive2_tm_pull_phys_ctx_ol,


