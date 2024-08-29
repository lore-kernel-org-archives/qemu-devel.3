Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00104C83F15
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2024 13:10:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjeut-0000V3-Ko; Thu, 29 Aug 2024 09:10:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sjeur-0000Mf-4u
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 09:10:21 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sjeun-0005Iw-Ey
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 09:10:20 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a86883231b4so66229166b.3
 for <qemu-devel@nongnu.org>; Thu, 29 Aug 2024 06:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724937016; x=1725541816; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K7GAFHCTD9T9M/HiP9Kh4Hb96okJ4OsR5k40LCiClU0=;
 b=E39Ql64fnggLh1bFcEChEr50hGIDFZBSxwl8G0GwldiJTTXUijh5zOcG4q9O3b2Nno
 4ucCRurKD3nB1XtEYbo9ymfYqRSjpsXwluS66CJlH9Syks1cFnLKmzDIyiP3jHXiHTHH
 S85d8rysDlMv+EnmItgZgxQ9GviU/Vwx7n5Fre4uZjMHl3UNV3M5QEEmrjLK+Tg40XJa
 gFQ0nt+tA0B22mNFZnDd2FMcX2vkSGbVU4Q/hISdQisXgWyfEUr09B6D7SGZ3sFbsW6g
 /ZDxeLqOcR+m4IMfJMyDyOp4xytjNqEe5z4zMlvr1CLmv1hkydHA2cuWGXmDsRmm+Rn6
 NdBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724937016; x=1725541816;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K7GAFHCTD9T9M/HiP9Kh4Hb96okJ4OsR5k40LCiClU0=;
 b=gVc2kT4PRDrAlvrwmemoc4kfNLLqvnvlBp8JI8VQRc5+dzFG+19/FSTQB5V9mbZPgQ
 QW1aSoTuEpo4NRPkOOcO0n06lAnZejy7DgOvOHCuIrXJmMx0YMvbGR+vITkl1JztG2Mo
 lTIUCk5KxVVfBwLhoqpa3P9o4H96gvOQSbjRtdUaYr6cevzhjFz7n3fH79b2b5XYrIdU
 KL4bGTkgC380suKJZ3hYOGy8dnBtAH/8ukEj9gpQtn+iNbtrqoI5Qjnib7QI1Xru7kT9
 xv03mk3iIlSmp0sOvGNdtHEPoMyBeaAY0oiqSvq1bTsqovUwF/4/6AD+L7eXbCSDiuZc
 Kd8w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVA/fURMoPdADdbA1CLtEc6MMFy6reLPBV7boORLHEU7AOQ7W5uiRKOBtXrb/SPoyaNnxGgH1/Yi+id@nongnu.org
X-Gm-Message-State: AOJu0YwjsGIgIHTpFJq1kDEbw/NWyxK0bR1neOo3KnNOSP+T46g5mC64
 MAbm/lAz8XGjAXduq6BpB9AehOuBnyJH1VC/G8qWqEL3GSRs041GGljDxcyXyK0ZFQlnfaOYI1L
 UAmR3N5rvaSwOqbbiuU5D8f4ynMxAW67FsT22dJpw3/mdaA1q
X-Google-Smtp-Source: AGHT+IG+wNuHP8rCdbp5xdbkJAfmaajyUyqCZYpCRcGQDXbVCgsT1snfz9kNFHBljq9jUpicSdZm1uz1HFSzBdwGMgs=
X-Received: by 2002:a05:6402:2803:b0:5be:d9ac:c776 with SMTP id
 4fb4d7f45d1cf-5c21eda0d9bmr2081799a12.38.1724936996626; Thu, 29 Aug 2024
 06:09:56 -0700 (PDT)
MIME-Version: 1.0
References: <20240813165250.2717650-1-peter.maydell@linaro.org>
 <14c38495-131f-4798-bf41-da442ede23eb@linux.ibm.com>
 <CAFEAcA8FFiiMXTcMR0WRP=Nhw3-+LYoP=X4OYrm5tnrp4L-wGQ@mail.gmail.com>
 <8050216dbbdd0762347d8e14f17d030ff8874283.camel@linux.ibm.com>
 <172467410002.31767.12365606864399178508@t14-nrb.local>
 <172483282308.162301.11735420619446380771@t14-nrb.local>
 <CAFEAcA-wVqbuW1aG2fd6O9BwMKrFXTLzcvuF4xd6j_4x5WUQ+Q@mail.gmail.com>
 <172493399778.162301.4960007495977124327@t14-nrb.local>
In-Reply-To: <172493399778.162301.4960007495977124327@t14-nrb.local>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 29 Aug 2024 14:09:44 +0100
Message-ID: <CAFEAcA_nXq91A79d0ROc54y=MFoTBETpMmSd_hvk4BzQ9A7=3Q@mail.gmail.com>
Subject: Re: [PATCH for-9.2 00/10] s390: Convert virtio-ccw, cpu to
 three-phase reset, and followup cleanup
To: Nico Boehr <nrb@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>, qemu-devel@nongnu.org, 
 Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org, 
 Richard Henderson <richard.henderson@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, 
 Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, 
 Michael Mueller <mimu@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Thu, 29 Aug 2024 at 13:20, Nico Boehr <nrb@linux.ibm.com> wrote:
>
> Quoting Peter Maydell (2024-08-28 17:46:42)
> [...]
> > Well, the series is *supposed* to be just a refactoring, not a change o=
f
> > behaviour, so I'm not sure. I don't suppose you have a reproduce case
> > that I can run? (I do have access to an s390 machine if that helps.)
>
> Well, it's on an internal testing framework which we do not release
> publicly. :-(
>
> Luckily, it's not that difficult to reproduce.  It seems like this only
> happens when a reboot is initiated over SSH connection via vsock. Here ar=
e
> some instructions on how to reproduce (with mkosi and Fedora):
>
> 1. Craft an mkosi.conf like this:
>    [Distribution]
>    Distribution=3Dfedora
>    Architecture=3Ds390x
>
>    [Output]
>    Format=3Dcpio
>    CompressOutput=3Dxz
>
>    [Content]
>    Packages=3Dopenssh-server
>    Packages=3Dkernel-modules-core-6.8.5-301.fc40.s390x
>    Bootloader=3Dnone
>    MakeInitrd=3Dno
>    Ssh=3Dyes
>    Autologin=3Dyes
>    RootPassword=3Dhunter
>    Timezone=3DEtc/UTC
>    Locale=3DC.UTF-8
> 2. Generate SSH host key:
>    mkdir -p mkosi.extra/etc/ssh && ssh-keygen -t ed25519 -f mkosi.extra/e=
tc/ssh/ssh_host_ed25519_key
> 3. Build image:
>    mkosi
> 4. Boot with QEMU:
>    qemu-system-s390x -machine s390-ccw-virtio,accel=3Dkvm -nodefaults -no=
graphic -chardev stdio,id=3Dcon0 -device sclpconsole,chardev=3Dcon0 -m 2048=
 -kernel image.vmlinuz -initrd image.cpio.xz -device vhost-vsock-ccw,guest-=
cid=3D3
> 5. In a different terminal, run a reboot loop:
>    i=3D0; while true; do ssh -o ProxyCommand=3D'socat VSOCK-CONNECT:3:22 =
-' localhost -l root reboot; echo $i; let i=3Di+1; done

Thanks. I tried this repro, but mkosi falls over almost
immediately:

=E2=80=A3 Detaching namespace
=E2=80=A3 Setting up package cache=E2=80=A6
=E2=80=A3 Setting up package cache /home/linux1/s390-failure/.mkosi-htsau2o=
t complete
=E2=80=A3 Setting up temporary workspace.
=E2=80=A3 Temporary workspace set up in /var/tmp/mkosi-tjc0nror
=E2=80=A3 Running second (final) stage=E2=80=A6
=E2=80=A3  Creating image with partition table=E2=80=A6
Disk /home/linux1/s390-failure/.mkosi-ddkx5xpb: 3 GiB, 3221266432
bytes, 6291536 sectors
Units: sectors of 1 * 512 =3D 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes

>>> Script header accepted.
>>> Script header accepted.
>>> Script header accepted.
>>> Created a new GPT disklabel (GUID: 14CF3B05-D072-0A45-8EE4-3219112ACB2E=
).
/home/linux1/s390-failure/.mkosi-ddkx5xpb1: Created a new partition 1
of type 'unknown' and of size 3 GiB.
/home/linux1/s390-failure/.mkosi-ddkx5xpb2: Done.

New situation:
Disklabel type: gpt
Disk identifier: 14CF3B05-D072-0A45-8EE4-3219112ACB2E

Device                                     Start     End Sectors Size Type
/home/linux1/s390-failure/.mkosi-ddkx5xpb1    40 6291495 6291456   3G unkno=
wn

The partition table has been altered.
=E2=80=A3  Created image with partition table as
/home/linux1/s390-failure/.mkosi-ddkx5xpb
=E2=80=A3  Attaching /home/linux1/s390-failure/.mkosi-ddkx5xpb as loopback=
=E2=80=A6
=E2=80=A3  Attached /dev/loop13
=E2=80=A3  Formatting root partition=E2=80=A6
mke2fs 1.46.5 (30-Dec-2021)
The file /dev/loop13p1 does not exist and no size was specified.
=E2=80=A3  (Detaching /dev/loop13)
Traceback (most recent call last):
  File "/usr/lib/python3.10/runpy.py", line 196, in _run_module_as_main
    return _run_code(code, main_globals, None,
  File "/usr/lib/python3.10/runpy.py", line 86, in _run_code
    exec(code, run_globals)
  File "/usr/lib/python3/dist-packages/mkosi/__main__.py", line 32, in <mod=
ule>
    main()
  File "/usr/lib/python3/dist-packages/mkosi/__main__.py", line 26, in main
    run_verb(a)
  File "/usr/lib/python3/dist-packages/mkosi/__init__.py", line 7809,
in run_verb
    manifest =3D build_stuff(args)
  File "/usr/lib/python3/dist-packages/mkosi/__init__.py", line 7227,
in build_stuff
    image =3D build_image(args, root, manifest=3Dmanifest,
do_run_build_script=3DFalse, cleanup=3DTrue)
  File "/usr/lib/python3/dist-packages/mkosi/__init__.py", line 6941,
in build_image
    prepare_root(args, encrypted.root, cached)
  File "/usr/lib/python3/dist-packages/mkosi/__init__.py", line 1308,
in prepare_root
    mkfs_generic(args, label, path, dev)
  File "/usr/lib/python3/dist-packages/mkosi/__init__.py", line 1031,
in mkfs_generic
    run([*cmdline, dev])
  File "/usr/lib/python3/dist-packages/mkosi/backend.py", line 699, in run
    return subprocess.run(cmdline, check=3Dcheck, stdout=3Dstdout,
stderr=3Dstderr, **kwargs)
  File "/usr/lib/python3.10/subprocess.py", line 526, in run
    raise CalledProcessError(retcode, process.args,
subprocess.CalledProcessError: Command '['mkfs.ext4', '-I', '256',
'-L', 'root', '-M', '/', '/dev/loop13p1']' returned non-zero exit
status 1.

(My s390 box is running Ubuntu, in case that makes a difference.)

Maybe you could put the kernel and initrd somewhere I can
get them from?

-- PMM

