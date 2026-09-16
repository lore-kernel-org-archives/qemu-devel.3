Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBCDBC982C1
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 16:17:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6sJe-0004gN-CF; Wed, 16 Sep 2026 12:16:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1x6sJb-0004fu-4F
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 12:16:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1x6sJY-0003DN-Gm
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 12:16:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789575411;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/sVwSOyb5JmZoWFMESeg9tJGwpWTB5Tli+b5xSN+R18=;
 b=Ow9OM0yV71elwQxRwkuUqa2jNgI15vjzk1lxjs5Fl+lfOpGEMWIy/5MNtvjUgFDQjtF84i
 9is9GrPK2K0EfMXOfuWWvgQi5+GemsXD+DH9P7Yb3wItMRXX/cN6uuz5tMSoPEKAgY3IH+
 JAFV6OKqWQmpomzHFrYP/mH4bACFQcI=
Received: from mail-yx1-f70.google.com (mail-yx1-f70.google.com
 [74.125.224.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-361-rWaNvdqhNe-4FaoZ9eg-xw-1; Wed, 16 Sep 2026 12:16:49 -0400
X-MC-Unique: rWaNvdqhNe-4FaoZ9eg-xw-1
X-Mimecast-MFC-AGG-ID: rWaNvdqhNe-4FaoZ9eg-xw_1789575409
Received: by mail-yx1-f70.google.com with SMTP id
 956f58d0204a3-671321441d1so5924290d50.1
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 09:16:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789575408; cv=none;
 d=google.com; s=arc-20260327;
 b=VmNw3oVcVRKzIgtfIm/OV75CPZ3aq4hg44xX9r5C4+MxJgoohUJtM+fnFvrQguZk/V
 Bv2wEYmgel9PD68DkaSsyQzfKP7ttUzolxgEB4UmpKyn4RMD9T+b/Fxop34rRqXfCB0K
 b90bNi72ecsLm5batDLzufMO1E3LvIOUGCor6DK9POekOvPPlonR1VgPSyv8c4xet8BI
 r3vyNOWwkvqB4p3Y3E4Eqp2mbWmPXpmj9oriXwWHR51LVd1I1VzETIkzKTreIlbmRVgZ
 gjF1muQGfw+UaAT0vX6BQO0yaARtZAhM+V7JnUSHDA1Eo4aCYnFF6x2WmbxnwszHDeS0
 iZ0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=/sVwSOyb5JmZoWFMESeg9tJGwpWTB5Tli+b5xSN+R18=;
 fh=V3JEu6r+pLdltbiC/UbjSLUukoS3WhGKq4o53lTX5QY=;
 b=CZGPfOuT/vBdx5Pin47lfWX4hzVa0arGkX45rLTlXLtziYqoUhBr5Yle2YNgj1HlMH
 /dJMvsBICMprclN1wr+v2taiDtnfBSVLQwjAlXowiobgyw8GDpC1PiEiRlQaxrf9QNL3
 tgii3tsWxJuZmjEWb5j72bHo44BxIqcoq/U2wvQMjgUnx1+kK8aX3ZqLh03nK3EGmq95
 IvW6/IZ3aFDEdBEjrG41xAE5v2lgu7lbYxLpUvrlWGKb9Y+IiEIySeGNJVakr83+elf8
 ET9E12CSIgqEi4UMKNUChAFu+PRD381g4vKGaL9fpMH2uQsxEbNwRmtVqJVRzsNL08+0
 +rKA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789575408; x=1790180208; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/sVwSOyb5JmZoWFMESeg9tJGwpWTB5Tli+b5xSN+R18=;
 b=UTZEogrJtjKDHik4j3e0cyF3hDjVOxm/+39s7QOC93dgIjg4x/G6tiBwY5YmB+oVbH
 /5uOAiPKgjkOB6+15k4DmS2adPhaSDWo0PJl81z21DjkdYD3m/tSsyl4WbkyaD9oZEPV
 6kjJplRSNjtHmhD7i2p/8C5gnaPWPgYA11Q+yvcvD/tDEMHzL0BMT/f8zTxywIQEQ3le
 DwmNRjW1TkkLevxGspVPeoCfedBzUjpswfhq0c55tcQJitF/XKZhTguUkBqv8vSrteiE
 mnIGid6pKCJ4GpMa3BGn4jUN3h2hvrHb6B94xE8SqsE4vDDzWfdXHGn8PE5mqCRGeGpg
 lhfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789575408; x=1790180208;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/sVwSOyb5JmZoWFMESeg9tJGwpWTB5Tli+b5xSN+R18=;
 b=T2DWr2lKVJrm7pDiy0QKumJB1S0gtud+umn3YBm5QqmB8oKndPyOMTW/QUVOIjt7sz
 4z2auWhr/zQQewuVj7vyuZYdd99ntpKPo43PJYwdPWs0ohWfe7UjQqMcR5dct5w4TOtT
 SASjMRrbbzEMKNrnaucTmvJWoIAfyLEePuGWPeW94h42Hr2jSn/5NT/daeNeE1Nt2ODT
 vn7/XZi4R4ojHnwDvy03pM68Jy9AA2Pbo/m2k4DBp0qWPcLuPC1zVQp2GXfZ/M4OLfgy
 RvehDjrhabeSlQ0pX1HKOvTO0zMDmeGbAT+tQLCTnF45eGjUNwxp+41YOQXoXuedshJn
 RGug==
X-Forwarded-Encrypted: i=1;
 AKwUvBxwcSJJNRwjKuGAmXXZHFFIj1KukGZ8gYdTu0muF818e+3k0RMRetKhGNQ0KsZHqCyn+eGFs5RiCLCI@nongnu.org
X-Gm-Message-State: AFuF++mgpRDRdwaDs0SzU9eX2vIGj5o53Xw1SwBD9phD7/KHr674EAij
 MKbkPfeROG+YPWTeISm7TJckiK9OJXECl9/RrhmVC5OyChM1EH2fZ5pas7wDDh/WoYLkp/Lw2il
 ONGGvrVJgcq+H3KRZ7BqjQGJZ+BskDJVdpyUQIT7RF1LM30rIcvTeGlslySOiDpc6eJ7zq74dMF
 x5MCQ2GSDACsKumlRkyVmJhoghCmDMtX0=
X-Gm-Gg: AYBFou1KALMGtrZ/upcCsi36oN8YrIQX1pbxa5ttURg6GLvdDftcvFYiiBfx1t0GT27
 wDtROZVcG/SoJ70i1YBN8yeWUb7mmQKBibu47VAovRcUTNHqOz7nBW/Yttt4QRQPmczi7C1toyZ
 rL7yjsCUDg8aa3W87De3yhxvH7hYRZE+6Jj/od7TZMVrgLHU8BZAdaws5/kEuSxPXpFmqO9cKwT
 uwLkLPKndMufEMU
X-Received: by 2002:a05:690e:43cc:10b0:66f:b219:9eda with SMTP id
 956f58d0204a3-67163209ca0mr753243d50.22.1789575408413; 
 Wed, 16 Sep 2026 09:16:48 -0700 (PDT)
X-Received: by 2002:a05:690e:43cc:10b0:66f:b219:9eda with SMTP id
 956f58d0204a3-67163209ca0mr753227d50.22.1789575407749; Wed, 16 Sep 2026
 09:16:47 -0700 (PDT)
MIME-Version: 1.0
References: <20260904150826.2331577-1-alex.bennee@linaro.org>
 <CAFEAcA9vZZmVPP3_P1xz-NX_sqWY0zrOC2LeGLTdnaK54XKQzQ@mail.gmail.com>
 <CAFn=p-bXoctWNEdERPBL-SMRPYDisban2e0-mxYjws7UVcjVzw@mail.gmail.com>
 <87tsnq9siw.fsf@draig.linaro.org>
In-Reply-To: <87tsnq9siw.fsf@draig.linaro.org>
From: John Snow <jsnow@redhat.com>
Date: Wed, 16 Sep 2026 12:16:36 -0400
X-Gm-Features: AcwNN1Vx4LQn_IiDqbGuRWzEMqD1qCawDgN9pDL2QT1S73n3D27qJ2dI08pwtkE
Message-ID: <CAFn=p-au47ecRqxo=FB5S=LoQqa0dPRXb1xDuCefVXXyZP+OWA@mail.gmail.com>
Subject: Re: [PULL v2 000/105] move check-tcg into the meson build
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_SBL=1.623 autolearn=no autolearn_force=no
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

On Tue, Sep 15, 2026 at 4:19=E2=80=AFPM Alex Benn=C3=A9e <alex.bennee@linar=
o.org> wrote:
>
> John Snow <jsnow@redhat.com> writes:
>
> > On Fri, Sep 4, 2026 at 2:04=E2=80=AFPM Peter Maydell <peter.maydell@lin=
aro.org> wrote:
> >>
> >> On Fri, 4 Sept 2026 at 16:08, Alex Benn=C3=A9e <alex.bennee@linaro.org=
> wrote:
> >> >
> >> > The following changes since commit d2843fbf80260e4346c856819e8cea117=
68c9d0e:
> >> >
> >> >   Merge tag 'pull-riscv-to-apply-20260904' of https://github.com/ali=
stair23/qemu into staging (2026-09-04 09:43:27 +0100)
> >> >
> >> > are available in the Git repository at:
> >> >
> >> >   https://gitlab.com/stsquad/qemu.git tags/pull-11.1-check-tcg-meson=
-040926-2
> >> >
> >> > for you to fetch changes up to 7a485176838e6b6044e73f925d308bb4b3002=
597:
> >> >
> >> >   MAINTAINERS: add maintainer for tcg/tests meson infrastructure (20=
26-09-04 16:06:22 +0100)
> >> >
> >> > ----------------------------------------------------------------
> >> > tests/tcg: conversion to meson
> >> >
> >> >   - remove unused variable from multiarch/memory
> >> >   - standardise checking plugin output
> >> >   - bump minimal meson to 1.6.0
> >> >   - introduce meson plumbing for check-tcg
> >> >   - return error code if docker probe fails
> >> >   - add CI/self/mem test to gdbstub prot-none tests
> >> >   - use raw opcode for fprcvt test in arm
> >> >   - remove unused variables from gpc-test
> >> >   - teach probe-gdb-support about mips
> >> >   - identify or1k pc register
> >> >   - port check-tcg logic to meson (all targets)
> >> >   - update documentation
> >> >   - add Pierrick as a maintainer for tests/tcg
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
>
> Try the v2 I've just posted. That fixed up the handling of mapping your
> host user id into the container so there are less surprises when it
> writes to the mapped volume.
>
>   https://patchew.org/QEMU/20260915201601.1207839-1-alex.bennee@linaro.or=
g/
>

No dice there. Fully rebooted my machine just in case there were
permission issues lingering in my session; still getting perm errors:

jsnow@jsnow-thinkpadp16vgen1 ~/s/q/build (review)> cat /etc/subuid
jsnow:100000:65536
jsnow@jsnow-thinkpadp16vgen1 ~/s/q/build (review)> cat /etc/subgid
jsnow:100000:65536

jsnow@jsnow-thinkpadp16vgen1 ~/s/q/build (review)> ls -lahZ
../tests/tcg/multiarch/system/hello.c
-rw-r--r--. 1 jsnow jsnow unconfined_u:object_r:user_home_t:s0 229 May
 7  2025 ../tests/tcg/multiarch/system/hello.c

Setting the dreaded `setenforce 0` it does seem to work, so I suppose
the issue is that my source tree is not labeled in a way that permits
it to be mapped into a container.

I'd like to ask that we have a hello world style check that tests to
see if it can access your source tree and, if not, proposes some
solutions:

(1) Prompt user to check that rootless podman is functioning
correctly, check your subuid/subgid etc
(2) Prompt user to check selinux labels
(3) Suggest that container builds can be disabled with --disable-containers

Possibly even as part of configure we do a simple hello-world test and
if it works, enable containers by default and if it does not, we
disable them. If you pass --enable-containers and the hello world
fails, configure exits with an error.

Or some other such thing.

--js


