Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A81EE7717F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 19:44:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMBaU-0003LN-NV; Fri, 13 Dec 2024 14:44:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1tMBaS-0003JH-J8
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 14:44:32 -0500
Received: from mail-lf1-f48.google.com ([209.85.167.48])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1tMBaN-0007Yn-Hk
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 14:44:32 -0500
Received: by mail-lf1-f48.google.com with SMTP id
 2adb3069b0e04-54024aa9febso2051256e87.1
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 11:44:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734119065; x=1734723865;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5Nq3ws/zMtmnvbUKGqCFjeNX1CVnceTvqSjX93z/veo=;
 b=sImVfixYzfWibivP5H4Ke+IiBm1JYXSV1bYWg0T872wQxX6dYPsip7R/+Kuu0bGv98
 zEaNimI+geR0hDnf9f/Bs9M3UEZL9OrIP/xeI8sTPliVHrIslEwtC/YOuPPg1wf7hWp8
 dDZZ87pcrYSY3JHzGIZPXqN68KkoSyVcf/ZSJ7pviu2TwVIEaaPlTHr0WCfYy/SFU0IJ
 5sfSzXvbx6UyjPmHtSwt8Q7822qunUpjonFuFHXA34VffFIBzlcFOxmhpqZohEmZzNrc
 2ari6X9K68ctYkV70QI0nxTbmhIilVVcrhbk65QnCUNFRJRbdOQSocH2hxBk8YaQ5euL
 anKA==
X-Gm-Message-State: AOJu0Yx6mIe9GeMYKrUTcPu+IxiVhnj/UwMu34qucPSSxzT4e/rYeWPR
 MHx4A/EuwEU27i7tZyGnv9+S6JRdUQmQ86eOnI4qxqrBbRV5y+GpS8PClw==
X-Gm-Gg: ASbGnctI4m3C0KQz7C1ZkFATI7KnF+jpTNKH13HfRtgElJpUApYuk7byRBAJA5r8UlJ
 0uHRgpDz9CL4gRSTcbVQ4rceZFW9mFPcyEgCoC9cH+Nk/QqQpf/2iV4AdfAy5shHJK/6Yho6tqC
 CtyOVEmjsZkaccE0KNx7BqLb52lUkQ4vChMvUcZOtqUy/9AHZ8uyGkSYvDxBjTHWlZ095RCQUpz
 jg0ICrSoO9wV8r0b7tyB4sRn41NwSLuuvon+eJv//nwiQUmPpdI+GWVGXthydZitIkrR5M792bk
X-Google-Smtp-Source: AGHT+IFKLbKUEN5NT4xfpfIarze5MwNFh4eRXkmOUdWMJsnLUxVbf+nMBhFvoisJXMBgfEcVfSIG1g==
X-Received: by 2002:a17:906:2931:b0:aa6:85d0:1486 with SMTP id
 a640c23a62f3a-aab77ee9688mr341687366b.54.1734118644543; 
 Fri, 13 Dec 2024 11:37:24 -0800 (PST)
Received: from tpx1 (ip-109-42-51-17.web.vodafone.de. [109.42.51.17])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aab9600e02esm7287766b.15.2024.12.13.11.37.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 11:37:24 -0800 (PST)
Date: Fri, 13 Dec 2024 20:37:22 +0100
From: Thomas Huth <huth@tuxfamily.org>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v2 02/34] next-cube: remove overlap between next.dma and
 next.mmio memory regions
Message-ID: <20241213203722.62490442@tpx1>
In-Reply-To: <20241212114620.549285-3-mark.cave-ayland@ilande.co.uk>
References: <20241212114620.549285-1-mark.cave-ayland@ilande.co.uk>
 <20241212114620.549285-3-mark.cave-ayland@ilande.co.uk>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=209.85.167.48; envelope-from=th.huth@gmail.com;
 helo=mail-lf1-f48.google.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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


 Hi Mark!

Am Thu, 12 Dec 2024 11:45:48 +0000
schrieb Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>:

> Change the start of the next.mmio memory region so that it follows on dir=
ectly
> after the next.dma memory region. Increase the address offsets in
> next_mmio_read() and next_mmio_write(), and reduce the size of the next.m=
mio
> memory region accordingly.
>=20
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  hw/m68k/next-cube.c | 28 ++++++++++++++--------------
>  1 file changed, 14 insertions(+), 14 deletions(-)
>=20
> diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
> index 0418fbc8aa..550e7f0b0a 100644
> --- a/hw/m68k/next-cube.c
> +++ b/hw/m68k/next-cube.c
> @@ -266,23 +266,23 @@ static uint64_t next_mmio_read(void *opaque, hwaddr=
 addr, unsigned size)
>      uint64_t val;
> =20
>      switch (addr) {
> -    case 0x7000:
> +    case 0x2000:    /* 0x2005000 */
>          /* DPRINTF("Read INT status: %x\n", s->int_status); */
>          val =3D s->int_status;
>          break;
> =20
> -    case 0x7800:
> +    case 0x2800:    /* 0x2007800 */
>          DPRINTF("MMIO Read INT mask: %x\n", s->int_mask);
>          val =3D s->int_mask;
>          break;
> =20
> -    case 0xc000 ... 0xc003:
> -        val =3D extract32(s->scr1, (4 - (addr - 0xc000) - size) << 3,
> +    case 0x7000 ... 0x7003:    /* 0x200c000 */
> +        val =3D extract32(s->scr1, (4 - (addr - 0x7000) - size) << 3,
>                          size << 3);
>          break;
> =20
> -    case 0xd000 ... 0xd003:
> -        val =3D extract32(s->scr2, (4 - (addr - 0xd000) - size) << 3,
> +    case 0x8000 ... 0x8003:    /* 0x200d000 */
> +        val =3D extract32(s->scr2, (4 - (addr - 0x8000) - size) << 3,
>                          size << 3);
>          break;
> =20
> @@ -301,25 +301,25 @@ static void next_mmio_write(void *opaque, hwaddr ad=
dr, uint64_t val,
>      NeXTPC *s =3D NEXT_PC(opaque);
> =20
>      switch (addr) {
> -    case 0x7000:
> +    case 0x2000:    /* 0x2005000 */

Comment should be /* 0x2007000 */ instead.

With that fixed:

Reviewed-by: Thomas Huth <huth@tuxfamily.org>

