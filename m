Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74417E92FCB
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 19:39:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaJ4Y-0004OD-JS; Mon, 29 Dec 2025 14:38:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nabihestefan@google.com>)
 id 1vaJ4P-00041j-Mc
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 14:38:22 -0500
Received: from mail-qt1-x82c.google.com ([2607:f8b0:4864:20::82c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nabihestefan@google.com>)
 id 1vaJ4O-0000JQ-5H
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 14:38:21 -0500
Received: by mail-qt1-x82c.google.com with SMTP id
 d75a77b69052e-4f34f257a1bso3264481cf.0
 for <qemu-devel@nongnu.org>; Mon, 29 Dec 2025 11:38:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1767037099; cv=none;
 d=google.com; s=arc-20240605;
 b=BcNlq/qIOosXr8TU3an2G3Pcf1n0oxt01gN7bC4BtVC2xa+lj+KgYTKYB2eMMrWYCw
 lPKlXphw9P1ZWKaAig8Ap2yHZHu4v3w9TfeeNjGbWLGPKXMTELQF42EYHwofcrr/2cw+
 N/31ZNI55N51H8Bd/8gXpMIEbqaPbXs3H+q51H8U8+0lzsc0OFq5jDeSBNv+pewZJP7Q
 UUTJaKgNJxBTFGRYRYY0GvyncqExjBKeQ2q9i3rLxVWFh7igTOcpLSamMP5O1bKhM0Uz
 N0iXjKI0Uj0XxLDPmtRcC9Ic7rYJE+o38ZPxhm5iylv1q8S9MOYQfqpdXUINrfP7kav5
 sJZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=iSHe0s9M59jQH1SzGvfiZ1+HXChWWuPGtrcv9A89JEE=;
 fh=+waN68atSTYXtjEh+rfObIc73rtiem2YKJLex1ZfN24=;
 b=kGKPEKe3/qADW138GUUXOb6VXAvO131LRUPcONQczzI86IxM4BLh0RYLzjU3Dnxxkf
 ipfeNZDOX7a83jL1mzRwXacAI/cYzUx7ojrq7gdhLS6CrGC8k+fDif0/J/l3rRb7LLVb
 EDRcxW17BJ2y4uWUDORZ+f9U8Rb5MAouJUc+Kw5kUiV9FdljPfJHl8UOFqwJ2zbtCU89
 cTFlGet7TdTpXjJ7wyFn+qTKYlZaNarbD+69AOln4T/Yc4CdNcTqPPxTtKAsZGwWRPNj
 3/DaUuEXXvjECMU+SbMZAOWhAJnyYbN+DT/Jb38+dipHKOkSuOscAWgQtcL+BY1S3pg/
 GhJg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1767037099; x=1767641899; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iSHe0s9M59jQH1SzGvfiZ1+HXChWWuPGtrcv9A89JEE=;
 b=uFvaz2961zrUSW78eoxwOETFbiA2hMkczveZh+vDeOXQuVauaQeY7wnjivNRGltwa6
 mEXeKenBWKXTfUHSBCnZxqqPuorechjU553QDgJmFiY1YMpmj0pGfQ5nbq7/5mAqEZTN
 Y6R9dqFgzvOYj9WZP2+cG1lg15MerEWmG1ItUQpGcpU3WmNq0boUM5hWUdzfZPKx2pKG
 p3iJIzyfnznyVzeBvC2Hp+JgdpqGLZ+T3BrftUymTvXQAdfDobqQrD+pH7i2XMpNZeBW
 9uY6F0VIMQdeFXqYRqwJmH0zmHFOzYLSC7tYCOPVLHO4f5fb4Syua1/T+1e+6o3v399X
 ZHJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767037099; x=1767641899;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iSHe0s9M59jQH1SzGvfiZ1+HXChWWuPGtrcv9A89JEE=;
 b=m4EZl+BtDlo7DwvxsOIbQAKdT8mPLT+yD/hu/AOulLsvcpF3f2e2DNo+zRoh/Q7RG1
 BGlUM9tbZIGQ0VbpLSmsNPWzudJlDHFFcjzKtL1tgU5sl1BVkxKEAdf4jn+cuj7cexD8
 xHg/QGZrREEApsxJeciBuYyhLfIgPgNd7FG/uXHcH2QcFqtOWHnQHkAw8BABcr19aTlV
 fetEqrVxIJ7S05AyaXOSK0rd4Mk8SBSjtP74Xycmu8hDn++H6tA4G6UWSncQW9k1S77M
 yhMyz/QJAyrBqZCRgFbZi6aDi+5ObjGlVXzkCU1LVL2eHFF3fV0imu3gsjBtfmcBgsrt
 b0tA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXEdqgb60KwsKuWu85bMJAVxk0bhwzov/VFbu80y7214EBhjmVRLWQZmuYrU/Y/3Er2da8XHwIVYiDR@nongnu.org
X-Gm-Message-State: AOJu0YxvtvkWQclSlIL7zmFoGRL3TA4ea/uXZca0NvPRJHlZT2ac/Ds5
 +OFzVLyhdcrDaj9//DKOC1vMXufFucP0JGF95fIy2WRBCPn4mtZIdxGXAxLcQPUfKs9xQfjfgLI
 347APC2grfyirLUHU2gW8yIaKgXh7bZUkbbtxsIc1
X-Gm-Gg: AY/fxX6/9MGdo/0g6fGDIImlYv37xATLiGWH6nF6/CWHw6niTpdj3DdX3CGtAhaZ+gn
 6pxdPti2HZo9X/JUV9k0p1MHlaIccE0oCwa4YtyoG6Z5n+bKEhGrUky0F1/hkovYwv39XbutGBr
 7MJhJeFjyMw+c9Wv3P1NNDvm0HL2WeQBh950HL/je4a7vhDGKRzxInSXB9Jqsag0HaS17rvbXmA
 mOOIf4fbM3a/IEA2hRUspiAe42KXf5LJ9L/8SB4iXUhsbXAsR4YM9/ybBtuBeQw2ZA5a+2abhWl
 J3hM5mhUApSCVP5saY9y9zRvEg==
X-Google-Smtp-Source: AGHT+IFp+zk5i/1xH0hJ2cC5ENduTb5O1V6JaEXoywsghiQBh0ln2M367h75zm0IU5YIIRCJRZShaH5rvf+qL5qzZw0=
X-Received: by 2002:a05:622a:1308:b0:4f3:b0f3:62bb with SMTP id
 d75a77b69052e-4f4e5f746cdmr33506191cf.13.1767037099009; Mon, 29 Dec 2025
 11:38:19 -0800 (PST)
MIME-Version: 1.0
References: <20251224014203.756264-1-kane_chen@aspeedtech.com>
 <20251224014203.756264-10-kane_chen@aspeedtech.com>
In-Reply-To: <20251224014203.756264-10-kane_chen@aspeedtech.com>
From: Nabih Estefan <nabihestefan@google.com>
Date: Mon, 29 Dec 2025 11:38:07 -0800
X-Gm-Features: AQt7F2qHyuy0Rjs9h4p2xga7-Nm5mI_12tEjB8I0iD1yXmFVitSSKnEErrcsRr8
Message-ID: <CA+QoejV4vX4SqX87y7jd81DXL-4hfHRvYhTLBpjwdf+oH4EMaQ@mail.gmail.com>
Subject: Re: [PATCH v4 09/19] hw/arm/aspeed: Attach SRAM device to AST1700
 model
To: Kane Chen <kane_chen@aspeedtech.com>
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, 
 Troy Lee <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, 
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, 
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 troy_lee@aspeedtech.com, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::82c;
 envelope-from=nabihestefan@google.com; helo=mail-qt1-x82c.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

On Tue, Dec 23, 2025 at 5:42=E2=80=AFPM Kane Chen <kane_chen@aspeedtech.com=
> wrote:
>
> From: Kane-Chen-AS <kane_chen@aspeedtech.com>
>
> Map the SRAM device to AST1700 model
>
> Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>
> Reviewed-by: C=C3=A9dric Le Goater <clg@redhat.com>

Reviewed-by: Nabih Estefan <nabihestefan@google.com>
Tested-by: Nabih Estefan <nabihestefan@google.com>


> ---
>  include/hw/arm/aspeed_ast1700.h |  2 ++
>  hw/arm/aspeed_ast1700.c         | 18 ++++++++++++++++++
>  hw/arm/aspeed_ast27x0.c         |  1 +
>  3 files changed, 21 insertions(+)
>
> diff --git a/include/hw/arm/aspeed_ast1700.h b/include/hw/arm/aspeed_ast1=
700.h
> index a0d6b3ae44..23588f7a81 100644
> --- a/include/hw/arm/aspeed_ast1700.h
> +++ b/include/hw/arm/aspeed_ast1700.h
> @@ -20,9 +20,11 @@ struct AspeedAST1700SoCState {
>      SysBusDevice parent_obj;
>
>      MemoryRegion iomem;
> +    uint8_t board_idx;
>
>      AspeedLTPIState ltpi;
>      SerialMM uart;
> +    MemoryRegion sram;
>  };
>
>  #endif /* ASPEED_AST1700_H */
> diff --git a/hw/arm/aspeed_ast1700.c b/hw/arm/aspeed_ast1700.c
> index f444582795..cb07d94054 100644
> --- a/hw/arm/aspeed_ast1700.c
> +++ b/hw/arm/aspeed_ast1700.c
> @@ -14,13 +14,16 @@
>  #include "hw/arm/aspeed_ast1700.h"
>
>  #define AST2700_SOC_LTPI_SIZE        0x01000000
> +#define AST1700_SOC_SRAM_SIZE        0x00040000
>
>  enum {
> +    ASPEED_AST1700_DEV_SRAM,
>      ASPEED_AST1700_DEV_UART12,
>      ASPEED_AST1700_DEV_LTPI_CTRL,
>  };
>
>  static const hwaddr aspeed_ast1700_io_memmap[] =3D {
> +    [ASPEED_AST1700_DEV_SRAM]      =3D  0x00BC0000,
>      [ASPEED_AST1700_DEV_UART12]    =3D  0x00C33B00,
>      [ASPEED_AST1700_DEV_LTPI_CTRL] =3D  0x00C34000,
>  };
> @@ -29,12 +32,21 @@ static void aspeed_ast1700_realize(DeviceState *dev, =
Error **errp)
>  {
>      AspeedAST1700SoCState *s =3D ASPEED_AST1700(dev);
>      SysBusDevice *sbd =3D SYS_BUS_DEVICE(dev);
> +    char dev_name[32];
>
>      /* Occupy memory space for all controllers in AST1700 */
>      memory_region_init(&s->iomem, OBJECT(s), TYPE_ASPEED_AST1700,
>                         AST2700_SOC_LTPI_SIZE);
>      sysbus_init_mmio(sbd, &s->iomem);
>
> +    /* SRAM */
> +    snprintf(dev_name, sizeof(dev_name), "aspeed.ioexp-sram.%d", s->boar=
d_idx);
> +    memory_region_init_ram(&s->sram, OBJECT(s), dev_name,
> +                           AST1700_SOC_SRAM_SIZE, errp);
> +    memory_region_add_subregion(&s->iomem,
> +                            aspeed_ast1700_io_memmap[ASPEED_AST1700_DEV_=
SRAM],
> +                            &s->sram);
> +
>      /* UART */
>      qdev_prop_set_uint8(DEVICE(&s->uart), "regshift", 2);
>      qdev_prop_set_uint32(DEVICE(&s->uart), "baudbase", 38400);
> @@ -69,11 +81,17 @@ static void aspeed_ast1700_instance_init(Object *obj)
>
>      return;
>  }
> +
> +static const Property aspeed_ast1700_props[] =3D {
> +    DEFINE_PROP_UINT8("board-idx", AspeedAST1700SoCState, board_idx, 0),
> +};
> +
>  static void aspeed_ast1700_class_init(ObjectClass *klass, const void *da=
ta)
>  {
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
>
>      dc->realize =3D aspeed_ast1700_realize;
> +    device_class_set_props(dc, aspeed_ast1700_props);
>  }
>
>  static const TypeInfo aspeed_ast1700_info =3D {
> diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c
> index 678d4eb6d9..f2418e0e45 100644
> --- a/hw/arm/aspeed_ast27x0.c
> +++ b/hw/arm/aspeed_ast27x0.c
> @@ -1096,6 +1096,7 @@ static void aspeed_soc_ast2700_realize(DeviceState =
*dev, Error **errp)
>
>      /* IO Expander */
>      for (i =3D 0; i < sc->ioexp_num; i++) {
> +        qdev_prop_set_uint8(DEVICE(&s->ioexp[i]), "board-idx", i);
>          if (!sysbus_realize(SYS_BUS_DEVICE(&s->ioexp[i]), errp)) {
>              return;
>          }
> --
> 2.43.0
>

