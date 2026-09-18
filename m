Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A964C982D8
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 16:24:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7bNB-0000W7-EK; Fri, 18 Sep 2026 12:23:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1x7bN7-0000Ve-7I
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 12:23:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1x7bN4-0000ZH-7k
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 12:23:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789748608;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HVwj85Oz7+FGJ01D6M8g0mmOTY68cRr0PCm+zVAri1s=;
 b=ICgOW2Xn3eKvnBNyeGxoqA8yQ4v7VN0ACbY7exa6UMYmUPp+7yXvJm30Xt9iT5f2kcWHic
 2MdH5yh83WwJPGEv3kodRORGUKDIzSm2GnzNAPM7WoUvtVdcYQWQRLO6lte84GCiPiYk2D
 nMD5vQ0WquFAsKeyxD7ooTU8pz+1c6M=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-369-hKhswJebM5W6lDOCl2ApYQ-1; Fri, 18 Sep 2026 12:23:27 -0400
X-MC-Unique: hKhswJebM5W6lDOCl2ApYQ-1
X-Mimecast-MFC-AGG-ID: hKhswJebM5W6lDOCl2ApYQ_1789748607
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-86c3a053d9bso8912087b3.0
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2026 09:23:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789748607; cv=none;
 d=google.com; s=arc-20260327;
 b=L8NEi34FPGVx1SM3V1c91cDmfFBotB48ZkctZuj3r9cnERnApGrm8sy9TgTCJ7mMA2
 45DtufQpcjZHjPEZ0Ypb/bpPMEe4jcgoylaKWInI4oo052d0dX62yVLjGFhJZkRWLlYs
 IFIuv1wddMjLlDLP4dcEz+ooqTq6edGhPOC3Z43zHI0Ke1aRHoXd7hxyS5VWk1wU75Al
 Qpu+/AgLtS1yEJn6GckmovDoQlNDYc01nmQYRuxp5aqfKbswQ3hlPAW8wYi0nXbnl5he
 CidOEwvxTXCLPBIBH3dGLx6GSgQYXc2lGxiF6ZxJvwoKouj2cAraHAuQ8t3c5mgkNC23
 iYEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=HVwj85Oz7+FGJ01D6M8g0mmOTY68cRr0PCm+zVAri1s=;
 fh=oSdcdVrP5F4/ougs0Fzsj/q1V1ldF1c/J2xhMdI8+2k=;
 b=BRd1HLXKjhXdJkhlMZAdOWw8GgtrrDKRyzplajuJLbhcTMjMUis8cH4q+ixTgcorNL
 pKVDhKwmE8MziNj0OgyV72phLfXB+zWLvqZRS9+yKwWkVg8kCcKGE6s+YxMpmu0o1YVp
 8LtGi8gpkyo7wLUJBSNC0czvCppFUzAmLSQSzYtKqJDbN1easaM2CQ5e6aTPehiu80iT
 iPHsqaCDUNZXTP7GgXM8QWnPyvTPKEGf6vFknfA7hMseXEckpam5itQ/MDdiDqchtr12
 eKLzltwgKCGQRUHWiYQdJobB7Kwlz4A4RJhYXwfsWGG57zoX7IWFGw/+H4F0ZuUvPFJh
 351A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789748607; x=1790353407; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=HVwj85Oz7+FGJ01D6M8g0mmOTY68cRr0PCm+zVAri1s=;
 b=t/SB7JWhvi+WPjo+Dgsrm0tWropinTvILXr9wNUt0PQNKmjrakuRLCMXuQwwhYD3F1
 fMJzl4rk/5uaGsDg/Yv7f5Jf7UlKHd3skEDKIozSWzvSUrTUz7ntiwumEwb/1qUhiJqF
 2U1M2+6LzUeFFQ1ALPQHuOI3tVXeJs25y9VIMeC2Lfio4ZTS/qM+LaJXZF8J55zThlAj
 V/paezcee7JMHRkUwDg1dUNkT0IelixzapnU1yCEJYNLsj6zGB/Wuh2SQtzwo6o9tTeF
 JpVTWrhkemGhbNycqvjErs6DvwsU37NArCB71W1GPlufynhsQTyU7TWpOKHA85hJ/7BK
 TNZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789748607; x=1790353407;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HVwj85Oz7+FGJ01D6M8g0mmOTY68cRr0PCm+zVAri1s=;
 b=Vpe1lm+9LAWSp3BxCRJC98EeMHAImcy/1523Nke+bvXRb4rR3BOG0Nskd0Wue95SEM
 eYjSc6cYIftRrKT8/96SlvCU3QI+Q8D3Lgro8CF0UqAsGCmbhdruzaxZZqFne6OsMDVy
 JGyKCbtfQQ6p9ovk1CsD5b+bazdzLkiH6TggMx/0p/f4wBA1oiua/uCrjQnMC/cuoRSw
 Fj/f5ZTT0/Gu8pmxgc2VOOkVyzi7RQZI9TzKAt+DNMja5xMFuXQ9mTJwM9mjXaY7U9pT
 WdF4L6LF5R8Ua7+QKhp7etTe0zA/IhsjiPAbAmJQVoDwNz3/jNUhc/Dd7S/tBlz3YXd2
 kdjw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxXdi7uv57twZ/80Q9iNFXP62NDRwa8jZwmuKEHOtfUfNisjnycM8H5eM+g2UbtdzvCTVzEXpQ9hkGa@nongnu.org
X-Gm-Message-State: AFuF++mZcG3k19S0HjkD1BnVwEHyAnqG3lhaOFFYPu2UExYHrNZIaEvk
 rfRaqb1IOVrhb4PBI/OO9hR1bJIAWAAvxC8IH0lKRqt3OQX7niyYZBiu7mowJWtW1jwGFgJiOXS
 rTpNQvSQWVBK6QXi57H9K4/E0gotS2QNkuQrkJw/aGPa1sBwaR+cPYztbcsiHNN0v9/2SyW1VCE
 YoNGLcdnimzhHs/hecSX3xHakyy567f0w=
X-Gm-Gg: AYBFou3OnkZ9mLxyJP3rvi9Z1eZRxEo2xj4YdYaHDToF6uZl0qX8atl67YUbfdVDM40
 Q5YeAR/3TORnbLSE5x8FPsBQdjC1UJsArOtpZ29dxEsPY1Zfn/IZkhy7R7KX9cBHULtdhSp252b
 1koEDg7SyoETTf1taOwspR5bWGN/4G9o9Rs2uV7VatSluIYrkNsziY8+xJQoiwS2CoZZQLldiPi
 vcbY4PC2i4QExwB
X-Received: by 2002:a05:690c:f07:b0:81e:6bd6:39a5 with SMTP id
 00721157ae682-89730708f3emr17993497b3.1.1789748606687; 
 Fri, 18 Sep 2026 09:23:26 -0700 (PDT)
X-Received: by 2002:a05:690c:f07:b0:81e:6bd6:39a5 with SMTP id
 00721157ae682-89730708f3emr17993307b3.1.1789748606122; Fri, 18 Sep 2026
 09:23:26 -0700 (PDT)
MIME-Version: 1.0
References: <20260904150826.2331577-1-alex.bennee@linaro.org>
 <CAFEAcA9vZZmVPP3_P1xz-NX_sqWY0zrOC2LeGLTdnaK54XKQzQ@mail.gmail.com>
 <CAFn=p-bXoctWNEdERPBL-SMRPYDisban2e0-mxYjws7UVcjVzw@mail.gmail.com>
 <a80c4add-8c2a-4a20-8888-223fecc3f697@oss.qualcomm.com>
 <CAFn=p-bLuN2La1aqp7rpanjNiezUPk-v4D3kneGiHAPqPO-iyA@mail.gmail.com>
 <05149892-fad2-4576-a47d-bd8523ae6ada@oss.qualcomm.com>
 <CAFn=p-a64Dq7NOJo-7KqtkGovw6m+r_7q6ronAoy5ivWRGgZSg@mail.gmail.com>
 <ce78d727-046a-4755-b807-a996f06ae47b@oss.qualcomm.com>
 <95c18d55-87ca-4f81-bfa9-364b4b012657@oss.qualcomm.com>
 <78c818a4-2619-4dd5-87f8-af5e1017c9db@oss.qualcomm.com>
 <6a9dffd1-6b53-4b05-8d4a-564de0cc08f2@oss.qualcomm.com>
In-Reply-To: <6a9dffd1-6b53-4b05-8d4a-564de0cc08f2@oss.qualcomm.com>
From: John Snow <jsnow@redhat.com>
Date: Fri, 18 Sep 2026 12:23:14 -0400
X-Gm-Features: AcwNN1XOGB0J1q9tAhcAgMJNhBy5psuiLSFRfzfdKvHAWDc_BJny4FkShDhvk00
Message-ID: <CAFn=p-a8_Y92uVV8c2Yt4mU0hCmmqn1+Vqg6Qd=B6AGmrqQ1sg@mail.gmail.com>
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

On Thu, Sep 17, 2026 at 6:12=E2=80=AFPM Pierrick Bouvier
<pierrick.bouvier@oss.qualcomm.com> wrote:
>
> On 9/17/2026 12:27 PM, Pierrick Bouvier wrote:
> > On 9/15/2026 1:10 PM, Pierrick Bouvier wrote:
> >> On 9/15/2026 1:04 PM, Pierrick Bouvier wrote:
> >>> On 9/15/2026 12:22 PM, John Snow wrote:
> >>>> On Tue, Sep 15, 2026 at 3:07=E2=80=AFPM Pierrick Bouvier
> >>>> <pierrick.bouvier@oss.qualcomm.com> wrote:
> >>>>>
> >>>>> On 9/15/2026 11:26 AM, John Snow wrote:
> >>>>>> On Tue, Sep 15, 2026 at 1:17=E2=80=AFPM Pierrick Bouvier
> >>>>>> <pierrick.bouvier@oss.qualcomm.com> wrote:
> >>>>>>>
> >>>>>>> On 9/15/2026 9:52 AM, John Snow wrote:
> >>>>>>>> On Fri, Sep 4, 2026 at 2:04=E2=80=AFPM Peter Maydell <peter.mayd=
ell@linaro.org> wrote:
> >>>>>>>>>
> >>>>>>>>> On Fri, 4 Sept 2026 at 16:08, Alex Benn=C3=A9e <alex.bennee@lin=
aro.org> wrote:
> >>>>>>>>>>
> >>>>>>>>>> The following changes since commit d2843fbf80260e4346c856819e8=
cea11768c9d0e:
> >>>>>>>>>>
> >>>>>>>>>>   Merge tag 'pull-riscv-to-apply-20260904' of https://github.c=
om/alistair23/qemu into staging (2026-09-04 09:43:27 +0100)
> >>>>>>>>>>
> >>>>>>>>>> are available in the Git repository at:
> >>>>>>>>>>
> >>>>>>>>>>   https://gitlab.com/stsquad/qemu.git tags/pull-11.1-check-tcg=
-meson-040926-2
> >>>>>>>>>>
> >>>>>>>>>> for you to fetch changes up to 7a485176838e6b6044e73f925d308bb=
4b3002597:
> >>>>>>>>>>
> >>>>>>>>>>   MAINTAINERS: add maintainer for tcg/tests meson infrastructu=
re (2026-09-04 16:06:22 +0100)
> >>>>>>>>>>
> >>>>>>>>>> --------------------------------------------------------------=
--
> >>>>>>>>>> tests/tcg: conversion to meson
> >>>>>>>>>>
> >>>>>>>>>>   - remove unused variable from multiarch/memory
> >>>>>>>>>>   - standardise checking plugin output
> >>>>>>>>>>   - bump minimal meson to 1.6.0
> >>>>>>>>>>   - introduce meson plumbing for check-tcg
> >>>>>>>>>>   - return error code if docker probe fails
> >>>>>>>>>>   - add CI/self/mem test to gdbstub prot-none tests
> >>>>>>>>>>   - use raw opcode for fprcvt test in arm
> >>>>>>>>>>   - remove unused variables from gpc-test
> >>>>>>>>>>   - teach probe-gdb-support about mips
> >>>>>>>>>>   - identify or1k pc register
> >>>>>>>>>>   - port check-tcg logic to meson (all targets)
> >>>>>>>>>>   - update documentation
> >>>>>>>>>>   - add Pierrick as a maintainer for tests/tcg
> >>>>>>>>
> >>>>>>>> Hi, I'm having difficulties building after this PR, after eb7f0c=
14 in
> >>>>>>>> particular.
> >>>>>>>>
> >>>>>>>> I keep seeing stuff like this:
> >>>>>>>>
> >>>>>>>> FAILED: [code=3D1] tests/tcg/x86_64-softmmu-hello.test
> >>>>>>>> /home/jsnow/src/qemu/tests/tcg/../docker/docker.py --command pod=
man
> >>>>>>>> run --run-as-current-user -w /home/jsnow/src/qemu/build -v
> >>>>>>>> /home/jsnow/src/qemu:/home/jsnow/src/qemu debian-amd64-cross
> >>>>>>>> x86_64-linux-gnu-gcc
> >>>>>>>> /home/jsnow/src/qemu/tests/tcg/multiarch/system/hello.c -o
> >>>>>>>> tests/tcg/x86_64-softmmu-hello.test -static -MMD -MF
> >>>>>>>> tests/tcg/x86_64-softmmu-hello.d -Wall -Werror -O0 -g
> >>>>>>>> -fno-strict-aliasing -nostdlib -ffreestanding -Wa,--noexecstack =
-I
> >>>>>>>> /home/jsnow/src/qemu/tests/tcg/x86_64/system/../../minilib
> >>>>>>>> /home/jsnow/src/qemu/tests/tcg/x86_64/system/../../minilib/print=
f.c
> >>>>>>>> ../tests/tcg/x86_64/system/boot.S -Wl,-T
> >>>>>>>> ../tests/tcg/x86_64/system/kernel.ld -Wl,-melf_x86_64
> >>>>>>>> -Wl,--no-warn-rwx-segments -Wl,--build-id=3Dnone -lgcc
> >>>>>>>> cc1: fatal error:
> >>>>>>>> /home/jsnow/src/qemu/tests/tcg/multiarch/system/hello.c: Permiss=
ion
> >>>>>>>> denied
> >>>>>>>> compilation terminated.
> >>>>>>>> cc1: fatal error:
> >>>>>>>> /home/jsnow/src/qemu/tests/tcg/x86_64/system/../../minilib/print=
f.c:
> >>>>>>>> Permission denied
> >>>>>>>> compilation terminated.
> >>>>>>>> cc1: fatal error: ../tests/tcg/x86_64/system/boot.S: Permission =
denied
> >>>>>>>> compilation terminated.
> >>>>>>>> Traceback (most recent call last):
> >>>>>>>>   File "/home/jsnow/src/qemu/tests/tcg/../docker/docker.py", lin=
e 657,
> >>>>>>>> in <module>
> >>>>>>>>     sys.exit(main())
> >>>>>>>>              ~~~~^^
> >>>>>>>>   File "/home/jsnow/src/qemu/tests/tcg/../docker/docker.py", lin=
e 653, in main
> >>>>>>>>     return args.cmdobj.run(args, argv)
> >>>>>>>>            ~~~~~~~~~~~~~~~^^^^^^^^^^^^
> >>>>>>>>   File "/home/jsnow/src/qemu/tests/tcg/../docker/docker.py", lin=
e 395, in run
> >>>>>>>>     return Docker(args.command).run(argv, args.keep, quiet=3Darg=
s.quiet,
> >>>>>>>>            ~~~~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^=
^^^^^^
> >>>>>>>>                                     as_user=3Dargs.run_as_curren=
t_user)
> >>>>>>>>                                     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^=
^^^^^
> >>>>>>>>   File "/home/jsnow/src/qemu/tests/tcg/../docker/docker.py", lin=
e 353, in run
> >>>>>>>>     ret =3D self._do_check(["run", "--rm", "--label",
> >>>>>>>>                          "com.qemu.instance.uuid=3D" + label] + =
cmd,
> >>>>>>>>                          quiet=3Dquiet)
> >>>>>>>>   File "/home/jsnow/src/qemu/tests/tcg/../docker/docker.py", lin=
e 230,
> >>>>>>>> in _do_check
> >>>>>>>>     return subprocess.check_call(self._command + cmd, **kwargs)
> >>>>>>>>            ~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> >>>>>>>>   File "/usr/lib64/python3.14/subprocess.py", line 420, in check=
_call
> >>>>>>>>     raise CalledProcessError(retcode, cmd)
> >>>>>>>> subprocess.CalledProcessError: Command '['podman', 'run', '--rm'=
,
> >>>>>>>> '--label', 'com.qemu.instance.uuid=3D0df29d1fcdc947f1b0cde41104e=
ebed9',
> >>>>>>>> '--userns=3Dkeep-id', '-u', '21266', '-w', '/home/jsnow/src/qemu=
/build',
> >>>>>>>> '-v', '/home/jsnow/src/qemu:/home/jsnow/src/qemu',
> >>>>>>>> 'debian-amd64-cross', 'x86_64-linux-gnu-gcc',
> >>>>>>>> '/home/jsnow/src/qemu/tests/tcg/multiarch/system/hello.c', '-o',
> >>>>>>>> 'tests/tcg/x86_64-softmmu-hello.test', '-static', '-MMD', '-MF',
> >>>>>>>> 'tests/tcg/x86_64-softmmu-hello.d', '-Wall', '-Werror', '-O0', '=
-g',
> >>>>>>>> '-fno-strict-aliasing', '-nostdlib', '-ffreestanding',
> >>>>>>>> '-Wa,--noexecstack', '-I',
> >>>>>>>> '/home/jsnow/src/qemu/tests/tcg/x86_64/system/../../minilib',
> >>>>>>>> '/home/jsnow/src/qemu/tests/tcg/x86_64/system/../../minilib/prin=
tf.c',
> >>>>>>>> '../tests/tcg/x86_64/system/boot.S', '-Wl,-T',
> >>>>>>>> '../tests/tcg/x86_64/system/kernel.ld', '-Wl,-melf_x86_64',
> >>>>>>>> '-Wl,--no-warn-rwx-segments', '-Wl,--build-id=3Dnone', '-lgcc']'
> >>>>>>>> returned non-zero exit status 1.
> >>>>>>>> filter=3D--filter=3Dlabel=3Dcom.qemu.instance.uuid=3D0df29d1fcdc=
947f1b0cde41104eebed9
> >>>>>>>> ninja: build stopped: subcommand failed.
> >>>>>>>> make: *** [Makefile:170: run-ninja] Error 1
> >>>>>>>>
> >>>>>>>
> >>>>>>> Interesting, it seems to be an issue with podman user mapping.
> >>>>>>
> >>>>>> Maybe something I set up ages ago and promptly forgot about? I hav=
en't
> >>>>>> fussed with user mapping permissions in several aeons, it's possib=
le I
> >>>>>> have something stale in some config somewhere ...
> >>>>>>
> >>>>>>>
> >>>>>>> Which distro you use (especially which version)?
> >>>>>>
> >>>>>> ~> cat /etc/fedora-release
> >>>>>> Fedora release 44 (Forty Four)
> >>>>>>
> >>>>>>>
> >>>>>>> Also, could you please report output of those commands:
> >>>>>>> $ podman --version
> >>>>>>
> >>>>>> ~> podman --version
> >>>>>> podman version 5.8.4
> >>>>>>
> >>>>>>> $ ls -al /home/jsnow/src/qemu/tests/tcg/multiarch/system/hello.c
> >>>>>>
> >>>>>> ~> ls -al /home/jsnow/src/qemu/tests/tcg/multiarch/system/hello.c
> >>>>>> -rw-r--r--. 1 jsnow jsnow 229 May  7  2025
> >>>>>> /home/jsnow/src/qemu/tests/tcg/multiarch/system/hello.c
> >>>>>>
> >>>>>>> $ /home/jsnow/src/qemu/tests/tcg/../docker/docker.py --command po=
dman \
> >>>>>>>   run --run-as-current-user -w /home/jsnow/src/qemu/build -v \
> >>>>>>>   /home/jsnow/src/qemu:/home/jsnow/src/qemu debian-amd64-cross \
> >>>>>>>   touch -v new_file && ls -al new_file
> >>>>>>
> >>>>>> There's no "-v" option for touch, but:
> >>>>>>
> >>>>>
> >>>>> Copy-paste mistake sorry, thanks for fixing command.
> >>>>>
> >>>>>> ~> /home/jsnow/src/qemu/tests/tcg/../docker/docker.py --command po=
dman \
> >>>>>>                                                                   =
run
> >>>>>> --run-as-current-user -w /home/jsnow/src/qemu/build -v \
> >>>>>>
> >>>>>> /home/jsnow/src/qemu:/home/jsnow/src/qemu debian-amd64-cross \
> >>>>>>
> >>>>>> touch new_file && ls -al new_file
> >>>>>> touch: cannot touch 'new_file': Permission denied
> >>>>>> Traceback (most recent call last):
> >>>>>>   File "/home/jsnow/src/qemu/tests/tcg/../docker/docker.py", line =
657,
> >>>>>> in <module>
> >>>>>>     sys.exit(main())
> >>>>>>              ~~~~^^
> >>>>>>   File "/home/jsnow/src/qemu/tests/tcg/../docker/docker.py", line =
653, in main
> >>>>>>     return args.cmdobj.run(args, argv)
> >>>>>>            ~~~~~~~~~~~~~~~^^^^^^^^^^^^
> >>>>>>   File "/home/jsnow/src/qemu/tests/tcg/../docker/docker.py", line =
395, in run
> >>>>>>     return Docker(args.command).run(argv, args.keep, quiet=3Dargs.=
quiet,
> >>>>>>            ~~~~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^=
^^^^
> >>>>>>                                     as_user=3Dargs.run_as_current_=
user)
> >>>>>>                                     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^=
^^^
> >>>>>>   File "/home/jsnow/src/qemu/tests/tcg/../docker/docker.py", line =
353, in run
> >>>>>>     ret =3D self._do_check(["run", "--rm", "--label",
> >>>>>>                          "com.qemu.instance.uuid=3D" + label] + cm=
d,
> >>>>>>                          quiet=3Dquiet)
> >>>>>>   File "/home/jsnow/src/qemu/tests/tcg/../docker/docker.py", line =
230,
> >>>>>> in _do_check
> >>>>>>     return subprocess.check_call(self._command + cmd, **kwargs)
> >>>>>>            ~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> >>>>>>   File "/usr/lib64/python3.14/subprocess.py", line 420, in check_c=
all
> >>>>>>     raise CalledProcessError(retcode, cmd)
> >>>>>> subprocess.CalledProcessError: Command '['podman', 'run', '--rm',
> >>>>>> '--label', 'com.qemu.instance.uuid=3Dd2faaf6ef4914d83b429069b4497c=
bb2',
> >>>>>> '--userns=3Dkeep-id', '-u', '21266', '-w', '/home/jsnow/src/qemu/b=
uild',
> >>>>>> '-v', '/home/jsnow/src/qemu:/home/jsnow/src/qemu',
> >>>>>> 'debian-amd64-cross', 'touch', 'new_file']' returned non-zero exit
> >>>>>> status 1.
> >>>>>> filter=3D--filter=3Dlabel=3Dcom.qemu.instance.uuid=3Dd2faaf6ef4914=
d83b429069b4497cbb2
> >>>>>>
> >>>>>
> >>>>> What is the content of your /etc/subuid?
> >>>>>
> >>>>> Giving your user id (21266), I guess you have a LDAP account or
> >>>>> something similar: not a local account.
> >>>>> I had the same issue on my corporate VM, and had to add an explicit
> >>>>> mapping for my user.
> >>>>>
> >>>>> You should have something like:
> >>>>>
> >>>>> $ cat /etc/subuid
> >>>>> jsnow:100000:65536
> >>>>> $ cat /etc/subgid
> >>>>> jsnow:100000:65536
> >>>>
> >>>> I updated my entries to this; I am still having problems so I assume=
 I
> >>>> need to refresh my login or restart or some such thing. Will have to
> >>>> try that a little bit later :)
> >>>>
> >>>> Do you think it's possible to add a simple "hello world" example tha=
t
> >>>> tries to touch a source file to determine if permissions are
> >>>> appropriately set up, and if not, gives a nice human-readable error
> >>>> message? (Along with advice to try --disable-containers as a
> >>>> fallback.)
> >>>>
> >>>
> >>> It could be possible to add something to docker.py probe directly.
> >>> However, it would be good to know why there is an issue on your setup=
 at
> >>> the moment, just to rule out another obvious error.
> >>>
> >>
> >> Would that be possible to try a shared mount (:z)?
> >>
> >> /home/jsnow/src/qemu/tests/tcg/../docker/docker.py --command podman \
> >>  run --run-as-current-user -w /home/jsnow/src/qemu/build -v \
> >>  /home/jsnow/src/qemu:/home/jsnow/src/qemu:z debian-amd64-cross \
> >>  touch -v new_file && ls -al new_file
> >>
> >> If it works, that's related to SELinux blocking such access by default=
.
> >> And we can add the flag inconditionally.
> >>
> >
> > I installed fedora and could reproduce the issue. SELinux is enabled by
> > default, to the opposite of debian.
> >
> > The right fix is not :z (not enough with podman), but to use
> > --security-opt label=3Ddisable, which works with docker and podman.
> >
> > I'll send a patch today so Alex can include it in his PR tomorrow.
> >
>
> Sent:
> https://lore.kernel.org/qemu-devel/20260917221117.274619-2-pierrick.bouvi=
er@oss.qualcomm.com/T/#
>

Thanks, you're the best! (Testing shortly, will respond on that series.)

--js


