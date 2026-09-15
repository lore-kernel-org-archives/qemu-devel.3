Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F39EC88E75
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 18:28:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6XsL-0005Sk-VP; Tue, 15 Sep 2026 14:27:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1x6Xre-0005Pr-V8
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 14:26:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1x6XrU-0002bi-2s
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 14:26:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789496784;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OtA/f11gnE0Zf5InXOp5z4oY4SlcHdW+tnKXYxJs2MQ=;
 b=DwyFamuxF+bzdchUfozs8HiSH6OXol78gwLLgob+Wak5C1ld3egTlV2PTuU5zD30pvNr4x
 qsqDQJExDL3+WtOcYA1KezaeI942P1hamMCxks52feWNwcgGaypykfBChpMFw1oSm+kFJ/
 3erU3jtzRdaWN9UwyCTGp/WVVa3tYFc=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-113-jt3aiN_lM7aYQlRQaUg9Sg-1; Tue, 15 Sep 2026 14:26:21 -0400
X-MC-Unique: jt3aiN_lM7aYQlRQaUg9Sg-1
X-Mimecast-MFC-AGG-ID: jt3aiN_lM7aYQlRQaUg9Sg_1789496780
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-8615bb9d4c2so39508627b3.3
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 11:26:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789496780; cv=none;
 d=google.com; s=arc-20260327;
 b=sHfWSSndW4lQN8Jh3ICoVCAGAcmMJ850CyrlFyFqLqKeWZ7RkGTGqao4uKnBi80Ucy
 pgLpzNvNXJP2GISFwE5rxzwZTzMPAkr6XbPczF2gQRDi6xkze65VQvhx4V3wNZsbYQyQ
 1PbwirLzFJRwYn39nonwg8QuuGP8V0+yjceYoip5EE6j2yBWZgeVjJuLC6kiV+XWt/zP
 alQBX95cyNjJ6rDgEReDFop6yu93tkmtUk1wT6fBJXMENjNX1lzMB/Mq7LT2N0HnHbEw
 /cLf+6v6VhGGEqo44XvIfByGlcrpZ+ayNZxhk/6x5EaJraT3WpJQjwASrL9tCx5Pz4lh
 dWwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=OtA/f11gnE0Zf5InXOp5z4oY4SlcHdW+tnKXYxJs2MQ=;
 fh=kMzw4Efcc0fhII5noldOlwHIACx9TtZfxtM+NbCuVfU=;
 b=kWee+kmY65fcul/ClCLXawJhIdpvkesOg7Vpym1At7cHt+mmpu/ku/VgrWh8CTRXC4
 8A74LULE3QD5FFPYPpfPBjtiZAULw+1pnW1B0nnHPUnt47kY6B0AHpmed8P8F6g+GGAC
 AfuTwaRikWYSO9UqZHTFUu7GggTm5+JpymskruwxXkMOxjQAp8M0lEX7AgZ0htTUJrmT
 v3H+GJzWSc/+nCePoDdyo7DGN8J1W8spCzjaq0P9i1jW+itnsz8CfwL/QrVARhPIHonU
 fXzRlvdXmAnuv6Gsmra+tSTL6OG50MEBavshsnJkGVLmYHbjseD/cA9YucNX/e7jqidU
 wRHA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789496780; x=1790101580; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=OtA/f11gnE0Zf5InXOp5z4oY4SlcHdW+tnKXYxJs2MQ=;
 b=LLQhZrIChYf54zlmKl0ASG2XjjI27qXA+RnnnnteC2SKP/AjnK8TocQ56wtJxWMGzR
 jTS+cbfqD9hXzUsViPzoKoXGSJWzF8H/4Cfna2P5WdWYQO3TptE8BQbS8f14I2W0SsxL
 XQbP/lNOJo3f1Jt7aCTe52DzgSCr8yg/km+qj0iapmeqc8BB6gO1Uv2EI70EWw8clU9m
 zqnJYQOMPjzxQBini6rf0rKmO/MJfp5xqAxv9+8GmjmJHbuxdO0mUgeQTvpA9b8PQ7mr
 7PunRd8Qfngp/8Ag7CHdYvERuIgh9wgMyyo2qIeQ2om+q7auvb4vHs9nKhyIZAdywh+m
 U3cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789496780; x=1790101580;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=OtA/f11gnE0Zf5InXOp5z4oY4SlcHdW+tnKXYxJs2MQ=;
 b=g0wjDcHIlyKPSfckDGxkIjQWO2wuNhiERmMHabzQziI9wAC52m99SSC8i4S2v30sra
 EMqfGgNLVZq3DQ8ho7pbxfFvInlMISTksRm98TKNx92tSIeA9pz2qPE5u0hPUKkE8gCs
 vAhESaZqJthsYAKgTx5iGv0QESSpfKD9FMqMt5p6ibmo51j/9QYAOIqtRtq3h2yM1wO3
 695VDU+RP7o/odg+nydFZMhNCWeQ/V6Xkgu+yopED9qInk1VFL4izc7g6n4DqKEyJmjv
 cu9TycohAc+kHd1UQXQBz4Y0hlvdwnXCPAx0wdNUjc1iLVQ2Tmmm5bMi/nkYSbHde7N6
 P5gw==
X-Forwarded-Encrypted: i=1;
 AKwUvBy3CA+8IJnINvfn3pnRDmpri+NbJA9lM3zCeYWB15YciXPBYVTXw8pnEgHhFvmmVTuSgyfYuuv8POQJ@nongnu.org
X-Gm-Message-State: AFuF++mj2sXUsTtuHkwr4XL2+o7Et8rpQaoxQEV4mmf/al4+NFwQ0y6g
 N9LTHRug46Hk9roZlRpCvEMpfsd197ZJfyn1Oa4FQqkSmglgRJAhNoqY5g7I3cYMzwcMgAK9L2M
 8rQL+VLD7WBLGt94wFO/wL2KrOVYg+LFfixvwsDzG3ibk7/5GqvQHntkhvapnKZHkPByY7Y3oQW
 hvVyYd6oLhyW2TODWY5xITcfbWd/MXwrI=
X-Gm-Gg: AYBFou1MmmTAOYR3wOoN9QhtKHi9YjtLvZTrMvoUYzkl8fKIAufM568nB4f45VeVATM
 I7xP8z0ks+AmRd02lUUmyp+0+Sw5NE1Er+mhBrl04Jpb2jgD/qrnJaD1PQHDNMls1/2FhLVBSDh
 vrrJbTsRo/9lwfde4bsksPqbxXjcbu/Rn8qjZvi5spj3q/8hSX1ufh3mWsZnS4yVNzLiI+uqexg
 Y+A6baq97R9qoYL
X-Received: by 2002:a05:690e:4082:b0:668:9fa5:b9cc with SMTP id
 956f58d0204a3-6714def2a12mr3443374d50.0.1789496780207; 
 Tue, 15 Sep 2026 11:26:20 -0700 (PDT)
X-Received: by 2002:a05:690e:4082:b0:668:9fa5:b9cc with SMTP id
 956f58d0204a3-6714def2a12mr3443353d50.0.1789496779735; Tue, 15 Sep 2026
 11:26:19 -0700 (PDT)
MIME-Version: 1.0
References: <20260904150826.2331577-1-alex.bennee@linaro.org>
 <CAFEAcA9vZZmVPP3_P1xz-NX_sqWY0zrOC2LeGLTdnaK54XKQzQ@mail.gmail.com>
 <CAFn=p-bXoctWNEdERPBL-SMRPYDisban2e0-mxYjws7UVcjVzw@mail.gmail.com>
 <a80c4add-8c2a-4a20-8888-223fecc3f697@oss.qualcomm.com>
In-Reply-To: <a80c4add-8c2a-4a20-8888-223fecc3f697@oss.qualcomm.com>
From: John Snow <jsnow@redhat.com>
Date: Tue, 15 Sep 2026 14:26:09 -0400
X-Gm-Features: AcwNN1VVA2jKliaZzBJAtenSPk_leNBrttrpccWl4HbTw5QgipfD8Fz8nK-JFQ0
Message-ID: <CAFn=p-bLuN2La1aqp7rpanjNiezUPk-v4D3kneGiHAPqPO-iyA@mail.gmail.com>
Subject: Re: [PULL v2 000/105] move check-tcg into the meson build
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Sep 15, 2026 at 1:17=E2=80=AFPM Pierrick Bouvier
<pierrick.bouvier@oss.qualcomm.com> wrote:
>
> On 9/15/2026 9:52 AM, John Snow wrote:
> > On Fri, Sep 4, 2026 at 2:04=E2=80=AFPM Peter Maydell <peter.maydell@lin=
aro.org> wrote:
> >>
> >> On Fri, 4 Sept 2026 at 16:08, Alex Benn=C3=A9e <alex.bennee@linaro.org=
> wrote:
> >>>
> >>> The following changes since commit d2843fbf80260e4346c856819e8cea1176=
8c9d0e:
> >>>
> >>>   Merge tag 'pull-riscv-to-apply-20260904' of https://github.com/alis=
tair23/qemu into staging (2026-09-04 09:43:27 +0100)
> >>>
> >>> are available in the Git repository at:
> >>>
> >>>   https://gitlab.com/stsquad/qemu.git tags/pull-11.1-check-tcg-meson-=
040926-2
> >>>
> >>> for you to fetch changes up to 7a485176838e6b6044e73f925d308bb4b30025=
97:
> >>>
> >>>   MAINTAINERS: add maintainer for tcg/tests meson infrastructure (202=
6-09-04 16:06:22 +0100)
> >>>
> >>> ----------------------------------------------------------------
> >>> tests/tcg: conversion to meson
> >>>
> >>>   - remove unused variable from multiarch/memory
> >>>   - standardise checking plugin output
> >>>   - bump minimal meson to 1.6.0
> >>>   - introduce meson plumbing for check-tcg
> >>>   - return error code if docker probe fails
> >>>   - add CI/self/mem test to gdbstub prot-none tests
> >>>   - use raw opcode for fprcvt test in arm
> >>>   - remove unused variables from gpc-test
> >>>   - teach probe-gdb-support about mips
> >>>   - identify or1k pc register
> >>>   - port check-tcg logic to meson (all targets)
> >>>   - update documentation
> >>>   - add Pierrick as a maintainer for tests/tcg
> >
> > Hi, I'm having difficulties building after this PR, after eb7f0c14 in
> > particular.
> >
> > I keep seeing stuff like this:
> >
> > FAILED: [code=3D1] tests/tcg/x86_64-softmmu-hello.test
> > /home/jsnow/src/qemu/tests/tcg/../docker/docker.py --command podman
> > run --run-as-current-user -w /home/jsnow/src/qemu/build -v
> > /home/jsnow/src/qemu:/home/jsnow/src/qemu debian-amd64-cross
> > x86_64-linux-gnu-gcc
> > /home/jsnow/src/qemu/tests/tcg/multiarch/system/hello.c -o
> > tests/tcg/x86_64-softmmu-hello.test -static -MMD -MF
> > tests/tcg/x86_64-softmmu-hello.d -Wall -Werror -O0 -g
> > -fno-strict-aliasing -nostdlib -ffreestanding -Wa,--noexecstack -I
> > /home/jsnow/src/qemu/tests/tcg/x86_64/system/../../minilib
> > /home/jsnow/src/qemu/tests/tcg/x86_64/system/../../minilib/printf.c
> > ../tests/tcg/x86_64/system/boot.S -Wl,-T
> > ../tests/tcg/x86_64/system/kernel.ld -Wl,-melf_x86_64
> > -Wl,--no-warn-rwx-segments -Wl,--build-id=3Dnone -lgcc
> > cc1: fatal error:
> > /home/jsnow/src/qemu/tests/tcg/multiarch/system/hello.c: Permission
> > denied
> > compilation terminated.
> > cc1: fatal error:
> > /home/jsnow/src/qemu/tests/tcg/x86_64/system/../../minilib/printf.c:
> > Permission denied
> > compilation terminated.
> > cc1: fatal error: ../tests/tcg/x86_64/system/boot.S: Permission denied
> > compilation terminated.
> > Traceback (most recent call last):
> >   File "/home/jsnow/src/qemu/tests/tcg/../docker/docker.py", line 657,
> > in <module>
> >     sys.exit(main())
> >              ~~~~^^
> >   File "/home/jsnow/src/qemu/tests/tcg/../docker/docker.py", line 653, =
in main
> >     return args.cmdobj.run(args, argv)
> >            ~~~~~~~~~~~~~~~^^^^^^^^^^^^
> >   File "/home/jsnow/src/qemu/tests/tcg/../docker/docker.py", line 395, =
in run
> >     return Docker(args.command).run(argv, args.keep, quiet=3Dargs.quiet=
,
> >            ~~~~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> >                                     as_user=3Dargs.run_as_current_user)
> >                                     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> >   File "/home/jsnow/src/qemu/tests/tcg/../docker/docker.py", line 353, =
in run
> >     ret =3D self._do_check(["run", "--rm", "--label",
> >                          "com.qemu.instance.uuid=3D" + label] + cmd,
> >                          quiet=3Dquiet)
> >   File "/home/jsnow/src/qemu/tests/tcg/../docker/docker.py", line 230,
> > in _do_check
> >     return subprocess.check_call(self._command + cmd, **kwargs)
> >            ~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> >   File "/usr/lib64/python3.14/subprocess.py", line 420, in check_call
> >     raise CalledProcessError(retcode, cmd)
> > subprocess.CalledProcessError: Command '['podman', 'run', '--rm',
> > '--label', 'com.qemu.instance.uuid=3D0df29d1fcdc947f1b0cde41104eebed9',
> > '--userns=3Dkeep-id', '-u', '21266', '-w', '/home/jsnow/src/qemu/build'=
,
> > '-v', '/home/jsnow/src/qemu:/home/jsnow/src/qemu',
> > 'debian-amd64-cross', 'x86_64-linux-gnu-gcc',
> > '/home/jsnow/src/qemu/tests/tcg/multiarch/system/hello.c', '-o',
> > 'tests/tcg/x86_64-softmmu-hello.test', '-static', '-MMD', '-MF',
> > 'tests/tcg/x86_64-softmmu-hello.d', '-Wall', '-Werror', '-O0', '-g',
> > '-fno-strict-aliasing', '-nostdlib', '-ffreestanding',
> > '-Wa,--noexecstack', '-I',
> > '/home/jsnow/src/qemu/tests/tcg/x86_64/system/../../minilib',
> > '/home/jsnow/src/qemu/tests/tcg/x86_64/system/../../minilib/printf.c',
> > '../tests/tcg/x86_64/system/boot.S', '-Wl,-T',
> > '../tests/tcg/x86_64/system/kernel.ld', '-Wl,-melf_x86_64',
> > '-Wl,--no-warn-rwx-segments', '-Wl,--build-id=3Dnone', '-lgcc']'
> > returned non-zero exit status 1.
> > filter=3D--filter=3Dlabel=3Dcom.qemu.instance.uuid=3D0df29d1fcdc947f1b0=
cde41104eebed9
> > ninja: build stopped: subcommand failed.
> > make: *** [Makefile:170: run-ninja] Error 1
> >
>
> Interesting, it seems to be an issue with podman user mapping.

Maybe something I set up ages ago and promptly forgot about? I haven't
fussed with user mapping permissions in several aeons, it's possible I
have something stale in some config somewhere ...

>
> Which distro you use (especially which version)?

~> cat /etc/fedora-release
Fedora release 44 (Forty Four)

>
> Also, could you please report output of those commands:
> $ podman --version

~> podman --version
podman version 5.8.4

> $ ls -al /home/jsnow/src/qemu/tests/tcg/multiarch/system/hello.c

~> ls -al /home/jsnow/src/qemu/tests/tcg/multiarch/system/hello.c
-rw-r--r--. 1 jsnow jsnow 229 May  7  2025
/home/jsnow/src/qemu/tests/tcg/multiarch/system/hello.c

> $ /home/jsnow/src/qemu/tests/tcg/../docker/docker.py --command podman \
>   run --run-as-current-user -w /home/jsnow/src/qemu/build -v \
>   /home/jsnow/src/qemu:/home/jsnow/src/qemu debian-amd64-cross \
>   touch -v new_file && ls -al new_file

There's no "-v" option for touch, but:

~> /home/jsnow/src/qemu/tests/tcg/../docker/docker.py --command podman \
                                                                  run
--run-as-current-user -w /home/jsnow/src/qemu/build -v \

/home/jsnow/src/qemu:/home/jsnow/src/qemu debian-amd64-cross \

touch new_file && ls -al new_file
touch: cannot touch 'new_file': Permission denied
Traceback (most recent call last):
  File "/home/jsnow/src/qemu/tests/tcg/../docker/docker.py", line 657,
in <module>
    sys.exit(main())
             ~~~~^^
  File "/home/jsnow/src/qemu/tests/tcg/../docker/docker.py", line 653, in m=
ain
    return args.cmdobj.run(args, argv)
           ~~~~~~~~~~~~~~~^^^^^^^^^^^^
  File "/home/jsnow/src/qemu/tests/tcg/../docker/docker.py", line 395, in r=
un
    return Docker(args.command).run(argv, args.keep, quiet=3Dargs.quiet,
           ~~~~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
                                    as_user=3Dargs.run_as_current_user)
                                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/home/jsnow/src/qemu/tests/tcg/../docker/docker.py", line 353, in r=
un
    ret =3D self._do_check(["run", "--rm", "--label",
                         "com.qemu.instance.uuid=3D" + label] + cmd,
                         quiet=3Dquiet)
  File "/home/jsnow/src/qemu/tests/tcg/../docker/docker.py", line 230,
in _do_check
    return subprocess.check_call(self._command + cmd, **kwargs)
           ~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/lib64/python3.14/subprocess.py", line 420, in check_call
    raise CalledProcessError(retcode, cmd)
subprocess.CalledProcessError: Command '['podman', 'run', '--rm',
'--label', 'com.qemu.instance.uuid=3Dd2faaf6ef4914d83b429069b4497cbb2',
'--userns=3Dkeep-id', '-u', '21266', '-w', '/home/jsnow/src/qemu/build',
'-v', '/home/jsnow/src/qemu:/home/jsnow/src/qemu',
'debian-amd64-cross', 'touch', 'new_file']' returned non-zero exit
status 1.
filter=3D--filter=3Dlabel=3Dcom.qemu.instance.uuid=3Dd2faaf6ef4914d83b42906=
9b4497cbb2



>
> This should help us to see what's your effective uid in the container.
> Maybe this issue was present before, did you try running make check-tcg
> in the past, or not?
>
> > Is there some kind of setup I have neglected to perform to make this
> > new build system work? Is there a way I can skip these tests in the
> > meantime...?
> >
>
> You can use ./configure --disable-containers, so it will not try to use
> podman.
>
> > Thanks,
> > --js
> >
> >
>
> Regards,
> Pierrick
>


