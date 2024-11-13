Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F1D4D462B2
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2024 14:34:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBEQt-0001kC-5b; Wed, 13 Nov 2024 09:33:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lists@philjordan.eu>)
 id 1tBEQq-0001ij-Tt
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 09:33:20 -0500
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lists@philjordan.eu>)
 id 1tBEQm-0001SB-Sm
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 09:33:20 -0500
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-7ee6edc47abso4586753a12.3
 for <qemu-devel@nongnu.org>; Wed, 13 Nov 2024 06:33:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1731508387; x=1732113187;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=HUjOA4iDWhfXNiw2Eu17I+CzyL1lt4NF2uRutadg+M4=;
 b=3POqhkB3EeHxBSQ1sb62CPphF96xH+eZenSVnjv0Q2IWHcKMFrX4RrcO6BkmIGHF/M
 QnfWtjW6X6Zb2zbLlS9ma1pNrxGhJ5ozT7WZoN4Z/grrrUXdziIkH/Gjn6A/kNVRn8G7
 zAKngu3UhPSJZTzg6Elg3CfOEzSV1QRxWBAvk/++WEL/7LzhOIIaqCM+lhcTzUBObBKV
 5VyE6+QoRN6r2u/l/XTtmE7uD0C/gXt+DWtDbZtGU8JUKuXeE5S/CAQT3FXVlFJvOADt
 hbnQAWZxXGY611Lp2QNUtUT4RqAepQncDHh1ch4Pf06y1oVr7oTiNVx7HhJxFxOvz1RJ
 xXsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731508387; x=1732113187;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HUjOA4iDWhfXNiw2Eu17I+CzyL1lt4NF2uRutadg+M4=;
 b=vyKygEwlTAn/WLx/qCWinkPViOiffJVBVdpvioI1cFd5lfVmaMZlk/eMuQWBDNVocp
 qwFTRgNCjubG2bxU8oquBaulYlWqw2R0qDOeyNK6cJdP8u4SvNBvxmk4i/DofDuvGdHE
 ewLlpsOCrU/tjxpNKiT/ksTm5ZxJUU/mz6V/nwVk+EpcAtwt18ICg6/JI/FQmIOsecEO
 nJGXgKYSGA7lWTMs4L7sHmHM3fjdHH0bxJl9urQuWFg3FCzXsQ234DvE9McG4FEsJa27
 5NrBYBSuA88+7ROgc/oOzkVhaQHgheokkyddpwhkxGrVFHwDSh44TAZz67hxp8rXJMSN
 9EQg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX5C7h5WRPoTos4Q0beKiPDLmjH1DpAIMlChAMSoMZNkKqKpi4TLfQwMALRbp8+xMyAkjbP5IiQBK/G@nongnu.org
X-Gm-Message-State: AOJu0YxnsVSG7/kMt0zyZ3iIouJZ/pmsXnnQcAm3bvqR44k3SnE54rBM
 xYzy5VcjhZDVkFivIFLKFgDy0/CRLbl3sYfonFp1r34MCMmXH7Dmbtn4+pFDZM1KWCtnp5XzK7f
 k86CbL3z0P06vNQJVUJiHX9JdpDs1lgkmBO0X
X-Google-Smtp-Source: AGHT+IH8rSwdS7pAorQ1Ruvt4zY7kZZHqOQph1QUniomTg9UjzSDexkbzkjg+b4QDlRF3O1uiL+t3NlPVJkB21Yx+oY=
X-Received: by 2002:a17:90b:2692:b0:2e2:d1c9:95c with SMTP id
 98e67ed59e1d1-2e9b1715bd0mr28894383a91.16.1731508387442; Wed, 13 Nov 2024
 06:33:07 -0800 (PST)
MIME-Version: 1.0
References: <20241108144709.95498-1-phil@philjordan.eu>
 <20241108144709.95498-13-phil@philjordan.eu>
 <49a1d82f-2464-4e10-b932-733e94be31b2@daynix.com>
 <CAGCz3vt_HuXu9uPwrOQkgE84-8nTgEQXST-BbXXc=FsEx_Wx2w@mail.gmail.com>
 <d245e6b2-f089-42e6-9614-947192fc96d8@daynix.com>
In-Reply-To: <d245e6b2-f089-42e6-9614-947192fc96d8@daynix.com>
From: Phil Dennis-Jordan <lists@philjordan.eu>
Date: Wed, 13 Nov 2024 15:32:56 +0100
Message-ID: <CAGCz3vsntN13pK+C_meqLkM0uku4JFq=_9DjBUObe4Vq--FH+w@mail.gmail.com>
Subject: Re: [PATCH v8 12/15] hw/vmapple/cfg: Introduce vmapple cfg region
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Phil Dennis-Jordan <phil@philjordan.eu>, qemu-devel@nongnu.org,
 agraf@csgraf.de, 
 peter.maydell@linaro.org, pbonzini@redhat.com, rad@semihalf.com, 
 quic_llindhol@quicinc.com, stefanha@redhat.com, mst@redhat.com, 
 slp@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net, 
 marcel.apfelbaum@gmail.com, gaosong@loongson.cn, jiaxun.yang@flygoat.com, 
 chenhuacai@kernel.org, kwolf@redhat.com, hreitz@redhat.com, philmd@linaro.org, 
 shorne@gmail.com, palmer@dabbelt.com, alistair.francis@wdc.com, 
 bmeng.cn@gmail.com, liwei1518@gmail.com, dbarboza@ventanamicro.com, 
 zhiwei_liu@linux.alibaba.com, jcmvbkbc@gmail.com, marcandre.lureau@redhat.com, 
 berrange@redhat.com, qemu-arm@nongnu.org, qemu-block@nongnu.org, 
 qemu-riscv@nongnu.org, Alexander Graf <graf@amazon.com>
Content-Type: multipart/alternative; boundary="0000000000005c115c0626cc362d"
Received-SPF: neutral client-ip=2607:f8b0:4864:20::535;
 envelope-from=lists@philjordan.eu; helo=mail-pg1-x535.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NEUTRAL=0.779 autolearn=no autolearn_force=no
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

--0000000000005c115c0626cc362d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 11 Nov 2024 at 05:21, Akihiko Odaki <akihiko.odaki@daynix.com>
wrote:

> On 2024/11/11 0:01, Phil Dennis-Jordan wrote:
> > On Sun, 10 Nov 2024 at 08:15, Akihiko Odaki <akihiko.odaki@daynix.com>
> wrote:
> >>
> >> On 2024/11/08 23:47, Phil Dennis-Jordan wrote:
> >>> From: Alexander Graf <graf@amazon.com>
> >>>
> >>> Instead of device tree or other more standardized means, VMApple pass=
es
> >>> platform configuration to the first stage boot loader in a binary
> encoded
> >>> format that resides at a dedicated RAM region in physical address
> space.
> >>>
> >>> This patch models this configuration space as a qdev device which we
> can
> >>> then map at the fixed location in the address space. That way, we can
> >>> influence and annotate all configuration fields easily.
> >>>
> >>> Signed-off-by: Alexander Graf <graf@amazon.com>
> >>> Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
> >>> ---
> >>>
> >>> v3:
> >>>
> >>>    * Replaced legacy device reset method with Resettable method
> >>>
> >>> v4:
> >>>
> >>>    * Fixed initialisation of default values for properties
> >>>    * Dropped superfluous endianness conversions
> >>>    * Moved most header code to .c, device name #define goes in
> vmapple.h
> >>>
> >>> v5:
> >>>
> >>>    * Improved error reporting in case of string property buffer
> overflow.
> >>>
> >>> v7:
> >>>
> >>>    * Changed error messages for overrun of properties with
> >>>      fixed-length strings to be more useful to users than developers.
> >>>
> >>> v8:
> >>>
> >>>    * Consistent parenthesising of macro arguments for better safety.
> >>>
> >>>    hw/vmapple/Kconfig           |   3 +
> >>>    hw/vmapple/cfg.c             | 196
> +++++++++++++++++++++++++++++++++++
> >>>    hw/vmapple/meson.build       |   1 +
> >>>    include/hw/vmapple/vmapple.h |   2 +
> >>>    4 files changed, 202 insertions(+)
> >>>    create mode 100644 hw/vmapple/cfg.c
> >>>
> >>> diff --git a/hw/vmapple/Kconfig b/hw/vmapple/Kconfig
> >>> index 68f88876eb9..8bbeb9a9237 100644
> >>> --- a/hw/vmapple/Kconfig
> >>> +++ b/hw/vmapple/Kconfig
> >>> @@ -4,3 +4,6 @@ config VMAPPLE_AES
> >>>    config VMAPPLE_BDIF
> >>>        bool
> >>>
> >>> +config VMAPPLE_CFG
> >>> +    bool
> >>> +
> >>> diff --git a/hw/vmapple/cfg.c b/hw/vmapple/cfg.c
> >>> new file mode 100644
> >>> index 00000000000..787e2505d57
> >>> --- /dev/null
> >>> +++ b/hw/vmapple/cfg.c
> >>> @@ -0,0 +1,196 @@
> >>> +/*
> >>> + * VMApple Configuration Region
> >>> + *
> >>> + * Copyright =C2=A9 2023 Amazon.com, Inc. or its affiliates. All Rig=
hts
> Reserved.
> >>> + *
> >>> + * SPDX-License-Identifier: GPL-2.0-or-later
> >>> + *
> >>> + * This work is licensed under the terms of the GNU GPL, version 2 o=
r
> later.
> >>> + * See the COPYING file in the top-level directory.
> >>> + */
> >>> +
> >>> +#include "qemu/osdep.h"
> >>> +#include "hw/vmapple/vmapple.h"
> >>> +#include "hw/sysbus.h"
> >>> +#include "qemu/log.h"
> >>> +#include "qemu/module.h"
> >>> +#include "qapi/error.h"
> >>> +#include "net/net.h"
> >>> +
> >>> +OBJECT_DECLARE_SIMPLE_TYPE(VMAppleCfgState, VMAPPLE_CFG)
> >>> +
> >>> +#define VMAPPLE_CFG_SIZE 0x00010000
> >>> +
> >>> +typedef struct VMAppleCfg {
> >>> +    uint32_t version;         /* 0x000 */
> >>> +    uint32_t nr_cpus;         /* 0x004 */
> >>> +    uint32_t unk1;            /* 0x008 */
> >>> +    uint32_t unk2;            /* 0x00c */
> >>> +    uint32_t unk3;            /* 0x010 */
> >>> +    uint32_t unk4;            /* 0x014 */
> >>> +    uint64_t ecid;            /* 0x018 */
> >>> +    uint64_t ram_size;        /* 0x020 */
> >>> +    uint32_t run_installer1;  /* 0x028 */
> >>> +    uint32_t unk5;            /* 0x02c */
> >>> +    uint32_t unk6;            /* 0x030 */
> >>> +    uint32_t run_installer2;  /* 0x034 */
> >>> +    uint32_t rnd;             /* 0x038 */
> >>> +    uint32_t unk7;            /* 0x03c */
> >>> +    MACAddr mac_en0;          /* 0x040 */
> >>> +    uint8_t pad1[2];
> >>> +    MACAddr mac_en1;          /* 0x048 */
> >>> +    uint8_t pad2[2];
> >>> +    MACAddr mac_wifi0;        /* 0x050 */
> >>> +    uint8_t pad3[2];
> >>> +    MACAddr mac_bt0;          /* 0x058 */
> >>> +    uint8_t pad4[2];
> >>> +    uint8_t reserved[0xa0];   /* 0x060 */
> >>> +    uint32_t cpu_ids[0x80];   /* 0x100 */
> >>> +    uint8_t scratch[0x200];   /* 0x180 */
> >>> +    char serial[32];          /* 0x380 */
> >>> +    char unk8[32];            /* 0x3a0 */
> >>> +    char model[32];           /* 0x3c0 */
> >>> +    uint8_t unk9[32];         /* 0x3e0 */
> >>> +    uint32_t unk10;           /* 0x400 */
> >>> +    char soc_name[32];        /* 0x404 */
> >>> +} VMAppleCfg;
> >>> +
> >>> +struct VMAppleCfgState {
> >>> +    SysBusDevice parent_obj;
> >>> +    VMAppleCfg cfg;
> >>> +
> >>> +    MemoryRegion mem;
> >>> +    char *serial;
> >>> +    char *model;
> >>> +    char *soc_name;
> >>> +};
> >>> +
> >>> +static void vmapple_cfg_reset(Object *obj, ResetType type)
> >>> +{
> >>> +    VMAppleCfgState *s =3D VMAPPLE_CFG(obj);
> >>> +    VMAppleCfg *cfg;
> >>> +
> >>> +    cfg =3D memory_region_get_ram_ptr(&s->mem);
> >>> +    memset(cfg, 0, VMAPPLE_CFG_SIZE);
> >>> +    *cfg =3D s->cfg;
> >>> +}
> >>> +
> >>> +static bool set_fixlen_property_or_error(char *restrict dst,
> >>> +                                         const char *restrict src,
> >>> +                                         size_t dst_size, Error
> **errp,
> >>> +                                         const char *property_name)
> >>> +{
> >>> +    size_t len;
> >>> +
> >>> +    len =3D g_strlcpy(dst, src, dst_size);
> >>> +    if (len < dst_size) { /* len does not count nul terminator */
> >>> +        return true;
> >>> +    }
> >>> +
> >>> +    error_setg(errp,
> >>> +               "Failed to set property '%s' on VMApple 'cfg' device:
> length "
> >>> +               "(%zu) exceeds maximum of %zu",
> >>
> >> Don't print the device name here as it will be automatically printed.
> >
> > That's not what I'm seeing in tests. With code as-is, and setting an
> > overly long value from create_cfg() in the vmapple machine type
> > startup, I get the following output:
> >
> > qemu-system-aarch64: Failed to set property 'soc_name' on VMApple
> > 'cfg' device: length (50) exceeds maximum of 31
> >
> > I don't see any redundant mention of an object or property name. Of
> > course, this error occurs during the cfg device's realize(), not
> > immediately when setting the property. I can't see a built-in way to
> > explicitly limit the length of a string property.
>
> I was thinking of the scenario where the device is added with the
> -device option. It seems the device name is not printed when it is
> realized by the machine, but in that case the user will not be aware of
> the 'cfg' device so it is not helpful. A proper way to add a context
> here is calling error_prepend() in the vmapple machine to tell that it
> is a failure in that machine type.
>

I couldn't find any error_prepend() uses in existing machine types to work
from as examples, but I hope I've got it right now. I've made create_cfg()
accept an errp (pass &error_fatal); inside create_cfg, check whether
sysbus_realize_and_unref() succeeded, and if not, apply error_prepend
before returning.

It's in v10 of the patch set, which I've just posted.

>
> >>> +               property_name, len, dst_size - 1);
> >>> +    return false;
> >>> +}
> >>> +
> >>> +#define set_fixlen_property_or_return(dst_array, src, errp,
> property_name) \
> >>> +    do { \
> >>> +        if (!set_fixlen_property_or_error((dst_array), (src), \
> >>> +                                          ARRAY_SIZE(dst_array), \
> >>> +                                          (errp), (property_name))) =
{
> \
> >>> +            return; \
> >>> +        } \
> >>> +    } while (0)
> >>> +
> >>> +static void vmapple_cfg_realize(DeviceState *dev, Error **errp)
> >>> +{
> >>> +    VMAppleCfgState *s =3D VMAPPLE_CFG(dev);
> >>> +    uint32_t i;
> >>> +
> >>> +    if (!s->serial) {
> >>> +        s->serial =3D g_strdup("1234");
> >>> +    }
> >>> +    if (!s->model) {
> >>> +        s->model =3D g_strdup("VM0001");
> >>> +    }
> >>> +    if (!s->soc_name) {
> >>> +        s->soc_name =3D g_strdup("Apple M1 (Virtual)");
> >>> +    }
> >>> +
> >>> +    set_fixlen_property_or_return(s->cfg.serial, s->serial, errp,
> "serial");
> >>> +    set_fixlen_property_or_return(s->cfg.model, s->model, errp,
> "model");
> >>> +    set_fixlen_property_or_return(s->cfg.soc_name, s->soc_name, errp=
,
> "soc_name");
> >>> +    set_fixlen_property_or_return(s->cfg.unk8, "D/A", errp, "unk8");
> >>> +    s->cfg.version =3D 2;
> >>> +    s->cfg.unk1 =3D 1;
> >>> +    s->cfg.unk2 =3D 1;
> >>> +    s->cfg.unk3 =3D 0x20;
> >>> +    s->cfg.unk4 =3D 0;
> >>> +    s->cfg.unk5 =3D 1;
> >>> +    s->cfg.unk6 =3D 1;
> >>> +    s->cfg.unk7 =3D 0;
> >>> +    s->cfg.unk10 =3D 1;
> >>> +
> >>> +    if (s->cfg.nr_cpus > ARRAY_SIZE(s->cfg.cpu_ids)) {
> >>> +        error_setg(errp,
> >>> +                   "Failed to create %u CPUs, vmapple machine
> supports %zu max",
> >>> +                   s->cfg.nr_cpus, ARRAY_SIZE(s->cfg.cpu_ids));
> >>> +        return;
> >>> +    }
> >>> +    for (i =3D 0; i < s->cfg.nr_cpus; i++) {
> >>> +        s->cfg.cpu_ids[i] =3D i;
> >>> +    }
> >>> +}
> >>> +
> >>> +static void vmapple_cfg_init(Object *obj)
> >>> +{
> >>> +    VMAppleCfgState *s =3D VMAPPLE_CFG(obj);
> >>> +
> >>> +    memory_region_init_ram(&s->mem, obj, "VMApple Config",
> VMAPPLE_CFG_SIZE,
> >>> +                           &error_fatal);
> >>> +    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mem);
> >>> +}
> >>> +
> >>> +static Property vmapple_cfg_properties[] =3D {
> >>> +    DEFINE_PROP_UINT32("nr-cpus", VMAppleCfgState, cfg.nr_cpus, 1),
> >>> +    DEFINE_PROP_UINT64("ecid", VMAppleCfgState, cfg.ecid, 0),
> >>> +    DEFINE_PROP_UINT64("ram-size", VMAppleCfgState, cfg.ram_size, 0)=
,
> >>> +    DEFINE_PROP_UINT32("run_installer1", VMAppleCfgState,
> cfg.run_installer1, 0),
> >>> +    DEFINE_PROP_UINT32("run_installer2", VMAppleCfgState,
> cfg.run_installer2, 0),
> >>> +    DEFINE_PROP_UINT32("rnd", VMAppleCfgState, cfg.rnd, 0),
> >>> +    DEFINE_PROP_MACADDR("mac-en0", VMAppleCfgState, cfg.mac_en0),
> >>> +    DEFINE_PROP_MACADDR("mac-en1", VMAppleCfgState, cfg.mac_en1),
> >>> +    DEFINE_PROP_MACADDR("mac-wifi0", VMAppleCfgState, cfg.mac_wifi0)=
,
> >>> +    DEFINE_PROP_MACADDR("mac-bt0", VMAppleCfgState, cfg.mac_bt0),
> >>> +    DEFINE_PROP_STRING("serial", VMAppleCfgState, serial),
> >>> +    DEFINE_PROP_STRING("model", VMAppleCfgState, model),
> >>> +    DEFINE_PROP_STRING("soc_name", VMAppleCfgState, soc_name),
> >>> +    DEFINE_PROP_END_OF_LIST(),
> >>> +};
> >>> +
> >>> +static void vmapple_cfg_class_init(ObjectClass *klass, void *data)
> >>> +{
> >>> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> >>> +    ResettableClass *rc =3D RESETTABLE_CLASS(klass);
> >>> +
> >>> +    dc->realize =3D vmapple_cfg_realize;
> >>> +    dc->desc =3D "VMApple Configuration Region";
> >>> +    device_class_set_props(dc, vmapple_cfg_properties);
> >>> +    rc->phases.hold =3D vmapple_cfg_reset;
> >>> +}
> >>> +
> >>> +static const TypeInfo vmapple_cfg_info =3D {
> >>> +    .name          =3D TYPE_VMAPPLE_CFG,
> >>> +    .parent        =3D TYPE_SYS_BUS_DEVICE,
> >>> +    .instance_size =3D sizeof(VMAppleCfgState),
> >>> +    .instance_init =3D vmapple_cfg_init,
> >>> +    .class_init    =3D vmapple_cfg_class_init,
> >>> +};
> >>> +
> >>> +static void vmapple_cfg_register_types(void)
> >>> +{
> >>> +    type_register_static(&vmapple_cfg_info);
> >>> +}
> >>> +
> >>> +type_init(vmapple_cfg_register_types)
> >>> diff --git a/hw/vmapple/meson.build b/hw/vmapple/meson.build
> >>> index d4624713deb..64b78693a31 100644
> >>> --- a/hw/vmapple/meson.build
> >>> +++ b/hw/vmapple/meson.build
> >>> @@ -1,2 +1,3 @@
> >>>    system_ss.add(when: 'CONFIG_VMAPPLE_AES',  if_true: files('aes.c')=
)
> >>>    system_ss.add(when: 'CONFIG_VMAPPLE_BDIF', if_true: files('bdif.c'=
))
> >>> +system_ss.add(when: 'CONFIG_VMAPPLE_CFG',  if_true: files('cfg.c'))
> >>> diff --git a/include/hw/vmapple/vmapple.h
> b/include/hw/vmapple/vmapple.h
> >>> index 9090e9c5ac8..3bba59f5ec7 100644
> >>> --- a/include/hw/vmapple/vmapple.h
> >>> +++ b/include/hw/vmapple/vmapple.h
> >>> @@ -16,4 +16,6 @@
> >>>
> >>>    #define TYPE_VMAPPLE_BDIF "vmapple-bdif"
> >>>
> >>> +#define TYPE_VMAPPLE_CFG "vmapple-cfg"
> >>> +
> >>>    #endif /* HW_VMAPPLE_VMAPPLE_H */
> >>
> >>
>
>

--0000000000005c115c0626cc362d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Mon, 11 Nov 2024 at 05:21, Akihiko=
 Odaki &lt;<a href=3D"mailto:akihiko.odaki@daynix.com">akihiko.odaki@daynix=
.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex">On 2024/11/11 0:01, Phil Dennis-Jordan wrote:<br>
&gt; On Sun, 10 Nov 2024 at 08:15, Akihiko Odaki &lt;<a href=3D"mailto:akih=
iko.odaki@daynix.com" target=3D"_blank">akihiko.odaki@daynix.com</a>&gt; wr=
ote:<br>
&gt;&gt;<br>
&gt;&gt; On 2024/11/08 23:47, Phil Dennis-Jordan wrote:<br>
&gt;&gt;&gt; From: Alexander Graf &lt;<a href=3D"mailto:graf@amazon.com" ta=
rget=3D"_blank">graf@amazon.com</a>&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Instead of device tree or other more standardized means, VMApp=
le passes<br>
&gt;&gt;&gt; platform configuration to the first stage boot loader in a bin=
ary encoded<br>
&gt;&gt;&gt; format that resides at a dedicated RAM region in physical addr=
ess space.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; This patch models this configuration space as a qdev device wh=
ich we can<br>
&gt;&gt;&gt; then map at the fixed location in the address space. That way,=
 we can<br>
&gt;&gt;&gt; influence and annotate all configuration fields easily.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Signed-off-by: Alexander Graf &lt;<a href=3D"mailto:graf@amazo=
n.com" target=3D"_blank">graf@amazon.com</a>&gt;<br>
&gt;&gt;&gt; Signed-off-by: Phil Dennis-Jordan &lt;<a href=3D"mailto:phil@p=
hiljordan.eu" target=3D"_blank">phil@philjordan.eu</a>&gt;<br>
&gt;&gt;&gt; ---<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; v3:<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 * Replaced legacy device reset method with Resett=
able method<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; v4:<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 * Fixed initialisation of default values for prop=
erties<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 * Dropped superfluous endianness conversions<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 * Moved most header code to .c, device name #defi=
ne goes in vmapple.h<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; v5:<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 * Improved error reporting in case of string prop=
erty buffer overflow.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; v7:<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 * Changed error messages for overrun of propertie=
s with<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 fixed-length strings to be more useful to =
users than developers.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; v8:<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 * Consistent parenthesising of macro arguments fo=
r better safety.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 hw/vmapple/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 =C2=A03 +<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 hw/vmapple/cfg.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0| 196 +++++++++++++++++++++++++++++++++++<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 hw/vmapple/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0=
|=C2=A0 =C2=A01 +<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 include/hw/vmapple/vmapple.h |=C2=A0 =C2=A02 +<br=
>
&gt;&gt;&gt;=C2=A0 =C2=A0 4 files changed, 202 insertions(+)<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 create mode 100644 hw/vmapple/cfg.c<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; diff --git a/hw/vmapple/Kconfig b/hw/vmapple/Kconfig<br>
&gt;&gt;&gt; index 68f88876eb9..8bbeb9a9237 100644<br>
&gt;&gt;&gt; --- a/hw/vmapple/Kconfig<br>
&gt;&gt;&gt; +++ b/hw/vmapple/Kconfig<br>
&gt;&gt;&gt; @@ -4,3 +4,6 @@ config VMAPPLE_AES<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 config VMAPPLE_BDIF<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 bool<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; +config VMAPPLE_CFG<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 bool<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt; diff --git a/hw/vmapple/cfg.c b/hw/vmapple/cfg.c<br>
&gt;&gt;&gt; new file mode 100644<br>
&gt;&gt;&gt; index 00000000000..787e2505d57<br>
&gt;&gt;&gt; --- /dev/null<br>
&gt;&gt;&gt; +++ b/hw/vmapple/cfg.c<br>
&gt;&gt;&gt; @@ -0,0 +1,196 @@<br>
&gt;&gt;&gt; +/*<br>
&gt;&gt;&gt; + * VMApple Configuration Region<br>
&gt;&gt;&gt; + *<br>
&gt;&gt;&gt; + * Copyright =C2=A9 2023 Amazon.com, Inc. or its affiliates. =
All Rights Reserved.<br>
&gt;&gt;&gt; + *<br>
&gt;&gt;&gt; + * SPDX-License-Identifier: GPL-2.0-or-later<br>
&gt;&gt;&gt; + *<br>
&gt;&gt;&gt; + * This work is licensed under the terms of the GNU GPL, vers=
ion 2 or later.<br>
&gt;&gt;&gt; + * See the COPYING file in the top-level directory.<br>
&gt;&gt;&gt; + */<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt; +#include &quot;qemu/osdep.h&quot;<br>
&gt;&gt;&gt; +#include &quot;hw/vmapple/vmapple.h&quot;<br>
&gt;&gt;&gt; +#include &quot;hw/sysbus.h&quot;<br>
&gt;&gt;&gt; +#include &quot;qemu/log.h&quot;<br>
&gt;&gt;&gt; +#include &quot;qemu/module.h&quot;<br>
&gt;&gt;&gt; +#include &quot;qapi/error.h&quot;<br>
&gt;&gt;&gt; +#include &quot;net/net.h&quot;<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt; +OBJECT_DECLARE_SIMPLE_TYPE(VMAppleCfgState, VMAPPLE_CFG)<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt; +#define VMAPPLE_CFG_SIZE 0x00010000<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt; +typedef struct VMAppleCfg {<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 uint32_t version;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0/* 0x000 */<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 uint32_t nr_cpus;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0/* 0x004 */<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 uint32_t unk1;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 /* 0x008 */<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 uint32_t unk2;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 /* 0x00c */<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 uint32_t unk3;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 /* 0x010 */<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 uint32_t unk4;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 /* 0x014 */<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 uint64_t ecid;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 /* 0x018 */<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 uint64_t ram_size;=C2=A0 =C2=A0 =C2=A0 =C2=A0 /=
* 0x020 */<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 uint32_t run_installer1;=C2=A0 /* 0x028 */<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 uint32_t unk5;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 /* 0x02c */<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 uint32_t unk6;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 /* 0x030 */<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 uint32_t run_installer2;=C2=A0 /* 0x034 */<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 uint32_t rnd;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0/* 0x038 */<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 uint32_t unk7;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 /* 0x03c */<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 MACAddr mac_en0;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 /* 0x040 */<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 uint8_t pad1[2];<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 MACAddr mac_en1;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 /* 0x048 */<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 uint8_t pad2[2];<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 MACAddr mac_wifi0;=C2=A0 =C2=A0 =C2=A0 =C2=A0 /=
* 0x050 */<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 uint8_t pad3[2];<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 MACAddr mac_bt0;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 /* 0x058 */<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 uint8_t pad4[2];<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 uint8_t reserved[0xa0];=C2=A0 =C2=A0/* 0x060 */=
<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 uint32_t cpu_ids[0x80];=C2=A0 =C2=A0/* 0x100 */=
<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 uint8_t scratch[0x200];=C2=A0 =C2=A0/* 0x180 */=
<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 char serial[32];=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 /* 0x380 */<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 char unk8[32];=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 /* 0x3a0 */<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 char model[32];=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0/* 0x3c0 */<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 uint8_t unk9[32];=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0/* 0x3e0 */<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 uint32_t unk10;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0/* 0x400 */<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 char soc_name[32];=C2=A0 =C2=A0 =C2=A0 =C2=A0 /=
* 0x404 */<br>
&gt;&gt;&gt; +} VMAppleCfg;<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt; +struct VMAppleCfgState {<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 SysBusDevice parent_obj;<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 VMAppleCfg cfg;<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 MemoryRegion mem;<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 char *serial;<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 char *model;<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 char *soc_name;<br>
&gt;&gt;&gt; +};<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt; +static void vmapple_cfg_reset(Object *obj, ResetType type)<br=
>
&gt;&gt;&gt; +{<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 VMAppleCfgState *s =3D VMAPPLE_CFG(obj);<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 VMAppleCfg *cfg;<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 cfg =3D memory_region_get_ram_ptr(&amp;s-&gt;me=
m);<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 memset(cfg, 0, VMAPPLE_CFG_SIZE);<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 *cfg =3D s-&gt;cfg;<br>
&gt;&gt;&gt; +}<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt; +static bool set_fixlen_property_or_error(char *restrict dst,<=
br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0const char *restrict src,<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0size_t dst_size, Error **errp,<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0const char *property_name)<br>
&gt;&gt;&gt; +{<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 size_t len;<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 len =3D g_strlcpy(dst, src, dst_size);<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 if (len &lt; dst_size) { /* len does not count =
nul terminator */<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return true;<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 }<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 error_setg(errp,<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;=
Failed to set property &#39;%s&#39; on VMApple &#39;cfg&#39; device: length=
 &quot;<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;=
(%zu) exceeds maximum of %zu&quot;,<br>
&gt;&gt;<br>
&gt;&gt; Don&#39;t print the device name here as it will be automatically p=
rinted.<br>
&gt; <br>
&gt; That&#39;s not what I&#39;m seeing in tests. With code as-is, and sett=
ing an<br>
&gt; overly long value from create_cfg() in the vmapple machine type<br>
&gt; startup, I get the following output:<br>
&gt; <br>
&gt; qemu-system-aarch64: Failed to set property &#39;soc_name&#39; on VMAp=
ple<br>
&gt; &#39;cfg&#39; device: length (50) exceeds maximum of 31<br>
&gt; <br>
&gt; I don&#39;t see any redundant mention of an object or property name. O=
f<br>
&gt; course, this error occurs during the cfg device&#39;s realize(), not<b=
r>
&gt; immediately when setting the property. I can&#39;t see a built-in way =
to<br>
&gt; explicitly limit the length of a string property.<br>
<br>
I was thinking of the scenario where the device is added with the <br>
-device option. It seems the device name is not printed when it is <br>
realized by the machine, but in that case the user will not be aware of <br=
>
the &#39;cfg&#39; device so it is not helpful. A proper way to add a contex=
t <br>
here is calling error_prepend() in the vmapple machine to tell that it <br>
is a failure in that machine type.<br></blockquote><div><br></div><div>I co=
uldn&#39;t find any error_prepend() uses in existing machine types to work =
from as examples, but I hope I&#39;ve got it right now. I&#39;ve made creat=
e_cfg() accept an errp (pass &amp;error_fatal); inside create_cfg, check wh=
ether sysbus_realize_and_unref() succeeded, and if not, apply error_prepend=
 before returning.<br></div><div><br></div><div>It&#39;s in v10 of the patc=
h set, which I&#39;ve just posted.<br></div><div><br></div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid r=
gb(204,204,204);padding-left:1ex">
&gt; <br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0proper=
ty_name, len, dst_size - 1);<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 return false;<br>
&gt;&gt;&gt; +}<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt; +#define set_fixlen_property_or_return(dst_array, src, errp, p=
roperty_name) \<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 do { \<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!set_fixlen_property_or_error=
((dst_array), (src), \<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 ARRAY_SIZE(dst_array), \<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 (errp), (property_name))) { \<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return; \<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 } \<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 } while (0)<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt; +static void vmapple_cfg_realize(DeviceState *dev, Error **err=
p)<br>
&gt;&gt;&gt; +{<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 VMAppleCfgState *s =3D VMAPPLE_CFG(dev);<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 uint32_t i;<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 if (!s-&gt;serial) {<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;serial =3D g_strdup(&quot;1=
234&quot;);<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 }<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 if (!s-&gt;model) {<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;model =3D g_strdup(&quot;VM=
0001&quot;);<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 }<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 if (!s-&gt;soc_name) {<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;soc_name =3D g_strdup(&quot=
;Apple M1 (Virtual)&quot;);<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 }<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 set_fixlen_property_or_return(s-&gt;cfg.serial,=
 s-&gt;serial, errp, &quot;serial&quot;);<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 set_fixlen_property_or_return(s-&gt;cfg.model, =
s-&gt;model, errp, &quot;model&quot;);<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 set_fixlen_property_or_return(s-&gt;cfg.soc_nam=
e, s-&gt;soc_name, errp, &quot;soc_name&quot;);<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 set_fixlen_property_or_return(s-&gt;cfg.unk8, &=
quot;D/A&quot;, errp, &quot;unk8&quot;);<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 s-&gt;cfg.version =3D 2;<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 s-&gt;cfg.unk1 =3D 1;<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 s-&gt;cfg.unk2 =3D 1;<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 s-&gt;cfg.unk3 =3D 0x20;<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 s-&gt;cfg.unk4 =3D 0;<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 s-&gt;cfg.unk5 =3D 1;<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 s-&gt;cfg.unk6 =3D 1;<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 s-&gt;cfg.unk7 =3D 0;<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 s-&gt;cfg.unk10 =3D 1;<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 if (s-&gt;cfg.nr_cpus &gt; ARRAY_SIZE(s-&gt;cfg=
.cpu_ids)) {<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp,<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0&quot;Failed to create %u CPUs, vmapple machine supports %zu max&=
quot;,<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0s-&gt;cfg.nr_cpus, ARRAY_SIZE(s-&gt;cfg.cpu_ids));<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 }<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 for (i =3D 0; i &lt; s-&gt;cfg.nr_cpus; i++) {<=
br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;cfg.cpu_ids[i] =3D i;<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 }<br>
&gt;&gt;&gt; +}<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt; +static void vmapple_cfg_init(Object *obj)<br>
&gt;&gt;&gt; +{<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 VMAppleCfgState *s =3D VMAPPLE_CFG(obj);<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 memory_region_init_ram(&amp;s-&gt;mem, obj, &qu=
ot;VMApple Config&quot;, VMAPPLE_CFG_SIZE,<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;error_fatal);<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 sysbus_init_mmio(SYS_BUS_DEVICE(obj), &amp;s-&g=
t;mem);<br>
&gt;&gt;&gt; +}<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt; +static Property vmapple_cfg_properties[] =3D {<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 DEFINE_PROP_UINT32(&quot;nr-cpus&quot;, VMApple=
CfgState, cfg.nr_cpus, 1),<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 DEFINE_PROP_UINT64(&quot;ecid&quot;, VMAppleCfg=
State, cfg.ecid, 0),<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 DEFINE_PROP_UINT64(&quot;ram-size&quot;, VMAppl=
eCfgState, cfg.ram_size, 0),<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 DEFINE_PROP_UINT32(&quot;run_installer1&quot;, =
VMAppleCfgState, cfg.run_installer1, 0),<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 DEFINE_PROP_UINT32(&quot;run_installer2&quot;, =
VMAppleCfgState, cfg.run_installer2, 0),<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 DEFINE_PROP_UINT32(&quot;rnd&quot;, VMAppleCfgS=
tate, cfg.rnd, 0),<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 DEFINE_PROP_MACADDR(&quot;mac-en0&quot;, VMAppl=
eCfgState, cfg.mac_en0),<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 DEFINE_PROP_MACADDR(&quot;mac-en1&quot;, VMAppl=
eCfgState, cfg.mac_en1),<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 DEFINE_PROP_MACADDR(&quot;mac-wifi0&quot;, VMAp=
pleCfgState, cfg.mac_wifi0),<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 DEFINE_PROP_MACADDR(&quot;mac-bt0&quot;, VMAppl=
eCfgState, cfg.mac_bt0),<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 DEFINE_PROP_STRING(&quot;serial&quot;, VMAppleC=
fgState, serial),<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 DEFINE_PROP_STRING(&quot;model&quot;, VMAppleCf=
gState, model),<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 DEFINE_PROP_STRING(&quot;soc_name&quot;, VMAppl=
eCfgState, soc_name),<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 DEFINE_PROP_END_OF_LIST(),<br>
&gt;&gt;&gt; +};<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt; +static void vmapple_cfg_class_init(ObjectClass *klass, void *=
data)<br>
&gt;&gt;&gt; +{<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 DeviceClass *dc =3D DEVICE_CLASS(klass);<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 ResettableClass *rc =3D RESETTABLE_CLASS(klass)=
;<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 dc-&gt;realize =3D vmapple_cfg_realize;<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 dc-&gt;desc =3D &quot;VMApple Configuration Reg=
ion&quot;;<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 device_class_set_props(dc, vmapple_cfg_properti=
es);<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 rc-&gt;phases.hold =3D vmapple_cfg_reset;<br>
&gt;&gt;&gt; +}<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt; +static const TypeInfo vmapple_cfg_info =3D {<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 .name=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D TYP=
E_VMAPPLE_CFG,<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 .parent=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D TYPE_SYS=
_BUS_DEVICE,<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 .instance_size =3D sizeof(VMAppleCfgState),<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 .instance_init =3D vmapple_cfg_init,<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 .class_init=C2=A0 =C2=A0 =3D vmapple_cfg_class_=
init,<br>
&gt;&gt;&gt; +};<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt; +static void vmapple_cfg_register_types(void)<br>
&gt;&gt;&gt; +{<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 type_register_static(&amp;vmapple_cfg_info);<br=
>
&gt;&gt;&gt; +}<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt; +type_init(vmapple_cfg_register_types)<br>
&gt;&gt;&gt; diff --git a/hw/vmapple/meson.build b/hw/vmapple/meson.build<b=
r>
&gt;&gt;&gt; index d4624713deb..64b78693a31 100644<br>
&gt;&gt;&gt; --- a/hw/vmapple/meson.build<br>
&gt;&gt;&gt; +++ b/hw/vmapple/meson.build<br>
&gt;&gt;&gt; @@ -1,2 +1,3 @@<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 system_ss.add(when: &#39;CONFIG_VMAPPLE_AES&#39;,=
=C2=A0 if_true: files(&#39;aes.c&#39;))<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 system_ss.add(when: &#39;CONFIG_VMAPPLE_BDIF&#39;=
, if_true: files(&#39;bdif.c&#39;))<br>
&gt;&gt;&gt; +system_ss.add(when: &#39;CONFIG_VMAPPLE_CFG&#39;,=C2=A0 if_tr=
ue: files(&#39;cfg.c&#39;))<br>
&gt;&gt;&gt; diff --git a/include/hw/vmapple/vmapple.h b/include/hw/vmapple=
/vmapple.h<br>
&gt;&gt;&gt; index 9090e9c5ac8..3bba59f5ec7 100644<br>
&gt;&gt;&gt; --- a/include/hw/vmapple/vmapple.h<br>
&gt;&gt;&gt; +++ b/include/hw/vmapple/vmapple.h<br>
&gt;&gt;&gt; @@ -16,4 +16,6 @@<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 #define TYPE_VMAPPLE_BDIF &quot;vmapple-bdif&quot=
;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; +#define TYPE_VMAPPLE_CFG &quot;vmapple-cfg&quot;<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 #endif /* HW_VMAPPLE_VMAPPLE_H */<br>
&gt;&gt;<br>
&gt;&gt;<br>
<br>
</blockquote></div></div>

--0000000000005c115c0626cc362d--

