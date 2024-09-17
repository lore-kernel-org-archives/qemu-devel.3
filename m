Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6246ECAC5AC
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2024 23:19:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqhSF-0007ei-KE; Tue, 17 Sep 2024 19:17:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1sqhSD-0007cP-9J; Tue, 17 Sep 2024 19:17:53 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1sqhSB-0007ul-Cw; Tue, 17 Sep 2024 19:17:53 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 0C4954E600F;
 Wed, 18 Sep 2024 01:17:46 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id 83MRX-ehTNyj; Wed, 18 Sep 2024 01:17:44 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 0CC8D4E6000; Wed, 18 Sep 2024 01:17:44 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 09233746F60;
 Wed, 18 Sep 2024 01:17:44 +0200 (CEST)
Date: Wed, 18 Sep 2024 01:17:44 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
cc: qemu-devel@nongnu.org, mst@redhat.com, bcain@quicinc.com, 
 qemu-trivial@nongnu.org
Subject: Re: [PATCH] hw: fix memory leak in IRQState allocation
In-Reply-To: <6f0b480e1f0fbeb9550d447dcbeda920f1869d2d.1726598846.git.quic_mathbern@quicinc.com>
Message-ID: <bd9bb785-8166-0cb0-b61a-80a139a7e1b1@eik.bme.hu>
References: <6f0b480e1f0fbeb9550d447dcbeda920f1869d2d.1726598846.git.quic_mathbern@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, 17 Sep 2024, Matheus Tavares Bernardino wrote:
> At e72a7f65c1 (hw: Move declaration of IRQState to header and add init
> function, 2024-06-29), we've changed qemu_allocate_irq() to use a
> combination of g_new() + object_initialize() instead of
> IRQ(object_new()). The latter sets obj->free, so that that the memory is
> properly cleaned when the object is finalized, but the former doesn't.
>
> Signed-off-by: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>

Sorry for breaking it, I did not know about that feature of object_new. 
Thanks for fixing it.

Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
Fixes: e72a7f65c1 (hw: Move declaration of IRQState to header and add init function)

Regards,
BALATON Zoltan

> ---
> hw/core/irq.c | 19 +++++++++++--------
> 1 file changed, 11 insertions(+), 8 deletions(-)
>
> diff --git a/hw/core/irq.c b/hw/core/irq.c
> index db95ffc18f..7d80de1ca6 100644
> --- a/hw/core/irq.c
> +++ b/hw/core/irq.c
> @@ -34,13 +34,19 @@ void qemu_set_irq(qemu_irq irq, int level)
>     irq->handler(irq->opaque, irq->n, level);
> }
>
> +static void qemu_init_irq_fields(IRQState *irq, qemu_irq_handler handler,
> +                                 void *opaque, int n)
> +{
> +    irq->handler = handler;
> +    irq->opaque = opaque;
> +    irq->n = n;
> +}
> +
> void qemu_init_irq(IRQState *irq, qemu_irq_handler handler, void *opaque,
>                    int n)
> {
>     object_initialize(irq, sizeof(*irq), TYPE_IRQ);
> -    irq->handler = handler;
> -    irq->opaque = opaque;
> -    irq->n = n;
> +    qemu_init_irq_fields(irq, handler, opaque, n);
> }
>
> qemu_irq *qemu_extend_irqs(qemu_irq *old, int n_old, qemu_irq_handler handler,
> @@ -66,11 +72,8 @@ qemu_irq *qemu_allocate_irqs(qemu_irq_handler handler, void *opaque, int n)
>
> qemu_irq qemu_allocate_irq(qemu_irq_handler handler, void *opaque, int n)
> {
> -    IRQState *irq;
> -
> -    irq = g_new(IRQState, 1);
> -    qemu_init_irq(irq, handler, opaque, n);
> -
> +    IRQState *irq = IRQ(object_new(TYPE_IRQ));
> +    qemu_init_irq_fields(irq, handler, opaque, n);
>     return irq;
> }
>
>

