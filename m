Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56037E77184
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 16:24:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOJGh-0003IR-4H; Thu, 19 Dec 2024 11:20:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1tOHKH-00010d-Ls
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 09:16:29 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1tOHKC-0006PL-Pg
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 09:16:29 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-385d7f19f20so427154f8f.1
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 06:16:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734617783; x=1735222583; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xh4y+WQ9eMdjdzRhDj8FZbbXuTTw6o1hds5obhvcwis=;
 b=jhti0eMJG4/TFKHAV73GSyPWZbxRpbEXB+AoVjlfonZA9XG5I9GKFWMycy4hHtzRwp
 0NLXtFdaRMlmVgdYP404YiFYBRTywNfBw5bNSZqSuv268eBObTwOHaGerzAilAEjXqe9
 Gv4pOmmNFrUq1F/eZr0Oj3k9essLYfTokphEn+FZDNQ/yWF2y+VAbI6ATBuySiA7Q5a0
 GjOxtlX31KHeCsvj32ni9IJWttDo88hcYWoXuB3+GnMZg3NQdCd0955xCklroHsKddAC
 c48u3G/3uXTVdW8fCI1pov+se9slRCQY9RMyhWtKb26D/5cKX+opkF4lWQv6v+BGZ3EK
 nTIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734617783; x=1735222583;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xh4y+WQ9eMdjdzRhDj8FZbbXuTTw6o1hds5obhvcwis=;
 b=PNVYFyIXXj/Nn4uRVmh9rLvSUc1D2nanASOsyrgYpQd4cBbhzGSP+vNoTLPxRSqEqP
 9DNyQMwDlun5xro00UMSJztFASJeLU8fBwR61KwWpNVIk28uvjBiu2dA05DAuaP45OfM
 yHXsY61SWxZvBs8dJ/kIIi0RzZwNIwDQAvrAcSswK9h1zbGKWPRqAAIBwJbWUCYxHCyR
 x5g8peD4rymCHgkekEO0oNpVPfjiAaKzc6rMmU6xO9XdL6FwW6ZmlbQIKVz2kN41Lj+l
 nZy034lJyySwVkIEd+nAcvgPzAEjiRdiqG/fT3mKp8LyLD94FzCrmMauVMHPSF4epmwM
 Q+JQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4yIpT8ddJz4hlP199xJuKGHZWe2vPMaptRD8ikibEST/VKI+nayEQno1FbtQo6qnnchUr+Wp/8M0H@nongnu.org
X-Gm-Message-State: AOJu0Yx2b3p9ZLDRCTu+CfE0TNxHt/o/roAHumwwvaOZrpaeVKYW5B63
 ws7ytRG/Xz0S/9eLOmZNcaHLyvN0hPcEhfbJmH7Haqj90+Q6aUpb
X-Gm-Gg: ASbGnctJIq2ol94GLurBj1zJslNLuvikuYzSoLrdMpemFoo9uWbXoNs8cC5jh/QkKlZ
 OdhtnmIDnn6spSYD0PXjmatdKt+/kyni3CwhkCJ+nE/MNfLy5Ye4m1jAAuaKPIYw2ZoTpBaZKFB
 VBL78PxmfRahxZfDdNWIy/ScDsc9FXjgF6GyufivwWIGWW2hnfiipmOlEhcfIesJ3L38G37qZ+C
 DFr3hirY7Opw6T6Fans9ED3lq7SLVGAF9rtoNnky7xikFURcYRmjryeEfbW+LoB9vfLLMeFYrS9
 KP1NWGFQ2D35yumpP5gRawh3JSKWwac=
X-Google-Smtp-Source: AGHT+IHGwuRC6/XDNQlJPXOZ0L/prmw4JG/Sqb+PxdInQ+mfIRwDtNmnOwaZ+i+0Ql8YwjfJ4Y8pMA==
X-Received: by 2002:a5d:47a3:0:b0:385:fb66:faee with SMTP id
 ffacd0b85a97d-388e4d42ce4mr5960163f8f.18.1734617782493; 
 Thu, 19 Dec 2024 06:16:22 -0800 (PST)
Received: from [127.0.0.1] (dynamic-077-191-068-081.77.191.pool.telefonica.de.
 [77.191.68.81]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c89e1cesm1609195f8f.64.2024.12.19.06.16.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Dec 2024 06:16:22 -0800 (PST)
Date: Thu, 19 Dec 2024 14:16:20 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: BALATON Zoltan <balaton@eik.bme.hu>,
 Phil Dennis-Jordan <phil@philjordan.eu>
CC: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_1/2=5D_hw/usb/hcd-xhci-p?=
 =?US-ASCII?Q?ci=3A_Make_PCI_device_more_configurable?=
In-Reply-To: <ba2749f3-8cc4-0ea6-57dd-aa122403b937@eik.bme.hu>
References: <20241212085207.1439501-1-npiggin@gmail.com>
 <20241212085207.1439501-2-npiggin@gmail.com>
 <CAAibmn3NsDewTEFdWoR=VpTRSb5C67bFMYXnf74zBQOwWCLi1Q@mail.gmail.com>
 <D6EFJHL1PDCX.2TZC2E8DZLNU3@gmail.com>
 <CAAibmn3STc4hWJPfDtdp2rDscx_8cO=cO4JA=qhneif03Jf9QA@mail.gmail.com>
 <ba2749f3-8cc4-0ea6-57dd-aa122403b937@eik.bme.hu>
Message-ID: <5FF37BC7-D27E-439C-97CA-D3E397056404@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=shentey@gmail.com; helo=mail-wr1-x434.google.com
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



Am 19=2E Dezember 2024 09:23:13 UTC schrieb BALATON Zoltan <balaton@eik=2E=
bme=2Ehu>:
>On Wed, 18 Dec 2024, Phil Dennis-Jordan wrote:
>> On Wed, 18 Dec 2024 at 02:19, Nicholas Piggin <npiggin@gmail=2Ecom> wro=
te:
>>> On Thu Dec 12, 2024 at 8:41 PM AEST, Phil Dennis-Jordan wrote:
>>>> Hey Nicholas,
>>>>=20
>>>> I'm not an XHCI & PCI expert (yet?) so apologies if I've got some of =
this
>>>> wrong, but I've asked some questions and made some comments inline:
>>>=20
>>> Hey Phil,
>>>=20
>>> Thanks for the review, looks like you are the expert now :)
>>>=20
>>=20
>> The "hot potato" method for determining maintainership=2E :-)
>
>That's how I got some parts I'm maintainer of now=2E :-)
>
>[=2E=2E=2E]
>>>> On Thu, 12 Dec 2024 at 09:52, Nicholas Piggin <npiggin@gmail=2Ecom> w=
rote:
>>>> Surely we should only propagate the error and fail realize() iff s->m=
six
>>> is
>>>> ON_OFF_AUTO_ON?
>>>>=20
>>>> For ON_OFF_AUTO_AUTO, msix_init returning failure isn't a critical er=
ror=2E
>>>=20
>>> Yep you're right=2E=2E=2E you had been testing with msix disabled=2E I=
 wonder if
>>> there is a good way to force fail this in qtests?
>>>=20
>>=20
>> I'm really the wrong person to ask about qtest, I'm only just beginning=
 to
>> get to grips with it=2E It seems the only real reason msix_init fails o=
ther
>> than misconfiguration of the device/BAR is when msi_nonbroken =3D false=
=2E
>>=20
>> At least on x86(-64), msi_nonbroken=3Dtrue is unconditionally set in
>> apic_realize()=2E (I think real hardware would not support MSI(-X) on t=
he
>> i440FX chipset - I was fairly certain it was the PCI root/southbridge
>> catching the writes to the reserved memory region, and I didn't think t=
he
>> PIIX did this; but at least in QEMU it doesn't seem to be implemented i=
n a
>> chipset-dependent way=2E) I'm not sure it's possible to run QEMU withou=
t an
>> APIC?
>
>There's isapc but you can't attach PCI card to that=2E It seems according=
 to -machine pc,help that there's a PIC=3D<OnOffAuto> option but no similar=
 for APIC=2E Maybe that could be added but not sure it would work=2E (Addin=
g Bernhard to cc to quickly pass on the potato=2E)

I agree, the only x86 machine with no APIC is the isapc machine=2E All oth=
ers (i440fx, q35, microvm) have it always enabled=2E I guess there is just =
no point in disabling it since the APIC is part of the architecture for age=
s and SMP requires it=2E Although PIIX3+ didn't have an APIC built-in it ha=
d interfaces for handling a dedicated one which is basically what QEMU emul=
ates=2E

Best regards,
Bernhard

>
>Regards,
>BALATON Zoltan
>
>> On aarch64, the GICv3 needs to explicitly enable support (via the ITS),=
 so
>> perhaps it's possible to set up an aarch64 qtest with ITS disabled? It
>> looks like the 'virt' machine type only supports the ITS from version 6=
=2E2,
>> so older versions will disable it=2E
>>=20
>> Sorry, clutching at straws here=2E
>>=20
>>=20
>>>>> +
>>>>> +        pci_register_bar(dev, s->msix_bar_nr,
>>>>> +                         PCI_BASE_ADDRESS_SPACE_MEMORY |
>>>>> +                         PCI_BASE_ADDRESS_MEM_TYPE_64,
>>>>> +                         msix_bar);
>>>>>=20
>>>>=20
>>>> Is it safe to call pci_register_bar() again for the msix_bar_nr =3D 0=
 case?
>>>> Even if it is safe, is it sensible? If we're calling it twice for the
>>> same
>>>> BAR, and the arguments of either of the calls changes in future, the
>>> other
>>>> needs to change too=2E Doesn't seem ideal=2E
>>>=20
>>> Good catch=2E It looks like it "works" so long as the bar wasn't mappe=
d,
>>> but I'm sure bad practice=2E=2E=2E Interesting there is no assertion i=
n
>>> there though=2E I'll fix it though=2E
>>>=20
>>=20
>> I notice there's a msix_init_exclusive_bar()=E2=80=A6 I wonder if it'd =
be simpler
>> to use that and modify it so it allows you to choose a size and layout =
for
>> the BAR, rather than adding all that extra code to deal with the extra =
BAR
>> in the XHCI?
>> (It already calls pci_register_bar() and msix_init() internally, but se=
ems
>> to set the BAR's size to 4096 and places the PBA at halfway through the
>> BAR=2E Perhaps rename it to something like
>> msix_init_exclusive_bar_with_layout and pass the bar_size and
>> bar_pba_offset in as parameters; then make msix_init_exclusive_bar() a
>> wrapper for that function with the existing defaults for those variable=
s?)
>>=20
>> Just kicking around some ideas here, I have no idea if that actually en=
ds
>> up making things simpler=E2=80=A6
>>=20
>>=20
>>> Thanks,
>>> Nick
>>>=20
>> 

