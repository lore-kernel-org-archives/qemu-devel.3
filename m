Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56455C98318
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Sep 2026 11:52:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAQvo-0000AT-6n; Sat, 26 Sep 2026 07:51:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1xAQvl-00009d-8n; Sat, 26 Sep 2026 07:51:01 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1xAQvj-0007s1-Hv; Sat, 26 Sep 2026 07:51:01 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 546675832AB;
 Sat, 26 Sep 2026 13:50:56 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id rPzUHyng_9Ng; Sat, 26 Sep 2026 13:50:54 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 3045A583223; Sat, 26 Sep 2026 13:50:54 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 2E6935831F0;
 Sat, 26 Sep 2026 13:50:54 +0200 (CEST)
Date: Sat, 26 Sep 2026 13:50:54 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
cc: jsnow@redhat.com, den@openvz.org, qemu-block@nongnu.org, 
 qemu-devel@nongnu.org
Subject: Re: [PATCH] ide/macio.c: use pmac_ide_transfer_cb() for disk DMA
 read callback
In-Reply-To: <20260926074425.468348-1-mark.cave-ayland@ilande.co.uk>
Message-ID: <fcdeb3fc-dba5-a625-5a0f-c5686a061358@eik.bme.hu>
References: <20260926074425.468348-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_MSPIKE_H2=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Sat, 26 Sep 2026, Mark Cave-Ayland wrote:
> Since its original implementation the disk DMA callback pmac_ide_transfer_cb()
> accidentally made use of the CDROM DMA read callback pmac_ide_atapi_transfer_cb()
> for disk DMA reads instead of itself.
>
> Fixes: be1e343995e ("macio: switch over to new byte-aligned DMA helpers")
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>

I'm not too familiar with this device but the change looks OK as far as I 
can tell.

Regards,
BALATON Zoltan

> ---
> hw/ide/macio.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/ide/macio.c b/hw/ide/macio.c
> index 40fb4f3b4f3..a95e68083f4 100644
> --- a/hw/ide/macio.c
> +++ b/hw/ide/macio.c
> @@ -180,7 +180,7 @@ static void pmac_ide_transfer_cb(void *opaque, int ret)
>     switch (s->dma_cmd) {
>     case IDE_DMA_READ:
>         s->bus->dma->aiocb = dma_blk_read(s->blk, &s->sg, offset, 0x1,
> -                                          pmac_ide_atapi_transfer_cb, io);
> +                                          pmac_ide_transfer_cb, io);
>         break;
>     case IDE_DMA_WRITE:
>         s->bus->dma->aiocb = dma_blk_write(s->blk, &s->sg, offset, 0x1,
>

