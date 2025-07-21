Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F190C83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 20:39:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udxHt-0002p8-41; Mon, 21 Jul 2025 16:39:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1udxHc-0002lk-Rl
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 16:38:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1udxHa-0007IC-FU
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 16:38:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753130324;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=32hBqsS59L4N5atbDma0XrKZqbh/7lW6YeMFmB3fWGk=;
 b=SxvSbKazO7kh7A+6GtslJqTFM/TG4fyLz32CgCc8VWoILgcXa8XBkaV/UXPOTwBw+WfJkR
 uRFqOgn84x4G4Q63Fbmok1MGSZYfR1SgBfZ7QZupzABwNyqrn10ABzptwdNQBVumaze8ZI
 KrjGXjvx8s2VZKvrDTEDFoExkBGXtOk=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-414-44u-SM9VO4mJezzh3G11dQ-1; Mon, 21 Jul 2025 16:38:41 -0400
X-MC-Unique: 44u-SM9VO4mJezzh3G11dQ-1
X-Mimecast-MFC-AGG-ID: 44u-SM9VO4mJezzh3G11dQ_1753130320
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-234fedd3e51so46408545ad.1
 for <qemu-devel@nongnu.org>; Mon, 21 Jul 2025 13:38:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753130320; x=1753735120;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=32hBqsS59L4N5atbDma0XrKZqbh/7lW6YeMFmB3fWGk=;
 b=Hwd0w7VlQmJbRTjCeALB4drh9nAs0e+7FgDVK97cxcx4dTXbXWlWRddcZrs8rmK7gl
 H5OHOaK2CEKdH5kH3S3AHsNoVRzh4DhR/0iiBrDkfHOMXC4bVoDoz0Vy5enYid/FGAOQ
 6wvjSq6M5m7wB2g+WnBbLNcmcS6Wf1p+G+KDrk0zj0UqEMU1CzyRfdlRAPkrQ+bslMlF
 BiC4jA6thWMbsZWx2lZ8DoLUmW52JUMpYTs4hw20MPeVapcy+rkMstbAIIU5XFgMl4Yt
 6ms06nVltKVriX4msQhnMSZKvhGT70QAhuRIgwZb2H6JYbpC2zo2FNoZLn4VpcrR1F6O
 K+ZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXDEPpFsyGEx2JC/SEii+5jie4MV5tpdZUSzlCCsa6/AHt080f6Vy9H6HfzrWsZnw8GVWxUZug9iduT@nongnu.org
X-Gm-Message-State: AOJu0YzfWE16yvdE680WQCue8f2dU9dlrIcwkblLosTDFN8XITKnUJbR
 Kc592UPOlBTb7m1SrK66gvl93AjrCNu41EMLKlRW2+C2TuDoE+FMu6HexdPIxE8B0RzfyvqoNkC
 kNcikgDljOCGUbIJI8qs3lp/1fXXFW/xxwE1JkIZ9lTMouEtVIqjVBGivrDZMYGMgMHbcFieqqv
 Epm8HZCQssonvMDUik00GyF7Zfhltokzk=
X-Gm-Gg: ASbGnctn/hH0ZHBDPRKStQ+SBlRhivh2RglcixzW+l+kKcZycVHUO4nMLTo9t95vAJm
 82FBz3F7iNSev+xrXrHgLcRvHDfVDxopc7K3CPnUmRf4BATjqc8bqkCa9WWKZ7yA+cpk9Nhq7cH
 GosnIlzi2B1UYFfzw9zEm6VezIg2rOgn6t2IhHgWlhmZAtq/+ndLK4
X-Received: by 2002:a17:902:e802:b0:234:d7b2:2ac5 with SMTP id
 d9443c01a7336-23e256c97d4mr280355055ad.21.1753130320289; 
 Mon, 21 Jul 2025 13:38:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH1MvrI/x3sWqyCnBsZKlYWOJ4d2TNY5sQ/m6FQVbe2YZdR4htSm/WRhHyIYzklpo0GXnf41PnDdQRTnTLEFRM=
X-Received: by 2002:a17:902:e802:b0:234:d7b2:2ac5 with SMTP id
 d9443c01a7336-23e256c97d4mr280354795ad.21.1753130319846; Mon, 21 Jul 2025
 13:38:39 -0700 (PDT)
MIME-Version: 1.0
References: <20250716-functional_tests_debug_arg-v1-1-6a9cd68318bb@linaro.org>
 <87ms93xl69.fsf@draig.linaro.org>
In-Reply-To: <87ms93xl69.fsf@draig.linaro.org>
From: John Snow <jsnow@redhat.com>
Date: Mon, 21 Jul 2025 16:38:26 -0400
X-Gm-Features: Ac12FXwwF7n10QSdSY3QY4-M0PVvF_kCqs9QHImSyYEH7yN7UATLuT7aHuGiiKA
Message-ID: <CAFn=p-YTFYr-cxz0B8jay=-HVpjyo9To72DZAg5o45SRBR0wnA@mail.gmail.com>
Subject: Re: [PATCH] tests/functional: add --debug CLI arg
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-devel@nongnu.org,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.926,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Jul 17, 2025 at 4:44=E2=80=AFAM Alex Benn=C3=A9e <alex.bennee@linar=
o.org> wrote:
>
> Manos Pitsidianakis <manos.pitsidianakis@linaro.org> writes:
>
> > Add argument parsing to functional tests to improve developer experienc=
e
> > when running individual tests. All logs are printed to stdout
> > interspersed with TAP output.
> >
> >   ./pyvenv/bin/python3 ../tests/functional/test_aarch64_virt.py --help
> >   usage: test_aarch64_virt [-h] [-d]
>
> Am I holding it wrong?
>
>   =E2=9E=9C  ./pyvenv/bin/python ../../tests/functional/test_aarch64_virt=
.py --help
>   Traceback (most recent call last):
>     File "/home/alex/lsrc/qemu.git/builds/all/../../tests/functional/test=
_aarch64_virt.py", line 16, in <module>
>       from qemu_test import QemuSystemTest, Asset, exec_command_and_wait_=
for_pattern
>     File "/home/alex/lsrc/qemu.git/tests/functional/qemu_test/__init__.py=
", line 14, in <module>
>       from .testcase import QemuBaseTest, QemuUserTest, QemuSystemTest
>     File "/home/alex/lsrc/qemu.git/tests/functional/qemu_test/testcase.py=
", line 26, in <module>
>       from qemu.machine import QEMUMachine
>   ModuleNotFoundError: No module named 'qemu'
>
> I thought the point of the venv is we had all the modules we need
> automatically available to the PYTHONPATH?

As Thomas points out, "qemu" is special since it's already in the
tree. There has been some dragging-of-feet by yours-truly because
installing the "qemu" module by default when running configure
introduces a considerable startup lag time, and the module is not
actually needed for the simple configuration and building of QEMU -
only testing.

It's something I want to fix, but must admit to being a bit stumped as
to how I will bridge that gap long term. Currently, all of the modules
we need are in the tree with no dependencies, so it can be fixed with
a simple PYTHONPATH hack. However, if I actually remove the QMP
library from the tree like I have wanted to, then we need pip to do a
real install and process dependencies, and this creates some
complications and extra startup lag.

Naively, I think adding a "just in time installation of testing
dependencies" when you go to run a testing command from "make XXXX"
might be sufficient for us, possibly in conjunction with a configure
flag that lets you pre-load testing dependencies.

>
>
> >
> >   QEMU Functional test
> >
> >   options:
> >     -h, --help   show this help message and exit
> >     -d, --debug  Also print test and console logs on stdout. This will
> >                  make the TAP output invalid and is meant for debugging
> >                  only.
> >
> > Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> > ---
> >  docs/devel/testing/functional.rst      |  2 ++
> >  tests/functional/qemu_test/testcase.py | 51 ++++++++++++++++++++++++++=
++++++--
> >  2 files changed, 50 insertions(+), 3 deletions(-)
> >
> > diff --git a/docs/devel/testing/functional.rst b/docs/devel/testing/fun=
ctional.rst
> > index 9e56dd1b1189216b9b4aede00174c15203f38b41..9d08abe2848277d635befb0=
296f578cfaa4bd66d 100644
> > --- a/docs/devel/testing/functional.rst
> > +++ b/docs/devel/testing/functional.rst
> > @@ -63,6 +63,8 @@ directory should be your build folder. For example::
> >    $ export QEMU_TEST_QEMU_BINARY=3D$PWD/qemu-system-x86_64
> >    $ pyvenv/bin/python3 ../tests/functional/test_file.py
> >
> > +By default, functional tests redirect informational logs and console o=
utput to
> > +log files. Specify the ``--debug`` flag to also print those to standar=
d output.
> >  The test framework will automatically purge any scratch files created =
during
> >  the tests. If needing to debug a failed test, it is possible to keep t=
hese
> >  files around on disk by setting ```QEMU_TEST_KEEP_SCRATCH=3D1``` as an=
 env
> > diff --git a/tests/functional/qemu_test/testcase.py b/tests/functional/=
qemu_test/testcase.py
> > index 2082c6fce43b0544d4e4258cd4155f555ed30cd4..fad7a946c6677e9ef5c42b8=
f77187ba836c11aeb 100644
> > --- a/tests/functional/qemu_test/testcase.py
> > +++ b/tests/functional/qemu_test/testcase.py
> > @@ -11,6 +11,7 @@
> >  # This work is licensed under the terms of the GNU GPL, version 2 or
> >  # later.  See the COPYING file in the top-level directory.
> >
> > +import argparse
> >  import logging
> >  import os
> >  from pathlib import Path
> > @@ -31,6 +32,20 @@
> >  from .uncompress import uncompress
> >
> >
> > +def parse_args(test_name: str) -> argparse.Namespace:
> > +    parser =3D argparse.ArgumentParser(
> > +        prog=3Dtest_name, description=3D"QEMU Functional test"
> > +    )
> > +    parser.add_argument(
> > +        "-d",
> > +        "--debug",
> > +        action=3D"store_true",
> > +        help=3D"Also print test and console logs on stdout. This will =
make the"
> > +        " TAP output invalid and is meant for debugging only.",
> > +    )
> > +    return parser.parse_args()
> > +
> > +
> >  class QemuBaseTest(unittest.TestCase):
> >
> >      '''
> > @@ -196,6 +211,9 @@ def assets_available(self):
> >          return True
> >
> >      def setUp(self):
> > +        path =3D os.path.basename(sys.argv[0])[:-3]
> > +        args =3D parse_args(path)
> > +        self.debug_output =3D args.debug
> >          self.qemu_bin =3D os.getenv('QEMU_TEST_QEMU_BINARY')
> >          self.assertIsNotNone(self.qemu_bin, 'QEMU_TEST_QEMU_BINARY mus=
t be set')
> >          self.arch =3D self.qemu_bin.split('-')[-1]
> > @@ -221,6 +239,16 @@ def setUp(self):
> >          self.machinelog.setLevel(logging.DEBUG)
> >          self.machinelog.addHandler(self._log_fh)
> >
> > +        if self.debug_output:
> > +            handler =3D logging.StreamHandler(sys.stdout)
> > +            handler.setLevel(logging.DEBUG)
> > +            formatter =3D logging.Formatter(
> > +                "%(asctime)s - %(name)s - %(levelname)s - %(message)s"
> > +            )
> > +            handler.setFormatter(formatter)
> > +            self.log.addHandler(handler)
> > +            self.machinelog.addHandler(handler)
> > +
> >          if not self.assets_available():
> >              self.skipTest('One or more assets is not available')
> >
> > @@ -230,11 +258,16 @@ def tearDown(self):
> >          if self.socketdir is not None:
> >              shutil.rmtree(self.socketdir.name)
> >              self.socketdir =3D None
> > -        self.machinelog.removeHandler(self._log_fh)
> > -        self.log.removeHandler(self._log_fh)
> > +        for handler in [self._log_fh, logging.StreamHandler(sys.stdout=
)]:
> > +            self.machinelog.removeHandler(handler)
> > +            self.log.removeHandler(handler)
> >
> >      def main():
> >          path =3D os.path.basename(sys.argv[0])[:-3]
> > +        # If argparse receives --help or an unknown argument, it will =
raise a
> > +        # SystemExit which will get caught by the test runner. Parse t=
he
> > +        # arguments here too to handle that case.
> > +        _ =3D parse_args(path)
> >
> >          cache =3D os.environ.get("QEMU_TEST_PRECACHE", None)
> >          if cache is not None:
> > @@ -292,6 +325,14 @@ def setUp(self):
> >          fileFormatter =3D logging.Formatter('%(asctime)s: %(message)s'=
)
> >          self._console_log_fh.setFormatter(fileFormatter)
> >          console_log.addHandler(self._console_log_fh)
> > +        if self.debug_output:
> > +            handler =3D logging.StreamHandler(sys.stdout)
> > +            handler.setLevel(logging.DEBUG)
> > +            formatter =3D logging.Formatter(
> > +                "%(asctime)s - %(name)s - %(levelname)s - %(message)s"
> > +            )
> > +            handler.setFormatter(formatter)
> > +            console_log.addHandler(handler)
> >
> >      def set_machine(self, machinename):
> >          # TODO: We should use QMP to get the list of available machine=
s
> > @@ -398,5 +439,9 @@ def set_vm_arg(self, arg, value):
> >      def tearDown(self):
> >          for vm in self._vms.values():
> >              vm.shutdown()
> > -        logging.getLogger('console').removeHandler(self._console_log_f=
h)
> > +        for handler in [
> > +            self._console_log_fh,
> > +            logging.StreamHandler(sys.stdout),
> > +        ]:
> > +            logging.getLogger("console").removeHandler(handler)
> >          super().tearDown()
> >
> > ---
> > base-commit: c079d3a31e45093286c65f8ca5350beb3a4404a9
> > change-id: 20250716-functional_tests_debug_arg-aa0a5f6b9375
>
> --
> Alex Benn=C3=A9e
> Virtualisation Tech Lead @ Linaro
>


