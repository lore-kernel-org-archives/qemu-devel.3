Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 849B7FF8873
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 15:31:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wITMF-0002eV-Sm; Thu, 30 Apr 2026 11:31:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wITLm-0002dT-7Q
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 11:30:50 -0400
Received: from mail-yx1-xb12a.google.com ([2607:f8b0:4864:20::b12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wITLi-00085Z-9U
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 11:30:47 -0400
Received: by mail-yx1-xb12a.google.com with SMTP id
 956f58d0204a3-6589bfb4de2so441604d50.2
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 08:30:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777563045; cv=none;
 d=google.com; s=arc-20240605;
 b=Ux30NH6ARW31e1BycE0z9a2Bcwn8k6pMSZnnAG5lE+cayMV6kgnyEv7osemz193XI2
 nNySOXz/q1g4Dn2JYxIrAlaouF2kBjWYB32pD1iJu4dXXaJNyoEd7mk0Z8Ck5js6BVPx
 NFlYNmRXs1ICTRumkj/M8PphPvsHR2NChPDpAAVX2xSnduC1ZsMIkfWPj2q2pWc9Zizj
 RBmgcvPVraj18MGjOg1z4BnFkrndzQWVnPpV+ajGUtBzQZOmZ0iXt46mOq5weKNYyH0i
 SWxorsxi8W734ekyj3oKfb9FHeCEtO5hdB62VYIMTDk8HwpF+nnAJPA/5107EKfEgYi1
 XJKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=dFYUmsxpYxNeVnEWvGfeRKeiHiWjjJcXujbHi4Nouvo=;
 fh=N2y4sIgp27vFb7/F9FYu8pF/IxFiU4WCumEaDVu1hgc=;
 b=AkvANSzOqOa52hx/AN9p3zsNOpjoZGpP2IUXSP5oc/v4X47jWTTlaa4IWr+ujKIJ2k
 R9WjAraXbcGVXrI3rCL+KDFPN86bumzDxpBDZgx5OqccAjLOuGJAyEmfGISnnhNPPZqJ
 bzxz2gI7wYgqdUhRow/KhC9oRRo8xraMkF/oVljtY7ucPw8Tp5x1jumxRnb5mOsA1FP9
 p1ah7ETcNxiUVdOgEdTlih5gGFRv4njOS5M0+PqfwNrppt0SumKUBbXBYs2U8djbyVj/
 GKjk4pSYGwXBxlzHnNJKAWqjFy7XUNyUEJfUfmRYU3R0YqALXmL93cY8uvMlRMN78Vhs
 AydA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777563045; x=1778167845; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dFYUmsxpYxNeVnEWvGfeRKeiHiWjjJcXujbHi4Nouvo=;
 b=SrIqihMZ6Ch0SSNDhq/qb1vJ14XBF0XRg7lyITDMKzAK9Wv4LB2LTmGU5aLz2xILUM
 oMdcOTVaH5Ab7MDiRat8Ln/20KxWzzFF82e14XSAxQar2PP4MmCMheVO/HXrJObDZ8N4
 TdG3IHNZ0ltYEzxSPgkcO46tS8zmekpBAVogmkWY8+76Ft5WPe4z8p41V5ulhTohKiVU
 cYBmA1d3ZwI1HlNnNUsxBuMmJgzduP+fGx3YwPIzD769TZjfCW104zRCCzMQw6L86ra6
 idZJqBgGa3a/uc4ZR2Jm4+8Nm/++xF411O5yb7aZv0BYgCkvKskTNlyy0F0msv41Nrbj
 /t2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777563045; x=1778167845;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dFYUmsxpYxNeVnEWvGfeRKeiHiWjjJcXujbHi4Nouvo=;
 b=aPXgiSPjtPzQRfW6YjeelNmuVEupx6P97SyuOsTIPHaY1Y9Iu2rNIotE3S6DfpVDVi
 LUhnPRNDPBQtxBjpx4xPsD8MgQPmAs7yxP0q+iLrrSAQKIOxQ72lRTGCE6WEZlNhO9ZS
 i4Xg/lQxEpQ+bugCDBuhf0+f205sQUAVTqvZLqScgeM50lk7rzB2K+mAGJPbUSCCaYIG
 +uJise1CIZWstz7JsKDdLIq9CoUTmcd3PWxWBTemu33hg6jj1vPdiiOMaPYu4kEILZ/I
 o2/AN29NoMCoA0/rkj/nK6kJ04GN3ILkVPGqiMOsW8bDxVi42BCzbLoUNMXFfMCeMIgi
 SvGQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/4tDV09VU1kWJdoNVDtY1xW3/CRgxUEeoez6CkPNFw+jKvxr3hKblMqj6N05jatV77k607+mH3uGr2@nongnu.org
X-Gm-Message-State: AOJu0YwtE1zSUkfwlDG4Hp1+F8sL04F2y1R+7uNIfJG14jXwkOrdQzN0
 tkkTKkDlG+KbahTgVDWnlQrgMAlODM07jyCPIQb3D6khJ0lkeo+EtLT4sqT7vtQMp1c2l7kbt0C
 mviJeAq9jgGqLRfmVFcPDIBsN6ob+zeJCgJBErAwsiw==
X-Gm-Gg: AeBDies9gTVFUJmPRfxVPwEdjl9bXqsAkNbO8uFNbgZk1OqxdjTHl9+buwBEz1FdhBB
 R234FGPGHzdZnfCGKsvsgxJeQjG+93AKLOtHZYCLFngk3MN5jJvvmI+HBx8ejCov560PuypBxOz
 9+uuoiiHv9BlWvEn4TD83Fl0x2Tmysn+HrJAfMYx7EQaveLDWxfO9rFatzsTnIkW8X4z2lVt6WU
 gxLqM/D23SLZu5hNICP4Vra2zW+Eh80WhuxZINFwUMHOuzbQqDR11xhkKMVYPdRkxZTUjpmZOYX
 rtYq69bhBhquzDTCG/WL04QSbVTLmzARHtiJiQJBqSb6n3YIx0b/Xr69KbsT4ZCQOByHBWAcQBr
 rkg==
X-Received: by 2002:a05:690e:2518:b0:64c:f4ff:607c with SMTP id
 956f58d0204a3-65c18de22c6mr1938423d50.33.1777563044370; Thu, 30 Apr 2026
 08:30:44 -0700 (PDT)
MIME-Version: 1.0
References: <20260427-qom-tests-v1-0-c413f3605311@redhat.com>
 <20260427-qom-tests-v1-34-c413f3605311@redhat.com>
 <CAFEAcA-tSqa7SQUE-f5yTq_P9eW6p_XrnNSnHZjw4g=Z2WncAQ@mail.gmail.com>
 <4f90d39a-560f-4922-ac54-2c975dae249d@linaro.org>
In-Reply-To: <4f90d39a-560f-4922-ac54-2c975dae249d@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 30 Apr 2026 16:30:32 +0100
X-Gm-Features: AVHnY4JBP1_L_uvofr5Vpxo45GYDlKrZBmYLSz9Y1l3ero1v48W7SBi8qZA9Zjw
Message-ID: <CAFEAcA_LcHgtAAYFjqm+P68ULwSRJWfr6LipMg9YsviyWDxH7Q@mail.gmail.com>
Subject: Re: [PATCH 34/41] hw/arm/virt: free flash devices and OEM strings on
 finalization
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 qemu-devel@nongnu.org, armbru@redhat.com, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Thu, 30 Apr 2026 at 16:18, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> On 30/4/26 17:12, Peter Maydell wrote:
> > On Mon, 27 Apr 2026 at 20:45, Marc-Andr=C3=A9 Lureau
> > <marcandre.lureau@redhat.com> wrote:
> >>
> >> +static void virt_instance_finalize(Object *obj)
> >> +{
> >> +    VirtMachineState *vms =3D VIRT_MACHINE(obj);
> >> +
> >> +    for (int i =3D 0; i < ARRAY_SIZE(vms->flash); i++) {
> >> +        if (vms->flash[i] && !qdev_is_realized(DEVICE(vms->flash[i]))=
) {
> >> +            object_unref(OBJECT(vms->flash[i]));
> >> +        }
> >
> > We currently use qdev_is_realized() almost nowhere in
> > the codebase. Isn't there some way to do this such that we
> > don't have to care about this because the object is
> > parented and gets auto-dereffed ? Having each object
> > have to care about the possibility of "inited but
> > not realized" devices in finalize seems like it's going
> > to result in a lot of bugs...
>
> Why are we creating pflash devices if we aren't realizing them
> (thus not using them at all)? Destroying them when unneeded
> would avoid that manual cleanup, right?

I wondered that, but what happens is that we init the pflash
devices in the machine's instance_init by calling virt_flash_create(),
and then later we do the "configure, realize, map" part in
virt_flash_map() in the MachineClass::init method. So if
you init the Machine object but never call its init method
before finalizing it, the flash devices are still in the
inited-but-not-realized state. (This is similar to how with
a normal qdev object, if you init it but don't realize it
it will init but not realize all its child objects.)
(We need to create the flash devices earlier than we do
the other devices on the board to make the machine properties
that virt_flash_create() sets up work.)

Since virt_flash_create1() calls object_property_add_child()
to make the flash device a child of the machine, I think
we could make that be the only reference, by having
virt_flash_create1() do:

 Object *obj =3D object_new_with_props(TYPE_PFLASH_CFI01, OBJECT(vms),
                                     name, &error_fatal, NULL);
 DeviceState *dev =3D DEVICE(obj);

and then using sysbus_realize() rather than sysbus_realize_and_unref()
in virt_flash_map1(). Not tested, though...

-- PMM

