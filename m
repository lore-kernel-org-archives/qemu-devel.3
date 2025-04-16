Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AB76C369C7
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Apr 2025 20:25:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u59JU-0007GZ-J6; Wed, 16 Apr 2025 16:24:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nabihestefan@google.com>)
 id 1u59JC-00072q-Mf
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 16:24:35 -0400
Received: from mail-qt1-x82e.google.com ([2607:f8b0:4864:20::82e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nabihestefan@google.com>)
 id 1u59J9-0002IF-GA
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 16:24:34 -0400
Received: by mail-qt1-x82e.google.com with SMTP id
 d75a77b69052e-47681dba807so12941cf.1
 for <qemu-devel@nongnu.org>; Wed, 16 Apr 2025 13:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1744835070; x=1745439870; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dbRjehg7BDu5aLWRv9UwWcITpA9l3iDZFOySPlh+RlE=;
 b=qpD/0gcCJ4UvievklwX3AqAUtYLR86PKUC4dcW5PBmCdt54eVk3b1LKU+xsFGnOhbm
 +8yZA/e42SZgJvoRGLFEHTfy8ZTgPxBW25vi8LifHheMWRXs3gKBhOnUkTMuUtjWLO+B
 UuCAlFpVSk6s1jHQiNSC+iAjuZ4+YqINbt1zgC0ZP5iTLIGNLRVbADiNYfSgtmnN4Hva
 7pRs3btMr72fCdhSDh+K/RGE5cZ7tVRbed7o2G/MzpfRVj7+v5/qOnTUt+bCczBDtOwK
 MjARGDHoLZF6Gl+hQaMdITHKdRQKD4516NzYZs2BJU8oE8Y/I5AHFJOKFyYq/lZHavVv
 bmDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744835070; x=1745439870;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dbRjehg7BDu5aLWRv9UwWcITpA9l3iDZFOySPlh+RlE=;
 b=C6r7411Lp0BSqg16sR5UsCCt/G0fOrVdPiyAYBaxCaOFfVDWDACd0OOLTObZpBzZzD
 JJ3HWvBWm6m46jk01rcGoD4D1au0nq7iXrCPSqv92O4YNz5V6gH5jJAswt3eAfjZ/vqL
 lsoY8CZDrpLjbTtkxEpt9noMOzai6LhLG0H6UBzigXBljyRxXIgryY2Obcs51pFAw3eI
 CXN+XocfNMv9APRt0FMC0Y3Pe5iYA4bEU7I98djRHBNVRPh9WzXNijSGTOHfB5pYUiH5
 2d8eVUXaRpluwUYHiWIT3uiGoolKHrD6OaASJRjWzt8MVC0qbyx9MO3vv3yyn/8xYuqj
 9ywQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUVJ8ZWKQjsQwcm8UHtuqvlByBQMq4skP0Mct50dhkjv3e1hmPl4th/TDBqdjqHm7hyt0/f3/CMk07T@nongnu.org
X-Gm-Message-State: AOJu0YxFTgulmTMvSd6j8hqFBD2mr/kkfl20FYRCFTCRklm80r7kONXa
 MJl5lEbLiWBpL9sk6yfN/MQT9n9rKfDJ7ImCkn5fDStZxDMQh/w13l0RiQWvttOeiChEHYMY34/
 26tDBEQMyR9YM9qukA1UJUt2mmNV3CN3ymwIS
X-Gm-Gg: ASbGncvCbw9DaRaWD7r46rK0zWIKSQzxQoS3W8LAHt1lwxkEuadebVUCBAZuQWDLg5v
 fumX0LQ+RFkXnriB5ZFhuyOfp8DokznaJ1y+lETyigfnR4JKN1I/KDGL1/7XMvyYv6tWsQ48kB+
 f8p2Zlyz5JZ1mhdVkPOLMLSDrzeDTqCHNsKPrFsvlog9q+5F7EWo5APKEXQ+8iUjM=
X-Google-Smtp-Source: AGHT+IHtb1K0swz1RF0lUfUt9ptrlYRE+UK2p99hrOHNKg+znU/nxzjs7M4/7bCraV2ALZCUgr8iGZNpFhS0H3xvUiQ=
X-Received: by 2002:a05:622a:2c5:b0:477:95a:ac57 with SMTP id
 d75a77b69052e-47ade63186emr836391cf.14.1744835070334; Wed, 16 Apr 2025
 13:24:30 -0700 (PDT)
MIME-Version: 1.0
References: <20250416034327.315714-1-jamin_lin@aspeedtech.com>
 <20250416034327.315714-3-jamin_lin@aspeedtech.com>
In-Reply-To: <20250416034327.315714-3-jamin_lin@aspeedtech.com>
From: Nabih Estefan <nabihestefan@google.com>
Date: Wed, 16 Apr 2025 13:24:19 -0700
X-Gm-Features: ATxdqUFq1ies6X_faHPMU06IjZSOxDjpJBR1rf9HQiubbulexA5x6RbYBnhWDAE
Message-ID: <CA+QoejXckB0N60DYXudiG12FN7jWZverWceYBXC5jpjHLP2hQg@mail.gmail.com>
Subject: Re: [PATCH v3 02/10] hw/arm/aspeed_ast27x0 Introduce vbootrom memory
 region
To: Jamin Lin <jamin_lin@aspeedtech.com>
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, 
 Troy Lee <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Joel Stanley <joel@jms.id.au>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>, 
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, troy_lee@aspeedtech.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::82e;
 envelope-from=nabihestefan@google.com; helo=mail-qt1-x82e.google.com
X-Spam_score_int: -178
X-Spam_score: -17.9
X-Spam_bar: -----------------
X-Spam_report: (-17.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.268,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=unavailable autolearn_force=no
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

On Tue, Apr 15, 2025 at 8:43=E2=80=AFPM Jamin Lin <jamin_lin@aspeedtech.com=
> wrote:
>
> Introduce a new vbootrom memory region. The region is mapped at address
> "0x00000000" and has a size of 128KB, identical to the SRAM region size.
> This memory region is intended for loading a vbootrom image file as part =
of the
> boot process.
>
> The vbootrom registered in the SoC's address space using the ASPEED_DEV_V=
BOOTROM
> index.
>
> Introduced a "vbootrom_size" attribute in "AspeedSoCClass" to define virt=
ual
> boot ROM size.
>
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Nabih Estefan <nabihestefan@google.com>
Tested-by: Nabih Estefan <nabihestefan@google.com>

> ---
>  include/hw/arm/aspeed_soc.h |  3 +++
>  hw/arm/aspeed_ast27x0.c     | 12 ++++++++++++
>  2 files changed, 15 insertions(+)
>
> diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
> index f069d17d16..9af8cfbc3e 100644
> --- a/include/hw/arm/aspeed_soc.h
> +++ b/include/hw/arm/aspeed_soc.h
> @@ -59,6 +59,7 @@ struct AspeedSoCState {
>      MemoryRegion sram;
>      MemoryRegion spi_boot_container;
>      MemoryRegion spi_boot;
> +    MemoryRegion vbootrom;
>      AddressSpace dram_as;
>      AspeedRtcState rtc;
>      AspeedTimerCtrlState timerctrl;
> @@ -152,6 +153,7 @@ struct AspeedSoCClass {
>      const char * const *valid_cpu_types;
>      uint32_t silicon_rev;
>      uint64_t sram_size;
> +    uint64_t vbootrom_size;
>      uint64_t secsram_size;
>      int spis_num;
>      int ehcis_num;
> @@ -169,6 +171,7 @@ struct AspeedSoCClass {
>  const char *aspeed_soc_cpu_type(AspeedSoCClass *sc);
>
>  enum {
> +    ASPEED_DEV_VBOOTROM,
>      ASPEED_DEV_SPI_BOOT,
>      ASPEED_DEV_IOMEM,
>      ASPEED_DEV_UART0,
> diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c
> index b05ed75ff4..7eece8e286 100644
> --- a/hw/arm/aspeed_ast27x0.c
> +++ b/hw/arm/aspeed_ast27x0.c
> @@ -24,6 +24,7 @@
>  #include "qemu/log.h"
>
>  static const hwaddr aspeed_soc_ast2700_memmap[] =3D {
> +    [ASPEED_DEV_VBOOTROM]  =3D  0x00000000,
>      [ASPEED_DEV_SRAM]      =3D  0x10000000,
>      [ASPEED_DEV_HACE]      =3D  0x12070000,
>      [ASPEED_DEV_EMMC]      =3D  0x12090000,
> @@ -657,6 +658,15 @@ static void aspeed_soc_ast2700_realize(DeviceState *=
dev, Error **errp)
>      memory_region_add_subregion(s->memory,
>                                  sc->memmap[ASPEED_DEV_SRAM], &s->sram);
>
> +    /* VBOOTROM */
> +    name =3D g_strdup_printf("aspeed.vbootrom.%d", CPU(&a->cpu[0])->cpu_=
index);
> +    if (!memory_region_init_ram(&s->vbootrom, OBJECT(s), name,
> +                                sc->vbootrom_size, errp)) {
> +        return;
> +    }
> +    memory_region_add_subregion(s->memory,
> +                                sc->memmap[ASPEED_DEV_VBOOTROM], &s->vbo=
otrom);
> +
>      /* SCU */
>      if (!sysbus_realize(SYS_BUS_DEVICE(&s->scu), errp)) {
>          return;
> @@ -898,6 +908,7 @@ static void aspeed_soc_ast2700a0_class_init(ObjectCla=
ss *oc, void *data)
>
>      sc->valid_cpu_types =3D valid_cpu_types;
>      sc->silicon_rev  =3D AST2700_A0_SILICON_REV;
> +    sc->vbootrom_size =3D 0x20000;
>      sc->sram_size    =3D 0x20000;
>      sc->spis_num     =3D 3;
>      sc->wdts_num     =3D 8;
> @@ -925,6 +936,7 @@ static void aspeed_soc_ast2700a1_class_init(ObjectCla=
ss *oc, void *data)
>
>      sc->valid_cpu_types =3D valid_cpu_types;
>      sc->silicon_rev  =3D AST2700_A1_SILICON_REV;
> +    sc->vbootrom_size =3D 0x20000;
>      sc->sram_size    =3D 0x20000;
>      sc->spis_num     =3D 3;
>      sc->wdts_num     =3D 8;
> --
> 2.43.0
>

