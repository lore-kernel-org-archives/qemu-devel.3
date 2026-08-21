Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACD89C5DF8C
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 09:50:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxLsk-0002Nx-Mt; Fri, 21 Aug 2026 05:49:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wxLsj-0002Nf-MD
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 05:49:49 -0400
Received: from mail-yx1-xb12c.google.com ([2607:f8b0:4864:20::b12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wxLsi-00021O-1X
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 05:49:49 -0400
Received: by mail-yx1-xb12c.google.com with SMTP id
 956f58d0204a3-66c9995ca60so3307839d50.1
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2026 02:49:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787305786; cv=none;
 d=google.com; s=arc-20260327;
 b=fEm2zS8W3F+GTbL2pgxG3T8ispX6CxCQ8RHEzT/DW2nlSBb7RL1HVXTtwLfx4oui8I
 J9j75+F1zDXUPWJ4FWCKhmmXm/JzKsqEurBb0SsFuNFCxu6TsQW7Q2UE+OzoSkLUjfDR
 v93U17BPTaXlvXIkj2VQq9rXBZu866RrFL2fxJtXY95KN+ddBr+AKNUvmbkoyUD5hN+l
 w9e3L0B4bfaLSTenw+gByUecieNMB0748ehK0zW7QGW4KzlK56y9eh0Ot50G0ozujZzF
 tQxb9qGW5yYE/VC4qGMTySbw+bgGGtj8QU0Gf8KA3AzDK2fWVgXNldZRtS+/NDiPox6o
 e2Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=tg7EuQje/tPVZdyMbR4UCbpPTRRW2oBS8zrQvxBp0pY=;
 fh=807MsW+MsVAwrx8AAp4Z3r6QYRrLTdkjnTjLLi+vJXc=;
 b=cuTx364mrQKZD4dUYuYHrVfj59pZN9ka2BGFDo1p0jv5dCFnc/SM2QsiHKOu/q6MeC
 sC80uwRVdAogWMznmFU0kYbHdrtt+WnWdfIlbVyOdJOjvUCV6F2NEyOQErwkc/xBHc0/
 bK0o68EfBGfkxzuxtj0NYdriERkfFoGdLpeho3hPniWxaVPSkJvN5oHmnr9fRYR/fBVH
 BFD7jdEzANgpmzTmlat9ilCQX3BrbOba0CZsK3wz05oC+f6UkF5wy72psN3YCylin6wP
 uNTHKVBL/9XQ0LjldVEomjGaBdaR4e95PKO/ic9Wq8Q0ufCtIle/HAvJbx9944kx3UdR
 E9OA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787305786; x=1787910586; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=tg7EuQje/tPVZdyMbR4UCbpPTRRW2oBS8zrQvxBp0pY=;
 b=iI6Ebnh12HVPWKGFb2osMPEEQLT4ryKvyt85zVEAnVXRfwXN/k67pHneLkZdu9nH5c
 EFkJl6mKJUwi5A2XEwtF82wCd1Kp1LQC4uIiuRl/5eESyYxIGIAL1tfu/A1Jalqc15mE
 ZRH3V1bbBEAUEeWzdB6JBXtmrFzZJw/8Z2WLDz90hVrNHut8vHH9M4JUHWdm9pHcXGBA
 9Wp+/XL76/IAyxdLtxHa2Q/5JCYlHiE+BrSi6XmI4MNkdYAzqiGpSa4ZC9vGUh45iDzQ
 96/WGAeRK327Rs5S76Io+ujKT/ZgkNGXr6rKMswgYju7xCb6aUyumGVZoWvxBeo+l5Ro
 IAgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787305786; x=1787910586;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tg7EuQje/tPVZdyMbR4UCbpPTRRW2oBS8zrQvxBp0pY=;
 b=sgwafDbpKqK8QbocwHdVhf4gK2Lpc3FcaBjoGSYPDY06Ykc5IRKoPasIjGUuGiuizN
 XM4k/0eiqGUxybS58x90aTgWTwESdV5aENorAMpwdLEMcOIlfeGt0m5zRccNh0g6ElML
 o/HKerPHh0EPs/Wy/uWUl0TmCJADwSylCJutCeYfb1MgqosmmrkiC87sNc/NL/T171Mg
 bDA8nbRPYWOeMD1AP+61SK8zz/13Jwr8e2UHFGGzM9z+mxfty3lC+bo1cV9NlueD+Qpo
 L8uOjysgLMZP6BfwVjBTTTnEmE78L64iJmwo65BIMZUqyl2uzMTB2mYjJXwT7WI8DyLF
 C7Hw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq+zv960pnCCGb6A91RltY+BA/iRnuqDzFbxHIT09Y44XETSIRFrIECoUCDtXXqb+OVAQ7FI8eZYBYW@nongnu.org
X-Gm-Message-State: AFuF++m4APvMWcMeZ+OY6vd9IceyAbFYbUL+JyVilmhcluaATDUq4Bsw
 OmrULLjijTiWC+fTlKkgEZ0YULb1UQJeAsGZgUmk5cBf+WEaCJz+UWZYGtgC1CYN7MiYMVu/sD3
 FPpgQD+dfhKrM43OHCJaxtKmxBhpbe5bN7JePD1r7tw==
X-Gm-Gg: AR+sD13GfHTGotnamRujRDs87+++sQRGjnczQfOGQzdEN6QTzypMNDSb/n6VvBCW0c3
 FJI+77vQu4tyru2WLTDrOrY+MxibhMyz7GbUAReB+EgM1vPRGYX+RDVdG+4W4AvuLHJb8V/tDw6
 8QdQKKwRjcNzmuIEdWVn3fvtLNnKlDsvKHANh/Pth+LtQm4/JgVJtfDni0JGdrvQB/PiSfoQg8+
 vf/9PrrvJ1Irl5sJpwqttSZH6KZePWvrGHTTd7NObrcZ/uhFiEouupLycl9gK5G2DKGBaTJW1nO
 E1FqQdedVypISJU8nTadmCCR0vjLL4FnqmMa2665jm0WTe/XcUikuE2xKymeMwVt5tmRoL9x1Ss
 nRLS/vb64OdUlE/bhAymoFOOrl3ox
X-Received: by 2002:a05:690e:454c:20b0:66c:e9ae:d90 with SMTP id
 956f58d0204a3-66ce9ae0e82mr533447d50.18.1787305786480; Fri, 21 Aug 2026
 02:49:46 -0700 (PDT)
MIME-Version: 1.0
References: <20260816131300.51799-1-bin.meng@processmission.com>
 <20260816131300.51799-20-bin.meng@processmission.com>
 <10643a9a-8b04-48d9-a8ad-6dd86a4f29d1@oss.qualcomm.com>
In-Reply-To: <10643a9a-8b04-48d9-a8ad-6dd86a4f29d1@oss.qualcomm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 21 Aug 2026 10:49:35 +0100
X-Gm-Features: AcwNN1XKI7dyak-hFl1wBBn7Epxb8hO4yMquCFY7uZoQL4qHgnRy5WIXjxXQ4lY
Message-ID: <CAFEAcA_U9dwtJqigcaPJHWUgn5bRACG+zz4q+pDETzMfk5qXuQ@mail.gmail.com>
Subject: Re: [PATCH v2 19/20] hw/arm: versatilepb: Store boot info in the
 machine state
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: Bin Meng <bin.meng@processmission.com>, QEMU <qemu-devel@nongnu.org>, 
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Sun, 16 Aug 2026 at 16:07, Philippe Mathieu-Daud=C3=A9
<philmd@oss.qualcomm.com> wrote:
>
> On 16/8/26 15:12, Bin Meng wrote:
> > arm_load_kernel() keeps a pointer to the boot info struct for the
> > lifetime of the VM, so the struct logically belongs to the machine
> > rather than to a file scoped static object.
> >
> > Give both machine types the same VersatileMachineState instance struct
> > and store the boot info there.
> >
> > As in the xlnx-zcu102 and raspi machines, the boot info belongs to
> > the machine rather than to a static object:
> >
> > 4d1ac883a7 ("hw/arm: xlnx-zcu102: Move arm_boot_info into XlnxZCU102")
> > 0f15c6e338 ("hw/arm/raspi: Move arm_boot_info structure to RaspiMachine=
State")
> >
> > Signed-off-by: Bin Meng <bin.meng@processmission.com>
> > ---
> >
> >   hw/arm/versatilepb.c | 16 ++++++++++++----
> >   1 file changed, 12 insertions(+), 4 deletions(-)
> >
> > diff --git a/hw/arm/versatilepb.c b/hw/arm/versatilepb.c
> > index c6991a52e6..520af79c80 100644
> > --- a/hw/arm/versatilepb.c
> > +++ b/hw/arm/versatilepb.c
> > @@ -182,10 +182,16 @@ static void vpb_sic_init(Object *obj)
> >      peripherals and expansion busses.  For now we emulate a subset of =
the
> >      PB peripherals and just change the board ID.  */
> >
> > -static struct arm_boot_info versatile_binfo;
> > +typedef struct VersatileMachineState {
> > +    MachineState parent;
> > +
> > +    struct arm_boot_info bootinfo;
> > +} VersatileMachineState;
> >
> >   static void versatile_init(MachineState *machine, int board_id)
> >   {
> > +    /* versatilepb and versatileab embed the same state as first membe=
r */
> > +    VersatileMachineState *vms =3D (VersatileMachineState *)machine;
>
> Use OBJECT_DECLARE_SIMPLE_TYPE() and the defined macro?

That doesn't work, unfortunately, because in this file we define
two machine types (versatileab and versatilepb) which are separate
classes directly inheriting from TYPE_MACHINE but which share
a common init function (both classes have an instance_init
method which calls versatile_init()). OBJECT_DECLARE_SIMPLE_TYPE
wants a 1:1 relation between the state struct and the type.

I think to get this into a shape where we could use the standard
QOM macros we would probably need to define a common abstract
class that both the leaf machine types inherited from. That
feels like it's probably a worthwhile cleanup, but I'm OK
with what this patch is doing rather than making the "create
the abstract parent" refactor a dependency for this series.

The same applies for the omap_sx1.c and realview.c patches
in this series, which do a similar thing.

thanks
-- PMM

