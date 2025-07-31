Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59404C87FCA
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Jul 2025 12:53:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhSmP-0003Zw-UC; Thu, 31 Jul 2025 08:53:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uhSHO-0001vl-OG
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 08:21:05 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uhSHL-0007ps-Jg
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 08:21:02 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-61568fbed16so1205005a12.3
 for <qemu-devel@nongnu.org>; Thu, 31 Jul 2025 05:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753964456; x=1754569256; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x98vFWk5VwLWtqTxHX9ph5zetOg5OCg/GNN18TFJJRA=;
 b=U15Z+WndKPaTL74br2seMiJXr1MJQ67S8B0GWMpHqu8RcoqxvyZ53AERFeen5GXmwX
 O0mGe7KCEb3ggLVKBVd1xAmdARFSzbBP4pnB34lo+HFnQz+wZUdkulqVhs7pLr4561mt
 XRyU3fOyj+X9b10ER4+NFY1xZf2YTXZYMm76fDmio2I0QtNbFqcUz2yh6aU5YzfM5fpl
 TdWR3MsFfBSMX/x5j1qrZuT29iiUqXHMd/oc3B5GuWLesZeZ3AVDDGnl84NADc/6eGXk
 DIo4EXq1W6fTrzyrS/5vYmlXbl9a9Kzxt1M3h6GlKanZ9/4Ge7oMuEk5FMg80E1yx/JH
 02bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753964456; x=1754569256;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x98vFWk5VwLWtqTxHX9ph5zetOg5OCg/GNN18TFJJRA=;
 b=fXCTeWn6ZWtFTZrOQPAbCKXsjKAUEUoHnWsHHNjqEEeOqwDPBnhsWrYWSpvCY/ozXS
 kWMPfihPvlegR2lZB/gXgI9zt0HeB3g6MNlSMCqzuJW6kC+5Y+SE2Dt7cjq+ijeL+QoH
 JXSObt0L5ZslnobsfsHbl0G12PsZrjemG9H9WYVajSLQIlXyqy781D9mWL1nvMgq3UjG
 952PCB8+FWvGEtJtZNw68Scq5r5vdqRfHolEMFKu2Bthk/BYuiyf719+W74S4ktvW/iV
 50JBzZTtD+1ts0JW164SvYQnnc/KkU3pgr41wPQnh9ikGZeUBDQL8RcyBtvanzqVuzc6
 /zuw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXkjcsBfS+AuO6Wn3SF4727YbjbmiOqlVYKYnSq11shxYBrDNmV0T6we+QV5QLhjPKJOJIx0aDOQ9wY@nongnu.org
X-Gm-Message-State: AOJu0Yyylho59RnyoiSbC7S6Df+WlF01mPHp9/ASt3oLAufolj4HuYCH
 3NhnfHRejSX+N4JYg9NkcHl3T8E5rqFEXg+o899tS1xbuTgY4ienoJ5X1PWmd2kzyVq1C4KcaAS
 jEBIgHCBG4YqyJ9Doc89HSZvPZfgLVRgsIgOn31HHfQ==
X-Gm-Gg: ASbGncsKZ0MgXyNkRKzAoTdrFfV+cF7Cey2BopzRih80Mov8b5SjJM51U0Xc3SGzR82
 MaAea8fpmAGd6IIZm1HBIttrfnFvDgNfkV2fI6cjj9NqwJMcQmzGxk9rqyZXk56Ia3Feu23W9x0
 Ir2e5uAMNZa3CBH/+YXEWXGOELBgGQYQjr4ULrSeeKnpxKZ3RCEfzB6NA6xUiWFhGZ8Er8K72yI
 i47MHs=
X-Google-Smtp-Source: AGHT+IEAsyTOl5GglgkEdXGleonuQlGkjyONhLjrkicXeb3GfCJijGNitLLCKy0kvdx+xlqWV5ROBKxwGjRBHb28rbk=
X-Received: by 2002:aa7:c6d7:0:b0:615:4244:8c4c with SMTP id
 4fb4d7f45d1cf-61587231618mr6002909a12.30.1753964456350; Thu, 31 Jul 2025
 05:20:56 -0700 (PDT)
MIME-Version: 1.0
References: <20250730-nvdimm_arm64_virt-v1-1-f843596ab995@linaro.org>
 <20250731110036.00003a0a@huawei.com>
 <e8203af151ea4f9696b809dd5de6b155@huawei.com>
In-Reply-To: <e8203af151ea4f9696b809dd5de6b155@huawei.com>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Thu, 31 Jul 2025 15:20:29 +0300
X-Gm-Features: Ac12FXww3DXUmO92J5lBOo5j_WeuLiCKRbm6nD0KdwgJpRK0xleauGXSh62mhVE
Message-ID: <CAAjaMXZdHEQGi=w==iVCurTs1MrL=_2CfE+i8nTte7vjWL+T7Q@mail.gmail.com>
Subject: Re: [PATCH] hw/arm: add static NVDIMMs in device tree
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>, 
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>, 
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 Gustavo Romero <gustavo.romero@linaro.org>, 
 "imammedo@redhat.com" <imammedo@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x533.google.com
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

On Thu, Jul 31, 2025 at 2:14=E2=80=AFPM Shameerali Kolothum Thodi
<shameerali.kolothum.thodi@huawei.com> wrote:
>
>
>
> > -----Original Message-----
> > From: Jonathan Cameron <jonathan.cameron@huawei.com>
> > Sent: Thursday, July 31, 2025 11:01 AM
> > To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> > Cc: qemu-devel@nongnu.org; Peter Maydell <peter.maydell@linaro.org>;
> > qemu-arm@nongnu.org; Gustavo Romero <gustavo.romero@linaro.org>;
> > Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
> > Subject: Re: [PATCH] hw/arm: add static NVDIMMs in device tree
> >
> > On Wed, 30 Jul 2025 15:21:41 +0300
> > Manos Pitsidianakis <manos.pitsidianakis@linaro.org> wrote:
> >
> > > NVDIMM is used for fast rootfs with EROFS, for example by kata
> > > containers. To allow booting with static NVDIMM memory, add them to
> > > the device tree in arm virt machine.
> > >
> > > This allows users to boot directly with nvdimm memory devices without
> > > having to rely on ACPI and hotplug.
> > >
> > > Verified to work with command invocation:
> > >
> > > ./qemu-system-aarch64 \
> > >   -M virt,nvdimm=3Don \
> > >   -cpu cortex-a57 \
> > >   -m 4G,slots=3D2,maxmem=3D8G \
> > >   -object memory-backend-file,id=3Dmem1,share=3Don,mem-
> > path=3D/tmp/nvdimm,size=3D4G,readonly=3Doff \
> > >   -device nvdimm,id=3Dnvdimm1,memdev=3Dmem1,unarmed=3Doff \
> > >   -drive file=3D./debian-12-nocloud-arm64-commited.qcow2,format=3Dqco=
w2 \
> > >   -kernel ./vmlinuz-6.1.0-13-arm64 \
> > >   -append "root=3D/dev/vda1 console=3DttyAMA0,115200 acpi=3Doff"
> > >   -initrd ./initrd.img-6.1.0-13-arm64 \
> > >   -nographic \
> > >   -serial mon:stdio
> > >
> > > Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> >
> > +CC shameer who might be able to remember how the nvdimm stuff works
> > in
> > +ACPI better
> > than I can.  I think this is fine but more eyes would be good.
>

Hello Shameer,

> The cold plug DT support was part of the initial NVDIMM series,
> https://lore.kernel.org/qemu-devel/20191004155302.4632-5-shameerali.kolot=
hum.thodi@huawei.com/
>
> But I can't remember the reason for dropping it, other than the comment f=
rom
> Igor, that why we should do it for NVDIMM but not PC-DIMM.
> https://lore.kernel.org/qemu-devel/20191111154627.63fc061b@redhat.com/
>
> So, I guess there was not a strong use case for that at that time.

Yes. Our motivation for this patch is just feature parity with x86.
It's a nice-to-have, if it's possible.

>
> The PC-DIMM DT cold plug was dropped due to the issues/obstacles mentione=
d here,
> https://lore.kernel.org/qemu-devel/5FC3163CFD30C246ABAA99954A238FA83F1B6A=
66@lhreml524-mbs.china.huawei.com/

Thank you very much for this link. On a first glance, if this problem
is still happening with edk2, perhaps a temporary fix would be to only
put coldplugged DIMMs in the device tree when the machine has acpi=3Doff
explicitly to prevent the potential for firmware confusion?

>
> +CC: Igor and Eric.
>
> Thanks,
> Shameer
>
> > > ---
> > >  hw/arm/boot.c | 39 +++++++++++++++++++++++++++++++++++++++
> > >  hw/arm/virt.c |  8 +++++---
> > >  2 files changed, 44 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/hw/arm/boot.c b/hw/arm/boot.c index
> > >
> > d391cd01bb1b92ff213e69b84e5a69413b36c4f8..a0c1bcdf946ca98bb5da63f1
> > a518
> > > 018eb578dd81 100644
> > > --- a/hw/arm/boot.c
> > > +++ b/hw/arm/boot.c
> > > @@ -25,6 +25,7 @@
> > >  #include "hw/boards.h"
> > >  #include "system/reset.h"
> > >  #include "hw/loader.h"
> > > +#include "hw/mem/memory-device.h"
> > >  #include "elf.h"
> > >  #include "system/device_tree.h"
> > >  #include "qemu/config-file.h"
> > > @@ -515,6 +516,26 @@ static void fdt_add_psci_node(void *fdt,
> > ARMCPU *armcpu)
> > >      qemu_fdt_setprop_cell(fdt, "/psci", "migrate", migrate_fn);  }
> > >
> > > +static int fdt_add_pmem_node(void *fdt, uint32_t acells, uint32_t sc=
ells,
> > > +                             int64_t mem_base, int64_t size, int64_t
> > > +node) {
> > > +    int ret;
> > > +
> > > +    g_autofree char *nodename =3D g_strdup_printf("/pmem@%" PRIx64,
> > > + mem_base);
> > > +
> > > +    qemu_fdt_add_subnode(fdt, nodename);
> > > +    qemu_fdt_setprop_string(fdt, nodename, "compatible", "pmem-
> > region");
> > > +    ret =3D qemu_fdt_setprop_sized_cells(fdt, nodename, "reg", acell=
s,
> > > +                                       mem_base, scells, size);
> >
> > I'd burn some lines to avoid a comment covering unrelated ret handling
> >
> >       if (ret)
> >               return ret;
> >
> >       if (node >=3D 0) {
> >               return qem_fdt_setprop_cell()
> >       }
> >
> >       return 0;
> >
> > > +    /* only set the NUMA ID if it is specified */
> > > +    if (!ret && node >=3D 0) {
> > > +        ret =3D qemu_fdt_setprop_cell(fdt, nodename, "numa-node-id",
> > > +                                    node);
> > > +    }
> > > +
> > > +    return ret;
> > > +}
> > > +
> > >  int arm_load_dtb(hwaddr addr, const struct arm_boot_info *binfo,
> > >                   hwaddr addr_limit, AddressSpace *as, MachineState *=
ms,
> > >                   ARMCPU *cpu)
> > > @@ -525,6 +546,7 @@ int arm_load_dtb(hwaddr addr, const struct
> > arm_boot_info *binfo,
> > >      unsigned int i;
> > >      hwaddr mem_base, mem_len;
> > >      char **node_path;
> > > +    g_autofree MemoryDeviceInfoList *md_list =3D NULL;
> > >      Error *err =3D NULL;
> > >
> > >      if (binfo->dtb_filename) {
> > > @@ -628,6 +650,23 @@ int arm_load_dtb(hwaddr addr, const struct
> > arm_boot_info *binfo,
> > >          }
> > >      }
> > >
> > > +    md_list =3D qmp_memory_device_list();
> > > +    for (MemoryDeviceInfoList *m =3D md_list; m !=3D NULL; m =3D m->=
next) {
> > > +        MemoryDeviceInfo *mi =3D m->value;
> > > +
> > > +        if (mi->type =3D=3D MEMORY_DEVICE_INFO_KIND_NVDIMM) {
> > > +            PCDIMMDeviceInfo *di =3D mi->u.nvdimm.data;
> > > +
> > > +            rc =3D fdt_add_pmem_node(fdt, acells, scells,
> > > +                                   di->addr, di->size, di->node);
> > > +            if (rc < 0) {
> > > +                fprintf(stderr, "couldn't add NVDIMM /pmem@%"PRIx64"
> > node\n",
> > > +                        di->addr);
> > > +                goto fail;
> > > +            }
> > > +        }
> > > +    }
> > > +
> > >      rc =3D fdt_path_offset(fdt, "/chosen");
> > >      if (rc < 0) {
> > >          qemu_fdt_add_subnode(fdt, "/chosen"); diff --git
> > > a/hw/arm/virt.c b/hw/arm/virt.c index
> > >
> > ef6be3660f5fb38da84235c32dc2d13a5c61889c..910f5bb5f66ee217a9140f912
> > 880
> > > 4a5b9f69b5b6 100644
> > > --- a/hw/arm/virt.c
> > > +++ b/hw/arm/virt.c
> > > @@ -2917,7 +2917,7 @@ static void
> > virt_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
> > >      const MachineState *ms =3D MACHINE(hotplug_dev);
> > >      const bool is_nvdimm =3D object_dynamic_cast(OBJECT(dev),
> > > TYPE_NVDIMM);
> > >
> > > -    if (!vms->acpi_dev) {
> > > +    if (!vms->acpi_dev && !(is_nvdimm && !dev->hotplugged)) {
> > >          error_setg(errp,
> > >                     "memory hotplug is not enabled: missing acpi-ged =
device");
> > >          return;
> > > @@ -2949,8 +2949,10 @@ static void virt_memory_plug(HotplugHandler
> > *hotplug_dev,
> > >          nvdimm_plug(ms->nvdimms_state);
> > >      }
> > >
> > > -    hotplug_handler_plug(HOTPLUG_HANDLER(vms->acpi_dev),
> > > -                         dev, &error_abort);
> > > +    if (vms->acpi_dev) {
> > > +        hotplug_handler_plug(HOTPLUG_HANDLER(vms->acpi_dev),
> > > +                             dev, &error_abort);
> > > +    }
> > >  }
> > >
> > >  static void virt_machine_device_pre_plug_cb(HotplugHandler
> > > *hotplug_dev,
> > >
> > > ---
> > > base-commit: 9b80226ece693197af8a981b424391b68b5bc38e
> > > change-id: 20250730-nvdimm_arm64_virt-931a764bbe0c
> > >
> > > --
> > > =CE=B3=CE=B1=E1=BF=96=CE=B1 =CF=80=CF=85=CF=81=CE=AF =CE=BC=CE=B9=CF=
=87=CE=B8=CE=AE=CF=84=CF=89
> > >
> > >
>

