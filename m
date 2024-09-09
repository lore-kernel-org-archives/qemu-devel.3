Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 186B5ECE57A
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 12:36:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sndcD-00020b-Dx; Mon, 09 Sep 2024 08:35:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1sndcB-0001yq-Uk
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 08:35:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1sndc9-0000Sf-Cz
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 08:35:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725885327;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Do4vcB6e2lbVbQmsy5zwyRk2AujZCywh2UhuYIo4si0=;
 b=ShVbrDtWLb6Jilvuy6dxNQoGulweHg92aWBKr8XO4FVBYDWGU4m253Lz9RjqLjUNw5Dsdp
 WPcfaNHOEJ5QnxqofUQaPJmPdpmNFE1Puxo6mUvmwLI+h9NtHNAX+wW5kEh0Xc7aUq7Kew
 qxCizDWMv/S6fQ7LrEkka49qjW1FLMo=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-T8ZKDaMdO3OyhzbPbDKlSw-1; Mon, 09 Sep 2024 08:35:23 -0400
X-MC-Unique: T8ZKDaMdO3OyhzbPbDKlSw-1
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-6db791c41daso23401327b3.1
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 05:35:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725885323; x=1726490123;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Do4vcB6e2lbVbQmsy5zwyRk2AujZCywh2UhuYIo4si0=;
 b=pFgfh00GC5vpFBFLbJePybKHd4f9Sx6gacxT2Adr4nlTWmrbaG0Q88F5dujSX55QVd
 nz/lp8TOB6urWmpqhodLOxsLcWpiQYr19FZmdIa3drfoyuM1GEKyM+UnuSfYqMC7Ijl9
 IvcdxYc3TSEDJu5mYNKqXlVCs4e3lHWO16wmATp2O4u8ATzdLQz6adxFiiID4tcxdLN8
 xzzsZp6zeLGYPDISTbwZve5Is8H5rLClC4WdIvirBsD1tcDxjIdDVLMcAmb9L7zhtkfB
 AYAeQp3DscPqFyODT9OFKDAHKZiTums6nG2FYl140U8bvhLLaEnZRdtVuKgeZJSChuas
 6wgw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVvmhiAezr8SiC6QvQxcD+sjdnw0gYa/sTPePpQbNJJjPKgKtrZ0IKcvH3fIyud2fii4JhXCk05gB6a@nongnu.org
X-Gm-Message-State: AOJu0Ywis4iNSRRP42F4j2ecqrzFo0CWMg3UBiotnfVyqtBUw3m3XwyJ
 xoUoPPKrFwmrkf0g9+p2nik3aFm18svFcLyCHVxojfgcdApbYgNYUAwprMVsXirL6V9pyHqe6ow
 tFeJEExBhoFkMXJxXOyQOeFZEFscgw28qdm/oI+2rC+1pooIIfV7TK0q9LG9TkNuPuWaH+V0RN4
 9wJ6uCWRahXLEBSZKnCfVVEPMgIOk=
X-Received: by 2002:a05:690c:2a83:b0:6b0:39dd:48e with SMTP id
 00721157ae682-6db44f1b953mr68693907b3.27.1725885323223; 
 Mon, 09 Sep 2024 05:35:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGRwaoSbdcqvkkvDSj4R/57OeIxAiQX+hWJR3NpD7LNinfN6WvvgDWJiFebJKqQfOr9BoC70s6Wz9JaUDnnKRI=
X-Received: by 2002:a05:690c:2a83:b0:6b0:39dd:48e with SMTP id
 00721157ae682-6db44f1b953mr68693617b3.27.1725885322597; Mon, 09 Sep 2024
 05:35:22 -0700 (PDT)
MIME-Version: 1.0
References: <20240802112138.46831-1-sahilcdq@proton.me>
 <2620452.Lt9SDvczpP@valdaarhun>
 <CAJaqyWdno3yzuxpCMQN1CyLTt1SOv+oHHwB0Jze28gGqLicscQ@mail.gmail.com>
 <9355562.CDJkKcVGEf@valdaarhun>
In-Reply-To: <9355562.CDJkKcVGEf@valdaarhun>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 9 Sep 2024 14:34:45 +0200
Message-ID: <CAJaqyWdFB=UfxV8LNoajP2+CC=8h98Wuow6oaiHcfjU8d69hpg@mail.gmail.com>
Subject: Re: [RFC v3 3/3] vhost: Allocate memory for packed vring
To: Sahil <icegambit91@gmail.com>
Cc: sgarzare@redhat.com, mst@redhat.com, qemu-devel@nongnu.org, 
 Sahil Siddiq <sahilcdq@proton.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Sun, Sep 8, 2024 at 9:47=E2=80=AFPM Sahil <icegambit91@gmail.com> wrote:
>
> Hi,
>
> On Friday, August 30, 2024 4:18:31=E2=80=AFPM GMT+5:30 Eugenio Perez Mart=
in wrote:
> > On Fri, Aug 30, 2024 at 12:20=E2=80=AFPM Sahil <icegambit91@gmail.com> =
wrote:
> > > Hi,
> > >
> > > On Tuesday, August 27, 2024 9:00:36=E2=80=AFPM GMT+5:30 Eugenio Perez=
 Martin wrote:
> > > > On Wed, Aug 21, 2024 at 2:20=E2=80=AFPM Sahil <icegambit91@gmail.co=
m> wrote:
> > > > > [...]
> > > > > I have been trying to test my changes so far as well. I am not ve=
ry
> > > > > clear
> > > > > on a few things.
> > > > >
> > > > > Q1.
> > > > > I built QEMU from source with my changes and followed the vdpa_si=
m +
> > > > > vhost_vdpa tutorial [1]. The VM seems to be running fine. How do =
I
> > > > > check
> > > > > if the packed format is being used instead of the split vq format=
 for
> > > > > shadow virtqueues? I know the packed format is used when virtio_v=
dev
> > > > > has
> > > > > got the VIRTIO_F_RING_PACKED bit enabled. Is there a way of check=
ing
> > > > > that
> > > > > this is the case?
> > > >
> > > > You can see the features that the driver acked from the guest by
> > > > checking sysfs. Once you know the PCI BFN from lspci:
> > > > # lspci -nn|grep '\[1af4:1041\]'
> > > > 01:00.0 Ethernet controller [0200]: Red Hat, Inc. Virtio 1.0 networ=
k
> > > > device [1af4:1041] (rev 01)
> > > > # cut -c 35
> > > > /sys/devices/pci0000:00/0000:00:02.0/0000:01:00.0/virtio0/features =
0
> > > >
> > > > Also, you can check from QEMU by simply tracing if your functions a=
re
> > > > being called.
> > > >
> > > > > Q2.
> > > > > What's the recommended way to see what's going on under the hood?=
 I
> > > > > tried
> > > > > using the -D option so QEMU's logs are written to a file but the =
file
> > > > > was
> > > > > empty. Would using qemu with -monitor stdio or attaching gdb to t=
he
> > > > > QEMU
> > > > > VM be worthwhile?
> > > >
> > > > You need to add --trace options with the regex you want to get to
> > > > enable any output. For example, --trace 'vhost_vdpa_*' print all th=
e
> > > > trace_vhost_vdpa_* functions.
> > > >
> > > > If you want to speed things up, you can just replace the interestin=
g
> > > > trace_... functions with fprintf(stderr, ...). We can add the trace
> > > > ones afterwards.
> > >
> > > Understood. I am able to trace the functions that are being called wi=
th
> > > fprintf. I'll stick with fprintf for now.
> > >
> > > I realized that packed vqs are not being used in the test environment=
. I
> > > see that in "hw/virtio/vhost-shadow-virtqueue.c", svq->is_packed is s=
et
> > > to 0 and that calls vhost_svq_add_split(). I am not sure how one enab=
les
> > > the packed feature bit. I don't know if this is an environment issue.
> > >
> > > I built qemu from the latest source with my changes on top of it. I
> > > followed this article [1] to set up the environment.
> > >
> > > On the host machine:
> > >
> > > $ uname -a
> > > Linux fedora 6.10.5-100.fc39.x86_64 #1 SMP PREEMPT_DYNAMIC Wed Aug 14
> > > 15:49:25 UTC 2024 x86_64 GNU/Linux
> > >
> > > $ ./qemu/build/qemu-system-x86_64 --version
> > > QEMU emulator version 9.0.91
> > >
> > > $ vdpa -V
> > > vdpa utility, iproute2-6.4.0
> > >
> > > All the relevant vdpa modules have been loaded in accordance with [1]=
.
> > >
> > > $ lsmod | grep -iE "(vdpa|virtio)"
> > > vdpa_sim_net    12288  0
> > > vdpa_sim                24576  1 vdpa_sim_net
> > > vringh          32768  2 vdpa_sim,vdpa_sim_net
> > > vhost_vdpa              32768  2
> > > vhost           65536  1 vhost_vdpa
> > > vhost_iotlb             16384  4 vdpa_sim,vringh,vhost_vdpa,vhost
> > > vdpa            36864  3 vdpa_sim,vhost_vdpa,vdpa_sim_net
> > >
> > > $ ls -l /sys/bus/vdpa/devices/vdpa0/driver
> > > lrwxrwxrwx. 1 root root 0 Aug 30 11:25 /sys/bus/vdpa/devices/vdpa0/dr=
iver
> > > -> ../../bus/vdpa/drivers/vhost_vdpa
> > >
> > > In the output of the following command, I see ANY_LAYOUT is supported=
.
> > > According to virtio_config.h [2] in the linux kernel, this represents=
 the
> > > layout of descriptors. This refers to split and packed vqs, right?
> > >
> > > $ vdpa mgmtdev show
> > >
> > > vdpasim_net:
> > >   supported_classes net
> > >   max_supported_vqs 3
> > >   dev_features MTU MAC STATUS CTRL_VQ CTRL_MAC_ADDR ANY_LAYOUT VERSIO=
N_1
> > >   ACCESS_PLATFORM>
> > > $ vdpa dev show -jp
> > > {
> > >
> > >     "dev": {
> > >
> > >         "vdpa0": {
> > >
> > >             "type": "network",
> > >             "mgmtdev": "vdpasim_net",
> > >             "vendor_id": 0,
> > >             "max_vqs": 3,
> > >             "max_vq_size": 256
> > >
> > >         }
> > >
> > >     }
> > >
> > > }
> > >
> > > I started the VM by running:
> > >
> > > $ sudo ./qemu/build/qemu-system-x86_64 \
> > > -enable-kvm \
> > > -drive file=3D//home/ig91/fedora_qemu_test_vm/L1.qcow2,media=3Ddisk,i=
f=3Dvirtio
> > > \
> > > -net nic,model=3Dvirtio \
> > > -net user,hostfwd=3Dtcp::2226-:22 \
> > > -netdev type=3Dvhost-vdpa,vhostdev=3D/dev/vhost-vdpa-0,id=3Dvhost-vdp=
a0 \
> > > -device
> > > virtio-net-pci,netdev=3Dvhost-vdpa0,bus=3Dpci.0,addr=3D0x7,disable-le=
gacy=3Don,di
> > > sable-modern=3Doff,page-per-vq=3Don,event_idx=3Doff,packed=3Don \ -no=
graphic \
> > > -m 2G \
> > > -smp 2 \
> > > -cpu host \
> > > 2>&1 | tee vm.log
> > >
> > > I added the packed=3Don option to -device virtio-net-pci.
> > >
> > > In the VM:
> > >
> > > # uname -a
> > > Linux fedora 6.8.5-201.fc39.x86_64 #1 SMP PREEMPT_DYNAMIC Thu Apr 11
> > > 18:25:26 UTC 2024 x86_64 GNU/Linux
> > >
> > > # lspci -nn | grep -i -A15 "\[1af4:1041\]"
> > > 00:07.0 Ethernet controller [0200]: Red Hat, Inc. Virtio 1.0 network
> > > device [1af4:1041] (rev 01)
> > >
> > > # cut -c 35 /sys/devices/pci0000:00/0000:00:07.0/virtio1/features
> > > 0
> > >
> > > The packed vq feature bit hasn't been set. Am I missing something her=
e?
> >
> > vdpa_sim does not support packed vq at the moment. You need to build
> > the use case #3 of the second part of that blog [1]. It's good that
> > you build the vdpa_sim earlier as it is a simpler setup.
> >
> > If you have problems with the vp_vdpa environment please let me know
> > so we can find alternative setups.
>
> Thank you for the clarification. I tried setting up the vp_vdpa
> environment (scenario 3) but I ended up running into a problem
> in the L1 VM.
>
> I verified that nesting is enabled in KVM (L0):
>
> $ grep -oE "(vmx|svm)" /proc/cpuinfo | sort | uniq
> vmx
>
> $ cat /sys/module/kvm_intel/parameters/nested
> Y
>
> There are no issues when booting L1. I start the VM by running:
>
> $ sudo ./qemu/build/qemu-system-x86_64 \
> -enable-kvm \
> -drive file=3D//home/ig91/fedora_qemu_test_vm/L1.qcow2,media=3Ddisk,if=3D=
virtio \
> -net nic,model=3Dvirtio \
> -net user,hostfwd=3Dtcp::2222-:22 \
> -device intel-iommu,snoop-control=3Don \
> -device virtio-net-pci,netdev=3Dnet0,disable-legacy=3Don,disable-modern=
=3Doff,iommu_platform=3Don,event_idx=3Doff,packed=3Don,bus=3Dpcie.0,addr=3D=
0x4 \
> -netdev tap,id=3Dnet0,script=3Dno,downscript=3Dno \
> -nographic \
> -m 2G \
> -smp 2 \
> -M q35 \
> -cpu host \
> 2>&1 | tee vm.log
>
> Kernel version in L1:
>
> # uname -a
> Linux fedora 6.8.5-201.fc39.x86_64 #1 SMP PREEMPT_DYNAMIC Thu Apr 11 18:2=
5:26 UTC 2024 x86_64 GNU/Linux
>

Did you run the kernels with the arguments "iommu=3Dpt intel_iommu=3Don"?
You can print them with cat /proc/cmdline.

> The following variables are set in the kernel's config as
> described in the blog [1]:
>
> CONFIG_VIRTIO_VDPA=3Dm
> CONFIG_VDPA=3Dm
> CONFIG_VP_VDPA=3Dm
> CONFIG_VHOST_VDPA=3Dm
>
> The vDPA tool also satisfies the version criterion.
>
> # vdpa -V
> vdpa utility, iproute2-6.10.0
>
> I built QEMU from source with my changes on top of it.
>
> # ./qemu/build/qemu-system-x86_64 --version
> QEMU emulator version 9.0.91
>
> The relevant vdpa modules are loaded successfully as
> explained in the blog.
>
> # lsmod | grep -i vdpa
> vp_vdpa         20480  0
> vhost_vdpa      32768  0
> vhost                   65536  1 vhost_vdpa
> vhost_iotlb    16384  2 vhost_vdpa,vhost
> vdpa               36864  2 vp_vdpa,vhost_vdpa
> irqbypass       12288  2 vhost_vdpa,kvm
>
> # lspci | grep -i virtio
> 00:03.0 SCSI storage controller: Red Hat, Inc. Virtio block device
> 00:04.0 Ethernet controller: Red Hat, Inc. Virtio 1.0 network device (rev=
 01)
>
> # lspci -n |grep 00:04.0
> 00:04.0 0200: 1af4:1041 (rev 01)
>
> I then unbind the virtio-pci device from the virtio-pci
> driver and bind it to the vp_vdpa driver.
>
> # echo 0000:00:04.0 > /sys/bus/pci/drivers/virtio-pci/unbind
> # echo 1af4 1041 > /sys/bus/pci/drivers/vp-vdpa/new_id
>
> I then create the vDPA device without any issues.
>
> # vdpa mgmtdev show
> pci/0000:00:04.0:
>   supported_classes net
>   max_supported_vqs 3
>   dev_features CSUM GUEST_CSUM CTRL_GUEST_OFFLOADS MAC GUEST_TSO4 GUEST_T=
SO6 GUEST_ECN GUEST_UFO HOST_TSO4 HOST_TSO6 HOST_ECN HOST_UFO MRG_RXBUF STA=
TUS CTRL_VQ CTRL_RX CTRL_VLAN CTRL_RX_EXTRA GUEST_ANNOUNCE CTRL_MAC_ADDR RI=
NG_INDIRECT_DE6
>
> # vdpa dev add name vdpa0 mgmtdev pci/0000:00:04.0
> # vdpa dev show -jp
> {
>     "dev": {
>         "vdpa0": {
>             "type": "network",
>             "mgmtdev": "pci/0000:00:04.0",
>             "vendor_id": 6900,
>             "max_vqs": 3,
>             "max_vq_size": 256
>         }
>     }
> }
>
> # ls -l /sys/bus/vdpa/devices/vdpa0/driver
> lrwxrwxrwx. 1 root root 0 Sep  8 18:58 /sys/bus/vdpa/devices/vdpa0/driver=
 -> ../../../../bus/vdpa/drivers/vhost_vdpa
>
> # ls -l /dev/ |grep vdpa
> crw-------. 1 root root    239,   0 Sep  8 18:58 vhost-vdpa-0
>
> # driverctl -b vdpa list-devices
> vdpa0 vhost_vdpa
>
> I have a qcow2 image L2.qcow in L1. QEMU throws an error
> when trying to launch L2.
>
> # sudo ./qemu/build/qemu-system-x86_64 \
> -enable-kvm \
> -drive file=3D//root/L2.qcow2,media=3Ddisk,if=3Dvirtio \
> -netdev type=3Dvhost-vdpa,vhostdev=3D/dev/vhost-vdpa-0,id=3Dvhost-vdpa0 \
> -device virtio-net-pci,netdev=3Dvhost-vdpa0,bus=3Dpcie.0,addr=3D0x7,disab=
le-legacy=3Don,disable-modern=3Doff,event_idx=3Doff,packed=3Don \
> -nographic \
> -m 2G \
> -smp 2 \
> -M q35 \
> -cpu host \
> 2>&1 | tee vm.log
>
> qemu-system-x86_64: -netdev type=3Dvhost-vdpa,vhostdev=3D/dev/vhost-vdpa-=
0,id=3Dvhost-vdpa0: Could not open '/dev/vhost-vdpa-0': Unknown error 524
>
> I get the same error when trying to launch L2 with qemu-kvm
> which I installed using "dnf install".
>
> # qemu-kvm --version
> QEMU emulator version 8.1.3 (qemu-8.1.3-5.fc39)
>
> The minimum version of QEMU required is v7.0.0-rc4.
>
> According to "include/linux/errno.h" [2], errno 524 is
> ENOTSUPP (operation is not supported). I am not sure
> where I am going wrong.
>
> However, I managed to set up scenario 4 successfully
> and I see that packed vq is enabled in this case.
>
> # cut -c 35 /sys/devices/pci0000:00/0000:00:04.0/virtio1/features
> 1
>
> For the time being, shall I simply continue testing with
> scenario 4?
>
> > Thanks!
> >
> > [1]
> > https://www.redhat.com/en/blog/hands-vdpa-what-do-you-do-when-you-aint-=
got-
> > hardware-part-2
> > > Thanks,
> > > Sahil
> > >
> > > [1]
> > > https://www.redhat.com/en/blog/hands-vdpa-what-do-you-do-when-you-ain=
t-go
> > > t-hardware-part-1 [2]
> > > https://github.com/torvalds/linux/blob/master/include/uapi/linux/virt=
io_c
> > > onfig.h#L63
>
> Thanks,
> Sahil
>
> [1] https://www.redhat.com/en/blog/hands-vdpa-what-do-you-do-when-you-ain=
t-got-hardware-part-2
> [2] https://github.com/torvalds/linux/blob/master/include/linux/errno.h#L=
27
>
>


