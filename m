Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6C21CCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 07:24:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6OWA-0003Nx-4H; Wed, 08 Oct 2025 03:23:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1v6OW8-0003NP-78
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 03:23:20 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1v6OW5-0001GL-Mz
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 03:23:19 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-b41870fef44so1392553566b.3
 for <qemu-devel@nongnu.org>; Wed, 08 Oct 2025 00:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1759908196; x=1760512996; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KmTtfQn485dwI5VyrBNqFWBnPgTEl3i8e/JThGkX2tQ=;
 b=YzgrexsADpuquJt7lCVZG+GptIbl24SaxbxDUUW7OirD5g4FqiIKgoRW2Lylbo/sbX
 RFkFlcLfiSfuydSSfGJwaFo/i9HwvTLHdw4CfpeKCjlXtqx95e42YJ7CgIuEYZfn1FYT
 1MEnO6VbxkUNa7E+aX2PwZddvDVZXI5Nkq2MHHRVr3ZME3i6KlqSJhMsHCINEM1rU1By
 0Pe0RnTINHbKNMV72MTsKBaFujXPl5yA1lsQJ/1xFYtJy/Wrjak3km1hQcnEXUBDu2DS
 inoc9lo0UlxpQBLlSSW8C4ndMgHqkxp42ZdcayfuRHCBKOEjDdKjBeuN9+VT/O4VU/fL
 Vkxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759908196; x=1760512996;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KmTtfQn485dwI5VyrBNqFWBnPgTEl3i8e/JThGkX2tQ=;
 b=Tu7XjeGcj/04cN+eY6WzxsGhPuIJEVQpAiTPxfeVrxbfmxhcaAg83DoJC2xuV4glwr
 7Y2kRJVGVlfVtB3MvMJVG3jwEXpIUZMPazAFMEZ7rH9J4iAdUtBC9xvPQ2/o5OT6O56O
 J1UclCY1XvNcjKXIjVRDbpYUbOyHScQt11yNofTUfl68EuHirtDn3BNfYhqEr8yBKYVP
 b/o44lg1sa4tmWaTlLNv7fEl3nfoGyFW20ylKIlGYFwhiLgM69CM1hJ8ToEadkSCH473
 hDZ9LxPPzRk10o3yWCyIMzoTfc36acuH98vhYBT0xp6beOMK47FlQuOCN+UlSZueZAil
 c7cw==
X-Gm-Message-State: AOJu0YzHRH5Pr7EdQS9ElKyNKyPskotfLTwe8jrGT8cdA4PUDJTns/4C
 qd5wy8BWDZrAtK8+dTP5t5TIGpkOrMEdt3n3D1Z0Lnb0T+RyW1/Ct7RCArTXLjHiWCXkrJN1Ofm
 Pyus9YLGx0fWdxiFHUlHDebKdydTU66sLcLqmnbnFOg==
X-Gm-Gg: ASbGncvcJiMD7ZOXxOBgnm5sOgU+BRKkJYliq3McJRlMqVPP0nUeAO02nlvo7bLw7/e
 bEoBUHSvnpoSinDYxBTpLUDheLDIQWjuTEfhYvXJSaxQ3NTjJOqArRyjMIQG1OBnzJm0dUaNXko
 PvS0C7mw+dwYMs4ovNVHLG9Sbir9EVtzLNdwTm0ezIjjIT9tE6dktP9HTk9vsW4yOToD99LUQp0
 0eivqBxCa7AEwyN8w3oiB54x5OBrYMaLim5dlmSQitm
X-Google-Smtp-Source: AGHT+IFbDKcBie8VUaWvi8UCHiyckWQHhFj/LPTpRBRFA+ODi0NLZAKWMJ7zKvzx+yBoRUoslPKWq3Pm79ipOLDpIlc=
X-Received: by 2002:a17:906:ef04:b0:b3c:8b25:ab74 with SMTP id
 a640c23a62f3a-b50aa393c32mr275057166b.10.1759908195943; Wed, 08 Oct 2025
 00:23:15 -0700 (PDT)
MIME-Version: 1.0
References: <20250417105249.18232-1-jim.shu@sifive.com>
 <20250417105249.18232-15-jim.shu@sifive.com>
 <efccad5e-d5a8-4ebe-b2ae-1b683239399d@ventanamicro.com>
In-Reply-To: <efccad5e-d5a8-4ebe-b2ae-1b683239399d@ventanamicro.com>
From: Jim Shu <jim.shu@sifive.com>
Date: Wed, 8 Oct 2025 15:23:04 +0800
X-Gm-Features: AS18NWDQ21OHt99vGJLCTGG-oO9s-4oWUiOwJF8CUPFHyOSUR5TJROXZeQFko00
Message-ID: <CALw707pdRABgsz5b40tKo_G6uhD_2+okGg8fEtRdtfG4RshoAA@mail.gmail.com>
Subject: Re: [PATCH v2 14/18] hw/misc: riscv_wgchecker: Implement RISC-V
 WorldGuard Checker
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Michael Rolnik <mrolnik@gmail.com>, 
 Helge Deller <deller@gmx.de>, Song Gao <gaosong@loongson.cn>,
 Laurent Vivier <laurent@vivier.eu>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Aleksandar Rikalo <arikalo@gmail.com>, 
 Stafford Horne <shorne@gmail.com>, Nicholas Piggin <npiggin@gmail.com>, 
 Ilya Leoshkevich <iii@linux.ibm.com>, Thomas Huth <thuth@redhat.com>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, 
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Max Filippov <jcmvbkbc@gmail.com>, 
 "open list:PowerPC TCG CPUs" <qemu-ppc@nongnu.org>,
 "open list:S390 TCG CPUs" <qemu-s390x@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=jim.shu@sifive.com; helo=mail-ej1-x62d.google.com
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

I will send a v3 patch to fix it, thanks!

- Jim

On Sun, Aug 10, 2025 at 12:39=E2=80=AFAM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
>
>
> On 4/17/25 7:52 AM, Jim Shu wrote:
> > Implement the RISC-V WorldGuard Checker, which sits in front of RAM or
> > device MMIO and allow software to configure it to either pass through o=
r
> > reject transactions.
> >
> > We implement the wgChecker as a QEMU IOMMU, which will direct transacti=
ons
> > either through to the devices and memory behind it or to a special
> > "never works" AddressSpace if they are blocked.
> >
> > This initial commit implements the skeleton of the device:
> >   * it always permits accesses
> >   * it doesn't implement wgChecker's slot registers
> >   * it doesn't implement the interrupt or other behaviour
> >     for blocked transactions
> >
> > Signed-off-by: Jim Shu <jim.shu@sifive.com>
> > ---
> >   hw/misc/meson.build                |   2 +-
> >   hw/misc/riscv_wgchecker.c          | 603 ++++++++++++++++++++++++++++=
+
> >   hw/misc/trace-events               |   8 +
> >   include/hw/misc/riscv_worldguard.h |  63 +++
> >   4 files changed, 675 insertions(+), 1 deletion(-)
> >   create mode 100644 hw/misc/riscv_wgchecker.c
> >
> > diff --git a/hw/misc/meson.build b/hw/misc/meson.build
> > index 3d2f4bb6a3..73c11bc7c9 100644
> > --- a/hw/misc/meson.build
> > +++ b/hw/misc/meson.build
> > @@ -34,7 +34,7 @@ system_ss.add(when: 'CONFIG_SIFIVE_E_PRCI', if_true: =
files('sifive_e_prci.c'))
> >   system_ss.add(when: 'CONFIG_SIFIVE_E_AON', if_true: files('sifive_e_a=
on.c'))
> >   system_ss.add(when: 'CONFIG_SIFIVE_U_OTP', if_true: files('sifive_u_o=
tp.c'))
> >   system_ss.add(when: 'CONFIG_SIFIVE_U_PRCI', if_true: files('sifive_u_=
prci.c'))
> > -specific_ss.add(when: 'CONFIG_RISCV_WORLDGUARD', if_true: files('riscv=
_worldguard.c'))
> > +specific_ss.add(when: 'CONFIG_RISCV_WORLDGUARD', if_true: files('riscv=
_worldguard.c', 'riscv_wgchecker.c'))
> >
> >   subdir('macio')
> >
> > diff --git a/hw/misc/riscv_wgchecker.c b/hw/misc/riscv_wgchecker.c
> > new file mode 100644
> > index 0000000000..ea50f4f53a
> > --- /dev/null
> > +++ b/hw/misc/riscv_wgchecker.c
> > @@ -0,0 +1,603 @@
>
> (...)
>
> > +
> > +static void riscv_wgchecker_realize(DeviceState *dev, Error **errp)
> > +{
> > +    Object *obj =3D OBJECT(dev);
> > +    RISCVWgCheckerState *s =3D RISCV_WGCHECKER(dev);
> > +    uint64_t size;
> > +
> > +    if (worldguard_config =3D=3D NULL) {
> > +        error_setg(errp, "Couldn't find global WorldGuard configs. "
> > +                   "Please realize %s device at first.",
>
> Extra "at":  "Please realize %s device first."
>
>
> Everything else LGTM:
>
>
> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
>
> > +                   TYPE_RISCV_WORLDGUARD);
> > +        return;
> > +    }
> > +
> > +    if (s->slot_count =3D=3D 0) {
> > +        error_setg(errp, "wgChecker slot-count couldn't be zero.");
> > +        return;
> > +    }
> > +
> > +    memory_region_init_io(&s->mmio, OBJECT(dev), &riscv_wgchecker_ops,=
 s,
> > +                          TYPE_RISCV_WGCHECKER, s->mmio_size);
> > +    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->mmio);
> > +    sysbus_init_irq(SYS_BUS_DEVICE(dev), &s->irq);
> > +
> > +    /* Address range should be NAPOT alignment */
> > +    address_range_align_napot(s);
> > +
> > +    for (int i=3D0; i<WGC_NUM_REGIONS; i++) {
> > +        WgCheckerRegion *region =3D &s->mem_regions[i];
> > +
> > +        if (!region->downstream) {
> > +            continue;
> > +        }
> > +        region->wgchecker =3D s;
> > +
> > +        const char *upstream_name =3D g_strdup_printf(
> > +            "wgchecker-upstream-%"HWADDR_PRIx, region->region_offset);
> > +        const char *downstream_name =3D g_strdup_printf(
> > +            "wgchecker-downstream-%"HWADDR_PRIx, region->region_offset=
);
> > +
> > +        size =3D memory_region_size(region->downstream);
> > +        memory_region_init_iommu(&region->upstream, sizeof(region->ups=
tream),
> > +                                 TYPE_RISCV_WGC_IOMMU_MEMORY_REGION,
> > +                                 obj, upstream_name, size);
> > +
> > +        /* upstream MRs are 2nd ~ (n+1)th MemoryRegion. */
> > +        sysbus_init_mmio(SYS_BUS_DEVICE(dev), MEMORY_REGION(&region->u=
pstream));
> > +
> > +        /*
> > +         * This memory region is not exposed to users of this device a=
s a
> > +         * sysbus MMIO region, but is instead used internally as somet=
hing
> > +         * that our IOMMU translate function might direct accesses to.
> > +         */
> > +        memory_region_init_io(&region->blocked_io, obj, &riscv_wgc_mem=
_blocked_ops,
> > +                              region, "wgchecker-blocked-io", size);
> > +
> > +        address_space_init(&region->downstream_as, region->downstream,
> > +                           downstream_name);
> > +        address_space_init(&region->blocked_io_as, &region->blocked_io=
,
> > +                           "wgchecker-blocked-io");
> > +    }
> > +}
> > +
> > +static void riscv_wgchecker_unrealize(DeviceState *dev)
> > +{
> > +    RISCVWgCheckerState *s =3D RISCV_WGCHECKER(dev);
> > +
> > +    g_free(s->slots);
> > +    if (s->num_default_slots && s->default_slots) {
> > +        g_free(s->default_slots);
> > +    }
> > +}
> > +
> > +static void riscv_wgchecker_reset_enter(Object *obj, ResetType type)
> > +{
> > +    RISCVWgCheckerState *s =3D RISCV_WGCHECKER(obj);
> > +    uint64_t start =3D s->addr_range_start;
> > +    uint64_t end =3D s->addr_range_start + s->addr_range_size;
> > +    int nslots =3D s->slot_count;
> > +
> > +    s->errcause =3D 0;
> > +    s->erraddr =3D 0;
> > +}
> > +
> > +static void riscv_wgchecker_class_init(ObjectClass *klass, void *data)
> > +{
> > +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> > +
> > +    device_class_set_props(dc, riscv_wgchecker_properties);
> > +    dc->user_creatable =3D true;
> > +    dc->realize =3D riscv_wgchecker_realize;
> > +    dc->unrealize =3D riscv_wgchecker_unrealize;
> > +    ResettableClass *rc =3D RESETTABLE_CLASS(klass);
> > +    rc->phases.enter =3D riscv_wgchecker_reset_enter;
> > +}
> > +
> > +static void riscv_wgchecker_instance_init(Object *obj)
> > +{
> > +    RISCVWgCheckerState *s =3D RISCV_WGCHECKER(obj);
> > +
> > +    s->num_default_slots =3D 0;
> > +}
> > +
> > +static const TypeInfo riscv_wgchecker_info =3D {
> > +    .name          =3D TYPE_RISCV_WGCHECKER,
> > +    .parent        =3D TYPE_SYS_BUS_DEVICE,
> > +    .instance_init =3D riscv_wgchecker_instance_init,
> > +    .instance_size =3D sizeof(RISCVWgCheckerState),
> > +    .class_init    =3D riscv_wgchecker_class_init,
> > +};
> > +
> > +static void riscv_wgchecker_register_types(void)
> > +{
> > +    type_register_static(&riscv_wgchecker_info);
> > +    type_register_static(&riscv_wgc_iommu_memory_region_info);
> > +}
> > +
> > +type_init(riscv_wgchecker_register_types)
> > +
> > +/*
> > + * Create WgChecker device
> > + */
> > +DeviceState *riscv_wgchecker_create(hwaddr addr, uint32_t size,
> > +                                    qemu_irq irq, uint32_t slot_count,
> > +                                    uint64_t addr_range_start,
> > +                                    uint64_t addr_range_size,
> > +                                    uint32_t num_of_region,
> > +                                    MemoryRegion **downstream,
> > +                                    uint64_t *region_offset,
> > +                                    uint32_t num_default_slots,
> > +                                    WgCheckerSlot *default_slots)
> > +{
> > +    DeviceState *dev =3D qdev_new(TYPE_RISCV_WGCHECKER);
> > +    RISCVWgCheckerState *s =3D RISCV_WGCHECKER(dev);
> > +    char name_mr[32];
> > +    char name_offset[32];
> > +    int i;
> > +
> > +    qdev_prop_set_uint32(dev, "slot-count", slot_count);
> > +    qdev_prop_set_uint32(dev, "mmio-size", size);
> > +    qdev_prop_set_uint64(dev, "addr-range-start", addr_range_start);
> > +    if (addr_range_size) {
> > +        qdev_prop_set_uint64(dev, "addr-range-size", addr_range_size);
> > +    }
> > +
> > +    g_assert(num_of_region <=3D WGC_NUM_REGIONS);
> > +    for (i=3D0; i<num_of_region; i++) {
> > +        snprintf(name_mr, 32, "downstream-mr[%d]", i);
> > +        snprintf(name_offset, 32, "region-offset[%d]", i);
> > +
> > +        object_property_set_link(OBJECT(dev), name_mr,
> > +                                 OBJECT(downstream[i]), &error_fatal);
> > +        qdev_prop_set_uint64(dev, name_offset, region_offset[i]);
> > +    }
> > +
> > +    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
> > +    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, addr);
> > +    sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, irq);
> > +    return dev;
> > +}
> > diff --git a/hw/misc/trace-events b/hw/misc/trace-events
> > index 4383808d7a..b1d8538220 100644
> > --- a/hw/misc/trace-events
> > +++ b/hw/misc/trace-events
> > @@ -395,3 +395,11 @@ ivshmem_flat_interrupt_peer(uint16_t peer_id, uint=
16_t vector_id) "Interrupting
> >   i2c_echo_event(const char *id, const char *event) "%s: %s"
> >   i2c_echo_recv(const char *id, uint8_t data) "%s: recv 0x%02" PRIx8
> >   i2c_echo_send(const char *id, uint8_t data) "%s: send 0x%02" PRIx8
> > +
> > +# riscv_worldguard.c
> > +riscv_wgchecker_mmio_read(uint64_t base, uint64_t offset, unsigned int=
 size) "base =3D 0x%"PRIx64", offset =3D 0x%"PRIx64", size =3D 0x%x"
> > +riscv_wgchecker_mmio_write(uint64_t base, uint64_t offset, unsigned in=
t size, uint64_t val) "base =3D 0x%"PRIx64", offset =3D 0x%"PRIx64", size =
=3D 0x%x, val =3D 0x%"PRIx64
> > +
> > +riscv_wgc_mem_blocked_read(uint64_t addr, unsigned size, uint32_t wid)=
 "wgChecker blocked read: offset 0x%" PRIx64 " size %u wid %" PRIu32
> > +riscv_wgc_mem_blocked_write(uint64_t addr, uint64_t data, unsigned siz=
e, uint32_t wid) "wgChecker blocked write: offset 0x%" PRIx64 " data 0x%" P=
RIx64 " size %u wid %" PRIu32
> > +riscv_wgc_translate(uint64_t addr, int flags, int wid, const char *res=
) "wgChecker translate: addr 0x%016" PRIx64 " flags 0x%x wid %d: %s"
> > diff --git a/include/hw/misc/riscv_worldguard.h b/include/hw/misc/riscv=
_worldguard.h
> > index 211a72e438..7b5aae866a 100644
> > --- a/include/hw/misc/riscv_worldguard.h
> > +++ b/include/hw/misc/riscv_worldguard.h
> > @@ -53,4 +53,67 @@ void riscv_worldguard_apply_cpu(uint32_t hartid);
> >   uint32_t mem_attrs_to_wid(MemTxAttrs attrs);
> >   bool could_access_wgblocks(MemTxAttrs attrs, const char *wgblock);
> >
> > +#define TYPE_RISCV_WGCHECKER  "riscv.wgchecker"
> > +
> > +typedef struct RISCVWgCheckerState RISCVWgCheckerState;
> > +DECLARE_INSTANCE_CHECKER(RISCVWgCheckerState, RISCV_WGCHECKER,
> > +                         TYPE_RISCV_WGCHECKER)
> > +
> > +#define TYPE_RISCV_WGC_IOMMU_MEMORY_REGION    "riscv-wgc-iommu-memory-=
region"
> > +
> > +typedef struct WgCheckerSlot WgCheckerSlot;
> > +struct WgCheckerSlot {
> > +    uint64_t addr;
> > +    uint64_t perm;
> > +    uint32_t cfg;
> > +};
> > +
> > +typedef struct WgCheckerRegion WgCheckerRegion;
> > +struct WgCheckerRegion {
> > +    MemoryRegion *downstream;
> > +    uint64_t region_offset;
> > +
> > +    IOMMUMemoryRegion upstream;
> > +    MemoryRegion blocked_io;
> > +    AddressSpace downstream_as;
> > +    AddressSpace blocked_io_as;
> > +
> > +    RISCVWgCheckerState *wgchecker;
> > +};
> > +
> > +#define WGC_NUM_REGIONS     16
> > +
> > +struct RISCVWgCheckerState {
> > +    /*< private >*/
> > +    SysBusDevice parent_obj;
> > +
> > +    /*< public >*/
> > +    MemoryRegion mmio;
> > +    qemu_irq irq;
> > +
> > +    /* error reg */
> > +    uint64_t errcause;
> > +    uint64_t erraddr;
> > +
> > +    /* Memory regions protected by wgChecker */
> > +    WgCheckerRegion mem_regions[WGC_NUM_REGIONS];
> > +
> > +    /* Property */
> > +    uint32_t slot_count; /* nslots */
> > +    uint32_t mmio_size;
> > +    uint64_t addr_range_start;
> > +    uint64_t addr_range_size;
> > +    bool hw_bypass;
> > +};
> > +
> > +DeviceState *riscv_wgchecker_create(hwaddr addr, uint32_t size,
> > +                                    qemu_irq irq, uint32_t slot_count,
> > +                                    uint64_t addr_range_start,
> > +                                    uint64_t addr_range_size,
> > +                                    uint32_t num_of_region,
> > +                                    MemoryRegion **downstream,
> > +                                    uint64_t *region_offset,
> > +                                    uint32_t num_default_slots,
> > +                                    WgCheckerSlot *default_slots);
> > +
> >   #endif
>

