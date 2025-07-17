Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44F06C83F34
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 10:05:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucLTh-0001lw-EG; Thu, 17 Jul 2025 06:04:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ucLTL-0001UK-Kc
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 06:04:15 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ucLTJ-0005db-DE
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 06:04:15 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-ad572ba1347so115062666b.1
 for <qemu-devel@nongnu.org>; Thu, 17 Jul 2025 03:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752746651; x=1753351451; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mWBKCFK1cZMBxegyF04FtHgxoVcZCsmSJZ3sN8URrZc=;
 b=CoctvwnAV3HVyNMk9SSsds9IAfJyUIIZ58xqE7MzvqCWSPXax+pvtJoyp1PITVOYfo
 JUcX4gpIeUb2+OUq4gvKIfirROzzYhQFbL9Zcda86hfjWLK58YPoJPCt2CAttNhQ67GW
 jgumR/iJXMfz3bC88Nkf2gBAtJOr0jUjye24w/4wH9QMNomM8tc7qtidduta/99OwN3t
 +GXINLdXPH5tqGbxjYx/1Z7MxU0RfVdHrwU+bLXS214t9vrsRRyaLOtx9/GklrPFtwAH
 jxaMvKe5sMG1Ygr+6KVE25Gz9806AwGSTGQpr4nFYz6cbbHRj1HXDL8sj625HTrVCOVB
 6Y5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752746651; x=1753351451;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mWBKCFK1cZMBxegyF04FtHgxoVcZCsmSJZ3sN8URrZc=;
 b=xTcG7vCMuNhEGrBimka8jHjoVRQdzvmSif6/OEKmXxjL36Uq7CHdhs5EIr4ZLg0Pmk
 d2euEwXEFiXxcp41TIizKIj1BGhgZUx9cUWeo/ovaerrizmoiln6MiPb/DdYiMmgfm6N
 0vhNMCx6jrLZcOPCcCGmOzF9DMOJptpwzBeVfsKrgpYXU7GI6Tt4LMvci51p2wAM9/kd
 GH9M5Q7e/CweUf/d9PX5V/ujtD4E+Q7Vg/S703ozVwC+4HHqKhoHYGcVVqvEgOxZz6p1
 wl9Krwn6m9vZf0qdb38f+03X+JLDF8oJmfquwqfpWtxSNJSrCk957G/96PblO/q3jlgC
 AWyg==
X-Gm-Message-State: AOJu0YxTReq0gjiaG7dYZWfByGVIrgNGAGf9SnpKHP/uMQNXLm2rDeTh
 s+hetbn4aBxK0zRJ2tvUxE2hWYYujhfDlZN4Msgs+1NwxnjqBw8ZDJElOiczTVxEltI=
X-Gm-Gg: ASbGncticisrBqs5vzKpbMprnQjGtzGG7vkRCoyNft4qSKOznSgvGAzy1JxgrqVtdNC
 sePgWQ6kANG6wGY0qx/YzLePboysMhkjYPPY2KRCGwQlG7Y6pCPy1ubiIRv/WouN1QrpUZ9NSJY
 Ebq8GHp+V0zX5M/bvsPblsh30ajWzJfcI0aDXtjOqmO2VWk775ZiRmpL8Tkbj8sjHS8soLiItXK
 gGEW9bI6GZM8W58LdEOKDgTSfKw/Iasjev2DrWflRxhtG1R/7oIaXkp+KAJtAxg4aOwuVd3o6Sd
 4md8jcvwzL7o9TfT/YoaEdA7dkdTsYygD44NDeiff2wuoZYN8NsVLVxT3ljoXQiUeIscexZsRRA
 yceViNxQjVjDIWjZc0JK61yU=
X-Google-Smtp-Source: AGHT+IG2m49Xsxsl5Akp9nZn1KxhgVA0PuuMuOg8GOvXZubUVcg9V4NXBGVOKn9TIxXODIlNobQTHg==
X-Received: by 2002:a17:907:7286:b0:ae3:a799:8e84 with SMTP id
 a640c23a62f3a-ae9cddaa532mr507297466b.8.1752746651209; 
 Thu, 17 Jul 2025 03:04:11 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ae6e826469asm1321299366b.85.2025.07.17.03.04.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Jul 2025 03:04:10 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 992975F812;
 Thu, 17 Jul 2025 11:04:09 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org,  Thomas Huth <thuth@redhat.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: Re: [PATCH] tests/functional: add --debug CLI arg
In-Reply-To: <CAAjaMXapnp2b2QJ2BGRF636vtY5fNEjmxiC2hgZbA4rTzhmM1Q@mail.gmail.com>
 (Manos Pitsidianakis's message of "Thu, 17 Jul 2025 11:47:12 +0300")
References: <20250716-functional_tests_debug_arg-v1-1-6a9cd68318bb@linaro.org>
 <87ms93xl69.fsf@draig.linaro.org>
 <CAAjaMXapnp2b2QJ2BGRF636vtY5fNEjmxiC2hgZbA4rTzhmM1Q@mail.gmail.com>
User-Agent: mu4e 1.12.11; emacs 30.1
Date: Thu, 17 Jul 2025 11:04:09 +0100
Message-ID: <87h5zbxheu.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62b.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
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

Manos Pitsidianakis <manos.pitsidianakis@linaro.org> writes:

> On Thu, Jul 17, 2025 at 11:42=E2=80=AFAM Alex Benn=C3=A9e <alex.bennee@li=
naro.org> wrote:
>>
>> Manos Pitsidianakis <manos.pitsidianakis@linaro.org> writes:
>>
>> > Add argument parsing to functional tests to improve developer experien=
ce
>> > when running individual tests. All logs are printed to stdout
>> > interspersed with TAP output.
>> >
>> >   ./pyvenv/bin/python3 ../tests/functional/test_aarch64_virt.py --help
>> >   usage: test_aarch64_virt [-h] [-d]
>>
>> Am I holding it wrong?
>>
>>   =E2=9E=9C  ./pyvenv/bin/python ../../tests/functional/test_aarch64_vir=
t.py --help
>>   Traceback (most recent call last):
>>     File "/home/alex/lsrc/qemu.git/builds/all/../../tests/functional/tes=
t_aarch64_virt.py", line 16, in <module>
>>       from qemu_test import QemuSystemTest, Asset, exec_command_and_wait=
_for_pattern
>>     File "/home/alex/lsrc/qemu.git/tests/functional/qemu_test/__init__.p=
y", line 14, in <module>
>>       from .testcase import QemuBaseTest, QemuUserTest, QemuSystemTest
>>     File "/home/alex/lsrc/qemu.git/tests/functional/qemu_test/testcase.p=
y", line 26, in <module>
>>       from qemu.machine import QEMUMachine
>>   ModuleNotFoundError: No module named 'qemu'
>>
>> I thought the point of the venv is we had all the modules we need
>> automatically available to the PYTHONPATH?
>
> Is PYTHONPATH exported? Check that you've done the instructions
> detailed here:
> https://www.qemu.org/docs/master/devel/testing/functional.html#running-te=
sts

We should probably include enough in the commit message so a blind copy
and paste works, or at least indicates you need more setup to run the
test:

  set -x PYTHONPATH ../../python:../../tests/functional/
  env QEMU_TEST_QEMU_BINARY=3D./qemu-system-aarch64 ./pyvenv/bin/python ../=
../tests/functional/test_aarch64_virt.py --debug

>>
>> >
>> >   QEMU Functional test
>> >
>> >   options:
>> >     -h, --help   show this help message and exit
>> >     -d, --debug  Also print test and console logs on stdout. This will
>> >                  make the TAP output invalid and is meant for debugging
>> >                  only.
>> >
>> > Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
>> > ---
>> >  docs/devel/testing/functional.rst      |  2 ++
>> >  tests/functional/qemu_test/testcase.py | 51 +++++++++++++++++++++++++=
+++++++--
>> >  2 files changed, 50 insertions(+), 3 deletions(-)
>> >
>> > diff --git a/docs/devel/testing/functional.rst b/docs/devel/testing/fu=
nctional.rst
>> > index 9e56dd1b1189216b9b4aede00174c15203f38b41..9d08abe2848277d635befb=
0296f578cfaa4bd66d 100644
>> > --- a/docs/devel/testing/functional.rst
>> > +++ b/docs/devel/testing/functional.rst
>> > @@ -63,6 +63,8 @@ directory should be your build folder. For example::
>> >    $ export QEMU_TEST_QEMU_BINARY=3D$PWD/qemu-system-x86_64
>> >    $ pyvenv/bin/python3 ../tests/functional/test_file.py
>> >
>> > +By default, functional tests redirect informational logs and console =
output to
>> > +log files. Specify the ``--debug`` flag to also print those to standa=
rd output.
>> >  The test framework will automatically purge any scratch files created=
 during
>> >  the tests. If needing to debug a failed test, it is possible to keep =
these
>> >  files around on disk by setting ```QEMU_TEST_KEEP_SCRATCH=3D1``` as a=
n env
>> > diff --git a/tests/functional/qemu_test/testcase.py b/tests/functional=
/qemu_test/testcase.py
>> > index 2082c6fce43b0544d4e4258cd4155f555ed30cd4..fad7a946c6677e9ef5c42b=
8f77187ba836c11aeb 100644
>> > --- a/tests/functional/qemu_test/testcase.py
>> > +++ b/tests/functional/qemu_test/testcase.py
>> > @@ -11,6 +11,7 @@
>> >  # This work is licensed under the terms of the GNU GPL, version 2 or
>> >  # later.  See the COPYING file in the top-level directory.
>> >
>> > +import argparse
>> >  import logging
>> >  import os
>> >  from pathlib import Path
>> > @@ -31,6 +32,20 @@
>> >  from .uncompress import uncompress
>> >
>> >
>> > +def parse_args(test_name: str) -> argparse.Namespace:
>> > +    parser =3D argparse.ArgumentParser(
>> > +        prog=3Dtest_name, description=3D"QEMU Functional test"
>> > +    )
>> > +    parser.add_argument(
>> > +        "-d",
>> > +        "--debug",
>> > +        action=3D"store_true",
>> > +        help=3D"Also print test and console logs on stdout. This will=
 make the"
>> > +        " TAP output invalid and is meant for debugging only.",
>> > +    )
>> > +    return parser.parse_args()
>> > +
>> > +

I'm definitely onboard for improving the ergonomics of calling the tests
directly. Others to consider:

  - triggering the behaviour of QEMU_TEST_KEEP_SCRATCH
  - dumping the command line without the test harness QMP/serial pipes conn=
ected


<snip>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

