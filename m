Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A34FACDDE5B
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 10:20:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3YSq-0006Yw-U8; Wed, 23 Oct 2024 06:19:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1t3YSp-0006Ya-Qz
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 06:19:39 -0400
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1t3YSn-00013L-KE
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 06:19:39 -0400
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-539e6c754bdso6374404e87.2
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2024 03:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1729678775; x=1730283575; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WRLEGApwpGdGi+H55ZQdwD4cV1bsdddx0DAwJ56BiGI=;
 b=SyyKlV5vXiBts0qgzvhMNUy+133MHajkgeCeGcHAU17YjH3TlgIYhtecZuAxTKHK7Y
 ywdSbtXBR5+oHtPxwSIhds/nXaybyLtzYiHO+LyLKw8uD++1xWB0rtkiGDhNta3dU6DH
 aDp1h8gm0BMzyBLRyj4vXklqTtv5FJhc82JQuje9vsfsqvcDZt+WGJsdXclh2KXG915N
 60yFv7f1yPA6T1a+GG2YNhQ1mczvU0FIXDUCrv1QB2J+q2adW7r5uMTh8lfcOqsWCbp5
 c0HXnzXjWVLmoPzU6f6/bN2HqiLWyVkORa/tpCF4lc1LnOBjdGFnTRFI6YwDgu56+tvX
 HUyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729678775; x=1730283575;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WRLEGApwpGdGi+H55ZQdwD4cV1bsdddx0DAwJ56BiGI=;
 b=rQlvvacrBQPWzxBx1e+GwhgGhorxRjHlakqvlcwK1RLJ8FXziCo3PTBd6H/wJAFg9v
 A3JiGX2DS3aARbSw+gcTqRwwyfz3xqCHLV6Aik3YMKuLddvNvTQaPH9X0JS2QyTtIRNi
 Ollkt58fLApuwwHR/Gi105fyWTdX4QWxTJwBTFe/ol0xvYNeHry4JvAkGrfFhbGa2a8U
 9WYtfBb6fhSrfZx4m3RK9sdWQByjcB96sIN6pF8i0sbc4n86FneYnw7YKICLsD9EE5Z4
 nP4/OT9++uc1OIzITaKYx3VokPkD8Wg+L8pK6Ks9f2zTJ6GEGZH1sLjXz3ApsJ3ZRXSn
 fFBA==
X-Gm-Message-State: AOJu0YxaMSSOj8DiXq1UO/P2+nprpB7NepzglOM5VaWOV7IqrPkmulWa
 knbKvLryAs5KyF62OlGKKEH2C/rLNVS2CHZ9T6evVHZqzV7jmRsrWGNhFEvzh3jF+fVEYobh8Y4
 DnAbV3NO7Unh1mkYPFn1+zQMvqR7djSMSZSV5fQ==
X-Google-Smtp-Source: AGHT+IED6r7UVuT3+KM99rLXtSm9Vypcu90WjhQ9PherDVmGgj5QiVl7ynXSrsAY6nTEpiSYVBw5y/qz8QmUdVrWKT8=
X-Received: by 2002:a05:6512:401a:b0:539:f953:2da7 with SMTP id
 2adb3069b0e04-53b1a3a70a5mr1000871e87.50.1729678775209; Wed, 23 Oct 2024
 03:19:35 -0700 (PDT)
MIME-Version: 1.0
References: <20241021040942.400-1-jim.shu@sifive.com>
 <20241021040942.400-2-jim.shu@sifive.com>
 <7a631349-accf-49b0-a679-f62b1cfb4b1c@ventanamicro.com>
In-Reply-To: <7a631349-accf-49b0-a679-f62b1cfb4b1c@ventanamicro.com>
From: Jim Shu <jim.shu@sifive.com>
Date: Wed, 23 Oct 2024 18:19:19 +0800
Message-ID: <CALw707qX6XzHPyL3uj2AHBxNvQ7_-yaRhVcNoCcwPgtM7mP74A@mail.gmail.com>
Subject: Re: [PATCH 1/2] hw/riscv: Support to load DTB after 3GB memory on
 64-bit system.
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=jim.shu@sifive.com; helo=mail-lf1-x133.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, Oct 21, 2024 at 9:42=E2=80=AFPM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
>
>
> On 10/21/24 1:09 AM, Jim Shu wrote:
> > Larger initrd image will overlap the DTB at 3GB address. Since 64-bit
> > system doesn't have 32-bit addressable issue, we just load DTB to the e=
nd
> > of dram in 64-bit system.
> >
> > Signed-off-by: Jim Shu <jim.shu@sifive.com>
> > ---
> >   hw/riscv/boot.c            | 8 ++++++--
> >   hw/riscv/microchip_pfsoc.c | 4 ++--
> >   hw/riscv/sifive_u.c        | 4 ++--
> >   hw/riscv/spike.c           | 4 ++--
> >   hw/riscv/virt.c            | 2 +-
> >   include/hw/riscv/boot.h    | 2 +-
> >   6 files changed, 14 insertions(+), 10 deletions(-)
> >
> > diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
> > index 9115ecd91f..ad45bd7a6a 100644
> > --- a/hw/riscv/boot.c
> > +++ b/hw/riscv/boot.c
> > @@ -293,7 +293,7 @@ out:
> >    * The FDT is fdt_packed() during the calculation.
> >    */
> >   uint64_t riscv_compute_fdt_addr(hwaddr dram_base, hwaddr dram_size,
> > -                                MachineState *ms)
> > +                                MachineState *ms, RISCVHartArrayState =
*harts)
> >   {
> >       int ret =3D fdt_pack(ms->fdt);
> >       hwaddr dram_end, temp;
> > @@ -321,7 +321,11 @@ uint64_t riscv_compute_fdt_addr(hwaddr dram_base, =
hwaddr dram_size,
> >        * Thus, put it at an 2MB aligned address that less than fdt size=
 from the
> >        * end of dram or 3GB whichever is lesser.
> >        */
> > -    temp =3D (dram_base < 3072 * MiB) ? MIN(dram_end, 3072 * MiB) : dr=
am_end;
> > +    if (!riscv_is_32bit(harts)) {
> > +        temp =3D dram_end;
> > +    } else {
> > +        temp =3D (dram_base < 3072 * MiB) ? MIN(dram_end, 3072 * MiB) =
: dram_end;
> > +    }
>
> I think it's a fine idea to do a different computation if we're running a=
 64 bit
> CPU but this alone won't fix the issue you're reporting.
>
> Running a 64-bit CPU does not guarantee that 'dram_end' will be enough to=
 fit
> kernel+initrd and the fdt. There's no correlation between running 64 bits=
 and having
> enough RAM to fit everything, i.e. you can run a 64-bit CPU with short RA=
M and end
> up with the same problem. There's also the board mem topology to account =
for: the
> Microchip board will always use a 1GB ram bank ('dram_end' will be always=
 1Gb max)
> running 32 or 64 bit CPUs.
>
> It seems that we also need to consider the end of kernel+initrd to proper=
ly tune
> where to put the fdt, erroring out if we don't have enough size for every=
thing.
> This would make the logic work regardless of the word size of the CPU.
>
> This information is calculated in riscv_load_kernel(), which is currently
> returning only the kernel start addr.  We have the information we need wr=
itten in
> the FDT as "/chosen/linux,initrd-end" but that isn't enough because this =
attribute
> is written only if we have an initrd. We would hit the same problem again=
 if we
> have a big enough kernel in an low enough RAM env.
>
> First thing that comes to mind is to use an abstraction like
>
> typedef struct RISCVBootProps {
>      uint64_t kernel_start;
>      uint64_t kernel_end;
>      bool is_64bit;
> } RISCVKernelProps;
>
> And use it to allow riscv_load_kernel() to write both kernel_start (the c=
urrent
> return value) and kernel_end (that can be either kernel_start + kernel_si=
ze or,
> if we have an initrd, the value written in linux,initrd-end). riscv_compu=
te_fdt_addr()
> would then use this as an extra arg and then we have the 'kernel_end' val=
ue to
> calculate the fdt_addr too.
>
>
>
> In fact, I think this can be further extended to fully encapsulate the bo=
ot process
> of all boards, that are kind of doing the same thing with all these helpe=
rs, into a
> single 'super function' that would receive a struct like the one from abo=
ve (with
> more properties), setting all the boot parameters the board needs, pass i=
t to a single
> function that does everything and just use the result as each board wants=
. This
> is something that we might play around with but it'll be something for th=
e next
> release.
>
>
> Thanks,
>
> Daniel

Thanks for the feedback. I can try to add the checking of overlapping
between initrd and dtb in the V2 patch.
I think it may change some boot APIs in "hw/riscv/boot.c"

ARM has an abstraction of the most info in `struct arm_boot_info`, so
it can add checkings in the functions like
`arm_setup_direct_kernel_boot()`.
We may do the similar work but be simpler at first.


Thanks,
Jim Shu

>
>
>
> >
> >       return QEMU_ALIGN_DOWN(temp - fdtsize, 2 * MiB);
> >   }
> > diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
> > index f9a3b43d2e..ba8b0a2c26 100644
> > --- a/hw/riscv/microchip_pfsoc.c
> > +++ b/hw/riscv/microchip_pfsoc.c
> > @@ -519,7 +519,7 @@ static void microchip_icicle_kit_machine_init(Machi=
neState *machine)
> >       bool kernel_as_payload =3D false;
> >       target_ulong firmware_end_addr, kernel_start_addr;
> >       uint64_t kernel_entry;
> > -    uint32_t fdt_load_addr;
> > +    uint64_t fdt_load_addr;
> >       DriveInfo *dinfo =3D drive_get(IF_SD, 0, 0);
> >
> >       /* Sanity check on RAM size */
> > @@ -625,7 +625,7 @@ static void microchip_icicle_kit_machine_init(Machi=
neState *machine)
> >           /* Compute the fdt load address in dram */
> >           fdt_load_addr =3D riscv_compute_fdt_addr(memmap[MICROCHIP_PFS=
OC_DRAM_LO].base,
> >                                                  memmap[MICROCHIP_PFSOC=
_DRAM_LO].size,
> > -                                               machine);
> > +                                               machine, &s->soc.u_cpus=
);
> >           riscv_load_fdt(fdt_load_addr, machine->fdt);
> >
> >           /* Load the reset vector */
> > diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
> > index 9b3dcf3a7a..fd974f2357 100644
> > --- a/hw/riscv/sifive_u.c
> > +++ b/hw/riscv/sifive_u.c
> > @@ -519,7 +519,7 @@ static void sifive_u_machine_init(MachineState *mac=
hine)
> >       const char *firmware_name;
> >       uint32_t start_addr_hi32 =3D 0x00000000;
> >       int i;
> > -    uint32_t fdt_load_addr;
> > +    uint64_t fdt_load_addr;
> >       uint64_t kernel_entry;
> >       DriveInfo *dinfo;
> >       BlockBackend *blk;
> > @@ -606,7 +606,7 @@ static void sifive_u_machine_init(MachineState *mac=
hine)
> >
> >       fdt_load_addr =3D riscv_compute_fdt_addr(memmap[SIFIVE_U_DEV_DRAM=
].base,
> >                                              memmap[SIFIVE_U_DEV_DRAM].=
size,
> > -                                           machine);
> > +                                           machine, &s->soc.u_cpus);
> >       riscv_load_fdt(fdt_load_addr, machine->fdt);
> >
> >       if (!riscv_is_32bit(&s->soc.u_cpus)) {
> > diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
> > index fceb91d946..acd7ab1ae1 100644
> > --- a/hw/riscv/spike.c
> > +++ b/hw/riscv/spike.c
> > @@ -201,7 +201,7 @@ static void spike_board_init(MachineState *machine)
> >       hwaddr firmware_load_addr =3D memmap[SPIKE_DRAM].base;
> >       target_ulong kernel_start_addr;
> >       char *firmware_name;
> > -    uint32_t fdt_load_addr;
> > +    uint64_t fdt_load_addr;
> >       uint64_t kernel_entry;
> >       char *soc_name;
> >       int i, base_hartid, hart_count;
> > @@ -317,7 +317,7 @@ static void spike_board_init(MachineState *machine)
> >
> >       fdt_load_addr =3D riscv_compute_fdt_addr(memmap[SPIKE_DRAM].base,
> >                                              memmap[SPIKE_DRAM].size,
> > -                                           machine);
> > +                                           machine, &s->soc[0]);
> >       riscv_load_fdt(fdt_load_addr, machine->fdt);
> >
> >       /* load the reset vector */
> > diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> > index ee3129f3b3..cfbeeaf7d5 100644
> > --- a/hw/riscv/virt.c
> > +++ b/hw/riscv/virt.c
> > @@ -1399,7 +1399,7 @@ static void virt_machine_done(Notifier *notifier,=
 void *data)
> >
> >       fdt_load_addr =3D riscv_compute_fdt_addr(memmap[VIRT_DRAM].base,
> >                                              memmap[VIRT_DRAM].size,
> > -                                           machine);
> > +                                           machine, &s->soc[0]);
> >       riscv_load_fdt(fdt_load_addr, machine->fdt);
> >
> >       /* load the reset vector */
> > diff --git a/include/hw/riscv/boot.h b/include/hw/riscv/boot.h
> > index 18bfe9f7bf..7ccbe5f62a 100644
> > --- a/include/hw/riscv/boot.h
> > +++ b/include/hw/riscv/boot.h
> > @@ -49,7 +49,7 @@ target_ulong riscv_load_kernel(MachineState *machine,
> >                                  bool load_initrd,
> >                                  symbol_fn_t sym_cb);
> >   uint64_t riscv_compute_fdt_addr(hwaddr dram_start, uint64_t dram_size=
,
> > -                                MachineState *ms);
> > +                                MachineState *ms, RISCVHartArrayState =
*harts);
> >   void riscv_load_fdt(hwaddr fdt_addr, void *fdt);
> >   void riscv_setup_rom_reset_vec(MachineState *machine, RISCVHartArrayS=
tate *harts,
> >                                  hwaddr saddr,

