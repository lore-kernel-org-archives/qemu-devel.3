Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D4ADC021B8
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Mar 2025 11:58:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpQtY-0002bO-Nl; Tue, 04 Mar 2025 06:57:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tpQtM-0002aV-Vi
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 06:57:00 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tpQtI-00083T-Ro
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 06:56:56 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-390fb1b987fso3455496f8f.1
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 03:56:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741089410; x=1741694210; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GQIJeUPdS/YNSvgS9zmk2AevijokA5rIojg/Bz5kWVA=;
 b=mcHXyQTmDFcIsfpsrpWQk6EFyQPT50/PTTVEH7Jjlgj3DqVkrHBFMDRXHFLWQFbd5I
 GRfni4B2YkG+uVja0Esb7VxMtFu/ov42N0yirilu/YZapOizHTw+jgL/2Lo/4uFiRkPi
 6S+Opf1YUys4h0ZuJm2GZLz7jNzt1nkY/wySnrUFubL1uLPBCThedUdj9b6OdYDo+Wcy
 292mYy0Xury21cqE7CQUkbKCEp35biYTAAXy3TCVRGb7lGwTt/Y/gpehtZcmdU9cfn6o
 xPNmPGN8GMEzyFdF+VDtp+XCS6YtP7bk34UdIrgTBjI7YvybER9/3mAhtddffWEUBOfr
 foMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741089410; x=1741694210;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GQIJeUPdS/YNSvgS9zmk2AevijokA5rIojg/Bz5kWVA=;
 b=DXGL+8c9XcM7U+An6uwDMR0N6ROyyhbM6WM7whuzP31UdPXrkKlhzgl8D3kmJ+hr8u
 Ge9+dkMgpdPfWvUu8ejoOKV7ihgujEH4mlQg7hoEZLScNFPRKFaF4Bmr4hZSJ/n2To/O
 BU5IM+rVKY8sQnhucS32X2rOKEtqvVChRKGg2xiibKEFUb0xxyRd2molN4sw/6TsQWQS
 fYmp7BPnPuprdMs7iIsubl0NElE4WWsh6MPo8dLnBzzl8seT/FMWREGe/jdsTHGc2shw
 zmWuhCmkPAAixUhEGOoRcE/+m+MnSh4o4jP19j5bqqh9AmvXeGqsYeglBmkXjtFHQGf9
 /wmw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUtELY5+TpbhJFNIS1LtBMuXP4Y8JH8hVZq5e3JBajzJx7DW3gWAgc9MQqLobIP1W3lN5wmq9v61MuH@nongnu.org
X-Gm-Message-State: AOJu0YzSXxbqjYJRCIkBgKbdKUEgaibqPiC0y+93Mnpt1o//PbU1ZNzQ
 gADejMxpFqeGxfFERsW+++obPIBP16Fm9c4UTpjdRoq0cib3oZGnhtjfH7ZnbjA=
X-Gm-Gg: ASbGnctKotrRumTuuNkZ6rR34cccJtTVqMBLw89PQLLAqEqS9V+0M9pM5wY0+XM7B/H
 2FxEh0TQKbVieVZVVtHYFrKBrpeOzgDSeJg4WEN6Gc18eubO/zdBAB0rZjiV8luJ8dNcxkIqWn6
 vTW6hU+CfIQbYasp8B5uN0w575wCgpc6wBfiPF3gBHoThud8RCCeszYf2lwezltKokGteiFQEo3
 G162M7Ra6ndnIqDbhyHe1yyZo8fn98RUiKTmrtlPknK6t9FlFN8PVdwKBJFmJhCHxCq2V+U1dlT
 mBnP6lIxkBrkoFyqT8MftNk6Ky7dZfMPjbZFGQhFhV/kbuY=
X-Google-Smtp-Source: AGHT+IH1nlT8qXYGlbZ4ulz/VDtldw0zXiPUT1v190ZmBC8XLU60Qlrx7anTVo5T1HTK8InzcK1wrg==
X-Received: by 2002:a05:6000:1789:b0:391:a43:8bb6 with SMTP id
 ffacd0b85a97d-3910a438e3fmr6597748f8f.33.1741089410308; 
 Tue, 04 Mar 2025 03:56:50 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bca26676esm36213035e9.8.2025.03.04.03.56.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Mar 2025 03:56:49 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 0D93A5F93C;
 Tue,  4 Mar 2025 11:56:49 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org,  qemu-devel@nongnu.org, Brian Cain
 <brian.cain@oss.qualcomm.com>
Subject: Re: [PATCH] tests/tcg: Suppress compiler false-positive warning on
 sha1.c
In-Reply-To: <20250227141343.1675415-1-peter.maydell@linaro.org> (Peter
 Maydell's message of "Thu, 27 Feb 2025 14:13:43 +0000")
References: <20250227141343.1675415-1-peter.maydell@linaro.org>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Tue, 04 Mar 2025 11:56:49 +0000
Message-ID: <87o6yh57r2.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42c.google.com
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

Peter Maydell <peter.maydell@linaro.org> writes:

> GCC versions at least 12 through 15 incorrectly report a warning
> about code in sha1.c:
>
> tests/tcg/multiarch/sha1.c:161:13: warning: =E2=80=98SHA1Transform=E2=80=
=99 reading 64 bytes from a region of size 0 [-Wstringop-overread]
>   161 |             SHA1Transform(context->state, &data[i]);
>       |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> This is a piece of stock library code for doing SHA1 which we've
> simply copied, rather than writing ourselves. The bug has been
> reported to upstream GCC (about a different library's use of this
> code):
>  https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D106709
>
> For our test case, since this isn't our original code and there isn't
> actually a bug in it, suppress the incorrect warning rather than
> trying to modify the code to work around the compiler issue.
<snip>
> --- a/tests/tcg/multiarch/Makefile.target
> +++ b/tests/tcg/multiarch/Makefile.target
> @@ -45,6 +45,14 @@ vma-pthread: LDFLAGS+=3D-pthread
>  sigreturn-sigmask: CFLAGS+=3D-pthread
>  sigreturn-sigmask: LDFLAGS+=3D-pthread
>=20=20
> +# GCC versions 12/13/14/15 at least incorrectly complain about
> +# "'SHA1Transform' reading 64 bytes from a region of size 0"; see the gc=
c bug
> +# https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D106709
> +# Since this is just a standard piece of library code we've borrowed for=
 a
> +# TCG test case, suppress the warning rather than trying to modify the
> +# code to work around the compiler.
> +sha1: CFLAGS+=3D-Wno-stringop-overread
> +

Sadly this breaks the hexagon compiler:

  error: unknown warning option '-Wno-stringop-overread' [-Werror,-Wunknown=
-warning-option]
  Traceback (most recent call last):
    File "/home/alex/lsrc/qemu.git/tests/docker/docker.py", line 683, in <m=
odule>
      sys.exit(main())
               ^^^^^^
    File "/home/alex/lsrc/qemu.git/tests/docker/docker.py", line 679, in ma=
in
      return args.cmdobj.run(args, argv)
             ^^^^^^^^^^^^^^^^^^^^^^^^^^^
    File "/home/alex/lsrc/qemu.git/tests/docker/docker.py", line 657, in run
      return Docker().run(cmd, False, quiet=3Dargs.quiet,
             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
    File "/home/alex/lsrc/qemu.git/tests/docker/docker.py", line 370, in run
      ret =3D self._do_check(["run", "--rm", "--label",
            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
    File "/home/alex/lsrc/qemu.git/tests/docker/docker.py", line 247, in _d=
o_check
      return subprocess.check_call(self._command + cmd, **kwargs)
             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
    File "/usr/lib/python3.11/subprocess.py", line 413, in check_call
      raise CalledProcessError(retcode, cmd)
  subprocess.CalledProcessError: Command '['podman', 'run', '--rm', '--labe=
l', 'com.qemu.instance.uuid=3D5bbb7b6ed2ea4377b9b6d646859ec4ea', '--userns=
=3Dkeep-id', '-u', '1000', '-w', '/home/alex/lsrc/qemu.git/builds/all/tests=
/tcg/hexagon-linux-user', '-v', '/home/alex/lsrc/qemu.git/builds/all/tests/=
tcg/hexagon-linux-user:/home/alex/lsrc/qemu.git/builds/all/tests/tcg/hexago=
n-linux-user:rw', '-v', '/home/alex/lsrc/qemu.git:/home/alex/lsrc/qemu.git:=
ro,z', 'qemu/debian-hexagon-cross', 'hexagon-unknown-linux-musl-clang', '-W=
no-incompatible-pointer-types', '-Wno-undefined-internal', '-fno-unroll-loo=
ps', '-fno-stack-protector', '-Wall', '-Werror', '-O0', '-g', '-fno-strict-=
aliasing', '-Wno-stringop-overread', '-mv73', '-O2', '-static', '/home/alex=
/lsrc/qemu.git/tests/tcg/multiarch/sha1.c', '-o', 'sha1', '-static']' retur=
ned non-zero exit status 1.
  filter=3D--filter=3Dlabel=3Dcom.qemu.instance.uuid=3D5bbb7b6ed2ea4377b9b6=
d646859ec4ea
  make[1]: *** [Makefile:122: sha1] Error 1
  make: *** [/home/alex/lsrc/qemu.git/tests/Makefile.include:52: build-tcg-=
tests-hexagon-linux-user] Error 2

Is it that new an option?

>  # The vma-pthread seems very sensitive on gitlab and we currently
>  # don't know if its exposing a real bug or the test is flaky.
>  ifneq ($(GITLAB_CI),)

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

