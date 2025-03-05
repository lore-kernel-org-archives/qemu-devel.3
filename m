Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34B1FC282DE
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 16:57:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tps3I-0003eY-Uh; Wed, 05 Mar 2025 11:57:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tps3D-0003Vn-NS
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 11:56:56 -0500
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tps3B-0006um-Am
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 11:56:55 -0500
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5dee07e51aaso13193805a12.3
 for <qemu-devel@nongnu.org>; Wed, 05 Mar 2025 08:56:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741193811; x=1741798611; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Llya3cKTylfTdJlmzelKgDKlLlGaQCfDm77o7jsNxaE=;
 b=YoZFrhtPPnl1YAAx38VRcFYmp84J17aMe5nVI2a9vSZk5OukGaiVhA5OrRGdrkULn8
 srRqI12fu+4kNSM4AKNUPi1JO42n3TuJhoJU49mLTo/lNsTU7xqDQCedmo8wP3EHFBKO
 1rbS0N3cUMlLp+Phoe73mAoStdi9QQmlKNKsBrXdWNgJ+4Aby4/Ket0x8KWneljGFCI2
 GrJL8lSYF3fQBHL/TD1CAT8zkgw3r2GuQKWIBYRoB1NGGjMN4AXZw+Cqs+eDzO6gRZbs
 TRfjZTzh3uQF7Kfegt1uDik24qvS0MylfHTYB+a6tbpREgjYxlKd2QdBwFdMSlvmYTI0
 FWVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741193811; x=1741798611;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Llya3cKTylfTdJlmzelKgDKlLlGaQCfDm77o7jsNxaE=;
 b=OBwl9pMTQbVuf6KWyy2ZH8M1O4SQ5i0/V+v9eEbpmmOY/SlifpoBALO8Kwx9OXUCae
 tkLNxgs5x/xb6S0vgd10v/w8NtDQlj2JaoUiH9WN9RbXo7tvy9OTq7u0BCcJh+wT60Yx
 VK9tGA1yebVz8HB3wpShSEA5+/dhg2KmSuqnITJ4UoDyK8vImFPLWTGuh7uodCgHYqdn
 vHJgdIVOCarT2yoZBGcXFyLEEDNOgcckOHo7kq+4Rd2pcWtnwA+gCTDp47qIIf0vRR2k
 jtpiMch6Y3Jbt8zsiTMdS9jmVdllfPWVZ7Yq6VEbvN2YqnnznRbWu18rbo5/z7WVtu5I
 /4UQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXUIOBmEhY4ugO945pTyQxV/4994LVi5iujRWBPmLi1jrkiZ9ii3RE0ytfRU8Vr6KqKVJJU9lnEsAYw@nongnu.org
X-Gm-Message-State: AOJu0YxM+WH3QQ23+gZ6aKx7P11XoIJ8FoQOmsvguvBtZnNEH0wPr5Gm
 5WL841zzxtsNmpSRcIHTmBaWTvLzWEbGtKosDnZdIuNb6syiC6Gy8EWuHEZNQapUffKZgEUMOz9
 hy/Y=
X-Gm-Gg: ASbGncvAfWvo1IAVWO2GVYaND7Z1nrn0bjTzvFcPC8m+u8Lf0jY32lPNIUWo5z6c1CY
 efx1aF4iYumqAJNEBf1Ewm+nrw9zgnp8Q/Vm6rs52hNWh+OjiZ57DPiRFNBQWdD7Cne90Ny1eat
 lTOEIO3VBy14o8E+egnc/JM8C9Um8VU8uzAlGiNMxhZ4ow+ayJ6XzGoMBBUB33DDpijDpLd/ciM
 Bs+Vj7wDTAGReHPcyTYAAMzoiBk/Zmap66vZxVUhY2aC1ZbMqI5oHeU5lhu+Rvx3ATbzdRaBetT
 6XzBg/LZXkRGYVKz7n82KZDv9NEncNRN7WJ/yvRQZdAgDgs=
X-Google-Smtp-Source: AGHT+IFzAKSYYFW11gsREt2ZSv/Z2fKwFJHEX9/bgRVgfxMTzhRbw4AAegwlf0oqZCZ6UH98MOXgZg==
X-Received: by 2002:a05:6402:3495:b0:5e4:b874:3df7 with SMTP id
 4fb4d7f45d1cf-5e59f4cc1f2mr4213907a12.25.1741193810698; 
 Wed, 05 Mar 2025 08:56:50 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5e4c3b4aa3bsm9867128a12.16.2025.03.05.08.56.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Mar 2025 08:56:50 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 7592B5F932;
 Wed,  5 Mar 2025 16:56:48 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,  qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Subject: Re: [PATCH] tests/tcg: Suppress compiler false-positive warning on
 sha1.c
In-Reply-To: <2de21adf-204b-4417-aa2b-2d16d22148f8@oss.qualcomm.com> (Brian
 Cain's message of "Wed, 5 Mar 2025 08:56:26 -0600")
References: <20250227141343.1675415-1-peter.maydell@linaro.org>
 <87o6yh57r2.fsf@draig.linaro.org>
 <CAFEAcA9VDtWKoQ09dOt+ZxJ2MhdRTFY_X1ON58pEjYTM_NtZ-A@mail.gmail.com>
 <2de21adf-204b-4417-aa2b-2d16d22148f8@oss.qualcomm.com>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Wed, 05 Mar 2025 16:56:48 +0000
Message-ID: <87ikon4drj.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x536.google.com
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

Brian Cain <brian.cain@oss.qualcomm.com> writes:

> On 3/4/2025 6:51 AM, Peter Maydell wrote:
>> On Tue, 4 Mar 2025 at 11:56, Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
>>> Peter Maydell <peter.maydell@linaro.org> writes:
>>>> +# GCC versions 12/13/14/15 at least incorrectly complain about
>>>> +# "'SHA1Transform' reading 64 bytes from a region of size 0"; see the=
 gcc bug
>>>> +# https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D106709
>>>> +# Since this is just a standard piece of library code we've borrowed =
for a
>>>> +# TCG test case, suppress the warning rather than trying to modify the
>>>> +# code to work around the compiler.
>>>> +sha1: CFLAGS+=3D-Wno-stringop-overread
>>>> +
>>> Sadly this breaks the hexagon compiler:
>>>
>>>    error: unknown warning option '-Wno-stringop-overread' [-Werror,-Wun=
known-warning-option]
>>>    Traceback (most recent call last):
>>>      File "/home/alex/lsrc/qemu.git/tests/docker/docker.py", line 683, =
in <module>
>>>        sys.exit(main())
>>>                 ^^^^^^
>>>      File "/home/alex/lsrc/qemu.git/tests/docker/docker.py", line 679, =
in main
>>>        return args.cmdobj.run(args, argv)
>>>               ^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>>      File "/home/alex/lsrc/qemu.git/tests/docker/docker.py", line 657, =
in run
>>>        return Docker().run(cmd, False, quiet=3Dargs.quiet,
>>>               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>>      File "/home/alex/lsrc/qemu.git/tests/docker/docker.py", line 370, =
in run
>>>        ret =3D self._do_check(["run", "--rm", "--label",
>>>              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>>      File "/home/alex/lsrc/qemu.git/tests/docker/docker.py", line 247, =
in _do_check
>>>        return subprocess.check_call(self._command + cmd, **kwargs)
>>>               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>>      File "/usr/lib/python3.11/subprocess.py", line 413, in check_call
>>>        raise CalledProcessError(retcode, cmd)
>>>    subprocess.CalledProcessError: Command '['podman', 'run', '--rm', '-=
-label', 'com.qemu.instance.uuid=3D5bbb7b6ed2ea4377b9b6d646859ec4ea', '--us=
erns=3Dkeep-id', '-u', '1000', '-w', '/home/alex/lsrc/qemu.git/builds/all/t=
ests/tcg/hexagon-linux-user', '-v', '/home/alex/lsrc/qemu.git/builds/all/te=
sts/tcg/hexagon-linux-user:/home/alex/lsrc/qemu.git/builds/all/tests/tcg/he=
xagon-linux-user:rw', '-v', '/home/alex/lsrc/qemu.git:/home/alex/lsrc/qemu.=
git:ro,z', 'qemu/debian-hexagon-cross', 'hexagon-unknown-linux-musl-clang',=
 '-Wno-incompatible-pointer-types', '-Wno-undefined-internal', '-fno-unroll=
-loops', '-fno-stack-protector', '-Wall', '-Werror', '-O0', '-g', '-fno-str=
ict-aliasing', '-Wno-stringop-overread', '-mv73', '-O2', '-static', '/home/=
alex/lsrc/qemu.git/tests/tcg/multiarch/sha1.c', '-o', 'sha1', '-static']' r=
eturned non-zero exit status 1.
>>>    filter=3D--filter=3Dlabel=3Dcom.qemu.instance.uuid=3D5bbb7b6ed2ea437=
7b9b6d646859ec4ea
>>>    make[1]: *** [Makefile:122: sha1] Error 1
>>>    make: *** [/home/alex/lsrc/qemu.git/tests/Makefile.include:52: build=
-tcg-tests-hexagon-linux-user] Error 2
>>>
>>> Is it that new an option?
>> I think it's new-ish (gcc 11?). On the other hand
>
>
> I was going to volunteer to update the toolchain used for hexagon to
> address this.=C2=A0 But unfortunately this warning is still not supported
> in clang 21.
>
> https://github.com/llvm/llvm-project/issues/72455 sounds like it's not
> very likely to arrive any time soon.
>
>
> So "-Wno-unknown-warning-option" does indeed seem like a good workaround.
>
>
>> -Wno-unknown-warning-option is quite old, and would suppress
>> this error. If we do
>>   CFLAGS+=3D-Wno-unknown-warning-option -Wno-stringop-overread

Workaround is fine for the time being then.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

