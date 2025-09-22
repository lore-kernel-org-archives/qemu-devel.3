Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 504D9CAC592
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 10:46:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0e3O-0004ez-IO; Mon, 22 Sep 2025 06:45:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1v0e30-0004dm-Ow
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 06:45:39 -0400
Received: from mail-qt1-x82a.google.com ([2607:f8b0:4864:20::82a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1v0e2y-0006Ht-KC
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 06:45:30 -0400
Received: by mail-qt1-x82a.google.com with SMTP id
 d75a77b69052e-4b3d3f6360cso42075711cf.0
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 03:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758537927; x=1759142727; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1sRzXPfgzHztAXeC/zGxPf549CyrDZuRgB/Cd4ZP5p4=;
 b=Nd4Z2V8Sby+5xEAf5weRkBNixfpKJVMk3JC4jiT6YXXlEAQxvPRW1tL8XY9uZ3Z7Ml
 E0enypbK6LjF2A3TYi31LTucEGgUFgi96vkf0vcYpM/hktKjo1t3UEyfGsR17HQnVxlz
 wED34ZjI6M6gjhVVbDmIXUO6dCbfchvxX0AjcHiV//O21BvO7deujenWjG1Vd2xKQol8
 BY1OVDSutHVRCRgiAcmra3OlQ/K1YRMbYtsZYQYQaIdRmHyxRLUPezTwglwCjlHNg8ur
 GDkyFEf8iNPFXtR0VOJdX7v80CJ9rprC0WlBlZcXzUPYEzA9JBat32DoyzGezYcFyqp0
 usnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758537927; x=1759142727;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1sRzXPfgzHztAXeC/zGxPf549CyrDZuRgB/Cd4ZP5p4=;
 b=j5BYGqUK7ElNq1Xah/E16gC/PAGvHwiHbAV6gjVhxdtPgYg37vEtfzLYOUN4otAsvu
 BAYku7jzt+/kQIS67FWa6UZBJbNJKJdiaym3O04/cpMDYz0meZKrey3hhI6Swoi3rbV7
 jH5dFv4BUCdSp1XltixuskP615oLU5iRMi8mMrNePyfWlu0bazczGbdGuu6TRNpj0+as
 /Nfovb3pwtvdK+IoshvKA1nYA+CEAjnD4k2qAwZMuvbYMO8HmPvxHn6DAN0oEUk/cTVp
 Qkq66DoyzC+gGHyZTw0bPCcBJk0ld1aAB7uEqWFdgblHo99IGfsYs0wwdZ6Ht4697muO
 gHmw==
X-Gm-Message-State: AOJu0Yym+SBOdUfDbLIQttYkqcuTP1y0/BrZM7VXahuc5MmiFz5bJh+N
 DnspUj3STZ+8rqBsSgXZPhhFEofEwZd3Kcni/+SrY4U1pFJ11FnvQARFjXEPNN+HesizoyhNWXT
 nGcgVVrlNgfcItaVT0f5ciEFs/ad4A9I=
X-Gm-Gg: ASbGncuJQouuACgMCeDbzzQCVkgsM4ldrQEysYko/H/HYwUnj4x7ZvNOaRko47WbWKE
 ChrnIDyMFj5R7+kHa4L1MZR7AYDZNicLYMxaJaUFwD5Dr62OBvrD8TM0LUN6WZlVIf1cIuvGsPW
 XTt3iBN47xQef0Pyd930O7lP/8BQoApyXbKEde7l4bPjYM/jIC2wmRm9Cy8oWgDl6h1yKX1+u/p
 TGgvrXKhgqKVBKoDJAMTJFEZy2UmF4JV5wF7BxI
X-Google-Smtp-Source: AGHT+IHmP9YzwLcXIiZksFhWgBvSBkSu0bnM03P+d4ZChskc4K+XpiQi56jwaI1Jh25wNbc10G2uwfdT3VlX5lsEG6c=
X-Received: by 2002:a05:622a:4c13:b0:4d0:1b36:7a66 with SMTP id
 d75a77b69052e-4d01b367fe2mr10028211cf.21.1758537927162; Mon, 22 Sep 2025
 03:45:27 -0700 (PDT)
MIME-Version: 1.0
References: <20250919133320.240145-1-marcandre.lureau@redhat.com>
 <20250919133320.240145-20-marcandre.lureau@redhat.com>
 <aM1rj-5Rja1CXqy0@redhat.com>
 <CAMxuvay3zOzcRZBDseDw4UwqTRC5k1Qk1cRomGvVRzR2jV8U3w@mail.gmail.com>
 <aNEnnyvfqHgF4rq1@redhat.com>
In-Reply-To: <aNEnnyvfqHgF4rq1@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 22 Sep 2025 14:45:15 +0400
X-Gm-Features: AS18NWD9PWoTagwzMMAu49m6ygM5lZz-obtA5FL_noWn4DLcqsVytN3OZOtoCPI
Message-ID: <CAJ+F1C+KOsFg6G-6aZAr5cnHj94s3AMsoxJiNtsFu39L63juHw@mail.gmail.com>
Subject: Re: [PATCH 19/24] configure: set the meson executable suffix/ext
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Ed Maste <emaste@freebsd.org>, Thomas Huth <thuth@redhat.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>, 
 Yonggang Luo <luoyonggang@gmail.com>, Warner Losh <imp@bsdimp.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Kohei Tokunaga <ktokunaga.mail@gmail.com>, Kyle Evans <kevans@freebsd.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::82a;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x82a.google.com
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

Hi

On Mon, Sep 22, 2025 at 2:42=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com> wrote:
>
> On Mon, Sep 22, 2025 at 02:34:25PM +0400, Marc-Andr=C3=A9 Lureau wrote:
> > Hi
> >
> > On Fri, Sep 19, 2025 at 6:41=E2=80=AFPM Daniel P. Berrang=C3=A9 <berran=
ge@redhat.com>
> > wrote:
> >
> > > On Fri, Sep 19, 2025 at 05:33:13PM +0400, marcandre.lureau@redhat.com
> > > wrote:
> > > > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > >
> > >
> > > Please actually the reason why the change is needed. The code
> > > change seems related to msys2 / Windows, but our CI is already
> > > covering this and so what's broken ?
> > >
> >
> > It doesn't cover --enable-rust yet:
> >
> > ../rust/meson.build:41:2: ERROR: Program
> > '/c/Users/User/qemu/build/pyvenv/bin/meson' not found or not executable
>
> So it is is called meson.exe on Windows, even though it is a
> script, not an executable ?

It's a PE EXE. I don't know how it works there.

> Can you put all this info in the commit message.

sure

> >
> >
> > >
> > >
> > > > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > > > ---
> > > >  configure | 14 +++++++++++++-
> > > >  1 file changed, 13 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/configure b/configure
> > > > index 8d84e3c5c0..7b1795ab29 100755
> > > > --- a/configure
> > > > +++ b/configure
> > > > @@ -1000,7 +1000,19 @@ $mkvenv ensuregroup --dir
> > > "${source_path}/python/wheels" \
> > > >  # We ignore PATH completely here: we want to use the venv's Meson
> > > >  # *exclusively*.
> > > >
> > > > -meson=3D"$(cd pyvenv/bin; pwd)/meson"
> > > > +# for msys2
> > > > +get_pwd() {
> > > > +    if pwd -W >/dev/null 2>&1; then
> > > > +        pwd -W
> > > > +    else
> > > > +        pwd
> > > > +    fi
> > > > +}
> > > > +
> > > > +meson=3D"$(cd pyvenv/bin; get_pwd)/meson"
> > > > +if [ -f "$meson$EXESUF" ]; then
> > > > +  meson=3D"$meson$EXESUF"
> > > > +fi
> > > >
> > > >  # Conditionally ensure Sphinx is installed.
> > > >
> > > > --
> > > > 2.51.0
> > > >
> > >
> > > With regards,
> > > Daniel
> > > --
> > > |: https://berrange.com      -o-
> > > https://www.flickr.com/photos/dberrange :|
> > > |: https://libvirt.org         -o-
> > > https://fstop138.berrange.com :|
> > > |: https://entangle-photo.org    -o-
> > > https://www.instagram.com/dberrange :|
> > >
> > >
>
> With regards,
> Daniel
> --
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
>
>


--=20
Marc-Andr=C3=A9 Lureau

