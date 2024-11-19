Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36C6CD4417F
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2024 16:21:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDQyb-0006SD-29; Tue, 19 Nov 2024 11:21:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tDQya-0006Ry-8l
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 11:21:16 -0500
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tDQyY-0008Ji-JP
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 11:21:16 -0500
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5cfddc94c83so1565374a12.3
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2024 08:21:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732033272; x=1732638072; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9YTbU8ZyTorCnXxtXdjHBbwCfxZ0op2/UBZo+i144/4=;
 b=LqibsqVnS/DfO/U8Sz7swPfXUdem6k7X6ftBMLvqU76gK2cXpQuHwEbOJbhOmDlvnq
 ORSoS1tNrDEUBJv7SzgjI6nu/FLWu0NE8+Xed4aQeRsmziTTMNAzxWYOwVL17MGNf9XZ
 EBBlOEvEOCqquQds5yQ1fMbVq1XYBkL/KAVBalL3SASrNFv1YLkDwH4LO2C/lb5boWr1
 iTVUGz5zTTn2EDj7GCYdZ8rhheTbOFWMUdbnH5+aM9BLWK3RLV47pk50/EajujamBQbk
 noUq2KCtgc3e+a5GLz3uF5AA64W0ccX8ejbWryjS3RH0xE8aCiDNorl7CruprT0CRcIJ
 5NUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732033272; x=1732638072;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9YTbU8ZyTorCnXxtXdjHBbwCfxZ0op2/UBZo+i144/4=;
 b=qwna6RTst3EhzS7JhIXTWzd2DHDBHZAMlbEzAauQp/juqXdKfSA8cQG9GCL/QkeLfD
 3hoNeGjgZt0BVw741wrJevOafNWiczsoIDJa8ju9mX5kXobY4XZrvhM2o519ZSgf4MOU
 PhoS0IYa6bg6H9necydfdlTEDoW0pgLprO4n0XAOuRWECi2wb5/xzH/x3L1ba/zduxjp
 OQsZlpdWYU/isozc+qmDB4K0RQWKs7RGx7Rj/FBOugxbS7dpEUPyVt5irmT6FomtfJ2C
 jbiMkEUtv0lJ1TJeABL2VDKB60F8IRymTKsVFSEcHHRxyYcgvuhBmxoF89bon1sfiQwL
 GkAg==
X-Gm-Message-State: AOJu0Yzgftom9nWgHChWspiNmu1W01iJjbtgkzSVSo4nJlFxkkRPmmU8
 WlKnbqrOTjwOEsV2nF3lVFxiEuzKe5sCBe0nwFnEecKK0Pbsuy+LK0S7pgsTZxk=
X-Google-Smtp-Source: AGHT+IHjNzP1YLxMMKOPZ++oGwMuayjD8i7CSuUvwQfUTPBbn61isB42j/QsLA9mUzz60LOGVmBKDQ==
X-Received: by 2002:a17:907:d29:b0:a9a:294:cb30 with SMTP id
 a640c23a62f3a-aa4834122e4mr1524922166b.16.1732033271867; 
 Tue, 19 Nov 2024 08:21:11 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa20df51653sm663225166b.48.2024.11.19.08.21.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Nov 2024 08:21:11 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 7DBF75F716;
 Tue, 19 Nov 2024 16:21:10 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  Thomas Huth <thuth@redhat.com>,  Ani Sinha
 <anisinha@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 02/15] tests/functional: automatically clean up scratch
 files after tests
In-Reply-To: <20241119150519.1123365-3-berrange@redhat.com> ("Daniel P.
 =?utf-8?Q?Berrang=C3=A9=22's?= message of "Tue, 19 Nov 2024 15:05:06
 +0000")
References: <20241119150519.1123365-1-berrange@redhat.com>
 <20241119150519.1123365-3-berrange@redhat.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Tue, 19 Nov 2024 16:21:10 +0000
Message-ID: <87frnnp53d.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x535.google.com
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> The build/tests/functional subdirectories are consuming huge amounts
> of disk space.
>
> Split the location for scratch files into a 'scratch' sub-directory,
> separate from log files, and delete it upon completion of each test.
> The new env variable QEMU_TEST_KEEP_SCRATCH can be set to preserve
> this scratch dir for debugging access if required.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  docs/devel/testing/functional.rst      |  6 ++++++
>  tests/functional/qemu_test/testcase.py | 14 +++++++++-----
>  2 files changed, 15 insertions(+), 5 deletions(-)
>
> diff --git a/docs/devel/testing/functional.rst b/docs/devel/testing/funct=
ional.rst
> index bf6f1bb81e..6b5d0c5b98 100644
> --- a/docs/devel/testing/functional.rst
> +++ b/docs/devel/testing/functional.rst
> @@ -65,6 +65,12 @@ to the QEMU binary that should be used for the test, f=
or example::
>    $ export QEMU_TEST_QEMU_BINARY=3D$PWD/qemu-system-x86_64
>    $ python3 ../tests/functional/test_file.py
>=20=20
> +The test framework will automatically purge any scratch files created du=
ring
> +the tests. If needing to debug a failed test, it is possible to keep the=
se
> +files around on disk by setting ```QEMU_TEST_KEEP_SCRATCH=3D1``` as an e=
nv
> +variable.  Any preserved files will be deleted the next time the test is=
 run
> +without this variable set.
> +
>  Overview
>  --------
>=20=20
> diff --git a/tests/functional/qemu_test/testcase.py b/tests/functional/qe=
mu_test/testcase.py
> index 411978b5ef..b9418e2ac0 100644
> --- a/tests/functional/qemu_test/testcase.py
> +++ b/tests/functional/qemu_test/testcase.py
> @@ -13,8 +13,9 @@
>=20=20
>  import logging
>  import os
> -import subprocess
>  import pycotap
> +import shutil
> +import subprocess
>  import sys
>  import unittest
>  import uuid
> @@ -40,11 +41,12 @@ def setUp(self, bin_prefix):
>          self.assertIsNotNone(self.qemu_bin, 'QEMU_TEST_QEMU_BINARY must =
be set')
>          self.arch =3D self.qemu_bin.split('-')[-1]
>=20=20
> -        self.workdir =3D os.path.join(BUILD_DIR, 'tests/functional', sel=
f.arch,
> -                                    self.id())
> +        self.outputdir =3D os.path.join(BUILD_DIR, 'tests', 'functional',
> +                                      self.arch, self.id())

I don't think you need save self.outputdir as only self.logdir is used
by the other functions.

> +        self.workdir =3D os.path.join(self.outputdir, 'scratch')
>          os.makedirs(self.workdir, exist_ok=3DTrue)
>=20=20
> -        self.logdir =3D self.workdir
> +        self.logdir =3D self.outputdir
>          self.log_filename =3D os.path.join(self.logdir, 'base.log')
>          self.log =3D logging.getLogger('qemu-test')
>          self.log.setLevel(logging.DEBUG)
> @@ -56,6 +58,8 @@ def setUp(self, bin_prefix):
>          self.log.addHandler(self._log_fh)
>=20=20
>      def tearDown(self):
> +        if "QEMU_TEST_KEEP_SCRATCH" not in os.environ:
> +            shutil.rmtree(self.workdir)
>          self.log.removeHandler(self._log_fh)
>=20=20
>      def main():
> @@ -108,7 +112,7 @@ def setUp(self):
>=20=20
>          console_log =3D logging.getLogger('console')
>          console_log.setLevel(logging.DEBUG)
> -        self.console_log_name =3D os.path.join(self.workdir, 'console.lo=
g')
> +        self.console_log_name =3D os.path.join(self.logdir, 'console.log=
')
>          self._console_log_fh =3D logging.FileHandler(self.console_log_na=
me,
>                                                     mode=3D'w')
>          self._console_log_fh.setLevel(logging.DEBUG)

Otherwise:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>


--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

