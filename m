Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E273F3C9AF
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 16:50:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuvbK-0004P5-Ej; Tue, 24 Feb 2026 11:49:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1vuvbH-0004OC-DP
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 11:49:31 -0500
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1vuvbE-0002HK-Q3
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 11:49:31 -0500
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-4648447e29bso354870b6e.0
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 08:49:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771951767; cv=none;
 d=google.com; s=arc-20240605;
 b=MOH8s9y8G2WdehZVxBalKb5y1Dt0vdcrYzYxmDUVj9YDyMyX+BfcwyWdhukkCuA0SK
 LQN7ACYE33A8iNtjsDdeAYm/4D7/6fitY0EB6iuqcHhQxws+2DRhASHb/9LpnMHK4aA+
 By9Xaxhynf2GKloiR4BJEZ8RghglPOo94+3n5to0ZIwjHwWHBczXl4zFpTswyUHZMwL1
 sXh5iuvIZqmHtTNbR9uKLLT7uwz0a8IWqmfuyFBrsRae4bz+QYe3T9xO3iwE0stguqp+
 eG0/27n6ahcua6OPHbE5cwfxRsghIO2udHPgweh6sSkQII4zimqQC7ZbVrTkppJR2xgY
 ZnEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=aiEfwu1X+YjaV7whJeCCQrAjuGsJiezIfMnblUZpbuA=;
 fh=pggvW+WFzoStQBBZKiXFHS2nAyshaB9+RMcezy9zA24=;
 b=P+NCUp7CwIzlSB7MCkt0PHxSSksBiaNMSI1tIZE647p8BF/GT67ryh8WXrIBG3TuVb
 ilFbP3DnohhzTr2c2lhG4DhT52a8nKIg1w/pmIizJKJOMh1g701v2Cj+M/xWmFHf2ZZV
 kRgLyHpNalQC6fbRow7QtU0yIjWD4reyYnS4BsWmnxyKAP90pbRt4lVGeTElYPAFthvJ
 o5f+fY4ae25SoFJC86Ocu+I9Casp0cuOJNIeFbOTLOwsRHDjwDjLoShzqViQveoCDLwe
 G88nh9Jj+6Aj+WVQYM6VZ8STn1+ZyZmP5UNaalGu3uWQGfvnOzAkzjEqxVO0KBh57Tkx
 ZceA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771951767; x=1772556567; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aiEfwu1X+YjaV7whJeCCQrAjuGsJiezIfMnblUZpbuA=;
 b=AzpU4e4cC/IOJRBMYMs44DCiED1e6e9yeuO3mSenHjhnSOr07pr9ctHZ5w9Tl+o5qf
 nBO3jCXcScTO9Ezt2nZPaFc3/w4+6mJksw4IFdlv45LJHWYwMaf52DxxI2Gcq8idRst1
 dCaqFtJh0SC18wQusTnPECaafmLfdyORmyCjyFP1G943jOerF42kykNzHzfRkHt0GJlQ
 e/K/wOKP1dEfLM2EuZNFmj9LvxMUdZlUWiE5rPAGepw1frw6W3A7omH+x/AEtLCg6P7n
 t328xcfwMsze2kjWtuiQz+CA5tmy6tFeaXO3EiJmRXGCnhquOR0JXEBRGWhYIaNpGS+b
 otmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771951767; x=1772556567;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aiEfwu1X+YjaV7whJeCCQrAjuGsJiezIfMnblUZpbuA=;
 b=GFABjFEQ9lPToz8bah7WzHP9gI4HmQXIJ8Ab2HVP0HcrM23/yooq2tUUYDtrwQL2Hu
 oXwdNWgCEzMmZlg58ZLg5/At7W28GVEjoqf6V4L7Ghwp0u0Thxfl+M1+GvUS4sROutAJ
 pL7KecB7jbSYNsPrcNZDIM8rA/5lmYbRmNCwKYCBxB+h2vU5Kdurna5iFOscgbD/alkZ
 sTHVwI6Q8UmYqJ0+PYKB9x0HYvu9wy0J4fvfT8zRhCQifgzBtTLWE8Dn8nj05V+gSV3W
 W5CqED9ohIRWB/MAXc4xpMN6zCPvd/+j4TMNDvKAtKsgUyttO+HAFdIh7fw/e0wEwxrG
 1zww==
X-Forwarded-Encrypted: i=1;
 AJvYcCWXkdclRgkiWxuJPW97ReWoJFuoITPHJQG3On0NziO5ndElFYxdvgTL7llO4/tDk4A3xzJRQuEv+p6n@nongnu.org
X-Gm-Message-State: AOJu0Yx21DNjC4c1U4djXgkqbVWD6GE3xbhD6D2jjt4PJm+l/wD88+b+
 EuJYkXeQ7e3KHUs5Xba8sMdle/zEk29Bq6T4RDhnqLAfw21ox6c008DQCTIrHaIPv71m+yWN/hy
 MY6zU7TrXff+qn5Q79QRq4Aaw/9/ATAw=
X-Gm-Gg: AZuq6aJjSUYxrZ2CTgUmWRZixqk3ffMLtAtaAz5PqejkQtJbwKG6tVoqSScKqRbQD91
 pM/B4bpLS0p39DhQ9Qx7dHvNTUGf+ifBRPZZ4nN5O8e4EDHk/0McM327y8JGebJ+J2AZLTV6y0d
 THMkhtdltDwNkUmO7C2sQ8MhGicEUVmO4ba2B5/StM3XFFlSpD158DSrgjmX2Nr5NXCAOqOtnjt
 rZgeE9nYDWV7naySIsyoqVSkvWOWfrTCNlt/h6m1JlZsBvtV2m0HOZpGbEojXmObngwKq9LUD11
 okdMAAU=
X-Received: by 2002:a05:6820:4b10:b0:662:bf9b:1638 with SMTP id
 006d021491bc7-679c44f85f4mr6944287eaf.62.1771951767299; Tue, 24 Feb 2026
 08:49:27 -0800 (PST)
MIME-Version: 1.0
References: <20260219143332.3316679-1-ruslichenko.r@gmail.com>
 <20260219144901.3317747-1-ruslichenko.r@gmail.com>
 <dd8a92cc-51d6-4404-bd09-75b1798f925a@redhat.com>
 <87y0kj4mr3.fsf@draig.linaro.org>
 <CAN-aV1H0_4LviryDEmDSN0TfdSit-uN31H8g87sRBkJAHYbrdQ@mail.gmail.com>
 <d2d16e2b-d86a-633f-b32a-e063746658d8@eik.bme.hu>
In-Reply-To: <d2d16e2b-d86a-633f-b32a-e063746658d8@eik.bme.hu>
From: Ruslan Ruslichenko <ruslichenko.r@gmail.com>
Date: Tue, 24 Feb 2026 17:49:16 +0100
X-Gm-Features: AaiRm52A265NnHJ4xKpWwUx7vqi1UtxcrIH65yutc-OzVUOzp4jQ6sXJ7sca40M
Message-ID: <CAN-aV1Ezvu1VnQJYiMDrNceaRAG32-DKtV85v2w58R4bpkL=KA@mail.gmail.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::230;
 envelope-from=ruslichenko.r@gmail.com; helo=mail-oi1-x230.google.com
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

On Tue, Feb 24, 2026 at 12:55=E2=80=AFAM BALATON Zoltan <balaton@eik.bme.hu=
> wrote:
>
> On Mon, 23 Feb 2026, Ruslan Ruslichenko wrote:
> > On Mon, Feb 23, 2026 at 2:23=E2=80=AFPM Alex Benn=C3=A9e <alex.bennee@l=
inaro.org> wrote:
> >>
> >> Thomas Huth <thuth@redhat.com> writes:
> >>
> >>>  Hi!
> >>>
> >>> On 19/02/2026 15.48, Ruslan Ruslichenko wrote:
> >>>> From: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
> >>>> Add new '-hw-dtb' command-line option and corresponding
> >>>> MachineState property.
> >>>> The 'hw-dtb' option allows to specify a Device tree
> >>>> binary with hardware description which Qemu should
> >>>> emulate.
> >>>> Signed-off-by: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
> >>>> ---
> >>>>   hw/core/machine.c        | 19 +++++++++++++++++++
> >>>>   include/hw/core/boards.h |  1 +
> >>>>   qemu-options.hx          |  9 +++++++++
> >>>>   system/vl.c              |  3 +++
> >>>>   4 files changed, 32 insertions(+)
> >>>> diff --git a/hw/core/machine.c b/hw/core/machine.c
> >>>> index d4ef620c17..affd24cd49 100644
> >>>> --- a/hw/core/machine.c
> >>>> +++ b/hw/core/machine.c
> >>>> @@ -363,6 +363,20 @@ static void machine_set_dtb(Object *obj, const =
char *value, Error **errp)
> >>>>       ms->dtb =3D g_strdup(value);
> >>>>   }
> >>>>   +static char *machine_get_hw_dtb(Object *obj, Error **errp)
> >>>> +{
> >>>> +    MachineState *ms =3D MACHINE(obj);
> >>>> +
> >>>> +    return g_strdup(ms->hw_dtb);
> >>>> +}
> >>>> +
> >>>> +static void machine_set_hw_dtb(Object *obj, const char *value, Erro=
r **errp)
> >>>> +{
> >>>> +    MachineState *ms =3D MACHINE(obj);
> >>>> +
> >>>> +    ms->hw_dtb =3D g_strdup(value);
> >>>> +}
> >>>> +
> >>>>   static char *machine_get_dumpdtb(Object *obj, Error **errp)
> >>>>   {
> >>>>       MachineState *ms =3D MACHINE(obj);
> >>>> @@ -1145,6 +1159,11 @@ static void machine_class_init(ObjectClass *o=
c, const void *data)
> >>>>       object_class_property_set_description(oc, "dtb",
> >>>>           "Linux kernel device tree file");
> >>>>   +    object_class_property_add_str(oc, "hw-dtb",
> >>>> +                            machine_get_hw_dtb, machine_set_hw_dtb)=
;
> >>>> +    object_class_property_set_description(oc, "hw-dtb",
> >>>> +                "A device tree binary used to describe the hardware=
 to QEMU");
> >>>
> >>> Do the hardware dtbs differ from the ones that are passed to the Linu=
x
> >>> kernel? If not, I think you likely could use the existing "dtb"
> >>> property for your new feature?
> >>
> >> They have to - the normal DTB cannot define the whole system because i=
ts
> >> only concerned with reporting what the kernel can see to the kernel an=
d
> >> not defining the whole system including what the firmware sees.
> >>
> >
> > Yes, Indeed.
> > Normal DTB was explored, but there is not enough information to create
> > QEMU models from it.
> > Thus we need to have a separate device tree.
>
> What additional data is needed that's not present in dtb from firmware an=
d
> what if that additional data is passed to the kernel? I think the kernel
> would just ignore the additional data that it doesn't need so one dtb
> might be enough even if it has to be more detailed than what the kernel
> normally gets. If that works we don't need a separate option.
>

Here are few specific examples:

1. DTS compatibles and QOM type names are all different.
Using Linux device tree would require to maintain some massive hardcoded ma=
pping
even for devices that otherwise don't require any special handling.

2. Object properties. We would probably need to make sure there is no confl=
icts
and all properties are either ignored by Linux drivers or have exactly
the same meaning.

3. Devices mapped to Secure Firmwares only. Those are not accessible by Lin=
ux
and trying to initialize them from the Linux kernel would cause memory abor=
ts.

4. Connecting devices to backends such as serial, block devices, etc.
We need to specify corresponding 'chardev' and 'driver' properties.

5. Interrupt wiring. Some hardware lines are transparent to Linux, but need=
 be
wired by QEMU. For example, interrupt controllers are wired to CPUs, etc.
If we would want to initialize it from dts eventually, this would need to b=
e
passed somehow.

Overall, my understanding is Device models typically need to support
booting existing
OS images and device trees from regular platform builds.
And at least due points 2-4, we cannot use them directly.
Since we still need to modify the device tree for QEMU anyway, having suppo=
rt
for unified DTS doesn't really make sense.

> This series seems to be more complex than Bernhard's e500-fdt experiment
> (I've linked to that in
> <https://lists.nongnu.org/archive/html/qemu-devel/2026-01/msg05470.html>)
> Bernhard's patch only added minimal support for creating devices from fdt
> and then put additional logic in the devices instead of handling them in
> generic code. Would such an approach lead to simpler fdt handling? If not
> why is the additional complexity needed?
>

Most devices can be created from generic code. Supporting one common
approach to initialize some specific device class would be simpler and more
maintainable than writing a custom FDT handler logic within each device mod=
el.


> Regards,
> BALATON Zoltan

--
BR,
Ruslan Ruslichenko

