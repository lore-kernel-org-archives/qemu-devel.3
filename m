Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22BACF513E5
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 22:33:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyHFt-000711-7c; Thu, 05 Mar 2026 17:33:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vyHFq-00070S-Lc
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 17:33:14 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vyHFn-00067e-HR
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 17:33:13 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-439aa2f8ebaso3607442f8f.2
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2026 14:33:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772749990; x=1773354790; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/fJElUsvaoaJhNxbEgqNdEk1gqTq1M+CDjm8jn8Y1Vw=;
 b=Y44q8VRSYftEtfXHJhcAU9mQfQb/BkiSQ0tdhtI6OK/srcgtOFYRcsR6iTJQbDbIWa
 n/ukhtKqbL+M2USQZotlIzVY6eiO6CCbUhn+i2OhVT5XpmLABlV8f84/Sq/U46GsJCdo
 ilOc6+tG/q3vi4QbquFknL2sEsaOcMZ/ZC5IiiTHarWBoOI/Y8bHD83ApGvg6Eh4iQ1/
 VaZcaKlY2aD97u6fHnpI9C9njdHhZBd2Pn5Q9qcsz6nsY69GDSF1TNKLJG7Psf1W3Vuc
 /w8KqXS8+D70+PvFlKvl2yKCqfWBs/m6JGmdnH1lpsB67hqCXHbDh9YDHJTEfFOZPHQr
 UXnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772749990; x=1773354790;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/fJElUsvaoaJhNxbEgqNdEk1gqTq1M+CDjm8jn8Y1Vw=;
 b=AcL04/95Wm/+P/s92vw3KR3ATIC6Qg+DgVrtKZNcbx55wrsxEDtXKCVvy3yA5MZnMx
 SicDRnRtLj5YD457y7BNMmwG/s39OfcErl2etweP8JQ7aTGOiOu/yimdiiLu4Kve2H40
 tlTtkfkSgZGaB2rB3EeKElKr/u+dJjtwHO2hElwTBpBkcxKllzwGrSvxWUVYQyA7Z3g4
 W9Kp8dxolPClnqSZXZxDVJmzyvUE/oa6ATHD2QRuIWEoA5FHQAKB5Bq/ZUlC/yAllCc7
 Ct0naZ1lstZ0qNTpBnV0w+yAf2JVkYtXt693HPDU0TFNa7TDH6egFyG1xyoHNl8nfH59
 IKwQ==
X-Gm-Message-State: AOJu0YwLx3vleKClMRpRVaAIDWf4cACqAjrN96buKORrdfz+ntOk4g+P
 CJ0u51B1QcaB2mdtp1jJgFxYp/+5qk3/KMc9c72nj5FWoB3dmOvNaqWVlhY7FQ==
X-Gm-Gg: ATEYQzydzs8XDkxc4mQARCnyyqORPOsGgujGHOPbWfA4BUFX1w9/eWexz69Uo0EcsHj
 5zXLWjs48bDepYTywDhd99g16rje8N8fLqUVoYRPkMtOuXyYXCkk03DVHyf5T5W90leXDgmKOx8
 HFRa4oVY2d/HCmVbo6TvEl7aUqyohLTl1/wRYrh0oNf3K0doGr2BI9xaP4MlnF5aIO+gXX68rpa
 xh4+06jUNzFdGxqTdau5BF0DoFMGDmbm/jAlloLujVlPM3PpvxRStMyg+XuSFrrvdDvCncjIf65
 +CQh+5Ag5QqeChSrAwDgY/JXI220PcmWTjDgx+lUJsEZ4jZ/UBmrYziI0bvMpKvUkA/gD1pswH9
 7ULWdWFRn7qLnn1VuloUvMQZjTGtuzxNEUopBVzf1ETjZEineMFdhTP5xCHLe89xBD2P6Z89NtL
 5c68vjLYSnqHEdVNWATr1yEPta7hLmJ90I8uckrp6OwzoC+8NY7O06iyEh9+6ZpKv9vY/teOlwB
 DNhvfblfHySuT2pCifEOpSr71U0CV5QaVzyBoehPwQ2KZQ=
X-Received: by 2002:a5d:5303:0:b0:439:cb5c:b18d with SMTP id
 ffacd0b85a97d-439cb5cb1efmr9077841f8f.38.1772749989457; 
 Thu, 05 Mar 2026 14:33:09 -0800 (PST)
Received: from ehlo.thunderbird.net
 (dynamic-2a02-3100-2989-c400-f009-a6c9-39e7-d8fe.310.pool.telefonica.de.
 [2a02:3100:2989:c400:f009:a6c9:39e7:d8fe])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439ab6ebe56sm43437474f8f.15.2026.03.05.14.33.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Mar 2026 14:33:09 -0800 (PST)
Date: Thu, 05 Mar 2026 22:33:06 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
CC: Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 Troy Lee <leetroy@gmail.com>, Joel Stanley <joel@jms.id.au>,
 =?ISO-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>,
 =?ISO-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Steven Lee <steven_lee@aspeedtech.com>, Jamin Lin <jamin_lin@aspeedtech.com>, 
 qemu-arm@nongnu.org, Helge Deller <deller@gmx.de>
Subject: Re: [PATCH v3 12/14] hw/char/serial: Keep MemoryRegionOps private
In-Reply-To: <20260305220911.131508-13-shentey@gmail.com>
References: <20260305220911.131508-1-shentey@gmail.com>
 <20260305220911.131508-13-shentey@gmail.com>
Message-ID: <CD755833-23F8-41EA-A29B-CD0B6607565D@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=shentey@gmail.com; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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



Am 5=2E M=C3=A4rz 2026 22:09:09 UTC schrieb Bernhard Beschow <shentey@gmai=
l=2Ecom>:
>Rather than requiring users of TYPE_SERIAL to initialize the MMIO region
>themselves, make it generic enough to be configured via properties=2E Thi=
s
>makes TYPE_SERIAL more self-contained and prepares it for being turned
>into a SysBusDevice=2E
>
>Note that for TYPE_SERIAL_MM, if the regshift property has the default va=
lue
>zero, serial_io_ops rather than serial_mm_ops is now used=2E This seems t=
o be
>fine since in both cases, registers are one byte wide and there are no ga=
ps
>between registers=2E Therefore, neither the endianness nor the access siz=
e
>should make a difference=2E

Hmm, the access size of 1 is now actually stricter=2E Before, it was possi=
ble to read or write all registers at once with one 64 bit access=2E I wond=
er if this is used or useful in practice or if the access size of 8 was cho=
sen to avoid a combinatoric explosion of MemoryRegionOps=2E

Should we make a bet here and fix regressions, if any, as they happen to a=
void "cargo culting"?

Best regards,
Bernhard

> Running `make check` and `make check-functional`
>seems to confirm this=2E
>
>Signed-off-by: Bernhard Beschow <shentey@gmail=2Ecom>
>---
> include/hw/char/serial-mm=2Eh |  3 --
> include/hw/char/serial=2Eh    |  4 +-
> hw/char/diva-gsp=2Ec          |  5 ---
> hw/char/serial-isa=2Ec        |  1 -
> hw/char/serial-mm=2Ec         | 51 -------------------------
> hw/char/serial-pci-multi=2Ec  |  5 ---
> hw/char/serial-pci=2Ec        |  1 -
> hw/char/serial=2Ec            | 76 ++++++++++++++++++++++++++++++-------
> 8 files changed, 66 insertions(+), 80 deletions(-)
>
>diff --git a/include/hw/char/serial-mm=2Eh b/include/hw/char/serial-mm=2E=
h
>index 0076bdc061=2E=2E4c18e2a609 100644
>--- a/include/hw/char/serial-mm=2Eh
>+++ b/include/hw/char/serial-mm=2Eh
>@@ -39,9 +39,6 @@ struct SerialMM {
>     SysBusDevice parent;
>=20
>     SerialState serial;
>-
>-    uint8_t regshift;
>-    uint8_t endianness;
> };
>=20
> SerialMM *serial_mm_init(MemoryRegion *address_space,
>diff --git a/include/hw/char/serial=2Eh b/include/hw/char/serial=2Eh
>index ea82ffac47=2E=2E0cf641a860 100644
>--- a/include/hw/char/serial=2Eh
>+++ b/include/hw/char/serial=2Eh
>@@ -62,6 +62,9 @@ struct SerialState {
>     guint watch_tag;
>     bool wakeup;
>=20
>+    uint8_t regshift;
>+    uint8_t endianness;
>+
>     /* Time when the last byte was successfully sent out of the tsr */
>     uint64_t last_xmit_ts;
>     Fifo8 recv_fifo;
>@@ -80,7 +83,6 @@ struct SerialState {
> };
>=20
> extern const VMStateDescription vmstate_serial;
>-extern const MemoryRegionOps serial_io_ops;
>=20
> #define TYPE_SERIAL "serial"
> OBJECT_DECLARE_SIMPLE_TYPE(SerialState, SERIAL)
>diff --git a/hw/char/diva-gsp=2Ec b/hw/char/diva-gsp=2Ec
>index f9aa6e326d=2E=2Eb0a2437c85 100644
>--- a/hw/char/diva-gsp=2Ec
>+++ b/hw/char/diva-gsp=2Ec
>@@ -47,7 +47,6 @@ typedef struct PCIDivaSerialState {
>     MemoryRegion mailboxbar;    /* for hardware mailbox */
>     uint32_t     subvendor;
>     uint32_t     ports;
>-    char         *name[PCI_SERIAL_MAX_PORTS];
>     SerialState  state[PCI_SERIAL_MAX_PORTS];
>     uint32_t     level[PCI_SERIAL_MAX_PORTS];
>     qemu_irq     *irqs;
>@@ -64,7 +63,6 @@ static void diva_pci_exit(PCIDevice *dev)
>         s =3D pci->state + i;
>         memory_region_del_subregion(&pci->membar, &s->io);
>         qdev_unrealize(DEVICE(s));
>-        g_free(pci->name[i]);
>     }
>     qemu_free_irqs(pci->irqs, pci->ports);
> }
>@@ -136,9 +134,6 @@ static void diva_pci_realize(PCIDevice *dev, Error **=
errp)
>             return;
>         }
>         s->irq =3D pci->irqs[i];
>-        pci->name[i] =3D g_strdup_printf("uart #%zu", i + 1);
>-        memory_region_init_io(&s->io, OBJECT(pci), &serial_io_ops, s,
>-                              pci->name[i], 8);
>=20
>         /* calculate offset of given port based on bitmask */
>         while ((portmask & BIT(0)) =3D=3D 0) {
>diff --git a/hw/char/serial-isa=2Ec b/hw/char/serial-isa=2Ec
>index a4be0492c5=2E=2E3a48b2495e 100644
>--- a/hw/char/serial-isa=2Ec
>+++ b/hw/char/serial-isa=2Ec
>@@ -80,7 +80,6 @@ static void serial_isa_realizefn(DeviceState *dev, Erro=
r **errp)
>     qdev_realize(DEVICE(s), NULL, errp);
>     qdev_set_legacy_instance_id(dev, isa->iobase, 3);
>=20
>-    memory_region_init_io(&s->io, OBJECT(isa), &serial_io_ops, s, "seria=
l", 8);
>     isa_register_ioport(isadev, &s->io, isa->iobase);
> }
>=20
>diff --git a/hw/char/serial-mm=2Ec b/hw/char/serial-mm=2Ec
>index 0e0be26fa9=2E=2E1dba4fc694 100644
>--- a/hw/char/serial-mm=2Ec
>+++ b/hw/char/serial-mm=2Ec
>@@ -30,44 +30,6 @@
> #include "qapi/error=2Eh"
> #include "hw/core/qdev-properties=2Eh"
>=20
>-static uint64_t serial_mm_read(void *opaque, hwaddr addr, unsigned size)
>-{
>-    SerialMM *s =3D SERIAL_MM(opaque);
>-    return serial_io_ops=2Eread(&s->serial, addr >> s->regshift, 1);
>-}
>-
>-static void serial_mm_write(void *opaque, hwaddr addr,
>-                            uint64_t value, unsigned size)
>-{
>-    SerialMM *s =3D SERIAL_MM(opaque);
>-    value &=3D 255;
>-    serial_io_ops=2Ewrite(&s->serial, addr >> s->regshift, value, 1);
>-}
>-
>-static const MemoryRegionOps serial_mm_ops[] =3D {
>-    [DEVICE_NATIVE_ENDIAN] =3D {
>-        =2Eread =3D serial_mm_read,
>-        =2Ewrite =3D serial_mm_write,
>-        =2Eendianness =3D DEVICE_NATIVE_ENDIAN,
>-        =2Evalid=2Emax_access_size =3D 8,
>-        =2Eimpl=2Emax_access_size =3D 8,
>-    },
>-    [DEVICE_LITTLE_ENDIAN] =3D {
>-        =2Eread =3D serial_mm_read,
>-        =2Ewrite =3D serial_mm_write,
>-        =2Eendianness =3D DEVICE_LITTLE_ENDIAN,
>-        =2Evalid=2Emax_access_size =3D 8,
>-        =2Eimpl=2Emax_access_size =3D 8,
>-    },
>-    [DEVICE_BIG_ENDIAN] =3D {
>-        =2Eread =3D serial_mm_read,
>-        =2Ewrite =3D serial_mm_write,
>-        =2Eendianness =3D DEVICE_BIG_ENDIAN,
>-        =2Evalid=2Emax_access_size =3D 8,
>-        =2Eimpl=2Emax_access_size =3D 8,
>-    },
>-};
>-
> static void serial_mm_realize(DeviceState *dev, Error **errp)
> {
>     SerialMM *smm =3D SERIAL_MM(dev);
>@@ -77,9 +39,6 @@ static void serial_mm_realize(DeviceState *dev, Error *=
*errp)
>         return;
>     }
>=20
>-    memory_region_init_io(&s->io, OBJECT(dev),
>-                          &serial_mm_ops[smm->endianness], smm, "serial"=
,
>-                          8 << smm->regshift);
>     sysbus_init_mmio(SYS_BUS_DEVICE(smm), &s->io);
>     sysbus_init_irq(SYS_BUS_DEVICE(smm), &smm->serial=2Eirq);
> }
>@@ -125,20 +84,10 @@ static void serial_mm_instance_init(Object *o)
>     qdev_alias_all_properties(DEVICE(&smm->serial), o);
> }
>=20
>-static const Property serial_mm_properties[] =3D {
>-    /*
>-     * Set the spacing between adjacent memory-mapped UART registers=2E
>-     * Each register will be at (1 << regshift) bytes after the previous=
 one=2E
>-     */
>-    DEFINE_PROP_UINT8("regshift", SerialMM, regshift, 0),
>-    DEFINE_PROP_UINT8("endianness", SerialMM, endianness, DEVICE_NATIVE_=
ENDIAN),
>-};
>-
> static void serial_mm_class_init(ObjectClass *oc, const void *data)
> {
>     DeviceClass *dc =3D DEVICE_CLASS(oc);
>=20
>-    device_class_set_props(dc, serial_mm_properties);
>     dc->realize =3D serial_mm_realize;
>     dc->vmsd =3D &vmstate_serial_mm;
> }
>diff --git a/hw/char/serial-pci-multi=2Ec b/hw/char/serial-pci-multi=2Ec
>index 7782452018=2E=2Eeda0d43bcf 100644
>--- a/hw/char/serial-pci-multi=2Ec
>+++ b/hw/char/serial-pci-multi=2Ec
>@@ -42,7 +42,6 @@ typedef struct PCIMultiSerialState {
>     PCIDevice    dev;
>     MemoryRegion iobar;
>     uint32_t     ports;
>-    char         *name[PCI_SERIAL_MAX_PORTS];
>     SerialState  state[PCI_SERIAL_MAX_PORTS];
>     uint32_t     level[PCI_SERIAL_MAX_PORTS];
>     IRQState     irqs[PCI_SERIAL_MAX_PORTS];
>@@ -58,7 +57,6 @@ static void multi_serial_pci_exit(PCIDevice *dev)
>         s =3D pci->state + i;
>         memory_region_del_subregion(&pci->iobar, &s->io);
>         qdev_unrealize(DEVICE(s));
>-        g_free(pci->name[i]);
>     }
> }
>=20
>@@ -108,9 +106,6 @@ static void multi_serial_pci_realize(PCIDevice *dev, =
Error **errp)
>             return;
>         }
>         s->irq =3D &pci->irqs[i];
>-        pci->name[i] =3D g_strdup_printf("uart #%zu", i + 1);
>-        memory_region_init_io(&s->io, OBJECT(pci), &serial_io_ops, s,
>-                              pci->name[i], 8);
>         memory_region_add_subregion(&pci->iobar, 8 * i, &s->io);
>         pci->ports++;
>     }
>diff --git a/hw/char/serial-pci=2Ec b/hw/char/serial-pci=2Ec
>index d8cacc9085=2E=2E9a0bf2d890 100644
>--- a/hw/char/serial-pci=2Ec
>+++ b/hw/char/serial-pci=2Ec
>@@ -56,7 +56,6 @@ static void serial_pci_realize(PCIDevice *dev, Error **=
errp)
>     pci->dev=2Econfig[PCI_INTERRUPT_PIN] =3D 1;
>     s->irq =3D pci_allocate_irq(&pci->dev);
>=20
>-    memory_region_init_io(&s->io, OBJECT(pci), &serial_io_ops, s, "seria=
l", 8);
>     pci_register_bar(&pci->dev, 0, PCI_BASE_ADDRESS_SPACE_IO, &s->io);
> }
>=20
>diff --git a/hw/char/serial=2Ec b/hw/char/serial=2Ec
>index 0f3469a1e8=2E=2E49227830e1 100644
>--- a/hw/char/serial=2Ec
>+++ b/hw/char/serial=2Ec
>@@ -921,10 +921,67 @@ static int serial_be_change(void *opaque)
>     return 0;
> }
>=20
>+static const MemoryRegionOps serial_io_ops =3D {
>+    =2Eread =3D serial_ioport_read,
>+    =2Ewrite =3D serial_ioport_write,
>+    =2Evalid =3D {
>+        =2Eunaligned =3D 1,
>+    },
>+    =2Eimpl =3D {
>+        =2Emin_access_size =3D 1,
>+        =2Emax_access_size =3D 1,
>+    },
>+    =2Eendianness =3D DEVICE_LITTLE_ENDIAN,
>+};
>+
>+static uint64_t serial_mm_read(void *opaque, hwaddr addr, unsigned size)
>+{
>+    SerialState *s =3D opaque;
>+
>+    return serial_ioport_read(s, addr >> s->regshift, 1);
>+}
>+
>+static void serial_mm_write(void *opaque, hwaddr addr,
>+                            uint64_t value, unsigned size)
>+{
>+    SerialState *s =3D opaque;
>+
>+    serial_ioport_write(s, addr >> s->regshift, value & 0xff, 1);
>+}
>+
>+static const MemoryRegionOps serial_mm_ops[] =3D {
>+    [DEVICE_NATIVE_ENDIAN] =3D {
>+        =2Eread =3D serial_mm_read,
>+        =2Ewrite =3D serial_mm_write,
>+        =2Eendianness =3D DEVICE_NATIVE_ENDIAN,
>+        =2Evalid=2Emax_access_size =3D 8,
>+        =2Eimpl=2Emax_access_size =3D 8,
>+    },
>+    [DEVICE_LITTLE_ENDIAN] =3D {
>+        =2Eread =3D serial_mm_read,
>+        =2Ewrite =3D serial_mm_write,
>+        =2Eendianness =3D DEVICE_LITTLE_ENDIAN,
>+        =2Evalid=2Emax_access_size =3D 8,
>+        =2Eimpl=2Emax_access_size =3D 8,
>+    },
>+    [DEVICE_BIG_ENDIAN] =3D {
>+        =2Eread =3D serial_mm_read,
>+        =2Ewrite =3D serial_mm_write,
>+        =2Eendianness =3D DEVICE_BIG_ENDIAN,
>+        =2Evalid=2Emax_access_size =3D 8,
>+        =2Eimpl=2Emax_access_size =3D 8,
>+    },
>+};
>+
> static void serial_realize(DeviceState *dev, Error **errp)
> {
>     SerialState *s =3D SERIAL(dev);
>=20
>+    memory_region_init_io(&s->io, OBJECT(s),
>+                          s->regshift ? &serial_mm_ops[s->endianness]
>+                                      : &serial_io_ops,
>+                          s, "serial", 8 << s->regshift);
>+
>     s->modem_status_poll =3D timer_new_ns(QEMU_CLOCK_VIRTUAL, (QEMUTimer=
CB *) serial_update_msl, s);
>=20
>     s->fifo_timeout_timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL, (QEMUTime=
rCB *) fifo_timeout_int, s);
>@@ -952,23 +1009,16 @@ static void serial_unrealize(DeviceState *dev)
>     qemu_unregister_reset(serial_reset, s);
> }
>=20
>-const MemoryRegionOps serial_io_ops =3D {
>-    =2Eread =3D serial_ioport_read,
>-    =2Ewrite =3D serial_ioport_write,
>-    =2Evalid =3D {
>-        =2Eunaligned =3D 1,
>-    },
>-    =2Eimpl =3D {
>-        =2Emin_access_size =3D 1,
>-        =2Emax_access_size =3D 1,
>-    },
>-    =2Eendianness =3D DEVICE_LITTLE_ENDIAN,
>-};
>-
> static const Property serial_properties[] =3D {
>     DEFINE_PROP_CHR("chardev", SerialState, chr),
>     DEFINE_PROP_UINT32("baudbase", SerialState, baudbase, 115200),
>     DEFINE_PROP_BOOL("wakeup", SerialState, wakeup, false),
>+    /*
>+     * Set the spacing between adjacent memory-mapped UART registers=2E
>+     * Each register will be at (1 << regshift) bytes after the previous=
 one=2E
>+     */
>+    DEFINE_PROP_UINT8("regshift", SerialState, regshift, 0),
>+    DEFINE_PROP_UINT8("endianness", SerialState, endianness, DEVICE_NATI=
VE_ENDIAN),
> };
>=20
> static void serial_class_init(ObjectClass *klass, const void *data)

