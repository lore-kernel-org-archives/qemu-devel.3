Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A910C83F1A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 10:04:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucLSR-00086V-Mw; Thu, 17 Jul 2025 06:03:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1ucLSN-0007oo-UL
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 06:03:16 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1ucLSK-0005Z8-Ge
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 06:03:15 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-60cc11b34f6so3261370a12.0
 for <qemu-devel@nongnu.org>; Thu, 17 Jul 2025 03:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752746591; x=1753351391; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bfiB4FvivwgjEaoJFs9pRVBF97YQoqGaogphl7f5nl4=;
 b=Dnl0ckJMpRafsY0tpr/itXN9kSGObYqzwXhX5SFAmwVZuu9VqUAGhjW7chFlG5C5jz
 3oBkTzB+lcOlH8jwz7Dw+ECmSVkpfpXIP8QDBDtTCf0FVT/Uif3eA8aR5fq/N2+pjpuF
 TQaQzkZ+JPvzVKhl+dnh1zb+1M4iwr1DZhHtAGtKVkak2pBhJ/MMhVWnlVc6IkyZNz/L
 gsqGUYRwmuUnEJiC88kYCDhaXjVQRE2zfCkEPPZurtJZqJLcrufgvSOr86Tl0e7XLaBw
 kUkoQ9DALfbD1TkH6OoyZn6edUmFNywCj1WghW4LbWczf/cR9UtN2+Kn2W16eSZ2Q5p6
 xp/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752746591; x=1753351391;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bfiB4FvivwgjEaoJFs9pRVBF97YQoqGaogphl7f5nl4=;
 b=WRfEgCSeZY6RixuVhBbgwLkvMKpJUCGBCmkDLUArX97y7xueTkSnCW/ag0gBDgkaNO
 0JXWq/oKfbvm5eNtihI4cFBS557AX7BfwGKXpNPwQq/qMLDes2COrGHdn+3bjvh6eS0I
 iL6A/uW9paEDBl3Mg49SjPDJiJcSPjvzpBnzVNRXJHUUQHKiq2ASUhR4Jd+TINdOaHpq
 JSNHyegPUfBsThk698y3tQwEOnXHvEpRIvxkmikMsnvri+6mGoOFqwEfqTfuLnRRcmys
 k1DKeb9VXZGarbM4awP+w0QmMfTar2JJBe6Y+CgTodmWwSuHI6DcXw2j0DyGAD1ok3nZ
 i+ng==
X-Gm-Message-State: AOJu0YyfZ8LcmRddOmRKLuLQ2FtgqjJnB8Na2x850F1Mr8hMW+1vuF5k
 1Vdn0WjJ/tO5hRFEUyC4qhtbSnlSNd3zQudexkCzjD8bUAcT5dHMqp9xSoswV/BJrYK0g3UyzWy
 RdHF0leZTi3OFvegjUvB4T5C66sYquwQQJJjxVe8/sg==
X-Gm-Gg: ASbGncug6K1LGOpaTvZHpDxBCT4nIio5WiRBkEOUXHRbDjTlc6mBAdjEY4+GtmjN5U0
 DpgIj0KcATY0wrQojmos+R+l8FVLvMXp60VPfqZRAn/U7SBstyePkb9kRdUJsRBBJpbJPXuAkub
 ShXpt36KeYvfVAKWMA0Q0AWhCmYABZv35PQeXqDB6mRqn+86N5WAE+fqyUXMvEmzvn3poluDkuH
 WIWeg==
X-Google-Smtp-Source: AGHT+IEJ4wcIuene4Si/sMX8XeVIyQ0/A0HpFOdCJJSF9frj93LdHEaYmgxb0sQnhJxX1ODBgRNhNujGJaxe0dgP310=
X-Received: by 2002:a17:907:7e84:b0:ae0:6621:2f69 with SMTP id
 a640c23a62f3a-aec4d6108fcmr266957866b.13.1752746590389; Thu, 17 Jul 2025
 03:03:10 -0700 (PDT)
MIME-Version: 1.0
References: <20250716-functional_tests_debug_arg-v1-1-6a9cd68318bb@linaro.org>
 <aHjAsibYCOu0YuU3@redhat.com>
 <CAAjaMXY-fMJ9MFjOURct-zxPi8nCVraoxjgy+A960zHD-iFu1A@mail.gmail.com>
 <aHjEyGGROGrEBgGs@redhat.com>
In-Reply-To: <aHjEyGGROGrEBgGs@redhat.com>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Thu, 17 Jul 2025 13:02:44 +0300
X-Gm-Features: Ac12FXwNGf5kWQNLdKE2VxykfgwgXS2pgbP_FTwZyZRrJYPDkDEi40rh_ZtBRco
Message-ID: <CAAjaMXa_mTSeU9Wx+VaciMiT0LdxhCik9a0YiOKZD4=7n6d3Hw@mail.gmail.com>
Subject: Re: [PATCH] tests/functional: add --debug CLI arg
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x529.google.com
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

On Thu, Jul 17, 2025 at 12:39=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@=
redhat.com> wrote:
>
> On Thu, Jul 17, 2025 at 12:27:08PM +0300, Manos Pitsidianakis wrote:
> > On Thu, Jul 17, 2025 at 12:22=E2=80=AFPM Daniel P. Berrang=C3=A9 <berra=
nge@redhat.com> wrote:
> > >
> > > On Wed, Jul 16, 2025 at 09:08:00AM +0300, Manos Pitsidianakis wrote:
> > > > Add argument parsing to functional tests to improve developer exper=
ience
> > > > when running individual tests. All logs are printed to stdout
> > > > interspersed with TAP output.
> > > >
> > > >   ./pyvenv/bin/python3 ../tests/functional/test_aarch64_virt.py --h=
elp
> > > >   usage: test_aarch64_virt [-h] [-d]
> > > >
> > > >   QEMU Functional test
> > > >
> > > >   options:
> > > >     -h, --help   show this help message and exit
> > > >     -d, --debug  Also print test and console logs on stdout. This w=
ill
> > > >                  make the TAP output invalid and is meant for debug=
ging
> > > >                  only.
> > > >
> > > > Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> > > > ---
> > > >  docs/devel/testing/functional.rst      |  2 ++
> > > >  tests/functional/qemu_test/testcase.py | 51 ++++++++++++++++++++++=
++++++++++--
> > > >  2 files changed, 50 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/docs/devel/testing/functional.rst b/docs/devel/testing=
/functional.rst
> > > > index 9e56dd1b1189216b9b4aede00174c15203f38b41..9d08abe2848277d635b=
efb0296f578cfaa4bd66d 100644
> > > > --- a/docs/devel/testing/functional.rst
> > > > +++ b/docs/devel/testing/functional.rst
> > > > @@ -63,6 +63,8 @@ directory should be your build folder. For exampl=
e::
> > > >    $ export QEMU_TEST_QEMU_BINARY=3D$PWD/qemu-system-x86_64
> > > >    $ pyvenv/bin/python3 ../tests/functional/test_file.py
> > > >
> > > > +By default, functional tests redirect informational logs and conso=
le output to
> > > > +log files. Specify the ``--debug`` flag to also print those to sta=
ndard output.
> > > >  The test framework will automatically purge any scratch files crea=
ted during
> > > >  the tests. If needing to debug a failed test, it is possible to ke=
ep these
> > > >  files around on disk by setting ```QEMU_TEST_KEEP_SCRATCH=3D1``` a=
s an env
> > > > diff --git a/tests/functional/qemu_test/testcase.py b/tests/functio=
nal/qemu_test/testcase.py
> > > > index 2082c6fce43b0544d4e4258cd4155f555ed30cd4..fad7a946c6677e9ef5c=
42b8f77187ba836c11aeb 100644
> > > > --- a/tests/functional/qemu_test/testcase.py
> > > > +++ b/tests/functional/qemu_test/testcase.py
> > > > @@ -11,6 +11,7 @@
> > > >  # This work is licensed under the terms of the GNU GPL, version 2 =
or
> > > >  # later.  See the COPYING file in the top-level directory.
> > > >
> > > > +import argparse
> > > >  import logging
> > > >  import os
> > > >  from pathlib import Path
> > > > @@ -31,6 +32,20 @@
> > > >  from .uncompress import uncompress
> > > >
> > > >
> > > > +def parse_args(test_name: str) -> argparse.Namespace:
> > > > +    parser =3D argparse.ArgumentParser(
> > > > +        prog=3Dtest_name, description=3D"QEMU Functional test"
> > > > +    )
> > > > +    parser.add_argument(
> > > > +        "-d",
> > > > +        "--debug",
> > > > +        action=3D"store_true",
> > > > +        help=3D"Also print test and console logs on stdout. This w=
ill make the"
> > > > +        " TAP output invalid and is meant for debugging only.",
> > > > +    )
> > > > +    return parser.parse_args()
> > > > +
> > > > +
> > > >  class QemuBaseTest(unittest.TestCase):
> > > >
> > > >      '''
> > > > @@ -196,6 +211,9 @@ def assets_available(self):
> > > >          return True
> > > >
> > > >      def setUp(self):
> > > > +        path =3D os.path.basename(sys.argv[0])[:-3]
> > > > +        args =3D parse_args(path)
> > >
> > > IMHO this is not code that belongs in setUp. Indeed, I don't think
> > > it belongs in this file at all, better have a helper for parsing
> > > args in 'utils', and expose a global 'debug_enabled' flag from utils
> > > that we can reference elsewhere.
> >
> > setUp is where the logs are setup, do you mean logs should be split
> > into another function/file altogether? Maybe out of scope for this
> > patch, I can another one that does it before adding the --debug
> > option. What do you think?
>
> I'm saying 'parse_args' should be in util.py
>
> > > > +        self.debug_output =3D args.debug
> > > >          self.qemu_bin =3D os.getenv('QEMU_TEST_QEMU_BINARY')
> > > >          self.assertIsNotNone(self.qemu_bin, 'QEMU_TEST_QEMU_BINARY=
 must be set')
> > > >          self.arch =3D self.qemu_bin.split('-')[-1]
> > > > @@ -221,6 +239,16 @@ def setUp(self):
> > > >          self.machinelog.setLevel(logging.DEBUG)
> > > >          self.machinelog.addHandler(self._log_fh)
> > > >
> > > > +        if self.debug_output:
> > > > +            handler =3D logging.StreamHandler(sys.stdout)
> > > > +            handler.setLevel(logging.DEBUG)
> > > > +            formatter =3D logging.Formatter(
> > > > +                "%(asctime)s - %(name)s - %(levelname)s - %(messag=
e)s"
> > > > +            )
> > > > +            handler.setFormatter(formatter)
> > > > +            self.log.addHandler(handler)
> > > > +            self.machinelog.addHandler(handler)
> > >
> > > There was already a lot of effectively duplicated code between
> > > this and the console_log stuff below. This new addition makes
> > > that duplication even more substantial, such that I think it
> > > all needs to be spun out into a helper method.
> >
> > Ditto
>
> This should be a method we can call like:
>
>   handlers =3D create_loggers("base.log", "qemu-test",
>                             "%(asctime)s - %(levelname)s - %(message)s")
>
> which is able to return multiple handlers. Initially it would just
> return the current "self.log_fh" handler, and then this patch would
> extend it to return a second handler for the console stream when
> '--debug' is set.
>
>
> > > > @@ -230,11 +258,16 @@ def tearDown(self):
> > > >          if self.socketdir is not None:
> > > >              shutil.rmtree(self.socketdir.name)
> > > >              self.socketdir =3D None
> > > > -        self.machinelog.removeHandler(self._log_fh)
> > > > -        self.log.removeHandler(self._log_fh)
> > > > +        for handler in [self._log_fh, logging.StreamHandler(sys.st=
dout)]:
> > >
> > > We should have stashed the original handler when created,
> > > rather than re-creating StreamHandler at time of removal.
> > > I'm kinda of surprised it even works to re-create it.
> >
> > It's the same file descriptor, after all. I'd be surprised if it didn't=
 work.
>
> log.removeHandler has no visibility of the file descriptiors.
>
> It will just compare the python handler object instances, which
> I very much doubt will match with this code
>

Hm probably, yeah. I will send a v2 that stores the handler.

Thanks,

--=20
Manos Pitsidianakis
Emulation and Virtualization Engineer at Linaro Ltd

