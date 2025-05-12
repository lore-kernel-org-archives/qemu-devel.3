Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 267D2C3ABC3
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 14:11:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uETrj-0005x2-Sw; Mon, 12 May 2025 10:10:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uETri-0005wn-DY
 for qemu-devel@nongnu.org; Mon, 12 May 2025 10:10:46 -0400
Received: from mail-yw1-x1132.google.com ([2607:f8b0:4864:20::1132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uETrg-00053h-80
 for qemu-devel@nongnu.org; Mon, 12 May 2025 10:10:46 -0400
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-70b75ba2fb5so2266167b3.3
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 07:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747059042; x=1747663842; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lCclfJmgA91UOJkeTHXtAriekx6u5wMn1ghIdAf+OxA=;
 b=gKCJYWEJtoOP+Yfbb6oTM9y5fRNAsug6HEunPQZIKYLsd//zX1vyCJFEERXnLVCvbS
 qgxehV9zOCqHXXIFgnQ5MXOAG7AbHNOxfMA7dGxRneZhFIs8zmPD4wBqkhrAMeRQe7FD
 M3KSCVxJpUc3OkK8W1IxDoMPc6wlE2g9dyKHxQi1MRbQrPCKddVhIGcWmQnBWQjFvwz3
 n2yuLfBZAC2vUnLCwBSZA9fEaCQL++alNG01lZo8dL3me1UyviliUtiDYXBpc/b56OT4
 nTJYQsagp09Ea2mJWM/X+9v+6G31V/gDy23rBRnrWxf2Y3/5u312WLs49lrF0AdUJBYR
 n2xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747059042; x=1747663842;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lCclfJmgA91UOJkeTHXtAriekx6u5wMn1ghIdAf+OxA=;
 b=HBqTtB4NdjYkcRzyGjEse87AoqoIQXkLoGf7IMzMzw28oIXSVFF8ncbVfNBL6frxeG
 U6if2QPzwICjQBrVhEbf8IjOksEL4LhbU11mXhH6JgH2GO7ojxaF261ohBn9s+Omj3lb
 662NhlEFmd4E9MXoBqABr7Qx2fWW41dn83Jq0/M/jZ/ADt6+DWWvveK/gkOmhusSV4Ov
 uJA4K+wfsJvG7Mvh0GnmW8lVJlYryURaSfj4f5uu15B0BSec+erMfI1C3BM+CEimx/eE
 FGStgXdcsYf34Vg4gn8miQcRHeH+Db+en2J+nYdbT8hxCJQWKc1J+3EUJuYKx3mc+PfI
 OneQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU5sY/04QL04E7UcsJxVDLLiIeI9+zv9NeSLVp3U6ehraPx9KuwxdTKEwfO47ydkL+GVCOrJsVrop2j@nongnu.org
X-Gm-Message-State: AOJu0YxOiH4Vd1Tc1CebiG2MEDXl8PAhI8kvvDNS3EVkkRyZTXkSFNlB
 jvTMJOp8tSzpexPINJVfm42y1W1jf0/YGm4Hfn19YIv4kSLv+bGwwuQULCsZEPLKrusviDZbTvz
 FhXj6QdsorTK6ufeE/DUUXOPE6nyy7dOB0ssoCA==
X-Gm-Gg: ASbGncuDz1keL9Z93b8x/ZaJSwdihWKzcrVFwZONlK2uks103AoKGvMZ/2KLDLCer41
 eWBPEJpa+DXf2FYLeAe8mlJr604QGTixJOxW7oAnk/syQyOxzOHKUmj41FOpcq/P4FZxPgY6FKL
 2uXXhICAnfuLQrNj5+9tiAoa3c7piNXOcBAQ==
X-Google-Smtp-Source: AGHT+IHjlE9Z8danLJclT/d9NRiml/9P/6mzykJpml07vpeK+a/d7toxEOTo7TJf2UlUoisOjitV8Bddnq9CHgJgnEE=
X-Received: by 2002:a05:690c:6012:b0:708:5243:44d4 with SMTP id
 00721157ae682-70a3fb75976mr184816767b3.31.1747059042263; Mon, 12 May 2025
 07:10:42 -0700 (PDT)
MIME-Version: 1.0
References: <20250506164602.3897164-1-stgraber@stgraber.org>
 <aBsduLe2QDbr4Ol1@redhat.com>
In-Reply-To: <aBsduLe2QDbr4Ol1@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 12 May 2025 15:10:31 +0100
X-Gm-Features: AX0GCFsirUhim9ivzNUEz1blLww7d4EM8rYgs0D6i95rj1c2NLBAu1dKm6s6IL8
Message-ID: <CAFEAcA-3kqoLWA3WRuL+Lwk_ozo2cYOh_A3_AsPB=Crxu1Zhgg@mail.gmail.com>
Subject: Re: [PATCH] hw/usb/network: Remove hardcoded 0x40 prefix
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: =?UTF-8?Q?St=C3=A9phane_Graber?= <stgraber@stgraber.org>, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1132.google.com
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

On Wed, 7 May 2025 at 09:46, Daniel P. Berrang=C3=A9 <berrange@redhat.com> =
wrote:
>
> On Tue, May 06, 2025 at 12:45:53PM -0400, St=C3=A9phane Graber via wrote:
> > USB NICs have a "40:" prefix hardcoded for all MAC addresses.
> >
> > This overrides user-provided configuration and leads to an inconsistent
> > experience.
> >
> > I couldn't find any documented reason (comment or git commits) for this
> > behavior. It seems like everyone is just expecting the MAC address to b=
e
> > fully passed through to the guest, but it isn't.
> >
> > This is also particularly problematic as the "40:" prefix isn't a
> > reserved prefix for MAC addresses (IEEE OUI). There are a number of
> > valid allocations out there which use this prefix, meaning that QEMU ma=
y
> > be causing MAC address conflicts.
> >
> > Signed-off-by: St=C3=A9phane Graber <stgraber@stgraber.org>
> > Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2951
> > ---
> >  hw/usb/dev-network.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/hw/usb/dev-network.c b/hw/usb/dev-network.c
> > index 81cc09dcac..1df2454181 100644
> > --- a/hw/usb/dev-network.c
> > +++ b/hw/usb/dev-network.c
> > @@ -1383,7 +1383,7 @@ static void usb_net_realize(USBDevice *dev, Error=
 **errp)
> >      qemu_format_nic_info_str(qemu_get_queue(s->nic), s->conf.macaddr.a=
);
> >      snprintf(s->usbstring_mac, sizeof(s->usbstring_mac),
> >               "%02x%02x%02x%02x%02x%02x",
> > -             0x40,
> > +             s->conf.macaddr.a[0],
> >               s->conf.macaddr.a[1],
> >               s->conf.macaddr.a[2],
> >               s->conf.macaddr.a[3],

Note in particular that this string is used *only* for
what we return to the guest if it queries the STRING_ETHADDR
USB string property. It's not used for what we return for
the OID_802_3_PERMANENT_ADDRESS or OID_802_3_CURRENT_ADDRESS OIDs
for NDIS, or for the MAC address we actually use in the QEMU networking
code to send/receive packets for this device, or in the NIC info
string we print for users. In all those other places we directly
use s->conf.macaddr.a, which is the full thing the user asks for.

> To repeat what I said in the ticket, the 0x40 byte originates from when
> this was first committed to QEMU. We can see the finall accepted patch
>
>   https://lists.nongnu.org/archive/html/qemu-devel/2008-07/msg00385.html
>
> but tracing the history back further, this was *not* in the version of
> the patches submitted by the original author 2 years earlier:
>
>  https://lists.nongnu.org/archive/html/qemu-devel/2006-10/msg00339.html
>
> There's no explanation of this difference. Could easily be a left-over
> hack from some debugging attempt that no one noticed until now.

That original version of the patches is even odder, because it
does this for the STRING_ETHADDR:

+                       case STRING_ETHADDR:
+                               ret =3D set_usb_string(data, "400102030405"=
);
+                               break;

i.e. hardcodes it entirely.

I think we should note in the commit message that the hardcoded
0x40 is only used for STRING_ETHADDR and not for any of the
other ways we use the MAC address. But otherwise

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

