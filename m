Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA96DC5321E
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2024 00:07:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1siNGc-0004T2-DG; Sun, 25 Aug 2024 20:07:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1siNGa-0004Fl-Fe; Sun, 25 Aug 2024 20:07:28 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1siNGY-00015h-Sn; Sun, 25 Aug 2024 20:07:28 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5bed72ff2f2so4538138a12.2; 
 Sun, 25 Aug 2024 17:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724630845; x=1725235645; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C9+9xKI5agTW7ctUZ54KfDyxEXojQUG4SZi93TVJGhs=;
 b=im1pyXCoFX40+D7RJQogS1y2H5n4dCy12uDiLD1VrT/dOL4QnDPsuKEdkmutW9t2vy
 kZYoj6tYJvPPOAc+1Q8Z2t5zLdYmHtQrLeSYguYwfevj1lCBLpRr4D7KKs62a/ZCn1fH
 CzxYHh2HxnjqsCKaUxSDxRuVNk9ErfEIGEM8kCvAU/2UCdPTH//Jq070aW9z666hZZKz
 AJZ59c2aUeiEUCVjlsYrWqyXbGMyjN336pkBjSTA7Ndz4A/gfADv8u7FEPDmXNjSnxco
 +rheiB78XZqJdf6YIP0Yubz+W49F3PMIMMfn6J7uMxb56o1Ew9MbIG4pWfQwPk3+NXsN
 /jNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724630845; x=1725235645;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C9+9xKI5agTW7ctUZ54KfDyxEXojQUG4SZi93TVJGhs=;
 b=T6LCo/oa30SNtmlt838+emlT/XyDlCpMize8pGc1l51zCQZ4MNU8EPOCL5aatbBNy0
 1F9ZfdjCy7E20iIGstgMFyasJox+L7UluXeWiR0YWWh8FCi0hyO0Ddvz+A4RtAtjVBHY
 tPMu26ISQVZZ4alYZrTj+q1GFVG8QPc5Qjy+audoNNMz3WT8rEbUzD8pF2xKOKkSmvTd
 zLHNLEXIk0qzwMABm6xJbEJA0P9tUyq4f5mYetVhrMlZPKxW9BIcGSIqcjJpw4pblo1P
 1bR6HldzFlFt10puub0V8j7ru6DpnCKE3qzkiSz+eW0jH5lmTXOq4/gAV5QOWcCzXuIM
 +zwg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXvQZhkAikEHSm5aTKTOtlwXaquV8J8eIJp0vHDEltW0h8Z6GmSb4ZVcbBByAw2L0CxEdGEY6XCv9lu@nongnu.org
X-Gm-Message-State: AOJu0YwjnMC61Vgn7m8E8OKPE3AgUgY1J1VcnT26TjDdZjJ6a+OcrLQB
 T/b1hOzu3YlA103fg+XinVVcibVDZKX8JrNnyAoN0z/NsZoSG5RaGqSz58ku9j9uT2q0HjWyC9M
 hK7Wb0uyHB5dkRRFMRhlKFX5aivE=
X-Google-Smtp-Source: AGHT+IFZaAJlkAzB6qmX4euSTSfnhI36COLI45kpsvTf7Y+a9gd23FcjnmIw+y9FPyY2OUY1cvDM4o9PgVGgLeDtuXY=
X-Received: by 2002:a05:6402:26d5:b0:5be:fd66:edf3 with SMTP id
 4fb4d7f45d1cf-5c089175e75mr5498129a12.18.1724630844556; Sun, 25 Aug 2024
 17:07:24 -0700 (PDT)
MIME-Version: 1.0
References: <20240822162127.705879-1-peter.maydell@linaro.org>
 <20240822162127.705879-6-peter.maydell@linaro.org>
In-Reply-To: <20240822162127.705879-6-peter.maydell@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 26 Aug 2024 10:06:57 +1000
Message-ID: <CAKmqyKNHr3N4dy10X1XUVtA7gBtysz6Dycj=C9rH2FodmBhhBw@mail.gmail.com>
Subject: Re: [PATCH for-9.2 5/6] hw/misc/xlnx-versal-trng: Call
 register_finalize_block
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Francisco Iglesias <francisco.iglesias@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x535.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Fri, Aug 23, 2024 at 2:22=E2=80=AFAM Peter Maydell <peter.maydell@linaro=
.org> wrote:
>
> The TYPE_XLNX_VERSAL_TRNG device creates a register block with
> register_init_block32() in its instance_init method; we must
> therefore destroy it in our instance_finalize method to avoid a leak
> in the QOM introspection "init-inspect-finalize" lifecycle:
>
> Direct leak of 304 byte(s) in 1 object(s) allocated from:
>     #0 0x55842ec799d8 in __interceptor_calloc (/mnt/nvmedisk/linaro/qemu-=
from-laptop/qemu/build/asan/qemu-system-aarch64+0x294e9d8) (BuildId: 47496e=
53f3e779f1c7e9b82cbea07407152b498b)
>     #1 0x7fe793c75c50 in g_malloc0 debian/build/deb/../../../glib/gmem.c:=
161:13
>     #2 0x55842f0aec5d in register_init_block hw/core/register.c:248:34
>     #3 0x55842f0af6be in register_init_block32 hw/core/register.c:299:12
>     #4 0x55842f801588 in trng_init hw/misc/xlnx-versal-trng.c:614:9
>     #5 0x558431c411a1 in object_init_with_type qom/object.c:420:9
>     #6 0x558431c2847b in object_initialize_with_type qom/object.c:562:5
>     #7 0x558431c29d1d in object_new_with_type qom/object.c:782:5
>     #8 0x558431c29df1 in object_new qom/object.c:797:12
>     #9 0x558432427c1d in qmp_device_list_properties qom/qom-qmp-cmds.c:14=
4:11
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  include/hw/misc/xlnx-versal-trng.h | 1 +
>  hw/misc/xlnx-versal-trng.c         | 6 +++---
>  2 files changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/include/hw/misc/xlnx-versal-trng.h b/include/hw/misc/xlnx-ve=
rsal-trng.h
> index 0bcef8a6132..d96f8f9eff3 100644
> --- a/include/hw/misc/xlnx-versal-trng.h
> +++ b/include/hw/misc/xlnx-versal-trng.h
> @@ -50,6 +50,7 @@ typedef struct XlnxVersalTRng {
>      uint64_t forced_prng_count;
>      uint64_t tst_seed[2];
>
> +    RegisterInfoArray *reg_array;
>      uint32_t regs[RMAX_XLNX_VERSAL_TRNG];
>      RegisterInfo regs_info[RMAX_XLNX_VERSAL_TRNG];
>  } XlnxVersalTRng;
> diff --git a/hw/misc/xlnx-versal-trng.c b/hw/misc/xlnx-versal-trng.c
> index c0d1dde8708..86905479b8f 100644
> --- a/hw/misc/xlnx-versal-trng.c
> +++ b/hw/misc/xlnx-versal-trng.c
> @@ -608,9 +608,8 @@ static void trng_init(Object *obj)
>  {
>      XlnxVersalTRng *s =3D XLNX_VERSAL_TRNG(obj);
>      SysBusDevice *sbd =3D SYS_BUS_DEVICE(obj);
> -    RegisterInfoArray *reg_array;
>
> -    reg_array =3D
> +    s->reg_array =3D
>          register_init_block32(DEVICE(obj), trng_regs_info,
>                                ARRAY_SIZE(trng_regs_info),
>                                s->regs_info, s->regs,
> @@ -618,7 +617,7 @@ static void trng_init(Object *obj)
>                                XLNX_VERSAL_TRNG_ERR_DEBUG,
>                                R_MAX * 4);
>
> -    sysbus_init_mmio(sbd, &reg_array->mem);
> +    sysbus_init_mmio(sbd, &s->reg_array->mem);
>      sysbus_init_irq(sbd, &s->irq);
>
>      s->prng =3D g_rand_new();
> @@ -628,6 +627,7 @@ static void trng_finalize(Object *obj)
>  {
>      XlnxVersalTRng *s =3D XLNX_VERSAL_TRNG(obj);
>
> +    register_finalize_block(s->reg_array);
>      g_rand_free(s->prng);
>      s->prng =3D NULL;
>  }
> --
> 2.34.1
>
>

