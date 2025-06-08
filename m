Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 198DEC5AD49
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Jun 2025 08:20:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOBGO-0000Z8-7p; Sun, 08 Jun 2025 04:20:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <oleg.tolmatcev@gmail.com>)
 id 1uOBGL-0000YJ-VH
 for qemu-devel@nongnu.org; Sun, 08 Jun 2025 04:20:18 -0400
Received: from mail-lj1-x232.google.com ([2a00:1450:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <oleg.tolmatcev@gmail.com>)
 id 1uOBGA-0008HQ-61
 for qemu-devel@nongnu.org; Sun, 08 Jun 2025 04:20:17 -0400
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-32a72cb7e4dso32229971fa.0
 for <qemu-devel@nongnu.org>; Sun, 08 Jun 2025 01:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749370804; x=1749975604; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UgKQiuggoUk9E0kKs0i87d5sCG+2bdwKjkdLVrKjcFE=;
 b=g/MrOuWRxz2SHY8/ToIsoVD/bkaaqaeBVhh6D168WM5OI9XObgxie46Mxot0ppp2Mu
 zchHth8TRjhiwDmsA7O/hBYepOuSOM2XDHDFkG8xGBRMdW0beNaaPmQf4yX6536iNUQE
 GgDALMxYdceuT896JKv7Zv90DvPo3kinW+MKG2zYYDzsNJqD2/N93tPMpLuj2DSvymWE
 bbpX7JWEEHdju4/75MssRObiiaFy9zPP7nyb6uFp1c9c5ZpTZwEhNb5iO0+0Xb2ZJCOl
 s9q0DjkONmKK4hTBIDdCOIQOz5lIIGwZJCvq8Kxyg3M6hqxzNftoU77yiyeMTOgp0K4O
 5QtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749370804; x=1749975604;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UgKQiuggoUk9E0kKs0i87d5sCG+2bdwKjkdLVrKjcFE=;
 b=w4iNTTNc13TpHjlKDrvXRfP3V9a3KpO23tcoilzDOcCwino5DrvasJv/ZRu6gIXkC6
 rrKTvnZa1QeDOg7M6GBKPKFB5KxZC60zshNONNa4vavib0SNXUcrGip6oLGqhPtE28Lh
 qLldhDvYDXZF/1i82g0ZfXXUD+uLRC4QYfNH8abzKT9ftKLSCy+u6y+/fVkzGNK34Vql
 p/aTeCOYIRLa207fR6bFwuyI0zxcP4UKK/U3gMFWQi4dJxuXky3ExQDOUaBBPRkivDRk
 dgDEtkVhEtSKYXrtvB1R4ux/Yxbrz6dH+VXgVc25UikjxD+G3zyPaNfNpHyo86vbhBls
 dccg==
X-Gm-Message-State: AOJu0YyubQnfx3rTZlgwUpBEFuPjmaKUcxKOEPmIOWfp29cXJ5D+XpF9
 zOLjsjx3ywnsZ3WysxnA+t6PtqmTy4OmmG7X2GYQWRUzVU4H1CfkfF8Qu9PRvCUmdV9x+QabO/q
 leqvQ4o/M/lR9d4RtGMm5Zi0IC3XyhGQ=
X-Gm-Gg: ASbGncvGdADVLneh65TBk6gZXNc9wdh3VJLYLpuBiwcD7EjwG0l0HCpcKCHuXEIE5qB
 Dw7JZGyLzRDfMSlvYcYcDLehGvc86ikagQyEfOvzW+Fbcqeer5+8ME0P8FoeHol3NeU1gfO7XHE
 zAG/kMrKUYztCejEjfRwUFrTj41jPwILGeJ8MvXDfGkmeZNtz6TS4bVfYjRzLfXs60
X-Google-Smtp-Source: AGHT+IG9qyoEy+QUT2gWR8852lB5bvIErtvca2pzG4EAjXRJtiu4WXrRb3TpiOQp125QJPVUNWt6RWvqnT3XWbEwEk4=
X-Received: by 2002:a2e:a545:0:b0:32a:7951:554 with SMTP id
 38308e7fff4ca-32adfc7fee4mr22072851fa.11.1749370803594; Sun, 08 Jun 2025
 01:20:03 -0700 (PDT)
MIME-Version: 1.0
References: <20250607094503.1307-2-oleg.tolmatcev@gmail.com>
 <20250607191226.GA554948@fedora>
In-Reply-To: <20250607191226.GA554948@fedora>
From: Oleg Tolmatcev <oleg.tolmatcev@gmail.com>
Date: Sun, 8 Jun 2025 10:19:51 +0200
X-Gm-Features: AX0GCFsBpYZibYMr4N8y6n6lva0oP7E3SSZ5VUu3oL-tVJuHPuT49BY0h1XiZCI
Message-ID: <CACcXsZgGtXLTZg2yev6Z6rMEiuabu-h9EBxwoQz=-QH+Ye6NHw@mail.gmail.com>
Subject: Re: [PATCH RESEND v3] meson: fix Windows build
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Mads Ynddal <mads@ynddal.dk>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::232;
 envelope-from=oleg.tolmatcev@gmail.com; helo=mail-lj1-x232.google.com
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

Am Sa., 7. Juni 2025 um 21:12 Uhr schrieb Stefan Hajnoczi <stefanha@redhat.=
com>:
>
> On Sat, Jun 07, 2025 at 11:45:04AM +0200, oltolm wrote:
> > Sorry, I forgot to cc the maintainers.
> >
> > The build failed when run on Windows. I replaced calls to Unix programs
> > like =C2=B4cat=C2=B4, =C2=B4sed=C2=B4 and =C2=B4true=C2=B4 with calls t=
o =C2=B4python=C2=B4. I wrapped calls to
> > =C2=B4os.path.relpath=C2=B4 in try-except because it can fail when the =
two paths
> > are on different drives. I made sure to convert the Windows paths to
> > Unix paths to prevent warnings in generated files.
> >
> > Signed-off-by: oltolm <oleg.tolmatcev@gmail.com>
> > ---
> >  contrib/plugins/meson.build         |  2 +-
> >  plugins/meson.build                 |  2 +-
> >  scripts/tracetool/__init__.py       | 15 ++++++++++++---
> >  scripts/tracetool/backend/ftrace.py |  4 +---
> >  scripts/tracetool/backend/log.py    |  4 +---
> >  scripts/tracetool/backend/syslog.py |  4 +---
> >  tests/functional/meson.build        |  4 +---
> >  tests/include/meson.build           |  2 +-
> >  tests/tcg/plugins/meson.build       |  2 +-
> >  trace/meson.build                   |  5 +++--
> >  10 files changed, 23 insertions(+), 21 deletions(-)
> >
> > diff --git a/contrib/plugins/meson.build b/contrib/plugins/meson.build
> > index fa8a426c8..1876bc784 100644
> > --- a/contrib/plugins/meson.build
> > +++ b/contrib/plugins/meson.build
> > @@ -24,7 +24,7 @@ endif
> >  if t.length() > 0
> >    alias_target('contrib-plugins', t)
> >  else
> > -  run_target('contrib-plugins', command: find_program('true'))
> > +  run_target('contrib-plugins', command: [python, '-c', ''])
> >  endif
> >
> >  plugin_modules +=3D t
> > diff --git a/plugins/meson.build b/plugins/meson.build
> > index 5383c7b88..cb7472df8 100644
> > --- a/plugins/meson.build
> > +++ b/plugins/meson.build
> > @@ -33,7 +33,7 @@ if host_os =3D=3D 'windows'
> >      input: qemu_plugin_symbols,
> >      output: 'qemu_plugin_api.def',
> >      capture: true,
> > -    command: ['sed', '-e', '0,/^/s//EXPORTS/; s/[{};]//g', '@INPUT@'])
> > +    command: [python, '-c', 'import fileinput, re; print("EXPORTS", en=
d=3D""); [print(re.sub(r"[{};]", "", line), end=3D"") for line in fileinput=
.input()]', '@INPUT@'])
>
> On second thought, is print("EXPORTS", end=3D"") correct? Unlike the line=
s
> coming from fileinput, there is no line ending. I though that .def files
> look like this:
>
> EXPORTS
>   ...
>   ...
>
> So maybe end=3D"" should be dropped for EXPORTS to correctly format the
> .def file?
>
> (I didn't have a Windows build environment to check myself, but it
> should be easy to diff the before/after files to verify whether there
> are any changes.)

I already did that. It produces the same output.
Oleg

