Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5F01EEB582
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 09:56:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sogXi-0001sI-2e; Thu, 12 Sep 2024 05:55:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1sogXf-0001rj-V5
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 05:55:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1sogXc-0006lF-K4
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 05:55:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726134905;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LaUP1IFw6sSo124hoNn8s+RyeJ17BILV9+y+FlVqXyE=;
 b=hnqOCcg5/1ZHhUeMOS/1cPwNH/8lI1gzUo2FD++i6OnXss2GVsCEgLRHchFMRO5JF1j+Aa
 YV8NPIHxoSD8pr8Fp92RAB+O1cNnbT6OelqfKSgV7lrSrsNIENzJ9z4io6+fi1PZBh04mE
 Fy6nXeyYdglZgMmpj6GpYfVKwqnNNIQ=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-205-AHrQiejiMiixHHIqJoIsfw-1; Thu, 12 Sep 2024 05:55:04 -0400
X-MC-Unique: AHrQiejiMiixHHIqJoIsfw-1
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-6886cd07673so21366847b3.3
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2024 02:55:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726134904; x=1726739704;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LaUP1IFw6sSo124hoNn8s+RyeJ17BILV9+y+FlVqXyE=;
 b=Womyjup5vDrl74HgcpDlk+1h2UjBNpabYApcC8SG8vjP6eoQ0FFH5mjuQCzHpyTytx
 i50akm4ubBlt0QOiHVstR61l8tU9rfWxJVu7OtkF3229K3UXkoaarQybicynnehkFM9r
 idJytPCxxHSds+CMyAuuPYLLUXo1uh4ea/rDUOQAG+EaQhI2D82/nhoJQFP7cZTme+L6
 DnwK+f76Tiqlbi+nA0awFJAZKQWIS0tlR+EQRCwaBMsYu7lRVwu9jKBnRylPAl3tn0Q7
 16EqkSYFUFsCSSBF6Z460xyq8Q572bC2gOYkP7Nj/ti3VK8zmRu8ezZdqolhvSN/DTLY
 dqRg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV9uQJL3xHITpAmBYNd9dC5QeDw7c1oQYHfo3/sUJpqperCy3h0bjqGZS+i+59XC6mXmmKAeFgJTCSB@nongnu.org
X-Gm-Message-State: AOJu0YzvFI/bCXgJVFLiK9oIi2ChY7kW4SxsVhxyHuZKsCZNdPQ6x544
 lgXvJayDZgBN5fYlesE601P+87hiy663Slv8knnMb0zvBNXAsLPpQrzi1RHz71qfWiIebYYcf7j
 faUNmOheCJrBOZzDrQ+RG+lqd5k/0ATnxuYCROvdd5gAyFrchpx6sEVVrqMiHgrXdxIlYbTqmSd
 L5J92F4VMyCtgMO8myOn0ldeykz3c=
X-Received: by 2002:a05:690c:2c85:b0:6d9:c367:5486 with SMTP id
 00721157ae682-6dbb6bb923bmr18074517b3.42.1726134903655; 
 Thu, 12 Sep 2024 02:55:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFDkHZjOtaCfmJPuq6Q9ILL7jnJUq3Iuwt0QK9ohNZIsYU9djE6wVQsh04typ0IxOr/bLZlGu3RwjgsJ1AdK+c=
X-Received: by 2002:a05:690c:2c85:b0:6d9:c367:5486 with SMTP id
 00721157ae682-6dbb6bb923bmr18074417b3.42.1726134903316; Thu, 12 Sep 2024
 02:55:03 -0700 (PDT)
MIME-Version: 1.0
References: <20240802112138.46831-1-sahilcdq@proton.me>
 <9355562.CDJkKcVGEf@valdaarhun>
 <CAJaqyWdFB=UfxV8LNoajP2+CC=8h98Wuow6oaiHcfjU8d69hpg@mail.gmail.com>
 <1803917.VLH7GnMWUR@valdaarhun>
In-Reply-To: <1803917.VLH7GnMWUR@valdaarhun>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 12 Sep 2024 11:54:27 +0200
Message-ID: <CAJaqyWeCYrMW8zbLh=kHx_qQWAdXyR8oGpDgfopNeBabXrPovA@mail.gmail.com>
Subject: Re: [RFC v3 3/3] vhost: Allocate memory for packed vring
To: Sahil <icegambit91@gmail.com>
Cc: sgarzare@redhat.com, mst@redhat.com, qemu-devel@nongnu.org, 
 Sahil Siddiq <sahilcdq@proton.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Wed, Sep 11, 2024 at 9:36=E2=80=AFPM Sahil <icegambit91@gmail.com> wrote=
:
>
> Hi,
>
> On Monday, September 9, 2024 6:04:45=E2=80=AFPM GMT+5:30 Eugenio Perez Ma=
rtin wrote:
> > On Sun, Sep 8, 2024 at 9:47=E2=80=AFPM Sahil <icegambit91@gmail.com> wr=
ote:
> > > On Friday, August 30, 2024 4:18:31=E2=80=AFPM GMT+5:30 Eugenio Perez =
Martin wrote:
> > > > On Fri, Aug 30, 2024 at 12:20=E2=80=AFPM Sahil <icegambit91@gmail.c=
om> wrote:
> > > > [...]
> > > > vdpa_sim does not support packed vq at the moment. You need to buil=
d
> > > > the use case #3 of the second part of that blog [1]. It's good that
> > > > you build the vdpa_sim earlier as it is a simpler setup.
> > > >
> > > > If you have problems with the vp_vdpa environment please let me kno=
w
> > > > so we can find alternative setups.
> > >
> > > Thank you for the clarification. I tried setting up the vp_vdpa
> > > environment (scenario 3) but I ended up running into a problem
> > > in the L1 VM.
> > >
> > > I verified that nesting is enabled in KVM (L0):
> > >
> > > $ grep -oE "(vmx|svm)" /proc/cpuinfo | sort | uniq
> > > vmx
> > >
> > > $ cat /sys/module/kvm_intel/parameters/nested
> > > Y
> > >
> > > There are no issues when booting L1. I start the VM by running:
> > >
> > > $ sudo ./qemu/build/qemu-system-x86_64 \
> > > -enable-kvm \
> > > -drive file=3D//home/ig91/fedora_qemu_test_vm/L1.qcow2,media=3Ddisk,i=
f=3Dvirtio
> > > \
> > > -net nic,model=3Dvirtio \
> > > -net user,hostfwd=3Dtcp::2222-:22 \
> > > -device intel-iommu,snoop-control=3Don \
> > > -device
> > > virtio-net-pci,netdev=3Dnet0,disable-legacy=3Don,disable-modern=3Doff=
,iommu_pla
> > > tform=3Don,event_idx=3Doff,packed=3Don,bus=3Dpcie.0,addr=3D0x4 \ -net=
dev
> > > tap,id=3Dnet0,script=3Dno,downscript=3Dno \
> > > -nographic \
> > > -m 2G \
> > > -smp 2 \
> > > -M q35 \
> > > -cpu host \
> > > 2>&1 | tee vm.log
> > >
> > > Kernel version in L1:
> > >
> > > # uname -a
> > > Linux fedora 6.8.5-201.fc39.x86_64 #1 SMP PREEMPT_DYNAMIC Thu Apr 11
> > > 18:25:26 UTC 2024 x86_64 GNU/Linux
> > Did you run the kernels with the arguments "iommu=3Dpt intel_iommu=3Don=
"?
> > You can print them with cat /proc/cmdline.
>
> I missed this while setting up the environment. After setting the kernel
> params I managed to move past this issue but my environment in virtualbox
> was very unstable and it kept crashing.
>

I've no experience with virtualbox+vdpa, sorry :). Why not use QEMU also fo=
r L1?

> I managed to get L1 to run on my host OS, so scenario 3 is now up and
> running. However, the packed bit seems to be disabled in this scenario to=
o.
>
> L0 (host machine) specs:
> - kernel version:
>   6.6.46-1-lts
>
> - QEMU version:
>   9.0.50 (v8.2.0-5536-g16514611dc)
>
> - vDPA version:
>   iproute2-6.10.0
>
> L1 specs:
>
> - kernel version:
>   6.8.5-201.fc39.x86_64
>
> - QEMU version:
>   9.0.91
>
> - vDPA version:
>   iproute2-6.10.0
>
> L2 specs:
> - kernel version
>   6.8.7-200.fc39.x86_64
>
> I followed the following steps to set up scenario 3:
>
> =3D=3D=3D=3D In L0 =3D=3D=3D=3D
>
> $ grep -oE "(vmx|svm)" /proc/cpuinfo | sort | uniq
> vmx
>
> $ cat /sys/module/kvm_intel/parameters/nested
> Y
>
> $ sudo ./qemu/build/qemu-system-x86_64 \
> -enable-kvm \
> -drive file=3D//home/valdaarhun/valdaarhun/qcow2_img/L1.qcow2,media=3Ddis=
k,if=3Dvirtio \
> -net nic,model=3Dvirtio \
> -net user,hostfwd=3Dtcp::2222-:22 \
> -device intel-iommu,snoop-control=3Don \
> -device virtio-net-pci,netdev=3Dnet0,disable-legacy=3Don,disable-modern=
=3Doff,iommu_platform=3Don,event_idx=3Doff,packed=3Don,bus=3Dpcie.0,addr=3D=
0x4 \
> -netdev tap,id=3Dnet0,script=3Dno,downscript=3Dno \
> -nographic \
> -m 8G \
> -smp 4 \
> -M q35 \
> -cpu host \
> 2>&1 | tee vm.log
>
> =3D=3D=3D=3D In L1 =3D=3D=3D=3D
>
> I verified that the following config variables are set as decribed in the=
 blog [1].
>
> CONFIG_VIRTIO_VDPA=3Dm
> CONFIG_VDPA=3Dm
> CONFIG_VP_VDPA=3Dm
> CONFIG_VHOST_VDPA=3Dm
>
> # modprobe vdpa
> # modprobe vhost_vdpa
> # modprobe vp_vdpa
>
> # lsmod | grep -i vdpa
> vp_vdpa                 20480  0
> vhost_vdpa              32768  0
> vhost                   65536  1 vhost_vdpa
> vhost_iotlb             16384  2 vhost_vdpa,vhost
> vdpa                    36864  2 vp_vdpa,vhost_vdpa
> irqbypass               12288  2 vhost_vdpa,kvm
>
> # lspci | grep -i ethernet
> 00:04.0 Ethernet controller: Red Hat, Inc. Virtio 1.0 network device (rev=
 01)
>
> # lspci -nn | grep 00:04.0
> 00:04.0 Ethernet controller [0200]: Red Hat, Inc. Virtio 1.0 network devi=
ce [1af4:1041] (rev 01)
>
> # echo 0000:00:04.0 > /sys/bus/pci/drivers/virtio-pci/unbind
> # echo 1af4 1041 > /sys/bus/pci/drivers/vp-vdpa/new_id
>
> # vdpa mgmtdev show
> pci/0000:00:04.0:
>   supported_classes net < unknown class >
>   max_supported_vqs 3
>   dev_features  CSUM  GUEST_CSUM  CTRL_GUEST_OFFLOADS  MAC  GUEST_TSO4
>   GUEST_TSO6  GUEST_ECN  GUEST_UFO  HOST_TSO4  HOST_TSO6  HOST_ECN
>   HOST_UFO  MRG_RXBUF  STATUS  CTRL_VQ  CTRL_RX  CTRL_VLAN  CTRL_RX_EXTRA
>   GUEST_ANNOUNCE  CTRL_MAC_ADDR  RING_INDIRECT_DESC  RING_EVENT_IDX
>   VERSION_1  ACCESS_PLATFORM  bit_40  bit_54  bit_55  bit_56
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
> lrwxrwxrwx. 1 root root 0 Sep 11 17:07 /sys/bus/vdpa/devices/vdpa0/driver=
 -> ../../../../bus/vdpa/drivers/vhost_vdpa
>
> # ls -l /dev/ |grep vdpa
> crw-------. 1 root root    239,   0 Sep 11 17:07 vhost-vdpa-0
>
> # driverctl -b vdpa
> vdpa0 vhost_vdpa [*]
>
> Booting L2:
>
> # ./qemu/build/qemu-system-x86_64 \
> -nographic \
> -m 4G \
> -enable-kvm \
> -M q35 \
> -drive file=3D//root/L2.qcow2,media=3Ddisk,if=3Dvirtio \
> -netdev type=3Dvhost-vdpa,vhostdev=3D/dev/vhost-vdpa-0,id=3Dvhost-vdpa0 \
> -device virtio-net-pci,netdev=3Dvhost-vdpa0,disable-legacy=3Don,disable-m=
odern=3Doff,event_idx=3Doff,packed=3Don,bus=3Dpcie.0,addr=3D0x7 \
> -smp 4 \
> -cpu host \
> 2>&1 | tee vm.log
>
> =3D=3D=3D=3D In L2 =3D=3D=3D=3D
>
> # cut -c 35 /sys/devices/pci0000:00/0000:00:07.0/virtio1/features
> 0
>
> Based on what I have understood from the kernel's source, vhost-vdpa and
> vp-vdpa both support packed vqs and v6.6.46 is more recent than the
> minimum required kernel version. I am not sure where I am going wrong.
>
> > > However, I managed to set up scenario 4 successfully
> > > and I see that packed vq is enabled in this case.
> > >
> > > # cut -c 35 /sys/devices/pci0000:00/0000:00:04.0/virtio1/features
> > > 1
>
> So far scenario 4 is the only scenario where the virtio-net device has th=
e packed
> feature enabled. The difference between scenarios 3 and 4 in terms of the=
 kernel
> modules loaded is that scenario 4 uses virtio_vdpa while scenario 3 uses =
vdpa and
> vhost_vdpa.
>

We're pretty close then :). But I don't see anything obviously wrong here.

I guess it is the same L1 VM in both cases, isn't it?

The function that gets the features from vhost-vdpa in QEMU is
hw/virtio/vhost-vdpa.c:vhost_vdpa_get_features. Can you check that it
returns bit 34 (offset starts with 0 here)? If it returns it, can you
keep debugging until you see what clears it?

If it comes clear, then we need to check the kernel.

If you don't see anything wrong there, we can keep debugging the
function that handles getting the features through L2 guest PCI read,
hw/virtio/virtio-pci.c:virtio_pci_common_read. VIRTIO_PCI_COMMON_DF
case when proxy->dfselect=3D=3D1.

Let me know what you find.

Thanks!


