Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24726C54791
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 17:11:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdCaR-0002Go-19; Thu, 22 Feb 2024 12:10:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rdCaO-0002G3-RU
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 12:10:16 -0500
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rdCaM-0008Kf-Ls
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 12:10:16 -0500
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-565468bec51so1211187a12.1
 for <qemu-devel@nongnu.org>; Thu, 22 Feb 2024 09:10:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708621813; x=1709226613; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+clhGK5CmMbUnm7X1zLQ+lroWGpJSidp8qaoKLdvM0E=;
 b=LEMu0Y7J9t1WXeUqdsE4bx6cHuHpgtWvUEEQdaa3zCu8EBj8RTT2T/bE1bWRoDQUsv
 m+8MTRnf0fSvz8FlSyngd+G/HLRQKh5oHR9VAOmFJHqSp1nGxZhhOAtcikP/VckhB0SQ
 ZFNNW8y0zyQrL+Y94kD9imOlh16txWy/6zTAgU5hAAzSJFGYgkkMer+SfI/9RKoylUOt
 cjnEag/dtAqI3WDYl+fZPOK+wKIYUoV8e4RY+EfWSjshkkDwne6umjMKPWJ1h24NfOpV
 Dx7bYz8qd3l/2PQGFNZQSMOg9zLR5RFchaBBOHS4mjoH83tMdyaau+Cvsbrmbuj7DasL
 N+dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708621813; x=1709226613;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+clhGK5CmMbUnm7X1zLQ+lroWGpJSidp8qaoKLdvM0E=;
 b=n5UD6sRUD17w22x9clRRpZyqcpZg6wjCQy2tnLUYW77hdbTUscVdq8sN58pju5oUl9
 MTX8c3lQSrHsmv/JCKaF4bMl/7oWA2VtpIj/7+Rc8GhUqhdZlHXaNarYCA9Lr9KUTX17
 TIKodQAKXMgWZ7unstwhgirEiVzNORimxqqkzx8E3Y0tz+sqLSp0IL3QbB/c5r/PTX+0
 CrmbNd+XicXT7pN3f4lM2eA/6Fj7B1wll39yeTKU+DYGAROPmNMZ+MjuNyK6UxgBmPrr
 Yb/wVEhOfrS7GpQbGFOwJqaAgQplPIlvWGqQVf8ZC7UG7kQtKStceg4KW1SDxjc26rIx
 1TSA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXxiTVsOTdXR0TKMOafyFisoMT4O5RfHZ5kUTEIQWYhUJ/CT80os35tsPyM/j9yRdY3i+nWxDRsJhfvPfPWfv+4dZh4Da0=
X-Gm-Message-State: AOJu0YyxH6NCfkpRnq13tsnWRASOGd9z0X2kg8pXBEGsoK+h76AcB/8x
 PFfOLMRrijKgmkTGo9H+cu1Un28PPZDk8ocpoBa3XG8e71UhVsKxaqUWz3vPU4MC+YhNk9yp9SI
 QHBvSjPPAd4w492u04HixkTJZzzlrvF3Iy8nkPg==
X-Google-Smtp-Source: AGHT+IEly/qy7fFCWe/A4i4RjIJfJHMb84VXxNj7chgks0xxYaMDU+46E2PahxeEW3Fe/UXXeF8B6li8k25TlkOHvjU=
X-Received: by 2002:a05:6402:43c3:b0:564:9628:2e2f with SMTP id
 p3-20020a05640243c300b0056496282e2fmr2865537edc.17.1708621812704; Thu, 22 Feb
 2024 09:10:12 -0800 (PST)
MIME-Version: 1.0
References: <DDADA9A9-DED4-4510-A532-7600C0233467@daveparsons.net>
 <fdda385d-2e18-4554-88d0-e43cb5b90e39@tls.msk.ru>
In-Reply-To: <fdda385d-2e18-4554-88d0-e43cb5b90e39@tls.msk.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Feb 2024 17:10:01 +0000
Message-ID: <CAFEAcA9psJuvPz+mWYzWz0NLTcQTCNhknFrGZ2bx7Frtb3=B4A@mail.gmail.com>
Subject: Re: [PATCH] ui/cocoa: Fix incorrect window clipping on macOS Sonoma
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: David Parsons <dave@daveparsons.net>, qemu-devel@nongnu.org,
 qemu-trivial@nongnu.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Akihiko Odaki <akihiko.odaki@daynix.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, 22 Feb 2024 at 06:08, Michael Tokarev <mjt@tls.msk.ru> wrote:
>
> [Adding a few more Ccs]
>
> 17.02.2024 18:58, David Parsons :
> > macOS Sonoma changes the NSView.clipsToBounds to false by default where=
 it was true in
> > earlier version of macOS. This causes the window contents to be obscure=
d by the window
> > frame. This fixes the issue by conditionally setting the clipping on So=
noma to true.
> >
> > Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1994
> > Signed-off-by: David Parsons <dave@daveparsons.net>
> >
> > diff --git a/ui/cocoa.m b/ui/cocoa.m
> > index eb99064bee..c9e3b96004 100644
> > --- a/ui/cocoa.m
> > +++ b/ui/cocoa.m
> > @@ -365,6 +365,9 @@ - (id)initWithFrame:(NSRect)frameRect
> >           screen.width =3D frameRect.size.width;
> >           screen.height =3D frameRect.size.height;
> >           kbd =3D qkbd_state_init(dcl.con);
> > +        if (@available(macOS 14, *)) {
> > +            [self setClipsToBounds:YES];
> > +        }
> >
> >       }
> >       return self;
> >
>
> Hi David!
>
> While the code change is tiny, I for one know nothing about MacOS and
> its cocoa thing, so to me (with my trivial-patches hat on) this is a
> no-go.  I'd love to have a review from someone more knowlegeable in
> this area.

Mmm. Akihiko is the expert here, but I do notice that we don't
seem to be handling the "macos-version-specific" stuff in a
way we've done it before (we don't use @available elsewhere).

I did wonder if we could call the setClipsToBounds method unconditionally;
The release notes say
https://developer.apple.com/documentation/macos-release-notes/appkit-releas=
e-notes-for-macos-14#NSView
"This property is available back to macOS 10.9. This availability is
intended to allow code targeting older OSes to set this property to
true without guarding the setter in an availability check."

but I think that might only mean "you can do this building on a new
SDK that's targeting an old version", not "you can do this
when building on an older SDK" (at least judging from the
comments in the gitlab issue).

The other option would be to fix whatever it is that we're
presumably not getting right that means this default change
caused the bug. My guess is that we are in the case
"Confusing a view=E2=80=99s bounds and its dirty rect. The dirty rect
 passed to .drawRect() should be used to determine what to draw,
 not where to draw it. Use NSView.bounds when determining the
 layout of what your view draws."
But unless the fix for that is really obvious and easy I guess
that flipping the default back to its old value is the better
approach.

-- PMM

