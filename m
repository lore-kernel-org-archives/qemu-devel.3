Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F20FC30658
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 21:18:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOksM-0007ck-0L; Tue, 02 Jul 2024 17:17:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1sOksK-0007cS-JE
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 17:17:20 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1sOksH-0004Ve-Uk
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 17:17:20 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-57cbc2a2496so2335360a12.0
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 14:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719955034; x=1720559834; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xWB8oMPxB4ELkK7X+fVB430E4v/2SFt1bC4oRUP3qBU=;
 b=OPQWQ2tfQveBhWHHokjXS8jJEZLNjIMKXwqtPoaAHDZ8rUHpvFsvVveFsKrUzFzeSU
 KADV6F8DW7EgZdZO+sCrmmCyJ15+eBL4b9vnIBHUGYd4Qv3OF7BUSCyseu7/K7T5YCvi
 eMI3PPS5pwMvz+u61WAK8rJOIzG8nl54TwLdP/k3l9Sxlla862RrzAg6/gxo084Vj8QT
 1ni//3kSzMQJxS4EE6PaM+fwD/jEzE52w+muSURIKlitq92uvwrjb7xbZPVqFsWD7BkI
 xjykw17aUeW31PC4vEYuadgMQvCqeoXT5TEH1b/VMKe+eXLzw0ZMKGGutfgENGO/f0FF
 uZ6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719955034; x=1720559834;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xWB8oMPxB4ELkK7X+fVB430E4v/2SFt1bC4oRUP3qBU=;
 b=fC+Uds6rH/hGzBGgwkB1SFG2+xPSkfeV6Hlm5b6IqkEAm7TmT20+feExK1y7EGz6cH
 HQR1XPkr7F9RwDheqSdQPC7nRzUoz21v07ZTS9g8EuRGwV/4Rumn14eVpxegXLSj4gw7
 nXGq0x1e7JCh27iz4+1DzMK/5CdM08EbGvaf8iHu13rZkdkPs/inC2hFLHkt+grYykk+
 LvzvmPd/RKaEy8r+tHBgXY7MlsNBnOT8rk3olkfpg4Rc6gNr/9J8jfV81unj58I4vV4K
 ePX1NOKPFncqZRELKmsquGKdlYCeKrHKnZExBOkR4dCIo29eQcELh/x73TgHHR8HJYtk
 YPxQ==
X-Gm-Message-State: AOJu0YwRSUjvhbg0xGPmEMxb4VrtFqMxpxxapHt+mqLV8T4iKm10VSR7
 q/ZntviYyybXdBesc3se9ioqjqhLqePnRR0ju92EAIUuAiuqZUlbH67D7Q==
X-Google-Smtp-Source: AGHT+IEJVrTTpmYcOh3k1ff7gbQmjvhW3QcotWlD6/6zyhVOFztCbH3p2HQj1rF0L7rp/L+tHyM/5g==
X-Received: by 2002:a17:906:e0d9:b0:a72:b2a4:e207 with SMTP id
 a640c23a62f3a-a751449fc3bmr705983866b.45.1719955034347; 
 Tue, 02 Jul 2024 14:17:14 -0700 (PDT)
Received: from [127.0.0.1] (dynamic-077-011-043-115.77.11.pool.telefonica.de.
 [77.11.43.115]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a72aaf633desm452288366b.73.2024.07.02.14.17.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Jul 2024 14:17:13 -0700 (PDT)
Date: Tue, 02 Jul 2024 21:17:12 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>
CC: philmd@linaro.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_2/2=5D_hw/isa/vt82c686=2Ec=3A_Embed_i82?=
 =?US-ASCII?Q?59_irq_in_device_state_instead_of_allocating?=
In-Reply-To: <4CBF639B-CC3E-4644-9F87-481B9147F2A9@gmail.com>
References: <cover.1719690591.git.balaton@eik.bme.hu>
 <b70b9e72063b4dd4005bf4bc040b84f2bb617bf4.1719690591.git.balaton@eik.bme.hu>
 <CAFEAcA_tBjQrJMpjbzVUVcrTWghr4v=MHB0qpWx=xjML6ek9mg@mail.gmail.com>
 <4CBF639B-CC3E-4644-9F87-481B9147F2A9@gmail.com>
Message-ID: <00311AC8-D02C-4C3A-85A7-8FB3B51DDE9C@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x52a.google.com
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



Am 2=2E Juli 2024 18:42:23 UTC schrieb Bernhard Beschow <shentey@gmail=2Ec=
om>:
>
>
>Am 1=2E Juli 2024 12:58:15 UTC schrieb Peter Maydell <peter=2Emaydell@lin=
aro=2Eorg>:
>>On Sat, 29 Jun 2024 at 21:01, BALATON Zoltan <balaton@eik=2Ebme=2Ehu> wr=
ote:
>>>
>>> To avoid a warning about unfreed qemu_irq embed the i8259 irq in the
>>> device state instead of allocating it=2E
>>>
>>> Signed-off-by: BALATON Zoltan <balaton@eik=2Ebme=2Ehu>
>>> ---
>>>  hw/isa/vt82c686=2Ec | 7 ++++---
>>>  1 file changed, 4 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/hw/isa/vt82c686=2Ec b/hw/isa/vt82c686=2Ec
>>> index 8582ac0322=2E=2E834051abeb 100644
>>> --- a/hw/isa/vt82c686=2Ec
>>> +++ b/hw/isa/vt82c686=2Ec
>>> @@ -592,6 +592,8 @@ OBJECT_DECLARE_SIMPLE_TYPE(ViaISAState, VIA_ISA)
>>>
>>>  struct ViaISAState {
>>>      PCIDevice dev;
>>> +
>>> +    IRQState i8259_irq;
>>>      qemu_irq cpu_intr;
>>>      qemu_irq *isa_irqs_in;
>>>      uint16_t irq_state[ISA_NUM_IRQS];
>>> @@ -715,13 +717,12 @@ static void via_isa_realize(PCIDevice *d, Error =
**errp)
>>>      ViaISAState *s =3D VIA_ISA(d);
>>>      DeviceState *dev =3D DEVICE(d);
>>>      PCIBus *pci_bus =3D pci_get_bus(d);
>>> -    qemu_irq *isa_irq;
>>>      ISABus *isa_bus;
>>>      int i;
>>>
>>>      qdev_init_gpio_out(dev, &s->cpu_intr, 1);
>>>      qdev_init_gpio_in_named(dev, via_isa_pirq, "pirq", PCI_NUM_PINS);
>>> -    isa_irq =3D qemu_allocate_irqs(via_isa_request_i8259_irq, s, 1);
>>> +    qemu_init_irq(&s->i8259_irq, via_isa_request_i8259_irq, s, 0);
>>>      isa_bus =3D isa_bus_new(dev, pci_address_space(d), pci_address_sp=
ace_io(d),
>>>                            errp);
>>
>>So if I understand correctly, this IRQ line isn't visible
>>from outside this chip,
>
>Actally it is, in the form of the INTR pin=2E Assuming similar naming con=
ventions in vt82xx and piix, one can confirm this by consulting the piix4 d=
atasheet, "Figure 5=2E Interrupt Controller Block Diagram"=2E Moreover, the=
 pegasos2 schematics (linked in the QEMU documentation) suggest that this p=
in is actually used there, although not modeled in QEMU=2E

Well, QEMU does actually wire the intr pin in the pegasos2 board code, exc=
ept that it isn't a named gpio like in piix4=2E If we allow this pin to be =
wired before the south bridge's realize we might be able to eliminate the "=
intermediate irq forwarder" as Phil used to name it, resulting in less and =
more efficient code=2E This solution would basically follow the pattern I o=
utlined under below link=2E

Best regards,
Bernhard

> Compare this to how the "intr" pin is exposed by the piix4 device model =
and wired in the Malta board=2E
>
>> we're just trying to wire together
>>two internal components of the chip? If so, I agree that
>>this seems a better way than creating a named GPIO that
>>we then have to document as a "not really an external
>>connection, don't try to use this" line=2E (We've done that
>>before I think in other devices, and it works but it's
>>a bit odd-looking=2E)
>>
>>That said, I do notice that the via_isa_request_i8259_irq()
>>function doesn't do anything except pass the level onto
>>another qemu_irq, so I think the theoretical ideal would be
>>if we could arrange to plumb things directly through rather
>>than needing this extra qemu_irq and function=2E There's
>>probably a reason (order of device creation/connection?)
>>that doesn't work though=2E
>
>I think there could be a general pattern of device creation/connection wh=
ich I've outlined here: https://lore=2Ekernel=2Eorg/qemu-devel/0FFB5FD2-08C=
E-4CEC-9001-E7AC24407A44@gmail=2Ecom/
>
>Best regards,
>Bernhard
>
>>
>>-- PMM
>>

