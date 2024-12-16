Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC1EFE7717F
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 08:41:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tN6fO-0005Aj-LQ; Mon, 16 Dec 2024 03:41:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1tN6fM-0005AW-Kb
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 03:41:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1tN6fJ-0005V2-9j
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 03:41:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734338478;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lZV9wJfq8bwEaBo1TJGTyekiDP6vHQeabLmaw5Ewc5s=;
 b=K+IoQ68KTKXwp9HYDZDz/Cd3VRIiLeAaVBGxg9475Kk0NOPzuUClrclhnfiHL2e4H3RS5M
 nF81qMK/aG0ocgJsn7840IA8eahNIc1Fnxm3HnHMdsf1u7+LXSOCKRtyBXVvtFmQTKT5nr
 VPdmhjhDG5h5ajJYk6s/SR7HpAKkcpM=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-157-DkHkdDo8NbGU0r14wbuQXw-1; Mon, 16 Dec 2024 03:40:09 -0500
X-MC-Unique: DkHkdDo8NbGU0r14wbuQXw-1
X-Mimecast-MFC-AGG-ID: DkHkdDo8NbGU0r14wbuQXw
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-6effbb8ca1fso46391347b3.1
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2024 00:40:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734338409; x=1734943209;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lZV9wJfq8bwEaBo1TJGTyekiDP6vHQeabLmaw5Ewc5s=;
 b=BAG64F9nkV8OPNdCWDM6JrbqDp1q7YrdlObWJkzeravYr3MrmJRAT6pEipySc/60qs
 PNPP37GOVtnv6ng12tGP1KCPEvejf5dlD+29goRa9WirZpxlVRiRiGPZrZm7oNbXzoex
 bA/XvdhfjtTzXtWh9RhKtweULgdx3Ns0fapWMtNfWgKiN5xO+meVea/nNQs/OKJKLLy1
 djR5XWDhKjcgzxPAQ0C8/R1jZ+U+zNKpMqMSt2jL6d736AprM3NqXpOFZTnK9RtxJqzL
 qCvKROSJdNVFfXBCNJig7km8nohmK99d8L7fz+jKluuMZTFTlBNYV+4qk9o7cIrQOR4w
 UR7A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWB06hGWTkEnaQxsw5MbkNfZMZdQb32uCI5WR/DzVkWYtIEfFOeHa2fXNUebBtJLr1WDT80ekA1iW1N@nongnu.org
X-Gm-Message-State: AOJu0YxJ+/ANprNw+ktqyCO4MGs1rj1yR3jwACwWdSZAgUbM34TLng5u
 ZjCog9NIe6Zzy0ryfHWaAFr6DvKBNzXmgPEuL6kuq+Eyp24V+c9Hh4wSHfH+g4E8b8TGhGI2oK+
 Li1cdGqb0wuRvMGvGuLW/E5I/dc8ugtB04VtQATRTF4OGiirLbzlGVrj6gFVjldLWG7OzIjOnrb
 1bMPpZjiw+7Aj6MhDlWyjDlpE/xdo=
X-Gm-Gg: ASbGncuKZPxizIDLUWeMq2W9tcHLhJ1Q5iwRkXPiIp3W8hi8JJmfSmP4CulfNBN3MhL
 tHR9n5UyddKEtllRyRv7FbozZbS9gAhFk2wSfvw==
X-Received: by 2002:a05:690c:680d:b0:6ef:a53e:8e3e with SMTP id
 00721157ae682-6f279adc0a7mr98892817b3.9.1734338408838; 
 Mon, 16 Dec 2024 00:40:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHmTat7ku0jjh7y6jVkEoRuTLegVBasNChg4KBoOjNbmyofcx/QvEBroNZedRO1pvJQeAMjyWaFsJFmlN5s7MM=
X-Received: by 2002:a05:690c:680d:b0:6ef:a53e:8e3e with SMTP id
 00721157ae682-6f279adc0a7mr98892717b3.9.1734338408448; Mon, 16 Dec 2024
 00:40:08 -0800 (PST)
MIME-Version: 1.0
References: <20241205203430.76251-1-sahilcdq@proton.me>
 <CAJaqyWerdWk5S0Sxt4oMUCc8FQJTxopyvhtyOV6ocbXmJ_p7Dw@mail.gmail.com>
 <f95a9e51-6aa1-4aeb-959e-99e9b31109be@gmail.com>
In-Reply-To: <f95a9e51-6aa1-4aeb-959e-99e9b31109be@gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 16 Dec 2024 09:39:32 +0100
Message-ID: <CAJaqyWdx6GGrQ8-Pm9k9jE11djdk3B1OHda+uGTQqYbq5tyX7w@mail.gmail.com>
Subject: Re: [RFC v4 0/5] Add packed virtqueue to shadow virtqueue
To: Sahil Siddiq <icegambit91@gmail.com>
Cc: sgarzare@redhat.com, mst@redhat.com, qemu-devel@nongnu.org, 
 Sahil Siddiq <sahilcdq@proton.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.168,
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

On Sun, Dec 15, 2024 at 6:27=E2=80=AFPM Sahil Siddiq <icegambit91@gmail.com=
> wrote:
>
> Hi,
>
> On 12/10/24 2:57 PM, Eugenio Perez Martin wrote:
> > On Thu, Dec 5, 2024 at 9:34=E2=80=AFPM Sahil Siddiq <icegambit91@gmail.=
com> wrote:
> >>
> >> Hi,
> >>
> >> There are two issues that I found while trying to test
> >> my changes. I thought I would send the patch series
> >> as well in case that helps in troubleshooting. I haven't
> >> been able to find an issue in the implementation yet.
> >> Maybe I am missing something.
> >>
> >> I have been following the "Hands on vDPA: what do you do
> >> when you ain't got the hardware v2 (Part 2)" [1] blog to
> >> test my changes. To boot the L1 VM, I ran:
> >>
> >> sudo ./qemu/build/qemu-system-x86_64 \
> >> -enable-kvm \
> >> -drive file=3D//home/valdaarhun/valdaarhun/qcow2_img/L1.qcow2,media=3D=
disk,if=3Dvirtio \
> >> -net nic,model=3Dvirtio \
> >> -net user,hostfwd=3Dtcp::2222-:22 \
> >> -device intel-iommu,snoop-control=3Don \
> >> -device virtio-net-pci,netdev=3Dnet0,disable-legacy=3Don,disable-moder=
n=3Doff,iommu_platform=3Don,guest_uso4=3Doff,guest_uso6=3Doff,host_uso=3Dof=
f,guest_announce=3Doff,ctrl_vq=3Don,ctrl_rx=3Don,packed=3Don,event_idx=3Dof=
f,bus=3Dpcie.0,addr=3D0x4 \
> >> -netdev tap,id=3Dnet0,script=3Dno,downscript=3Dno \
> >> -nographic \
> >> -m 8G \
> >> -smp 4 \
> >> -M q35 \
> >> -cpu host 2>&1 | tee vm.log
> >>
> >> Without "guest_uso4=3Doff,guest_uso6=3Doff,host_uso=3Doff,
> >> guest_announce=3Doff" in "-device virtio-net-pci", QEMU
> >> throws "vdpa svq does not work with features" [2] when
> >> trying to boot L2.
> >>
> >> The enums added in commit #2 in this series is new and
> >> wasn't in the earlier versions of the series. Without
> >> this change, x-svq=3Dtrue throws "SVQ invalid device feature
> >> flags" [3] and x-svq is consequently disabled.
> >>
> >> The first issue is related to running traffic in L2
> >> with vhost-vdpa.
> >>
> >> In L0:
> >>
> >> $ ip addr add 111.1.1.1/24 dev tap0
> >> $ ip link set tap0 up
> >> $ ip addr show tap0
> >> 4: tap0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel sta=
te UNKNOWN group default qlen 1000
> >>      link/ether d2:6d:b9:61:e1:9a brd ff:ff:ff:ff:ff:ff
> >>      inet 111.1.1.1/24 scope global tap0
> >>         valid_lft forever preferred_lft forever
> >>      inet6 fe80::d06d:b9ff:fe61:e19a/64 scope link proto kernel_ll
> >>         valid_lft forever preferred_lft forever
> >>
> >> I am able to run traffic in L2 when booting without
> >> x-svq.
> >>
> >> In L1:
> >>
> >> $ ./qemu/build/qemu-system-x86_64 \
> >> -nographic \
> >> -m 4G \
> >> -enable-kvm \
> >> -M q35 \
> >> -drive file=3D//root/L2.qcow2,media=3Ddisk,if=3Dvirtio \
> >> -netdev type=3Dvhost-vdpa,vhostdev=3D/dev/vhost-vdpa-0,id=3Dvhost-vdpa=
0 \
> >> -device virtio-net-pci,netdev=3Dvhost-vdpa0,disable-legacy=3Don,disabl=
e-modern=3Doff,ctrl_vq=3Don,ctrl_rx=3Don,event_idx=3Doff,bus=3Dpcie.0,addr=
=3D0x7 \
> >> -smp 4 \
> >> -cpu host \
> >> 2>&1 | tee vm.log
> >>
> >> In L2:
> >>
> >> # ip addr add 111.1.1.2/24 dev eth0
> >> # ip addr show eth0
> >> 2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel sta=
te UP group default qlen 1000
> >>      link/ether 52:54:00:12:34:57 brd ff:ff:ff:ff:ff:ff
> >>      altname enp0s7
> >>      inet 111.1.1.2/24 scope global eth0
> >>         valid_lft forever preferred_lft forever
> >>      inet6 fe80::9877:de30:5f17:35f9/64 scope link noprefixroute
> >>         valid_lft forever preferred_lft forever
> >>
> >> # ip route
> >> 111.1.1.0/24 dev eth0 proto kernel scope link src 111.1.1.2
> >>
> >> # ping 111.1.1.1 -w3
> >> PING 111.1.1.1 (111.1.1.1) 56(84) bytes of data.
> >> 64 bytes from 111.1.1.1: icmp_seq=3D1 ttl=3D64 time=3D0.407 ms
> >> 64 bytes from 111.1.1.1: icmp_seq=3D2 ttl=3D64 time=3D0.671 ms
> >> 64 bytes from 111.1.1.1: icmp_seq=3D3 ttl=3D64 time=3D0.291 ms
> >>
> >> --- 111.1.1.1 ping statistics ---
> >> 3 packets transmitted, 3 received, 0% packet loss, time 2034ms
> >> rtt min/avg/max/mdev =3D 0.291/0.456/0.671/0.159 ms
> >>
> >>
> >> But if I boot L2 with x-svq=3Dtrue as shown below, I am unable
> >> to ping the host machine.
> >>
> >> $ ./qemu/build/qemu-system-x86_64 \
> >> -nographic \
> >> -m 4G \
> >> -enable-kvm \
> >> -M q35 \
> >> -drive file=3D//root/L2.qcow2,media=3Ddisk,if=3Dvirtio \
> >> -netdev type=3Dvhost-vdpa,vhostdev=3D/dev/vhost-vdpa-0,x-svq=3Dtrue,id=
=3Dvhost-vdpa0 \
> >> -device virtio-net-pci,netdev=3Dvhost-vdpa0,disable-legacy=3Don,disabl=
e-modern=3Doff,ctrl_vq=3Don,ctrl_rx=3Don,event_idx=3Doff,bus=3Dpcie.0,addr=
=3D0x7 \
> >> -smp 4 \
> >> -cpu host \
> >> 2>&1 | tee vm.log
> >>
> >> In L2:
> >>
> >> # ip addr add 111.1.1.2/24 dev eth0
> >> # ip addr show eth0
> >> 2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel sta=
te UP group default qlen 1000
> >>      link/ether 52:54:00:12:34:57 brd ff:ff:ff:ff:ff:ff
> >>      altname enp0s7
> >>      inet 111.1.1.2/24 scope global eth0
> >>         valid_lft forever preferred_lft forever
> >>      inet6 fe80::9877:de30:5f17:35f9/64 scope link noprefixroute
> >>         valid_lft forever preferred_lft forever
> >>
> >> # ip route
> >> 111.1.1.0/24 dev eth0 proto kernel scope link src 111.1.1.2
> >>
> >> # ping 111.1.1.1 -w10
> >> PING 111.1.1.1 (111.1.1.1) 56(84) bytes of data.
> >>  From 111.1.1.2 icmp_seq=3D1 Destination Host Unreachable
> >> ping: sendmsg: No route to host
> >>  From 111.1.1.2 icmp_seq=3D2 Destination Host Unreachable
> >>  From 111.1.1.2 icmp_seq=3D3 Destination Host Unreachable
> >>
> >> --- 111.1.1.1 ping statistics ---
> >> 3 packets transmitted, 0 received, +3 errors, 100% packet loss, time 2=
076ms
> >> pipe 3
> >>
> >> The other issue is related to booting L2 with "x-svq=3Dtrue"
> >> and "packed=3Don".
> >>
> >> In L1:
> >>
> >> $ ./qemu/build/qemu-system-x86_64 \
> >> -nographic \
> >> -m 4G \
> >> -enable-kvm \
> >> -M q35 \
> >> -drive file=3D//root/L2.qcow2,media=3Ddisk,if=3Dvirtio \
> >> -netdev type=3Dvhost-vdpa,vhostdev=3D/dev/vhost-vdpa-0,id=3Dvhost-vdpa=
0,x-svq=3Dtrue \
> >> -device virtio-net-pci,netdev=3Dvhost-vdpa0,disable-legacy=3Don,disabl=
e-modern=3Doff,guest_uso4=3Doff,guest_uso6=3Doff,host_uso=3Doff,guest_annou=
nce=3Doff,ctrl_vq=3Don,ctrl_rx=3Don,event_idx=3Doff,packed=3Don,bus=3Dpcie.=
0,addr=3D0x7 \
> >> -smp 4 \
> >> -cpu host \
> >> 2>&1 | tee vm.log
> >>
> >> The kernel throws "virtio_net virtio1: output.0:id 0 is not
> >> a head!" [4].
> >>
> >
> > So this series implements the descriptor forwarding from the guest to
> > the device in packed vq. We also need to forward the descriptors from
> > the device to the guest. The device writes them in the SVQ ring.
> >
> > The functions responsible for that in QEMU are
> > hw/virtio/vhost-shadow-virtqueue.c:vhost_svq_flush, which is called by
> > the device when used descriptors are written to the SVQ, which calls
> > hw/virtio/vhost-shadow-virtqueue.c:vhost_svq_get_buf. We need to do
> > modifications similar to vhost_svq_add: Make them conditional if we're
> > in split or packed vq, and "copy" the code from Linux's
> > drivers/virtio/virtio_ring.c:virtqueue_get_buf.
> >
> > After these modifications you should be able to ping and forward
> > traffic. As always, It is totally ok if it needs more than one
> > iteration, and feel free to ask any question you have :).
> >
>
> I misunderstood this part. While working on extending
> hw/virtio/vhost-shadow-virtqueue.c:vhost_svq_get_buf() [1]
> for packed vqs, I realized that this function and
> vhost_svq_flush() already support split vqs. However, I am
> unable to ping L0 when booting L2 with "x-svq=3Dtrue" and
> "packed=3Doff" or when the "packed" option is not specified
> in QEMU's command line.
>
> I tried debugging these functions for split vqs after running
> the following QEMU commands while following the blog [2].
>
> Booting L1:
>
> $ sudo ./qemu/build/qemu-system-x86_64 \
> -enable-kvm \
> -drive file=3D//home/valdaarhun/valdaarhun/qcow2_img/L1.qcow2,media=3Ddis=
k,if=3Dvirtio \
> -net nic,model=3Dvirtio \
> -net user,hostfwd=3Dtcp::2222-:22 \
> -device intel-iommu,snoop-control=3Don \
> -device virtio-net-pci,netdev=3Dnet0,disable-legacy=3Don,disable-modern=
=3Doff,iommu_platform=3Don,guest_uso4=3Doff,guest_uso6=3Doff,host_uso=3Doff=
,guest_announce=3Doff,ctrl_vq=3Don,ctrl_rx=3Don,packed=3Doff,event_idx=3Dof=
f,bus=3Dpcie.0,addr=3D0x4 \
> -netdev tap,id=3Dnet0,script=3Dno,downscript=3Dno \
> -nographic \
> -m 8G \
> -smp 4 \
> -M q35 \
> -cpu host 2>&1 | tee vm.log
>
> Booting L2:
>
> # ./qemu/build/qemu-system-x86_64 \
> -nographic \
> -m 4G \
> -enable-kvm \
> -M q35 \
> -drive file=3D//root/L2.qcow2,media=3Ddisk,if=3Dvirtio \
> -netdev type=3Dvhost-vdpa,vhostdev=3D/dev/vhost-vdpa-0,x-svq=3Dtrue,id=3D=
vhost-vdpa0 \
> -device virtio-net-pci,netdev=3Dvhost-vdpa0,disable-legacy=3Don,disable-m=
odern=3Doff,ctrl_vq=3Don,ctrl_rx=3Don,event_idx=3Doff,bus=3Dpcie.0,addr=3D0=
x7 \
> -smp 4 \
> -cpu host \
> 2>&1 | tee vm.log
>
> I printed out the contents of VirtQueueElement returned
> by vhost_svq_get_buf() in vhost_svq_flush() [3].
> I noticed that "len" which is set by "vhost_svq_get_buf"
> is always set to 0 while VirtQueueElement.len is non-zero.
> I haven't understood the difference between these two "len"s.
>

VirtQueueElement.len is the length of the buffer, while the len of
vhost_svq_get_buf is the bytes written by the device. In the case of
the tx queue, VirtQueuelen is the length of the tx packet, and the
vhost_svq_get_buf is always 0 as the device does not write. In the
case of rx, VirtQueueElem.len is the available length for a rx frame,
and the vhost_svq_get_buf len is the actual length written by the
device.

To be 100% accurate a rx packet can span over multiple buffers, but
SVQ does not need special code to handle this.

So vhost_svq_get_buf should return > 0 for rx queue (svq->vq->index =3D=3D
0), and 0 for tx queue (svq->vq->index % 2 =3D=3D 1).

Take into account that vhost_svq_get_buf only handles split vq at the
moment! It should be renamed or splitted into vhost_svq_get_buf_split.

> The "len" that is set to 0 is used in "virtqueue_fill()" in
> virtio.c [4]. Could this point to why I am not able to ping
> L0 from L2?
>

It depends :). Let me know in what vq you find that.

> Thanks,
> Sahil
>
> [1] https://gitlab.com/qemu-project/qemu/-/blob/master/hw/virtio/vhost-sh=
adow-virtqueue.c#L418
> [2] https://www.redhat.com/en/blog/hands-vdpa-what-do-you-do-when-you-ain=
t-got-hardware-part-2
> [3] https://gitlab.com/qemu-project/qemu/-/blob/master/hw/virtio/vhost-sh=
adow-virtqueue.c#L488
> [4] https://gitlab.com/qemu-project/qemu/-/blob/master/hw/virtio/vhost-sh=
adow-virtqueue.c#L501
>


