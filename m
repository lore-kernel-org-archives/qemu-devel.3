Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0103C282DE
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 04:22:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tq2jx-000189-G7; Wed, 05 Mar 2025 23:21:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tq2jv-00017e-Is; Wed, 05 Mar 2025 23:21:43 -0500
Received: from mail-vk1-xa33.google.com ([2607:f8b0:4864:20::a33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tq2jt-0008Hf-Qm; Wed, 05 Mar 2025 23:21:43 -0500
Received: by mail-vk1-xa33.google.com with SMTP id
 71dfb90a1353d-52399515bd2so247804e0c.1; 
 Wed, 05 Mar 2025 20:21:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741234900; x=1741839700; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=049l3ey0bOivZhgApDw0mmziJI4t9UXjqFwQhKRF/24=;
 b=EUSDWrECb+XVP/yuJdzCh/+Z5HnmcfRaQPAn8uUn36CnAaMi0L2iBYt/5sTjp7elFt
 5RrIIY+66KrSQH7xlk+siUWSnj31H0i8lwhC17Ztu9Wx438Trf6XoE57ZS7S81r2XSMw
 vpRhe8c4Ft2DSFLcU9QgzBvGyR+udT0LXXAaA7e0dGFBAhUrrCC8YexKhzk0ht4TGleS
 TnLsyN/8OgZzg8k682zqs6abHZ+virYmgkoRnrGLt5nKQI4jfP2R+EDY6jmqDVQNFrM/
 crzyHUIMuV4I4b53lPkufCLrMq17TmsuZBaWLK31K+kSXMTDYpwi7ix6W+nv7HDjdvJ0
 4MEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741234900; x=1741839700;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=049l3ey0bOivZhgApDw0mmziJI4t9UXjqFwQhKRF/24=;
 b=c0OFuQuc8YsyVJkiBhWneqEYQ1A5fbT0GSU6YetcC/5/xs7hR+Ltbvgw4RvXIkKjfS
 n6zxn4te6irRo1LieN4KV3LjTTuAd/zlcdpdrwGyeyv7k3I8G9zJI3xNkQ7y5L1lrXhD
 wv8fULlZb7lFtrgZryYFstw37JKR5cMnbyNt+4Nt8WH0YIt4ZclYEDh0W8m+RLhelEXu
 /3+7Nk8R0SJarlXHfLkLUAIOIKlrdSbXFz16ImRjqmq2TOnLsj5mc9PLu3V2EkkJlEVc
 nmkTd+xK8vXJB9jnpksHP3afXZenM/FUlCdN2pUQB40M/aO0evzfg7FkvvxtI92m7oDq
 a9qw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXrCOFaS4oxoVLFbP5FdiTFTblkOlqB+Nb5dJPy7Qs2fO/PylHIbtTU9NHem0uRwL3+jLZXvoC+lZum@nongnu.org
X-Gm-Message-State: AOJu0YycrBPitUZti99VPO6JsWQA6MRx5Gjmd45Xc5LRcIsPZYUz5sEP
 TAqrjUy6pXzoQieJ0LlowaJoZzQ0QHIh/jp1JHlvGUkCzsxWqdYXie76eO/ZEASejVvelm9vm9Q
 bkeueA0/azOmYuI7/OLNACETRsPE=
X-Gm-Gg: ASbGncv9xPawAAjH81RbOzayoxwbrQ+sdNknpPaEaJSAoQbht+0XYqRxQIyfdxB67cB
 rIcRVjdoSpkz4b3yKhuIL004YzEveilsikAgvmjVcfJN9Xc9vx1kRQ0I8ZeLCnjSaQf2Tkx+SO+
 ckizpVXxQ5MF+qgDAj9YldayQ5C6/VltXxMd1uBtFAb5+aYdIL0qaNqyO+
X-Google-Smtp-Source: AGHT+IGaGPbM3O3971xIztkVtMQN4ojUuTHwaCfkrzivRwrxPyDZhsbHEeNc9YNG+cjzXWnfAi6WhFm9O8EyVT6y6XE=
X-Received: by 2002:a05:6122:3542:b0:520:4fff:4c85 with SMTP id
 71dfb90a1353d-523d5002f54mr1340256e0c.2.1741234900174; Wed, 05 Mar 2025
 20:21:40 -0800 (PST)
MIME-Version: 1.0
References: <20250225005446.13894-1-sebastian.huber@embedded-brains.de>
 <20250225005446.13894-6-sebastian.huber@embedded-brains.de>
In-Reply-To: <20250225005446.13894-6-sebastian.huber@embedded-brains.de>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 6 Mar 2025 14:21:14 +1000
X-Gm-Features: AQ5f1Jpbd67JJpio6ETR3wX1PgFi8ge4-88Kzckd-BSOcd4OYCN0HtgcB13VvpY
Message-ID: <CAKmqyKMckasbSFHohQL4odC-sK1oSw1d7ozX3banriGywoMS8A@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] hw/riscv: Configurable MPFS CLINT timebase freq
To: Sebastian Huber <sebastian.huber@embedded-brains.de>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Conor Dooley <conor.dooley@microchip.com>, Bin Meng <bin.meng@windriver.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a33;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa33.google.com
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

On Tue, Feb 25, 2025 at 10:55=E2=80=AFAM Sebastian Huber
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
> index df902c8667..9068eed780 100644
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
> @@ -669,6 +668,40 @@ static void microchip_icicle_kit_machine_init(Machin=
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
> @@ -690,12 +723,20 @@ static void microchip_icicle_kit_machine_class_init=
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

