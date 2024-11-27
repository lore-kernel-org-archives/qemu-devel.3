Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C70D0D66BA3
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2024 02:09:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tG7Ta-0003dX-EO; Tue, 26 Nov 2024 21:08:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tG7TR-0003cP-Fg
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 21:08:14 -0500
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tG7TO-0001iw-Dv
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 21:08:13 -0500
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-7ee51d9ae30so4852472a12.1
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2024 18:08:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732673285; x=1733278085; darn=nongnu.org;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L2/d3lJCa2A0xqWzZDg8pbxlKhIaJLRiROSXUvD85lk=;
 b=hn0rubzUiYsQNXHUQmvgcRkJ6QWQOrSrNw7deelyOSbfpmqlrDBBDEc80pZUubyIZW
 qofcjB4iN9ijdSXPsLNiFb7cbnD+oLxp5uuWffVBolcIbchWF2wg2rRSjNSPRM8YNWYM
 zgtuTmsA2cWXOl35b0ilWW6YXj5Zz7YoaJlvR2YsPycv6f/qIEz+CMAdnZQrlaCnMVHP
 Dm15zLKxWdNjbvynFZzrRyZWWNeV17KgD32lbzL4r+6FEsgkPNPi7jXJgnZbMF7B+aD9
 AVU/E1oDFrBRH04D0y1NR4+Ix+8ZP5Sxv3F2x4S2LYVsm3uHGyMb+2Afq0F5DYe/T6AC
 7ccQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732673285; x=1733278085;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=L2/d3lJCa2A0xqWzZDg8pbxlKhIaJLRiROSXUvD85lk=;
 b=GggTX3aMbX/GrS1Hb5k/v7z933ltOHbHXUDm5Jd/3Z7Qw+T1go4zARz/k8HrvcDHxo
 f8q+cPCW9+mBsc7F76I52S5yji4urE7sElLmw/NrwG1PNiFK8+FE7mM0DaBt7wzoIRGx
 ICHAQ5LJ4SQeJ3L+ViaYNau0woaJU1sI7/USkd3rR81CcLgjFu7YMnm55dgndT/GIWMn
 PajCscCc2bBBXFVmfGyBzpn3hsI7irG7LZQr7sdHxPhi4YJOPxfc1pX6S/qALhKP4ZBX
 tsRB9++aLMIhb75zw1WPbYejmKzyoWSkaid7acrWC4lH0OyatSOoQcn2Lahh89eh/oXO
 7Cvg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUlsI5gvYfQqpzuEO0s0bpLkV2iOZTcLHaGXOA5nNkLok+PCwfvMCoOqRyueUWLroO1vGS0USzKW+HS@nongnu.org
X-Gm-Message-State: AOJu0YyB93wmfdmt2UTcOHPZjLgnJgV7Mkm09eERBH+3gqXxoQPwVl0f
 CAbL3Zgzs0arJ2A1ncPPPs9yHp9N23Fuoa/UwTW4JdUQ1vJ9tWGH
X-Gm-Gg: ASbGncunupsfb6+o5zz5IGB5TvFK2cmDu3veDVhkmTr47D6cPBM91I8GXXCAdqhFlUH
 KTybDL1dLU+THWQMuCJhhkRd76GrcyiQ4Njo802YTEZg5aORY23mqDIoepEkVcdzwD3p/JeknEL
 GB1XSmcXekoozIKpsjnQEtHm2YmEoG+TMhnSbvj91RZcAB06RGUGhoBMXWzCmYcmQPmlAg40zv4
 5rU0nfqTHtFhF3eyP1e7oHXNO5v+WQdV8LzfzDaKCs7DCMODiILhEOCoJd/8ddPUXAHAqI=
X-Google-Smtp-Source: AGHT+IGOSK2hGAcJ3MdALfPrdEKu5FAsuXOUQ2GXA3W6FT+/3n2tZPWUNcenLwGnVP4N9in1m5EToA==
X-Received: by 2002:a05:6a20:e198:b0:1db:e1b0:b673 with SMTP id
 adf61e73a8af0-1e0e0aaf9aemr2449304637.9.1732673284723; 
 Tue, 26 Nov 2024 18:08:04 -0800 (PST)
Received: from localhost (124-171-72-210.tpgi.com.au. [124.171.72.210])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7251226247esm4062731b3a.170.2024.11.26.18.08.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Nov 2024 18:08:04 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 27 Nov 2024 12:07:59 +1000
Message-Id: <D5WLEZZRQ9GY.1FI9FC4T787TW@gmail.com>
From: "Nicholas Piggin" <npiggin@gmail.com>
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 <qemu-devel@nongnu.org>
Cc: "Paolo Bonzini" <pbonzini@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, "Marcel Apfelbaum" <marcel.apfelbaum@gmail.com>, "Gerd
 Hoffmann" <kraxel@redhat.com>
Subject: Re: [PATCH 2/2] hw/usb: Add TI TUSB73X0 XHCI controller model
X-Mailer: aerc 0.18.2
References: <20241110050009.389367-1-npiggin@gmail.com>
 <20241110050009.389367-3-npiggin@gmail.com>
 <72319f4e-cfe5-4e1a-90a3-d2d29752291f@linaro.org>
In-Reply-To: <72319f4e-cfe5-4e1a-90a3-d2d29752291f@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x533.google.com
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

On Mon Nov 11, 2024 at 1:39 AM AEST, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi Nick,
>
> On 10/11/24 05:00, Nicholas Piggin wrote:
> > This controller is accepted by IBM Power firmware when the subsystem ID=
s
> > are set to Power servers. Firmware is picky about device support so the
> > NEC driver does not work.
> >=20
> > The TI HW has some interesting differences from NEC, notably a separate
> > BAR for MSIX, and PM capabilities. The spec is freely available without
> > sign-up.
> >=20
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > ---
> >   include/hw/pci/pci_ids.h |  1 +
> >   include/hw/usb/xhci.h    |  1 +
> >   hw/usb/hcd-xhci-ti.c     | 94 +++++++++++++++++++++++++++++++++++++++=
+
> >   hw/usb/Kconfig           |  5 +++
> >   hw/usb/meson.build       |  1 +
> >   5 files changed, 102 insertions(+)
> >   create mode 100644 hw/usb/hcd-xhci-ti.c
> >=20
> > diff --git a/include/hw/pci/pci_ids.h b/include/hw/pci/pci_ids.h
> > index f1a53fea8d..fdb692db51 100644
> > --- a/include/hw/pci/pci_ids.h
> > +++ b/include/hw/pci/pci_ids.h
> > @@ -182,6 +182,7 @@
> >   #define PCI_VENDOR_ID_HP                 0x103c
> >  =20
> >   #define PCI_VENDOR_ID_TI                 0x104c
> > +#define PCI_DEVICE_ID_TI_TUSB73X0        0x8241
> >  =20
> >   #define PCI_VENDOR_ID_MOTOROLA           0x1057
> >   #define PCI_DEVICE_ID_MOTOROLA_MPC106    0x0002
> > diff --git a/include/hw/usb/xhci.h b/include/hw/usb/xhci.h
> > index 5c90e1373e..203ec1fca3 100644
> > --- a/include/hw/usb/xhci.h
> > +++ b/include/hw/usb/xhci.h
> > @@ -3,6 +3,7 @@
> >  =20
> >   #define TYPE_XHCI "base-xhci"
> >   #define TYPE_NEC_XHCI "nec-usb-xhci"
> > +#define TYPE_TI_XHCI "ti-usb-xhci"
> >   #define TYPE_QEMU_XHCI "qemu-xhci"
> >   #define TYPE_XHCI_SYSBUS "sysbus-xhci"
> >  =20
> > diff --git a/hw/usb/hcd-xhci-ti.c b/hw/usb/hcd-xhci-ti.c
> > new file mode 100644
> > index 0000000000..a3f7ef8ba2
> > --- /dev/null
> > +++ b/hw/usb/hcd-xhci-ti.c
> > @@ -0,0 +1,94 @@
> > +/*
> > + * USB xHCI controller emulation
> > + * Datasheet https://www.ti.com/product/TUSB7340
> > + *
> > + * Copyright (c) 2011 Securiforest
> > + * Date: 2011-05-11 ;  Author: Hector Martin <hector@marcansoft.com>
> > + * Based on usb-xhci-nec.c, emulates TI TUSB73X0
> > + *
> > + * This library is free software; you can redistribute it and/or
> > + * modify it under the terms of the GNU Lesser General Public
> > + * License as published by the Free Software Foundation; either
> > + * version 2.1 of the License, or (at your option) any later version.
> > + *
> > + * This library is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> > + * Lesser General Public License for more details.
> > + *
> > + * You should have received a copy of the GNU Lesser General Public
> > + * License along with this library; if not, see <http://www.gnu.org/li=
censes/>.
> > + */
> > +
> > +#include "qemu/osdep.h"
> > +#include "hw/usb.h"
> > +#include "qemu/module.h"
> > +#include "hw/pci/pci.h"
> > +#include "hw/qdev-properties.h"
> > +
> > +#include "hcd-xhci-pci.h"
> > +
> > +OBJECT_DECLARE_SIMPLE_TYPE(XHCITiState, TI_XHCI)
> > +
> > +struct XHCITiState {
> > +    /*< private >*/
> > +    XHCIPciState parent_obj;
> > +    /*< public >*/
> > +    uint32_t flags;
> > +    uint32_t intrs;
> > +    uint32_t slots;
> > +};
> > +
> > +static Property ti_xhci_properties[] =3D {
> > +    DEFINE_PROP_ON_OFF_AUTO("msi", XHCIPciState, msi, ON_OFF_AUTO_AUTO=
),
> > +    DEFINE_PROP_ON_OFF_AUTO("msix", XHCIPciState, msix, ON_OFF_AUTO_AU=
TO),
> > +    DEFINE_PROP_UINT32("intrs", XHCITiState, intrs, 8),
> > +    DEFINE_PROP_UINT32("slots", XHCITiState, slots, XHCI_MAXSLOTS),
> > +    DEFINE_PROP_END_OF_LIST(),
> > +};
> > +
> > +static void ti_xhci_instance_init(Object *obj)
> > +{
> > +    XHCIPciState *pci =3D XHCI_PCI(obj);
> > +    XHCITiState *ti =3D TI_XHCI(obj);
> > +
> > +    pci->xhci.flags    =3D ti->flags;
>
> ti->flags doesn't seem initialized / used.

Aha, because you removed the last flags from nec driver and I
copied this from there :P

Good catch. Shall we just remove the flags from XHCINecState?

Thanks,
Nick

