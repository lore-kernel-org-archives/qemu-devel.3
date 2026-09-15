Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAABFC88E75
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 16:53:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6WPD-0000WO-Pq; Tue, 15 Sep 2026 12:53:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1x6WP6-0000Tp-Af
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 12:53:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1x6WP4-0008Q5-EG
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 12:53:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789491184;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JsZhCzznAgndZkRtD7LPWAViE6Xktw7cITEK/EXn0fw=;
 b=izeV8YNhSJ1vkrdDB94Zo512sKDTzRVavxJErxZFCjb53i3unOsR4yhJMt7Mey9kFwBaDs
 QPzzX35FWZ43U5hZEEP3+ZEJO0D0XWLOV28v+rUb98i6Q3rsz4twkkt/70VbC3Weos4DAE
 758E03zRtocVLjZitiM8rfxoGH3/hwE=
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-27-DYX0-gMdNOWj5v6xl1su5A-1; Tue, 15 Sep 2026 12:53:02 -0400
X-MC-Unique: DYX0-gMdNOWj5v6xl1su5A-1
X-Mimecast-MFC-AGG-ID: DYX0-gMdNOWj5v6xl1su5A_1789491182
Received: by mail-yx1-f71.google.com with SMTP id
 956f58d0204a3-6714b504d08so2432894d50.1
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 09:53:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789491182; cv=none;
 d=google.com; s=arc-20260327;
 b=cpEolVu31OkQTVVsPoKgDFKYH7YAOspGsQyqOluiBQPqmTO/yYFNr0UNNJGiMyTq/U
 sOOL3r/aamCtRRXPKPTuIbKN18MvA/lLHlMaCRmPWV1S+3dV2oOLNfeAA6WtJIup4Wib
 yifwDbk6zg1rRy88DHHilMZp7fH2yB+YA8nyldcLgcRXsFrlYpyYdccyZiZ9GbtJPZMg
 X5XL1aWB86yyOr9bJxeYef+1AKELhQ4u0GqC1f2C0pwKqi5wqFTdbug+lsAKo9UG5P8d
 jq8zAk0COikCYsXzImAq7BIrQ0pgdPgPEb8nGuNx4Tokg7pb+O5nW3NQ5U/xOIEJkYyM
 7SwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=JsZhCzznAgndZkRtD7LPWAViE6Xktw7cITEK/EXn0fw=;
 fh=sHGebKe9CmcET6fatK2+IGx2qsuYtOlXQYQotuX+1zc=;
 b=SZLHn7AhHOgGEGYSluo4dP33w/B1SjezY+SfcNRBZKy9mY0t2kk8Q1Z405UvpQEmYZ
 fODXJWJBD0Y0AhmDm8FQky6/J3XEu4F4c9Eh+pUCQkhZAog/e7LGKLYLNM0iPZeEotW9
 pa20qLLhCnkQk0EQ7xzvxWqQ3upxboj26g5C57GfUGz+p3wTik/Jv//B01WDYdhax5sc
 7vt0V3dR5euqozqBevj7WFGiVsI6WMT17XvGA6eeOBUn/29e3QXdHbT/zZEkRiQtruR2
 zOQi2H3kZeqRhKuDWsPxMlA4PMoja7uBZobhENB6GGTPrgCVjXkSHRDGOue4DCJ65dUK
 fz3Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789491182; x=1790095982; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=JsZhCzznAgndZkRtD7LPWAViE6Xktw7cITEK/EXn0fw=;
 b=VHbovBnBzXYQgV61jRO+S7p4Rzq5vgcJbZmA67pVolt3FbpnDvuL5onspZP5OGipiu
 8pbtpX25Wz1VWVJ8NT9P3lUqp41fkPknHn3sp++CeSlhcvChJTH8Av8SbvwL7J/OyC+p
 iSKtfQDfLKDzTjAJjx9lWQm4qWF26hyxXADFYjUcIqaoKaYSr2ilrkFJTnh5KUKX/le9
 Cc15pHWwRkmHMrw6JvqtWrAPx7MOxQ1JtsY7Pi5CsgJrTTzCwgHwhMFdQXMhsedbSWCZ
 UTOqAZgYrnEGUmEuhv28B9bdXHgZk3y2+lBWoLBQGl4QczqpRn0xsE0Ce+++A82/zcmr
 2vsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789491182; x=1790095982;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JsZhCzznAgndZkRtD7LPWAViE6Xktw7cITEK/EXn0fw=;
 b=xEIWdWGYOlTS68fvCCtFEePix3j16GrXEM6stSx2q2CZ214YlO/NBzdFIzSlgCgiVC
 /Ov7aCQ18Islf09l9wmdFlYdwsXb7/LaTyfGRQw/ar/UpYYlKEiUlX+zukXs6jz+2R73
 iPtJEhr4HSRTnUV4s336tXWHsr3Fe/hXF6drq40Cc1XMM5j9KE1/5GhcUramuTk1PenM
 TLWbdTDj+QnO2qrICIOMjt0Cu9hwSCxQfhbicatpU+blv8eWbhDAE23quqzT23PsC2lD
 KnjiAzlbzO3BYdFv0DlU+jKPgiad1DPj+/g12sOgoaIz2w2dlO0ACDz/3VLTGGqa6E6r
 /JKw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzJzRnhwt0dIkP+Mce3n92/7vxxg1DWEUFVxXQn3TvdM90Ns78XBP2ceYNI4EoRjeMPR+RR4XEoiuNR@nongnu.org
X-Gm-Message-State: AFuF++l/mMEppGJQuMDM/P5lSn16j5Sgkg83xZkQTZ6V5WcIuCa4U2WV
 pfq70M7QMg4dTmy7EcMO6AA2DgcqIe0AONipYRacsbBeTVv2GIBFm2NTewGOUyhGi1Um5/6FQez
 L9WRPPZqqGthHptRICnrpfwFUK5IOFcQ5vAd9ce+TpOT7NeeEUTWuK4CusBil/z7MqzhI49w6OT
 7nTXvaxXTm0AM34xljmo4Afu8SgxhLNKg=
X-Gm-Gg: AYBFou0nvMK2yw96HJ9J2yplEUXtY0EFj2YmtpsbUtdgdU4cH9m/WJEmxu8Xxpq4Wrm
 JV+MFf/Q3dHfOl8hzV2x8LHnbaG4OjV6XbAwce3/NnR12NPdZtrTyG8w7awjkFw6B474qR21iOX
 Y5Zpg7l8LaotO+SGVQKYTSQe5wggoCMEk2se/DYN+IZ2E50Sn5lUrOLZGqV1lfFEqHPYB3lMwGa
 VHlGvIaNTsaHXTU
X-Received: by 2002:a05:690e:414a:b0:671:3e72:de4 with SMTP id
 956f58d0204a3-6714e0878e5mr2784346d50.50.1789491182156; 
 Tue, 15 Sep 2026 09:53:02 -0700 (PDT)
X-Received: by 2002:a05:690e:414a:b0:671:3e72:de4 with SMTP id
 956f58d0204a3-6714e0878e5mr2784325d50.50.1789491181531; Tue, 15 Sep 2026
 09:53:01 -0700 (PDT)
MIME-Version: 1.0
References: <20260904150826.2331577-1-alex.bennee@linaro.org>
 <CAFEAcA9vZZmVPP3_P1xz-NX_sqWY0zrOC2LeGLTdnaK54XKQzQ@mail.gmail.com>
In-Reply-To: <CAFEAcA9vZZmVPP3_P1xz-NX_sqWY0zrOC2LeGLTdnaK54XKQzQ@mail.gmail.com>
From: John Snow <jsnow@redhat.com>
Date: Tue, 15 Sep 2026 12:52:50 -0400
X-Gm-Features: AcwNN1Ul6PF0NVR723zA6f5tnQzRGXK6SBL0DsWrQx0e2BuV7WSpIX80rLNk7kM
Message-ID: <CAFn=p-bXoctWNEdERPBL-SMRPYDisban2e0-mxYjws7UVcjVzw@mail.gmail.com>
Subject: Re: [PULL v2 000/105] move check-tcg into the meson build
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

On Fri, Sep 4, 2026 at 2:04=E2=80=AFPM Peter Maydell <peter.maydell@linaro.=
org> wrote:
>
> On Fri, 4 Sept 2026 at 16:08, Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
> >
> > The following changes since commit d2843fbf80260e4346c856819e8cea11768c=
9d0e:
> >
> >   Merge tag 'pull-riscv-to-apply-20260904' of https://github.com/alista=
ir23/qemu into staging (2026-09-04 09:43:27 +0100)
> >
> > are available in the Git repository at:
> >
> >   https://gitlab.com/stsquad/qemu.git tags/pull-11.1-check-tcg-meson-04=
0926-2
> >
> > for you to fetch changes up to 7a485176838e6b6044e73f925d308bb4b3002597=
:
> >
> >   MAINTAINERS: add maintainer for tcg/tests meson infrastructure (2026-=
09-04 16:06:22 +0100)
> >
> > ----------------------------------------------------------------
> > tests/tcg: conversion to meson
> >
> >   - remove unused variable from multiarch/memory
> >   - standardise checking plugin output
> >   - bump minimal meson to 1.6.0
> >   - introduce meson plumbing for check-tcg
> >   - return error code if docker probe fails
> >   - add CI/self/mem test to gdbstub prot-none tests
> >   - use raw opcode for fprcvt test in arm
> >   - remove unused variables from gpc-test
> >   - teach probe-gdb-support about mips
> >   - identify or1k pc register
> >   - port check-tcg logic to meson (all targets)
> >   - update documentation
> >   - add Pierrick as a maintainer for tests/tcg

Hi, I'm having difficulties building after this PR, after eb7f0c14 in
particular.

I keep seeing stuff like this:

FAILED: [code=3D1] tests/tcg/x86_64-softmmu-hello.test
/home/jsnow/src/qemu/tests/tcg/../docker/docker.py --command podman
run --run-as-current-user -w /home/jsnow/src/qemu/build -v
/home/jsnow/src/qemu:/home/jsnow/src/qemu debian-amd64-cross
x86_64-linux-gnu-gcc
/home/jsnow/src/qemu/tests/tcg/multiarch/system/hello.c -o
tests/tcg/x86_64-softmmu-hello.test -static -MMD -MF
tests/tcg/x86_64-softmmu-hello.d -Wall -Werror -O0 -g
-fno-strict-aliasing -nostdlib -ffreestanding -Wa,--noexecstack -I
/home/jsnow/src/qemu/tests/tcg/x86_64/system/../../minilib
/home/jsnow/src/qemu/tests/tcg/x86_64/system/../../minilib/printf.c
../tests/tcg/x86_64/system/boot.S -Wl,-T
../tests/tcg/x86_64/system/kernel.ld -Wl,-melf_x86_64
-Wl,--no-warn-rwx-segments -Wl,--build-id=3Dnone -lgcc
cc1: fatal error:
/home/jsnow/src/qemu/tests/tcg/multiarch/system/hello.c: Permission
denied
compilation terminated.
cc1: fatal error:
/home/jsnow/src/qemu/tests/tcg/x86_64/system/../../minilib/printf.c:
Permission denied
compilation terminated.
cc1: fatal error: ../tests/tcg/x86_64/system/boot.S: Permission denied
compilation terminated.
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
'--label', 'com.qemu.instance.uuid=3D0df29d1fcdc947f1b0cde41104eebed9',
'--userns=3Dkeep-id', '-u', '21266', '-w', '/home/jsnow/src/qemu/build',
'-v', '/home/jsnow/src/qemu:/home/jsnow/src/qemu',
'debian-amd64-cross', 'x86_64-linux-gnu-gcc',
'/home/jsnow/src/qemu/tests/tcg/multiarch/system/hello.c', '-o',
'tests/tcg/x86_64-softmmu-hello.test', '-static', '-MMD', '-MF',
'tests/tcg/x86_64-softmmu-hello.d', '-Wall', '-Werror', '-O0', '-g',
'-fno-strict-aliasing', '-nostdlib', '-ffreestanding',
'-Wa,--noexecstack', '-I',
'/home/jsnow/src/qemu/tests/tcg/x86_64/system/../../minilib',
'/home/jsnow/src/qemu/tests/tcg/x86_64/system/../../minilib/printf.c',
'../tests/tcg/x86_64/system/boot.S', '-Wl,-T',
'../tests/tcg/x86_64/system/kernel.ld', '-Wl,-melf_x86_64',
'-Wl,--no-warn-rwx-segments', '-Wl,--build-id=3Dnone', '-lgcc']'
returned non-zero exit status 1.
filter=3D--filter=3Dlabel=3Dcom.qemu.instance.uuid=3D0df29d1fcdc947f1b0cde4=
1104eebed9
ninja: build stopped: subcommand failed.
make: *** [Makefile:170: run-ninja] Error 1

Is there some kind of setup I have neglected to perform to make this
new build system work? Is there a way I can skip these tests in the
meantime...?

Thanks,
--js


