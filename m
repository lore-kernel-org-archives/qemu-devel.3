Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75B67CD342F
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 10:27:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKCzc-0006dK-Cg; Tue, 05 May 2026 06:27:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wKCzU-0006d1-TQ
 for qemu-devel@nongnu.org; Tue, 05 May 2026 06:27:00 -0400
Received: from mail-yx1-xb12e.google.com ([2607:f8b0:4864:20::b12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wKCzS-0002nS-Uq
 for qemu-devel@nongnu.org; Tue, 05 May 2026 06:27:00 -0400
Received: by mail-yx1-xb12e.google.com with SMTP id
 956f58d0204a3-656d749109cso2773547d50.3
 for <qemu-devel@nongnu.org>; Tue, 05 May 2026 03:26:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777976818; cv=none;
 d=google.com; s=arc-20240605;
 b=I9bpJ0o06xDb9Q7uueMWS2np/swdX+cmWIHDtzkRsX5FBp1q1oeyxLKjkZSJCIW7BY
 nR1yt2iaW/056NanSafWotO+GJIOdmwJa03A1UCLL0TzxyzJ9U5oEg1ZxEwjnb3LXHuv
 8tAJuKIK286HMOk2QdPn8gons8fqytHiLeeSBU4Os0/ekm7n8QfJY75nZg7WM8N+bMJD
 F6/8g9FAYeOX5p9qP68qTBiYaI1ltJxUNF21Ed6UFGp1PQ59wGe7x9kScmAV73z1SIlJ
 Yqw1/UJ46zykl/LypMEq/yR5AqqsUV1lW5f0qi7llv4RipT8y4nGCmX8uM5nFnNOv5Zk
 88fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Ewknm9abXTEcV/JuYaRGF8bMsL6/CVAhbGtThzsXklI=;
 fh=+1firF9KONN4Yc1L4UE+f7hjZIqv5yKMPW+CbJoXUyw=;
 b=HenOb9KQb/6UFkNV13Co5tt1sBfCKxh1nuYCGdbbtyORp85XaNIRZNvz9CuNFUe9HF
 yPpR91urlSYq8SoaG2tcdEg3xGH+p3U0WBqlo8O1mwk+InL0SSf6DsTAwNcCemtOk5aT
 injShsNQ1O4AWdSvEDfrbP7T8SeeMB93t8BRX5etO0ornpPfhsfBa2AXiPPxq8SnyAAb
 FSEyQJdYM9k2UuHhB0xWAgf4ysEcVrFBU2DOUr/hFDvUgXv3GRFUXwBKnkvNOLBp6/lC
 Jpt1Jj13xo6nY1zPV9rEdDrO3pGM7DkQpT5O2MpPQSwMs82++djMlzh1n6sVtHsV6aVh
 Ipmw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777976818; x=1778581618; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ewknm9abXTEcV/JuYaRGF8bMsL6/CVAhbGtThzsXklI=;
 b=i4v1KOO+/UOjr+mRFzUqlkaTbx9J1A9YwKZ9c0uzs7/pe43v69wXeznKTXddltfvEX
 m1AyAFpfNzCFMYbGavGO8bOGyXqUirvlQRIVWe33Z2EdZ3Njw/7OlGtoQaYUrNJE3OJB
 NwOm7ZcZdOe+QcDWvmDKJJMuFu0tLOb+b/T6hvg77pZdWltbhEybTi0wFGQKOwsq4yUY
 3tGOnZ69lCo4Ou8Nw+W14dGgLOns8IjglzvnuBAG4TG1rGuAnexQ+iVdu6gC2YuP8UOA
 UQ6He39HahoTC/spMFqeaO9eXRD5kVI0msguhdJ5xKWGcLpcM9SqAuOW5LXlvwG0DF4h
 G+fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777976818; x=1778581618;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ewknm9abXTEcV/JuYaRGF8bMsL6/CVAhbGtThzsXklI=;
 b=b8EbrEcMWiljLH1ORhEMp7jDo7nAUs+upepimJ6mbKxsZl9vp9N1cjOmwofE+vnTr3
 oc6Yv8qKfSaY1bbYyOlXRjvrFkwJug1zgFyCndBxy2ps7roUuMobl//ti3A1M1nj2wja
 Mo3wWdcTJgCou0kB2NBCeZoRJjN3uX20R3a8oH1PJIudOHwq+uUIkSdXWa2isJcyNOJC
 rDHpuJC/usVrElpPPbXXvru+Hbk+kumJU2MZKy2GkUDuFnSq3vYjiJZ/e2E7MpbYRX9K
 AICLdJRIqErFXkuTVwpUVm26DqS2jAaXnnfLUzIP54a8tUEbhXFO9dspCfmboRMNk4IG
 hg7g==
X-Gm-Message-State: AOJu0YwB7kQO74HHwugsoivF7PNIKpWKPu/9oVIhmaRlrltuu8zHH/dX
 6ERG5Ys/yeATI2p1UD0m41Y2eV1tdvjdVBT+b6NiZxHwrts1b2qBXZrp8euKkWOAmTfvNjmRHKw
 +SmoqAg0UcTMeY1skKFGmuz5KD2wnoqRDaYIDuY/lIA==
X-Gm-Gg: AeBDievuRb1wAteRSvnP/CqZa3T4zotE6gvc5a5YDSQxAQsMO40kZuAOIHwmCC5EFet
 NfXgwb8JCnmrRi+UIX25+eBPSqD5yZdgMmpQmr6I3JccmTha5FsQYH9QWmin9A3V942/LXHyyy+
 zND6tU0dGvPfDG7lKUbTwGvyTrOc1yc7tQWh7qaLQzCtkcM5I3b/svyVqk9TA9N54i5wBDo0sXc
 uDbq+mUP2X4SXPNkwpvRtW1tuNNOQmKgvYEsoTCL0WmyiEpZrr3jHduDYj1XR8LcGUy/pNIc44t
 0pmHDCgqofILREsJENAK2TZOap2EwnEERRjK1WFmgP0BoJfUtL/gA4amwFsTsBPtHatx/PCHBuN
 ITw==
X-Received: by 2002:a05:690e:1c1b:b0:650:1960:c8b4 with SMTP id
 956f58d0204a3-65c69ead719mr2399805d50.42.1777976817670; Tue, 05 May 2026
 03:26:57 -0700 (PDT)
MIME-Version: 1.0
References: <20260504-qom-tests-v2-0-ef7e3dc94f7a@redhat.com>
 <20260504-qom-tests-v2-7-ef7e3dc94f7a@redhat.com>
 <CAFEAcA8BAOvSKUxvE_yn0psM10v+WPZy=9=DLeneXGKeiWSrHg@mail.gmail.com>
 <CAMxuvawmHjz31dUBeiuHaVy5cgq_vhJe+8Nz8S1iKE8wcGubCQ@mail.gmail.com>
In-Reply-To: <CAMxuvawmHjz31dUBeiuHaVy5cgq_vhJe+8Nz8S1iKE8wcGubCQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 5 May 2026 11:26:46 +0100
X-Gm-Features: AVHnY4JsFjzpck3O7_4IKXdXs9vACr6P-aH5W0OeK1EgO18YAjEaCJnnCivV7h8
Message-ID: <CAFEAcA8p0DBo+dyehyhFKYEMs21UrywZxVLPkuiuU9gYov8v1A@mail.gmail.com>
Subject: Re: [PATCH v2 07/46] hw/ipmi: reject NULL 'bmc' property rather than
 crash
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12e.google.com
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

On Tue, 5 May 2026 at 11:02, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
>
> Hi
>
> On Tue, May 5, 2026 at 1:57=E2=80=AFPM Peter Maydell <peter.maydell@linar=
o.org> wrote:
> >
> > On Mon, 4 May 2026 at 12:36, Marc-Andr=C3=A9 Lureau
> > <marcandre.lureau@redhat.com> wrote:
> > >
> > > The type-checking macros (IPMI_BMC(val)) which crash on NULL.
> > >
> > > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > > ---
> > >  hw/ipmi/ipmi.c | 9 ++++++++-
> > >  1 file changed, 8 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/hw/ipmi/ipmi.c b/hw/ipmi/ipmi.c
> > > index b49affaccec..d532d38e556 100644
> > > --- a/hw/ipmi/ipmi.c
> > > +++ b/hw/ipmi/ipmi.c
> > > @@ -95,7 +95,14 @@ static const TypeInfo ipmi_interface_type_info =3D=
 {
> > >  static void isa_ipmi_bmc_check(const Object *obj, const char *name,
> > >                                 Object *val, Error **errp)
> > >  {
> > > -    IPMIBmc *bmc =3D IPMI_BMC(val);
> > > +    IPMIBmc *bmc;
> > > +
> > > +    if (!val) {
> > > +        error_setg(errp, "%s cannot be set to NULL", name);
> > > +        return;
> > > +    }
> > > +
> > > +    bmc =3D IPMI_BMC(val);
> > >
> > >      if (bmc->intf)
> > >          error_setg(errp, "BMC object is already in use");
> >
> > I was looking through the code to check where the type macros fall over
> > on NULL pointers, and I couldn't find it, so I did this little test,
> > and as far as I can tell they don't assert, they just return NULL:

> > Is the problem you saw really with the cast macro, and not with
> > this function's explicit dereference of bmc in "bmc->intf" ?
>
>
> You're right; it's with the "bmc->intf", I'll update the commit message.

We can also update the code change, because we don't need
to split the declaration and initialization of bmc; we
can keep the existing "IPMIBmc *bmc =3D IPMI_BMC(val);".

thanks
-- PMM

