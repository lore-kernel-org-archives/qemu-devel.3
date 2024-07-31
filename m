Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69610C3DA7F
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 14:25:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZAFw-0000PS-10; Wed, 31 Jul 2024 10:24:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sZAFu-0000Nb-5h
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 10:24:42 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sZAFq-00083e-QJ
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 10:24:41 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a7ab76558a9so180768866b.1
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2024 07:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722435877; x=1723040677; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=JG24vtz8ETS40lIwRB20UNh7kxLPPzw9cvGAhVyQoak=;
 b=GQbGm38nzYaTsCZ2ftmU1ugSNTuWTtCUPQNWQ+p0ovsJJdnyJkJGD0qysf9ZvMpXwx
 kAQFrX1HBLYK43qRQhyQTW6gINPJKKXQZ1/iBcRSpLcTw8Ss+9qd7c1rEq92hPHqZtwk
 1h/6u9urzjFVz/fLudUo6GKEZCqmnQNIickmrB4L/egBsfXhq+W9FGHc4FUEO883AuQZ
 7f+V/cWtsf+8p9sGMW3asR/sDSxSJm495J2/wdqdWm0HcFEGnI2xme2z9X43DO+OG3pc
 flGtaMgVlssaYLW1jAVS+lkGVEcbNyXLKWCUcjR5WWqw9+8jXsYrk+CO3GpekRatHsCA
 Cm0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722435877; x=1723040677;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JG24vtz8ETS40lIwRB20UNh7kxLPPzw9cvGAhVyQoak=;
 b=TnnkSOdFfW1y7OfUutQ1tqk3U/0Jx3XaiQE70AIh3qafey9P22PC6FEO9htb6N9j9H
 5w0ID5zrLnn0jrU5QwvSVUNLOVcgkFABjq+p3eKMAoE/kAQu4FQ6a0gg49wjKOTFPgXQ
 OzO7hbv+ZOIv95H6WyMvD4X0EjwFhs0r0I+SxJme8vYjex348qptZml2kcloQ2i9JA3G
 IMDGcZUbayLMiZSxK1DaVsGW09cyK39GMaDqz/8BDRlhsp3yJoXdgbvh8Z0BC8jgbeI6
 XswMTi/qNDT/J1sHNkYMajv2RFmC+/45Ge5F2osbJ6FZsamuLlj59ifB6K4/hRQGJjbS
 2mlw==
X-Gm-Message-State: AOJu0Yy+b4Fw4FM/QsUey5AY5OcHd+NnSUfcfs9SSql4Uo5/8AI2Nr/4
 k7ZLmCQZ/Jbnohth6DR4WF4ghxa+K5vIreKgGtzloNdGvSanyGjLz2gYlPiqfN8=
X-Google-Smtp-Source: AGHT+IG/ThELwy3tLT4uCnBfjYeX5o6RL52NoEyPsjIXMx+xF9QWcHpmRusaQ0JGAqf0Pt94U6qHpA==
X-Received: by 2002:a17:907:97c7:b0:a6f:996f:23ea with SMTP id
 a640c23a62f3a-a7d859645f0mr563408066b.15.1722435876783; 
 Wed, 31 Jul 2024 07:24:36 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7acadb98a2sm769247366b.217.2024.07.31.07.24.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Jul 2024 07:24:36 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 399A35F8CB;
 Wed, 31 Jul 2024 15:24:35 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  Fabiano Rosas <farosas@suse.de>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  John
 Snow <jsnow@redhat.com>,  qemu-ppc@nongnu.org,  Richard Henderson
 <richard.henderson@linaro.org>,  Ani Sinha <anisinha@redhat.com>,  Thomas
 Huth <thuth@redhat.com>
Subject: Re: [PATCH v3 02/24] tests/functional: Add base classes for the
 upcoming pytest-based tests
In-Reply-To: <20240730170347.4103919-3-berrange@redhat.com> ("Daniel P.
 =?utf-8?Q?Berrang=C3=A9=22's?= message of "Tue, 30 Jul 2024 18:03:22
 +0100")
References: <20240730170347.4103919-1-berrange@redhat.com>
 <20240730170347.4103919-3-berrange@redhat.com>
Date: Wed, 31 Jul 2024 15:24:35 +0100
Message-ID: <87ed79fxlo.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

> From: Thomas Huth <thuth@redhat.com>
>
> The file is mostly a copy of the tests/avocado/avocado_qemu/__init__.py
> file with some adjustments to get rid of the Avocado dependencies (i.e.
> we also have to drop the LinuxSSHMixIn and LinuxTest for now).
>
> The emulator binary and build directory are now passed via
> environment variables that will be set via meson.build later.
<snip>
> diff --git a/tests/functional/qemu_test/testcase.py b/tests/functional/qe=
mu_test/testcase.py
> new file mode 100644
> index 0000000000..82cc1d454f
> --- /dev/null
> +++ b/tests/functional/qemu_test/testcase.py
> @@ -0,0 +1,154 @@
> +# Test class and utilities for functional tests
> +#
> +# Copyright 2018, 2024 Red Hat, Inc.
> +#
> +# Original Author (Avocado-based tests):
> +#  Cleber Rosa <crosa@redhat.com>
> +#
> +# Adaption for standalone version:
> +#  Thomas Huth <thuth@redhat.com>
> +#
> +# This work is licensed under the terms of the GNU GPL, version 2 or
> +# later.  See the COPYING file in the top-level directory.
> +
> +import logging
> +import os
> +import pycotap
> +import sys
> +import unittest
> +import uuid
> +
> +from qemu.machine import QEMUMachine
> +from qemu.utils import kvm_available, tcg_available
> +
> +from .cmd import run_cmd
> +from .config import BUILD_DIR
> +
> +
> +class QemuBaseTest(unittest.TestCase):
> +
> +    qemu_bin =3D os.getenv('QEMU_TEST_QEMU_BINARY')
> +    arch =3D None
> +
> +    workdir =3D None
> +    log =3D logging.getLogger('qemu-test')
> +
> +    def setUp(self, bin_prefix):
> +        self.assertIsNotNone(self.qemu_bin, 'QEMU_TEST_QEMU_BINARY must =
be set')
> +        self.arch =3D self.qemu_bin.split('-')[-1]
> +
> +        self.workdir =3D os.path.join(BUILD_DIR, 'tests/functional', sel=
f.arch,
> +                                    self.id())
> +        if not os.path.exists(self.workdir):
> +            os.makedirs(self.workdir)

This is racy under --repeat:

  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D 1/4 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
  test:         qemu:func-quick+func-riscv64 / func-riscv64-riscv_opensbi
  start time:   14:16:52
  duration:     0.06s
  result:       exit status 1
  command:      PYTHONPATH=3D/home/alex/lsrc/qemu.git/python:/home/alex/lsr=
c/qemu.git/tests/functional QEMU_BUILD_ROOT=3D/home/alex/lsrc/qemu.git/buil=
ds/all QEMU_TEST_QEMU_BINARY=3D
  /home/alex/lsrc/qemu.git/builds/all/qemu-system-riscv64 MALLOC_PERTURB_=
=3D71 QEMU_TEST_QEMU_IMG=3D/home/alex/lsrc/qemu.git/builds/all/qemu-img /ho=
me/alex/lsrc/qemu.git/builds/al
  l/pyvenv/bin/python3 /home/alex/lsrc/qemu.git/tests/functional/test_riscv=
_opensbi.py
  ----------------------------------- stdout ------------------------------=
-----
  TAP version 13
  not ok 1 test_riscv_opensbi.RiscvOpenSBI.test_riscv_sifive_u
  not ok 2 test_riscv_opensbi.RiscvOpenSBI.test_riscv_spike
  not ok 3 test_riscv_opensbi.RiscvOpenSBI.test_riscv_virt
  1..3
  ----------------------------------- stderr ------------------------------=
-----
  Traceback (most recent call last):
    File "/home/alex/lsrc/qemu.git/tests/functional/qemu_test/testcase.py",=
 line 85, in setUp
      super().setUp('qemu-system-')
    File "/home/alex/lsrc/qemu.git/tests/functional/qemu_test/testcase.py",=
 line 45, in setUp
      os.makedirs(self.workdir)
    File "<frozen os>", line 225, in makedirs=20
  FileExistsError: [Errno 17] File exists: '/home/alex/lsrc/qemu.git/builds=
/all/tests/functional/riscv64/test_riscv_opensbi.RiscvOpenSBI.test_riscv_si=
five_u'

  Traceback (most recent call last):
    File "/home/alex/lsrc/qemu.git/tests/functional/qemu_test/testcase.py",=
 line 85, in setUp
      super().setUp('qemu-system-')
    File "/home/alex/lsrc/qemu.git/tests/functional/qemu_test/testcase.py",=
 line 45, in setUp
      os.makedirs(self.workdir)
    File "<frozen os>", line 225, in makedirs=20
  FileExistsError: [Errno 17] File exists: '/home/alex/lsrc/qemu.git/builds=
/all/tests/functional/riscv64/test_riscv_opensbi.RiscvOpenSBI.test_riscv_sp=
ike'

  Traceback (most recent call last):
    File "/home/alex/lsrc/qemu.git/tests/functional/qemu_test/testcase.py",=
 line 85, in setUp
      super().setUp('qemu-system-')
    File "/home/alex/lsrc/qemu.git/tests/functional/qemu_test/testcase.py",=
 line 45, in setUp
      os.makedirs(self.workdir)
    File "<frozen os>", line 225, in makedirs=20
  FileExistsError: [Errno 17] File exists: '/home/alex/lsrc/qemu.git/builds=
/all/tests/functional/riscv64/test_riscv_opensbi.RiscvOpenSBI.test_riscv_vi=
rt'


  (test program exited with status code 1)

We could just:

  os.makedirs(self.workdir, exist_ok =3D True)

<snip>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

