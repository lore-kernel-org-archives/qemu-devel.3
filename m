Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F046CCD184
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 13:28:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6qfA-0000mr-PC; Thu, 09 Oct 2025 09:26:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xpahos@gmail.com>) id 1v6qf8-0000ly-5v
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 09:26:30 -0400
Received: from mail-lj1-x236.google.com ([2a00:1450:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xpahos@gmail.com>) id 1v6qez-0002WA-U0
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 09:26:28 -0400
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-36a6a397477so9293711fa.3
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 06:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760016376; x=1760621176; darn=nongnu.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nAgI9JeXuBKnRzaQOG8nK3oOjLGJCuXuDU+WMuN6Cw8=;
 b=kfPabzQomPITt3IeIisquRcRPsyM9cVl0aenFlQLBYn7yFnBkGfrQQi1CRLMsmg1IB
 Pgxqts+j9zRYrJS4O8iD3kMA9IFOM4e2866tNFPnbpbWGPg+6NgLm/bSxeiZ+hbjPlAI
 JpS/Wrso3FF47dGHvFWACqcARr/FtimDmCthW2GNout/DqwU+E1uoS+O1EMfUNVZpuWQ
 Oz8ul2DPCbyKNnNKgx4XqYZMoHQBTArIPvtzSfq67BabuWXcouRxdNTS0gOdpBpHfa/Z
 sykJac8G8ACYBwsriLHm8xndhBcoJmvnfnRGENtl8rQ+LRu4r+7V0O4msX0FLzmepgXz
 e9Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760016376; x=1760621176;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nAgI9JeXuBKnRzaQOG8nK3oOjLGJCuXuDU+WMuN6Cw8=;
 b=md+MMgsYmBD7roquLiHHNEH86mtMD3B+OWQ22eCT+QUEkE7BN7XA5VacCLOHofBSb4
 IwF3LpLUieiSOnQe/x4gJ+qRX63Rq9Ss5hzIB1gNVlU5iTer4k08p0LEEY2F/7UbGMhG
 b8/daQFvzuokp2cbj28CUuwzVe6fvG1RmsJYSLZg7Wyt8mqAnFjDb3aLRjsUlcxZGESb
 JM2EW7k7cF7lmRhWu4XrDSpfCqD5DqiYlCHX34xKRBlmqw4V05p/Z2V/HXg+MY5fkTrj
 PR6bEcqjRWHwBUw2d9/hHFsjPwMSBv/awALQSzbh4qV/yAx8hGF+ifyL6ys1C2MlwIWr
 lO8w==
X-Gm-Message-State: AOJu0YxXa947gsPgZjo7k1jlO7haN92GHDYKh6/XIAF/rhR8qWyRdtoN
 xo1vLwJJD8r8nCdah1AvtdRAFQDwPARt0GT/veV1cbwawPSzPiwfg6RU
X-Gm-Gg: ASbGncsHNcntxTQNOlsD4DTcgKxKN9S31Mxy4iC6lwV57CWV1RH1Tqa9xcOwop4ou3D
 MYGhNa40kQndHcjKLZJFl1Kh8CZfTHiMt+shGDH7IQeMb8g8/TTQHCbMf4uD110IkLvDhVLcWwg
 Z9BKOpFn5RBqeoZYk9/jBQJN0kftqz5VcPuFxnfcmiwDiR4N1m6zstnnwqMqRFIxdkNGpGAE42T
 MNjWS3MjQHac4nim09cdThoYHJft3WQVsYEJGspa+fSVNNHrszlYaOoESBjj8uMaqPuHM591ETO
 6cgmD9lCBrDV/kOOVpXWF/lXjUcp9suATTpDErd6D7EvZqJwrZQpMc9JvbeyInBenPWT8NUcTul
 r9XetHx7fT3/F3JdIeuP5rjNngf4XbWec4/ecNMQRKjRs1VEIC8KO8B7XKz20NeQ51AM=
X-Google-Smtp-Source: AGHT+IHjiuO9UbyeCuxZon+kgxSWKPk9+qcnKqNmp4G5fH8RWkWbU/m6OmxQrcV7doazAP4Co1GVrg==
X-Received: by 2002:a05:651c:1543:b0:35f:73ba:e758 with SMTP id
 38308e7fff4ca-37609cfa0a8mr20272801fa.1.1760016375638; 
 Thu, 09 Oct 2025 06:26:15 -0700 (PDT)
Received: from smtpclient.apple ([2a02:6bf:8011:f00:6191:211a:2507:cf35])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-375f39fca47sm28419641fa.16.2025.10.09.06.26.14
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 09 Oct 2025 06:26:15 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51.11.2\))
Subject: Re: [PATCH] hw/arm: add pvpanic mmio device for arm
From: Alexander Gryanko <xpahos@gmail.com>
In-Reply-To: <20251007151157.5a601c3e@fedora>
Date: Thu, 9 Oct 2025 16:25:59 +0300
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org, qemu-trivial@nongnu.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <DFAE42FB-786F-45D3-9FC5-C72DEC5A4301@gmail.com>
References: <CC5A0011-CD14-40F9-8023-8BF5F989BCCF@gmail.com>
 <20251007151157.5a601c3e@fedora>
To: Igor Mammedov <imammedo@redhat.com>
X-Mailer: Apple Mail (2.3776.700.51.11.2)
Received-SPF: pass client-ip=2a00:1450:4864:20::236;
 envelope-from=xpahos@gmail.com; helo=mail-lj1-x236.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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



> On 7 Oct 2025, at 16:11, Igor Mammedov <imammedo@redhat.com> wrote:
>=20
> On Sat, 4 Oct 2025 23:19:09 +0300
> Alexander Gryanko <xpahos@gmail.com> wrote:
>=20
>> Currently, pvpanic is available in three device types: ISA,
>> MMIO, and PCI. For early stages of system initialisation
>> before PCI enumeration, only ISA and MMIO are suitable.
>> ISA is specific to the x86 platform; only MMIO devices
>> can be used for ARM. It is not possible to specify a
>> device as on the x86 platform (-device pvpanic); the
>=20
> perhaps ARM folsk know better, don't we have some
> user create-able sysbus devices? Can it be implemented
> as such, so we would avoid creating built-in device?

As a QEMU user, I expected there to be a way to specify a dtb from a =
file that could be used as the actual device tree inside the virtual =
machine. Perhaps there is a way to do this, but I am not very familiar =
with the QEMU code and do not know how it should work.

>=20
>> only possible way is to add an MMIO device to the dtb,
>> which can be implemented by manually adding new functions
>> to the QEMU code, as was done in the VMApple implementation.
>>=20
>> Signed-off-by: Alexander Gryanko <xpahos@gmail.com>
>> ---
>> hw/arm/virt.c         | 25 +++++++++++++++++++++++++
>> include/hw/arm/virt.h |  1 +
>> 2 files changed, 26 insertions(+)
>>=20
>> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
>> index 02209fadcf..1059584b67 100644
>> --- a/hw/arm/virt.c
>> +++ b/hw/arm/virt.c
>> @@ -39,6 +39,7 @@
>> #include "hw/arm/virt.h"
>> #include "hw/block/flash.h"
>> #include "hw/display/ramfb.h"
>> +#include "hw/misc/pvpanic.h"
>> #include "net/net.h"
>> #include "system/device_tree.h"
>> #include "system/numa.h"
>> @@ -182,6 +183,7 @@ static const MemMapEntry base_memmap[] =3D {
>>    [VIRT_UART0] =3D              { 0x09000000, 0x00001000 },
>>    [VIRT_RTC] =3D                { 0x09010000, 0x00001000 },
>>    [VIRT_FW_CFG] =3D             { 0x09020000, 0x00000018 },
>> +    [VIRT_PVPANIC] =3D            { 0x09021000, 0x00000002 },
>>    [VIRT_GPIO] =3D               { 0x09030000, 0x00001000 },
>>    [VIRT_UART1] =3D              { 0x09040000, 0x00001000 },
>>    [VIRT_SMMU] =3D               { 0x09050000, SMMU_IO_LEN },
>> @@ -276,6 +278,27 @@ static bool ns_el2_virt_timer_present(void)
>>        arm_feature(env, ARM_FEATURE_EL2) && cpu_isar_feature(aa64_vh, =
cpu);
>> }
>>=20
>> +static void create_pvpanic(VirtMachineState *vms)
>> +{
>> +    char *nodename;
>> +    MachineState *ms =3D MACHINE(vms);
>> +    DeviceState *dev =3D qdev_new(TYPE_PVPANIC_MMIO_DEVICE);
>> +    SysBusDevice *s =3D SYS_BUS_DEVICE(dev);
>> +
>> +    hwaddr base =3D vms->memmap[VIRT_PVPANIC].base;
>> +    hwaddr size =3D vms->memmap[VIRT_PVPANIC].size;
>> +
>> +    sysbus_realize_and_unref(s, &error_fatal);
>> +    sysbus_mmio_map(s, 0, base);
>> +
>> +    nodename =3D g_strdup_printf("/pvpanic@%" PRIx64, base);
>> +    qemu_fdt_add_subnode(ms->fdt, nodename);
>> +    qemu_fdt_setprop_string(ms->fdt, nodename, "compatible",
>> +                            "qemu,pvpanic-mmio");
>> +    qemu_fdt_setprop_sized_cells(ms->fdt, nodename, "reg",
>> +                                 2, base, 2, size);
>> +}
>> +
>> static void create_fdt(VirtMachineState *vms)
>> {
>>    MachineState *ms =3D MACHINE(vms);
>> @@ -2498,6 +2521,8 @@ static void machvirt_init(MachineState =
*machine)
>>    create_pcie(vms);
>>    create_cxl_host_reg_region(vms);
>>=20
>> +    create_pvpanic(vms);
>=20
> given that virt is versioned machine type,
> we probably need a compat knob to disable it's creation on old machine =
types
>=20
>> +
>>    if (has_ged && aarch64 && firmware_loaded && =
virt_is_acpi_enabled(vms)) {
>>        vms->acpi_dev =3D create_acpi_ged(vms);
>>    } else {
>> diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
>> index ea2cff05b0..39bf07c9c1 100644
>> --- a/include/hw/arm/virt.h
>> +++ b/include/hw/arm/virt.h
>> @@ -81,6 +81,7 @@ enum {
>>    VIRT_NVDIMM_ACPI,
>>    VIRT_PVTIME,
>>    VIRT_ACPI_PCIHP,
>> +    VIRT_PVPANIC,
>>    VIRT_LOWMEMMAP_LAST,
>> };
>>=20
>>=20
>> ---
>> base-commit: bd6aa0d1e59d71218c3eee055bc8d222c6e1a628
>> change-id: 20251004-arm-pvpanic-84a7d7b67d8d
>>=20
>> Best regards,
>=20


