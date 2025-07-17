Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1292C83F1B
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 08:47:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucKHK-0000BB-HK; Thu, 17 Jul 2025 04:47:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1ucKHI-0008V6-3V
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 04:47:44 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1ucKHF-00043f-Nf
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 04:47:43 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-60c9d8a169bso1136910a12.1
 for <qemu-devel@nongnu.org>; Thu, 17 Jul 2025 01:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752742059; x=1753346859; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oj72l4zM/dR6/x3nPKaDmXnu5RI7guNT+V7Wbg37UBY=;
 b=L5ZbIR4tQ9Jjzdb0SUjvbhl9c3Ima3d2F4gUopujZTv9WKoEvL+Y3XNBE7dQrYRgYc
 cie1nwKp56xJJF67eaoSrBxwGkNXnTYcMFJlj0aH3A2RtQiZx9Z8lp6dF5rvH6TWtLDx
 xXb6/SqRfmbQkrEfpy0y8MmnCPG5Y4UrJ3xhJHP9YjhuDHKxM5KO3/2HVncLy+/V5B7M
 Amsupgn1TUDXWQVyYgs6jXYxov0oI4mGDRTgq+gfDaELsrzWL40ir/tKIXX/SYIsR05b
 O+RxRx8s5iLUaUk9/8zKor2CYcoI8Eck1+tqQ8n661zomuy7MX08EAOa+Bmr7y7pjFHM
 aw1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752742059; x=1753346859;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oj72l4zM/dR6/x3nPKaDmXnu5RI7guNT+V7Wbg37UBY=;
 b=xNNGCBlXpwMdkMLaSUhc8vwCDDSmiTj2q0NdVcoGhdeiIYQwO6L36W15K/RMrFkwAv
 Hn7f5nxnd8W7J+gcvvnS1qRPf3bdc/PL1dOcFuYp6Xxr1+kMfWa1THHb0sv1WFuclNfF
 V/q2VJ12aB0tXoVzlQ2k3ZvYiArieYLummxpYS5nOSirCF2LYzM7CZjPMlkqmeRYmC0T
 ZKl8TvQ0CjAZpuCFAPhcelhzpwtH0eMPYDYHBYRbO5h6Phbeu/QD5cniRSZuZZBgVUTZ
 vl7phKPdCzQLc6LTN8IETKloN/UK5C3b60Rbvn/nNwbzewVhG2s2zV6uu+FwwZ+Ik7hi
 Bgew==
X-Gm-Message-State: AOJu0YzUNG6ZqCk52VNO05JEmVtFj/Ei0d5UPbGN+Dz2S239I9AdjL6O
 Cn/MXSQJ1Kz72dXbDgbJgChL7VutnH4mZhbATYDevdVg+2YU88MAXKiREuDVyflqUHiqm00PpW+
 MnXyjGAxolJ4M84dZ4PqXPNG022fdkfvhGfZ3+cFnhA==
X-Gm-Gg: ASbGncsX89T6+aTcX4ujixiU7u7cEjnicDsjRam6gCnzipjIDCemOaU7pLCH8ndjvjG
 /C8Av9vJWSrIB3Np4Mx3bb+MIYgSJetF9sxigtnH1M4CpFoSAymSF2NMV6fxp6lKsXrSkhtM+vK
 dglnydbzKbOUQ2LlnSbv47OR6MB2oE2PS4W8EBpcYZuWdSyYg1FwhRzTk/3S9SLRIjSA3nxxOWN
 9aSjg==
X-Google-Smtp-Source: AGHT+IFAspWWB1WlrZZBfSvwLGNCPVAvwg2uVMEjk7SicPxLj8oQzi7SSfDarn39VNqk5gZI0eVyEELqhVKP6s/xwjg=
X-Received: by 2002:a05:6402:164d:b0:60c:5853:5b7f with SMTP id
 4fb4d7f45d1cf-61285dfca8dmr4381828a12.32.1752742059070; Thu, 17 Jul 2025
 01:47:39 -0700 (PDT)
MIME-Version: 1.0
References: <20250716-functional_tests_debug_arg-v1-1-6a9cd68318bb@linaro.org>
 <87ms93xl69.fsf@draig.linaro.org>
In-Reply-To: <87ms93xl69.fsf@draig.linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Thu, 17 Jul 2025 11:47:12 +0300
X-Gm-Features: Ac12FXwDELCqDB74cS2TeOpRFNbcyYSTsD36c_GpHsblm5q8AegQj0TS5JDooeA
Message-ID: <CAAjaMXapnp2b2QJ2BGRF636vtY5fNEjmxiC2hgZbA4rTzhmM1Q@mail.gmail.com>
Subject: Re: [PATCH] tests/functional: add --debug CLI arg
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x535.google.com
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

On Thu, Jul 17, 2025 at 11:42=E2=80=AFAM Alex Benn=C3=A9e <alex.bennee@lina=
ro.org> wrote:
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

Is PYTHONPATH exported? Check that you've done the instructions
detailed here: https://www.qemu.org/docs/master/devel/testing/functional.ht=
ml#running-tests

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

