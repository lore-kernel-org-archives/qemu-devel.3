Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E34F2EFD20F
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 08:57:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvAhT-0004Pu-1n; Wed, 25 Feb 2026 03:56:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1vvAhL-0004Ov-12
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 03:56:48 -0500
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1vvAhD-0008Di-3y
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 03:56:46 -0500
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-65b9d8d6b7dso9214293a12.2
 for <qemu-devel@nongnu.org>; Wed, 25 Feb 2026 00:56:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772009795; cv=none;
 d=google.com; s=arc-20240605;
 b=W1VB4We9TOhFzKmT8alqsD7zk6X0eBC6E4BhJcIceOKO/4vznZTB3GJ19PibDLDkpX
 wF+/ZQ+P6ZG6LrUKDZcjKHVgRo6wyIwQsLeVsYLJC1C3waywu+aCJEd7T7jOBtLZw1LT
 klPhUvD4zOsqAOdqDik+rifEQZylc/oBB3YXOIfMrhdWzev16ZRKTJz3S5OPSxBzkNOf
 ZWI9fhMzxG/VFhtTAcI+zmnEM9yHOPcE/5j0vvtjhyWZduB17x628RwW7yyEg7RpotPd
 INMzB2N+8auee9txBNBq12+NLrDeHVE6myIOYjrlD3373EmuOWjTk6QMLtfKvB8pechv
 xjlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=UzgX8BKWZ1Pr8gzuAA9LuDd0oMCO9HAKIWfwMvDjoKU=;
 fh=41D+QBSLo5XO1AlGttJU47CNS0Y+tRrMa3eS+PtqSz8=;
 b=d0BONIkwwBwlK+cnZsJ/BlFWrUZxamr3dxb95RsLwFEgidpb2APcFW4hKKM0qLMF6j
 OZD6mQl+WHWmNsafluBkG491VV3M2AmcGhDo/nqdJkvxI3NQiE4dj39CI+3NOP0mI+Cx
 lrwqFjKH0WHXetI9SwOatqAEhS3KT12ILhAAj3HvbPB7tQz6PO+hpziUclfSQ1K1uqaV
 Svu2/5HhfkASOl/P97G7zx6WgboAwBBih1QuAR5+cshFyG7RUeG/exuAAZ6DbW3krwoi
 8i8ExYHx0azlg0j8iAJfaw1u6nnIKotPhyZ6QXPMW73IY/Ne3iOWPqFJyryqmixz6Y3O
 EOOw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772009795; x=1772614595; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UzgX8BKWZ1Pr8gzuAA9LuDd0oMCO9HAKIWfwMvDjoKU=;
 b=IDpqyzDusfGv50cPvXVAGT26dIoMMYDJLpUqQ0aTv1/unL+hqsK1RbeOBDU0yVeeYB
 7fMorPs9+fm2eGM2rsshZ7VFfotVJBl6pRqTshMX4kDC64ipMFgTjtAUFfYUCVCpStnq
 rXCmbVqjeWpl5U1bPxwrgQu0zVenUoTG8B3lpeT4dNlFpaZj1hlxBAKHRHPqtfe6iSdr
 B9y1kNHH4Z/GjBXx+AqO3zRk6+QOuK8oKDQJTYWHFlkgmeiVtNtxlFgS/V2hGPQ9BsbF
 uMHXo5+WP0aZhJLI378oiKEL/M4Lua+68IQFFg/NTEs+YWEBN8oUfRIZA2z02bP5mPca
 U5lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772009795; x=1772614595;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UzgX8BKWZ1Pr8gzuAA9LuDd0oMCO9HAKIWfwMvDjoKU=;
 b=ARL3VDy81Rf02vE60r6yquX5pEaAMIQlDuAP0HzXAaiJ6qo2fa1OCf8mTba4FIVqtL
 xB0VxJoBbQzqJPkZPjskVTWn5duyss7thPbQ+hQew7Rv+4VdtzkQIycgq9N/di2GaYtU
 AaIJpHGCaxScZWaIHsRTLICF8cxUR9Bj4u0trzvv3VD97BIeGGNAABFDutn6kTeaIP75
 hlnn4hoInstTmOnWyEv8u1mHt3QALP/lLDKvmlIyWQ1wcj071bvLWmC32a1x0yRwwP6Q
 GWcNSFbNFG8ZLBjf3XdlVy/GJExUu/3ACjtmFzL3TsBGiLwAvnzjp20uAy6PYssBP0nZ
 ixpQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWqLrXMX87Fhnw/5LxstbjpWfLADzWiNWQBNLnKCIDAGLN3DfPoPQGWEwPKrFKhT003M9xWswo4Wis+@nongnu.org
X-Gm-Message-State: AOJu0YwbC6I+wMeIu9t11tDD0/AA9XYA4nMNP3JI5Ksf133/Vyv4sGBB
 X6Tvqoi6KSdLIrUhopHIvbieCGVHhlLYAS7lupz9U9qX+FwPxw7VECtpKjIdObJ3tcJ10xIcbOS
 7WnV2UNsQaUaA4oItN2UtYHiXH04xTko=
X-Gm-Gg: ATEYQzyAvp5tDjsicV3Oe3AQp5pP6r9cb4QXb8n/zJeai7Q4fbN8TLK+mG+6A09haEM
 mQTTE6j1howp2Lsr4CpuuLpJ88u11MsnRrgZ3Tj3H0G+P8NrcBjXVlYYEQ7/mLNizB5PqdD7DN8
 AZywD1vwLXKu+ZEGWKuRSeNfkO5WcIJyf5fhcJR4VCQU8Kb3ihmU0cbcFyAxoZ3rBbcLhoy7WLf
 /xTXg5/NTJ9nj8g3V+siCh0G7guPuSgsWfWpSy48AfKEWZwfY/DVuFmTDev3nscTzq+FlXrymc7
 E0xWYdxA
X-Received: by 2002:a05:6402:f23:b0:65f:88f7:da0 with SMTP id
 4fb4d7f45d1cf-65f88f7101dmr849718a12.15.1772009794357; Wed, 25 Feb 2026
 00:56:34 -0800 (PST)
MIME-Version: 1.0
References: <20260219143332.3316679-1-ruslichenko.r@gmail.com>
 <20260219144901.3317747-1-ruslichenko.r@gmail.com>
 <dd8a92cc-51d6-4404-bd09-75b1798f925a@redhat.com>
 <87y0kj4mr3.fsf@draig.linaro.org>
 <CAN-aV1H0_4LviryDEmDSN0TfdSit-uN31H8g87sRBkJAHYbrdQ@mail.gmail.com>
 <d2d16e2b-d86a-633f-b32a-e063746658d8@eik.bme.hu>
 <CAN-aV1Ezvu1VnQJYiMDrNceaRAG32-DKtV85v2w58R4bpkL=KA@mail.gmail.com>
 <0bfb8cfc-a793-30cd-72c6-98b7a8177d32@eik.bme.hu>
 <233e3622-19b5-ed7b-5fdc-df23d5597681@eik.bme.hu>
In-Reply-To: <233e3622-19b5-ed7b-5fdc-df23d5597681@eik.bme.hu>
From: Ruslan Ruslichenko <ruslichenko.r@gmail.com>
Date: Wed, 25 Feb 2026 09:56:23 +0100
X-Gm-Features: AaiRm506uL5fWlToQcjPG44K_WPL-F34o0VLTRi0dkKHwo47tjY4qw0Vx6fZ2uA
Message-ID: <CAN-aV1FsyXH=sSDXsmpPr2ZNAkfP7yovGgiaTjyx-btfmBdO0A@mail.gmail.com>
Subject: Re: [PATCH v2 19/33] hw/core/machine: add '-hw-dtb' option for machine
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 peter.maydell@linaro.org, artem_mygaiev@epam.com, volodymyr_babchuk@epam.com, 
 takahiro.nakata.wr@renesas.com, 
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>, Ruslan_Ruslichenko@epam.com,
 philmd@linaro.org, 
 wangyanan55@huawei.com, zhao1.liu@intel.com, pbonzini@redhat.com, 
 Bernhard Beschow <shentey@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=ruslichenko.r@gmail.com; helo=mail-ed1-x52f.google.com
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

On Wed, Feb 25, 2026 at 1:07=E2=80=AFAM BALATON Zoltan <balaton@eik.bme.hu>=
 wrote:
>
> On Tue, 24 Feb 2026, BALATON Zoltan wrote:
> > On Tue, 24 Feb 2026, Ruslan Ruslichenko wrote:
> >> On Tue, Feb 24, 2026 at 12:55=E2=80=AFAM BALATON Zoltan <balaton@eik.b=
me.hu> wrote:
> >>> On Mon, 23 Feb 2026, Ruslan Ruslichenko wrote:
> >>>> On Mon, Feb 23, 2026 at 2:23=E2=80=AFPM Alex Benn=C3=A9e <alex.benne=
e@linaro.org>
> >>>> wrote:
> >>>>>
> >>>>> Thomas Huth <thuth@redhat.com> writes:
> >>>>>
> >>>>>>  Hi!
> >>>>>>
> >>>>>> On 19/02/2026 15.48, Ruslan Ruslichenko wrote:
> >>>>>>> From: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
> >>>>>>> Add new '-hw-dtb' command-line option and corresponding
> >>>>>>> MachineState property.
> >>>>>>> The 'hw-dtb' option allows to specify a Device tree
> >>>>>>> binary with hardware description which Qemu should
> >>>>>>> emulate.
> >>>>>>> Signed-off-by: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
> >>>>>>> ---
> >>>>>>>   hw/core/machine.c        | 19 +++++++++++++++++++
> >>>>>>>   include/hw/core/boards.h |  1 +
> >>>>>>>   qemu-options.hx          |  9 +++++++++
> >>>>>>>   system/vl.c              |  3 +++
> >>>>>>>   4 files changed, 32 insertions(+)
> >>>>>>> diff --git a/hw/core/machine.c b/hw/core/machine.c
> >>>>>>> index d4ef620c17..affd24cd49 100644
> >>>>>>> --- a/hw/core/machine.c
> >>>>>>> +++ b/hw/core/machine.c
> >>>>>>> @@ -363,6 +363,20 @@ static void machine_set_dtb(Object *obj, con=
st
> >>>>>>> char *value, Error **errp)
> >>>>>>>       ms->dtb =3D g_strdup(value);
> >>>>>>>   }
> >>>>>>>   +static char *machine_get_hw_dtb(Object *obj, Error **errp)
> >>>>>>> +{
> >>>>>>> +    MachineState *ms =3D MACHINE(obj);
> >>>>>>> +
> >>>>>>> +    return g_strdup(ms->hw_dtb);
> >>>>>>> +}
> >>>>>>> +
> >>>>>>> +static void machine_set_hw_dtb(Object *obj, const char *value, E=
rror
> >>>>>>> **errp)
> >>>>>>> +{
> >>>>>>> +    MachineState *ms =3D MACHINE(obj);
> >>>>>>> +
> >>>>>>> +    ms->hw_dtb =3D g_strdup(value);
> >>>>>>> +}
> >>>>>>> +
> >>>>>>>   static char *machine_get_dumpdtb(Object *obj, Error **errp)
> >>>>>>>   {
> >>>>>>>       MachineState *ms =3D MACHINE(obj);
> >>>>>>> @@ -1145,6 +1159,11 @@ static void machine_class_init(ObjectClass=
 *oc,
> >>>>>>> const void *data)
> >>>>>>>       object_class_property_set_description(oc, "dtb",
> >>>>>>>           "Linux kernel device tree file");
> >>>>>>>   +    object_class_property_add_str(oc, "hw-dtb",
> >>>>>>> +                            machine_get_hw_dtb, machine_set_hw_d=
tb);
> >>>>>>> +    object_class_property_set_description(oc, "hw-dtb",
> >>>>>>> +                "A device tree binary used to describe the hardw=
are
> >>>>>>> to QEMU");
> >>>>>>
> >>>>>> Do the hardware dtbs differ from the ones that are passed to the L=
inux
> >>>>>> kernel? If not, I think you likely could use the existing "dtb"
> >>>>>> property for your new feature?
> >>>>>
> >>>>> They have to - the normal DTB cannot define the whole system becaus=
e its
> >>>>> only concerned with reporting what the kernel can see to the kernel=
 and
> >>>>> not defining the whole system including what the firmware sees.
> >>>>>
> >>>>
> >>>> Yes, Indeed.
> >>>> Normal DTB was explored, but there is not enough information to crea=
te
> >>>> QEMU models from it.
> >>>> Thus we need to have a separate device tree.
> >>>
> >>> What additional data is needed that's not present in dtb from firmwar=
e and
> >>> what if that additional data is passed to the kernel? I think the ker=
nel
> >>> would just ignore the additional data that it doesn't need so one dtb
> >>> might be enough even if it has to be more detailed than what the kern=
el
> >>> normally gets. If that works we don't need a separate option.
> >>>
> >>
> >> Here are few specific examples:
> >>
> >> 1. DTS compatibles and QOM type names are all different.
> >> Using Linux device tree would require to maintain some massive hardcod=
ed
> >> mapping
> >> even for devices that otherwise don't require any special handling.
> >
> > Bernhard's patches had the same issue and solved it by adding subclasse=
s with
> > names matching the dtb. I think that would not work but a better approa=
ch is
> > to allow alias names for devices (we already have machine name aliases =
I
> > thought something similar for devices) that would solve this issue with=
out
> > too much additional complexity. Then the device would just need an addi=
tional
> > line registering an alias name to match the dtb name (or more of differ=
ent
> > machines have different compatible names).
> >
> >> 2. Object properties. We would probably need to make sure there is no
> >> conflicts
> >> and all properties are either ignored by Linux drivers or have exactly
> >> the same meaning.
> >>
> >> 3. Devices mapped to Secure Firmwares only. Those are not accessible b=
y
> >> Linux
> >> and trying to initialize them from the Linux kernel would cause memory
> >> aborts.
> >>
> >> 4. Connecting devices to backends such as serial, block devices, etc.
> >> We need to specify corresponding 'chardev' and 'driver' properties.
> >
> > This is probably not part of the machine but a specific invocation so t=
hese
> > should be specified on the command line and not in the machine definion=
.
> >
> >> 5. Interrupt wiring. Some hardware lines are transparent to Linux, but=
 need
> >> be
> >> wired by QEMU. For example, interrupt controllers are wired to CPUs, e=
tc.
> >> If we would want to initialize it from dts eventually, this would need=
 to
> >> be
> >> passed somehow.
> >>
> >> Overall, my understanding is Device models typically need to support
> >> booting existing
> >> OS images and device trees from regular platform builds.
> >> And at least due points 2-4, we cannot use them directly.
> >
> > Some of the points may be solved other than modifying dtb but some may =
indeed
> > need extensions so a separate hw-dtb may be needed in more complex case=
s.
> >
> >> Since we still need to modify the device tree for QEMU anyway, having
> >> support
> >> for unified DTS doesn't really make sense.
> >
> > However it may be worthwile to try keeping the modifications minimal so=
 for
> > simple machines like the e500-ppc that has no secure world or other thi=
ngs
> > not described by the normal dtb it could just use the regular dtb and t=
he
> > hw-dtb option would be optional for more complex machines that need it.

In fact, machine code now decides which device tree binary to pass to
the generic fdt parser.
So e500-ppc can indeed use a normal dtb instead and if corresponding
aliases are registered
then the machine should be created with the fdt_generic framework too.
However, for more complex cases we would indeed need HW dtb.

> >
> >>> This series seems to be more complex than Bernhard's e500-fdt experim=
ent
> >>> (I've linked to that in
> >>> <https://lists.nongnu.org/archive/html/qemu-devel/2026-01/msg05470.ht=
ml>)
> >>> Bernhard's patch only added minimal support for creating devices from=
 fdt
> >>> and then put additional logic in the devices instead of handling them=
 in
> >>> generic code. Would such an approach lead to simpler fdt handling? If=
 not
> >>> why is the additional complexity needed?
> >>
> >> Most devices can be created from generic code. Supporting one common
> >> approach to initialize some specific device class would be simpler and=
 more
> >> maintainable than writing a custom FDT handler logic within each devic=
e
> >> model.
> >
> > I think putting device specific knowledge in generic code is against th=
e
> > object oriented design of QEMU and would be less maintainable because i=
t
> > would not belong to the device maintainers that way. If you have common=
 code
> > for some device classes then those devices probably have a superclass w=
here
> > this code could be put. The problem of mapping property names to device
> > specific properties could also be done easier within a device model whi=
ch has
> > better knowledge of the device and then we would not need a global tabl=
e
> > mapping these. So while at first look it may seem more fragmented putti=
ng
> > some logic in devices instead of a central place it's better fits the o=
bject
> > model and groups device specific logic in the device model which is mor=
e
> > maintainable than a global mapping that does not belong to any device b=
ut
> > touches several unrelated devices.
>

Currently, there are only a few special cases for serial, blockdev type dev=
ices
to set up their properties, but no awareness about any device class. Even t=
his
may probably be improved to be more generic in future too.
All other properties are set without any specific mapping to device class,
so the parsing logic is generic.
The complexity exists because fdt_generic handles the logic for
machine construction,
such as creating custom memory regions, mapping devices to these regions, a=
nd
parsing irq-maps.
Specifically, this generic memory mapping logic was required to instantiate
secure devices and create the correct address space mapping for the PCIe bu=
s
in order to build the sbsa-ref example machine.


> It does not help that Google randomly refuses my emails saying it's spam
> if I cc it to more than one gmail user. See my reply above if you've
> missed the previous mail. Hopefully this gets through.
>
> Regards,
> BALATON Zoltan

--
BR,
Ruslan Ruslichenko

