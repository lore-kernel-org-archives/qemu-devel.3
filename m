Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A44AC02182
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 09:25:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taAV1-00049s-5G; Tue, 21 Jan 2025 04:24:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1taAUz-00049e-MH
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 04:24:41 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1taAUx-0000ju-Ts
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 04:24:41 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43621d27adeso36293495e9.2
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2025 01:24:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737451478; x=1738056278; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jKbTvQ7GFs0VuMcggjQ4sZbkRoeENt60Wbm8shZRflk=;
 b=Ey2ffAPubI5Hos2hSY69QqnyxS4DyLmV+Q3ntXIXpbmMXLoADRN5OWIDT47ccGRaSM
 PSuE2DQ5fUFIi52iGZrfYSFQ5QGndhHFA0ZJ9l4c++60599Ve8KfIdQvcJVTRNtiNUw9
 zCuJ1sxv2wxH4wNi6slQM7jHikilO+4y3ZFGkzn03ETrj4LCU14NiZUdB0ZPYAOcuuPl
 dcZMzAR2uSJCLGRp+GSG/eiN/vzKUdu7dT4MU3etRCRrL4Nv1v9NQJsG2VqJ6Yj6uPEI
 qHVmmZ4uPIrramaM2Oz+dRMjLLwQCy6kT+8oSM8RUBqGoijQCoZB61tNTfMOgQ4hz/iZ
 GEMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737451478; x=1738056278;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jKbTvQ7GFs0VuMcggjQ4sZbkRoeENt60Wbm8shZRflk=;
 b=qRErt8L6O52WvBGIITtUwPXPx6+0n+yCtWAiJzt3WQyLdOmDxvxqfLNqkHpW1WByDy
 IvoofolYisEQtvzbsTEnDYPIzEIw5vBL9gxP1sVln2UiW4mIcLFd+NIHhb0lKH3FcyYQ
 s/huAsbzHMgd/zN5Sd2LhdXJ0pOcXjsi44aHSTd4ByOapAOOTuiC9MH2e1CIXbqapwaz
 rAGHnBJZbQkks2t/0r8xf23K0bXu9ztdwMu6q1Vs9kQ84D49vOG5K0y56D+NOseHaUb6
 ssWrquQlFPC9+hik4Mv2ehoAy0bk5dI2Tho/gQ76ehc/3WT9pb8oLxzAcCov8xcVX+/M
 lyjA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWFj5TMmQfq8CgNu4fOieaw2PvAOXZEJdkI5VVyg0Igl6I9+3Chx6DSGLdXMePmFayshdOspnbgcopu@nongnu.org
X-Gm-Message-State: AOJu0Yy19EqcxaUOyWbxkYHeNYyzF4Sm0KQ7b9gglgCQR2rhRGjPs2GK
 OzenSgKKoM24TU0IOTaS0M4uwLEHVu2muPf/DMjVFP7tvp/Jj661
X-Gm-Gg: ASbGncv6EfcMJPMlLxf7hb0XVBdlMkp6Z3qzdl46BGSkx7AbpFoSIvRZKKdyITyaF4x
 2oxdD52Wpd3MgTsBxLyk1tW8l2d7iyJX2HZjAUut5vMwXeCST6lmck3rbIE03klhzr3z3SeuSzX
 s4XMWTEQJLisNvjvbZbc4UKaY8suZlBhdhjRMm+sw+jjbQTT+cb0tVXIUqT1TJbvqWkGKPCeuET
 1Uombf2ODPTiB+R+S9p9YIj/gkEXVvrfVPYAH069yqTFj9JZv3jmv20VrWPGKVO
X-Google-Smtp-Source: AGHT+IGkDV3ieKpGhIrpytUUgxJfKwq3e98LfMm74F8UOZpFN1pO9PijmdjYyzlKfofhd8UEpc0tjQ==
X-Received: by 2002:adf:f402:0:b0:385:f7a3:fea6 with SMTP id
 ffacd0b85a97d-38bf56628f0mr11631027f8f.13.1737451477765; 
 Tue, 21 Jan 2025 01:24:37 -0800 (PST)
Received: from [127.0.0.1] ([62.214.191.67]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4389041f61bsm170147995e9.17.2025.01.21.01.24.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jan 2025 01:24:37 -0800 (PST)
Date: Tue, 21 Jan 2025 09:24:26 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
CC: Alberto Garcia <berto@igalia.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>,
 =?ISO-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 2/2] hw/ipack: Remove legacy qemu_allocate_irqs() use
In-Reply-To: <20250121084452.81941-3-philmd@linaro.org>
References: <20250121084452.81941-1-philmd@linaro.org>
 <20250121084452.81941-3-philmd@linaro.org>
Message-ID: <27522A5D-63E7-45B7-8A54-A19E453AB401@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x32e.google.com
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



Am 21=2E Januar 2025 08:44:52 UTC schrieb "Philippe Mathieu-Daud=C3=A9" <p=
hilmd@linaro=2Eorg>:
>No need to dynamically allocate IRQ when we know before hands
>how many we'll use=2E Declare the 2 of them in IPackDevice state
>and initialize them in the DeviceRealize handler=2E
>
>Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro=2Eorg>
>---
> include/hw/ipack/ipack=2Eh | 7 ++-----
> hw/char/ipoctal232=2Ec     | 4 ++--
> hw/ipack/ipack=2Ec         | 7 +++----
> hw/ipack/tpci200=2Ec       | 6 +++---
> 4 files changed, 10 insertions(+), 14 deletions(-)
>
>diff --git a/include/hw/ipack/ipack=2Eh b/include/hw/ipack/ipack=2Eh
>index cbcdda509d3=2E=2E00f397fd020 100644
>--- a/include/hw/ipack/ipack=2Eh
>+++ b/include/hw/ipack/ipack=2Eh
>@@ -12,6 +12,7 @@
> #define QEMU_IPACK_H
>=20
> #include "hw/qdev-core=2Eh"
>+#include "hw/irq=2Eh"
> #include "qom/object=2Eh"
>=20
>=20
>@@ -19,10 +20,8 @@
> OBJECT_DECLARE_SIMPLE_TYPE(IPackBus, IPACK_BUS)
>=20
> struct IPackBus {
>-    /*< private >*/
>     BusState parent_obj;
>=20
>-    /* All fields are private */
>     uint8_t n_slots;
>     uint8_t free_slot;
>     qemu_irq_handler set_irq;
>@@ -58,13 +57,11 @@ struct IPackDeviceClass {
> };
>=20
> struct IPackDevice {
>-    /*< private >*/
>     DeviceState parent_obj;
>-    /*< public >*/
>=20
>     int32_t slot;
>     /* IRQ objects for the IndustryPack INT0# and INT1# */
>-    qemu_irq *irq;
>+    IRQState irq[2];
> };
>=20
> extern const VMStateDescription vmstate_ipack_device;
>diff --git a/hw/char/ipoctal232=2Ec b/hw/char/ipoctal232=2Ec
>index d1e5f6dad2e=2E=2Ea2879977fb3 100644
>--- a/hw/char/ipoctal232=2Ec
>+++ b/hw/char/ipoctal232=2Ec
>@@ -184,9 +184,9 @@ static void update_irq(IPOctalState *dev, unsigned bl=
ock)
>     unsigned intno =3D block / 2;
>=20
>     if ((blk0->isr & blk0->imr) || (blk1->isr & blk1->imr)) {
>-        qemu_irq_raise(idev->irq[intno]);
>+        qemu_irq_raise(&idev->irq[intno]);
>     } else {
>-        qemu_irq_lower(idev->irq[intno]);
>+        qemu_irq_lower(&idev->irq[intno]);
>     }
> }
>=20
>diff --git a/hw/ipack/ipack=2Ec b/hw/ipack/ipack=2Ec
>index ed75f791832=2E=2Eeeb48dd331c 100644
>--- a/hw/ipack/ipack=2Ec
>+++ b/hw/ipack/ipack=2Ec
>@@ -55,22 +55,21 @@ static void ipack_device_realize(DeviceState *dev, Er=
ror **errp)
>     }
>     bus->free_slot =3D idev->slot + 1;
>=20
>-    idev->irq =3D qemu_allocate_irqs(bus->set_irq, idev, 2);
>+    for (int i =3D 0; i < ARRAY_SIZE(idev->irq); i++) {
>+        qemu_init_irq(&idev->irq[i], bus->set_irq, idev, i);

I wonder if we eventually need a qemu_init_irqs() (note the plural) as we =
remove further uses of qemu_allocate_irqs()=2E

>+    }
>=20
>     k->realize(dev, errp);
> }
>=20
> static void ipack_device_unrealize(DeviceState *dev)
> {
>-    IPackDevice *idev =3D IPACK_DEVICE(dev);
>     IPackDeviceClass *k =3D IPACK_DEVICE_GET_CLASS(dev);
>=20
>     if (k->unrealize) {
>         k->unrealize(dev);
>         return;
>     }
>-
>-    qemu_free_irqs(idev->irq, 2);
> }
>=20
> static const Property ipack_device_props[] =3D {
>diff --git a/hw/ipack/tpci200=2Ec b/hw/ipack/tpci200=2Ec
>index 88eef4b8308=2E=2E470a4203ae4 100644
>--- a/hw/ipack/tpci200=2Ec
>+++ b/hw/ipack/tpci200=2Ec
>@@ -275,11 +275,11 @@ static void tpci200_write_las0(void *opaque, hwaddr=
 addr, uint64_t val,
>                 if (ip !=3D NULL) {
>                     if (val & STATUS_INT(i, 0)) {
>                         DPRINTF("Clear IP %c INT0# status\n", 'A' + i);
>-                        qemu_irq_lower(ip->irq[0]);
>+                        qemu_irq_lower(&ip->irq[0]);
>                     }
>                     if (val & STATUS_INT(i, 1)) {
>                         DPRINTF("Clear IP %c INT1# status\n", 'A' + i);
>-                        qemu_irq_lower(ip->irq[1]);
>+                        qemu_irq_lower(&ip->irq[1]);
>                     }
>                 }
>=20
>@@ -344,7 +344,7 @@ static uint64_t tpci200_read_las1(void *opaque, hwadd=
r addr, unsigned size)
>                 bool int_set =3D s->status & STATUS_INT(ip_n, intno);
>                 bool int_edge_sensitive =3D s->ctrl[ip_n] & CTRL_INT_EDG=
E(intno);
>                 if (int_set && !int_edge_sensitive) {
>-                    qemu_irq_lower(ip->irq[intno]);
>+                    qemu_irq_lower(&ip->irq[intno]);
>                 }
>             }
>=20

With the above addressed:
Reviewed-by: Bernhard Beschow <shentey@gmail=2Ecom>

