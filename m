Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31D88C3DA7F
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 09:52:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZ60B-0000mi-Bc; Wed, 31 Jul 2024 05:52:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sZ608-0000m7-Tw
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 05:52:09 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sZ607-0008J9-0R
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 05:52:08 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5a2ffc3447fso7598583a12.1
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2024 02:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722419525; x=1723024325; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=zvHh6swc6+CXbwtvpCF7fKGkXu/sO/5WWNVt+ISureY=;
 b=GGJV0nqvNXZuanBnrLEyYN9nR2c02I2lEVxweVTjriuntWOydjXaHdy1mFcQX6tb/w
 JUxPYZGka4ZWWVwnhgiTwjzYxGBI7uXc47WWd/tkQf2OhzcOY7eubl0JFBZyz7XVA8SG
 tMVAieu85jcqi51CeEp1f/D0lElh3nuwapgHhoBoRt+Wu7m2a/nWH7bFQHUGKOd9fDQq
 3Ir0cHK1zAh5uprY4CitIVQFy/jaZhBxqjHqO8zx4sF/bSKBR4Repll9BXsGc2kpo6c4
 QMKeLpyzm59mfmN+JDkhqY+Tlz67X1pZBCy9LX3hHEK204THNFtnTA6Xw4xoOcqWrht/
 9oXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722419525; x=1723024325;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zvHh6swc6+CXbwtvpCF7fKGkXu/sO/5WWNVt+ISureY=;
 b=bPKJMSZFlRdF75zhOzmSv2/MwxmyXh9CiOspsucndFd08Hq7L70Lbi1DEg7FkgvPW+
 qiGNoxX06UUUl6CckDUkZMV4djpcET+Mt0v+2q7XxHWlTtPfWhLGyCuX0SDUQYjHVZLH
 BlZwY6rc3srsS+lHVDJEwgbser3KqdhYCMiYc7fZRfH7/E1fJcEOnFNr7kOsPuL9hsDB
 c42g97gEy7LtiS3++9oefymy0P5FoZRBmPgeV5OQ2Mum0JI/ChIvsg/UC0ftFKRIpH/f
 dV3Q4eaHSKu/GciFRnMR/TeF5jAEwRnhrRebReJKYrXFircTiBz3F42dmj0IGH2qoWHU
 DpMA==
X-Gm-Message-State: AOJu0YwCA9NixD5xiBBSk1tN4ThGMUlCqPcNcFzbLcEWfEJR3TWV5YjS
 mboPdz/STcLFGWKwI57JND0Z5ItfqmXlr+oa+WuLZNFTeb+D+2Sbaas+YRqMHyRmYAKby0vR30T
 a
X-Google-Smtp-Source: AGHT+IGk8J40IU53jgc8Wbi818mXWD1eVk/y39vxVpp02c1nIfrmMQX8oVuI7teEDM7xVSk2pg3xKw==
X-Received: by 2002:a05:6402:3587:b0:5a1:a447:9fa7 with SMTP id
 4fb4d7f45d1cf-5b0205d5dc5mr12194439a12.15.1722419524529; 
 Wed, 31 Jul 2024 02:52:04 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5ac64eb3111sm8477162a12.69.2024.07.31.02.52.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Jul 2024 02:52:04 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id F26425F80B;
 Wed, 31 Jul 2024 10:52:02 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Itaru Kitayama <itaru.kitayama@linux.dev>
Cc: qemu-devel@nongnu.org,  Jean-Philippe Brucker
 <jean-philippe@linaro.org>,  Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: Re: QEMU unexpectedly closed the monitor
In-Reply-To: <7F67EEEA-D222-4348-83EF-5C81C94C79D0@linux.dev> (Itaru
 Kitayama's message of "Wed, 31 Jul 2024 08:04:08 +0900")
References: <8AFDCC22-C476-45EF-9119-2E3C9A2A91C3@linux.dev>
 <87le1jc8qi.fsf@draig.linaro.org>
 <7F67EEEA-D222-4348-83EF-5C81C94C79D0@linux.dev>
Date: Wed, 31 Jul 2024 10:52:02 +0100
Message-ID: <87h6c5dh31.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x535.google.com
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

Itaru Kitayama <itaru.kitayama@linux.dev> writes:

> Hi Alex,
>
>> On Jul 30, 2024, at 22:25, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>>=20
>> Itaru Kitayama <itaru.kitayama@linux.dev> writes:
>>=20
>>> Hi,
>>>=20
>>> Executing virt-install with the following options:
>>>=20
>>> sudo virt-install --machine=3Dvirt --arch=3Daarch64 --name=3Dtest8 --di=
sk
>>> path=3D/var/lib/libvirt/images/jammy.qcow2,format=3Dqcow2,device=3Ddisk=
,bus=3Dvirtio,cache=3Dnone
>>> --memory=3D2048 --vcpu=3D1 --nographic --check all=3Doff --features acp=
i=3Doff
>>> --import --os-variant=3Dubuntu22.04 --virt-type kvm --boot
>>> kernel=3DImage-guest-cca-v4,initrd=3Drootfs.cpio,kernel_args=3D'earlycon
>>> console=3DttyAMA0 rdinit=3D/sbin/init rw root=3D/dev/vda acpi=3Doff' --=
network
>>> none
>>>=20
>>> receives an error:
>>>=20
>>> Starting install...
>>> ERROR    internal error: QEMU unexpectedly closed the monitor (vm=3D'te=
st8'): 2024-07-29T06:23:04.717118Z qemu-system-aarch64: could not load kern=
el '/home/realm/Image-guest-cca-v4=E2=80=99
>>>=20
>>> I am not sure how to investigate as the kernel Image (Image-guest-cca-v=
4) can work if it is used directly with the qemu-system-aarch64, like:
>>>=20
>>> sudo qemu-system-aarch64 -kernel Image-guest-cca-v4 -initrd
>>> rootfs.cpio -cpu host -M virt,gic-version=3D3,acpi=3Doff -enable-kvm -s=
mp
>>> 2 -m 2048M -nographic -append 'earlycon console=3DttyAMA0
>>> rdinit=3D/sbin/init rw root=3D/dev/vda acpi=3Doff' -net none
>>=20
>> Is there any way to get virt-install to dump its QEMU command line?
>> There obviously seems to be something off if it works when you build the
>> command line by hand.
>
> Not in a form we wish, but structured way, see the attached log with
> the =E2=80=94debug option.

You can extract the XML into a file and then do:

  virsh domxml-to-native qemu-argv test.xml=20

which will give you an excessive command line like this:

  /usr/bin/qemu-system-aarch64 -name guest=3Dtest8,debug-threads=3Don -obje=
ct '{"qom-type":"secret","id":"masterKey0","format":"raw","file":"/home/ale=
x/.config/libvirt/qemu/lib/domain--1-test8/master-key.aes"}' -machine virt-=
6.2,usb=3Doff,dump-guest-core=3Doff,gic-version=3D3,memory-backend=3Dmach-v=
irt.ram -accel kvm -cpu host -m 2048 -object '{"qom-type":"memory-backend-r=
am","id":"mach-virt.ram","size":2147483648}' -overcommit mem-lock=3Doff -sm=
p 1,sockets=3D1,cores=3D1,threads=3D1 -uuid b32a6305-44e2-470e-b514-2c0aff7=
6549b -display none -no-user-config -nodefaults -chardev socket,id=3Dcharmo=
nitor,path=3D/home/alex/.config/libvirt/qemu/lib/domain--1-test8/monitor.so=
ck,server=3Don,wait=3Doff -mon chardev=3Dcharmonitor,id=3Dmonitor,mode=3Dco=
ntrol -rtc base=3Dutc -no-shutdown -no-acpi -boot strict=3Don -kernel /home=
/realm/Image-v6.10 -initrd /home/realm/rootfs.cpio -append 'earlycon consol=
e=3DttyAMA0 rdinit=3D/sbin/init rw root=3D/dev/vda acpi=3Don' -device pcie-=
root-port,port=3D8,chassis=3D1,id=3Dpci.1,bus=3Dpcie.0,multifunction=3Don,a=
ddr=3D0x1 -device pcie-root-port,port=3D9,chassis=3D2,id=3Dpci.2,bus=3Dpcie=
.0,addr=3D0x1.0x1 -device pcie-root-port,port=3D10,chassis=3D3,id=3Dpci.3,b=
us=3Dpcie.0,addr=3D0x1.0x2 -device pcie-root-port,port=3D11,chassis=3D4,id=
=3Dpci.4,bus=3Dpcie.0,addr=3D0x1.0x3 -device pcie-root-port,port=3D12,chass=
is=3D5,id=3Dpci.5,bus=3Dpcie.0,addr=3D0x1.0x4 -device pcie-root-port,port=
=3D13,chassis=3D6,id=3Dpci.6,bus=3Dpcie.0,addr=3D0x1.0x5 -device pcie-root-=
port,port=3D14,chassis=3D7,id=3Dpci.7,bus=3Dpcie.0,addr=3D0x1.0x6 -device p=
cie-root-port,port=3D15,chassis=3D8,id=3Dpci.8,bus=3Dpcie.0,addr=3D0x1.0x7 =
-device pcie-root-port,port=3D16,chassis=3D9,id=3Dpci.9,bus=3Dpcie.0,multif=
unction=3Don,addr=3D0x2 -device pcie-root-port,port=3D17,chassis=3D10,id=3D=
pci.10,bus=3Dpcie.0,addr=3D0x2.0x1 -device pcie-root-port,port=3D18,chassis=
=3D11,id=3Dpci.11,bus=3Dpcie.0,addr=3D0x2.0x2 -device pcie-root-port,port=
=3D19,chassis=3D12,id=3Dpci.12,bus=3Dpcie.0,addr=3D0x2.0x3 -device pcie-roo=
t-port,port=3D20,chassis=3D13,id=3Dpci.13,bus=3Dpcie.0,addr=3D0x2.0x4 -devi=
ce pcie-root-port,port=3D21,chassis=3D14,id=3Dpci.14,bus=3Dpcie.0,addr=3D0x=
2.0x5 -device qemu-xhci,p2=3D15,p3=3D15,id=3Dusb,bus=3Dpci.1,addr=3D0x0 -de=
vice virtio-serial-pci,id=3Dvirtio-serial0,bus=3Dpci.2,addr=3D0x0 -blockdev=
 '{"driver":"file","filename":"/var/lib/libvirt/images/jammy.qcow2","node-n=
ame":"libvirt-1-storage","cache":{"direct":true,"no-flush":false},"auto-rea=
d-only":true,"discard":"unmap"}' -blockdev '{"node-name":"libvirt-1-format"=
,"read-only":false,"cache":{"direct":true,"no-flush":false},"driver":"qcow2=
","file":"libvirt-1-storage"}' -device virtio-blk-pci,bus=3Dpci.3,addr=3D0x=
0,drive=3Dlibvirt-1-format,id=3Dvirtio-disk0,bootindex=3D1,write-cache=3Don=
 -chardev pty,id=3Dcharserial0 -serial chardev:charserial0 -chardev socket,=
id=3Dcharchannel0,path=3D/home/alex/.config/libvirt/qemu/channel/target/dom=
ain--1-test8/org.qemu.guest_agent.0,server=3Don,wait=3Doff -device virtseri=
alport,bus=3Dvirtio-serial0.0,nr=3D1,chardev=3Dcharchannel0,id=3Dchannel0,n=
ame=3Dorg.qemu.guest_agent.0 -audiodev '{"id":"audio1","driver":"none"}' -d=
evice virtio-balloon-pci,id=3Dballoon0,bus=3Dpci.4,addr=3D0x0 -object '{"qo=
m-type":"rng-random","id":"objrng0","filename":"/dev/urandom"}' -device vir=
tio-rng-pci,rng=3Dobjrng0,id=3Drng0,bus=3Dpci.5,addr=3D0x0 -sandbox on,obso=
lete=3Ddeny,elevateprivileges=3Ddeny,spawn=3Ddeny,resourcecontrol=3Ddeny -m=
sg timestamp=3Don

You then need to manually strip out all the various chardevs for libvirt
control sockets and you can an equivalent command line you can run from
the console. One thing that did jump out as a bit weird to me was:

 -rtc base=3Dutc -no-shutdown -no-acpi -boot strict=3Don \
 -kernel /home/realm/Image-v6.10 \
 -initrd /home/realm/rootfs.cpio \
 -append 'earlycon console=3DttyAMA0 rdinit=3D/sbin/init rw root=3D/dev/vda=
 acpi=3Don'

which seems to be both disabling ACPI and then enabling it in the kernel
options. Maybe that is a firmware thing?

>
> Itaru.
>
> [2. application/octet-stream; log]...
>
>
>>=20
>>>=20
>>> Userland is Ubuntu 24.04, and the host and guest kernels are for the pr=
otected VM (Realm) execution.
>>> Any help would be appreciated.
>>>=20
>>> Thanks,
>>> Itaru.
>>=20
>> --=20
>> Alex Benn=C3=A9e
>> Virtualisation Tech Lead @ Linaro

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

