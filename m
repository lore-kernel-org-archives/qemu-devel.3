Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C00DD3399B
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2024 16:23:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5SW3-0003NP-JC; Mon, 28 Oct 2024 12:22:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1t5SVw-0003MK-0L
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 12:22:45 -0400
Received: from mail-lf1-f44.google.com ([209.85.167.44])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1t5SVt-0007SH-PR
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 12:22:43 -0400
Received: by mail-lf1-f44.google.com with SMTP id
 2adb3069b0e04-539f2b95775so5241405e87.1
 for <qemu-devel@nongnu.org>; Mon, 28 Oct 2024 09:22:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730132560; x=1730737360;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+YHY8Nv18pxlCz1uEenyc9ERO/Bsm5FhkStKYBrPiXU=;
 b=w59l2CJHopkZnxAgipDYJ+hciwsMyFc4IV1c3zQ5QaTNUpN+Y2R+8j8bu64iaXE3GH
 sDtGCRWd333++rd1NabWeFaEfvIWp66V+/Ptg6Rp5XxBQlrPZ9lJrGJORaQD4J3C2zVP
 6JevtgONhU7xIMahZ5ITn1YaTN//PBo8gW8fz3CqIwBygqSQgSRDTUW4evTBOHioxFKd
 Y9mcS/FiTZxhf3SSkqfB/ePji9Lp9djM9TFWqhG0bqnYD2qt2MmLIOj952K1AO8jZIzq
 ic2W4epWjgV6cClatk7ikOqSc/os+/UdTEtXr0nlOsluCQVqQsYvHzUKSgtzPlwERVUp
 Nnsw==
X-Gm-Message-State: AOJu0YyxdBh/rnUYQQlC9UyYmxh+EQxRkiaPiGM7VLCenx5YUzRQkyRE
 KA2Zne0q7wpz6HVOSEoYpCdzm7gOIDbBZj/+Q0Y5531q/BHsk5w5Kw154Q==
X-Google-Smtp-Source: AGHT+IGtmecs37+UAuKDf/xgDSPt1IH4SxpkIj+3fT2pEL1VYK3CCseU9vfH6OeghwSjZ7dutnl5pg==
X-Received: by 2002:a05:6512:10c7:b0:52e:936e:a237 with SMTP id
 2adb3069b0e04-53b348cc510mr6790376e87.16.1730132559117; 
 Mon, 28 Oct 2024 09:22:39 -0700 (PDT)
Received: from tpx1 (ip-109-40-241-30.web.vodafone.de. [109.40.241.30])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9b1e1a6b81sm390918766b.43.2024.10.28.09.22.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Oct 2024 09:22:38 -0700 (PDT)
Date: Mon, 28 Oct 2024 17:22:37 +0100
From: Thomas Huth <huth@tuxfamily.org>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 10/36] next-cube: move SCSI 4020 logic from next-pc
 device to next-scsi device
Message-ID: <20241028172237.21e83c92@tpx1>
In-Reply-To: <20241023085852.1061031-11-mark.cave-ayland@ilande.co.uk>
References: <20241023085852.1061031-1-mark.cave-ayland@ilande.co.uk>
 <20241023085852.1061031-11-mark.cave-ayland@ilande.co.uk>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=209.85.167.44; envelope-from=th.huth@gmail.com;
 helo=mail-lf1-f44.google.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Am Wed, 23 Oct 2024 09:58:26 +0100
schrieb Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>:

> The SCSI 4020 logic refers to the offset of the SCSI CSRs within the NeXTCube
> address space. Due to the previously overlapping memory regions, there were
> duplicate MMIO accessors in the next.scr memory region for these registers but
> now this has been resolved. This allows us to move the more complex prototype
> logic into the next-scsi MMIO accessors.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  hw/m68k/next-cube.c | 139 ++++++++++++++++++++------------------------
>  1 file changed, 62 insertions(+), 77 deletions(-)
> 
> diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
> index 32466a425f..22da777006 100644
> --- a/hw/m68k/next-cube.c
> +++ b/hw/m68k/next-cube.c
> @@ -365,8 +365,6 @@ static const MemoryRegionOps next_mmio_ops = {
>  
>  static uint64_t next_scr_readfn(void *opaque, hwaddr addr, unsigned size)
>  {
> -    NeXTPC *s = NEXT_PC(opaque);
> -    NeXTSCSI *ns = NEXT_SCSI(&s->next_scsi);
>      uint64_t val;
>  
>      switch (addr) {
> @@ -375,16 +373,6 @@ static uint64_t next_scr_readfn(void *opaque, hwaddr addr, unsigned size)
>          val = 0x40 | 0x04 | 0x2 | 0x1;
>          break;
>  
> -    case 0x14020:
> -        DPRINTF("SCSI 4020  STATUS READ %X\n", ns->scsi_csr_1);
> -        val = ns->scsi_csr_1;
> -        break;
> -
> -    case 0x14021:
> -        DPRINTF("SCSI 4021 STATUS READ %X\n", ns->scsi_csr_2);
> -        val = 0x40;

Where is that hard-coded 0x40 gone now? Please mention this in the commit
description, otherwise this looks like a mistake?

 Thomas


> -        break;
> -
>      /*
>       * These 4 registers are the hardware timer, not sure which register
>       * is the latch instead of data, but no problems so far.
> @@ -413,9 +401,6 @@ static uint64_t next_scr_readfn(void *opaque, hwaddr addr, unsigned size)
>  static void next_scr_writefn(void *opaque, hwaddr addr, uint64_t val,
>                               unsigned size)
>  {
> -    NeXTPC *s = NEXT_PC(opaque);
> -    NeXTSCSI *ns = NEXT_SCSI(&s->next_scsi);
> -
>      switch (addr) {
>      case 0x14108:
>          DPRINTF("FDCSR Write: %"PRIx64 "\n", val);
> @@ -424,68 +409,6 @@ static void next_scr_writefn(void *opaque, hwaddr addr, uint64_t val,
>          }
>          break;
>  
> -    case 0x14020: /* SCSI Control Register */
> -        if (val & SCSICSR_FIFOFL) {
> -            DPRINTF("SCSICSR FIFO Flush\n");
> -            /* will have to add another irq to the esp if this is needed */
> -            /* esp_puflush_fifo(esp_g); */
> -        }
> -
> -        if (val & SCSICSR_ENABLE) {
> -            DPRINTF("SCSICSR Enable\n");
> -            /*
> -             * qemu_irq_raise(s->scsi_dma);
> -             * s->scsi_csr_1 = 0xc0;
> -             * s->scsi_csr_1 |= 0x1;
> -             * qemu_irq_pulse(s->scsi_dma);
> -             */
> -        }
> -        /*
> -         * else
> -         *     s->scsi_csr_1 &= ~SCSICSR_ENABLE;
> -         */
> -
> -        if (val & SCSICSR_RESET) {
> -            DPRINTF("SCSICSR Reset\n");
> -            /* I think this should set DMADIR. CPUDMA and INTMASK to 0 */
> -            qemu_irq_raise(s->scsi_reset);
> -            ns->scsi_csr_1 &= ~(SCSICSR_INTMASK | 0x80 | 0x1);
> -            qemu_irq_lower(s->scsi_reset);
> -        }
> -        if (val & SCSICSR_DMADIR) {
> -            DPRINTF("SCSICSR DMAdir\n");
> -        }
> -        if (val & SCSICSR_CPUDMA) {
> -            DPRINTF("SCSICSR CPUDMA\n");
> -            /* qemu_irq_raise(s->scsi_dma); */
> -            s->int_status |= 0x4000000;
> -        } else {
> -            /* fprintf(stderr,"SCSICSR CPUDMA disabled\n"); */
> -            s->int_status &= ~(0x4000000);
> -            /* qemu_irq_lower(s->scsi_dma); */
> -        }
> -        if (val & SCSICSR_INTMASK) {
> -            DPRINTF("SCSICSR INTMASK\n");
> -            /*
> -             * int_mask &= ~0x1000;
> -             * s->scsi_csr_1 |= val;
> -             * s->scsi_csr_1 &= ~SCSICSR_INTMASK;
> -             * if (s->scsi_queued) {
> -             *     s->scsi_queued = 0;
> -             *     next_irq(s, NEXT_SCSI_I, level);
> -             * }
> -             */
> -        } else {
> -            /* int_mask |= 0x1000; */
> -        }
> -        if (val & 0x80) {
> -            /* int_mask |= 0x1000; */
> -            /* s->scsi_csr_1 |= 0x80; */
> -        }
> -        DPRINTF("SCSICSR Write: %"PRIx64 "\n", val);
> -        /* s->scsi_csr_1 = val; */
> -        break;
> -
>      /* Hardware timer latch - not implemented yet */
>      case 0x1a000:
>      default:
> @@ -846,13 +769,73 @@ static void next_scsi_csr_write(void *opaque, hwaddr addr, uint64_t val,
>                                  unsigned size)
>  {
>      NeXTSCSI *s = NEXT_SCSI(opaque);
> +    NeXTPC *pc = NEXT_PC(container_of(s, NeXTPC, next_scsi));
>  
>      switch (addr) {
>      case 0:
> +        if (val & SCSICSR_FIFOFL) {
> +            DPRINTF("SCSICSR FIFO Flush\n");
> +            /* will have to add another irq to the esp if this is needed */
> +            /* esp_puflush_fifo(esp_g); */
> +        }
> +
> +        if (val & SCSICSR_ENABLE) {
> +            DPRINTF("SCSICSR Enable\n");
> +            /*
> +             * qemu_irq_raise(s->scsi_dma);
> +             * s->scsi_csr_1 = 0xc0;
> +             * s->scsi_csr_1 |= 0x1;
> +             * qemu_irq_pulse(s->scsi_dma);
> +             */
> +        }
> +        /*
> +         * else
> +         *     s->scsi_csr_1 &= ~SCSICSR_ENABLE;
> +         */
> +
> +        if (val & SCSICSR_RESET) {
> +            DPRINTF("SCSICSR Reset\n");
> +            /* I think this should set DMADIR. CPUDMA and INTMASK to 0 */
> +            qemu_irq_raise(pc->scsi_reset);
> +            s->scsi_csr_1 &= ~(SCSICSR_INTMASK | 0x80 | 0x1);
> +            qemu_irq_lower(pc->scsi_reset);
> +        }
> +        if (val & SCSICSR_DMADIR) {
> +            DPRINTF("SCSICSR DMAdir\n");
> +        }
> +        if (val & SCSICSR_CPUDMA) {
> +            DPRINTF("SCSICSR CPUDMA\n");
> +            /* qemu_irq_raise(s->scsi_dma); */
> +            pc->int_status |= 0x4000000;
> +        } else {
> +            /* fprintf(stderr,"SCSICSR CPUDMA disabled\n"); */
> +            pc->int_status &= ~(0x4000000);
> +            /* qemu_irq_lower(s->scsi_dma); */
> +        }
> +        if (val & SCSICSR_INTMASK) {
> +            DPRINTF("SCSICSR INTMASK\n");
> +            /*
> +             * int_mask &= ~0x1000;
> +             * s->scsi_csr_1 |= val;
> +             * s->scsi_csr_1 &= ~SCSICSR_INTMASK;
> +             * if (s->scsi_queued) {
> +             *     s->scsi_queued = 0;
> +             *     next_irq(s, NEXT_SCSI_I, level);
> +             * }
> +             */
> +        } else {
> +            /* int_mask |= 0x1000; */
> +        }
> +        if (val & 0x80) {
> +            /* int_mask |= 0x1000; */
> +            /* s->scsi_csr_1 |= 0x80; */
> +        }
> +        DPRINTF("SCSICSR1 Write: %"PRIx64 "\n", val);
>          s->scsi_csr_1 = val;
>          break;
>  
>      case 1:
> +        DPRINTF("SCSICSR2 Write: %"PRIx64 "\n", val);
>          s->scsi_csr_2 = val;
>          break;
>  
> @@ -868,10 +851,12 @@ static uint64_t next_scsi_csr_read(void *opaque, hwaddr addr, unsigned size)
>  
>      switch (addr) {
>      case 0:
> +        DPRINTF("SCSI 4020  STATUS READ %X\n", s->scsi_csr_1);
>          val = s->scsi_csr_1;
>          break;
>  
>      case 1:
> +        DPRINTF("SCSI 4021 STATUS READ %X\n", s->scsi_csr_2);
>          val = s->scsi_csr_2;
>          break;
>  

