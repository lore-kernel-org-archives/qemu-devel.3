Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34BEDC3600C
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 02:13:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0WXW-0007Ot-OO; Thu, 03 Apr 2025 22:12:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1u0WXQ-0007OX-4B; Thu, 03 Apr 2025 22:12:09 -0400
Received: from mail-ua1-x92a.google.com ([2607:f8b0:4864:20::92a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1u0WXN-0000sw-JB; Thu, 03 Apr 2025 22:12:07 -0400
Received: by mail-ua1-x92a.google.com with SMTP id
 a1e0cc1a2514c-86dc3482b3dso2457745241.0; 
 Thu, 03 Apr 2025 19:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743732721; x=1744337521; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FdKF9xGYYdGFLr8czdjLqmchdZ/7uQOO8de4agJgXDA=;
 b=PEExJfIwv8DNPOAjIUbvSeRimxUIeEEOggUQtH4q9wtz0WcMOAboZIjkdOzayVDE0W
 6x2CH1MloECSyV5onpI75sPiGP33XNJ+3G/iZla6FlkXXbpZTmDAgmiZ1IIFE1zugk5K
 q9QmtmKiqjBOPFL5TfuPRD2O4+YSuHYAuF7j5d4HPGWX50hzEyae9sSzi/FdTfd5DlS0
 qqjHFSS0pHtNiJYrJeizga1QqWiFpViOxMtCWD1pVJP4/6FF9BGL1fhIzKzYkb2tqGmz
 KkpT9AirjnuVaRQDDTFD3AHthQkgacJAdLsj4KTI6fUjMNkVL1W7hrYHRou9mJZPAnUM
 alYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743732721; x=1744337521;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FdKF9xGYYdGFLr8czdjLqmchdZ/7uQOO8de4agJgXDA=;
 b=Y4MjwtkzbNVMUm6jwUXo4l0RqTmDKlcnG4kmyAJyx2qIXQ673W4/2Yo2NDctPfMzX2
 0gGgfGGSbK5PWH7AJtSRwT95y/gWJjOgUtYhtdvWCkgZC8pGj9iI2hwII+nqSrsMzkjb
 3LUsaL9yEDa1TWZCy9JHriVv2F4kB5RtceFenfDUc+gWdI9sK4iGa6I3bbLEbnNgjVV2
 bBjYhKTNT30DIA172dWQlm/IHsNXHpKjFOWtTc6+nUnzu12j5Wz+CLttOF4+x4S78j7M
 Jf1WzbUgrjtdxNIT9F8SirblMoRQYufDGC41A1X6vEjJhmWQQjMizIyidURqKiy1uKtx
 /b4Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWu4D8CqL9zMwDNDG7gATfGjM/lOrnazGq+gMg/i8O4gRfRYsK2TIbYxny7A6dsvISxEITNCd45Dq2h@nongnu.org
X-Gm-Message-State: AOJu0Yxvy+5DZcEp0fgPrx5wpLWJwrOdNiovKF8JqtSROYFig+uGL1HZ
 3Wc3DOllDr+yIz7UjxIL0erqb0OwDhZnxDGjaN0hZBSyFIRVIR4HTfu60CH87jpD+dmML/+Qewn
 iDr9Xby9re/Na3QWWL6I+qNP5yfI=
X-Gm-Gg: ASbGncureVltUXMhYjDlbhjhNDbAkabONQqdjBpGYlAYkh9f+oqGamr2reSSOFU5J/I
 bANrCz8Ln0qIKEexQfUMnUZ8e2SzCJiG/LvzNX0EX4JwTdJPlJWKdVHZ9yIpjhDSkwP85plK/Ux
 8Kd3B6SpF0NXO9zBawYj4rdcA8A3y5WdCtxIuh2KS/GKdIzG0HM6YoKwBb
X-Google-Smtp-Source: AGHT+IHNLbbcpn4gKrgClPcekO0r54w8nf+ZCEZ0EVar6OLIxEq26CvAK8ilrn3EzmuoOTON5XjyOoF5JP9nA5URfPc=
X-Received: by 2002:a05:6102:1495:b0:4b3:fee3:2820 with SMTP id
 ada2fe7eead31-4c854fbb66dmr1185014137.9.1743732721366; Thu, 03 Apr 2025
 19:12:01 -0700 (PDT)
MIME-Version: 1.0
References: <20250319061342.26435-1-sebastian.huber@embedded-brains.de>
 <20250319061342.26435-6-sebastian.huber@embedded-brains.de>
In-Reply-To: <20250319061342.26435-6-sebastian.huber@embedded-brains.de>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 4 Apr 2025 12:11:35 +1000
X-Gm-Features: ATxdqUG37XyGNqINykuk23BRVvbz3H20PlBwwMjtpLNnMNdDtjE4u-kX3K_jx9c
Message-ID: <CAKmqyKMOFtUQM-=-nNeLBsWfokbTgMYgvLXbn7qHsd53SKA3+w@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] hw/riscv: Configurable MPFS CLINT timebase freq
To: Sebastian Huber <sebastian.huber@embedded-brains.de>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92a;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x92a.google.com
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

On Wed, Mar 19, 2025 at 4:13=E2=80=AFPM Sebastian Huber
<sebastian.huber@embedded-brains.de> wrote:
>
> This property enables the setting of the CLINT timebase frequency
> through the command line, for example:
>
>   -machine microchip-icicle-kit,clint-timebase-frequency=3D10000000
>
> Signed-off-by: Sebastian Huber <sebastian.huber@embedded-brains.de>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/riscv/microchip_pfsoc.c         | 49 +++++++++++++++++++++++++++---
>  include/hw/riscv/microchip_pfsoc.h |  1 +
>  2 files changed, 46 insertions(+), 4 deletions(-)
>
> diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
> index 5c9f7f643f..616bb63982 100644
> --- a/hw/riscv/microchip_pfsoc.c
> +++ b/hw/riscv/microchip_pfsoc.c
> @@ -39,6 +39,7 @@
>  #include "qemu/units.h"
>  #include "qemu/cutils.h"
>  #include "qapi/error.h"
> +#include "qapi/visitor.h"
>  #include "hw/boards.h"
>  #include "hw/loader.h"
>  #include "hw/sysbus.h"
> @@ -61,9 +62,6 @@
>  #define BIOS_FILENAME   "hss.bin"
>  #define RESET_VECTOR    0x20220000
>
> -/* CLINT timebase frequency */
> -#define CLINT_TIMEBASE_FREQ 1000000
> -
>  /* GEM version */
>  #define GEM_REVISION    0x0107010c
>
> @@ -193,6 +191,7 @@ static void microchip_pfsoc_soc_instance_init(Object =
*obj)
>  static void microchip_pfsoc_soc_realize(DeviceState *dev, Error **errp)
>  {
>      MachineState *ms =3D MACHINE(qdev_get_machine());
> +    MicrochipIcicleKitState *iks =3D MICROCHIP_ICICLE_KIT_MACHINE(ms);
>      MicrochipPFSoCState *s =3D MICROCHIP_PFSOC(dev);
>      const MemMapEntry *memmap =3D microchip_pfsoc_memmap;
>      MemoryRegion *system_memory =3D get_system_memory();
> @@ -253,7 +252,7 @@ static void microchip_pfsoc_soc_realize(DeviceState *=
dev, Error **errp)
>          memmap[MICROCHIP_PFSOC_CLINT].base + RISCV_ACLINT_SWI_SIZE,
>          RISCV_ACLINT_DEFAULT_MTIMER_SIZE, 0, ms->smp.cpus,
>          RISCV_ACLINT_DEFAULT_MTIMECMP, RISCV_ACLINT_DEFAULT_MTIME,
> -        CLINT_TIMEBASE_FREQ, false);
> +        iks->clint_timebase_freq, false);
>
>      /* L2 cache controller */
>      create_unimplemented_device("microchip.pfsoc.l2cc",
> @@ -671,6 +670,40 @@ static void microchip_icicle_kit_machine_init(Machin=
eState *machine)
>      }
>  }
>
> +static void microchip_icicle_kit_set_clint_timebase_freq(Object *obj,
> +                                                         Visitor *v,
> +                                                         const char *nam=
e,
> +                                                         void *opaque,
> +                                                         Error **errp)
> +{
> +    MicrochipIcicleKitState *s =3D MICROCHIP_ICICLE_KIT_MACHINE(obj);
> +    uint32_t value;
> +
> +    if (!visit_type_uint32(v, name, &value, errp)) {
> +        return;
> +    }
> +
> +    s->clint_timebase_freq =3D value;
> +}
> +
> +static void microchip_icicle_kit_get_clint_timebase_freq(Object *obj,
> +                                                         Visitor *v,
> +                                                         const char *nam=
e,
> +                                                         void *opaque,
> +                                                         Error **errp)
> +{
> +    MicrochipIcicleKitState *s =3D MICROCHIP_ICICLE_KIT_MACHINE(obj);
> +    uint32_t value =3D s->clint_timebase_freq;
> +
> +    visit_type_uint32(v, name, &value, errp);
> +}
> +
> +static void microchip_icicle_kit_machine_instance_init(Object *obj)
> +{
> +    MicrochipIcicleKitState *m =3D MICROCHIP_ICICLE_KIT_MACHINE(obj);
> +    m->clint_timebase_freq =3D 1000000;
> +}
> +
>  static void microchip_icicle_kit_machine_class_init(ObjectClass *oc, voi=
d *data)
>  {
>      MachineClass *mc =3D MACHINE_CLASS(oc);
> @@ -692,12 +725,20 @@ static void microchip_icicle_kit_machine_class_init=
(ObjectClass *oc, void *data)
>       * See memory_tests() in mss_ddr.c in the HSS source code.
>       */
>      mc->default_ram_size =3D 1537 * MiB;
> +
> +    object_class_property_add(oc, "clint-timebase-frequency", "uint32_t"=
,
> +                              microchip_icicle_kit_get_clint_timebase_fr=
eq,
> +                              microchip_icicle_kit_set_clint_timebase_fr=
eq,
> +                              NULL, NULL);
> +    object_class_property_set_description(oc, "clint-timebase-frequency"=
,
> +                                  "Set CLINT timebase frequency in Hz.")=
;
>  }
>
>  static const TypeInfo microchip_icicle_kit_machine_typeinfo =3D {
>      .name       =3D MACHINE_TYPE_NAME("microchip-icicle-kit"),
>      .parent     =3D TYPE_MACHINE,
>      .class_init =3D microchip_icicle_kit_machine_class_init,
> +    .instance_init =3D microchip_icicle_kit_machine_instance_init,
>      .instance_size =3D sizeof(MicrochipIcicleKitState),
>  };
>
> diff --git a/include/hw/riscv/microchip_pfsoc.h b/include/hw/riscv/microc=
hip_pfsoc.h
> index daef086da6..7ca9b976c1 100644
> --- a/include/hw/riscv/microchip_pfsoc.h
> +++ b/include/hw/riscv/microchip_pfsoc.h
> @@ -67,6 +67,7 @@ typedef struct MicrochipIcicleKitState {
>      MachineState parent_obj;
>
>      /*< public >*/
> +    uint32_t clint_timebase_freq;
>      MicrochipPFSoCState soc;
>  } MicrochipIcicleKitState;
>
> --
> 2.43.0
>

