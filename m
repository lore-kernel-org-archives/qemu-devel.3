Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8198C30653
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 21:07:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPTfC-0006Xb-59; Thu, 04 Jul 2024 17:06:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1sPTfA-0006V6-Ha
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 17:06:44 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1sPTf8-0007Ws-F0
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 17:06:44 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-57cbc66a0a6so1780137a12.1
 for <qemu-devel@nongnu.org>; Thu, 04 Jul 2024 14:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720127199; x=1720731999; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lwddYItCT82VQZGmH5vkpRu4iOBj1LGve7vBI/wi1Io=;
 b=NgBVBfAuJX9NJMPi+cY1WMbr+u96HjcY+xQv4rjoHtI5JVMCKwxjQWbO2v7HytM7Uo
 68yVLWtJ13ycflBO+lWgYklKWf7SiRfMW0zqD3hqHvo8KDEBOjmvGwHIf7H+Vog1rpnd
 28gXAaZ4Kl0z1wCtdY9hSowpFnZbxaksFmsL2MvMMPzzIkcAOsFao2VK8albVHb2gWlO
 KVbxBSmS1mBrq3M1WobJmdorMx4/2jKnc5OfeOrN/dTdnuHeoNn22bsaeHMYFfDhNnH1
 MsECYD5saOwOs4OhNOMxGdDskAK3zE518z5zmUFx41F6jgn4CfnlqmTmbRXS3XiwpXQD
 xrqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720127199; x=1720731999;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lwddYItCT82VQZGmH5vkpRu4iOBj1LGve7vBI/wi1Io=;
 b=fx3ipEKxGLAGpSvfCET5vsa27smGshhxlcz/DCiJlsXvkp1rzhBMgki3FgPz0iOPyW
 8cnogxKmrb9hs7EOMVwvW16pl5BSBtjRjEOFZqtQ9ZV3cXlWVtoYL03jtQB9UR/ZPbws
 EzNZsB+WxIdhgmlEE32MFTXMDtesXdFHGlEx15nPQdj1MtOV9MpTSsOPK23dykP6pOPi
 lTW9liS8BM+kt/emV+oA//l07RHgbgEAKbN9mXHDiR+3sSopSPqyze5nIFRGr8z8VSWm
 Kkcp5m9Mrxw6Reh6V1mQIVMNz8wbxdDMzEsF25LdfVRDvK1bL/Or4LVrr0syg4Yk+CYl
 0nsQ==
X-Gm-Message-State: AOJu0Yw63Q63uzdsaq1BJSz4KkdBd0hHwDWZ/gDhtDyUTCU6SHkej2cA
 2fhHYv+453oFL8PKcgTpUs1wfyJadOpCoFvhJzJcHfIaHuFhLbBr
X-Google-Smtp-Source: AGHT+IH5nuWpxdUF9o3wayaqi3wvukvsGnqUlFC42f48mCmrTqPetukMxwyOuoqyhS3lQbjp9VDQlQ==
X-Received: by 2002:a05:6402:5202:b0:58c:36e:51bf with SMTP id
 4fb4d7f45d1cf-58e7a74c721mr2201817a12.3.1720127199290; 
 Thu, 04 Jul 2024 14:06:39 -0700 (PDT)
Received: from [127.0.0.1] (dynamic-077-188-087-180.77.188.pool.telefonica.de.
 [77.188.87.180]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-58612c835c4sm8862170a12.11.2024.07.04.14.06.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Jul 2024 14:06:38 -0700 (PDT)
Date: Thu, 04 Jul 2024 21:06:36 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
CC: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 philmd@linaro.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_2/2=5D_hw/isa/vt82c686=2Ec=3A_Embed_i82?=
 =?US-ASCII?Q?59_irq_in_device_state_instead_of_allocating?=
In-Reply-To: <4aa99879-7769-29a4-67f4-236dfa24299a@eik.bme.hu>
References: <cover.1719690591.git.balaton@eik.bme.hu>
 <b70b9e72063b4dd4005bf4bc040b84f2bb617bf4.1719690591.git.balaton@eik.bme.hu>
 <CAFEAcA_tBjQrJMpjbzVUVcrTWghr4v=MHB0qpWx=xjML6ek9mg@mail.gmail.com>
 <4CBF639B-CC3E-4644-9F87-481B9147F2A9@gmail.com>
 <00311AC8-D02C-4C3A-85A7-8FB3B51DDE9C@gmail.com>
 <cf46b29f-b36f-37b8-373f-72ad487ee749@eik.bme.hu>
 <69FF1605-8E74-44CA-BE43-8D85AAC89EBE@gmail.com>
 <4aa99879-7769-29a4-67f4-236dfa24299a@eik.bme.hu>
Message-ID: <07E1F496-C129-4E24-AA20-D650080B5B78@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x52b.google.com
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



Am 3=2E Juli 2024 11:13:08 UTC schrieb BALATON Zoltan <balaton@eik=2Ebme=
=2Ehu>:
>On Wed, 3 Jul 2024, Bernhard Beschow wrote:
>> Am 3=2E Juli 2024 00:09:45 UTC schrieb BALATON Zoltan <balaton@eik=2Ebm=
e=2Ehu>:
>>> On Tue, 2 Jul 2024, Bernhard Beschow wrote:
>>>> Am 2=2E Juli 2024 18:42:23 UTC schrieb Bernhard Beschow <shentey@gmai=
l=2Ecom>:
>>>>> Am 1=2E Juli 2024 12:58:15 UTC schrieb Peter Maydell <peter=2Emaydel=
l@linaro=2Eorg>:
>>>>>> On Sat, 29 Jun 2024 at 21:01, BALATON Zoltan <balaton@eik=2Ebme=2Eh=
u> wrote:
>>>>>>>=20
>>>>>>> To avoid a warning about unfreed qemu_irq embed the i8259 irq in t=
he
>>>>>>> device state instead of allocating it=2E
>>>>>>>=20
>>>>>>> Signed-off-by: BALATON Zoltan <balaton@eik=2Ebme=2Ehu>
>>>>>>> ---
>>>>>>>  hw/isa/vt82c686=2Ec | 7 ++++---
>>>>>>>  1 file changed, 4 insertions(+), 3 deletions(-)
>>>>>>>=20
>>>>>>> diff --git a/hw/isa/vt82c686=2Ec b/hw/isa/vt82c686=2Ec
>>>>>>> index 8582ac0322=2E=2E834051abeb 100644
>>>>>>> --- a/hw/isa/vt82c686=2Ec
>>>>>>> +++ b/hw/isa/vt82c686=2Ec
>>>>>>> @@ -592,6 +592,8 @@ OBJECT_DECLARE_SIMPLE_TYPE(ViaISAState, VIA_IS=
A)
>>>>>>>=20
>>>>>>>  struct ViaISAState {
>>>>>>>      PCIDevice dev;
>>>>>>> +
>>>>>>> +    IRQState i8259_irq;
>>>>>>>      qemu_irq cpu_intr;
>>>>>>>      qemu_irq *isa_irqs_in;
>>>>>>>      uint16_t irq_state[ISA_NUM_IRQS];
>>>>>>> @@ -715,13 +717,12 @@ static void via_isa_realize(PCIDevice *d, Er=
ror **errp)
>>>>>>>      ViaISAState *s =3D VIA_ISA(d);
>>>>>>>      DeviceState *dev =3D DEVICE(d);
>>>>>>>      PCIBus *pci_bus =3D pci_get_bus(d);
>>>>>>> -    qemu_irq *isa_irq;
>>>>>>>      ISABus *isa_bus;
>>>>>>>      int i;
>>>>>>>=20
>>>>>>>      qdev_init_gpio_out(dev, &s->cpu_intr, 1);
>>>>>>>      qdev_init_gpio_in_named(dev, via_isa_pirq, "pirq", PCI_NUM_PI=
NS);
>>>>>>> -    isa_irq =3D qemu_allocate_irqs(via_isa_request_i8259_irq, s, =
1);
>>>>>>> +    qemu_init_irq(&s->i8259_irq, via_isa_request_i8259_irq, s, 0)=
;
>>>>>>>      isa_bus =3D isa_bus_new(dev, pci_address_space(d), pci_addres=
s_space_io(d),
>>>>>>>                            errp);
>>>>>>=20
>>>>>> So if I understand correctly, this IRQ line isn't visible
>>>>>> from outside this chip,
>>>>>=20
>>>>> Actally it is, in the form of the INTR pin=2E Assuming similar namin=
g
>>>=20
>>> The INTR pin corresponds to qemu_irq cpu_intr not the i8259_irq=2E
>>>=20
>>>>> conventions in vt82xx and piix, one can confirm this by consulting t=
he piix4 datasheet, "Figure 5=2E Interrupt Controller Block Diagram"=2E Mor=
eover, the pegasos2 schematics (linked in the QEMU documentation) suggest t=
hat this pin is actually used there, although not modeled in QEMU=2E
>>>>=20
>>>> Well, QEMU does actually wire the intr pin in the pegasos2 board code=
, except that it isn't a named gpio like in piix4=2E If we allow this pin t=
o
>>>=20
>>> I could make that named to make it clearer, now it's the only output g=
pio so did not name it as usually devices that only have one output don't u=
se named gpios for that=2E
>>>=20
>>>> be wired before the south bridge's realize we might be able to elimin=
ate the "intermediate irq forwarder" as Phil used to name it, resulting in =
less and more efficient code=2E This solution would basically follow the pa=
ttern I outlined under below link=2E
>>>=20
>>> I think the problem here is that i8259 does not provide an output gpio=
 for this interrupt that the VT82xx could pass on but instead i8259_init() =
needs a qemu_irq to be passed rhat the i8259 model will set=2E This seems t=
o be a legacy init function so the fix may be to Qdev-ify i8259 and add an =
output irq to it then its users could instantiate and connect its IRQs as u=
sual and we don't need to create a qemu_irq to pass it to i8259_init()=2E
>>=20
>> I've implemented the approach avoiding the intermediate IRQ forwarders =
here: https://github=2Ecom/shentok/qemu/commits/upstream/vt82c686-irq/ =2E =
I'd send this series to the list as soon as I resolve some email authentica=
tion issues=2E
>
>This connects the gpio out before the device is realized=2E I don't think=
 that's the right fix and confuses all the users of this device as they wil=
l need to remember to do this=2E I think the current interrupt forwarder is=
 OK until i8259 is Qdev-ified and solves this within the device=2E I'm OK w=
ith the patch that makes intr named if you can submit just that=2E

I've now sent a series with naming the gpio as the first patch: https://lo=
re=2Ekernel=2Eorg/qemu-devel/20240704205854=2E18537-1-shentey@gmail=2Ecom/

Best regards,
Bernhard

>
>Regards,
>BALATON Zoltan

