Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7122EC83F1B
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 10:14:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucLcw-0001gR-BK; Thu, 17 Jul 2025 06:14:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1ucLcu-0001dR-Hn
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 06:14:08 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1ucLcs-0006uL-2P
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 06:14:08 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-6097d144923so1836090a12.1
 for <qemu-devel@nongnu.org>; Thu, 17 Jul 2025 03:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752747243; x=1753352043; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qJvnJ1mnySecVnxop5Rx5hgRG/fwjkDDlTmWJ8j+4io=;
 b=e1s+gzdLeBe1eCLZoChnt/DH0CrIK7Al2QwbMWTyG6VotO7iJBvCzgFFNdV+5MN0xe
 IVNr+RWnvSfQ7XoJmLgJSUxx368UABqgnV9qlncu5Hy221yq1g7szN5mAa3enRzF+cQl
 scAnXcOcEa/wT8kxnSlq2PkSDJmRo7VPvJ8oedIJiV2IP6J4zH4b2Y6CyHYk1sbmRs2K
 e5p6EIWadc9BOQ41v8sZCC7qXk8A/Cq2aYzv55MPhqAWTD6rVWPYAAUWW8tfjxklkbE+
 oVV5zW9r9zXq5QGvwKCSd2K4ECA3DI3asHVLQR8TNBpSzRLKVI0CxLR0ndR0/Siqro6l
 uhKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752747243; x=1753352043;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qJvnJ1mnySecVnxop5Rx5hgRG/fwjkDDlTmWJ8j+4io=;
 b=ULK63Ve4AJ/FwoXjCXJ7Ie30js5afMYozkmJjiAjE4ftqJmLEWBlf8TPgRPvzddJ5E
 97kaoNy6dL6FtHVuE0PNZxzegM46w3oLEek44PKjSevBqjcnSDa7cAB+pRG6zZx/D0yM
 RZVHS33l9YrunPNgXO/TSAQgTg2h4xBI+POF/g6RpxlXrz5Ga8lZnIhgscHojAoU7p7R
 CR2eXMJ4ntBAzjvkMNOb1fYCd/6DPmXTNsNILCrF4bq0rkLhmSuN/QmhAN0rYHTvuOTn
 FDVMi0Equ6AIxU0NhBL10SFATUQ0DxzKtrkeNKJ+hRsO+H4Hiz60W81L8GoN73lokd1j
 uSUg==
X-Gm-Message-State: AOJu0Yxv6bgwSa+i6vTPNMeEvKXfdEgkPrkagNd8v8aAigc/zS1ez4GE
 aUYLc3CUrQVnrtOXdpkC7Iwy8eBDiFe5Zkm/iV5yzGO72L7qXX7muZHuK30q7WDZ8mNYHBQjodc
 V8yOI0rZrhJ2Zx6kG3gnGS0Rzic3Q32uj42AJcRF/kw==
X-Gm-Gg: ASbGncvDbn51xAVcYejChfM+RnNadQffI9fK+vjIv7brwFWhxMIkm2aIg1CY51dfEPh
 M5OR0Oe1a/m6zm86NTW8Bi4mEQMEy2IDP8KO8W8FXeSx84vMjqKx9QI+zNhxYWIbx8Ia8D859Pe
 UXB3JxsH7Hf6vnZwfUrhf8JlaZarH+cMwoEodhF1Wsr08dxRikMrlxhSdmviBr2xhtEqL8VX9EG
 23GesHmdwYx3TRr
X-Google-Smtp-Source: AGHT+IFZx/8SXfKE3VGT/N9Eli0fCNdaFumg9DonG+VYsWs5CoRIBDDR9kPGDkFl+ZzXzr2IoxXF9bZUIV8qJqzsBTE=
X-Received: by 2002:a05:6402:2553:b0:600:129:444e with SMTP id
 4fb4d7f45d1cf-612a3243e21mr2253211a12.4.1752747242775; Thu, 17 Jul 2025
 03:14:02 -0700 (PDT)
MIME-Version: 1.0
References: <20250716-functional_tests_debug_arg-v1-1-6a9cd68318bb@linaro.org>
 <87ms93xl69.fsf@draig.linaro.org>
 <CAAjaMXapnp2b2QJ2BGRF636vtY5fNEjmxiC2hgZbA4rTzhmM1Q@mail.gmail.com>
 <87h5zbxheu.fsf@draig.linaro.org>
In-Reply-To: <87h5zbxheu.fsf@draig.linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Thu, 17 Jul 2025 13:13:36 +0300
X-Gm-Features: Ac12FXwLgBMbjPFzMqqHlGmXUI4o-6n07AmBqtcvqlwR0UYwirxxBJGmb3gZWaw
Message-ID: <CAAjaMXauZOhWXcWS4rBd9REo=5fKrnJOWQxaw8_KENcy+9NwnQ@mail.gmail.com>
Subject: Re: [PATCH] tests/functional: add --debug CLI arg
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x52f.google.com
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

On Thu, Jul 17, 2025 at 1:04=E2=80=AFPM Alex Benn=C3=A9e <alex.bennee@linar=
o.org> wrote:
>
> Manos Pitsidianakis <manos.pitsidianakis@linaro.org> writes:
>
> > On Thu, Jul 17, 2025 at 11:42=E2=80=AFAM Alex Benn=C3=A9e <alex.bennee@=
linaro.org> wrote:
> >>
> >> Manos Pitsidianakis <manos.pitsidianakis@linaro.org> writes:
> >>
> >> > Add argument parsing to functional tests to improve developer experi=
ence
> >> > when running individual tests. All logs are printed to stdout
> >> > interspersed with TAP output.
> >> >
> >> >   ./pyvenv/bin/python3 ../tests/functional/test_aarch64_virt.py --he=
lp
> >> >   usage: test_aarch64_virt [-h] [-d]
> >>
> >> Am I holding it wrong?
> >>
> >>   =E2=9E=9C  ./pyvenv/bin/python ../../tests/functional/test_aarch64_v=
irt.py --help
> >>   Traceback (most recent call last):
> >>     File "/home/alex/lsrc/qemu.git/builds/all/../../tests/functional/t=
est_aarch64_virt.py", line 16, in <module>
> >>       from qemu_test import QemuSystemTest, Asset, exec_command_and_wa=
it_for_pattern
> >>     File "/home/alex/lsrc/qemu.git/tests/functional/qemu_test/__init__=
.py", line 14, in <module>
> >>       from .testcase import QemuBaseTest, QemuUserTest, QemuSystemTest
> >>     File "/home/alex/lsrc/qemu.git/tests/functional/qemu_test/testcase=
.py", line 26, in <module>
> >>       from qemu.machine import QEMUMachine
> >>   ModuleNotFoundError: No module named 'qemu'
> >>
> >> I thought the point of the venv is we had all the modules we need
> >> automatically available to the PYTHONPATH?
> >
> > Is PYTHONPATH exported? Check that you've done the instructions
> > detailed here:
> > https://www.qemu.org/docs/master/devel/testing/functional.html#running-=
tests
>
> We should probably include enough in the commit message so a blind copy
> and paste works, or at least indicates you need more setup to run the
> test:
>
>   set -x PYTHONPATH ../../python:../../tests/functional/
>   env QEMU_TEST_QEMU_BINARY=3D./qemu-system-aarch64 ./pyvenv/bin/python .=
./../tests/functional/test_aarch64_virt.py --debug
>
> >>
> >> >
> >> >   QEMU Functional test
> >> >
> >> >   options:
> >> >     -h, --help   show this help message and exit
> >> >     -d, --debug  Also print test and console logs on stdout. This wi=
ll
> >> >                  make the TAP output invalid and is meant for debugg=
ing
> >> >                  only.
> >> >
> >> > Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> >> > ---
> >> >  docs/devel/testing/functional.rst      |  2 ++
> >> >  tests/functional/qemu_test/testcase.py | 51 +++++++++++++++++++++++=
+++++++++--
> >> >  2 files changed, 50 insertions(+), 3 deletions(-)
> >> >
> >> > diff --git a/docs/devel/testing/functional.rst b/docs/devel/testing/=
functional.rst
> >> > index 9e56dd1b1189216b9b4aede00174c15203f38b41..9d08abe2848277d635be=
fb0296f578cfaa4bd66d 100644
> >> > --- a/docs/devel/testing/functional.rst
> >> > +++ b/docs/devel/testing/functional.rst
> >> > @@ -63,6 +63,8 @@ directory should be your build folder. For example=
::
> >> >    $ export QEMU_TEST_QEMU_BINARY=3D$PWD/qemu-system-x86_64
> >> >    $ pyvenv/bin/python3 ../tests/functional/test_file.py
> >> >
> >> > +By default, functional tests redirect informational logs and consol=
e output to
> >> > +log files. Specify the ``--debug`` flag to also print those to stan=
dard output.
> >> >  The test framework will automatically purge any scratch files creat=
ed during
> >> >  the tests. If needing to debug a failed test, it is possible to kee=
p these
> >> >  files around on disk by setting ```QEMU_TEST_KEEP_SCRATCH=3D1``` as=
 an env
> >> > diff --git a/tests/functional/qemu_test/testcase.py b/tests/function=
al/qemu_test/testcase.py
> >> > index 2082c6fce43b0544d4e4258cd4155f555ed30cd4..fad7a946c6677e9ef5c4=
2b8f77187ba836c11aeb 100644
> >> > --- a/tests/functional/qemu_test/testcase.py
> >> > +++ b/tests/functional/qemu_test/testcase.py
> >> > @@ -11,6 +11,7 @@
> >> >  # This work is licensed under the terms of the GNU GPL, version 2 o=
r
> >> >  # later.  See the COPYING file in the top-level directory.
> >> >
> >> > +import argparse
> >> >  import logging
> >> >  import os
> >> >  from pathlib import Path
> >> > @@ -31,6 +32,20 @@
> >> >  from .uncompress import uncompress
> >> >
> >> >
> >> > +def parse_args(test_name: str) -> argparse.Namespace:
> >> > +    parser =3D argparse.ArgumentParser(
> >> > +        prog=3Dtest_name, description=3D"QEMU Functional test"
> >> > +    )
> >> > +    parser.add_argument(
> >> > +        "-d",
> >> > +        "--debug",
> >> > +        action=3D"store_true",
> >> > +        help=3D"Also print test and console logs on stdout. This wi=
ll make the"
> >> > +        " TAP output invalid and is meant for debugging only.",
> >> > +    )
> >> > +    return parser.parse_args()
> >> > +
> >> > +
>
> I'm definitely onboard for improving the ergonomics of calling the tests
> directly. Others to consider:
>
>   - triggering the behaviour of QEMU_TEST_KEEP_SCRATCH
>   - dumping the command line without the test harness QMP/serial pipes co=
nnected

Definitely useful, I've needed those behaviors in the past!

I will send more patches. I will also see if it's easy to make it
possible to list the tests that would run in a specific file, and if
possible to run only specified tests.

Thanks,
--=20
Manos Pitsidianakis
Emulation and Virtualization Engineer at Linaro Ltd

