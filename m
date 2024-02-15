Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDDEDC4829E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 17:32:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rafaF-0005fT-IM; Thu, 15 Feb 2024 12:31:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rafaE-0005fG-06
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 12:31:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rafaC-0001mt-3x
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 12:31:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708018294;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=igWMgTwGPBkK9bOrJU6rM8Vuntt8MRGTwhT4rZto/iQ=;
 b=Z9l0wtHqyhIOHxHBxjjCJTl8F5MVVR9akkf20jxDUxtTjUhZpGVm9ovTvU4ybwEtdcvykY
 mbpHWNM0XGwQXCkiFec/lGHOM0B4lcT16rsTjIGW+E6Is6BGUT7yiauxxM+K2+wP9PQ6KT
 5sw/9s6eqRrG3dzlh0RcwCS1yfscHvk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-bp1XCGVkO9K4V5uJdJdddQ-1; Thu, 15 Feb 2024 12:31:31 -0500
X-MC-Unique: bp1XCGVkO9K4V5uJdJdddQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-411e24b69f7so5463035e9.3
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 09:31:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708018290; x=1708623090;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=igWMgTwGPBkK9bOrJU6rM8Vuntt8MRGTwhT4rZto/iQ=;
 b=IMZLJyYD9VO786xBnp7z4Erh+4DvrPZQcE+lWfwGl4jp7/E5DjQNYFft8GpYAbhXc/
 GP5POxXD1hJ9oxKKnemTZ0fae8AZzel2xNbz/cmKMy5HmCcV+HpnD7VAT6Sikbn7r+vy
 OIUarXO7iFV+4Xo3TDn+qvkbFZRzgXT0Q+Jne9CN0h7ebZBPQ/E3nXL/aKytQfIrO2k9
 TzkBMcZw4bIryliSzNOVcB4w4gwsZzrYdgxz0fWkY47a5yQlKcZ8eJhvGGaCiyyCYsZm
 /atkMD6mEbnwbryWTyt+IIDAUd2ivFUa4VZZ2mfj68+d2Ao0PSAZU+ygPaK/kkBLIZWe
 Ictg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVHDeXCb0QcuPJqECZllPq3acszQDWSKyj0NIKQlZRbrX0zf6pw4sJ7ca/6R0cwbgSQEnSFlxrL49mMX6bGYgiYtcju1o0=
X-Gm-Message-State: AOJu0YxTD0yg6BquslWNDSp4uwpuuxkPouSPOX/56YjSsQ+dKZ07EcK+
 HUgP6oiGIT2uXYjPRtNYx/L2elhpBoPRL4FmTtxJTe1YEMTOpsWYRdgyDXeQz9Yn2VhLix0hsg/
 eqIc8nRNuXFCe+6TtfDR+9Mx/JCeAtjsVK7R7N6C5LVHhQuEYvr6KTJvDf7Ke2FQywHFUWZpgj/
 eUxGXQrjm2h0kMullXhO6ujWylvsU=
X-Received: by 2002:a05:600c:1da3:b0:410:d1bd:150e with SMTP id
 p35-20020a05600c1da300b00410d1bd150emr1830122wms.14.1708018290246; 
 Thu, 15 Feb 2024 09:31:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE+/7h9y/D0zaYiV4WH13zG8Fqp6iYSzHjcRJrP9vQfZRatQLgZoWBnK9BTqVuWL3RWsVAEhmNCahd23A3PIgs=
X-Received: by 2002:a05:600c:1da3:b0:410:d1bd:150e with SMTP id
 p35-20020a05600c1da300b00410d1bd150emr1830109wms.14.1708018289922; Thu, 15
 Feb 2024 09:31:29 -0800 (PST)
MIME-Version: 1.0
References: <20240213155005.109954-1-pbonzini@redhat.com>
 <20240213155005.109954-9-pbonzini@redhat.com>
 <47a999a8-a0e0-4995-8f8c-8d18f564c30b@linaro.org>
 <d02bde71-c4b8-4b07-bc40-3b74d37b0738@eik.bme.hu>
In-Reply-To: <d02bde71-c4b8-4b07-bc40-3b74d37b0738@eik.bme.hu>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 15 Feb 2024 18:31:18 +0100
Message-ID: <CABgObfZ+pjg9mUU+w7ff7e-rw=9H6Kt5i7BzFZxUaiCQtUhgmQ@mail.gmail.com>
Subject: Re: [PATCH v3 8/9] mips/loongson3_virt: do not require CONFIG_USB
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org, shentey@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.772,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, Feb 15, 2024 at 3:27=E2=80=AFPM BALATON Zoltan <balaton@eik.bme.hu>=
 wrote:
>
> On Thu, 15 Feb 2024, Philippe Mathieu-Daud=C3=A9 wrote:
> > On 13/2/24 16:50, Paolo Bonzini wrote:
> >> Once the Kconfig for hw/mips is cleaned up, it will be possible to bui=
ld a
> >> binary that does not include any USB host controller and therefore tha=
t
> >> does not include the code guarded by CONFIG_USB.  While the simpler
> >> creation functions such as usb_create_simple can be inlined, this is n=
ot
> >> true of usb_bus_find().  Remove it, replacing it with a search of the
> >> single USB bus created by loongson3_virt_devices_init().
> >>
> >> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> >> ---
> >>   hw/mips/loongson3_virt.c | 5 +++--
> >>   1 file changed, 3 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/hw/mips/loongson3_virt.c b/hw/mips/loongson3_virt.c
> >> index caedde2df00..bedd3d496bd 100644
> >> --- a/hw/mips/loongson3_virt.c
> >> +++ b/hw/mips/loongson3_virt.c
> >> @@ -447,8 +447,9 @@ static inline void
> >> loongson3_virt_devices_init(MachineState *machine,
> >>         if (defaults_enabled() && object_class_by_name("pci-ohci")) {
> >>           pci_create_simple(pci_bus, -1, "pci-ohci");
> >> -        usb_create_simple(usb_bus_find(-1), "usb-kbd");
> >> -        usb_create_simple(usb_bus_find(-1), "usb-tablet");
> >> +        Object *usb_bus =3D object_resolve_path_type("", TYPE_USB_BUS=
,
> >> NULL);
> >> +        usb_create_simple(USB_BUS(usb_bus), "usb-kbd");
> >> +        usb_create_simple(USB_BUS(usb_bus), "usb-tablet");
> >>       }
> >>         pci_init_nic_devices(pci_bus, mc->default_nic);
> >
> > Can we remove usb_bus_find() completely instead?
> >
> > $ git grep -w usb_bus_find
> > hw/hppa/machine.c:401:        usb_create_simple(usb_bus_find(-1), "usb-=
kbd");
> > hw/hppa/machine.c:402:        usb_create_simple(usb_bus_find(-1),
> > "usb-mouse");
> > hw/mips/loongson3_virt.c:450:        usb_create_simple(usb_bus_find(-1)=
,
> > "usb-kbd");
> > hw/mips/loongson3_virt.c:451:        usb_create_simple(usb_bus_find(-1)=
,
> > "usb-tablet");
> > hw/ppc/mac_newworld.c:434:            USBBus *usb_bus =3D usb_bus_find(=
-1);
> > hw/ppc/sam460ex.c:423:    usb_create_simple(usb_bus_find(-1), "usb-kbd"=
);
> > hw/ppc/sam460ex.c:424:    usb_create_simple(usb_bus_find(-1), "usb-mous=
e");
> > hw/ppc/spapr.c:3027:            USBBus *usb_bus =3D usb_bus_find(-1);
> > hw/sh4/r2d.c:315:    usb_create_simple(usb_bus_find(-1), "usb-kbd");
> > hw/usb/bus.c:103:USBBus *usb_bus_find(int busnr)
> > hw/usb/bus.c:669:    USBBus *bus =3D usb_bus_find(-1 /* any */);
> > include/hw/usb.h:500:USBBus *usb_bus_find(int busnr);
>
> These are all the machines that add devices to a USB bus, there's no othe=
r
> example to do it in a different way currently. We could change this to ge=
t
> the usb bus in a different way but how?

We can move object_resolve_type_unambiguous out of
hw/i386/acpi-build.c to common code and use it, it's overall a
self-explanatory function.


