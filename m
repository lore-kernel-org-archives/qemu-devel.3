Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6517CE7716A
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Dec 2024 18:39:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMX2P-0006Rw-Mk; Sat, 14 Dec 2024 13:38:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tMX2M-0006Pe-6R; Sat, 14 Dec 2024 13:38:46 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tMX2K-0004rT-Fa; Sat, 14 Dec 2024 13:38:45 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4361fe642ddso29340305e9.2; 
 Sat, 14 Dec 2024 10:38:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734201520; x=1734806320; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=86wLUwSF1OZgLJAl27kejU/Ni89VOyQc9iW47FX90+k=;
 b=CtlxrjSc86AtpDqMJw+VoB9m0yaj3Pop8/e3LovZPlHD1Tb2Dfdnpjq3qClGqOx+o+
 7TMNrvOBsZwnufoelAJLoJZLKNLbLJayBsfYgbSeOb7669X99V7ZHy4c19gYUaVxGinU
 TtdOMkHuD8g9I+EcLmUa6sD9F0JpSjrNITGiDCr2mrVWeXT0ZSnD8Sure20tEVzhrCj4
 4gnuEmNh0uF/1cxUYIUoFIfgbTBhUIUyabURky05DBqY9ztadAXqh2auzOpHm8pLrRFV
 jyspb6oXFFY2cHQPuSY1QGXjkU4ZXGViCn0gT973cPEw+DM41yf5q3Acc2eM3dSbS0Bt
 r0ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734201520; x=1734806320;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=86wLUwSF1OZgLJAl27kejU/Ni89VOyQc9iW47FX90+k=;
 b=CRkcpXPXAJ+yiuxTflis4kLLq9IAEQU9uSZBIRqT2ENzK32xaMH5Cv1kJXK5T6NcBQ
 ulG6z2SK1othWfqKL4t8HlIg/HkF1Wiiv3t6ZwOhvXz/tO2yaHMvdxkLwfviEhVVsvsU
 DPH+DDBcjduyxjMaF+sf3Xa+MN2jmrJvpuYAj5iuIvzCi+VezWmI7zuRJs0HtrOHPiiG
 i0a1jdP4Fd4cRP6lkiSxu4CM3IixnsMEpE3YxpGu66hCJjP8yjEMG6Eeo1FBveLVgJeZ
 b/ZM4U2bxdSzcGfqAeNqHBIAdokllIbVZoTzSWXVeq2k4sqcFsU7qwHDQI77NgBh8gcL
 l1LQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXY1UQ7gykrbKcj6+DgGLsZ3xuHi/nSVLkVN1Ch7xsHIEBjFzZ8lrNeDZ1qal0thfbWc5A4wqOavx43@nongnu.org
X-Gm-Message-State: AOJu0YznzOJwQlbp4v3cQ4YnkYzJYkhOdq+h2X+oNrfREoW7pGE7wCyh
 EyZDFgimjjv0V5Ra9e4Xu6IeOdvQYb7218iCvDy7GzhXOPsyVfKGovT8jw==
X-Gm-Gg: ASbGncv9KTShrk3hfS8ONhjG+jxK9IPHqO/kPQUAHsVq4GQGJv/cPtLHqYvjjjRc/vP
 cGZJzP3EbBOCFVOhWG07bb7MpIb6cRDLu+ZtQHk1CGYKpYix+wZLuXx4sNz42pfS1H4u1kq5C7/
 ihFY0TWIDmxsaT2/ykpoB8iWQ99BQ+561kGXGBAhokNn2Kq6G/JOjZt839SDTCheI5tPb2SkND/
 uE/iKupvSf8AV0EWbdu2WxuyLl0NXIvsZe2up8tGxuGldalhg1f
X-Google-Smtp-Source: AGHT+IEL1GM3310Rk8uHPnMhNjleeyl5qpPYTLb48XHeeHBC0JuH5JgJvLcH1Prhj5mKIx5XzJ+U9w==
X-Received: by 2002:a05:600c:1c1e:b0:436:30e4:459b with SMTP id
 5b1f17b1804b1-43630e4465amr62870405e9.18.1734201519635; 
 Sat, 14 Dec 2024 10:38:39 -0800 (PST)
Received: from [127.0.0.1] ([185.238.219.73]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4363602c92csm31667435e9.15.2024.12.14.10.38.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Dec 2024 10:38:38 -0800 (PST)
Date: Sat, 14 Dec 2024 18:38:36 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
CC: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
Subject: Re: [PATCH 30/71] hw/ide: Constify all Property
In-Reply-To: <20241213190750.2513964-35-richard.henderson@linaro.org>
References: <20241213190750.2513964-1-richard.henderson@linaro.org>
 <20241213190750.2513964-35-richard.henderson@linaro.org>
Message-ID: <20326C49-CDA0-4B35-BAEA-662861E74B48@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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



Am 13=2E Dezember 2024 19:07:04 UTC schrieb Richard Henderson <richard=2Eh=
enderson@linaro=2Eorg>:
>Signed-off-by: Richard Henderson <richard=2Ehenderson@linaro=2Eorg>
>---
> hw/ide/ahci=2Ec    | 2 +-
> hw/ide/cf=2Ec      | 2 +-
> hw/ide/cmd646=2Ec  | 2 +-
> hw/ide/ide-dev=2Ec | 6 +++---
> hw/ide/isa=2Ec     | 2 +-
> hw/ide/macio=2Ec   | 2 +-
> hw/ide/mmio=2Ec    | 2 +-
> 7 files changed, 9 insertions(+), 9 deletions(-)
>
>diff --git a/hw/ide/ahci=2Ec b/hw/ide/ahci=2Ec
>index 0eb24304ee=2E=2E8ee015c1a4 100644
>--- a/hw/ide/ahci=2Ec
>+++ b/hw/ide/ahci=2Ec
>@@ -1867,7 +1867,7 @@ static void sysbus_ahci_realize(DeviceState *dev, E=
rror **errp)
>     ahci_realize(&s->ahci, dev, &address_space_memory);
> }
>=20
>-static Property sysbus_ahci_properties[] =3D {
>+static const Property sysbus_ahci_properties[] =3D {
>     DEFINE_PROP_UINT32("num-ports", SysbusAHCIState, ahci=2Eports, 1),
>     DEFINE_PROP_END_OF_LIST(),
> };
>diff --git a/hw/ide/cf=2Ec b/hw/ide/cf=2Ec
>index 2a425cb0f2=2E=2E190914f513 100644
>--- a/hw/ide/cf=2Ec
>+++ b/hw/ide/cf=2Ec
>@@ -24,7 +24,7 @@ static void ide_cf_realize(IDEDevice *dev, Error **errp=
)
>     ide_dev_initfn(dev, IDE_CFATA, errp);
> }
>=20
>-static Property ide_cf_properties[] =3D {
>+static const Property ide_cf_properties[] =3D {
>     DEFINE_IDE_DEV_PROPERTIES(),
>     DEFINE_BLOCK_CHS_PROPERTIES(IDEDrive, dev=2Econf),
>     DEFINE_PROP_BIOS_CHS_TRANS("bios-chs-trans",
>diff --git a/hw/ide/cmd646=2Ec b/hw/ide/cmd646=2Ec
>index 6b02fc81ec=2E=2E942f6c470c 100644
>--- a/hw/ide/cmd646=2Ec
>+++ b/hw/ide/cmd646=2Ec
>@@ -313,7 +313,7 @@ static void pci_cmd646_ide_exitfn(PCIDevice *dev)
>     }
> }
>=20
>-static Property cmd646_ide_properties[] =3D {
>+static const Property cmd646_ide_properties[] =3D {
>     DEFINE_PROP_UINT32("secondary", PCIIDEState, secondary, 0),
>     DEFINE_PROP_END_OF_LIST(),
> };
>diff --git a/hw/ide/ide-dev=2Ec b/hw/ide/ide-dev=2Ec
>index 03f7967798=2E=2Ecc92531f1c 100644
>--- a/hw/ide/ide-dev=2Ec
>+++ b/hw/ide/ide-dev=2Ec
>@@ -29,7 +29,7 @@
> #include "qapi/visitor=2Eh"
> #include "ide-internal=2Eh"
>=20
>-static Property ide_props[] =3D {
>+static const Property ide_props[] =3D {
>     DEFINE_PROP_UINT32("unit", IDEDevice, unit, -1),
>     DEFINE_PROP_BOOL("win2k-install-hack", IDEDevice, win2k_install_hack=
, false),
>     DEFINE_PROP_END_OF_LIST(),
>@@ -191,7 +191,7 @@ static void ide_cd_realize(IDEDevice *dev, Error **er=
rp)
>     ide_dev_initfn(dev, IDE_CD, errp);
> }
>=20
>-static Property ide_hd_properties[] =3D {
>+static const Property ide_hd_properties[] =3D {
>     DEFINE_IDE_DEV_PROPERTIES(),
>     DEFINE_BLOCK_CHS_PROPERTIES(IDEDrive, dev=2Econf),
>     DEFINE_PROP_BIOS_CHS_TRANS("bios-chs-trans",
>@@ -218,7 +218,7 @@ static const TypeInfo ide_hd_info =3D {
>     =2Eclass_init    =3D ide_hd_class_init,
> };
>=20
>-static Property ide_cd_properties[] =3D {
>+static const Property ide_cd_properties[] =3D {
>     DEFINE_IDE_DEV_PROPERTIES(),
>     DEFINE_PROP_END_OF_LIST(),
> };
>diff --git a/hw/ide/isa=2Ec b/hw/ide/isa=2Ec
>index 211ebc9ba7=2E=2Ea0a7e4837c 100644
>--- a/hw/ide/isa=2Ec
>+++ b/hw/ide/isa=2Ec
>@@ -101,7 +101,7 @@ ISADevice *isa_ide_init(ISABus *bus, int iobase, int =
iobase2, int irqnum,
>     return isadev;
> }
>=20
>-static Property isa_ide_properties[] =3D {
>+static const Property isa_ide_properties[] =3D {
>     DEFINE_PROP_UINT32("iobase",  ISAIDEState, iobase,  0x1f0),
>     DEFINE_PROP_UINT32("iobase2", ISAIDEState, iobase2, 0x3f6),
>     DEFINE_PROP_UINT32("irq",     ISAIDEState, irqnum,  14),
>diff --git a/hw/ide/macio=2Ec b/hw/ide/macio=2Ec
>index 99477a3d13=2E=2E25f8403e80 100644
>--- a/hw/ide/macio=2Ec
>+++ b/hw/ide/macio=2Ec
>@@ -459,7 +459,7 @@ static void macio_ide_initfn(Object *obj)
>                              qdev_prop_allow_set_link_before_realize, 0)=
;
> }
>=20
>-static Property macio_ide_properties[] =3D {
>+static const Property macio_ide_properties[] =3D {
>     DEFINE_PROP_UINT32("channel", MACIOIDEState, channel, 0),
>     DEFINE_PROP_UINT32("addr", MACIOIDEState, addr, -1),
>     DEFINE_PROP_END_OF_LIST(),
>diff --git a/hw/ide/mmio=2Ec b/hw/ide/mmio=2Ec
>index 53d22fb37f=2E=2E43ab66f347 100644
>--- a/hw/ide/mmio=2Ec
>+++ b/hw/ide/mmio=2Ec
>@@ -141,7 +141,7 @@ static void mmio_ide_initfn(Object *obj)
>     sysbus_init_irq(d, &s->irq);
> }
>=20
>-static Property mmio_ide_properties[] =3D {
>+static const Property mmio_ide_properties[] =3D {
>     DEFINE_PROP_UINT32("shift", MMIOIDEState, shift, 0),
>     DEFINE_PROP_END_OF_LIST()
> };

Reviewed-by: Bernhard Beschow <shentey@gmail=2Ecom>

