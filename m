Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEC34D10BE8
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2024 07:57:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4bfN-0001Sd-LA; Sat, 26 Oct 2024 03:56:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1t4bfL-0001SQ-Ja
 for qemu-devel@nongnu.org; Sat, 26 Oct 2024 03:56:55 -0400
Received: from mail-ed1-f42.google.com ([209.85.208.42])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1t4bfJ-0008PY-HL
 for qemu-devel@nongnu.org; Sat, 26 Oct 2024 03:56:55 -0400
Received: by mail-ed1-f42.google.com with SMTP id
 4fb4d7f45d1cf-5c9c28c1e63so3215574a12.0
 for <qemu-devel@nongnu.org>; Sat, 26 Oct 2024 00:56:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729929412; x=1730534212;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mkiV4szHhk2528/pRtDT/3rsCXTkuJVdEld2571UcWM=;
 b=u3b6lm4TwHaDEjphAImeFOHm9DqWpWpGsZcDvF5hWwUzSQCoOEnv84xS6rDQCaLNmo
 ZbjO3EIpZHaEzyXQL3ftStG/5NNJuELN55JDNHX/HnKHcVerLxAT52e1dOvYCW3C5m4H
 +gQZSFcULVU2jYokG/WfB3jCMNJjTWj/tyGlTs3YGkuLymbebiuegsVfWVDaDcALQ/SJ
 w3y2j/9rzTcWbR5nQoc+0sPnHCLdn53WhWMwgyBGi94qE15/hyeCmz3LJ/Am+wdrJw4S
 7MGzRQuJeiFF8Qiwc+8FmwV1w1H//j9ije5rOaIhHt7/n4BrPv9ShxLWAPJYGCCaAv3i
 b5Gw==
X-Gm-Message-State: AOJu0Yy7nlB4d7AxATpinhYtBdfjtgReBTp8GX/TPb1XyG8HmV1fUnAk
 kQlNIX7Hirxoch0zarz1pZzI+u0QINJG65l3iUi944S1tO06lnXExJYI9A==
X-Google-Smtp-Source: AGHT+IF9HD96v3Qw0QCWam9hCGr2SJwznDVfs3hpWVR+WB/N7d11n6YoTdenic39TMfeeMrg4hds6Q==
X-Received: by 2002:a17:906:f58e:b0:a9a:4e77:92f with SMTP id
 a640c23a62f3a-a9de619b1f0mr142549166b.56.1729929411492; 
 Sat, 26 Oct 2024 00:56:51 -0700 (PDT)
Received: from tpx1 (ip-109-40-241-30.web.vodafone.de. [109.40.241.30])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5cbb634737fsm1325600a12.82.2024.10.26.00.56.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Oct 2024 00:56:50 -0700 (PDT)
Date: Sat, 26 Oct 2024 09:56:48 +0200
From: Thomas Huth <huth@tuxfamily.org>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 03/36] next-cube: remove overlap between next.dma and
 next.mmio memory regions
Message-ID: <20241026095648.15865fbb@tpx1>
In-Reply-To: <20241023085852.1061031-4-mark.cave-ayland@ilande.co.uk>
References: <20241023085852.1061031-1-mark.cave-ayland@ilande.co.uk>
 <20241023085852.1061031-4-mark.cave-ayland@ilande.co.uk>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=209.85.208.42; envelope-from=th.huth@gmail.com;
 helo=mail-ed1-f42.google.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.17, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-1.697, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Am Wed, 23 Oct 2024 09:58:19 +0100
schrieb Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>:

> Change the start of the next.mmio memory region so that it follows on directly
> after the next.dma memory region, adjusting the address offsets in
> next_mmio_read() and next_mmio_write() accordingly.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  hw/m68k/next-cube.c | 28 ++++++++++++++--------------
>  1 file changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
> index 4e8e55a8bd..e1d94c1ce0 100644
> --- a/hw/m68k/next-cube.c
> +++ b/hw/m68k/next-cube.c
> @@ -266,23 +266,23 @@ static uint64_t next_mmio_read(void *opaque, hwaddr addr, unsigned size)
>      uint64_t val;
>  
>      switch (addr) {
> -    case 0x7000:
> +    case 0x2000:
>          /* DPRINTF("Read INT status: %x\n", s->int_status); */
>          val = s->int_status;
>          break;
>  
> -    case 0x7800:
> +    case 0x2800:
>          DPRINTF("MMIO Read INT mask: %x\n", s->int_mask);
>          val = s->int_mask;
>          break;
>  
> -    case 0xc000 ... 0xc003:
> -        val = extract32(s->scr1, (4 - (addr - 0xc000) - size) << 3,
> +    case 0x7000 ... 0x7003:
> +        val = extract32(s->scr1, (4 - (addr - 0x7000) - size) << 3,
>                          size << 3);
>          break;
>  
> -    case 0xd000 ... 0xd003:
> -        val = extract32(s->scr2, (4 - (addr - 0xd000) - size) << 3,
> +    case 0x8000 ... 0x8003:
> +        val = extract32(s->scr2, (4 - (addr - 0x8000) - size) << 3,
>                          size << 3);
>          break;
>  
> @@ -301,25 +301,25 @@ static void next_mmio_write(void *opaque, hwaddr addr, uint64_t val,
>      NeXTPC *s = NEXT_PC(opaque);
>  
>      switch (addr) {
> -    case 0x7000:
> +    case 0x2000:
>          DPRINTF("INT Status old: %x new: %x\n", s->int_status,
>                  (unsigned int)val);
>          s->int_status = val;
>          break;
>  
> -    case 0x7800:
> +    case 0x2800:
>          DPRINTF("INT Mask old: %x new: %x\n", s->int_mask, (unsigned int)val);
>          s->int_mask  = val;
>          break;

Could you please add comments at the end of the "case" lines, stating which
mmio addresses are handled in each case? Otherwise, it's harder to grep for
certain addresses later. E.g:

    case 0x2800:     /* 0x2007800 */

> @@ -1000,7 +1000,7 @@ static void next_cube_init(MachineState *machine)
>      sysbus_create_simple(TYPE_NEXTFB, 0x0B000000, NULL);
>  
>      /* MMIO */
> -    sysbus_mmio_map(SYS_BUS_DEVICE(pcdev), 0, 0x02000000);
> +    sysbus_mmio_map(SYS_BUS_DEVICE(pcdev), 0, 0x02005000);

Why 0x02005000 and not directly 0x02007000 ?

I think there is another range at 0x02006000 related to the ethernet
controller, so directly going with 0x02007000 might cause less friction
later when we add the NIC?

 Thanks,
  Thomas

