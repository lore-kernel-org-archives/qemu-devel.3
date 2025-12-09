Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83634D3B993
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Dec 2025 19:43:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vT3cL-0003T0-DP; Tue, 09 Dec 2025 14:43:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vT3cJ-0003SY-Vp
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 14:43:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vT3cH-0004Wi-KF
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 14:43:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765309400;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H6Klh+25RYLDD7Q5BTf/qd4Lz8PwubaXdHvt+YmjyZU=;
 b=RSnW+aMe+Yv+xc2ljAu5GhsflH+b0ybWB5FA4EZIsaLao34kAJv/3vK47sFx8ElOrsxkkL
 W2zoxFml1/kV9wEtSkz6198G/yjAeOqAgReStDbcFcJX3iqEe8ZNh8nuaiHAxosgQ5JWEC
 uPg2QW374xEiWRKE57u9mX2AFrChGNU=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-411-9wfbDFUHPvGmZ1JaHqwojw-1; Tue, 09 Dec 2025 14:43:18 -0500
X-MC-Unique: 9wfbDFUHPvGmZ1JaHqwojw-1
X-Mimecast-MFC-AGG-ID: 9wfbDFUHPvGmZ1JaHqwojw_1765309398
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-78c2bce1258so60882027b3.1
 for <qemu-devel@nongnu.org>; Tue, 09 Dec 2025 11:43:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765309398; x=1765914198; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H6Klh+25RYLDD7Q5BTf/qd4Lz8PwubaXdHvt+YmjyZU=;
 b=Vpa3d/faDTp3PAz0ZpCbhkPPdpS2oZ63p5FBZYOkXIXfOvSKJ6yyIumkXL/un1DuKj
 +DesU4563elxFkxglG4b+RSDDaRr0hbw6c+mbpiZIs+SBHujJUCBh95UMlWfKfiDzDBd
 Z29QSKC6V+l+SeRr3TqgdPqH/REoOj4plNsqYc5wGu0ca75QFF7LuTjADgrZJZeJM2/O
 ZIFdIqHrdEkk87ET7Q/iD7ZBbsJv4k4Bz5bSH6idiWFT8+3cxV2OQlqouz6/wI3ioZyl
 pn/Ud0Na0u8vZ9ptYN4N9kIhF4EvpvfOdrkijKTKgvU9u9LuF9OT1c5rMKLLo383O7WE
 7HUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765309398; x=1765914198;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=H6Klh+25RYLDD7Q5BTf/qd4Lz8PwubaXdHvt+YmjyZU=;
 b=MnudKJZlgzDE0yHrXqHuF1ZBndTC03/1Ull3Fq98AryOD3XmS++q231NsQh0pXTNeV
 AzNUyu76htkZbQ/eyXAZYovGaadjofrPUmIOJbjvUtN5RvxeGZEMccA+jIFS/ub7zy1x
 HAGzfGPlxV6NeuRS3qbfUxNk4AAS3x4vMq1l2Jhgghi+ZbThdfLf3l9LXzmCWYdN6eL2
 69S/yZimZ4latSbSIwPCsuRqNFw3MNpqiuvc3nNcnzU7MglZJ+Apq1NZ29bstpA8GYiV
 Gwp7A7HHkeXuivy0jI4sHjCrhRzT6PAdArDImAB9BO7x3JmaeH0ILZa8vFZwEsVgy+wt
 +Kcw==
X-Gm-Message-State: AOJu0Ywrrbezi2OODFea6dA0RysRpz+BP3mqnoIearfk9AmI6ikgw5hq
 ejKMSaLRsw+TF+AwboE47etvbrLkiT1jnGe/ddfgckw5JAzMJOMuq94Qw3TmjAn/Q5916Vqtx03
 KJ7g6EGOEyySmG7lWSP8n/PHjQPlpEcv18LKA4VDiZw7gDi0x2ZesU/DW4TH/rl0inJCj4z2F9d
 QGnauaosj3NfBcwpKRk2VzEl1mivKNZtc=
X-Gm-Gg: AY/fxX7j6W/cVHZZcs8BVktXNEdtBBLw5YGNNjqap6VtMRwHVkOgIpBZL2HOGRA2UkS
 IZnZO6Xs3PPbmOBp1Er8rBKJ2gvVMBCCFXHic9PEyi0ZgI07soXVBG2iqcselObbpyagoVIyM0K
 yw/CUj1MOw8s4T7XcCYQE9UFZaWAF0hiN5JVJDAkhtLNMWYzJQU4fvdG80561s4YZ1kpp6vNwVo
 F7q0fzBYXd0ycr5ax2gDLwP6Q==
X-Received: by 2002:a53:eac7:0:b0:642:1d3:ae00 with SMTP id
 956f58d0204a3-6446eae8e74mr42323d50.49.1765309397806; 
 Tue, 09 Dec 2025 11:43:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGAwU5QIOy7eNXb/+pfeUzX02Y0YbztqEopZfD+jMwyCn8W0NW2cB/HL7mqmuMWq4cx+x04/tygoXONPg8mi9s=
X-Received: by 2002:a53:eac7:0:b0:642:1d3:ae00 with SMTP id
 956f58d0204a3-6446eae8e74mr42302d50.49.1765309397442; Tue, 09 Dec 2025
 11:43:17 -0800 (PST)
MIME-Version: 1.0
References: <20251205060058.1503170-1-jsnow@redhat.com>
 <aThVvP5vwfjVa-ka@redhat.com>
 <CAFn=p-aw1+BDuB1znFBdq_Z+V_qiuO-Vh69UZsS7LZKWZpPTuw@mail.gmail.com>
In-Reply-To: <CAFn=p-aw1+BDuB1znFBdq_Z+V_qiuO-Vh69UZsS7LZKWZpPTuw@mail.gmail.com>
From: John Snow <jsnow@redhat.com>
Date: Tue, 9 Dec 2025 14:43:06 -0500
X-Gm-Features: AQt7F2rNf9RrGgu5-3O0kBXXqxfX3dxrOHWQAsScbJALhpLyliiFDT8z-ljOoc0
Message-ID: <CAFn=p-Yi-af-NnA6gi4=23yanivQvfAi8M_6aD4A-mPptS-AxA@mail.gmail.com>
Subject: Re: [PATCH v3 00/15] python: drop qemu.qmp from qemu.git tree
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Cleber Rosa <crosa@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>, 
 Kevin Wolf <kwolf@redhat.com>, Qemu-block <qemu-block@nongnu.org>, 
 Michael Roth <michael.roth@amd.com>, Markus Armbruster <armbru@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Ed Maste <emaste@freebsd.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, Dec 9, 2025 at 12:23=E2=80=AFPM John Snow <jsnow@redhat.com> wrote:
>
>
>
> On Tue, Dec 9, 2025, 12:00=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com> wrote:
>>
>> On Fri, Dec 05, 2025 at 01:00:42AM -0500, John Snow wrote:
>> > Hello!
>> >
>> > This series drops the in-tree version of our python-qemu-qmp package
>> > ("qemu.qmp") in favor of the version hosted on PyPI, whose repository =
is
>> > located at https://gitlab.com/qemu-project/python-qemu-qmp.
>> >
>> > GitLab CI: https://gitlab.com/jsnow/qemu/-/pipelines/2197613036
>> >        (FreeBSD isn't my fault...!)
>> >
>> > The major effects of this patch series are:
>> >
>> > 1. qemu.qmp will be installed from PyPI or vendored packages instead o=
f
>> >    being utilized directly from the qemu.git tree.
>>
>> This is not getting installed in enough scenarios IMHO.
>
>
> It's hard to trigger an install when you don't use the build system, thou=
gh... If you bypass make/meson/ninja entirely I'm not really sure what I ca=
n do to bootstrap the test deps.
>
>>
>> My current workflow is commonly
>>
>>   $ ./configure --target-list=3Dx86_64-softmmu
>>   $ make
>>   $ ./scripts/qmp/qmp-shell-wrap
>>    /var/home/berrange/src/virt/qemu/build
>>   Traceback (most recent call last):
>>     File "/var/home/berrange/src/virt/qemu/scripts/qmp/qmp-shell-wrap", =
line 7, in <module>
>>       from qemu.qmp import qmp_shell
>>   ModuleNotFoundError: No module named 'qemu.qmp'
>>
>> Even if I add in a call to 'source build/pyvenv/bin/activate'
>> after 'make', I'm still missing the qemu.qmp python module.
>>
>> AFAICT, qemu.qmp only gets installed in the venv if you run
>> 'make check', and IMHO that should not be expected for the
>> above usage scenario.
>
>
> "make check-venv", to do just the minimum setup. You don't have to run ch=
eck.
>
> We could always add a flag to configure to front-load the testing environ=
ment and scripts, but I thought it was best to avoid adding new dependencie=
s by default.
>
> Like --with-python-tests or something? Then you'd always have it like you=
 do with meson and sphinx (with --enable-docs)
>
>>
>> Likewise I can no longer run any of the test programs directly
>> without first having run 'make check'. eg what I would currently
>> do is:
>>
>>    $ ./configure --target-list=3Dx86_64-softmmu
>>    $ make
>>    $ cd build/tests/qemu-iotests
>>    $ ./check 300
>>
>> I don't generally run 'make check' as frequently as I
>> 'configure && make' as it adds alot of time which is
>> not needed usually.
>>
>> In general I find it tedious having to remember to run
>> 'source build/pyvenv/bin/activate' in every terminal
>> window where I might want to run a QEMU script that relies
>> on python. It is also fairly undesirable too, as I use the
>> same terminal window for various purposes, that activating
>> the QEMU venv can interfere with non-QEMU python usage.
>
>
> You can run one-offs with build/pyvenv/bin/python3 without activating the=
 environment,
>
> but you're right that this does require an environment setup step (make c=
heck-venv)
>
>>
>> I would find it helpful if we provided a "run" script in the
>> root dir of the build directory that contained the following
>>
>>   $ cat build/run
>>   #!/bin/sh
>>
>>   set -e
>>
>>   HERE=3D$(realpath $(dirname $0))
>>   source $HERE/pyvenv/bin/activate
>>   exec "$@"
>>
>> Which would be used as a wrapper to execute scripts with the
>> right environment. That would let us keep the simpler workflow,
>> and avoid polluting the global terminal environment with the
>> qemu venv.
>>
>> eg to be used as
>>
>>    $ ./configure --target-list=3Dx86_64-softmmu
>>    $ make
>>    $ cd build/tests/qemu-iotests
>>    $ ../../run ./check 300
>>
>> or
>>
>>   $ ./configure --target-list=3Dx86_64-softmmu
>>   $ make
>>   $ ./build/run ./scripts/qmp/qmp-shell-wrap
>
>
> Shouldn't be too hard to add, honestly. Maybe adding in a "meson compile =
pyvenv/pyvenv_tests_group" line at the start to trigger the dep installatio=
n if it hasn't occurred already?
>
> Or maybe just directly invoking mkvenv ensuregroup to avoid ninja re-conf=
iguring things while you develop.
>
> Something like that.

How about something like this inside of your build root:

```
#!/usr/bin/env python3

import os
from pathlib import Path
import shlex
import subprocess
import sys

def main():
    venvpath =3D Path(__file__).parent.joinpath('pyvenv')

    groupfile =3D venvpath.joinpath('checktests.group')
    if not groupfile.exists():
        subprocess.run(["ninja", "pyvenv/checktests.group"])

    env =3D os.environ.copy()
    env['VIRTUAL_ENV'] =3D str(venvpath)
    env['PATH'] =3D str(venvpath.joinpath('bin')) + ':' + env['PATH']
    env['VIRTUAL_ENV_PROMPT'] =3D 'pyvenv'
    if 'PYTHONHOME' in env:
        del env['PYTHONHOME']

    command =3D shlex.join(sys.argv[1:])
    res =3D subprocess.run(command, env=3Denv, shell=3DTrue)
    sys.exit(res.returncode)

if __name__ =3D=3D '__main__':
    main()
```

Then you can run arbitrary things, like "./pyrun which python3" or
whatever you fancy. It only bothers calling ninja if the timestamp
file is not there to help save some startup time and avoid unnecessary
reconfigures. This should work for qmp-shell, qmp-shell-wrap,
qemu-ga-client, qmp-tui, qom, qom-fuse, qom-get, qom-list, qom-set,
qom-tree, device-crash-test, iotests, etc.

>
>
>>
>>
>>
>>
>> > 2. There are no new python dependencies checked or installed during
>> >    configure.  All test dependencies are installed post-hoc on an
>> >    as-needed basis.
>> > 3. "make check-venv" is no longer required to be run manually before a=
ny
>> >    test that is integrated with meson; this includes "make check" and
>> >    "make check-functional".
>> > 4. "make check-venv" no longer installs functional test dependencies: =
it
>> >    installs only the core suite of python test dependencies.
>> > 5. "make check-venv" is now required as a pre-requisite for running
>> >    device-crash-test and manually executed iotests.
>> > 6. Unfortunately, python3-wheel and python3-setuptools are now require=
d
>> >    on the host system if tests are to be executed and >=3D Python 3.13=
 is
>> >    used.
>> > 7. An awful lot of deleted lines of code, and a lot fewer headaches
>> >    managing two nearly-identical copies of this source code. O:-)
>> >
>> > Patches 1-5 are build system focused; they set up new pythondeps.toml,
>> > mkvenv, and meson systems in preparation for relying on an external
>> > qemu.qmp library, but does not yet make the switch.
>> >
>> > Patches 6-9 are testing and CI focused; they add necessary preparation
>> > steps to keep tests running happily once the in-tree qemu.qmp library =
is
>> > removed.
>> >
>> > Patches 10-15 are build system focused again; they implement the actua=
l
>> > switchover to the external qemu.qmp library.
>>
>> With regards,
>> Daniel
>> --
>> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberra=
nge :|
>> |: https://libvirt.org         -o-            https://fstop138.berrange.=
com :|
>> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberra=
nge :|
>>


