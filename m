Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C455FD6D24F
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2024 00:42:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGSbQ-0000ER-Gl; Wed, 27 Nov 2024 19:41:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tGSbM-0000Bk-W5
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 19:41:49 -0500
Received: from mail-vs1-xe2f.google.com ([2607:f8b0:4864:20::e2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tGSbL-0008VF-4M
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 19:41:48 -0500
Received: by mail-vs1-xe2f.google.com with SMTP id
 ada2fe7eead31-4adde46ccf8so70075137.0
 for <qemu-devel@nongnu.org>; Wed, 27 Nov 2024 16:41:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732754506; x=1733359306; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7NRgDApEuXu7pC+MgJEeX6ix7kAuF/Lf9HX8SCoJDM8=;
 b=T8yj0zNRNXs4krPgF10p8C7WhQHySBm8+lONgNRxbwi/OwH6i/+6t6HgimpMO0yegQ
 KvG4nMjKpsicBJN6ZR7SxtcCRaW7Ejw75aKNHK5bwDip1EIAQMRhuqq7bntIn5N0SKiq
 Xsx2sdLrgQu0Vydjo0FYjol6jyv7nXg2chb74h7lbNdq4u4pJh7J/tBGTlhNZ7cHewvM
 1HVZ5ezdqFOVLEv9eqalsEWHfIy9hXcNIhkf9z6PAPcsGAZvqpqruu38HQFrB+xhWPiq
 dkZSasjoH2MDtqW47AYs1izhJ+wAe5h4MhOSk7gbU4ah6xcTDknCP7bWnG0JPFMwem7w
 tmDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732754506; x=1733359306;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7NRgDApEuXu7pC+MgJEeX6ix7kAuF/Lf9HX8SCoJDM8=;
 b=G0Udfx9BwpxpIze+F4N4RsnWd9A04WcYihGxbtPPV0Qecye0Ry60DPHvUJ7tH9LWnk
 h8xuvv9l92FqYD8BMWwIxeyGiepfWDLh2ppJwvdDQdDvQSa7DH240effnOZbyXh6XF/M
 kTVPg2h8RxtOr+xClb4TBSilqXYukzNtbR5tIU74sz9+eG4LK6XNb7x7QdD20eFN7Tw/
 Z3XovhO2k485D6MaP2v/bDF6t5Mi73V3pBb9IwlOptqlzwe7Dfau3wgQ1/mpZbmarf3q
 mZqMguwoFXTTCOYMkubCybKKc7tmVPBROO8X5PU78BwpXzLRXADim64fr9Dy1vWGfMi9
 KlkA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWENayuKkGL5SmmQUnq2ZhBCyg11mnZckt69BYgysXF0nQ8kCNx4mFG/dCFaS/HX2uPw7H0f0H44RuC@nongnu.org
X-Gm-Message-State: AOJu0YyJek5mREh6pOUy1/BmaFY/dM/NuZ8LzarBuKQ+1cOKPahY0CXK
 Ny1eWYlRL7NuzZ8PPFO4YDwZ+TBfFQDPzTX49DWZhw7Rk4hKeJt3ATt4P41Re+oZE91eOy1SGWa
 uhC+xDC5iSyTVhFDPf0b/lkTYf38=
X-Gm-Gg: ASbGncsY0979dKYfjC8ql4NRxvpJIednPAtGezoaRZ/bamVY13mrGMoCg/Fa5GoKbd+
 unoZXuYJrLQpzE3ZKmFDKZ8NSGzj8QF0ADyNXWOM/5VWmFxv/kPvWeX3TH/DffA==
X-Google-Smtp-Source: AGHT+IHlYxb/MZNfVYp2x1uE4Z/kj1ZuuAD4/FziV9g6zidxMLEQ5wloHDjuy2AhGvV4XuqkeOAoHNAXzig4V3ZxgA8=
X-Received: by 2002:a05:6102:f0a:b0:4af:3f3c:515d with SMTP id
 ada2fe7eead31-4af447ba11amr6834821137.4.1732754505972; Wed, 27 Nov 2024
 16:41:45 -0800 (PST)
MIME-Version: 1.0
References: <cover.1475195078.git.alistair.francis@xilinx.com>
 <10f2a9dce5e5e11b6c6d959415b0ad6ee22bcba5.1475195078.git.alistair.francis@xilinx.com>
 <c32ee498-4bc4-408a-bc28-ab21563bb2e3@linaro.org>
In-Reply-To: <c32ee498-4bc4-408a-bc28-ab21563bb2e3@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 28 Nov 2024 10:41:20 +1000
Message-ID: <CAKmqyKNJxL6fRWYA1fka3dERt+6FWM=YveoQVBpXe9GV16jmgQ@mail.gmail.com>
Subject: Re: [PATCH v13 1/2] generic-loader: Add a generic loader
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Alistair Francis <alistair.francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@amd.com>, 
 qemu-devel@nongnu.org, peter.maydell@linaro.org, pbonzini@redhat.com, 
 Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e2f;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe2f.google.com
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

On Thu, Nov 28, 2024 at 2:09=E2=80=AFAM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> Hi,
>
> [very old patch merged as commit e481a1f63c93]
>
> On 30/9/16 02:25, Alistair Francis wrote:
> > Add a generic loader to QEMU which can be used to load images or set
> > memory values.
> >
> > Internally inside QEMU this is a device. It is a strange device that
> > provides no hardware interface but allows QEMU to monkey patch memory
> > specified when it is created. To be able to do this it has a reset
> > callback that does the memory operations.
> >
> > This device allows the user to monkey patch memory. To be able to do
> > this it needs a backend to manage the datas, the same as other
> > memory-related devices. In this case as the backend is so trivial we
> > have merged it with the frontend instead of creating and maintaining a
> > seperate backend.
> >
> > Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
> > Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> > Acked-by: Markus Armbruster <armbru@redhat.com>
> > ---
>
> > diff --git a/hw/core/generic-loader.c b/hw/core/generic-loader.c
> > new file mode 100644
> > index 0000000..79ab6df
> > --- /dev/null
> > +++ b/hw/core/generic-loader.c
> > @@ -0,0 +1,211 @@
> > +/*
> > + * Generic Loader
> > + *
> > + * Copyright (C) 2014 Li Guang
> > + * Copyright (C) 2016 Xilinx Inc.
> > + * Written by Li Guang <lig.fnst@cn.fujitsu.com>
> > + *
> > + * This program is free software; you can redistribute it and/or modif=
y it
> > + * under the terms of the GNU General Public License as published by t=
he
> > + * Free Software Foundation; either version 2 of the License, or
> > + * (at your option) any later version.
> > + *
> > + * This program is distributed in the hope that it will be useful, but=
 WITHOUT
> > + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY =
or
> > + * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public Licens=
e
> > + * for more details.
> > + *
> > + */
> > +
> > +/*
> > + * Internally inside QEMU this is a device. It is a strange device tha=
t
> > + * provides no hardware interface but allows QEMU to monkey patch memo=
ry
> > + * specified when it is created. To be able to do this it has a reset
> > + * callback that does the memory operations.
> > +
> > + * This device allows the user to monkey patch memory. To be able to d=
o
> > + * this it needs a backend to manage the datas, the same as other
> > + * memory-related devices. In this case as the backend is so trivial w=
e
> > + * have merged it with the frontend instead of creating and maintainin=
g a
> > + * seperate backend.
> > + */
> > +
> > +#include "qemu/osdep.h"
> > +#include "qom/cpu.h"
> > +#include "hw/sysbus.h"
> > +#include "sysemu/dma.h"
> > +#include "hw/loader.h"
> > +#include "qapi/error.h"
> > +#include "hw/core/generic-loader.h"
> > +
> > +#define CPU_NONE 0xFFFFFFFF
> > +
> > +static void generic_loader_reset(void *opaque)
> > +{
> > +    GenericLoaderState *s =3D GENERIC_LOADER(opaque);
> > +
> > +    if (s->set_pc) {
> > +        CPUClass *cc =3D CPU_GET_CLASS(s->cpu);
> > +        cpu_reset(s->cpu);
> > +        if (cc) {
> > +            cc->set_pc(s->cpu, s->addr);
> > +        }
> > +    }
> > +
> > +    if (s->data_len) {
> > +        assert(s->data_len < sizeof(s->data));
> > +        dma_memory_write(s->cpu->as, s->addr, &s->data, s->data_len);
> > +    }
> > +}
> > +
> > +static void generic_loader_realize(DeviceState *dev, Error **errp)
> > +{
> > +    GenericLoaderState *s =3D GENERIC_LOADER(dev);
> > +    hwaddr entry;
> > +    int big_endian;
> > +    int size =3D 0;
> > +
> > +    s->set_pc =3D false;
> > +
> > +    /* Perform some error checking on the user's options */
> > +    if (s->data || s->data_len  || s->data_be) {
> > +        /* User is loading memory values */
> > +        if (s->file) {
> > +            error_setg(errp, "Specifying a file is not supported when =
loading "
> > +                       "memory values");
> > +            return;
> > +        } else if (s->force_raw) {
> > +            error_setg(errp, "Specifying force-raw is not supported wh=
en "
> > +                       "loading memory values");
> > +            return;
> > +        } else if (!s->data_len) {
> > +            /* We cant' check for !data here as a value of 0 is still =
valid. */
> > +            error_setg(errp, "Both data and data-len must be specified=
");
> > +            return;
> > +        } else if (s->data_len > 8) {
> > +            error_setg(errp, "data-len cannot be greater then 8 bytes"=
);
>
> If s->data_len < 8 (like 4 or 2) ...
>
> > +            return;
> > +        }
> > +    } else if (s->file || s->force_raw)  {
> > +        /* User is loading an image */
> > +        if (s->data || s->data_len || s->data_be) {
> > +            error_setg(errp, "data can not be specified when loading a=
n "
> > +                       "image");
> > +            return;
> > +        }
> > +        s->set_pc =3D true;
> > +    } else if (s->addr) {
> > +        /* User is setting the PC */
> > +        if (s->data || s->data_len || s->data_be) {
> > +            error_setg(errp, "data can not be specified when setting a=
 "
> > +                       "program counter");
> > +            return;
> > +        } else if (!s->cpu_num) {
> > +            error_setg(errp, "cpu_num must be specified when setting a=
 "
> > +                       "program counter");
> > +            return;
> > +        }
> > +        s->set_pc =3D true;
> > +    } else {
> > +        /* Did the user specify anything? */
> > +        error_setg(errp, "please include valid arguments");
> > +        return;
> > +    }
> > +
> > +    qemu_register_reset(generic_loader_reset, dev);
> > +
> > +    if (s->cpu_num !=3D CPU_NONE) {
> > +        s->cpu =3D qemu_get_cpu(s->cpu_num);
> > +        if (!s->cpu) {
> > +            error_setg(errp, "Specified boot CPU#%d is nonexistent",
> > +                       s->cpu_num);
> > +            return;
> > +        }
> > +    } else {
> > +        s->cpu =3D first_cpu;
> > +    }
> > +
> > +#ifdef TARGET_WORDS_BIGENDIAN
> > +    big_endian =3D 1;
> > +#else
> > +    big_endian =3D 0;
> > +#endif
> > +
> > +    if (s->file) {
> > +        if (!s->force_raw) {
> > +            size =3D load_elf_as(s->file, NULL, NULL, &entry, NULL, NU=
LL,
> > +                               big_endian, 0, 0, 0, s->cpu->as);
> > +
> > +            if (size < 0) {
> > +                size =3D load_uimage_as(s->file, &entry, NULL, NULL, N=
ULL, NULL,
> > +                                      s->cpu->as);
> > +            }
> > +        }
> > +
> > +        if (size < 0 || s->force_raw) {
> > +            /* Default to the maximum size being the machine's ram siz=
e */
> > +            size =3D load_image_targphys_as(s->file, s->addr, ram_size=
,
> > +                                          s->cpu->as);
> > +        } else {
> > +            s->addr =3D entry;
> > +        }
> > +
> > +        if (size < 0) {
> > +            error_setg(errp, "Cannot load specified image %s", s->file=
);
> > +            return;
> > +        }
> > +    }
> > +
> > +    /* Convert the data endiannes */
> > +    if (s->data_be) {
> > +        s->data =3D cpu_to_be64(s->data);
> > +    } else {
> > +        s->data =3D cpu_to_le64(s->data);
>
> ... and if we swap, we ignore the data-len and swap 64-bit
> regardless, returning invalid data.
>
> I.e. data=3D0x1122, data-len=3D2, once swapped we get data=3D0x0000.
>
> Is that expected?

I don't think that's expected

Alistair

