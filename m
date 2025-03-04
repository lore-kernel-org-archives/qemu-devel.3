Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 085FCC282D6
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Mar 2025 12:57:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpRnD-0005Ak-1F; Tue, 04 Mar 2025 07:54:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tpRkT-00017l-RH
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 07:51:55 -0500
Received: from mail-yw1-x112c.google.com ([2607:f8b0:4864:20::112c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tpRkR-00087t-HH
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 07:51:49 -0500
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-6fb2a0e4125so36726127b3.1
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 04:51:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741092706; x=1741697506; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uxGGuaI68JKtynFFjWwLnLjsUcyuO6IkGZ9JrNoj9Hk=;
 b=Qp7VukeVolGztW7WROcl+ms1eTileftKRf4hgtnQKXwK3LoJUbk/kpVYP7gJM2OO7L
 L1Jx8mfv39mD4q+PxbMtDEG5pcD1Ku1gEHnY9qywDnKQQgVG7nNfd3YpYzRAw/bOV94k
 wc+k3B+NHQe/HzZro2K5kSiK2e1Xu2j7E8Ze3A49IKHNXy6vOrXcs5Bu+AwLWA/W0xXy
 GHLWWvpaX6SV+HNphEARTcga4Zykt+L9a5rG6Apu7RurDJYxPAdEtc/aQkNbtHp1TDLa
 LzhGgnKDQPllWdnCOMmmte8W0V7EF3MESVrPWNSB0uVgcsdkWJqCTU2PInbMH4gRqH+2
 wnhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741092706; x=1741697506;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uxGGuaI68JKtynFFjWwLnLjsUcyuO6IkGZ9JrNoj9Hk=;
 b=pSax8+pbWVFa4MYfuvfDwaeozSN8SDGP1qZVp4yV2M4ELKHYW2tdhXI4B02SyPBD7k
 KytQzbtKVsRcB57kTANp2l1AflQe/OQyjXAxCpnsxfO2No1FnLLyAHDBc/3yAGdzHB4K
 I2EpzwqRuSjGM3U/Ye1nJ8LSo0u1SDFT0qsUp6DML1zjc2MBv4CvxrKjtzNoHLfRkzEp
 1dcWzuvoD/OLn9zDK7mS2ArnbZ4JBLiI5CgzGrD+bkvOMf0rDjt6Mso7I4GbZzADvlDp
 0e8ns6jVIzti1kSBTOxXfoUCOlPxFp90xuqFnafjsz669ZOaRNmfXX8pxI+nBAg615Ps
 eojQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4rxiZdIIGzH/WcBrIN8ur4xq8gxI1lswoHbMHMpE4lbSeCxOyXIiXVQUrRnZ7qtOICUTI2VTsl6VL@nongnu.org
X-Gm-Message-State: AOJu0YwhRNVhgHdPd1UDFJvPcwar5tbU95hIarnQrFfrs2wXnAUsww4g
 qmpI/BgojkNGNSZ9U22c5kuxqLAS54wSfTubLPJDZZ076+6XWzh5BLTtRVqULbu1zu7aMMw3ggB
 jA2SgXGgZzDzwCJTCt2FkNHnkoEcQqSiDluFARA==
X-Gm-Gg: ASbGnct27vzMfNVI7wtyDR3dKsxkHpstoZDN74RhS4jD3GZZwDtlDqyrmmtv4IMsMXi
 yS2gthuBCCoDtmKga16BcQjjdfdGeM7RQs9uIhzG7uTBYNCOWD0qKZc74Uwogrw6TqQJ9cep4/d
 P8XlfSN6t2EV57ML4NOBjB9E/Nb2M=
X-Google-Smtp-Source: AGHT+IFrMaw5WXbhjojnTuWjafeg9jqYR5kLnuDJEsEs2jRm4DP5ngCjEjC1wDmiwD29KO9B96YcLpmxsqAClMk3SoA=
X-Received: by 2002:a05:690c:600a:b0:6ef:761e:cfc with SMTP id
 00721157ae682-6fd4a1405a8mr223122747b3.25.1741092705838; Tue, 04 Mar 2025
 04:51:45 -0800 (PST)
MIME-Version: 1.0
References: <20250227141343.1675415-1-peter.maydell@linaro.org>
 <87o6yh57r2.fsf@draig.linaro.org>
In-Reply-To: <87o6yh57r2.fsf@draig.linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 4 Mar 2025 12:51:34 +0000
X-Gm-Features: AQ5f1JqdU7-x-zWWBzJjlhTFs9_xhTkqxqg-1afm2BT6H0-52lc3IttwZY4Klew
Message-ID: <CAFEAcA9VDtWKoQ09dOt+ZxJ2MhdRTFY_X1ON58pEjYTM_NtZ-A@mail.gmail.com>
Subject: Re: [PATCH] tests/tcg: Suppress compiler false-positive warning on
 sha1.c
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Brian Cain <brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112c.google.com
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

On Tue, 4 Mar 2025 at 11:56, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
>
> Peter Maydell <peter.maydell@linaro.org> writes:
> > +# GCC versions 12/13/14/15 at least incorrectly complain about
> > +# "'SHA1Transform' reading 64 bytes from a region of size 0"; see the =
gcc bug
> > +# https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D106709
> > +# Since this is just a standard piece of library code we've borrowed f=
or a
> > +# TCG test case, suppress the warning rather than trying to modify the
> > +# code to work around the compiler.
> > +sha1: CFLAGS+=3D-Wno-stringop-overread
> > +
>
> Sadly this breaks the hexagon compiler:
>
>   error: unknown warning option '-Wno-stringop-overread' [-Werror,-Wunkno=
wn-warning-option]
>   Traceback (most recent call last):
>     File "/home/alex/lsrc/qemu.git/tests/docker/docker.py", line 683, in =
<module>
>       sys.exit(main())
>                ^^^^^^
>     File "/home/alex/lsrc/qemu.git/tests/docker/docker.py", line 679, in =
main
>       return args.cmdobj.run(args, argv)
>              ^^^^^^^^^^^^^^^^^^^^^^^^^^^
>     File "/home/alex/lsrc/qemu.git/tests/docker/docker.py", line 657, in =
run
>       return Docker().run(cmd, False, quiet=3Dargs.quiet,
>              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>     File "/home/alex/lsrc/qemu.git/tests/docker/docker.py", line 370, in =
run
>       ret =3D self._do_check(["run", "--rm", "--label",
>             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>     File "/home/alex/lsrc/qemu.git/tests/docker/docker.py", line 247, in =
_do_check
>       return subprocess.check_call(self._command + cmd, **kwargs)
>              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>     File "/usr/lib/python3.11/subprocess.py", line 413, in check_call
>       raise CalledProcessError(retcode, cmd)
>   subprocess.CalledProcessError: Command '['podman', 'run', '--rm', '--la=
bel', 'com.qemu.instance.uuid=3D5bbb7b6ed2ea4377b9b6d646859ec4ea', '--usern=
s=3Dkeep-id', '-u', '1000', '-w', '/home/alex/lsrc/qemu.git/builds/all/test=
s/tcg/hexagon-linux-user', '-v', '/home/alex/lsrc/qemu.git/builds/all/tests=
/tcg/hexagon-linux-user:/home/alex/lsrc/qemu.git/builds/all/tests/tcg/hexag=
on-linux-user:rw', '-v', '/home/alex/lsrc/qemu.git:/home/alex/lsrc/qemu.git=
:ro,z', 'qemu/debian-hexagon-cross', 'hexagon-unknown-linux-musl-clang', '-=
Wno-incompatible-pointer-types', '-Wno-undefined-internal', '-fno-unroll-lo=
ops', '-fno-stack-protector', '-Wall', '-Werror', '-O0', '-g', '-fno-strict=
-aliasing', '-Wno-stringop-overread', '-mv73', '-O2', '-static', '/home/ale=
x/lsrc/qemu.git/tests/tcg/multiarch/sha1.c', '-o', 'sha1', '-static']' retu=
rned non-zero exit status 1.
>   filter=3D--filter=3Dlabel=3Dcom.qemu.instance.uuid=3D5bbb7b6ed2ea4377b9=
b6d646859ec4ea
>   make[1]: *** [Makefile:122: sha1] Error 1
>   make: *** [/home/alex/lsrc/qemu.git/tests/Makefile.include:52: build-tc=
g-tests-hexagon-linux-user] Error 2
>
> Is it that new an option?

I think it's new-ish (gcc 11?). On the other hand
-Wno-unknown-warning-option is quite old, and would suppress
this error. If we do
 CFLAGS+=3D-Wno-unknown-warning-option -Wno-stringop-overread

does that work?

(Meson has cc.get_supported_arguments() that we can use to
filter out -Wfoo/-Wno-foo options that the compiler doesn't
support, but since this is built via a makefile rather than
by meson that's not conveniently accessible.)

-- PMM

