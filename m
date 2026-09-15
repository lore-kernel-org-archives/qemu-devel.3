Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA598C88E75
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 19:23:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6YkH-0007Mm-Vq; Tue, 15 Sep 2026 15:23:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1x6YkD-0007Mb-HC
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 15:23:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1x6YkA-0000mn-Ip
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 15:23:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789500180;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mkz1v7/R1IH61JV09OHuEI97WWlVuRYVueWKKLAEZcI=;
 b=W6MMYSB+zpY4M/2YEm2j+cziQ5cR1N661TU7+lm6KoknrgWF5ln2KIkE54MVa17m3HPC8J
 R7RTe17zdShgmnE/QfRJsLFJmhYFJnaQmJ0xbST/a46hiMRjIQXgPXjA99HT+WSBgFFMZq
 1SEmEwMyqOqhEP8CDrmViVg8514gIZg=
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-368-SZTTkl08PHWKT0u9PjEkEA-1; Tue, 15 Sep 2026 15:22:58 -0400
X-MC-Unique: SZTTkl08PHWKT0u9PjEkEA-1
X-Mimecast-MFC-AGG-ID: SZTTkl08PHWKT0u9PjEkEA_1789500178
Received: by mail-yx1-f71.google.com with SMTP id
 956f58d0204a3-671163d46bcso6537128d50.0
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 12:22:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789500178; cv=none;
 d=google.com; s=arc-20260327;
 b=rnOBZOk09bdHtHYX60qIohlDYHMN/Pz4EFZvF9pwtyi8/9u9SeV+xQb7mK/wDyXqe4
 VRmdCPMT2PD39FeqRwO1mlAsWtEwXEvzFEGYVsUsgyMyGzUg3jKSdPwrfsYIRfCdMdbz
 5Un0LU2YNMFoMym8tzKZuBJWGlTIYJmSL+yhxKWUxxZ3ZdjDt+e3B2ef3AEE8/gGMRhm
 kOn7JB3sPUx7AQ1crUW/YkpfqAwK0PV5H+p0tAhvGg4miwfzGH0MwxeW8sHapsoTqI+N
 uJNRoGh7jV3dnk5miPBPMcwCtfvfBr+25tuQO+fKODEaeJCpaq4QclnJQoM/Jg+uEO04
 phiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=mkz1v7/R1IH61JV09OHuEI97WWlVuRYVueWKKLAEZcI=;
 fh=Zsa/Zu/+dOV2ZGcNCPApu6/CGvbtd70DVsc8aDncJxQ=;
 b=fOfXLg0JqLex0RHmUndrvmDMdrIZucHVo+qru4gVoHn6xnAMTqf3dtZ0rX9N4UMMAb
 YsdLK5NlVnUk6h2LkcdeiCtAYNr9MRHVnZpch6MxtMhULR+7OBHPJCfBZJc39+lVjAsa
 2TC7zp9itVFZEEckdIzlf5UIQKNJyWcuKiZIEY3qsH2p8yrIoalgWafuYWQ0tQno6Ncy
 jj54qOBienChMEeY4RLkY5pR6TUp5t6Gkzymlvn2dNpptcuk5fTfhCIokzDV5ocqh40v
 cwEaV/SILLqmlWd+sWTwaI85YWEEUAa0AnjoQZo8z+AcB81ZXiLCpYNMVx3m1AaBrs7g
 xIQw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789500178; x=1790104978; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=mkz1v7/R1IH61JV09OHuEI97WWlVuRYVueWKKLAEZcI=;
 b=j09hmM2bi3gsVmN0XDfltwTR/Fcxj3ehDVnheBXwEY4OkW7/4Qf9WtF4Vwlpy5P+5a
 E/6ezgdTQvN8EVrC6RaUoBf52v5iA8mnzSP/Pk9l8p44AO4+wJlrfIQuEyMKISk73VhZ
 tCy8YT0cBEE/NP00iqkMwauxGjPFxDNlhhuJ4xUny1rt5GOeEPT9xLmpbNJ9NuIYVkkE
 /an919CNjVH6ArnfmB4SWz+m3AtH0iI9Xpu6YFQE11fVuZnbtbZ3/cQe5/6yDQ2EPhM3
 ZZnq9E3feEbI+K0ECwvXqNmKBWjLMJdHjWhbQX5IWgDzkAJepc7/IRhbM0uP2fb02Qox
 tvWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789500178; x=1790104978;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mkz1v7/R1IH61JV09OHuEI97WWlVuRYVueWKKLAEZcI=;
 b=PnhedcEjb1aC/uzKgs8uTEzzVgJTSj+oa1gPyuz7wEZg/BhyBEWwdsNiBzSJWYsfFy
 YiuPekxE7zg5HTaH8qV0k64x1grQTnUgdCD17anoIffOx3zHJ+GCGCB5JeUyXtrF8Vki
 3x8JvXXzikzfahCftvUzMCNdXfz4TU6xoBXYdbJM2/LzcrxcplyNa7dUx1ssXknmRF9Y
 8WU9lviREokanYq/Nsh2KFSR1GPka0HeLywI2Hl/86loJSf9rWLKk8QO4MGmiSlTsUCf
 oMg4W0n3IWISQnDoNNYWia23DZh7bBYvL1H+HSu1p58c8vGNewy3uO+ILf28LpZ7WA7g
 +I+w==
X-Forwarded-Encrypted: i=1;
 AKwUvBzSx4bieir76eJKQQ/UsfaQy9ZFohNMpX2f8feXBSNx/bseShyX2uxARMgZtUBnENldjX9sO2c5Hrhw@nongnu.org
X-Gm-Message-State: AFuF++nMEdAQQP75GweQkQ4Cw1lwkHPeijpEoFeEgTswDWv8mJ5JXRIZ
 lX9Ox1GxfPQCr4zl2Ynne4uSk6ixYkf7U7HjTE1UYuWCIFjQACDYZWZ1oiGSAO8M+SnSIwj+Xld
 sdElDxOA2ietLTjTJO706spbCzIPCDJeWdb8TO9sinQxjhLR6DRldUKIQiZ8V1VttYNHVW4vsQw
 2m1+NkU7+7H54SOuJw4hyxqSYyrRiIU4c=
X-Gm-Gg: AYBFou38WKc6m7PmoXkFn7F2ewhrPVuiFrmGaIQqVF2WX+QAoVtkDt1wMxBhcTXMtc5
 7k/ZphUoV2LxEbtHGplbYzBFhhzBj8VAlc9vMKZ1cnE1Td6Bh/aC2Zxlw//4TgO67S6TjnAIf01
 had8iKPTahYTM2GBt2NwQyWlZVulSptrbCk0M4zaR4Qh6bZx9iukPuH/oGan3AY+lAhauylAHZR
 VBkHaaMdNfpVfVA
X-Received: by 2002:a05:690e:80a:20b0:671:3261:b0ab with SMTP id
 956f58d0204a3-6714e205ff4mr2074929d50.96.1789500177773; 
 Tue, 15 Sep 2026 12:22:57 -0700 (PDT)
X-Received: by 2002:a05:690e:80a:20b0:671:3261:b0ab with SMTP id
 956f58d0204a3-6714e205ff4mr2074923d50.96.1789500177289; Tue, 15 Sep 2026
 12:22:57 -0700 (PDT)
MIME-Version: 1.0
References: <20260904150826.2331577-1-alex.bennee@linaro.org>
 <CAFEAcA9vZZmVPP3_P1xz-NX_sqWY0zrOC2LeGLTdnaK54XKQzQ@mail.gmail.com>
 <CAFn=p-bXoctWNEdERPBL-SMRPYDisban2e0-mxYjws7UVcjVzw@mail.gmail.com>
 <a80c4add-8c2a-4a20-8888-223fecc3f697@oss.qualcomm.com>
 <CAFn=p-bLuN2La1aqp7rpanjNiezUPk-v4D3kneGiHAPqPO-iyA@mail.gmail.com>
 <05149892-fad2-4576-a47d-bd8523ae6ada@oss.qualcomm.com>
In-Reply-To: <05149892-fad2-4576-a47d-bd8523ae6ada@oss.qualcomm.com>
From: John Snow <jsnow@redhat.com>
Date: Tue, 15 Sep 2026 15:22:46 -0400
X-Gm-Features: AcwNN1X2rTTa3FF1MYZwJG8Pi_zFch9Cdwofd0KHKmFpCXu9QwfJG1xwzszZFlc
Message-ID: <CAFn=p-a64Dq7NOJo-7KqtkGovw6m+r_7q6ronAoy5ivWRGgZSg@mail.gmail.com>
Subject: Re: [PULL v2 000/105] move check-tcg into the meson build
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Tue, Sep 15, 2026 at 3:07=E2=80=AFPM Pierrick Bouvier
<pierrick.bouvier@oss.qualcomm.com> wrote:
>
> On 9/15/2026 11:26 AM, John Snow wrote:
> > On Tue, Sep 15, 2026 at 1:17=E2=80=AFPM Pierrick Bouvier
> > <pierrick.bouvier@oss.qualcomm.com> wrote:
> >>
> >> On 9/15/2026 9:52 AM, John Snow wrote:
> >>> On Fri, Sep 4, 2026 at 2:04=E2=80=AFPM Peter Maydell <peter.maydell@l=
inaro.org> wrote:
> >>>>
> >>>> On Fri, 4 Sept 2026 at 16:08, Alex Benn=C3=A9e <alex.bennee@linaro.o=
rg> wrote:
> >>>>>
> >>>>> The following changes since commit d2843fbf80260e4346c856819e8cea11=
768c9d0e:
> >>>>>
> >>>>>   Merge tag 'pull-riscv-to-apply-20260904' of https://github.com/al=
istair23/qemu into staging (2026-09-04 09:43:27 +0100)
> >>>>>
> >>>>> are available in the Git repository at:
> >>>>>
> >>>>>   https://gitlab.com/stsquad/qemu.git tags/pull-11.1-check-tcg-meso=
n-040926-2
> >>>>>
> >>>>> for you to fetch changes up to 7a485176838e6b6044e73f925d308bb4b300=
2597:
> >>>>>
> >>>>>   MAINTAINERS: add maintainer for tcg/tests meson infrastructure (2=
026-09-04 16:06:22 +0100)
> >>>>>
> >>>>> ----------------------------------------------------------------
> >>>>> tests/tcg: conversion to meson
> >>>>>
> >>>>>   - remove unused variable from multiarch/memory
> >>>>>   - standardise checking plugin output
> >>>>>   - bump minimal meson to 1.6.0
> >>>>>   - introduce meson plumbing for check-tcg
> >>>>>   - return error code if docker probe fails
> >>>>>   - add CI/self/mem test to gdbstub prot-none tests
> >>>>>   - use raw opcode for fprcvt test in arm
> >>>>>   - remove unused variables from gpc-test
> >>>>>   - teach probe-gdb-support about mips
> >>>>>   - identify or1k pc register
> >>>>>   - port check-tcg logic to meson (all targets)
> >>>>>   - update documentation
> >>>>>   - add Pierrick as a maintainer for tests/tcg
> >>>
> >>> Hi, I'm having difficulties building after this PR, after eb7f0c14 in
> >>> particular.
> >>>
> >>> I keep seeing stuff like this:
> >>>
> >>> FAILED: [code=3D1] tests/tcg/x86_64-softmmu-hello.test
> >>> /home/jsnow/src/qemu/tests/tcg/../docker/docker.py --command podman
> >>> run --run-as-current-user -w /home/jsnow/src/qemu/build -v
> >>> /home/jsnow/src/qemu:/home/jsnow/src/qemu debian-amd64-cross
> >>> x86_64-linux-gnu-gcc
> >>> /home/jsnow/src/qemu/tests/tcg/multiarch/system/hello.c -o
> >>> tests/tcg/x86_64-softmmu-hello.test -static -MMD -MF
> >>> tests/tcg/x86_64-softmmu-hello.d -Wall -Werror -O0 -g
> >>> -fno-strict-aliasing -nostdlib -ffreestanding -Wa,--noexecstack -I
> >>> /home/jsnow/src/qemu/tests/tcg/x86_64/system/../../minilib
> >>> /home/jsnow/src/qemu/tests/tcg/x86_64/system/../../minilib/printf.c
> >>> ../tests/tcg/x86_64/system/boot.S -Wl,-T
> >>> ../tests/tcg/x86_64/system/kernel.ld -Wl,-melf_x86_64
> >>> -Wl,--no-warn-rwx-segments -Wl,--build-id=3Dnone -lgcc
> >>> cc1: fatal error:
> >>> /home/jsnow/src/qemu/tests/tcg/multiarch/system/hello.c: Permission
> >>> denied
> >>> compilation terminated.
> >>> cc1: fatal error:
> >>> /home/jsnow/src/qemu/tests/tcg/x86_64/system/../../minilib/printf.c:
> >>> Permission denied
> >>> compilation terminated.
> >>> cc1: fatal error: ../tests/tcg/x86_64/system/boot.S: Permission denie=
d
> >>> compilation terminated.
> >>> Traceback (most recent call last):
> >>>   File "/home/jsnow/src/qemu/tests/tcg/../docker/docker.py", line 657=
,
> >>> in <module>
> >>>     sys.exit(main())
> >>>              ~~~~^^
> >>>   File "/home/jsnow/src/qemu/tests/tcg/../docker/docker.py", line 653=
, in main
> >>>     return args.cmdobj.run(args, argv)
> >>>            ~~~~~~~~~~~~~~~^^^^^^^^^^^^
> >>>   File "/home/jsnow/src/qemu/tests/tcg/../docker/docker.py", line 395=
, in run
> >>>     return Docker(args.command).run(argv, args.keep, quiet=3Dargs.qui=
et,
> >>>            ~~~~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^=
^
> >>>                                     as_user=3Dargs.run_as_current_use=
r)
> >>>                                     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> >>>   File "/home/jsnow/src/qemu/tests/tcg/../docker/docker.py", line 353=
, in run
> >>>     ret =3D self._do_check(["run", "--rm", "--label",
> >>>                          "com.qemu.instance.uuid=3D" + label] + cmd,
> >>>                          quiet=3Dquiet)
> >>>   File "/home/jsnow/src/qemu/tests/tcg/../docker/docker.py", line 230=
,
> >>> in _do_check
> >>>     return subprocess.check_call(self._command + cmd, **kwargs)
> >>>            ~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> >>>   File "/usr/lib64/python3.14/subprocess.py", line 420, in check_call
> >>>     raise CalledProcessError(retcode, cmd)
> >>> subprocess.CalledProcessError: Command '['podman', 'run', '--rm',
> >>> '--label', 'com.qemu.instance.uuid=3D0df29d1fcdc947f1b0cde41104eebed9=
',
> >>> '--userns=3Dkeep-id', '-u', '21266', '-w', '/home/jsnow/src/qemu/buil=
d',
> >>> '-v', '/home/jsnow/src/qemu:/home/jsnow/src/qemu',
> >>> 'debian-amd64-cross', 'x86_64-linux-gnu-gcc',
> >>> '/home/jsnow/src/qemu/tests/tcg/multiarch/system/hello.c', '-o',
> >>> 'tests/tcg/x86_64-softmmu-hello.test', '-static', '-MMD', '-MF',
> >>> 'tests/tcg/x86_64-softmmu-hello.d', '-Wall', '-Werror', '-O0', '-g',
> >>> '-fno-strict-aliasing', '-nostdlib', '-ffreestanding',
> >>> '-Wa,--noexecstack', '-I',
> >>> '/home/jsnow/src/qemu/tests/tcg/x86_64/system/../../minilib',
> >>> '/home/jsnow/src/qemu/tests/tcg/x86_64/system/../../minilib/printf.c'=
,
> >>> '../tests/tcg/x86_64/system/boot.S', '-Wl,-T',
> >>> '../tests/tcg/x86_64/system/kernel.ld', '-Wl,-melf_x86_64',
> >>> '-Wl,--no-warn-rwx-segments', '-Wl,--build-id=3Dnone', '-lgcc']'
> >>> returned non-zero exit status 1.
> >>> filter=3D--filter=3Dlabel=3Dcom.qemu.instance.uuid=3D0df29d1fcdc947f1=
b0cde41104eebed9
> >>> ninja: build stopped: subcommand failed.
> >>> make: *** [Makefile:170: run-ninja] Error 1
> >>>
> >>
> >> Interesting, it seems to be an issue with podman user mapping.
> >
> > Maybe something I set up ages ago and promptly forgot about? I haven't
> > fussed with user mapping permissions in several aeons, it's possible I
> > have something stale in some config somewhere ...
> >
> >>
> >> Which distro you use (especially which version)?
> >
> > ~> cat /etc/fedora-release
> > Fedora release 44 (Forty Four)
> >
> >>
> >> Also, could you please report output of those commands:
> >> $ podman --version
> >
> > ~> podman --version
> > podman version 5.8.4
> >
> >> $ ls -al /home/jsnow/src/qemu/tests/tcg/multiarch/system/hello.c
> >
> > ~> ls -al /home/jsnow/src/qemu/tests/tcg/multiarch/system/hello.c
> > -rw-r--r--. 1 jsnow jsnow 229 May  7  2025
> > /home/jsnow/src/qemu/tests/tcg/multiarch/system/hello.c
> >
> >> $ /home/jsnow/src/qemu/tests/tcg/../docker/docker.py --command podman =
\
> >>   run --run-as-current-user -w /home/jsnow/src/qemu/build -v \
> >>   /home/jsnow/src/qemu:/home/jsnow/src/qemu debian-amd64-cross \
> >>   touch -v new_file && ls -al new_file
> >
> > There's no "-v" option for touch, but:
> >
>
> Copy-paste mistake sorry, thanks for fixing command.
>
> > ~> /home/jsnow/src/qemu/tests/tcg/../docker/docker.py --command podman =
\
> >                                                                   run
> > --run-as-current-user -w /home/jsnow/src/qemu/build -v \
> >
> > /home/jsnow/src/qemu:/home/jsnow/src/qemu debian-amd64-cross \
> >
> > touch new_file && ls -al new_file
> > touch: cannot touch 'new_file': Permission denied
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
> > '--label', 'com.qemu.instance.uuid=3Dd2faaf6ef4914d83b429069b4497cbb2',
> > '--userns=3Dkeep-id', '-u', '21266', '-w', '/home/jsnow/src/qemu/build'=
,
> > '-v', '/home/jsnow/src/qemu:/home/jsnow/src/qemu',
> > 'debian-amd64-cross', 'touch', 'new_file']' returned non-zero exit
> > status 1.
> > filter=3D--filter=3Dlabel=3Dcom.qemu.instance.uuid=3Dd2faaf6ef4914d83b4=
29069b4497cbb2
> >
>
> What is the content of your /etc/subuid?
>
> Giving your user id (21266), I guess you have a LDAP account or
> something similar: not a local account.
> I had the same issue on my corporate VM, and had to add an explicit
> mapping for my user.
>
> You should have something like:
>
> $ cat /etc/subuid
> jsnow:100000:65536
> $ cat /etc/subgid
> jsnow:100000:65536

I updated my entries to this; I am still having problems so I assume I
need to refresh my login or restart or some such thing. Will have to
try that a little bit later :)

Do you think it's possible to add a simple "hello world" example that
tries to touch a source file to determine if permissions are
appropriately set up, and if not, gives a nice human-readable error
message? (Along with advice to try --disable-containers as a
fallback.)

>
> Let me know if it solves your problem, else we'll find something else.
>
> >
> >
> >>
> >> This should help us to see what's your effective uid in the container.
> >> Maybe this issue was present before, did you try running make check-tc=
g
> >> in the past, or not?
> >>
> >>> Is there some kind of setup I have neglected to perform to make this
> >>> new build system work? Is there a way I can skip these tests in the
> >>> meantime...?
> >>>
> >>
> >> You can use ./configure --disable-containers, so it will not try to us=
e
> >> podman.
> >>
> >>> Thanks,
> >>> --js
> >>>
> >>>
> >>
> >> Regards,
> >> Pierrick
> >>
> >
>


