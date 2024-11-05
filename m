Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C3EFD3E779
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 22:39:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8SCQ-0002fU-Bx; Tue, 05 Nov 2024 17:38:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t8SCP-0002fI-8r; Tue, 05 Nov 2024 17:38:57 -0500
Received: from mail-ua1-x930.google.com ([2607:f8b0:4864:20::930])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t8SCN-0002S9-ME; Tue, 05 Nov 2024 17:38:57 -0500
Received: by mail-ua1-x930.google.com with SMTP id
 a1e0cc1a2514c-851d6c397bbso1943842241.2; 
 Tue, 05 Nov 2024 14:38:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730846334; x=1731451134; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ShFGJTpVKFc9QmQlqenOsyPYzBf+Ir7f6DuZ968ajtE=;
 b=SNLOUcARxc85DmXVH80uZeQDeb5IgXsmLwqZBTCmnlwb6DgjFihEfT+l73iQxGWe7C
 VKwzegIlfyumYru/sHjDcOaknmpxy4NQCQe1IM8X7GWUJ6DORtL+sKWP9rmINdNmjnBp
 IZrrWdC7FO+KeQP1bYU65CHOaeCQ3glwsTKUEYOQQomb+w6+co/oINjbpWNESuFcb+Mf
 zFWFyrcAhazzIHAo8rHocqakc8tmvxdY1TB6a6Nswz2jITy/Dmu2Xap6kfcN1rd9jo2S
 4l5UnGFqOjNScXNiZpsAWG7MOUCZESPX5nYF/V2IwNtILsoh+cTF31hst4tkYEN6Fbfn
 URYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730846334; x=1731451134;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ShFGJTpVKFc9QmQlqenOsyPYzBf+Ir7f6DuZ968ajtE=;
 b=jfclHzVLEXo+HyIo4SB3W3xwrn5IYSQfMLjRmVZ9GVIvrljCEk+yWWCrhsJQcQ07Hp
 3ykyGRa8URThdLdxpbHLQGf0tWYHnZoCYyErSwe9aTbYNSH2XKFvYBjxtYxQgEBaSBut
 NOVt7aisL6z8JgUBDXSith4THct4cnl8TuJiPr76OfMdk2sh5KrAPqxlom0z+qyAv4Mp
 2CMSNcBatrTv9chr/lXpDT5d1tbYSgIdB0IDtD779x9taXXMAwgvgq/rt9b77xwHkZYs
 KhNw8c2XeAlfjX+jz+okPJJ9EbqqAf6/MV7ZRQiyiqieNm+Q+6WbyQvPaHV6BlHNBu89
 wpGQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUM2UzosK8fhYUEG97UK4DoFrEwVvnf+jFAAQe7rlupG6Za8kD9EbWpjrRprWw8AWfBtgEDVYDZdw==@nongnu.org
X-Gm-Message-State: AOJu0YwE81od6f/GGlDGwsN9Rwnpds+6nnfTBE3/vMcAMxk3burCpgFu
 Dh+OAdTL46NOzEaQgmaN9SANxONadPPvzg7YNGJOUW0D/EDgs1Lp+bEMJ8Uw6SQaoshEC6t24Go
 HdyCj+9HyvnmITXZ1WjLsNWxi88g=
X-Google-Smtp-Source: AGHT+IGcwijgiRe68qjANus4ylg5oxWU0NQ/SEtlq+irkXpj53n/LErJL74Q5mcNhPgirUrzEJeO0Fc5BkGwwoUms58=
X-Received: by 2002:a05:6102:6cc:b0:4a5:6f41:211e with SMTP id
 ada2fe7eead31-4a8cfd598demr33376274137.24.1730846334280; Tue, 05 Nov 2024
 14:38:54 -0800 (PST)
MIME-Version: 1.0
References: <20241105130431.22564-1-philmd@linaro.org>
 <20241105130431.22564-7-philmd@linaro.org>
In-Reply-To: <20241105130431.22564-7-philmd@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 6 Nov 2024 08:38:28 +1000
Message-ID: <CAKmqyKMBaGoH_iXiQqX3TBuAJteGRA6UcXsFDuRqBSU-yLytaw@mail.gmail.com>
Subject: Re: [PATCH 06/19] hw/microblaze: Fix MemoryRegionOps coding style
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Anton Johansson <anjo@rev.ng>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Alistair Francis <alistair@alistair23.me>, Thomas Huth <thuth@redhat.com>,
 qemu-arm@nongnu.org, devel@lists.libvirt.org,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::930;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x930.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Tue, Nov 5, 2024 at 11:07=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> Fix few MemoryRegionOps style before adding new fields
> in the following commits.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/char/xilinx_uartlite.c | 4 ++--
>  hw/intc/xilinx_intc.c     | 4 ++--
>  hw/net/xilinx_ethlite.c   | 4 ++--
>  hw/timer/xilinx_timer.c   | 4 ++--
>  4 files changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/hw/char/xilinx_uartlite.c b/hw/char/xilinx_uartlite.c
> index f325084f8b9..a69ad769cc4 100644
> --- a/hw/char/xilinx_uartlite.c
> +++ b/hw/char/xilinx_uartlite.c
> @@ -172,8 +172,8 @@ static const MemoryRegionOps uart_ops =3D {
>      .endianness =3D DEVICE_NATIVE_ENDIAN,
>      .valid =3D {
>          .min_access_size =3D 1,
> -        .max_access_size =3D 4
> -    }
> +        .max_access_size =3D 4,
> +    },
>  };
>
>  static Property xilinx_uartlite_properties[] =3D {
> diff --git a/hw/intc/xilinx_intc.c b/hw/intc/xilinx_intc.c
> index 6e5012e66eb..2b8246f6206 100644
> --- a/hw/intc/xilinx_intc.c
> +++ b/hw/intc/xilinx_intc.c
> @@ -146,8 +146,8 @@ static const MemoryRegionOps pic_ops =3D {
>      .endianness =3D DEVICE_NATIVE_ENDIAN,
>      .valid =3D {
>          .min_access_size =3D 4,
> -        .max_access_size =3D 4
> -    }
> +        .max_access_size =3D 4,
> +    },
>  };
>
>  static void irq_handler(void *opaque, int irq, int level)
> diff --git a/hw/net/xilinx_ethlite.c b/hw/net/xilinx_ethlite.c
> index bd812908085..11eb53c4d60 100644
> --- a/hw/net/xilinx_ethlite.c
> +++ b/hw/net/xilinx_ethlite.c
> @@ -172,8 +172,8 @@ static const MemoryRegionOps eth_ops =3D {
>      .endianness =3D DEVICE_NATIVE_ENDIAN,
>      .valid =3D {
>          .min_access_size =3D 4,
> -        .max_access_size =3D 4
> -    }
> +        .max_access_size =3D 4,
> +    },
>  };
>
>  static bool eth_can_rx(NetClientState *nc)
> diff --git a/hw/timer/xilinx_timer.c b/hw/timer/xilinx_timer.c
> index 32a9df69e0b..0822345779c 100644
> --- a/hw/timer/xilinx_timer.c
> +++ b/hw/timer/xilinx_timer.c
> @@ -195,8 +195,8 @@ static const MemoryRegionOps timer_ops =3D {
>      .endianness =3D DEVICE_NATIVE_ENDIAN,
>      .valid =3D {
>          .min_access_size =3D 4,
> -        .max_access_size =3D 4
> -    }
> +        .max_access_size =3D 4,
> +    },
>  };
>
>  static void timer_hit(void *opaque)
> --
> 2.45.2
>
>

