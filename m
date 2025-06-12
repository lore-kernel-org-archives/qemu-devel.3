Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DCA2C61CE8
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Jun 2025 19:57:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPo2H-0002y7-Gc; Thu, 12 Jun 2025 15:56:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <oleg.tolmatcev@gmail.com>)
 id 1uPo2E-0002xu-4D
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 15:56:27 -0400
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <oleg.tolmatcev@gmail.com>)
 id 1uPo2B-00014o-DG
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 15:56:25 -0400
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-5534edc646dso1452368e87.1
 for <qemu-devel@nongnu.org>; Thu, 12 Jun 2025 12:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749758159; x=1750362959; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eCj99Y83HUP/mxDjehMSYoC7iB0U7Bd6ujdo97OVKVY=;
 b=J8JW8OKGUpqt9amKR0NLb2+dMUfLLJ4xrX8Aq5xBAUH7tIjMbh0oawiVML7y4xuI7Y
 xmiavWwJRUDZEhK2stdlPCwQO5d5OIfD4Bpk6hF3KhDmbwIRSNAKhpgbhb/yIhcV/H5h
 zOghgf3Y7pBFjMa/cUjKAxAUkaJ83OiNq+K4W2Np3lRAsy/KjtrRtSLsQdokRkNfYsdW
 6xUvxy0Q75HMLegbedvzJ2PH9CrFvAKidjflEtQP9/gURMNoaCI2jbcvSJLkSoFQQbaM
 UNereTtZZ5dnuMgURWd8yycFNh0/kJauvX2WMI/JxErjW7ZU94vPY/cLBgxNgSnfTuxP
 YFdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749758159; x=1750362959;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eCj99Y83HUP/mxDjehMSYoC7iB0U7Bd6ujdo97OVKVY=;
 b=m3iWvgsxqKAACb1es5FAuYvb8qFLt09lf5I3JmFctRY9HdfXt2KGvZ7Fi+ROMvtfMO
 r/dwnaDXt+cqEV4Q1h44iOOPdPMFRRSwvTbmua/0Ib9k7lW1trCECwSJM4Ua6e7TKD63
 v1JR0VZbiZ216orGvQYuidMPp1OGeumZ2kRCKRs8u/hHCBGTGAxFEj/6GqcahzldB0GE
 UVEcHwx70U+Aq/P42gzh8+ucxhop+uifnWoYAzx8bNsYnruF881SLLEZonhoKDXCPm0R
 sMhwpOKb6i/KbLF0k++GYuhuukuG6AtvGjEeK+imSpKySVxa/InmFKO1LnlaaizzCe1u
 bpGg==
X-Gm-Message-State: AOJu0YzsYK846Rlj7R5VsnjHyunKEVMdzCyDEcF6EMo4VRzqdnQQLBLV
 Xs+shMVytmcLx2paILYv7ULw340XIqmcwzGlF/OaKueBc1YF1YEYX/szi/f0VoTZaZqvwqqfESA
 6v5LqkmdS+sPsa4YsZWBIRkEQHdDKWsg=
X-Gm-Gg: ASbGncuVZl5aXF5G1lX2tE7Jmw3cltgKee216azRK4zIDqvFq/gmAgTF6FW0GvEH8SY
 uK4SjvXxnampNuL5jIZ2KIdLO3sFzjLrjOVxODXXQl9NWou1tesvEKhJEnr78zfIwOOIvcpXB3z
 QhcsmN3xmwB6XKux/JBPPodT3U+K2urWFewubZg/Zr0LBp8kgs5zmkDNRjpgAeQbA0rQMWtFNJA
 A==
X-Google-Smtp-Source: AGHT+IHhVIHarwKRzOvoWRmIjPSK2PKuM567itMMQS4iIH+Baph56UaWcXp7y+ah/liku9ZpU6LB7QU8tn3IjFHhjqE=
X-Received: by 2002:a05:6512:1598:b0:553:296b:a62 with SMTP id
 2adb3069b0e04-553af92f3b5mr117426e87.12.1749758158762; Thu, 12 Jun 2025
 12:55:58 -0700 (PDT)
MIME-Version: 1.0
References: <20250607094503.1307-2-oleg.tolmatcev@gmail.com>
 <CAJSP0QXOiaYWo-s8V7tRRBdyzJTCruY5ufvu9zyNPm9ZQR1SrQ@mail.gmail.com>
In-Reply-To: <CAJSP0QXOiaYWo-s8V7tRRBdyzJTCruY5ufvu9zyNPm9ZQR1SrQ@mail.gmail.com>
From: Oleg Tolmatcev <oleg.tolmatcev@gmail.com>
Date: Thu, 12 Jun 2025 21:55:46 +0200
X-Gm-Features: AX0GCFt3NcXCOw4MpNrBEPc9vkBMyigzOWPKJL7HRI_Ysn537lcObPM4VSCIZUY
Message-ID: <CACcXsZhwqiLcyuE6uQYTDqQqJucC1FQfXOCNSPwSQKvuEjBCcg@mail.gmail.com>
Subject: Re: [PATCH RESEND v3] meson: fix Windows build
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, 
 Mads Ynddal <mads@ynddal.dk>, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::12b;
 envelope-from=oleg.tolmatcev@gmail.com; helo=mail-lf1-x12b.google.com
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

Am Do., 12. Juni 2025 um 21:35 Uhr schrieb Stefan Hajnoczi <stefanha@gmail.=
com>:
>
> On Sat, Jun 7, 2025 at 5:47=E2=80=AFAM oltolm <oleg.tolmatcev@gmail.com> =
wrote:
> >
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
> >
> >    # then use dlltool to assemble a delaylib.
> >    # The delaylib will have an "imaginary" name (qemu.exe), that is use=
d by the
> > diff --git a/scripts/tracetool/__init__.py b/scripts/tracetool/__init__=
.py
> > index bc03238c0..6dfcbf71e 100644
> > --- a/scripts/tracetool/__init__.py
> > +++ b/scripts/tracetool/__init__.py
> > @@ -12,12 +12,14 @@
> >  __email__      =3D "stefanha@redhat.com"
> >
> >
> > +import os
> >  import re
> >  import sys
> >  import weakref
> > +from pathlib import PurePath
> >
> > -import tracetool.format
> >  import tracetool.backend
> > +import tracetool.format
> >
> >
> >  def error_write(*lines):
> > @@ -36,7 +38,7 @@ def error(*lines):
> >
> >  def out_open(filename):
> >      global out_filename, out_fobj
> > -    out_filename =3D filename
> > +    out_filename =3D posix_relpath(filename)
> >      out_fobj =3D open(filename, 'wt')
> >
> >  def out(*lines, **kwargs):
> > @@ -308,7 +310,7 @@ def build(line_str, lineno, filename):
> >              fmt =3D [fmt_trans, fmt]
> >          args =3D Arguments.build(groups["args"])
> >
> > -        return Event(name, props, fmt, args, lineno, filename)
> > +        return Event(name, props, fmt, args, lineno, posix_relpath(fil=
ename))
> >
> >      def __repr__(self):
> >          """Evaluable string representation for this object."""
> > @@ -447,3 +449,10 @@ def generate(events, group, format, backends,
> >      tracetool.backend.dtrace.PROBEPREFIX =3D probe_prefix
> >
> >      tracetool.format.generate(events, format, backend, group)
> > +
> > +def posix_relpath(path, start=3DNone):
> > +    try:
> > +        path =3D os.path.relpath(path, start)
> > +    except ValueError:
> > +        pass
> > +    return PurePath(path).as_posix()
> > diff --git a/scripts/tracetool/backend/ftrace.py b/scripts/tracetool/ba=
ckend/ftrace.py
> > index baed2ae61..5fa30ccc0 100644
> > --- a/scripts/tracetool/backend/ftrace.py
> > +++ b/scripts/tracetool/backend/ftrace.py
> > @@ -12,8 +12,6 @@
> >  __email__      =3D "stefanha@redhat.com"
> >
> >
> > -import os.path
> > -
> >  from tracetool import out
> >
> >
> > @@ -47,7 +45,7 @@ def generate_h(event, group):
> >          args=3Devent.args,
> >          event_id=3D"TRACE_" + event.name.upper(),
> >          event_lineno=3Devent.lineno,
> > -        event_filename=3Dos.path.relpath(event.filename),
> > +        event_filename=3Devent.filename,
> >          fmt=3Devent.fmt.rstrip("\n"),
> >          argnames=3Dargnames)
> >
> > diff --git a/scripts/tracetool/backend/log.py b/scripts/tracetool/backe=
nd/log.py
> > index de27b7e62..17ba1cd90 100644
> > --- a/scripts/tracetool/backend/log.py
> > +++ b/scripts/tracetool/backend/log.py
> > @@ -12,8 +12,6 @@
> >  __email__      =3D "stefanha@redhat.com"
> >
> >
> > -import os.path
> > -
> >  from tracetool import out
> >
> >
> > @@ -55,7 +53,7 @@ def generate_h(event, group):
> >          '    }',
> >          cond=3Dcond,
> >          event_lineno=3Devent.lineno,
> > -        event_filename=3Dos.path.relpath(event.filename),
> > +        event_filename=3Devent.filename,
> >          name=3Devent.name,
> >          fmt=3Devent.fmt.rstrip("\n"),
> >          argnames=3Dargnames)
> > diff --git a/scripts/tracetool/backend/syslog.py b/scripts/tracetool/ba=
ckend/syslog.py
> > index 012970f6c..5a3a00fe3 100644
> > --- a/scripts/tracetool/backend/syslog.py
> > +++ b/scripts/tracetool/backend/syslog.py
> > @@ -12,8 +12,6 @@
> >  __email__      =3D "stefanha@redhat.com"
> >
> >
> > -import os.path
> > -
> >  from tracetool import out
> >
> >
> > @@ -43,7 +41,7 @@ def generate_h(event, group):
> >          '    }',
> >          cond=3Dcond,
> >          event_lineno=3Devent.lineno,
> > -        event_filename=3Dos.path.relpath(event.filename),
> > +        event_filename=3Devent.filename,
> >          name=3Devent.name,
> >          fmt=3Devent.fmt.rstrip("\n"),
> >          argnames=3Dargnames)
> > diff --git a/tests/functional/meson.build b/tests/functional/meson.buil=
d
> > index 52b4706cf..ee222888f 100644
> > --- a/tests/functional/meson.build
> > +++ b/tests/functional/meson.build
> > @@ -411,6 +411,4 @@ foreach speed : ['quick', 'thorough']
> >    endforeach
> >  endforeach
> >
> > -run_target('precache-functional',
> > -           depends: precache_all,
> > -           command: ['true'])
> > +alias_target('precache-functional', precache_all)
>
> Hi Oleg,
> There is a CI hexagon build failure. Maybe precache_all is []:
> ../tests/functional/meson.build:417:0: ERROR: alias_target takes at
> least 2 arguments, but got 1.
>
> https://gitlab.com/qemu-project/qemu/-/jobs/10336566320#L4267
>
> Please take a look. Thanks!

Hi Stefan,

this should be replaced with

run_target('precache-functional',
           depends: precache_all,
           command: [python, '-c', ''])

Should I send a v4 of my patch?

Oleg

