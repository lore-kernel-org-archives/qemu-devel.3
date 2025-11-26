Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 897E7D10F22
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Nov 2025 11:40:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vODs9-0001mY-MH; Wed, 26 Nov 2025 06:39:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vODs7-0001lG-KZ
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 06:39:43 -0500
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vODs5-0005vW-RW
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 06:39:43 -0500
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-78a7af9fe4fso68897947b3.2
 for <qemu-devel@nongnu.org>; Wed, 26 Nov 2025 03:39:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764157181; x=1764761981; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x+uQm1JOAhc6ntQBq6fxJEeRkITc0qG+8jOew7896Us=;
 b=p4Gv3dYZTMhuz5OI3Ogwt0yb5ma82vyhhNY8P8YGYGgqvhlYj9lFyft+VtD+Ub+k4R
 t6b3rWK5/HhTXNuY3mPCqyBwVk6yAfk9oQnE0DJ3qAWL/1IgULyrDuDje02UdVIbTp8C
 mpwppN153saAQlG0xdtq9Dr31roSiTOV101OK2v+VjkeNBJTa6/0610XGLqp+shSoGso
 BI9DRrjTZ0w6V2qPgHgu3RR6GPMvezdLSaJbNY0kh6+0RGUzSP6QYnutbBhdsuNl+rYm
 7W4TOnN0LoGcPHF4nwNES765ldimS1tdAeHc7jE/k0kzTtnst2P9b/oVfkwgE+CS9B4G
 3dYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764157181; x=1764761981;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=x+uQm1JOAhc6ntQBq6fxJEeRkITc0qG+8jOew7896Us=;
 b=YpNR2KiWlE/HaSAov4/c1Kt9pAA86tHQ3C0vlhyqQ3zF/LsAeBFYbWmT9Pthokmq4U
 /3DFubDbIkgvyrqQRRd+9l1SH92M4tYc29inyXHd6Plexg6B3Gx9417akstASjBeoyuk
 69571VZM665gCt1e1CREuBR9EHzSjpQn46GpUYwotSnRiTdJWOrd+sRD44wRmU0U3rnE
 2Nzyd3Jkpyyi2/r2tmNK505/0EoxbsGjtxJEwddqrBJnmFDDrRP2faXZ4W8y4q8OD1aa
 qvWD2mVs//ahVv+SgPtiu0/YuP7ZAOPk9YeM2BYpg7LRiNwc2owG8nieTChg7uGyw/I/
 +3AA==
X-Gm-Message-State: AOJu0YwxD5Yi57CpgS2lA4i2NX0127EXwA7CCy8CrSfux0la1Kzzg/6O
 GU8IQqkGDAljGlR9mFzyPA8S4FPfl+aKDsjLNcxkvtvPgNGiBj7Zx4+0mVDUX8aP8N6kMN+znql
 xFeD4UvBd4Q3UP5be9ZeRZVGfF+raSsUBkzqLcrchmA==
X-Gm-Gg: ASbGncvTvLL/f/aX73UGgKssM9OibsPOODvPhSYW4f/1a7wwGiKCjujQ/5eNGVdNMDf
 qJvQd91INWZp3GAB7mCFmU+81wvP/MJp80snXs9Xfwxc1q2EFggckwgflfnDSG8WCVuPOTKPJky
 h3dj3JNQ/izazZLkz4xDStkWCS+S5EHAx0D9IL6D508jJPCiUaOa7aOA/N8SPaFW0LcYjmGHLfS
 pTBWwgTz7I/uiFTCy9Jf/X6K4MW5jqw7uJiECFDOH8ACdFUoJMnkeDt6pGY74sWzAkEIL1h
X-Google-Smtp-Source: AGHT+IFRxdDKn0CUCbFZihkfsRUs83RzdKEOUAT42A9UOPYde46bGApJ4awA5s4tsWHz8/okg0JWcWpWObwKEL5srw0=
X-Received: by 2002:a05:690c:630e:b0:786:393c:5f16 with SMTP id
 00721157ae682-78a8b556fb3mr143403957b3.49.1764157180719; Wed, 26 Nov 2025
 03:39:40 -0800 (PST)
MIME-Version: 1.0
References: <MW4PR11MB8291BDD718BE9BB5A160C839ACD4A@MW4PR11MB8291.namprd11.prod.outlook.com>
 <CAFEAcA9J=ETmdptn7cbzsx6hU_EiD+Pmvro+QW-T957vNMCSqw@mail.gmail.com>
 <MW4PR11MB82915352467DA0D706DF98CDACDEA@MW4PR11MB8291.namprd11.prod.outlook.com>
In-Reply-To: <MW4PR11MB82915352467DA0D706DF98CDACDEA@MW4PR11MB8291.namprd11.prod.outlook.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 26 Nov 2025 11:39:28 +0000
X-Gm-Features: AWmQ_bkXP5AvwthT7yNLutkq1PU454zzICERMNlUSWOz6x_faDe8sIGOq-3M0qw
Message-ID: <CAFEAcA823qNeCBnt7i-oajn-ZoFnJpv3mZkDtO073mSexZ1kHg@mail.gmail.com>
Subject: Re: [PATCH] hw/usb/host-libusb: Do not assert when detects invalid
 altsetting
To: "Yang, Liang1" <liang1.yang@intel.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, 
 "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>,
 "kraxel@redhat.com" <kraxel@redhat.com>, 
 "Kim, Dongwon" <dongwon.kim@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1129.google.com
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

On Wed, 26 Nov 2025 at 11:20, Yang, Liang1 <liang1.yang@intel.com> wrote:
> From: Peter Maydell <peter.maydell@linaro.org>

> > +        warn_report("usb-host: ignoring invalid configuration "
> > +            "for device %s (bus=3D%03d, addr=3D%03d)",
> > +            udev->product_desc ? udev->product_desc : "unknown",
> > +            s->bus_num, s->addr);
> > +        return;
>
> This is something we already get wrong in a lot of the error-exit paths o=
f this function, but we need to free the conf descriptor with libusb_free_c=
onfig_descriptor().
> (If you wanted to include a patch to fix those existing leaks that would =
be great.)
>
> YL: I see, let me check and see if can create a patch to fix those leaks.
>
> We already ignored a bNumInterfaces=3D=3D0 config (because the rest of th=
e function would just do nothing), so the only change here is to warn about=
 it.
>
> (1) Have you seen the bNumInterfaces=3D=3D0 situation in real life?
>
> YL: No, I have not seen (or noticed) this in real testing, but I think it=
's good to have especially during very fast USB hot-unplug/hot-replug.

If you haven't seen it, why worry about it? We won't crash if it
happens, we'll just ignore the device.

> (2) This is unrelated to the other half of the patch, so it should be its=
 own patch (i.e. one which just says "warn about this kind of invalid devic=
e rather than silently ignoring it").
>
> YL: This is for preventing the potential assert, but we can separate it i=
nto another patch or just remove it if it is really not required.
>
> (3) All the other cases in this function of "the info about the endpoint =
looked weird" we report via the tracepoint trace_usb_host_parse_error(). I =
don't have a strong opinion about warn_report vs a tracepoint here, but I d=
o think we should be consistent.
>
> YL: Understand, I think it depends. For normal QEMU USB event tracing or =
debugging, it's better to use the tracepoint functions. But in this case, i=
t is reporting an unexpected condition or behavior.

All of these error cases are the same thing, though -- the device (via
libusb) is reporting something to us that seems to be invalid.

> > +                 * invalid altsetting index during fast hotplug/unplug=
.
> > +                 * Instead of aborting, log a warning and skip the int=
erface.
> > +                 */
> > +                warn_report("usb-host: ignoring invalid altsetting=3D%=
d (max=3D%d) "
> > +                    "for interface=3D%d on %s (bus=3D%03d, addr=3D%03d=
)",
> > +                    alt,
> > +                    conf->interface[i].num_altsetting ? conf->interfac=
e[i].num_altsetting - 1 : -1,
> > +                    i,
> > +                    udev->product_desc ? udev->product_desc : "unknown=
",
> > +                    s->bus_num, s->addr);
> > +                continue;
>
> For other errors with the intf info we "return", i.e.
> skip the whole endpoint, rather than just continuing.
> Should we do the same thing here ?
> (Conceptually the same thing -- just "return" leaks the config descriptor=
, as noted above.)
>
> YL: In this case, only one interface has an inconsistent altsetting index=
 (caused by hot unplug/replug) while the others remain valid, so I use "con=
tinue" for skipping only the invalid interface avoids losing valid endpoint=
 information. Returning early would drop all remaining interfaces, which se=
ems undesirable.  Thanks.

But this USB device is just (temporarily) broken, isn't it? Doesn't it all =
come
back with the right information later?

If it's reporting garbage to us then ignoring it entirely until it's
consistently sensible seems safer to me.

thanks
-- PMM

