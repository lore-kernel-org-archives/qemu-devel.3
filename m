Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 929D6C3065C
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 19:24:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOj5s-0004P3-9d; Tue, 02 Jul 2024 15:23:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1sOj5l-0004OP-S1
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 15:23:06 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1sOj5j-0004qh-Dx
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 15:23:05 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a724958f118so562004166b.0
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 12:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719948179; x=1720552979; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=roQAYaU5u8pGXhgLEGBOrwEkNMr6egEYTbUzR2Ov4zA=;
 b=TvyFD3NyQyBbjYy8CnjYLFUnj8CQRgXDKxL1+oTzJkfQECDEpnwWo6jDZNyaA/2oSN
 M/oUy/1wUaTfyQadiTqxagy33lcjgAXG91ae0t4a2MClVb24xYmZJ2VKnw2cF0blLyon
 Lur3nRSxj0N4kc7Dp/0hXVgj9MiJKrfdytm+ShMVuweeJAO41R0lErpt91fGxxQZ8c7w
 MIxCh003fMb6e8kk18sTk2vdkqhJlAqQoSI8kADKzHArYhOjSzPoTFTquVFYKPrwH8iY
 7G/8PCKGlt8PXLV1orXsgiIwNhzBnsXeFuTyXm9AqAEbBBk3nebiaV/U7O1z6IOg+5Nt
 kxNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719948179; x=1720552979;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=roQAYaU5u8pGXhgLEGBOrwEkNMr6egEYTbUzR2Ov4zA=;
 b=mJJ1GnFOYv9Q9OVEUY2yD9VX5MEau7YCIwsZUVegFlGtF0olNpWRXY5jYSguwJ3QEx
 QvcxOdVJa3LhsdflVzs9HRrPYBz0Tnq1DWpEVgJHsaEhXfSwE5Indgd1K2D6LdxeZoGr
 aWAsFv9oYswvF2HPZkO4k6/W2JLhK2MopRzSP+WXKhU6CpOsldv0/WCMhg4AjctuIHmc
 YkIc7Di1fNb2B9Jgc8YTE//tBUF+lRkyUGauB97V87c5IahsM/7F2LFtMOvKsZToP+DW
 UmlsYAIAZ/BU9H9OOn8qpaq/bgpIov/fq9TT4qc3Drntymr0UTM7hVRVi1u1KZqz26JJ
 MR8Q==
X-Gm-Message-State: AOJu0YxycNUzEPJTpvs4ZyxFHmBGr++xPYC5JLU1dypIHr6RqIsRBWhd
 Lt/FPjW3PEGm+VbWZGqcAIfUUPid3WcciNxltqXwv6bimwkrAjMvWFQ8Bw==
X-Google-Smtp-Source: AGHT+IHr0WCL7pRtb/VDUBYxpdtnERd5a2gCt84IJORByTeMHyCSdfNTgv0Dui1qUlXRoADR8gI5iw==
X-Received: by 2002:a17:906:5944:b0:a6f:e8a3:7d4a with SMTP id
 a640c23a62f3a-a7514454653mr608654366b.24.1719948178317; 
 Tue, 02 Jul 2024 12:22:58 -0700 (PDT)
Received: from [127.0.0.1] (dynamic-077-011-043-115.77.11.pool.telefonica.de.
 [77.11.43.115]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a72ab08d138sm445734266b.158.2024.07.02.12.22.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Jul 2024 12:22:57 -0700 (PDT)
Date: Tue, 02 Jul 2024 18:44:31 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org, BALATON Zoltan <balaton@eik.bme.hu>
CC: philmd@linaro.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_2/2=5D_hw/isa/vt82c686=2Ec=3A_Embed_i82?=
 =?US-ASCII?Q?59_irq_in_device_state_instead_of_allocating?=
In-Reply-To: <b70b9e72063b4dd4005bf4bc040b84f2bb617bf4.1719690591.git.balaton@eik.bme.hu>
References: <cover.1719690591.git.balaton@eik.bme.hu>
 <b70b9e72063b4dd4005bf4bc040b84f2bb617bf4.1719690591.git.balaton@eik.bme.hu>
Message-ID: <537D3F52-CC8C-49D0-A134-746672442125@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x631.google.com
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



Am 29=2E Juni 2024 20:01:54 UTC schrieb BALATON Zoltan <balaton@eik=2Ebme=
=2Ehu>:
>To avoid a warning about unfreed qemu_irq embed the i8259 irq in the
>device state instead of allocating it=2E
>
>Signed-off-by: BALATON Zoltan <balaton@eik=2Ebme=2Ehu>
>---
> hw/isa/vt82c686=2Ec | 7 ++++---
> 1 file changed, 4 insertions(+), 3 deletions(-)
>
>diff --git a/hw/isa/vt82c686=2Ec b/hw/isa/vt82c686=2Ec
>index 8582ac0322=2E=2E834051abeb 100644
>--- a/hw/isa/vt82c686=2Ec
>+++ b/hw/isa/vt82c686=2Ec
>@@ -592,6 +592,8 @@ OBJECT_DECLARE_SIMPLE_TYPE(ViaISAState, VIA_ISA)
>=20
> struct ViaISAState {
>     PCIDevice dev;
>+
>+    IRQState i8259_irq;

Rename s/i8259/intr/ to match the pin name of the chip? Same for commit me=
ssage and subject=2E

For consistency with piix4 it might be cleaner to export the pin=2E Though=
 not need at the moment since it has no users=2E

With the renaming applied:
Reviewed-by: Bernhard Beschow <shentey@gmail=2Ecom>

>     qemu_irq cpu_intr;
>     qemu_irq *isa_irqs_in;
>     uint16_t irq_state[ISA_NUM_IRQS];
>@@ -715,13 +717,12 @@ static void via_isa_realize(PCIDevice *d, Error **e=
rrp)
>     ViaISAState *s =3D VIA_ISA(d);
>     DeviceState *dev =3D DEVICE(d);
>     PCIBus *pci_bus =3D pci_get_bus(d);
>-    qemu_irq *isa_irq;
>     ISABus *isa_bus;
>     int i;
>=20
>     qdev_init_gpio_out(dev, &s->cpu_intr, 1);
>     qdev_init_gpio_in_named(dev, via_isa_pirq, "pirq", PCI_NUM_PINS);
>-    isa_irq =3D qemu_allocate_irqs(via_isa_request_i8259_irq, s, 1);
>+    qemu_init_irq(&s->i8259_irq, via_isa_request_i8259_irq, s, 0);
>     isa_bus =3D isa_bus_new(dev, pci_address_space(d), pci_address_space=
_io(d),
>                           errp);
>=20
>@@ -729,7 +730,7 @@ static void via_isa_realize(PCIDevice *d, Error **err=
p)
>         return;
>     }
>=20
>-    s->isa_irqs_in =3D i8259_init(isa_bus, *isa_irq);
>+    s->isa_irqs_in =3D i8259_init(isa_bus, &s->i8259_irq);
>     isa_bus_register_input_irqs(isa_bus, s->isa_irqs_in);
>     i8254_pit_init(isa_bus, 0x40, 0, NULL);
>     i8257_dma_init(OBJECT(d), isa_bus, 0);

