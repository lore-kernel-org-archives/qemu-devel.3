Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72BF1C83F1A
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 08:43:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ua9LT-0006M6-Oz; Fri, 11 Jul 2025 04:43:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <weifeng.liu.z@gmail.com>)
 id 1ua9Gs-0007AF-HK
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 04:38:20 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <weifeng.liu.z@gmail.com>)
 id 1ua9Gq-0007v8-KP
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 04:38:18 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2352400344aso17272785ad.2
 for <qemu-devel@nongnu.org>; Fri, 11 Jul 2025 01:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1752223093; x=1752827893; darn=nongnu.org;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=7szApUk1nEp5iodg9amptUDrs9+jjHKxHiaBBVzDsHs=;
 b=ifymYSq7v7PXyaC5t2lOxt1sPa7lX4dg9yzjT6yh6OtPdQXioNJT7qvWyyOs2ugjPW
 4X9HSLLxHQN/01gv+bx3w/tlgsrkiC2SwQp3B8Ptxpi4HTE+nXxYIbh7xrk51U6gfE+A
 D24uh+kBOtCpun/pK5E4kNIApXOci6sYd9qHlT33nL6tPJQbroNHV8nkFkKLVabHIVTM
 P5Oa4A8AnNdIkmqLke+xZfYYP/BrxLHYCBLS627O3NTONP1OthdMC5BYRjeI+Ut1mZgC
 s0Nu+FDepq422qgy/Fe3NHoIj4h28q7W31sQJ3B9jeArgqzoR4UJWQ0mq9q5fbia/Dot
 mH9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752223093; x=1752827893;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7szApUk1nEp5iodg9amptUDrs9+jjHKxHiaBBVzDsHs=;
 b=WFguAZhdTn3E4KShFb8IoB4z5g948kA+LdTUYcpgXHxTRlsTBUddMvcRiB3yxQ6jwz
 wqbCTX+QCyQp2MrYC+PaOH2qC07IHbUwBesrvE8r5/Is56c/9XMvzGbIGEkQsjUzjHRd
 959Ew2chWfm0fsO/GvQiALo27Wb6UyiFkClNuNTNNQd9smjNF558yRBK5qrssdPWPA8l
 GQeVPDw5CXMUGDpWExp5yTUjnTR3dtrlwqnHYKD+fRWMG+PgSKXuxxAftjPa2PTOGCpN
 Tl2C6iQMavFUh1DK3EHqZixyDYqZ5GT4SDPp/H2q8rG4pYYOyDV/Ms74AadDIw02Ajr4
 148A==
X-Gm-Message-State: AOJu0Yy4fnX7iFHBIsXcrXrYKIf3ssclNIy1CymwcuSINhBF6jKB2SWo
 iImD00LrVDaGhnGH0YAVzq8tXPlQIqdNhJU/bm3VKd78RAMuBzw9mryW
X-Gm-Gg: ASbGnctdb6zfhdZBW+2Fy6V/3kMbAA19gKjbheiAzHh6lqVua0Q502mqLRLAj0cAxGS
 LSssCMGIeOEJ7Tkl26IIS7csg9keb8uhiToPrI1VVKjvcie69gDDu37gStyGjqigHNwZdQEUOtR
 FwtQxPuL/bBpv9vZvGU3gR0VfaygUDXQOsAkf+0p9toeMfgNVSboMq4nzpCNxLQdruv8VJVRKS7
 onuIOX5adohKQcthpMA3x3/DeMDp278dvDN4FXBLgArqIVN2AI9HUqr2RARRgzWht4/KWBvPdEQ
 tNf2thWA2amKN8KH1qJ1lBqSablYm9Fpq9B6HsdVuJCg1LYBc5k0KMSIi1PIgIi6vFKYnSVi3Vc
 WLksFlsMZ5WZaC8ECgxb1GnfFae3tPumnzA==
X-Google-Smtp-Source: AGHT+IGzjswBo6afoFNM1r1QGvernSI1pQ/1357aCw6LTjVwnfG8e0CSlW5r0MwDjvQsjtCfnkqWRA==
X-Received: by 2002:a17:903:230c:b0:224:26fd:82e5 with SMTP id
 d9443c01a7336-23df0969b83mr21044225ad.48.1752223093434; 
 Fri, 11 Jul 2025 01:38:13 -0700 (PDT)
Received: from [10.239.152.184] ([134.134.139.77])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31c3019e934sm7639684a91.33.2025.07.11.01.38.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Jul 2025 01:38:12 -0700 (PDT)
Message-ID: <4d25062ab034d349a10ae53cdb31075d10496490.camel@gmail.com>
Subject: Re: [PULL 14/19] ui/gtk: Update scales in fixed-scale mode when
 rendering GL area
From: Weifeng Liu <weifeng.liu.z@gmail.com>
To: =?ISO-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>, 
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com
Date: Fri, 11 Jul 2025 16:38:09 +0800
In-Reply-To: <CAJ+F1C+ux0GGyCpLn3sHzic7OWX-7gn7NtdYybaWD-snbWNMkA@mail.gmail.com>
References: <20250524173514.317886-1-marcandre.lureau@redhat.com>
 <20250524173514.317886-15-marcandre.lureau@redhat.com>
 <CAFEAcA_WKw124t-92KLSq_GT2wVWU9QtiF_qEHxPqjkXJSDAGg@mail.gmail.com>
 <CAJ+F1C+ux0GGyCpLn3sHzic7OWX-7gn7NtdYybaWD-snbWNMkA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
MIME-Version: 1.0
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=weifeng.liu.z@gmail.com; helo=mail-pl1-x62b.google.com
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

Hi,

On Fri, 2025-07-11 at 11:01 +0400, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>=20
> On Thu, Jul 10, 2025 at 4:24=E2=80=AFPM Peter Maydell
> <peter.maydell@linaro.org> wrote:
> >=20
> > On Sat, 24 May 2025 at 18:37, <marcandre.lureau@redhat.com> wrote:
> > >=20
> > > From: Weifeng Liu <weifeng.liu.z@gmail.com>
> > >=20
> > > When gl=3Don, scale_x and scale_y were set to 1 on startup that
> > > didn't
> > > reflect the real situation of the scan-out in free scale mode,
> > > resulting
> > > in incorrect cursor coordinates to be sent when moving the mouse
> > > pointer. Simply updating the scales before rendering the image
> > > fixes
> > > this issue.
> > >=20
> > > Signed-off-by: Weifeng Liu <weifeng.liu.z@gmail.com>
> > > Message-ID: <20250511073337.876650-5-weifeng.liu.z@gmail.com>
> > > Acked-by: Gerd Hoffmann <kraxel@redhat.com>
> > > Acked-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >=20
> > Hi; Coverity complains about this change CID 1610328):
> >=20
> > > @@ -50,8 +52,14 @@ void gd_gl_area_draw(VirtualConsole *vc)
> > >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0 gtk_gl_area_make_current(GTK_GL_AREA(vc->gfx=
.drawing_area));
> > > =C2=A0=C2=A0=C2=A0=C2=A0 gs =3D gdk_window_get_scale_factor(gtk_widge=
t_get_window(vc-
> > > >gfx.drawing_area));
> > > -=C2=A0=C2=A0=C2=A0 pw =3D gtk_widget_get_allocated_width(vc->gfx.dra=
wing_area) *
> > > gs;
> > > -=C2=A0=C2=A0=C2=A0 ph =3D gtk_widget_get_allocated_height(vc->gfx.dr=
awing_area) *
> > > gs;
> > > +=C2=A0=C2=A0=C2=A0 fbw =3D surface_width(vc->gfx.ds);
> > > +=C2=A0=C2=A0=C2=A0 fbh =3D surface_height(vc->gfx.ds);
> >=20
> > Here we now unconditionally dereference vc->gfx.ds at the start of
> > gd_gl_area_draw().
> >=20
> > But towards the end of this function we have a NULL check:
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!vc->gfx.ds) {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 retu=
rn;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> >=20
> > Either vc->gfx.ds can be NULL, in which case we need some
> > kind of guard on these surface_width() and surface_height()
> > calls; or else it can't, and the NULL check later is dead code.
> > Which is correct ?
>=20
> Given that it's simply called from a GTK callback, it can be NULL. I
> think we should simply return in this case, or perhaps use the older
> code path as a fallback. Weifeng, wdyt?

It makes sense to skip drawing when ds is NULL, although that shouldn=E2=80=
=99t
happen since dpy_gfx_replace_surface installs a dummy DisplaySurface
for any NULL input. I=E2=80=99ll draft a patch shortly to add this check (a=
nd
possibly other refinements).

Best regards,
Weifeng

