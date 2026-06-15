Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 321E7CD98DA
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 11:54:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZ5st-0007AO-Uf; Mon, 15 Jun 2026 07:53:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZ5ss-0007A4-C7
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 07:53:42 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZ5sq-000792-MP
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 07:53:42 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-6914a658115so4040685a12.0
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 04:53:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781524419; cv=none;
 d=google.com; s=arc-20240605;
 b=AatRTiDoVNj95gMegGmG+Iur81ZIrVNROHs+vJt8qebIxWIOeyUGMV+mQAF8hSfSjR
 Lba/MfrH5NdqTJVbngBQ7olTyXoF7QINDUei0RI+ZAu1OBi5GiMnI/gcb/XhR7QyMlkw
 WdsaS5nMzMGKN3Fln1JIdIxrWL9Ru0U8zGgKokafugENHNsFUe9NPVjb7JXyYMQxj2OI
 x17ZopYXJP5COGhdsfxycyUydn8f/nTIhdXS8LzevcVONr2ww3G6kkpuHARCROftERlb
 thzWURT0/2IA4dnTd3BfYeQGNh5DYj45B5jm6h0nggJL30vqf+lszVhl4vDxZYgXZqUT
 07Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=irQGXNvX1c+hVsVW90WSq0r6lTfshMZUx1ief8C4dz4=;
 fh=61SNLsXYOrBTMV8dKwA6hBgiAC84ZSEM9nJxSq5B2yw=;
 b=h8AgpuSr4DaoO2fyF3VvYgUUDa76ErhpxVNjkMilqIStPIe4lg1JpTIHHyPR2tnjwX
 G5crh33nvyROboqR2Prgu5m2gOSmOoaJxXwO43Ir/rmOAviratN05e+IJRAhckvot/tq
 g1Q1JvfOYcKqyoRb6RjZpyYN8sKWzdF5FAYuxrX/A/IsSshXRPVi6ukN3OQfUYphra6V
 45yzC/+KNyEghD70q5JtbfwNC2rN5/ZIL8/Mx/oI+uuO27Amg/xRMdLzE9K4krCTUrhM
 XK+tJ9h+25IXaylE3woxknrhnJtNNjbPHnRjCXYe0O6rsblFOZmpNUqZPQHqqFa7mhN4
 QpOQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781524419; x=1782129219; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=irQGXNvX1c+hVsVW90WSq0r6lTfshMZUx1ief8C4dz4=;
 b=D1AghSwNaOaKneE4KqQ0LN/hNDY5c9VZiO+FHD26ENZ3x0Can2S6iuTSa80PtWHpUP
 Xru1vm5rdkXqPkgYpKbTH48C2qqYYboZGMOrzoazRhUFlsaNdJAMzYwX6RSx9p3iWJKm
 Vie6CzffiHCGrAxjDma1sw68BuUg0+tg+YwoRjYpV9txUzcro4dDUb3rJJ+HHgeuNZck
 FliIQXs+rQZ4Z0HfM/vfOe4ciSdFC8Nki6QExyiXjlPxBjRtk5KEVGKiE704thCQFHuM
 lmpm+Et4SU4v5KYF6j8KrTkf8AKVhegSyi0r747nJbymZkBd6gHXUH1j2LMavJB98Ncl
 v99A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781524419; x=1782129219;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=irQGXNvX1c+hVsVW90WSq0r6lTfshMZUx1ief8C4dz4=;
 b=lgCmZoJ7iUkF2qe/ZXSwgiighwXX2NBt+LfMq05kYgASQKMJZ88JkmAZEywtrRgb0K
 JIzmN42vsMcrbDzERlTKn3mUVhrgF/2zEeP9ftSW/T6Sy0ectTWTkecwh4FwIs00TfPZ
 EHz6N3cnqYTE0wpegHTTe6Gwum3V/CXqJJVgiGnut1bTqGgJIzyccJh8U1uh5LiDNs+T
 6h1D2PC36h+LlOm73Nt1srizezhNuzHi5k3H7dlDIOhgB8AlI7r6WInT247LZzUjHDZc
 r0Cdz2oiALdvHDy3fTz4HyNpDb6qbxdBsIvRt08cCKoFRQhCTbeKc47ifMYurD6T+/Ul
 eSOQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ85dbw5f7elHzKinFde9wHBhmGKpvVAQpdFu3gs7EedXFPf0HXsboVw6dWP4HMMjuXDtR4EJCHMBmSE@nongnu.org
X-Gm-Message-State: AOJu0YzgtKUkipyU/m2wOhqyAhbZs2ZgXnYNEDtjnajY8qFmCHfMupEM
 60rLUrRrbEz54owMdsB40CQizvPG6SOUb4cP4KGURNJcb/9Vk0jD3Tp0NLGx59ze+NnAH9KMFPw
 v396BZpr5dr2hdc6dYHmqUHWeIxFBQmw=
X-Gm-Gg: Acq92OF9VS+jolWYC+eSBR/rm7L0xH8OTuDr4hw0flRoPylJNwdIhzmYcYjJb1eqKBg
 wH0MWZBuXeUh7GUDPfjSDxXkHrF7PPmjSMPNfA4YPJa6jIfLbVQ33Zie/A0f4jnuiyuboKsjCca
 34GtIIWJubDYS89eB+OwDqu7DSCoh2ZLhvDJhZFcBehFOB5WT5Ssc4s9Kat1Etn56/6CGK7DbkJ
 8IcHTbAGMjiqindGFUZi8dwinNTsPuY8eaLuw7FJq1CAP7c9MMPgmBGOJNI5LrqD1DZSZEFsjOd
 u/6xu/mB
X-Received: by 2002:a05:6402:26d1:b0:67c:a6d1:c48b with SMTP id
 4fb4d7f45d1cf-693784f79a5mr6316417a12.11.1781524418788; Mon, 15 Jun 2026
 04:53:38 -0700 (PDT)
MIME-Version: 1.0
References: <20260603065859.592063-1-joel@jms.id.au>
 <20260603065859.592063-13-joel@jms.id.au>
In-Reply-To: <20260603065859.592063-13-joel@jms.id.au>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 15 Jun 2026 21:53:12 +1000
X-Gm-Features: AVVi8Cf2KJ7rXoWCtc7Q__CCytATdOJt-YFA8v5cFn1PAS99aEtx51k0FHONeaw
Message-ID: <CAKmqyKOYeG24747aN-OyOCFi-Knb3vc5E0FV2PM-FstCmf3Xgg@mail.gmail.com>
Subject: Re: [PATCH v8 12/12] hw/riscv/atlantis: Add some i2c peripherals
To: Joel Stanley <joel@jms.id.au>
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Nicholas Piggin <npiggin@gmail.com>, 
 Andrew Jones <andrew.jones@oss.qualcomm.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, 
 Michael Ellerman <mpe@kernel.org>, Joel Stanley <jms@oss.tenstorrent.com>, 
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>, 
 Portia Stephens <portias@oss.tenstorrent.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x529.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Jun 3, 2026 at 5:03=E2=80=AFPM Joel Stanley <joel@jms.id.au> wrote:
>
> Add an I2C RTC device and a temperature sensor. These are not present
> on the board but help for testing.

It might be best to leave this out, if these aren't on the board
should they really go upstream?

Alistair

>
> The tmp105 is a lm75 compatible temperature sensor used by the
> SENSORS_LM75 Linux kernel driver.
>
> The ds1338 is a RTC device that is used by the RTC_DRV_DS1307 Linux
> kernel driver.
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
>  hw/riscv/tt_atlantis.c | 27 +++++++++++++++++++++++++++
>  hw/riscv/Kconfig       |  2 ++
>  2 files changed, 29 insertions(+)
>
> diff --git a/hw/riscv/tt_atlantis.c b/hw/riscv/tt_atlantis.c
> index b1ff0cbe2f61..5434650dd41e 100644
> --- a/hw/riscv/tt_atlantis.c
> +++ b/hw/riscv/tt_atlantis.c
> @@ -63,6 +63,13 @@ static const MemMapEntry tt_atlantis_memmap[] =3D {
>      [TT_ATL_DDR_HI] =3D          { 0x100000000,  0x1000000000 },
>  };
>
> +static I2CBus *i2c_get_bus(TTAtlantisState *s, unsigned busnr)
> +{
> +    assert(busnr < TT_ATL_NUM_I2C);
> +
> +    return s->i2c[busnr].bus;
> +}
> +
>  static uint32_t next_phandle(void)
>  {
>      static uint32_t phandle =3D 1;
> @@ -367,6 +374,19 @@ static void create_fdt_i2c(void *fdt, const MemMapEn=
try *mem, uint32_t irq,
>      qemu_fdt_setprop_cell(fdt, name, "#size-cells", 0);
>  }
>
> +static void create_fdt_i2c_device(TTAtlantisState *s, int bus,
> +                                  const char *compat, int addr)
> +{
> +    void *fdt =3D MACHINE(s)->fdt;
> +    hwaddr base =3D s->memmap[TT_ATL_I2C0 + bus].base;
> +    g_autofree char *name =3D g_strdup_printf("/soc/i2c@%"HWADDR_PRIX"/s=
ensor@%x",
> +                                            base, addr);
> +
> +    qemu_fdt_add_subnode(fdt, name);
> +    qemu_fdt_setprop_string(fdt, name, "compatible", compat);
> +    qemu_fdt_setprop_cell(fdt, name, "reg", addr);
> +}
> +
>  static void finalize_fdt(TTAtlantisState *s)
>  {
>      uint32_t aplic_s_phandle =3D next_phandle();
> @@ -394,6 +414,9 @@ static void finalize_fdt(TTAtlantisState *s)
>                         TT_ATL_I2C0_IRQ + i,
>                         aplic_s_phandle, periph_clk_phandle);
>      }
> +
> +    create_fdt_i2c_device(s, 0, "dallas,ds1338", 0x6f);
> +    create_fdt_i2c_device(s, 4, "ti,tmp105", 0x48);
>  }
>
>  static void create_fdt(TTAtlantisState *s)
> @@ -640,6 +663,10 @@ static void tt_atlantis_machine_init(MachineState *m=
achine)
>                             qdev_get_gpio_in(s->irqchip, TT_ATL_I2C0_IRQ =
+ i));
>      }
>
> +    /* I2C peripherals: qemu specific */
> +    i2c_slave_create_simple(i2c_get_bus(s, 0), "ds1338", 0x6f);
> +    i2c_slave_create_simple(i2c_get_bus(s, 4), "tmp105", 0x48);
> +
>      /* Load or create device tree */
>      if (machine->dtb) {
>          load_fdt(s);
> diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
> index 38180a903fbf..ff2d250ee439 100644
> --- a/hw/riscv/Kconfig
> +++ b/hw/riscv/Kconfig
> @@ -130,6 +130,8 @@ config TENSTORRENT
>      select SERIAL_MM
>      select DEVICE_TREE
>      select DESIGNWARE_I2C
> +    select DS1338
> +    select TMP105
>
>  config XIANGSHAN_KUNMINGHU
>      bool
> --
> 2.47.3
>
>

