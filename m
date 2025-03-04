Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F39A7C021B8
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Mar 2025 13:45:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpSZs-0005QH-7w; Tue, 04 Mar 2025 08:44:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tpSZr-0005PU-E6
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 08:44:55 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tpSZl-000054-B0
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 08:44:52 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43bccfa7b89so4954315e9.2
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 05:44:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741095887; x=1741700687; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HY/KyjOO93Qk38Sc+AJ7gPTFlAmrB03aC1xjm86gcH8=;
 b=gL6agW+UhR4rE9HV9/EvDr5BnY73SyjZEz+Ryhazo70z/OAC+Qe+ao4WIOARhTXoqt
 Y+QYSPu/I76yY/hqr+75NsLIg3GjWkfHlVY9992E0wdX8jgT/eXonbNUaxoCIwI0ApvF
 nwiQP3hLCWHCYNld/p1jYv/W5eihPFA6skowUUg0zTw5pnZ65hUc2NVCfByihJ701TDV
 93WOmpM+fs/Sd2WMwUDW2QX4vzkkWE5145VJMjj4XlpnJp0umPkfgqJuzpK5DpbrSx1r
 Z+mSUWPi7nZgRh8UVuao8PC6cVeUT8ywYC8bZSR2hyUHcJ5MFPKgbgBzFrUkv2gD4KvR
 Zmiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741095887; x=1741700687;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HY/KyjOO93Qk38Sc+AJ7gPTFlAmrB03aC1xjm86gcH8=;
 b=Snn8JelQqqlxFsYfVYgcHVNB+5UmI1/36DADjypINyxwQtlXDc0bwLO+YgmsObDyK/
 shKkTju76mcmbfsyjCklP+p1F5CA8U0nDitw/3p9NfGHY8v5PadBdnpoUEOebKH7Bj2p
 Wr/r38L4q1goMQ1s0527fYTkaf/NyoN7MfsugDkiNhAbOZV5egcjnixbCgMBqgqzsMqA
 aWV4837C4vqPDBUOudVyxfejusmTyKNPfvkN9Yw4PyCemRsBV64gomTt+tDOjCw8EoDB
 5VrfE0a0+pYqsqk3ymloaiWtB+Jd8JsBSasa8olZ9eWmM3LJqz4vQcsrfgDoc9rqOpEl
 MnXw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVcMwUYH6fYF40L3581EDoNBi/vflWNI1swloZUoN1p/CCiGEfkUSbw3qdDDGuMeeQykjLI1PMWAKCG@nongnu.org
X-Gm-Message-State: AOJu0YzQayogb3XKNVwKH2wSFbAG0nNNo4O4+ocVOEDsXl7asoSuNp8l
 8f/yOE+yA/cjoSPhl4HN7FiR2ePF78WqncsAv80HlnQGzIPydyqniQrGZuML4BWyllNtK3bxiGF
 4BDU=
X-Gm-Gg: ASbGnctK3mGVQpsfo7nrmGLn3PuFg8auV1BiRuIiEXdlt2GI812eT3scCGYK/FasmyA
 BxkUe67arSHR4TaD1OOKtY6cO/xZwh/fmTB6+tiIJgbSbPUej4ZUUqLob71s82JKf0h0wOZLUc8
 YKQH0SrmUUBJ6xiHdh6u1WV6kmAESJylzT3NulqjtqGDomWRtp0z+X6CHfNFfwOJXn//878W6/n
 /RlVoLz8rOyRnx0BtLPlmloLP9Ow/X2BS6LbekJ0Ifl3avB64hKhxE0MaUpT41kMuB1N7UvFA37
 ZVJQJGTyuAzCXZu0y2OH9Y5AnqbKsouSGeukXQvGgQk+f54=
X-Google-Smtp-Source: AGHT+IHIfDgPP+pk8tg5K+lbmHXf9+im4SrXVYKoe95GoIVm9L69KclYLpkSqS1GEzv4K6V2icRd0g==
X-Received: by 2002:a05:600c:3583:b0:43b:cb92:8c52 with SMTP id
 5b1f17b1804b1-43bcb928e75mr25192015e9.12.1741095887483; 
 Tue, 04 Mar 2025 05:44:47 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bbb15841dsm93424975e9.1.2025.03.04.05.44.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Mar 2025 05:44:46 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 5E6555F93C;
 Tue,  4 Mar 2025 13:44:45 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org,  qemu-devel@nongnu.org,  Brian Cain
 <brian.cain@oss.qualcomm.com>
Subject: Re: [PATCH] tests/tcg: Suppress compiler false-positive warning on
 sha1.c
In-Reply-To: <CAFEAcA9VDtWKoQ09dOt+ZxJ2MhdRTFY_X1ON58pEjYTM_NtZ-A@mail.gmail.com>
 (Peter Maydell's message of "Tue, 4 Mar 2025 12:51:34 +0000")
References: <20250227141343.1675415-1-peter.maydell@linaro.org>
 <87o6yh57r2.fsf@draig.linaro.org>
 <CAFEAcA9VDtWKoQ09dOt+ZxJ2MhdRTFY_X1ON58pEjYTM_NtZ-A@mail.gmail.com>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Tue, 04 Mar 2025 13:44:45 +0000
Message-ID: <87ikoo6hbm.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x335.google.com
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

> On Tue, 4 Mar 2025 at 11:56, Alex Benn=C3=A9e <alex.bennee@linaro.org> wr=
ote:
>>
>> Peter Maydell <peter.maydell@linaro.org> writes:
>> > +# GCC versions 12/13/14/15 at least incorrectly complain about
>> > +# "'SHA1Transform' reading 64 bytes from a region of size 0"; see the=
 gcc bug
>> > +# https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D106709
>> > +# Since this is just a standard piece of library code we've borrowed =
for a
>> > +# TCG test case, suppress the warning rather than trying to modify the
>> > +# code to work around the compiler.
>> > +sha1: CFLAGS+=3D-Wno-stringop-overread
>> > +
>>
>> Sadly this breaks the hexagon compiler:
>>
>>   error: unknown warning option '-Wno-stringop-overread' [-Werror,-Wunkn=
own-warning-option]
>>   Traceback (most recent call last):
>>     File "/home/alex/lsrc/qemu.git/tests/docker/docker.py", line 683, in=
 <module>
>>       sys.exit(main())
>>                ^^^^^^
>>     File "/home/alex/lsrc/qemu.git/tests/docker/docker.py", line 679, in=
 main
>>       return args.cmdobj.run(args, argv)
>>              ^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>     File "/home/alex/lsrc/qemu.git/tests/docker/docker.py", line 657, in=
 run
>>       return Docker().run(cmd, False, quiet=3Dargs.quiet,
>>              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>     File "/home/alex/lsrc/qemu.git/tests/docker/docker.py", line 370, in=
 run
>>       ret =3D self._do_check(["run", "--rm", "--label",
>>             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>     File "/home/alex/lsrc/qemu.git/tests/docker/docker.py", line 247, in=
 _do_check
>>       return subprocess.check_call(self._command + cmd, **kwargs)
>>              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>     File "/usr/lib/python3.11/subprocess.py", line 413, in check_call
>>       raise CalledProcessError(retcode, cmd)
>>   subprocess.CalledProcessError: Command '['podman', 'run', '--rm', '--l=
abel', 'com.qemu.instance.uuid=3D5bbb7b6ed2ea4377b9b6d646859ec4ea', '--user=
ns=3Dkeep-id', '-u', '1000', '-w', '/home/alex/lsrc/qemu.git/builds/all/tes=
ts/tcg/hexagon-linux-user', '-v', '/home/alex/lsrc/qemu.git/builds/all/test=
s/tcg/hexagon-linux-user:/home/alex/lsrc/qemu.git/builds/all/tests/tcg/hexa=
gon-linux-user:rw', '-v', '/home/alex/lsrc/qemu.git:/home/alex/lsrc/qemu.gi=
t:ro,z', 'qemu/debian-hexagon-cross', 'hexagon-unknown-linux-musl-clang', '=
-Wno-incompatible-pointer-types', '-Wno-undefined-internal', '-fno-unroll-l=
oops', '-fno-stack-protector', '-Wall', '-Werror', '-O0', '-g', '-fno-stric=
t-aliasing', '-Wno-stringop-overread', '-mv73', '-O2', '-static', '/home/al=
ex/lsrc/qemu.git/tests/tcg/multiarch/sha1.c', '-o', 'sha1', '-static']' ret=
urned non-zero exit status 1.
>>   filter=3D--filter=3Dlabel=3Dcom.qemu.instance.uuid=3D5bbb7b6ed2ea4377b=
9b6d646859ec4ea
>>   make[1]: *** [Makefile:122: sha1] Error 1
>>   make: *** [/home/alex/lsrc/qemu.git/tests/Makefile.include:52: build-t=
cg-tests-hexagon-linux-user] Error 2
>>
>> Is it that new an option?
>
> I think it's new-ish (gcc 11?). On the other hand
> -Wno-unknown-warning-option is quite old, and would suppress
> this error. If we do
>  CFLAGS+=3D-Wno-unknown-warning-option -Wno-stringop-overread
>
> does that work?

Yes, I did:

modified   tests/tcg/hexagon/Makefile.target
@@ -18,7 +18,7 @@
 # Hexagon doesn't support gdb, so skip the EXTRA_RUNS
 EXTRA_RUNS =3D
=20
-CFLAGS +=3D -Wno-incompatible-pointer-types -Wno-undefined-internal
+CFLAGS +=3D -Wno-incompatible-pointer-types -Wno-undefined-internal -Wno-u=
nknown-warning-option
 CFLAGS +=3D -fno-unroll-loops -fno-stack-protector


>
> (Meson has cc.get_supported_arguments() that we can use to
> filter out -Wfoo/-Wno-foo options that the compiler doesn't
> support, but since this is built via a makefile rather than
> by meson that's not conveniently accessible.)
>
> -- PMM

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

