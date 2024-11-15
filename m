Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41701D6DDED
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2024 10:34:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBtdd-0008Px-Ig; Fri, 15 Nov 2024 05:33:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tBtdc-0008PY-6H
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 05:33:16 -0500
Received: from mail-lj1-x236.google.com ([2a00:1450:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tBtda-0006mW-Iz
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 05:33:15 -0500
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2ff550d37a6so16768591fa.0
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2024 02:33:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731666792; x=1732271592; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=68fmHlYnz/CO4LtgoA/4HQw8Y1+gUuDD55yiCYfdrhw=;
 b=VxDvDX4otbnWdAu3SkRQZvol8XJrJ66vKxlQoI8frauHFFERmd6lEg2K2e3shKquT0
 o2AAoPcb2Lm/ggJwgqyVkWtDqngePtwvYh8oRqVPNqIpDW1vGn22icJPl0oUnlPFL49E
 D0NqUiAXLXJj21VzUu79zOc22LAZe0kiFLZNM82Nsa2myerXGM1e9/Uotja4URjbG5/8
 O7c2jrrT2/WFLA1w6MkRtAM+ER1i+6UlyoBkJWhT4JfiMqk7oEb6Im8B5GC+Kf9GDO9W
 GkT/REaFcq+FjEuXla0BLOBjOQIbAjfM8CAzQa0lg1qYmw8IgexpNdvu0poCHkl8Ry88
 VmhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731666792; x=1732271592;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=68fmHlYnz/CO4LtgoA/4HQw8Y1+gUuDD55yiCYfdrhw=;
 b=iVsWfuYeLkoAmCrrrqNWJpcEktJKEemSjnrTYjFMEyQ/TLr/oDNnzdqGU70Q0qQNPe
 HYMaXTQN9ZaokpdwDwxcnciM/xhqfShHeiEz3Z5RdN1h22yaeF/hF44gmMbSA+uOU0IU
 8CkGlRQk4yXwHBZbg1nKbxs1/PG+1HtwciPpV4Hpqdf4su+t/ae3sSCOmw76YiloZg24
 C2YhNGW59MOozdZGu9hQYkzU6WpGSs1tGTd3JTf0S3px9pz9rpgKzhRv9zsu7pbW221E
 cXXs+EMxHrbNdGUf7yM+SbmfrQN8BmLSTG8Lf1VIyuTFg5F2Dyrpl3FEbR7StS7Ir/ND
 FfHw==
X-Gm-Message-State: AOJu0YzxulvpTASdu/OgPtwfUom8jp2otAEQrlHrUZIrCPcCLhb/8ba1
 6hLRjv9GTu3pSyIGlfomVVvaRBpTWND6UYtQ9MWjTjkIGmsL9NDoDfJrDRrpgoE=
X-Google-Smtp-Source: AGHT+IFlLUorfcm9hcKTqOktgd4HolxSl3g9vmzA7Wn8k4OG2difCpSabbyc2rnFFxcbMh0lZoANQg==
X-Received: by 2002:a05:651c:1543:b0:2fc:b10c:df4 with SMTP id
 38308e7fff4ca-2ff6093369fmr11169141fa.20.1731666790853; 
 Fri, 15 Nov 2024 02:33:10 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432dab7220asm49227125e9.6.2024.11.15.02.33.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Nov 2024 02:33:10 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 1D3625F7A2;
 Fri, 15 Nov 2024 10:33:09 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 qemu-arm@nongnu.org,  Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>,  Anton Johansson <anjo@rev.ng>,  Bernhard
 Beschow <shentey@gmail.com>,  Alistair Francis <alistair@alistair23.me>,
 Paolo Bonzini <pbonzini@redhat.com>,  Gustavo Romero
 <gustavo.romero@linaro.org>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  Peter Maydell <peter.maydell@linaro.org>,
 Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH RESEND v2 19/19] hw/net/xilinx_ethlite: Map RESERVED I/O
 as unimplemented
In-Reply-To: <20241114210010.34502-20-philmd@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Thu, 14 Nov 2024 22:00:10
 +0100")
References: <20241114210010.34502-1-philmd@linaro.org>
 <20241114210010.34502-20-philmd@linaro.org>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Fri, 15 Nov 2024 10:33:09 +0000
Message-ID: <8734jsss62.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::236;
 envelope-from=alex.bennee@linaro.org; helo=mail-lj1-x236.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> In order to track access to reserved I/O space, use yet
> another UnimplementedDevice covering the whole device
> memory range. Mapped with lower priority (-1).
>
> The memory flat view becomes:
>
>   (qemu) info mtree -f
>   FlatView #0
>    Root memory region: system
>     0000000081000000-00000000810007e3 (prio 0, ram): ethlite.tx[0]buf
>     00000000810007e4-00000000810007f3 (prio 0, i/o): ethlite.mdio
>     00000000810007f4-00000000810007ff (prio 0, i/o): ethlite.tx[0]io
>     0000000081000800-0000000081000fe3 (prio 0, ram): ethlite.tx[1]buf
>     0000000081000fe4-0000000081000ff3 (prio -1, i/o): ethlite.reserved @0=
000000000000fe4
>     0000000081000ff4-0000000081000fff (prio 0, i/o): ethlite.tx[1]io
>     0000000081001000-00000000810017e3 (prio 0, ram): ethlite.rx[0]buf
>     00000000810017e4-00000000810017fb (prio -1, i/o): ethlite.reserved @0=
0000000000017e4
>     00000000810017fc-00000000810017ff (prio 0, i/o): ethlite.rx[0]io
>     0000000081001800-0000000081001fe3 (prio 0, ram): ethlite.rx[1]buf
>     0000000081001fe4-0000000081001ffb (prio -1, i/o): ethlite.reserved @0=
000000000001fe4
>     0000000081001ffc-0000000081001fff (prio 0, i/o): ethlite.rx[1]io
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  hw/net/xilinx_ethlite.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/hw/net/xilinx_ethlite.c b/hw/net/xilinx_ethlite.c
> index 5f1ff7b712..1be38c44dd 100644
> --- a/hw/net/xilinx_ethlite.c
> +++ b/hw/net/xilinx_ethlite.c
> @@ -95,6 +95,7 @@ struct XlnxXpsEthLite
>      uint32_t c_rx_pingpong;
>      unsigned int port_index; /* dual port RAM index */
>=20=20
> +    UnimplementedDeviceState rsvd;
>      UnimplementedDeviceState mdio;
>      XlnxXpsEthLitePort port[2];
>  };
> @@ -304,6 +305,16 @@ static void xilinx_ethlite_realize(DeviceState *dev,=
 Error **errp)
>      memory_region_init(&s->container, OBJECT(dev),
>                         "xlnx.xps-ethernetlite", 0x2000);
>=20=20
> +    object_initialize_child(OBJECT(dev), "ethlite.reserved", &s->rsvd,
> +                            TYPE_UNIMPLEMENTED_DEVICE);
> +    qdev_prop_set_string(DEVICE(&s->rsvd), "name", "ethlite.reserved");
> +    qdev_prop_set_uint64(DEVICE(&s->rsvd), "size",
> +                         memory_region_size(&s->container));
> +    sysbus_realize(SYS_BUS_DEVICE(&s->rsvd), &error_fatal);
> +    memory_region_add_subregion_overlap(&s->container, 0,
> +                           sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->rsv=
d), 0),
> +                           -1);
> +
>      object_initialize_child(OBJECT(dev), "ethlite.mdio", &s->mdio,
>                              TYPE_UNIMPLEMENTED_DEVICE);
>      qdev_prop_set_string(DEVICE(&s->mdio), "name", "ethlite.mdio");

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

