Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07773CD4F4C
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Sep 2024 19:47:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snNs4-0007cu-NL; Sun, 08 Sep 2024 15:46:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1snNs3-0007cI-CS
 for qemu-devel@nongnu.org; Sun, 08 Sep 2024 15:46:51 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1snNs0-00006n-Pd
 for qemu-devel@nongnu.org; Sun, 08 Sep 2024 15:46:51 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2d86f713557so2402740a91.2
 for <qemu-devel@nongnu.org>; Sun, 08 Sep 2024 12:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725824807; x=1726429607; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eEyl380fCeAFZ0W2cT8Kjh2BWgJUZ6kOgMJMOqDo6Go=;
 b=KG0zLcM4rbgflSXgwhB0w3hOKwRltUh4iHTFODg0WJPj2HtJ1f3OW7CRJhsLAJzHQL
 JOwBrwFDDkSWfNQQ5ZhHKEIS71og1EIF3LoJmKeRZsnsZ3yAVDjRTAFMYrba4J1a/jWd
 kZoKTEOsxZyp8g4LZQ289U8DNHlpA5YCgymlKLGCOkDt6MMEH7DfcJkn8rfx0DzGxvh/
 lHsll1cvaUu0+lSvkhnEN9HGWN2m2GHz0ZcAb0/bMETTvZaK99ndc6Zq25X5++uuVY2u
 7qvSxqX4HvzN69QSKSbGdNblgyDQAYqqbAcoQLBz9jDNfdhLbZqkwBlNJ+vRVm/tz5Q+
 eB7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725824807; x=1726429607;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eEyl380fCeAFZ0W2cT8Kjh2BWgJUZ6kOgMJMOqDo6Go=;
 b=LHk7EgtOP85VgDNwBJwkWzmQ3cKHK+SwHLfTATxOLUkvJQv09v8ZkWOKKBBX/kNGnz
 GC3PtKef7bPhijyOLa1vc10oyBWVF8v/HJD3gC5HCcg0PyadE9nVPc/HWEi8H25kJ4mI
 Bc2ogUvcvhp7LYNoUncbu0FZvlD8it6n0cHkeyH0OL5VgUhWmTGhCmaCVoTAH6x2YQgC
 g1DOGjFYDNfP2SA3ZGHd9VIcQrP35ZAC8yU6L7nh6a9RBZnFxLyv+9tedU8wv6YBY59x
 NJWeKElhLhWPeNTQ+F9cQfqhJkhxSkEsjMNvN8JET3BesRnMN0UKtH/mSOPs/hL0+k3u
 38/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXR13G4LuLZllIIStPX20E6jXG1wOwXEYImcvB96+xhPyCYbcd0sBsIi4wxSU+5c2mjj/ZBvn5hnC/Z@nongnu.org
X-Gm-Message-State: AOJu0Yzc+3BXANBo1Q6tVKRRRzkV0Z0/NqldKrNZoKzl+E01Tyn7iP6a
 Bhw/ZUiR27Wo6H+rCnmg+0NoYu8N7ovbX9+PohvZjx+q95+T3gD+
X-Google-Smtp-Source: AGHT+IHEPCtFEn1RE8ImxQ71aItodhlksrL4WGrasMATJ2rt+9lC5bLRrJYhmYpDAbCyBPP/AKsUiA==
X-Received: by 2002:a17:90a:ee8f:b0:2d3:c892:9607 with SMTP id
 98e67ed59e1d1-2dad4ef4a6amr10107321a91.12.1725824806389; 
 Sun, 08 Sep 2024 12:46:46 -0700 (PDT)
Received: from valdaarhun.localnet ([223.233.81.109])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2db04966aa5sm3035306a91.37.2024.09.08.12.46.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Sep 2024 12:46:45 -0700 (PDT)
From: Sahil <icegambit91@gmail.com>
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: sgarzare@redhat.com, mst@redhat.com, qemu-devel@nongnu.org,
 Sahil Siddiq <sahilcdq@proton.me>
Subject: Re: [RFC v3 3/3] vhost: Allocate memory for packed vring
Date: Mon, 09 Sep 2024 01:16:40 +0530
Message-ID: <9355562.CDJkKcVGEf@valdaarhun>
In-Reply-To: <CAJaqyWdno3yzuxpCMQN1CyLTt1SOv+oHHwB0Jze28gGqLicscQ@mail.gmail.com>
References: <20240802112138.46831-1-sahilcdq@proton.me>
 <2620452.Lt9SDvczpP@valdaarhun>
 <CAJaqyWdno3yzuxpCMQN1CyLTt1SOv+oHHwB0Jze28gGqLicscQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=icegambit91@gmail.com; helo=mail-pj1-x1036.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Hi,

On Friday, August 30, 2024 4:18:31=E2=80=AFPM GMT+5:30 Eugenio Perez Martin=
 wrote:
> On Fri, Aug 30, 2024 at 12:20=E2=80=AFPM Sahil <icegambit91@gmail.com> wr=
ote:
> > Hi,
> >=20
> > On Tuesday, August 27, 2024 9:00:36=E2=80=AFPM GMT+5:30 Eugenio Perez M=
artin wrote:
> > > On Wed, Aug 21, 2024 at 2:20=E2=80=AFPM Sahil <icegambit91@gmail.com>=
 wrote:
> > > > [...]
> > > > I have been trying to test my changes so far as well. I am not very
> > > > clear
> > > > on a few things.
> > > >=20
> > > > Q1.
> > > > I built QEMU from source with my changes and followed the vdpa_sim +
> > > > vhost_vdpa tutorial [1]. The VM seems to be running fine. How do I
> > > > check
> > > > if the packed format is being used instead of the split vq format f=
or
> > > > shadow virtqueues? I know the packed format is used when virtio_vdev
> > > > has
> > > > got the VIRTIO_F_RING_PACKED bit enabled. Is there a way of checking
> > > > that
> > > > this is the case?
> > >=20
> > > You can see the features that the driver acked from the guest by
> > > checking sysfs. Once you know the PCI BFN from lspci:
> > > # lspci -nn|grep '\[1af4:1041\]'
> > > 01:00.0 Ethernet controller [0200]: Red Hat, Inc. Virtio 1.0 network
> > > device [1af4:1041] (rev 01)
> > > # cut -c 35
> > > /sys/devices/pci0000:00/0000:00:02.0/0000:01:00.0/virtio0/features 0
> > >=20
> > > Also, you can check from QEMU by simply tracing if your functions are
> > > being called.
> > >=20
> > > > Q2.
> > > > What's the recommended way to see what's going on under the hood? I
> > > > tried
> > > > using the -D option so QEMU's logs are written to a file but the fi=
le
> > > > was
> > > > empty. Would using qemu with -monitor stdio or attaching gdb to the
> > > > QEMU
> > > > VM be worthwhile?
> > >=20
> > > You need to add --trace options with the regex you want to get to
> > > enable any output. For example, --trace 'vhost_vdpa_*' print all the
> > > trace_vhost_vdpa_* functions.
> > >=20
> > > If you want to speed things up, you can just replace the interesting
> > > trace_... functions with fprintf(stderr, ...). We can add the trace
> > > ones afterwards.
> >=20
> > Understood. I am able to trace the functions that are being called with
> > fprintf. I'll stick with fprintf for now.
> >=20
> > I realized that packed vqs are not being used in the test environment. I
> > see that in "hw/virtio/vhost-shadow-virtqueue.c", svq->is_packed is set
> > to 0 and that calls vhost_svq_add_split(). I am not sure how one enables
> > the packed feature bit. I don't know if this is an environment issue.
> >=20
> > I built qemu from the latest source with my changes on top of it. I
> > followed this article [1] to set up the environment.
> >=20
> > On the host machine:
> >=20
> > $ uname -a
> > Linux fedora 6.10.5-100.fc39.x86_64 #1 SMP PREEMPT_DYNAMIC Wed Aug 14
> > 15:49:25 UTC 2024 x86_64 GNU/Linux
> >=20
> > $ ./qemu/build/qemu-system-x86_64 --version
> > QEMU emulator version 9.0.91
> >=20
> > $ vdpa -V
> > vdpa utility, iproute2-6.4.0
> >=20
> > All the relevant vdpa modules have been loaded in accordance with [1].
> >=20
> > $ lsmod | grep -iE "(vdpa|virtio)"
> > vdpa_sim_net    12288  0
> > vdpa_sim                24576  1 vdpa_sim_net
> > vringh          32768  2 vdpa_sim,vdpa_sim_net
> > vhost_vdpa              32768  2
> > vhost           65536  1 vhost_vdpa
> > vhost_iotlb             16384  4 vdpa_sim,vringh,vhost_vdpa,vhost
> > vdpa            36864  3 vdpa_sim,vhost_vdpa,vdpa_sim_net
> >=20
> > $ ls -l /sys/bus/vdpa/devices/vdpa0/driver
> > lrwxrwxrwx. 1 root root 0 Aug 30 11:25 /sys/bus/vdpa/devices/vdpa0/driv=
er
> > -> ../../bus/vdpa/drivers/vhost_vdpa
> >=20
> > In the output of the following command, I see ANY_LAYOUT is supported.
> > According to virtio_config.h [2] in the linux kernel, this represents t=
he
> > layout of descriptors. This refers to split and packed vqs, right?
> >=20
> > $ vdpa mgmtdev show
> >=20
> > vdpasim_net:
> >   supported_classes net
> >   max_supported_vqs 3
> >   dev_features MTU MAC STATUS CTRL_VQ CTRL_MAC_ADDR ANY_LAYOUT VERSION_1
> >   ACCESS_PLATFORM>=20
> > $ vdpa dev show -jp
> > {
> >=20
> >     "dev": {
> >    =20
> >         "vdpa0": {
> >        =20
> >             "type": "network",
> >             "mgmtdev": "vdpasim_net",
> >             "vendor_id": 0,
> >             "max_vqs": 3,
> >             "max_vq_size": 256
> >        =20
> >         }
> >    =20
> >     }
> >=20
> > }
> >=20
> > I started the VM by running:
> >=20
> > $ sudo ./qemu/build/qemu-system-x86_64 \
> > -enable-kvm \
> > -drive file=3D//home/ig91/fedora_qemu_test_vm/L1.qcow2,media=3Ddisk,if=
=3Dvirtio
> > \
> > -net nic,model=3Dvirtio \
> > -net user,hostfwd=3Dtcp::2226-:22 \
> > -netdev type=3Dvhost-vdpa,vhostdev=3D/dev/vhost-vdpa-0,id=3Dvhost-vdpa0=
 \
> > -device
> > virtio-net-pci,netdev=3Dvhost-vdpa0,bus=3Dpci.0,addr=3D0x7,disable-lega=
cy=3Don,di
> > sable-modern=3Doff,page-per-vq=3Don,event_idx=3Doff,packed=3Don \ -nogr=
aphic \
> > -m 2G \
> > -smp 2 \
> > -cpu host \
> > 2>&1 | tee vm.log
> >=20
> > I added the packed=3Don option to -device virtio-net-pci.
> >=20
> > In the VM:
> >=20
> > # uname -a
> > Linux fedora 6.8.5-201.fc39.x86_64 #1 SMP PREEMPT_DYNAMIC Thu Apr 11
> > 18:25:26 UTC 2024 x86_64 GNU/Linux
> >=20
> > # lspci -nn | grep -i -A15 "\[1af4:1041\]"
> > 00:07.0 Ethernet controller [0200]: Red Hat, Inc. Virtio 1.0 network
> > device [1af4:1041] (rev 01)
> >=20
> > # cut -c 35 /sys/devices/pci0000:00/0000:00:07.0/virtio1/features
> > 0
> >=20
> > The packed vq feature bit hasn't been set. Am I missing something here?
>=20
> vdpa_sim does not support packed vq at the moment. You need to build
> the use case #3 of the second part of that blog [1]. It's good that
> you build the vdpa_sim earlier as it is a simpler setup.
>=20
> If you have problems with the vp_vdpa environment please let me know
> so we can find alternative setups.

Thank you for the clarification. I tried setting up the vp_vdpa
environment (scenario 3) but I ended up running into a problem
in the L1 VM.

I verified that nesting is enabled in KVM (L0):

$ grep -oE "(vmx|svm)" /proc/cpuinfo | sort | uniq
vmx

$ cat /sys/module/kvm_intel/parameters/nested
Y

There are no issues when booting L1. I start the VM by running:

$ sudo ./qemu/build/qemu-system-x86_64 \
=2Denable-kvm \
=2Ddrive file=3D//home/ig91/fedora_qemu_test_vm/L1.qcow2,media=3Ddisk,if=3D=
virtio \
=2Dnet nic,model=3Dvirtio \
=2Dnet user,hostfwd=3Dtcp::2222-:22 \
=2Ddevice intel-iommu,snoop-control=3Don \
=2Ddevice virtio-net-pci,netdev=3Dnet0,disable-legacy=3Don,disable-modern=
=3Doff,iommu_platform=3Don,event_idx=3Doff,packed=3Don,bus=3Dpcie.0,addr=3D=
0x4 \
=2Dnetdev tap,id=3Dnet0,script=3Dno,downscript=3Dno \
=2Dnographic \
=2Dm 2G \
=2Dsmp 2 \
=2DM q35 \
=2Dcpu host \
2>&1 | tee vm.log

Kernel version in L1:

# uname -a
Linux fedora 6.8.5-201.fc39.x86_64 #1 SMP PREEMPT_DYNAMIC Thu Apr 11 18:25:=
26 UTC 2024 x86_64 GNU/Linux

The following variables are set in the kernel's config as
described in the blog [1]:

CONFIG_VIRTIO_VDPA=3Dm
CONFIG_VDPA=3Dm
CONFIG_VP_VDPA=3Dm
CONFIG_VHOST_VDPA=3Dm

The vDPA tool also satisfies the version criterion.

# vdpa -V
vdpa utility, iproute2-6.10.0

I built QEMU from source with my changes on top of it.

# ./qemu/build/qemu-system-x86_64 --version
QEMU emulator version 9.0.91

The relevant vdpa modules are loaded successfully as
explained in the blog.

# lsmod | grep -i vdpa
vp_vdpa      	20480  0
vhost_vdpa	32768  0
vhost            	65536  1 vhost_vdpa
vhost_iotlb    16384  2 vhost_vdpa,vhost
vdpa               36864  2 vp_vdpa,vhost_vdpa
irqbypass   	12288  2 vhost_vdpa,kvm

# lspci | grep -i virtio
00:03.0 SCSI storage controller: Red Hat, Inc. Virtio block device
00:04.0 Ethernet controller: Red Hat, Inc. Virtio 1.0 network device (rev 0=
1)

# lspci -n |grep 00:04.0
00:04.0 0200: 1af4:1041 (rev 01)

I then unbind the virtio-pci device from the virtio-pci
driver and bind it to the vp_vdpa driver.

# echo 0000:00:04.0 > /sys/bus/pci/drivers/virtio-pci/unbind
# echo 1af4 1041 > /sys/bus/pci/drivers/vp-vdpa/new_id

I then create the vDPA device without any issues.

# vdpa mgmtdev show
pci/0000:00:04.0:=20
  supported_classes net
  max_supported_vqs 3
  dev_features CSUM GUEST_CSUM CTRL_GUEST_OFFLOADS MAC GUEST_TSO4 GUEST_TSO=
6 GUEST_ECN GUEST_UFO HOST_TSO4 HOST_TSO6 HOST_ECN HOST_UFO MRG_RXBUF STATU=
S CTRL_VQ CTRL_RX CTRL_VLAN CTRL_RX_EXTRA GUEST_ANNOUNCE CTRL_MAC_ADDR RING=
_INDIRECT_DE6

# vdpa dev add name vdpa0 mgmtdev pci/0000:00:04.0
# vdpa dev show -jp
{
    "dev": {
        "vdpa0": {
            "type": "network",
            "mgmtdev": "pci/0000:00:04.0",
            "vendor_id": 6900,
            "max_vqs": 3,
            "max_vq_size": 256
        }
    }
}

# ls -l /sys/bus/vdpa/devices/vdpa0/driver
lrwxrwxrwx. 1 root root 0 Sep  8 18:58 /sys/bus/vdpa/devices/vdpa0/driver -=
> ../../../../bus/vdpa/drivers/vhost_vdpa

# ls -l /dev/ |grep vdpa
crw-------. 1 root root    239,   0 Sep  8 18:58 vhost-vdpa-0

# driverctl -b vdpa list-devices
vdpa0 vhost_vdpa

I have a qcow2 image L2.qcow in L1. QEMU throws an error
when trying to launch L2.

# sudo ./qemu/build/qemu-system-x86_64 \
=2Denable-kvm \
=2Ddrive file=3D//root/L2.qcow2,media=3Ddisk,if=3Dvirtio \
=2Dnetdev type=3Dvhost-vdpa,vhostdev=3D/dev/vhost-vdpa-0,id=3Dvhost-vdpa0 \
=2Ddevice virtio-net-pci,netdev=3Dvhost-vdpa0,bus=3Dpcie.0,addr=3D0x7,disab=
le-legacy=3Don,disable-modern=3Doff,event_idx=3Doff,packed=3Don \
=2Dnographic \
=2Dm 2G \
=2Dsmp 2 \
=2DM q35 \
=2Dcpu host \
2>&1 | tee vm.log

qemu-system-x86_64: -netdev type=3Dvhost-vdpa,vhostdev=3D/dev/vhost-vdpa-0,=
id=3Dvhost-vdpa0: Could not open '/dev/vhost-vdpa-0': Unknown error 524

I get the same error when trying to launch L2 with qemu-kvm
which I installed using "dnf install".

# qemu-kvm --version
QEMU emulator version 8.1.3 (qemu-8.1.3-5.fc39)

The minimum version of QEMU required is v7.0.0-rc4.

According to "include/linux/errno.h" [2], errno 524 is
ENOTSUPP (operation is not supported). I am not sure
where I am going wrong.

However, I managed to set up scenario 4 successfully
and I see that packed vq is enabled in this case.

# cut -c 35 /sys/devices/pci0000:00/0000:00:04.0/virtio1/features
1

=46or the time being, shall I simply continue testing with
scenario 4?

> Thanks!
>=20
> [1]
> https://www.redhat.com/en/blog/hands-vdpa-what-do-you-do-when-you-aint-go=
t-
> hardware-part-2
> > Thanks,
> > Sahil
> >=20
> > [1]
> > https://www.redhat.com/en/blog/hands-vdpa-what-do-you-do-when-you-aint-=
go
> > t-hardware-part-1 [2]
> > https://github.com/torvalds/linux/blob/master/include/uapi/linux/virtio=
_c
> > onfig.h#L63

Thanks,
Sahil

[1] https://www.redhat.com/en/blog/hands-vdpa-what-do-you-do-when-you-aint-=
got-hardware-part-2
[2] https://github.com/torvalds/linux/blob/master/include/linux/errno.h#L27



