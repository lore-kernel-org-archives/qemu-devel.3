Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7971C83F1B
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 08:43:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucKCy-0001eO-Gl; Thu, 17 Jul 2025 04:43:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ucKCj-0001Xo-63
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 04:43:01 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ucKCg-0003SI-Uy
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 04:43:00 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-ae3703c2a8bso137299266b.0
 for <qemu-devel@nongnu.org>; Thu, 17 Jul 2025 01:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752741777; x=1753346577; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w2dBNNLh4y/X7LoTQuxTbD+iEbyu11dd+KvR3CVFqfQ=;
 b=jdgiUy73ShlSvaqRTWTvlRVTZDkdHmGV8Z4ksOSo0wSqC3tVbaXb0bh1CPZmS8kZ43
 aFo6nXCE57iX2k3tvHB5qGqdZwTKfHVUtnc7lFs+8xPQe8jTzqAHcLlyzg+z7LN3FMWa
 xUHM4gHW1tbcUdX4/k4yUNJj9sDP/8djaOVrkQLcmA/lIcAazzEpzeptQU/68KgW9iOA
 Tl8OkHHfGwOU2NP+/KZX6rCWrHZ7k7C5tFAC851mYCLL4lOBY4bLVi2dFEABC+vNcxoM
 Cyaj677rjSWnPDNEn+bHLhKCT6CQTXXPlgciAyxlyapF932mKmDp39U+tEARNamL0NAC
 GQZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752741777; x=1753346577;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=w2dBNNLh4y/X7LoTQuxTbD+iEbyu11dd+KvR3CVFqfQ=;
 b=KKPBCfoD6n2cLTsq/tPaatTj/Jkw+u362jq4an8p+5uo9Tc9r7u5Hf6SL1yHUO1BLn
 WWtS6jN3yupuCMvYPuTMIoBiobsuw4js38aFVRZ5Ua2UhgzR/yCbTLqi8o8C788w40m8
 Q8sK99Wfy+1iX0WUxevUnGzBgvCWE6Ddj5zf95tiimC9IPz6tcGTCw6DmsStIxgPYfhc
 E4lU46GLf2yzI6JAdXry+7/WNBv0IaWdE+AE+z4rv+vWp4SBrjXmNAjKCccEKWh2poVd
 uhyh9oZBKGZapypdewXH120V/h0jykgz1BeMW9JfiG295/v17ZwVBEqa5+dfMEGkKmxM
 3l4w==
X-Gm-Message-State: AOJu0Yy8Z0o7tX4XkIz+1CanMPHt9EK3UxYNCdZf77CNO8n9lutNEynR
 iKSdVOeyruhpuvIyRxvgHkcEMfOjVUoFAlgnZEwg+NnJuRogqmRKLzdy0AP1NgDv6SA=
X-Gm-Gg: ASbGncv6E6r+j5k3qhFT+xxspJOcdet45VhST0dSGIN1oY9ZMY/zptX4LE7yYwseCi9
 +PKzkY9WSa483i7urleBggKO9kKPqAFEPb/wwemxkFf1GrrfZ29x6DsAqdIIOcePz14QeLCwfSg
 TiTRp/FhQdaDvKgkOwUcKYVuCwt3oWPQVYXcpByvzGwZg1k+Bp0Ts/i9A5hOnV0iGr0Au3niEzK
 u9yn+6RFNBSL4L+JIUBCO1rbMWNXrGv5IL/ExpmcL6fxoalUsb5xMej1aBkl8jwMfqg6iAv3yGG
 +8RjcP9VSYZgAxvGTF8BC/LSx3uXtByEvZxuqUbVwqJLWbb219aT530bhcCutloUKVNubgbtQi1
 Tl8q6BMl9lVuKb8Xuw3/qh+E=
X-Google-Smtp-Source: AGHT+IGtAL2M3RyitXn/N1OpMYIgHw6UYxSblUPjs7hUu/svhf4/VLcuraWVaCwSwbBUyZwygQBcgg==
X-Received: by 2002:a17:907:3e13:b0:ae0:c497:c5ca with SMTP id
 a640c23a62f3a-ae9c9959289mr658354866b.3.1752741776586; 
 Thu, 17 Jul 2025 01:42:56 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-611c976ec04sm9640732a12.60.2025.07.17.01.42.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Jul 2025 01:42:55 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E31CE5F812;
 Thu, 17 Jul 2025 09:42:54 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org,  Thomas Huth <thuth@redhat.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: Re: [PATCH] tests/functional: add --debug CLI arg
In-Reply-To: <20250716-functional_tests_debug_arg-v1-1-6a9cd68318bb@linaro.org>
 (Manos Pitsidianakis's message of "Wed, 16 Jul 2025 09:08:00 +0300")
References: <20250716-functional_tests_debug_arg-v1-1-6a9cd68318bb@linaro.org>
User-Agent: mu4e 1.12.11; emacs 30.1
Date: Thu, 17 Jul 2025 09:42:54 +0100
Message-ID: <87ms93xl69.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x630.google.com
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

> Add argument parsing to functional tests to improve developer experience
> when running individual tests. All logs are printed to stdout
> interspersed with TAP output.
>
>   ./pyvenv/bin/python3 ../tests/functional/test_aarch64_virt.py --help
>   usage: test_aarch64_virt [-h] [-d]

Am I holding it wrong?

  =E2=9E=9C  ./pyvenv/bin/python ../../tests/functional/test_aarch64_virt.p=
y --help
  Traceback (most recent call last):
    File "/home/alex/lsrc/qemu.git/builds/all/../../tests/functional/test_a=
arch64_virt.py", line 16, in <module>
      from qemu_test import QemuSystemTest, Asset, exec_command_and_wait_fo=
r_pattern
    File "/home/alex/lsrc/qemu.git/tests/functional/qemu_test/__init__.py",=
 line 14, in <module>
      from .testcase import QemuBaseTest, QemuUserTest, QemuSystemTest
    File "/home/alex/lsrc/qemu.git/tests/functional/qemu_test/testcase.py",=
 line 26, in <module>
      from qemu.machine import QEMUMachine
  ModuleNotFoundError: No module named 'qemu'

I thought the point of the venv is we had all the modules we need
automatically available to the PYTHONPATH?


>
>   QEMU Functional test
>
>   options:
>     -h, --help   show this help message and exit
>     -d, --debug  Also print test and console logs on stdout. This will
>                  make the TAP output invalid and is meant for debugging
>                  only.
>
> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> ---
>  docs/devel/testing/functional.rst      |  2 ++
>  tests/functional/qemu_test/testcase.py | 51 ++++++++++++++++++++++++++++=
++++--
>  2 files changed, 50 insertions(+), 3 deletions(-)
>
> diff --git a/docs/devel/testing/functional.rst b/docs/devel/testing/funct=
ional.rst
> index 9e56dd1b1189216b9b4aede00174c15203f38b41..9d08abe2848277d635befb029=
6f578cfaa4bd66d 100644
> --- a/docs/devel/testing/functional.rst
> +++ b/docs/devel/testing/functional.rst
> @@ -63,6 +63,8 @@ directory should be your build folder. For example::
>    $ export QEMU_TEST_QEMU_BINARY=3D$PWD/qemu-system-x86_64
>    $ pyvenv/bin/python3 ../tests/functional/test_file.py
>=20=20
> +By default, functional tests redirect informational logs and console out=
put to
> +log files. Specify the ``--debug`` flag to also print those to standard =
output.
>  The test framework will automatically purge any scratch files created du=
ring
>  the tests. If needing to debug a failed test, it is possible to keep the=
se
>  files around on disk by setting ```QEMU_TEST_KEEP_SCRATCH=3D1``` as an e=
nv
> diff --git a/tests/functional/qemu_test/testcase.py b/tests/functional/qe=
mu_test/testcase.py
> index 2082c6fce43b0544d4e4258cd4155f555ed30cd4..fad7a946c6677e9ef5c42b8f7=
7187ba836c11aeb 100644
> --- a/tests/functional/qemu_test/testcase.py
> +++ b/tests/functional/qemu_test/testcase.py
> @@ -11,6 +11,7 @@
>  # This work is licensed under the terms of the GNU GPL, version 2 or
>  # later.  See the COPYING file in the top-level directory.
>=20=20
> +import argparse
>  import logging
>  import os
>  from pathlib import Path
> @@ -31,6 +32,20 @@
>  from .uncompress import uncompress
>=20=20
>=20=20
> +def parse_args(test_name: str) -> argparse.Namespace:
> +    parser =3D argparse.ArgumentParser(
> +        prog=3Dtest_name, description=3D"QEMU Functional test"
> +    )
> +    parser.add_argument(
> +        "-d",
> +        "--debug",
> +        action=3D"store_true",
> +        help=3D"Also print test and console logs on stdout. This will ma=
ke the"
> +        " TAP output invalid and is meant for debugging only.",
> +    )
> +    return parser.parse_args()
> +
> +
>  class QemuBaseTest(unittest.TestCase):
>=20=20
>      '''
> @@ -196,6 +211,9 @@ def assets_available(self):
>          return True
>=20=20
>      def setUp(self):
> +        path =3D os.path.basename(sys.argv[0])[:-3]
> +        args =3D parse_args(path)
> +        self.debug_output =3D args.debug
>          self.qemu_bin =3D os.getenv('QEMU_TEST_QEMU_BINARY')
>          self.assertIsNotNone(self.qemu_bin, 'QEMU_TEST_QEMU_BINARY must =
be set')
>          self.arch =3D self.qemu_bin.split('-')[-1]
> @@ -221,6 +239,16 @@ def setUp(self):
>          self.machinelog.setLevel(logging.DEBUG)
>          self.machinelog.addHandler(self._log_fh)
>=20=20
> +        if self.debug_output:
> +            handler =3D logging.StreamHandler(sys.stdout)
> +            handler.setLevel(logging.DEBUG)
> +            formatter =3D logging.Formatter(
> +                "%(asctime)s - %(name)s - %(levelname)s - %(message)s"
> +            )
> +            handler.setFormatter(formatter)
> +            self.log.addHandler(handler)
> +            self.machinelog.addHandler(handler)
> +
>          if not self.assets_available():
>              self.skipTest('One or more assets is not available')
>=20=20
> @@ -230,11 +258,16 @@ def tearDown(self):
>          if self.socketdir is not None:
>              shutil.rmtree(self.socketdir.name)
>              self.socketdir =3D None
> -        self.machinelog.removeHandler(self._log_fh)
> -        self.log.removeHandler(self._log_fh)
> +        for handler in [self._log_fh, logging.StreamHandler(sys.stdout)]:
> +            self.machinelog.removeHandler(handler)
> +            self.log.removeHandler(handler)
>=20=20
>      def main():
>          path =3D os.path.basename(sys.argv[0])[:-3]
> +        # If argparse receives --help or an unknown argument, it will ra=
ise a
> +        # SystemExit which will get caught by the test runner. Parse the
> +        # arguments here too to handle that case.
> +        _ =3D parse_args(path)
>=20=20
>          cache =3D os.environ.get("QEMU_TEST_PRECACHE", None)
>          if cache is not None:
> @@ -292,6 +325,14 @@ def setUp(self):
>          fileFormatter =3D logging.Formatter('%(asctime)s: %(message)s')
>          self._console_log_fh.setFormatter(fileFormatter)
>          console_log.addHandler(self._console_log_fh)
> +        if self.debug_output:
> +            handler =3D logging.StreamHandler(sys.stdout)
> +            handler.setLevel(logging.DEBUG)
> +            formatter =3D logging.Formatter(
> +                "%(asctime)s - %(name)s - %(levelname)s - %(message)s"
> +            )
> +            handler.setFormatter(formatter)
> +            console_log.addHandler(handler)
>=20=20
>      def set_machine(self, machinename):
>          # TODO: We should use QMP to get the list of available machines
> @@ -398,5 +439,9 @@ def set_vm_arg(self, arg, value):
>      def tearDown(self):
>          for vm in self._vms.values():
>              vm.shutdown()
> -        logging.getLogger('console').removeHandler(self._console_log_fh)
> +        for handler in [
> +            self._console_log_fh,
> +            logging.StreamHandler(sys.stdout),
> +        ]:
> +            logging.getLogger("console").removeHandler(handler)
>          super().tearDown()
>
> ---
> base-commit: c079d3a31e45093286c65f8ca5350beb3a4404a9
> change-id: 20250716-functional_tests_debug_arg-aa0a5f6b9375

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

