Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57F1DC71136
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Jun 2025 19:55:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPRWn-0005rH-4o; Wed, 11 Jun 2025 15:54:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1uPRWg-0005qs-Em
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 15:54:22 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1uPRWe-0004Y3-8I
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 15:54:22 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-ad883afdf0cso47070066b.0
 for <qemu-devel@nongnu.org>; Wed, 11 Jun 2025 12:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749671658; x=1750276458; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lwacJSlUX5SZ729sUvmr49ypnB+xPnmQTOkglly6cRo=;
 b=WUu57O1fMAffuRMdej7arLokZOZetH3tFHZV2KV4ooZ6CX9mbdTj1BwVn4zkbHJKrO
 bENi0VnYHTl2buqk1mvRF0+Mshg7MMIoH9YNALvymf048mAiDkFDrPOTO8XZjpBO6L26
 05xDh2eV1ZNBiKTJen8GkZcc+xtCp+Zx8vXMdcXQ5yJgWfYsGuyGYd0bQCNYwgaIOr7O
 EJUv6M3gC9DWb7sfCF/bN21mKJR00W7AZqcDIl5FsnZCj+Gep+uP9mrbeMvMzCHjSkxZ
 HhJ11VnYEIhbrZQicgKnVV72oQ3IaYdAIso7lcHARXKrLGINj7CmcTGpyij02m0tDq/S
 hTDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749671658; x=1750276458;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lwacJSlUX5SZ729sUvmr49ypnB+xPnmQTOkglly6cRo=;
 b=ioj0toawdELz7W5pD7R7QouojUtYBZNvmxbqLJckeELlpNuGUeNnTpGZ3MinieIP8O
 r9DzYlT0uNervnqWUL/xj8HEYY27Jsf/qfXh46HKu/ZdlS9RS/jxxQpC9nz88HtEddyX
 gNJ7Rr1UEBVlpLVA0830M8JeT8ueMokr7FXWMimP63uhEiSZ3+/USJufkXGg8pRIJq9n
 JBnuseFUxa5t1SC0LQBzbCxBbVcB1pILsPwwYrUfHzlH83wxnHVZdWCrRqsPdU7hFoKd
 zjHEi+5RJzkgmZCt4XbEPVe9iubmgDGFcneB1L1JFtg+DtJ2JybYjr7D/QtuN4QBi/yN
 aokw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWFLgXsWWWOl2xp1/fMgD9AICuf1JvhE5u7sok3w8IKyb50wgDM9U1zUWz6CqKHGdndcqC6uRYQ+GDX@nongnu.org
X-Gm-Message-State: AOJu0YwUDRk0vdONT0c32mMZfHBxM8lr1gMU7MHVFUu+PuCv8lzY6Uo7
 BabpWCuokwd2xbUaSMVEpb8YH9DsuvbAjuiwD9IWIEuWTFEnwmt1PFTmpZ5emYqF4cUN1/W8HWj
 EjazF00y2yRc1NK2ZnMIggK87f4naw4c=
X-Gm-Gg: ASbGnctAO0UiSE6edYUlJgQoR349CuUirCE6Q6XZOfgCw7ucEsDEsknm7sPRBJAbE3U
 wh3KiIB7aRplg6VX1syu5S+RiVUuJYyFqDk/72fP5DcL1GVV5h03NzzFQPi7lxHnhOS2eIHW6HQ
 7OpXPityOXvnAijOeLTGP5rnLdsEc5z+W01G0jbEKhCA==
X-Google-Smtp-Source: AGHT+IHat96TmOBQgKWPE2CKBdN1r+/nMzF33WtX4IW2O+GodewqR2KPZE8BM1Yb4ntZYA1qLNoJi9HFMVu9MJic8yI=
X-Received: by 2002:a17:907:3fa9:b0:ad5:1bfd:30d2 with SMTP id
 a640c23a62f3a-adea378c9d5mr96102866b.55.1749671658262; Wed, 11 Jun 2025
 12:54:18 -0700 (PDT)
MIME-Version: 1.0
References: <20250611182902.201331-1-stefanha@redhat.com>
 <20250611182902.201331-2-stefanha@redhat.com>
 <alpine.LMD.2.03.2506112113260.22610@eik.bme.hu>
In-Reply-To: <alpine.LMD.2.03.2506112113260.22610@eik.bme.hu>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 11 Jun 2025 15:54:06 -0400
X-Gm-Features: AX0GCFvdwnF7m3cPZq_yPTTSQ7MWGlHjezNqqB-m1ooBhskTbZPje1OX3pymdL8
Message-ID: <CAJSP0QVWQLK+5Z4DiNVDaz2-YtUUDYRj+roq9rwRS8ZVWYMKBg@mail.gmail.com>
Subject: Re: [PULL 1/1] meson: fix Windows build
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, 
 Mahmoud Mandour <ma.mandourr@gmail.com>, Mads Ynddal <mads@ynddal.dk>, 
 Alexandre Iooss <erdnaxe@crans.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 oltolm <oleg.tolmatcev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=stefanha@gmail.com; helo=mail-ej1-x62f.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FREEMAIL_REPLY=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Wed, Jun 11, 2025 at 3:25=E2=80=AFPM BALATON Zoltan <balaton@eik.bme.hu>=
 wrote:
>
> On Wed, 11 Jun 2025, Stefan Hajnoczi wrote:
> > From: oltolm <oleg.tolmatcev@gmail.com>
> >
> > Sorry, I forgot to cc the maintainers.
>
> Do we want comments like this end up in git log? This could have been
> fixed before a pull. Also the other pull request about uninitialised stac=
k
> variables had hw/audio/gus twice which was pointed out by a comment befor=
e
> the pull that one of those should be different but the pull request still
> had this error. Did you miss these or aren't these important enough to fi=
x
> before getting in git log forever or there is just no easy way to fix up
> commit messages in pull requests?

If another reviewer asks for the author to resend then I'll hold off
on merging, but I didn't see the comment about hw/audio/gus. Sorry!

I did see this "Sorry, I forgot to cc the maintainers" comment.
Although I'm not consistent, nowadays I generally do not fix these
issues when merging, provided it's a small issue that can be ignored
or understood from the context.

I don't really mind either way, so if there is a consensus that all
maintainers should be strict about this, I'm happy to join.

One related point I do have a strong opinion on is that the
qemu.git/master maintainer shouldn't be expected to do fixups on a
pull request they receive. Fixups should be done by subsystem
maintainers (and the pull request must be resent) or the original
patch authors. It doesn't scale when the qemu.git/master maintainer
has to make changes to code that they are unfamiliar with. That's not
the case here, but I just wanted to mention it because from time to
time someone requests this.

>
> Regards,
> BALATON Zoltan
>
> > The build failed when run on Windows. I replaced calls to Unix programs
> > like =C2=B4cat=C2=B4, =C2=B4sed=C2=B4 and =C2=B4true=C2=B4 with calls t=
o =C2=B4python=C2=B4. I wrapped calls to
> > =C2=B4os.path.relpath=C2=B4 in try-except because it can fail when the =
two paths
> > are on different drives. I made sure to convert the Windows paths to
> > Unix paths to prevent warnings in generated files.
> >
> > Signed-off-by: oltolm <oleg.tolmatcev@gmail.com>
> > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> > Acked-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> > Message-id: 20250607094503.1307-2-oleg.tolmatcev@gmail.com
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> > contrib/plugins/meson.build         |  2 +-
> > plugins/meson.build                 |  2 +-
> > scripts/tracetool/__init__.py       | 15 ++++++++++++---
> > scripts/tracetool/backend/ftrace.py |  4 +---
> > scripts/tracetool/backend/log.py    |  4 +---
> > scripts/tracetool/backend/syslog.py |  4 +---
> > tests/functional/meson.build        |  4 +---
> > tests/include/meson.build           |  2 +-
> > tests/tcg/plugins/meson.build       |  2 +-
> > trace/meson.build                   |  5 +++--
> > 10 files changed, 23 insertions(+), 21 deletions(-)
> >
> > diff --git a/contrib/plugins/meson.build b/contrib/plugins/meson.build
> > index fa8a426c8b..1876bc7843 100644
> > --- a/contrib/plugins/meson.build
> > +++ b/contrib/plugins/meson.build
> > @@ -24,7 +24,7 @@ endif
> > if t.length() > 0
> >   alias_target('contrib-plugins', t)
> > else
> > -  run_target('contrib-plugins', command: find_program('true'))
> > +  run_target('contrib-plugins', command: [python, '-c', ''])
> > endif
> >
> > plugin_modules +=3D t
> > diff --git a/plugins/meson.build b/plugins/meson.build
> > index b20edfbabc..62c991d87f 100644
> > --- a/plugins/meson.build
> > +++ b/plugins/meson.build
> > @@ -33,7 +33,7 @@ if host_os =3D=3D 'windows'
> >     input: qemu_plugin_symbols,
> >     output: 'qemu_plugin_api.def',
> >     capture: true,
> > -    command: ['sed', '-e', '0,/^/s//EXPORTS/; s/[{};]//g', '@INPUT@'])
> > +    command: [python, '-c', 'import fileinput, re; print("EXPORTS", en=
d=3D""); [print(re.sub(r"[{};]", "", line), end=3D"") for line in fileinput=
.input()]', '@INPUT@'])
> >
> >   # then use dlltool to assemble a delaylib.
> >   # The delaylib will have an "imaginary" name (qemu.exe), that is used=
 by the
> > diff --git a/scripts/tracetool/__init__.py b/scripts/tracetool/__init__=
.py
> > index bc03238c0f..6dfcbf71e1 100644
> > --- a/scripts/tracetool/__init__.py
> > +++ b/scripts/tracetool/__init__.py
> > @@ -12,12 +12,14 @@
> > __email__      =3D "stefanha@redhat.com"
> >
> >
> > +import os
> > import re
> > import sys
> > import weakref
> > +from pathlib import PurePath
> >
> > -import tracetool.format
> > import tracetool.backend
> > +import tracetool.format
> >
> >
> > def error_write(*lines):
> > @@ -36,7 +38,7 @@ def error(*lines):
> >
> > def out_open(filename):
> >     global out_filename, out_fobj
> > -    out_filename =3D filename
> > +    out_filename =3D posix_relpath(filename)
> >     out_fobj =3D open(filename, 'wt')
> >
> > def out(*lines, **kwargs):
> > @@ -308,7 +310,7 @@ def build(line_str, lineno, filename):
> >             fmt =3D [fmt_trans, fmt]
> >         args =3D Arguments.build(groups["args"])
> >
> > -        return Event(name, props, fmt, args, lineno, filename)
> > +        return Event(name, props, fmt, args, lineno, posix_relpath(fil=
ename))
> >
> >     def __repr__(self):
> >         """Evaluable string representation for this object."""
> > @@ -447,3 +449,10 @@ def generate(events, group, format, backends,
> >     tracetool.backend.dtrace.PROBEPREFIX =3D probe_prefix
> >
> >     tracetool.format.generate(events, format, backend, group)
> > +
> > +def posix_relpath(path, start=3DNone):
> > +    try:
> > +        path =3D os.path.relpath(path, start)
> > +    except ValueError:
> > +        pass
> > +    return PurePath(path).as_posix()
> > diff --git a/scripts/tracetool/backend/ftrace.py b/scripts/tracetool/ba=
ckend/ftrace.py
> > index baed2ae61c..5fa30ccc08 100644
> > --- a/scripts/tracetool/backend/ftrace.py
> > +++ b/scripts/tracetool/backend/ftrace.py
> > @@ -12,8 +12,6 @@
> > __email__      =3D "stefanha@redhat.com"
> >
> >
> > -import os.path
> > -
> > from tracetool import out
> >
> >
> > @@ -47,7 +45,7 @@ def generate_h(event, group):
> >         args=3Devent.args,
> >         event_id=3D"TRACE_" + event.name.upper(),
> >         event_lineno=3Devent.lineno,
> > -        event_filename=3Dos.path.relpath(event.filename),
> > +        event_filename=3Devent.filename,
> >         fmt=3Devent.fmt.rstrip("\n"),
> >         argnames=3Dargnames)
> >
> > diff --git a/scripts/tracetool/backend/log.py b/scripts/tracetool/backe=
nd/log.py
> > index de27b7e62e..17ba1cd90e 100644
> > --- a/scripts/tracetool/backend/log.py
> > +++ b/scripts/tracetool/backend/log.py
> > @@ -12,8 +12,6 @@
> > __email__      =3D "stefanha@redhat.com"
> >
> >
> > -import os.path
> > -
> > from tracetool import out
> >
> >
> > @@ -55,7 +53,7 @@ def generate_h(event, group):
> >         '    }',
> >         cond=3Dcond,
> >         event_lineno=3Devent.lineno,
> > -        event_filename=3Dos.path.relpath(event.filename),
> > +        event_filename=3Devent.filename,
> >         name=3Devent.name,
> >         fmt=3Devent.fmt.rstrip("\n"),
> >         argnames=3Dargnames)
> > diff --git a/scripts/tracetool/backend/syslog.py b/scripts/tracetool/ba=
ckend/syslog.py
> > index 012970f6cc..5a3a00fe31 100644
> > --- a/scripts/tracetool/backend/syslog.py
> > +++ b/scripts/tracetool/backend/syslog.py
> > @@ -12,8 +12,6 @@
> > __email__      =3D "stefanha@redhat.com"
> >
> >
> > -import os.path
> > -
> > from tracetool import out
> >
> >
> > @@ -43,7 +41,7 @@ def generate_h(event, group):
> >         '    }',
> >         cond=3Dcond,
> >         event_lineno=3Devent.lineno,
> > -        event_filename=3Dos.path.relpath(event.filename),
> > +        event_filename=3Devent.filename,
> >         name=3Devent.name,
> >         fmt=3Devent.fmt.rstrip("\n"),
> >         argnames=3Dargnames)
> > diff --git a/tests/functional/meson.build b/tests/functional/meson.buil=
d
> > index 557d59ddf4..4bce961c04 100644
> > --- a/tests/functional/meson.build
> > +++ b/tests/functional/meson.build
> > @@ -412,6 +412,4 @@ foreach speed : ['quick', 'thorough']
> >   endforeach
> > endforeach
> >
> > -run_target('precache-functional',
> > -           depends: precache_all,
> > -           command: ['true'])
> > +alias_target('precache-functional', precache_all)
> > diff --git a/tests/include/meson.build b/tests/include/meson.build
> > index 9abba308fa..8e8d1ec4e6 100644
> > --- a/tests/include/meson.build
> > +++ b/tests/include/meson.build
> > @@ -13,4 +13,4 @@ test_qapi_outputs_extra =3D [
> > test_qapi_files_extra =3D custom_target('QAPI test (include)',
> >                                       output: test_qapi_outputs_extra,
> >                                       input: test_qapi_files,
> > -                                      command: 'true')
> > +                                      command: [python, '-c', ''])
> > diff --git a/tests/tcg/plugins/meson.build b/tests/tcg/plugins/meson.bu=
ild
> > index 41f02f2c7f..029342282a 100644
> > --- a/tests/tcg/plugins/meson.build
> > +++ b/tests/tcg/plugins/meson.build
> > @@ -17,7 +17,7 @@ endif
> > if t.length() > 0
> >   alias_target('test-plugins', t)
> > else
> > -  run_target('test-plugins', command: find_program('true'))
> > +  run_target('test-plugins', command: [python, '-c', ''])
> > endif
> >
> > plugin_modules +=3D t
> > diff --git a/trace/meson.build b/trace/meson.build
> > index 3df4549355..9c42a57a05 100644
> > --- a/trace/meson.build
> > +++ b/trace/meson.build
> > @@ -4,7 +4,7 @@ trace_events_files =3D []
> > foreach item : [ '.' ] + trace_events_subdirs + qapi_trace_events
> >   if item in qapi_trace_events
> >     trace_events_file =3D item
> > -    group_name =3D item.full_path().split('/')[-1].underscorify()
> > +    group_name =3D fs.name(item).underscorify()
> >   else
> >     trace_events_file =3D meson.project_source_root() / item / 'trace-e=
vents'
> >     group_name =3D item =3D=3D '.' ? 'root' : item.underscorify()
> > @@ -57,10 +57,11 @@ foreach item : [ '.' ] + trace_events_subdirs + qap=
i_trace_events
> >   endif
> > endforeach
> >
> > +cat =3D [ python, '-c', 'import fileinput; [print(line, end=3D"") for =
line in fileinput.input()]', '@INPUT@' ]
> > trace_events_all =3D custom_target('trace-events-all',
> >                                  output: 'trace-events-all',
> >                                  input: trace_events_files,
> > -                                 command: [ 'cat', '@INPUT@' ],
> > +                                 command: cat,
> >                                  capture: true,
> >                                  install: get_option('trace_backends') =
!=3D [ 'nop' ],
> >                                  install_dir: qemu_datadir)
> > --
> > 2.49.0
> >
> >
> >

